Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVDDVSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVDDVSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVDDVRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:17:14 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:32740 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261403AbVDDVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:10:50 -0400
Subject: [PATCH] add Big Endian variants of ioread/iowrite
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:10:34 -0500
Message-Id: <1112649034.5813.100.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the new io infrastructure, all of our operators are expecting the
underlying device to be little endian (because the PCI bus, their main
consumer, is LE).

However, there are a fair few devices and busses in the world that are
actually Big Endian.  There's even evidence that some of these BE bus
and chip types are attached to LE systems.  Thus, there's a need for a
BE equivalent of our io{read,write}{16,32} operations.

The attached patch adds this as io{read,write}{16,32}be.  When it's in,
I'll add the first consume (the 53c700 SCSI chip driver).

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

===== arch/parisc/lib/iomap.c 1.1 vs edited =====
--- 1.1/arch/parisc/lib/iomap.c	2005-01-10 08:00:46 -06:00
+++ edited/arch/parisc/lib/iomap.c	2005-04-04 15:49:09 -05:00
@@ -43,10 +43,14 @@
 struct iomap_ops {
 	unsigned int (*read8)(void __iomem *);
 	unsigned int (*read16)(void __iomem *);
+	unsigned int (*read16be)(void __iomem *);
 	unsigned int (*read32)(void __iomem *);
+	unsigned int (*read32be)(void __iomem *);
 	void (*write8)(u8, void __iomem *);
 	void (*write16)(u16, void __iomem *);
+	void (*write16be)(u16, void __iomem *);
 	void (*write32)(u32, void __iomem *);
+	void (*write32be)(u32, void __iomem *);
 	void (*read8r)(void __iomem *, void *, unsigned long);
 	void (*read16r)(void __iomem *, void *, unsigned long);
 	void (*read32r)(void __iomem *, void *, unsigned long);
@@ -122,9 +126,13 @@
 static const struct iomap_ops ioport_ops = {
 	ioport_read8,
 	ioport_read16,
+	ioport_read16,
+	ioport_read32,
 	ioport_read32,
 	ioport_write8,
 	ioport_write16,
+	ioport_write16,
+	ioport_write32,
 	ioport_write32,
 	ioport_read8r,
 	ioport_read16r,
@@ -146,11 +154,21 @@
 	return readw(addr);
 }
 
+static unsigned int iomem_read16be(void __iomem *addr)
+{
+	return __raw_readw(addr);
+}
+
 static unsigned int iomem_read32(void __iomem *addr)
 {
 	return readl(addr);
 }
 
+static unsigned int iomem_read32be(void __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+
 static void iomem_write8(u8 datum, void __iomem *addr)
 {
 	writeb(datum, addr);
@@ -161,11 +179,21 @@
 	writew(datum, addr);
 }
 
+static void iomem_write16be(u16 datum, void __iomem *addr)
+{
+	__raw_writew(datum, addr);
+}
+
 static void iomem_write32(u32 datum, void __iomem *addr)
 {
 	writel(datum, addr);
 }
 
+static void iomem_write32be(u32 datum, void __iomem *addr)
+{
+	__raw_writel(datum, addr);
+}
+
 static void iomem_read8r(void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
@@ -217,10 +245,14 @@
 static const struct iomap_ops iomem_ops = {
 	iomem_read8,
 	iomem_read16,
+	iomem_read16be,
 	iomem_read32,
+	iomem_read32be,
 	iomem_write8,
 	iomem_write16,
+	iomem_write16be,
 	iomem_write32,
+	iomem_write32be,
 	iomem_read8r,
 	iomem_read16r,
 	iomem_read32r,
@@ -253,6 +285,13 @@
 	return le16_to_cpup((u16 *)addr);
 }
 
+unsigned int ioread16be(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read16be(addr);
+	return *((u16 *)addr);
+}
+
 unsigned int ioread32(void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
@@ -260,6 +299,13 @@
 	return le32_to_cpup((u32 *)addr);
 }
 
+unsigned int ioread32be(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read32be(addr);
+	return *((u32 *)addr);
+}
+
 void iowrite8(u8 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
@@ -278,6 +324,15 @@
 	}
 }
 
+void iowrite16be(u16 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write16be(datum, addr);
+	} else {
+		*((u16 *)addr) = datum;
+	}
+}
+
 void iowrite32(u32 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
@@ -287,6 +342,15 @@
 	}
 }
 
