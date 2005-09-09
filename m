Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVIIPut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVIIPut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVIIPut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:50:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62867 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964978AbVIIPut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:50:49 -0400
Date: Fri, 9 Sep 2005 16:50:43 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] basic iomem annotations (ppc64)
Message-ID: <20050909155043.GE9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/arch/ppc64/kernel/iomap.c current/arch/ppc64/kernel/iomap.c
--- RC13-git8-base/arch/ppc64/kernel/iomap.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc64/kernel/iomap.c	2005-09-08 23:53:33.000000000 -0400
@@ -56,15 +56,15 @@
  */
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insb((u8 __force *) addr, dst, count);
+	_insb((u8 __iomem *) addr, dst, count);
 }
 void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insw_ns((u16 __force *) addr, dst, count);
+	_insw_ns((u16 __iomem *) addr, dst, count);
 }
 void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insl_ns((u32 __force *) addr, dst, count);
+	_insl_ns((u32 __iomem *) addr, dst, count);
 }
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
@@ -72,15 +72,15 @@
 
 void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsb((u8 __force *) addr, src, count);
+	_outsb((u8 __iomem *) addr, src, count);
 }
 void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsw_ns((u16 __force *) addr, src, count);
+	_outsw_ns((u16 __iomem *) addr, src, count);
 }
 void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsl_ns((u32 __force *) addr, src, count);
+	_outsl_ns((u32 __iomem *) addr, src, count);
 }
 EXPORT_SYMBOL(iowrite8_rep);
 EXPORT_SYMBOL(iowrite16_rep);
