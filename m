Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTA2SHJ>; Wed, 29 Jan 2003 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbTA2SHJ>; Wed, 29 Jan 2003 13:07:09 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:13290 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP
	id <S266777AbTA2SGq>; Wed, 29 Jan 2003 13:06:46 -0500
Subject: [RFC][2.5.59 PATCH]mmio probes
From: Rusty Lynch <rusty@linux.co.intel.com>
To: lkml <linux-kernel@vger.kernel.org>, "Vamsi Krishna S." <vamsi@in.ibm.com>
Cc: Louis Zhuang <louis.zhuang@intel.com>,
       fault-injection-developer 
	<fault-injection-developer@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Jan 2003 10:15:46 -0800
Message-Id: <1043864147.11755.4.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I previously noted in an earlier message at
http://marc.theaimsgroup.com/?l=linux-kernel&m=104386132315914&w=2,
while kicking around ideas in the fault injection project, the need for some 
additional non-fi specific features has surfaced.

One of these needs is the ability to hook (in same way that kprobes can add a 
hook) to a specific memory mapped IO region before the user of the region gets 
access.  A fault injection test case may need to just note when a given
region is being read/written, take some action before the caller returns
from the read or write operation, or change the value that is being read
or written.

The following is a patch for a 2.5.59 kernel with the kprobes patch (posted at
http://marc.theaimsgroup.com/?l=linux-kernel&m=104254476428330&w=2 ) already
applied that provides this feature for the i368 architecture.  The patch
does not call the kprobes functions, but depends on the same tweaks to 
traps.c and fault.c that kprobes provides.

We also followed the same usage that kprobes provides, with a 
register_kmmio_probe() function for adding the hook/probe, and a
unregister_kmmio_probe() function for removing the hook/probe.

As with the kirq patch, this patch is an early request for comments with
the goal of an acceptable patch for the 2.7 kernel.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.957   -> 1.958  
#	arch/i386/mm/fault.c	1.24    -> 1.25   
#	   arch/i386/Kconfig	1.35    -> 1.36   
#	arch/i386/kernel/traps.c	1.43    -> 1.44   
#	arch/i386/kernel/Makefile	1.33    -> 1.34   
#	     kernel/Makefile	1.26    -> 1.27   
#	               (new)	        -> 1.1     include/linux/kmmio.h
#	               (new)	        -> 1.1     kernel/kmmio.c 
#	               (new)	        -> 1.1     arch/i386/kernel/kmmio.c
#	               (new)	        -> 1.1     include/asm-i386/kmmio.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/23	rusty@vmhack.(none)	1.958
# Adding kmmio
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Thu Jan 23 11:37:54 2003
+++ b/arch/i386/Kconfig	Thu Jan 23 11:37:54 2003
@@ -1554,6 +1554,15 @@
 	  for kernel debugging, non-intrusive instrumentation and testing.  If
 	  in doubt, say "N".
 
+config KMMIO
+	bool "KMMIO (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on KPROBES 
+	help
+	  KMMIO is a Kprobes add-ons for placing a probe on MMIO access, using
+	  register_kmmio(), and providing a callback function. This is useful
+	  for monitoring driver access specific MMIO address.
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Thu Jan 23 11:37:54 2003
+++ b/arch/i386/kernel/Makefile	Thu Jan 23 11:37:54 2003
@@ -4,7 +4,7 @@
 
 EXTRA_TARGETS := head.o init_task.o
 
-export-objs     := mca.o i386_ksyms.o time.o
+export-objs     := mca.o i386_ksyms.o time.o kmmio.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
@@ -30,6 +30,7 @@
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KMMIO)		+= kmmio.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o
 
