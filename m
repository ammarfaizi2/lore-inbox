Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVCGWmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVCGWmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVCGWl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:41:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261810AbVCGVsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:48:13 -0500
Date: Mon, 7 Mar 2005 13:48:08 -0800
From: Frank Rowand <frowand@mvista.com>
Message-Id: <200503072148.j27Lm8Hs006322@localhost.localdomain>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 3/5] ppc RT: ppc_mcount.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Source: MontaVista Software, Inc.
Signed-off-by: Frank Rowand <frowand@mvista.com>

Index: linux-2.6.10/arch/ppc/kernel/entry.S
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/entry.S
+++ linux-2.6.10/arch/ppc/kernel/entry.S
@@ -1018,3 +1018,85 @@ machine_check_in_rtas:
 	/* XXX load up BATs and panic */
 
 #endif /* CONFIG_PPC_OF */
+
+#ifdef CONFIG_MCOUNT
+
+/*
+ * mcount() is not the same as _mcount().  The callers of mcount() have a
+ * normal context.  The callers of _mcount() do not have a stack frame and
+ * have not saved the "caller saves" registers.
+ */
+_GLOBAL(mcount)
+	stwu	r1,-16(r1)
+	mflr	r3
+	lis	r5,mcount_enabled@ha
+	lwz	r5,mcount_enabled@l(r5)
+	stw	r3,20(r1)
+	cmpwi	r5,0
+	beq	1f
+	/* r3 contains lr (eip), put parent lr (parent_eip) in r4 */
+	lwz	r4,16(r1)
+	lwz	r4,4(r4)
+	bl	__trace
+1:
+	lwz	r0,20(r1)
+	mtlr	r0
+	addi	r1,r1,16
+	blr
+
+/*
+ * The -pg flag, which is specified in the case of CONFIG_MCOUNT, causes the
+ * C compiler to add a call to _mcount() at the start of each function preamble,
+ * before the stack frame is created.  An example of this preamble code is:
+ * 
+ * 	mflr    r0
+ * 	lis     r12,-16354
+ * 	stw     r0,4(r1)
+ * 	addi    r0,r12,-19652
+ * 	bl      0xc00034c8 <_mcount>
+ * 	mflr    r0
+ * 	stwu    r1,-16(r1)
+ */
+_GLOBAL(_mcount)
+#define M_STK_SIZE 48
+	/* Would not expect to need to save cr, but glibc version of */
+	/* _mcount() does, so cautiously saving it here too.         */
+	stwu	r1,-M_STK_SIZE(r1)
+	stw	r3, 12(r1)
+	stw	r4, 16(r1)
+	stw	r5, 20(r1)
+	stw	r6, 24(r1)
+	mflr	r3		/* will use as first arg to __trace() */
+	mfcr	r4
+	lis	r5,mcount_enabled@ha
+	lwz	r5,mcount_enabled@l(r5)
+	cmpwi	r5,0
+	stw	r3, 44(r1)	/* lr */
+	stw	r4,  8(r1)	/* cr */
+	stw	r7, 28(r1)
+	stw	r8, 32(r1)
+	stw	r9, 36(r1)
+	stw	r10,40(r1)
+	beq	1f
+	/* r3 contains lr (eip), put parent lr (parent_eip) in r4 */
+	lwz	r4,M_STK_SIZE+4(r1)
+	bl	__trace
+1:
+	lwz	r8,  8(r1)	/* cr */
+	lwz	r9, 44(r1)	/* lr */
+	lwz	r3, 12(r1)
+	lwz	r4, 16(r1)
+	lwz	r5, 20(r1)
+	mtcrf	0xff,r8
+	mtctr	r9
+	lwz	r0, 52(r1)
+	lwz	r6, 24(r1)
+	lwz	r7, 28(r1)
+	lwz	r8, 32(r1)
+	lwz	r9, 36(r1)
+	lwz	r10,40(r1)
+	addi	r1,r1,M_STK_SIZE
+	mtlr	r0
+	bctr
+
+#endif /* CONFIG_MCOUNT */
Index: linux-2.6.10/arch/ppc/boot/Makefile
===================================================================
--- linux-2.6.10.orig/arch/ppc/boot/Makefile
+++ linux-2.6.10/arch/ppc/boot/Makefile
@@ -11,6 +11,15 @@
 #
 
 CFLAGS	 	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
+
+ifdef CONFIG_MCOUNT
+# do not trace the boot loader
+nullstring :=
+space      := $(nullstring) # end of the line
+pg_flag     = $(nullstring) -pg # end of the line
+CFLAGS     := $(subst ${pg_flag},${space},${CFLAGS})
+endif
+
 HOSTCFLAGS	+= -Iarch/$(ARCH)/boot/include
 
 BOOT_TARGETS	= zImage zImage.initrd znetboot znetboot.initrd
