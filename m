Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbRCOB0n>; Wed, 14 Mar 2001 20:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131601AbRCOB0Y>; Wed, 14 Mar 2001 20:26:24 -0500
Received: from nrg.org ([216.101.165.106]:33808 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131600AbRCOB0K>;
	Wed, 14 Mar 2001 20:26:10 -0500
Date: Wed, 14 Mar 2001 17:25:22 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH for 2.5] preemptible kernel
Message-ID: <Pine.LNX.4.05.10103141653350.3094-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the latest preemptible kernel patch.  It's much cleaner and
smaller than previous versions, so I've appended it to this mail.  This
patch is against 2.4.2, although it's not intended for 2.4.  I'd like
comments from anyone interested in a low-latency Linux kernel solution
for the 2.5 development tree.

Kernel preemption is not allowed while spinlocks are held, which means
that this patch alone cannot guarantee low preemption latencies.  But
as long held locks (in particular the BKL) are replaced by finer-grained
locks, this patch will enable lower latencies as the kernel also becomes
more scalable on large SMP systems.

Notwithstanding the comments in the Configure.help section for
CONFIG_PREEMPT, I think this patch has a negligible effect on
throughput.  In fact, I got better average results from running 'dbench
16' on a 750MHz PIII with 128MB with kernel preemption turned on
(~30MB/s) than on the plain 2.4.2 kernel (~26MB/s).

(I had to rearrange three headers files that are needed in sched.h before
task_struct is defined, but which include inline functions that cannot
now be compiled until after task_struct is defined.  I chose not to
move them into sched.h, like d_path(), as I don't want to make it more
difficult to apply kernel patches to my kernel source tree.)

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/


diff -Nur 2.4.2/CREDITS linux/CREDITS
--- 2.4.2/CREDITS	Wed Mar 14 12:15:49 2001
+++ linux/CREDITS	Wed Mar 14 12:21:42 2001
@@ -907,8 +907,8 @@
 
 N: Nigel Gamble
 E: nigel@nrg.org
-E: nigel@sgi.com
 D: Interrupt-driven printer driver
+D: Preemptible kernel
 S: 120 Alley Way
 S: Mountain View, California 94040
 S: USA
diff -Nur 2.4.2/Documentation/Configure.help linux/Documentation/Configure.help
--- 2.4.2/Documentation/Configure.help	Wed Mar 14 12:16:10 2001
+++ linux/Documentation/Configure.help	Wed Mar 14 12:22:04 2001
@@ -130,6 +130,23 @@
   If you have system with several CPU's, you do not need to say Y
   here: APIC will be used automatically.
 
