Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270582AbUJULW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270582AbUJULW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270477AbUJULWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:22:06 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:14821 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S270582AbUJULVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:21:11 -0400
Message-ID: <6466.195.245.190.94.1098357608.squirrel@195.245.190.94>
In-Reply-To: <14882.195.245.190.93.1098354393.squirrel@195.245.190.93>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
       <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>   
    <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>   
    <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>   
    <20041020094508.GA29080@elte.hu>   
    <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>   
    <20041021091850.GA29183@elte.hu>
    <14882.195.245.190.93.1098354393.squirrel@195.245.190.93>
Date: Thu, 21 Oct 2004 12:20:08 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041021122008_79943"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 21 Oct 2004 11:21:07.0136 (UTC) FILETIME=[0F1A9400:01C4B760]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041021122008_79943
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>>
>> for the sake of testing could you disable CONFIG_USB and see whether the
>> instability is truly directly related to the USB crash, as you suspect?
>> Such a kernel crash can often destabilize other parts of the kernel.
>>
>
> Just tested with CONFIG_USB off, and can't test the usb-storage crash, of
> course. However, jackd  is still freezing to death. No console, nor syslog
> output can be found. The system just dies sometime after some jack client
> is launched. Will try further.
>
> I'm on the way to test Thomas Gleixner's patch...
>

OK. Thomas patch solves the usb-storage crash, but I added an oneliner
change to it, to make it build. Corrected patch is appended.

Thanks.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041021122008_79943
Content-Type: text/plain;
      name="realtime-preempt-2.6.9-rc4-mm1-U8.1_usb-storage.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="realtime-preempt-2.6.9-rc4-mm1-U8.1_usb-storage.patch"

diff -urN 2.6.9-rc4-mm1-RT-U8/drivers/usb/storage/scsiglue.c
2.6.9-rc4-mm1-RT-U8.1/drivers/usb/storage/scsiglue.c
--- 2.6.9-rc4-mm1-RT-U8/drivers/usb/storage/scsiglue.c	2004-10-12
09:41:44.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U8.1/drivers/usb/storage/scsiglue.c	2004-10-21
11:45:14.000000000 +0200
@@ -187,7 +187,7 @@
 	us->srb = srb;
 
 	/* wake up the process task */
-	up(&(us->sema));
+	complete(&(us->done));
 
 	return 0;
 }
diff -urN 2.6.9-rc4-mm1-RT-U8/drivers/usb/storage/usb.c
2.6.9-rc4-mm1-RT-U8.1/drivers/usb/storage/usb.c
--- 2.6.9-rc4-mm1-RT-U8/drivers/usb/storage/usb.c	2004-10-12
09:41:44.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U8.1/drivers/usb/storage/usb.c	2004-10-21
11:45:34.000000000 +0200
@@ -299,7 +299,7 @@
 
 	for(;;) {
 		US_DEBUGP("*** thread sleeping.\n");
-		if(down_interruptible(&us->sema))
+		if(wait_for_completion_interruptible(&us->done))
 			break;
 			
 		US_DEBUGP("*** thread awakened.\n");
@@ -845,7 +845,7 @@
 		scsi_unlock(us->host);
 		up(&us->dev_semaphore);
 
-		up(&us->sema);
+		complete(&us->done);
 		wait_for_completion(&us->notify);
 	}

@@ -941,7 +941,7 @@
 	}
 	memset(us, 0, sizeof(struct us_data));
 	init_MUTEX(&(us->dev_semaphore));
-	init_MUTEX_LOCKED(&(us->sema));
+	init_completion(&(us->done));
 	init_completion(&(us->notify));
 	init_waitqueue_head(&us->dev_reset_wait);
 	init_waitqueue_head(&us->scsi_scan_wait);
diff -urN 2.6.9-rc4-mm1-RT-U8/drivers/usb/storage/usb.h
2.6.9-rc4-mm1-RT-U8.1/drivers/usb/storage/usb.h
--- 2.6.9-rc4-mm1-RT-U8/drivers/usb/storage/usb.h	2004-10-12
09:41:44.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U8.1/drivers/usb/storage/usb.h	2004-10-21
11:45:13.000000000 +0200
@@ -159,8 +159,8 @@
 	dma_addr_t		iobuf_dma;
 
 	/* mutual exclusion and synchronization structures */
-	struct semaphore	sema;		 /* to sleep thread on   */
-	struct completion	notify;		 /* thread begin/end	 */
+	struct completion	done;   	 /* to sleep thread on   */
+	struct completion	notify; 	 /* thread begin/end	 */
 	wait_queue_head_t	dev_reset_wait;  /* wait during reset    */
 	wait_queue_head_t	scsi_scan_wait;	 /* wait before scanning */
 	struct completion	scsi_scan_done;	 /* scan thread end	 */
------=_20041021122008_79943--


