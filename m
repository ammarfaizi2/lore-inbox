Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbUKHQAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUKHQAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUKHQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:00:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261871AbUKHOfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:15 -0500
Date: Mon, 8 Nov 2004 14:34:18 GMT
Message-Id: <200411081434.iA8EYIwU023548@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 9/20] FRV: Fujitsu FR-V CPU arch implementation part 7
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 7 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_7-2610rc1mm3.diff
 Makefile     |    8 +
 __ashldi3.S  |   40 ++++++++
 __ashrdi3.S  |   41 +++++++++
 __lshrdi3.S  |   40 ++++++++
 __muldi3.S   |   32 +++++++
 __negdi2.S   |   28 ++++++
 atomic-ops.S |  265 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache.S      |   98 +++++++++++++++++++++
 checksum.c   |  148 ++++++++++++++++++++++++++++++++
 insl_ns.S    |   52 +++++++++++
 insl_sw.S    |   40 ++++++++
 memcpy.S     |  135 ++++++++++++++++++++++++++++++
 memset.S     |  182 ++++++++++++++++++++++++++++++++++++++++
 outsl_ns.S   |   59 +++++++++++++
 outsl_sw.S   |   45 ++++++++++
 15 files changed, 1213 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__ashldi3.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__ashldi3.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__ashldi3.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__ashldi3.S	2004-11-05 14:13:03.262549909 +0000
