Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWCaASU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWCaASU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWCaASU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:18:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36038 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751130AbWCaASS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:18:18 -0500
Date: Thu, 30 Mar 2006 16:18:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Synchronizing Bit operations V2
In-Reply-To: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

V2
	- Fix various oversights
	- Follow Hans Boehm's scheme for the barrier logic

The following patchset implements the ability to specify a
synchronization mode for bit operations.

I.e. instead of set_bit(x,y) we can do set_bit(x,y, mode).

The following modes are supported:

MODE_NON_ATOMIC
	Use non atomic version.
	F.e. set_bit(x,y, MODE_NON_ATOMIC) == __set_bit(x,y)

MODE_ATOMIC
	The operation is atomic but there is no guarantee how this
	operation is ordered respective to other memory operations.

MODE_ACQUIRE
	An atomic operation that is guaranteed to occur before
	all subsequent memory accesses

MODE_RELEASE
	An atomic operation that is guaranteed to occur after
	all previos memory acceses.

MODE_BARRIER
	An atomic operation that is guaranteed to occur between
	previous and later memory operations.

For architectures that have no support for bitops with modes we
fall back to some combination of memory barriers and atomic ops.

This patchset defines architecture support for only IA64.
Others could be done in a similar fashion.

Note that the current semantics for bitops IA64 are broken. Both
smp_mb__after/before_clear_bit are now set to full memory barriers
to compensate which may affect performance.

The kernel core code would need to be fixed to add the proper
synchronization modes to restore prior performance (with then
correct locking semantics). If kernel code wants to use synchronization
modes then an

#include <asm/bitops_mode.h>

needs to be added.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-mm2/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.16-mm2.orig/include/asm-ia64/bitops.h	2006-03-30 15:01:21.000000000 -0800
+++ linux-2.6.16-mm2/include/asm-ia64/bitops.h	2006-03-30 15:44:36.000000000 -0800
@@ -11,6 +11,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <asm/bitops_mode.h>
 #include <asm/bitops.h>
 #include <asm/intrinsics.h>
 
@@ -19,8 +20,6 @@
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
- * This function is atomic and may not be reordered.  See __set_bit()
- * if you do not require the atomic guarantees.
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  *
@@ -34,244 +33,106 @@
 static __inline__ void
 set_bit (int nr, volatile void *addr)
 {
-	__u32 bit, old, new;
-	volatile __u32 *m;
-	CMPXCHG_BUGCHECK_DECL
-
-	m = (volatile __u32 *) addr + (nr >> 5);
-	bit = 1 << (nr & 31);
-	do {
-		CMPXCHG_BUGCHECK(m);
-		old = *m;
-		new = old | bit;
-	} while (cmpxchg_acq(m, old, new) != old);
+	set_bit_mode(nr, addr, MODE_ATOMIC);
 }
 
 /**
  * __set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
  */
 static __inline__ void
 __set_bit (int nr, volatile void *addr)
 {
-	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
+	set_bit_mode(nr, addr, MODE_NON_ATOMIC);
 }
 
-/*
- * clear_bit() has "acquire" semantics.
- */
 #define smp_mb__before_clear_bit()	smp_mb()
-#define smp_mb__after_clear_bit()	do { /* skip */; } while (0)
+#define smp_mb__after_clear_bit()	smp_mb()
 
 /**
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
- *
- * clear_bit() is atomic and may not be reordered.  However, it does
- * not contain a memory barrier, so if it is used for locking purposes,
- * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
- * in order to ensure changes are visible on other processors.
  */
 static __inline__ void
 clear_bit (int nr, volatile void *addr)
 {
-	__u32 mask, old, new;
-	volatile __u32 *m;
-	CMPXCHG_BUGCHECK_DECL
-
-	m = (volatile __u32 *) addr + (nr >> 5);
-	mask = ~(1 << (nr & 31));
-	do {
-		CMPXCHG_BUGCHECK(m);
-		old = *m;
-		new = old & mask;
-	} while (cmpxchg_acq(m, old, new) != old);
+	clear_bit_mode(nr, addr, MODE_ATOMIC);
 }
 
-/**
- * __clear_bit - Clears a bit in memory (non-atomic version)
- */
 static __inline__ void
 __clear_bit (int nr, volatile void *addr)
 {
-	volatile __u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	*p &= ~m;
+	clear_bit_mode(nr, addr, MODE_NON_ATOMIC);
 }
 
 /**
  * change_bit - Toggle a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
- *
- * change_bit() is atomic and may not be reordered.
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
  */
 static __inline__ void
 change_bit (int nr, volatile void *addr)
 {
-	__u32 bit, old, new;
-	volatile __u32 *m;
-	CMPXCHG_BUGCHECK_DECL
-
-	m = (volatile __u32 *) addr + (nr >> 5);
-	bit = (1 << (nr & 31));
-	do {
-		CMPXCHG_BUGCHECK(m);
-		old = *m;
-		new = old ^ bit;
-	} while (cmpxchg_acq(m, old, new) != old);
+	change_bit_mode(nr, addr, MODE_ATOMIC);
 }
 
