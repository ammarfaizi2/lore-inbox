Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVCGWiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVCGWiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCGWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:37:17 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:65526 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261852AbVCGVsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:48:14 -0500
Date: Mon, 7 Mar 2005 13:48:08 -0800
From: Frank Rowand <frowand@mvista.com>
Message-Id: <200503072148.j27Lm81r006318@localhost.localdomain>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 1/5] ppc RT: ppc_rt.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Source: MontaVista Software, Inc.
Signed-off-by: Frank Rowand <frowand@mvista.com>

Index: linux-2.6.10/arch/ppc/Kconfig
===================================================================
--- linux-2.6.10.orig/arch/ppc/Kconfig
+++ linux-2.6.10/arch/ppc/Kconfig
@@ -17,9 +17,16 @@ config GENERIC_HARDIRQS
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
+	depends on !PREEMPT_RT
+
+config ASM_SEMAPHORES
+	bool
+	depends on !PREEMPT_RT
+	default y
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
+	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
 	default y
 
 config GENERIC_CALIBRATE_DELAY
@@ -862,15 +869,7 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
+source "lib/Kconfig.RT"
 
 config HIGHMEM
 	bool "High memory support"
Index: linux-2.6.10/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/smp.c
+++ linux-2.6.10/arch/ppc/kernel/smp.c
@@ -139,6 +139,11 @@ void smp_send_reschedule(int cpu)
 	smp_message_pass(cpu, PPC_MSG_RESCHEDULE, 0, 0);
 }
 
