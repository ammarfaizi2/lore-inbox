Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWEIItv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWEIItv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWEIItq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:46 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54915 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751582AbWEIIti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:38 -0400
Message-Id: <20060509085149.024456000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>
Subject: [RFC PATCH 05/35] Add sync bitops
Content-Disposition: inline; filename=synch-ops
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
Cc: Christoph Lameter <clameter@sgi.com>
---
 include/asm-i386/synch_bitops.h |  166 ++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/system.h       |   33 +++++++
 2 files changed, 199 insertions(+)

--- linus-2.6.orig/include/asm-i386/system.h
+++ linus-2.6/include/asm-i386/system.h
@@ -263,6 +263,9 @@ static inline unsigned long __xchg(unsig
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
+#define synch_cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__synch_cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
 #endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
@@ -292,6 +295,36 @@ static inline unsigned long __cmpxchg(vo
 	return old;
 }
 
+#define __LOCK_PREFIX "lock ; "
+static inline unsigned long __synch_cmpxchg(volatile void *ptr,
+					    unsigned long old,
+					    unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__(__LOCK_PREFIX "cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__(__LOCK_PREFIX "cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__(__LOCK_PREFIX "cmpxchgl %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+#undef __LOCK_PREFIX
+
 #ifndef CONFIG_X86_CMPXCHG
 /*
  * Building a kernel capable running on 80386. It may be necessary to
--- /dev/null
+++ linus-2.6/include/asm-i386/synch_bitops.h
@@ -0,0 +1,166 @@
+#ifndef _I386_SYNCH_BITOPS_H
+#define _I386_SYNCH_BITOPS_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ */
+
+/* make sure these are always locked */
+#define __LOCK_PREFIX "lock ; "
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
+ * synch_set_bit - Atomically set a bit in memory
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
+static inline void synch_set_bit(int nr, volatile unsigned long * addr)
+{
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btsl %1,%0"
+		:"+m" (ADDR)
+		:"Ir" (nr)
+		: "memory");
+}
+
+/**
+ * synch_clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * synch_clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
+ */
+static inline void synch_clear_bit(int nr, volatile unsigned long * addr)
+{
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btrl %1,%0"
+		:"+m" (ADDR)
+		:"Ir" (nr)
+		: "memory");
+}
+
+/**
+ * synch_change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void synch_change_bit(int nr, volatile unsigned long * addr)
+{
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btcl %1,%0"
+		:"+m" (ADDR)
+		:"Ir" (nr)
+		: "memory");
+}
+
+/**
+ * synch_test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It may be reordered on other architectures than x86.
+ * It also implies a memory barrier.
+ */
+static inline int synch_test_and_set_bit(int nr, volatile unsigned long * addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btsl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit),"+m" (ADDR)
+		:"Ir" (nr) : "memory");
+	return oldbit;
+}
+
+/**
+ * synch_test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reorderdered on other architectures other than x86.
+ * It also implies a memory barrier.
+ */
+static inline int synch_test_and_clear_bit(int nr, volatile unsigned long * addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btrl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit),"+m" (ADDR)
+		:"Ir" (nr) : "memory");
+	return oldbit;
+}
+
+/**
+ * synch_test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It also implies a memory barrier.
+ */
+static inline int synch_test_and_change_bit(int nr, volatile unsigned long* addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btcl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit),"+m" (ADDR)
+		:"Ir" (nr) : "memory");
+	return oldbit;
+}
+
+static __always_inline int synch_const_test_bit(int nr, const volatile unsigned long *addr)
+{
+	return ((1UL << (nr & 31)) &
+		(((const volatile unsigned int *)addr)[nr >> 5])) != 0;
+}
+
+static inline int synch_var_test_bit(int nr, const volatile unsigned long * addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__(
+		"btl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit)
+		:"m" (ADDR),"Ir" (nr));
+	return oldbit;
+}
+
+#define synch_test_bit(nr,addr) \
+(__builtin_constant_p(nr) ? \
+ synch_constant_test_bit((nr),(addr)) : \
+ synch_var_test_bit((nr),(addr)))
+
+#undef ADDR
+
+#endif /* _I386_SYNCH_BITOPS_H */

--
