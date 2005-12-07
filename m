Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVLGLNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVLGLNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVLGLNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:13:39 -0500
Received: from mail.renesas.com ([202.234.163.13]:38788 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1750857AbVLGLNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:13:38 -0500
Date: Wed, 07 Dec 2005 20:13:34 +0900 (JST)
Message-Id: <20051207.201334.735919797.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5-mm1] m32r: Fix M32104 cache flushing routines
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes cache memory parameter setting for the M32104 target.
So far, its performance seemed to have been degraded due to incorrect
cache parameter setting.

  * arch/m32r/boot/setup.S: Set SFR(Special Fuction Registers) region 
    to be non-cachable explicitly.
  * arch/m32r/mm/cache.c: Fix cache flushing routines not to switch off
    the M32104 cache.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/boot/setup.S |   15 ++++++++++++---
 arch/m32r/mm/cache.c   |   28 +++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 10 deletions(-)

Index: linux-2.6.15-rc5-mm1/arch/m32r/mm/cache.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/mm/cache.c	2005-12-06 22:34:17.000000000 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/mm/cache.c	2005-12-07 19:35:51.007406864 +0900
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/m32r/mm/cache.c
  *
- *  Copyright (C) 2002  Hirokazu Takata
+ *  Copyright (C) 2002-2005  Hirokazu Takata, Hayato Fujiwara
  */
 
 #include <linux/config.h>
@@ -9,7 +9,8 @@
 
 #undef MCCR
 
-#if defined(CONFIG_CHIP_XNUX2) || defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_OPSP)
+#if defined(CONFIG_CHIP_XNUX2) || defined(CONFIG_CHIP_M32700) \
+	|| defined(CONFIG_CHIP_VDEC2) || defined(CONFIG_CHIP_OPSP)
 /* Cache Control Register */
 #define MCCR		((volatile unsigned long*)0xfffffffc)
 #define MCCR_CC		(1UL << 7)	/* Cache mode modify bit */
@@ -27,7 +28,7 @@
 #define MCCR_IIV	(1UL << 0)	/* I-cache invalidate */
 #define MCCR_ICACHE_INV		MCCR_IIV
 #elif defined(CONFIG_CHIP_M32104)
-#define MCCR		((volatile unsigned long*)0xfffffffc)
+#define MCCR		((volatile unsigned short*)0xfffffffe)
 #define MCCR_IIV	(1UL << 8)	/* I-cache invalidate */
 #define MCCR_DIV	(1UL << 9)	/* D-cache invalidate */
 #define MCCR_DCB	(1UL << 10)	/* D-cache copy back */
@@ -36,7 +37,7 @@
 #define MCCR_ICACHE_INV		MCCR_IIV
 #define MCCR_DCACHE_CB		MCCR_DCB
 #define MCCR_DCACHE_CBINV	(MCCR_DIV|MCCR_DCB)
-#endif /* CONFIG_CHIP_XNUX2 || CONFIG_CHIP_M32700 */
+#endif
 
 #ifndef MCCR
 #error Unknown cache type.
@@ -47,29 +48,42 @@
 void _flush_cache_all(void)
 {
 #if defined(CONFIG_CHIP_M32102)
+	unsigned char mccr;
 	*MCCR = MCCR_ICACHE_INV;
+#elif defined(CONFIG_CHIP_M32104)
+	unsigned short mccr;
+
+	/* Copyback and invalidate D-cache */
+	/* Invalidate I-cache */
+	*MCCR |= (MCCR_ICACHE_INV | MCCR_DCACHE_CBINV);
 #else
 	unsigned long mccr;
 
 	/* Copyback and invalidate D-cache */
 	/* Invalidate I-cache */
 	*MCCR = MCCR_ICACHE_INV | MCCR_DCACHE_CBINV;
-	while ((mccr = *MCCR) & MCCR_IIV); /* loop while invalidating... */
 #endif
+	while ((mccr = *MCCR) & MCCR_IIV); /* loop while invalidating... */
 }
 
 /* Copy back D-cache and invalidate I-cache all */
 void _flush_cache_copyback_all(void)
 {
 #if defined(CONFIG_CHIP_M32102)
+	unsigned char mccr;
 	*MCCR = MCCR_ICACHE_INV;
+#elif defined(CONFIG_CHIP_M32104)
+	unsigned short mccr;
+
+	/* Copyback and invalidate D-cache */
+	/* Invalidate I-cache */
+	*MCCR |= (MCCR_ICACHE_INV | MCCR_DCACHE_CB);
 #else
 	unsigned long mccr;
 
 	/* Copyback D-cache */
 	/* Invalidate I-cache */
 	*MCCR = MCCR_ICACHE_INV | MCCR_DCACHE_CB;
-	while ((mccr = *MCCR) & MCCR_IIV); /* loop while invalidating... */
-
 #endif
+	while ((mccr = *MCCR) & MCCR_IIV); /* loop while invalidating... */
 }
Index: linux-2.6.15-rc5-mm1/arch/m32r/boot/setup.S
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/boot/setup.S	2005-12-06 22:34:17.000000000 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/boot/setup.S	2005-12-07 15:23:31.404976272 +0900
@@ -1,11 +1,10 @@
 /*
  *  linux/arch/m32r/boot/setup.S -- A setup code.
  *
- *  Copyright (C) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
- *  and Hitoshi Yamamoto
+ *  Copyright (C) 2001-2005   Hiroyuki Kondo, Hirokazu Takata,
+ *                            Hitoshi Yamamoto, Hayato Fujiwara
  *
  */
-/* $Id$ */
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
@@ -81,6 +80,16 @@ ENTRY(boot)
 ;	ldi	r1, #0x00		; cache off
 	st	r1, @r0
 #elif defined(CONFIG_CHIP_M32104)
+	ldi	r0, #-96		; DNCR0
+	seth	r1, #0x0060		;  from 0x00600000
+	or3	r1, r1, #0x0005		;  size 2MB
+	st	r1, @r0
+	seth	r1, #0x0100		;  from 0x01000000
+	or3	r1, r1, #0x0003		;  size 16MB
+	st	r1, @+r0
+	seth	r1, #0x0200		;  from 0x02000000
+	or3	r1, r1, #0x0002		;  size 32MB
+	st	r1, @+r0
 	ldi	r0, #-4              ;LDIMM	(r0, M32R_MCCR)
 	ldi	r1, #0x703		; cache on (with invalidation)
 	st	r1, @r0

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
