Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280646AbRKJNi3>; Sat, 10 Nov 2001 08:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280653AbRKJNiU>; Sat, 10 Nov 2001 08:38:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39181 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S280646AbRKJNiN>;
	Sat, 10 Nov 2001 08:38:13 -0500
Date: Sat, 10 Nov 2001 14:37:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel Developer <linux_developer@hotmail.com>
Cc: J Sloan <jjs@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CPQARRAY driver horribly broken in 2.4.14
Message-ID: <20011110143758.D17902@suse.de>
In-Reply-To: <F5uLCTaogxLDp7mvjkO00000742@hotmail.com> <3BEB5149.B0B7990F@pobox.com> <OE36joYAPNXRPmcarcR0001ece1@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <OE36joYAPNXRPmcarcR0001ece1@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09 2001, Linux Kernel Developer wrote:
> Hi,
> 
>     Thanks a lot for the help.  Any particular reason to use the new driver
> now or should I just wait until 2.4.15 is release?
> 
>     Guess I didn't need to do all that debugging.  Bug may have already been
> caught.  8-)
> 
>     However I did notice something.  The patch you've included below covers
> the cciss.c file?  My system is using the cpqarray driver.  And I fixed the
> problem by replacing the cpqarray.[ch], ida_cmd.h, and ida_ioctl.h files.  I
> don't think the patch below would have done anything for me as I'm pretty
> sure the cciss.c file isn't used by the cpqarray driver and since I didn't
> change out the cciss.c file in my now working kernel source tree (linux
> 2.4.14-lkd1 8-D).

You needed the cciss equivalent of the one posted, attached.

-- 
Jens Axboe


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cciss-dequeue-1

--- linux/drivers/block/cciss.c~	Thu Nov  8 11:36:24 2001
+++ linux/drivers/block/cciss.c	Thu Nov  8 11:37:03 2001
@@ -1307,6 +1307,8 @@
 	if (( c = cmd_alloc(h, 1)) == NULL)
 		goto startio;
 
+	blkdev_dequeue_request(creq);
+
 	spin_unlock_irq(&io_request_lock);
 
 	c->cmd_type = CMD_RWREQ;      
@@ -1386,12 +1388,6 @@
 
 	spin_lock_irq(&io_request_lock);
 
-	blkdev_dequeue_request(creq);
-
-        /*
-         * ehh, we can't really end the request here since it's not
-         * even started yet. for now it shouldn't hurt though
-         */
 	addQ(&(h->reqQ),c);
 	h->Qdepth++;
 	if(h->Qdepth > h->maxQsinceinit)

--cWoXeonUoKmBZSoM--