+Preemptible Kernel
+CONFIG_PREEMPT
+  This option reduces the latency of the kernel when reacting to
+  real-time or interactive events by allowing a low priority process to
+  be preempted even if it is in kernel mode executing a system call.
+  This allows applications that need real-time response, such as audio
+  and other multimedia applications, to run more reliably even when the
+  system is under load due to other, lower priority, processes.
+
+  This option is currently experimental if used in conjuction with SMP
+  support.
+
+  Say Y here if you are building a kernel for a desktop system, embedded
+  system or real-time system.  Say N if you are building a kernel for a
+  system where throughput is more important than interactive response,
+  such as a server system.  Say N if you are unsure.
+
 Kernel math emulation
 CONFIG_MATH_EMULATION
   Linux can emulate a math coprocessor (used for floating point
diff -Nur 2.4.2/arch/i386/config.in linux/arch/i386/config.in
--- 2.4.2/arch/i386/config.in	Wed Mar 14 12:14:18 2001
+++ linux/arch/i386/config.in	Wed Mar 14 12:20:02 2001
@@ -161,6 +161,11 @@
       define_bool CONFIG_X86_IO_APIC y
       define_bool CONFIG_X86_LOCAL_APIC y
    fi
+   bool 'Preemptible Kernel' CONFIG_PREEMPT
+else
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      bool 'Preemptible SMP Kernel (EXPERIMENTAL)' CONFIG_PREEMPT
+   fi
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
diff -Nur 2.4.2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- 2.4.2/arch/i386/kernel/entry.S	Wed Mar 14 12:17:37 2001
+++ linux/arch/i386/kernel/entry.S	Wed Mar 14 12:23:42 2001
@@ -72,7 +72,7 @@
  * these are offsets into the task-struct.
  */
 state		=  0
-flags		=  4
+preempt_count	=  4
 sigpending	=  8
 addr_limit	= 12
 exec_domain	= 16
@@ -80,8 +80,30 @@
 tsk_ptrace	= 24
 processor	= 52
 
+        /* These are offsets into the irq_stat structure
+         * There is one per cpu and it is aligned to 32
+         * byte boundry (we put that here as a shift count)
+         */
+irq_array_shift                 = CONFIG_X86_L1_CACHE_SHIFT
+
+irq_stat_softirq_active         = 0
+irq_stat_softirq_mask           = 4        
+irq_stat_local_irq_count        = 8
+irq_stat_local_bh_count         = 12
+
 ENOSYS = 38
 
+#ifdef CONFIG_SMP
+#define GET_CPU_INDX	movl processor(%ebx),%eax;  \
+                        shll $irq_array_shift,%eax
+#define GET_CURRENT_CPU_INDX GET_CURRENT(%ebx); \
+                             GET_CPU_INDX
+#define CPU_INDX (,%eax)
+#else
+#define GET_CPU_INDX
+#define GET_CURRENT_CPU_INDX GET_CURRENT(%ebx)
+#define CPU_INDX
+#endif
 
 #define SAVE_ALL \
 	cld; \
@@ -270,16 +292,44 @@
 #endif
 	jne   handle_softirq
 
+#ifdef CONFIG_PREEMPT
+	cli
+	incl preempt_count(%ebx)
+#endif
 ENTRY(ret_from_intr)
 	GET_CURRENT(%ebx)
+#ifdef CONFIG_PREEMPT
+	cli
+	decl preempt_count(%ebx)
+#endif
 	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
 	movb CS(%esp),%al
 	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
 	jne ret_with_reschedule
+#ifdef CONFIG_PREEMPT
+	cmpl $0,preempt_count(%ebx)
+	jnz restore_all
+	cmpl $0,need_resched(%ebx)
+	jz restore_all
+	movl SYMBOL_NAME(irq_stat)+irq_stat_local_bh_count CPU_INDX,%ecx
+	addl SYMBOL_NAME(irq_stat)+irq_stat_local_irq_count CPU_INDX,%ecx
+	jnz restore_all
+	incl preempt_count(%ebx)
+	sti
+	call SYMBOL_NAME(preempt_schedule)
+	jmp ret_from_intr
+#else
 	jmp restore_all
+#endif
 
 	ALIGN
 handle_softirq:
+#ifdef CONFIG_PREEMPT
+	cli
+	GET_CURRENT(%ebx)
+	incl preempt_count(%ebx)
+	sti
+#endif
 	call SYMBOL_NAME(do_softirq)
 	jmp ret_from_intr
 	
diff -Nur 2.4.2/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- 2.4.2/arch/i386/kernel/traps.c	Wed Mar 14 12:16:46 2001
+++ linux/arch/i386/kernel/traps.c	Wed Mar 14 12:22:45 2001
@@ -973,7 +973,7 @@
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_trap_gate(14,&page_fault);
+	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
diff -Nur 2.4.2/arch/i386/lib/dec_and_lock.c linux/arch/i386/lib/dec_and_lock.c
--- 2.4.2/arch/i386/lib/dec_and_lock.c	Wed Mar 14 12:16:12 2001
+++ linux/arch/i386/lib/dec_and_lock.c	Wed Mar 14 12:22:07 2001
@@ -8,6 +8,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
 
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
diff -Nur 2.4.2/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- 2.4.2/arch/i386/mm/fault.c	Wed Mar 14 12:16:41 2001
+++ linux/arch/i386/mm/fault.c	Wed Mar 14 12:22:40 2001
@@ -117,6 +117,9 @@
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
 
+	/* It's safe to allow preemption after cr2 has been saved */
+	local_irq_restore(regs->eflags);
+
 	tsk = current;
 
 	/*
diff -Nur 2.4.2/fs/exec.c linux/fs/exec.c
--- 2.4.2/fs/exec.c	Wed Mar 14 12:14:14 2001
+++ linux/fs/exec.c	Wed Mar 14 12:19:57 2001
@@ -412,8 +412,8 @@
 		active_mm = current->active_mm;
 		current->mm = mm;
 		current->active_mm = mm;
-		task_unlock(current);
 		activate_mm(active_mm, mm);
+		task_unlock(current);
 		mm_release();
 		if (old_mm) {
 			if (active_mm != old_mm) BUG();
diff -Nur 2.4.2/include/asm-i386/hardirq.h linux/include/asm-i386/hardirq.h
--- 2.4.2/include/asm-i386/hardirq.h	Wed Mar 14 12:17:12 2001
+++ linux/include/asm-i386/hardirq.h	Wed Mar 14 12:23:18 2001
@@ -36,6 +36,8 @@
 
 #define synchronize_irq()	barrier()
 
+#define release_irqlock(cpu)	do { } while (0)
+
 #else
 
 #include <asm/atomic.h>
diff -Nur 2.4.2/include/asm-i386/hw_irq.h linux/include/asm-i386/hw_irq.h
--- 2.4.2/include/asm-i386/hw_irq.h	Wed Mar 14 12:16:34 2001
+++ linux/include/asm-i386/hw_irq.h	Wed Mar 14 12:22:32 2001
@@ -92,6 +92,18 @@
 #define __STR(x) #x
 #define STR(x) __STR(x)
 
+#define GET_CURRENT \
+	"movl %esp, %ebx\n\t" \
+	"andl $-8192, %ebx\n\t"
+
+#ifdef CONFIG_PREEMPT
+#define BUMP_CONTEX_SWITCH_LOCK \
+	GET_CURRENT \
+	"incl 4(%ebx)\n\t"
+#else
+#define BUMP_CONTEX_SWITCH_LOCK
+#endif
+
 #define SAVE_ALL \
 	"cld\n\t" \
 	"pushl %es\n\t" \
@@ -105,14 +117,11 @@
 	"pushl %ebx\n\t" \
 	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
 	"movl %edx,%ds\n\t" \
-	"movl %edx,%es\n\t"
+	"movl %edx,%es\n\t" \
+	BUMP_CONTEX_SWITCH_LOCK
 
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
-
-#define GET_CURRENT \
-	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
 
 /*
  *	SMP has a few special interrupts for IPI messages
diff -Nur 2.4.2/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- 2.4.2/include/asm-i386/mmu_context.h	Wed Mar 14 12:13:52 2001
+++ linux/include/asm-i386/mmu_context.h	Wed Mar 14 12:19:34 2001
@@ -27,6 +27,10 @@
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
 {
+#ifdef CONFIG_PREEMPT
+	if (in_ctx_sw_off() == 0)
+		BUG();
+#endif
 	if (prev != next) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
diff -Nur 2.4.2/include/asm-i386/smplock.h linux/include/asm-i386/smplock.h
--- 2.4.2/include/asm-i386/smplock.h	Wed Mar 14 12:14:40 2001
+++ linux/include/asm-i386/smplock.h	Wed Mar 14 12:20:27 2001
@@ -10,7 +10,15 @@
 
 extern spinlock_t kernel_flag;
 
+#ifdef CONFIG_SMP
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#else
+#ifdef CONFIG_PREEMPT
+#define kernel_locked()		in_ctx_sw_off()
+#else
+#define kernel_locked()		1
+#endif
+#endif
 
 /*
  * Release global kernel lock and global interrupt lock
@@ -42,6 +50,11 @@
  */
 extern __inline__ void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth == -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 #if 1
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
@@ -53,6 +66,7 @@
 		"\n9:"
 		:"=m" (__dummy_lock(&kernel_flag)),
 		 "=m" (current->lock_depth));
