Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267712AbUHUTxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbUHUTxF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUHUTxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:53:05 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:62223 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S267725AbUHUTwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:52:07 -0400
Date: Sat, 21 Aug 2004 20:52:06 +0100
From: John Levon <levon@movementarian.org>
To: oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] OProfile ia64 performance counter support
Message-ID: <20040821195206.GA10240@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BybuI-000DkU-QJ*fbgxTQRDB06*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides support for IA64 hardware performance counters via
the perfmon interface. Please consider applying.

thanks
john


Index: linux-cvs/arch/ia64/oprofile/Kconfig
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/ia64/oprofile/Kconfig,v
retrieving revision 1.2
diff -u -a -p -r1.2 Kconfig
--- linux-cvs/arch/ia64/oprofile/Kconfig	9 Sep 2003 16:07:11 -0000	1.2
+++ linux-cvs/arch/ia64/oprofile/Kconfig	21 Aug 2004 20:42:56 -0000
@@ -16,6 +16,10 @@ config OPROFILE
 	  whole system, include the kernel, kernel modules, libraries,
 	  and applications.
 
+	  Due to firmware bugs, you may need to use the "nohalt" boot
+	  option if you're using OProfile with the hardware performance
+	  counters.
+
 	  If unsure, say N.
 
 endmenu
Index: linux-cvs/arch/ia64/oprofile/Makefile
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/ia64/oprofile/Makefile,v
retrieving revision 1.2
diff -u -a -p -r1.2 Makefile
--- linux-cvs/arch/ia64/oprofile/Makefile	9 Sep 2003 16:07:11 -0000	1.2
+++ linux-cvs/arch/ia64/oprofile/Makefile	21 Aug 2004 20:37:27 -0000
@@ -7,3 +7,4 @@ DRIVER_OBJS := $(addprefix ../../../driv
 		timer_int.o )
 
 oprofile-y := $(DRIVER_OBJS) init.o
+oprofile-$(CONFIG_PERFMON) += perfmon.o
Index: linux-cvs/arch/ia64/oprofile/init.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/ia64/oprofile/init.c,v
retrieving revision 1.2
diff -u -a -p -r1.2 init.c
--- linux-cvs/arch/ia64/oprofile/init.c	9 Sep 2003 16:07:11 -0000	1.2
+++ linux-cvs/arch/ia64/oprofile/init.c	21 Aug 2004 20:37:27 -0000
@@ -12,14 +12,21 @@
 #include <linux/init.h>
 #include <linux/errno.h>
  
-extern void timer_init(struct oprofile_operations ** ops);
+extern int perfmon_init(struct oprofile_operations ** ops);
+extern void perfmon_exit(void);
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
+#ifdef CONFIG_PERFMON
+	return perfmon_init(ops);
+#endif
 	return -ENODEV;
 }
 
 
 void oprofile_arch_exit(void)
 {
+#ifdef CONFIG_PERFMON
+	perfmon_exit();
+#endif
 }
Index: linux-cvs/arch/ia64/oprofile/perfmon.c
===================================================================
RCS file: linux-cvs/arch/ia64/oprofile/perfmon.c
diff -N linux-cvs/arch/ia64/oprofile/perfmon.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-cvs/arch/ia64/oprofile/perfmon.c	21 Aug 2004 20:37:27 -0000
@@ -0,0 +1,105 @@
+/**
+ * @file perfmon.c
+ *
+ * @remark Copyright 2003 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <asm/perfmon.h>
+#include <asm/ptrace.h>
+#include <asm/errno.h>
+
+static int allow_ints;
+
+static int
+perfmon_handler(struct task_struct *task, void *buf, pfm_ovfl_arg_t *arg,
+                struct pt_regs *regs, unsigned long stamp)
+{
+	int cpu = smp_processor_id();
+	unsigned long eip = instruction_pointer(regs);
+	int event = arg->pmd_eventid;
+ 
+	arg->ovfl_ctrl.bits.reset_ovfl_pmds = 1;
+
+	/* the owner of the oprofile event buffer may have exited
+	 * without perfmon being shutdown (e.g. SIGSEGV)
+	 */
+	if (allow_ints)
+		oprofile_add_sample(eip, !user_mode(regs), event, cpu);
+	return 0;
+}
+
+
+static int perfmon_start(void)
+{
+	allow_ints = 1;
+	return 0;
+}
+
+
+static void perfmon_stop(void)
+{
+	allow_ints = 0;
+}
+
+
+#define OPROFILE_FMT_UUID { \
+	0x77, 0x7a, 0x6e, 0x61, 0x20, 0x65, 0x73, 0x69, 0x74, 0x6e, 0x72, 0x20, 0x61, 0x65, 0x0a, 0x6c }
+
+static pfm_buffer_fmt_t oprofile_fmt = {
+ 	.fmt_name 	    = "oprofile_format",
+ 	.fmt_uuid	    = OPROFILE_FMT_UUID,
+ 	.fmt_handler	    = perfmon_handler,
+};
+
+
+static char * get_cpu_type(void)
+{
+	__u8 family = local_cpu_data->family;
+
+	switch (family) {
+		case 0x07:
+			return "ia64/itanium";
+		case 0x1f:
+			return "ia64/itanium2";
+		default:
+			return "ia64/ia64";
+	}
+}
+
+
+/* all the ops are handled via userspace for IA64 perfmon */
+static struct oprofile_operations perfmon_ops = {
+	.start = perfmon_start,
+	.stop = perfmon_stop,
+};
+
+static int using_perfmon;
+
+int perfmon_init(struct oprofile_operations ** ops)
+{
+	int ret = pfm_register_buffer_fmt(&oprofile_fmt);
+	if (ret)
+		return -ENODEV;
+
+	perfmon_ops.cpu_type = get_cpu_type();
+	*ops = &perfmon_ops;
+	using_perfmon = 1;
+	printk(KERN_INFO "oprofile: using perfmon.\n");
+	return 0;
+}
+
+
+void perfmon_exit(void)
+{
+	if (!using_perfmon)
+		return;
+
+	pfm_unregister_buffer_fmt(oprofile_fmt.fmt_uuid);
+}
