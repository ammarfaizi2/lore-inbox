Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUKIKyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUKIKyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUKIKu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:50:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27798 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261479AbUKIKi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:38:27 -0500
Subject: [PATCH 3/11] oprofile: i386 support for stack trace sampling
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-FYDFjSiKBRb0XvMsHIBP"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996693.1985.785.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:38:13 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FYDFjSiKBRb0XvMsHIBP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-FYDFjSiKBRb0XvMsHIBP
Content-Disposition: attachment; filename=oprofile-callgraph-i386
Content-Type: text/plain; name=oprofile-callgraph-i386; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile i386 arch updates, including some internal
API changes and support for stack trace sampling.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/i386/oprofile/Makefile          |    2 
 arch/i386/oprofile/backtrace.c       |  118 +++++++++++++++++++++++++++++++++++
 arch/i386/oprofile/init.c            |   12 ++-
 arch/i386/oprofile/nmi_int.c         |   47 ++++++-------
 arch/i386/oprofile/nmi_timer_int.c   |   16 +---
 arch/i386/oprofile/op_model_athlon.c |    9 --
 arch/i386/oprofile/op_model_p4.c     |    9 --
 arch/i386/oprofile/op_model_ppro.c   |    9 --
 arch/i386/oprofile/op_x86_model.h    |    5 -
 9 files changed, 164 insertions(+), 63 deletions(-)

Index: linux/arch/i386/oprofile/op_model_ppro.c
===================================================================
--- linux.orig/arch/i386/oprofile/op_model_ppro.c	2004-10-19 07:54:38.%N +1000
+++ linux/arch/i386/oprofile/op_model_ppro.c	2004-11-06 01:18:32.%N +1100
@@ -85,19 +85,16 @@ static void ppro_setup_ctrs(struct op_ms
 }
 
  
-static int ppro_check_ctrs(unsigned int const cpu, 
-			    struct op_msrs const * const msrs,
-			    struct pt_regs * const regs)
+static int ppro_check_ctrs(struct pt_regs * const regs,
+			   struct op_msrs const * const msrs)
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = profile_pc(regs);
-	int is_kernel = !user_mode(regs);
  
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
-			oprofile_add_sample(eip, is_kernel, i, cpu);
+			oprofile_add_sample(regs, i);
 			CTR_WRITE(reset_value[i], msrs, i);
 		}
 	}
Index: linux/arch/i386/oprofile/op_model_p4.c
===================================================================
--- linux.orig/arch/i386/oprofile/op_model_p4.c	2004-10-19 07:53:11.%N +1000
+++ linux/arch/i386/oprofile/op_model_p4.c	2004-11-06 01:18:32.%N +1100
@@ -619,14 +619,11 @@ static void p4_setup_ctrs(struct op_msrs
 }
 
 
