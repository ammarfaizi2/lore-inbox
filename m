Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUJPIK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUJPIK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 04:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUJPIK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 04:10:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:45033 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268680AbUJPIKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 04:10:47 -0400
Subject: [PATCH] ppc64: Split iomap implementation & eeh !
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097914058.8963.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 18:07:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Nowadays, it's possible to build CONFIG_PPC_PMAC without CONFIG_PPC_PSERIES,
in which case, eeh will not be included in the build (and the eeh checks are
turned into no-ops). However, we then "lose" the iomap functions. This patch
moves them to a separate file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/arch/ppc64/kernel/Makefile linux-pogo/arch/ppc64/kernel/Makefile
--- linux-2.5/arch/ppc64/kernel/Makefile	2004-09-28 10:45:48.000000000 +1000
+++ linux-pogo/arch/ppc64/kernel/Makefile	2004-10-16 18:03:38.000000000 +1000
@@ -19,7 +19,7 @@
 				     iSeries_IoMmTable.o
 pci-obj-$(CONFIG_PPC_MULTIPLATFORM)	+= pci_dn.o pci_dma_direct.o
 
-obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o $(pci-obj-y)
+obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o iomap.o $(pci-obj-y)
 
 obj-$(CONFIG_PPC_ISERIES) += iSeries_irq.o \
 			     iSeries_VpdInfo.o XmPciLpEvent.o \
diff -urN linux-2.5/arch/ppc64/kernel/eeh.c linux-pogo/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-09-24 14:33:05.000000000 +1000
+++ linux-pogo/arch/ppc64/kernel/eeh.c	2004-10-16 18:02:17.000000000 +1000
@@ -697,121 +697,6 @@
 }
 EXPORT_SYMBOL(eeh_remove_device);
 
