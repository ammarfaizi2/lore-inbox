Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293122AbSCAMsc>; Fri, 1 Mar 2002 07:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293068AbSCAMsV>; Fri, 1 Mar 2002 07:48:21 -0500
Received: from slip-202-135-78-141.ad.au.prserv.net ([202.135.78.141]:28288
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293122AbSCAMsB>; Fri, 1 Mar 2002 07:48:01 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
cc: Hubertus Franke <frankeh@watson.ibm.com>
Subject: [PATCH] Fast Userspace Mutexes.
Date: Fri, 01 Mar 2002 01:34:35 +1100
Message-Id: <E16gRe3-0006ak-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  New implementation.  Compiles (PPC), but due to personal reasons,
UNTESTED.  Thanks especially to Hubertus for his prior work and
feedback.

1) Turned into syscalls.
2) Added arch-specific sys_futex_region() to enable mutexes on region,
   and give a chance to detect lack of support via -ENOSYS.
3) Just a single atomic_t variable for mutex (thanks Paul M).
	- This means -ENOSYS on SMP 386s, as we need cmpxchg.
	- We can no longer do generic semaphores: mutexes only.
	- Requires arch __update_count atomic op.
4) Current valid args to sys_futex are -1 and +1: we can implement
   other lock types by using other values later (eg. rw locks).

Size of futex.c dropped from 244 to 161 lines, so it's clearly 40%
better!

