Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVJaBtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJaBtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVJaBtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:49:20 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:61930 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1750812AbVJaBtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:49:19 -0500
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.6.14 include/asm-arm/arch-ixp4xx/io.h: eliminate warning for pointer passed to integral function argument
Date: Sun, 30 Oct 2005 17:49:04 -0800
Message-ID: <000601c5ddbd$46cbdc90$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20051028075721.GF5044@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King
>On Thu, Oct 27, 2005 at 11:19:14PM -0700, John Bowler wrote:
>> Fix for a compiler warning, this wasn't apparent in 2.6.12, I
>> believe the compiler options have been changed (somewhere) so
>> that passing a (void*) to a (u32) argument is now warned.
>
>readb/writeb and friends take a "void __iomem *".  You should
>arrange the __ixp4xx versions to take that.

After some delay I've done that.  One use of these APIs actually
passes a (volatile void*) and this generates a warning with the
change.  In general I changed the 'read' p (pointer) parameter
to be:

const volatile void __iomem *

and the write parameter to be:

volatile void __iomem *

I've appended the full patch, however I will submit this via the
ARM patch system after an appropriate time for commments...

I did have to change 'check_signature' in the header file and I
changed it to (const unsigned char __iomem *) (it increments the
address).  Other instances of this function have a variety of
definitions, but the callers all seem to use a base type of void.

I note that the callers are happy adding offsets to a (void*) (this
never worked when I was young) - advice?  (I.e. can I rely on adding
numbers to a (void*), in which case I should probably change this?)

John Bowler <jbowler@acm.org>

--- linux-2.6.14/include/asm-arm/arch-ixp4xx/io.h	2005-10-29 23:33:21.757679882 -0700
+++ linux-2.6.14/include/asm-arm/arch-ixp4xx/io.h	2005-10-29 23:47:02.581331058 -0700
@@ -80,9 +80,9 @@ __ixp4xx_iounmap(void __iomem *addr)
 #define __arch_ioremap(a, s, f, x)	__ixp4xx_ioremap(a, s, f, x)
 #define	__arch_iounmap(a)		__ixp4xx_iounmap(a)
 
-#define	writeb(p, v)			__ixp4xx_writeb(p, v)
-#define	writew(p, v)			__ixp4xx_writew(p, v)
-#define	writel(p, v)			__ixp4xx_writel(p, v)
+#define	writeb(v, p)			__ixp4xx_writeb(v, p)
+#define	writew(v, p)			__ixp4xx_writew(v, p)
+#define	writel(v, p)			__ixp4xx_writel(v, p)
 
 #define	writesb(p, v, l)		__ixp4xx_writesb(p, v, l)
 #define	writesw(p, v, l)		__ixp4xx_writesw(p, v, l)
@@ -97,8 +97,9 @@ __ixp4xx_iounmap(void __iomem *addr)
 #define	readsl(p, v, l)			__ixp4xx_readsl(p, v, l)
 
 static inline void 
