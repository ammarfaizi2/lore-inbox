Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSHWL1C>; Fri, 23 Aug 2002 07:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSHWL1C>; Fri, 23 Aug 2002 07:27:02 -0400
Received: from verein.lst.de ([212.34.181.86]:54021 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318756AbSHWL0z>;
	Fri, 23 Aug 2002 07:26:55 -0400
Date: Fri, 23 Aug 2002 13:31:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BKPATCH] further BKL cleanups
Message-ID: <20020823133101.A20847@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have <asm-*/smplock.h> remove and everything in
<linux/smp_lock.h> we can move the definition/export of kernel_flag
to common code.  Also cleanup smp_lock.h a little more.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.509, 2002-08-23 13:56:54+02:00, hch@sb.bsdonline.org
  Cleanup BKL handling and move kernel_flag definition to common code


 arch/alpha/kernel/alpha_ksyms.c     |    2 -
 arch/alpha/kernel/smp.c             |    2 -
 arch/arm/kernel/armksyms.c          |    4 --
 arch/arm/kernel/setup.c             |    4 --
 arch/i386/kernel/i386_ksyms.c       |    1 
 arch/i386/kernel/smp.c              |    4 --
 arch/ia64/kernel/ia64_ksyms.c       |    4 --
 arch/ia64/kernel/smp.c              |    8 ----
 arch/mips/kernel/smp.c              |    1 
 arch/mips64/kernel/smp.c            |    1 
 arch/parisc/kernel/parisc_ksyms.c   |    3 -
 arch/ppc/kernel/ppc_ksyms.c         |    3 -
 arch/ppc/kernel/smp.c               |    1 
 arch/ppc64/kernel/ppc_ksyms.c       |    1 
 arch/ppc64/kernel/smp.c             |    1 
 arch/s390/kernel/smp.c              |    3 -
 arch/s390x/kernel/smp.c             |    3 -
 arch/sparc/kernel/smp.c             |    3 -
 arch/sparc/kernel/sparc_ksyms.c     |    7 ----
 arch/sparc64/kernel/smp.c           |    3 -
 arch/sparc64/kernel/sparc64_ksyms.c |    8 ----
 arch/x86_64/kernel/smp.c            |    3 -
 arch/x86_64/kernel/x8664_ksyms.c    |    1 
 include/linux/smp_lock.h            |   61 ++++++++++++++++--------------------
 kernel/ksyms.c                      |    4 ++
 kernel/sched.c                      |   15 ++++++++
 26 files changed, 48 insertions, 103 deletions


diff -Nru a/arch/alpha/kernel/alpha_ksyms.c b/arch/alpha/kernel/alpha_ksyms.c
--- a/arch/alpha/kernel/alpha_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/alpha/kernel/alpha_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -40,7 +40,6 @@
 extern struct hwrpb_struct *hwrpb;
 extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
-extern spinlock_t kernel_flag;
 extern spinlock_t rtc_lock;
 
 /* these are C runtime functions with special calling conventions: */
@@ -207,7 +206,6 @@
  */
 
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(flush_tlb_all);
 EXPORT_SYMBOL(flush_tlb_mm);
diff -Nru a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
--- a/arch/alpha/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/alpha/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -67,8 +67,6 @@
 	IPI_CPU_STOP,
 };
 
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 /* Set to a secondary's cpuid when it comes online.  */
 static int smp_secondary_alive __initdata = 0;
 
diff -Nru a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
--- a/arch/arm/kernel/armksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/arm/kernel/armksyms.c	Fri Aug 23 14:19:06 2002
@@ -273,7 +273,3 @@
 EXPORT_SYMBOL_NOVERS(__up_wakeup);
 
 EXPORT_SYMBOL(get_wchan);
-
-#ifdef CONFIG_PREEMPT
-EXPORT_SYMBOL(kernel_flag);
-#endif
diff -Nru a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
--- a/arch/arm/kernel/setup.c	Fri Aug 23 14:19:06 2002
+++ b/arch/arm/kernel/setup.c	Fri Aug 23 14:19:06 2002
@@ -36,10 +36,6 @@
 #define MEM_SIZE	(16*1024*1024)
 #endif
 
-#ifdef CONFIG_PREEMPT
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-#endif
-
 #if defined(CONFIG_FPE_NWFPE) || defined(CONFIG_FPE_FASTFPE)
 char fpe_type[8];
 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -126,7 +126,6 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/i386/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -18,6 +18,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