Get your complaints in now...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/kernel/Makefile working-2.5.6-pre1-futex/kernel/Makefile
--- linux-2.5.6-pre1/kernel/Makefile	Wed Feb 20 17:56:17 2002
+++ working-2.5.6-pre1-futex/kernel/Makefile	Fri Mar  1 01:04:26 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o futex.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/kernel/futex.c working-2.5.6-pre1-futex/kernel/futex.c
--- linux-2.5.6-pre1/kernel/futex.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-pre1-futex/kernel/futex.c	Fri Mar  1 01:01:35 2002
@@ -0,0 +1,161 @@
+/*
+ *  Fast Userspace Mutexes (which I call "Futexes!").
+ *  (C) Rusty Russell, IBM 2002
+ *
+ *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
+ *  enough at me, Linus for the original (flawed) idea, Matthew
+ *  Kirkwood for proof-of-concept implementation.
+ *
+ *  "The futexes are also cursed."
+ *  "But they come in a choice of three flavours!"
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <asm/atomic.h>
+
+#ifdef __HAVE_ARCH_UPDATE_COUNT
+/* FIXME: This may be way too small. --RR */
+#define USEM_HASHBITS 6
+/* The key for the hash is the address + index + offset within page */
+static wait_queue_head_t usem_waits[1<<USEM_HASHBITS];
+
+static inline wait_queue_head_t *hash_usem(const struct page *page,
+					   unsigned long offset)
+{
+	unsigned long h;
+
+	/* If someone is sleeping, page is pinned.  ie. page->virtual
+           is a constant when we care about it. */
+	h = (unsigned long)page->virtual + page->index + offset;
+	return &usem_waits[hash_long(h, USEM_HASHBITS)];
+}
+
+/* Get kernel address of the user page and pin it. */
+static struct page *pin_page(unsigned long page_start)
+{
+	struct mm_struct *mm = current->mm;
+	struct page *page;
+	int err;
+
+	down_read(&mm->mmap_sem);
+	err = get_user_pages(current, current->mm, page_start,
+			     1 /* one page */,
+			     1 /* writable */,
+			     0 /* don't force */,
+			     page,
+			     NULL /* don't return vmas */);
+	up_read(&mm->mmap_sem);
+
+	if (err < 0)
+		return ERR_PTR(err);
+	return page;
+}
+
+/* Stolen from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
+static int usem_down(wait_queue_head_t *wq, atomic_t *count)
+{
+	int retval = 0;
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	tsk->state = TASK_INTERRUPTIBLE;
+	add_wait_queue(wq, &wait);
+	smp_wmb();
+
+	/* Try to get the semaphore.  If the count is > 0, then we've
+	 * got the semaphore; we decrease count and exit the loop.
+	 * If the count is 0 or negative, we set it to -ve, indicating
+	 * that we are asleep, and then sleep.  */
+	while (__update_count(count, -1) <= 0) {
+		if (signal_pending(current)) {
+			/* A signal is pending - give up trying.  Set
+			 * sem->count to 0 if it is negative, since we
+			 * are no longer sleeping. */
+			__update_count(count, 0);
+			retval = -EINTR;
+			break;
+		}
+		schedule();
+		tsk->state = TASK_INTERRUPTIBLE;
+	}
+	tsk->state = TASK_RUNNING;
+	remove_wait_queue(wq, &wait);
+	return retval;
+}
+
+static int usem_up(wait_queue_head_t *wq, atomic_t *count)
+{
+	__update_count(count, 1);
+	wake_up(wq);
+	return 0;
+}
+
+asmlinkage int sys_futex(void *uaddr, int op)
+{
+	int ret;
+	unsigned long pos_in_page;
+	wait_queue_head_t *wq;
+
+	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
+
+	/* Must be "naturally" aligned, and not on page boundary. */
+	if ((pos_in_page % __alignof__(atomic_t)) != 0
+	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
+		return -EINVAL;
+
+	/* Simpler if it doesn't vanish underneath us. */
+	page = pin_page((unsigned long)uaddr - pos_in_page);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	wq = hash_usem(page, pos_in_page);
+
+	switch (op) {
+	case 1:
+		ret = usem_up(wq, page->virtual + pos_in_page);
+		break;
+	case -1:
+		ret = usem_down(wq, page->virtual + pos_in_page);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	put_page(page);
+	return ret;
+}
+
+static int __init init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(usem_waits); i++)
+		init_waitqueue_head(&usem_waits[i]);
+	return 0;
+}
+__initcall(init);
+
+#else /* if we don't __HAVE_ARCH_UPDATE_COUNT */
+asmlinkage int sys_futex(void *uaddr, int op)
+{
+	return -ENOSYS;
+}
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/i386/kernel/entry.S working-2.5.6-pre1-futex/arch/i386/kernel/entry.S
--- linux-2.5.6-pre1/arch/i386/kernel/entry.S	Wed Feb 20 17:56:59 2002
+++ working-2.5.6-pre1-futex/arch/i386/kernel/entry.S	Fri Mar  1 01:03:27 2002
@@ -716,6 +716,8 @@
 	.long SYMBOL_NAME(sys_lremovexattr)
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
+	.long SYMBOL_NAME(sys_futex_region)
+	.long SYMBOL_NAME(sys_futex)		/* 240 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/i386/kernel/sys_i386.c working-2.5.6-pre1-futex/arch/i386/kernel/sys_i386.c
--- linux-2.5.6-pre1/arch/i386/kernel/sys_i386.c	Tue Mar 20 07:35:09 2001
+++ working-2.5.6-pre1-futex/arch/i386/kernel/sys_i386.c	Fri Mar  1 01:01:27 2002
@@ -254,3 +254,13 @@
 	return -ERESTARTNOHAND;
 }
 
+/* Nothing special needs to be done to use atomic ops in userspace */
+asmlinkage int sys_futex_region(const void *uaddr, size_t len)
+{
+#ifndef __HAVE_ARCH_UPDATE_COUNT
+	/* Give them warning that SMP 386 kernels don't support this. */
+	return -ENOSYS;
+#else
+	return 0;
+#endif
+}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/ppc/kernel/misc.S working-2.5.6-pre1-futex/arch/ppc/kernel/misc.S
--- linux-2.5.6-pre1/arch/ppc/kernel/misc.S	Wed Feb 20 17:57:04 2002
+++ working-2.5.6-pre1-futex/arch/ppc/kernel/misc.S	Fri Mar  1 01:03:00 2002
@@ -1246,6 +1246,8 @@
 	.long sys_removexattr
 	.long sys_lremovexattr
 	.long sys_fremovexattr	/* 220 */
