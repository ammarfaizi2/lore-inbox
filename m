Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWFYTjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWFYTjB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFYTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:39:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:61870 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932226AbWFYTjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:39:00 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 25 Jun 2006 21:37:20 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFC PATCH 2.6.17-mm1 5/3] ieee1394: raw1394: remove redundant
 counting semaphore
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151172766.3181.75.camel@laptopd505.fenrus.org>
Message-ID: <tkrat.fc5e105c2b4b5ef5@s5r6.in-berlin.de>
References: <449BEBFB.60302@s5r6.in-berlin.de> 
 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net> 
 <30866.1151072338@warthog.cambridge.redhat.com> 
 <tkrat.df6845846c72176e@s5r6.in-berlin.de> 
 <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de> 
 <tkrat.e74b06c4105348f6@s5r6.in-berlin.de> 
 <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de> 
 <tkrat.3f9c07538e381afd@s5r6.in-berlin.de> 
 <449D7A53.4080605@s5r6.in-berlin.de>
 <1151172766.3181.75.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.894) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An already existing wait queue replaces raw1394's complete_sem which was
maintained in parallel to the wait queue.  The role of the semaphore's
counter is taken over by a direct check of what was really counted:  The
presence of items in the list of completed requests.

Notes:

 - raw1394_release() sleeps uninterruptibly until all requests were
   completed.  This is the same behaviour as before the patch.

 - The macros wait_event and wait_event_interruptible are called with a
   condition argument which has a side effect, i.e. manipulation of the
   requests list.  This side effect happens only if the condition is
   true.  The patch relies on the fact that wait_event[_interruptible]
   does not evaluate the condition again after it became true.

 - The diffstat looks unfavorable with respect to added lines of code.
   However 6 of them are comments, and some are due to separation of
   existing code blocks into two small helper functions.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/raw1394-private.h |    3 -
 drivers/ieee1394/raw1394.c         |   79 ++++++++++++++++-------------
 2 files changed, 46 insertions(+), 36 deletions(-)

This patch won't apply without the -mm patch because of the list_move
patch in -mm.  Variants of this and other 1394 patches for older kernels
can be found at http://me.in-berlin.de/~s5r6/linux1394/updates/.

I tested the patch on 2.6.16.x SMP PREEMPT x86 K7 uniprocessor with the
libraw1394 apps 1394commander and gscanbus, issuing asynchronous
transactions, bus resets, and PHY packets, which trigger raw1394_open,
raw1394_write, raw1394_read, raw1394_poll, raw1394_release.

