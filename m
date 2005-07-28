Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVG1DbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVG1DbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVG1DbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:31:01 -0400
Received: from graphe.net ([209.204.138.32]:36800 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261275AbVG1Da5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:30:57 -0400
Date: Wed, 27 Jul 2005 20:30:49 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: akpm@osdl.org
cc: pavel@suse.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Alternative to TIF_FREEZE -> a notifier in the task_struct?
In-Reply-To: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.62.0507272018060.11863@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm. I am thinking about an alternative to PF_FREEZE and TIF_FREEZE. 
PF/TIF_FREEZE essentially makes a task call a certain function in the 
context of the task. Maybe there is a way to generalize that?

One could introducing a notifier chain (todo) in the task_struct that 
is then called in the current places where PF/TIF_FREEZE is checked?

This could be used to have a process execute any other piece that is 
required to run in the context of the thread. Maybe such a feature could 
help with PTRACE or/and get_user_pages that currently do ugly things to a 
process. It may also allow changing values that so far cannot be
changed from the outside in the task struct by running a function
in the context of the process.

The feature to execute a function via a notifier chain allows to localize
the suspend functionality in kernel/power/process.c. We may be able to 
take the definitions out of sched.h (while adding the functions to handle 
the todo list).

Here is a patch against Linus current tree that does this. Note that this 
patch is incomplete at this point and only a basis for further discussion. 
Not all software suspend checkpoints are useful for a notifier chain. We 
would need to inspect several cases where drivers/kernel threads have 
special functionality for software suspend.

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/include/linux/sched.h	2005-07-27 20:04:57.000000000 -0700
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/notifier.h>
 
 struct exec_domain;
 
@@ -720,7 +721,10 @@
 	int (*notifier)(void *priv);
 	void *notifier_data;
 	sigset_t *notifier_mask;
-	
+
+	/* todo list to be executed in the context of this thread */
+	struct notifier_block *todo;
+
 	void *security;
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
@@ -811,7 +815,6 @@
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -1273,78 +1276,46 @@
 
 #endif
 
-#ifdef CONFIG_PM
-/*
- * Check if a process has been frozen
- */
-static inline int frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
-
 /*
- * Check if there is a request to freeze a process
+ * Check if there is a todo list request
  */
-static inline int freezing(struct task_struct *p)
+static inline int todo_list_active(void)
 {
-	return p->flags & PF_FREEZE;
+	return current->todo != NULL;
 }
 
-/*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
- */
-static inline void freeze(struct task_struct *p)
+static inline void run_todo_list(void)
 {
-	p->flags |= PF_FREEZE;
+	notifier_call_chain(&current->todo, 0, current);
 }
 
-/*
- * Wake up a frozen process
- */
-static inline int thaw_process(struct task_struct *p)
+static inline int try_todo_list(void)
 {
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
+	if (todo_list_active()) {
+		run_todo_list();
 		return 1;
-	}
-	return 0;
+	} else
+		return 0;
 }
 
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
-}
+#ifdef CONFIG_PM
 
-extern void refrigerator(void);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
 
-static inline int try_to_freeze(void)
+/*
+ * Check if a process has been frozen
+ */
+static inline int frozen(struct task_struct *p)
 {
-	if (freezing(current)) {
-		refrigerator();
-		return 1;
-	} else
-		return 0;
+	return p->flags & PF_FROZEN;
 }
+
 #else
 static inline int frozen(struct task_struct *p) { return 0; }
-static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
-
-static inline void refrigerator(void) {}
 static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
 
-static inline int try_to_freeze(void) { return 0; }
-
 #endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
Index: linux-2.6/kernel/power/process.c
===================================================================
--- linux-2.6.orig/kernel/power/process.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/kernel/power/process.c	2005-07-27 20:07:54.000000000 -0700
@@ -18,6 +18,8 @@
  */
 #define TIMEOUT	(6 * HZ)
 
+DECLARE_COMPLETION(thaw);
+static atomic_t nr_frozen;
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -32,25 +34,38 @@
 }
 
 /* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(void)
+static int refrigerator(struct notifier_block *nl, unsigned long x, void *v)
 {
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	long save;
 	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 
-	frozen_process(current);
 	spin_lock_irq(&current->sighand->siglock);
+	current->flags |= PF_FROZEN;
+	notifier_chain_unregister(&current->todo, nl);
 	recalc_sigpending(); /* We sent fake signal, clean it up */
