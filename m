Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUHNTlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUHNTlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUHNTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:40:20 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:52610 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264980AbUHNTdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:33:13 -0400
Subject: PATCH [6/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511991.4109.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:33:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 VFS: get rid of the fl_notify, fl_insert, fl_remove fields from
      struct file_lock. They belong in the new lock_manager_operations
      structure.

 Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

 fs/lockd/svclock.c |    3 +--
 fs/locks.c         |   27 ++++++---------------------
 include/linux/fs.h |    7 +++----
 3 files changed, 10 insertions(+), 27 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1-05-nlm_lockowner/fs/lockd/svclock.c linux-2.6.8.1-06-cleanup_locks/fs/lockd/svclock.c
--- linux-2.6.8.1-05-nlm_lockowner/fs/lockd/svclock.c	2004-08-14 14:29:27.000000000 -0400
+++ linux-2.6.8.1-06-cleanup_locks/fs/lockd/svclock.c	2004-08-14 14:29:43.000000000 -0400
@@ -42,7 +42,6 @@
 static void	nlmsvc_insert_block(struct nlm_block *block, unsigned long);
 static int	nlmsvc_remove_block(struct nlm_block *block);
 static void	nlmsvc_grant_callback(struct rpc_task *task);
-static void	nlmsvc_notify_blocked(struct file_lock *);
 
 /*
  * The list of blocked locks to retry
@@ -193,7 +192,6 @@ nlmsvc_create_block(struct svc_rqst *rqs
 		goto failed_free;
 
 	/* Set notifier function for VFS, and init args */
-	block->b_call.a_args.lock.fl.fl_notify = nlmsvc_notify_blocked;
 	block->b_call.a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
 	block->b_call.a_args.cookie = *cookie;	/* see above */
 
@@ -487,6 +485,7 @@ static int nlmsvc_same_owner(struct file
 
 struct lock_manager_operations nlmsvc_lock_operations = {
 	.fl_compare_owner = nlmsvc_same_owner,
+	.fl_notify = nlmsvc_notify_blocked,
 };
 
 /*
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-05-nlm_lockowner/fs/locks.c linux-2.6.8.1-06-cleanup_locks/fs/locks.c
--- linux-2.6.8.1-05-nlm_lockowner/fs/locks.c	2004-08-14 14:29:12.000000000 -0400
+++ linux-2.6.8.1-06-cleanup_locks/fs/locks.c	2004-08-14 14:29:43.000000000 -0400
@@ -189,9 +189,6 @@ void locks_init_lock(struct file_lock *f
 	fl->fl_flags = 0;
 	fl->fl_type = 0;
 	fl->fl_start = fl->fl_end = 0;
-	fl->fl_notify = NULL;
-	fl->fl_insert = NULL;
-	fl->fl_remove = NULL;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 }
@@ -225,9 +222,6 @@ void locks_copy_lock(struct file_lock *n
 	new->fl_type = fl->fl_type;
 	new->fl_start = fl->fl_start;
 	new->fl_end = fl->fl_end;
-	new->fl_notify = fl->fl_notify;
-	new->fl_insert = fl->fl_insert;
-	new->fl_remove = fl->fl_remove;
 	new->fl_ops = fl->fl_ops;
 	new->fl_lmops = fl->fl_lmops;
 	if (fl->fl_ops && fl->fl_ops->fl_copy_lock)
@@ -332,9 +326,6 @@ static int flock_to_posix_lock(struct fi
 	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
-	fl->fl_notify = NULL;
-	fl->fl_insert = NULL;
-	fl->fl_remove = NULL;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -374,9 +365,6 @@ static int flock64_to_posix_lock(struct 
 	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
-	fl->fl_notify = NULL;
-	fl->fl_insert = NULL;
-	fl->fl_remove = NULL;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -412,9 +400,6 @@ static int lease_alloc(struct file *filp
 	}
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
-	fl->fl_notify = NULL;
-	fl->fl_insert = NULL;
-	fl->fl_remove = NULL;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -490,8 +475,8 @@ static void locks_wake_up_blocks(struct 
 		struct file_lock *waiter = list_entry(blocker->fl_block.next,
 				struct file_lock, fl_block);
 		__locks_delete_block(waiter);
-		if (waiter->fl_notify)
-			waiter->fl_notify(waiter);
+		if (waiter->fl_lmops && waiter->fl_lmops->fl_notify)
+			waiter->fl_lmops->fl_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
 	}
@@ -508,8 +493,8 @@ static void locks_insert_lock(struct fil
 	fl->fl_next = *pos;
 	*pos = fl;
 
-	if (fl->fl_insert)
-		fl->fl_insert(fl);
+	if (fl->fl_ops && fl->fl_ops->fl_insert)
+		fl->fl_ops->fl_insert(fl);
 }
 
 /*
@@ -532,8 +517,8 @@ static void locks_delete_lock(struct fil
 		fl->fl_fasync = NULL;
 	}
 
-	if (fl->fl_remove)
-		fl->fl_remove(fl);
+	if (fl->fl_ops && fl->fl_ops->fl_remove)
+		fl->fl_ops->fl_remove(fl);
 
 	locks_wake_up_blocks(fl);
 	locks_free_lock(fl);
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-05-nlm_lockowner/include/linux/fs.h linux-2.6.8.1-06-cleanup_locks/include/linux/fs.h
--- linux-2.6.8.1-05-nlm_lockowner/include/linux/fs.h	2004-08-14 14:40:11.000000000 -0400
+++ linux-2.6.8.1-06-cleanup_locks/include/linux/fs.h	2004-08-14 14:29:43.000000000 -0400
@@ -627,12 +627,15 @@ extern void close_private_file(struct fi
 typedef struct files_struct *fl_owner_t;
 
 struct file_lock_operations {
+	void (*fl_insert)(struct file_lock *);	/* lock insertion callback */
+	void (*fl_remove)(struct file_lock *);	/* lock removal callback */
 	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
 	void (*fl_release_private)(struct file_lock *);
 };
 
 struct lock_manager_operations {
 	int (*fl_compare_owner)(struct file_lock *, struct file_lock *);
+	void (*fl_notify)(struct file_lock *);	/* unblock callback */
 };
 
 /* that will die - we need it for nfs_lock_info */
@@ -651,10 +654,6 @@ struct file_lock {
 	loff_t fl_start;
 	loff_t fl_end;
 
-	void (*fl_notify)(struct file_lock *);	/* unblock callback */
-	void (*fl_insert)(struct file_lock *);	/* lock insertion callback */
-	void (*fl_remove)(struct file_lock *);	/* lock removal callback */
-
 	struct fasync_struct *	fl_fasync; /* for lease break notifications */
 	unsigned long fl_break_time;	/* for nonblocking lease breaks */
 

