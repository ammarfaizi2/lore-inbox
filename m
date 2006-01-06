Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752452AbWAFQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbWAFQ3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWAFQ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752445AbWAFQ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:47 -0500
Date: Fri, 6 Jan 2006 16:29:35 GMT
Message-Id: <200601061629.k06GTZBm011362@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 2/17] FRV: Drop 8/16-bit xchg and cmpxchg
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch drops support for 8-bit and 16-bit xchg and cmpxchg
emulation and implements 32-bit xchg with the SWAP/SWAPI instruction.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-atomic-2615.diff
 arch/frv/lib/atomic-ops.S |   92 --------------------------------------------
 include/asm-frv/atomic.h  |   96 ++--------------------------------------------
 2 files changed, 5 insertions(+), 183 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/lib/atomic-ops.S linux-2.6.15-frv/arch/frv/lib/atomic-ops.S
--- /warthog/kernels/linux-2.6.15/arch/frv/lib/atomic-ops.S	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/lib/atomic-ops.S	2006-01-06 14:43:43.000000000 +0000
@@ -129,48 +129,6 @@ atomic_sub_return:
 
 ###############################################################################
 #
-# uint8_t __xchg_8(uint8_t i, uint8_t *v)
-#
-###############################################################################
-	.globl		__xchg_8
-        .type		__xchg_8,@function
-__xchg_8:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ldub.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	cstb.p		gr10,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		__xchg_8, .-__xchg_8
-
-###############################################################################
-#
-# uint16_t __xchg_16(uint16_t i, uint16_t *v)
-#
-###############################################################################
-	.globl		__xchg_16
-        .type		__xchg_16,@function
-__xchg_16:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	lduh.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	csth.p		gr10,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		__xchg_16, .-__xchg_16
-
-###############################################################################
-#
 # uint32_t __xchg_32(uint32_t i, uint32_t *v)
 #
 ###############################################################################
@@ -192,56 +150,6 @@ __xchg_32:
 
 ###############################################################################
 #
