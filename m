Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUGBRkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUGBRkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUGBRkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:40:31 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:7405 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S264775AbUGBRkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:40:01 -0400
Date: Fri, 2 Jul 2004 12:39:05 -0500
From: Jack Steiner <steiner@sgi.com>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
Message-ID: <20040702173905.GA18884@sgi.com>
References: <20040623143844.GA15670@sgi.com> <20040623143318.07932255.akpm@osdl.org> <16605.1322.355489.223220@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16605.1322.355489.223220@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 10:10:02PM -0700, David Mosberger wrote:
> >>>>> On Wed, 23 Jun 2004 14:33:18 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   Andrew> Jack Steiner <steiner@sgi.com> wrote:
> 
>   >> This patch adds a platform specific hook to allow an arch-specific
>   >> function to be called after an explicit migration.
> 
>   Andrew> OK by me.  David, could you please merge this up?
> 
>   Andrew> Jack, please prepare an update for Documentation/cachetlb.txt.
> 
> Jack, could you send me an updated patch which has all the revisions requested?
> Also, my preference would be for tlb_migrate_finish() to be a true no-op
> (not a call to a no-op function) when compiling for a platform that
> doesn't need this hook.  Could you look into this?
> 
> Thanks,
> 
> 	--david


Here is the final patch. It should have all the requested changes.


For platforms that dont define their own tlb_migrate_finish, it is defined as :

	#define tlb_migrate_finish(mm) do {} while (0)

I'm not sure if I understood your point above. This is consistent with
other noop definitions (at least some of them) & should not generate any
code.




Signed-off-by: Jack Steiner <steiner@sgi.com>



diff -uprN linux_base/arch/ia64/kernel/machvec.c linux/arch/ia64/kernel/machvec.c
--- linux_base/arch/ia64/kernel/machvec.c	2004-07-02 12:28:17.000000000 -0500
+++ linux/arch/ia64/kernel/machvec.c	2004-07-02 12:31:01.000000000 -0500
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
diff -uprN linux_base/arch/ia64/sn/kernel/sn2/sn2_smp.c linux/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- linux_base/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-07-02 12:28:17.000000000 -0500
+++ linux/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-07-02 12:31:01.000000000 -0500
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
diff -uprN linux_base/Documentation/cachetlb.txt linux/Documentation/cachetlb.txt
--- linux_base/Documentation/cachetlb.txt	2004-07-02 12:28:16.000000000 -0500
+++ linux/Documentation/cachetlb.txt	2004-07-02 12:31:01.000000000 -0500
@@ -132,6 +132,17 @@ changes occur:
 	translations for software managed TLB configurations.
 	The sparc64 port currently does this.
 
+7) void tlb_migrate_finish(struct mm_struct *mm)
+
+	This interface is called at the end of an explicit
+	process migration. This interface provides a hook 
+	to allow a platform to update TLB or context-specific 
+	information for the address space.
+
+	The ia64 sn2 platform is one example of a platform
+	that uses this interface.
+
+
 Next, we have the cache flushing interfaces.  In general, when Linux
 is changing an existing virtual-->physical mapping to a new value,
 the sequence will be in one of the following forms:
diff -uprN linux_base/include/asm-generic/tlb.h linux/include/asm-generic/tlb.h
--- linux_base/include/asm-generic/tlb.h	2004-07-02 12:28:23.000000000 -0500
+++ linux/include/asm-generic/tlb.h	2004-07-02 12:31:01.000000000 -0500
@@ -146,4 +146,6 @@ static inline void tlb_remove_page(struc
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
+#define tlb_migrate_finish(mm) do {} while (0)
+
 #endif /* _ASM_GENERIC__TLB_H */
diff -uprN linux_base/include/asm-ia64/machvec.h linux/include/asm-ia64/machvec.h
--- linux_base/include/asm-ia64/machvec.h	2004-07-02 12:28:24.000000000 -0500
+++ linux/include/asm-ia64/machvec.h	2004-07-02 12:31:01.000000000 -0500
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
diff -uprN linux_base/include/asm-ia64/machvec_sn2.h linux/include/asm-ia64/machvec_sn2.h
--- linux_base/include/asm-ia64/machvec_sn2.h	2004-07-02 12:28:24.000000000 -0500
+++ linux/include/asm-ia64/machvec_sn2.h	2004-07-02 12:31:01.000000000 -0500
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
diff -uprN linux_base/include/asm-ia64/tlb.h linux/include/asm-ia64/tlb.h
--- linux_base/include/asm-ia64/tlb.h	2004-07-02 12:28:24.000000000 -0500
+++ linux/include/asm-ia64/tlb.h	2004-07-02 12:31:01.000000000 -0500
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
 
diff -uprN linux_base/kernel/sched.c linux/kernel/sched.c
--- linux_base/kernel/sched.c	2004-07-02 12:28:27.000000000 -0500
+++ linux/kernel/sched.c	2004-07-02 12:31:01.000000000 -0500
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