Index: linux-2.6.17-mm2/drivers/ieee1394/raw1394-private.h
===================================================================
--- linux-2.6.17-mm2.orig/drivers/ieee1394/raw1394-private.h	2006-06-25 21:10:39.000000000 +0200
+++ linux-2.6.17-mm2/drivers/ieee1394/raw1394-private.h	2006-06-25 21:11:07.000000000 +0200
@@ -29,9 +29,8 @@ struct file_info {
 
         struct list_head req_pending;
         struct list_head req_complete;
-        struct semaphore complete_sem;
         spinlock_t reqlists_lock;
-        wait_queue_head_t poll_wait_complete;
+        wait_queue_head_t wait_complete;
 
         struct list_head addr_list;
 
Index: linux-2.6.17-mm2/drivers/ieee1394/raw1394.c
===================================================================
--- linux-2.6.17-mm2.orig/drivers/ieee1394/raw1394.c	2006-06-25 21:10:39.000000000 +0200
+++ linux-2.6.17-mm2/drivers/ieee1394/raw1394.c	2006-06-25 21:11:41.000000000 +0200
@@ -132,10 +132,9 @@ static void free_pending_request(struct 
 static void __queue_complete_req(struct pending_request *req)
 {
 	struct file_info *fi = req->file_info;
-	list_move_tail(&req->list, &fi->req_complete);
 
-	up(&fi->complete_sem);
-	wake_up_interruptible(&fi->poll_wait_complete);
+	list_move_tail(&req->list, &fi->req_complete);
+ 	wake_up(&fi->wait_complete);
 }
 
 static void queue_complete_req(struct pending_request *req)
@@ -463,13 +462,36 @@ raw1394_compat_read(const char __user *b
 
 #endif
 
+/* get next completed request  (caller must hold fi->reqlists_lock) */
+static inline struct pending_request *__next_complete_req(struct file_info *fi)
+{
+	struct list_head *lh;
+	struct pending_request *req = NULL;
+
+	if (!list_empty(&fi->req_complete)) {
+		lh = fi->req_complete.next;
+		list_del(lh);
+		req = list_entry(lh, struct pending_request, list);
+	}
+	return req;
+}
+
+/* atomically get next completed request */
+static struct pending_request *next_complete_req(struct file_info *fi)
+{
+	unsigned long flags;
+	struct pending_request *req;
+
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
+	req = __next_complete_req(fi);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+	return req;
+}
 
 static ssize_t raw1394_read(struct file *file, char __user * buffer,
 			    size_t count, loff_t * offset_is_ignored)
 {
-	unsigned long flags;
 	struct file_info *fi = (struct file_info *)file->private_data;
-	struct list_head *lh;
 	struct pending_request *req;
 	ssize_t ret;
 
@@ -487,22 +509,14 @@ static ssize_t raw1394_read(struct file 
 	}
 
 	if (file->f_flags & O_NONBLOCK) {
-		if (down_trylock(&fi->complete_sem)) {
+		if (!(req = next_complete_req(fi)))
 			return -EAGAIN;
-		}
 	} else {
-		if (down_interruptible(&fi->complete_sem)) {
+		if (wait_event_interruptible(fi->wait_complete,
+					     (req = next_complete_req(fi))))
 			return -ERESTARTSYS;
-		}
 	}
 
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
-	lh = fi->req_complete.next;
-	list_del(lh);
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
-
-	req = list_entry(lh, struct pending_request, list);
-
 	if (req->req.length) {
 		if (copy_to_user(int2ptr(req->req.recvb), req->data,
 				 req->req.length)) {
@@ -2744,7 +2758,7 @@ static unsigned int raw1394_poll(struct 
 	unsigned int mask = POLLOUT | POLLWRNORM;
 	unsigned long flags;
 
-	poll_wait(file, &fi->poll_wait_complete, pt);
+	poll_wait(file, &fi->wait_complete, pt);
 
 	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	if (!list_empty(&fi->req_complete)) {
@@ -2769,9 +2783,8 @@ static int raw1394_open(struct inode *in
 	fi->state = opened;
 	INIT_LIST_HEAD(&fi->req_pending);
 	INIT_LIST_HEAD(&fi->req_complete);
-	sema_init(&fi->complete_sem, 0);
 	spin_lock_init(&fi->reqlists_lock);
-	init_waitqueue_head(&fi->poll_wait_complete);
+	init_waitqueue_head(&fi->wait_complete);
 	INIT_LIST_HEAD(&fi->addr_list);
 
 	file->private_data = fi;
@@ -2784,7 +2797,7 @@ static int raw1394_release(struct inode 
 	struct file_info *fi = file->private_data;
 	struct list_head *lh;
 	struct pending_request *req;
-	int done = 0, i, fail = 0;
+	int i, fail;
 	int retval = 0;
 	struct list_head *entry;
 	struct arm_addr *addr = NULL;
@@ -2864,25 +2877,23 @@ static int raw1394_release(struct inode 
 		       "error(s) occurred \n");
 	}
 
-	while (!done) {
+	for (;;) {
+		/* This locked section guarantees that neither
+		 * complete nor pending requests exist once i!=0 */
 		spin_lock_irqsave(&fi->reqlists_lock, flags);
-
-		while (!list_empty(&fi->req_complete)) {
-			lh = fi->req_complete.next;
-			list_del(lh);
-
-			req = list_entry(lh, struct pending_request, list);
-
+		while ((req = __next_complete_req(fi)))
 			free_pending_request(req);
-		}
-
-		if (list_empty(&fi->req_pending))
-			done = 1;
 
+		i = list_empty(&fi->req_pending);
 		spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
-		if (!done)
-			down_interruptible(&fi->complete_sem);
+		if (i)
+			break;
+
+		/* Sleep until more requests can be freed.
+		 * FIXME?  This sleeps uninterruptibly. */
+		wait_event(fi->wait_complete, (req = next_complete_req(fi)));
+		free_pending_request(req);
 	}
 
 	/* Remove any sub-trees left by user space programs */


