Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUFWOlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUFWOlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUFWOlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:41:20 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:46306 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265157AbUFWOj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:39:26 -0400
Date: Wed, 23 Jun 2004 09:38:44 -0500
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] - Reduce TLB flushing during process migration
Message-ID: <20040623143844.GA15670@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The SGI NUMA platform does not use the hardware "ptc" instruction
to flush TLBs. Instead, it has to write an MMR on the chipset on each
node to cause a TLB flush transaction to be placed on the bus. On
large systems, the overhead to broadcast the TLB flush to many nodes
in the system is one of the hot spots in the kernel.

This patch adds a platform specific hook to allow an arch-specific
function to be called after an explicit migration. On SN2, we use this
callout to force a new context to be assigned. This reduces the
number of cross-node ptc flushes that are needed. Note that this
patch adds to a previous patch (already in the tree) that uses 
cpu_vm_mask (on SN2) to track the nodes where a VM context has been 
loaded. Forcing a new context causes the cpu_vm_mask to be cleared.

I dont have a benchmark for JUST the scheduler change, but the entire
cpu_vm_mask + sched change is:

        nwchem (siosi7.sale.xx-shm1cs) on a 128p showed:

          Before:
             56p = Time after atomic energies summed:   140.2
            120p = Time after atomic energies summed:   306.9

          After:
             56p = Time after atomic energies summed:    99.3
            120p = Time after atomic energies summed:   110.4

          Almost 3X improvement on 120p.


Note that the amount of improvement is HIGHLY application & 
platform specific.



This patch was originally posted earlier this year. This version incorporates
improvements suggested by Andrew Morten & David Mosberger.


Signed-off-by: Jack Steiner <steiner@sgi.com>




diff -uprN linuxbase/arch/ia64/kernel/machvec.c linux/arch/ia64/kernel/machvec.c
--- linuxbase/arch/ia64/kernel/machvec.c	2004-05-21 20:47:20.000000000 -0500
+++ linux/arch/ia64/kernel/machvec.c	2004-06-22 15:04:06.000000000 -0500
@@ -62,6 +62,12 @@ machvec_timer_interrupt (int irq, void *
 EXPORT_SYMBOL(machvec_timer_interrupt);
 
 void
+machvec_tlb_migrate_finish (struct mm_struct *mm)
+{
+}
+EXPORT_SYMBOL(machvec_tlb_migrate_finish);
+
+void
 machvec_dma_sync_single (struct device *hwdev, dma_addr_t dma_handle, size_t size, int dir)
 {
 	mb();
diff -uprN linuxbase/arch/ia64/sn/kernel/sn2/sn2_smp.c linux/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- linuxbase/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-05-21 20:47:20.000000000 -0500
+++ linux/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-06-22 15:04:06.000000000 -0500
@@ -27,6 +27,7 @@
 #include <asm/delay.h>
 #include <asm/io.h>
 #include <asm/smp.h>
+#include <asm/tlb.h>
 #include <asm/numa.h>
 #include <asm/bitops.h>
 #include <asm/hw_irq.h>
@@ -60,6 +61,13 @@ wait_piowc(void)
 }
 
 
+void
+sn_tlb_migrate_finish(struct mm_struct *mm)
+{
+	if (mm == current->mm)
+		flush_tlb_mm(mm);
+}
+
 
 /**
  * sn2_global_tlb_purge - globally purge translation cache of virtual address range
@@ -114,6 +122,13 @@ sn2_global_tlb_purge (unsigned long star
 		return;
 	}
 
+	if (atomic_read(&mm->mm_users) == 1) {
+		flush_tlb_mm(mm);
+		preempt_enable();
+		return;
+	}
+
+
 	nix = 0;
 	for (cnode=find_first_bit(&nodes_flushed, NR_NODES); cnode < NR_NODES; 
 			cnode=find_next_bit(&nodes_flushed, NR_NODES, ++cnode))
diff -uprN linuxbase/include/asm-generic/tlb.h linux/include/asm-generic/tlb.h
--- linuxbase/include/asm-generic/tlb.h	2004-06-22 07:15:51.000000000 -0500
+++ linux/include/asm-generic/tlb.h	2004-06-22 15:04:06.000000000 -0500
@@ -147,4 +147,6 @@ static inline void tlb_remove_page(struc
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
+#define tlb_migrate_finish(mm) flush_tlb_mm(mm)
+
 #endif /* _ASM_GENERIC__TLB_H */
diff -uprN linuxbase/include/asm-ia64/machvec.h linux/include/asm-ia64/machvec.h
--- linuxbase/include/asm-ia64/machvec.h	2004-05-21 20:47:29.000000000 -0500
+++ linux/include/asm-ia64/machvec.h	2004-06-22 15:04:06.000000000 -0500
@@ -19,6 +19,7 @@ struct pt_regs;
 struct scatterlist;
 struct irq_desc;
 struct page;
+struct mm_struct;
 
 typedef void ia64_mv_setup_t (char **);
 typedef void ia64_mv_cpu_init_t (void);
@@ -26,6 +27,7 @@ typedef void ia64_mv_irq_init_t (void);
 typedef void ia64_mv_send_ipi_t (int, int, int, int);
 typedef void ia64_mv_timer_interrupt_t (int, void *, struct pt_regs *);
 typedef void ia64_mv_global_tlb_purge_t (unsigned long, unsigned long, unsigned long);
+typedef void ia64_mv_tlb_migrate_finish_t (struct mm_struct *);
 typedef struct irq_desc *ia64_mv_irq_desc (unsigned int);
 typedef u8 ia64_mv_irq_to_vector (u8);
 typedef unsigned int ia64_mv_local_vector_to_irq (u8 vector);
@@ -72,6 +74,7 @@ typedef unsigned long ia64_mv_readq_rela
 extern void machvec_noop (void);
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
+extern void machvec_tlb_migrate_finish (struct mm_struct *);
 extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
 extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, int);
 