+	.long sys_futex_region
+	.long sys_futex
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/ppc/kernel/semaphore.c working-2.5.6-pre1-futex/arch/ppc/kernel/semaphore.c
--- linux-2.5.6-pre1/arch/ppc/kernel/semaphore.c	Wed Feb 20 17:57:04 2002
+++ working-2.5.6-pre1-futex/arch/ppc/kernel/semaphore.c	Fri Mar  1 01:02:31 2002
@@ -21,34 +21,6 @@
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 
-/*
- * Atomically update sem->count.
- * This does the equivalent of the following:
- *
- *	old_count = sem->count;
- *	tmp = MAX(old_count, 0) + incr;
- *	sem->count = tmp;
- *	return old_count;
- */
-static inline int __sem_update_count(struct semaphore *sem, int incr)
-{
-	int old_count, tmp;
-
-	__asm__ __volatile__("\n"
-"1:	lwarx	%0,0,%3\n"
-"	srawi	%1,%0,31\n"
-"	andc	%1,%0,%1\n"
-"	add	%1,%1,%4\n"
-	PPC405_ERR77(0,%3)
-"	stwcx.	%1,0,%3\n"
-"	bne	1b"
-	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
-	: "r" (&sem->count), "r" (incr), "m" (sem->count)
-	: "cc");
-
-	return old_count;
-}
-
 void __up(struct semaphore *sem)
 {
 	/*
@@ -59,7 +31,7 @@
 	 * (i.e. because some other cpu has called up() in the meantime),
 	 * in which case we just increment count.
 	 */
-	__sem_update_count(sem, 1);
+	__update_count(&sem->count, 1);
 	wake_up(&sem->wait);
 }
 
@@ -86,7 +58,7 @@
 	 * If the count is 0 or negative, we set it to -1, indicating
 	 * that we are asleep, and then sleep.
 	 */