+#endif
 #endif
 }
 
diff -Nur 2.4.2/include/asm-i386/softirq.h linux/include/asm-i386/softirq.h
--- 2.4.2/include/asm-i386/softirq.h	Wed Mar 14 12:16:35 2001
+++ linux/include/asm-i386/softirq.h	Wed Mar 14 12:22:35 2001
@@ -4,8 +4,8 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
-#define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
-#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
+#define cpu_bh_disable(cpu)	do { ctx_sw_off(); local_bh_count(cpu)++; barrier(); } while (0)
+#define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--;ctx_sw_on(); } while (0)
 
 #define local_bh_disable()	cpu_bh_disable(smp_processor_id())
 #define local_bh_enable()	cpu_bh_enable(smp_processor_id())
diff -Nur 2.4.2/include/asm-i386/spinlock.h linux/include/asm-i386/spinlock.h
--- 2.4.2/include/asm-i386/spinlock.h	Wed Mar 14 12:16:48 2001
+++ linux/include/asm-i386/spinlock.h	Wed Mar 14 12:22:49 2001
@@ -65,7 +65,7 @@
 #define spin_unlock_string \
 	"movb $1,%0"
 
-static inline int spin_trylock(spinlock_t *lock)
+static inline int _raw_spin_trylock(spinlock_t *lock)
 {
 	char oldval;
 	__asm__ __volatile__(
@@ -75,7 +75,7 @@
 	return oldval > 0;
 }
 
-static inline void spin_lock(spinlock_t *lock)
+static inline void _raw_spin_lock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	__label__ here;
@@ -90,7 +90,7 @@
 		:"=m" (lock->lock) : : "memory");
 }
 
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	if (lock->magic != SPINLOCK_MAGIC)
@@ -143,7 +143,7 @@
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
-static inline void read_lock(rwlock_t *rw)
+static inline void _raw_read_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic != RWLOCK_MAGIC)
@@ -152,7 +152,7 @@
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void write_lock(rwlock_t *rw)
+static inline void _raw_write_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic != RWLOCK_MAGIC)
@@ -161,10 +161,10 @@
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
+#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
+#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
-static inline int write_trylock(rwlock_t *lock)
+static inline int _raw_write_trylock(rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
diff -Nur 2.4.2/include/linux/brlock.h linux/include/linux/brlock.h
--- 2.4.2/include/linux/brlock.h	Wed Mar 14 12:14:04 2001
+++ linux/include/linux/brlock.h	Wed Mar 14 12:19:47 2001
@@ -170,12 +170,19 @@
 	__br_write_unlock(idx);
 }
 