+void smp_send_reschedule_allbutself(void)
+{
+	smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_RESCHEDULE, 0, 0);
+}
+
 #ifdef CONFIG_XMON
 void smp_send_xmon_break(int cpu)
 {
@@ -163,7 +168,7 @@ void smp_send_stop(void)
  * static memory requirements. It also looks cleaner.
  * Stolen from the i386 version.
  */
-static DEFINE_SPINLOCK(call_lock);
+static DEFINE_RAW_SPINLOCK(call_lock);
 
 static struct call_data_struct {
 	void (*func) (void *info);
Index: linux-2.6.10/include/linux/rt_lock.h
===================================================================
--- linux-2.6.10.orig/include/linux/rt_lock.h
+++ linux-2.6.10/include/linux/rt_lock.h
@@ -13,8 +13,13 @@
 typedef struct {
 	volatile unsigned long lock;
 # ifdef CONFIG_DEBUG_SPINLOCK
+# ifdef CONFIG_PPC32
+	volatile unsigned long owner_pc;
+	volatile unsigned long owner_cpu;
+# else
 	unsigned int magic;
 # endif
+# endif
 # ifdef CONFIG_PREEMPT
 	unsigned int break_lock;
 # endif
@@ -33,7 +38,11 @@ typedef struct {
  */
 #ifdef CONFIG_SMP
 typedef struct {
+#ifdef CONFIG_PPC32
+	volatile signed int lock;
+#else
 	volatile unsigned long lock;
+#endif
 # ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 # endif
Index: linux-2.6.10/arch/ppc/syslib/cpm2_common.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/cpm2_common.c
+++ linux-2.6.10/arch/ppc/syslib/cpm2_common.c
@@ -115,7 +115,7 @@ cpm2_fastbrg(uint brg, uint rate, int di
 /*
  * dpalloc / dpfree bits.
  */
-static spinlock_t cpm_dpmem_lock;
+static raw_spinlock_t cpm_dpmem_lock;
 /* 16 blocks should be enough to satisfy all requests
  * until the memory subsystem goes up... */
 static rh_block_t cpm_boot_dpmem_rh_block[16];
Index: linux-2.6.10/arch/ppc/kernel/Makefile
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/Makefile
+++ linux-2.6.10/arch/ppc/kernel/Makefile
@@ -13,8 +13,9 @@ extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
-					semaphore.o syscalls.o setup.o \
+					syscalls.o setup.o \
 					cputable.o ppc_htab.o perfmon.o
+obj-$(CONFIG_ASM_SEMAPHORES)	+= semaphore.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
Index: linux-2.6.10/include/asm-ppc/rwsem.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/rwsem.h
+++ linux-2.6.10/include/asm-ppc/rwsem.h
@@ -25,7 +25,7 @@ struct rw_semaphore {
 #define RWSEM_WAITING_BIAS		(-0x00010000)
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
+	raw_spinlock_t		wait_lock;
 	struct list_head	wait_list;
 #if RWSEM_DEBUG
 	int			debug;
@@ -42,7 +42,7 @@ struct rw_semaphore {
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	{ RWSEM_UNLOCKED_VALUE, RAW_SPIN_LOCK_UNLOCKED, \
 	  LIST_HEAD_INIT((name).wait_list) \
 	  __RWSEM_DEBUG_INIT }
 
Index: linux-2.6.10/arch/ppc/lib/dec_and_lock.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/lib/dec_and_lock.c
+++ linux-2.6.10/arch/ppc/lib/dec_and_lock.c
@@ -19,7 +19,7 @@
  */
 
 #ifndef ATOMIC_DEC_AND_LOCK
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+int _atomic_dec_and_raw_spin_lock(atomic_t *atomic, raw_spinlock_t *lock)
 {
 	int counter;
 	int newcount;
@@ -35,12 +35,12 @@ int _atomic_dec_and_lock(atomic_t *atomi
 			return 0;
 	}
 
-	spin_lock(lock);
+	_raw_spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
-	spin_unlock(lock);
+	_raw_spin_unlock(lock);
 	return 0;
 }
 
-EXPORT_SYMBOL(_atomic_dec_and_lock);
+EXPORT_SYMBOL(_atomic_dec_and_raw_spin_lock);
 #endif /* ATOMIC_DEC_AND_LOCK */
Index: linux-2.6.10/arch/ppc/8260_io/enet.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/8260_io/enet.c
+++ linux-2.6.10/arch/ppc/8260_io/enet.c
@@ -116,7 +116,7 @@ struct scc_enet_private {
 	scc_t	*sccp;
 	struct	net_device_stats stats;
 	uint	tx_full;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 static int scc_enet_open(struct net_device *dev);
Index: linux-2.6.10/arch/ppc/syslib/prom.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/prom.c
+++ linux-2.6.10/arch/ppc/syslib/prom.c
@@ -1397,7 +1397,7 @@ print_properties(struct device_node *np)
 }
 #endif
 
-static DEFINE_SPINLOCK(rtas_lock);
+static DEFINE_RAW_SPINLOCK(rtas_lock);
 
 /* this can be called after setup -- Cort */
 int __openfirmware
Index: linux-2.6.10/include/asm-ppc/semaphore.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/semaphore.h
+++ linux-2.6.10/include/asm-ppc/semaphore.h
@@ -16,6 +16,10 @@
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_PREEMPT_RT
+# include <linux/rt_lock.h>
+#else
+
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <linux/wait.h>
@@ -106,6 +110,7 @@ extern inline void up(struct semaphore *
 		__up(sem);
 }
 
+#endif /* CONFIG_PREEMPT_RT */
 #endif /* __KERNEL__ */
 
 #endif /* !(_PPC_SEMAPHORE_H) */
Index: linux-2.6.10/arch/ppc/8260_io/fcc_enet.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/8260_io/fcc_enet.c
+++ linux-2.6.10/arch/ppc/8260_io/fcc_enet.c
@@ -322,7 +322,7 @@ struct fcc_enet_private {
 	volatile fcc_enet_t	*ep;
 	struct	net_device_stats stats;
 	uint	tx_full;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 #ifdef	CONFIG_USE_MDIO
 	uint	phy_id;
Index: linux-2.6.10/include/asm-ppc/ocp.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/ocp.h
+++ linux-2.6.10/include/asm-ppc/ocp.h
@@ -29,10 +29,10 @@
 #include <linux/config.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
+#include <linux/rwsem.h>
 
 #include <asm/mmu.h>
 #include <asm/ocp_ids.h>
-#include <asm/rwsem.h>
 #include <asm/semaphore.h>
 
 #ifdef CONFIG_PPC_OCP
Index: linux-2.6.10/arch/ppc/8xx_io/enet.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/8xx_io/enet.c
+++ linux-2.6.10/arch/ppc/8xx_io/enet.c
@@ -144,7 +144,7 @@ struct scc_enet_private {
 	unsigned char *rx_vaddr[RX_RING_SIZE];
 	struct	net_device_stats stats;
 	uint	tx_full;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 static int scc_enet_open(struct net_device *dev);
Index: linux-2.6.10/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/open_pic.c
+++ linux-2.6.10/arch/ppc/syslib/open_pic.c
@@ -531,7 +531,7 @@ void openpic_reset_processor_phys(u_int 
 }
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PM)
-static DEFINE_SPINLOCK(openpic_setup_lock);
+static DEFINE_RAW_SPINLOCK(openpic_setup_lock);
 #endif
 
 #ifdef CONFIG_SMP
Index: linux-2.6.10/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/pmac_feature.c
+++ linux-2.6.10/arch/ppc/platforms/pmac_feature.c
@@ -63,7 +63,7 @@ extern struct device_node *k2_skiplist[2
  * We use a single global lock to protect accesses. Each driver has
  * to take care of its own locking
  */
-static DEFINE_SPINLOCK(feature_lock  __pmacdata);
+static DEFINE_RAW_SPINLOCK(feature_lock  __pmacdata);
 
 #define LOCK(flags)	spin_lock_irqsave(&feature_lock, flags);
 #define UNLOCK(flags)	spin_unlock_irqrestore(&feature_lock, flags);
Index: linux-2.6.10/arch/ppc/8xx_io/commproc.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/8xx_io/commproc.c
+++ linux-2.6.10/arch/ppc/8xx_io/commproc.c
@@ -372,7 +372,7 @@ cpm_setbrg(uint brg, uint rate)
 /*
  * dpalloc / dpfree bits.
  */
-static spinlock_t cpm_dpmem_lock;
+static raw_spinlock_t cpm_dpmem_lock;
 /*
  * 16 blocks should be enough to satisfy all requests
  * until the memory subsystem goes up...
Index: linux-2.6.10/arch/ppc/syslib/open_pic2.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/open_pic2.c
+++ linux-2.6.10/arch/ppc/syslib/open_pic2.c
@@ -386,7 +386,7 @@ static void openpic2_set_spurious(u_int 
 			   vec);
 }
 
-static DEFINE_SPINLOCK(openpic2_setup_lock);
+static DEFINE_RAW_SPINLOCK(openpic2_setup_lock);
 
 /*
  *  Initialize a timer interrupt (and disable it)
Index: linux-2.6.10/arch/ppc/platforms/pmac_nvram.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/pmac_nvram.c
+++ linux-2.6.10/arch/ppc/platforms/pmac_nvram.c
@@ -80,7 +80,7 @@ static volatile unsigned char *nvram_dat
 static int nvram_mult, is_core_99;
 static int core99_bank = 0;
 static int nvram_partitions[3];
-static DEFINE_SPINLOCK(nv_lock);
+static DEFINE_RAW_SPINLOCK(nv_lock);
 
 extern int pmac_newworld;
 extern int system_running;
Index: linux-2.6.10/include/asm-ppc/tlb.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/tlb.h
+++ linux-2.6.10/include/asm-ppc/tlb.h
@@ -25,7 +25,11 @@ struct mmu_gather;
 extern void tlb_flush(struct mmu_gather *tlb);
 
 /* Get the generic bits... */
+#ifdef CONFIG_PREEMPT_RT
+#include <asm-generic/tlb-simple.h>
+#else
 #include <asm-generic/tlb.h>
+#endif
 
 /* Nothing needed here in fact... */
 #define tlb_start_vma(tlb, vma)	do { } while (0)
@@ -38,7 +42,7 @@ static inline void __tlb_remove_tlb_entr
 					unsigned long address)
 {
 	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(tlb->mm, ptep, address);
+		flush_hash_entry(tlb_mm(tlb), ptep, address);
 }
 
 #else
@@ -50,7 +54,11 @@ static inline void __tlb_remove_tlb_entr
 #define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
 
 /* Get the generic bits... */
+#ifdef CONFIG_PREEMPT_RT
+#include <asm-generic/tlb-simple.h>
+#else
 #include <asm-generic/tlb.h>
+#endif
 
 #endif /* CONFIG_PPC_STD_MMU */
 
Index: linux-2.6.10/arch/ppc/kernel/traps.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/traps.c
+++ linux-2.6.10/arch/ppc/kernel/traps.c
@@ -72,7 +72,7 @@ void (*debugger_fault_handler)(struct pt
  * Trap & Exception support
  */
 
-DEFINE_SPINLOCK(die_lock);
+DEFINE_RAW_SPINLOCK(die_lock);
 
 void die(const char * str, struct pt_regs * fp, long err)
 {
Index: linux-2.6.10/arch/ppc/platforms/sbc82xx.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/sbc82xx.c
+++ linux-2.6.10/arch/ppc/platforms/sbc82xx.c
@@ -68,7 +68,7 @@ static void sbc82xx_time_init(void)
 
 static volatile char *sbc82xx_i8259_map;
 static char sbc82xx_i8259_mask = 0xff;
-static DEFINE_SPINLOCK(sbc82xx_i8259_lock);
+static DEFINE_RAW_SPINLOCK(sbc82xx_i8259_lock);
 
 static void sbc82xx_i8259_mask_and_ack_irq(unsigned int irq_nr)
 {
Index: linux-2.6.10/arch/ppc/platforms/chrp_smp.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/chrp_smp.c
+++ linux-2.6.10/arch/ppc/platforms/chrp_smp.c
@@ -57,7 +57,7 @@ smp_chrp_setup_cpu(int cpu_nr)
 		do_openpic_setup_cpu();
 }
 
-static DEFINE_SPINLOCK(timebase_lock);
+static DEFINE_RAW_SPINLOCK(timebase_lock);
 static unsigned int timebase_upper = 0, timebase_lower = 0;
 
 void __devinit
Index: linux-2.6.10/include/asm-ppc/hw_irq.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/hw_irq.h
+++ linux-2.6.10/include/asm-ppc/hw_irq.h
@@ -13,6 +13,7 @@ extern void timer_interrupt(struct pt_re
 #define INLINE_IRQS
 
 #define irqs_disabled()	((mfmsr() & MSR_EE) == 0)
+#define irqs_disabled_flags(flags)	((flags & MSR_EE) == 0)
 
 #ifdef INLINE_IRQS
 
Index: linux-2.6.10/include/asm-ppc/spinlock.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/spinlock.h
+++ linux-2.6.10/include/asm-ppc/spinlock.h
@@ -7,17 +7,6 @@
  * Simple spin lock operations.
  */
 
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-	volatile unsigned long owner_cpu;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
 #ifdef __KERNEL__
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_DEBUG_INIT     , 0, 0
@@ -25,16 +14,18 @@ typedef struct {
 #define SPINLOCK_DEBUG_INIT     /* */
 #endif
 
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
+#define __RAW_SPIN_LOCK_UNLOCKED { 0 SPINLOCK_DEBUG_INIT }
+#define RAW_SPIN_LOCK_UNLOCKED   (raw_spinlock_t) __RAW_SPIN_LOCK_UNLOCKED
 
-#define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_lock_init(x)	do { *(x) = RAW_SPIN_LOCK_UNLOCKED; } while(0)
+#define __raw_spin_is_locked(x)	((x)->lock != 0)
+#define __raw_spin_unlock_wait(x) \
+		do { barrier(); } while(__raw_spin_is_locked(x))
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -55,48 +46,32 @@ static inline void _raw_spin_lock(spinlo
 	: "cr0", "memory");
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__("eieio		# spin_unlock": : :"memory");
 	lock->lock = 0;
 }
 
-#define _raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
+#define __raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
 
 #else
 
-extern void _raw_spin_lock(spinlock_t *lock);
-extern void _raw_spin_unlock(spinlock_t *lock);
-extern int _raw_spin_trylock(spinlock_t *lock);
+extern void __raw_spin_lock(raw_spinlock_t *lock);
+extern void __raw_spin_unlock(raw_spinlock_t *lock);
+extern int __raw_spin_trylock(raw_spinlock_t *lock);
 
 #endif
 
-/*
- * Read-write spinlocks, allowing multiple readers
- * but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts
- * but no interrupt writers. For those circumstances we
- * can "mix" irq-safe locks - any writer needs to get a
- * irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- */
-typedef struct {
-	volatile signed int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
+#define __RAW_RW_LOCK_UNLOCKED { 0 }
+#define RAW_RW_LOCK_UNLOCKED (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED
+#define __raw_rwlock_init(lp) do { *(lp) = RAW_RW_LOCK_UNLOCKED; } while(0)
 
-#define read_can_lock(rw)	((rw)->lock >= 0)
-#define write_can_lock(rw)	(!(rw)->lock)
+#define __raw_read_can_lock(rw)	((rw)->lock >= 0)
+#define __raw_write_can_lock(rw)	(!(rw)->lock)
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-static __inline__ int _raw_read_trylock(rwlock_t *rw)
+static __inline__ int __raw_read_trylock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -116,7 +91,7 @@ static __inline__ int _raw_read_trylock(
 	return tmp > 0;
 }
 
-static __inline__ void _raw_read_lock(rwlock_t *rw)
+static __inline__ void __raw_read_lock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -137,7 +112,7 @@ static __inline__ void _raw_read_lock(rw
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_read_unlock(rwlock_t *rw)
+static __inline__ void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -153,7 +128,7 @@ static __inline__ void _raw_read_unlock(
 	: "cr0", "memory");
 }
 
-static __inline__ int _raw_write_trylock(rwlock_t *rw)
+static __inline__ int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -173,7 +148,7 @@ static __inline__ int _raw_write_trylock
 	return tmp == 0;
 }
 
-static __inline__ void _raw_write_lock(rwlock_t *rw)
+static __inline__ void __raw_write_lock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -194,7 +169,7 @@ static __inline__ void _raw_write_lock(r
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_write_unlock(rwlock_t *rw)
+static __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
 	rw->lock = 0;
@@ -202,12 +177,12 @@ static __inline__ void _raw_write_unlock
 
 #else
 
-extern void _raw_read_lock(rwlock_t *rw);
-extern void _raw_read_unlock(rwlock_t *rw);
-extern void _raw_write_lock(rwlock_t *rw);
-extern void _raw_write_unlock(rwlock_t *rw);
-extern int _raw_read_trylock(rwlock_t *rw);
-extern int _raw_write_trylock(rwlock_t *rw);
+extern void __raw_read_lock(raw_rwlock_t *rw);
+extern void __raw_read_unlock(raw_rwlock_t *rw);
+extern void __raw_write_lock(raw_rwlock_t *rw);
+extern void __raw_write_unlock(raw_rwlock_t *rw);
+extern int __raw_read_trylock(raw_rwlock_t *rw);
+extern int __raw_write_trylock(raw_rwlock_t *rw);
 
 #endif
 
Index: linux-2.6.10/arch/ppc/8xx_io/fec.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/8xx_io/fec.c
+++ linux-2.6.10/arch/ppc/8xx_io/fec.c
@@ -165,7 +165,7 @@ struct fec_enet_private {
 
 	struct	net_device_stats stats;
 	uint	tx_full;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 #ifdef	CONFIG_USE_MDIO
 	uint	phy_id;
Index: linux-2.6.10/arch/ppc/lib/locks.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/lib/locks.c
+++ linux-2.6.10/arch/ppc/lib/locks.c
@@ -43,7 +43,7 @@ static inline unsigned long __spin_trylo
 	return ret;
 }
 
-void _raw_spin_lock(spinlock_t *lock)
+void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	int cpu = smp_processor_id();
 	unsigned int stuck = INIT_STUCK;
@@ -63,9 +63,9 @@ void _raw_spin_lock(spinlock_t *lock)
 	lock->owner_pc = (unsigned long)__builtin_return_address(0);
 	lock->owner_cpu = cpu;
 }
-EXPORT_SYMBOL(_raw_spin_lock);
+EXPORT_SYMBOL(__raw_spin_lock);
 
-int _raw_spin_trylock(spinlock_t *lock)
+int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	if (__spin_trylock(&lock->lock))
 		return 0;
@@ -73,9 +73,9 @@ int _raw_spin_trylock(spinlock_t *lock)
 	lock->owner_pc = (unsigned long)__builtin_return_address(0);
 	return 1;
 }
-EXPORT_SYMBOL(_raw_spin_trylock);
+EXPORT_SYMBOL(__raw_spin_trylock);
 
-void _raw_spin_unlock(spinlock_t *lp)
+void __raw_spin_unlock(raw_spinlock_t *lp)
 {
   	if ( !lp->lock )
 		printk("_spin_unlock(%p): no lock cpu %d curr PC %p %s/%d\n",
@@ -89,13 +89,13 @@ void _raw_spin_unlock(spinlock_t *lp)
 	wmb();
 	lp->lock = 0;
 }
-EXPORT_SYMBOL(_raw_spin_unlock);
+EXPORT_SYMBOL(__raw_spin_unlock);
 
 /*
  * For rwlocks, zero is unlocked, -1 is write-locked,
  * positive is read-locked.
  */
-static __inline__ int __read_trylock(rwlock_t *rw)
+static __inline__ int __read_trylock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -115,13 +115,13 @@ static __inline__ int __read_trylock(rwl
 	return tmp;
 }
 
-int _raw_read_trylock(rwlock_t *rw)
+int __raw_read_trylock(raw_rwlock_t *rw)
 {
 	return __read_trylock(rw) > 0;
 }
-EXPORT_SYMBOL(_raw_read_trylock);
+EXPORT_SYMBOL(__raw_read_trylock);
 
-void _raw_read_lock(rwlock_t *rw)
+void __raw_read_lock(rwlock_t *rw)
 {
 	unsigned int stuck;
 
@@ -136,9 +136,9 @@ void _raw_read_lock(rwlock_t *rw)
 		}
 	}
 }
-EXPORT_SYMBOL(_raw_read_lock);
+EXPORT_SYMBOL(__raw_read_lock);
 
-void _raw_read_unlock(rwlock_t *rw)
+void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	if ( rw->lock == 0 )
 		printk("_read_unlock(): %s/%d (nip %08lX) lock %d\n",
@@ -147,9 +147,9 @@ void _raw_read_unlock(rwlock_t *rw)
 	wmb();
 	atomic_dec((atomic_t *) &(rw)->lock);
 }
-EXPORT_SYMBOL(_raw_read_unlock);
+EXPORT_SYMBOL(__raw_read_unlock);
 
-void _raw_write_lock(rwlock_t *rw)
+void __raw_write_lock(raw_rwlock_t *rw)
 {
 	unsigned int stuck;
 
@@ -165,18 +165,18 @@ void _raw_write_lock(rwlock_t *rw)
 	}
 	wmb();
 }
-EXPORT_SYMBOL(_raw_write_lock);
+EXPORT_SYMBOL(__raw_write_lock);
 
-int _raw_write_trylock(rwlock_t *rw)
+int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	if (cmpxchg(&rw->lock, 0, -1) != 0)
 		return 0;
 	wmb();
 	return 1;
 }
-EXPORT_SYMBOL(_raw_write_trylock);
+EXPORT_SYMBOL(__raw_write_trylock);
 
-void _raw_write_unlock(rwlock_t *rw)
+void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	if (rw->lock >= 0)
 		printk("_write_lock(): %s/%d (nip %08lX) lock %d\n",
@@ -185,6 +185,6 @@ void _raw_write_unlock(rwlock_t *rw)
 	wmb();
 	rw->lock = 0;
 }
-EXPORT_SYMBOL(_raw_write_unlock);
+EXPORT_SYMBOL(__raw_write_unlock);
 
 #endif
Index: linux-2.6.10/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/ppc_ksyms.c
+++ linux-2.6.10/arch/ppc/kernel/ppc_ksyms.c
@@ -295,9 +295,11 @@ EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(xmon);
 EXPORT_SYMBOL(xmon_printf);
 #endif
+#ifdef CONFIG_ASM_SEMAPHORES
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down);
 EXPORT_SYMBOL(__down_interruptible);
+#endif
 
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON)
 extern void (*debugger)(struct pt_regs *regs);
Index: linux-2.6.10/arch/ppc/platforms/pmac_pic.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/pmac_pic.c
+++ linux-2.6.10/arch/ppc/platforms/pmac_pic.c
@@ -68,7 +68,7 @@ static int max_irqs __pmacdata;
 static int max_real_irqs __pmacdata;
 static u32 level_mask[4] __pmacdata;
 
-static DEFINE_SPINLOCK(pmac_pic_lock __pmacdata);
+static DEFINE_RAW_SPINLOCK(pmac_pic_lock __pmacdata);
 
 
 #define GATWICK_IRQ_POOL_SIZE        10
Index: linux-2.6.10/arch/ppc/kernel/dma-mapping.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/dma-mapping.c
+++ linux-2.6.10/arch/ppc/kernel/dma-mapping.c
@@ -71,7 +71,7 @@ int map_page(unsigned long va, phys_addr
  * This is the page table (2MB) covering uncached, DMA consistent allocations
  */
 static pte_t *consistent_pte;
-static DEFINE_SPINLOCK(consistent_lock);
+static DEFINE_RAW_SPINLOCK(consistent_lock);
 
 /*
  * VM region handling support.
Index: linux-2.6.10/arch/ppc/syslib/ocp.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/ocp.c
+++ linux-2.6.10/arch/ppc/syslib/ocp.c
@@ -45,11 +45,11 @@
 #include <linux/pm.h>
 #include <linux/bootmem.h>
 #include <linux/device.h>
+#include <linux/rwsem.h>
 
 #include <asm/io.h>
 #include <asm/ocp.h>
 #include <asm/errno.h>
-#include <asm/rwsem.h>
 #include <asm/semaphore.h>
 
 //#define DBG(x)	printk x
Index: linux-2.6.10/arch/ppc/kernel/time.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/time.c
+++ linux-2.6.10/arch/ppc/kernel/time.c
@@ -91,7 +91,7 @@ extern unsigned long wall_jiffies;
 
 static long time_offset;
 
-DEFINE_SPINLOCK(rtc_lock);
+DEFINE_RAW_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
 
