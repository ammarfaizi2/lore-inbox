Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUI1Ruz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUI1Ruz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUI1Ruz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:50:55 -0400
Received: from peabody.ximian.com ([130.57.169.10]:1455 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268028AbUI1RuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:50:20 -0400
Subject: [patch] inotify: remove timer
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-q4rMt+J5uZ5oagJIHKLV"
Date: Tue, 28 Sep 2004 13:48:58 -0400
Message-Id: <1096393738.4911.44.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q4rMt+J5uZ5oagJIHKLV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

John,

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

Attached patch removes dev->timer and instead wakes up waiting tasks in
inotify_dev_queue_event().

I'd like you to go over it, make sure this works the same and makes
sense.  It needs a good testing before merged.

	Robert Love


--=-q4rMt+J5uZ5oagJIHKLV
Content-Disposition: attachment; filename=inotify-remove-timer-1.patch
Content-Type: text/x-patch; name=inotify-remove-timer-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove dev->timer

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   32 +++++++-------------------------
 1 files changed, 7 insertions(+), 25 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 16:40:37.000000000 -0400
+++ linux/drivers/char/inotify.c	2004-09-28 13:43:07.924958624 -0400
@@ -63,10 +63,14 @@
  *
  * 'bitmask' holds one bit for each possible watcher descriptor: a set bit
  * implies that the given WD is valid, unset implies it is not.
+ *
+ * This structure is protected by 'lock'.  Lock ordering:
+ *	dev->lock
+ *		dev->wait->lock
+ * FIXME: Define lock ordering wrt inode and dentry locking!
  */
 struct inotify_device {
 	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHERS);
-	struct timer_list	timer;
 	wait_queue_head_t 	wait;
 	struct list_head 	events;
 	struct list_head 	watchers;
@@ -248,9 +252,11 @@
 		return;
 	}
 
+	/* queue the event and wake up anyone waiting */
 	list_add_tail(&kevent->list, &dev->events);
 	iprintk(INOTIFY_DEBUG_EVENTS,
 		"queued event %x for %p\n", kevent->event.mask, dev);
+	wake_up_interruptible(&dev->wait);
 }
 
 /*
@@ -747,22 +753,6 @@
 	return out;
 }
 
-static void inotify_dev_timer(unsigned long data)
-{
-	struct inotify_device *dev;
-
-	if (!data)
-		return;
-	dev = (struct inotify_device *) data;
-
-	/* reset the timer */
-	mod_timer(&dev->timer, jiffies + (HZ/4));
-
-	/* wake up anyone blocked on the device */
-	if (inotify_dev_has_events(dev))
-		wake_up_interruptible(&dev->wait);
-}
-
 static int inotify_open(struct inode *inode, struct file *file)
 {
 	struct inotify_device *dev;
@@ -780,7 +770,6 @@
 
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watchers);
-	init_timer(&dev->timer);
 	init_waitqueue_head(&dev->wait);
 
 	dev->event_count = 0;
@@ -789,12 +778,6 @@
 
 	file->private_data = dev;
 
-	dev->timer.data = (unsigned long) dev;
-	dev->timer.function = inotify_dev_timer;
-	dev->timer.expires = jiffies + (HZ/4);
-
-	add_timer(&dev->timer);
-
 	printk(KERN_ALERT "inotify device opened\n");
 
 	return 0;
@@ -825,7 +808,6 @@
 	struct inotify_device *dev;
 
 	dev = file->private_data;
-	del_timer_sync(&dev->timer);
 	inotify_release_all_watchers(dev);
 	inotify_release_all_events(dev);
 	kfree(dev);

--=-q4rMt+J5uZ5oagJIHKLV--

