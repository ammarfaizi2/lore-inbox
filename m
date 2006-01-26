Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWAZDap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWAZDap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWAZDap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:30:45 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:37860 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751298AbWAZDao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:30:44 -0500
Date: Thu, 26 Jan 2006 12:30:50 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 2/12] generic __ffs()
Message-ID: <20060126033050.GA11138@miraclelinux.com>
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
unsigned long __ffs(unsigned long word);

HAVE_ARCH___FFS_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-sparc64/bitops.h


Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:08.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:09.000000000 +0900
@@ -193,6 +193,43 @@
 
 #endif /* HAVE_ARCH_NON_ATOMIC_BITOPS */
 
+#ifndef HAVE_ARCH___FFS_BITOPS
+
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Returns 0..BITS_PER_LONG-1
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	int b = 0, s;
+
+#if BITS_PER_LONG == 32
+	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
+	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
+	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
+	s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
+	s =  1; if (word << 31 != 0) s = 0; b += s;
+
+	return b;
+#elif BITS_PER_LONG == 64
+	s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
+	s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
+	s =  8; if (word << 56 != 0) s = 0; b += s; word >>= s;
+	s =  4; if (word << 60 != 0) s = 0; b += s; word >>= s;
+	s =  2; if (word << 62 != 0) s = 0; b += s; word >>= s;
+	s =  1; if (word << 63 != 0) s = 0; b += s;
+
+	return b;
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+#endif /* HAVE_ARCH___FFS_BITOPS */
+
 /*
  * fls: find last bit set.
  */