+	atomic_inc(&nr_frozen);
 	spin_unlock_irq(&current->sighand->siglock);
 
-	while (frozen(current))
-		schedule();
+	wait_for_completion(&thaw);
+	current->flags &= ~PF_FROZEN;
+	atomic_dec(&nr_frozen);
+	kfree(nl);
 	pr_debug("%s left refrigerator\n", current->comm);
 	current->state = save;
+	return 0;
+}
+
+void thaw_processes(void)
+{
+	printk( "Restarting tasks..." );
+	complete_all(&thaw);
+	while (atomic_read(&nr_frozen) > 0)
+		schedule();
+	printk( " done\n" );
 }
 
 /* 0 = success, else # of processes that we failed to stop */
@@ -61,19 +76,31 @@
 	struct task_struct *g, *p;
 	unsigned long flags;
 
+	atomic_set(&nr_frozen, 0);
+	INIT_COMPLETION(thaw);
+
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
 	do {
 		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
+			struct notifier_block *n;
+
 			if (!freezeable(p))
 				continue;
-			if (frozen(p))
+			if (p->flags & PF_FROZEN)
 				continue;
 
-			freeze(p);
+			n = kmalloc(sizeof(struct notifier_block), GFP_KERNEL);
+			n->notifier_call = refrigerator;
+			n->priority = 0;
 			spin_lock_irqsave(&p->sighand->siglock, flags);
+			if (!p->todo)
+				notifier_chain_register(&g->todo, n);
+			else
+				kfree(n);
+			recalc_sigpending();
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			todo++;
@@ -83,6 +110,7 @@
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			thaw_processes();
 			return todo;
 		}
 	} while(todo);
@@ -92,22 +120,3 @@
 	return 0;
 }
 
-void thaw_processes(void)
-{
-	struct task_struct *g, *p;
-
-	printk( "Restarting tasks..." );
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		if (!freezeable(p))
-			continue;
-		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-	} while_each_thread(g, p);
-
-	read_unlock(&tasklist_lock);
-	schedule();
-	printk( " done\n" );
-}
-
-EXPORT_SYMBOL(refrigerator);
Index: linux-2.6/kernel/signal.c
===================================================================
--- linux-2.6.orig/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/kernel/signal.c	2005-07-27 20:01:49.000000000 -0700
@@ -213,7 +213,7 @@
 fastcall void recalc_sigpending_tsk(struct task_struct *t)
 {
 	if (t->signal->group_stop_count > 0 ||
-	    (freezing(t)) ||
+	    (t->todo) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked))
 		set_tsk_thread_flag(t, TIF_SIGPENDING);
@@ -2231,7 +2231,7 @@
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
-			try_to_freeze();
+			try_todo_list();
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
Index: linux-2.6/Documentation/power/kernel_threads.txt
===================================================================
--- linux-2.6.orig/Documentation/power/kernel_threads.txt	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/Documentation/power/kernel_threads.txt	2005-07-27 19:59:59.000000000 -0700
@@ -4,15 +4,15 @@
 Freezer
 
 Upon entering a suspended state the system will freeze all
-tasks. This is done by delivering pseudosignals. This affects
-kernel threads, too. To successfully freeze a kernel thread
-the thread has to check for the pseudosignal and enter the
-refrigerator. Code to do this looks like this:
+tasks. This is done by making all processes execute a notifier.
+This affects kernel threads, too. To successfully freeze a kernel thread
+the thread has to check for the notifications and call the notifier
+chain for the process. Code to do this looks like this:
 
 	do {
 		hub_events();
 		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!signal_pending(current));
 
 from drivers/usb/core/hub.c::hub_thread()
Index: linux-2.6/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.orig/Documentation/power/swsusp.txt	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/Documentation/power/swsusp.txt	2005-07-27 19:59:59.000000000 -0700
@@ -155,7 +155,8 @@
 website, and not to the Linux Kernel Mailing List. We are working
 toward merging suspend2 into the mainline kernel.
 
