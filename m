Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUIVSsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUIVSsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUIVSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:48:21 -0400
Received: from peabody.ximian.com ([130.57.169.10]:18058 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266627AbUIVSsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:48:11 -0400
Subject: [patch] inotify: eliminate struct padding
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-XVvEOQkX3NIjQO1x8/GD"
Date: Wed, 22 Sep 2004 14:46:56 -0400
Message-Id: <1095878816.5090.45.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XVvEOQkX3NIjQO1x8/GD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey, John!

"struct inotify_device" was receiving a lot of padding, because it has a
lot of large structures of various sizes in it.  Plus a single char.

On x86, the main thing getting padding was "bitmask".  Rearranging the
structure solved the padding problem.  We have no ABI issues since the
structure is internal to inotify.c.

Once the per-element padding was fixed, we still have the structure
being padded out to the architecture's alignment size.  This is caused
by the lone char, read_state.  It turns out that nothing was using
read_state (??), so I just removed it.

Now there is no padding on the elements or the structure as a whole.
This saves a handful of bytes per structure.

I also s/watcher_count/nr_watches/ since we have a lot of other
watcher_counts.  I am easily confused.

Best,

	Robert Love


--=-XVvEOQkX3NIjQO1x8/GD
Content-Disposition: attachment; filename=inotify-padding-1.patch
Content-Type: text/x-patch; name=inotify-padding-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove padding

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-22 13:48:23.833541400 -0400
+++ linux/drivers/char/inotify.c	2004-09-22 14:40:23.623261272 -0400
@@ -60,21 +60,22 @@
 static int inotify_debug_flags;
 #define iprintk(f, str...) if (inotify_debug_flags & f) printk (KERN_ALERT str)
 
-/* For each inotify device we need to keep a list of events queued on it,
- * a list of inodes that we are watching and other stuff.
+/*
+ * struct inotify_device - represents an open instance of an inotify device
+ *
+ * For each inotify device, we need to keep track of the events queued on it,
+ * a list of the inodes that we are watching, and so on.
  */
 struct inotify_device {
+	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
+	struct timer_list	timer;
+	wait_queue_head_t 	wait;
 	struct list_head 	events;
-	atomic_t		event_count;
 	struct list_head 	watchers;
-	int			watcher_count;
-	wait_queue_head_t 	wait;
-	struct timer_list	timer;
-	char			read_state;
 	spinlock_t		lock;
-	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG];
+	atomic_t		event_count;
+	int			nr_watches;
 };
-#define inotify_device_event_list(pos) list_entry((pos), struct inotify_event, list)
 
 struct inotify_watcher {
 	int 			wd; // watcher descriptor
@@ -248,11 +249,11 @@
 	if (!dev)
 		return -1;
 
-	if (dev->watcher_count == MAX_INOTIFY_DEV_WATCHERS) {
+	if (dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS) {
 		return -1;
 	}
 
-	dev->watcher_count++;
+	dev->nr_watches++;
 
 	wd = find_first_zero_bit (dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
 
@@ -266,7 +267,7 @@
 	if (!dev||wd < 0)
 		return -1;
 
-	dev->watcher_count--;
+	dev->nr_watches--;
 
 	clear_bit (wd, dev->bitmask);
 
@@ -374,7 +375,7 @@
 	}
 
 
-	if (dev->watcher_count == MAX_INOTIFY_DEV_WATCHERS) {
+	if (dev->nr_watches == MAX_INOTIFY_DEV_WATCHERS) {
 		error = -ENOSPC;
 		goto out;
 	}
@@ -693,9 +694,8 @@
 	init_waitqueue_head(&dev->wait);
 
 	atomic_set(&dev->event_count, 0);
-	dev->watcher_count = 0;
+	dev->nr_watches = 0;
 	dev->lock = SPIN_LOCK_UNLOCKED;
-	dev->read_state = 0;
 
 	file->private_data = dev;
 
@@ -871,7 +871,7 @@
 
 	printk (KERN_ALERT "inotify device: %p\n", dev);
 	printk (KERN_ALERT "inotify event_count: %d\n", atomic_read(&dev->event_count));
-	printk (KERN_ALERT "inotify watch_count: %d\n", dev->watcher_count);
+	printk (KERN_ALERT "inotify watch_count: %d\n", dev->nr_watches);
 
 	spin_unlock(&dev->lock);
 }

--=-XVvEOQkX3NIjQO1x8/GD--

