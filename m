Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032309AbWLGPcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032309AbWLGPcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032306AbWLGPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:32:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032302AbWLGPcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:32:25 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] WorkStruct: Add assign_bits() to give an atomic-bitops safe assignment
Date: Thu, 07 Dec 2006 15:31:41 +0000
To: torvalds@osdl.org, akpm@osdl.org, davem@davemloft.com, wli@holomorphy.com,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061207153141.28408.69303.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com>
References: <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add assign_bits() to give an atomic-bitops safe assignment on all archs without
the need for cmpxchg().

This is needed where archs emulate atomic bitops using spinlocks as there's a
gap between reading the counter and updating it that a direct assignment could
get lost in.

Emulation by simply disabling interrupts on a UP-only arch should be sufficient
to permit direct assignment to work, provided NMI doesn't try to do bitops.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/sparc/lib/bitops.S                  |   24 +++++++++++++++++++++++
 include/asm-alpha/bitops.h               |    1 +
 include/asm-arm/bitops.h                 |   26 ++++++++++++++++++++++++
 include/asm-arm26/bitops.h               |    9 ++++++++
 include/asm-avr32/bitops.h               |    1 +
 include/asm-cris/bitops.h                |    1 +
 include/asm-frv/bitops.h                 |    1 +
 include/asm-generic/bitops/assign-bits.h |   32 ++++++++++++++++++++++++++++++
 include/asm-generic/bitops/atomic.h      |   21 ++++++++++++++++++++
 include/asm-h8300/bitops.h               |    1 +
 include/asm-i386/bitops.h                |    1 +
 include/asm-ia64/bitops.h                |    1 +
 include/asm-m32r/bitops.h                |    1 +
 include/asm-m68k/bitops.h                |    1 +
 include/asm-m68knommu/bitops.h           |    1 +
 include/asm-mips/bitops.h                |    1 +
 include/asm-parisc/bitops.h              |    9 ++++++++
 include/asm-powerpc/bitops.h             |    1 +
 include/asm-s390/bitops.h                |    2 ++
 include/asm-sh/bitops.h                  |    1 +
 include/asm-sh64/bitops.h                |    1 +
 include/asm-sparc/bitops.h               |   21 ++++++++++++++++++++
 include/asm-sparc64/bitops.h             |    1 +
 include/asm-v850/bitops.h                |    1 +
 include/asm-x86_64/bitops.h              |    1 +
 25 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/lib/bitops.S b/arch/sparc/lib/bitops.S
index cb7fb66..d6b9491 100644
--- a/arch/sparc/lib/bitops.S
+++ b/arch/sparc/lib/bitops.S
@@ -105,5 +105,29 @@ #endif
 	jmpl	%o7, %g0
 	 mov	%g4, %o7
 
+	/* And then just replace all the bits with those from %g2. */
+	.globl	___assign_bits
+___assign_bits:
+	rd	%psr, %g3
+	nop; nop; nop
+	or	%g3, PSR_PIL, %g5
+	wr	%g5, 0x0, %psr
+	nop; nop; nop
+#ifdef CONFIG_SMP
+	set	bitops_spinlock, %g5
+2:	ldstub	[%g5], %g7		! Spin on the byte lock for SMP.
+	orcc	%g7, 0x0, %g0		! Did we get it?
+	bne	2b			! Nope...
+	st	%g2, [%g1]
+	set	bitops_spinlock, %g5
+	stb	%g0, [%g5]
+#else
+	st	%g2, [%g1]
+#endif
+	wr	%g3, 0x0, %psr
+	nop; nop; nop
+	jmpl	%o7, %g0
+	 mov	%g4, %o7
+
 	.globl  __bitops_end
 __bitops_end:
diff --git a/include/asm-alpha/bitops.h b/include/asm-alpha/bitops.h
index 4b6ef7f..1263b26 100644
--- a/include/asm-alpha/bitops.h
+++ b/include/asm-alpha/bitops.h
@@ -2,6 +2,7 @@ #ifndef _ALPHA_BITOPS_H
 #define _ALPHA_BITOPS_H
 
 #include <asm/compiler.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 /*
  * Copyright 1994, Linus Torvalds.