-Q: A kernel thread must voluntarily freeze itself (call 'refrigerator').
+Q: A kernel thread must work on the todo list (call 'run_todo_list')
+to enter the refrigerator.
 I found some kernel threads that don't do it, and they don't freeze
 so the system can't sleep. Is this a known behavior?
 
@@ -164,7 +165,7 @@
 should be held at that point and it must be safe to sleep there), and
 add:
 
-       try_to_freeze();
+       try_todo_list();
 
 If the thread is needed for writing the image to storage, you should
 instead set the PF_NOFREEZE process flag when creating the thread (and
Index: linux-2.6/arch/frv/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/frv/kernel/signal.c	2005-07-27 19:59:59.000000000 -0700
@@ -536,7 +536,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6/arch/h8300/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/h8300/kernel/signal.c	2005-07-27 19:59:59.000000000 -0700
@@ -517,7 +517,7 @@
 	if ((regs->ccr & 0x10))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	current->thread.esp0 = (unsigned long) regs;
Index: linux-2.6/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/io_apic.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/i386/kernel/io_apic.c	2005-07-27 19:59:59.000000000 -0700
@@ -574,7 +574,7 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
-		try_to_freeze();
+		try_todo_list();
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			preempt_disable();
Index: linux-2.6/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/i386/kernel/signal.c	2005-07-27 19:59:59.000000000 -0700
@@ -608,7 +608,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6/arch/m32r/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/m32r/kernel/signal.c	2005-07-27 19:59:59.000000000 -0700
@@ -371,7 +371,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze()) 
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6/arch/ppc/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/ppc/kernel/signal.c	2005-07-27 19:59:59.000000000 -0700
@@ -705,7 +705,7 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
-	if (try_to_freeze()) {
+	if (try_todo_list()) {
 		signr = 0;
 		if (!signal_pending(current))
 			goto no_signal;
Index: linux-2.6/arch/x86_64/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/signal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/arch/x86_64/kernel/signal.c	2005-07-27 19:59:59.000000000 -0700
@@ -425,7 +425,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.orig/drivers/block/pktcdvd.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/block/pktcdvd.c	2005-07-27 19:59:59.000000000 -0700
@@ -1250,8 +1250,7 @@
 			residue = schedule_timeout(min_sleep_time);
 			VPRINTK("kcdrwd: wake up\n");
 
-			/* make swsusp happy with our thread */
-			try_to_freeze();
+			try_todo_list();
 
 			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
 				if (!pkt->sleep_time)
Index: linux-2.6/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6.orig/drivers/ieee1394/ieee1394_core.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/ieee1394/ieee1394_core.c	2005-07-27 19:59:59.000000000 -0700
@@ -1044,7 +1044,7 @@
 
 	while (1) {
 		if (down_interruptible(&khpsbpkt_sig)) {
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 			printk("khpsbpkt: received unexpected signal?!\n" );
 			break;
Index: linux-2.6/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.orig/drivers/ieee1394/nodemgr.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/ieee1394/nodemgr.c	2005-07-27 19:59:59.000000000 -0700
@@ -1510,7 +1510,7 @@
 
 		if (down_interruptible(&hi->reset_sem) ||
 		    down_interruptible(&nodemgr_serialize)) {
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 			printk("NodeMgr: received unexpected signal?!\n" );
 			break;
Index: linux-2.6/drivers/input/gameport/gameport.c
===================================================================
--- linux-2.6.orig/drivers/input/gameport/gameport.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/input/gameport/gameport.c	2005-07-27 19:59:59.000000000 -0700
@@ -435,7 +435,7 @@
 		gameport_handle_events();
 		wait_event_interruptible(gameport_wait,
 			kthread_should_stop() || !list_empty(&gameport_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
Index: linux-2.6/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/serio.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/input/serio/serio.c	2005-07-27 19:59:59.000000000 -0700
@@ -371,7 +371,7 @@
 		serio_handle_events();
 		wait_event_interruptible(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
Index: linux-2.6/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-07-27 19:59:59.000000000 -0700
@@ -394,7 +394,7 @@
 			break;
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		if (down_interruptible(&fepriv->sem))
 			break;
Index: linux-2.6/drivers/net/irda/stir4200.c
===================================================================
--- linux-2.6.orig/drivers/net/irda/stir4200.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/net/irda/stir4200.c	2005-07-27 19:59:59.000000000 -0700
@@ -763,7 +763,7 @@
 	{
 #ifdef CONFIG_PM
 		/* if suspending, then power off and wait */
-		if (unlikely(freezing(current))) {
+		if (unlikely(todo_list_active())) {
 			if (stir->receiving)
 				receive_stop(stir);
 			else
@@ -771,7 +771,7 @@
 
 			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
 
-			refrigerator();
+			run_todo_list();
 
 			if (change_speed(stir, stir->speed))
 				break;
Index: linux-2.6/drivers/pcmcia/cs.c
===================================================================
--- linux-2.6.orig/drivers/pcmcia/cs.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/pcmcia/cs.c	2005-07-27 19:59:59.000000000 -0700
@@ -683,7 +683,7 @@
 		}
 
 		schedule();
-		try_to_freeze();
+		try_todo_list();
 
 		if (!skt->thread)
 			break;
Index: linux-2.6/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/hub.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/usb/core/hub.c	2005-07-27 19:59:59.000000000 -0700
@@ -2812,7 +2812,7 @@
 		wait_event_interruptible(khubd_wait,
 				!list_empty(&hub_event_list) ||
 				kthread_should_stop());
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
 	pr_debug("%s: khubd exiting\n", usbcore_name);
Index: linux-2.6/drivers/usb/storage/usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/storage/usb.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/drivers/usb/storage/usb.c	2005-07-27 19:59:59.000000000 -0700
@@ -847,7 +847,7 @@
 		wait_event_interruptible_timeout(us->delay_wait,
 				test_bit(US_FLIDX_DISCONNECTING, &us->flags),
 				delay_use * HZ);
-		if (try_to_freeze())
+		if (try_todo_list())
 			goto retry;
 	}
 
Index: linux-2.6/fs/afs/kafsasyncd.c
===================================================================
--- linux-2.6.orig/fs/afs/kafsasyncd.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/afs/kafsasyncd.c	2005-07-27 19:59:59.000000000 -0700
@@ -116,7 +116,7 @@
 		remove_wait_queue(&kafsasyncd_sleepq, &myself);
 		set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		afs_discard_my_signals();
Index: linux-2.6/fs/afs/kafstimod.c
===================================================================
--- linux-2.6.orig/fs/afs/kafstimod.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/afs/kafstimod.c	2005-07-27 19:59:59.000000000 -0700
@@ -91,7 +91,7 @@
 			complete_and_exit(&kafstimod_dead, 0);
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		afs_discard_my_signals();
Index: linux-2.6/fs/jbd/journal.c
===================================================================
--- linux-2.6.orig/fs/jbd/journal.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/jbd/journal.c	2005-07-27 19:59:59.000000000 -0700
@@ -167,7 +167,7 @@
 	}
 
 	wake_up(&journal->j_wait_done_commit);
-	if (freezing(current)) {
+	if (todo_list_active()) {
 		/*
 		 * The simpler the better. Flushing journal isn't a
 		 * good idea, because that depends on threads that may
@@ -175,7 +175,7 @@
 		 */
 		jbd_debug(1, "Now suspending kjournald\n");
 		spin_unlock(&journal->j_state_lock);
-		refrigerator();
+		run_todo_list();
 		spin_lock(&journal->j_state_lock);
 	} else {
 		/*
Index: linux-2.6/fs/jfs/jfs_logmgr.c
===================================================================
--- linux-2.6.orig/fs/jfs/jfs_logmgr.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/jfs/jfs_logmgr.c	2005-07-27 19:59:59.000000000 -0700
@@ -2360,9 +2360,9 @@
 			lbmStartIO(bp);
 			spin_lock_irq(&log_redrive_lock);
 		}
-		if (freezing(current)) {
+		if (todo_list_active()) {
 			spin_unlock_irq(&log_redrive_lock);
-			refrigerator();
+			run_todo_list();
 		} else {
 			add_wait_queue(&jfs_IO_thread_wait, &wq);
 			set_current_state(TASK_INTERRUPTIBLE);
Index: linux-2.6/fs/lockd/clntproc.c
===================================================================
--- linux-2.6.orig/fs/lockd/clntproc.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/lockd/clntproc.c	2005-07-27 19:59:59.000000000 -0700
@@ -313,7 +313,7 @@
 	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
 	if (!signalled ()) {
 		schedule_timeout(NLMCLNT_GRACE_WAIT);
-		try_to_freeze();
+		try_todo_list();
 		if (!signalled ())
 			status = 0;
 	}
Index: linux-2.6/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/xfs/linux-2.6/xfs_buf.c	2005-07-27 19:59:59.000000000 -0700
@@ -1771,9 +1771,9 @@
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		if (unlikely(freezing(current))) {
+		if (unlikely(todo_list_active())) {
 			xfsbufd_force_sleep = 1;
-			refrigerator();
+			run_todo_list();
 		} else {
 			xfsbufd_force_sleep = 0;
 		}
Index: linux-2.6/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_super.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/fs/xfs/linux-2.6/xfs_super.c	2005-07-27 19:59:59.000000000 -0700
@@ -482,8 +482,8 @@
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		timeleft = schedule_timeout(timeleft);
-		/* swsusp */
-		try_to_freeze();
+
+		try_todo_list();
 		if (vfsp->vfs_flag & VFS_UMOUNT)
 			break;
 
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/kernel/sched.c	2005-07-27 19:59:59.000000000 -0700
@@ -4343,7 +4343,7 @@
 		struct list_head *head;
 		migration_req_t *req;
 
-		try_to_freeze();
+		try_todo_list();
 
 		spin_lock_irq(&rq->lock);
 
Index: linux-2.6/mm/pdflush.c
===================================================================
--- linux-2.6.orig/mm/pdflush.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/mm/pdflush.c	2005-07-27 19:59:59.000000000 -0700
@@ -105,7 +105,7 @@
 		spin_unlock_irq(&pdflush_lock);
 
 		schedule();
-		if (try_to_freeze()) {
+		if (try_todo_list()) {
 			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/mm/vmscan.c	2005-07-27 19:59:59.000000000 -0700
@@ -1217,7 +1217,7 @@
 	for ( ; ; ) {
 		unsigned long new_order;
 
-		try_to_freeze();
+		try_todo_list();
 
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		new_order = pgdat->kswapd_max_order;
Index: linux-2.6/net/rxrpc/krxiod.c
===================================================================
--- linux-2.6.orig/net/rxrpc/krxiod.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/net/rxrpc/krxiod.c	2005-07-27 19:59:59.000000000 -0700
@@ -138,7 +138,7 @@
 
 		_debug("### End Work");
 
-		try_to_freeze();
+		try_todo_list();
 
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
Index: linux-2.6/net/rxrpc/krxtimod.c
===================================================================
--- linux-2.6.orig/net/rxrpc/krxtimod.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/net/rxrpc/krxtimod.c	2005-07-27 19:59:59.000000000 -0700
@@ -90,7 +90,7 @@
 			complete_and_exit(&krxtimod_dead, 0);
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		rxrpc_discard_my_signals();
Index: linux-2.6/net/sunrpc/svcsock.c
===================================================================
--- linux-2.6.orig/net/sunrpc/svcsock.c	2005-07-27 19:59:28.000000000 -0700
+++ linux-2.6/net/sunrpc/svcsock.c	2005-07-27 19:59:59.000000000 -0700
@@ -1186,7 +1186,7 @@
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 
-	try_to_freeze();
+	try_todo_list();
 	if (signalled())
 		return -EINTR;
 
@@ -1227,7 +1227,7 @@
 
 		schedule_timeout(timeout);
 
-		try_to_freeze();
+		try_todo_list();
 
 		spin_lock_bh(&serv->sv_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);
Index: linux-2.6/drivers/net/8139too.c
===================================================================
--- linux-2.6.orig/drivers/net/8139too.c	2005-07-27 18:29:20.000000000 -0700
+++ linux-2.6/drivers/net/8139too.c	2005-07-27 20:11:28.000000000 -0700
@@ -1605,8 +1605,7 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
-			/* make swsusp happy with our thread */
-			try_to_freeze();
+			try_todo_list();
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