+#include <linux/interrupt.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -102,9 +103,6 @@
  *	or are signal timing bugs worked around in hardware and there's
  *	about nothing of note with C stepping upwards.
  */
-
-/* The 'big kernel lock' */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 struct tlb_state cpu_tlbstate[NR_CPUS] __cacheline_aligned = {[0 ... NR_CPUS-1] = { &init_mm, 0, }};
 
diff -Nru a/arch/ia64/kernel/ia64_ksyms.c b/arch/ia64/kernel/ia64_ksyms.c
--- a/arch/ia64/kernel/ia64_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/ia64/kernel/ia64_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -84,10 +84,6 @@
 EXPORT_SYMBOL(smp_call_function_single);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(ia64_cpu_to_sapicid);
-
-#include <asm/smplock.h>
-EXPORT_SYMBOL(kernel_flag);
-
 #else /* !CONFIG_SMP */
 
 EXPORT_SYMBOL(__flush_tlb_all);
diff -Nru a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
--- a/arch/ia64/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/ia64/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -53,14 +53,6 @@
 #include <asm/mca.h>
 
 /*
- * The Big Kernel Lock.  It's not supposed to be used for performance critical stuff
- * anymore.  But we still need to align it because certain workloads are still affected by
- * it.  For example, llseek() and various other filesystem related routines still use the
- * BKL.
- */
-spinlock_t kernel_flag __cacheline_aligned = SPIN_LOCK_UNLOCKED;
-
-/*
  * Structure and data for smp_call_function(). This is designed to minimise static memory
  * requirements. It also looks cleaner.
  */
diff -Nru a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
--- a/arch/mips/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/mips/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -53,7 +53,6 @@
 
 
 /* Ze Big Kernel Lock! */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int smp_threads_ready;  /* Not used */
 int smp_num_cpus;    
 int global_irq_holder = NO_PROC_ID;
diff -Nru a/arch/mips64/kernel/smp.c b/arch/mips64/kernel/smp.c
--- a/arch/mips64/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/mips64/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -53,7 +53,6 @@
 #endif /* CONFIG_SGI_IP27 */
 
 /* The 'big kernel lock' */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int smp_threads_ready;	/* Not used */
 atomic_t smp_commenced = ATOMIC_INIT(0);
 struct cpuinfo_mips cpu_data[NR_CPUS];
diff -Nru a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
--- a/arch/parisc/kernel/parisc_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/parisc/kernel/parisc_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -35,9 +35,6 @@
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(synchronize_irq);
 
-#include <asm/smplock.h>
-EXPORT_SYMBOL(kernel_flag);
-
 #include <asm/system.h>
 EXPORT_SYMBOL(__global_sti);
 EXPORT_SYMBOL(__global_cli);
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/ppc/kernel/ppc_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -93,9 +93,6 @@
 EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(probe_irq_mask);
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(kernel_flag);
-#endif /* CONFIG_SMP */
 
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL_NOVERS(DMA_MODE_READ);
diff -Nru a/arch/ppc/kernel/smp.c b/arch/ppc/kernel/smp.c
--- a/arch/ppc/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/ppc/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -47,7 +47,6 @@
 struct klock_info_struct klock_info = { KLOCK_CLEAR, 0 };
 atomic_t ipi_recv;
 atomic_t ipi_sent;
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 unsigned int prof_multiplier[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
 unsigned int prof_counter[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
 unsigned long cache_decay_ticks = HZ/100;
diff -Nru a/arch/ppc64/kernel/ppc_ksyms.c b/arch/ppc64/kernel/ppc_ksyms.c
--- a/arch/ppc64/kernel/ppc_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/ppc64/kernel/ppc_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -74,7 +74,6 @@
 EXPORT_SYMBOL(disable_irq_nosync);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(synchronize_irq);
-EXPORT_SYMBOL(kernel_flag);
 #endif /* CONFIG_SMP */
 
 EXPORT_SYMBOL(register_ioctl32_conversion);
diff -Nru a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/ppc64/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -51,7 +51,6 @@
 #include <asm/machdep.h>
 
 int smp_threads_ready = 0;
-spinlock_t kernel_flag __cacheline_aligned = SPIN_LOCK_UNLOCKED;
 unsigned long cache_decay_ticks;
 
 /* initialised so it doesnt end up in bss */
diff -Nru a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
--- a/arch/s390/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/s390/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -54,8 +54,6 @@
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
 static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
-spinlock_t       kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 volatile unsigned long phys_cpu_present_map;
 volatile unsigned long cpu_online_map;
 unsigned long    cache_decay_ticks = 0;
@@ -634,7 +632,6 @@
 }
 
 EXPORT_SYMBOL(lowcore_ptr);
-EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
 EXPORT_SYMBOL(smp_num_cpus);
diff -Nru a/arch/s390x/kernel/smp.c b/arch/s390x/kernel/smp.c
--- a/arch/s390x/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/s390x/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -53,8 +53,6 @@
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
 static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
-spinlock_t       kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 volatile unsigned long phys_cpu_present_map;
 volatile unsigned long cpu_online_map;
 unsigned long    cache_decay_ticks = 0;
@@ -613,7 +611,6 @@
 }
 
 EXPORT_SYMBOL(lowcore_ptr);
-EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
 EXPORT_SYMBOL(smp_num_cpus);
diff -Nru a/arch/sparc/kernel/smp.c b/arch/sparc/kernel/smp.c
--- a/arch/sparc/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/sparc/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -66,9 +66,6 @@
  * instruction which is much better...
  */
 
-/* Kernel spinlock */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 /* Used to make bitops atomic */
 unsigned char bitops_spinlock = 0;
 
diff -Nru a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
--- a/arch/sparc/kernel/sparc_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/sparc/kernel/sparc_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -77,10 +77,6 @@
 
 extern void dump_thread(struct pt_regs *, struct user *);
 
-#ifdef CONFIG_SMP
-extern spinlock_t kernel_flag;
-#endif
-
 /* One thing to note is that the way the symbols of the mul/div
  * support routines are named is a mess, they all start with
  * a '.' which makes it a bitch to export, here is the trick:
@@ -130,9 +126,6 @@
 EXPORT_SYMBOL_PRIVATE(_change_bit);
 
 #ifdef CONFIG_SMP
-/* Kernel wide locking */
-EXPORT_SYMBOL(kernel_flag);
-
 /* IRQ implementation. */
 EXPORT_SYMBOL(global_irq_holder);
 EXPORT_SYMBOL(synchronize_irq);
diff -Nru a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
--- a/arch/sparc64/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/sparc64/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -46,9 +46,6 @@
 /* Please don't make this stuff initdata!!!  --DaveM */
 static unsigned char boot_cpu_id;
 
-/* Kernel spinlock */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 atomic_t sparc64_num_cpus_online = ATOMIC_INIT(0);
 unsigned long cpu_online_map = 0;
 atomic_t sparc64_num_cpus_possible = ATOMIC_INIT(0);
diff -Nru a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
--- a/arch/sparc64/kernel/sparc64_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/sparc64/kernel/sparc64_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -101,9 +101,7 @@
 extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
-#ifdef CONFIG_SMP
-extern spinlock_t kernel_flag;
-#ifdef CONFIG_DEBUG_SPINLOCK
+#if defined(CONFIG_SMP) && defined(CONFIG_DEBUG_SPINLOCK)
 extern void _do_spin_lock (spinlock_t *lock, char *str);
 extern void _do_spin_unlock (spinlock_t *lock);
 extern int _spin_trylock (spinlock_t *lock);
@@ -112,7 +110,6 @@
 extern void _do_write_lock(rwlock_t *rw, char *str);
 extern void _do_write_unlock(rwlock_t *rw);
 #endif
-#endif
 
 extern unsigned long phys_base;
 extern unsigned long pfn_base;
@@ -126,9 +123,6 @@
 EXPORT_SYMBOL(__write_lock);
 EXPORT_SYMBOL(__write_unlock);
 #endif
-
-/* Kernel wide locking */
-EXPORT_SYMBOL(kernel_flag);
 
 /* Hard IRQ locking */
 #ifdef CONFIG_SMP
