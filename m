Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161417AbWATAGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417AbWATAGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWATAGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:06:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42430 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161230AbWATAGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:06:47 -0500
Date: Thu, 19 Jan 2006 18:06:41 -0600 (CST)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
cc: jes@sgi.com, tony.luck@intel.com
Subject: [PATCH] SN2 user-MMIO CPU migration
Message-ID: <20060118163305.Y42462@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On SGI Altix, MMIO writes from separate CPUs to the same device are
not guaranteed to arrive at the device in order.  Tasks cannot migrate
between CPUs during kernel-context execution (e.g. in device driver
code), so all is well.

However, if a device aperture is memory-mapped into a user process
which performs writes directly to the device (e.g. DRM), then it is
possible for the following incorrect sequence of events to occur:

	Task on CPU A issues write "A" to device
	Task migrates to CPU B
	Task on CPU B issues write "B" to device
	Device receives write "B"
	Device receives write "A"

This patch introduces a new machvec to the IA64 code to be called
at the time of task migration.  This machvec is a no-op on non-SN2
machines, and waits for a Shub status register to indicate outstanding
IO writes have been accepted on SN2.

A hook has also been added to the scheduler task migration code to
invoke this behavior at appropriate points.  This hook is compiled
into nothingness on all configs other than the IA64 generic and SN2
kernels.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

 arch/ia64/sn/kernel/setup.c       |    4 ++--
 arch/ia64/sn/kernel/sn2/sn2_smp.c |   19 ++++++++++++++++++-
 include/asm-ia64/machvec.h        |   13 +++++++++++++
 include/asm-ia64/machvec_sn2.h    |    4 +++-
 include/asm-ia64/system.h         |    2 ++
 kernel/sched.c                    |    7 +++++++
 6 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index e510dce..8e40a2c 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1999,2001-2005 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1999,2001-2006 Silicon Graphics, Inc. All rights reserved.
  */
 
 #include <linux/config.h>
@@ -654,7 +654,7 @@ void __init sn_cpu_init(void)
 			SH2_PIO_WRITE_STATUS_1, SH2_PIO_WRITE_STATUS_3};
 		u64 *pio;
 		pio = is_shub1() ? pio1 : pio2;
-		pda->pio_write_status_addr = (volatile unsigned long *) LOCAL_MMR_ADDR(pio[slice]);
+		pda->pio_write_status_addr = (volatile unsigned long *) GLOBAL_MMR_ADDR(nasid, pio[slice]);
 		pda->pio_write_status_val = is_shub1() ? SH_PIO_WRITE_STATUS_PENDING_WRITE_COUNT_MASK : 0;
 	}
 
diff --git a/arch/ia64/sn/kernel/sn2/sn2_smp.c b/arch/ia64/sn/kernel/sn2/sn2_smp.c
index 471bbaa..647c20d 100644
--- a/arch/ia64/sn/kernel/sn2/sn2_smp.c
+++ b/arch/ia64/sn/kernel/sn2/sn2_smp.c
@@ -5,7 +5,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2000-2005 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2000-2006 Silicon Graphics, Inc. All rights reserved.
  */
 
 #include <linux/init.h>
@@ -169,6 +169,23 @@ static inline unsigned long wait_piowc(v
 	return ws;
 }
 
