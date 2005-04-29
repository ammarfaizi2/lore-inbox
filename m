Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVD2ORP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVD2ORP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVD2ORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:17:15 -0400
Received: from ozlabs.org ([203.10.76.45]:50908 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262698AbVD2OPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:15:12 -0400
Date: Sat, 30 Apr 2005 00:11:19 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use smp_mb/wmb/rmb where possible
Message-ID: <20050429141119.GH19662@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Replace a number of memory barriers with smp_ variants. This means we
wont take the unnecessary hit on UP machines.

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: linux-2.6.12-rc2/fs/buffer.c
===================================================================
--- linux-2.6.12-rc2.orig/fs/buffer.c	2005-04-19 13:37:37.905690890 +1000
+++ linux-2.6.12-rc2/fs/buffer.c	2005-04-29 09:45:25.077846782 +1000
@@ -218,7 +218,7 @@
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
-		wmb();
+		smp_wmb();
 
 		sync_inodes_sb(sb, 0);
 		DQUOT_SYNC(sb);
@@ -235,7 +235,7 @@
 		sync_inodes_sb(sb, 1);
 
 		sb->s_frozen = SB_FREEZE_TRANS;
-		wmb();
+		smp_wmb();
 
 		sync_blockdev(sb->s_bdev);
 
@@ -263,7 +263,7 @@
 		if (sb->s_op->unlockfs)
 			sb->s_op->unlockfs(sb);
 		sb->s_frozen = SB_UNFROZEN;
-		wmb();
+		smp_wmb();
 		wake_up(&sb->s_wait_unfrozen);
 		drop_super(sb);
 	}
Index: linux-2.6.12-rc2/ipc/mqueue.c
===================================================================
--- linux-2.6.12-rc2.orig/ipc/mqueue.c	2004-10-29 07:03:22.000000000 +1000
+++ linux-2.6.12-rc2/ipc/mqueue.c	2005-04-29 09:45:25.081846475 +1000
@@ -767,7 +767,7 @@
 	list_del(&receiver->list);
 	receiver->state = STATE_PENDING;
 	wake_up_process(receiver->task);
-	wmb();
+	smp_wmb();
 	receiver->state = STATE_READY;
 }
 
@@ -786,7 +786,7 @@
 	list_del(&sender->list);
 	sender->state = STATE_PENDING;
 	wake_up_process(sender->task);
-	wmb();
+	smp_wmb();
 	sender->state = STATE_READY;
 }
 
Index: linux-2.6.12-rc2/kernel/kthread.c
===================================================================
--- linux-2.6.12-rc2.orig/kernel/kthread.c	2005-01-09 10:05:41.000000000 +1100
+++ linux-2.6.12-rc2/kernel/kthread.c	2005-04-29 09:45:25.082846399 +1000
@@ -174,7 +174,7 @@
 
 	/* Must init completion *before* thread sees kthread_stop_info.k */
 	init_completion(&kthread_stop_info.done);
-	wmb();
+	smp_wmb();
 
 	/* Now set kthread_should_stop() to true, and wake it up. */
 	kthread_stop_info.k = k;
Index: linux-2.6.12-rc2/kernel/profile.c
===================================================================
--- linux-2.6.12-rc2.orig/kernel/profile.c	2005-04-29 09:45:17.095141481 +1000
+++ linux-2.6.12-rc2/kernel/profile.c	2005-04-29 09:45:25.084846246 +1000
@@ -528,7 +528,7 @@
 	return 0;
 out_cleanup:
 	prof_on = 0;
