Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWFBLwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWFBLwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWFBLwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:52:25 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20521
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751034AbWFBLwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:52:24 -0400
Message-Id: <448042C1.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 02 Jun 2006 13:53:05 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andreas Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] fall back to old-style call trace if no unwinding
	is possible
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If no unwinding is possible at all for a certain exception instance,
fall back to the old style call trace instead of not showing any trace
at all.

Also, allow setting the stack trace mode at the command line.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: 2.6.17-rc5-unwind-generic/arch/i386/kernel/traps.c
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/arch/i386/kernel/traps.c	2006-06-02 13:21:20.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/arch/i386/kernel/traps.c	2006-06-02 13:32:29.000000000 +0200
@@ -93,6 +93,7 @@ asmlinkage void spurious_interrupt_bug(v
 asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
+static int call_trace = 1;
 ATOMIC_NOTIFIER_HEAD(i386die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
@@ -165,40 +166,47 @@ static inline unsigned long print_contex
 	return ebp;
 }
 
-static asmlinkage void show_trace_unwind(struct unwind_frame_info *info, void *log_lvl)
+static asmlinkage int show_trace_unwind(struct unwind_frame_info *info, void *log_lvl)
 {
+	int n = 0;
 	int printed = 0; /* nr of entries already printed on current line */
 
 	while (unwind(info) == 0 && UNW_PC(info)) {
+		++n;
 		printed = print_addr_and_symbol(UNW_PC(info), log_lvl, printed);
 		if (arch_unw_user_mode(info))
 			break;
 	}
 	if (printed)
 		printk("\n");
+	return n;
 }
 
 static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			       unsigned long *stack, char *log_lvl)
 {
 	unsigned long ebp;
-	struct unwind_frame_info info;
 
 	if (!task)
 		task = current;
 
-	if (regs) {
-		if (unwind_init_frame_info(&info, task, regs) == 0) {
-			show_trace_unwind(&info, log_lvl);
-			return;
+	if (call_trace >= 0) {
+		int unw_ret = 0;
+		struct unwind_frame_info info;
+
+		if (regs) {
+			if (unwind_init_frame_info(&info, task, regs) == 0)
+				unw_ret = show_trace_unwind(&info, log_lvl);
+		} else if (task == current)
+			unw_ret = unwind_init_running(&info, show_trace_unwind, log_lvl);
+		else {
+			if (unwind_init_blocked(&info, task) == 0)
+				unw_ret = show_trace_unwind(&info, log_lvl);
 		}
-	} else if (task == current) {
-		if (unwind_init_running(&info, show_trace_unwind, log_lvl) == 0)
-			return;
-	} else {
-		if (unwind_init_blocked(&info, task) == 0) {
-			show_trace_unwind(&info, log_lvl);
-			return;
+		if (unw_ret > 0) {
+			if (call_trace > 0)
+				return;
+			printk("%sLegacy call trace:\n", log_lvl);
 		}
 	}
 
@@ -1238,3 +1246,15 @@ static int __init kstack_setup(char *s)
 	return 1;
 }
 __setup("kstack=", kstack_setup);
+
+static int __init call_trace_setup(char *s)
+{
+	if (strcmp(s, "old") == 0)
+		call_trace = -1;
+	else if (strcmp(s, "both") == 0)
+		call_trace = 0;
+	else if (strcmp(s, "new") == 0)
+		call_trace = 1;
+	return 1;
+}
+__setup("call_trace=", call_trace_setup);
Index: 2.6.17-rc5-unwind-generic/arch/x86_64/kernel/traps.c
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/arch/x86_64/kernel/traps.c	2006-05-30 09:19:02.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/arch/x86_64/kernel/traps.c	2006-06-02 13:36:12.000000000 +0200
@@ -109,6 +109,7 @@ static inline void preempt_conditional_c
 }
 
 static int kstack_depth_to_print = 10;
+static int call_trace = 1;
 
 #ifdef CONFIG_KALLSYMS
 #include <linux/kallsyms.h> 
@@ -192,11 +193,12 @@ static unsigned long *in_exception_stack
 	return NULL;
 }
 
-static void show_trace_unwind(struct unwind_frame_info *info, void *context)
+static int show_trace_unwind(struct unwind_frame_info *info, void *context)
 {
-	int i = 11;
+	int i = 11, n = 0;
 
 	while (unwind(info) == 0 && UNW_PC(info)) {
+		++n;
 		if (i > 50) {
 			printk("\n       ");
 			i = 7;
@@ -207,6 +209,7 @@ static void show_trace_unwind(struct unw
 			break;
 	}
 	printk("\n");
+	return n;
 }
 
 /*
@@ -220,27 +223,32 @@ void show_trace(struct task_struct *tsk,
 {
 	const unsigned cpu = safe_smp_processor_id();
 	unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
-	int i;
+	int i = 11;
 	unsigned used = 0;
-	struct unwind_frame_info info;
 
 	printk("\nCall Trace:");
 
 	if (!tsk)
 		tsk = current;
 
-	if (regs) {
-		if (unwind_init_frame_info(&info, tsk, regs) == 0) {
-			show_trace_unwind(&info, NULL);
-			return;
-		}
-	} else if (tsk == current) {
-		if (unwind_init_running(&info, show_trace_unwind, NULL) == 0)
-			return;
-	} else {
-		if (unwind_init_blocked(&info, tsk) == 0) {
-			show_trace_unwind(&info, NULL);
-			return;
+	if (call_trace >= 0) {
+		int unw_ret = 0;
+		struct unwind_frame_info info;
+
+		if (regs) {
+			if (unwind_init_frame_info(&info, tsk, regs) == 0)
+				unw_ret = show_trace_unwind(&info, NULL);
+		} else if (tsk == current)
+			unw_ret = unwind_init_running(&info, show_trace_unwind, NULL);
+		else {
+			if (unwind_init_blocked(&info, tsk) == 0)
+				unw_ret = show_trace_unwind(&info, NULL);
+		}
+		if (unw_ret > 0) {
+			if (call_trace > 0)
+				return;
+			printk("Legacy call trace:");
+			i = 18;
 		}
 	}
 
@@ -266,7 +274,7 @@ void show_trace(struct task_struct *tsk,
 		} \
 	} while (0)
 
-	for(i = 11; ; ) {
+	for(; ; ) {
 		const char *id;
 		unsigned long *estack_end;
 		estack_end = in_exception_stack(cpu, (unsigned long)stack,
@@ -1054,3 +1062,14 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
+static int __init call_trace_setup(char *s)
+{
+	if (strcmp(s, "old") == 0)
+		call_trace = -1;
+	else if (strcmp(s, "both") == 0)
+		call_trace = 0;
+	else if (strcmp(s, "new") == 0)
+		call_trace = 1;
+	return 1;
+}
+__setup("call_trace=", call_trace_setup);
Index: 2.6.17-rc5-unwind-generic/include/asm-i386/unwind.h
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/include/asm-i386/unwind.h	2006-06-02 13:21:20.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/include/asm-i386/unwind.h	2006-06-02 13:23:30.000000000 +0200
@@ -66,10 +66,10 @@ static inline void arch_unw_init_blocked
 	info->regs.xes = __USER_DS;
 }
 
-extern asmlinkage void arch_unwind_init_running(struct unwind_frame_info *,
-                                                asmlinkage void (*callback)(struct unwind_frame_info *,
-                                                                            void *arg),
-                                                void *arg);
+extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,
+                                               asmlinkage int (*callback)(struct unwind_frame_info *,
+                                                                          void *arg),
+                                               void *arg);
 
 static inline int arch_unw_user_mode(const struct unwind_frame_info *info)
 {
Index: 2.6.17-rc5-unwind-generic/include/asm-x86_64/unwind.h
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/include/asm-x86_64/unwind.h	2006-05-30 09:18:44.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/include/asm-x86_64/unwind.h	2006-06-02 13:36:12.000000000 +0200
@@ -75,10 +75,10 @@ static inline void arch_unw_init_blocked
 	info->regs.ss = __KERNEL_DS;
 }
 
-extern void arch_unwind_init_running(struct unwind_frame_info *,
-                                     void (*callback)(struct unwind_frame_info *,
-                                                      void *arg),
-                                     void *arg);
+extern int arch_unwind_init_running(struct unwind_frame_info *,
+                                    int (*callback)(struct unwind_frame_info *,
+                                                    void *arg),
+                                    void *arg);
 
 static inline int arch_unw_user_mode(const struct unwind_frame_info *info)
 {
Index: 2.6.17-rc5-unwind-generic/include/linux/unwind.h
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/include/linux/unwind.h	2006-06-02 13:21:20.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/include/linux/unwind.h	2006-06-02 13:23:30.000000000 +0200
@@ -49,8 +49,8 @@ extern int unwind_init_blocked(struct un
  * Prepare to unwind the currently running thread.
  */
 extern int unwind_init_running(struct unwind_frame_info *,
-                               asmlinkage void (*callback)(struct unwind_frame_info *,
-                                                           void *arg),
+                               asmlinkage int (*callback)(struct unwind_frame_info *,
+                                                          void *arg),
                                void *arg);
 
 /*
@@ -97,8 +97,8 @@ static inline int unwind_init_blocked(st
 }
 
 static inline int unwind_init_running(struct unwind_frame_info *info,
-                                      asmlinkage void (*cb)(struct unwind_frame_info *,
-                                                            void *arg),
+                                      asmlinkage int (*cb)(struct unwind_frame_info *,
+                                                           void *arg),
                                       void *arg)
 {
 	return -ENOSYS;
Index: 2.6.17-rc5-unwind-generic/kernel/unwind.c
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/kernel/unwind.c	2006-06-02 13:21:20.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/kernel/unwind.c	2006-06-02 13:23:30.000000000 +0200
@@ -885,14 +885,13 @@ EXPORT_SYMBOL(unwind_init_blocked);
  * Prepare to unwind the currently running thread.
  */
 int unwind_init_running(struct unwind_frame_info *info,
-                        asmlinkage void (*callback)(struct unwind_frame_info *,
-                                                    void *arg),
+                        asmlinkage int (*callback)(struct unwind_frame_info *,
+                                                   void *arg),
                         void *arg)
 {
 	info->task = current;
-	arch_unwind_init_running(info, callback, arg);
 
-	return 0;
+	return arch_unwind_init_running(info, callback, arg);
 }
 EXPORT_SYMBOL(unwind_init_running);
 


