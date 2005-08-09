Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVHIEVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVHIEVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVHIEVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:21:55 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:18378 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932442AbVHIEVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:21:54 -0400
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Lameter <christoph@lameter.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1123559495.4370.87.camel@localhost>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
	 <Pine.LNX.4.62.0507272018060.11863@graphe.net>
	 <20050728074116.GF6529@elf.ucw.cz>
	 <Pine.LNX.4.62.0507280804310.23907@graphe.net>
	 <20050728193433.GA1856@elf.ucw.cz>
	 <Pine.LNX.4.62.0507281251040.12675@graphe.net>
	 <Pine.LNX.4.62.0507281254380.12781@graphe.net>
	 <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz>
	 <Pine.LNX.4.62.0507281456240.14677@graphe.net>
	 <1123551167.9451.5.camel@localhost>
	 <Pine.LNX.4.62.0508081858040.32489@graphe.net>
	 <1123559495.4370.87.camel@localhost>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123561281.4370.108.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 14:21:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry everyone else for emailing you too. I'm only doing so to honour
the convention of not removing people from replies.)

Hi Christoph.

As I look at the patch in preparation for sending it, I don't think I
really changed anything significant. (I didn't address the issues I
mentioned in the previous email).

The only thing I think might be worth mentioning is that I added
freeze_processes and thaw_processes declarations to
include/linux/suspend.h. I got warnings without them there - perhaps,
though, it's just due to differences in Suspend2.

Having said this, I promised to send you my version, so I've inlined it
below. As you'll see, I'm making some changes just to minimise the
differences with swsusp.

Regards,

Nigel

 Documentation/power/kernel_threads.txt |   10 +-
 Documentation/power/swsusp.txt         |    5 -
 include/linux/sched.h                  |    1 
 kernel/power/process.c                 |  114 ++++++++++++++++++---------------
 4 files changed, 72 insertions(+), 58 deletions(-)
diff -ruNp 992-suspend_fix.patch-old/Documentation/power/kernel_threads.txt 992-suspend_fix.patch-new/Documentation/power/kernel_threads.txt
--- 992-suspend_fix.patch-old/Documentation/power/kernel_threads.txt	2005-08-08 17:23:31.000000000 +1000
+++ 992-suspend_fix.patch-new/Documentation/power/kernel_threads.txt	2005-08-09 08:11:41.000000000 +1000
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
diff -ruNp 992-suspend_fix.patch-old/Documentation/power/swsusp.txt 992-suspend_fix.patch-new/Documentation/power/swsusp.txt
--- 992-suspend_fix.patch-old/Documentation/power/swsusp.txt	2005-08-08 17:23:31.000000000 +1000
+++ 992-suspend_fix.patch-new/Documentation/power/swsusp.txt	2005-08-09 08:11:41.000000000 +1000
@@ -155,7 +155,8 @@ should be sent to the mailing list avail
 website, and not to the Linux Kernel Mailing List. We are working
 toward merging suspend2 into the mainline kernel.
 
-Q: A kernel thread must voluntarily freeze itself (call 'refrigerator').
+Q: A kernel thread must work on the todo list (call 'run_todo_list')
+to enter the refrigerator.
 I found some kernel threads that don't do it, and they don't freeze
 so the system can't sleep. Is this a known behavior?
 
@@ -164,7 +165,7 @@ place where the thread is safe to be fro
 should be held at that point and it must be safe to sleep there), and
 add:
 
