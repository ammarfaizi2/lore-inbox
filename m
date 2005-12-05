Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbVLEX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVLEX7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVLEX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:59:41 -0500
Received: from serv01.siteground.net ([70.85.91.68]:55767 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751482AbVLEX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:59:40 -0500
Date: Mon, 5 Dec 2005 15:59:26 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 1/2] Change maxaligned_in_smp alignemnt macros to internodealigned_in_smp macros
Message-ID: <20051205235926.GA3788@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
The following 2 patches changes maxaligned macros to internodealigned
macros, and kills L1_CACHE_SHIFT_MAX. Please consider for to -mm.

Thanks,
Kiran

---
 
____cacheline_maxaligned_in_smp is currently used to align critical
structures and avoid false sharing.  It uses per-arch L1_CACHE_SHIFT_MAX
and people find L1_CACHE_SHIFT_MAX useless.  

However, we have been using ____cacheline_maxaligned_in_smp to align
structures on the internode cacheline size.  As per Andi's suggestion,
following patch kills ____cacheline_maxaligned_in_smp and
introduces INTERNODE_CACHE_SHIFT, which defaults to L1_CACHE_SHIFT
for all arches.  Arches needing L3/Internode cacheline alignment
can define INTERNODE_CACHE_SHIFT in the arch asm/cache.h.
Patch replaces ____cacheline_maxaligned_in_smp with 
____cacheline_internodealigned_in_smp

With this patch, L1_CACHE_SHIFT_MAX can be killed

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Andi Kleen <ak@suse.de>


Index: linux-2.6.15-rc5mm1/arch/i386/kernel/init_task.c
===================================================================
--- linux-2.6.15-rc5mm1.orig/arch/i386/kernel/init_task.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc5mm1/arch/i386/kernel/init_task.c	2005-12-05 10:40:04.000000000 -0800
@@ -42,5 +42,5 @@
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
  * no more per-task TSS's.
  */ 
-DEFINE_PER_CPU(struct tss_struct, init_tss) ____cacheline_maxaligned_in_smp = INIT_TSS;
+DEFINE_PER_CPU(struct tss_struct, init_tss) ____cacheline_internodealigned_in_smp = INIT_TSS;
 
Index: linux-2.6.15-rc5mm1/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.15-rc5mm1.orig/arch/i386/kernel/irq.c	2005-12-05 10:29:31.000000000 -0800
+++ linux-2.6.15-rc5mm1/arch/i386/kernel/irq.c	2005-12-05 10:40:04.000000000 -0800
@@ -19,7 +19,7 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 
-DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
+DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_internodealigned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 #ifndef CONFIG_X86_LOCAL_APIC
Index: linux-2.6.15-rc5mm1/arch/x86_64/kernel/init_task.c
===================================================================
--- linux-2.6.15-rc5mm1.orig/arch/x86_64/kernel/init_task.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc5mm1/arch/x86_64/kernel/init_task.c	2005-12-05 10:40:04.000000000 -0800
@@ -44,6 +44,6 @@
  * section. Since TSS's are completely CPU-local, we want them
  * on exact cacheline boundaries, to eliminate cacheline ping-pong.
  */ 
-DEFINE_PER_CPU(struct tss_struct, init_tss) ____cacheline_maxaligned_in_smp = INIT_TSS;
+DEFINE_PER_CPU(struct tss_struct, init_tss) ____cacheline_internodealigned_in_smp = INIT_TSS;
 
 #define ALIGN_TO_4K __attribute__((section(".data.init_task")))
Index: linux-2.6.15-rc5mm1/include/linux/cache.h
===================================================================
--- linux-2.6.15-rc5mm1.orig/include/linux/cache.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc5mm1/include/linux/cache.h	2005-12-05 10:40:04.000000000 -0800
@@ -45,12 +45,21 @@
 #endif /* CONFIG_SMP */
 #endif
 
-#if !defined(____cacheline_maxaligned_in_smp)
+/* 
+ * The maximum alignment needed for some critical structures
+ * These could be inter-node cacheline sizes/L3 cacheline
+ * size etc.  Define this in asm/cache.h for your arch
+ */
+#ifndef INTERNODE_CACHE_SHIFT
+#define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
+#endif
+
+#if !defined(____cacheline_internodealigned_in_smp)
 #if defined(CONFIG_SMP)