diff -Nru a/arch/i386/kernel/kmmio.c b/arch/i386/kernel/kmmio.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/kmmio.c	Thu Jan 23 11:37:54 2003
@@ -0,0 +1,159 @@
+/* 
+ * KMMIO
+ * Benfit many code from kprobes
+ * (C) 2002 Louis Zhuang <louis.zhuang@intel.com>.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <linux/kmmio.h>
+#include <linux/ptrace.h>
+#include <linux/preempt.h>
+#include <asm/io.h>
+#include <asm/highmem.h>
+
+static int cpu=-1;
+static struct kmmio_fault_page *cur_page = NULL;
+static struct kmmio_probe *cur_probe = NULL;
+static unsigned long kmmio_saved_eflags;
+/*
+ * Interrupts are disabled on entry as trap3 is an interrupt gate 
+ * and they remain disabled thorough out this function.
+ */
+int kmmio_handler(struct pt_regs *regs, unsigned long addr)
+{
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	lock_kmmio();
+
+	cur_page = get_kmmio_fault_page((void *)addr);
+	if (!cur_page) {
+		/* this page fault is not caused by kmmio */
+		/* XXX some pending fault on other cpu may cause problem! */ 
+		unlock_kmmio();
+		goto no_kmmio;
+	}
+	cpu = smp_processor_id();
+	
+	cur_probe = get_kmmio_probe((void *)addr); 
+	kmmio_saved_eflags = (regs->eflags & (TF_MASK|IF_MASK));
+	
+	if (cur_probe && cur_probe->pre_handler) {
+		cur_probe->pre_handler(cur_probe, regs, addr);
+	}
+	
+	regs->eflags |= TF_MASK;
+	regs->eflags &= ~IF_MASK;
+
+	/* We hold lock, now we set present bit in PTE and single step. */
+	disarm_kmmio_fault_page(cur_page->page);
+	
+
+	return 1;
+
+no_kmmio:
+	preempt_enable_no_resched();
+	return 0;
+}
+
+/*
+ * Interrupts are disabled on entry as trap1 is an interrupt gate 
+ * and they remain disabled thorough out this function.  
+ * And we hold kmmio lock.
+ */
+int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
+{
+	if (!is_kmmio_active())
+		return 0;
+	if (smp_processor_id() != cpu)
+		return 0;
+
+	if (cur_probe && cur_probe->post_handler) {
+		cur_probe->post_handler(cur_probe, condition, regs);
+	}
+
+	arm_kmmio_fault_page(cur_page->page);
+	__flush_tlb_one(cur_page->page);
+	
+	regs->eflags &= ~TF_MASK;
+	regs->eflags |= kmmio_saved_eflags;
+
+	cpu = -1;
+	
+	unlock_kmmio();
+	preempt_enable_no_resched();
+	
+        /*
+	 * if somebody else is singlestepping across a probe point, eflags
+	 * will have TF set, in which case, continue the remaining processing
+	 * of do_debug, as if this is not a probe hit.
+	 */
+	if (regs->eflags & TF_MASK)
+		return 0;
+
+	return 1;
+}
+
+static inline pte_t *get_pte(unsigned long address) 
+{
+        pgd_t *pgd = pgd_offset_k(address);
+	pmd_t *pmd = pmd_offset(pgd, address);
+	if (pmd_large(*pmd))
+		return (pte_t *)pmd;
+	return pte_offset_kernel(pmd, address);
+};
+
+/**
+ * Set/Clear pte bits
+ */
+static inline void clr_pte_bits(unsigned long addr, 
+				unsigned long bitmask) 
+{
+	pte_t *pte;
+	pte = get_pte(addr);
+	set_pte( pte, __pte( pte_val(*pte) & ~bitmask) );	
+};
+
+static inline void set_pte_bits(unsigned long addr, 
+				unsigned long bitmask) 
+{
+	pte_t *pte;
+	pte = get_pte(addr);
+	set_pte( pte, __pte( pte_val(*pte) | bitmask) );	
+};	
+
+void arm_kmmio_fault_page(kmmio_addr_t page)
+{	
+	(unsigned long)page &= PAGE_MASK;
+	clr_pte_bits((unsigned long)page, _PAGE_PRESENT);
+}
+
+void disarm_kmmio_fault_page(kmmio_addr_t page)
+{
+	(unsigned long)page &= PAGE_MASK;
+	set_pte_bits((unsigned long)page, _PAGE_PRESENT);
+}
+
+/* the function is only used to make virt map to bus */
+void *kmmio_invert_map(void *virt_addr, unsigned long bus_addr)
+{
+	int offset;
+	pte_t *pte;
+
+	if((unsigned long)virt_addr & ~PAGE_MASK)
+		BUG();
+	
+	offset = bus_addr & ~PAGE_MASK;
+	bus_addr &= PAGE_MASK;
+	pte = get_pte((unsigned long)virt_addr);
+	
+	set_pte( pte, __pte( (pte_val(*pte) & ~PAGE_MASK) | bus_addr) );
+	return virt_addr+offset;								
+}
+
+EXPORT_SYMBOL_GPL(kmmio_invert_map);
diff -Nru a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Thu Jan 23 11:37:54 2003
+++ b/arch/i386/kernel/traps.c	Thu Jan 23 11:37:54 2003
@@ -25,6 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/kallsyms.h>
 #include <linux/kprobes.h>
+#include <linux/kmmio.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -529,6 +530,9 @@
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
 	if (post_kprobe_handler(regs))
+		return 1;
+
+	if (post_kmmio_handler(condition, regs))
 		return 1;
 
 	/* Interrupts not disabled for normal trap handling. */
diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c	Thu Jan 23 11:37:54 2003
+++ b/arch/i386/mm/fault.c	Thu Jan 23 11:37:54 2003
@@ -21,6 +21,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/kmmio.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -163,6 +164,9 @@
 	__asm__("movl %%cr2,%0":"=r" (address));
 
 	if (kprobe_running() && kprobe_fault_handler(regs, 14))
