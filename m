Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUJUKRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUJUKRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270381AbUJUKR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:17:27 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:19875
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269399AbUJUKDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:03:36 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu>
	 <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098352534.26758.33.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 11:55:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 11:12, Rui Nuno Capela wrote:

Can you try that one ?

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


