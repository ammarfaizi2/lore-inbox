Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVEWPus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVEWPus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEWPto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:49:44 -0400
Received: from fmr18.intel.com ([134.134.136.17]:26299 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261898AbVEWPrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:47:25 -0400
Message-Id: <20050523154228.761736000@csdlinux-2.jf.intel.com>
References: <20050523153906.988390000@csdlinux-2.jf.intel.com>
Date: Mon, 23 May 2005 08:39:09 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: tony.luck@intel.com, rohit.seth@intel.com, rusty.lynch@intel.com,
       prasanna@in.ibm.com, ananth@in.ibm.com, systemtap@sources.redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: [patch 3/4] Kprobes support for IA64
Content-Disposition: inline; filename=kprobes-jprobes-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds IA64 architecture specific JProbes support on top of Kprobes

signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>
=======================================================================
 arch/ia64/kernel/Makefile  |    2 -
 arch/ia64/kernel/jprobes.S |   61 +++++++++++++++++++++++++++++++++++++++++++++
 arch/ia64/kernel/kprobes.c |   28 ++++++++++++++++----
 include/asm-ia64/kprobes.h |    5 +++
 4 files changed, 89 insertions(+), 7 deletions(-)

Index: linux-2.6.12-rc4/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/kernel/kprobes.c	2005-05-23 07:57:06.490151962 -0700
+++ linux-2.6.12-rc4/arch/ia64/kernel/kprobes.c	2005-05-23 07:57:38.340737509 -0700
@@ -35,12 +35,15 @@
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 
+extern void jprobe_inst_return(void);
+
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
 #define KPROBE_HIT_SS		0x00000002
 
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status;
+static struct pt_regs jprobe_saved_regs;
 
 enum instruction_type {A, I, M, F, B, L, X, u};
 static enum instruction_type bundle_encoding[32][3] = {
@@ -318,15 +321,28 @@
 
 int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	printk(KERN_WARNING "Jprobes is not supported\n");
-	return 0;
-}
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	unsigned long addr = ((struct fnptr *)(jp->entry))->ip;
 
-void jprobe_return(void)
-{
+	/* save architectural state */
+	jprobe_saved_regs = *regs;
+
+	/* after rfi, execute the jprobe instrumented function */
+	regs->cr_iip = addr & ~0xFULL;
+	ia64_psr(regs)->ri = addr & 0xf;
+	regs->r1 = ((struct fnptr *)(jp->entry))->gp;
+
+	/*
+	 * fix the return address to our jprobe_inst_return() function
+	 * in the jprobes.S file
+	 */
+ 	regs->b0 = ((struct fnptr *)(jprobe_inst_return))->ip;
+
+	return 1;
 }
 
 int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	return 0;
+	*regs = jprobe_saved_regs;
+	return 1;
 }
Index: linux-2.6.12-rc4/arch/ia64/kernel/Makefile
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/kernel/Makefile	2005-05-23 07:55:50.895426325 -0700
+++ linux-2.6.12-rc4/arch/ia64/kernel/Makefile	2005-05-23 07:57:22.849526761 -0700
@@ -20,7 +20,7 @@
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
-obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
 # The gate DSO image is built using a special linker script.
Index: linux-2.6.12-rc4/arch/ia64/kernel/jprobes.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/arch/ia64/kernel/jprobes.S	2005-05-23 07:57:22.850503324 -0700
@@ -0,0 +1,61 @@
+/*
+ * Jprobe specific operations
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Intel Corporation, 2005
+ *
+ * 2005-May     Rusty Lynch <rusty.lynch@intel.com> and Anil S Keshavamurthy
+ *              <anil.s.keshavamurthy@intel.com> initial implementation
+ *
+ * Jprobes (a.k.a. "jump probes" which is built on-top of kprobes) allow a
+ * probe to be inserted into the beginning of a function call.  The fundamental
+ * difference between a jprobe and a kprobe is the jprobe handler is executed
+ * in the same context as the target function, while the kprobe handlers
+ * are executed in interrupt context.
+ *
+ * For jprobes we initially gain control by placing a break point in the
+ * first instruction of the targeted function.  When we catch that specific
+ * break, we:
+ *        * set the return address to our jprobe_inst_return() function
+ *        * jump to the jprobe handler function
+ *
+ * Since we fixed up the return address, the jprobe handler will return to our
+ * jprobe_inst_return() function, giving us control again.  At this point we
+ * are back in the parents frame marker, so we do yet another call to our
+ * jprobe_break() function to fix up the frame marker as it would normally
+ * exist in the target function.
+ *
+ * Our jprobe_return function then transfers control back to kprobes.c by
+ * executing a break instruction using one of our reserved numbers.  When we
+ * catch that break in kprobes.c, we continue like we do for a normal kprobe
+ * by single stepping the emulated instruction, and then returning execution
+ * to the correct location.
+ */
+#include <asm/asmmacro.h>
+
+	/*
+	 * void jprobe_break(void)
+	 */
+ENTRY(jprobe_break)
+	break.m 0x80300
+END(jprobe_break)
+
+	/*
+	 * void jprobe_inst_return(void)
+	 */
+GLOBAL_ENTRY(jprobe_inst_return)
+	br.call.sptk.many b0=jprobe_break
+END(jprobe_inst_return)
Index: linux-2.6.12-rc4/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-ia64/kprobes.h	2005-05-23 07:55:50.897379450 -0700
+++ linux-2.6.12-rc4/include/asm-ia64/kprobes.h	2005-05-23 07:57:38.341714071 -0700
@@ -57,6 +57,11 @@
 	kprobe_opcode_t insn;
 };
 
+/* ia64 does not need this */
+static inline void jprobe_return(void)
+{
+}
+
 #ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);

--
