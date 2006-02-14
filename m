Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWBNFE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWBNFE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWBNFE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:04:58 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:974 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030355AbWBNFEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:04:54 -0500
Message-Id: <20060214050441.708881000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:03:52 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 01/47] alpha: use config options instead of __alpha_fix__ and __alpha_cix__
Content-Disposition: inline; filename=alpha-config-cpu-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use config options instead of gcc builtin definition
to tell the use of instruction set extensions (CIX and FIX).

This is introduced to tell the kbuild system the use of opmized hweight*()
routines on alpha architecture.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>


 arch/alpha/lib/ev6-memchr.S |    2 +-
 arch/alpha/lib/fpreg.c      |    8 ++++----
 include/asm-alpha/bitops.h  |   10 +++++-----
 include/asm-alpha/fpu.h     |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

Index: 2.6-rc/arch/alpha/lib/ev6-memchr.S
===================================================================
--- 2.6-rc.orig/arch/alpha/lib/ev6-memchr.S
+++ 2.6-rc/arch/alpha/lib/ev6-memchr.S
@@ -84,7 +84,7 @@ $last_quad:
         beq     $2, $not_found	# U : U L U L
 
 $found_it:
-#if defined(__alpha_fix__) && defined(__alpha_cix__)
+#ifdef CONFIG_ALPHA_EV67
 	/*
 	 * Since we are guaranteed to have set one of the bits, we don't
 	 * have to worry about coming back with a 0x40 out of cttz...
Index: 2.6-rc/arch/alpha/lib/fpreg.c
===================================================================
--- 2.6-rc.orig/arch/alpha/lib/fpreg.c
+++ 2.6-rc/arch/alpha/lib/fpreg.c
@@ -4,7 +4,7 @@
  * (C) Copyright 1998 Linus Torvalds
  */
 
-#if defined(__alpha_cix__) || defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 #define STT(reg,val)  asm volatile ("ftoit $f"#reg",%0" : "=r"(val));
 #else
 #define STT(reg,val)  asm volatile ("stt $f"#reg",%0" : "=m"(val));
@@ -53,7 +53,7 @@ alpha_read_fp_reg (unsigned long reg)
 	return val;
 }
 
-#if defined(__alpha_cix__) || defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 #define LDT(reg,val)  asm volatile ("itoft %0,$f"#reg : : "r"(val));
 #else
 #define LDT(reg,val)  asm volatile ("ldt $f"#reg",%0" : : "m"(val));
@@ -98,7 +98,7 @@ alpha_write_fp_reg (unsigned long reg, u
 	}
 }
 
-#if defined(__alpha_cix__) || defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 #define STS(reg,val)  asm volatile ("ftois $f"#reg",%0" : "=r"(val));
 #else
 #define STS(reg,val)  asm volatile ("sts $f"#reg",%0" : "=m"(val));
@@ -147,7 +147,7 @@ alpha_read_fp_reg_s (unsigned long reg)
 	return val;
 }
 
-#if defined(__alpha_cix__) || defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 #define LDS(reg,val)  asm volatile ("itofs %0,$f"#reg : : "r"(val));
 #else
 #define LDS(reg,val)  asm volatile ("lds $f"#reg",%0" : : "m"(val));
Index: 2.6-rc/include/asm-alpha/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-alpha/bitops.h
+++ 2.6-rc/include/asm-alpha/bitops.h
@@ -261,7 +261,7 @@ static inline unsigned long ffz_b(unsign
 
 static inline unsigned long ffz(unsigned long word)
 {
-#if defined(__alpha_cix__) && defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 	/* Whee.  EV67 can calculate it directly.  */
 	return __kernel_cttz(~word);
 #else
@@ -281,7 +281,7 @@ static inline unsigned long ffz(unsigned
  */
 static inline unsigned long __ffs(unsigned long word)
 {
-#if defined(__alpha_cix__) && defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 	/* Whee.  EV67 can calculate it directly.  */
 	return __kernel_cttz(word);
 #else
@@ -313,7 +313,7 @@ static inline int ffs(int word)
 /*
  * fls: find last bit set.
  */
-#if defined(__alpha_cix__) && defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 static inline int fls(int word)
 {
 	return 64 - __kernel_ctlz(word & 0xffffffff);
@@ -326,7 +326,7 @@ static inline int fls(int word)
 /* Compute powers of two for the given integer.  */
 static inline long floor_log2(unsigned long word)
 {
-#if defined(__alpha_cix__) && defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 	return 63 - __kernel_ctlz(word);
 #else
 	long bit;
@@ -347,7 +347,7 @@ static inline long ceil_log2(unsigned lo
  * of bits set) of a N-bit word
  */
 
-#if defined(__alpha_cix__) && defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 /* Whee.  EV67 can calculate it directly.  */
 static inline unsigned long hweight64(unsigned long w)
 {
Index: 2.6-rc/include/asm-alpha/fpu.h
===================================================================
--- 2.6-rc.orig/include/asm-alpha/fpu.h
+++ 2.6-rc/include/asm-alpha/fpu.h
@@ -130,7 +130,7 @@ rdfpcr(void)
 {
 	unsigned long tmp, ret;
 
-#if defined(__alpha_cix__) || defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 	__asm__ __volatile__ (
 		"ftoit $f0,%0\n\t"
 		"mf_fpcr $f0\n\t"
@@ -154,7 +154,7 @@ wrfpcr(unsigned long val)
 {
 	unsigned long tmp;
 
-#if defined(__alpha_cix__) || defined(__alpha_fix__)
+#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 	__asm__ __volatile__ (
 		"ftoit $f0,%0\n\t"
 		"itoft %1,$f0\n\t"

--