-	mb();
+	smp_mb();
 	on_each_cpu(profile_nop, NULL, 0, 1);
 	for_each_online_cpu(cpu) {
 		struct page *page;
Index: linux-2.6.12-rc2/kernel/ptrace.c
===================================================================
--- linux-2.6.12-rc2.orig/kernel/ptrace.c	2005-02-04 04:10:37.000000000 +1100
+++ linux-2.6.12-rc2/kernel/ptrace.c	2005-04-29 09:45:25.086846092 +1000
@@ -135,7 +135,7 @@
  	    (current->gid != task->sgid) ||
  	    (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
 		goto bad;
-	rmb();
+	smp_rmb();
 	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
 		goto bad;
 	/* the same process cannot be attached many times */
Index: linux-2.6.12-rc2/kernel/stop_machine.c
===================================================================
--- linux-2.6.12-rc2.orig/kernel/stop_machine.c	2005-03-29 16:06:38.000000000 +1000
+++ linux-2.6.12-rc2/kernel/stop_machine.c	2005-04-29 09:45:25.088845939 +1000
@@ -33,7 +33,7 @@
 	set_cpus_allowed(current, cpumask_of_cpu((int)(long)cpu));
 
 	/* Ack: we are alive */
-	mb(); /* Theoretically the ack = 0 might not be on this CPU yet. */
+	smp_mb(); /* Theoretically the ack = 0 might not be on this CPU yet. */
 	atomic_inc(&stopmachine_thread_ack);
 
 	/* Simple state machine */
@@ -43,14 +43,14 @@
 			local_irq_disable();
 			irqs_disabled = 1;
 			/* Ack: irqs disabled. */
-			mb(); /* Must read state first. */
+			smp_mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
 		} else if (stopmachine_state == STOPMACHINE_PREPARE
 			   && !prepared) {
 			/* Everyone is in place, hold CPU. */
 			preempt_disable();
 			prepared = 1;
-			mb(); /* Must read state first. */
+			smp_mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
 		}
 		/* Yield in first stage: migration threads need to
@@ -62,7 +62,7 @@
 	}
 
 	/* Ack: we are exiting. */
-	mb(); /* Must read state first. */
+	smp_mb(); /* Must read state first. */
 	atomic_inc(&stopmachine_thread_ack);
 
 	if (irqs_disabled)
@@ -77,7 +77,7 @@
 static void stopmachine_set_state(enum stopmachine_state state)
 {
 	atomic_set(&stopmachine_thread_ack, 0);
-	wmb();
+	smp_wmb();
 	stopmachine_state = state;
 	while (atomic_read(&stopmachine_thread_ack) != stopmachine_num_threads)
 		cpu_relax();
Index: linux-2.6.12-rc2/kernel/sys.c
===================================================================
--- linux-2.6.12-rc2.orig/kernel/sys.c	2005-04-19 13:37:40.664011630 +1000
+++ linux-2.6.12-rc2/kernel/sys.c	2005-04-29 09:45:25.093845556 +1000
@@ -545,7 +545,7 @@
 	if (new_egid != old_egid)
 	{
 		current->mm->dumpable = 0;
-		wmb();
+		smp_wmb();
 	}
 	if (rgid != (gid_t) -1 ||
 	    (egid != (gid_t) -1 && egid != old_rgid))
@@ -576,7 +576,7 @@
 		if(old_egid != gid)
 		{
 			current->mm->dumpable=0;
-			wmb();
+			smp_wmb();
 		}
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
 	}
@@ -585,7 +585,7 @@
 		if(old_egid != gid)
 		{
 			current->mm->dumpable=0;
-			wmb();
+			smp_wmb();
 		}
 		current->egid = current->fsgid = gid;
 	}
@@ -616,7 +616,7 @@
 	if(dumpclear)
 	{
 		current->mm->dumpable = 0;
-		wmb();
+		smp_wmb();
 	}
 	current->uid = new_ruid;
 	return 0;
