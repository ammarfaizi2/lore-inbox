Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129948AbQJaQPJ>; Tue, 31 Oct 2000 11:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbQJaQO7>; Tue, 31 Oct 2000 11:14:59 -0500
Received: from mons.uio.no ([129.240.130.14]:30611 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129718AbQJaQOq>;
	Tue, 31 Oct 2000 11:14:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14846.61426.636279.523179@charged.uio.no>
Date: Tue, 31 Oct 2000 17:14:42 +0100 (CET)
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [PATCH] fix deadlocks + blocking in 2.4.0 pre6/7 knfsd locking...
X-Mailer: VM 6.71 under 21.1 (patch 3) "Acadia" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/locks.c

  - Drop semaphore when we call fl_notify hooks. This is to allow the
    notification routines to call posix_unblock_lock().
  - In locks_wake_up_blocks(), drop semaphore when we're asking the
    waiter waiter to unblock, and reorder loop to protect against the
    waiter disappearing beneath us while we're not holding the
    semaphore.
  - locks_delete_lock() should not call file->f_op->lock().  The
    latter notifies the *server*, hence calling it from routines like
    posix_lock_file() while merging/unmerging locks in our internal
    representation of the locks is a bug.
    A new function locks_unlock_delete() takes care of the special
    case when we're freeing all locks upon close() and drops the
    semaphore before notifying the server.

fs/lockd/clntproc.c

  - Grab kernel_lock() when accessing lockd-specific structures from
    the higher-level locking via fl_notify/fl_insert/fl_delete.
  - We must use locks_copy_lock() in order to copy the actual struct
    file_lock in nlmclnt_setgrantargs() if we want to avoid clobbering 
    the list structure.

fs/lockd/svclock.c
   - Fix timeout mechanism in 'nlm_blocked' list:
      1) allow for jiffy wraparound - use time_before/after
      2) fix NLM_NEVER 'magic value' for no-timeout.
   - When removing from the nlm_blocked, ensure that block->b_queued
     flag is reset.
   - Fix race in block notification with wake up lockd.

net/sunrpc/svcsock.c
   - ensure that svc_wake_up() does result in the lockd() routine
     being called back, rather than just looping in svc_recv().

Trond

  
diff -u --recursive --new-file linux-2.4.0-test10-pre6/fs/lockd/clntproc.c linux-2.4.0-test10-fix_locks/fs/lockd/clntproc.c
--- linux-2.4.0-test10-pre6/fs/lockd/clntproc.c	Thu Sep 21 22:38:58 2000
+++ linux-2.4.0-test10-fix_locks/fs/lockd/clntproc.c	Sat Oct 28 18:25:59 2000
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
+#include <linux/smp_lock.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
@@ -64,11 +65,11 @@
 int
 nlmclnt_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
 {
-	nlmclnt_next_cookie(&call->a_args.cookie);
-	call->a_args.lock    = *lock;
+	locks_copy_lock(&call->a_args.lock.fl, &lock->fl);
+	memcpy(&call->a_args.lock.fh, &lock->fh, sizeof(call->a_args.lock.fh));
 	call->a_args.lock.caller = system_utsname.nodename;
+	call->a_args.lock.oh.len = lock->oh.len;
 
-	init_waitqueue_head(&call->a_args.lock.fl.fl_wait);
 	/* set default data area */
 	call->a_args.lock.oh.data = call->a_owner;
 
@@ -406,15 +407,19 @@
 static
 void nlmclnt_insert_lock_callback(struct file_lock *fl)
 {
+	lock_kernel();
 	nlm_get_host(fl->fl_u.nfs_fl.host);
+	unlock_kernel();
 }
 static
 void nlmclnt_remove_lock_callback(struct file_lock *fl)
 {
+	lock_kernel();
 	if (fl->fl_u.nfs_fl.host) {
 		nlm_release_host(fl->fl_u.nfs_fl.host);
 		fl->fl_u.nfs_fl.host = NULL;
 	}
+	unlock_kernel();
 }
 
 /*
diff -u --recursive --new-file linux-2.4.0-test10-pre6/fs/lockd/svclock.c linux-2.4.0-test10-fix_locks/fs/lockd/svclock.c
--- linux-2.4.0-test10-pre6/fs/lockd/svclock.c	Fri Oct 27 14:50:13 2000
+++ linux-2.4.0-test10-fix_locks/fs/lockd/svclock.c	Sat Oct 28 18:25:44 2000
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/smp_lock.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/nlm.h>
@@ -53,9 +54,15 @@
 	dprintk("lockd: nlmsvc_insert_block(%p, %ld)\n", block, when);
 	if (block->b_queued)
 		nlmsvc_remove_block(block);
-	for (bp = &nlm_blocked; (b = *bp); bp = &b->b_next)
-		if (when < b->b_when)
-			break;
+	bp = &nlm_blocked;
+	if (when != NLM_NEVER) {
+		if ((when += jiffies) == NLM_NEVER)
+			when ++;
+		while ((b = *bp) && time_before_eq(b->b_when,when))
+			bp = &b->b_next;
+	} else
+		while ((b = *bp))
+			bp = &b->b_next;
 
 	block->b_queued = 1;
 	block->b_when = when;
@@ -106,8 +113,10 @@
 				(long long)fl->fl_end, fl->fl_type,
 				*(unsigned int*)(block->b_call.a_args.cookie.data));
 		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
-			if (remove)
+			if (remove) {
 				*head = block->b_next;
+				block->b_queued = 0;
+			}
 			return block;
 		}
 	}
@@ -173,10 +182,11 @@
 	locks_init_lock(&block->b_call.a_args.lock.fl);
 	locks_init_lock(&block->b_call.a_res.lock.fl);
 
-	/* Set notifier function for VFS, and init args */
-	lock->fl.fl_notify = nlmsvc_notify_blocked;
 	if (!nlmclnt_setgrantargs(&block->b_call, lock))
 		goto failed_free;
+
+	/* Set notifier function for VFS, and init args */
+	block->b_call.a_args.lock.fl.fl_notify = nlmsvc_notify_blocked;
 	block->b_call.a_args.cookie = *cookie;	/* see above */
 
 	dprintk("lockd: created block %p...\n", block);
@@ -457,13 +467,15 @@
 
 	dprintk("lockd: VFS unblock notification for block %p\n", fl);
 	posix_unblock_lock(fl);
+	lock_kernel();
 	for (bp = &nlm_blocked; (block = *bp); bp = &block->b_next) {
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
-			svc_wake_up(block->b_daemon);
 			nlmsvc_insert_block(block, 0);
+			svc_wake_up(block->b_daemon);
 			return;
 		}
 	}