+		return;
+
+	if (is_kmmio_active() && kmmio_handler(regs, address))
 		return;
 
 	/* It's safe to allow irq's after cr2 has been saved */
diff -Nru a/include/asm-i386/kmmio.h b/include/asm-i386/kmmio.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/kmmio.h	Thu Jan 23 11:37:54 2003
@@ -0,0 +1,33 @@
+/*
+ * Benfit many code from kprobes
+ * (C) 2002 Louis Zhuang <louis.zhuang@intel.com>.
+ */
+
+#ifndef _ASM_KMMIO_H
+#define _ASM_KMMIO_H
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+struct pt_regs;
+
+typedef void* kmmio_addr_t;
+
+#ifdef CONFIG_KMMIO
+extern void arm_kmmio_fault_page(kmmio_addr_t page);
+extern void disarm_kmmio_fault_page(kmmio_addr_t page);
+extern int post_kmmio_handler(unsigned long condition, 
+			      struct pt_regs *regs);
+extern int kmmio_handler(struct pt_regs *regs, unsigned long addr);
+extern void *kmmio_invert_map(void *virt_addr, unsigned long bus_addr);
+#else /* !CONFIG_KMMIO */
+static inline int post_kmmio_handler(unsigned long condition, 
+				     struct pt_regs *regs) 
+{ 
+	return 0; 
+}
+static inline int kmmio_handler(struct pt_regs *regs, unsigned long addr) 
+{ 
+	return 0; 
+}
+#endif
+#endif /* _ASM_KMMIO_H */
diff -Nru a/include/linux/kmmio.h b/include/linux/kmmio.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/kmmio.h	Thu Jan 23 11:37:54 2003
@@ -0,0 +1,67 @@
+#ifndef _LINUX_KMMIO_H
+#define _LINUX_KMMIO_H
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <asm/kmmio.h>
+
+struct kmmio_probe;
+struct kmmio_fault_page;
+struct pt_regs;
+
+typedef void (*kmmio_pre_handler_t)(struct kmmio_probe *, 
+				    struct pt_regs *, 
+				    unsigned long addr);
+typedef void (*kmmio_post_handler_t)(struct kmmio_probe *, 
+				     unsigned long condition, 
+				     struct pt_regs *);
+struct kmmio_probe {
+	struct list_head list;
+
+	/* location of the probe point */
+	kmmio_addr_t addr;
+
+	 /* Called before addr is executed. */
+	kmmio_pre_handler_t pre_handler;
+
+	/* Called after addr is executed, unless... */
+	kmmio_post_handler_t post_handler;
+};
+
+struct kmmio_fault_page {
+	struct list_head list;
+
+	/* location of the fault page */
+	kmmio_addr_t page;
+
+	int count;
+};
+
+#ifdef CONFIG_KMMIO
+/* Locks kmmio: irq must be disabled */
+void lock_kmmio(void);
+void unlock_kmmio(void);
+
+/* kmmio is active by some kmmio_probes? */
+static inline int is_kmmio_active(void)
+{
+	extern unsigned int kmmio_count;
+	return kmmio_count;
+}
+
+/* Get the kmmio at this addr (if any).  Must have called lock_kmmio */
+struct kmmio_probe *get_kmmio_probe(kmmio_addr_t addr);
+struct kmmio_fault_page *get_kmmio_fault_page(kmmio_addr_t page);
+int add_kmmio_fault_page(kmmio_addr_t page);
+void release_kmmio_fault_page(kmmio_addr_t page);
+
+int register_kmmio_probe(struct kmmio_probe *p);
+void unregister_kmmio_probe(struct kmmio_probe *p);
+#else
+static inline int is_kmmio_active(void) 
+{ 
+	return 0; 
+}
+#endif
+#endif /* _LINUX_KMMIO_H */
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Thu Jan 23 11:37:54 2003
+++ b/kernel/Makefile	Thu Jan 23 11:37:54 2003
@@ -4,7 +4,7 @@
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
 		printk.o suspend.o dma.o module.o cpufreq.o \
