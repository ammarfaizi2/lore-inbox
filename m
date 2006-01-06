Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752371AbWAFQgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbWAFQgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbWAFQ34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752371AbWAFQ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:47 -0500
Date: Fri, 6 Jan 2006 16:29:36 GMT
Message-Id: <200601061629.k06GTaYt011371@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 6/17] FRV: Supply various missing I/O access primitives
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch supplies various I/O access primitives that are missing for
the FRV arch:

 (*) mmiowb()

 (*) read*_relaxed()

 (*) ioport_*map()

 (*) ioread*(), iowrite*(), ioread*_rep() and iowrite*_rep()

 (*) pci_io*map()

 (*) check_signature()

The patch also makes __is_PCI_addr() more efficient.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-io-2615.diff
 include/asm-frv/io.h      |  123 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-frv/mb-regs.h |    4 +
 2 files changed, 127 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/io.h linux-2.6.15-frv/include/asm-frv/io.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/io.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.15-frv/include/asm-frv/io.h	2006-01-06 14:43:43.000000000 +0000
@@ -18,6 +18,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/types.h>
 #include <asm/virtconvert.h>
 #include <asm/string.h>
 #include <asm/mb-regs.h>
@@ -104,6 +105,8 @@ static inline void __insl(unsigned long 
 		__insl_sw(addr, buf, len);
 }
 
+#define mmiowb() mb()
+
 /*
  *	make the short names macros so specific devices
  *	can override them as required
@@ -209,6 +212,10 @@ static inline uint32_t readl(const volat
 	return ret;
 }
 
+#define readb_relaxed readb
+#define readw_relaxed readw
+#define readl_relaxed readl
+
 static inline void writeb(uint8_t datum, volatile void __iomem *addr)
 {
 	__builtin_write8((volatile uint8_t __force *) addr, datum);
@@ -268,11 +275,106 @@ static inline void __iomem *ioremap_full
 
 extern void iounmap(void __iomem *addr);
 
+static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return (void __iomem *) port;
+}
+
+static inline void ioport_unmap(void __iomem *p)
+{
+}
+
 static inline void flush_write_buffers(void)
 {
 	__asm__ __volatile__ ("membar" : : :"memory");
 }
 
+/*
+ * do appropriate I/O accesses for token type
+ */
+static inline unsigned int ioread8(void __iomem *p)
+{
+	return __builtin_read8(p);
+}
+
+static inline unsigned int ioread16(void __iomem *p)
+{
+	uint16_t ret = __builtin_read16(p);
+	if (__is_PCI_addr(p))
+		ret = _swapw(ret);
+	return ret;
+}
+
+static inline unsigned int ioread32(void __iomem *p)
+{
+	uint32_t ret = __builtin_read32(p);
+	if (__is_PCI_addr(p))
+		ret = _swapl(ret);
+	return ret;
+}
+
+static inline void iowrite8(u8 val, void __iomem *p)
+{
+	__builtin_write8(p, val);
+	if (__is_PCI_MEM(p))
+		__flush_PCI_writes();
+}
+
+static inline void iowrite16(u16 val, void __iomem *p)
+{
+	if (__is_PCI_addr(p))
+		val = _swapw(val);
+	__builtin_write16(p, val);
+	if (__is_PCI_MEM(p))
+		__flush_PCI_writes();
+}
+
+static inline void iowrite32(u32 val, void __iomem *p)
+{
+	if (__is_PCI_addr(p))
+		val = _swapl(val);
+	__builtin_write32(p, val);
+	if (__is_PCI_MEM(p))
+		__flush_PCI_writes();
+}
+
+static inline void ioread8_rep(void __iomem *p, void *dst, unsigned long count)
+{
+	io_insb((unsigned long) p, dst, count);
+}
+
+static inline void ioread16_rep(void __iomem *p, void *dst, unsigned long count)
+{
+	io_insw((unsigned long) p, dst, count);
+}
+
+static inline void ioread32_rep(void __iomem *p, void *dst, unsigned long count)
+{
+	__insl_ns((unsigned long) p, dst, count);
+}
+
+static inline void iowrite8_rep(void __iomem *p, const void *src, unsigned long count)
+{
+	io_outsb((unsigned long) p, src, count);
+}
+
+static inline void iowrite16_rep(void __iomem *p, const void *src, unsigned long count)
+{
+	io_outsw((unsigned long) p, src, count);
+}
+
+static inline void iowrite32_rep(void __iomem *p, const void *src, unsigned long count)
+{
+	__outsl_ns((unsigned long) p, src, count);
+}
+
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+{
+}
+
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
@@ -284,6 +386,27 @@ static inline void flush_write_buffers(v
  * Convert a virtual cached pointer to an uncached pointer
  */
 #define xlate_dev_kmem_ptr(p)	p
+ 
+/*
+ * Check BIOS signature
+ */
+static inline int check_signature(volatile void __iomem *io_addr,
+				  const unsigned char *signature, int length)
+{
+	int retval = 0;
+
+	do {
+		if (readb(io_addr) != *signature)
+			goto out;
+		io_addr++;
+		signature++;
+		length--;
+	} while (length);
+
+	retval = 1;
+out:
+	return retval;
+}
 
 #endif /* __KERNEL__ */
 
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/mb-regs.h linux-2.6.15-frv/include/asm-frv/mb-regs.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/mb-regs.h	2005-03-02 12:08:45.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/mb-regs.h	2006-01-06 14:43:43.000000000 +0000
@@ -68,6 +68,9 @@ do {									\
 #define __is_PCI_MEM(addr) \
 	((unsigned long)(addr) - __region_PCI_MEM < 0x08000000UL)
 
+#define __is_PCI_addr(addr) \
+	((unsigned long)(addr) - __region_PCI_IO < 0x0c000000UL)
+
 #define __get_CLKSW()	({ *(volatile unsigned long *)(__region_CS2 + 0x0130000cUL) & 0xffUL; })
 #define __get_CLKIN()	(__get_CLKSW() * 125U * 100000U / 24U)
 
@@ -149,6 +152,7 @@ do {									\
 
 #define __is_PCI_IO(addr)	0	/* no PCI */
 #define __is_PCI_MEM(addr)	0
+#define __is_PCI_addr(addr)	0
 #define __region_PCI_IO		0
 #define __region_PCI_MEM	0
 #define __flush_PCI_writes()	do { } while(0)
