Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUJPJCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUJPJCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 05:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268693AbUJPJCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 05:02:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:56553 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268688AbUJPJCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 05:02:23 -0400
Subject: [PATCH] ppc32: Add "native" iomap interfaces
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1097917142.8961.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 18:59:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds proper ppc32 "iomap" interfaces.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/arch/ppc/Kconfig linux-lappy/arch/ppc/Kconfig
--- linux-2.5/arch/ppc/Kconfig	2004-09-24 14:32:52.000000000 +1000
+++ linux-lappy/arch/ppc/Kconfig	2004-10-16 18:46:34.000000000 +1000
@@ -35,10 +35,6 @@
 	bool
 	default y
 
-config GENERIC_IOMAP
-	bool
-	default y
-
 source "init/Kconfig"
 
 menu "Processor"
diff -urN linux-2.5/arch/ppc/kernel/pci.c linux-lappy/arch/ppc/kernel/pci.c
--- linux-2.5/arch/ppc/kernel/pci.c	2004-09-24 14:32:53.000000000 +1000
+++ linux-lappy/arch/ppc/kernel/pci.c	2004-10-16 18:12:50.000000000 +1000
@@ -1709,6 +1709,32 @@
 	res->child = NULL;
 }
 
+void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
+{
+	unsigned long start = pci_resource_start(dev, bar);
+	unsigned long len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+	if (!len)
+		return NULL;
+	if (max && len > max)
+		len = max;
+	if (flags & IORESOURCE_IO)
+		return ioport_map(start, len);
+	if (flags & IORESOURCE_MEM)
+		return (void __iomem *) start;
+	/* What? */
+	return NULL;
+}
+
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	/* Nothing to do */
+}
+EXPORT_SYMBOL(pci_iomap);
+EXPORT_SYMBOL(pci_iounmap);
+
+
 /*
  * Null PCI config access functions, for the case when we can't
  * find a hose.
diff -urN linux-2.5/arch/ppc/mm/pgtable.c linux-lappy/arch/ppc/mm/pgtable.c
--- linux-2.5/arch/ppc/mm/pgtable.c	2004-09-24 14:32:55.000000000 +1000
+++ linux-lappy/arch/ppc/mm/pgtable.c	2004-10-16 18:23:21.000000000 +1000
@@ -22,6 +22,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
@@ -271,6 +272,18 @@
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
 }
 
+void __iomem *ioport_map(unsigned long port, unsigned int len)
+{
+	return (void __iomem *) (port + _IO_BASE);
+}
+
+void ioport_unmap(void __iomem *addr)
+{
+	/* Nothing to do */
+}
+EXPORT_SYMBOL(ioport_map);
+EXPORT_SYMBOL(ioport_unmap);
+
 int
 map_page(unsigned long va, phys_addr_t pa, int flags)
 {
diff -urN linux-2.5/include/asm-ppc/io.h linux-lappy/include/asm-ppc/io.h
--- linux-2.5/include/asm-ppc/io.h	2004-09-24 14:36:10.000000000 +1000
+++ linux-lappy/include/asm-ppc/io.h	2004-10-16 18:16:24.000000000 +1000
@@ -398,6 +398,79 @@
 	return 0;
 }
 
+/*
+ * Here comes the ppc implementation of the IOMAP 
+ * interfaces.
+ */
+static inline unsigned int ioread8(void __iomem *addr)
+{
+	return readb(addr);
+}
+
+static inline unsigned int ioread16(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+static inline unsigned int ioread32(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static inline void iowrite8(u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+
+static inline void iowrite16(u16 val, void __iomem *addr)
+{
+	writew(val, addr);
+}
+
+static inline void iowrite32(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+
+static inline void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	_insb((u8 __force *) addr, dst, count);
+}
+
+static inline void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	_insw_ns((u16 __force *) addr, dst, count);
+}
+
+static inline void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	_insl_ns((u32 __force *) addr, dst, count);
+}
+
+static inline void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	_outsb((u8 __force *) addr, src, count);
+}
+
+static inline void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	_outsw_ns((u16 __force *) addr, src, count);
+}
+
+static inline void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	_outsl_ns((u32 __force *) addr, src, count);
+}
+
+/* Create a virtual mapping cookie for an IO port range */
+extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+extern void ioport_unmap(void __iomem *);
+
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+
 #endif /* _PPC_IO_H */
 
 #ifdef CONFIG_8260_PCI9