@@ -673,7 +673,7 @@
 	if (new_euid != old_euid)
 	{
 		current->mm->dumpable=0;
-		wmb();
+		smp_wmb();
 	}
 	current->fsuid = current->euid = new_euid;
 	if (ruid != (uid_t) -1 ||
@@ -723,7 +723,7 @@
 	if (old_euid != uid)
 	{
 		current->mm->dumpable = 0;
-		wmb();
+		smp_wmb();
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
@@ -768,7 +768,7 @@
 		if (euid != current->euid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->euid = euid;
 	}
@@ -818,7 +818,7 @@
 		if (egid != current->egid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->egid = egid;
 	}
@@ -865,7 +865,7 @@
 		if (uid != old_fsuid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->fsuid = uid;
 	}
@@ -895,7 +895,7 @@
 		if (gid != old_fsgid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->fsgid = gid;
 		key_fsgid_changed(current);
Index: linux-2.6.12-rc2/kernel/timer.c
===================================================================
--- linux-2.6.12-rc2.orig/kernel/timer.c	2005-04-19 13:37:40.681010312 +1000
+++ linux-2.6.12-rc2/kernel/timer.c	2005-04-29 09:45:25.096845326 +1000
@@ -999,7 +999,7 @@
 		 * Make sure we read the pid before re-reading the
 		 * parent pointer:
 		 */
-		rmb();
+		smp_rmb();
 		parent = me->group_leader->real_parent;
 		if (old != parent)
 			continue;
Index: linux-2.6.12-rc2/lib/rwsem-spinlock.c
===================================================================
--- linux-2.6.12-rc2.orig/lib/rwsem-spinlock.c	2005-03-10 06:08:38.000000000 +1100
+++ linux-2.6.12-rc2/lib/rwsem-spinlock.c	2005-04-29 09:45:25.098845173 +1000
@@ -76,7 +76,7 @@
 		list_del(&waiter->list);
 		tsk = waiter->task;
 		/* Don't touch waiter after ->task has been NULLed */
-		mb();
+		smp_mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
 		put_task_struct(tsk);
@@ -91,7 +91,7 @@
 
 		list_del(&waiter->list);
 		tsk = waiter->task;
-		mb();
+		smp_mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
 		put_task_struct(tsk);
@@ -123,7 +123,7 @@
 	list_del(&waiter->list);
 
 	tsk = waiter->task;
-	mb();
+	smp_mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
 	put_task_struct(tsk);
Index: linux-2.6.12-rc2/lib/rwsem.c
===================================================================
--- linux-2.6.12-rc2.orig/lib/rwsem.c	2005-03-10 06:08:38.000000000 +1100
+++ linux-2.6.12-rc2/lib/rwsem.c	2005-04-29 09:45:25.100845020 +1000
@@ -74,7 +74,7 @@
 	 */
 	list_del(&waiter->list);
 	tsk = waiter->task;
-	mb();
+	smp_mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
 	put_task_struct(tsk);
@@ -117,7 +117,7 @@
 		waiter = list_entry(next, struct rwsem_waiter, list);
 		next = waiter->list.next;
 		tsk = waiter->task;
-		mb();
+		smp_mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
 		put_task_struct(tsk);
Index: linux-2.6.12-rc2/mm/mempool.c
===================================================================
--- linux-2.6.12-rc2.orig/mm/mempool.c	2005-03-29 16:06:38.000000000 +1000
+++ linux-2.6.12-rc2/mm/mempool.c	2005-04-29 09:45:25.101844943 +1000
@@ -210,7 +210,7 @@
 	 * If the pool is less than 50% full and we can perform effective
 	 * page reclaim then try harder to allocate an element.
 	 */
-	mb();
+	smp_mb();
 	if ((gfp_mask & __GFP_FS) && (gfp_mask != gfp_nowait) &&
 				(pool->curr_nr <= pool->min_nr/2)) {
 		element = pool->alloc(gfp_mask, pool->pool_data);
@@ -236,7 +236,7 @@
 		return NULL;
 
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
-	mb();
+	smp_mb();
 	if (!pool->curr_nr)
 		io_schedule();
 	finish_wait(&pool->wait, &wait);
@@ -257,7 +257,7 @@
 {
 	unsigned long flags;
 
-	mb();
+	smp_mb();
 	if (pool->curr_nr < pool->min_nr) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (pool->curr_nr < pool->min_nr) {
