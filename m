Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWGBXUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWGBXUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWGBXUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:20:36 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:17111 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750705AbWGBXUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:20:36 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:20:12 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 12/19] ieee1394: raw1394: remove redundant counting semaphore
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.ec101c502c6e8f0e@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.903) AWL,BAYES_50
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
   However 19 of them are comments, and some are due to separation of
   existing code blocks into two small helper functions.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/raw1394-private.h |    3
 drivers/ieee1394/raw1394.c         |   91 ++++++++++++++++++-----------
 2 files changed, 58 insertions(+), 36 deletions(-)

Index: linux-2.6.17-mm5/drivers/ieee1394/raw1394-private.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/raw1394-private.h	2006-07-01 10:56:28.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/raw1394-private.h	2006-07-02 13:47:26.000000000 +0200
@@ -29,9 +29,8 @@ struct file_info {
 
         struct list_head req_pending;
         struct list_head req_complete;
-        struct semaphore complete_sem;
         spinlock_t reqlists_lock;
-        wait_queue_head_t poll_wait_complete;
+        wait_queue_head_t wait_complete;
 
         struct list_head addr_list;
 
Index: linux-2.6.17-mm5/drivers/ieee1394/raw1394.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/raw1394.c	2006-07-02 13:44:15.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/raw1394.c	2006-07-02 13:48:23.000000000 +0200
@@ -133,10 +133,9 @@ static void free_pending_request(struct 
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
@@ -464,13 +463,36 @@ raw1394_compat_read(const char __user *b
 
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
 
@@ -488,22 +510,21 @@ static ssize_t raw1394_read(struct file 
 	}
 
 	if (file->f_flags & O_NONBLOCK) {
-		if (down_trylock(&fi->complete_sem)) {
+		if (!(req = next_complete_req(fi)))
 			return -EAGAIN;
-		}
 	} else {
-		if (down_interruptible(&fi->complete_sem)) {
+		/*
+		 * NB: We call the macro wait_event_interruptible() with a
+		 * condition argument with side effect.  This is only possible
+		 * because the side effect does not occur until the condition
+		 * became true, and wait_event_interruptible() won't evaluate
+		 * the condition again after that.
+		 */
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
@@ -2745,7 +2766,7 @@ static unsigned int raw1394_poll(struct 
 	unsigned int mask = POLLOUT | POLLWRNORM;
 	unsigned long flags;
 
-	poll_wait(file, &fi->poll_wait_complete, pt);
+	poll_wait(file, &fi->wait_complete, pt);
 
 	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	if (!list_empty(&fi->req_complete)) {
@@ -2770,9 +2791,8 @@ static int raw1394_open(struct inode *in
 	fi->state = opened;
 	INIT_LIST_HEAD(&fi->req_pending);
 	INIT_LIST_HEAD(&fi->req_complete);
-	sema_init(&fi->complete_sem, 0);
 	spin_lock_init(&fi->reqlists_lock);
-	init_waitqueue_head(&fi->poll_wait_complete);
+	init_waitqueue_head(&fi->wait_complete);
 	INIT_LIST_HEAD(&fi->addr_list);
 
 	file->private_data = fi;
@@ -2785,7 +2805,7 @@ static int raw1394_release(struct inode 
 	struct file_info *fi = file->private_data;
 	struct list_head *lh;
 	struct pending_request *req;
-	int done = 0, i, fail = 0;
+	int i, fail;
 	int retval = 0;
 	struct list_head *entry;
 	struct arm_addr *addr = NULL;
@@ -2865,25 +2885,28 @@ static int raw1394_release(struct inode 
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
+		/*
+		 * Sleep until more requests can be freed.
+		 *
+		 * NB: We call the macro wait_event() with a condition argument
+		 * with side effect.  This is only possible because the side
+		 * effect does not occur until the condition became true, and
+		 * wait_event() won't evaluate the condition again after that.
+		 */
+		wait_event(fi->wait_complete, (req = next_complete_req(fi)));
+		free_pending_request(req);
 	}
 
 	/* Remove any sub-trees left by user space programs */


