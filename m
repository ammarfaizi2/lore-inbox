Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272520AbTGZOgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272517AbTGZOgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:36:21 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:39980 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272518AbTGZOcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:43 -0400
Date: Sat, 26 Jul 2003 16:51:52 +0200
Message-Id: <200307261451.h6QEpqK8002400@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k show_stack() portability and cleanup patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: show_stack() portability and cleanup patch:
  - Add a task pointer argument to show_stack() and pass NULL as the first
    argument where needed
  - Remove show_trace_task()

--- linux-2.6.x/arch/m68k/kernel/traps.c	Tue Mar 25 10:06:08 2003
+++ linux-m68k-2.6.x/arch/m68k/kernel/traps.c	Thu Jun 26 11:22:53 2003
@@ -852,11 +852,6 @@
 	printk("\n");
 }
 
-void show_trace_task(struct task_struct *tsk)
-{
-	show_trace((unsigned long *)tsk->thread.esp0);
-}
-
 void show_registers(struct pt_regs *regs)
 {
 	struct frame *fp = (struct frame *)regs;
@@ -915,7 +910,7 @@
 	default:
 	    printk("\n");
 	}
-	show_stack((unsigned long *)addr);
+	show_stack(NULL, (unsigned long *)addr);
 
 	printk("Code: ");
 	for (i = 0; i < 10; i++)
@@ -923,13 +918,17 @@
 	printk ("\n");
 }
 
-extern void show_stack(unsigned long *stack)
+extern void show_stack(struct task_struct *task, unsigned long *stack)
 {
 	unsigned long *endstack;
 	int i;
 
-	if (!stack)
-		stack = (unsigned long *)&stack;
+	if (!stack) {
+		if (task)
+			stack = (unsigned long *)task->thread.esp0;
+		else
+			stack = (unsigned long *)&stack;
+	}
 	endstack = (unsigned long *)(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
 
 	printk("Stack from %08lx:", (unsigned long)stack);
@@ -1124,7 +1123,7 @@
 
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
 		current->comm, current->pid, PAGE_SIZE+(unsigned long)current);
-	show_stack((unsigned long *)fp);
+	show_stack(NULL, (unsigned long *)fp);
 	do_exit(SIGSEGV);
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
