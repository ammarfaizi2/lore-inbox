Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVL2AjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVL2AjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVL2AjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:09 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42984 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932566AbVL2AjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:08 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 20] Introduce __memcpy_toio32
X-Mercurial-Node: ef833f6712e7e5d0e9002eaeab2d0a32d06182c8
Message-Id: <ef833f6712e7e5d0e900.1135816280@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:20 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is an arch-independent building block for memcpy_toio32.
It copies data to a memory-mapped I/O region, using 32-bit accesses.
This style of access is required by some devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r a56fd6a8895d -r ef833f6712e7 include/asm-generic/iomap.h
--- a/include/asm-generic/iomap.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-generic/iomap.h	Wed Dec 28 14:19:42 2005 -0800
@@ -56,6 +56,15 @@
 extern void fastcall iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void fastcall iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
 
+/*
+ * __memcpy_toio32 - copy data to MMIO space, in 32-bit units
+ *
+ * @to: destination, in MMIO space (must be 32-bit aligned)
+ * @from: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ */
+void fastcall __memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
 /* Create a virtual mapping cookie for an IO port range */
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
 extern void ioport_unmap(void __iomem *);
diff -r a56fd6a8895d -r ef833f6712e7 lib/iomap.c
--- a/lib/iomap.c	Wed Dec 28 14:19:42 2005 -0800
+++ b/lib/iomap.c	Wed Dec 28 14:19:42 2005 -0800
@@ -187,6 +187,17 @@
 EXPORT_SYMBOL(iowrite16_rep);
 EXPORT_SYMBOL(iowrite32_rep);
 
+void fastcall __memcpy_toio32(void __iomem *d, const void *s, size_t count)
+{
+	u32 __iomem *dst = d;
+	const u32 *src = s;
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		__raw_writel(*src++, dst++);
+	wmb();
+}
+
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
