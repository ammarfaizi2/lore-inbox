Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283754AbRLEEqR>; Tue, 4 Dec 2001 23:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283753AbRLEEqB>; Tue, 4 Dec 2001 23:46:01 -0500
Received: from [202.135.142.196] ([202.135.142.196]:21520 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S283751AbRLEEpy>;
	Tue, 4 Dec 2001 23:45:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.1-pre5 cacheline align cleanup
Date: Wed, 05 Dec 2001 15:45:43 +1100
Message-Id: <E16BTwF-0003IJ-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some confusing uses of the __cacheline_aligned macros.  This
cleans them up.

1) __cacheline_aligned should always be applied to variable
   definitions, as before,

2) __aligned_type should be applied to struct declarations.

3) __aligned_section can be applied to array declarations (which must
   be arrays of an __aligned_type type, of course).

And all of them vanish on SMP (if you want it on UP, do it manually).

Thanks,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/cache.h working-2.5.1-pre5-align/include/linux/cache.h
--- linux-2.5.1-pre5/include/linux/cache.h	Tue Dec  4 17:17:27 2001
+++ working-2.5.1-pre5-align/include/linux/cache.h	Wed Dec  5 12:09:08 2001
@@ -12,34 +12,25 @@
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 #endif
 
-#ifndef ____cacheline_aligned
-#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#endif
-
-#ifndef ____cacheline_aligned_in_smp
 #ifdef CONFIG_SMP
-#define ____cacheline_aligned_in_smp ____cacheline_aligned
-#else
-#define ____cacheline_aligned_in_smp
-#endif /* CONFIG_SMP */
-#endif
+/* Use this with types. */
+#define __aligned_type __attribute__((__aligned__(SMP_CACHE_BYTES)))
 
-#ifndef __cacheline_aligned
-#ifdef MODULE
-#define __cacheline_aligned ____cacheline_aligned
-#else
+#ifndef MODULE
+/* This with simple variables whose types are not aligned (not arrays!) */
 #define __cacheline_aligned					\
   __attribute__((__aligned__(SMP_CACHE_BYTES),			\
 		 __section__(".data.cacheline_aligned")))
-#endif
-#endif /* __cacheline_aligned */
-
-#ifndef __cacheline_aligned_in_smp
-#ifdef CONFIG_SMP
-#define __cacheline_aligned_in_smp __cacheline_aligned
+/* This is for variables whose types are declared __aligned_type */
+#define __aligned_section __attribute__((__section__(".data.cacheline_aligned")))
 #else
-#define __cacheline_aligned_in_smp
-#endif /* CONFIG_SMP */
-#endif
+#define __cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
+#define __aligned_section
+#endif /* MODULE */
+#else
+#define __aligned_type
+#define __cacheline_aligned
+#define __aligned_section
+#endif /* !CONFIG_SMP */
 
 #endif /* __LINUX_CACHE_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/alpha/kernel/irq.c working-2.5.1-pre5-align/arch/alpha/kernel/irq.c