-#define ____cacheline_maxaligned_in_smp \
-	__attribute__((__aligned__(1 << (L1_CACHE_SHIFT_MAX))))
+#define ____cacheline_internodealigned_in_smp \
+	__attribute__((__aligned__(1 << (INTERNODE_CACHE_SHIFT))))
 #else
-#define ____cacheline_maxaligned_in_smp
+#define ____cacheline_internodealigned_in_smp
 #endif
 #endif
 
Index: linux-2.6.15-rc5mm1/include/linux/ide.h
===================================================================
--- linux-2.6.15-rc5mm1.orig/include/linux/ide.h	2005-12-05 10:29:32.000000000 -0800
+++ linux-2.6.15-rc5mm1/include/linux/ide.h	2005-12-05 10:40:04.000000000 -0800
@@ -922,7 +922,7 @@
 	unsigned dma;
 
 	void (*led_act)(void *data, int rw);
-} ____cacheline_maxaligned_in_smp ide_hwif_t;
+} ____cacheline_internodealigned_in_smp ide_hwif_t;
 
 /*
  *  internal ide interrupt handler type
Index: linux-2.6.15-rc5mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5mm1.orig/include/linux/mmzone.h	2005-12-05 10:29:32.000000000 -0800
+++ linux-2.6.15-rc5mm1/include/linux/mmzone.h	2005-12-05 10:40:04.000000000 -0800
@@ -38,7 +38,7 @@
 #if defined(CONFIG_SMP)
 struct zone_padding {
 	char x[0];
-} ____cacheline_maxaligned_in_smp;
+} ____cacheline_internodealigned_in_smp;
 #define ZONE_PADDING(name)	struct zone_padding name;
 #else
 #define ZONE_PADDING(name)
@@ -233,7 +233,7 @@
 	 * rarely used fields:
 	 */
 	char			*name;
-} ____cacheline_maxaligned_in_smp;
+} ____cacheline_internodealigned_in_smp;
 
 
 /*
Index: linux-2.6.15-rc5mm1/include/linux/rcupdate.h
===================================================================
--- linux-2.6.15-rc5mm1.orig/include/linux/rcupdate.h	2005-12-05 10:29:32.000000000 -0800
+++ linux-2.6.15-rc5mm1/include/linux/rcupdate.h	2005-12-05 10:40:04.000000000 -0800
@@ -65,7 +65,7 @@
 	long	cur;		/* Current batch number.                      */
 	long	completed;	/* Number of the last completed batch         */
 	int	next_pending;	/* Is the next batch already waiting?         */
-} ____cacheline_maxaligned_in_smp;
+} ____cacheline_internodealigned_in_smp;
 
 /* Is batch a before batch b ? */
 static inline int rcu_batch_before(long a, long b)
Index: linux-2.6.15-rc5mm1/kernel/rcupdate.c
===================================================================
--- linux-2.6.15-rc5mm1.orig/kernel/rcupdate.c	2005-12-05 10:29:33.000000000 -0800
+++ linux-2.6.15-rc5mm1/kernel/rcupdate.c	2005-12-05 10:40:04.000000000 -0800
@@ -61,9 +61,9 @@
 	                              /* for current batch to proceed.        */
 };
 
-static struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
+static struct rcu_state rcu_state ____cacheline_internodealigned_in_smp =
 	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-static struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
+static struct rcu_state rcu_bh_state ____cacheline_internodealigned_in_smp =
 	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
 
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
Index: linux-2.6.15-rc5mm1/mm/sparse.c
===================================================================
--- linux-2.6.15-rc5mm1.orig/mm/sparse.c	2005-12-05 10:29:15.000000000 -0800
+++ linux-2.6.15-rc5mm1/mm/sparse.c	2005-12-05 10:40:04.000000000 -0800
@@ -18,10 +18,10 @@
  */
 #ifdef CONFIG_SPARSEMEM_EXTREME
 struct mem_section *mem_section[NR_SECTION_ROOTS]
-	____cacheline_maxaligned_in_smp;
+	____cacheline_internodealigned_in_smp;
 #else
 struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
-	____cacheline_maxaligned_in_smp;
+	____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
 
