Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWAZDgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAZDgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAZDgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:36:47 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:25573 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932082AbWAZDgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:36:46 -0500
Date: Thu, 26 Jan 2006 12:36:52 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 9/12] generic hweight64()
Message-ID: <20060126033652.GH11138@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126032713.GA9984@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
unsigned long hweight64(__u64 w);

HAVE_ARCH_HWEIGHT64_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h

Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:11.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:11.000000000 +0900
@@ -491,6 +491,25 @@
 
 #endif /* HAVE_ARCH_HWEIGHT_BITOPS */
 
+#ifndef HAVE_ARCH_HWEIGHT64_BITOPS
+
+static inline unsigned long hweight64(__u64 w)
+{
+#if BITS_PER_LONG < 64
+	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
+#else
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#endif
+}
+
+#endif /* HAVE_ARCH_HWEIGHT64_BITOPS */
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_GENERIC_BITOPS_H */
