Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131799AbQKJV1Q>; Fri, 10 Nov 2000 16:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131842AbQKJV1G>; Fri, 10 Nov 2000 16:27:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29671 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131799AbQKJV0f>;
	Fri, 10 Nov 2000 16:26:35 -0500
Date: Fri, 10 Nov 2000 16:26:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] show_task() and thread_saved_pc() fix for x86
Message-ID: <Pine.GSO.4.21.0011101618030.17943-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* thread_saved_pc() on x86 returns (thread->esp)[3]. Bogus, since the
third word from the stack top has absolutely nothing to return address of
any kind. Correct value: (thread->esp)[0][1] - ebp is on top of the stack
and the rest is obvious. Current code gives completely bogus addresses -
try to say Alt-SysRq-T and watch the show.

	* kernel/sched::show_state() used the wrong check for process being
on some CPU - p==current is nice for UP, but on SMP it's obviously wrong.
Moroever, nothing prevents schedule() another CPU while we are going through
the process state. Fix: show_state() grabs runqueue_lock, show_task() checks
p->has_cpu instead of p == current.

	Please, apply.
							Cheers,
								Al

diff -urN rc11-2/include/asm-i386/processor.h rc11-2-show_task/include/asm-i386/processor.h
--- rc11-2/include/asm-i386/processor.h	Fri Nov 10 09:14:04 2000
+++ rc11-2-show_task/include/asm-i386/processor.h	Fri Nov 10 16:08:15 2000
@@ -412,7 +412,7 @@
  */
 extern inline unsigned long thread_saved_pc(struct thread_struct *t)
 {
-	return ((unsigned long *)t->esp)[3];
+	return ((unsigned long **)t->esp)[0][1];
 }
 
 unsigned long get_wchan(struct task_struct *p);
diff -urN rc11-2/kernel/sched.c rc11-2-show_task/kernel/sched.c
--- rc11-2/kernel/sched.c	Fri Nov 10 09:18:43 2000
+++ rc11-2-show_task/kernel/sched.c	Fri Nov 10 16:11:39 2000
@@ -1121,12 +1121,12 @@
 	else
 		printk(" ");
 #if (BITS_PER_LONG == 32)
-	if (p == current)
+	if (p->has_cpu)
 		printk(" current  ");
 	else
 		printk(" %08lX ", thread_saved_pc(&p->thread));
 #else
-	if (p == current)
+	if (p->has_cpu)
 		printk("   current task   ");
 	else
 		printk(" %016lx ", thread_saved_pc(&p->thread));
@@ -1186,6 +1186,7 @@
 void show_state(void)
 {
 	struct task_struct *p;
+	unsigned long flags;
 
 #if (BITS_PER_LONG == 32)
 	printk("\n"
@@ -1196,10 +1197,12 @@
 	       "                                 free                        sibling\n");
 	printk("  task                 PC        stack   pid father child younger older\n");
 #endif
+	spin_lock_irqsave(&runqueue_lock, flags);
 	read_lock(&tasklist_lock);
 	for_each_task(p)
 		show_task(p);
 	read_unlock(&tasklist_lock);
+	spin_unlock_irqrestore(&runqueue_lock, flags);
 }
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