-/**
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
 static __inline__ void
 __change_bit (int nr, volatile void *addr)
 {
-	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
+	change_bit_mode(nr, addr, MODE_NON_ATOMIC);
 }
 
 /**
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.  
- * It also implies a memory barrier.
  */
 static __inline__ int
 test_and_set_bit (int nr, volatile void *addr)
 {
-	__u32 bit, old, new;
-	volatile __u32 *m;
-	CMPXCHG_BUGCHECK_DECL
-
-	m = (volatile __u32 *) addr + (nr >> 5);
-	bit = 1 << (nr & 31);
-	do {
-		CMPXCHG_BUGCHECK(m);
-		old = *m;
-		new = old | bit;
-	} while (cmpxchg_acq(m, old, new) != old);
-	return (old & bit) != 0;
+	return test_and_set_bit_mode(nr, addr, MODE_ATOMIC);
 }
 
-/**
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
 static __inline__ int
 __test_and_set_bit (int nr, volatile void *addr)
 {
-	__u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	int oldbitset = (*p & m) != 0;
-
-	*p |= m;
-	return oldbitset;
+	return test_and_set_bit_mode(nr, addr, MODE_NON_ATOMIC);
 }
 
 /**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.  
- * It also implies a memory barrier.
  */
 static __inline__ int
 test_and_clear_bit (int nr, volatile void *addr)
 {
-	__u32 mask, old, new;
-	volatile __u32 *m;
-	CMPXCHG_BUGCHECK_DECL
-
-	m = (volatile __u32 *) addr + (nr >> 5);
-	mask = ~(1 << (nr & 31));
-	do {
-		CMPXCHG_BUGCHECK(m);
-		old = *m;
-		new = old & mask;
-	} while (cmpxchg_acq(m, old, new) != old);
-	return (old & ~mask) != 0;
+	return test_and_clear_bit_mode(nr, addr, MODE_ATOMIC);
 }
 
-/**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
 static __inline__ int
 __test_and_clear_bit(int nr, volatile void * addr)
 {
-	__u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	int oldbitset = *p & m;
-
-	*p &= ~m;
-	return oldbitset;
+	return test_and_clear_bit_mode(nr, addr, MODE_NON_ATOMIC);
 }
 
 /**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.  
- * It also implies a memory barrier.
  */
 static __inline__ int
 test_and_change_bit (int nr, volatile void *addr)
 {
-	__u32 bit, old, new;
-	volatile __u32 *m;
-	CMPXCHG_BUGCHECK_DECL
-
-	m = (volatile __u32 *) addr + (nr >> 5);
-	bit = (1 << (nr & 31));
-	do {
-		CMPXCHG_BUGCHECK(m);
-		old = *m;
-		new = old ^ bit;
-	} while (cmpxchg_acq(m, old, new) != old);
-	return (old & bit) != 0;
+	return test_and_change_bit_mode(nr, addr, MODE_ATOMIC);
 }
 
-/*
- * WARNING: non atomic version.
- */
 static __inline__ int
 __test_and_change_bit (int nr, void *addr)
 {
-	__u32 old, bit = (1 << (nr & 31));
-	__u32 *m = (__u32 *) addr + (nr >> 5);
-
-	old = *m;
-	*m = old ^ bit;
-	return (old & bit) != 0;
+	return test_and_change_bit_mode(nr, addr, MODE_NON_ATOMIC);
 }
 
 static __inline__ int
