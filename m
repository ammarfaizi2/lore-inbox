Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSGZJoq>; Fri, 26 Jul 2002 05:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGZJop>; Fri, 26 Jul 2002 05:44:45 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:18693 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317667AbSGZJog>; Fri, 26 Jul 2002 05:44:36 -0400
Date: Fri, 26 Jul 2002 13:47:30 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Oliver Pitzeier <o.pitzeier@uptime.at>, linux-kernel@vger.kernel.org
Subject: [alpha 2.5.28] Re: kbuild 2.5.26 - arch/alpha
Message-ID: <20020726134730.A14954@jurassic.park.msu.ru>
References: <200207211354.g6LDsADU005586@alder.intra.bruli.net> <3D3D6B3B.25754.1392D3FD@localhost> <20020723132811.GX8891@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020723132811.GX8891@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jul 23, 2002 at 03:28:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2002 at 03:28:11PM +0200, Jan-Benedict Glaw wrote:
> There was a quite good patch sent to l-k some weeks ago which
> (basically) still applies. I'm using this one (with watering eyes
> waiting for a compileable Linus-Kernel...).

Fortunately there is not so much new "breakage" introduced since 2.5.24
(last kernel I checked). Updated patch attached. By now tested only
on sx164. SMP is still broken, sorry.

I'm planning to split this in a reasonable fashion and start
feeding it to Linus/Richard. Hopefully early in August...

Ivan.


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="axp-2528.patch"

--- 2.5.28/drivers/char/rtc.c	Thu Jul 25 01:03:26 2002
+++ linux/drivers/char/rtc.c	Thu Jul 25 15:28:26 2002
@@ -870,7 +870,9 @@ no_irq:
 
 	if (misc_register(&rtc_dev))
 		{
+#if RTC_IRQ
 		free_irq(RTC_IRQ, NULL);
+#endif
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -ENODEV;
 		}
--- 2.5.28/drivers/serial/8250_pci.c	Thu Jul 25 01:03:30 2002
+++ linux/drivers/serial/8250_pci.c	Thu Jul 25 19:21:36 2002
@@ -30,6 +30,7 @@
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/serial.h>
+#include <asm/io.h>
 
 #include "8250.h"
 
--- 2.5.28/include/asm-alpha/page.h	Thu Jul 25 01:03:30 2002
+++ linux/include/asm-alpha/page.h	Thu Jul 25 15:28:26 2002
@@ -15,10 +15,10 @@
 #define STRICT_MM_TYPECHECKS
 
 extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
 
 extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
