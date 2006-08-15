Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWHOKxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWHOKxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWHOKxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:53:11 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:2185 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030205AbWHOKxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:53:10 -0400
Message-Id: <44E1C3C2.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 15 Aug 2006 12:53:22 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <patches@x86-64.org>
Subject: Re: backtracer stuck in apic_timer_interrupt
References: <200608040920.42076.ak@suse.de>
In-Reply-To: <200608040920.42076.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Do you know why the backtracer gets stuck in apic_timer_interrupt?
>Somehow it didn't manage to go over to the process stack, but it
should
>have.

No, I don't, I just verified that the annotations are correct (in that
unwinds can pass this function). If you see this again, I'd need the
raw
stack dump to compare. However, while doing this I also saw a case
where it wouldn't properly unwind (but one level up from
apic_timer_interrupt), however in this case it was expectedly getting
stuck because the interrupt had hit a procedure that already entered
it
epilogue, which gcc fails to annotate.

Further, while doing this, I found myself ending up with an unwound
stack trace followed by a legacy one, but without any separator
indicating so. Therefore I looked at the fallback logic you recently
changed and found that it was still not quite right. Hence I created
below patch (for both i386 and x86-64).

Jan

The unwinder fallback logic still had potential for falling through to
the legacy stack trace code without printing an indication (at once
serving as a separator) of this.

Further, the stack pointer retrieval for the fallback should be as
restrictive as possible (in order to avoid having the legacy stack
tracer try to access invalid memory). The patch tightens that, but
this could certainly be further improved.

Also making the call_trace command line option now conditional upon
CONFIG_STACK_UNWIND (as it's meaningless otherwise).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.18-rc4/arch/i386/kernel/traps.c	2006-08-15
11:29:35.000000000 +0200
+++
2.6.18-rc4-unwind-x86-fallback/arch/i386/kernel/traps.c	2006-08-15
10:52:43.000000000 +0200
@@ -92,7 +92,11 @@ asmlinkage void spurious_interrupt_bug(v
 asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
+#ifdef CONFIG_STACK_UNWIND
 static int call_trace = 1;
+#else
+#define call_trace (-1)
+#endif
 ATOMIC_NOTIFIER_HEAD(i386die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
@@ -187,22 +191,21 @@ static void show_trace_log_lvl(struct ta
 			if (unwind_init_blocked(&info, task) == 0)
 				unw_ret = show_trace_unwind(&info,
log_lvl);
 		}
-		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
-#ifdef CONFIG_STACK_UNWIND
-			print_symbol("DWARF2 unwinder stuck at %s\n",
-				     UNW_PC(&info));
-			if (call_trace == 1) {
-				printk("Leftover inexact
backtrace:\n");
-				if (UNW_SP(&info))
+		if (unw_ret > 0) {
+			if (call_trace == 1 &&
!arch_unw_user_mode(&info)) {
+				print_symbol("DWARF2 unwinder stuck at
%s\n",
+					     UNW_PC(&info));
+				if (UNW_SP(&info) >= PAGE_OFFSET) {
+					printk("Leftover inexact
backtrace:\n");
 					stack = (void *)UNW_SP(&info);
-			} else if (call_trace > 1)
+				} else
+					printk("Full inexact backtrace
again:\n");
+			} else if (call_trace >= 1)
 				return;
 			else
 				printk("Full inexact backtrace
again:\n");
-#else
+		} else
 			printk("Inexact backtrace:\n");
-#endif
-		}
 	}
 
 	if (task == current) {
@@ -1241,6 +1244,7 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
+#ifdef CONFIG_STACK_UNWIND
 static int __init call_trace_setup(char *s)
 {
 	if (strcmp(s, "old") == 0)
@@ -1254,3 +1258,4 @@ static int __init call_trace_setup(char 
 	return 1;
 }
 __setup("call_trace=", call_trace_setup);
+#endif
--- linux-2.6.18-rc4/arch/x86_64/kernel/traps.c	2006-08-15
11:29:41.000000000 +0200
+++
2.6.18-rc4-unwind-x86-fallback/arch/x86_64/kernel/traps.c	2006-08-15
10:49:34.000000000 +0200
@@ -107,7 +107,11 @@ static inline void preempt_conditional_c
 }
 
 static int kstack_depth_to_print = 12;
+#ifdef CONFIG_STACK_UNWIND
 static int call_trace = 1;
+#else
+#define call_trace (-1)
+#endif
 
 #ifdef CONFIG_KALLSYMS
 # include <linux/kallsyms.h>
@@ -274,21 +278,21 @@ void show_trace(struct task_struct *tsk,
 			if (unwind_init_blocked(&info, tsk) == 0)
 				unw_ret = show_trace_unwind(&info,
NULL);
 		}
-		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
-#ifdef CONFIG_STACK_UNWIND
-			unsigned long rip = info.regs.rip;
-			print_symbol("DWARF2 unwinder stuck at %s\n",
rip);
-			if (call_trace == 1) {
-				printk("Leftover inexact
backtrace:\n");
-				stack = (unsigned long *)info.regs.rsp;
-			} else if (call_trace > 1)
+		if (unw_ret > 0) {
+			if (call_trace == 1 &&
!arch_unw_user_mode(&info)) {
+				print_symbol("DWARF2 unwinder stuck at
%s\n",
+					     UNW_PC(&info));
+				if ((long)UNW_SP(&info) < 0) {
+					printk("Leftover inexact
backtrace:\n");
+					stack = (unsigned long
*)UNW_SP(&info);
+				} else
+					printk("Full inexact backtrace
again:\n");
+			} else if (call_trace >= 1)
 				return;
 			else
 				printk("Full inexact backtrace
again:\n");
-#else
+		} else
 			printk("Inexact backtrace:\n");
-#endif
-		}
 	}
 
 	/*
@@ -1120,6 +1124,7 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
+#ifdef CONFIG_STACK_UNWIND
 static int __init call_trace_setup(char *s)
 {
 	if (strcmp(s, "old") == 0)
@@ -1133,3 +1138,4 @@ static int __init call_trace_setup(char 
 	return 1;
 }
 __setup("call_trace=", call_trace_setup);
+#endif
--- linux-2.6.18-rc4/include/asm-i386/unwind.h	2006-08-15
11:30:00.000000000 +0200
+++
2.6.18-rc4-unwind-x86-fallback/include/asm-i386/unwind.h	2006-08-15
09:36:19.000000000 +0200
@@ -87,6 +87,7 @@ static inline int arch_unw_user_mode(con
 #else
 
 #define UNW_PC(frame) ((void)(frame), 0)
+#define UNW_SP(frame) ((void)(frame), 0)
 
 static inline int arch_unw_user_mode(const void *info)
 {
--- linux-2.6.18-rc4/include/asm-x86_64/unwind.h	2006-08-15
11:30:02.000000000 +0200
+++
2.6.18-rc4-unwind-x86-fallback/include/asm-x86_64/unwind.h	2006-08-15
09:36:19.000000000 +0200
@@ -95,6 +95,7 @@ static inline int arch_unw_user_mode(con
 #else
 
 #define UNW_PC(frame) ((void)(frame), 0)
+#define UNW_SP(frame) ((void)(frame), 0)
 
 static inline int arch_unw_user_mode(const void *info)
 {

