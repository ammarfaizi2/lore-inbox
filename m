Return-Path: <linux-kernel-owner+w=401wt.eu-S932627AbXAJFg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbXAJFg2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbXAJFgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:36:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:4133 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbXAJFfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:35:53 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=YYveSekdaui0jGJ3XX5VAdowxK31ZUQSKdWrSWSrue57ReDj+ZgmQZhjuwa7dmgmnKysivArhviWv++io1jGcBKAljaay/aBJzYi0lAkxwGHUc23EuFu86z6XHYmbDYbhcfQj20lalPV5PNPOwKHmqSNSLZQxit2uZrfsTUhNjE=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/13] devres: implement managed iomap interface
In-Reply-To: <11684073353213-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 10 Jan 2007 14:35:37 +0900
Message-Id: <11684073371547-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement managed iomap interface - devm_ioport_map(),
devm_ioport_unmap(), devm_ioremap(), devm_ioremap_nocache(),
devm_iounmap(), pcim_iomap_table(), pcim_iomap() and pcim_iounmap().
Except for being managed and additional gendev argument, these
functions take the same arguments and have the same effect as
non-managed coutnerparts.

pcim_iomap_table() returns pointer to constant array of void __iomem *
which record addresses for all mapped BARs.  This function is
guaranteed to succeed after successful pcim_iomap() and drivers are
free to reference the returned iomap table.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/io.h |   17 ++++
 lib/Makefile       |    3 +-
 lib/iomap.c        |  246 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 263 insertions(+), 3 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 81877ea..f5edf9c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -28,6 +28,23 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		       unsigned long phys_addr, pgprot_t prot);
 
+/*
+ * Managed iomap interface
+ */
+void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
+			       unsigned int nr);
+void devm_ioport_unmap(struct device *dev, void __iomem *addr);
+
+void __iomem * devm_ioremap(struct device *dev, unsigned long offset,
+			    unsigned long size);
+void __iomem * devm_ioremap_nocache(struct device *dev, unsigned long offset,
+				    unsigned long size);
+void devm_iounmap(struct device *dev, void __iomem *addr);
+
+void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
+void __iomem * const * pcim_iomap_table(struct pci_dev *pdev);
+
 /**
  *	check_signature		-	find BIOS signatures
  *	@io_addr: mmio address to check
diff --git a/lib/Makefile b/lib/Makefile
index 77b4bad..29b2e99 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o reciprocal_div.o
+	 sha1.o irq_regs.o reciprocal_div.o iomap.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
@@ -41,7 +41,6 @@ obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
-obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff --git a/lib/iomap.c b/lib/iomap.c
index d6ccdd8..3214028 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -4,8 +4,10 @@
  * (C) Copyright 2004 Linus Torvalds
  */
 #include <linux/pci.h>
+#include <linux/io.h>
+
+#ifdef CONFIG_GENERIC_IOMAP
 #include <linux/module.h>