diff -urN RC13-git8-base/include/asm-ppc64/eeh.h current/include/asm-ppc64/eeh.h
--- RC13-git8-base/include/asm-ppc64/eeh.h	2005-06-17 15:48:29.000000000 -0400
+++ current/include/asm-ppc64/eeh.h	2005-09-08 23:55:47.000000000 -0400
@@ -219,23 +219,24 @@
 static inline void eeh_memset_io(volatile void __iomem *addr, int c,
 				 unsigned long n)
 {
+	void *p = (void __force *)addr;
 	u32 lc = c;
 	lc |= lc << 8;
 	lc |= lc << 16;
 
-	while(n && !EEH_CHECK_ALIGN(addr, 4)) {
-		*((volatile u8 *)addr) = c;
-		addr = (void *)((unsigned long)addr + 1);
+	while(n && !EEH_CHECK_ALIGN(p, 4)) {
+		*((volatile u8 *)p) = c;
+		p++;
 		n--;
 	}
 	while(n >= 4) {
-		*((volatile u32 *)addr) = lc;
-		addr = (void *)((unsigned long)addr + 4);
+		*((volatile u32 *)p) = lc;
+		p += 4;
 		n -= 4;
 	}
 	while(n) {
-		*((volatile u8 *)addr) = c;
-		addr = (void *)((unsigned long)addr + 1);
+		*((volatile u8 *)p) = c;
+		p++;
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");
@@ -250,22 +251,22 @@
 	while(n && (!EEH_CHECK_ALIGN(vsrc, 4) || !EEH_CHECK_ALIGN(dest, 4))) {
 		*((u8 *)dest) = *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
-		vsrc = (void *)((unsigned long)vsrc + 1);
-		dest = (void *)((unsigned long)dest + 1);			
+		vsrc++;
+		dest++;
 		n--;
 	}
 	while(n > 4) {
 		*((u32 *)dest) = *((volatile u32 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
-		vsrc = (void *)((unsigned long)vsrc + 4);
-		dest = (void *)((unsigned long)dest + 4);			
+		vsrc += 4;
+		dest += 4;
 		n -= 4;
 	}
 	while(n) {
 		*((u8 *)dest) = *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
-		vsrc = (void *)((unsigned long)vsrc + 1);
-		dest = (void *)((unsigned long)dest + 1);			
+		vsrc++;
+		dest++;
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");
@@ -286,20 +287,20 @@
 
 	while(n && (!EEH_CHECK_ALIGN(vdest, 4) || !EEH_CHECK_ALIGN(src, 4))) {
 		*((volatile u8 *)vdest) = *((u8 *)src);
-		src = (void *)((unsigned long)src + 1);
-		vdest = (void *)((unsigned long)vdest + 1);			
+		src++;
+		vdest++;
 		n--;
 	}
 	while(n > 4) {
 		*((volatile u32 *)vdest) = *((volatile u32 *)src);
-		src = (void *)((unsigned long)src + 4);
-		vdest = (void *)((unsigned long)vdest + 4);			
+		src += 4;
+		vdest += 4;
 		n-=4;
 	}
 	while(n) {
 		*((volatile u8 *)vdest) = *((u8 *)src);
-		src = (void *)((unsigned long)src + 1);
-		vdest = (void *)((unsigned long)vdest + 1);			
+		src++;
+		vdest++;
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");
diff -urN RC13-git8-base/include/asm-ppc64/io.h current/include/asm-ppc64/io.h
--- RC13-git8-base/include/asm-ppc64/io.h	2005-06-17 15:48:29.000000000 -0400
+++ current/include/asm-ppc64/io.h	2005-09-08 23:54:20.000000000 -0400
@@ -20,10 +20,10 @@
 
 #include <asm-generic/iomap.h>
 
-#define __ide_mm_insw(p, a, c) _insw_ns((volatile u16 *)(p), (a), (c))
-#define __ide_mm_insl(p, a, c) _insl_ns((volatile u32 *)(p), (a), (c))
-#define __ide_mm_outsw(p, a, c) _outsw_ns((volatile u16 *)(p), (a), (c))
-#define __ide_mm_outsl(p, a, c) _outsl_ns((volatile u32 *)(p), (a), (c))
+#define __ide_mm_insw(p, a, c) _insw_ns((volatile u16 __iomem *)(p), (a), (c))
+#define __ide_mm_insl(p, a, c) _insl_ns((volatile u32 __iomem *)(p), (a), (c))
+#define __ide_mm_outsw(p, a, c) _outsw_ns((volatile u16 __iomem *)(p), (a), (c))
+#define __ide_mm_outsl(p, a, c) _outsl_ns((volatile u32 __iomem *)(p), (a), (c))
 
 
 #define SIO_CONFIG_RA	0x398
@@ -71,8 +71,8 @@
  * Neither do the standard versions now, these are just here
  * for older code.
  */
-#define insw_ns(port, buf, ns)	_insw_ns((u16 *)((port)+pci_io_base), (buf), (ns))
-#define insl_ns(port, buf, nl)	_insl_ns((u32 *)((port)+pci_io_base), (buf), (nl))
+#define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 #else
 
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
@@ -136,9 +136,9 @@
 #define insw_ns(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
 #define insl_ns(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
 
-#define outsb(port, buf, ns)  _outsb((u8 *)((port)+pci_io_base), (buf), (ns))
-#define outsw(port, buf, ns)  _outsw_ns((u16 *)((port)+pci_io_base), (buf), (ns))
-#define outsl(port, buf, nl)  _outsl_ns((u32 *)((port)+pci_io_base), (buf), (nl))
+#define outsb(port, buf, ns)  _outsb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define outsw(port, buf, ns)  _outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define outsl(port, buf, nl)  _outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 
 #endif
 
@@ -147,16 +147,16 @@
 #define readl_relaxed(addr) readl(addr)
 #define readq_relaxed(addr) readq(addr)
 
-extern void _insb(volatile u8 *port, void *buf, int ns);
-extern void _outsb(volatile u8 *port, const void *buf, int ns);
-extern void _insw(volatile u16 *port, void *buf, int ns);
-extern void _outsw(volatile u16 *port, const void *buf, int ns);
-extern void _insl(volatile u32 *port, void *buf, int nl);
-extern void _outsl(volatile u32 *port, const void *buf, int nl);
-extern void _insw_ns(volatile u16 *port, void *buf, int ns);
-extern void _outsw_ns(volatile u16 *port, const void *buf, int ns);
-extern void _insl_ns(volatile u32 *port, void *buf, int nl);
-extern void _outsl_ns(volatile u32 *port, const void *buf, int nl);
+extern void _insb(volatile u8 __iomem *port, void *buf, int ns);
+extern void _outsb(volatile u8 __iomem *port, const void *buf, int ns);
+extern void _insw(volatile u16 __iomem *port, void *buf, int ns);
+extern void _outsw(volatile u16 __iomem *port, const void *buf, int ns);
+extern void _insl(volatile u32 __iomem *port, void *buf, int nl);
+extern void _outsl(volatile u32 __iomem *port, const void *buf, int nl);
+extern void _insw_ns(volatile u16 __iomem *port, void *buf, int ns);
+extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, int ns);
+extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
+extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, int nl);
 
 #define mmiowb()
 
@@ -176,8 +176,8 @@
  * Neither do the standard versions now, these are just here
  * for older code.
  */
-#define outsw_ns(port, buf, ns)	_outsw_ns((u16 *)((port)+pci_io_base), (buf), (ns))
-#define outsl_ns(port, buf, nl)	_outsl_ns((u32 *)((port)+pci_io_base), (buf), (nl))
+#define outsw_ns(port, buf, ns)	_outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define outsl_ns(port, buf, nl)	_outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 
 
 #define IO_SPACE_LIMIT ~(0UL)
