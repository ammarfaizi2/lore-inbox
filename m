Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUH1PSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUH1PSP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUH1PSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:18:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51929 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266925AbUH1PRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:17:24 -0400
Date: Sat, 28 Aug 2004 17:17:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch][2/3] kernel/ BUG -> BUG_ON conversions
Message-ID: <20040828151716.GC12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828151137.GA12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does BUG -> BUG_ON conversions in kernel/ .

diffstat output:
 kernel/cpu.c      |    8 +++-----
 kernel/exit.c     |   13 +++++--------
 kernel/fork.c     |    3 +--
 kernel/module.c   |    9 +++------
 kernel/power/pm.c |    3 +--
 kernel/printk.c   |    6 ++----
 kernel/ptrace.c   |    6 ++----
 kernel/signal.c   |   27 +++++++++------------------
 kernel/softirq.c  |    6 ++----
 kernel/timer.c    |    3 +--
 10 files changed, 29 insertions(+), 55 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full-3.4/kernel/cpu.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/cpu.c	2004-08-28 16:06:24.000000000 +0200
@@ -156,9 +156,8 @@
 	kthread_bind(p, smp_processor_id());
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
-	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
-	    == NOTIFY_BAD)
-		BUG();
+	BUG_ON(notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
+	       == NOTIFY_BAD);
 
 	check_for_tasks(cpu);
 
@@ -203,8 +202,7 @@
 	ret = __cpu_up(cpu);
 	if (ret != 0)
 		goto out_notify;
-	if (!cpu_online(cpu))
-		BUG();
+	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/exit.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/exit.c	2004-08-28 16:08:24.000000000 +0200
@@ -503,7 +503,7 @@
 		down_read(&mm->mmap_sem);
 	}
 	atomic_inc(&mm->mm_count);
-	if (mm != tsk->active_mm) BUG();
+	BUG_ON(mm != tsk->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(tsk);
 	tsk->mm = NULL;
@@ -878,11 +877,9 @@
 	const struct list_head *tmp, *head = &link->pidptr->task_list;
 
 #ifdef CONFIG_SMP
-	if (!p->sighand)
-		BUG();
-	if (!spin_is_locked(&p->sighand->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
-		BUG();
+	BUG_ON(!p->sighand);
+	BUG_ON(!spin_is_locked(&p->sighand->siglock) &&
+				!rwlock_is_locked(&tasklist_lock));
 #endif
 	tmp = link->pid_chain.next;
 	if (tmp == head)
@@ -1350,8 +1347,7 @@
 		if (options & __WNOTHREAD)
 			break;
 		tsk = next_thread(tsk);
-		if (tsk->signal != current->signal)
-			BUG();
+		BUG_ON(tsk->signal != current->signal);
 	} while (tsk != current);
 
 	read_unlock(&tasklist_lock);
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/fork.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/fork.c	2004-08-28 16:08:45.000000000 +0200
@@ -809,8 +809,7 @@
 	struct files_struct *files  = current->files;
 	int rc;
 
-	if(!files)
-		BUG();
+	BUG_ON(!files);
 
 	/* This can race but the race causes us to copy when we don't
 	   need to and drop the copy */
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/module.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/module.c	2004-08-28 16:13:44.000000000 +0200
@@ -655,8 +655,7 @@
 	const unsigned long *crc;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &owner, &crc, 1))
-		BUG();
+	BUG_ON(!__find_symbol(symbol, &owner, &crc, 1));
 	module_put(owner);
 	spin_unlock_irqrestore(&modlist_lock, flags);
 }
@@ -667,8 +666,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!kernel_text_address((unsigned long)addr))
-		BUG();
+	BUG_ON(!kernel_text_address((unsigned long)addr));
 
 	module_put(module_text_address((unsigned long)addr));
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -905,8 +903,7 @@
 	const unsigned long *crc;
 	struct module *owner;
 