+void iowrite32be(u32 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write32be(datum, addr);
+	} else {
+		*((u32 *)addr) = datum;
+	}
+}
+
 /* Repeating interfaces */
 
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
@@ -406,10 +470,14 @@
 
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
+EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
+EXPORT_SYMBOL(ioread32be);
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
+EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
+EXPORT_SYMBOL(iowrite32be);
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
 EXPORT_SYMBOL(ioread32_rep);
===== include/asm-generic/iomap.h 1.3 vs edited =====
--- 1.3/include/asm-generic/iomap.h	2004-09-14 18:28:47 -05:00
+++ edited/include/asm-generic/iomap.h	2005-04-04 12:06:14 -05:00
@@ -2,6 +2,7 @@
 #define __GENERIC_IO_H
 
 #include <linux/linkage.h>
+#include <asm/byteorder.h>
 
 /*
  * These are the "generic" interfaces for doing new-style
@@ -26,11 +27,15 @@
  */
 extern unsigned int fastcall ioread8(void __iomem *);
 extern unsigned int fastcall ioread16(void __iomem *);
+extern unsigned int fastcall ioread16be(void __iomem *);
 extern unsigned int fastcall ioread32(void __iomem *);
+extern unsigned int fastcall ioread32be(void __iomem *);
 
 extern void fastcall iowrite8(u8, void __iomem *);
 extern void fastcall iowrite16(u16, void __iomem *);
+extern void fastcall iowrite16be(u16, void __iomem *);
 extern void fastcall iowrite32(u32, void __iomem *);
+extern void fastcall iowrite32be(u32, void __iomem *);
 
 /*
  * "string" versions of the above. Note that they
===== lib/iomap.c 1.6 vs edited =====
--- 1.6/lib/iomap.c	2004-10-28 02:39:50 -05:00
+++ edited/lib/iomap.c	2005-04-04 14:04:14 -05:00
@@ -58,13 +58,23 @@
 {
 	IO_COND(addr, return inw(port), return readw(addr));
 }
+unsigned int fastcall ioread16be(void __iomem *addr)
+{
+	IO_COND(addr, return inw(port), return be16_to_cpu(__raw_readw(addr)));
+}
 unsigned int fastcall ioread32(void __iomem *addr)
 {
 	IO_COND(addr, return inl(port), return readl(addr));
 }
+unsigned int fastcall ioread32be(void __iomem *addr)
+{
+	IO_COND(addr, return inl(port), return be32_to_cpu(__raw_readl(addr)));
+}
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
+EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
+EXPORT_SYMBOL(ioread32be);
 
 void fastcall iowrite8(u8 val, void __iomem *addr)
 {
@@ -74,13 +84,23 @@
 {
 	IO_COND(addr, outw(val,port), writew(val, addr));
 }
+void fastcall iowrite16be(u16 val, void __iomem *addr)
+{
+	IO_COND(addr, outw(val,port), __raw_writew(cpu_to_be16(val), addr));
+}
 void fastcall iowrite32(u32 val, void __iomem *addr)
 {
 	IO_COND(addr, outl(val,port), writel(val, addr));
 }
+void fastcall iowrite32be(u32 val, void __iomem *addr)
+{
+	IO_COND(addr, outl(val,port), __raw_writel(cpu_to_be32(val), addr));
+}
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
+EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
+EXPORT_SYMBOL(iowrite32be);
 
 /*
  * These are the "repeat MMIO read/write" functions.


