Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263395AbVGARQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbVGARQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbVGARQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:16:15 -0400
Received: from graphe.net ([209.204.138.32]:7053 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263395AbVGARPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:15:02 -0400
Date: Fri, 1 Jul 2005 10:14:50 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [SUSPEND 2/2] Replace PF_FROZEN with TASK_FROZEN
In-Reply-To: <Pine.LNX.4.62.0507011004100.17205@graphe.net>
Message-ID: <Pine.LNX.4.62.0507011009500.17205@graphe.net>
References: <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net>
 <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org>
 <Pine.LNX.4.62.0506262249080.4374@graphe.net> <20050627141320.GA4945@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.62.0506270804450.17400@graphe.net> <42C0EBAB.8070709@sw.ru>
 <20050628124750.GB11129@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0507011004100.17205@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the PF_FROZEN flag and introduces TASK_FROZEN. This allows a simplification
of the locking for software suspend and helps clean up race conditions.

Also remove many inline functions to follow the coding style in other locations.

Beware: compiles fine not tested since I need to move on to other issues 
now. But this is my best stab at how this could be fixed in the time that 
I could spend with the issue.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.12/include/linux/sched.h
===================================================================
--- linux-2.6.12.orig/include/linux/sched.h	2005-07-01 04:50:46.000000000 +0000
+++ linux-2.6.12/include/linux/sched.h	2005-07-01 08:58:49.000000000 +0000
@@ -110,8 +110,9 @@ extern unsigned long nr_iowait(void);
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_STOPPED		4
 #define TASK_TRACED		8
-#define EXIT_ZOMBIE		16
-#define EXIT_DEAD		32
+#define TASK_FROZEN		16
+#define EXIT_ZOMBIE		32
+#define EXIT_DEAD		64
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
@@ -808,7 +809,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
-#define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
@@ -1270,14 +1270,6 @@ extern void normalize_rt_tasks(void);
 
 #ifdef CONFIG_PM
 /*
- * Check if a process has been frozen
- */
-static inline int frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
-
-/*
  * Check if there is a request to freeze a process
  */
 static inline int freezing(struct task_struct *p)
@@ -1285,36 +1277,6 @@ static inline int freezing(struct task_s
 	return test_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
-/*
- * Request that a process be frozen
- */
-static inline void freeze(struct task_struct *p)
-{
-	set_ti_thread_flag(p->thread_info, TIF_FREEZE);
-}
-
-/*
- * Wake up a frozen process
- */
-static inline int thaw_process(struct task_struct *p)
-{
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags |= PF_FROZEN;
-	clear_ti_thread_flag(p->thread_info, TIF_FREEZE);
-}
-
 extern void refrigerator(void);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
@@ -1328,11 +1290,7 @@ static inline int try_to_freeze(void)
 		return 0;
 }
 #else
-static inline int frozen(struct task_struct *p) { return 0; }
 static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
 
 static inline void refrigerator(void) {}
 static inline int freeze_processes(void) { BUG(); return 0; }
Index: linux-2.6.12/kernel/power/process.c
===================================================================
--- linux-2.6.12.orig/kernel/power/process.c	2005-07-01 04:50:46.000000000 +0000
+++ linux-2.6.12/kernel/power/process.c	2005-07-01 08:58:49.000000000 +0000
@@ -37,20 +37,21 @@ void refrigerator(void)
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	long save;
-	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
+
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 
-	frozen_process(current);
+	save = current->state;
+	current->state = TASK_FROZEN;
+	while (test_thread_flag(TIF_FREEZE))
+		schedule();
+	current->state = save;
+
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* We sent fake signal, clean it up */
 	spin_unlock_irq(&current->sighand->siglock);
 
-	while (frozen(current))
-		schedule();
 	pr_debug("%s left refrigerator\n", current->comm);
-	current->state = save;
 }
 
 /* 0 = success, else # of processes that we failed to stop */
@@ -67,14 +68,12 @@ int freeze_processes(void)
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			if (!freezeable(p))
-				continue;
-			if ((frozen(p)) ||
-			    (p->state == TASK_TRACED) ||
-			    (p->state == TASK_STOPPED))
+
+			if (!freezeable(p) ||
+			    (p->state & (TASK_FROZEN | TASK_TRACED | TASK_STOPPED)))
 				continue;
 
-			freeze(p);
+			set_tsk_thread_flag(p, TIF_FREEZE);
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
@@ -85,6 +84,7 @@ int freeze_processes(void)
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			thaw_processes();
 			return todo;
 		}
 	} while(todo);
@@ -103,8 +103,8 @@ void thaw_processes(void)
 	do_each_thread(g, p) {
 		if (!freezeable(p))
 			continue;
-		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		if (test_and_clear_tsk_thread_flag(p, TIF_FREEZE))
+			wake_up_state(p, TASK_FROZEN);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
Index: linux-2.6.12/fs/proc/array.c
===================================================================
--- linux-2.6.12.orig/fs/proc/array.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/fs/proc/array.c	2005-07-01 09:07:05.000000000 +0000
@@ -133,8 +133,9 @@ static const char *task_state_array[] = 
 	"D (disk sleep)",	/*  2 */
 	"T (stopped)",		/*  4 */
 	"T (tracing stop)",	/*  8 */
-	"Z (zombie)",		/* 16 */
-	"X (dead)"		/* 32 */
+	"F (frozen)",		/* 16 */
+	"Z (zombie)",		/* 32 */
+	"X (dead)"		/* 64 */
 };
 
 static inline const char * get_task_state(struct task_struct *tsk)
@@ -143,7 +144,8 @@ static inline const char * get_task_stat
 					    TASK_INTERRUPTIBLE |
 					    TASK_UNINTERRUPTIBLE |
 					    TASK_STOPPED |
-					    TASK_TRACED)) |
+					    TASK_TRACED |
+					    TASK_FROZEN)) |
 			(tsk->exit_state & (EXIT_ZOMBIE |
 					    EXIT_DEAD));
 	const char **p = &task_state_array[0];