-static int p4_check_ctrs(unsigned int const cpu, 
-			  struct op_msrs const * const msrs,
-			  struct pt_regs * const regs)
+static int p4_check_ctrs(struct pt_regs * const regs,
+			 struct op_msrs const * const msrs)
 {
 	unsigned long ctr, low, high, stag, real;
 	int i;
-	unsigned long eip = profile_pc(regs);
-	int is_kernel = !user_mode(regs);
 
 	stag = get_stagger();
 
@@ -657,7 +654,7 @@ static int p4_check_ctrs(unsigned int co
 		CCCR_READ(low, high, real);
  		CTR_READ(ctr, high, real);
 		if (CCCR_OVF_P(low) || CTR_OVERFLOW_P(ctr)) {
-			oprofile_add_sample(eip, is_kernel, i, cpu);
+			oprofile_add_sample(regs, i);
  			CTR_WRITE(reset_value[i], real);
 			CCCR_CLEAR_OVF(low);
 			CCCR_WRITE(low, high, real);
Index: linux/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux.orig/arch/i386/oprofile/nmi_int.c	2004-11-06 01:11:55.%N +1100
+++ linux/arch/i386/oprofile/nmi_int.c	2004-11-06 01:19:22.%N +1100
@@ -84,7 +84,7 @@ static void __exit exit_driverfs(void)
 
 static int nmi_callback(struct pt_regs * regs, int cpu)
 {
-	return model->check_ctrs(cpu, &cpu_msrs[cpu], regs);
+	return model->check_ctrs(regs, &cpu_msrs[cpu]);
 }
  
  
@@ -300,16 +300,7 @@ static int nmi_create_files(struct super
 }
  
  
-struct oprofile_operations nmi_ops = {
-	.create_files 	= nmi_create_files,
-	.setup 		= nmi_setup,
-	.shutdown	= nmi_shutdown,
-	.start		= nmi_start,
-	.stop		= nmi_stop
-};
- 
-
-static int __init p4_init(void)
+static int __init p4_init(char ** cpu_type)
 {
 	__u8 cpu_model = boot_cpu_data.x86_model;
 
@@ -317,18 +308,18 @@ static int __init p4_init(void)
 		return 0;
 
 #ifndef CONFIG_SMP
-	nmi_ops.cpu_type = "i386/p4";
+	*cpu_type = "i386/p4";
 	model = &op_p4_spec;
 	return 1;
 #else
 	switch (smp_num_siblings) {
 		case 1:
-			nmi_ops.cpu_type = "i386/p4";
+			*cpu_type = "i386/p4";
 			model = &op_p4_spec;
 			return 1;
 
 		case 2:
-			nmi_ops.cpu_type = "i386/p4-ht";
+			*cpu_type = "i386/p4-ht";
 			model = &op_p4_ht2_spec;
 			return 1;
 	}
@@ -340,7 +331,7 @@ static int __init p4_init(void)
 }
 
 
-static int __init ppro_init(void)
+static int __init ppro_init(char ** cpu_type)
 {
 	__u8 cpu_model = boot_cpu_data.x86_model;
 
@@ -348,13 +339,13 @@ static int __init ppro_init(void)
 		return 0;
 
 	if (cpu_model == 9) {
-		nmi_ops.cpu_type = "i386/p6_mobile";
+		*cpu_type = "i386/p6_mobile";
 	} else if (cpu_model > 5) {
-		nmi_ops.cpu_type = "i386/piii";
+		*cpu_type = "i386/piii";
 	} else if (cpu_model > 2) {
-		nmi_ops.cpu_type = "i386/pii";
+		*cpu_type = "i386/pii";
 	} else {
-		nmi_ops.cpu_type = "i386/ppro";
+		*cpu_type = "i386/ppro";
 	}
 
 	model = &op_ppro_spec;
@@ -364,10 +355,11 @@ static int __init ppro_init(void)
 /* in order to get driverfs right */
 static int using_nmi;
 
-int __init nmi_init(struct oprofile_operations ** ops)
+int __init nmi_init(struct oprofile_operations * ops)
 {
 	__u8 vendor = boot_cpu_data.x86_vendor;
 	__u8 family = boot_cpu_data.x86;
+	char *cpu_type;
  
 	if (!cpu_has_apic)
 		return -ENODEV;
@@ -381,13 +373,13 @@ int __init nmi_init(struct oprofile_oper
 				return -ENODEV;
 			case 6:
 				model = &op_athlon_spec;
-				nmi_ops.cpu_type = "i386/athlon";
+				cpu_type = "i386/athlon";
 				break;
 			case 0xf:
 				model = &op_athlon_spec;
 				/* Actually it could be i386/hammer too, but give
 				   user space an consistent name. */
-				nmi_ops.cpu_type = "x86-64/hammer";
+				cpu_type = "x86-64/hammer";
 				break;
 			}
 			break;
@@ -396,13 +388,13 @@ int __init nmi_init(struct oprofile_oper
 			switch (family) {
 				/* Pentium IV */
 				case 0xf:
-					if (!p4_init())
+					if (!p4_init(&cpu_type))
 						return -ENODEV;
 					break;
 
 				/* A P6-class processor */
 				case 6:
-					if (!ppro_init())
+					if (!ppro_init(&cpu_type))
 						return -ENODEV;
 					break;
 
@@ -417,7 +409,12 @@ int __init nmi_init(struct oprofile_oper
 
 	init_driverfs();
 	using_nmi = 1;
-	*ops = &nmi_ops;
+	ops->create_files = nmi_create_files;
+	ops->setup = nmi_setup;
+	ops->shutdown = nmi_shutdown;
+	ops->start = nmi_start;
+	ops->stop = nmi_stop;
+	ops->cpu_type = cpu_type;
 	printk(KERN_INFO "oprofile: using NMI interrupt.\n");
 	return 0;
 }
Index: linux/arch/i386/oprofile/nmi_timer_int.c
===================================================================
--- linux.orig/arch/i386/oprofile/nmi_timer_int.c	2004-10-19 07:53:45.%N +1000
+++ linux/arch/i386/oprofile/nmi_timer_int.c	2004-11-06 01:18:32.%N +1100
@@ -20,9 +20,7 @@
  
 static int nmi_timer_callback(struct pt_regs * regs, int cpu)
 {
-	unsigned long eip = instruction_pointer(regs);
- 
-	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
+	oprofile_add_sample(regs, 0);
 	return 1;
 }
 
@@ -42,20 +40,16 @@ static void timer_stop(void)
 }
 
 
-static struct oprofile_operations nmi_timer_ops = {
-	.start	= timer_start,
-	.stop	= timer_stop,
-	.cpu_type = "timer"
-};
-
-int __init nmi_timer_init(struct oprofile_operations ** ops)
+int __init nmi_timer_init(struct oprofile_operations * ops)
 {
 	extern int nmi_active;
 
 	if (nmi_active <= 0)
 		return -ENODEV;
 
-	*ops = &nmi_timer_ops;
+	ops->start = timer_start;
+	ops->stop = timer_stop;
+	ops->cpu_type = "timer";
 	printk(KERN_INFO "oprofile: using NMI timer interrupt.\n");
 	return 0;
 }
Index: linux/arch/i386/oprofile/init.c
===================================================================
--- linux.orig/arch/i386/oprofile/init.c	2004-10-19 07:54:32.%N +1000
+++ linux/arch/i386/oprofile/init.c	2004-11-06 01:18:32.%N +1100
@@ -15,22 +15,24 @@
  * with the NMI mode driver.
  */
  
-extern int nmi_init(struct oprofile_operations ** ops);
-extern int nmi_timer_init(struct oprofile_operations **ops);
+extern int nmi_init(struct oprofile_operations * ops);
+extern int nmi_timer_init(struct oprofile_operations * ops);
 extern void nmi_exit(void);
+extern void x86_backtrace(struct pt_regs * const regs, unsigned int depth);
 
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
+
+void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
 	int ret = -ENODEV;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	ret = nmi_init(ops);
 #endif
-
 #ifdef CONFIG_X86_IO_APIC
 	if (ret < 0)
 		ret = nmi_timer_init(ops);
 #endif
-	return ret;
+	ops->backtrace = x86_backtrace;
 }
 
 
Index: linux/arch/i386/oprofile/op_x86_model.h
===================================================================
--- linux.orig/arch/i386/oprofile/op_x86_model.h	2004-10-19 07:53:43.%N +1000
+++ linux/arch/i386/oprofile/op_x86_model.h	2004-11-06 01:18:32.%N +1100
@@ -36,9 +36,8 @@ struct op_x86_model_spec {
 	unsigned int const num_controls;
 	void (*fill_in_addresses)(struct op_msrs * const msrs);
 	void (*setup_ctrs)(struct op_msrs const * const msrs);
-	int (*check_ctrs)(unsigned int const cpu, 
-		struct op_msrs const * const msrs,
-		struct pt_regs * const regs);
+	int (*check_ctrs)(struct pt_regs * const regs,
+		struct op_msrs const * const msrs);
 	void (*start)(struct op_msrs const * const msrs);
 	void (*stop)(struct op_msrs const * const msrs);
 };
Index: linux/arch/i386/oprofile/Makefile
===================================================================
--- linux.orig/arch/i386/oprofile/Makefile	2004-10-19 07:55:06.%N +1000
+++ linux/arch/i386/oprofile/Makefile	2004-11-06 01:18:32.%N +1100
@@ -6,7 +6,7 @@ DRIVER_OBJS = $(addprefix ../../../drive
 		oprofilefs.o oprofile_stats.o  \
 		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) init.o
+oprofile-y				:= $(DRIVER_OBJS) init.o backtrace.o
 oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
 					   op_model_ppro.o op_model_p4.o
 oprofile-$(CONFIG_X86_IO_APIC)		+= nmi_timer_int.o
Index: linux/arch/i386/oprofile/op_model_athlon.c
===================================================================
--- linux.orig/arch/i386/oprofile/op_model_athlon.c	2004-10-19 07:55:36.%N +1000
+++ linux/arch/i386/oprofile/op_model_athlon.c	2004-11-06 01:18:32.%N +1100
@@ -90,19 +90,16 @@ static void athlon_setup_ctrs(struct op_
 }
 
  
-static int athlon_check_ctrs(unsigned int const cpu, 
-			      struct op_msrs const * const msrs, 
-			      struct pt_regs * const regs)
+static int athlon_check_ctrs(struct pt_regs * const regs,
+			     struct op_msrs const * const msrs)
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = profile_pc(regs);
-	int is_kernel = !user_mode(regs);
 
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
-			oprofile_add_sample(eip, is_kernel, i, cpu);
+			oprofile_add_sample(regs, i);
 			CTR_WRITE(reset_value[i], msrs, i);
 		}
 	}
Index: linux/arch/i386/oprofile/backtrace.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/i386/oprofile/backtrace.c	2004-11-06 01:18:32.%N +1100
@@ -0,0 +1,118 @@
+/**
+ * @file backtrace.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ * @author David Smith
+ */
+
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+ 
+struct frame_head {
+	struct frame_head * ebp;
+	unsigned long ret;
+} __attribute__((packed));
+
+
+static struct frame_head *
+dump_backtrace(struct frame_head * head)
+{
+	oprofile_add_trace(head->ret);
+
+	/* frame pointers should strictly progress back up the stack
+	 * (towards higher addresses) */
+	if (head >= head->ebp)
+		return 0;
+
+	return head->ebp;
+}
+
+
+#ifdef CONFIG_X86_4G
+/* With a 4G kernel/user split, user pages are not directly
+ * accessible from the kernel, so don't try
+ */
+static int pages_present(struct frame_head * head)
+{
+	return 0;
+}
+#else
+/* check that the page(s) containing the frame head are present */
+static int pages_present(struct frame_head * head)
+{
+	struct mm_struct * mm = current->mm;
+
+	/* FIXME: only necessary once per page */
+	if (!check_user_page_readable(mm, (unsigned long)head))
+		return 0;
+
+	return check_user_page_readable(mm, (unsigned long)(head + 1));
+}
+#endif /* CONFIG_X86_4G */
+
+
+/*
+ * |             | /\ Higher addresses
+ * |             |
+ * --------------- stack base (address of current_thread_info)
+ * | thread info |
+ * .             .
+ * |    stack    |
+ * --------------- saved regs->ebp value if valid (frame_head address)
+ * .             .
+ * --------------- struct pt_regs stored on stack (struct pt_regs *)
+ * |             |
+ * .             .
+ * |             |
+ * --------------- %esp
+ * |             |
+ * |             | \/ Lower addresses
+ *
+ * Thus, &pt_regs <-> stack base restricts the valid(ish) ebp values
+ */
+#ifdef CONFIG_FRAME_POINTER
+static int valid_kernel_stack(struct frame_head * head, struct pt_regs * regs)
+{
+	unsigned long headaddr = (unsigned long)head;
+	unsigned long stack = (unsigned long)regs;
+	unsigned long stack_base = (stack & ~(THREAD_SIZE - 1)) + THREAD_SIZE;
+
+	return headaddr > stack && headaddr < stack_base;
+}
+#else
+/* without fp, it's just junk */
+static int valid_kernel_stack(struct frame_head * head, struct pt_regs * regs)
+{
+	return 0;
+}
+#endif
+
+
+void
+x86_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	struct frame_head * head = (struct frame_head *)regs->ebp;
+
+	if (!user_mode(regs)) {
+		while (depth-- && valid_kernel_stack(head, regs))
+			head = dump_backtrace(head);
+		return;
+	}
+
+#ifdef CONFIG_SMP
+	if (!spin_trylock(&current->mm->page_table_lock))
+		return;
+#endif
+
+	while (depth-- && head && pages_present(head))
+		head = dump_backtrace(head);
+
+#ifdef CONFIG_SMP
+	spin_unlock(&current->mm->page_table_lock);
+#endif
+}

--=-FYDFjSiKBRb0XvMsHIBP--