diff -Nru a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
--- a/arch/x86_64/kernel/smp.c	Fri Aug 23 14:19:06 2002
+++ b/arch/x86_64/kernel/smp.c	Fri Aug 23 14:19:06 2002
@@ -22,9 +22,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
-/* The 'big kernel lock' */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
 /*
  * the following functions deal with sending IPIs between CPUs.
  *
diff -Nru a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/arch/x86_64/kernel/x8664_ksyms.c	Fri Aug 23 14:19:06 2002
@@ -109,7 +109,6 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
diff -Nru a/include/linux/smp_lock.h b/include/linux/smp_lock.h
--- a/include/linux/smp_lock.h	Fri Aug 23 14:19:06 2002
+++ b/include/linux/smp_lock.h	Fri Aug 23 14:19:06 2002
@@ -2,21 +2,10 @@
 #define __LINUX_SMPLOCK_H
 
 #include <linux/config.h>
-
-#if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
-
-#define lock_kernel()				do { } while(0)
-#define unlock_kernel()				do { } while(0)
-#define release_kernel_lock(task)		do { } while(0)
-#define reacquire_kernel_lock(task)		do { } while(0)
-#define kernel_locked() 1
-
-#else
-
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
 #include <linux/sched.h>
-#include <asm/current.h>
+#include <linux/spinlock.h>
+
+#if CONFIG_SMP || CONFIG_PREEMPT
 
 extern spinlock_t kernel_flag;
 
@@ -26,23 +15,22 @@
 #define put_kernel_lock()	spin_unlock(&kernel_flag)
 
 /*
- * Release global kernel lock and global interrupt lock
+ * Release global kernel lock.
  */
-#define release_kernel_lock(task)		\
-do {						\
-	if (unlikely(task->lock_depth >= 0))	\
-		put_kernel_lock();		\
-} while (0)
+static inline void release_kernel_lock(struct task_struct *task)
+{
+	if (unlikely(task->lock_depth >= 0))
+		put_kernel_lock();
+}
 
 /*
  * Re-acquire the kernel lock
  */
-#define reacquire_kernel_lock(task)		\
-do {						\
-	if (unlikely(task->lock_depth >= 0))	\
-		get_kernel_lock();		\
-} while (0)
-
+static inline void reacquire_kernel_lock(struct task_struct *task)
+{
+	if (unlikely(task->lock_depth >= 0))
+		get_kernel_lock();
+}
 
 /*
  * Getting the big kernel lock.
@@ -51,22 +39,29 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static inline void lock_kernel(void)
 {
 	int depth = current->lock_depth+1;
-	if (!depth)
+	if (likely(!depth))
 		get_kernel_lock();
 	current->lock_depth = depth;
 }
 
-static __inline__ void unlock_kernel(void)
+static inline void unlock_kernel(void)
 {
-	if (current->lock_depth < 0)
+	if (unlikely(current->lock_depth < 0))
 		BUG();
-	if (--current->lock_depth < 0)
+	if (likely(--current->lock_depth < 0))
 		put_kernel_lock();
 }
 
-#endif /* CONFIG_SMP */
+#else
+
+#define lock_kernel()				do { } while(0)
+#define unlock_kernel()				do { } while(0)
+#define release_kernel_lock(task)		do { } while(0)
+#define reacquire_kernel_lock(task)		do { } while(0)
+#define kernel_locked()				1
 
-#endif
+#endif /* CONFIG_SMP || CONFIG_PREEMPT */
+#endif /* __LINUX_SMPLOCK_H */
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Aug 23 14:19:06 2002
+++ b/kernel/ksyms.c	Fri Aug 23 14:19:06 2002
@@ -51,6 +51,7 @@
 #include <linux/buffer_head.h>
 #include <linux/root_dev.h>
 #include <linux/percpu.h>
+#include <linux/smp_lock.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -480,6 +481,9 @@
 EXPORT_SYMBOL_GPL(idle_cpu);
 #if CONFIG_SMP
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
+#endif
+#if CONFIG_SMP || CONFIG_PREEMPT
+EXPORT_SYMBOL(kernel_flag);
 #endif
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(jiffies_64);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Aug 23 14:19:06 2002
+++ b/kernel/sched.c	Fri Aug 23 14:19:06 2002
@@ -1881,7 +1881,6 @@
 }
 
 #if CONFIG_SMP
-
 /*
  * This is how migration works:
  *
@@ -2068,6 +2067,20 @@
 	return 0;
 }
 
+#endif
+
+#if CONFIG_SMP || CONFIG_PREEMPT
+/*
+ * The 'big kernel lock'
+ *
+ * This spinlock is taken and released recursively by lock_kernel()
+ * and unlock_kernel().  It is transparently dropped and reaquired
+ * over schedule().  It is used to protect legacy code that hasn't
+ * been migrated to a proper locking design yet.
+ *
+ * Don't use in new code.
+ */
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 #endif
 
 extern void init_timervecs(void);

===================================================================


This BitKeeper patch contains the following changesets:
1.509
## Wrapped with gzip_uu ##


begin 664 bkpatch1165
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
49(O9*VSTV!#B._\#EV7D8JQ+````
`
end