-/*
- * Here comes the EEH implementation of the IOMAP 
- * interfaces.
- */
-unsigned int fastcall ioread8(void __iomem *addr)
-{
-	return readb(addr);
-}
-unsigned int fastcall ioread16(void __iomem *addr)
-{
-	return readw(addr);
-}
-unsigned int fastcall ioread32(void __iomem *addr)
-{
-	return readl(addr);
-}
-EXPORT_SYMBOL(ioread8);
-EXPORT_SYMBOL(ioread16);
-EXPORT_SYMBOL(ioread32);
-
-void fastcall iowrite8(u8 val, void __iomem *addr)
-{
-	writeb(val, addr);
-}
-void fastcall iowrite16(u16 val, void __iomem *addr)
-{
-	writew(val, addr);
-}
-void fastcall iowrite32(u32 val, void __iomem *addr)
-{
-	writel(val, addr);
-}
-EXPORT_SYMBOL(iowrite8);
-EXPORT_SYMBOL(iowrite16);
-EXPORT_SYMBOL(iowrite32);
-
-/*
- * These are the "repeat read/write" functions. Note the
- * non-CPU byte order. We do things in "IO byteorder"
- * here.
- *
- * FIXME! We could make these do EEH handling if we really
- * wanted. Not clear if we do.
- */
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
-{
-	_insb((u8 __force *) addr, dst, count);
-}
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
-{
-	_insw_ns((u16 __force *) addr, dst, count);
-}
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
-{
-	_insl_ns((u32 __force *) addr, dst, count);
-}
-EXPORT_SYMBOL(ioread8_rep);
-EXPORT_SYMBOL(ioread16_rep);
-EXPORT_SYMBOL(ioread32_rep);
-
-void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	_outsb((u8 __force *) addr, src, count);
-}
-void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	_outsw_ns((u16 __force *) addr, src, count);
-}
-void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	_outsl_ns((u32 __force *) addr, src, count);
-}
-EXPORT_SYMBOL(iowrite8_rep);
-EXPORT_SYMBOL(iowrite16_rep);
-EXPORT_SYMBOL(iowrite32_rep);
-
-void __iomem *ioport_map(unsigned long port, unsigned int len)
-{
-	if (!_IO_IS_VALID(port))
-		return NULL;
-	return (void __iomem *) (port+pci_io_base);
-}
-
-void ioport_unmap(void __iomem *addr)
-{
-	/* Nothing to do */
-}
-EXPORT_SYMBOL(ioport_map);
-EXPORT_SYMBOL(ioport_unmap);
-
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
-{
-	unsigned long start = pci_resource_start(dev, bar);
-	unsigned long len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (!len)
-		return NULL;
-	if (max && len > max)
-		len = max;
-	if (flags & IORESOURCE_IO)
-		return ioport_map(start, len);
-	if (flags & IORESOURCE_MEM)
-		return (void __iomem *) start;
-	/* What? */
-	return NULL;
-}
-
-void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{
-	/* Nothing to do */
-}
-EXPORT_SYMBOL(pci_iomap);
-EXPORT_SYMBOL(pci_iounmap);
-
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	unsigned int cpu;
diff -urN linux-2.5/arch/ppc64/kernel/iomap.c linux-pogo/arch/ppc64/kernel/iomap.c
--- /dev/null	2004-09-01 15:26:22.000000000 +1000
+++ linux-pogo/arch/ppc64/kernel/iomap.c	2004-10-16 18:02:11.000000000 +1000
@@ -0,0 +1,119 @@
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/mm.h>
+#include <asm/io.h>
+
+/*
+ * Here comes the ppc64 implementation of the IOMAP 
+ * interfaces.
+ */
+unsigned int fastcall ioread8(void __iomem *addr)
+{
+	return readb(addr);
+}
+unsigned int fastcall ioread16(void __iomem *addr)
+{
+	return readw(addr);
+}
+unsigned int fastcall ioread32(void __iomem *addr)
+{
+	return readl(addr);
+}
+EXPORT_SYMBOL(ioread8);
+EXPORT_SYMBOL(ioread16);
+EXPORT_SYMBOL(ioread32);
+
+void fastcall iowrite8(u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+void fastcall iowrite16(u16 val, void __iomem *addr)
+{
+	writew(val, addr);
+}
+void fastcall iowrite32(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+EXPORT_SYMBOL(iowrite8);
+EXPORT_SYMBOL(iowrite16);
+EXPORT_SYMBOL(iowrite32);
+
+/*
+ * These are the "repeat read/write" functions. Note the
+ * non-CPU byte order. We do things in "IO byteorder"
+ * here.
+ *
+ * FIXME! We could make these do EEH handling if we really
+ * wanted. Not clear if we do.
+ */
+void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	_insb((u8 __force *) addr, dst, count);
+}
+void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	_insw_ns((u16 __force *) addr, dst, count);
+}
+void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	_insl_ns((u32 __force *) addr, dst, count);
+}
+EXPORT_SYMBOL(ioread8_rep);
+EXPORT_SYMBOL(ioread16_rep);
+EXPORT_SYMBOL(ioread32_rep);
+
+void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	_outsb((u8 __force *) addr, src, count);
+}
+void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	_outsw_ns((u16 __force *) addr, src, count);
+}
+void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	_outsl_ns((u32 __force *) addr, src, count);
+}
+EXPORT_SYMBOL(iowrite8_rep);
+EXPORT_SYMBOL(iowrite16_rep);
+EXPORT_SYMBOL(iowrite32_rep);
+
+void __iomem *ioport_map(unsigned long port, unsigned int len)
+{
+	if (!_IO_IS_VALID(port))
+		return NULL;
+	return (void __iomem *) (port+pci_io_base);
+}
+
+void ioport_unmap(void __iomem *addr)
+{
+	/* Nothing to do */
+}
+EXPORT_SYMBOL(ioport_map);
+EXPORT_SYMBOL(ioport_unmap);
+
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