Index: linux-2.6.16-mm2/include/asm-ia64/bitops_mode.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-mm2/include/asm-ia64/bitops_mode.h	2006-03-30 16:07:22.000000000 -0800
@@ -0,0 +1,204 @@
+#ifndef _ASM_IA64_BITOPS_MODE_H
+#define _ASM_IA64_BITOPS_MODE_H
+
+/*
+ * Copyright (C) 2006 Silicon Graphics, Incorporated
+ *	Christoph Lameter <christoph@lameter.com>
+ *
+ * Bit operations with the ability to specify the synchronization mode
+ */
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/intrinsics.h>
+
+#define MODE_NON_ATOMIC 0
+#define MODE_ATOMIC 1
+#define MODE_ACQUIRE 2
+#define MODE_RELEASE 3
+#define MODE_BARRIER 4
+
+static __inline__ __u32 cmpxchg_mode(volatile __u32 *m, __u32 old, __u32 new, int mode)
+{
+	__u32 x;
+
+	switch (mode) {
+	case MODE_ATOMIC :
+	case MODE_ACQUIRE :
+		return cmpxchg_acq(m, old, new);
+
+	case MODE_RELEASE :
+		return cmpxchg_rel(m, old, new);
+
+	case MODE_BARRIER :
+		x = cmpxchg_rel(m, old, new);
+		ia64_mf();
+		return x;
+	}
+}
+
+
+/**
+ * set_bit_mode - set a bit in memory
+ *
+ * The address must be (at least) "long" aligned.
+ * Note that there are driver (e.g., eepro100) which use these operations to
+ * operate on hw-defined data-structures, so we can't easily change these
+ * operations to force a bigger alignment.
+ *
+ * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
+ */
+static __inline__ void
+set_bit_mode (int nr, volatile void *addr, int mode)
+{
+	__u32 bit, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	bit = 1 << (nr & 31);
+
+	if (mode == MODE_NON_ATOMIC) {
+		*m |= bit;
+		return;
+	}
+
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old | bit;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
+}
+
+/**
+ * clear_bit_mode - Clears a bit in memory
+ */
+static __inline__ void
+clear_bit_mode (int nr, volatile void *addr, int mode)
+{
+	__u32 mask, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	mask = ~(1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		*m &= mask;
+		return;
+	}
+
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old & mask;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
+}
+
+/**
+ * change_bit_mode - Toggle a bit in memory
+ */
+static __inline__ void
+change_bit_mode (int nr, volatile void *addr, int mode)
+{
+	__u32 bit, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	bit = (1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		*m ^= bit;
+		return;
+	}
+
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old ^ bit;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
+}
+
+/**
+ * test_and_set_bit_mode - Set a bit and return its old value
+ */
+static __inline__ int
+test_and_set_bit_mode (int nr, volatile void *addr, int mode)
+{
+	__u32 bit, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	bit = 1 << (nr & 31);
+
+	if (mode == MODE_NON_ATOMIC) {
+		int oldbitset = *m & bit;
+		*m |= bit;
+		return oldbitset;
+	}
+
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old | bit;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
+	return (old & bit) != 0;
+}
+
+/**
+ * test_and_clear_bit_mode - Clear a bit and return its old value
+ */
+static __inline__ int
+test_and_clear_bit_mode (int nr, volatile void *addr, int mode)
+{
+	__u32 mask, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	mask = ~(1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		int oldbitset = *m & mask;
+		*m &= mask;
+		return oldbitset;
+	}
+
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old & mask;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
+	return (old & ~mask) != 0;
+}
+
+/**
+ * test_and_change_bit_mode - Change a bit and return its old value
+ */
+static __inline__ int
+test_and_change_bit_mode (int nr, volatile void *addr, int mode)
+{
+	__u32 bit, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	bit = (1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		old = *m;
+		*m = old ^ bit;
+		return (old & bit) != 0;
+	}
+
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old ^ bit;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
+	return (old & bit) != 0;
+}
+
+#endif /* _ASM_IA64_BITOPS_MODE_H */
Index: linux-2.6.16-mm2/include/asm-generic/bitops_mode.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-mm2/include/asm-generic/bitops_mode.h	2006-03-30 15:44:36.000000000 -0800
@@ -0,0 +1,220 @@
+#ifndef _ASM_GENERIC_BITOPS_MODE_H
+#define _ASM_GENERIC_BITOPS_MODE_H
+
+/*
+ * Copyright (C) 2006 Silicon Graphics, Incorporated
+ *	Christoph Lameter <christoph@lameter.com>
+ *
+ * Fallback logic for bit operations with synchronization mode
+ */
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/intrinsics.h>
+
+#define MODE_NON_ATOMIC 0
+#define MODE_ATOMIC 1
+#define MODE_ACQUIRE 2
+#define MODE_RELEASE 3
+#define MODE_BARRIER 4
+
+/**
+ * set_bit_mode - Set a bit in memory
+ *
+ * The address must be (at least) "long" aligned.
+ * Note that there are driver (e.g., eepro100) which use these operations to
+ * operate on hw-defined data-structures, so we can't easily change these
+ * operations to force a bigger alignment.
+ *
+ * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
+ */
+static __inline__ void
+set_bit_mode (int nr, volatile void *addr, int mode)
+{
+	switch (mode) {
+	case MODE_NON_ATOMIC:
+		__set_bit(nr,addr);
+		return;
+
+	case MODE_ATOMIC:
+		set_bit(nr,addr);
+		return;
+
+	case MODE_ACQUIRE:
+		set_bit(nr,addr);
+		smp_mb();
+		return;
+
+	case MODE_RELEASE:
+		smb_mb();
+		set_bit(nr,addr);
+		return;
+
+	case MODE_BARRIER:
+		smb_mb();
+		set_bit(nr,addr);
+		smb_mb();
+		return;
+	}
+}
+
+/**
+ * clear_bit_mode - Clears a bit in memory
+ */
+static __inline__ void
+clear_bit_mode (int nr, volatile void *addr, int mode)
+{
+	switch (mode) {
+	case MODE_NON_ATOMIC:
+		__clear_bit(nr,addr);
+		return;
+
+	case MODE_ATOMIC:
+		clear_bit(nr,addr);
+		return;
+
+	case MODE_ACQUIRE:
+		clear_bit(nr,addr);
+		smp_mb();
+		return;
+
+	case MODE_RELEASE:
+		smb_mb();
+		clear_bit(nr,addr);
+		return;
+
+	case MODE_BARRIER:
+		smb_mb();
+		clear_bit(nr,addr);
+		smb_mb();
+		return;
+	}
+}
+
+/**
+ * change_bit_mode - Toggle a bit in memory
+ */
+static __inline__ void
+change_bit_mode (int nr, volatile void *addr, int mode)
+{
+	switch (mode) {
+	case MODE_NON_ATOMIC:
+		__change_bit(nr,addr);
+		return;
+
+	case MODE_ATOMIC:
+		change_bit(nr,addr);
+		return;
+
+	case MODE_ACQUIRE:
+		change_bit(nr,addr);
+		smp_mb();
+		return;
+
+	case MODE_RELEASE:
+		smb_mb();
+		change_bit(nr,addr);
+		return;
+
+	case MODE_BARRIER:
+		smb_mb();
+		change_bit(nr,addr);
+		smb_mb();
+		return;
+	}
+}
+
+/**
+ * test_and_set_bit_mode - Set a bit and return its old value
+ */
+static __inline__ int
+test_and_set_bit_mode (int nr, volatile void *addr, int mode)
+{
+	int x;
+	switch (mode) {
+	case MODE_NON_ATOMIC:
+		return __test_and_set_bit(nr,addr);
+
+	case MODE_ATOMIC:
+	 	return test_and_set_bit(nr,addr);
+
+	case MODE_ACQUIRE:
+		x = test_and_set_bit(nr,addr);
+		smp_mb();
+		return x;
+
+	case MODE_RELEASE:
+		smb_mb();
+		return test_and_set_bit(nr,addr);
+
+	case MODE_BARRIER:
+		smb_mb();
+		x = test_and_set_bit(nr,addr);
+		smb_mb();
+		return x;
+	}
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ */
+static __inline__ int
+test_and_clear_bit_mode (int nr, volatile void *addr, int mode)
+{
+	int x;
+	switch (mode) {
+	case MODE_NON_ATOMIC:
+		return __test_and_clear_bit(nr,addr);
+
+	case MODE_ATOMIC:
+	 	return test_and_clear_bit(nr,addr);
+
+	case MODE_ACQUIRE:
+		x = test_and_clear_bit(nr,addr);
+		smp_mb();
+		return x;
+
+	case MODE_RELEASE:
+		smb_mb();
+		return test_and_clear_bit(nr,addr);
+
+	case MODE_BARRIER:
+		smb_mb();
+		x = test_and_set_bit(nr,addr);
+		smb_mb();
+		return x;
+	}
+}
+
+/**
+ * test_and_change_bit - Change a bit and return its old value
+ */
+static __inline__ int
+test_and_change_bit_mode (int nr, volatile void *addr, int mode)
+{
+	int x;
+	switch (mode) {
+	case MODE_NON_ATOMIC:
+		return __test_and_change_bit(nr,addr);
+
+	case MODE_ATOMIC:
+	 	return test_and_change_bit(nr,addr);
+
+	case MODE_ACQUIRE:
+		x = test_and_change_bit(nr,addr);
+		smp_mb();
+		return x;
+
+	case MODE_RELEASE:
+		smb_mb();
+		return test_and_change_bit(nr,addr);
+
+	case MODE_BARRIER:
+		smb_mb();
+		x = test_and_change_bit(nr,addr);
+		smb_mb();
+		return x;
+	}
+}
+
+#endif /* _ASM_GENERIC_BITOPS_MODE_H */
