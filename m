Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUHTWxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUHTWxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 18:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268790AbUHTWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 18:53:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31976 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268676AbUHTWw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 18:52:56 -0400
Date: Fri, 20 Aug 2004 15:52:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: joshk@triplehelix.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix bug in sparc64 user copy patch
Message-Id: <20040820155250.69c09781.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There were a few slight bugs in the UltraSPARC-I/II/IIi/IIe
parts of that patch I sent you, here is the fix.

===== arch/sparc64/lib/U1copy_from_user.S 1.1 vs edited =====
--- 1.1/arch/sparc64/lib/U1copy_from_user.S	2004-08-19 20:10:28 -07:00
+++ edited/arch/sparc64/lib/U1copy_from_user.S	2004-08-20 10:22:41 -07:00
@@ -20,4 +20,14 @@
 #define LOAD_BLK(addr,dest)	ldda [addr] ASI_BLK_AIUS, dest
 #define EX_RETVAL(x)		0
 
+	/* Writing to %asi is _expensive_ so we hardcode it.
+	 * Reading %asi to check for KERNEL_DS is comparatively
+	 * cheap.
+	 */
+#define PREAMBLE					\
+	rd		%asi, %g1;			\
+	cmp		%g1, ASI_AIUS;			\
+	bne,pn		%icc, memcpy_user_stub;		\
+	 nop;						\
+
 #include "U1memcpy.S"
===== arch/sparc64/lib/U1memcpy.S 1.1 vs edited =====
--- 1.1/arch/sparc64/lib/U1memcpy.S	2004-08-19 20:10:30 -07:00
+++ edited/arch/sparc64/lib/U1memcpy.S	2004-08-20 11:37:27 -07:00
@@ -193,6 +193,7 @@
 	and		%g2, 7, %g2
 	andncc		%g3, 0x7, %g3
 	fmovd		%f0, %f2
+	sub		%g3, 0x8, %g3
 	sub		%o2, %o4, %o2
 
 	add		%g1, %o4, %g1
@@ -444,7 +445,7 @@
 2:	membar		#StoreLoad | #StoreStore
 	VISExit
 	retl
-	 mov		%g5, %o0
+	 mov		EX_RETVAL(%g5), %o0
 
 	.align		64
 70:	/* 16 < len <= (5 * 64) */
@@ -539,7 +540,7 @@
 	 add		%o1, 4, %o1
 
 85:	retl
-	 mov		%g5, %o0
+	 mov		EX_RETVAL(%g5), %o0
 
 	.align		32
 90:	EX_LD(LOAD(ldub, %o1, %g1))
@@ -548,4 +549,4 @@
 	bgu,pt		%XCC, 90b
 	 add		%o1, 1, %o1
 	retl
-	 mov		%g5, %o0
+	 mov		EX_RETVAL(%g5), %o0