-	while (__sem_update_count(sem, -1) <= 0) {
+	while (__update_count(&sem->count, -1) <= 0) {
 		schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
@@ -111,14 +83,14 @@
 	add_wait_queue_exclusive(&sem->wait, &wait);
 	smp_wmb();
 
-	while (__sem_update_count(sem, -1) <= 0) {
+	while (__update_count(&sem->count, -1) <= 0) {
 		if (signal_pending(current)) {
 			/*
 			 * A signal is pending - give up trying.
 			 * Set sem->count to 0 if it is negative,
 			 * since we are no longer sleeping.
 			 */
-			__sem_update_count(sem, 0);
+			__update_count(&sem->count, 0);
 			retval = -EINTR;
 			break;
 		}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/ppc/mm/ppc_mmu.c working-2.5.6-pre1-futex/arch/ppc/mm/ppc_mmu.c
--- linux-2.5.6-pre1/arch/ppc/mm/ppc_mmu.c	Wed Feb 20 17:57:04 2002
+++ working-2.5.6-pre1-futex/arch/ppc/mm/ppc_mmu.c	Fri Mar  1 01:01:35 2002
@@ -304,3 +304,9 @@
 		add_hash_page(mm->context, address, ptep);
 	}
 }
+
+/* Nothing special needs to be done to use atomic ops in userspace */
+asmlinkage int sys_futex_region(const void *uaddr, size_t len)
+{
+	return 0;
+}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/asm-i386/atomic.h working-2.5.6-pre1-futex/include/asm-i386/atomic.h
--- linux-2.5.6-pre1/include/asm-i386/atomic.h	Fri Nov 23 06:46:18 2001
+++ working-2.5.6-pre1-futex/include/asm-i386/atomic.h	Fri Mar  1 01:10:44 2002
@@ -2,6 +2,7 @@
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <asm/system.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -201,4 +202,44 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+/*
+ * Atomically update count.
+ * This does the equivalent of the following:
+ *
+ *	old_count = *count;
+ *	tmp = MAX(old_count, 0) + incr;
+ *	*count = tmp;
+ *	return old_count;
+ */
+#ifdef CONFIG_M386
+#ifndef CONFIG_SMP
+#define __HAVE_ARCH_UPDATE_COUNT
+/* We can still do this (no userspace can be running). */
+static inline int __update_count(atomic_t *count, int incr)
+{
+	int old_count, tmp;
+
+	preempt_disable();
+	old_count = atomic_read(count);
+	tmp = old_count > 0 ? old_count : 0;
+	atomic_set(count, tmp + incr);
+	preempt_enable();
+	return old_count;
+}
+#else
+/* SMP 386 update_count is not possible. 8( */
+#else /* ! 386 */
+#define __HAVE_ARCH_UPDATE_COUNT
+static inline int __update_count(atomic_t *count, int incr)
+{
+	int old_count, tmp;
+
+	do {
+		old_count = atomic_read(count);
+		tmp = old_count > 0 ? old_count : 0;
+	} while (cmpxchg(&count->counter, old_count, tmp + incr) != old_count);
+
+	return old_count;
+}
+#endif /* CONFIG_M386 */
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/asm-i386/unistd.h working-2.5.6-pre1-futex/include/asm-i386/unistd.h
--- linux-2.5.6-pre1/include/asm-i386/unistd.h	Wed Feb 20 17:56:40 2002
+++ working-2.5.6-pre1-futex/include/asm-i386/unistd.h	Fri Mar  1 01:04:17 2002
@@ -243,6 +243,8 @@
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
+#define __NR_futex_region	239
+#define __NR_futex		240
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/asm-ppc/atomic.h working-2.5.6-pre1-futex/include/asm-ppc/atomic.h
--- linux-2.5.6-pre1/include/asm-ppc/atomic.h	Wed Feb 20 17:57:18 2002
+++ working-2.5.6-pre1-futex/include/asm-ppc/atomic.h	Fri Mar  1 01:08:14 2002
@@ -198,5 +198,31 @@
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+/*
+ * Atomically update count.
+ * This does the equivalent of the following:
+ *
+ *	old_count = *count;
+ *	tmp = MAX(old_count, 0) + incr;
+ *	*count = tmp;
+ *	return old_count;
+ */
+static inline int __update_count(atomic_t *count, int incr)
+{
+	int old_count, tmp;
+
+	__asm__ __volatile__("\n"
+"1:	lwarx	%0,0,%3\n"
+"	srawi	%1,%0,31\n"
+"	andc	%1,%0,%1\n"
+"	add	%1,%1,%4\n"
+"	stwcx.	%1,0,%3\n"
+"	bne	1b"
+	: "=&r" (old_count), "=&r" (tmp), "=m" (*count)
+	: "r" (count), "r" (incr), "m" (*count)
+	: "cc");
+
+	return old_count;
+}
 #endif /* __KERNEL__ */
 #endif /* _ASM_PPC_ATOMIC_H_ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/asm-ppc/unistd.h working-2.5.6-pre1-futex/include/asm-ppc/unistd.h
--- linux-2.5.6-pre1/include/asm-ppc/unistd.h	Wed Feb 20 17:57:18 2002
+++ working-2.5.6-pre1-futex/include/asm-ppc/unistd.h	Fri Mar  1 01:03:57 2002
@@ -228,6 +228,8 @@
 #define __NR_removexattr	218
 #define __NR_lremovexattr	219
 #define __NR_fremovexattr	220
+#define __NR_futex_region	221
+#define __NR_futex		222
 
 #define __NR(n)	#n
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/linux/hash.h working-2.5.6-pre1-futex/include/linux/hash.h
--- linux-2.5.6-pre1/include/linux/hash.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-pre1-futex/include/linux/hash.h	Fri Mar  1 01:01:35 2002
@@ -0,0 +1,58 @@
+#ifndef _LINUX_HASH_H
+#define _LINUX_HASH_H
+/* Fast hashing routine for a long.
+   (C) 2002 William Lee Irwin III, IBM */
+
+/*
+ * Knuth recommends primes in approximately golden ratio to the maximum
+ * integer representable by a machine word for multiplicative hashing.
+ * Chuck Lever verified the effectiveness of this technique:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ *
+ * These primes are chosen to be bit-sparse, that is operations on
+ * them can use shifts and additions instead of multiplications for
+ * machines where multiplications are slow.
+ */
+#if BITS_PER_LONG == 32
+/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e370001UL
+#elif BITS_PER_LONG == 64
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
+#else
+#error Define GOLDEN_RATIO_PRIME for your wordsize.
+#endif
+
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	unsigned long hash = val;
+
+#if BITS_PER_LONG == 64
+	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
+	unsigned long n = hash;
+	n <<= 18;
+	hash -= n;
+	n <<= 33;
+	hash -= n;
+	n <<= 3;
+	hash += n;
+	n <<= 3;
+	hash -= n;
+	n <<= 4;
+	hash += n;
+	n <<= 2;
+	hash += n;
+#else
+	/* On some cpus multiply is faster, on others gcc will do shifts */
+	hash *= GOLDEN_RATIO_PRIME;
+#endif
+
+	/* High bits are more random, so use them. */
+	return hash >> (BITS_PER_LONG - bits);
+}
+	
+static inline unsigned long hash_ptr(void *ptr, unsigned int bits)
+{
+	return hash_long((unsigned long)ptr, bits);
+}
+#endif /* _LINUX_HASH_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/include/linux/mmzone.h working-2.5.5-usem/include/linux/mmzone.h
--- linux-2.5.5/include/linux/mmzone.h	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/include/linux/mmzone.h	Thu Feb 21 12:46:30 2002
@@ -51,8 +51,7 @@
 	/*
 	 * wait_table		-- the array holding the hash table
 	 * wait_table_size	-- the size of the hash table array
-	 * wait_table_shift	-- wait_table_size
-	 * 				== BITS_PER_LONG (1 << wait_table_bits)
+	 * wait_table_bits	-- wait_table_size == (1 << wait_table_bits)
 	 *
 	 * The purpose of all these is to keep track of the people
 	 * waiting for a page to become available and make them
@@ -75,7 +74,7 @@
 	 */
 	wait_queue_head_t	* wait_table;
 	unsigned long		wait_table_size;
-	unsigned long		wait_table_shift;
+	unsigned long		wait_table_bits;
 
 	/*
 	 * Discontig memory support fields.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/mm/filemap.c working-2.5.5-usem/mm/filemap.c
--- linux-2.5.5/mm/filemap.c	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/mm/filemap.c	Thu Feb 21 13:01:02 2002
@@ -25,6 +25,7 @@
 #include <linux/iobuf.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/hash.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -773,32 +774,8 @@
 static inline wait_queue_head_t *page_waitqueue(struct page *page)
 {
 	const zone_t *zone = page_zone(page);
-	wait_queue_head_t *wait = zone->wait_table;
-	unsigned long hash = (unsigned long)page;
 
-#if BITS_PER_LONG == 64
-	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
-	unsigned long n = hash;
-	n <<= 18;
-	hash -= n;
-	n <<= 33;
-	hash -= n;
-	n <<= 3;
-	hash += n;
-	n <<= 3;
-	hash -= n;
-	n <<= 4;
-	hash += n;
-	n <<= 2;
-	hash += n;
-#else
-	/* On some cpus multiply is faster, on others gcc will do shifts */
-	hash *= GOLDEN_RATIO_PRIME;
-#endif
-
-	hash >>= zone->wait_table_shift;
-
-	return &wait[hash];
+	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
 /* 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/mm/page_alloc.c working-2.5.5-usem/mm/page_alloc.c
--- linux-2.5.5/mm/page_alloc.c	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/mm/page_alloc.c	Thu Feb 21 12:33:46 2002
@@ -776,8 +776,8 @@
 		 * per zone.
 		 */
 		zone->wait_table_size = wait_table_size(size);
-		zone->wait_table_shift =
-			BITS_PER_LONG - wait_table_bits(zone->wait_table_size);
+		zone->wait_table_bits =
+			wait_table_bits(zone->wait_table_size);
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, zone->wait_table_size
 						* sizeof(wait_queue_head_t));
