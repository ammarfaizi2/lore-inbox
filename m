Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRHTVpH>; Mon, 20 Aug 2001 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269506AbRHTVov>; Mon, 20 Aug 2001 17:44:51 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:35253 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269515AbRHTVod>; Mon, 20 Aug 2001 17:44:33 -0400
Date: Mon, 20 Aug 2001 17:44:48 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: johannes@erdfelt.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        t.sailer@alumni.ethz.ch
Subject: Re: Patch for bizzare oops in USB
Message-ID: <20010820174448.A1299@devserv.devel.redhat.com>
In-Reply-To: <20010818013101.A7058@devserv.devel.redhat.com> <3B80FBA9.556B7B2B@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B80FBA9.556B7B2B@scs.ch>; from sailer@scs.ch on Mon, Aug 20, 2001 at 01:59:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 20 Aug 2001 13:59:37 +0200
> From: Thomas Sailer <sailer@scs.ch>

> > -       current->state = TASK_INTERRUPTIBLE;
> > +       current->state = TASK_UNINTERRUPTIBLE;  /* MUST BE SO. -- zaitcev */

> This is bad for other users of usb_control_msg/usb_bulk_msg that depend on
> the sleep to be interruptible. Instead of bouncing back and forth whether
> those routines shall sleep interruptibly or uninterruptibly, we should either
> provide two routines or a parameter that specifies whether the sleep
> shall be interruptible, or create a local version of usb_control_msg
> if ov511 is the only user requiring uninterruptible sleep.

A prolifiration of subtly different versions of basic primitives
is not an answer either. But wait, here's a better fix. The
root of the evil is that the waiting thread accesses urb->status
before a callback happened, which is unsafe.

BTW, I took a liberty to clean the thing up a bit. It looked as
if the author of that fragment was not sure of what he was doing,
and the style was quite dirty. I think a number of wrongs for
such a small fragment was astonishing.

 - "status" was an errno in the begining, then 5 lines down
   it's bool (== timeout), then it turns into system style once again.
 - Wasted pointer to wait head
 - Unused void *stuff.
 - typedef without _t and unprefixed type name in global header.
 - Urban legend of test for waitqueue_active() before wakeup.
   This is one half wrong because so many people do it,
   anyone has an idea why? Half a point deducted.
 - Confused and redundant checking for -EINPROGRESS
   (even if it was the cause of oops)

And the last one ...
 - THE GOD DAMN RACE THAT OOPS - that's 10 hacker points down!
   It only goes to show that replacing interruptible_sleep_on
   with add_wait_queue/schedule/remove_wait_queue does not make
   any racy code correct automatically.

Cheesh, I am surprised _anything_ in Linux kernel works.

-- Pete

--- linux-2.4.8/include/linux/usb.h	Fri Aug 10 18:16:46 2001
+++ linux-2.4.8-e/include/linux/usb.h	Mon Aug 20 10:28:36 2001
@@ -539,13 +539,12 @@
  *                         SYNCHRONOUS CALL SUPPORT                  *
  *-------------------------------------------------------------------*/
 
-typedef struct
+struct usb_api_data
 {
-  wait_queue_head_t *wakeup;
-
-  void* stuff;
-  /* more to follow */
-} api_wrapper_data;
+	wait_queue_head_t wqh;
+	int done;
+	/* void* stuff;	*/	/* Possible extension later. */
+};
 
 /* -------------------------------------------------------------------------- */
 
--- linux-2.4.8/drivers/usb/usb.c	Tue Jul 24 14:20:56 2001
+++ linux-2.4.8-e/drivers/usb/usb.c	Mon Aug 20 14:05:45 2001
@@ -1041,15 +1041,10 @@
  *-------------------------------------------------------------------*/
 static void usb_api_blocking_completion(urb_t *urb)
 {
-	api_wrapper_data *awd = (api_wrapper_data *)urb->context;
+	struct usb_api_data *awd = (struct usb_api_data *)urb->context;
 
-	if (waitqueue_active(awd->wakeup))
-		wake_up(awd->wakeup);
-#if 0
-	else
-		dbg("(blocking_completion): waitqueue empty!"); 
-		// even occurs if urb was unlinked by timeout...
-#endif
+	awd->done = 1;
+	wake_up(&awd->wqh);
 }
 
 /*-------------------------------------------------------------------*
@@ -1060,35 +1055,32 @@
 static int usb_start_wait_urb(urb_t *urb, int timeout, int* actual_length)
 { 
 	DECLARE_WAITQUEUE(wait, current);
-	DECLARE_WAIT_QUEUE_HEAD(wqh);
-	api_wrapper_data awd;
+	struct usb_api_data awd;
 	int status;
-  
-	awd.wakeup = &wqh;
-	init_waitqueue_head(&wqh); 	
+
+	init_waitqueue_head(&awd.wqh); 	
+	awd.done = 0;
+
 	current->state = TASK_INTERRUPTIBLE;
-	add_wait_queue(&wqh, &wait);
+	add_wait_queue(&awd.wqh, &wait);
+
 	urb->context = &awd;
 	status = usb_submit_urb(urb);
 	if (status) {
 		// something went wrong
 		usb_free_urb(urb);
 		current->state = TASK_RUNNING;
-		remove_wait_queue(&wqh, &wait);
+		remove_wait_queue(&awd.wqh, &wait);
 		return status;
 	}
 
-	if (urb->status == -EINPROGRESS) {
-		while (timeout && urb->status == -EINPROGRESS)
-			status = timeout = schedule_timeout(timeout);
-	} else
-		status = 1;
+	while (timeout && !awd.done)
+		timeout = schedule_timeout(timeout);
 
 	current->state = TASK_RUNNING;
-	remove_wait_queue(&wqh, &wait);
+	remove_wait_queue(&awd.wqh, &wait);
 
-	if (!status) {
-		// timeout
+	if (!timeout) {
 		printk("usb_control/bulk_msg: timeout\n");
 		usb_unlink_urb(urb);  // remove urb safely
 		status = -ETIMEDOUT;
