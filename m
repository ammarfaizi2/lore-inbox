Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269100AbRHVAEd>; Tue, 21 Aug 2001 20:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271900AbRHVAEX>; Tue, 21 Aug 2001 20:04:23 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54893 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269100AbRHVAEO>; Tue, 21 Aug 2001 20:04:14 -0400
Date: Tue, 21 Aug 2001 20:04:26 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108220004.f7M04Qx01206@devserv.devel.redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like the change int he usb_start_wait_urb code is a problem. 

Yes, something was not right with my change.
I am trying to coax people into testing this (on top of -ac8):

--- linux-2.4.8-ac8/drivers/usb/usb.c	Tue Aug 21 14:39:55 2001
+++ linux-2.4.8-ac8-niph/drivers/usb/usb.c	Tue Aug 21 16:02:01 2001
@@ -1080,10 +1080,17 @@
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&awd.wqh, &wait);
 
-	if (!timeout) {
-		printk("usb_control/bulk_msg: timeout\n");
-		usb_unlink_urb(urb);  // remove urb safely
-		status = -ETIMEDOUT;
+	if (!awd.done) {
+		if (urb->status != -EINPROGRESS) {	/* No callback?!! */
+			printk(KERN_ERR "usb: raced timeout, "
+			    "pipe 0x%x status %d time left %d\n",
+			    urb->pipe, urb->status, timeout);
+			status = urb->status;
+		} else {
+			printk("usb_control/bulk_msg: timeout\n");
+			usb_unlink_urb(urb);  // remove urb safely
+			status = -ETIMEDOUT;
+		}
 	} else
 		status = urb->status;
 

> I suspect either you need to add wmb() and rmb() to stop misoptimisations
> on done (along with making it (!timeout && !awd.done)

Arjan said so too - I'll add them later just in case.
About (!timeout && !awd.done) - it's not going to be enough,
I think. I suspect that callback is not delivered at all
in some circumstances, or something really screwy like that.

> there is a signal related problem - if so  making it set the state
> to TASK_UNINTERRUPTIBLE might cure it

I tried that first and it worked, but someone disagreed. Dunno...

-- Pete
