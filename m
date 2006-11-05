Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965810AbWKEDci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965810AbWKEDci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965811AbWKEDci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:32:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:50410 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965810AbWKEDch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:32:37 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1162689005.28571.118.camel@localhost.localdomain>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 14:32:13 +1100
Message-Id: <1162697533.28571.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the generic lib/iomap.c use arch provided MMIO accessors when
available for big endian and repeat operations. Also while at it,
fix the *_be version which are currently broken for PIO

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

And because a patch is better than a long email...

Index: linux-cell/lib/iomap.c
===================================================================
--- linux-cell.orig/lib/iomap.c	2006-11-05 14:21:29.000000000 +1100
+++ linux-cell/lib/iomap.c	2006-11-05 14:30:32.000000000 +1100
@@ -34,6 +34,71 @@
 #define PIO_RESERVED	0x40000UL
 #endif
 
+#ifndef HAVE_ARCH_FULL_MMIO_SET
+/*
+ * Allow arch to provide _be versions and "repeat" versions. If not, we
+ * define default implementations here
+ */
+#define readw_be(addr)		be16_to_cpu(__raw_readw(addr))
+#define readl_be(addr)		be32_to_cpu(__raw_readl(addr))
+#define writew_be(val, addr)	__raw_writew(cpu_to_be16(val), addr)
+#define writel_be(val, addr)	__raw_writel(cpu_to_be32(val), addr)
+
+/*
+ * These are the "repeat MMIO read/write" functions.
+ * Note the "__raw" accesses, since we don't want to
+ * convert to CPU byte order. We write in "IO byte
+ * order" (we also don't have IO barriers).
+ */
+static inline void readsb(void __iomem *addr, u8 *dst, int count)
+{
+	while (--count >= 0) {
+		u8 data = __raw_readb(addr);
+		*dst = data;
+		dst++;
+	}
+}
+static inline void readsw(void __iomem *addr, u16 *dst, int count)
+{
+	while (--count >= 0) {
+		u16 data = __raw_readw(addr);
+		*dst = data;
+		dst++;
+	}
+}
+static inline void readsl(void __iomem *addr, u32 *dst, int count)
+{
+	while (--count >= 0) {
+		u32 data = __raw_readl(addr);
+		*dst = data;
+		dst++;
+	}
+}
+
+static inline void writesb(void __iomem *addr, const u8 *src, int count)
+{
+	while (--count >= 0) {
+		__raw_writeb(*src, addr);
+		src++;
+	}
+}
+static inline void writesw(void __iomem *addr, const u16 *src, int count)
+{
+	while (--count >= 0) {
+		__raw_writew(*src, addr);
+		src++;
+	}
+}
+static inline void writesl(void __iomem *addr, const u32 *src, int count)
+{
+	while (--count >= 0) {
+		__raw_writel(*src, addr);
+		src++;
+	}
+}
+
+#endif /* !defined(HAVE_ARCH_FULL_MMIO_SET) */
+
 /*
  * Ugly macros are a way of life.
  */
@@ -60,7 +125,7 @@
 }
 unsigned int fastcall ioread16be(void __iomem *addr)
 {
-	IO_COND(addr, return inw(port), return be16_to_cpu(__raw_readw(addr)));
+	IO_COND(addr, return swab16(inw(port)), return readw_be(addr));
 }
 unsigned int fastcall ioread32(void __iomem *addr)
 {
@@ -68,7 +133,7 @@
 }
 unsigned int fastcall ioread32be(void __iomem *addr)
 {
-	IO_COND(addr, return inl(port), return be32_to_cpu(__raw_readl(addr)));
+	IO_COND(addr, return swab32(inl(port)), return readl_be(addr));
 }
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
@@ -86,7 +151,7 @@
 }
 void fastcall iowrite16be(u16 val, void __iomem *addr)
 {
-	IO_COND(addr, outw(val,port), __raw_writew(cpu_to_be16(val), addr));
+	IO_COND(addr, outw(swab16(val),port), writew_be(val, addr));
 }
 void fastcall iowrite32(u32 val, void __iomem *addr)
 {
@@ -94,7 +159,7 @@
 }
 void fastcall iowrite32be(u32 val, void __iomem *addr)
 {
-	IO_COND(addr, outl(val,port), __raw_writel(cpu_to_be32(val), addr));
+	IO_COND(addr, outl(swab32(val),port), writel_be(val, addr));
 }
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
@@ -102,70 +167,18 @@
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
 
-/*
- * These are the "repeat MMIO read/write" functions.
- * Note the "__raw" accesses, since we don't want to
- * convert to CPU byte order. We write in "IO byte
- * order" (we also don't have IO barriers).
- */
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
-{
-	while (--count >= 0) {
-		u8 data = __raw_readb(addr);
-		*dst = data;
-		dst++;
-	}
-}
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
-{
-	while (--count >= 0) {
-		u16 data = __raw_readw(addr);
-		*dst = data;
-		dst++;
-	}
-}
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
-{
-	while (--count >= 0) {
-		u32 data = __raw_readl(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_outsb(void __iomem *addr, const u8 *src, int count)
-{
-	while (--count >= 0) {
-		__raw_writeb(*src, addr);
-		src++;
-	}
-}
-static inline void mmio_outsw(void __iomem *addr, const u16 *src, int count)
-{
-	while (--count >= 0) {
-		__raw_writew(*src, addr);
-		src++;
-	}
-}
-static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
-{
-	while (--count >= 0) {
-		__raw_writel(*src, addr);
-		src++;
-	}
-}
 
 void fastcall ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	IO_COND(addr, insb(port,dst,count), mmio_insb(addr, dst, count));
+	IO_COND(addr, insb(port,dst,count), readsb(addr, dst, count));
 }
 void fastcall ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	IO_COND(addr, insw(port,dst,count), mmio_insw(addr, dst, count));
+	IO_COND(addr, insw(port,dst,count), readsw(addr, dst, count));
 }
 void fastcall ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	IO_COND(addr, insl(port,dst,count), mmio_insl(addr, dst, count));
+	IO_COND(addr, insl(port,dst,count), readsl(addr, dst, count));
 }
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
@@ -173,15 +186,15 @@
 
 void fastcall iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	IO_COND(addr, outsb(port, src, count), mmio_outsb(addr, src, count));
+	IO_COND(addr, outsb(port, src, count), writesb(addr, src, count));
 }
 void fastcall iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	IO_COND(addr, outsw(port, src, count), mmio_outsw(addr, src, count));
+	IO_COND(addr, outsw(port, src, count), writesw(addr, src, count));
 }
 void fastcall iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	IO_COND(addr, outsl(port, src,count), mmio_outsl(addr, src, count));
+	IO_COND(addr, outsl(port, src,count), writesl(addr, src, count));
 }
 EXPORT_SYMBOL(iowrite8_rep);
 EXPORT_SYMBOL(iowrite16_rep);


