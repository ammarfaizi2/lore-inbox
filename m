Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSCAMmm>; Fri, 1 Mar 2002 07:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293068AbSCAMm0>; Fri, 1 Mar 2002 07:42:26 -0500
Received: from slip-202-135-78-141.ad.au.prserv.net ([202.135.78.141]:20864
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S286687AbSCAMmM>; Fri, 1 Mar 2002 07:42:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fast Userspace Mutexes. 
To: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
cc: Hubertus Franke <frankeh@watson.ibm.com>
In-Reply-To: Your message of "Fri, 01 Mar 2002 01:34:35 +1100."
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <19673.1014985996.0@rustcorp.com.au>
Date: Fri, 01 Mar 2002 23:34:13 +1100
Message-Id: <E16gmF8-00057N-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19673.1014985996.1@rustcorp.com.au>

> OK.  New implementation.  Compiles (PPC), but due to personal reasons,
> UNTESTED.  Thanks especially to Hubertus for his prior work and
> feedback.

This patch actually tested on PPC (2.4.18, so may have porting
errors).  Intel is still untested.

Also, updated library version included.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/i386/kernel/entry.S working-2.5.6-pre1-futex/arch/i386/kernel/entry.S
--- linux-2.5.6-pre1/arch/i386/kernel/entry.S	Wed Feb 20 17:56:59 2002
+++ working-2.5.6-pre1-futex/arch/i386/kernel/entry.S	Fri Mar  1 22:52:29 2002
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
+++ working-2.5.6-pre1-futex/arch/i386/kernel/sys_i386.c	Fri Mar  1 22:51:21 2002
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
+++ working-2.5.6-pre1-futex/arch/ppc/kernel/misc.S	Fri Mar  1 22:51:53 2002
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
+++ working-2.5.6-pre1-futex/arch/ppc/kernel/semaphore.c	Fri Mar  1 22:52:06 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/arch/ppc/mm/ppc_mmu.c working-2.5.6-pre1-futex/arch/ppc/mm/ppc_mmu.c
--- linux-2.5.6-pre1/arch/ppc/mm/ppc_mmu.c	Wed Feb 20 17:57:04 2002
+++ working-2.5.6-pre1-futex/arch/ppc/mm/ppc_mmu.c	Fri Mar  1 22:51:25 2002
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
+++ working-2.5.6-pre1-futex/include/asm-i386/atomic.h	Fri Mar  1 22:51:25 2002
@@ -2,6 +2,7 @@
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <asm/system.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -201,4 +202,43 @@
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
+	/* preempt_disable() */
+	old_count = atomic_read(count);
+	tmp = old_count > 0 ? old_count : 0;
+	atomic_set(count, tmp + incr);
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
+++ working-2.5.6-pre1-futex/include/asm-i386/unistd.h	Fri Mar  1 22:53:20 2002
@@ -243,6 +243,8 @@
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
+#define __NR_futex_region	239
+#define __NR_futex		240
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/asm-ppc/atomic.h working-2.5.6-pre1-futex/include/asm-ppc/atomic.h
--- linux-2.5.6-pre1/include/asm-ppc/atomic.h	Wed Feb 20 17:57:18 2002
+++ working-2.5.6-pre1-futex/include/asm-ppc/atomic.h	Fri Mar  1 22:58:34 2002
@@ -198,5 +198,32 @@
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
+#define __HAVE_ARCH_UPDATE_COUNT
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
+++ working-2.5.6-pre1-futex/include/asm-ppc/unistd.h	Fri Mar  1 22:52:52 2002
@@ -228,6 +228,8 @@
 #define __NR_removexattr	218
 #define __NR_lremovexattr	219
 #define __NR_fremovexattr	220
+#define __NR_futex_region	221
+#define __NR_futex		222
 
 #define __NR(n)	#n
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/linux/hash.h working-2.5.6-pre1-futex/include/linux/hash.h
--- linux-2.5.6-pre1/include/linux/hash.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.6-pre1-futex/include/linux/hash.h	Fri Mar  1 22:51:25 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/include/linux/mmzone.h working-2.5.6-pre1-futex/include/linux/mmzone.h
--- linux-2.5.6-pre1/include/linux/mmzone.h	Fri Mar  1 22:58:34 2002
+++ working-2.5.6-pre1-futex/include/linux/mmzone.h	Fri Mar  1 23:10:14 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/kernel/Makefile working-2.5.6-pre1-futex/kernel/Makefile
--- linux-2.5.6-pre1/kernel/Makefile	Wed Feb 20 17:56:17 2002
+++ working-2.5.6-pre1-futex/kernel/Makefile	Fri Mar  1 22:53:36 2002
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
+++ working-2.5.6-pre1-futex/kernel/futex.c	Fri Mar  1 23:00:20 2002
@@ -0,0 +1,162 @@
+/*
+ *  Fast Userspace Mutexes (which I call "Futexes!").
+ *  (C) Rusty Russell, IBM 2002
+ *
+ *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
+ *  enough at me, Linus for the original (flawed) idea, Matthew
+ *  Kirkwood for proof-of-concept implementation.
+ *
+ *  "The frutexes are also cursed."
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
+static inline wait_queue_head_t *hash_usem(struct page *page,
+					   unsigned long offset)
+{
+	unsigned long h;
+
+	/* If someone is sleeping, page is pinned.  ie. page address
+           is a constant when we care about it. */
+	h = (unsigned long)page_address(page) + page->index + offset;
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
+			     &page,
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
+	struct page *page;
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
+		ret = usem_up(wq, page_address(page) + pos_in_page);
+		break;
+	case -1:
+		ret = usem_down(wq, page_address(page) + pos_in_page);
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/mm/filemap.c working-2.5.6-pre1-futex/mm/filemap.c
--- linux-2.5.6-pre1/mm/filemap.c	Wed Feb 27 14:45:43 2002
+++ working-2.5.6-pre1-futex/mm/filemap.c	Fri Mar  1 23:10:14 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre1/mm/page_alloc.c working-2.5.6-pre1-futex/mm/page_alloc.c
--- linux-2.5.6-pre1/mm/page_alloc.c	Wed Feb 20 17:57:21 2002
+++ working-2.5.6-pre1-futex/mm/page_alloc.c	Fri Mar  1 23:10:14 2002
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


------- =_aaaaaaaaaa0
Content-Type: application/octet-stream; name="usem.tar.gz"
Content-ID: <19673.1014985996.2@rustcorp.com.au>
Content-Description: usem userspace library
Content-Transfer-Encoding: base64

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

------- =_aaaaaaaaaa0--
