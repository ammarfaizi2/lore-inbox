Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWAZDfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWAZDfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZDfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:35:12 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:14053 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751310AbWAZDfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:35:10 -0500
Date: Thu, 26 Jan 2006 12:35:16 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 7/12] generic ffs()
Message-ID: <20060126033516.GF11138@miraclelinux.com>
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
int ffs(int x);

HAVE_ARCH_FFS_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/linux/bitops.h


Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:10.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:10.000000000 +0900
@@ -418,13 +418,45 @@
 
 #endif /* HAVE_ARCH_SCHED_BITOPS */
 
+#ifndef HAVE_ARCH_FFS_BITOPS
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
 
-#define ffs(x) generic_ffs(x)
+static inline int ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+#endif /* HAVE_ARCH_FFS_BITOPS */
+
 
 /*
  * hweightN: returns the hamming weight (i.e. the number