@@ -95,8 +95,12 @@ extern __inline__ int get_order(unsigned
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 #ifndef CONFIG_DISCONTIGMEM
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #endif /* CONFIG_DISCONTIGMEM */
 
 #define VM_DATA_DEFAULT_FLAGS		(VM_READ | VM_WRITE | VM_EXEC | \
--- 2.5.28/include/asm-alpha/pgtable.h	Thu Jul 25 01:03:24 2002
+++ linux/include/asm-alpha/pgtable.h	Thu Jul 25 15:28:26 2002
@@ -179,11 +179,12 @@ extern unsigned long __zero_page(void);
 #endif
 #if defined(CONFIG_ALPHA_GENERIC) || \
     (defined(CONFIG_ALPHA_EV6) && !defined(USE_48_BIT_KSEG))
-#define PHYS_TWIDDLE(phys) \
-  ((((phys) & 0xc0000000000UL) == 0x40000000000UL) \
-  ? ((phys) ^= 0xc0000000000UL) : (phys))
+#define KSEG_PFN	(0xc0000000000UL >> PAGE_SHIFT)
+#define PHYS_TWIDDLE(pfn) \
+  ((((pfn) & KSEG_PFN) == (0x40000000000UL >> PAGE_SHIFT)) \
+  ? ((pfn) ^= KSEG_PFN) : (pfn))
 #else
-#define PHYS_TWIDDLE(phys) (phys)
+#define PHYS_TWIDDLE(pfn) (pfn)
 #endif
 
 /*
@@ -199,12 +200,13 @@ extern unsigned long __zero_page(void);
 #endif
 
 #ifndef CONFIG_DISCONTIGMEM
+#define pte_pfn(pte)	(pte_val(pte) >> 32)
+#define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 #define mk_pte(page, pgprot)						\
 ({									\
 	pte_t pte;							\
 									\
-	pte_val(pte) = ((unsigned long)(page - mem_map) << 32) |	\
-		       pgprot_val(pgprot);				\
+	pte_val(pte) = (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\
 	pte;								\
 })
 #else
@@ -219,10 +221,20 @@ extern unsigned long __zero_page(void);
 										\
 	pte;									\
 })
+#define pte_page(x)							\
+({									\
+	unsigned long kvirt;						\
+	struct page * __xx;						\
+									\
+	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
+	__xx = virt_to_page(kvirt);					\
+									\
+	__xx;								\
+})
 #endif
 
-extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
-{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpage) << (32-PAGE_SHIFT)) | pgprot_val(pgprot); return pte; }
+extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
+{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
 
 extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
@@ -233,20 +245,6 @@ extern inline void pmd_set(pmd_t * pmdp,
 extern inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
 { pgd_val(*pgdp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
-#ifndef CONFIG_DISCONTIGMEM
-#define pte_page(x)	(mem_map+(unsigned long)((pte_val(x) >> 32)))
-#else
-#define pte_page(x)							\
-({									\
-	unsigned long kvirt;						\
-	struct page * __xx;						\
-									\
-	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
-	__xx = virt_to_page(kvirt);					\
-									\
-	__xx;								\
-})
-#endif
 
 extern inline unsigned long
 pmd_page_kernel(pmd_t pmd)
--- 2.5.28/include/asm-alpha/tlb.h	Thu Jul 25 01:03:26 2002
+++ linux/include/asm-alpha/tlb.h	Thu Jul 25 15:28:26 2002
@@ -1 +1,15 @@
+#ifndef _ALPHA_TLB_H
+#define _ALPHA_TLB_H
+
+#define tlb_start_vma(tlb, vma)			do { } while (0)
+#define tlb_end_vma(tlb, vma)			do { } while (0)
+#define tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
+
+#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
+
 #include <asm-generic/tlb.h>
+
+#define pte_free_tlb(tlb,pte)			pte_free(pte)
+#define pmd_free_tlb(tlb,pmd)			pmd_free(pmd)
+ 
+#endif
--- 2.5.28/include/asm-alpha/bitops.h	Thu Jul 25 01:03:28 2002
+++ linux/include/asm-alpha/bitops.h	Thu Jul 25 15:28:26 2002
@@ -315,6 +315,20 @@ static inline int ffs(int word)
 	return word ? result+1 : 0;
 }
 
+/*
+ * fls: find last bit set.
+ */
+#if defined(__alpha_cix__) && defined(__alpha_fix__)
+static inline int fls(int word)
+{
+	long result;
+	__asm__("ctlz %1,%0" : "=r"(result) : "r"(word & 0xffffffff));
+	return 64 - result;
+}
+#else
+#define fls	generic_fls
+#endif
+
 /* Compute powers of two for the given integer.  */
 static inline int floor_log2(unsigned long word)
 {
--- 2.5.28/include/asm-alpha/regdef.h	Thu Jan  1 00:00:00 1970
+++ linux/include/asm-alpha/regdef.h	Thu Jul 25 15:28:26 2002
@@ -0,0 +1,44 @@
+#ifndef __alpha_regdef_h__
+#define __alpha_regdef_h__
+
+#define v0	$0	/* function return value */
+
+#define t0	$1	/* temporary registers (caller-saved) */
+#define t1	$2
+#define t2	$3
+#define t3	$4
+#define t4	$5
+#define t5	$6
+#define t6	$7
+#define t7	$8
+
+#define	s0	$9	/* saved-registers (callee-saved registers) */
+#define	s1	$10
+#define	s2	$11
+#define	s3	$12
+#define	s4	$13
+#define	s5	$14
+#define	s6	$15
+#define	fp	s6	/* frame-pointer (s6 in frame-less procedures) */
+
+#define a0	$16	/* argument registers (caller-saved) */
+#define a1	$17
+#define a2	$18
+#define a3	$19
+#define a4	$20
+#define a5	$21
+
+#define t8	$22	/* more temps (caller-saved) */
+#define t9	$23
+#define t10	$24
+#define t11	$25
+#define ra	$26	/* return address register */
+#define t12	$27
+
+#define pv	t12	/* procedure-variable register */
+#define AT	$at	/* assembler temporary */
+#define gp	$29	/* global pointer */
+#define sp	$30	/* stack pointer */
+#define zero	$31	/* reads as zero, writes are noops */
+
+#endif /* __alpha_regdef_h__ */
--- 2.5.28/include/asm-alpha/hardirq.h	Thu Jul 25 01:03:20 2002
+++ linux/include/asm-alpha/hardirq.h	Thu Jul 25 18:52:20 2002
@@ -7,91 +7,91 @@
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned long __softirq_pending;
-	unsigned int __local_irq_count;
-	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
+	unsigned long idle_timestamp;
 	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
 /*
- * Are we in an interrupt context? Either doing bottom half
- * or hardware interrupt processing?
+ * We put the hardirq and softirq counter into the preemption
+ * counter. The bitmask has the following meaning:
+ *
+ * - bits 0-7 are the preemption count (max preemption depth: 256)
+ * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
+ *
+ * - ( bit 26 is the PREEMPT_ACTIVE flag. )
+ *
+ * PREEMPT_MASK: 0x000000ff
+ * HARDIRQ_MASK: 0x0000ff00
+ * SOFTIRQ_MASK: 0x00ff0000
  */
 
-#define in_interrupt()						\
-({								\
-	int __cpu = smp_processor_id();				\
-	(local_irq_count(__cpu) + local_bh_count(__cpu)) != 0;	\
-})
+#define PREEMPT_BITS	8
+#define SOFTIRQ_BITS	8
+#define HARDIRQ_BITS	8
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+
+#define __MASK(x)	((1UL << (x))-1)
+
+#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
+#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+
+#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
+#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
+
+#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
+#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 
-#define in_irq() (local_irq_count(smp_processor_id()) != 0)
-
-#ifndef CONFIG_SMP
+/*
+ * The hardirq mask has to be large enough to have
+ * space for potentially all IRQ sources in the system
+ * nesting on a single CPU:
+ */
+#if (1 << HARDIRQ_BITS) < NR_IRQS
+#error HARDIRQ_BITS is too low!
+#endif
 
-extern unsigned long __irq_attempt[];
-#define irq_attempt(cpu, irq)  ((void)(cpu), __irq_attempt[irq])
+/*
+ * Are we doing bottom half or hardware interrupt processing?
+ * Are we in a softirq context? Interrupt context?
+ */
+#define in_irq()		(hardirq_count())
+#define in_softirq()		(softirq_count())
+#define in_interrupt()		(irq_count())
 
-#define hardirq_trylock(cpu)	(local_irq_count(cpu) == 0)
-#define hardirq_endlock(cpu)	((void) 0)
 
-#define irq_enter(cpu, irq)	(local_irq_count(cpu)++)
-#define irq_exit(cpu, irq)	(local_irq_count(cpu)--)
+#define hardirq_trylock()	(!in_interrupt())
+#define hardirq_endlock()	do { } while (0)
 
-#define synchronize_irq()	barrier()
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
+#if CONFIG_PREEMPT
+# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
+#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+# endif
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() &&				\
+		    softirq_pending(smp_processor_id()))	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
+} while (0)
 
