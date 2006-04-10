Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWDJUkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWDJUkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDJUkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:40:09 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:10427 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932145AbWDJUkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:40:07 -0400
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 10 Apr 2006 22:35:20 +0200)
Subject: [PATCH 3/3] locks: clean up locks_remove_posix()
References: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FT3At-0004M4-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Apr 2006 22:39:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

locks_remove_posix() can use posix_lock_file() instead of doing the
lock removal by hand.  posix_lock_file() now does exacly the same.

The comment about pids no longer applies, posix_lock_file() takes only
the owner into account.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-04-09 11:10:01.000000000 +0200
+++ linux/fs/locks.c	2006-04-09 11:17:58.000000000 +0200
@@ -1891,15 +1891,14 @@ out:
  */
 void locks_remove_posix(struct file *filp, fl_owner_t owner)
 {
-	struct file_lock lock, **before;
+	struct file_lock lock;
 
 	/*
 	 * If there are no locks held on this file, we don't need to call
 	 * posix_lock_file().  Another process could be setting a lock on this
 	 * file at the same time, but we wouldn't remove that lock anyway.
 	 */
-	before = &filp->f_dentry->d_inode->i_flock;
-	if (*before == NULL)
+	if (!filp->f_dentry->d_inode->i_flock)
 		return;
 
 	lock.fl_type = F_UNLCK;
@@ -1912,25 +1911,11 @@ void locks_remove_posix(struct file *fil
 	lock.fl_ops = NULL;
 	lock.fl_lmops = NULL;
 
-	if (filp->f_op && filp->f_op->lock != NULL) {
+	if (filp->f_op && filp->f_op->lock != NULL)
 		filp->f_op->lock(filp, F_SETLK, &lock);
-		goto out;
-	}
+	else
+		posix_lock_file(filp, &lock);
 
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