-#include <asm/io.h>
 
 /*
  * Read/write from/to an (offsettable) iomem cookie. It might be a PIO
@@ -254,3 +256,245 @@ void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 }
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
+
+#endif /* CONFIG_GENERIC_IOMAP */
+
+/*
+ * Generic iomap devres
+ */
+static void devm_ioport_map_release(struct device *dev, void *res)
+{
+	ioport_unmap(*(void __iomem **)res);
+}
+
+static int devm_ioport_map_match(struct device *dev, void *res,
+				 void *match_data)
+{
+	return *(void **)res == match_data;
+}
+
+/**
+ * devm_ioport_map - Managed ioport_map()
+ * @dev: Generic device to map ioport for
+ * @port: Port to map
+ * @nr: Number of ports to map
+ *
+ * Managed ioport_map().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
+			       unsigned int nr)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioport_map_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioport_map(port, nr);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioport_map);
+
+/**
+ * devm_ioport_unmap - Managed ioport_unmap()
+ * @dev: Generic device to unmap for
+ * @addr: Address to unmap
+ *
+ * Managed ioport_unmap().  @addr must have been mapped using
+ * devm_ioport_map().
+ */
+void devm_ioport_unmap(struct device *dev, void __iomem *addr)
+{
+	ioport_unmap(addr);
+	WARN_ON(devres_destroy(dev, devm_ioport_map_release,
+			       devm_ioport_map_match, (void *)addr));
+}
+EXPORT_SYMBOL(devm_ioport_unmap);
+
+static void devm_ioremap_release(struct device *dev, void *res)
+{
+	iounmap(*(void __iomem **)res);
+}
+
+static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
+{
+	return *(void **)res == match_data;
+}
+
+/**
+ * devm_ioremap - Managed ioremap()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap(struct device *dev, unsigned long offset,
+			   unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap);
+
+/**
+ * devm_ioremap_nocache - Managed ioremap_nocache()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_nocache().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_ioremap_nocache(struct device *dev, unsigned long offset,
+				   unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_nocache(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_nocache);
+
+/**
+ * devm_iounmap - Managed iounmap()
+ * @dev: Generic device to unmap for
+ * @addr: Address to unmap
+ *
+ * Managed iounmap().  @addr must have been mapped using devm_ioremap*().
+ */
+void devm_iounmap(struct device *dev, void __iomem *addr)
+{
+	iounmap(addr);
+	WARN_ON(devres_destroy(dev, devm_ioremap_release, devm_ioremap_match,
+			       (void *)addr));
+}
+EXPORT_SYMBOL(devm_iounmap);
+
+/*
+ * PCI iomap devres
+ */
+#define PCIM_IOMAP_MAX	PCI_ROM_RESOURCE
+
+struct pcim_iomap_devres {
+	void __iomem *table[PCIM_IOMAP_MAX];
+};
+
+static void pcim_iomap_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
+	struct pcim_iomap_devres *this = res;
+	int i;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (this->table[i])
+			pci_iounmap(dev, this->table[i]);
+}
+
+/**
+ * pcim_iomap_table - access iomap allocation table
+ * @pdev: PCI device to access iomap table for
+ *
+ * Access iomap allocation table for @dev.  If iomap table doesn't
+ * exist and @pdev is managed, it will be allocated.  All iomaps
+ * recorded in the iomap table are automatically unmapped on driver
+ * detach.
+ *
+ * This function might sleep when the table is first allocated but can
+ * be safely called without context and guaranteed to succed once
+ * allocated.
+ */
+void __iomem * const * pcim_iomap_table(struct pci_dev *pdev)
+{
+	struct pcim_iomap_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
+	if (dr)
+		return dr->table;
+
+	new_dr = devres_alloc(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
+	return dr->table;
+}
+EXPORT_SYMBOL(pcim_iomap_table);
+
+/**
+ * pcim_iomap - Managed pcim_iomap()
+ * @pdev: PCI device to iomap for
+ * @bar: BAR to iomap
+ * @maxlen: Maximum length of iomap
+ *
+ * Managed pci_iomap().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
+{
+	void __iomem **tbl;
+
+	BUG_ON(bar >= PCIM_IOMAP_MAX);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+		return NULL;
+
+	tbl[bar] = pci_iomap(pdev, bar, maxlen);
+	return tbl[bar];
+}
+EXPORT_SYMBOL(pcim_iomap);
+
+/**
+ * pcim_iounmap - Managed pci_iounmap()
+ * @pdev: PCI device to iounmap for
+ * @addr: Address to unmap
+ *
+ * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
+ */
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
+{
+	void __iomem **tbl;
+	int i;
+
+	pci_iounmap(pdev, addr);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	BUG_ON(!tbl);
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (tbl[i] == addr) {
+			tbl[i] = NULL;
+			return;
+		}
+	WARN_ON(1);
+}
+EXPORT_SYMBOL(pcim_iounmap);
-- 
1.4.4.3