-       try_to_freeze();
+       try_todo_list();
 
 If the thread is needed for writing the image to storage, you should
 instead set the PF_NOFREEZE process flag when creating the thread (and
diff -ruNp 992-suspend_fix.patch-old/include/linux/sched.h 992-suspend_fix.patch-new/include/linux/sched.h
--- 992-suspend_fix.patch-old/include/linux/sched.h	2005-08-09 11:17:49.000000000 +1000
+++ 992-suspend_fix.patch-new/include/linux/sched.h	2005-08-09 08:11:41.000000000 +1000
@@ -835,7 +835,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
diff -ruNp 992-suspend_fix.patch-old/kernel/power/process.c 992-suspend_fix.patch-new/kernel/power/process.c
--- 992-suspend_fix.patch-old/kernel/power/process.c	2005-08-09 11:17:48.000000000 +1000
+++ 992-suspend_fix.patch-new/kernel/power/process.c	2005-08-09 11:10:59.000000000 +1000
@@ -61,6 +61,11 @@ extern void suspend_relinquish_console(v
 static void freeze_lru(void);
 extern void thaw_lru(void);
 
+DECLARE_COMPLETION(kernelspace_thaw);
+DECLARE_COMPLETION(userspace_thaw);
+static atomic_t nr_userspace_frozen;
+static atomic_t nr_kernelspace_frozen;
+
 /*
  * to_be_frozen
  *
@@ -72,7 +77,7 @@ extern void thaw_lru(void);
 static int to_be_frozen(struct task_struct * p, int type_being_frozen) {
 
 	if ((p == current) ||
-	    (frozen(p)) ||
+	    (p->flags & PF_FROZEN) ||
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
@@ -86,47 +91,68 @@ static int to_be_frozen(struct task_stru
 	return 1;
 }
 
-/**
- * refrigerator - idle routine for frozen processes
- * @flag: unsigned long, non zero if signals to be flushed.
- *
- * A routine for kernel threads which should not do work during suspend
- * to enter and spin in until the process is finished.
+/*
+ * Invoked by the task todo list notifier when the task to be
+ * frozen is running.
  */
-
-void refrigerator(void)
+static int freeze_process(struct notifier_block *nl, unsigned long x, void *v)
 {
-	unsigned long flags;
+  	/* Hmm, should we be allowed to suspend when there are realtime
+  	   processes around? */
 	long save;
+
+	save = current->state;
+	current->flags |= PF_FROZEN;
+	notifier_chain_unregister(&current->todo, nl);
+	kfree(nl);
 	
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	spin_unlock_irq(&current->sighand->siglock);
 
-	if (unlikely(current->flags & PF_NOFREEZE)) {
-		current->flags &= ~PF_FREEZE;
-		return;
+	if (current->mm) {
+		atomic_inc(&nr_userspace_frozen);
+		wait_for_completion(&userspace_thaw);
+		atomic_dec(&nr_userspace_frozen);
+	} else {
+		atomic_inc(&nr_kernelspace_frozen);
+		wait_for_completion(&kernelspace_thaw);
+		atomic_dec(&nr_kernelspace_frozen);
 	}
 
-	save = current->state;
-	suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
-		"\n%s (%d) refrigerated and sigpending recalculated.",
-		current->comm, current->pid);
+	current->flags &= ~PF_FROZEN;
+	current->state = save;
 
-	frozen_process(current);
+	return 0;
+}
 
-	while (test_suspend_state(SUSPEND_FREEZER_ON) && frozen(current)) {
-		current->state = TASK_STOPPED;
-		schedule();
-		spin_lock_irqsave(&current->sighand->siglock, flags);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
-	}
+static inline void freeze(struct task_struct *p)
+{
+	unsigned long flags;
+
+	/*
+	 * We only freeze if the todo list is empty to avoid
+	 * putting multiple freeze handlers on the todo list.
+	 */
 	
-	current->state = save;
-}
+	if (!p->todo) {
+		struct notifier_block *n;
 
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
+}
 
 /*
  * num_to_be_frozen
@@ -204,6 +230,12 @@ static int freeze_threads(int type, int 
 	unsigned long start_time = jiffies;
 	int result = 0, still_to_do;
 
+	if (!atomic_read(&nr_userspace_frozen))
+		init_completion(&userspace_thaw);
+	
+	if (!atomic_read(&nr_kernelspace_frozen))
+		init_completion(&kernelspace_thaw);
+
 	suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 1,
 		"\n STARTING TO FREEZE TYPE %d THREADS.\n",
 		type);
@@ -388,7 +420,6 @@ aborting:
 
 void thaw_processes(int which_threads)
 {
-	struct task_struct *p, *g;
 	suspend_message(SUSPEND_FREEZER, SUSPEND_LOW, 1, "Thawing tasks\n");
 	
 	suspend_task = 0;
@@ -397,27 +428,10 @@ void thaw_processes(int which_threads)
 
 	clear_suspend_state(SUSPEND_DISABLE_SYNCING);
 	
-	preempt_disable();
-	
-	local_irq_disable();
+	complete_all(&kernelspace_thaw);
 
-	read_lock(&tasklist_lock);
-
-	do_each_thread(g, p) {
-		if (frozen(p)) {
-			if ((which_threads == FREEZER_KERNEL_THREADS) && p->mm)
-				continue;
-			suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
-					"Waking %5d: %s.\n", p->pid, p->comm);
-			thaw_process(p);
-		}
-	} while_each_thread(g, p);
-
-	read_unlock(&tasklist_lock);
-
-	preempt_enable();
-
-	local_irq_enable();
+	if (which_threads != FREEZER_KERNEL_THREADS)
+		complete_all(&userspace_thaw);
 
 	schedule();
 }