-#define irq_attempt(cpu, irq) (cpu_data[cpu].irq_attempt[irq])
-
-#include <asm/atomic.h>
-#include <linux/spinlock.h>
-#include <asm/smp.h>
-
-extern int global_irq_holder;
-extern spinlock_t global_irq_lock;
-
-static inline int irqs_running (void)
-{
-	int i;
-
-	for (i = 0; i < smp_num_cpus; i++)
-		if (local_irq_count(i))
-			return 1;
-	return 0;
-}
-
-static inline void release_irqlock(int cpu)
-{
-	/* if we didn't own the irq lock, just ignore.. */
-	if (global_irq_holder == cpu) {
-		global_irq_holder = NO_PROC_ID;
-		spin_unlock(&global_irq_lock);
-        }
-}
-
-static inline void irq_enter(int cpu, int irq)
-{
-	++local_irq_count(cpu);
-
-	while (spin_is_locked(&global_irq_lock))
-		barrier();
-}
-
-static inline void irq_exit(int cpu, int irq)
-{
-        --local_irq_count(cpu);
-}
-
-static inline int hardirq_trylock(int cpu)
-{
-	return !local_irq_count(cpu) && !spin_is_locked(&global_irq_lock);
-}
-
-#define hardirq_endlock(cpu)	do { } while (0)
-
-extern void synchronize_irq(void);
-
+#ifndef CONFIG_SMP
+# define synchronize_irq(irq)	barrier()
+#else
+  extern void synchronize_irq(unsigned int irq);
 #endif /* CONFIG_SMP */
