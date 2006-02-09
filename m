Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWBIFzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWBIFzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWBIFzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:55:38 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:4553 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1422807AbWBIFzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:55:37 -0500
Date: Thu, 9 Feb 2006 14:55:31 +0900
To: Andi Kleen <ak@suse.de>
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: remove __alpha_cix__ and __alpha_fix__
Message-ID: <20060209055531.GA2642@miraclelinux.com>
References: <20060201090224.536581000@localhost.localdomain> <200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru> <200602011124.29423.ak@suse.de> <20060202125007.GA5918@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202125007.GA5918@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 09:50:07PM +0900, mita wrote:
> This patch will put hweight*() into lib/hweight.c

I realized that this patch broke ia64 and alpha.
I want to fix it by making new config option like CONFIG_GENERIC_HWEIGHT.
But there is a difficulty to define CONFIG_GENERIC_HWEIGHT on alpha.
So I want to add the patch below. Does it cause anything bad?

Index: 2.6-git/arch/alpha/lib/ev6-memchr.S
===================================================================
--- 2.6-git.orig/arch/alpha/lib/ev6-memchr.S
+++ 2.6-git/arch/alpha/lib/ev6-memchr.S
@@ -84,7 +84,7 @@ $last_quad:
         beq     $2, $not_found	# U : U L U L
 
 $found_it:
-#if defined(__alpha_fix__) && defined(__alpha_cix__)
+#ifdef CONFIG_ALPHA_EV67
 	/*
 	 * Since we are guaranteed to have set one of the bits, we don't
 	 * have to worry about coming back with a 0x40 out of cttz...
Index: 2.6-git/arch/alpha/lib/fpreg.c
===================================================================
--- 2.6-git.orig/arch/alpha/lib/fpreg.c
+++ 2.6-git/arch/alpha/lib/fpreg.c
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
Index: 2.6-git/include/asm-alpha/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-alpha/bitops.h
+++ 2.6-git/include/asm-alpha/bitops.h
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
Index: 2.6-git/include/asm-alpha/fpu.h
===================================================================
--- 2.6-git.orig/include/asm-alpha/fpu.h
+++ 2.6-git/include/asm-alpha/fpu.h
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
