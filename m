Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWHCA1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWHCA1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWHCAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:52 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:43737 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750900AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002518.061401577@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:12 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Content-Disposition: inline; filename=002-sync-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add "always lock'd" implementations of set_bit, clear_bit and
change_bit and the corresponding test_and_ functions.  Also add
"always lock'd" implementation of cmpxchg.  These give guaranteed
strong synchronisation and are required for non-SMP kernels running on
an SMP hypervisor.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Christoph Lameter <clameter@sgi.com>

---
 include/asm-i386/sync_bitops.h |  156 ++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/system.h      |   36 +++++++++
 2 files changed, 192 insertions(+)


===================================================================
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -261,6 +261,9 @@ static inline unsigned long __xchg(unsig
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
+#define sync_cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__sync_cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
 #endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
@@ -282,6 +285,39 @@ static inline unsigned long __cmpxchg(vo
 		return prev;
 	case 4:
 		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+
+/*
+ * Always use locked operations when touching memory shared with a
+ * hypervisor, since the system may be SMP even if the guest kernel
+ * isn't.
+ */
+static inline unsigned long __sync_cmpxchg(volatile void *ptr,
+					    unsigned long old,
+					    unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__("lock; cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__("lock; cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__("lock; cmpxchgl %1,%2"
 				     : "=a"(prev)
 				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
 				     : "memory");
===================================================================
--- /dev/null
+++ b/include/asm-i386/sync_bitops.h
@@ -0,0 +1,156 @@
+#ifndef _I386_SYNC_BITOPS_H
+#define _I386_SYNC_BITOPS_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ */
+
+/*
+ * These have to be done with inline assembly: that way the bit-setting
+ * is guaranteed to be atomic. All bit operations return 0 if the bit
+ * was cleared before the operation and != 0 if it was not.
+ *
+ * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
+ */
+
+#define ADDR (*(volatile long *) addr)
+
+/**
+ * sync_set_bit - Atomically set a bit in memory
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
+static inline void sync_set_bit(int nr, volatile unsigned long * addr)
+{
+	__asm__ __volatile__("lock; btsl %1,%0"
+			     :"+m" (ADDR)
+			     :"Ir" (nr)
+			     : "memory");
+}
+
+/**
+ * sync_clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * sync_clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
+ */
+static inline void sync_clear_bit(int nr, volatile unsigned long * addr)
+{
+	__asm__ __volatile__("lock; btrl %1,%0"
+			     :"+m" (ADDR)
+			     :"Ir" (nr)
+			     : "memory");
+}
+
+/**
+ * sync_change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void sync_change_bit(int nr, volatile unsigned long * addr)
+{
+	__asm__ __volatile__("lock; btcl %1,%0"
+			     :"+m" (ADDR)
+			     :"Ir" (nr)
+			     : "memory");
+}
+
+/**
+ * sync_test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It may be reordered on other architectures than x86.
+ * It also implies a memory barrier.
+ */
+static inline int sync_test_and_set_bit(int nr, volatile unsigned long * addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__("lock; btsl %2,%1\n\tsbbl %0,%0"
+			     :"=r" (oldbit),"+m" (ADDR)
+			     :"Ir" (nr) : "memory");
+	return oldbit;
+}
+
+/**
+ * sync_test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reorderdered on other architectures other than x86.
+ * It also implies a memory barrier.
+ */
+static inline int sync_test_and_clear_bit(int nr, volatile unsigned long * addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__("lock; btrl %2,%1\n\tsbbl %0,%0"
+			     :"=r" (oldbit),"+m" (ADDR)
+			     :"Ir" (nr) : "memory");
+	return oldbit;
+}
+
+/**
+ * sync_test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It also implies a memory barrier.
+ */
+static inline int sync_test_and_change_bit(int nr, volatile unsigned long* addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__("lock; btcl %2,%1\n\tsbbl %0,%0"
+			     :"=r" (oldbit),"+m" (ADDR)
+			     :"Ir" (nr) : "memory");
+	return oldbit;
+}
+
+static __always_inline int sync_const_test_bit(int nr, const volatile unsigned long *addr)
+{
+	return ((1UL << (nr & 31)) &
+		(((const volatile unsigned int *)addr)[nr >> 5])) != 0;
+}
+
+static inline int sync_var_test_bit(int nr, const volatile unsigned long * addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__("btl %2,%1\n\tsbbl %0,%0"
+			     :"=r" (oldbit)
+			     :"m" (ADDR),"Ir" (nr));
+	return oldbit;
+}
+
+#define sync_test_bit(nr,addr)			\
+	(__builtin_constant_p(nr) ?		\
+	 sync_constant_test_bit((nr),(addr)) :	\
+	 sync_var_test_bit((nr),(addr)))
+
+#undef ADDR
+
+#endif /* _I386_SYNC_BITOPS_H */

--

