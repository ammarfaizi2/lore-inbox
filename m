Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVAMWEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVAMWEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVAMWCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:02:55 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:45061 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261764AbVAMV6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:30 -0500
Subject: [patch 09/11] uml: add stack content to dumps
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:01:08 +0100
Message-Id: <20050113210108.751921FEF9@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Copy some code from i386 to print the stack content. Rough form yet, should
work although.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/kernel/sysrq.c |   40 +++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 5 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-add-stack-content-to-dumps arch/um/kernel/sysrq.c
--- linux-2.6.10-rc/arch/um/kernel/sysrq.c~uml-add-stack-content-to-dumps	2004-11-30 18:32:12.000000000 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/sysrq.c	2004-11-30 20:27:06.540447816 +0100
@@ -15,11 +15,13 @@
 void show_trace(unsigned long * stack)
 {
 	/* XXX: Copy the CONFIG_FRAME_POINTER stack-walking backtrace from
-	 * arch/i386/kernel/traps.c. */
+	 * arch/i386/kernel/traps.c, and then move this to sys-i386/sysrq.c.*/
         unsigned long addr;
 
-        if (!stack)
+        if (!stack) {
                 stack = (unsigned long*) &stack;
+		WARN_ON(1);
+	}
 
         printk("Call Trace: \n");
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
@@ -34,7 +36,8 @@ void show_trace(unsigned long * stack)
 }
 
 /*
- * The architecture-independent dump_stack generator
+ * stack dumps generator - this is used by arch-independent code.
+ * And this is identical to i386 currently.
  */
 void dump_stack(void)
 {
@@ -44,7 +47,34 @@ void dump_stack(void)
 }
 EXPORT_SYMBOL(dump_stack);
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+/*Stolen from arch/i386/kernel/traps.c */
+static int kstack_depth_to_print = 24;
+
+/* This recently started being used in arch-independent code too, as in
+ * kernel/sched.c.*/
+void show_stack(struct task_struct *task, unsigned long *esp)
 {
-	show_trace(sp);
+	unsigned long *stack;
+	int i;
+
+	if (esp == NULL) {
+		if (task != current) {
+			esp = (unsigned long *) KSTK_ESP(task);
+			/* Which one? No actual difference - just coding style.*/
+			//esp = (unsigned long *) PT_REGS_IP(&task->thread.regs);
+		} else {
+			esp = (unsigned long *) &esp;
+		}
+	}
+
+	stack = esp;
+	for(i = 0; i < kstack_depth_to_print; i++) {
+		if (kstack_end(stack))
+			break;
+		if (i && ((i % 8) == 0))
+			printk("\n       ");
+		printk("%08lx ", *stack++);
+	}
+
+	show_trace(esp);
 }
_
