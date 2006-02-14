Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWBNFLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWBNFLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWBNFLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:11:21 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46287 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030397AbWBNFFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:09 -0500
Message-Id: <20060214050444.235416000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:04 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
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
Subject: [patch 13/47] generic sched_find_first_bit()
Content-Disposition: inline; filename=sched-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
int sched_find_first_bit(const unsigned long *b);

In include/asm-generic/bitops/sched.h

This code largely copied from:
include/asm-powerpc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/sched.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/sched.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/sched.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BITOPS_SCHED_H_
+#define _ASM_GENERIC_BITOPS_SCHED_H_
+
+#include <linux/compiler.h>	/* unlikely() */
+#include <asm/types.h>
+
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int sched_find_first_bit(const unsigned long *b)
+{
+#if BITS_PER_LONG == 64
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 64;
+	return __ffs(b[2]) + 128;
+#elif BITS_PER_LONG == 32
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (b[3])
+		return __ffs(b[3]) + 96;
+	return __ffs(b[4]) + 128;
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+#endif /* _ASM_GENERIC_BITOPS_SCHED_H_ */

--