--- linux-2.5.1-pre5/arch/alpha/kernel/irq.c	Tue Dec  4 17:17:18 2001
+++ working-2.5.1-pre5-align/arch/alpha/kernel/irq.c	Tue Dec  4 19:45:07 2001
@@ -33,7 +33,7 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
+irq_desc_t irq_desc[NR_IRQS] __aligned_section = {
 	[0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}
 };
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/alpha/kernel/smp.c working-2.5.1-pre5-align/arch/alpha/kernel/smp.c
--- linux-2.5.1-pre5/arch/alpha/kernel/smp.c	Tue Nov 27 16:53:27 2001
+++ working-2.5.1-pre5-align/arch/alpha/kernel/smp.c	Tue Dec  4 19:45:14 2001
@@ -56,8 +56,8 @@
 
 /* A collection of single bit ipi messages.  */
 static struct {
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+	unsigned long bits __aligned_type;
+} ipi_data[NR_CPUS] __aligned_section;
 
 enum ipi_message_type {
 	IPI_RESCHEDULE,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/i386/kernel/init_task.c working-2.5.1-pre5-align/arch/i386/kernel/init_task.c
--- linux-2.5.1-pre5/arch/i386/kernel/init_task.c	Tue Sep 18 08:29:09 2001
+++ working-2.5.1-pre5-align/arch/i386/kernel/init_task.c	Tue Dec  4 19:05:01 2001
@@ -29,5 +29,5 @@
  * section. Since TSS's are completely CPU-local, we want them
  * on exact cacheline boundaries, to eliminate cacheline ping-pong.
  */ 
-struct tss_struct init_tss[NR_CPUS] __cacheline_aligned = { [0 ... NR_CPUS-1] = INIT_TSS };
+struct tss_struct init_tss[NR_CPUS] __aligned_section = { [0 ... NR_CPUS-1] = INIT_TSS };
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/i386/kernel/irq.c working-2.5.1-pre5-align/arch/i386/kernel/irq.c
--- linux-2.5.1-pre5/arch/i386/kernel/irq.c	Tue Dec  4 17:17:18 2001
+++ working-2.5.1-pre5-align/arch/i386/kernel/irq.c	Tue Dec  4 19:04:08 2001
@@ -66,7 +66,7 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
+irq_desc_t irq_desc[NR_IRQS] __aligned_section =
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
 static void register_irq_proc (unsigned int irq);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/ia64/kernel/irq.c working-2.5.1-pre5-align/arch/ia64/kernel/irq.c
--- linux-2.5.1-pre5/arch/ia64/kernel/irq.c	Tue Dec  4 17:17:18 2001
+++ working-2.5.1-pre5-align/arch/ia64/kernel/irq.c	Tue Dec  4 19:46:01 2001
@@ -65,7 +65,7 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t _irq_desc[NR_IRQS] __cacheline_aligned =
+irq_desc_t _irq_desc[NR_IRQS] __aligned_section =
 	{ [0 ... NR_IRQS-1] = { IRQ_DISABLED, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
 static void register_irq_proc (unsigned int irq);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/ia64/kernel/perfmon.c working-2.5.1-pre5-align/arch/ia64/kernel/perfmon.c
--- linux-2.5.1-pre5/arch/ia64/kernel/perfmon.c	Tue Nov 27 16:53:28 2001
+++ working-2.5.1-pre5-align/arch/ia64/kernel/perfmon.c	Tue Dec  4 18:31:38 2001
@@ -276,7 +276,7 @@
 
 struct {
 	struct task_struct *owner;
-} ____cacheline_aligned pmu_owners[NR_CPUS];
+} __aligned_type pmu_owners[NR_CPUS];
 
 
 /* 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/mips/kernel/irq.c working-2.5.1-pre5-align/arch/mips/kernel/irq.c
--- linux-2.5.1-pre5/arch/mips/kernel/irq.c	Tue Dec  4 17:17:18 2001
+++ working-2.5.1-pre5-align/arch/mips/kernel/irq.c	Tue Dec  4 19:45:22 2001
@@ -24,7 +24,7 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
+irq_desc_t irq_desc[NR_IRQS] __aligned_section =
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/ppc/kernel/irq.c working-2.5.1-pre5-align/arch/ppc/kernel/irq.c
--- linux-2.5.1-pre5/arch/ppc/kernel/irq.c	Tue Dec  4 17:17:18 2001
+++ working-2.5.1-pre5-align/arch/ppc/kernel/irq.c	Tue Dec  4 19:45:30 2001
@@ -75,7 +75,7 @@
 
 #define MAXCOUNT 10000000
 
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
+irq_desc_t irq_desc[NR_IRQS] __aligned_section =
 	{ [0 ... NR_IRQS-1] = { 0, NULL, NULL, 0, SPIN_LOCK_UNLOCKED}};
 	
 int ppc_spurious_interrupts = 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/ppc/kernel/ppc_defs.h working-2.5.1-pre5-align/arch/ppc/kernel/ppc_defs.h
--- linux-2.5.1-pre5/arch/ppc/kernel/ppc_defs.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.1-pre5-align/arch/ppc/kernel/ppc_defs.h	Wed Dec  5 12:48:56 2001
@@ -0,0 +1,82 @@
+/*
+ * WARNING! This file is automatically generated - DO NOT EDIT!
+ */
+#define	STATE	0
+#define	NEXT_TASK	72
+#define	COUNTER	32
+#define	PROCESSOR	48
+#define	SIGPENDING	8
+#define	THREAD	624
+#define	MM	44
+#define	ACTIVE_MM	80
+#define	TASK_STRUCT_SIZE	1536
+#define	KSP	0
+#define	PGDIR	16
+#define	LAST_SYSCALL	20
+#define	PT_REGS	8
+#define	PT_TRACESYS	2
+#define	TASK_FLAGS	4
+#define	TASK_PTRACE	24
+#define	NEED_RESCHED	20
+#define	THREAD_FPR0	24
+#define	THREAD_FPSCR	284
+#define	THREAD_VR0	288
+#define	THREAD_VRSAVE	816
+#define	THREAD_VSCR	800
+#define	TASK_UNION_SIZE	8192
+#define	STACK_FRAME_OVERHEAD	16
+#define	INT_FRAME_SIZE	192
+#define	GPR0	16
+#define	GPR1	20
+#define	GPR2	24
+#define	GPR3	28
+#define	GPR4	32
+#define	GPR5	36
+#define	GPR6	40
+#define	GPR7	44
+#define	GPR8	48
+#define	GPR9	52
+#define	GPR10	56
+#define	GPR11	60
+#define	GPR12	64
+#define	GPR13	68
+#define	GPR14	72
+#define	GPR15	76
+#define	GPR16	80
+#define	GPR17	84
+#define	GPR18	88
+#define	GPR19	92
+#define	GPR20	96
+#define	GPR21	100
+#define	GPR22	104
+#define	GPR23	108
+#define	GPR24	112
+#define	GPR25	116
+#define	GPR26	120
+#define	GPR27	124
+#define	GPR28	128
+#define	GPR29	132
+#define	GPR30	136
+#define	GPR31	140
+#define	_NIP	144
+#define	_MSR	148
+#define	_CTR	156
+#define	_LINK	160
+#define	_CCR	168
+#define	_MQ	172
+#define	_XER	164
+#define	_DAR	180
+#define	_DSISR	184
+#define	_DEAR	180
+#define	_ESR	184
+#define	ORIG_GPR3	152
+#define	RESULT	188
+#define	TRAP	176
+#define	CLONE_VM	256
+#define	MM_PGD	12
+#define	CPU_SPEC_ENTRY_SIZE	32
+#define	CPU_SPEC_PVR_MASK	0
+#define	CPU_SPEC_PVR_VALUE	4
+#define	CPU_SPEC_FEATURES	12
+#define	CPU_SPEC_SETUP	28
+#define	NUM_USER_SEGMENTS	8
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/arch/sh/kernel/irq.c working-2.5.1-pre5-align/arch/sh/kernel/irq.c
--- linux-2.5.1-pre5/arch/sh/kernel/irq.c	Tue Dec  4 17:17:18 2001
+++ working-2.5.1-pre5-align/arch/sh/kernel/irq.c	Tue Dec  4 19:45:54 2001
@@ -40,7 +40,7 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
+irq_desc_t irq_desc[NR_IRQS] __aligned_section =
 				{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, }};
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/drivers/net/acenic.h working-2.5.1-pre5-align/drivers/net/acenic.h
--- linux-2.5.1-pre5/drivers/net/acenic.h	Tue Nov 27 16:53:30 2001
+++ working-2.5.1-pre5-align/drivers/net/acenic.h	Wed Dec  5 13:41:48 2001
@@ -647,7 +647,7 @@
 	 * RX elements
 	 */
 	unsigned long		std_refill_busy
-				__attribute__ ((aligned (SMP_CACHE_BYTES)));
+				__aligned_type;
 	unsigned long		mini_refill_busy, jumbo_refill_busy;
 	atomic_t		cur_rx_bufs;
 	atomic_t		cur_mini_bufs;
@@ -682,7 +682,7 @@
 	char			name[48];
 #ifdef INDEX_DEBUG
 	spinlock_t		debug_lock
-				__attribute__ ((aligned (SMP_CACHE_BYTES)));;
+				__aligned_type;
 	u32			last_tx, last_std_rx, last_mini_rx;
 #endif
 	struct net_device_stats stats;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/fs/block_dev.c working-2.5.1-pre5-align/fs/block_dev.c
--- linux-2.5.1-pre5/fs/block_dev.c	Tue Dec  4 17:17:26 2001
+++ working-2.5.1-pre5-align/fs/block_dev.c	Wed Dec  5 12:09:00 2001
@@ -234,7 +234,7 @@
 #define HASH_SIZE	(1UL << HASH_BITS)
 #define HASH_MASK	(HASH_SIZE-1)
 static struct list_head bdev_hashtable[HASH_SIZE];
-static spinlock_t bdev_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+static spinlock_t bdev_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t * bdev_cachep;
 
 #define alloc_bdev() \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/fs/buffer.c working-2.5.1-pre5-align/fs/buffer.c
--- linux-2.5.1-pre5/fs/buffer.c	Tue Dec  4 17:17:26 2001
+++ working-2.5.1-pre5-align/fs/buffer.c	Wed Dec  5 12:09:00 2001
@@ -74,7 +74,7 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+static spinlock_t lru_list_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/fs/dcache.c working-2.5.1-pre5-align/fs/dcache.c
--- linux-2.5.1-pre5/fs/dcache.c	Tue Dec  4 17:17:26 2001
+++ working-2.5.1-pre5-align/fs/dcache.c	Tue Dec  4 18:32:28 2001
@@ -29,7 +29,7 @@
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
 
-spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t dcache_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 
 /* Right now the dcache depends on the kernel lock */
 #define check_lock()	if (!kernel_locked()) BUG()
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-alpha/cache.h working-2.5.1-pre5-align/include/asm-alpha/cache.h
--- linux-2.5.1-pre5/include/asm-alpha/cache.h	Fri Oct  5 11:47:08 2001
+++ working-2.5.1-pre5-align/include/asm-alpha/cache.h	Wed Dec  5 13:36:26 2001
@@ -18,7 +18,4 @@
 # define L1_CACHE_SHIFT     5
 #endif
 
-#define L1_CACHE_ALIGN(x)  (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
-#define SMP_CACHE_BYTES    L1_CACHE_BYTES
-
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-alpha/hardirq.h working-2.5.1-pre5-align/include/asm-alpha/hardirq.h
--- linux-2.5.1-pre5/include/asm-alpha/hardirq.h	Tue Jul 10 07:47:39 2001
+++ working-2.5.1-pre5-align/include/asm-alpha/hardirq.h	Tue Dec  4 18:23:39 2001
@@ -11,7 +11,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-arm/cache.h working-2.5.1-pre5-align/include/asm-arm/cache.h
--- linux-2.5.1-pre5/include/asm-arm/cache.h	Tue Sep 19 09:15:23 2000
+++ working-2.5.1-pre5-align/include/asm-arm/cache.h	Tue Dec  4 18:39:02 2001
@@ -5,15 +5,4 @@
 #define __ASMARM_CACHE_H
 
 #define        L1_CACHE_BYTES  32
-#define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
-#define        SMP_CACHE_BYTES L1_CACHE_BYTES
-
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(L1_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
-
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-arm/hardirq.h working-2.5.1-pre5-align/include/asm-arm/hardirq.h
--- linux-2.5.1-pre5/include/asm-arm/hardirq.h	Fri Oct 12 02:04:57 2001
+++ working-2.5.1-pre5-align/include/asm-arm/hardirq.h	Tue Dec  4 18:25:41 2001
@@ -12,7 +12,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-cris/hardirq.h working-2.5.1-pre5-align/include/asm-cris/hardirq.h
--- linux-2.5.1-pre5/include/asm-cris/hardirq.h	Fri Jul 27 08:10:07 2001
+++ working-2.5.1-pre5-align/include/asm-cris/hardirq.h	Wed Dec  5 12:08:59 2001
@@ -12,7 +12,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h> /* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-i386/hardirq.h working-2.5.1-pre5-align/include/asm-i386/hardirq.h
--- linux-2.5.1-pre5/include/asm-i386/hardirq.h	Tue Nov 27 16:53:39 2001
+++ working-2.5.1-pre5-align/include/asm-i386/hardirq.h	Tue Dec  4 18:23:25 2001
@@ -13,7 +13,7 @@
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned int __nmi_count;	/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-i386/processor.h working-2.5.1-pre5-align/include/asm-i386/processor.h
--- linux-2.5.1-pre5/include/asm-i386/processor.h	Tue Nov 27 16:53:39 2001
+++ working-2.5.1-pre5-align/include/asm-i386/processor.h	Wed Dec  5 13:35:29 2001
@@ -53,7 +53,7 @@
 	unsigned long *pmd_quick;
 	unsigned long *pte_quick;
 	unsigned long pgtable_cache_sz;
-} __attribute__((__aligned__(SMP_CACHE_BYTES)));
+} __aligned_type;
 
 #define X86_VENDOR_INTEL 0
 #define X86_VENDOR_CYRIX 1
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-m68k/hardirq.h working-2.5.1-pre5-align/include/asm-m68k/hardirq.h
--- linux-2.5.1-pre5/include/asm-m68k/hardirq.h	Tue Nov  6 11:41:42 2001
+++ working-2.5.1-pre5-align/include/asm-m68k/hardirq.h	Tue Dec  4 18:23:44 2001
@@ -11,7 +11,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
         struct task_struct * __ksoftirqd_task;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-mips/cache.h working-2.5.1-pre5-align/include/asm-mips/cache.h
--- linux-2.5.1-pre5/include/asm-mips/cache.h	Tue Jul  3 06:56:40 2001
+++ working-2.5.1-pre5-align/include/asm-mips/cache.h	Wed Dec  5 13:35:50 2001
@@ -34,6 +34,4 @@
 #define L1_CACHE_BYTES 		32	/* A guess */
 #endif
 
-#define SMP_CACHE_BYTES		L1_CACHE_BYTES
-
 #endif /* _ASM_CACHE_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-mips/hardirq.h working-2.5.1-pre5-align/include/asm-mips/hardirq.h
--- linux-2.5.1-pre5/include/asm-mips/hardirq.h	Mon Sep 10 03:43:01 2001
+++ working-2.5.1-pre5-align/include/asm-mips/hardirq.h	Tue Dec  4 18:23:33 2001
@@ -21,7 +21,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task;	/* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-mips64/hardirq.h working-2.5.1-pre5-align/include/asm-mips64/hardirq.h
--- linux-2.5.1-pre5/include/asm-mips64/hardirq.h	Mon Sep 10 03:43:02 2001
+++ working-2.5.1-pre5-align/include/asm-mips64/hardirq.h	Tue Dec  4 18:26:27 2001
@@ -20,7 +20,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task;	/* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-parisc/cache.h working-2.5.1-pre5-align/include/asm-parisc/cache.h
--- linux-2.5.1-pre5/include/asm-parisc/cache.h	Thu Dec  7 06:46:39 2000
+++ working-2.5.1-pre5-align/include/asm-parisc/cache.h	Wed Dec  5 13:38:29 2001
@@ -31,12 +31,6 @@
 #define L1_CACHE_BYTES 32
 #endif
 
-#define L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
-
-#define SMP_CACHE_BYTES L1_CACHE_BYTES
-
-#define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
-
 extern void init_cache(void);		/* initializes cache-flushing */
 extern void flush_data_cache(void);	/* flushes data-cache only */
 extern void flush_instruction_cache(void);/* flushes code-cache only */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-parisc/hardirq.h working-2.5.1-pre5-align/include/asm-parisc/hardirq.h
--- linux-2.5.1-pre5/include/asm-parisc/hardirq.h	Wed Dec  6 07:29:39 2000
+++ working-2.5.1-pre5-align/include/asm-parisc/hardirq.h	Wed Dec  5 12:09:00 2001
@@ -16,7 +16,7 @@
 	unsigned int __local_irq_count;
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-ppc/cache.h working-2.5.1-pre5-align/include/asm-ppc/cache.h
--- linux-2.5.1-pre5/include/asm-ppc/cache.h	Fri Nov 30 20:57:34 2001
+++ working-2.5.1-pre5-align/include/asm-ppc/cache.h	Wed Dec  5 12:09:08 2001
@@ -27,18 +27,7 @@
 #endif
 
 #define	L1_CACHE_BYTES L1_CACHE_LINE_SIZE
-#define	SMP_CACHE_BYTES L1_CACHE_BYTES
-
-#define	L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define	L1_CACHE_PAGES		8
-
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(L1_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-ppc/hardirq.h working-2.5.1-pre5-align/include/asm-ppc/hardirq.h
--- linux-2.5.1-pre5/include/asm-ppc/hardirq.h	Fri Nov 30 20:57:34 2001
+++ working-2.5.1-pre5-align/include/asm-ppc/hardirq.h	Wed Dec  5 12:09:08 2001
@@ -21,7 +21,7 @@
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task;
 	unsigned int __last_jiffy_stamp;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-s390/hardirq.h working-2.5.1-pre5-align/include/asm-s390/hardirq.h
--- linux-2.5.1-pre5/include/asm-s390/hardirq.h	Thu Jul 26 07:12:02 2001
+++ working-2.5.1-pre5-align/include/asm-s390/hardirq.h	Wed Dec  5 12:09:00 2001
@@ -24,7 +24,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-s390/init.h working-2.5.1-pre5-align/include/asm-s390/init.h
--- linux-2.5.1-pre5/include/asm-s390/init.h	Thu Jul 26 07:12:02 2001
+++ working-2.5.1-pre5-align/include/asm-s390/init.h	Tue Dec  4 18:42:02 2001
@@ -22,8 +22,5 @@
 #define __FINIT .previous
 #define __INITDATA      .section        ".data.init",#alloc,#write
 */
-
-#define __cacheline_aligned __attribute__ ((__aligned__(256)))
-
 #endif
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-s390x/hardirq.h working-2.5.1-pre5-align/include/asm-s390x/hardirq.h
--- linux-2.5.1-pre5/include/asm-s390x/hardirq.h	Thu Jul 26 07:12:02 2001
+++ working-2.5.1-pre5-align/include/asm-s390x/hardirq.h	Wed Dec  5 12:08:59 2001
@@ -24,7 +24,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-s390x/init.h working-2.5.1-pre5-align/include/asm-s390x/init.h
--- linux-2.5.1-pre5/include/asm-s390x/init.h	Thu Jul 26 07:12:02 2001
+++ working-2.5.1-pre5-align/include/asm-s390x/init.h	Tue Dec  4 18:42:59 2001
@@ -23,7 +23,5 @@
 #define __INITDATA      .section        ".data.init",#alloc,#write
 */
 
-#define __cacheline_aligned __attribute__ ((__aligned__(256)))
-
 #endif
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-sh/hardirq.h working-2.5.1-pre5-align/include/asm-sh/hardirq.h
--- linux-2.5.1-pre5/include/asm-sh/hardirq.h	Sun Sep  9 05:29:09 2001
+++ working-2.5.1-pre5-align/include/asm-sh/hardirq.h	Tue Dec  4 18:26:19 2001
@@ -11,7 +11,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-sparc/cache.h working-2.5.1-pre5-align/include/asm-sparc/cache.h
--- linux-2.5.1-pre5/include/asm-sparc/cache.h	Wed Sep  1 04:23:30 1999
+++ working-2.5.1-pre5-align/include/asm-sparc/cache.h	Tue Dec  4 18:36:26 2001
@@ -11,17 +11,6 @@
 #include <asm/asi.h>
 
 #define L1_CACHE_BYTES 32
-#define L1_CACHE_ALIGN(x) ((((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1)))
-
-#define SMP_CACHE_BYTES 32
-
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(SMP_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
 
 /* Direct access to the instruction cache is provided through and
  * alternate address space.  The IDC bit must be off in the ICCR on
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-sparc/hardirq.h working-2.5.1-pre5-align/include/asm-sparc/hardirq.h
--- linux-2.5.1-pre5/include/asm-sparc/hardirq.h	Tue Jul 10 07:47:39 2001
+++ working-2.5.1-pre5-align/include/asm-sparc/hardirq.h	Tue Dec  4 18:23:50 2001
@@ -24,7 +24,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
         struct task_struct * __ksoftirqd_task;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 /* Note that local_irq_count() is replaced by sparc64 specific version for SMP */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-sparc64/cache.h working-2.5.1-pre5-align/include/asm-sparc64/cache.h
--- linux-2.5.1-pre5/include/asm-sparc64/cache.h	Thu Oct 18 07:16:39 2001
+++ working-2.5.1-pre5-align/include/asm-sparc64/cache.h	Tue Dec  4 18:39:09 2001
@@ -7,17 +7,7 @@
 /* bytes per L1 cache line */
 #define        L1_CACHE_BYTES		32 /* Two 16-byte sub-blocks per line. */
 
-#define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
-
 #define        SMP_CACHE_BYTES_SHIFT	6
 #define        SMP_CACHE_BYTES		(1 << SMP_CACHE_BYTES_SHIFT) /* L2 cache line size. */
-
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(SMP_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-sparc64/hardirq.h working-2.5.1-pre5-align/include/asm-sparc64/hardirq.h
--- linux-2.5.1-pre5/include/asm-sparc64/hardirq.h	Thu Oct 18 07:16:39 2001
+++ working-2.5.1-pre5-align/include/asm-sparc64/hardirq.h	Tue Dec  4 18:25:32 2001
@@ -24,7 +24,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
         struct task_struct * __ksoftirqd_task;
-} ____cacheline_aligned irq_cpustat_t;
+} __aligned_type irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 /* Note that local_irq_count() is replaced by sparc64 specific version for SMP */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/brlock.h working-2.5.1-pre5-align/include/linux/brlock.h
--- linux-2.5.1-pre5/include/linux/brlock.h	Wed Dec  5 12:09:29 2001
+++ working-2.5.1-pre5-align/include/linux/brlock.h	Wed Dec  5 13:34:57 2001
@@ -68,7 +68,7 @@
 #ifndef __BRLOCK_USE_ATOMICS
 struct br_wrlock {
 	spinlock_t lock;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
+} __aligned_type;
 
 extern struct br_wrlock __br_write_locks[__BR_IDX_MAX];
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/interrupt.h working-2.5.1-pre5-align/include/linux/interrupt.h
--- linux-2.5.1-pre5/include/linux/interrupt.h	Wed Dec  5 12:09:08 2001
+++ working-2.5.1-pre5-align/include/linux/interrupt.h	Wed Dec  5 13:25:55 2001
@@ -125,7 +125,7 @@
 struct tasklet_head
 {
 	struct tasklet_struct *list;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
+} __aligned_type;
 
 extern struct tasklet_head tasklet_vec[NR_CPUS];
 extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/irq.h working-2.5.1-pre5-align/include/linux/irq.h
--- linux-2.5.1-pre5/include/linux/irq.h	Fri Nov 30 21:10:04 2001
+++ working-2.5.1-pre5-align/include/linux/irq.h	Wed Dec  5 12:48:56 2001
@@ -62,7 +62,7 @@
 	struct irqaction *action;	/* IRQ action list */
 	unsigned int depth;		/* nested irq disables */
 	spinlock_t lock;
-} ____cacheline_aligned irq_desc_t;
+} __aligned_type irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/netdevice.h working-2.5.1-pre5-align/include/linux/netdevice.h
--- linux-2.5.1-pre5/include/linux/netdevice.h	Fri Nov 30 20:59:16 2001
+++ working-2.5.1-pre5-align/include/linux/netdevice.h	Wed Dec  5 13:34:29 2001
@@ -161,7 +161,7 @@
 	unsigned fastroute_deferred_out;
 	unsigned fastroute_latency_reduction;
 	unsigned cpu_collision;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
+} __aligned_type;
 
 extern struct netif_rx_stats netdev_rx_stat[];
 
