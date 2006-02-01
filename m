Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWBAJNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWBAJNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWBAJD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:29 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:48969 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751491AbWBAJDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:23 -0500
Message-Id: <20060201090322.252374000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:29 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Keith Owens <kaos@sgi.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 05/44] generic {,test_and_}{set,clear,change}_bit()
Content-Disposition: inline; filename=atomic-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

void set_bit(int nr, volatile unsigned long *addr);
void clear_bit(int nr, volatile unsigned long *addr);
void change_bit(int nr, volatile unsigned long *addr);
int test_and_set_bit(int nr, volatile unsigned long *addr);
int test_and_clear_bit(int nr, volatile unsigned long *addr);
int test_and_change_bit(int nr, volatile unsigned long *addr);

In include/asm-generic/bitops/atomic.h

This code largely copied from:

include/asm-powerpc/bitops.h
include/asm-parisc/bitops.h
include/asm-parisc/atomic.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/atomic.h |  191 ++++++++++++++++++++++++++++++++++++
 1 files changed, 191 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/atomic.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/atomic.h
@@ -0,0 +1,191 @@
+#ifndef _ASM_GENERIC_BITOPS_ATOMIC_H_
+#define _ASM_GENERIC_BITOPS_ATOMIC_H_
+
+#include <asm/types.h>
+
+#define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
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
+/*
+ * NMI events can occur at any time, including when interrupts have been
+ * disabled by *_irqsave().  So you can get NMI events occurring while a
+ * *_bit fucntion is holding a spin lock.  If the NMI handler also wants
+ * to do bit manipulation (and they do) then you can get a deadlock
+ * between the original caller of *_bit() and the NMI handler.
+ *
+ * by Keith Owens
+ */
+
+/**
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This function is atomic and may not be reordered.  See __set_bit()
+ * if you do not require the atomic guarantees.
+ *
+ * Note: there are no guarantees that this function will not be reordered
+ * on non x86 architectures, so if you are writting portable code,
+ * make sure not to rely on its reordering guarantees.
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
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
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
+ */
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
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
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
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It may be reordered on other architectures than x86.
+ * It also implies a memory barrier.
+ */
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
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reorderdered on other architectures other than x86.
+ * It also implies a memory barrier.
+ */
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old & ~mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+
+	return (old & mask) != 0;
+}
+
+/**
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It also implies a memory barrier.
+ */
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old;
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(p, flags);
+	old = *p;
+	*p = old ^ mask;
+	_atomic_spin_unlock_irqrestore(p, flags);
+
+	return (old & mask) != 0;
+}
+
+#endif /* _ASM_GENERIC_BITOPS_ATOMIC_H */

--
