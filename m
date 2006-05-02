Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWEBU2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWEBU2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEBU2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:28:13 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:31953 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751246AbWEBU2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:28:12 -0400
Message-ID: <4457C0CD.3030304@myri.com>
Date: Tue, 02 May 2006 22:27:57 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] add __iowrite64_copy
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The following patch introduces __iowrite64_copy. It will be used by the
Myri-10G Ethernet driver to post requests to the NIC. This driver will
be submitted soon.

__iowrite64_copy copies to I/O memory in units of 64 bits when possible
(on 64 bit architectures).
It reverts to __iowrite32_copy on 32 bit architectures.

Signed-off-by: Brice Goglin <brice@myri.com>

include/linux/io.h |  1 +
lib/iomap_copy.c   | 28 ++++++++++++++++++++++++++++
2 files changed, 29 insertions(+)


--- linux-mm/include/linux/io.h.old	2006-03-24 14:14:46.000000000 -0500
+++ linux-mm/include/linux/io.h	2006-04-27 17:17:48.294803301 -0400
@@ -21,5 +21,6 @@
 #include <asm/io.h>
 
 void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
+void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
 #endif /* _LINUX_IO_H */
--- linux-mm/lib/iomap_copy.c.old	2006-03-24 14:14:49.000000000 -0500
+++ linux-mm/lib/iomap_copy.c	2006-04-27 17:27:55.339971819 -0400
@@ -40,3 +40,31 @@
 		__raw_writel(*src++, dst++);
 }
 EXPORT_SYMBOL_GPL(__iowrite32_copy);
+
+/**
+ * __iowrite64_copy - copy data to MMIO space, in 64-bit or 32-bit units
+ * @to: destination, in MMIO space (must be 64-bit aligned)
+ * @from: source (must be 64-bit aligned)
+ * @count: number of 64-bit quantities to copy
+ *
+ * Copy data from kernel space to MMIO space, in units of 32 or 64 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ */
+void __attribute__((weak)) __iowrite64_copy(void __iomem *to,
+					    const void *from,
+					    size_t count)
+{
+#ifdef CONFIG_64BIT
+	u64 __iomem *dst = to;
+	const u64 *src = from;
+	const u64 *end = src + count;
+
+	while (src < end)
+		__raw_writeq(*src++, dst++);
+#else
+	__iowrite32_copy(to, from, count * 2);
+#endif
+}
+
+EXPORT_SYMBOL_GPL(__iowrite64_copy);