@@ -478,7 +478,7 @@
 	struct sk_buff_head	input_pkt_queue;
 	struct net_device	*output_queue;
 	struct sk_buff		*completion_queue;
-} __attribute__((__aligned__(SMP_CACHE_BYTES)));
+} __aligned_type;
 
 
 extern struct softnet_data softnet_data[NR_CPUS];
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/net/route.h working-2.5.1-pre5-align/include/net/route.h
--- linux-2.5.1-pre5/include/net/route.h	Fri Nov 30 20:59:28 2001
+++ working-2.5.1-pre5-align/include/net/route.h	Wed Dec  5 12:41:21 2001
@@ -109,7 +109,7 @@
         unsigned int out_hit;
         unsigned int out_slow_tot;
         unsigned int out_slow_mc;
-} ____cacheline_aligned_in_smp;
+} __aligned_type;
 
 extern struct ip_rt_acct *ip_rt_acct;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/net/snmp.h working-2.5.1-pre5-align/include/net/snmp.h
--- linux-2.5.1-pre5/include/net/snmp.h	Fri Nov 30 20:59:28 2001
+++ working-2.5.1-pre5-align/include/net/snmp.h	Wed Dec  5 12:41:21 2001
@@ -62,7 +62,7 @@
  	unsigned long	IpFragFails;
  	unsigned long	IpFragCreates;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+} __aligned_type;
  
 struct ipv6_mib
 {
@@ -89,7 +89,7 @@
  	unsigned long	Ip6InMcastPkts;
  	unsigned long	Ip6OutMcastPkts;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+} __aligned_type;
  
 struct icmp_mib
 {
@@ -121,7 +121,7 @@
  	unsigned long	IcmpOutAddrMaskReps;
 	unsigned long	dummy;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+} __aligned_type;
 
 struct icmpv6_mib
 {
@@ -159,7 +159,7 @@
 	unsigned long	Icmp6OutGroupMembResponses;
 	unsigned long	Icmp6OutGroupMembReductions;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+} __aligned_type;
  
 struct tcp_mib
 {
@@ -178,7 +178,7 @@
  	unsigned long	TcpInErrs;
  	unsigned long	TcpOutRsts;
 	unsigned long   __pad[0]; 
-} ____cacheline_aligned;
+} __aligned_type;
  
 struct udp_mib
 {
@@ -187,7 +187,7 @@
  	unsigned long	UdpInErrors;
  	unsigned long	UdpOutDatagrams;
 	unsigned long   __pad[0];
-} ____cacheline_aligned; 
+} __aligned_type; 
 
 struct linux_mib 
 {
@@ -257,7 +257,7 @@
 	unsigned long	TCPAbortFailed;
 	unsigned long	TCPMemoryPressures;
 	unsigned long   __pad[0];
-} ____cacheline_aligned;
+} __aligned_type;
 
 
 /* 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/net/tcp.h working-2.5.1-pre5-align/include/net/tcp.h
--- linux-2.5.1-pre5/include/net/tcp.h	Wed Dec  5 12:41:21 2001
+++ working-2.5.1-pre5-align/include/net/tcp.h	Wed Dec  5 13:37:10 2001
@@ -117,8 +117,7 @@
 	 * Now align to a new cache line as all the following members
 	 * are often dirty.
 	 */