+	unlock_kernel();
 
 	printk(KERN_WARNING "lockd: notification for unknown block!\n");
 }
@@ -520,7 +532,7 @@
 	if ((error = posix_lock_file(&file->f_file, &lock->fl, 0)) < 0) {
 		printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
 				-error, __FUNCTION__);
-		nlmsvc_insert_block(block, jiffies + 10 * HZ);
+		nlmsvc_insert_block(block, 10 * HZ);
 		up(&file->f_sema);
 		return;
 	}
@@ -532,7 +544,7 @@
 	block->b_incall  = 1;
 
 	/* Schedule next grant callback in 30 seconds */
-	nlmsvc_insert_block(block, jiffies + 30 * HZ);
+	nlmsvc_insert_block(block, 30 * HZ);
 
 	/* Call the client */
 	nlm_get_host(block->b_call.a_host);
@@ -570,13 +582,13 @@
 	 * can be done, though. */
 	if (task->tk_status < 0) {
 		/* RPC error: Re-insert for retransmission */
-		timeout = jiffies + 10 * HZ;
+		timeout = 10 * HZ;
 	} else if (block->b_done) {
 		/* Block already removed, kill it for real */
 		timeout = 0;
 	} else {
 		/* Call was successful, now wait for client callback */
-		timeout = jiffies + 60 * HZ;
+		timeout = 60 * HZ;
 	}
 	nlmsvc_insert_block(block, timeout);
 	svc_wake_up(block->b_daemon);
