Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWAZDxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWAZDxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWAZDth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:37 -0500
Received: from [202.53.187.9] ([202.53.187.9]:17899 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932231AbWAZDtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:12 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 05/23] [Suspend2] Make the freezer use todo lists.
Date: Thu, 26 Jan 2006 13:45:38 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034537.3178.26968.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(This is Christoph Lameter's original patch, slightly modified. I don't
remove PF_FROZEN because it will still be used by later modifications.
Christoph's original comment follows).

Make the suspend code use the todo list in the task_struct.

This patch makes the suspend code SMP clean by removing the current usage
of PF_FREEZE and PF_FROZEN. Instead it relies on the new notification
handler in the task_struct, a completion handler and an atomic counter for
the number of processes frozen.

All the logic is local to the suspend code and no longer requires changes
to other kernel components.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 Documentation/power/kernel_threads.txt |   10 +-
 Documentation/power/swsusp.txt         |    5 +
 include/linux/sched.h                  |    1 
 kernel/power/process.c                 |  134 ++++++++++++++++----------------
 4 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/Documentation/power/kernel_threads.txt b/Documentation/power/kernel_threads.txt
index fb57784..5edd749 100644
--- a/Documentation/power/kernel_threads.txt
+++ b/Documentation/power/kernel_threads.txt
@@ -4,15 +4,15 @@ KERNEL THREADS
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
diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index 08c79d4..2de0e65 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -135,7 +135,8 @@ should be sent to the mailing list avail
 website, and not to the Linux Kernel Mailing List. We are working
 toward merging suspend2 into the mainline kernel.
 
-Q: A kernel thread must voluntarily freeze itself (call 'refrigerator').
+Q: A kernel thread must work on the todo list (call 'run_todo_list')
+to enter the refrigerator.
 I found some kernel threads that don't do it, and they don't freeze
 so the system can't sleep. Is this a known behavior?
 
@@ -144,7 +145,7 @@ place where the thread is safe to be fro
 should be held at that point and it must be safe to sleep there), and
 add:
 
-       try_to_freeze();
+       try_todo_list();
 
 If the thread is needed for writing the image to storage, you should
 instead set the PF_NOFREEZE process flag when creating the thread (and
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7d566dd..991c5e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -924,7 +924,6 @@ static inline void put_task_struct(struc
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 28de118..a788186 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -18,6 +18,8 @@
  */
 #define TIMEOUT	(6 * HZ)
 
+DECLARE_COMPLETION(thaw);
+static atomic_t nr_frozen;
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -31,27 +33,68 @@ static inline int freezeable(struct task
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(void)
+/*
+ * Invoked by the task todo list notifier when the task to be
+ * frozen is running.
+ */
+static int freeze_process(struct notifier_block *nl, unsigned long x, void *v)
 {
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	long save;
 	save = current->state;
-	pr_debug("%s entered refrigerator\n", current->comm);
+	pr_debug("%s frozen\n", current->comm);
+	current->flags |= PF_FROZEN;
+	notifier_chain_unregister(&current->todo, nl);
+	kfree(nl);
 	printk("=");
 
-	frozen_process(current);
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* We sent fake signal, clean it up */
+	atomic_inc(&nr_frozen);
 	spin_unlock_irq(&current->sighand->siglock);
 
-	while (frozen(current)) {
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule();
-	}
-	pr_debug("%s left refrigerator\n", current->comm);
+	wait_for_completion(&thaw);
+	current->flags &= ~PF_FROZEN;
+	atomic_dec(&nr_frozen);
+	pr_debug("%s thawed\n", current->comm);
 	current->state = save;
+	return 0;
+}
+
+void thaw_processes(void)
+{
+	printk("Restarting tasks..");
+	complete_all(&thaw);
+	while (atomic_read(&nr_frozen) > 0)
+		schedule();
+	printk("done\n");
+}
+
+static inline void freeze(struct task_struct *p)
+{
+	unsigned long flags;
+
+	/*
+	 * We only freeze if the todo list is empty to avoid
+	 * putting multiple freeze handlers on the todo list.
+	 */
+	if (!p->todo) {
+		struct notifier_block *n;
+
+		n = kmalloc(sizeof(struct notifier_block),
+					GFP_ATOMIC);
+		if (n) {
+			n->notifier_call = freeze_process;
+			n->priority = 0;
+			notifier_chain_register(&p->todo, n);
+		}
+ 	}
+	/* Make the process work on its todo list */
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	recalc_sigpending();
+	signal_wake_up(p, 0);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 }
 
 /* 0 = success, else # of processes that we failed to stop */
@@ -60,75 +103,36 @@ int freeze_processes(void)
 	int todo;
 	unsigned long start_time;
 	struct task_struct *g, *p;
-	unsigned long flags;
 
-	printk( "Stopping tasks: " );
+	atomic_set(&nr_frozen, 0);
+	INIT_COMPLETION(thaw);
+
+	printk("Stopping tasks: ");
 	start_time = jiffies;
 	do {
 		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
-			if (!freezeable(p))
-				continue;
-			if (frozen(p))
-				continue;
-
-			freeze(p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
+			if (freezeable(p)) {
+				if (!(p->flags & PF_FROZEN))
+					freeze(p);
+				todo++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
-			break;
+			printk("\n");
+			printk(KERN_ERR " stopping tasks failed"
+					"(%d tasks remaining)\n",
+					todo - atomic_read(&nr_frozen));
+			thaw_processes();
+			return todo;
 		}
-	} while(todo);
+	} while (atomic_read(&nr_frozen) < todo);
 
-	/* This does not unfreeze processes that are already frozen
-	 * (we have slightly ugly calling convention in that respect,
-	 * and caller must call thaw_processes() if something fails),
-	 * but it cleans up leftover PF_FREEZE requests.
-	 */
-	if (todo) {
-		read_lock(&tasklist_lock);
-		do_each_thread(g, p)
-			if (freezing(p)) {
-				pr_debug("  clean up: %s\n", p->comm);
-				p->flags &= ~PF_FREEZE;
-				spin_lock_irqsave(&p->sighand->siglock, flags);
-				recalc_sigpending_tsk(p);
-				spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			}
-		while_each_thread(g, p);
-		read_unlock(&tasklist_lock);
-		return todo;
-	}
-
-	printk( "|\n" );
+	printk("|\n");
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

--
Nigel Cunningham		nigel at suspend2 dot net