+#else 	/* CONFIG_SMP */
+#ifdef CONFIG_PREEMPT
+# define br_read_lock(idx)	({ (void)(idx); ctx_sw_off(); })
+# define br_read_unlock(idx)	({ (void)(idx); ctx_sw_on(); })
+# define br_write_lock(idx)	({ (void)(idx); ctx_sw_off(); })
+# define br_write_unlock(idx)	({ (void)(idx); ctx_sw_on(); })
 #else
 # define br_read_lock(idx)	((void)(idx))
 # define br_read_unlock(idx)	((void)(idx))
 # define br_write_lock(idx)	((void)(idx))
 # define br_write_unlock(idx)	((void)(idx))
 #endif
+#endif	/* CONFIG_SMP */
 
 /*
  * Now enumerate all of the possible sw/hw IRQ protected
diff -Nur 2.4.2/include/linux/dcache.h linux/include/linux/dcache.h
--- 2.4.2/include/linux/dcache.h	Wed Mar 14 12:15:09 2001
+++ linux/include/linux/dcache.h	Wed Mar 14 12:20:59 2001
@@ -126,31 +126,6 @@
 
 extern spinlock_t dcache_lock;
 
-/**
- * d_drop - drop a dentry
- * @dentry: dentry to drop
- *
- * d_drop() unhashes the entry from the parent
- * dentry hashes, so that it won't be found through
- * a VFS lookup any more. Note that this is different
- * from deleting the dentry - d_delete will try to
- * mark the dentry negative if possible, giving a
- * successful _negative_ lookup, while d_drop will
- * just make the cache lookup fail.
- *
- * d_drop() is used mainly for stuff that wants
- * to invalidate a dentry for some reason (NFS
- * timeouts or autofs deletes).
- */
-
-static __inline__ void d_drop(struct dentry * dentry)
-{
-	spin_lock(&dcache_lock);
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
-	spin_unlock(&dcache_lock);
-}
-
 static __inline__ int dname_external(struct dentry *d)
 {
 	return d->d_name.name != d->d_iname; 
@@ -271,3 +246,34 @@
 #endif /* __KERNEL__ */
 
 #endif	/* __LINUX_DCACHE_H */
+
+#if !defined(__LINUX_DCACHE_H_INLINES) && defined(_TASK_STRUCT_DEFINED)
+#define __LINUX_DCACHE_H_INLINES
+
+#ifdef __KERNEL__
+/**
+ * d_drop - drop a dentry
+ * @dentry: dentry to drop
+ *
+ * d_drop() unhashes the entry from the parent
+ * dentry hashes, so that it won't be found through
+ * a VFS lookup any more. Note that this is different
+ * from deleting the dentry - d_delete will try to
+ * mark the dentry negative if possible, giving a
+ * successful _negative_ lookup, while d_drop will
+ * just make the cache lookup fail.
+ *
+ * d_drop() is used mainly for stuff that wants
+ * to invalidate a dentry for some reason (NFS
+ * timeouts or autofs deletes).
+ */
+
+static __inline__ void d_drop(struct dentry * dentry)
+{
+	spin_lock(&dcache_lock);
+	list_del(&dentry->d_hash);
+	INIT_LIST_HEAD(&dentry->d_hash);
+	spin_unlock(&dcache_lock);
+}
+#endif
+#endif
diff -Nur 2.4.2/include/linux/fs_struct.h linux/include/linux/fs_struct.h
--- 2.4.2/include/linux/fs_struct.h	Wed Mar 14 12:17:20 2001
+++ linux/include/linux/fs_struct.h	Wed Mar 14 12:23:26 2001
@@ -20,6 +20,15 @@
 extern void exit_fs(struct task_struct *);
 extern void set_fs_altroot(void);
 
+struct fs_struct *copy_fs_struct(struct fs_struct *old);
+void put_fs_struct(struct fs_struct *fs);
+
+#endif
+#endif
+
+#if !defined(_LINUX_FS_STRUCT_H_INLINES) && defined(_TASK_STRUCT_DEFINED)
+#define _LINUX_FS_STRUCT_H_INLINES
+#ifdef __KERNEL__
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
@@ -65,9 +74,5 @@
 		mntput(old_pwdmnt);
 	}
 }
