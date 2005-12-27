Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVL0Xp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVL0Xp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVL0Xp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:45:27 -0500
Received: from mx.pathscale.com ([64.160.42.68]:43982 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932404AbVL0Xp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:45:26 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 3] Introduce __memcpy_toio32
X-Mercurial-Node: 7b7b442a4d6338ae8ca7c2e3124d932c9cc27b87
Message-Id: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135726914@eng-12.pathscale.com>
Date: Tue, 27 Dec 2005 15:41:55 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Cc: mpm@selenic.com, akpm@osdl.org, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is an arch-independent building block for memcpy_toio32.
It copies data to a memory-mapped I/O region, using 32-bit accesses.
This style of access is required by some devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 789a24638663 -r 7b7b442a4d63 include/asm-generic/iomap.h
--- a/include/asm-generic/iomap.h	Tue Dec 27 09:27:10 2005 +0800
+++ b/include/asm-generic/iomap.h	Tue Dec 27 15:41:48 2005 -0800
@@ -56,6 +56,12 @@
 extern void fastcall iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void fastcall iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
 
+/*
+ * MMIO copy routines.  These are guaranteed to operate in units denoted
+ * by their names.  This style of operation is required by some devices.
+ */
+extern void fastcall __memcpy_toio32(volatile void __iomem *to, const void *from, size_t count);
+
 /* Create a virtual mapping cookie for an IO port range */
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
 extern void ioport_unmap(void __iomem *);
diff -r 789a24638663 -r 7b7b442a4d63 lib/iomap.c
--- a/lib/iomap.c	Tue Dec 27 09:27:10 2005 +0800
+++ b/lib/iomap.c	Tue Dec 27 15:41:48 2005 -0800
@@ -187,6 +187,22 @@
 EXPORT_SYMBOL(iowrite16_rep);
 EXPORT_SYMBOL(iowrite32_rep);
 
+/*
+ * Copy data to an MMIO region.  MMIO space accesses are performed
+ * in the sizes indicated in each function's name.
+ */
+void fastcall __memcpy_toio32(volatile void __iomem *d, const void *s, size_t count)
+{
+	volatile u32 __iomem *dst = d;
+	const u32 *src = s;
+
+	while (--count >= 0) {
+		__raw_writel(*src++, dst++);
+	}
+}
+
+EXPORT_SYMBOL_GPL(__memcpy_toio32);
+
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
