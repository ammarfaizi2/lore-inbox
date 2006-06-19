Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWFSMZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWFSMZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFSMZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932403AbWFSMZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/15] frv: basic __iomem annotations
Date: Mon, 19 Jun 2006 13:24:48 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122448.10060.13994.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Add annotations to the FRV I/O handling functions for sparse.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/mm/kmap.c        |    6 +++---
 include/asm-frv/io.h      |   38 +++++++++++++++++++-------------------
 include/asm-frv/mb-regs.h |   27 +++++++++++++++++++--------
 3 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/arch/frv/mm/kmap.c b/arch/frv/mm/kmap.c
index c54f18e..40b62c5 100644
--- a/arch/frv/mm/kmap.c
+++ b/arch/frv/mm/kmap.c
@@ -31,15 +31,15 @@ #undef DEBUG
  * Map some physical address range into the kernel address space.
  */
 
-void *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag)
+void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag)
 {
-	return (void *)physaddr;
+	return (void __iomem *)physaddr;
 }
 
 /*
  * Unmap a ioremap()ed region again
  */
-void iounmap(void *addr)
+void iounmap(void volatile __iomem *addr)
 {
 }
 
diff --git a/include/asm-frv/io.h b/include/asm-frv/io.h
index 01247cb..0c18453 100644
--- a/include/asm-frv/io.h
+++ b/include/asm-frv/io.h
@@ -41,13 +41,13 @@ static inline unsigned long _swapl(unsig
 //#define __iormb() asm volatile("membar")
 //#define __iowmb() asm volatile("membar")
 
-#define __raw_readb(addr) __builtin_read8((void *) (addr))
-#define __raw_readw(addr) __builtin_read16((void *) (addr))
-#define __raw_readl(addr) __builtin_read32((void *) (addr))
+#define __raw_readb __builtin_read8
+#define __raw_readw __builtin_read16
+#define __raw_readl __builtin_read32
 
-#define __raw_writeb(datum, addr) __builtin_write8((void *) (addr), datum)
-#define __raw_writew(datum, addr) __builtin_write16((void *) (addr), datum)
-#define __raw_writel(datum, addr) __builtin_write32((void *) (addr), datum)
+#define __raw_writeb(datum, addr) __builtin_write8(addr, datum)
+#define __raw_writew(datum, addr) __builtin_write16(addr, datum)
+#define __raw_writel(datum, addr) __builtin_write32(addr, datum)
 
 static inline void io_outsb(unsigned int addr, const void *buf, int len)
 {
@@ -129,12 +129,12 @@ static inline void memcpy_toio(volatile 
 
 static inline uint8_t inb(unsigned long addr)
 {
-	return __builtin_read8((void *)addr);
+	return __builtin_read8((void __iomem *)addr);
 }
 
 static inline uint16_t inw(unsigned long addr)
 {
-	uint16_t ret = __builtin_read16((void *)addr);
+	uint16_t ret = __builtin_read16((void __iomem *)addr);
 
 	if (__is_PCI_IO(addr))
 		ret = _swapw(ret);
@@ -144,7 +144,7 @@ static inline uint16_t inw(unsigned long
 
 static inline uint32_t inl(unsigned long addr)
 {
-	uint32_t ret = __builtin_read32((void *)addr);
+	uint32_t ret = __builtin_read32((void __iomem *)addr);
 
 	if (__is_PCI_IO(addr))
 		ret = _swapl(ret);
@@ -154,21 +154,21 @@ static inline uint32_t inl(unsigned long
 
 static inline void outb(uint8_t datum, unsigned long addr)
 {
-	__builtin_write8((void *)addr, datum);
+	__builtin_write8((void __iomem *)addr, datum);
 }
 
 static inline void outw(uint16_t datum, unsigned long addr)
 {
 	if (__is_PCI_IO(addr))
 		datum = _swapw(datum);
-	__builtin_write16((void *)addr, datum);
+	__builtin_write16((void __iomem *)addr, datum);
 }
 
 static inline void outl(uint32_t datum, unsigned long addr)
 {
 	if (__is_PCI_IO(addr))
 		datum = _swapl(datum);
-	__builtin_write32((void *)addr, datum);
+	__builtin_write32((void __iomem *)addr, datum);
 }
 
 #define inb_p(addr)	inb(addr)
@@ -190,12 +190,12 @@ #define IO_SPACE_LIMIT	0xffffffff
 
 static inline uint8_t readb(const volatile void __iomem *addr)
 {
-	return __builtin_read8((volatile uint8_t __force *) addr);
+	return __builtin_read8((__force void volatile __iomem *) addr);
 }
 
 static inline uint16_t readw(const volatile void __iomem *addr)
 {
-	uint16_t ret =	__builtin_read16((volatile uint16_t __force *)addr);
+	uint16_t ret =	__builtin_read16((__force void volatile __iomem *)addr);
 
 	if (__is_PCI_MEM(addr))
 		ret = _swapw(ret);
@@ -204,7 +204,7 @@ static inline uint16_t readw(const volat
 
 static inline uint32_t readl(const volatile void __iomem *addr)
 {
-	uint32_t ret =	__builtin_read32((volatile uint32_t __force *)addr);
+	uint32_t ret =	__builtin_read32((__force void volatile __iomem *)addr);
 
 	if (__is_PCI_MEM(addr))
 		ret = _swapl(ret);
@@ -218,7 +218,7 @@ #define readl_relaxed readl
 
 static inline void writeb(uint8_t datum, volatile void __iomem *addr)
 {
-	__builtin_write8((volatile uint8_t __force *) addr, datum);
+	__builtin_write8(addr, datum);
 	if (__is_PCI_MEM(addr))
 		__flush_PCI_writes();
 }
@@ -228,7 +228,7 @@ static inline void writew(uint16_t datum
 	if (__is_PCI_MEM(addr))
 		datum = _swapw(datum);
 
-	__builtin_write16((volatile uint16_t __force *) addr, datum);
+	__builtin_write16(addr, datum);
 	if (__is_PCI_MEM(addr))
 		__flush_PCI_writes();
 }
@@ -238,7 +238,7 @@ static inline void writel(uint32_t datum
 	if (__is_PCI_MEM(addr))
 		datum = _swapl(datum);
 
-	__builtin_write32((volatile uint32_t __force *) addr, datum);
+	__builtin_write32(addr, datum);
 	if (__is_PCI_MEM(addr))
 		__flush_PCI_writes();
 }
@@ -272,7 +272,7 @@ static inline void __iomem *ioremap_full
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
 
-extern void iounmap(void __iomem *addr);
+extern void iounmap(void volatile __iomem *addr);
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
diff --git a/include/asm-frv/mb-regs.h b/include/asm-frv/mb-regs.h
index 93fa732..219e5f9 100644
--- a/include/asm-frv/mb-regs.h
+++ b/include/asm-frv/mb-regs.h
@@ -16,6 +16,17 @@ #include <asm/cpu-irqs.h>
 #include <asm/sections.h>
 #include <asm/mem-layout.h>
 
+#ifndef __ASSEMBLY__
+/* gcc builtins, annotated */
+
+unsigned long __builtin_read8(volatile void __iomem *);
+unsigned long __builtin_read16(volatile void __iomem *);
+unsigned long __builtin_read32(volatile void __iomem *);
+void __builtin_write8(volatile void __iomem *, unsigned char);
+void __builtin_write16(volatile void __iomem *, unsigned short);
+void __builtin_write32(volatile void __iomem *, unsigned long);
+#endif
+
 #define __region_IO	KERNEL_IO_START	/* the region from 0xe0000000 to 0xffffffff has suitable
 					 * protection laid over the top for use in memory-mapped
 					 * I/O
@@ -59,7 +70,7 @@ #define __region_PCI_IO		(__region_CS2 +
 #define __region_PCI_MEM	(__region_CS2 + 0x08000000UL)
 #define __flush_PCI_writes()						\
 do {									\
-	__builtin_write8((volatile void *) __region_PCI_MEM, 0);	\
+	__builtin_write8((volatile void __iomem *) __region_PCI_MEM, 0);	\
 } while(0)
 
 #define __is_PCI_IO(addr) \
@@ -83,15 +94,15 @@ #ifdef CONFIG_MB93090_MB00
 #define __set_LEDS(X)							\
 do {									\
 	if (mb93090_mb00_detected)					\
-		__builtin_write32((void *) __addr_LEDS(), ~(X));	\
+		__builtin_write32((void __iomem *) __addr_LEDS(), ~(X));	\
 } while (0)
 #else
 #define __set_LEDS(X)
 #endif
 
 #define __addr_LCD()		(__region_CS2 + 0x01200008UL)
-#define __get_LCD(B)		__builtin_read32((volatile void *) (B))
-#define __set_LCD(B,X)		__builtin_write32((volatile void *) (B), (X))
+#define __get_LCD(B)		__builtin_read32((volatile void __iomem *) (B))
+#define __set_LCD(B,X)		__builtin_write32((volatile void __iomem *) (B), (X))
 
 #define LCD_D			0x000000ff		/* LCD data bus */
 #define LCD_RW			0x00000100		/* LCD R/W signal */
@@ -161,11 +172,11 @@ #define __get_CLKSW()		0UL
 #define __get_CLKIN()		66000000UL
 
 #define __addr_LEDS()		(__region_CS2 + 0x00000023UL)
-#define __set_LEDS(X)		__builtin_write8((volatile void *) __addr_LEDS(), (X))
+#define __set_LEDS(X)		__builtin_write8((volatile void __iomem *) __addr_LEDS(), (X))
 
 #define __addr_FPGATR()		(__region_CS2 + 0x00000030UL)
-#define __set_FPGATR(X)		__builtin_write32((volatile void *) __addr_FPGATR(), (X))
-#define __get_FPGATR()		__builtin_read32((volatile void *) __addr_FPGATR())
+#define __set_FPGATR(X)		__builtin_write32((volatile void __iomem *) __addr_FPGATR(), (X))
+#define __get_FPGATR()		__builtin_read32((volatile void __iomem *) __addr_FPGATR())
 
 #define MB93093_FPGA_FPGATR_AUDIO_CLK	0x00000003
 
@@ -180,7 +191,7 @@ #define MB93093_FPGA_FPGATR_AUDIO_CLK_02
 #define MB93093_FPGA_SWR_PUSHSWMASK	(0x1F<<26)
 #define MB93093_FPGA_SWR_PUSHSW4	(1<<29)
 
-#define __addr_FPGA_SWR		((volatile void *)(__region_CS2 + 0x28UL))
+#define __addr_FPGA_SWR		((volatile void __iomem *)(__region_CS2 + 0x28UL))
 #define __get_FPGA_PUSHSW1_5()	(__builtin_read32(__addr_FPGA_SWR) & MB93093_FPGA_SWR_PUSHSWMASK)
 
 