+void sn_task_migrate(struct task_struct *task) {
+	pda_t *old_pda = pdacpu(task_cpu(task));
+	volatile unsigned long *adr = old_pda->pio_write_status_addr;
+	unsigned long val = old_pda->pio_write_status_val;
+
+	/* Ensure user-mapped MMIO writes from old CPU have been accepted
+	 * by the IO hardware before resuming execution on the new CPU.
+	 * This is necessary as on SN2 PIO write ordering is not guaranteed
+	 * when the writes issue from seperate CPUs (well, technically Shubs).
+	 * Without this it is possible for a task to issue write "A" from one
+	 * CPU, context switch to another CPU, issue write "B", but have
+	 * the IO hardware receive the writes in the order "B" then "A".
+	 */
+	while ((*adr & SH_PIO_WRITE_STATUS_PENDING_WRITE_COUNT_MASK) != val)
+		cpu_relax();
+}
+
 void sn_tlb_migrate_finish(struct mm_struct *mm)
 {
 	if (mm == current->mm)
diff --git a/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
index ca5ea99..5fb312c 100644
--- a/include/asm-ia64/machvec.h
+++ b/include/asm-ia64/machvec.h
@@ -27,6 +27,7 @@ typedef void ia64_mv_irq_init_t (void);
 typedef void ia64_mv_send_ipi_t (int, int, int, int);
 typedef void ia64_mv_timer_interrupt_t (int, void *, struct pt_regs *);
 typedef void ia64_mv_global_tlb_purge_t (struct mm_struct *, unsigned long, unsigned long, unsigned long);
+typedef void ia64_mv_task_migrate_t (struct task_struct *);
 typedef void ia64_mv_tlb_migrate_finish_t (struct mm_struct *);
 typedef unsigned int ia64_mv_local_vector_to_irq (u8);
 typedef char *ia64_mv_pci_get_legacy_mem_t (struct pci_bus *);
@@ -85,10 +86,16 @@ machvec_noop_mm (struct mm_struct *mm)
 {
 }
 
+static inline void
+machvec_noop_task (struct task_struct *task)
+{
+}
+
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
 extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
 extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, int);
+extern void machvec_task_migrate (struct task_struct *);
 extern void machvec_tlb_migrate_finish (struct mm_struct *);
 
 # if defined (CONFIG_IA64_HP_SIM)