-	rwlock_t __tcp_lhash_lock
-		__attribute__((__aligned__(SMP_CACHE_BYTES)));
+	rwlock_t __tcp_lhash_lock __aligned_type;
 	atomic_t __tcp_lhash_users;
 	wait_queue_head_t __tcp_lhash_wait;
 	spinlock_t __tcp_portalloc_lock;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/kernel/fork.c working-2.5.1-pre5-align/kernel/fork.c
--- linux-2.5.1-pre5/kernel/fork.c	Tue Dec  4 17:17:28 2001
+++ working-2.5.1-pre5-align/kernel/fork.c	Tue Dec  4 18:32:59 2001
@@ -206,7 +206,7 @@
 	return retval;
 }
 
-spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t mmlist_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/kernel/ksyms.c working-2.5.1-pre5-align/kernel/ksyms.c
--- linux-2.5.1-pre5/kernel/ksyms.c	Tue Dec  4 17:17:28 2001
+++ working-2.5.1-pre5-align/kernel/ksyms.c	Wed Dec  5 12:10:43 2001
@@ -60,7 +60,6 @@
 extern void *sys_call_table;
 
 extern struct timezone sys_tz;
-extern int request_dma(unsigned int dmanr, char * deviceID);
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/kernel/sched.c working-2.5.1-pre5-align/kernel/sched.c
--- linux-2.5.1-pre5/kernel/sched.c	Tue Nov 27 16:53:42 2001
+++ working-2.5.1-pre5-align/kernel/sched.c	Wed Dec  5 13:27:21 2001
@@ -104,7 +104,7 @@
 		cycles_t last_schedule;
 	} schedule_data;
 	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
