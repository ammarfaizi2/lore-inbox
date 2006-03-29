Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWC2XdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWC2XdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWC2XdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:33:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47052 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751273AbWC2XdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:33:14 -0500
Date: Wed, 29 Mar 2006 15:33:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <65953E8166311641A685BDF71D865826A23D40@cacexc12.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.64.0603291529160.26011@schroedinger.engr.sgi.com>
References: <65953E8166311641A685BDF71D865826A23D40@cacexc12.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... Maybe we therefore need to add a mode to each bit operation in 
the kernel?

With that we can also get rid of the __* version of bitops.

Possible modes are

NON_ATOMIC 	Do not perform any atomic ops at all.

ATOMIC		Atomic but unordered

ACQUIRE		Atomic with acquire semantics (or lock semantics)

RELEASE 	Atomic with release semantics (or unlock semantics)

FENCE		Atomic with full fence.

This would require another bitops overhaul.

Maybe we can preserve the existing code with bitops like __* mapped to 
*(..., NON_ATOMIC) and * mapped to *(..., FENCE) and the gradually fix the 
rest of the kernel.

Nick?


Index: linux-2.6/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/bitops.h	2006-03-27 09:45:11.000000000 -0800
+++ linux-2.6/include/asm-ia64/bitops.h	2006-03-29 15:27:54.000000000 -0800
@@ -14,6 +14,30 @@
 #include <asm/bitops.h>
 #include <asm/intrinsics.h>
 
+#define MODE_NON_ATOMIC 0
+#define MODE_ATOMIC 1
+#define MODE_ACQUIRE 2
+#define MODE_RELEASE 3
+#define MODE_FENCE 4
+
+__u32 cmpxchg_mode(volatile __u32 *m, __u32 old, __u32 new, int mode)
+{
+	switch (mode) {
+	case MODE_NONE :
+	case MODE_ACQUIRE :
+		return cmpxchg_acq(m, old, new);
+
+	case MODE_FENCE :
+		smp_mb();
+		/* Fall through */
+
+	case MODE_RELEASE :
+		return cmpxchg_rel(m, old, new);
+
+	}
+}
+
+
 /**
  * set_bit - Atomically set a bit in memory
  * @nr: the bit to set
@@ -32,7 +56,7 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 static __inline__ void
-set_bit (int nr, volatile void *addr)
+set_bit (int nr, volatile void *addr, int mode)
 {
 	__u32 bit, old, new;
 	volatile __u32 *m;
@@ -40,35 +64,20 @@ set_bit (int nr, volatile void *addr)
 
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = 1 << (nr & 31);
+
+	if (mode == ORDER_NON_ATOMIC) {
+		*m |= bit;
+		return;
+	}
+
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old | bit;
-	} while (cmpxchg_acq(m, old, new) != old);
+	} while (cmpxchg_mode(m, old, new, mode) != old);
 }
 
 /**
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __inline__ void
-__set_bit (int nr, volatile void *addr)
-{
-	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
-}
-
-/*
- * clear_bit() has "acquire" semantics.
- */
-#define smp_mb__before_clear_bit()	smp_mb()
-#define smp_mb__after_clear_bit()	do { /* skip */; } while (0)
-
-/**
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
@@ -79,7 +88,7 @@ __set_bit (int nr, volatile void *addr)
  * in order to ensure changes are visible on other processors.
  */
 static __inline__ void
-clear_bit (int nr, volatile void *addr)
+clear_bit (int nr, volatile void *addr, int mode)
 {
 	__u32 mask, old, new;
 	volatile __u32 *m;
@@ -87,22 +96,17 @@ clear_bit (int nr, volatile void *addr)
 
 	m = (volatile __u32 *) addr + (nr >> 5);
 	mask = ~(1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		*m &= ~mask;
+		return;
+	}
+
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old & mask;
-	} while (cmpxchg_acq(m, old, new) != old);
-}
-
-/**
- * __clear_bit - Clears a bit in memory (non-atomic version)
- */
-static __inline__ void
-__clear_bit (int nr, volatile void *addr)
-{
-	volatile __u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	*p &= ~m;
+	} while (cmpxchg_mode(m, old, new, mode) != old);
 }
 
 /**
@@ -115,7 +119,7 @@ __clear_bit (int nr, volatile void *addr
  * restricted to acting on a single-word quantity.
  */
 static __inline__ void
