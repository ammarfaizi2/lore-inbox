Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWBAJQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWBAJQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWBAJNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:13:41 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:54090 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932337AbWBAJD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:29 -0500
Message-Id: <20060201090325.905071000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:38 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 14/44] generic hweight{64,32,16,8}()
Content-Disposition: inline; filename=hweight-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch introduces the C-language equivalents of the functions below:

unsigned int hweight32(unsigned int w);
unsigned int hweight16(unsigned int w);
unsigned int hweight8(unsigned int w);
unsigned long hweight64(__u64 w);

In include/asm-generic/bitops/hweight.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/hweight.h |   54 +++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/hweight.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/hweight.h
@@ -0,0 +1,54 @@
+#ifndef _ASM_GENERIC_BITOPS_HWEIGHT_H_
+#define _ASM_GENERIC_BITOPS_HWEIGHT_H_
+
+#include <asm/types.h>
+
+/**
+ * hweightN - returns the hamming weight of a N-bit word
+ * @x: the word to weigh
+ *
+ * The Hamming Weight of a number is the total number of bits set in it.
+ */
+
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
+static inline unsigned long hweight64(__u64 w)
+{
+#if BITS_PER_LONG == 32
+	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
+#elif BITS_PER_LONG == 64
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+#endif /* _ASM_GENERIC_BITOPS_HWEIGHT_H_ */

--
