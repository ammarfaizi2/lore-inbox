Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUHTE6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUHTE6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHTE5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:57:52 -0400
Received: from thunk.org ([140.239.227.29]:17068 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267521AbUHTE5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:57:24 -0400
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH] [4/4] /dev/random: Remove RNDGETPOOL ioctl
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1By1St-0001TS-Qj@thunk.org>
Date: Fri, 20 Aug 2004 00:57:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recently, someone has kvetched that RNDGETPOOL is a "security
vulnerability".  Never mind that it is superuser only, and with
superuser privs you could load a nasty kernel module, or read the
entropy pool out of /dev/mem directly, but they are nevertheless still
spreading FUD.

In any case, no one is using it (it was there for debugging purposes
only), so we can remove it as dead code.

patch-random-4-remove-rndgetpool

--- random.c	2004/08/19 22:50:19	1.4
+++ random.c	2004/08/19 22:50:43	1.5
@@ -1741,10 +1741,9 @@
 random_ioctl(struct inode * inode, struct file * file,
 	     unsigned int cmd, unsigned long arg)
 {
-	int *tmp, size, ent_count;
+	int size, ent_count;
 	int __user *p = (int __user *)arg;
 	int retval;
-	unsigned long flags;
 	
 	switch (cmd) {
 	case RNDGETENTCNT:
@@ -1765,40 +1764,6 @@
 		if (random_state->entropy_count >= random_read_wakeup_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
-	case RNDGETPOOL:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		if (get_user(size, p) ||
-		    put_user(random_state->poolinfo.poolwords, p++))
-			return -EFAULT;
-		if (size < 0)
-			return -EFAULT;
-		if (size > random_state->poolinfo.poolwords)
-			size = random_state->poolinfo.poolwords;
-
-		/* prepare to atomically snapshot pool */
-
-		tmp = kmalloc(size * sizeof(__u32), GFP_KERNEL);
-
-		if (!tmp)
-			return -ENOMEM;
-
-		spin_lock_irqsave(&random_state->lock, flags);
-		ent_count = random_state->entropy_count;
-		memcpy(tmp, random_state->pool, size * sizeof(__u32));
-		spin_unlock_irqrestore(&random_state->lock, flags);
-
-		if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
-			kfree(tmp);
-			return -EFAULT;
-		}
-
-		kfree(tmp);
-
-		if(put_user(ent_count, p++))
-			return -EFAULT;
-
-		return 0;
 	case RNDADDENTROPY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