@@ -113,6 +120,7 @@ extern void machvec_tlb_migrate_finish (
 #  define platform_send_ipi	ia64_mv.send_ipi
 #  define platform_timer_interrupt	ia64_mv.timer_interrupt
 #  define platform_global_tlb_purge	ia64_mv.global_tlb_purge
+#  define platform_task_migrate		ia64_mv.task_migrate
 #  define platform_tlb_migrate_finish	ia64_mv.tlb_migrate_finish
 #  define platform_dma_init		ia64_mv.dma_init
 #  define platform_dma_alloc_coherent	ia64_mv.dma_alloc_coherent
@@ -161,6 +169,7 @@ struct ia64_machine_vector {
 	ia64_mv_send_ipi_t *send_ipi;
 	ia64_mv_timer_interrupt_t *timer_interrupt;
 	ia64_mv_global_tlb_purge_t *global_tlb_purge;
+	ia64_mv_task_migrate_t *task_migrate;
 	ia64_mv_tlb_migrate_finish_t *tlb_migrate_finish;
 	ia64_mv_dma_init *dma_init;
 	ia64_mv_dma_alloc_coherent *dma_alloc_coherent;
@@ -205,6 +214,7 @@ struct ia64_machine_vector {
 	platform_send_ipi,			\
 	platform_timer_interrupt,		\
 	platform_global_tlb_purge,		\
+	platform_task_migrate,			\
 	platform_tlb_migrate_finish,		\
 	platform_dma_init,			\
 	platform_dma_alloc_coherent,		\
@@ -287,6 +297,9 @@ extern ia64_mv_dma_supported		swiotlb_dm
 #ifndef platform_global_tlb_purge
 # define platform_global_tlb_purge	ia64_global_tlb_purge /* default to architected version */
 #endif
+#ifndef platform_task_migrate
+# define platform_task_migrate		machvec_noop_task
+#endif
 #ifndef platform_tlb_migrate_finish
 # define platform_tlb_migrate_finish	machvec_noop_mm
 #endif
diff --git a/include/asm-ia64/machvec_sn2.h b/include/asm-ia64/machvec_sn2.h
index e1b6cd6..c91fd03 100644
--- a/include/asm-ia64/machvec_sn2.h
+++ b/include/asm-ia64/machvec_sn2.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2002-2003 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2002-2006 Silicon Graphics, Inc.  All Rights Reserved.
  * 
  * This program is free software; you can redistribute it and/or modify it 
  * under the terms of version 2 of the GNU General Public License 
@@ -39,6 +39,7 @@ extern ia64_mv_irq_init_t sn_irq_init;
 extern ia64_mv_send_ipi_t sn2_send_IPI;
 extern ia64_mv_timer_interrupt_t sn_timer_interrupt;
 extern ia64_mv_global_tlb_purge_t sn2_global_tlb_purge;
+extern ia64_mv_task_migrate_t sn_task_migrate;
 extern ia64_mv_tlb_migrate_finish_t	sn_tlb_migrate_finish;
 extern ia64_mv_local_vector_to_irq sn_local_vector_to_irq;
 extern ia64_mv_pci_get_legacy_mem_t sn_pci_get_legacy_mem;
@@ -86,6 +87,7 @@ extern ia64_mv_dma_supported		sn_dma_sup
 #define platform_send_ipi		sn2_send_IPI
 #define platform_timer_interrupt	sn_timer_interrupt
 #define platform_global_tlb_purge       sn2_global_tlb_purge
+#define platform_task_migrate		sn_task_migrate
 #define platform_tlb_migrate_finish	sn_tlb_migrate_finish
 #define platform_pci_fixup		sn_pci_fixup
 #define platform_inb			__sn_inb
diff --git a/include/asm-ia64/system.h b/include/asm-ia64/system.h
index 80c5a23..47093c1 100644
--- a/include/asm-ia64/system.h
+++ b/include/asm-ia64/system.h
@@ -249,6 +249,8 @@ extern void ia64_load_extra (struct task
 # define switch_to(prev,next,last)	__switch_to(prev, next, last)
 #endif
 
+#define arch_task_migrate(task)	platform_task_migrate(task)
+
 /*
  * On IA-64, we don't want to hold the runqueue's lock during the low-level context-switch,
  * because that could cause a deadlock.  Here is an example by Erich Focht:
diff --git a/kernel/sched.c b/kernel/sched.c
index 788ecce..d8375c0 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -291,6 +291,9 @@ for (domain = rcu_dereference(cpu_rq(cpu
 #ifndef finish_arch_switch
 # define finish_arch_switch(prev)	do { } while (0)
 #endif
+#ifndef arch_task_migrate
+# define arch_task_migrate(task)	do { } while (0)
+#endif
 
 #ifndef __ARCH_WANT_UNLOCKED_CTXSW
 static inline int task_running(runqueue_t *rq, task_t *p)
@@ -936,6 +939,7 @@ static int migrate_task(task_t *p, int d
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
+		arch_task_migrate(p);
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -1353,6 +1357,7 @@ static int try_to_wake_up(task_t *p, uns
 out_set_cpu:
 	new_cpu = wake_idle(new_cpu, p);
 	if (new_cpu != cpu) {
+		arch_task_migrate(p);
 		set_task_cpu(p, new_cpu);
 		task_rq_unlock(rq, &flags);
 		/* might preempt at this point */
@@ -1876,6 +1881,7 @@ void pull_task(runqueue_t *src_rq, prio_
 {
 	dequeue_task(p, src_array);
 	dec_nr_running(p, src_rq);
+	arch_task_migrate(p);
 	set_task_cpu(p, this_cpu);
 	inc_nr_running(p, this_rq);
 	enqueue_task(p, this_array);
@@ -4547,6 +4553,7 @@ static void __migrate_task(struct task_s
 	if (!cpu_isset(dest_cpu, p->cpus_allowed))
 		goto out;
 
+	arch_task_migrate(p);
 	set_task_cpu(p, dest_cpu);
 	if (p->array) {
 		/*