-		profile.o rcupdate.o intermodule.o params.o
+		profile.o rcupdate.o intermodule.o params.o kmmio.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
@@ -23,6 +23,7 @@
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_KMMIO)   += kmmio.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nru a/kernel/kmmio.c b/kernel/kmmio.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/kmmio.c	Thu Jan 23 11:37:54 2003
@@ -0,0 +1,149 @@
+/* Support for MMIO probes.
+ * Benfit many code from kprobes
+ * (C) 2002 Louis Zhuang <louis.zhuang@intel.com>.
+*/
+
+#include <linux/kmmio.h>
+#include <linux/spinlock.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/cacheflush.h>
+#include <asm/errno.h>
+#include <asm/highmem.h>
+
+#define KMMIO_HASH_BITS 6
+#define KMMIO_TABLE_SIZE (1 << KMMIO_HASH_BITS)
+
+static struct list_head kmmio_table[KMMIO_TABLE_SIZE];
+
+#define KMMIO_PAGE_HASH_BITS 4
+#define KMMIO_PAGE_TABLE_SIZE (1 << KMMIO_PAGE_HASH_BITS)
+static struct list_head kmmio_page_table[KMMIO_PAGE_TABLE_SIZE];
+
+unsigned int kmmio_count = 0;
+static spinlock_t kmmio_lock = SPIN_LOCK_UNLOCKED;
+
+/* Locks kmmio: irqs must be disabled */
+void lock_kmmio(void)
+{
+	spin_lock(&kmmio_lock);
+}
+
+void unlock_kmmio(void)
+{
+	spin_unlock(&kmmio_lock);
+}
+
+/* You have to be holding the kmmio_lock */
+struct kmmio_probe *get_kmmio_probe(void *addr)
+{
+	struct list_head *head, *tmp;
+
+	head = &kmmio_table[hash_ptr(addr, KMMIO_HASH_BITS)];
+	list_for_each(tmp, head) {
+		struct kmmio_probe *p = list_entry(tmp, struct kmmio_probe, list);
+		if (p->addr == addr)
+			return p;
+	}
+	return NULL;
+}
+
+int register_kmmio_probe(struct kmmio_probe *p)
+{
+	int ret = 0;
+	
+	spin_lock_irq(&kmmio_lock);
+	kmmio_count++;
+	if (get_kmmio_probe(p->addr)) {
+		ret = -EEXIST;
+		goto out;
+	}
+	list_add(&p->list, &kmmio_table[hash_ptr(p->addr, KMMIO_HASH_BITS)]);
+
+	if (add_kmmio_fault_page(p->addr)) {
+		printk(KERN_ERR "Unable to set page fault\n");
+	}
+	
+ out:
+	spin_unlock_irq(&kmmio_lock);
+	flush_tlb_all();
+	return ret;
+}
+
+void unregister_kmmio_probe(struct kmmio_probe *p)
+{
+	spin_lock_irq(&kmmio_lock);
+	release_kmmio_fault_page(p->addr);
+	list_del(&p->list);
+	kmmio_count--;
+	spin_unlock_irq(&kmmio_lock);
+}
+
+struct kmmio_fault_page *get_kmmio_fault_page(kmmio_addr_t page)
+{
+	struct list_head *head, *tmp;
+
+	(unsigned long)page &= PAGE_MASK;
+	head = &kmmio_page_table[hash_ptr(page, KMMIO_PAGE_HASH_BITS)];
+	list_for_each(tmp, head) {
+		struct kmmio_fault_page *p 
+			= list_entry(tmp, struct kmmio_fault_page, list);
+		if (p->page == page)
+			return p;
+	}
+	return NULL;
+}
+
+int add_kmmio_fault_page(kmmio_addr_t page)
+{
+	struct kmmio_fault_page *f;
+	
+	(unsigned long)page &= PAGE_MASK;
+	f = get_kmmio_fault_page(page);
+	if (f) {
+		f->count++;
+		return 0;
+	}
+	f = (struct kmmio_fault_page *)kmalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f) return -1;
+	f->count = 1;
+	f->page = page;
+	list_add(&f->list, 
+		 &kmmio_page_table[hash_ptr(f->page, KMMIO_PAGE_HASH_BITS)]);
+
+	arm_kmmio_fault_page(f->page);
+	return 0;
+}
+
+void release_kmmio_fault_page(kmmio_addr_t page)
+{
+	struct kmmio_fault_page *f;
+
+	(unsigned long)page &= PAGE_MASK;
+	f = get_kmmio_fault_page(page);
+	if (!f)	return;
+	f->count--;
+	if(!f->count) {
+		disarm_kmmio_fault_page(f->page);
+		list_del(&f->list);
+	}
+}
+
+static int __init init_kmmio(void)
+{
+	int i;
+
+	/* FIXME allocate the probe table, currently defined statically */
+	/* initialize all list heads */
+	for (i = 0; i < KMMIO_TABLE_SIZE; i++)
+		INIT_LIST_HEAD(&kmmio_table[i]);
+	for (i = 0; i < KMMIO_PAGE_TABLE_SIZE; i++) 
+		INIT_LIST_HEAD(&kmmio_page_table[i]);
+	return 0;
+}
+__initcall(init_kmmio);
+
+EXPORT_SYMBOL_GPL(register_kmmio_probe);
+EXPORT_SYMBOL_GPL(unregister_kmmio_probe);



