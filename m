Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbUKDCD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUKDCD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUKDCCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:02:53 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:1940
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262054AbUKDBzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:45 -0500
Subject: [patch 12/20] uml:use kallsyms when dumping stack
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:42 +0100
Message-Id: <20041103231742.8D7B855C7F@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes UML use print_symbol() when dumping the stack. It is not yet
complete (the i386 version uses the frame pointers to walk the stack, for
instance), but should be at least enough.

Also, it uses bust_spinlock() when dumping errors to help them reach the
console. This appears not to be enough - however I analyzed the UML console
code, and it seems that UML console don't get flushed *at all* when exiting.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/sysrq.c   |   13 ++++++-------
 vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c |    6 +++---
 2 files changed, 9 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-use-kallsyms arch/um/kernel/sysrq.c
--- vanilla-linux-2.6.9/arch/um/kernel/sysrq.c~uml-use-kallsyms	2004-11-03 23:45:00.242401880 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/sysrq.c	2004-11-03 23:45:00.246401272 +0100
@@ -14,23 +14,23 @@
 
 void show_trace(unsigned long * stack)
 {
-        int i;
+	/* XXX: Copy the CONFIG_FRAME_POINTER stack-walking backtrace from
+	 * arch/i386/kernel/traps.c. */
         unsigned long addr;
 
         if (!stack)
                 stack = (unsigned long*) &stack;
 
-        printk("Call Trace:\n");
-        i = 1;
+        printk("Call Trace: \n");
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
                 addr = *stack++;
 		if (__kernel_text_address(addr)) {
-			printk("[<%08lx>] ", addr);
-			print_symbol("%s", addr);
+			printk(" [<%08lx>]", addr);
+			print_symbol(" %s", addr);
 			printk("\n");
-			i++;
                 }
         }
+        printk("\n");
 }
 
 /*
@@ -48,4 +48,3 @@ void show_stack(struct task_struct *task
 {
 	show_trace(sp);
 }
-
diff -puN arch/um/kernel/um_arch.c~uml-use-kallsyms arch/um/kernel/um_arch.c
--- vanilla-linux-2.6.9/arch/um/kernel/um_arch.c~uml-use-kallsyms	2004-11-03 23:45:00.243401728 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c	2004-11-03 23:45:00.246401272 +0100
@@ -405,9 +405,9 @@ extern int uml_exitcode;
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
-#ifdef CONFIG_MAGIC_SYSRQ
-	handle_sysrq('p', &current->thread.regs, NULL);
-#endif
+	bust_spinlocks(1);
+	show_regs(&(current->thread.regs));
+	bust_spinlocks(0);
 	uml_exitcode = 1;
 	machine_halt();
 	return(0);
_