@@ -0,0 +1,40 @@
+/* __ashldi3.S:	64-bit arithmetic shift left
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# unsigned long long __ashldi3(unsigned long long value [GR8:GR9], unsigned by [GR10])
+#
+###############################################################################
+        .globl		__ashldi3
+        .type		__ashldi3,@function
+__ashldi3:
+	andicc.p	gr10,#63,gr10,icc0
+	setlos		#32,gr5
+	andicc.p	gr10,#32,gr0,icc1
+	beqlr		icc0,#0
+	ckeq		icc1,cc4			; cc4 is true if 0<N<32
+
+	# deal with a shift in the range 1<=N<=31
+	csll.p		gr8,gr10,gr8	,cc4,#1		; MSW <<= N
+	csub		gr5,gr10,gr5	,cc4,#1		; M = 32 - N
+	csrl.p		gr9,gr5,gr4	,cc4,#1
+	csll		gr9,gr10,gr9	,cc4,#1		; LSW <<= N
+	cor.p		gr4,gr8,gr8	,cc4,#1		; MSW |= LSW >> M
+
+	# deal with a shift in the range 32<=N<=63
+	csll		gr9,gr10,gr8	,cc4,#0		; MSW = LSW << (N & 31 [implicit AND])
+	cor.p		gr0,gr0,gr9	,cc4,#0		; LSW = 0
+	bralr
+	.size		__ashldi3, .-__ashldi3
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__ashrdi3.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__ashrdi3.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__ashrdi3.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__ashrdi3.S	2004-11-05 14:13:03.266549572 +0000
@@ -0,0 +1,41 @@
+/* __ashrdi3.S:	64-bit arithmetic shift right
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# signed long long __ashrdi3(signed long long value [GR8:GR9], unsigned by [GR10])
+#
+###############################################################################
+        .globl		__ashrdi3
+        .type		__ashrdi3,@function
+__ashrdi3:
+	andicc.p	gr10,#63,gr10,icc0
+	setlos		#32,gr5
+	andicc.p	gr10,#32,gr0,icc1
+	beqlr		icc0,#0
+	setlos.p	#31,gr6
+	ckeq		icc1,cc4			; cc4 is true if 0<N<32
+
+	# deal with a shift in the range 1<=N<=31
+	csrl.p		gr9,gr10,gr9	,cc4,#1		; LSW >>= N
+	csub		gr5,gr10,gr5	,cc4,#1		; M = 32 - N
+	csll.p		gr8,gr5,gr4	,cc4,#1
+	csra		gr8,gr10,gr8	,cc4,#1		; MSW >>= N
+	cor.p		gr4,gr9,gr9	,cc4,#1		; LSW |= MSW << M
+
+	# deal with a shift in the range 32<=N<=63
+	csra		gr8,gr10,gr9	,cc4,#0		; LSW = MSW >> (N & 31 [implicit AND])
+	csra.p		gr8,gr6,gr8	,cc4,#0		; MSW >>= 31
+	bralr
+	.size		__ashrdi3, .-__ashrdi3
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/atomic-ops.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/atomic-ops.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/atomic-ops.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/atomic-ops.S	2004-11-05 14:13:03.270549234 +0000
@@ -0,0 +1,265 @@
+/* atomic-ops.S: kernel atomic operations
+ *
+ * For an explanation of how atomic ops work in this arch, see:
+ *   Documentation/fujitsu/frv/atomic-ops.txt
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/spr-regs.h>
+
+	.text
+	.balign 4
+
+###############################################################################
+#
+# unsigned long atomic_test_and_ANDNOT_mask(unsigned long mask, volatile unsigned long *v);
+#
+###############################################################################
+	.globl		atomic_test_and_ANDNOT_mask
+        .type		atomic_test_and_ANDNOT_mask,@function
+atomic_test_and_ANDNOT_mask:
+	not.p		gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	and		gr8,gr10,gr11
+	cst.p		gr11,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		atomic_test_and_ANDNOT_mask, .-atomic_test_and_ANDNOT_mask
+
+###############################################################################
+#
+# unsigned long atomic_test_and_OR_mask(unsigned long mask, volatile unsigned long *v);
+#
+###############################################################################
+	.globl		atomic_test_and_OR_mask
+        .type		atomic_test_and_OR_mask,@function
+atomic_test_and_OR_mask:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	or		gr8,gr10,gr11
+	cst.p		gr11,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		atomic_test_and_OR_mask, .-atomic_test_and_OR_mask
+
+###############################################################################
+#
+# unsigned long atomic_test_and_XOR_mask(unsigned long mask, volatile unsigned long *v);
+#
+###############################################################################
+	.globl		atomic_test_and_XOR_mask
+        .type		atomic_test_and_XOR_mask,@function
+atomic_test_and_XOR_mask:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	xor		gr8,gr10,gr11
+	cst.p		gr11,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		atomic_test_and_XOR_mask, .-atomic_test_and_XOR_mask
+
+###############################################################################
+#
+# int atomic_add_return(int i, atomic_t *v)
+#
+###############################################################################
+	.globl		atomic_add_return
+        .type		atomic_add_return,@function
+atomic_add_return:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	add		gr8,gr10,gr8
+	cst.p		gr8,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		atomic_add_return, .-atomic_add_return
+
+###############################################################################
+#
+# int atomic_sub_return(int i, atomic_t *v)
+#
+###############################################################################
+	.globl		atomic_sub_return
+        .type		atomic_sub_return,@function
+atomic_sub_return:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	sub		gr8,gr10,gr8
+	cst.p		gr8,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		atomic_sub_return, .-atomic_sub_return
+
+###############################################################################
+#
+# uint8_t __xchg_8(uint8_t i, uint8_t *v)
+#
+###############################################################################
+	.globl		__xchg_8
+        .type		__xchg_8,@function
+__xchg_8:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ldub.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	cstb.p		gr10,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		__xchg_8, .-__xchg_8
+
+###############################################################################
+#
+# uint16_t __xchg_16(uint16_t i, uint16_t *v)
+#
+###############################################################################
+	.globl		__xchg_16
+        .type		__xchg_16,@function
+__xchg_16:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	lduh.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	csth.p		gr10,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		__xchg_16, .-__xchg_16
+
+###############################################################################
+#
+# uint32_t __xchg_32(uint32_t i, uint32_t *v)
+#
+###############################################################################
+	.globl		__xchg_32
+        .type		__xchg_32,@function
+__xchg_32:
+	or.p		gr8,gr8,gr10
+0:
+	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
+	ckeq		icc3,cc7
+	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
+	orcr		cc7,cc7,cc3			/* set CC3 to true */
+	cst.p		gr10,@(gr9,gr0)		,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
+	beq		icc3,#0,0b
+	bralr
+
+	.size		__xchg_32, .-__xchg_32
+
+###############################################################################
+#
+# uint8_t __cmpxchg_8(uint8_t *v, uint8_t test, uint8_t new)
+#
+###############################################################################
+	.globl		__cmpxchg_8
+        .type		__cmpxchg_8,@function
+__cmpxchg_8:
+	or.p		gr8,gr8,gr11
+0:
+	orcc		gr0,gr0,gr0,icc3
+	ckeq		icc3,cc7
+	ldub.p		@(gr11,gr0),gr8
+	orcr		cc7,cc7,cc3
+	sub		gr8,gr9,gr7
+	sllicc		gr7,#24,gr0,icc0
+	bne		icc0,#0,1f
+	cstb.p		gr10,@(gr11,gr0)	,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1
+	beq		icc3,#0,0b
+1:
+	bralr
+
+	.size		__cmpxchg_8, .-__cmpxchg_8
+
+###############################################################################
+#
+# uint16_t __cmpxchg_16(uint16_t *v, uint16_t test, uint16_t new)
+#
+###############################################################################
+	.globl		__cmpxchg_16
+        .type		__cmpxchg_16,@function
+__cmpxchg_16:
+	or.p		gr8,gr8,gr11
+0:
+	orcc		gr0,gr0,gr0,icc3
+	ckeq		icc3,cc7
+	lduh.p		@(gr11,gr0),gr8
+	orcr		cc7,cc7,cc3
+	sub		gr8,gr9,gr7
+	sllicc		gr7,#16,gr0,icc0
+	bne		icc0,#0,1f
+	csth.p		gr10,@(gr11,gr0)	,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1
+	beq		icc3,#0,0b
+1:
+	bralr
+
+	.size		__cmpxchg_16, .-__cmpxchg_16
+
+###############################################################################
+#
+# uint32_t __cmpxchg_32(uint32_t *v, uint32_t test, uint32_t new)
+#
+###############################################################################
+	.globl		__cmpxchg_32
+        .type		__cmpxchg_32,@function
+__cmpxchg_32:
+	or.p		gr8,gr8,gr11
+0:
+	orcc		gr0,gr0,gr0,icc3
+	ckeq		icc3,cc7
+	ld.p		@(gr11,gr0),gr8
+	orcr		cc7,cc7,cc3
+	subcc		gr8,gr9,gr7,icc0
+	bne		icc0,#0,1f
+	cst.p		gr10,@(gr11,gr0)	,cc3,#1
+	corcc		gr29,gr29,gr0		,cc3,#1
+	beq		icc3,#0,0b
+1:
+	bralr
+
+	.size		__cmpxchg_32, .-__cmpxchg_32
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/cache.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/cache.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/cache.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/cache.S	2004-11-05 14:13:03.274548896 +0000
@@ -0,0 +1,98 @@
+/* cache.S: cache managment routines
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/spr-regs.h>
+#include <asm/cache.h>
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# Write back a range of dcache
+# - void frv_dcache_writeback(unsigned long start [GR8], unsigned long size [GR9])
+#
+###############################################################################
+        .globl		frv_dcache_writeback
+        .type		frv_dcache_writeback,@function
+frv_dcache_writeback:	
+	andi		gr8,~(L1_CACHE_BYTES-1),gr8
+
+2:	dcf		@(gr8,gr0)
+	addi		gr8,#L1_CACHE_BYTES,gr8
+	cmp		gr9,gr8,icc0
+	bhi		icc0,#2,2b
+
+	membar
+	bralr
+	.size		frv_dcache_writeback, .-frv_dcache_writeback
+
+##############################################################################
+#
+# Invalidate a range of dcache and icache
+# - void frv_cache_invalidate(unsigned long start [GR8], unsigned long end [GR9]);
+#
+###############################################################################
+        .globl		frv_cache_invalidate
+        .type		frv_cache_invalidate,@function
+frv_cache_invalidate:
+	andi		gr8,~(L1_CACHE_BYTES-1),gr8
+
+2:	dci		@(gr8,gr0)
+	ici		@(gr8,gr0)
+	addi		gr8,#L1_CACHE_BYTES,gr8
+	cmp		gr9,gr8,icc0
+	bhi		icc0,#2,2b
+
+	membar
+	bralr
+	.size		frv_cache_invalidate, .-frv_cache_invalidate
+
+##############################################################################
+#
+# Invalidate a range of icache
+# - void frv_icache_invalidate(unsigned long start [GR8], unsigned long end [GR9]);
+#
+###############################################################################
+        .globl		frv_icache_invalidate
+        .type		frv_icache_invalidate,@function
+frv_icache_invalidate:
+	andi		gr8,~(L1_CACHE_BYTES-1),gr8
+
+2:	ici		@(gr8,gr0)
+	addi		gr8,#L1_CACHE_BYTES,gr8
+	cmp		gr9,gr8,icc0
+	bhi		icc0,#2,2b
+
+	membar
+	bralr
+	.size		frv_icache_invalidate, .-frv_icache_invalidate
+
+###############################################################################
+#
+# Write back and invalidate a range of dcache and icache
+# - void frv_cache_wback_inv(unsigned long start [GR8], unsigned long end [GR9])
+#
+###############################################################################
+        .globl		frv_cache_wback_inv
+        .type		frv_cache_wback_inv,@function
+frv_cache_wback_inv:	
+	andi		gr8,~(L1_CACHE_BYTES-1),gr8
+
+2:	dcf		@(gr8,gr0)
+	ici		@(gr8,gr0)
+	addi		gr8,#L1_CACHE_BYTES,gr8
+	cmp		gr9,gr8,icc0
+	bhi		icc0,#2,2b
+
+	membar
+	bralr
+	.size		frv_cache_wback_inv, .-frv_cache_wback_inv
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/checksum.c linux-2.6.10-rc1-mm3-frv/arch/frv/lib/checksum.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/checksum.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/checksum.c	2004-11-05 14:13:03.278548558 +0000
@@ -0,0 +1,148 @@
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		IP/TCP/UDP checksumming routines
+ *
+ * Authors:	Jorge Cwik, <jorge@laser.satlink.net>
+ *		Arnt Gulbrandsen, <agulbra@nvg.unit.no>
+ *		Tom May, <ftom@netcom.com>
+ *		Andreas Schwab, <schwab@issan.informatik.uni-dortmund.de>
+ *		Lots of code moved from tcp.c and ip.c; see those files
+ *		for more names.
+ *
+ * 03/02/96	Jes Sorensen, Andreas Schwab, Roman Hodek:
+ *		Fixed some nasty bugs, causing some horrible crashes.
+ *		A: At some points, the sum (%0) was used as
+ *		length-counter instead of the length counter
+ *		(%1). Thanks to Roman Hodek for pointing this out.
+ *		B: GCC seems to mess up if one uses too many
+ *		data-registers to hold input values and one tries to
+ *		specify d0 and d1 as scratch registers. Letting gcc choose these
+ *      registers itself solves the problem.
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+ 
+/* Revised by Kenneth Albanowski for m68knommu. Basic problem: unaligned access kills, so most
+   of the assembly has to go. */
+
+#include <net/checksum.h>
+#include <asm/checksum.h>
+
+static inline unsigned short from32to16(unsigned long x)
+{
+	/* add up 16-bit and 16-bit for 16+c bit */
+	x = (x & 0xffff) + (x >> 16);
+	/* add up carry.. */
+	x = (x & 0xffff) + (x >> 16);
+	return x;
+}
+
+static unsigned long do_csum(const unsigned char * buff, int len)
+{
+	int odd, count;
+	unsigned long result = 0;
+
+	if (len <= 0)
+		goto out;
+	odd = 1 & (unsigned long) buff;
+	if (odd) {
+		result = *buff;
+		len--;
+		buff++;
+	}
+	count = len >> 1;		/* nr of 16-bit words.. */
+	if (count) {
+		if (2 & (unsigned long) buff) {
+			result += *(unsigned short *) buff;
+			count--;
+			len -= 2;
+			buff += 2;
+		}
+		count >>= 1;		/* nr of 32-bit words.. */
+		if (count) {
+		        unsigned long carry = 0;
+			do {
+				unsigned long w = *(unsigned long *) buff;
+				count--;
+				buff += 4;
+				result += carry;
+				result += w;
+				carry = (w > result);
+			} while (count);
+			result += carry;
+			result = (result & 0xffff) + (result >> 16);
+		}
+		if (len & 2) {
+			result += *(unsigned short *) buff;
+			buff += 2;
+		}
+	}
+	if (len & 1)
+		result += (*buff << 8);
+	result = from32to16(result);
+	if (odd)
+		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
+out:
+	return result;
+}
+
+/*
+ * computes the checksum of a memory block at buff, length len,
+ * and adds in "sum" (32-bit)
+ *
+ * returns a 32-bit number suitable for feeding into itself
+ * or csum_tcpudp_magic
+ *
+ * this function must be called with even lengths, except
+ * for the last fragment, which may be odd
+ *
+ * it's best to have buff aligned on a 32-bit boundary
+ */
+unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum)
+{
+	unsigned int result = do_csum(buff, len);
+
+	/* add in old sum, and carry.. */
+	result += sum;
+	if (sum > result)
+		result += 1;
+	return result;
+}
+
+/*
+ * this routine is used for miscellaneous IP-like checksums, mainly
+ * in icmp.c
+ */
+unsigned short ip_compute_csum(const unsigned char * buff, int len)
+{
+	return ~do_csum(buff,len);
+}
+
+/*
+ * copy from fs while checksumming, otherwise like csum_partial
+ */
+
+unsigned int
+csum_partial_copy_from_user(const char *src, char *dst, int len, int sum, int *csum_err)
+{
+	if (csum_err) *csum_err = 0;
+	memcpy(dst, src, len);
+	return csum_partial(dst, len, sum);
+}
+
+/*
+ * copy from ds while checksumming, otherwise like csum_partial
+ */
+
+unsigned int
+csum_partial_copy(const char *src, char *dst, int len, int sum)
+{
+	memcpy(dst, src, len);
+	return csum_partial(dst, len, sum);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/insl_ns.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/insl_ns.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/insl_ns.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/insl_ns.S	2004-11-05 14:13:03.282548220 +0000
@@ -0,0 +1,52 @@
+/* insl_ns.S: input array of 4b words from device port without byte swapping
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# void __insl_ns(unsigned int port, void *buf, int n)
+#
+###############################################################################
+        .globl		__insl_ns
+        .type		__insl_ns,@function
+__insl_ns:
+	andicc.p	gr9,#3,gr0,icc0
+	setlos		#4,gr4
+	bne		icc0,#0,__insl_ns_misaligned
+	subi		gr9,#4,gr9
+0:
+	ldi.p		@(gr8,#0),gr5
+	subicc		gr10,#1,gr10,icc0
+	stu.p		gr5,@(gr9,gr4)
+	bhi		icc0,#2,0b
+	bralr
+
+__insl_ns_misaligned:
+	subi.p		gr9,#1,gr9
+	setlos		#1,gr4
+0:
+	ldi		@(gr8,#0),gr5
+
+	srli		gr5,#24,gr6
+	stbu.p		gr6,@(gr9,gr4)
+	srli		gr5,#16,gr6
+	stbu.p		gr6,@(gr9,gr4)
+	srli		gr5,#8,gr6
+	stbu.p		gr6,@(gr9,gr4)
+	subicc		gr10,#1,gr10,icc0
+	stbu.p		gr5,@(gr9,gr4)
+	bhi		icc0,#2,0b
+	bralr
+
+	.size		__insl_ns, .-__insl_ns
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/insl_sw.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/insl_sw.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/insl_sw.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/insl_sw.S	2004-11-05 14:13:03.286547882 +0000
@@ -0,0 +1,40 @@
+/* insl_sw.S: input array of 4b words from device port with byte swapping
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# void __insl_sw(unsigned int port, void *buf, int n)
+#
+###############################################################################
+        .globl		__insl_sw
+        .type		__insl_sw,@function
+__insl_sw:
+	subi.p		gr9,#1,gr9
+	setlos		#1,gr4
+0:
+	ldi.p		@(gr8,#0),gr5		; get 0xAABBCCDD
+	subicc		gr10,#1,gr10,icc0
+
+	stbu.p		gr5,@(gr9,gr4)		; write 0xDD
+	srli		gr5,#8,gr5
+	stbu.p		gr5,@(gr9,gr4)		; write 0xCC
+	srli		gr5,#8,gr5
+	stbu.p		gr5,@(gr9,gr4)		; write 0xBB
+	srli		gr5,#8,gr5
+	stbu.p		gr5,@(gr9,gr4)		; write 0xAA
+	bhi		icc0,#2,0b
+	bralr
+
+	.size		__insl_sw, .-__insl_sw
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__lshrdi3.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__lshrdi3.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__lshrdi3.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__lshrdi3.S	2004-11-05 14:13:03.289547629 +0000
@@ -0,0 +1,40 @@
+/* __lshrdi3.S:	64-bit logical shift right
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# unsigned long long __lshrdi3(unsigned long long value [GR8:GR9], unsigned by [GR10])
+#
+###############################################################################
+        .globl		__lshrdi3
+        .type		__lshrdi3,@function
+__lshrdi3:
+	andicc.p	gr10,#63,gr10,icc0
+	setlos		#32,gr5
+	andicc.p	gr10,#32,gr0,icc1
+	beqlr		icc0,#0
+	ckeq		icc1,cc4			; cc4 is true if 0<N<32
+
+	# deal with a shift in the range 1<=N<=31
+	csrl.p		gr9,gr10,gr9	,cc4,#1		; LSW >>= N
+	csub		gr5,gr10,gr5	,cc4,#1		; M = 32 - N
+	csll.p		gr8,gr5,gr4	,cc4,#1
+	csrl		gr8,gr10,gr8	,cc4,#1		; MSW >>= N
+	cor.p		gr4,gr9,gr9	,cc4,#1		; LSW |= MSW << M
+
+	# deal with a shift in the range 32<=N<=63
+	csrl		gr8,gr10,gr9	,cc4,#0		; LSW = MSW >> (N & 31 [implicit AND])
+	cor.p		gr0,gr0,gr8	,cc4,#0		; MSW = 0
+	bralr
+	.size		__lshrdi3, .-__lshrdi3
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/Makefile linux-2.6.10-rc1-mm3-frv/arch/frv/lib/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/Makefile	2004-11-05 14:13:03.293547291 +0000
@@ -0,0 +1,8 @@
+#
+# Makefile for FRV-specific library files..
+#
+
+lib-y := \
+	__ashldi3.o __lshrdi3.o __muldi3.o __ashrdi3.o __negdi2.o \
+	checksum.o memcpy.o memset.o atomic-ops.o \
+	outsl_ns.o outsl_sw.o insl_ns.o insl_sw.o cache.o
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/memcpy.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/memcpy.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/memcpy.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/memcpy.S	2004-11-05 14:13:03.300546700 +0000
@@ -0,0 +1,135 @@
+/* memcpy.S: optimised assembly memcpy
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# void *memcpy(void *to, const char *from, size_t count)
+#
+# - NOTE: must not use any stack. exception detection performs function return
+#         to caller's fixup routine, aborting the remainder of the copy
+#
+###############################################################################
+        .globl		memcpy,__memcpy_end
+        .type		memcpy,@function
+memcpy:
+	or.p		gr8,gr9,gr4
+	orcc		gr10,gr0,gr0,icc3
+	or.p		gr10,gr4,gr4
+	beqlr		icc3,#0
+
+	# optimise based on best common alignment for to, from & count
+	andicc.p	gr4,#0x0f,gr0,icc0
+	setlos		#8,gr11
+	andicc.p	gr4,#0x07,gr0,icc1
+	beq		icc0,#0,memcpy_16
+	andicc.p	gr4,#0x03,gr0,icc0
+	beq		icc1,#0,memcpy_8
+	andicc.p	gr4,#0x01,gr0,icc1
+	beq		icc0,#0,memcpy_4
+	setlos.p	#1,gr11
+	beq		icc1,#0,memcpy_2
+
+	# do byte by byte copy
+	sub.p		gr8,gr11,gr3
+	sub		gr9,gr11,gr9
+0:	ldubu.p		@(gr9,gr11),gr4
+	subicc		gr10,#1,gr10,icc0
+	stbu.p		gr4,@(gr3,gr11)
+	bne		icc0,#2,0b
+	bralr
+
+	# do halfword by halfword copy
+memcpy_2:
+	setlos		#2,gr11
+	sub.p		gr8,gr11,gr3
+	sub		gr9,gr11,gr9
+0:	lduhu.p		@(gr9,gr11),gr4
+	subicc		gr10,#2,gr10,icc0
+	sthu.p		gr4,@(gr3,gr11)
+	bne		icc0,#2,0b
+	bralr
+
+	# do word by word copy
+memcpy_4:
+	setlos		#4,gr11
+	sub.p		gr8,gr11,gr3
+	sub		gr9,gr11,gr9
+0:	ldu.p		@(gr9,gr11),gr4
+	subicc		gr10,#4,gr10,icc0
+	stu.p		gr4,@(gr3,gr11)
+	bne		icc0,#2,0b
+	bralr
+
+	# do double-word by double-word copy
+memcpy_8:
+	sub.p		gr8,gr11,gr3
+	sub		gr9,gr11,gr9
+0:	lddu.p		@(gr9,gr11),gr4
+	subicc		gr10,#8,gr10,icc0
+	stdu.p		gr4,@(gr3,gr11)
+	bne		icc0,#2,0b
+	bralr
+
+	# do quad-word by quad-word copy
+memcpy_16:
+	sub.p		gr8,gr11,gr3
+	sub		gr9,gr11,gr9
+0:	lddu		@(gr9,gr11),gr4
+	lddu.p		@(gr9,gr11),gr6
+	subicc		gr10,#16,gr10,icc0
+	stdu		gr4,@(gr3,gr11)
+	stdu.p		gr6,@(gr3,gr11)
+	bne		icc0,#2,0b
+	bralr
+__memcpy_end:
+
+	.size		memcpy, __memcpy_end-memcpy
+
+###############################################################################
+#
+# copy to/from userspace
+# - return the number of bytes that could not be copied (0 on complete success)
+#
+# long __memcpy_user(void *dst, const void *src, size_t count)
+#
+###############################################################################
+        .globl		__memcpy_user, __memcpy_user_error_lr, __memcpy_user_error_handler
+        .type		__memcpy_user,@function
+__memcpy_user:
+	movsg		lr,gr7
+	subi.p		sp,#8,sp
+	add		gr8,gr10,gr6		; calculate expected end address
+	stdi		gr6,@(sp,#0)
+
+	# abuse memcpy to do the dirty work
+	call		memcpy
+__memcpy_user_error_lr:
+	ldi.p		@(sp,#4),gr7
+	setlos		#0,gr8
+	jmpl.p		@(gr7,gr0)
+	addi		sp,#8,sp
+
+	# deal any exception generated by memcpy
+	# GR8 - memcpy's current dest address
+	# GR11 - memset's step value (index register for store insns)
+__memcpy_user_error_handler:
+	lddi.p		@(sp,#0),gr4		; load GR4 with dst+count, GR5 with ret addr
+	add		gr11,gr3,gr7
+	sub.p		gr4,gr7,gr8
+
+	addi		sp,#8,sp
+	jmpl		@(gr5,gr0)
+
+	.size		__memcpy_user, .-__memcpy_user
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/memset.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/memset.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/memset.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/memset.S	2004-11-05 14:13:03.304546362 +0000
@@ -0,0 +1,182 @@
+/* memset.S: optimised assembly memset
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# void *memset(void *p, char ch, size_t count)
+#
+# - NOTE: must not use any stack. exception detection performs function return
+#         to caller's fixup routine, aborting the remainder of the set
+#         GR4, GR7, GR8, and GR11 must be managed
+#
+###############################################################################
+        .globl		memset,__memset_end
+        .type		memset,@function
+memset:
+	orcc.p		gr10,gr0,gr5,icc3		; GR5 = count
+	andi		gr9,#0xff,gr9
+	or.p		gr8,gr0,gr4			; GR4 = address
+	beqlr		icc3,#0
+
+	# conditionally write a byte to 2b-align the address
+	setlos.p	#1,gr6
+	andicc		gr4,#1,gr0,icc0
+	ckne		icc0,cc7
+	cstb.p		gr9,@(gr4,gr0)		,cc7,#1
+	csubcc		gr5,gr6,gr5		,cc7,#1	; also set ICC3
+	cadd.p		gr4,gr6,gr4		,cc7,#1
+	beqlr		icc3,#0
+
+	# conditionally write a word to 4b-align the address
+	andicc.p	gr4,#2,gr0,icc0
+	subicc		gr5,#2,gr0,icc1
+	setlos.p	#2,gr6
+	ckne		icc0,cc7
+	slli.p		gr9,#8,gr12			; need to double up the pattern
+	cknc		icc1,cc5
+	or.p		gr9,gr12,gr12
+	andcr		cc7,cc5,cc7
+
+	csth.p		gr12,@(gr4,gr0)		,cc7,#1
+	csubcc		gr5,gr6,gr5		,cc7,#1	; also set ICC3
+	cadd.p		gr4,gr6,gr4		,cc7,#1
+	beqlr		icc3,#0
+
+	# conditionally write a dword to 8b-align the address
+	andicc.p	gr4,#4,gr0,icc0
+	subicc		gr5,#4,gr0,icc1
+	setlos.p	#4,gr6
+	ckne		icc0,cc7
+	slli.p		gr12,#16,gr13			; need to quadruple-up the pattern
+	cknc		icc1,cc5
+	or.p		gr13,gr12,gr12
+	andcr		cc7,cc5,cc7
+
+	cst.p		gr12,@(gr4,gr0)		,cc7,#1
+	csubcc		gr5,gr6,gr5		,cc7,#1	; also set ICC3
+	cadd.p		gr4,gr6,gr4		,cc7,#1
+	beqlr		icc3,#0
+
+	or.p		gr12,gr12,gr13			; need to octuple-up the pattern
+
+	# the address is now 8b-aligned - loop around writing 64b chunks
+	setlos		#8,gr7
+	subi.p		gr4,#8,gr4			; store with update index does weird stuff
+	setlos		#64,gr6
+
+	subicc		gr5,#64,gr0,icc0
+0:	cknc		icc0,cc7
+	cstdu		gr12,@(gr4,gr7)		,cc7,#1
+	cstdu		gr12,@(gr4,gr7)		,cc7,#1
+	cstdu		gr12,@(gr4,gr7)		,cc7,#1
+	cstdu		gr12,@(gr4,gr7)		,cc7,#1
+	cstdu		gr12,@(gr4,gr7)		,cc7,#1
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	csubcc		gr5,gr6,gr5		,cc7,#1	; also set ICC3
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	subicc		gr5,#64,gr0,icc0
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	beqlr		icc3,#0
+	bnc		icc0,#2,0b
+
+	# now do 32-byte remnant
+	subicc.p	gr5,#32,gr0,icc0
+	setlos		#32,gr6
+	cknc		icc0,cc7
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	csubcc		gr5,gr6,gr5		,cc7,#1	; also set ICC3
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	setlos		#16,gr6
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	subicc		gr5,#16,gr0,icc0
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	beqlr		icc3,#0
+
+	# now do 16-byte remnant
+	cknc		icc0,cc7
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	csubcc		gr5,gr6,gr5		,cc7,#1	; also set ICC3
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	beqlr		icc3,#0
+
+	# now do 8-byte remnant
+	subicc		gr5,#8,gr0,icc1
+	cknc		icc1,cc7
+	cstdu.p		gr12,@(gr4,gr7)		,cc7,#1
+	csubcc		gr5,gr7,gr5		,cc7,#1	; also set ICC3
+	setlos.p	#4,gr7
+	beqlr		icc3,#0
+
+	# now do 4-byte remnant
+	subicc		gr5,#4,gr0,icc0
+	addi.p		gr4,#4,gr4
+	cknc		icc0,cc7
+	cstu.p		gr12,@(gr4,gr7)		,cc7,#1
+	csubcc		gr5,gr7,gr5		,cc7,#1	; also set ICC3
+	subicc.p	gr5,#2,gr0,icc1
+	beqlr		icc3,#0
+
+	# now do 2-byte remnant
+	setlos		#2,gr7
+	addi.p		gr4,#2,gr4
+	cknc		icc1,cc7
+	csthu.p		gr12,@(gr4,gr7)		,cc7,#1
+	csubcc		gr5,gr7,gr5		,cc7,#1	; also set ICC3
+	subicc.p	gr5,#1,gr0,icc0
+	beqlr		icc3,#0
+
+	# now do 1-byte remnant
+	setlos		#0,gr7
+	addi.p		gr4,#2,gr4
+	cknc		icc0,cc7
+	cstb.p		gr12,@(gr4,gr0)		,cc7,#1
+	bralr
+__memset_end:
+
+	.size		memset, __memset_end-memset
+
+###############################################################################
+#
+# clear memory in userspace
+# - return the number of bytes that could not be cleared (0 on complete success)
+#
+# long __memset_user(void *p, size_t count)
+#
+###############################################################################
+        .globl		__memset_user, __memset_user_error_lr, __memset_user_error_handler
+        .type		__memset_user,@function
+__memset_user:
+	movsg		lr,gr11
+
+	# abuse memset to do the dirty work
+	or.p		gr9,gr9,gr10
+	setlos		#0,gr9
+	call		memset
+__memset_user_error_lr:
+	jmpl.p		@(gr11,gr0)
+	setlos		#0,gr8
+
+	# deal any exception generated by memset
+	# GR4  - memset's address tracking pointer
+	# GR7  - memset's step value (index register for store insns)
+	# GR8  - memset's original start address
+	# GR10 - memset's original count
+__memset_user_error_handler:
+	add.p		gr4,gr7,gr4
+	add		gr8,gr10,gr8
+	jmpl.p		@(gr11,gr0)
+	sub		gr8,gr4,gr8		; we return the amount left uncleared
+
+	.size		__memset_user, .-__memset_user
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__muldi3.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__muldi3.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__muldi3.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__muldi3.S	2004-11-05 14:13:03.308546024 +0000
@@ -0,0 +1,32 @@
+/* __muldi3.S:	64-bit multiply
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# unsigned long long __muldi3(unsigned long long x [GR8:GR9],
+#                             unsigned long long y [GR10:GR11])
+#
+###############################################################################
+        .globl		__muldi3, __mulll, __umulll
+        .type		__muldi3,@function
+__muldi3:
+__mulll:
+__umulll:
+	umul		gr8,gr11,gr4		; GR4:GR5 = x.MSW * y.LSW
+	umul		gr9,gr10,gr6		; GR6:GR7 = x.LSW * y.MSW
+	umul.p		gr9,gr11,gr8		; GR8:GR9 = x.LSW * y.LSW
+	add		gr5,gr7,gr5
+	add.p		gr8,gr5,gr8		; GR8 += GR5 + GR7
+	bralr
+	.size		__muldi3, .-__muldi3
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__negdi2.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__negdi2.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/__negdi2.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/__negdi2.S	2004-11-05 14:13:03.312545687 +0000
@@ -0,0 +1,28 @@
+/* __negdi2.S: 64-bit negate
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# unsigned long long __negdi2(unsigned long long value [GR8:GR9])
+#
+###############################################################################
+        .globl		__negdi2
+        .type		__negdi2,@function
+__negdi2:
+	subcc		gr0,gr9,gr9,icc0
+	subx		gr0,gr8,gr8,icc0
+	bralr
+	.size		__negdi2, .-__negdi2
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/outsl_ns.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/outsl_ns.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/outsl_ns.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/outsl_ns.S	2004-11-05 14:13:03.315545433 +0000
@@ -0,0 +1,59 @@
+/* outsl_ns.S: output array of 4b words to device without byte swapping
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# void __outsl_ns(unsigned int port, const void *buf, int n)
+#
+###############################################################################
+        .globl		__outsl_ns
+        .type		__outsl_ns,@function
+__outsl_ns:
+	andicc.p	gr9,#3,gr0,icc0
+	setlos		#4,gr4
+	bne		icc0,#0,__outsl_ns_misaligned
+	subi		gr9,#4,gr9
+0:
+	ldu.p		@(gr9,gr4),gr5
+	subicc		gr10,#1,gr10,icc0
+	sti.p		gr5,@(gr8,#0)
+	bhi		icc0,#2,0b
+
+	membar
+	bralr
+
+__outsl_ns_misaligned:
+	subi.p		gr9,#1,gr9
+	setlos		#1,gr4
+0:
+	ldubu		@(gr9,gr4),gr5
+	ldubu.p		@(gr9,gr4),gr6
+	slli		gr5,#8,gr5
+	ldubu.p		@(gr9,gr4),gr7
+	or		gr5,gr6,gr5
+	ldubu.p		@(gr9,gr4),gr6
+	slli		gr5,#16,gr5
+	slli.p		gr7,#8,gr7
+	or		gr5,gr6,gr5
+	subicc.p	gr10,#1,gr10,icc0
+	or		gr5,gr7,gr5
+
+	sti.p		gr5,@(gr8,#0)
+	bhi		icc0,#2,0b
+
+	membar
+	bralr
+
+	.size		__outsl_ns, .-__outsl_ns
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/outsl_sw.S linux-2.6.10-rc1-mm3-frv/arch/frv/lib/outsl_sw.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/lib/outsl_sw.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/lib/outsl_sw.S	2004-11-05 14:13:03.319545095 +0000
@@ -0,0 +1,45 @@
+/* outsl_ns.S: output array of 4b words to device with byte swapping
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# void __outsl_sw(unsigned int port, const void *buf, int n)
+#
+###############################################################################
+        .globl		__outsl_sw
+        .type		__outsl_sw,@function
+__outsl_sw:
+	subi.p		gr9,#1,gr9
+	setlos		#1,gr4
+0:
+	ldubu		@(gr9,gr4),gr5
+	ldubu		@(gr9,gr4),gr6
+	slli		gr6,#8,gr6
+	ldubu.p		@(gr9,gr4),gr7
+	or		gr5,gr6,gr5
+	ldubu.p		@(gr9,gr4),gr6
+	slli		gr7,#16,gr7
+	slli.p		gr6,#24,gr6
+	or		gr5,gr7,gr5
+	subicc.p	gr10,#1,gr10,icc0
+	or		gr5,gr6,gr5
+
+	sti.p		gr5,@(gr8,#0)
+	bhi		icc0,#2,0b
+
+	membar
+	bralr
+
+	.size		__outsl_sw, .-__outsl_sw
