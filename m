Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVG2UiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVG2UiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVG2Uf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:35:56 -0400
Received: from graphe.net ([209.204.138.32]:13024 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262792AbVG2Uer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:34:47 -0400
Date: Fri, 29 Jul 2005 13:34:45 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 3/4] Task notifier against mm: Make suspend code SMP safe
 using todo list
In-Reply-To: <Pine.LNX.4.62.0507291332100.5304@graphe.net>
Message-ID: <Pine.LNX.4.62.0507291333410.5304@graphe.net>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
 <Pine.LNX.4.62.0507291332100.5304@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the suspend code use the todo list in the task_struct

This patch makes the suspend code SMP clean by removing PF_FREEZE and PF_FROZEN. Instead
it relies on the new notification handler in the task_struct, a completion handler and an
atomic counter for the number of processes frozen. All the logic is local to the
suspend code and no longer requires changes to other kernel components.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3-mm3/include/linux/sched.h
===================================================================
--- linux-2.6.13-rc3-mm3.orig/include/linux/sched.h	2005-07-29 12:37:44.000000000 -0700
+++ linux-2.6.13-rc3-mm3/include/linux/sched.h	2005-07-29 12:37:59.000000000 -0700
@@ -890,9 +890,7 @@
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
-#define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
Index: linux-2.6.13-rc3-mm3/kernel/power/process.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/kernel/power/process.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/kernel/power/process.c	2005-07-29 12:37:59.000000000 -0700
@@ -18,6 +18,8 @@
  */
 #define TIMEOUT	(6 * HZ)
 
+DECLARE_COMPLETION(thaw);
+static atomic_t nr_frozen;
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -31,26 +33,36 @@
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(void)
+static int freeze_process(struct notifier_block *nl, unsigned long x, void *v)
 {
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	long save;
 	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
-	pr_debug("%s entered refrigerator\n", current->comm);
+	pr_debug("%s frozen\n", current->comm);
 	printk("=");
 
-	frozen_process(current);
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* We sent fake signal, clean it up */
+	atomic_inc(&nr_frozen);
 	spin_unlock_irq(&current->sighand->siglock);
 
-	while (frozen(current))
-		schedule();
-	pr_debug("%s left refrigerator\n", current->comm);
+	wait_for_completion(&thaw);
+	atomic_dec(&nr_frozen);
+	notifier_chain_unregister(&current->todo, nl);
+	kfree(nl);
+	pr_debug("%s thawed\n", current->comm);
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
@@ -61,19 +73,32 @@
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
-				continue;
 
-			freeze(p);
+			/* If there is nothing on the todo list then get the process to freeze itself */
+			if (!todo_list_active()) {
+				n = kmalloc(sizeof(struct notifier_block), GFP_ATOMIC);
+				if (n) {
+					n->notifier_call = freeze_process;
+					n->priority = 0;
+					notifier_chain_register(&g->todo, n);
+				}
+		 	}
+			/* Make the process work on its todo list */
 			spin_lock_irqsave(&p->sighand->siglock, flags);
+			recalc_sigpending();
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			todo++;
@@ -83,31 +108,13 @@
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			thaw_processes();
 			return todo;
 		}
-	} while(todo);
+	} while(todo < atomic_read(&nr_frozen));
 
 	printk( "|\n" );
 	BUG_ON(in_atomic());
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
Index: linux-2.6.13-rc3-mm3/Documentation/power/kernel_threads.txt
===================================================================
--- linux-2.6.13-rc3-mm3.orig/Documentation/power/kernel_threads.txt	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/Documentation/power/kernel_threads.txt	2005-07-29 12:37:59.000000000 -0700
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
Index: linux-2.6.13-rc3-mm3/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.13-rc3-mm3.orig/Documentation/power/swsusp.txt	2005-07-29 12:32:11.000000000 -0700
+++ linux-2.6.13-rc3-mm3/Documentation/power/swsusp.txt	2005-07-29 12:37:59.000000000 -0700
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