-
-struct fs_struct *copy_fs_struct(struct fs_struct *old);
-void put_fs_struct(struct fs_struct *fs);
-
 #endif
 #endif
diff -Nur 2.4.2/include/linux/sched.h linux/include/linux/sched.h
--- 2.4.2/include/linux/sched.h	Wed Mar 14 12:15:15 2001
+++ linux/include/linux/sched.h	Wed Mar 14 12:21:06 2001
@@ -86,6 +86,7 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
+#define TASK_PREEMPTED		64
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
@@ -150,6 +151,9 @@
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+#ifdef CONFIG_PREEMPT
+asmlinkage void preempt_schedule(void);
+#endif
 
 extern int schedule_task(struct tq_struct *task);
 extern void flush_scheduled_tasks(void);
@@ -280,7 +284,17 @@
 	 * offsets of these are hardcoded elsewhere - touch with care
 	 */
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
+#ifdef CONFIG_PREEMPT
+        /*
+         * We want the preempt_count in this cache line, but we
+         * a) don't want to mess up the offsets in asm code and
+         * b) the alignment of the next line below so
+         * we move "flags" down
+         */
+	atomic_t preempt_count;          /* 0=> preemptable, < 0 => BUG */
+#else
 	unsigned long flags;	/* per process flags, defined below */
+#endif
 	int sigpending;
 	mm_segment_t addr_limit;	/* thread address space:
 					 	0-0xBFFFFFFF for user-thead
@@ -312,6 +326,9 @@
 
 	struct task_struct *next_task, *prev_task;
 	struct mm_struct *active_mm;
+#ifdef CONFIG_PREEMPT
+	unsigned long flags;	/* per process flags, defined below */
+#endif
 
 /* task state */
 	struct linux_binfmt *binfmt;
@@ -885,6 +902,11 @@
 	mntput(rootmnt);
 	return res;
 }
+
+#define _TASK_STRUCT_DEFINED
+#include <linux/dcache.h>
+#include <linux/tqueue.h>
+#include <linux/fs_struct.h>
 
 #endif /* __KERNEL__ */
 
