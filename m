Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbULNQQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbULNQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbULNQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:16:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34245 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261542AbULNQOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:14:03 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV Minix & ext2 bitops fixes
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 14 Dec 2004 16:13:57 +0000
Message-ID: <9392.1103040837@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch does two things:

 (1) Implements the ext2/ext3 bitops in terms of the main bitops functions.

 (2) Changes the Minix bitops to use the ext2 bitops (LE) rather than the main
     bitops (BE).

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-bitops-2610rc2mm3.diff 
 bitops.h |   71 +++++++++------------------------------------------------------
 1 files changed, 11 insertions(+), 60 deletions(-)

diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/include/asm-frv/bitops.h linux-2.6.10-rc3-mm1-misc/include/asm-frv/bitops.h
--- linux-2.6.10-rc3-mm1-mmcleanup/include/asm-frv/bitops.h	2004-12-13 17:34:20.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/include/asm-frv/bitops.h	2004-12-14 15:33:31.000000000 +0000
@@ -258,65 +258,16 @@
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
-static inline int ext2_set_bit(int nr, volatile void * addr)
-{
-	unsigned long old, tmp, mask;
-	volatile unsigned char *ptr = addr;
-	ptr += nr >> 3;
-
-	asm("0:						\n"
-	    "	setlos.p	#1,%3			\n"
-	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-	    "	sll%I4.p	%3,%4,%3		\n"
-	    "	ckeq		icc3,cc7		\n"
-	    "	ldub.p		%M0,%1			\n"	/* LDUB.P/ORCR must be atomic */
-	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-	    "	or		%1,%3,%2		\n"
-	    "	cstb.p		%2,%M0		,cc3,#1	\n"
-	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
-	    "	beq		icc3,#0,0b		\n"
-	    : "+U"(*ptr), "=&r"(old), "=r"(tmp), "=&r"(mask)
-	    : "Ir"(nr & 7)
-	    : "memory", "cc7", "cc3", "icc3"
-	    );
-
-	return old & mask;
-}
-
-#define ext2_set_bit_atomic(lock,nr,addr) ext2_set_bit((nr), addr)
-
-static inline int ext2_clear_bit(int nr, volatile void * addr)
-{
-	unsigned long old, tmp, mask;
-	volatile unsigned char *ptr = addr;
-	ptr += nr >> 3;
-
-	asm("0:						\n"
-	    "	setlos.p	#1,%3			\n"
-	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-	    "	sll%I4.p	%3,%4,%3		\n"
-	    "	ckeq		icc3,cc7		\n"
-	    "	ldub.p		%M0,%1			\n"	/* LDUB.P/ORCR must be atomic */
-	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-	    "	not		%3,%2			\n"
-	    "	and		%1,%2,%2		\n"
-	    "	cstb.p		%2,%M0		,cc3,#1	\n"
-	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
-	    "	beq		icc3,#0,0b		\n"
-	    : "+U"(*ptr), "=&r"(old), "=r"(tmp), "=&r"(mask)
-	    : "Ir"(nr & 7)
-	    : "memory", "cc7", "cc3", "icc3"
-	    );
-
-	return old & mask;
-}
+#define ext2_set_bit(nr, addr)		test_and_set_bit  ((nr) ^ 0x18, (addr))
+#define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 0x18, (addr))
 
-#define ext2_clear_bit_atomic(lock,nr,addr) ext2_clear_bit((nr), addr)
+#define ext2_set_bit_atomic(lock,nr,addr)	ext2_set_bit((nr), addr)
+#define ext2_clear_bit_atomic(lock,nr,addr)	ext2_clear_bit((nr), addr)
 
 static inline int ext2_test_bit(int nr, const volatile void * addr)
 {
-	int			mask;
-	const volatile unsigned char	*ADDR = (const unsigned char *) addr;
+	const volatile unsigned char *ADDR = (const unsigned char *) addr;
+	int mask;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
@@ -379,11 +330,11 @@
 }
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr)			test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
+#define minix_test_and_set_bit(nr,addr)		ext2_set_bit(nr,addr)
+#define minix_set_bit(nr,addr)			ext2_set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr)	ext2_clear_bit(nr,addr)
+#define minix_test_bit(nr,addr)			ext2_test_bit(nr,addr)
+#define minix_find_first_zero_bit(addr,size)	ext2_find_first_zero_bit(addr,size)
 
 #endif /* __KERNEL__ */
 