-__ixp4xx_writeb(u8 value, u32 addr)
+__ixp4xx_writeb(u8 value, volatile void __iomem *p)
 {
+	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
 	if (addr >= VMALLOC_START) {
@@ -113,15 +114,16 @@ __ixp4xx_writeb(u8 value, u32 addr)
 }
 
 static inline void
-__ixp4xx_writesb(u32 bus_addr, const u8 *vaddr, int count)
+__ixp4xx_writesb(volatile void __iomem *bus_addr, const u8 *vaddr, int count)
 {
 	while (count--)
 		writeb(*vaddr++, bus_addr);
 }
 
 static inline void 
-__ixp4xx_writew(u16 value, u32 addr)
+__ixp4xx_writew(u16 value, volatile void __iomem *p)
 {
+	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
 	if (addr >= VMALLOC_START) {
@@ -136,15 +138,16 @@ __ixp4xx_writew(u16 value, u32 addr)
 }
 
 static inline void
-__ixp4xx_writesw(u32 bus_addr, const u16 *vaddr, int count)
+__ixp4xx_writesw(volatile void __iomem *bus_addr, const u16 *vaddr, int count)
 {
 	while (count--)
 		writew(*vaddr++, bus_addr);
 }
 
 static inline void 
-__ixp4xx_writel(u32 value, u32 addr)
+__ixp4xx_writel(u32 value, volatile void __iomem *p)
 {
+	u32 addr = (u32)p;
 	if (addr >= VMALLOC_START) {
 		__raw_writel(value, addr);
 		return;
@@ -154,15 +157,16 @@ __ixp4xx_writel(u32 value, u32 addr)
 }
 
 static inline void
-__ixp4xx_writesl(u32 bus_addr, const u32 *vaddr, int count)
+__ixp4xx_writesl(volatile void __iomem *bus_addr, const u32 *vaddr, int count)
 {
 	while (count--)
 		writel(*vaddr++, bus_addr);
 }
 
 static inline unsigned char 
-__ixp4xx_readb(u32 addr)
+__ixp4xx_readb(const volatile void __iomem *p)
 {
+	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
 	if (addr >= VMALLOC_START)
@@ -177,15 +181,16 @@ __ixp4xx_readb(u32 addr)
 }
 
 static inline void
-__ixp4xx_readsb(u32 bus_addr, u8 *vaddr, u32 count)
+__ixp4xx_readsb(const volatile void __iomem *bus_addr, u8 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = readb(bus_addr);
 }
 
 static inline unsigned short 
-__ixp4xx_readw(u32 addr)
+__ixp4xx_readw(const volatile void __iomem *p)
 {
+	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
 	if (addr >= VMALLOC_START)
@@ -200,15 +205,16 @@ __ixp4xx_readw(u32 addr)
 }
 
 static inline void 
-__ixp4xx_readsw(u32 bus_addr, u16 *vaddr, u32 count)
+__ixp4xx_readsw(const volatile void __iomem *bus_addr, u16 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = readw(bus_addr);
 }
 
 static inline unsigned long 
-__ixp4xx_readl(u32 addr)
+__ixp4xx_readl(const volatile void __iomem *p)
 {
+	u32 addr = (u32)p;
 	u32 data;
 
 	if (addr >= VMALLOC_START)
@@ -221,7 +227,7 @@ __ixp4xx_readl(u32 addr)
 }
 
 static inline void 
-__ixp4xx_readsl(u32 bus_addr, u32 *vaddr, u32 count)
+__ixp4xx_readsl(const volatile void __iomem *bus_addr, u32 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = readl(bus_addr);
@@ -239,7 +245,7 @@ __ixp4xx_readsl(u32 bus_addr, u32 *vaddr
 				eth_copy_and_sum((s),__mem_pci(c),(l),(b))
 
 static inline int
-check_signature(unsigned long bus_addr, const unsigned char *signature,
+check_signature(const unsigned char __iomem *bus_addr, const unsigned char *signature,
 		int length)
 {
 	int retval = 0;
@@ -389,7 +395,7 @@ __ixp4xx_insl(u32 io_addr, u32 *vaddr, u
 #define	__is_io_address(p)	(((unsigned long)p >= PIO_OFFSET) && \
 					((unsigned long)p <= (PIO_MASK + PIO_OFFSET)))
 static inline unsigned int
-__ixp4xx_ioread8(void __iomem *addr)
+__ixp4xx_ioread8(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -398,12 +404,12 @@ __ixp4xx_ioread8(void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return (unsigned int)__raw_readb(port);
 #else
-		return (unsigned int)__ixp4xx_readb(port);
+		return (unsigned int)__ixp4xx_readb(addr);
 #endif
 }
 
 static inline void
-__ixp4xx_ioread8_rep(void __iomem *addr, void *vaddr, u32 count)
+__ixp4xx_ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -412,12 +418,12 @@ __ixp4xx_ioread8_rep(void __iomem *addr,
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsb(addr, vaddr, count);
 #else
-		__ixp4xx_readsb(port, vaddr, count);
+		__ixp4xx_readsb(addr, vaddr, count);
 #endif
 }
 
 static inline unsigned int
-__ixp4xx_ioread16(void __iomem *addr)
+__ixp4xx_ioread16(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -426,12 +432,12 @@ __ixp4xx_ioread16(void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return le16_to_cpu(__raw_readw((u32)port));
 #else
-		return (unsigned int)__ixp4xx_readw((u32)port);
+		return (unsigned int)__ixp4xx_readw(addr);
 #endif
 }
 
 static inline void
-__ixp4xx_ioread16_rep(void __iomem *addr, void *vaddr, u32 count)
+__ixp4xx_ioread16_rep(const void __iomem *addr, void *vaddr, u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -440,12 +446,12 @@ __ixp4xx_ioread16_rep(void __iomem *addr
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsw(addr, vaddr, count);
 #else
-		__ixp4xx_readsw(port, vaddr, count);
+		__ixp4xx_readsw(addr, vaddr, count);
 #endif
 }
 
 static inline unsigned int
-__ixp4xx_ioread32(void __iomem *addr)
+__ixp4xx_ioread32(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -454,13 +460,13 @@ __ixp4xx_ioread32(void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return le32_to_cpu(__raw_readl((u32)port));
 #else
-		return (unsigned int)__ixp4xx_readl((u32)port);
+		return (unsigned int)__ixp4xx_readl(addr);
 #endif
 	}
 }
 
 static inline void
-__ixp4xx_ioread32_rep(void __iomem *addr, void *vaddr, u32 count)
+__ixp4xx_ioread32_rep(const void __iomem *addr, void *vaddr, u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -469,7 +475,7 @@ __ixp4xx_ioread32_rep(void __iomem *addr
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsl(addr, vaddr, count);
 #else
-		__ixp4xx_readsl(port, vaddr, count);
+		__ixp4xx_readsl(addr, vaddr, count);
 #endif
 }
 
@@ -483,7 +489,7 @@ __ixp4xx_iowrite8(u8 value, void __iomem
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writeb(value, port);
 #else
-		__ixp4xx_writeb(value, port);
+		__ixp4xx_writeb(value, addr);
 #endif
 }
 
@@ -497,7 +503,7 @@ __ixp4xx_iowrite8_rep(void __iomem *addr
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesb(addr, vaddr, count);
 #else
-		__ixp4xx_writesb(port, vaddr, count);
+		__ixp4xx_writesb(addr, vaddr, count);
 #endif
 }
 
@@ -511,7 +517,7 @@ __ixp4xx_iowrite16(u16 value, void __iom
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writew(cpu_to_le16(value), addr);
 #else
-		__ixp4xx_writew(value, port);
+		__ixp4xx_writew(value, addr);
 #endif
 }
 
@@ -525,7 +531,7 @@ __ixp4xx_iowrite16_rep(void __iomem *add
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesw(addr, vaddr, count);
 #else
-		__ixp4xx_writesw(port, vaddr, count);
+		__ixp4xx_writesw(addr, vaddr, count);
 #endif
 }
 
@@ -539,7 +545,7 @@ __ixp4xx_iowrite32(u32 value, void __iom
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writel(cpu_to_le32(value), port);
 #else
-		__ixp4xx_writel(value, port);
+		__ixp4xx_writel(value, addr);
 #endif
 }
 
@@ -553,7 +559,7 @@ __ixp4xx_iowrite32_rep(void __iomem *add
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesl(addr, vaddr, count);
 #else
-		__ixp4xx_writesl(port, vaddr, count);
+		__ixp4xx_writesl(addr, vaddr, count);
 #endif
 }
 

