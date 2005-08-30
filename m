Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVH3I2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVH3I2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVH3I2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:28:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:181 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751231AbVH3I2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:28:39 -0400
Date: Tue, 30 Aug 2005 13:58:15 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Tom Rini <trini@kernel.crashing.org>, Andi Kleen <ak@suse.de>,
       kaos@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 16/16] Add hardware breakpoint support for i386
Message-ID: <20050830082815.GA28700@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050830082653.GA629@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830082653.GA629@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch provides a simple interface for kernel-space watchpoints
using processor's debug registers. Using Kwatch interface users can
monitor kernel global variables and dump the debugging information such
as kernel stack, global variables, processor registers.

	int register_kwatch(unsigned long addr, u8 length, u8 type,
		kwatch_handler_t handler)

	-length of the breakpoint can be 1,2 or 4 bytes long.
	-type can be read, write, execute. 
		0 Break on instruction execution only. 
		1 Break on data writes only.
		3 Break on data reads or writes but not instruction fetches.

	-return value is the debug register number allocated/used 
	for setting up this watch point.

Sample code:

	This sample code sets a watchpoint on the pid_max
	and registers a call back function if any writes 
	happen to pid_max.

	struct kwatch kp;
	void kwatch_handler(struct kwatch *p, struct pt_regs *regs)
	{
		.......<do-any-thing>........
	}
	
	Register watchpoint probe from init_module:
	
	static int debug_regs_num;
	int init_module(void)
	{
		..........<do-any-thing>............

		debug_regs_num = register_kwatch(kallsyms_lookup_name(pid_max),
					 4, 1, kwatch_handler);
		..........<do-any-thing>............
	}

	Test this by changing the value of pid_max in 
	/proc/sys/kernel/pid_max
	
	echo 1000 > /proc/sys/kernel/pid_max
	
	You see the call back function being called.

	Unregister the watchpoint from cleanup_module:

	void cleanup_module(void)
	{
		..........<do-any-thing>............
		unregister_kwatch(debug_regs_num);
		..........<do-any-thing>............
	}

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---


---

 linux-2.6.13-prasanna/arch/i386/Kconfig.debug   |    8 +
 linux-2.6.13-prasanna/arch/i386/kernel/Makefile |    1 
 linux-2.6.13-prasanna/arch/i386/kernel/kwatch.c |  189 ++++++++++++++++++++++++
 linux-2.6.13-prasanna/include/asm-i386/kwatch.h |   60 +++++++
 4 files changed, 258 insertions(+)

diff -puN arch/i386/Kconfig.debug~kernel-watchpoint arch/i386/Kconfig.debug
--- linux-2.6.13/arch/i386/Kconfig.debug~kernel-watchpoint	2005-08-30 11:44:25.921069488 +0530
+++ linux-2.6.13-prasanna/arch/i386/Kconfig.debug	2005-08-30 11:44:25.932067816 +0530
@@ -32,6 +32,14 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config KWATCH
+	bool "Kwatch points"
+	depends on DEBUG_KERNEL
+	select DEBUGREG
+	help
+	  This enables kernel-space watchpoints using processor's debug
+	  registers. If in doubt, say "N".
+
 config DEBUGREG
 	bool "Global Debug Registers"
 	depends on DEBUG_KERNEL
