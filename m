Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVAITms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVAITms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAITmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:42:35 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:54026 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261734AbVAITmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:42:13 -0500
Date: Sun, 9 Jan 2005 19:42:09 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: viro@zenII.uk.linux.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: make flock_lock_file_wait static
Message-ID: <20050109194209.GA7588@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below makes flock_lock_file_wait static, because it is only used
(once) in fs/locks.c. Making it static allows gcc to generate better code
(partial or entirely inlining it, gcc 3.4 also optimizes the calling
convention for static functions which are guaranteed only local to the file)


Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.10/fs/locks.c linux/fs/locks.c
--- linux-2.6.10/fs/locks.c	2005-01-09 14:51:10.101125171 +0100
+++ linux/fs/locks.c	2005-01-09 20:39:44.930216959 +0100
@@ -1451,7 +1451,7 @@ out_unlock:
  *
  * Add a FLOCK style lock to a file.
  */
-int flock_lock_file_wait(struct file *filp, struct file_lock *fl)
+static int flock_lock_file_wait(struct file *filp, struct file_lock *fl)
 {
 	int error;
 	might_sleep();
@@ -1469,8 +1469,6 @@ int flock_lock_file_wait(struct file *fi
 	return error;
 }
 
-EXPORT_SYMBOL(flock_lock_file_wait);
-
 /**
  *	sys_flock: - flock() system call.
  *	@fd: the file descriptor to lock.
diff -purN linux-2.6.10/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.6.10/include/linux/fs.h	2005-01-09 14:51:10.293101584 +0100
+++ linux/include/linux/fs.h	2005-01-09 20:39:18.678389875 +0100
@@ -709,7 +709,6 @@ extern int posix_lock_file_wait(struct f
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
 extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
-extern int flock_lock_file_wait(struct file *filp, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags);
 extern void lease_get_mtime(struct inode *, struct timespec *time);
 extern int setlease(struct file *, long, struct file_lock **);

