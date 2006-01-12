Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWALBsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWALBsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWALBsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:48:07 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:2229 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964967AbWALBsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:48:05 -0500
Date: Wed, 11 Jan 2006 20:41:39 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.15-current] i386: fix stack dump loglevel
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200601112044_MC3-1-B5B1-3B1E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent changes caused part of stack traces from SysRq-T to print at
KERN_EMERG loglevel.  Also, parts of stack dump during oops were
failing to print at that level when they should.


Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>
---

 arch/i386/kernel/traps.c |   57 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 18 deletions(-)

--- 2.6.15a.orig/arch/i386/kernel/traps.c
+++ 2.6.15a/arch/i386/kernel/traps.c
@@ -112,33 +112,38 @@ static inline int valid_stack_ptr(struct
 		p < (void *)tinfo + THREAD_SIZE - 3;
 }
 
+static inline void print_addr_and_symbol(unsigned long addr, char *log_lvl)
+{
+		printk(log_lvl);
+		printk(" [<%08lx>] ", addr);
+		print_symbol("%s", addr);
+		printk("\n");
+}
+
 static inline unsigned long print_context_stack(struct thread_info *tinfo,
-				unsigned long *stack, unsigned long ebp)
+				unsigned long *stack, unsigned long ebp,
+				char *log_lvl)
 {
 	unsigned long addr;
 
 #ifdef	CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
 		addr = *(unsigned long *)(ebp + 4);
-		printk(KERN_EMERG " [<%08lx>] ", addr);
-		print_symbol("%s", addr);
-		printk("\n");
+		print_addr_and_symbol(addr, log_lvl);
 		ebp = *(unsigned long *)ebp;
 	}
 #else
 	while (valid_stack_ptr(tinfo, stack)) {
 		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			printk(KERN_EMERG " [<%08lx>]", addr);
-			print_symbol(" %s", addr);
-			printk("\n");
-		}
+		if (__kernel_text_address(addr))
+			print_addr_and_symbol(addr, log_lvl);
 	}
 #endif
 	return ebp;
 }
 
-void show_trace(struct task_struct *task, unsigned long * stack)
+static void show_trace_log_lvl(struct task_struct *task,
+			       unsigned long *stack, char *log_lvl)
 {
 	unsigned long ebp;
 
@@ -157,7 +162,7 @@ void show_trace(struct task_struct *task
 		struct thread_info *context;
 		context = (struct thread_info *)
 			((unsigned long)stack & (~(THREAD_SIZE - 1)));
-		ebp = print_context_stack(context, stack, ebp);
+		ebp = print_context_stack(context, stack, ebp, log_lvl);
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
@@ -165,7 +170,13 @@ void show_trace(struct task_struct *task
 	}
 }
 
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_trace(struct task_struct *task, unsigned long * stack)
+{
+	show_trace_log_lvl(task, stack, "");
+}
+
+static void show_stack_log_lvl(struct task_struct *task, unsigned long *esp,
+			       char *log_lvl)
 {
 	unsigned long *stack;
 	int i;
@@ -178,16 +189,26 @@ void show_stack(struct task_struct *task
 	}
 
 	stack = esp;
-	printk(KERN_EMERG);
+	printk(log_lvl);
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
 			break;
-		if (i && ((i % 8) == 0))
-			printk("\n" KERN_EMERG "       ");
+		if (i && ((i % 8) == 0)) {
+			printk("\n");
+			printk(log_lvl);
+			printk("       ");
+		}
 		printk("%08lx ", *stack++);
 	}
-	printk("\n" KERN_EMERG "Call Trace:\n");
-	show_trace(task, esp);
+	printk("\n");
+	printk(log_lvl);
+	printk("Call Trace:\n");
+	show_trace_log_lvl(task, esp, log_lvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_log_lvl(task, esp, "");
 }
 
 /*
@@ -238,7 +259,7 @@ void show_registers(struct pt_regs *regs
 		u8 __user *eip;
 
 		printk("\n" KERN_EMERG "Stack: ");
-		show_stack(NULL, (unsigned long*)esp);
+		show_stack_log_lvl(NULL, (unsigned long *)esp, KERN_EMERG);
 
 		printk(KERN_EMERG "Code: ");
 
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