diff -Nur 2.4.2/include/linux/smp.h linux/include/linux/smp.h
--- 2.4.2/include/linux/smp.h	Wed Mar 14 12:15:31 2001
+++ linux/include/linux/smp.h	Wed Mar 14 12:21:23 2001
@@ -81,7 +81,9 @@
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
+#ifndef CONFIG_PREEMPT
 #define kernel_lock()
+#endif
 #define cpu_logical_map(cpu)			0
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
diff -Nur 2.4.2/include/linux/smp_lock.h linux/include/linux/smp_lock.h
--- 2.4.2/include/linux/smp_lock.h	Wed Mar 14 12:15:40 2001
+++ linux/include/linux/smp_lock.h	Wed Mar 14 12:21:32 2001
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
 
 #define lock_kernel()				do { } while(0)
 #define unlock_kernel()				do { } while(0)
diff -Nur 2.4.2/include/linux/spinlock.h linux/include/linux/spinlock.h
--- 2.4.2/include/linux/spinlock.h	Wed Mar 14 12:13:53 2001
+++ linux/include/linux/spinlock.h	Wed Mar 14 12:19:35 2001
@@ -40,7 +40,9 @@
 
 #if (DEBUG_SPINLOCKS < 1)
 
+#ifndef CONFIG_PREEMPT
 #define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
+#endif
 
 /*
  * Your basic spinlocks, allowing only a single CPU anywhere
@@ -56,11 +58,11 @@
 #endif
 
 #define spin_lock_init(lock)	do { } while(0)
-#define spin_lock(lock)		(void)(lock) /* Not "unused variable". */
+#define _raw_spin_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define spin_is_locked(lock)	(0)
-#define spin_trylock(lock)	({1; })
+#define _raw_spin_trylock(lock)	({1; })
 #define spin_unlock_wait(lock)	do { } while(0)
-#define spin_unlock(lock)	do { } while(0)
+#define _raw_spin_unlock(lock)	do { } while(0)
 
 #elif (DEBUG_SPINLOCKS < 2)
 
@@ -119,12 +121,74 @@
 #endif
 
 #define rwlock_init(lock)	do { } while(0)
-#define read_lock(lock)		(void)(lock) /* Not "unused variable". */
-#define read_unlock(lock)	do { } while(0)
-#define write_lock(lock)	(void)(lock) /* Not "unused variable". */
-#define write_unlock(lock)	do { } while(0)
+#define _raw_read_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_read_unlock(lock)	do { } while(0)
+#define _raw_write_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_write_unlock(lock)	do { } while(0)
 
 #endif /* !SMP */
+
+#ifdef CONFIG_PREEMPT
+
+#define switch_lock_count() current->preempt_count
+
+#define in_ctx_sw_off() (switch_lock_count().counter)
+#define atomic_ptr_in_ctx_sw_off() (&switch_lock_count())
+
+#define ctx_sw_off() \
+do { \
+	atomic_inc(atomic_ptr_in_ctx_sw_off());  \
+} while (0)
+
+#define ctx_sw_on_no_preempt() \
+do { \
+	atomic_dec(atomic_ptr_in_ctx_sw_off()); \
+} while (0)
+
+#define ctx_sw_on() \
+do { \
+	if (atomic_dec_and_test(atomic_ptr_in_ctx_sw_off()) && \
+					current->need_resched) \
+		preempt_schedule();   \
+} while (0)
+
+#define spin_lock(lock)	\
+do { \
+	ctx_sw_off(); \
+	_raw_spin_lock(lock); \
+} while(0)
+#define spin_trylock(lock)	({ctx_sw_off(); _raw_spin_trylock(lock) ? \
+					1 : ({ctx_sw_on(); 0;});})
+#define spin_unlock(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	ctx_sw_on(); \
+} while (0)
+
+#define read_lock(lock)		({ctx_sw_off(); _raw_read_lock(lock);})
+#define read_unlock(lock)	({_raw_read_unlock(lock); ctx_sw_on();})
+#define write_lock(lock)	({ctx_sw_off(); _raw_write_lock(lock);})
+#define write_unlock(lock)	({_raw_write_unlock(lock); ctx_sw_on();})
+#define write_trylock(lock)	({ctx_sw_off(); _raw_write_trylock(lock) ? \
+					1 : ({ctx_sw_on(); 0;});})
+
+#else
+
+#define in_ctx_sw_off() do { } while (0)
+#define ctx_sw_off()    do { } while (0)
+#define ctx_sw_on_no_preempt()
+#define ctx_sw_on()     do { } while (0)
+
+#define spin_lock(lock)		_raw_spin_lock(lock)
+#define spin_trylock(lock)	_raw_spin_trylock(lock)
+#define spin_unlock(lock)	_raw_spin_unlock(lock)
+
+#define read_lock(lock)		_raw_read_lock(lock)
+#define read_unlock(lock)	_raw_read_unlock(lock)
+#define write_lock(lock)	_raw_write_lock(lock)
+#define write_unlock(lock)	_raw_write_unlock(lock)
+#define write_trylock(lock)	_raw_write_trylock(lock)
+#endif
 
 /* "lock on reference count zero" */
 #ifndef atomic_dec_and_lock
