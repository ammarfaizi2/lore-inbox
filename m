Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUHNT33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUHNT33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUHNT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:29:22 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:49538 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264857AbUHNT3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:29:03 -0400
Subject: PATCH [1/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511742.4109.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:29:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 VFS: Fix up posix_same_owner() so that it only uses the
      file_lock->fl_owner field when determining lock equality.

 VFS: Fix up posix locking routines to use posix_same_owner() instead
      of rolling their own checks.

    Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

 locks.c |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1/fs/locks.c linux-2.6.8.1-01-fix_locks/fs/locks.c
--- linux-2.6.8.1/fs/locks.c	2004-08-14 14:27:44.000000000 -0400
+++ linux-2.6.8.1-01-fix_locks/fs/locks.c	2004-08-14 14:28:58.000000000 -0400
@@ -414,14 +414,16 @@ static inline int locks_overlap(struct f
 }
 
 /*
- * Check whether two locks have the same owner.  The apparently superfluous
- * check for fl_pid enables us to distinguish between locks set by lockd.
+ * Check whether two locks have the same owner.
  */
 static inline int
 posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
-	return (fl1->fl_owner == fl2->fl_owner) &&
-		(fl1->fl_pid == fl2->fl_pid);
+	/* FIXME: Replace this sort of thing with struct file_lock_operations */
+	if ((fl1->fl_type | fl2->fl_type) & FL_LOCKD)
+		return fl1->fl_owner == fl2->fl_owner &&
+			fl1->fl_pid == fl2->fl_pid;
+	return fl1->fl_owner == fl2->fl_owner;
 }
 
 /* Remove waiter from blocker's block list.
@@ -631,24 +633,15 @@ int posix_locks_deadlock(struct file_loc
 				struct file_lock *block_fl)
 {
 	struct list_head *tmp;
-	fl_owner_t caller_owner, blocked_owner;
-	unsigned int	 caller_pid, blocked_pid;
-
-	caller_owner = caller_fl->fl_owner;
-	caller_pid = caller_fl->fl_pid;
-	blocked_owner = block_fl->fl_owner;
-	blocked_pid = block_fl->fl_pid;
 
 next_task:
-	if (caller_owner == blocked_owner && caller_pid == blocked_pid)
+	if (posix_same_owner(caller_fl, block_fl))
 		return 1;
 	list_for_each(tmp, &blocked_list) {
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
-		if ((fl->fl_owner == blocked_owner)
-		    && (fl->fl_pid == blocked_pid)) {
+		if (posix_same_owner(fl, block_fl)) {
 			fl = fl->fl_next;
-			blocked_owner = fl->fl_owner;
-			blocked_pid = fl->fl_pid;
+			block_fl = fl;
 			goto next_task;
 		}
 	}
@@ -1684,7 +1677,7 @@ void locks_remove_posix(struct file *fil
 	lock_kernel();
 	while (*before != NULL) {
 		struct file_lock *fl = *before;
-		if (IS_POSIX(fl) && (fl->fl_owner == owner)) {
+		if (IS_POSIX(fl) && posix_same_owner(fl, &lock)) {
 			locks_delete_lock(before);
 			continue;
 		}

