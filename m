Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWBQSoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWBQSoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBQSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:44:03 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:62692 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751055AbWBQSoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:44:01 -0500
Message-ID: <43F62B96.C54704D1@tv-sign.ru>
Date: Fri, 17 Feb 2006 23:01:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] convert sighand_cache to use SLAB_DESTROY_BY_RCU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch borrows a clever Hugh's 'struct anon_vma' trick.

Without tasklist_lock held we can't trust task->sighand until we
locked it and re-checked that it is still the same.

But this means we don't need to defer 'kmem_cache_free(sighand)'.
We can return the memory to slab immediately, all we need is to
be sure that sighand->siglock can't dissapear inside rcu protected
section.

To do so we need to initialize ->siglock inside ctor function,
SLAB_DESTROY_BY_RCU does the rest.

 include/linux/sched.h |    8 --------
 kernel/fork.c         |   21 +++++++++++----------
 kernel/signal.c       |    2 +-
 fs/exec.c             |    3 +--
 4 files changed, 13 insertions(+), 21 deletions(-)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/include/linux/sched.h~1_DBR	2006-02-16 22:04:46.000000000 +0300
+++ 2.6.16-rc3/include/linux/sched.h	2006-02-18 00:05:20.000000000 +0300
@@ -353,16 +353,8 @@ struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
-	struct rcu_head		rcu;
 };
 
-extern void sighand_free_cb(struct rcu_head *rhp);
-
-static inline void sighand_free(struct sighand_struct *sp)
-{
-	call_rcu(&sp->rcu, sighand_free_cb);
-}
-
 /*
  * NOTE! "signal_struct" does not have it's own
  * locking, because a shared signal_struct always
--- 2.6.16-rc3/kernel/fork.c~1_DBR	2006-02-16 23:15:23.000000000 +0300
+++ 2.6.16-rc3/kernel/fork.c	2006-02-18 01:11:59.000000000 +0300
@@ -784,14 +784,6 @@ int unshare_files(void)
 
 EXPORT_SYMBOL(unshare_files);
 
-void sighand_free_cb(struct rcu_head *rhp)
-{
-	struct sighand_struct *sp;
-
-	sp = container_of(rhp, struct sighand_struct, rcu);
-	kmem_cache_free(sighand_cachep, sp);
-}
-
 static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct sighand_struct *sig;
@@ -804,7 +796,6 @@ static inline int copy_sighand(unsigned 
 	rcu_assign_pointer(tsk->sighand, sig);
 	if (!sig)
 		return -ENOMEM;
-	spin_lock_init(&sig->siglock);
 	atomic_set(&sig->count, 1);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	return 0;
@@ -1345,11 +1336,21 @@ long do_fork(unsigned long clone_flags,
 #define ARCH_MIN_MMSTRUCT_ALIGN 0
 #endif
 
+static void sighand_ctor(void *data, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct sighand_struct *sighand = data;
+
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
+					SLAB_CTOR_CONSTRUCTOR)
+		spin_lock_init(&sighand->siglock);
+}
+
 void __init proc_caches_init(void)
 {
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_DESTROY_BY_RCU,
+			sighand_ctor, NULL);
 	signal_cachep = kmem_cache_create("signal_cache",
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
--- 2.6.16-rc3/kernel/signal.c~1_DBR	2006-02-13 21:47:19.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-18 00:07:37.000000000 +0300
@@ -330,7 +330,7 @@ void __exit_sighand(struct task_struct *
 	/* Ok, we're done with the signal handlers */
 	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
-		sighand_free(sighand);
+		kmem_cache_free(sighand_cachep, sighand);
 }
 
 void exit_sighand(struct task_struct *tsk)
--- 2.6.16-rc3/fs/exec.c~1_DBR	2006-02-16 22:34:59.000000000 +0300
+++ 2.6.16-rc3/fs/exec.c	2006-02-18 01:12:36.000000000 +0300
@@ -751,7 +751,6 @@ no_thread_group:
 		/*
 		 * Move our state over to newsighand and switch it in.
 		 */
-		spin_lock_init(&newsighand->siglock);
 		atomic_set(&newsighand->count, 1);
 		memcpy(newsighand->action, oldsighand->action,
 		       sizeof(newsighand->action));
@@ -768,7 +767,7 @@ no_thread_group:
 		write_unlock_irq(&tasklist_lock);
 
 		if (atomic_dec_and_test(&oldsighand->count))
-			sighand_free(oldsighand);
+			kmem_cache_free(sighand_cachep, oldsighand);
 	}
 
 	BUG_ON(!thread_group_leader(current));