diff -puN /dev/null arch/i386/kernel/kwatch.c
--- /dev/null	2005-08-30 16:04:24.253093808 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/kwatch.c	2005-08-30 11:44:25.933067664 +0530
@@ -0,0 +1,189 @@
+/*
+ *  Kernel Watchpoint interface.
+ *  arch/i386/kernel/kwatch.c
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> for
+ *		Kernel Watchpoint implementation.
+ * 2004-Oct	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> to
+ *		to make use of notifiers.
+ */
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <asm/kwatch.h>
+#include <asm/kdebug.h>
+#include <asm/debugreg.h>
+#include <asm/bitops.h>
+
+static struct kwatch kwatch_list[DR_MAX];
+static spinlock_t kwatch_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long kwatch_in_progress;	/* currently being handled */
+
+struct dr_info {
+	int debugreg;
+	unsigned long addr;
+	int type;
+};
+
+static inline void write_smp_dr(void *info)
+{
+	struct dr_info *dr = (struct dr_info *)info;
+
+	if (cpu_has_de && dr->type == DR_TYPE_IO)
+		set_in_cr4(X86_CR4_DE);
+	write_dr(dr->debugreg, dr->addr);
+}
+
+/* Update the debug register on all CPUs */
+static void sync_dr(int debugreg, unsigned long addr, int type)
+{
+	struct dr_info dr;
+	dr.debugreg = debugreg;
+	dr.addr = addr;
+	dr.type = type;
+	smp_call_function(write_smp_dr, &dr, 0, 0);
+}
+
+/*
+ * Interrupts are disabled on entry as trap1 is an interrupt gate and they
+ * remain disabled thorough out this function.
+ */
+int kwatch_handler(unsigned long condition, struct pt_regs *regs)
+{
+	int debugreg = dr_trap(condition);
+	unsigned long addr = dr_trap_addr(condition);
+	int retval = 0;
+
+	if (!(condition & (DR_TRAP0 | DR_TRAP1 | DR_TRAP2 | DR_TRAP3)))
+		return 0;
+
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	/* If we are recursing, we already hold the lock. */
+	if (kwatch_in_progress)
+		goto recursed;
+
+	set_bit(debugreg, &kwatch_in_progress);
+
+	spin_lock(&kwatch_lock);
+	if (kwatch_list[debugreg].addr != addr)
+		goto out;
+
+	if (kwatch_list[debugreg].handler)
+		kwatch_list[debugreg].handler(&kwatch_list[debugreg], regs);
+
+	if (kwatch_list[debugreg].type == DR_TYPE_EXECUTE)
+		regs->eflags |= RF_MASK;
+      out:
+	clear_bit(debugreg, &kwatch_in_progress);
+	spin_unlock(&kwatch_lock);
+	preempt_enable_no_resched();
+	return retval;
+
+      recursed:
+	if (kwatch_list[debugreg].type == DR_TYPE_EXECUTE)
+		regs->eflags |= RF_MASK;
+	preempt_enable_no_resched();
+	return 1;
+}
+
+int register_kwatch(unsigned long addr, u8 length, u8 type,
+		    kwatch_handler_t handler)
+{
+	int debugreg;
+	unsigned long dr7, flags;
+
+	debugreg = dr_alloc(DR_ANY, DR_ALLOC_GLOBAL);
+	if (debugreg < 0)
+		return -1;
+
+	spin_lock_irqsave(&kwatch_lock, flags);
+	kwatch_list[debugreg].addr = addr;
+	kwatch_list[debugreg].length = length;
+	kwatch_list[debugreg].type = type;
+	kwatch_list[debugreg].handler = handler;
+	spin_unlock_irqrestore(&kwatch_lock, flags);
+
+	write_dr(debugreg, (unsigned long)addr);
+	sync_dr(debugreg, (unsigned long)addr, type);
+	if (cpu_has_de && type == DR_TYPE_IO)
+		set_in_cr4(X86_CR4_DE);
+
+	dr7 = read_dr(7);
+	SET_DR7(dr7, debugreg, type, length);
+	write_dr(7, dr7);
+	sync_dr(7, dr7, 0);
+	return debugreg;
+}
+
+void unregister_kwatch(int debugreg)
+{
+	unsigned long flags;
+	unsigned long dr7 = read_dr(7);
+
+	RESET_DR7(dr7, debugreg);
+	write_dr(7, dr7);
+	sync_dr(7, dr7, 0);
+	dr_free(debugreg);
+
+	spin_lock_irqsave(&kwatch_lock, flags);
+	kwatch_list[debugreg].addr = 0;
+	kwatch_list[debugreg].handler = NULL;
+	spin_unlock_irqrestore(&kwatch_lock, flags);
+}
+
+/*
+ * Wrapper routine to for handling exceptions.
+ */
+int kwatch_exceptions_notify(struct notifier_block *self, unsigned long val,
+			     void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	switch (val) {
+	case DIE_DEBUG:
+		if (kwatch_handler(args->err, args->regs))
+			return NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kwatch_exceptions_nb = {
+	.notifier_call = kwatch_exceptions_notify,
+	.priority = 0x7ffffffe	/* we need to notified second */
+};
+
+static int __init init_kwatch(void)
+{
+	int err = 0;
+
+	err = register_die_notifier(&kwatch_exceptions_nb);
+	return err;
+}
+
+__initcall(init_kwatch);
+
+EXPORT_SYMBOL_GPL(register_kwatch);
+EXPORT_SYMBOL_GPL(unregister_kwatch);
diff -puN arch/i386/kernel/Makefile~kernel-watchpoint arch/i386/kernel/Makefile
--- linux-2.6.13/arch/i386/kernel/Makefile~kernel-watchpoint	2005-08-30 11:44:25.926068728 +0530
+++ linux-2.6.13-prasanna/arch/i386/kernel/Makefile	2005-08-30 11:44:25.934067512 +0530
@@ -35,6 +35,7 @@ obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_DEBUGREG)		+= debugreg.o
+obj-$(CONFIG_KWATCH)		+= kwatch.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -puN /dev/null include/asm-i386/kwatch.h
--- /dev/null	2005-08-30 16:04:24.253093808 +0530
+++ linux-2.6.13-prasanna/include/asm-i386/kwatch.h	2005-08-30 11:44:25.935067360 +0530
@@ -0,0 +1,60 @@
+#ifndef _ASM_KWATCH_H
+#define _ASM_KWATCH_H
+/*
+ *  Kernel Watchpoint interface.
+ *  include/asm-i386/kwatch.h
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> for
+ *		Kernel Watchpoint implementation.
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+struct kwatch;
+typedef void (*kwatch_handler_t) (struct kwatch *, struct pt_regs *);
+
+struct kwatch {
+	unsigned long addr;	/* location of watchpoint */
+	u8 length;		/* range of address */
+	u8 type;		/* type of watchpoint */
+	kwatch_handler_t handler;
+};
+
+#define RF_MASK	0x00010000
+
+#ifdef CONFIG_KWATCH
+extern int register_kwatch(unsigned long addr, u8 length, u8 type,
+			   kwatch_handler_t handler);
+extern void unregister_kwatch(int debugreg);
+extern int kwatch_handler(unsigned long condition, struct pt_regs *regs);
+#else
+static inline int register_kwatch(unsigned long addr, u8 length, u8 type,
+				  kwatch_handler_t handler)
+{
+	return -ENOSYS;
+}
+static inline void unregister_kwatch(int debugreg)
+{
+}
+static inline int kwatch_handler(unsigned long condition, struct pt_regs *regs)
+{
+	return 0;
+}
+#endif
+#endif				/* _ASM_KWATCH_H */

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
