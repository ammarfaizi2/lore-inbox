Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUJLKsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUJLKsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269608AbUJLKsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:48:42 -0400
Received: from [64.62.253.241] ([64.62.253.241]:23815 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S268535AbUJLKsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:48:14 -0400
Date: Tue, 12 Oct 2004 03:50:56 -0700
From: Bryan Rittmeyer <bryan@staidm.org>
To: John McCutchan <ttb@tentacle.dhs.org>, Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] inotify 0.13.1 cleanup
Message-ID: <20041012105056.GA26353@staidm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Two minor optimizations and an ENOMEM.

-Bryan

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inotify-0.13.1-cleanup_1.patch"

--- inotify.c.orig	2004-10-12 01:16:12.000000000 -0700
+++ inotify.c	2004-10-12 02:44:52.000000000 -0700
@@ -218,7 +218,6 @@
 
 	/* the queue has just overflowed and we need to notify user space */
 	if (dev->event_count == MAX_INOTIFY_QUEUED_EVENTS) {
-		dev->event_count++;
 		kevent = kernel_event(-1, IN_Q_OVERFLOW, cookie, NULL);
 		iprintk(INOTIFY_DEBUG_EVENTS, "sending IN_Q_OVERFLOW to %p\n",
 			dev);
@@ -229,19 +228,18 @@
 			!event_and(mask, watch->mask))
 		return;
 
-	dev->event_count++;
 	kevent = kernel_event(watch->wd, mask, cookie, filename);
 
 add_event_to_queue:
 	if (!kevent) {
 		iprintk(INOTIFY_DEBUG_EVENTS, "failed to queue event for %p"
 			" -- could not allocate kevent\n", dev);
-		dev->event_count--;
 		return;
 	}
 
 	/* queue the event and wake up anyone waiting */
 	list_add_tail(&kevent->list, &dev->events);
+	dev->event_count++;
 	iprintk(INOTIFY_DEBUG_EVENTS,
 		"queued event %x for %p\n", kevent->event.mask, dev);
 	wake_up_interruptible(&dev->wait);
@@ -470,13 +468,17 @@
 	if (!inode->inotify_data) {
 		inode->inotify_data = kmem_cache_alloc(inode_data_cachep,
 							GFP_ATOMIC);
+
+		if(!inode->inotify_data)
+			return -ENOMEM;
+
 		INIT_LIST_HEAD(&inode->inotify_data->watches);
 		inode->inotify_data->watch_mask = 0;
 		inode->inotify_data->watch_count = 0;
 	}
 	list_add(&watch->i_list, &inode->inotify_data->watches);
 	inode->inotify_data->watch_count++;
-	inode_update_watch_mask(inode);
+	inode->inotify_data->watch_mask |= watch->mask;
 
 	return 0;
 }
@@ -788,6 +790,7 @@
 {
 	struct inode *inode;
 	struct inotify_watch *watch;
+	int ret;
 
 	inode = find_inode(request->dirname);
 	if (IS_ERR(inode))
@@ -842,7 +845,17 @@
 		return -ENOSPC;
 	}
 
-	inode_add_watch(inode, watch);
+	ret = inode_add_watch(inode, watch);
+	if(ret < 0) {
+		iprintk(INOTIFY_DEBUG_ERRORS,
+			"can't add watch\n");
+		list_del(&watch->d_list); /* inotify_dev_rm_watch w/o event */
+		delete_watch(dev, watch);
+		spin_unlock(&dev->lock);
+		spin_unlock(&inode->i_lock);
+		unref_inode(inode);
+		return ret;
+	}
 
 	spin_unlock(&dev->lock);
 	spin_unlock(&inode->i_lock);

--n8g4imXOkfNTN/H1--