-# uint8_t __cmpxchg_8(uint8_t *v, uint8_t test, uint8_t new)
-#
-###############################################################################
-	.globl		__cmpxchg_8
-        .type		__cmpxchg_8,@function
-__cmpxchg_8:
-	or.p		gr8,gr8,gr11
-0:
-	orcc		gr0,gr0,gr0,icc3
-	ckeq		icc3,cc7
-	ldub.p		@(gr11,gr0),gr8
-	orcr		cc7,cc7,cc3
-	sub		gr8,gr9,gr7
-	sllicc		gr7,#24,gr0,icc0
-	bne		icc0,#0,1f
-	cstb.p		gr10,@(gr11,gr0)	,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1
-	beq		icc3,#0,0b
-1:
-	bralr
-
-	.size		__cmpxchg_8, .-__cmpxchg_8
-
-###############################################################################
-#
-# uint16_t __cmpxchg_16(uint16_t *v, uint16_t test, uint16_t new)
-#
-###############################################################################
-	.globl		__cmpxchg_16
-        .type		__cmpxchg_16,@function
-__cmpxchg_16:
-	or.p		gr8,gr8,gr11
-0:
-	orcc		gr0,gr0,gr0,icc3
-	ckeq		icc3,cc7
-	lduh.p		@(gr11,gr0),gr8
-	orcr		cc7,cc7,cc3
-	sub		gr8,gr9,gr7
-	sllicc		gr7,#16,gr0,icc0
-	bne		icc0,#0,1f
-	csth.p		gr10,@(gr11,gr0)	,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1
-	beq		icc3,#0,0b
-1:
-	bralr
-
-	.size		__cmpxchg_16, .-__cmpxchg_16
-
-###############################################################################
-#
 # uint32_t __cmpxchg_32(uint32_t *v, uint32_t test, uint32_t new)
 #
 ###############################################################################
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/atomic.h linux-2.6.15-frv/include/asm-frv/atomic.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/atomic.h	2006-01-04 12:39:38.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/atomic.h	2006-01-06 14:43:43.000000000 +0000
@@ -218,51 +218,12 @@ extern unsigned long atomic_test_and_XOR
 	__typeof__(*(ptr)) __xg_orig;						\
 										\
 	switch (sizeof(__xg_orig)) {						\
-	case 1:									\
-		asm volatile(							\
-			"0:						\n"	\
-			"	orcc		gr0,gr0,gr0,icc3	\n"	\
-			"	ckeq		icc3,cc7		\n"	\
-			"	ldub.p		%M0,%1			\n"	\
-			"	orcr		cc7,cc7,cc3		\n"	\
-			"	cstb.p		%2,%M0		,cc3,#1	\n"	\
-			"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
-			"	beq		icc3,#0,0b		\n"	\
-			: "+U"(*__xg_ptr), "=&r"(__xg_orig)			\
-			: "r"(x)						\
-			: "memory", "cc7", "cc3", "icc3"			\
-			);							\
-		break;								\
-										\
-	case 2:									\
-		asm volatile(							\
-			"0:						\n"	\
-			"	orcc		gr0,gr0,gr0,icc3	\n"	\
-			"	ckeq		icc3,cc7		\n"	\
-			"	lduh.p		%M0,%1			\n"	\
-			"	orcr		cc7,cc7,cc3		\n"	\
-			"	csth.p		%2,%M0		,cc3,#1	\n"	\
-			"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
-			"	beq		icc3,#0,0b		\n"	\
-			: "+U"(*__xg_ptr), "=&r"(__xg_orig)			\
-			: "r"(x)						\
-			: "memory", "cc7", "cc3", "icc3"			\
-			);							\
-		break;								\
-										\
 	case 4:									\
 		asm volatile(							\
-			"0:						\n"	\
-			"	orcc		gr0,gr0,gr0,icc3	\n"	\
-			"	ckeq		icc3,cc7		\n"	\
-			"	ld.p		%M0,%1			\n"	\
-			"	orcr		cc7,cc7,cc3		\n"	\
-			"	cst.p		%2,%M0		,cc3,#1	\n"	\
-			"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
-			"	beq		icc3,#0,0b		\n"	\
-			: "+U"(*__xg_ptr), "=&r"(__xg_orig)			\
+			"swap%I0 %2,%M0"					\
+			: "+m"(*__xg_ptr), "=&r"(__xg_orig)			\
 			: "r"(x)						\
-			: "memory", "cc7", "cc3", "icc3"			\
+			: "memory"						\
 			);							\
 		break;								\
 										\
@@ -277,8 +238,6 @@ extern unsigned long atomic_test_and_XOR
 
 #else
 
-extern uint8_t  __xchg_8 (uint8_t i,  volatile void *v);
-extern uint16_t __xchg_16(uint16_t i, volatile void *v);
 extern uint32_t __xchg_32(uint32_t i, volatile void *v);
 
 #define xchg(ptr, x)										\
@@ -287,8 +246,6 @@ extern uint32_t __xchg_32(uint32_t i, vo
 	__typeof__(*(ptr)) __xg_orig;								\
 												\
 	switch (sizeof(__xg_orig)) {								\
-	case 1: __xg_orig = (__typeof__(*(ptr))) __xchg_8 ((uint8_t)  x, __xg_ptr);	break;	\
-	case 2: __xg_orig = (__typeof__(*(ptr))) __xchg_16((uint16_t) x, __xg_ptr);	break;	\
 	case 4: __xg_orig = (__typeof__(*(ptr))) __xchg_32((uint32_t) x, __xg_ptr);	break;	\
 	default:										\
 		__xg_orig = 0;									\
@@ -318,46 +275,6 @@ extern uint32_t __xchg_32(uint32_t i, vo
 	__typeof__(*(ptr)) __xg_new = (new);					\
 										\
 	switch (sizeof(__xg_orig)) {						\
-	case 1:									\
-		asm volatile(							\
-			"0:						\n"	\
-			"	orcc		gr0,gr0,gr0,icc3	\n"	\
-			"	ckeq		icc3,cc7		\n"	\
-			"	ldub.p		%M0,%1			\n"	\
-			"	orcr		cc7,cc7,cc3		\n"	\
-			"	sub%I4		%1,%4,%2		\n"	\
-			"	sllcc		%2,#24,gr0,icc0		\n"	\
-			"	bne		icc0,#0,1f		\n"	\
-			"	cstb.p		%3,%M0		,cc3,#1	\n"	\
-			"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
-			"	beq		icc3,#0,0b		\n"	\
-			"1:						\n"	\
-			: "+U"(*__xg_ptr), "=&r"(__xg_orig), "=&r"(__xg_tmp)	\
-			: "r"(__xg_new), "NPr"(__xg_test)			\
-			: "memory", "cc7", "cc3", "icc3", "icc0"		\
-			);							\
-		break;								\
-										\
-	case 2:									\
-		asm volatile(							\
-			"0:						\n"	\
-			"	orcc		gr0,gr0,gr0,icc3	\n"	\
-			"	ckeq		icc3,cc7		\n"	\
-			"	lduh.p		%M0,%1			\n"	\
-			"	orcr		cc7,cc7,cc3		\n"	\
-			"	sub%I4		%1,%4,%2		\n"	\
-			"	sllcc		%2,#16,gr0,icc0		\n"	\
-			"	bne		icc0,#0,1f		\n"	\
-			"	csth.p		%3,%M0		,cc3,#1	\n"	\
-			"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
-			"	beq		icc3,#0,0b		\n"	\
-			"1:						\n"	\
-			: "+U"(*__xg_ptr), "=&r"(__xg_orig), "=&r"(__xg_tmp)	\
-			: "r"(__xg_new), "NPr"(__xg_test)			\
-			: "memory", "cc7", "cc3", "icc3", "icc0"		\
-			);							\
-		break;								\
-										\
 	case 4:									\
 		asm volatile(							\
 			"0:						\n"	\
@@ -388,8 +305,6 @@ extern uint32_t __xchg_32(uint32_t i, vo
 
 #else
 
-extern uint8_t  __cmpxchg_8 (uint8_t *v,  uint8_t test,  uint8_t new);
-extern uint16_t __cmpxchg_16(uint16_t *v, uint16_t test, uint16_t new);
 extern uint32_t __cmpxchg_32(uint32_t *v, uint32_t test, uint32_t new);
 
 #define cmpxchg(ptr, test, new)							\
@@ -400,8 +315,6 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 	__typeof__(*(ptr)) __xg_new = (new);					\
 										\
 	switch (sizeof(__xg_orig)) {						\
-	case 1: __xg_orig = __cmpxchg_8 (__xg_ptr, __xg_test, __xg_new); break;	\
-	case 2: __xg_orig = __cmpxchg_16(__xg_ptr, __xg_test, __xg_new); break;	\
 	case 4: __xg_orig = __cmpxchg_32(__xg_ptr, __xg_test, __xg_new); break;	\
 	default:								\
 		__xg_orig = 0;							\
@@ -414,7 +327,7 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 
 #endif
 
-#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
@@ -424,6 +337,7 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 		c = old;					\
 	c != (u);						\
 })
+
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
 #endif /* _ASM_ATOMIC_H */
