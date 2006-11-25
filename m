Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966872AbWKYRqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966872AbWKYRqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966879AbWKYRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 12:46:30 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:1190 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S966872AbWKYRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 12:46:30 -0500
Date: Sat, 25 Nov 2006 12:40:56 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] X86: add sysctl for kstack_depth_to_print
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Message-ID: <200611251243_MC3-1-D2DA-5EB0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysctl for kstack_depth_to_print. This lets users change
the amount of raw stack data printed in dump_stack() without
having to reboot.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---
Tested on i386; compiled on x86_64.

 Documentation/sysctl/kernel.txt |    8 ++++++++
 arch/i386/kernel/traps.c        |    2 +-
 arch/x86_64/kernel/traps.c      |    2 +-
 include/asm-x86_64/stacktrace.h |    2 ++
 include/linux/sysctl.h          |    1 +
 kernel/sysctl.c                 |    9 +++++++++
 6 files changed, 22 insertions(+), 2 deletions(-)

--- 2.6.19-rc6-32smp.orig/kernel/sysctl.c
+++ 2.6.19-rc6-32smp/kernel/sysctl.c
@@ -54,6 +54,7 @@ extern int proc_nr_files(ctl_table *tabl
 
 #ifdef CONFIG_X86
 #include <asm/nmi.h>
+#include <asm/stacktrace.h>
 #endif
 
 #if defined(CONFIG_SYSCTL)
@@ -707,6 +708,14 @@ static ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_KSTACK_DEPTH_TO_PRINT,
+		.procname	= "kstack_depth_to_print",
+		.data		= &kstack_depth_to_print,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #if defined(CONFIG_MMU)
 	{
--- 2.6.19-rc6-32smp.orig/arch/i386/kernel/traps.c
+++ 2.6.19-rc6-32smp/arch/i386/kernel/traps.c
@@ -94,7 +94,7 @@ asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
-static int kstack_depth_to_print = 24;
+int kstack_depth_to_print = 24;
 #ifdef CONFIG_STACK_UNWIND
 static int call_trace = 1;
 #else
--- 2.6.19-rc6-32smp.orig/include/asm-x86_64/stacktrace.h
+++ 2.6.19-rc6-32smp/include/asm-x86_64/stacktrace.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_STACKTRACE_H
 #define _ASM_STACKTRACE_H 1
 
+extern int kstack_depth_to_print;
+
 /* Generic stack tracer with callbacks */
 
 struct stacktrace_ops {
--- 2.6.19-rc6-32smp.orig/include/linux/sysctl.h
+++ 2.6.19-rc6-32smp/include/linux/sysctl.h
@@ -160,6 +160,7 @@ enum
 	KERN_MAX_LOCK_DEPTH=74,
 	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
+	KERN_KSTACK_DEPTH_TO_PRINT=78, /* int: # words to print in show_stack() */
 };
 
 
--- 2.6.19-rc6-32smp.orig/Documentation/sysctl/kernel.txt
+++ 2.6.19-rc6-32smp/Documentation/sysctl/kernel.txt
@@ -27,6 +27,7 @@ show up in /proc/sys/kernel:
 - hotplug
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
+- kstack_depth_to_print       [ X86 only ]
 - l2cr                        [ PPC only ]
 - modprobe                    ==> Documentation/kmod.txt
 - msgmax
@@ -170,6 +171,13 @@ This flag controls the L2 cache of G3 pr
 
 ==============================================================
 
+kstack_depth_to_print: (X86 only)
+
+Controls the number of words to print when dumping the raw
+kernel stack.
+
+==============================================================
+
 osrelease, ostype & version:
 
 # cat osrelease
--- 2.6.19-rc6-32smp.orig/arch/x86_64/kernel/traps.c
+++ 2.6.19-rc6-32smp/arch/x86_64/kernel/traps.c
@@ -108,7 +108,7 @@ static inline void preempt_conditional_c
 	preempt_enable_no_resched();
 }
 
-static int kstack_depth_to_print = 12;
+int kstack_depth_to_print = 12;
 #ifdef CONFIG_STACK_UNWIND
 static int call_trace = 1;
 #else
-- 
Chuck
"Even supernovas have their duller moments."
