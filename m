Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWAZD3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAZD3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWAZD3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:29:14 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:31204 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751296AbWAZD3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:29:13 -0500
Date: Thu, 26 Jan 2006 12:29:18 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 1/12] generic *_bit()
Message-ID: <20060126032918.GB9984@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126032713.GA9984@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

- atomic operation:
void set_bit(int nr, volatile unsigned long *addr);
void clear_bit(int nr, volatile unsigned long *addr);
void change_bit(int nr, volatile unsigned long *addr);
int test_and_set_bit(int nr, volatile unsigned long *addr);
int test_and_clear_bit(int nr, volatile unsigned long *addr);
int test_and_change_bit(int nr, volatile unsigned long *addr);

- non-atomic operation:
void __set_bit(int nr, volatile unsigned long *addr);
void __clear_bit(int nr, volatile unsigned long *addr);
void __change_bit(int nr, volatile unsigned long *addr);
int __test_and_set_bit(int nr, volatile unsigned long *addr);
int __test_and_clear_bit(int nr, volatile unsigned long *addr);
int __test_and_change_bit(int nr, volatile unsigned long *addr);
int test_bit(int nr, const volatile unsigned long *addr);

HAVE_ARCH_ATOMIC_BITOPS is defined when the architecture has its own
{,test_and_}{set,clear,change}_bit()

HAVE_ARCH_NON_ATOMIC_BITOPS is defined when the architecture has its own
__{,test_and_}{set,clear,change}_bit() and test_bit()

This code largely copied from:
include/asm-powerpc/bitops.h
include/asm-parisc/bitops.h
include/asm-parisc/atomic.h


Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:07:14.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:08.000000000 +0900
@@ -1,56 +1,198 @@
 #ifndef _ASM_GENERIC_BITOPS_H_
 #define _ASM_GENERIC_BITOPS_H_
 
+#include <asm/types.h>
+
+#define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+
+#ifndef HAVE_ARCH_ATOMIC_BITOPS
+
+#ifdef CONFIG_SMP
+#include <asm/spinlock.h>
+#include <asm/cache.h>		/* we use L1_CACHE_BYTES */
+
+/* Use an array of spinlocks for our atomic_ts.
+ * Hash function to index into a different SPINLOCK.
+ * Since "a" is usually an address, use one spinlock per cacheline.
+ */
+#  define ATOMIC_HASH_SIZE 4
+#  define ATOMIC_HASH(a) (&(__atomic_hash[ (((unsigned long) a)/L1_CACHE_BYTES) & (ATOMIC_HASH_SIZE-1) ]))
+
+extern raw_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
+
+/* Can't use raw_spin_lock_irq because of #include problems, so
+ * this is the substitute */
+#define _atomic_spin_lock_irqsave(l,f) do {	\
+	raw_spinlock_t *s = ATOMIC_HASH(l);	\
+	local_irq_save(f);			\
+	__raw_spin_lock(s);			\
+} while(0)
+
+#define _atomic_spin_unlock_irqrestore(l,f) do {	\
+	raw_spinlock_t *s = ATOMIC_HASH(l);		\
+	__raw_spin_unlock(s);				\
+	local_irq_restore(f);				\
+} while(0)
+
+
+#else
+#  define _atomic_spin_lock_irqsave(l,f) do { local_irq_save(f); } while (0)
+#  define _atomic_spin_unlock_irqrestore(l,f) do { local_irq_restore(f); } while (0)
+#endif
+
 /*
  * For the benefit of those who are trying to port Linux to another
  * architecture, here are some C-language equivalents.  You should
  * recode these in the native assembly language, if at all possible.
- * To guarantee atomicity, these routines call cli() and sti() to
- * disable interrupts while they operate.  (You have to provide inline
- * routines to cli() and sti().)
  *
- * Also note, these routines assume that you have 32 bit longs.
- * You will have to change this if you are trying to port Linux to the
- * Alpha architecture or to a Cray.  :-)
- * 
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
-extern __inline__ int set_bit(int nr,long * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	*p  |= mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+}
+
+static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	*p &= ~mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+}
+
+static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	*p ^= mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+}
+
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old | mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+
+	return (old & mask) != 0;
+}
+
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
-	int	mask, retval;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old & ~mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	cli();
-	retval = (mask & *addr) != 0;
-	*addr |= mask;
-	sti();
-	return retval;
+	return (old & mask) != 0;
 }
 
-extern __inline__ int clear_bit(int nr, long * addr)
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long *addr)
 {
-	int	mask, retval;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old ^ mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	cli();
-	retval = (mask & *addr) != 0;
-	*addr &= ~mask;
-	sti();
-	return retval;
+	return (old & mask) != 0;
 }
 
-extern __inline__ int test_bit(int nr, const unsigned long * addr)
+#endif /* HAVE_ARCH_ATOMIC_BITOPS */
+
+#ifndef HAVE_ARCH_NON_ATOMIC_BITOPS
+
+static __inline__ void __set_bit(int nr, volatile unsigned long *addr)
 {
-	int	mask;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	return ((mask & *addr) != 0);
+	*p  |= mask;
 }
 
+static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p &= ~mask;
+}
+
+static __inline__ void __change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p ^= mask;
+}
+
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old | mask;
+	return (old & mask) != 0;
+}
+
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old & ~mask;
+	return (old & mask) != 0;
+}
+
+static __inline__ int __test_and_change_bit(int nr,
+					    volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old ^ mask;
+	return (old & mask) != 0;
+}
+
+static __inline__ int test_bit(int nr, __const__ volatile unsigned long *addr)
+{
+	return 1UL & (addr[BITOP_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+}
+
+#endif /* HAVE_ARCH_NON_ATOMIC_BITOPS */
+
 /*
  * fls: find last bit set.
  */