-	if (!__find_symbol("struct_module", &owner, &crc, 1))
-		BUG();
+	BUG_ON(!__find_symbol("struct_module", &owner, &crc, 1));
 	return check_version(sechdrs, versindex, "struct_module", mod,
 			     crc);
 }
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/power/pm.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/power/pm.c	2004-08-28 16:14:19.000000000 +0200
@@ -156,8 +156,7 @@
 	int status = 0;
 	unsigned long prev_state, next_state;
 
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	switch (rqst) {
 	case PM_SUSPEND:
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/printk.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/printk.c	2004-08-28 16:14:47.000000000 +0200
@@ -418,8 +418,7 @@
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
-	if (((long)(start - end)) > 0)
-		BUG();
+	BUG_ON(((long)(start - end)) > 0);
 
 	cur_index = start;
 	start_print = start;
@@ -596,8 +595,7 @@
  */
 void acquire_console_sem(void)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	down(&console_sem);
 	console_locked = 1;
 	console_may_schedule = 1;
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/ptrace.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/ptrace.c	2004-08-28 16:15:19.000000000 +0200
@@ -28,8 +28,7 @@
  */
 void __ptrace_link(task_t *child, task_t *new_parent)
 {
-	if (!list_empty(&child->ptrace_list))
-		BUG();
+	BUG_ON(!list_empty(&child->ptrace_list));
 	if (child->parent == new_parent)
 		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
@@ -46,8 +45,7 @@
  */
 void __ptrace_unlink(task_t *child)
 {
-	if (!child->ptrace)
-		BUG();
+	BUG_ON(!child->ptrace);
 	child->ptrace = 0;
 	if (list_empty(&child->ptrace_list))
 		return;
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/signal.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/signal.c	2004-08-28 16:17:07.000000000 +0200
@@ -346,10 +346,8 @@
 	struct signal_struct * sig = tsk->signal;
 	struct sighand_struct * sighand = tsk->sighand;
 
-	if (!sig)
-		BUG();
-	if (!atomic_read(&sig->count))
-		BUG();
+	BUG_ON(!sig);
+	BUG_ON(!atomic_read(&sig->count));
 	spin_lock(&sighand->siglock);
 	if (atomic_dec_and_test(&sig->count)) {
 		if (tsk == sig->curr_target)
@@ -816,11 +814,9 @@
 {
 	int ret = 0;
 
-	if (!irqs_disabled())
-		BUG();
+	BUG_ON(!irqs_disabled());
 #ifdef CONFIG_SMP
-	if (!spin_is_locked(&t->sighand->siglock))
-		BUG();
+	BUG_ON(!spin_is_locked(&t->sighand->siglock));
 #endif
 
 	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
@@ -1008,8 +1004,7 @@
 	int ret = 0;
 
 #ifdef CONFIG_SMP
-	if (!spin_is_locked(&p->sighand->siglock))
-		BUG();
+	BUG_ON(!spin_is_locked(&p->sighand->siglock));
 #endif
 	handle_stop_signal(sig, p);
 
@@ -1378,8 +1373,7 @@
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		if (q->info.si_code != SI_TIMER)
-			BUG();
+		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		goto out;
 	} 
@@ -1425,8 +1419,7 @@
 		 * the overrun count.  Other uses should not try to
 		 * send the signal multiple times.
 		 */
-		if (q->info.si_code != SI_TIMER)
-			BUG();
+		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		goto out;
 	} 
@@ -1474,8 +1467,7 @@
 	do {
 		wake_up_interruptible_sync(&tsk->wait_chldexit);
 		tsk = next_thread(tsk);
-		if (tsk->signal != parent->signal)
-			BUG();
+		BUG_ON(tsk->signal != parent->signal);
 	} while (tsk != parent);
 }
 
@@ -1490,8 +1482,7 @@
 	int why, status;
 	struct sighand_struct *psig;
 
-	if (sig == -1)
-		BUG();
+	BUG_ON(sig == -1);
 
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/softirq.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/softirq.c	2004-08-28 16:18:12.000000000 +0200
@@ -240,8 +240,7 @@
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
+				BUG_ON(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state));
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
@@ -273,8 +272,7 @@
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
+				BUG_ON(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state));
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
--- linux-2.6.9-rc1-mm1-full-3.4/kernel/timer.c.old	2004-08-28 16:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/kernel/timer.c	2004-08-28 16:18:42.000000000 +0200
@@ -1374,8 +1374,7 @@
 		spin_lock(&new_base->lock);
 	}
 
-	if (old_base->running_timer)
-		BUG();
+	BUG_ON(old_base->running_timer);
 	for (i = 0; i < TVR_SIZE; i++)
 		if (!migrate_timer_list(new_base, old_base->tv1.vec + i))
 			goto unlock_again;