+
 #endif /* _ALPHA_HARDIRQ_H */
--- 2.5.28/include/asm-alpha/mmu_context.h	Thu Jul 25 01:03:28 2002
+++ linux/include/asm-alpha/mmu_context.h	Thu Jul 25 15:28:26 2002
@@ -227,8 +227,9 @@ init_new_context(struct task_struct *tsk
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		mm->context[cpu_logical_map(i)] = 0;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			mm->context[i] = 0;
         tsk->thread_info->pcb.ptbr
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 	return 0;
--- 2.5.28/include/asm-alpha/smp.h	Thu Jul 25 01:03:25 2002
+++ linux/include/asm-alpha/smp.h	Thu Jul 25 18:52:38 2002
@@ -30,7 +30,6 @@ struct cpuinfo_alpha {
 	int need_new_asn;
 	int asn_lock;
 	unsigned long ipi_count;
-	unsigned long irq_attempt[NR_IRQS];
 	unsigned long prof_multiplier;
 	unsigned long prof_counter;
 	unsigned char mcheck_expected;
@@ -41,15 +40,6 @@ struct cpuinfo_alpha {
 extern struct cpuinfo_alpha cpu_data[NR_CPUS];
 
 #define PROC_CHANGE_PENALTY     20
-
-/* Map from cpu id to sequential logical cpu number.  This will only
-   not be idempotent when cpus failed to come on-line.  */
-extern int __cpu_number_map[NR_CPUS];
-#define cpu_number_map(cpu)  __cpu_number_map[cpu]
-
-/* The reverse map from sequential logical cpu number to cpu id.  */
-extern int __cpu_logical_map[NR_CPUS];
-#define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
 
 #define hard_smp_processor_id()	__hard_smp_processor_id()
 #define smp_processor_id()	(current_thread_info()->cpu)
--- 2.5.28/include/asm-alpha/system.h	Thu Jul 25 01:03:29 2002
+++ linux/include/asm-alpha/system.h	Thu Jul 25 17:18:12 2002
@@ -130,8 +130,10 @@ struct el_common_EV6_mcheck {
 extern void halt(void) __attribute__((noreturn));
 #define __halt() __asm__ __volatile__ ("call_pal %0 #halt" : : "i" (PAL_halt))
 
-#define prepare_to_switch()	do { } while(0)
-#define switch_to(prev,next)						  \
+#define prepare_arch_schedule(prev)		do { } while(0)
+#define finish_arch_schedule(prev)		do { } while(0)
+
+#define switch_to(prev,next,last)						  \
 do {									  \
 	alpha_switch_to(virt_to_phys(&(next)->thread_info->pcb), (prev)); \
 	check_mmu_context();						  \
--- 2.5.28/include/asm-alpha/softirq.h	Thu Jul 25 01:03:24 2002
+++ linux/include/asm-alpha/softirq.h	Thu Jul 25 15:51:13 2002
@@ -1,35 +1,21 @@
 #ifndef _ALPHA_SOFTIRQ_H
 #define _ALPHA_SOFTIRQ_H
 
-#include <linux/stddef.h>
-#include <asm/atomic.h>
+#include <linux/preempt.h>
 #include <asm/hardirq.h>
 
-extern inline void cpu_bh_disable(int cpu)
-{
-	local_bh_count(cpu)++;
-	barrier();
-}
-
-extern inline void __cpu_bh_enable(int cpu)
-{
-	barrier();
-	local_bh_count(cpu)--;
-}
-
-#define __local_bh_enable()	__cpu_bh_enable(smp_processor_id())
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
+#define local_bh_disable() \
+		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
+#define __local_bh_enable() \
+		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
 
 #define local_bh_enable()					\
 do {								\
-	int cpu;						\
-								\
-	barrier();						\
-	cpu = smp_processor_id();				\
-	if (!--local_bh_count(cpu) && softirq_pending(cpu))	\
+	__local_bh_enable();					\
+	if (unlikely(!in_interrupt() &&				\
+		     softirq_pending(smp_processor_id())))	\
 		do_softirq();					\
+	preempt_check_resched();				\
 } while (0)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
 #endif /* _ALPHA_SOFTIRQ_H */
--- 2.5.28/include/asm-alpha/pgalloc.h	Thu Jul 25 17:24:12 2002
+++ linux/include/asm-alpha/pgalloc.h	Thu Jul 25 17:24:17 2002
@@ -2,6 +2,7 @@
 #define _ALPHA_PGALLOC_H
 
 #include <linux/config.h>
+#include <linux/mm.h>
 
 /*      
  * Allocate and free page tables. The xxx_kernel() versions are
--- 2.5.28/include/asm-alpha/param.h	Thu Jul 25 01:03:26 2002
+++ linux/include/asm-alpha/param.h	Thu Jul 25 17:26:59 2002
@@ -15,6 +15,8 @@
 # endif
 #endif
 
+#define USER_HZ		HZ
+
 #define EXEC_PAGESIZE	8192
 
 #ifndef NGROUPS
--- 2.5.28/arch/alpha/lib/stxcpy.S	Thu Jul 25 01:03:22 2002
+++ linux/arch/alpha/lib/stxcpy.S	Thu Jul 25 15:28:26 2002
@@ -20,7 +20,7 @@
  * Furthermore, v0, a3-a5, t11, and t12 are untouched.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.28/arch/alpha/lib/ev6-stxcpy.S	Thu Jul 25 01:03:17 2002
+++ linux/arch/alpha/lib/ev6-stxcpy.S	Thu Jul 25 15:28:26 2002
@@ -30,7 +30,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.28/arch/alpha/lib/ev6-stxncpy.S	Thu Jul 25 01:03:31 2002
+++ linux/arch/alpha/lib/ev6-stxncpy.S	Thu Jul 25 15:28:26 2002
@@ -38,7 +38,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.28/arch/alpha/lib/strncpy_from_user.S	Thu Jul 25 01:03:19 2002
+++ linux/arch/alpha/lib/strncpy_from_user.S	Thu Jul 25 15:28:26 2002
@@ -12,7 +12,7 @@
 
 
 #include <asm/errno.h>
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.28/arch/alpha/lib/stxncpy.S	Thu Jul 25 01:03:32 2002
+++ linux/arch/alpha/lib/stxncpy.S	Thu Jul 25 15:28:26 2002
@@ -28,7 +28,7 @@
  * Furthermore, v0, a3-a5, t11, t12, and $at are untouched.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.28/arch/alpha/lib/ev67-strlen_user.S	Thu Jul 25 01:03:27 2002
+++ linux/arch/alpha/lib/ev67-strlen_user.S	Thu Jul 25 15:28:26 2002
@@ -23,7 +23,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.28/arch/alpha/lib/strchr.S	Thu Jul 25 01:03:27 2002
+++ linux/arch/alpha/lib/strchr.S	Thu Jul 25 15:28:26 2002
@@ -6,7 +6,7 @@
  * string, or null if it is not found.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.28/arch/alpha/lib/strlen_user.S	Thu Jul 25 01:03:28 2002
+++ linux/arch/alpha/lib/strlen_user.S	Thu Jul 25 15:28:26 2002
@@ -12,7 +12,7 @@
  * boundary when doing so.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.28/arch/alpha/lib/ev67-strrchr.S	Thu Jul 25 01:03:28 2002
+++ linux/arch/alpha/lib/ev67-strrchr.S	Thu Jul 25 15:28:26 2002
@@ -19,7 +19,7 @@
  */
 
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.28/arch/alpha/lib/ev67-strchr.S	Thu Jul 25 01:03:29 2002
+++ linux/arch/alpha/lib/ev67-strchr.S	Thu Jul 25 15:28:26 2002
@@ -16,7 +16,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.28/arch/alpha/lib/strrchr.S	Thu Jul 25 01:03:31 2002
+++ linux/arch/alpha/lib/strrchr.S	Thu Jul 25 15:28:26 2002
@@ -6,7 +6,7 @@
  * within a null-terminated string, or null if it is not found.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.28/arch/alpha/lib/ev6-strncpy_from_user.S	Thu Jul 25 01:03:32 2002
+++ linux/arch/alpha/lib/ev6-strncpy_from_user.S	Thu Jul 25 15:28:26 2002
@@ -27,7 +27,7 @@
 
 
 #include <asm/errno.h>
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.28/arch/alpha/kernel/pci.c	Thu Jul 25 01:03:19 2002
+++ linux/arch/alpha/kernel/pci.c	Thu Jul 25 15:28:26 2002
@@ -190,12 +190,12 @@ pcibios_align_resource(void *data, struc
 #undef MB
 #undef GB
 
-static void __init
+static int __init
 pcibios_init(void)
 {
-	if (!alpha_mv.init_pci)
-		return;
-	alpha_mv.init_pci();
+	if (alpha_mv.init_pci)
+		alpha_mv.init_pci();
+	return 0;
 }
 
 subsys_initcall(pcibios_init);
--- 2.5.28/arch/alpha/kernel/signal.c	Thu Jul 25 01:03:27 2002
+++ linux/arch/alpha/kernel/signal.c	Thu Jul 25 15:28:26 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- 2.5.28/arch/alpha/kernel/osf_sys.c	Thu Jul 25 01:03:17 2002
+++ linux/arch/alpha/kernel/osf_sys.c	Thu Jul 25 18:19:46 2002
@@ -33,6 +33,7 @@
 #include <linux/file.h>
 #include <linux/types.h>
 #include <linux/ipc.h>
+#include <linux/namei.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
@@ -956,6 +957,13 @@ static inline long put_it32(struct itime
 		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
 }
 
+static inline void
+jiffies_to_timeval32(unsigned long jiffies, struct timeval32 *value)
+{
+	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
+	value->tv_sec = jiffies / HZ;
+}
+
 asmlinkage int osf_gettimeofday(struct timeval32 *tv, struct timezone *tz)
 {
 	if (tv) {
@@ -1163,32 +1171,24 @@ asmlinkage int osf_getrusage(int who, st
 	memset(&r, 0, sizeof(r));
 	switch (who) {
 	case RUSAGE_SELF:
-		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_utime);
-		r.ru_utime.tv_usec = CT_TO_USECS(current->times.tms_utime);
-		r.ru_stime.tv_sec = CT_TO_SECS(current->times.tms_stime);
-		r.ru_stime.tv_usec = CT_TO_USECS(current->times.tms_stime);
+		jiffies_to_timeval32(current->utime, &r.ru_utime);
+		jiffies_to_timeval32(current->stime, &r.ru_stime);
 		r.ru_minflt = current->min_flt;
 		r.ru_majflt = current->maj_flt;
 		r.ru_nswap = current->nswap;
 		break;
 	case RUSAGE_CHILDREN:
-		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_cutime);
-		r.ru_utime.tv_usec = CT_TO_USECS(current->times.tms_cutime);
-		r.ru_stime.tv_sec = CT_TO_SECS(current->times.tms_cstime);
-		r.ru_stime.tv_usec = CT_TO_USECS(current->times.tms_cstime);
+		jiffies_to_timeval32(current->cutime, &r.ru_utime);
+		jiffies_to_timeval32(current->cstime, &r.ru_stime);
 		r.ru_minflt = current->cmin_flt;
 		r.ru_majflt = current->cmaj_flt;
 		r.ru_nswap = current->cnswap;
 		break;
 	default:
-		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_utime +
-					       current->times.tms_cutime);
-		r.ru_utime.tv_usec = CT_TO_USECS(current->times.tms_utime +
-						 current->times.tms_cutime);
-		r.ru_stime.tv_sec = CT_TO_SECS(current->times.tms_stime +
-					       current->times.tms_cstime);
-		r.ru_stime.tv_usec = CT_TO_USECS(current->times.tms_stime +
-						 current->times.tms_cstime);
+		jiffies_to_timeval32(current->utime + current->cutime,
+				   &r.ru_utime);
+		jiffies_to_timeval32(current->stime + current->cstime,
+				   &r.ru_stime);
 		r.ru_minflt = current->min_flt + current->cmin_flt;
 		r.ru_majflt = current->maj_flt + current->cmaj_flt;
 		r.ru_nswap = current->nswap + current->cnswap;
--- 2.5.28/arch/alpha/kernel/alpha_ksyms.c	Thu Jul 25 15:26:41 2002
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Thu Jul 25 15:28:26 2002
@@ -214,7 +214,6 @@ EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(smp_imb);
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(__cpu_number_map);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_call_function_on_cpu);
 EXPORT_SYMBOL(global_irq_holder);
--- 2.5.28/arch/alpha/kernel/setup.c	Thu Jul 25 15:26:41 2002
+++ linux/arch/alpha/kernel/setup.c	Thu Jul 25 15:28:26 2002
@@ -1118,7 +1118,7 @@ show_cpuinfo(struct seq_file *f, void *s
 #ifdef CONFIG_SMP
 	seq_printf(f, "cpus active\t\t: %d\n"
 		      "cpu active mask\t\t: %016lx\n",
-		       smp_num_cpus, cpu_present_mask);
+		       num_online_cpus(), cpu_present_mask);
 #endif
 
 	return 0;
--- 2.5.28/arch/alpha/kernel/irq_smp.c	Thu Jul 25 01:03:19 2002
+++ linux/arch/alpha/kernel/irq_smp.c	Thu Jul 25 15:38:52 2002
@@ -220,7 +220,7 @@ __global_restore_flags(unsigned long fla
 #define DEBUG_SYNCHRONIZE_IRQ 0
 
 void
-synchronize_irq(void)
+synchronize_irq(unsigned int irq)
 {
 #if 0
 	/* Joe's version.  */
--- 2.5.28/arch/alpha/kernel/irq.c	Thu Jul 25 01:03:30 2002
+++ linux/arch/alpha/kernel/irq.c	Thu Jul 25 19:05:09 2002
@@ -75,13 +75,7 @@ int
 handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 		 struct irqaction *action)
 {
-	int status;
-	int cpu = smp_processor_id();
-
-	kstat.irqs[cpu][irq]++;
-	irq_enter(cpu, irq);
-
-	status = 1;	/* Force the "do bottom halves" bit */
+	int status = 1;	/* Force the "do bottom halves" bit */
 
 	do {
 		if (!(action->flags & SA_INTERRUPT))
@@ -97,8 +91,6 @@ handle_IRQ_event(unsigned int irq, struc
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
-	irq_exit(cpu, irq);
-
 	return status;
 }
 
@@ -130,12 +122,7 @@ void
 disable_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-
-	if (!local_irq_count(smp_processor_id())) {
-		do {
-			barrier();
-		} while (irq_desc[irq].status & IRQ_INPROGRESS);
-	}
+	synchronize_irq(irq);
 }
 
 void
@@ -610,7 +597,8 @@ handle_irq(int irq, struct pt_regs * reg
 		return;
 	}
 
-	irq_attempt(cpu, irq)++;
+	irq_enter();
+	kstat.irqs[cpu][irq]++;
 	spin_lock_irq(&desc->lock); /* mask also the higher prio events */
 	desc->handler->ack(irq);
 	/*
@@ -669,8 +657,7 @@ out:
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
 
-	if (softirq_pending(cpu))
-		do_softirq();
+	irq_exit();
 }
 
 /*
@@ -702,7 +689,7 @@ probe_irq_on(void)
 
 	/* Wait for longstanding interrupts to trigger. */
 	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ synchronize_irq();
+		/* about 20ms delay */ synchronize_irq(0);
 
 	/* enable any unassigned irqs (we must startup again here because
 	   if a longstanding irq happened in the previous stage, it may have
@@ -723,7 +710,7 @@ probe_irq_on(void)
 	 * Wait for spurious interrupts to trigger
 	 */
 	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ synchronize_irq();
+		/* about 100ms delay */ synchronize_irq(0);
 
 	/*
 	 * Now filter out any obviously spurious interrupts
--- 2.5.28/arch/alpha/kernel/irq_alpha.c	Thu Jul 25 01:03:22 2002
+++ linux/arch/alpha/kernel/irq_alpha.c	Thu Jul 25 18:54:10 2002
@@ -14,10 +14,6 @@
 #include "proto.h"
 #include "irq_impl.h"
 
-#ifndef CONFIG_SMP
-unsigned long __irq_attempt[NR_IRQS];
-#endif
-
 /* Hack minimum IPL during interrupt processing for broken hardware.  */
 #ifdef CONFIG_ALPHA_BROKEN_IRQ_MASK
 int __min_ipl;
@@ -63,7 +59,6 @@ do_entInt(unsigned long type, unsigned l
 		smp_percpu_timer_interrupt(&regs);
 		cpu = smp_processor_id();
 		if (cpu != boot_cpuid) {
-		        irq_attempt(cpu, RTC_IRQ)++;
 		        kstat.irqs[cpu][RTC_IRQ]++;
 		} else {
 			handle_irq(RTC_IRQ, &regs);

--fdj2RfSjLxBAspz7--