-change_bit (int nr, volatile void *addr)
+change_bit (int nr, volatile void *addr, int mode)
 {
 	__u32 bit, old, new;
 	volatile __u32 *m;
@@ -123,6 +127,12 @@ change_bit (int nr, volatile void *addr)
 
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = (1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		*m ~= bit;
+		return;
+	}
+
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
@@ -131,21 +141,6 @@ change_bit (int nr, volatile void *addr)
 }
 
 /**
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __inline__ void
-__change_bit (int nr, volatile void *addr)
-{
-	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
-}
-
-/**
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -154,7 +149,7 @@ __change_bit (int nr, volatile void *add
  * It also implies a memory barrier.
  */
 static __inline__ int
-test_and_set_bit (int nr, volatile void *addr)
+test_and_set_bit (int nr, volatile void *addr, int mode)
 {
 	__u32 bit, old, new;
 	volatile __u32 *m;
@@ -162,6 +157,13 @@ test_and_set_bit (int nr, volatile void 
 
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = 1 << (nr & 31);
+
+	if (mode == MODE_NON_ATOMIC) {
+		int oldbitset = *m & bit;
+		*m |= bit;
+		return oldbitset;
+	}
+
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
@@ -171,26 +173,6 @@ test_and_set_bit (int nr, volatile void 
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __inline__ int
-__test_and_set_bit (int nr, volatile void *addr)
-{
-	__u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	int oldbitset = (*p & m) != 0;
-
-	*p |= m;
-	return oldbitset;
-}
-
-/**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -199,7 +181,7 @@ __test_and_set_bit (int nr, volatile voi
  * It also implies a memory barrier.
  */
 static __inline__ int
-test_and_clear_bit (int nr, volatile void *addr)
+test_and_clear_bit (int nr, volatile void *addr, int mode)
 {
 	__u32 mask, old, new;
 	volatile __u32 *m;
@@ -207,6 +189,13 @@ test_and_clear_bit (int nr, volatile voi
 
 	m = (volatile __u32 *) addr + (nr >> 5);
 	mask = ~(1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		int oldbitset = *m & mask;
+		*m &= ~mask;
+		return oldbitset;
+	}
+
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
@@ -216,26 +205,6 @@ test_and_clear_bit (int nr, volatile voi
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __inline__ int
-__test_and_clear_bit(int nr, volatile void * addr)
-{
-	__u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	int oldbitset = *p & m;
-
-	*p &= ~m;
-	return oldbitset;
-}
-
-/**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -244,7 +213,7 @@ __test_and_clear_bit(int nr, volatile vo
  * It also implies a memory barrier.
  */
 static __inline__ int
-test_and_change_bit (int nr, volatile void *addr)
+test_and_change_bit (int nr, volatile void *addr, int mode)
 {
 	__u32 bit, old, new;
 	volatile __u32 *m;
@@ -252,6 +221,13 @@ test_and_change_bit (int nr, volatile vo
 
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = (1 << (nr & 31));
+
+	if (mode == MODE_NON_ATOMIC) {
+		old = *m;
+		*m = old ^ bit;
+		return (old & bit) != 0;
+	}
+
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
@@ -260,20 +236,6 @@ test_and_change_bit (int nr, volatile vo
 	return (old & bit) != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ int
-__test_and_change_bit (int nr, void *addr)
-{
-	__u32 old, bit = (1 << (nr & 31));
-	__u32 *m = (__u32 *) addr + (nr >> 5);
-
-	old = *m;
-	*m = old ^ bit;
-	return (old & bit) != 0;
-}
-
 static __inline__ int
 test_bit (int nr, const volatile void *addr)
 {
