Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCXD6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCXD6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVCXD6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:58:43 -0500
Received: from mail.renesas.com ([202.234.163.13]:28041 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261603AbVCXD6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:58:40 -0500
Date: Thu, 24 Mar 2005 12:58:34 +0900 (JST)
Message-Id: <20050324.125834.336470342.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sakugawa@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1] m32r: Fix M32102 I-cache invalidation
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes I-cache invalidation operation for M32102 chip,
which is one of m32r MMU-less targets.

Before this fix, the m32r kernel for M32102 chip missed I-cache
invalidation operation and switched off I-cache unintentionally.
This bug caused awful performance degradation.

Signed-off-by: Mamoru Sakugawa <sakugawa@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/arch/m32r/mm/cache.c b/arch/m32r/mm/cache.c
--- a/arch/m32r/mm/cache.c	2004-12-25 06:35:50.000000000 +0900
+++ b/arch/m32r/mm/cache.c	2005-03-10 21:43:07.708321535 +0900
@@ -4,8 +4,6 @@
  *  Copyright (C) 2002  Hirokazu Takata
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <asm/pgtable.h>
 
@@ -25,8 +23,8 @@
 #define MCCR_DCACHE_CBINV	(MCCR_CC|MCCR_DIV|MCCR_DCB)
 #define CHECK_MCCR(mccr)	(mccr = *MCCR)
 #elif defined(CONFIG_CHIP_M32102)
-#define MCCR		((volatile unsigned long*)0xfffffffc)
-#define MCCR_IIV	(1UL << 8)	/* I-cache invalidate */
+#define MCCR		((volatile unsigned char*)0xfffffffe)
+#define MCCR_IIV	(1UL << 0)	/* I-cache invalidate */
 #define MCCR_ICACHE_INV		MCCR_IIV
 #endif /* CONFIG_CHIP_XNUX2 || CONFIG_CHIP_M32700 */
 
@@ -65,4 +63,3 @@ void _flush_cache_copyback_all(void)
 
 #endif
 }
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