diff -Nur 2.4.2/include/linux/tqueue.h linux/include/linux/tqueue.h
--- 2.4.2/include/linux/tqueue.h	Wed Mar 14 12:15:53 2001
+++ linux/include/linux/tqueue.h	Wed Mar 14 12:21:46 2001
@@ -75,6 +75,22 @@
 extern spinlock_t tqueue_lock;
 
 /*
+ * Call all "bottom halfs" on a given list.
+ */
+
+extern void __run_task_queue(task_queue *list);
+
+static inline void run_task_queue(task_queue *list)
+{
+	if (TQ_ACTIVE(*list))
+		__run_task_queue(list);
+}
+
+#endif /* _LINUX_TQUEUE_H */
+
+#if !defined(_LINUX_TQUEUE_H_INLINES) && defined(_TASK_STRUCT_DEFINED)
+#define _LINUX_TQUEUE_H_INLINES
+/*
  * Queue a task on a tq.  Return non-zero if it was successfully
  * added.
  */
@@ -90,17 +106,4 @@
 	}
 	return ret;
 }
-
-/*
- * Call all "bottom halfs" on a given list.
- */
-
-extern void __run_task_queue(task_queue *list);
-
-static inline void run_task_queue(task_queue *list)
-{
-	if (TQ_ACTIVE(*list))
-		__run_task_queue(list);
-}
-
-#endif /* _LINUX_TQUEUE_H */
+#endif
diff -Nur 2.4.2/kernel/exit.c linux/kernel/exit.c
--- 2.4.2/kernel/exit.c	Wed Mar 14 12:16:14 2001
+++ linux/kernel/exit.c	Wed Mar 14 12:22:10 2001
@@ -276,6 +276,10 @@
 struct mm_struct * start_lazy_tlb(void)
 {
 	struct mm_struct *mm = current->mm;
+#ifdef CONFIG_PREEMPT
+	if (in_ctx_sw_off() == 0)
+		BUG();
+#endif
 	current->mm = NULL;
 	/* active_mm is still 'mm' */
 	atomic_inc(&mm->mm_count);
@@ -287,6 +291,10 @@
 {
 	struct mm_struct *active_mm = current->active_mm;
 
+#ifdef CONFIG_PREEMPT
+	if (in_ctx_sw_off() == 0)
+		BUG();
+#endif
 	current->mm = mm;
 	if (mm != active_mm) {
 		current->active_mm = mm;
@@ -310,8 +318,8 @@
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
 		tsk->mm = NULL;
-		task_unlock(tsk);
 		enter_lazy_tlb(mm, current, smp_processor_id());
+		task_unlock(tsk);
 		mmput(mm);
 	}
 }
diff -Nur 2.4.2/kernel/fork.c linux/kernel/fork.c
--- 2.4.2/kernel/fork.c	Wed Mar 14 12:14:12 2001
+++ linux/kernel/fork.c	Wed Mar 14 12:19:57 2001
@@ -594,6 +594,12 @@
 	if (p->binfmt && p->binfmt->module)
 		__MOD_INC_USE_COUNT(p->binfmt->module);
 
+#ifdef CONFIG_PREEMPT
+        /* Since we are keeping the context switch off state as part
+         * of the context, make sure we start with it off.
+         */
+	p->preempt_count.counter = 1;
+#endif
 	p->did_exec = 0;
 	p->swappable = 0;
 	p->state = TASK_UNINTERRUPTIBLE;
diff -Nur 2.4.2/kernel/ksyms.c linux/kernel/ksyms.c
--- 2.4.2/kernel/ksyms.c	Wed Mar 14 12:16:28 2001
+++ linux/kernel/ksyms.c	Wed Mar 14 12:22:27 2001
@@ -427,6 +427,9 @@
 EXPORT_SYMBOL(interruptible_sleep_on);
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 EXPORT_SYMBOL(schedule);
+#ifdef CONFIG_PREEMPT
+EXPORT_SYMBOL(preempt_schedule);
+#endif
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(xtime);
diff -Nur 2.4.2/kernel/sched.c linux/kernel/sched.c
--- 2.4.2/kernel/sched.c	Wed Mar 14 12:13:59 2001
+++ linux/kernel/sched.c	Wed Mar 14 12:19:41 2001
@@ -443,7 +443,7 @@
 	task_lock(prev);
 	prev->has_cpu = 0;
 	mb();
-	if (prev->state == TASK_RUNNING)
+	if (task_on_runqueue(prev))
 		goto needs_resched;
 
 out_unlock:
@@ -473,7 +473,7 @@
 			goto out_unlock;
 
 		spin_lock_irqsave(&runqueue_lock, flags);
-		if (prev->state == TASK_RUNNING)
+		if (task_on_runqueue(prev))
 			reschedule_idle(prev);
 		spin_unlock_irqrestore(&runqueue_lock, flags);
 		goto out_unlock;
@@ -486,6 +486,9 @@
 void schedule_tail(struct task_struct *prev)
 {
 	__schedule_tail(prev);
+#ifdef CONFIG_PREEMPT
+	ctx_sw_on();
+#endif
 }
 
 /*
@@ -505,6 +508,10 @@
 	struct list_head *tmp;
 	int this_cpu, c;
 
+#ifdef CONFIG_PREEMPT
+	ctx_sw_off(); 
+#endif
+
 	if (!current->active_mm) BUG();
 need_resched_back:
 	prev = current;
@@ -540,7 +547,14 @@
 				break;
 			}
 		default:
+#ifdef CONFIG_PREEMPT
+			if (prev->state & TASK_PREEMPTED)
+				break;
+#endif
 			del_from_runqueue(prev);
+#ifdef CONFIG_PREEMPT
+		case TASK_PREEMPTED:
+#endif
 		case TASK_RUNNING:
 	}
 	prev->need_resched = 0;
@@ -555,7 +569,7 @@
 	 */
 	next = idle_task(this_cpu);
 	c = -1000;
-	if (prev->state == TASK_RUNNING)
+	if (task_on_runqueue(prev))
 		goto still_running;
 
 still_running_back:
@@ -646,6 +660,9 @@
 	if (current->need_resched)
 		goto need_resched_back;
 
+#ifdef CONFIG_PREEMPT
+	ctx_sw_on_no_preempt(); 
+#endif
 	return;
 
 recalculate:
@@ -1231,3 +1248,15 @@
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current, cpu);
 }
+#ifdef CONFIG_PREEMPT
+asmlinkage void preempt_schedule(void)
+{
+	while (current->need_resched) {
+		ctx_sw_off();
+		current->state |= TASK_PREEMPTED;
+		schedule();
+		current->state &= ~TASK_PREEMPTED;
+		ctx_sw_on_no_preempt();
+	}
+}
+#endif
diff -Nur 2.4.2/lib/dec_and_lock.c linux/lib/dec_and_lock.c
--- 2.4.2/lib/dec_and_lock.c	Wed Mar 14 12:14:15 2001
+++ linux/lib/dec_and_lock.c	Wed Mar 14 12:19:57 2001
@@ -1,4 +1,5 @@
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
 
 /*
diff -Nur 2.4.2/net/socket.c linux/net/socket.c
--- 2.4.2/net/socket.c	Wed Mar 14 12:16:29 2001
+++ linux/net/socket.c	Wed Mar 14 12:22:26 2001
@@ -131,7 +131,7 @@
 
 static struct net_proto_family *net_families[NPROTO];
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 static atomic_t net_family_lockct = ATOMIC_INIT(0);
 static spinlock_t net_family_lock = SPIN_LOCK_UNLOCKED;
 

