Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWCaRda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWCaRda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWCaRda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:33:30 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:60903 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751075AbWCaRd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:33:29 -0500
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:26:25 +0200)
Subject: [PATCH 4/4] locks: clean up locks_remove_posix()
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNUq-0005Wk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:33:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

locks_remove_posix() can use posix_lock_file() instead of doing the
lock removal by hand.  posix_lock_file() now does exacly the same.

The comment about pids no longer applies, posix_lock_file() takes only
the owner into account.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
+++ linux/fs/locks.c	2006-03-31 18:55:34.000000000 +0200
@@ -1866,15 +1866,15 @@ out:
  */
 void locks_remove_posix(struct file *filp, fl_owner_t owner)
 {
-	struct file_lock lock, **before;
+	struct file_lock lock;
+	struct inode *inode = filp->f_dentry->d_inode;
 
 	/*
 	 * If there are no locks held on this file, we don't need to call
 	 * posix_lock_file().  Another process could be setting a lock on this
 	 * file at the same time, but we wouldn't remove that lock anyway.
 	 */
-	before = &filp->f_dentry->d_inode->i_flock;
-	if (*before == NULL)
+	if (!inode->i_flock)
 		return;
 
 	lock.fl_type = F_UNLCK;
@@ -1887,25 +1887,11 @@ void locks_remove_posix(struct file *fil
 	lock.fl_ops = NULL;
 	lock.fl_lmops = NULL;
 
-	if (filp->f_op && filp->f_op->lock != NULL) {
+	if (filp->f_op && filp->f_op->lock != NULL)
 		filp->f_op->lock(filp, F_SETLK, &lock);
-		goto out;
-	}
+	else
+		__posix_lock_file(inode, &lock, NULL);
 
-	/* Can't use posix_lock_file here; we need to remove it no matter
-	 * which pid we have.
-	 */
-	lock_kernel();
-	while (*before != NULL) {
-		struct file_lock *fl = *before;
-		if (IS_POSIX(fl) && posix_same_owner(fl, &lock)) {
-			locks_delete_lock(before);
-			continue;
-		}
-		before = &fl->fl_next;
-	}
-	unlock_kernel();
-out:
 	if (lock.fl_ops && lock.fl_ops->fl_release_private)
 		lock.fl_ops->fl_release_private(&lock);
 }
