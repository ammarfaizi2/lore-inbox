Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbSJVKw6>; Tue, 22 Oct 2002 06:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSJVKw6>; Tue, 22 Oct 2002 06:52:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41687 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262400AbSJVKww>;
	Tue, 22 Oct 2002 06:52:52 -0400
Date: Tue, 22 Oct 2002 16:42:20 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/4] kprobes - kwatch points for 2.5.44
Message-ID: <20021022164220.C26617@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch to provide kernel watch points. This requires
the earlier debug registers patch. The simple interface
provided is:

int register_kwatch(unsigned long addr, u8 length, u8 type,
                kwatch_handler_t handler)

return value is the debug register number allocated/used
for setting up this watch point.

and

void unregister_kwatch(int debugreg)

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/config.in 44-kprobes/arch/i386/config.in
--- 44-pure/arch/i386/config.in	2002-10-22 14:08:23.000000000 +0530
+++ 44-kprobes/arch/i386/config.in	2002-10-22 14:09:32.000000000 +0530
@@ -458,6 +458,7 @@
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Global Debug Registers' CONFIG_DEBUGREG
+   dep_bool '  Kwatch points' CONFIG_KWATCH $CONFIG_DEBUGREG
    bool '  Check for stack overflows' CONFIG_DEBUG_STACKOVERFLOW
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/kwatch.c 44-kprobes/arch/i386/kernel/kwatch.c
--- 44-pure/arch/i386/kernel/kwatch.c	1970-01-01 05:30:00.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/kwatch.c	2002-10-22 14:09:11.000000000 +0530
@@ -0,0 +1,135 @@
+/* 
+ * Support for kernel watchpoints.
+ * (C) 2002 Vamsi Krishna S <vamsi_krishna@in.ibm.com>.
+ */
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/kwatch.h>
+#include <asm/debugreg.h>
+#include <asm/bitops.h>
+
+static struct kwatch kwatch_list[DR_MAX];
+static spinlock_t kwatch_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long kwatch_in_progress; /* currently being handled */
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
+	if (!(condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))) {
+		return 0;
+	}
+	
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	/* If we are recursing, we already hold the lock. */
+	if (kwatch_in_progress) {
+		goto recursed;
+	}
+	set_bit(debugreg, &kwatch_in_progress);
+	
+	spin_lock(&kwatch_lock);
+	if (kwatch_list[debugreg].addr != addr)
+		goto out;
+
+	if (kwatch_list[debugreg].handler) {
+		kwatch_list[debugreg].handler(&kwatch_list[debugreg], regs);
+	}
+	
+	if (kwatch_list[debugreg].type == DR_TYPE_EXECUTE)
+		regs->eflags |= RF_MASK;
+out:
+	clear_bit(debugreg, &kwatch_in_progress);
+	spin_unlock(&kwatch_lock);
+	preempt_enable_no_resched();
+	return retval;
+
+recursed:
+	if (kwatch_list[debugreg].type == DR_TYPE_EXECUTE)
+		regs->eflags |= RF_MASK;
+	preempt_enable_no_resched();
+	return 1;
+}
+
+int register_kwatch(unsigned long addr, u8 length, u8 type, 
+		kwatch_handler_t handler)
+{
+	int debugreg;
+	unsigned long dr7, flags;
+
+	debugreg = dr_alloc(DR_ANY, DR_ALLOC_GLOBAL);
+	if (debugreg < 0) {
+		return -1;
+	}
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
+EXPORT_SYMBOL_GPL(register_kwatch);
+EXPORT_SYMBOL_GPL(unregister_kwatch);
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/Makefile 44-kprobes/arch/i386/kernel/Makefile
--- 44-pure/arch/i386/kernel/Makefile	2002-10-22 14:08:23.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/Makefile	2002-10-22 14:09:11.000000000 +0530
@@ -4,7 +4,7 @@
 
 EXTRA_TARGETS := head.o init_task.o
 
-export-objs     := mca.o i386_ksyms.o time.o debugreg.o
+export-objs     := mca.o i386_ksyms.o time.o debugreg.o kwatch.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
@@ -31,6 +31,7 @@
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_DEBUGREG)		+= debugreg.o
+obj-$(CONFIG_KWATCH)		+= kwatch.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/traps.c 44-kprobes/arch/i386/kernel/traps.c
--- 44-pure/arch/i386/kernel/traps.c	2002-10-22 14:08:24.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/traps.c	2002-10-22 14:09:11.000000000 +0530
@@ -39,6 +39,7 @@
 #include <asm/io.h>
 #include <asm/atomic.h>
 #include <asm/debugreg.h>
+#include <asm/kwatch.h>
 #include <asm/desc.h>
 #include <asm/i387.h>
 #include <asm/nmi.h>
@@ -591,6 +592,9 @@
 	if (post_kprobe_handler(regs))
 		return 1;
 
+	if (kwatch_handler(condition, regs))
+		return 1;
+
 	/* Interrupts not disabled for normal trap handling. */
 	restore_interrupts(regs);
 
diff -urN -X /home/vamsi/.dontdiff 44-pure/include/asm-i386/kwatch.h 44-kprobes/include/asm-i386/kwatch.h
--- 44-pure/include/asm-i386/kwatch.h	1970-01-01 05:30:00.000000000 +0530
+++ 44-kprobes/include/asm-i386/kwatch.h	2002-10-22 14:09:11.000000000 +0530
@@ -0,0 +1,31 @@
+#ifndef _ASM_KWATCH_H
+#define _ASM_KWATCH_H
+/*
+ * Dynamic Probes (kwatch points) support
+ *  	Vamsi Krishna S <vamsi_krishna@in.ibm.com>, Oct, 2002
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+struct kwatch;
+typedef void (*kwatch_handler_t)(struct kwatch *, struct pt_regs *);
+
+struct kwatch {
+	unsigned long addr;	/* location of watchpoint */
+	u8 length;	/* range of address */
+	u8 type;	/* type of watchpoint */
+	kwatch_handler_t handler;
+};
+
+#define RF_MASK	0x00010000
+
+#ifdef CONFIG_KWATCH
+extern int register_kwatch(unsigned long addr, u8 length, u8 type, kwatch_handler_t handler);
+extern void unregister_kwatch(int debugreg);
+extern int kwatch_handler(unsigned long condition, struct pt_regs *regs);
+#else
+static inline int register_kwatch(unsigned long addr, u8 length, u8 type, kwatch_handler_t handler) { return -ENOSYS; }
+static inline void unregister_kwatch(int debugreg) { }
+static inline int kwatch_handler(unsigned long condition, struct pt_regs *regs) { return 0; }
+#endif
+#endif /* _ASM_KWATCH_H */
