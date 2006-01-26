Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWAZDcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWAZDcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWAZDcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:32:31 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:55524 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750734AbWAZDc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:32:29 -0500
Date: Thu, 26 Jan 2006 12:32:36 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 4/12] generic fls() and fls64()
Message-ID: <20060126033235.GC11138@miraclelinux.com>
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
int fls(int x);
int fls64(__u64 x);

HAVE_ARCH_FLS_BITOPS is defined when the architecture has its own
fls().
HAVE_ARCH_FLS64_BITOPS is defined when the architecture has its own
fls64()

This code largely copied from:
include/linux/bitops.h


Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:10.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:10.000000000 +0900
@@ -237,12 +237,54 @@
 
 #endif /* HAVE_ARCH_FFZ_BITOPS */
 
+#ifndef HAVE_ARCH_FLS_BITOPS
+
 /*
  * fls: find last bit set.
  */
 
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+static __inline__ int fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+#endif /* HAVE_ARCH_FLS_BITOPS */
+
+#ifndef HAVE_ARCH_FLS64_BITOPS
+
+static inline int fls64(__u64 x)
+{
+	__u32 h = x >> 32;
+	if (h)
+		return fls(x) + 32;
+	return fls(x);
+}
+
+#endif /* HAVE_ARCH_FLS64_BITOPS */
 
 #ifdef __KERNEL__
 
