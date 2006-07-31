Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWGaN5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGaN5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGaN4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:56:36 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:60140 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750825AbWGaN4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:56:13 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 4/6] AVR32: Add I/O port access primitives
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:55:58 +0200
Message-Id: <11543541601135-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11543541602148-git-send-email-hskinnemoen@atmel.com>
References: <1154354160566-git-send-email-hskinnemoen@atmel.com> <11543541601753-git-send-email-hskinnemoen@atmel.com> <11543541602148-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds definitions of inb, outb and friends to include/asm-avr32/io.h

I'm still not sure about the best way to emulate I/O port access on
AVR32, but we should be able to override the __io() macro from
platform-specific headers in the future when we know better what the
requirements really are.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/io.h |   84 ++++++++++++++++++++++++++----------------------
 1 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/include/asm-avr32/io.h b/include/asm-avr32/io.h
index 8633e49..30d7340 100644
--- a/include/asm-avr32/io.h
+++ b/include/asm-avr32/io.h
@@ -5,6 +5,24 @@ #include <linux/string.h>
 
 #ifdef __KERNEL__
 
+#include <asm/addrspace.h>
+
+/* virt_to_phys will only work when address is in P1 or P2 */
+static __inline__ unsigned long virt_to_phys(volatile void *address)
+{
+	return PHYSADDR(address);
+}
+
+static __inline__ void * phys_to_virt(unsigned long address)
+{
+	return (void *)P1SEGADDR(address);
+}
+
+#define cached_to_phys(addr)	((unsigned long)PHYSADDR(addr))
+#define uncached_to_phys(addr)	((unsigned long)PHYSADDR(addr))
+#define phys_to_cached(addr)	((void *)P1SEGADDR(addr))
+#define phys_to_uncached(addr)	((void *)P2SEGADDR(addr))
+
 /*
  * Generic IO read/write.  These perform native-endian accesses.  Note
  * that some architectures will want to re-define __raw_{read,write}w.
@@ -17,17 +35,6 @@ extern void __raw_readsb(unsigned int ad
 extern void __raw_readsw(unsigned int addr, void *data, int wordlen);
 extern void __raw_readsl(unsigned int addr, void *data, int longlen);
 
-#ifdef PCMCIA_HSMC_IO_HACK
-#error Needs updating
-/* The HMATRIX tries to byteswap the address for us, so we have to swap it back. */
-#define __raw_writeb(v,a)	(*(volatile unsigned char *)((unsigned long)(a) ^ 3UL) = (v))
-#define __raw_writew(v,a)	(*(volatile unsigned short *)((unsigned long)(a) ^ 2UL) = (v))
-#define __raw_writel(v,a)	(*(volatile unsigned int   *)(a) = (v))
-
-#define __raw_readb(a)		(*(volatile unsigned char *)((unsigned long)(a) ^ 3UL))
-#define __raw_readw(a)		(*(volatile unsigned short *)((unsigned long)(a) ^ 2UL))
-#define __raw_readl(a)		(*(volatile unsigned int *)(a))
-#else
 static inline void writeb(unsigned char b, volatile void __iomem *addr)
 {
 	*(volatile unsigned char __force *)addr = b;
@@ -59,7 +66,6 @@ static inline unsigned int readl(const v
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
-#endif
 
 #define writesb(p, d, l)	__raw_writesb((unsigned int)p, d, l)
 #define writesw(p, d, l)	__raw_writesw((unsigned int)p, d, l)
@@ -109,18 +115,36 @@ extern void __readwrite_bug(const char *
 
 #define IO_SPACE_LIMIT	0xffffffff
 
+/* Convert I/O port address to virtual address */
+#define __io(p)		((void __iomem *)phys_to_uncached(p))
+
 /*
- * All I/O is memory mapped, so these macros don't make very much
- * sense.  They are needed for PCMCIA support, however, so we'll have
- * to implement them somehow.  For now, they will cause linker errors.
+ *  IO port access primitives
+ *  -------------------------
+ *
+ * The AVR32 doesn't have special IO access instructions; all IO is memory
+ * mapped. Note that these are defined to perform little endian accesses
+ * only. Their primary purpose is to access PCI and ISA peripherals.
+ *
+ * Note that for a big endian machine, this implies that the following
+ * big endian mode connectivity is in place.
+ *
+ * The machine specific io.h include defines __io to translate an "IO"
+ * address to a memory address.
+ *
+ * Note that we prevent GCC re-ordering or caching values in expressions
+ * by introducing sequence points into the in*() definitions.  Note that
+ * __raw_* do not guarantee this behaviour.
+ *
+ * The {in,out}[bwl] macros are for emulating x86-style PCI/ISA IO space.
  */
-extern void outb(unsigned char value, unsigned long port);
-extern void outw(unsigned short value, unsigned long port);
-extern void outl(unsigned long value, unsigned long port);
+#define outb(v, p)		__raw_writeb(v, __io(p))
+#define outw(v, p)		__raw_writew(cpu_to_le16(v), __io(p))
+#define outl(v, p)		__raw_writel(cpu_to_le32(v), __io(p))
 
-extern unsigned char inb(unsigned long port);
-extern unsigned short inw(unsigned long port);
-extern unsigned long inl(unsigned long port);
+#define inb(p)			__raw_readb(__io(p))
+#define inw(p)			le16_to_cpu(__raw_readw(__io(p)))
+#define inl(p)			le32_to_cpu(__raw_readl(__io(p)))
 
 static inline void __outsb(unsigned long port, void *addr, unsigned int count)
 {
@@ -197,24 +221,6 @@ #define ioremap(offset, size)			\
 #define iounmap(addr)				\
 	__iounmap(addr)
 
-#include <asm/addrspace.h>
-
-/* virt_to_phys will only work when address is in P1 or P2 */
-static __inline__ unsigned long virt_to_phys(volatile void *address)
-{
-	return PHYSADDR(address);
-}
-
-static __inline__ void * phys_to_virt(unsigned long address)
-{
-	return (void *)P1SEGADDR(address);
-}
-
-#define cached_to_phys(addr)	((unsigned long)PHYSADDR(addr))
-#define uncached_to_phys(addr)	((unsigned long)PHYSADDR(addr))
-#define phys_to_cached(addr)	((void *)P1SEGADDR(addr))
-#define phys_to_uncached(addr)	((void *)P2SEGADDR(addr))
-
 #define cached(addr) P1SEGADDR(addr)
 #define uncached(addr) P2SEGADDR(addr)
 
-- 
1.4.0

