Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271783AbRHRFbI>; Sat, 18 Aug 2001 01:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271785AbRHRFa6>; Sat, 18 Aug 2001 01:30:58 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:34636 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271784AbRHRFar>; Sat, 18 Aug 2001 01:30:47 -0400
Date: Sat, 18 Aug 2001 01:31:01 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: johannes@erdfelt.com
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch for bizzare oops in USB
Message-ID: <20010818013101.A7058@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran webcam(1) with ov511 and if I hit ^C, the box oopses.
Apparently, the following happens:

1. On SIGINT, v4l closes ov511, which isses a string of
   control requests to quescent the cam.
2. One of those requests enters usb_internal_control_msg
   where it submits the URB and does schedule_timeout().
3. Since the signal is pending [sic], it does not wait,
   but spins testing urb->status.
4. The interrupt is taken on other CPU and it gets into
   sohci_return_urb, then clears status and calls urb_rm_priv.
5. The user thread sees that status becomes zero and *frees the URB*.
6. The urb_rm_priv takes a spinlock and does its dirty buseness.
7. User thread reallocates the URB and resubmits it,
   waiting on the spinlock meanwhile.
8. urb_rm_priv zaps urb->dev in the URB which was already
   freed and reallocated and releases the spinlock.
9. The user thread keels over deep inside td_submit_urb()
   dereferencing urb->dev->something

Took me a couple of days to figure it all out. :)

diff -ur -X dontdiff linux-2.4.8/drivers/usb/usb.c linux-2.4.8-e/drivers/usb/usb.c
--- linux-2.4.8/drivers/usb/usb.c	Tue Jul 24 14:20:56 2001
+++ linux-2.4.8-e/drivers/usb/usb.c	Fri Aug 17 22:03:27 2001
@@ -1066,7 +1066,7 @@
   
 	awd.wakeup = &wqh;
 	init_waitqueue_head(&wqh); 	
-	current->state = TASK_INTERRUPTIBLE;
+	current->state = TASK_UNINTERRUPTIBLE;	/* MUST BE SO. -- zaitcev */
 	add_wait_queue(&wqh, &wait);
 	urb->context = &awd;
 	status = usb_submit_urb(urb);
