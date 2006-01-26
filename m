Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWAZDgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWAZDgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWAZDgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:36:09 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:21221 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751313AbWAZDgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:36:07 -0500
Date: Thu, 26 Jan 2006 12:36:13 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 8/12] generic hweight{32,16,8}()
Message-ID: <20060126033613.GG11138@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126032713.GA9984@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:
unsigned int hweight32(unsigned int w);
unsigned int hweight16(unsigned int w);
unsigned int hweight8(unsigned int w);

HAVE_ARCH_HWEIGHT_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:10.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:11.000000000 +0900
@@ -458,14 +458,38 @@
 #endif /* HAVE_ARCH_FFS_BITOPS */
 
 
+#ifndef HAVE_ARCH_HWEIGHT_BITOPS
+
 /*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
 
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+static inline unsigned int hweight32(unsigned int w)
+{
+        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
+        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
+        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+}
+
+static inline unsigned int hweight16(unsigned int w)
+{
+        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+        res = (res & 0x3333) + ((res >> 2) & 0x3333);
+        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
+        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+}
+
+static inline unsigned int hweight8(unsigned int w)
+{
+        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+        res = (res & 0x33) + ((res >> 2) & 0x33);
+        return (res & 0x0F) + ((res >> 4) & 0x0F);
+}
+
+#endif /* HAVE_ARCH_HWEIGHT_BITOPS */
 
 #endif /* __KERNEL__ */
 