+} aligned_data [NR_CPUS] __aligned_section = { {{&init_task,0}}};
 
 #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/kernel/softirq.c working-2.5.1-pre5-align/kernel/softirq.c
--- linux-2.5.1-pre5/kernel/softirq.c	Tue Dec  4 17:17:28 2001
+++ working-2.5.1-pre5-align/kernel/softirq.c	Wed Dec  5 13:26:20 2001
@@ -42,7 +42,7 @@
 
 irq_cpustat_t irq_stat[NR_CPUS];
 
-static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
+static struct softirq_action softirq_vec[32] __cacheline_aligned;
 
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
@@ -145,9 +145,8 @@
 
 
 /* Tasklets */
-
-struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned_in_smp;
-struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned_in_smp;
+struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned;
+struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/mm/filemap.c working-2.5.1-pre5-align/mm/filemap.c
--- linux-2.5.1-pre5/mm/filemap.c	Tue Dec  4 17:17:28 2001
+++ working-2.5.1-pre5-align/mm/filemap.c	Tue Dec  4 18:35:04 2001
@@ -47,7 +47,7 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;
 
-spinlock_t pagecache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagecache_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
  *	with the pagecache_lock held.
@@ -57,7 +57,7 @@
  *		pagemap_lru_lock ->
  *			pagecache_lock
  */
-spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagemap_lru_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/net/core/dev.c working-2.5.1-pre5-align/net/core/dev.c
--- linux-2.5.1-pre5/net/core/dev.c	Tue Nov 27 16:53:43 2001
+++ working-2.5.1-pre5-align/net/core/dev.c	Tue Dec  4 19:03:25 2001
@@ -185,7 +185,7 @@
  *	Device drivers call our routines to queue packets here. We empty the
  *	queue in the local softnet handler.
  */
-struct softnet_data softnet_data[NR_CPUS] __cacheline_aligned;
+struct softnet_data softnet_data[NR_CPUS] __aligned_section;
 
 #ifdef CONFIG_NET_FASTROUTE
 int netdev_fastroute;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/net/ipv4/netfilter/ip_tables.c working-2.5.1-pre5-align/net/ipv4/netfilter/ip_tables.c
--- linux-2.5.1-pre5/net/ipv4/netfilter/ip_tables.c	Tue Nov  6 11:41:43 2001
+++ working-2.5.1-pre5-align/net/ipv4/netfilter/ip_tables.c	Wed Dec  5 13:40:53 2001
@@ -90,7 +90,7 @@
 	unsigned int underflow[NF_IP_NUMHOOKS];
 
 	/* ipt_entry tables: one per CPU */
-	char entries[0] __attribute__((aligned(SMP_CACHE_BYTES)));
+	char entries[0] __aligned_type;
 };
 
 static LIST_HEAD(ipt_target);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/net/socket.c working-2.5.1-pre5-align/net/socket.c
--- linux-2.5.1-pre5/net/socket.c	Thu Oct 18 07:38:28 2001
+++ working-2.5.1-pre5-align/net/socket.c	Tue Dec  4 19:03:39 2001
@@ -188,7 +188,7 @@
 static union {
 	int	counter;
 	char	__pad[SMP_CACHE_BYTES];
-} sockets_in_use[NR_CPUS] __cacheline_aligned = {{0}};
+} sockets_in_use[NR_CPUS] __aligned_section = {{0}};
 
 /*
  *	Support routines. Move socket addresses back and forth across the kernel/user

--
Premature optmztion is rt of all evl. --DK