diff --git a/include/asm-arm/bitops.h b/include/asm-arm/bitops.h
index b41831b..5932134 100644
--- a/include/asm-arm/bitops.h
+++ b/include/asm-arm/bitops.h
@@ -117,6 +117,32 @@ ____atomic_test_and_change_bit(unsigned 
 	return res & mask;
 }
 
+#if __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_32v6K)
+static inline void assign_bits(unsigned long v, unsigned long *addr)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__("@ atomic_set\n"
+"1:	ldrex	%0, [%1]\n"
+"	strex	%0, %2, [%1]\n"
+"	teq	%0, #0\n"
+"	bne	1b"
+	: "=&r" (tmp)
+	: "r" (addr), "r" (v)
+	: "cc");
+}
+
+#else
+static inline void assign_bits(unsigned long v, unsigned long *addr)
+{
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	*addr = v;
+	raw_local_irq_restore(flags);
+}
+#endif
+
 #include <asm-generic/bitops/non-atomic.h>
 
 /*
diff --git a/include/asm-arm26/bitops.h b/include/asm-arm26/bitops.h
index 19a6957..9b489c0 100644
--- a/include/asm-arm26/bitops.h
+++ b/include/asm-arm26/bitops.h
@@ -117,6 +117,15 @@ ____atomic_test_and_change_bit(unsigned 
 	return res & mask;
 }
 
+static inline void assign_bits(unsigned long v, unsigned long *addr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	*addr = v;
+	local_irq_restore(flags);
+}
+
 #include <asm-generic/bitops/non-atomic.h>
 
 /*
diff --git a/include/asm-avr32/bitops.h b/include/asm-avr32/bitops.h
index 5299f8c..11d8fb0 100644
--- a/include/asm-avr32/bitops.h
+++ b/include/asm-avr32/bitops.h
@@ -230,6 +230,7 @@ static inline int test_and_change_bit(in
 	return (old & mask) != 0;
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 /* Find First bit Set */
diff --git a/include/asm-cris/bitops.h b/include/asm-cris/bitops.h
index a569065..8ea3dc9 100644
--- a/include/asm-cris/bitops.h
+++ b/include/asm-cris/bitops.h
@@ -141,6 +141,7 @@ static inline int test_and_change_bit(in
 	return retval;
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 /*
diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 1f70d47..3af3a03 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -157,6 +157,7 @@ (__builtin_constant_p(nr) ? \
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/find.h>
 
 /**
diff --git a/include/asm-generic/bitops/assign-bits.h b/include/asm-generic/bitops/assign-bits.h
new file mode 100644
index 0000000..db6d5b2
--- /dev/null
+++ b/include/asm-generic/bitops/assign-bits.h
@@ -0,0 +1,32 @@
+/* Safely assign a value to a word modified by atomic bitops
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_GENERIC_BITOPS_ASSIGN_BITS_H
+#define _ASM_GENERIC_BITOPS_ASSIGN_BITS_H
+
+/**
+ * assign_bits - Safely assign to a word containing atomically modified bits
+ * @v: Value to assign to the word
+ * @addr: The word to modify
+ *
+ * Safely assign a value to a word that contains bits that are atomically
+ * modified by such as clear_bit() or test_and_set_bit().
+ *
+ * On some arches direct assignment isn't safe because the bitops have to be
+ * implemented using spinlocks to gain atomicity - which means they're only
+ * safe with respect to related operations.
+ */
+static inline void assign_bits(unsigned long v, unsigned long *addr)
+{
+	*addr = v;
+}
+
+#endif /* _ASM_GENERIC_BITOPS_ASSIGN_BITS_H */
diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 7833931..32d2ca7 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -188,4 +188,25 @@ static inline int test_and_change_bit(in
 	return (old & mask) != 0;
 }
 
+/**
+ * assign_bits - Safely assign to a word containing atomically modified bits
+ * @v: Value to assign to the word
+ * @addr: The word to modify
+ *
+ * Safely assign a value to a word that contains bits that are atomically
+ * modified by such as clear_bit() or test_and_set_bit().
+ *
+ * Direct assignment isn't safe if bitops are implemented using spinlocks to
+ * gain atomicity - which means they're only safe with respect to related
+ * operations.
+ */
+static inline void assign_bits(unsigned long v, volatile unsigned long *addr)
+{
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(addr, flags);
+	*addr = v;
+	_atomic_spin_unlock_irqrestore(addr, flags);
+}
+
 #endif /* _ASM_GENERIC_BITOPS_ATOMIC_H */
diff --git a/include/asm-h8300/bitops.h b/include/asm-h8300/bitops.h
index d76299c..d5dea31 100644
--- a/include/asm-h8300/bitops.h
+++ b/include/asm-h8300/bitops.h
@@ -175,6 +175,7 @@ #undef H8300_GEN_TEST_BITOP_CONST
 #undef H8300_GEN_TEST_BITOP_CONST_INT
 #undef H8300_GEN_TEST_BITOP
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/ffs.h>
 
 static __inline__ unsigned long __ffs(unsigned long word)
diff --git a/include/asm-i386/bitops.h b/include/asm-i386/bitops.h
index 1c780fa..51ea0bb 100644
--- a/include/asm-i386/bitops.h
+++ b/include/asm-i386/bitops.h
@@ -7,6 +7,7 @@ #define _I386_BITOPS_H
 
 #include <linux/compiler.h>
 #include <asm/alternative.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 /*
  * These have to be done with inline assembly: that way the bit-setting
diff --git a/include/asm-ia64/bitops.h b/include/asm-ia64/bitops.h
index 6cc517e..452e565 100644
--- a/include/asm-ia64/bitops.h
+++ b/include/asm-ia64/bitops.h
@@ -12,6 +12,7 @@ #define _ASM_IA64_BITOPS_H
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <asm/intrinsics.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 /**
  * set_bit - Atomically set a bit in memory
diff --git a/include/asm-m32r/bitops.h b/include/asm-m32r/bitops.h
index 66ab672..bb67351 100644
--- a/include/asm-m32r/bitops.h
+++ b/include/asm-m32r/bitops.h
@@ -243,6 +243,7 @@ static __inline__ int test_and_change_bi
 	return (oldbit != 0);
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/__ffs.h>
diff --git a/include/asm-m68k/bitops.h b/include/asm-m68k/bitops.h
index 1a61fdb..8a302ce 100644
--- a/include/asm-m68k/bitops.h
+++ b/include/asm-m68k/bitops.h
@@ -9,6 +9,7 @@ #define _M68K_BITOPS_H
  */
 
 #include <linux/compiler.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 /*
  * Require 68020 or better.
diff --git a/include/asm-m68knommu/bitops.h b/include/asm-m68knommu/bitops.h
index d7fa7d9..75792ba 100644
--- a/include/asm-m68knommu/bitops.h
+++ b/include/asm-m68knommu/bitops.h
@@ -15,6 +15,7 @@ #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index 06445de..cd18bf9 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -382,6 +382,7 @@ static inline int test_and_change_bit(un
 	smp_mb();
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 /*
diff --git a/include/asm-parisc/bitops.h b/include/asm-parisc/bitops.h
index 9005619..416bd99 100644
--- a/include/asm-parisc/bitops.h
+++ b/include/asm-parisc/bitops.h
@@ -102,6 +102,15 @@ static __inline__ int test_and_change_bi
 	return (oldbit & mask) ? 1 : 0;
 }
 
+static inline void assign_bits(unsigned long v, volatile unsigned long *addr)
+{
+	unsigned long flags;
+
+	_atomic_spin_lock_irqsave(addr, flags);
+	*addr = v;
+	_atomic_spin_unlock_irqrestore(addr, flags);
+}
+
 #include <asm-generic/bitops/non-atomic.h>
 
 #ifdef __KERNEL__
diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
index c341063..04fe968 100644
--- a/include/asm-powerpc/bitops.h
+++ b/include/asm-powerpc/bitops.h
@@ -184,6 +184,7 @@ static __inline__ void set_bits(unsigned
 	: "cc");
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 /*
diff --git a/include/asm-s390/bitops.h b/include/asm-s390/bitops.h
index f79c9b7..653b965 100644
--- a/include/asm-s390/bitops.h
+++ b/include/asm-s390/bitops.h
@@ -409,6 +409,8 @@ #define test_and_clear_bit  test_and_cle
 #define test_and_change_bit test_and_change_bit_simple
 #endif
 
+#include <asm-generic/bitops/assign-bits.h>
+
 
 /*
  * This routine doesn't need to be atomic.
diff --git a/include/asm-sh/bitops.h b/include/asm-sh/bitops.h
index 1c16792..342d05a 100644
--- a/include/asm-sh/bitops.h
+++ b/include/asm-sh/bitops.h
@@ -98,6 +98,7 @@ static inline int test_and_change_bit(in
 	return retval;
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 static inline unsigned long ffz(unsigned long word)
diff --git a/include/asm-sh64/bitops.h b/include/asm-sh64/bitops.h
index f3bdcdb..b299e6c 100644
--- a/include/asm-sh64/bitops.h
+++ b/include/asm-sh64/bitops.h
@@ -109,6 +109,7 @@ static __inline__ int test_and_change_bi
 	return retval;
 }
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 static __inline__ unsigned long ffz(unsigned long word)
diff --git a/include/asm-sparc/bitops.h b/include/asm-sparc/bitops.h
index 04aa331..fa729e4 100644
--- a/include/asm-sparc/bitops.h
+++ b/include/asm-sparc/bitops.h
@@ -152,6 +152,27 @@ static inline void change_bit(unsigned l
 	: "memory", "cc");
 }
 
+static inline void assign_bits(unsigned long v, volatile unsigned long *addr)
+{
+	register unsigned long value asm("g2");
+	register unsigned long *ADDR asm("g1");
+	register int tmp1 asm("g3");
+	register int tmp2 asm("g4");
+	register int tmp3 asm("g5");
+	register int tmp4 asm("g7");
+
+	ADDR = (unsigned long *) addr;
+	value = v;
+
+	__asm__ __volatile__(
+	"mov	%%o7, %%g4\n\t"
+	"call	___assign_bits\n\t"
+	" add	%%o7, 8, %%o7\n"
+	: "=&r" (value), "=r" (tmp1), "=r" (tmp2), "=r" (tmp3), "=r" (tmp4)
+	: "0" (value), "r" (ADDR)
+	: "memory", "cc");
+}
+
 #include <asm-generic/bitops/non-atomic.h>
 
 #define smp_mb__before_clear_bit()	do { } while(0)
diff --git a/include/asm-sparc64/bitops.h b/include/asm-sparc64/bitops.h
index 3d5e1af..a8f7ef1 100644
--- a/include/asm-sparc64/bitops.h
+++ b/include/asm-sparc64/bitops.h
@@ -17,6 +17,7 @@ extern void set_bit(unsigned long nr, vo
 extern void clear_bit(unsigned long nr, volatile unsigned long *addr);
 extern void change_bit(unsigned long nr, volatile unsigned long *addr);
 
+#include <asm-generic/bitops/assign-bits.h>
 #include <asm-generic/bitops/non-atomic.h>
 
 #ifdef CONFIG_SMP
diff --git a/include/asm-v850/bitops.h b/include/asm-v850/bitops.h
index 1fa99ba..3bd8fbb 100644
--- a/include/asm-v850/bitops.h
+++ b/include/asm-v850/bitops.h
@@ -22,6 +22,7 @@ #include <asm/system.h>		/* interrupt en
 #ifdef __KERNEL__
 
 #include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 /*
  * The __ functions are not atomic
diff --git a/include/asm-x86_64/bitops.h b/include/asm-x86_64/bitops.h
index 5b535ea..3eaa848 100644
--- a/include/asm-x86_64/bitops.h
+++ b/include/asm-x86_64/bitops.h
@@ -6,6 +6,7 @@ #define _X86_64_BITOPS_H
  */
 
 #include <asm/alternative.h>
+#include <asm-generic/bitops/assign-bits.h>
 
 #define ADDR (*(volatile long *) addr)
 