@@ -604,7 +616,7 @@
 	if ((block = nlmsvc_find_block(cookie)) != NULL) {
 		if (status == NLM_LCK_DENIED_GRACE_PERIOD) {
 			/* Try again in a couple of seconds */
-			nlmsvc_insert_block(block, jiffies + 10 * HZ);
+			nlmsvc_insert_block(block, 10 * HZ);
 			block = NULL;
 		} else {
 			/* Lock is now held by client, or has been rejected.
@@ -635,7 +647,11 @@
 	dprintk("nlmsvc_retry_blocked(%p, when=%ld)\n",
 			nlm_blocked,
 			nlm_blocked? nlm_blocked->b_when : 0);
-	while ((block = nlm_blocked) && block->b_when <= jiffies) {
+	while ((block = nlm_blocked)) {
+		if (block->b_when == NLM_NEVER)
+			break;
+	        if (time_after(block->b_when,jiffies))
+			break;
 		dprintk("nlmsvc_retry_blocked(%p, when=%ld, done=%d)\n",
 			block, block->b_when, block->b_done);
 		if (block->b_done)
diff -u --recursive --new-file linux-2.4.0-test10-pre6/fs/locks.c linux-2.4.0-test10-fix_locks/fs/locks.c
--- linux-2.4.0-test10-pre6/fs/locks.c	Fri Oct 27 14:50:13 2000
+++ linux-2.4.0-test10-fix_locks/fs/locks.c	Sat Oct 28 18:12:20 2000
@@ -436,21 +436,28 @@
 {
 	while (!list_empty(&blocker->fl_block)) {
 		struct file_lock *waiter = list_entry(blocker->fl_block.next, struct file_lock, fl_block);
+
+		if (!wait) {
+			/* Remove waiter from the block list, because by the
+			 * time it wakes up blocker won't exist any more.
+			 */
+			locks_delete_block(waiter);
+		}
 		/* N.B. Is it possible for the notify function to block?? */
-		if (waiter->fl_notify)
+		if (waiter->fl_notify) {
+			release_fl_sem();
 			waiter->fl_notify(waiter);
-		wake_up(&waiter->fl_wait);
+			acquire_fl_sem();
+		} else
+			wake_up(&waiter->fl_wait);
 		if (wait) {
+			release_fl_sem();
 			/* Let the blocked process remove waiter from the
 			 * block list when it gets scheduled.
 			 */
 			current->policy |= SCHED_YIELD;
 			schedule();
-		} else {
-			/* Remove waiter from the block list, because by the
-			 * time it wakes up blocker won't exist any more.
-			 */
-			locks_delete_block(waiter);
+			acquire_fl_sem();
 		}
 	}
 }
@@ -477,7 +484,6 @@
  */
 static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
 {
-	int (*lock)(struct file *, int, struct file_lock *);
 	struct file_lock *fl = *thisfl_p;
 
 	*thisfl_p = fl->fl_next;
@@ -496,12 +502,26 @@
 		fl->fl_remove(fl);
 
 	locks_wake_up_blocks(fl, wait);
-	lock = fl->fl_file->f_op->lock;
-	if (lock) {
+	locks_free_lock(fl);
+}
+
+/*
+ * Call back client filesystem in order to get it to unregister a lock,
+ * then delete lock. Essentially useful only in locks_remove_*().
+ * Note: this must be called with the semaphore already held!
+ */
+static inline void locks_unlock_delete(struct file_lock **thisfl_p)
+{
+	struct file_lock *fl = *thisfl_p;
+	int (*lock)(struct file *, int, struct file_lock *);
+
+	if ((lock = fl->fl_file->f_op->lock) != NULL) {
 		fl->fl_type = F_UNLCK;
+		release_fl_sem();
 		lock(fl->fl_file, F_SETLK, fl);
+		acquire_fl_sem();
 	}
-	locks_free_lock(fl);
+	locks_delete_lock(thisfl_p, 0);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -1644,11 +1664,12 @@
 		return;
 	}
 	acquire_fl_sem();
+ again:
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
-			locks_delete_lock(before, 0);
-			continue;
+			locks_unlock_delete(before);
+			goto again;
 		}
 		before = &fl->fl_next;
 	}
diff -u --recursive --new-file linux-2.4.0-test10-pre6/net/sunrpc/svcsock.c linux-2.4.0-test10-fix_locks/net/sunrpc/svcsock.c
--- linux-2.4.0-test10-pre6/net/sunrpc/svcsock.c	Sat Jul  8 00:57:49 2000
+++ linux-2.4.0-test10-fix_locks/net/sunrpc/svcsock.c	Fri Oct 27 17:12:11 2000
@@ -800,7 +800,6 @@
 			"svc_recv: service %p, wait queue active!\n",
 			 rqstp);
 
-again:
 	/* Initialize the buffers */
 	rqstp->rq_argbuf = rqstp->rq_defbuf;
 	rqstp->rq_resbuf = rqstp->rq_defbuf;
@@ -846,7 +845,7 @@
 	/* No data, incomplete (TCP) read, or accept() */
 	if (len == 0 || len == -EAGAIN) {
 		svc_sock_release(rqstp);
-		goto again;
+		return -EAGAIN;
 	}
 
 	rqstp->rq_secure  = ntohs(rqstp->rq_addr.sin_port) < 1024;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