@@ -95,6 +98,7 @@ extern void machvec_dma_sync_sg (struct 
 #  define platform_send_ipi	ia64_mv.send_ipi
 #  define platform_timer_interrupt	ia64_mv.timer_interrupt
 #  define platform_global_tlb_purge	ia64_mv.global_tlb_purge
+#  define platform_tlb_migrate_finish	ia64_mv.tlb_migrate_finish
 #  define platform_dma_init		ia64_mv.dma_init
 #  define platform_dma_alloc_coherent	ia64_mv.dma_alloc_coherent
 #  define platform_dma_free_coherent	ia64_mv.dma_free_coherent
@@ -140,6 +144,7 @@ struct ia64_machine_vector {
 	ia64_mv_send_ipi_t *send_ipi;
 	ia64_mv_timer_interrupt_t *timer_interrupt;
 	ia64_mv_global_tlb_purge_t *global_tlb_purge;
+	ia64_mv_tlb_migrate_finish_t *tlb_migrate_finish;
 	ia64_mv_dma_init *dma_init;
 	ia64_mv_dma_alloc_coherent *dma_alloc_coherent;
 	ia64_mv_dma_free_coherent *dma_free_coherent;
@@ -181,6 +186,7 @@ struct ia64_machine_vector {
 	platform_send_ipi,			\
 	platform_timer_interrupt,		\
 	platform_global_tlb_purge,		\
+	platform_tlb_migrate_finish,		\
 	platform_dma_init,			\
 	platform_dma_alloc_coherent,		\
 	platform_dma_free_coherent,		\
@@ -260,6 +266,9 @@ extern ia64_mv_dma_supported		swiotlb_dm
 #ifndef platform_global_tlb_purge
 # define platform_global_tlb_purge	ia64_global_tlb_purge /* default to architected version */
 #endif
+#ifndef platform_tlb_migrate_finish
+# define platform_tlb_migrate_finish machvec_tlb_migrate_finish
+#endif
 #ifndef platform_dma_init
 # define platform_dma_init		swiotlb_init
 #endif
diff -uprN linuxbase/include/asm-ia64/machvec_sn2.h linux/include/asm-ia64/machvec_sn2.h
--- linuxbase/include/asm-ia64/machvec_sn2.h	2004-05-21 20:47:29.000000000 -0500
+++ linux/include/asm-ia64/machvec_sn2.h	2004-06-22 15:04:06.000000000 -0500
@@ -39,6 +39,7 @@ extern ia64_mv_irq_init_t sn_irq_init;
 extern ia64_mv_send_ipi_t sn2_send_IPI;
 extern ia64_mv_timer_interrupt_t sn_timer_interrupt;
 extern ia64_mv_global_tlb_purge_t sn2_global_tlb_purge;
+extern ia64_mv_tlb_migrate_finish_t	sn_tlb_migrate_finish;
 extern ia64_mv_irq_desc sn_irq_desc;
 extern ia64_mv_irq_to_vector sn_irq_to_vector;
 extern ia64_mv_local_vector_to_irq sn_local_vector_to_irq;
@@ -83,6 +84,7 @@ extern ia64_mv_dma_supported		sn_dma_sup
 #define platform_send_ipi		sn2_send_IPI
 #define platform_timer_interrupt	sn_timer_interrupt
 #define platform_global_tlb_purge       sn2_global_tlb_purge
+#define platform_tlb_migrate_finish	sn_tlb_migrate_finish
 #define platform_pci_fixup		sn_pci_fixup
 #define platform_inb			__sn_inb
 #define platform_inw			__sn_inw
diff -uprN linuxbase/include/asm-ia64/tlb.h linux/include/asm-ia64/tlb.h
--- linuxbase/include/asm-ia64/tlb.h	2004-05-21 20:47:29.000000000 -0500
+++ linux/include/asm-ia64/tlb.h	2004-06-22 15:04:06.000000000 -0500
@@ -44,6 +44,7 @@
 #include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
+#include <asm/machvec.h>
 
 #ifdef CONFIG_SMP
 # define FREE_PTE_NR		2048
@@ -211,6 +212,8 @@ __tlb_remove_tlb_entry (struct mmu_gathe
 	tlb->end_addr = address + PAGE_SIZE;
 }
 
+#define tlb_migrate_finish(mm)	platform_tlb_migrate_finish(mm)
+
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
 
diff -uprN linuxbase/kernel/sched.c linux/kernel/sched.c
--- linuxbase/kernel/sched.c	2004-06-22 07:15:51.000000000 -0500
+++ linux/kernel/sched.c	2004-06-22 15:05:15.000000000 -0500
@@ -40,6 +40,7 @@
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 #include <linux/kthread.h>
+#include <asm/tlb.h>
 
 #include <asm/unistd.h>
 
@@ -3335,6 +3336,7 @@ int set_cpus_allowed(task_t *p, cpumask_
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
 		wait_for_completion(&req.done);
+		tlb_migrate_finish(p->mm);
 		return 0;
 	}
 out:
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


