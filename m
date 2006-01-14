Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWANWyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWANWyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWANWyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:54:12 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:14211 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751353AbWANWyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:54:09 -0500
Date: Sun, 15 Jan 2006 00:54:06 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sh: I/O routine cleanups and ioremap() overhaul.
Message-ID: <20060114225406.GG4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a few changes in the way that the I/O routines are
defined on SH, specifically so that things like the iomap API properly
wrap through the machvec for board-specific quirks.

In addition to this, the old p3_ioremap() work is converted to a more
generic __ioremap() that will map through the PMB if it's available, or
fall back on page tables for everything else.

An alpha-like IO_CONCAT is also added so we can start to clean up the
board-specific io.h mess, which will be handled in board update patches..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/io.c         |   41 ++++--
 arch/sh/kernel/io_generic.c |  192 +++++++++++++----------------
 arch/sh/mm/ioremap.c        |   99 ++++++++++++---
 include/asm-sh/io.h         |  287 +++++++++++++++++++++++++-------------------
 include/asm-sh/io_generic.h |   88 ++++++-------
 include/asm-sh/machvec.h    |   66 ++++------
 6 files changed, 438 insertions(+), 335 deletions(-)

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/io.c sh-2.6.15/arch/sh/kernel/io.c
--- linux-2.6.15/arch/sh/kernel/io.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/kernel/io.c	2006-01-04 00:15:27.000000000 +0200
@@ -2,58 +2,73 @@
  * linux/arch/sh/kernel/io.c
  *
  * Copyright (C) 2000  Stuart Menefy
+ * Copyright (C) 2005  Paul Mundt
  *
  * Provide real functions which expand to whatever the header file defined.
  * Also definitions of machine independent IO functions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
-
-#include <asm/io.h>
 #include <linux/module.h>
+#include <asm/machvec.h>
+#include <asm/io.h>
 
 /*
  * Copy data from IO memory space to "real" memory space.
  * This needs to be optimized.
  */
-void  memcpy_fromio(void * to, unsigned long from, unsigned long count)
+void memcpy_fromio(void *to, volatile void __iomem *from, unsigned long count)
 {
 	char *p = to;
         while (count) {
                 count--;
-                *p = readb(from);
+                *p = readb((void __iomem *)from);
                 p++;
                 from++;
         }
 }
- 
+EXPORT_SYMBOL(memcpy_fromio);
+
 /*
  * Copy data from "real" memory space to IO memory space.
  * This needs to be optimized.
  */
-void  memcpy_toio(unsigned long to, const void * from, unsigned long count)
+void memcpy_toio(volatile void __iomem *to, const void *from, unsigned long count)
 {
 	const char *p = from;
         while (count) {
                 count--;
-                writeb(*p, to);
+                writeb(*p, (void __iomem *)to);
                 p++;
                 to++;
         }
 }
- 
+EXPORT_SYMBOL(memcpy_toio);
+
 /*
  * "memset" on IO memory space.
  * This needs to be optimized.
  */
-void  memset_io(unsigned long dst, int c, unsigned long count)
+void memset_io(volatile void __iomem *dst, int c, unsigned long count)
 {
         while (count) {
                 count--;
-                writeb(c, dst);
+                writeb(c, (void __iomem *)dst);
                 dst++;
         }
 }
-
-EXPORT_SYMBOL(memcpy_fromio);
-EXPORT_SYMBOL(memcpy_toio);
 EXPORT_SYMBOL(memset_io);
 
+void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return sh_mv.mv_ioport_map(port, nr);
+}
+EXPORT_SYMBOL(ioport_map);
+
+void ioport_unmap(void __iomem *addr)
+{
+	sh_mv.mv_ioport_unmap(addr);
+}
+EXPORT_SYMBOL(ioport_unmap);
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/io_generic.c sh-2.6.15/arch/sh/kernel/io_generic.c
--- linux-2.6.15/arch/sh/kernel/io_generic.c	2004-08-14 20:27:37.000000000 +0300
+++ sh-2.6.15/arch/sh/kernel/io_generic.c	2006-01-04 00:46:18.000000000 +0200
@@ -3,6 +3,7 @@
  * linux/arch/sh/kernel/io_generic.c
  *
  * Copyright (C) 2000  Niibe Yutaka
+ * Copyright (C) 2005  Paul Mundt
  *
  * Generic I/O routine. These can be used where a machine specific version
  * is not required.
@@ -10,21 +11,20 @@
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
- *
  */
-
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/machvec.h>
-#include <linux/module.h>
 
-#if defined(CONFIG_CPU_SH3)
+#ifdef CONFIG_CPU_SH3
+/* SH3 has a PCMCIA bug that needs a dummy read from area 6 for a
+ * workaround. */
 /* I'm not sure SH7709 has this kind of bug */
-#define SH3_PCMCIA_BUG_WORKAROUND 1
-#define DUMMY_READ_AREA6	  0xba000000
+#define dummy_read()	ctrl_inb(0xba000000)
+#else
+#define dummy_read()
 #endif
 
-#define PORT2ADDR(x) (sh_mv.mv_isa_port2addr(x))
-
 unsigned long generic_io_base;
 
 static inline void delay(void)
@@ -32,40 +32,40 @@
 	ctrl_inw(0xa0000000);
 }
 
-unsigned char generic_inb(unsigned long port)
+u8 generic_inb(unsigned long port)
 {
-	return *(volatile unsigned char*)PORT2ADDR(port);
+	return ctrl_inb((unsigned long __force)ioport_map(port, 1));
 }
 
-unsigned short generic_inw(unsigned long port)
+u16 generic_inw(unsigned long port)
 {
-	return *(volatile unsigned short*)PORT2ADDR(port);
+	return ctrl_inw((unsigned long __force)ioport_map(port, 2));
 }
 
-unsigned int generic_inl(unsigned long port)
+u32 generic_inl(unsigned long port)
 {
-	return *(volatile unsigned long*)PORT2ADDR(port);
+	return ctrl_inl((unsigned long __force)ioport_map(port, 4));
 }
 
-unsigned char generic_inb_p(unsigned long port)
+u8 generic_inb_p(unsigned long port)
 {
-	unsigned long v = *(volatile unsigned char*)PORT2ADDR(port);
+	unsigned long v = generic_inb(port);
 
 	delay();
 	return v;
 }
 
-unsigned short generic_inw_p(unsigned long port)
+u16 generic_inw_p(unsigned long port)
 {
-	unsigned long v = *(volatile unsigned short*)PORT2ADDR(port);
+	unsigned long v = generic_inw(port);
 
 	delay();
 	return v;
 }
 
-unsigned int generic_inl_p(unsigned long port)
+u32 generic_inl_p(unsigned long port)
 {
-	unsigned long v = *(volatile unsigned long*)PORT2ADDR(port);
+	unsigned long v = generic_inl(port);
 
 	delay();
 	return v;
@@ -77,75 +77,70 @@
  * convert the port address to real address once.
  */
 
-void generic_insb(unsigned long port, void *buffer, unsigned long count)
+void generic_insb(unsigned long port, void *dst, unsigned long count)
 {
-	volatile unsigned char *port_addr;
-	unsigned char *buf=buffer;
-
-	port_addr = (volatile unsigned char *)PORT2ADDR(port);
+	volatile u8 *port_addr;
+	u8 *buf = dst;
 
-	while(count--)
-	    *buf++ = *port_addr;
+	port_addr = (volatile u8 *)ioport_map(port, 1);
+	while (count--)
+		*buf++ = *port_addr;
 }
 
-void generic_insw(unsigned long port, void *buffer, unsigned long count)
+void generic_insw(unsigned long port, void *dst, unsigned long count)
 {
-	volatile unsigned short *port_addr;
-	unsigned short *buf=buffer;
+	volatile u16 *port_addr;
+	u16 *buf = dst;
 
-	port_addr = (volatile unsigned short *)PORT2ADDR(port);
+	port_addr = (volatile u16 *)ioport_map(port, 2);
+	while (count--)
+		*buf++ = *port_addr;
 
-	while(count--)
-	    *buf++ = *port_addr;
-#ifdef SH3_PCMCIA_BUG_WORKAROUND
-	ctrl_inb (DUMMY_READ_AREA6);
-#endif
+	dummy_read();
 }
 
-void generic_insl(unsigned long port, void *buffer, unsigned long count)
+void generic_insl(unsigned long port, void *dst, unsigned long count)
 {
-	volatile unsigned long *port_addr;
-	unsigned long *buf=buffer;
+	volatile u32 *port_addr;
+	u32 *buf = dst;
 
-	port_addr = (volatile unsigned long *)PORT2ADDR(port);
+	port_addr = (volatile u32 *)ioport_map(port, 4);
+	while (count--)
+		*buf++ = *port_addr;
 
-	while(count--)
-	    *buf++ = *port_addr;
-#ifdef SH3_PCMCIA_BUG_WORKAROUND
-	ctrl_inb (DUMMY_READ_AREA6);
-#endif
+	dummy_read();
 }
 
-void generic_outb(unsigned char b, unsigned long port)
+void generic_outb(u8 b, unsigned long port)
 {
-	*(volatile unsigned char*)PORT2ADDR(port) = b;
+	ctrl_outb(b, (unsigned long __force)ioport_map(port, 1));
 }
 
-void generic_outw(unsigned short b, unsigned long port)
+void generic_outw(u16 b, unsigned long port)
 {
-	*(volatile unsigned short*)PORT2ADDR(port) = b;
+	ctrl_outw(b, (unsigned long __force)ioport_map(port, 2));
 }
 
-void generic_outl(unsigned int b, unsigned long port)
+void generic_outl(u32 b, unsigned long port)
 {
-        *(volatile unsigned long*)PORT2ADDR(port) = b;
+	ctrl_outl(b, (unsigned long __force)ioport_map(port, 4));
 }
 
-void generic_outb_p(unsigned char b, unsigned long port)
+void generic_outb_p(u8 b, unsigned long port)
 {
-	*(volatile unsigned char*)PORT2ADDR(port) = b;
+	generic_outb(b, port);
 	delay();
 }
 
-void generic_outw_p(unsigned short b, unsigned long port)
+void generic_outw_p(u16 b, unsigned long port)
 {
-	*(volatile unsigned short*)PORT2ADDR(port) = b;
+	generic_outw(b, port);
 	delay();
 }
 
-void generic_outl_p(unsigned int b, unsigned long port)
+void generic_outl_p(u32 b, unsigned long port)
 {
-	*(volatile unsigned long*)PORT2ADDR(port) = b;
+	generic_outl(b, port);
 	delay();
 }
 
@@ -154,90 +149,77 @@
  * address. However as the port address doesn't change we only need to
  * convert the port address to real address once.
  */
-
-void generic_outsb(unsigned long port, const void *buffer, unsigned long count)
+void generic_outsb(unsigned long port, const void *src, unsigned long count)
 {
-	volatile unsigned char *port_addr;
-	const unsigned char *buf=buffer;
+	volatile u8 *port_addr;
+	const u8 *buf = src;
 
-	port_addr = (volatile unsigned char *)PORT2ADDR(port);
+	port_addr = (volatile u8 __force *)ioport_map(port, 1);
 
-	while(count--)
-	    *port_addr = *buf++;
+	while (count--)
+		*port_addr = *buf++;
 }
 
-void generic_outsw(unsigned long port, const void *buffer, unsigned long count)
+void generic_outsw(unsigned long port, const void *src, unsigned long count)
 {
-	volatile unsigned short *port_addr;
-	const unsigned short *buf=buffer;
+	volatile u16 *port_addr;
+	const u16 *buf = src;
 
-	port_addr = (volatile unsigned short *)PORT2ADDR(port);
+	port_addr = (volatile u16 __force *)ioport_map(port, 2);
 
-	while(count--)
-	    *port_addr = *buf++;
+	while (count--)
+		*port_addr = *buf++;
 
-#ifdef SH3_PCMCIA_BUG_WORKAROUND
-	ctrl_inb (DUMMY_READ_AREA6);
-#endif
+	dummy_read();
 }
 
-void generic_outsl(unsigned long port, const void *buffer, unsigned long count)
+void generic_outsl(unsigned long port, const void *src, unsigned long count)
 {
-	volatile unsigned long *port_addr;
-	const unsigned long *buf=buffer;
+	volatile u32 *port_addr;
+	const u32 *buf = src;
 
-	port_addr = (volatile unsigned long *)PORT2ADDR(port);
+	port_addr = (volatile u32 __force *)ioport_map(port, 4);
+	while (count--)
+		*port_addr = *buf++;
 
-	while(count--)
-	    *port_addr = *buf++;
-
-#ifdef SH3_PCMCIA_BUG_WORKAROUND
-	ctrl_inb (DUMMY_READ_AREA6);
-#endif
-}
-
-unsigned char generic_readb(unsigned long addr)
-{
-	return *(volatile unsigned char*)addr;
+	dummy_read();
 }
 
-unsigned short generic_readw(unsigned long addr)
+u8 generic_readb(void __iomem *addr)
 {
-	return *(volatile unsigned short*)addr;
+	return ctrl_inb((unsigned long __force)addr);
 }
 
-unsigned int generic_readl(unsigned long addr)
+u16 generic_readw(void __iomem *addr)
 {
-	return *(volatile unsigned long*)addr;
+	return ctrl_inw((unsigned long __force)addr);
 }
 
-void generic_writeb(unsigned char b, unsigned long addr)
+u32 generic_readl(void __iomem *addr)
 {
-	*(volatile unsigned char*)addr = b;
+	return ctrl_inl((unsigned long __force)addr);
 }
 
-void generic_writew(unsigned short b, unsigned long addr)
+void generic_writeb(u8 b, void __iomem *addr)
 {
-	*(volatile unsigned short*)addr = b;
+	ctrl_outb(b, (unsigned long __force)addr);
 }
 
-void generic_writel(unsigned int b, unsigned long addr)
+void generic_writew(u16 b, void __iomem *addr)
 {
-        *(volatile unsigned long*)addr = b;
+	ctrl_outw(b, (unsigned long __force)addr);
 }
 
-void * generic_ioremap(unsigned long offset, unsigned long size)
+void generic_writel(u32 b, void __iomem *addr)
 {
-	return (void *) P2SEGADDR(offset);
+	ctrl_outl(b, (unsigned long __force)addr);
 }
-EXPORT_SYMBOL(generic_ioremap);
 
-void generic_iounmap(void *addr)
+void __iomem *generic_ioport_map(unsigned long addr, unsigned int size)
 {
+	return (void __iomem *)(addr + generic_io_base);
 }
-EXPORT_SYMBOL(generic_iounmap);
 
-unsigned long generic_isa_port2addr(unsigned long offset)
+void generic_ioport_unmap(void __iomem *addr)
 {
-	return offset + generic_io_base;
 }

diff -urN -X exclude linux-2.6.15/arch/sh/mm/ioremap.c sh-2.6.15/arch/sh/mm/ioremap.c
--- linux-2.6.15/arch/sh/mm/ioremap.c	2006-01-04 14:19:57.000000000 +0200
+++ sh-2.6.15/arch/sh/mm/ioremap.c	2006-01-11 03:12:36.000000000 +0200
@@ -6,13 +6,19 @@
  * 640k-1MB IO memory area on PC's
  *
  * (C) Copyright 1995 1996 Linus Torvalds
+ * (C) Copyright 2005, 2006 Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
  */
-
 #include <linux/vmalloc.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
+#include <asm/addrspace.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
@@ -80,9 +86,15 @@
 	if (address >= end)
 		BUG();
 	do {
+		pud_t *pud;
 		pmd_t *pmd;
-		pmd = pmd_alloc(&init_mm, dir, address);
+
 		error = -ENOMEM;
+
+		pud = pud_alloc(&init_mm, dir, address);
+		if (!pud)
+			break;
+		pmd = pmd_alloc(&init_mm, pud, address);
 		if (!pmd)
 			break;
 		if (remap_area_pmd(pmd, address, end - address,
@@ -97,10 +109,6 @@
 }
 
 /*
- * Generic mapping function (not visible outside):
- */
-
-/*
  * Remap an arbitrary physical address space into the kernel virtual
  * address space. Needed when the kernel wants to access high addresses
  * directly.
@@ -109,11 +117,11 @@
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-void * p3_ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
+			unsigned long flags)
 {
-	void * addr;
 	struct vm_struct * area;
-	unsigned long offset, last_addr;
+	unsigned long offset, last_addr, addr, orig_addr;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -124,7 +132,7 @@
 	 * Don't remap the low PCI/ISA area, it's always mapped..
 	 */
 	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
-		return phys_to_virt(phys_addr);
+		return (void __iomem *)phys_to_virt(phys_addr);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
@@ -146,16 +154,71 @@
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
-	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
-		vunmap(addr);
-		return NULL;
+	orig_addr = addr = (unsigned long)area->addr;
+
+#ifdef CONFIG_32BIT
+	/*
+	 * First try to remap through the PMB once a valid VMA has been
+	 * established. Smaller allocations (or the rest of the size
+	 * remaining after a PMB mapping due to the size not being
+	 * perfectly aligned on a PMB size boundary) are then mapped
+	 * through the UTLB using conventional page tables.
+	 *
+	 * PMB entries are all pre-faulted.
+	 */
+	if (unlikely(size >= 0x1000000)) {
+		unsigned long mapped = pmb_remap(addr, phys_addr, size, flags);
+
+		if (likely(mapped)) {
+			addr		+= mapped;
+			phys_addr	+= mapped;
+			size		-= mapped;
+		}
 	}
-	return (void *) (offset + (char *)addr);
+#endif
+
+	if (likely(size))
+		if (remap_area_pages(addr, phys_addr, size, flags)) {
+			vunmap((void *)orig_addr);
+			return NULL;
+		}
+
+	return (void __iomem *)(offset + (char *)orig_addr);
 }
+EXPORT_SYMBOL(__ioremap);
 
-void p3_iounmap(void *addr)
+void __iounmap(void __iomem *addr)
 {
-	if (addr > high_memory)
-		vfree((void *)(PAGE_MASK & (unsigned long)addr));
+	unsigned long vaddr = (unsigned long __force)addr;
+	struct vm_struct *p;
+
+	if (PXSEG(vaddr) < P3SEG)
+		return;
+
+#ifdef CONFIG_32BIT
+	/*
+	 * Purge any PMB entries that may have been established for this
+	 * mapping, then proceed with conventional VMA teardown.
+	 *
+	 * XXX: Note that due to the way that remove_vm_area() does
+	 * matching of the resultant VMA, we aren't able to fast-forward
+	 * the address past the PMB space until the end of the VMA where
+	 * the page tables reside. As such, unmap_vm_area() will be
+	 * forced to linearly scan over the area until it finds the page
+	 * tables where PTEs that need to be unmapped actually reside,
+	 * which is far from optimal. Perhaps we need to use a separate
+	 * VMA for the PMB mappings?
+	 *					-- PFM.
+	 */
+	pmb_unmap(vaddr);
+#endif
+
+	p = remove_vm_area((void *)(vaddr & PAGE_MASK));
+	if (!p) {
+		printk(KERN_ERR "%s: bad address %p\n", __FUNCTION__, addr);
+		return;
+	}
+
+	kfree(p);
 }
+EXPORT_SYMBOL(__iounmap);

diff -urN -X exclude linux-2.6.15/include/asm-sh/io.h sh-2.6.15/include/asm-sh/io.h
--- linux-2.6.15/include/asm-sh/io.h	2005-06-20 22:46:02.000000000 +0300
+++ sh-2.6.15/include/asm-sh/io.h	2006-01-11 03:14:10.000000000 +0200
@@ -11,7 +11,7 @@
  * For read{b,w,l} and write{b,w,l} there are also __raw versions, which
  * do not have a memory barrier after them.
  *
- * In addition, we have 
+ * In addition, we have
  *   ctrl_in{b,w,l}/ctrl_out{b,w,l} for SuperH specific I/O.
  *   which are processor specific.
  */
@@ -23,19 +23,27 @@
  *  inb   by default expands to _inb, but the machine specific code may
  *        define it to __inb if it chooses.
  */
-
+#include <linux/config.h>
 #include <asm/cache.h>
 #include <asm/system.h>
 #include <asm/addrspace.h>
 #include <asm/machvec.h>
-#include <linux/config.h>
+#include <asm/pgtable.h>
+#include <asm-generic/iomap.h>
+
+#ifdef __KERNEL__
 
 /*
  * Depending on which platform we are running on, we need different
  * I/O functions.
  */
+#define __IO_PREFIX	generic
+#include <asm/io_generic.h>
+
+#define maybebadio(port) \
+  printk(KERN_ERR "bad PC-like io %s:%u for port 0x%lx at 0x%08x\n", \
+	 __FUNCTION__, __LINE__, (port), (u32)__builtin_return_address(0))
 
-#ifdef __KERNEL__
 /*
  * Since boards are able to define their own set of I/O routines through
  * their respective machine vector, we always wrap through the mv.
@@ -44,113 +52,120 @@
  * a given routine, it will be wrapped to generic code at run-time.
  */
 
-# define __inb(p)	sh_mv.mv_inb((p))
-# define __inw(p)	sh_mv.mv_inw((p))
-# define __inl(p)	sh_mv.mv_inl((p))
-# define __outb(x,p)	sh_mv.mv_outb((x),(p))
-# define __outw(x,p)	sh_mv.mv_outw((x),(p))
-# define __outl(x,p)	sh_mv.mv_outl((x),(p))
-
-# define __inb_p(p)	sh_mv.mv_inb_p((p))
-# define __inw_p(p)	sh_mv.mv_inw_p((p))
-# define __inl_p(p)	sh_mv.mv_inl_p((p))
-# define __outb_p(x,p)	sh_mv.mv_outb_p((x),(p))
-# define __outw_p(x,p)	sh_mv.mv_outw_p((x),(p))
-# define __outl_p(x,p)	sh_mv.mv_outl_p((x),(p))
-
-# define __insb(p,b,c)	sh_mv.mv_insb((p), (b), (c))
-# define __insw(p,b,c)	sh_mv.mv_insw((p), (b), (c))
-# define __insl(p,b,c)	sh_mv.mv_insl((p), (b), (c))
-# define __outsb(p,b,c)	sh_mv.mv_outsb((p), (b), (c))
-# define __outsw(p,b,c)	sh_mv.mv_outsw((p), (b), (c))
-# define __outsl(p,b,c)	sh_mv.mv_outsl((p), (b), (c))
-
-# define __readb(a)	sh_mv.mv_readb((a))
-# define __readw(a)	sh_mv.mv_readw((a))
-# define __readl(a)	sh_mv.mv_readl((a))
-# define __writeb(v,a)	sh_mv.mv_writeb((v),(a))
-# define __writew(v,a)	sh_mv.mv_writew((v),(a))
-# define __writel(v,a)	sh_mv.mv_writel((v),(a))
-
-# define __ioremap(a,s)	sh_mv.mv_ioremap((a), (s))
-# define __iounmap(a)	sh_mv.mv_iounmap((a))
-
-# define __isa_port2addr(a)	sh_mv.mv_isa_port2addr(a)
-
-# define inb		__inb
-# define inw		__inw
-# define inl		__inl
-# define outb		__outb
-# define outw		__outw
-# define outl		__outl
-
-# define inb_p		__inb_p
-# define inw_p		__inw_p
-# define inl_p		__inl_p
-# define outb_p		__outb_p
-# define outw_p		__outw_p
-# define outl_p		__outl_p
-
-# define insb		__insb
-# define insw		__insw
-# define insl		__insl
-# define outsb		__outsb
-# define outsw		__outsw
-# define outsl		__outsl
-
-# define __raw_readb	__readb
-# define __raw_readw	__readw
-# define __raw_readl	__readl
-# define __raw_writeb	__writeb
-# define __raw_writew	__writew
-# define __raw_writel	__writel
+#define __inb(p)	sh_mv.mv_inb((p))
+#define __inw(p)	sh_mv.mv_inw((p))
+#define __inl(p)	sh_mv.mv_inl((p))
+#define __outb(x,p)	sh_mv.mv_outb((x),(p))
+#define __outw(x,p)	sh_mv.mv_outw((x),(p))
+#define __outl(x,p)	sh_mv.mv_outl((x),(p))
+
+#define __inb_p(p)	sh_mv.mv_inb_p((p))
+#define __inw_p(p)	sh_mv.mv_inw_p((p))
+#define __inl_p(p)	sh_mv.mv_inl_p((p))
+#define __outb_p(x,p)	sh_mv.mv_outb_p((x),(p))
+#define __outw_p(x,p)	sh_mv.mv_outw_p((x),(p))
+#define __outl_p(x,p)	sh_mv.mv_outl_p((x),(p))
+
+#define __insb(p,b,c)	sh_mv.mv_insb((p), (b), (c))
+#define __insw(p,b,c)	sh_mv.mv_insw((p), (b), (c))
+#define __insl(p,b,c)	sh_mv.mv_insl((p), (b), (c))
+#define __outsb(p,b,c)	sh_mv.mv_outsb((p), (b), (c))
+#define __outsw(p,b,c)	sh_mv.mv_outsw((p), (b), (c))
+#define __outsl(p,b,c)	sh_mv.mv_outsl((p), (b), (c))
+
+#define __readb(a)	sh_mv.mv_readb((a))
+#define __readw(a)	sh_mv.mv_readw((a))
+#define __readl(a)	sh_mv.mv_readl((a))
+#define __writeb(v,a)	sh_mv.mv_writeb((v),(a))
+#define __writew(v,a)	sh_mv.mv_writew((v),(a))
+#define __writel(v,a)	sh_mv.mv_writel((v),(a))
+
+#define inb		__inb
+#define inw		__inw
+#define inl		__inl
+#define outb		__outb
+#define outw		__outw
+#define outl		__outl
+
+#define inb_p		__inb_p
+#define inw_p		__inw_p
+#define inl_p		__inl_p
+#define outb_p		__outb_p
+#define outw_p		__outw_p
+#define outl_p		__outl_p
+
+#define insb		__insb
+#define insw		__insw
+#define insl		__insl
+#define outsb		__outsb
+#define outsw		__outsw
+#define outsl		__outsl
+
+#define __raw_readb(a)		__readb((void __iomem *)(a))
+#define __raw_readw(a)		__readw((void __iomem *)(a))
+#define __raw_readl(a)		__readl((void __iomem *)(a))
+#define __raw_writeb(v, a)	__writeb(v, (void __iomem *)(a))
+#define __raw_writew(v, a)	__writew(v, (void __iomem *)(a))
+#define __raw_writel(v, a)	__writel(v, (void __iomem *)(a))
 
 /*
  * The platform header files may define some of these macros to use
  * the inlined versions where appropriate.  These macros may also be
  * redefined by userlevel programs.
  */
-#ifdef __raw_readb
-# define readb(a)	({ unsigned long r_ = __raw_readb((unsigned long)a); mb(); r_; })
+#ifdef __readb
+# define readb(a)	({ unsigned long r_ = __raw_readb(a); mb(); r_; })
 #endif
 #ifdef __raw_readw
-# define readw(a)	({ unsigned long r_ = __raw_readw((unsigned long)a); mb(); r_; })
+# define readw(a)	({ unsigned long r_ = __raw_readw(a); mb(); r_; })
 #endif
 #ifdef __raw_readl
-# define readl(a)	({ unsigned long r_ = __raw_readl((unsigned long)a); mb(); r_; })
+# define readl(a)	({ unsigned long r_ = __raw_readl(a); mb(); r_; })
 #endif
 
 #ifdef __raw_writeb
-# define writeb(v,a)	({ __raw_writeb((v),(unsigned long)(a)); mb(); })
+# define writeb(v,a)	({ __raw_writeb((v),(a)); mb(); })
 #endif
 #ifdef __raw_writew
-# define writew(v,a)	({ __raw_writew((v),(unsigned long)(a)); mb(); })
+# define writew(v,a)	({ __raw_writew((v),(a)); mb(); })
 #endif
 #ifdef __raw_writel
-# define writel(v,a)	({ __raw_writel((v),(unsigned long)(a)); mb(); })
+# define writel(v,a)	({ __raw_writel((v),(a)); mb(); })
 #endif
 
 #define readb_relaxed(a) readb(a)
 #define readw_relaxed(a) readw(a)
 #define readl_relaxed(a) readl(a)
 
-#define mmiowb()
+/* Simple MMIO */
+#define ioread8(a)		readb(a)
+#define ioread16(a)		readw(a)
+#define ioread16be(a)		be16_to_cpu(__raw_readw((a)))
+#define ioread32(a)		readl(a)
+#define ioread32be(a)		be32_to_cpu(__raw_readl((a)))
+
+#define iowrite8(v,a)		writeb((v),(a))
+#define iowrite16(v,a)		writew((v),(a))
+#define iowrite16be(v,a)	__raw_writew(cpu_to_be16((v)),(a))
+#define iowrite32(v,a)		writel((v),(a))
+#define iowrite32be(v,a)	__raw_writel(cpu_to_be32((v)),(a))
+
+#define ioread8_rep(a,d,c)	insb((a),(d),(c))
+#define ioread16_rep(a,d,c)	insw((a),(d),(c))
+#define ioread32_rep(a,d,c)	insl((a),(d),(c))
+
+#define iowrite8_rep(a,s,c)	outsb((a),(s),(c))
+#define iowrite16_rep(a,s,c)	outsw((a),(s),(c))
+#define iowrite32_rep(a,s,c)	outsl((a),(s),(c))
 
-/*
- * If the platform has PC-like I/O, this function converts the offset into
- * an address.
- */
-static __inline__ unsigned long isa_port2addr(unsigned long offset)
-{
-	return __isa_port2addr(offset);
-}
+#define mmiowb()	wmb()	/* synco on SH-4A, otherwise a nop */
 
 /*
  * This function provides a method for the generic case where a board-specific
- * isa_port2addr simply needs to return the port + some arbitrary port base.
+ * ioport_map simply needs to return the port + some arbitrary port base.
  *
  * We use this at board setup time to implicitly set the port base, and
- * as a result, we can use the generic isa_port2addr.
+ * as a result, we can use the generic ioport_map.
  */
 static inline void __set_io_port_base(unsigned long pbase)
 {
@@ -159,51 +174,52 @@
 	generic_io_base = pbase;
 }
 
-#define isa_readb(a) readb(isa_port2addr(a))
-#define isa_readw(a) readw(isa_port2addr(a))
-#define isa_readl(a) readl(isa_port2addr(a))
-#define isa_writeb(b,a) writeb(b,isa_port2addr(a))
-#define isa_writew(w,a) writew(w,isa_port2addr(a))
-#define isa_writel(l,a) writel(l,isa_port2addr(a))
+#define isa_readb(a) readb(ioport_map(a, 1))
+#define isa_readw(a) readw(ioport_map(a, 2))
+#define isa_readl(a) readl(ioport_map(a, 4))
+#define isa_writeb(b,a) writeb(b,ioport_map(a, 1))
+#define isa_writew(w,a) writew(w,ioport_map(a, 2))
+#define isa_writel(l,a) writel(l,ioport_map(a, 4))
+
 #define isa_memset_io(a,b,c) \
-  memset((void *)(isa_port2addr((unsigned long)a)),(b),(c))
+  memset((void *)(ioport_map((unsigned long)(a), 1)),(b),(c))
 #define isa_memcpy_fromio(a,b,c) \
-  memcpy((a),(void *)(isa_port2addr((unsigned long)(b))),(c))
+  memcpy((a),(void *)(ioport_map((unsigned long)(b), 1)),(c))
 #define isa_memcpy_toio(a,b,c) \
-  memcpy((void *)(isa_port2addr((unsigned long)(a))),(b),(c))
+  memcpy((void *)(ioport_map((unsigned long)(a), 1)),(b),(c))
 
 /* We really want to try and get these to memcpy etc */
-extern void memcpy_fromio(void *, unsigned long, unsigned long);
-extern void memcpy_toio(unsigned long, const void *, unsigned long);
-extern void memset_io(unsigned long, int, unsigned long);
+extern void memcpy_fromio(void *, volatile void __iomem *, unsigned long);
+extern void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
+extern void memset_io(volatile void __iomem *, int, unsigned long);
 
 /* SuperH on-chip I/O functions */
-static __inline__ unsigned char ctrl_inb(unsigned long addr)
+static inline unsigned char ctrl_inb(unsigned long addr)
 {
 	return *(volatile unsigned char*)addr;
 }
 
-static __inline__ unsigned short ctrl_inw(unsigned long addr)
+static inline unsigned short ctrl_inw(unsigned long addr)
 {
 	return *(volatile unsigned short*)addr;
 }
 
-static __inline__ unsigned int ctrl_inl(unsigned long addr)
+static inline unsigned int ctrl_inl(unsigned long addr)
 {
 	return *(volatile unsigned long*)addr;
 }
 
-static __inline__ void ctrl_outb(unsigned char b, unsigned long addr)
+static inline void ctrl_outb(unsigned char b, unsigned long addr)
 {
 	*(volatile unsigned char*)addr = b;
 }
 
-static __inline__ void ctrl_outw(unsigned short b, unsigned long addr)
+static inline void ctrl_outw(unsigned short b, unsigned long addr)
 {
 	*(volatile unsigned short*)addr = b;
 }
 
-static __inline__ void ctrl_outl(unsigned int b, unsigned long addr)
+static inline void ctrl_outl(unsigned int b, unsigned long addr)
 {
         *(volatile unsigned long*)addr = b;
 }
@@ -214,12 +230,12 @@
  * Change virtual addresses to physical addresses and vv.
  * These are trivial on the 1:1 Linux/SuperH mapping
  */
-static __inline__ unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void *address)
 {
 	return PHYSADDR(address);
 }
 
-static __inline__ void * phys_to_virt(unsigned long address)
+static inline void *phys_to_virt(unsigned long address)
 {
 	return (void *)P1SEGADDR(address);
 }
@@ -234,27 +250,60 @@
  * differently. On the x86 architecture, we just read/write the
  * memory location directly.
  *
- * On SH, we have the whole physical address space mapped at all times
- * (as MIPS does), so "ioremap()" and "iounmap()" do not need to do
- * anything.  (This isn't true for all machines but we still handle
- * these cases with wired TLB entries anyway ...)
+ * On SH, we traditionally have the whole physical address space mapped
+ * at all times (as MIPS does), so "ioremap()" and "iounmap()" do not
+ * need to do anything but place the address in the proper segment. This
+ * is true for P1 and P2 addresses, as well as some P3 ones. However,
+ * most of the P3 addresses and newer cores using extended addressing
+ * need to map through page tables, so the ioremap() implementation
+ * becomes a bit more complicated. See arch/sh/mm/ioremap.c for
+ * additional notes on this.
  *
  * We cheat a bit and always return uncachable areas until we've fixed
- * the drivers to handle caching properly.  
+ * the drivers to handle caching properly.
  */
-static __inline__ void * ioremap(unsigned long offset, unsigned long size)
-{
-	return __ioremap(offset, size);
-}
-
-static __inline__ void iounmap(void *addr)
-{
-	return __iounmap(addr);
-}
-
-#define ioremap_nocache(off,size) ioremap(off,size)
+#ifdef CONFIG_MMU
+void __iomem *__ioremap(unsigned long offset, unsigned long size,
+			unsigned long flags);
+void __iounmap(void __iomem *addr);
+#else
+#define __ioremap(offset, size, flags)	((void __iomem *)(offset))
+#define __iounmap(addr)			do { } while (0)
+#endif /* CONFIG_MMU */
+
+static inline void __iomem *
+__ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
+{
+	unsigned long last_addr = offset + size - 1;
+
+	/*
+	 * For P1 and P2 space this is trivial, as everything is already
+	 * mapped. Uncached access for P1 addresses are done through P2.
+	 * In the P3 case or for addresses outside of the 29-bit space,
+	 * mapping must be done by the PMB or by using page tables.
+	 */
+	if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {
+		if (unlikely(flags & _PAGE_CACHABLE))
+			return (void __iomem *)P1SEGADDR(offset);
+
+		return (void __iomem *)P2SEGADDR(offset);
+	}
+
+	return __ioremap(offset, size, flags);
+}
+
+#define ioremap(offset, size)				\
+	__ioremap_mode((offset), (size), 0)
+#define ioremap_nocache(offset, size)			\
+	__ioremap_mode((offset), (size), 0)
+#define ioremap_cache(offset, size)			\
+	__ioremap_mode((offset), (size), _PAGE_CACHABLE)
+#define p3_ioremap(offset, size, flags)			\
+	__ioremap((offset), (size), (flags))
+#define iounmap(addr)					\
+	__iounmap((addr))
 
-static __inline__ int check_signature(unsigned long io_addr,
+static inline int check_signature(char __iomem *io_addr,
 			const unsigned char *signature, int length)
 {
 	int retval = 0;
diff -urN -X exclude linux-2.6.15/include/asm-sh/io_generic.h sh-2.6.15/include/asm-sh/io_generic.h
--- linux-2.6.15/include/asm-sh/io_generic.h	2004-07-15 22:22:27.000000000 +0300
+++ sh-2.6.15/include/asm-sh/io_generic.h	2006-01-04 00:15:30.000000000 +0200
@@ -1,51 +1,49 @@
 /*
- * include/asm-sh/io_generic.h
- *
- * Copyright 2000 Stuart Menefy (stuart.menefy@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * Generic IO functions
+ * Trivial I/O routine definitions, intentionally meant to be included
+ * multiple times. Ugly I/O routine concatenation helpers taken from
+ * alpha. Must be included _before_ io.h to avoid preprocessor-induced
+ * routine mismatch.
  */
+#define IO_CONCAT(a,b)	_IO_CONCAT(a,b)
+#define _IO_CONCAT(a,b)	a ## _ ## b
 
-#ifndef _ASM_SH_IO_GENERIC_H
-#define _ASM_SH_IO_GENERIC_H
+#ifndef __IO_PREFIX
+#error "Don't include this header without a valid system prefix"
+#endif
+
+u8 IO_CONCAT(__IO_PREFIX,inb)(unsigned long);
+u16 IO_CONCAT(__IO_PREFIX,inw)(unsigned long);
+u32 IO_CONCAT(__IO_PREFIX,inl)(unsigned long);
+
+void IO_CONCAT(__IO_PREFIX,outb)(u8, unsigned long);
+void IO_CONCAT(__IO_PREFIX,outw)(u16, unsigned long);
+void IO_CONCAT(__IO_PREFIX,outl)(u32, unsigned long);
+
+u8 IO_CONCAT(__IO_PREFIX,inb_p)(unsigned long);
+u16 IO_CONCAT(__IO_PREFIX,inw_p)(unsigned long);
+u32 IO_CONCAT(__IO_PREFIX,inl_p)(unsigned long);
+void IO_CONCAT(__IO_PREFIX,outb_p)(u8, unsigned long);
+void IO_CONCAT(__IO_PREFIX,outw_p)(u16, unsigned long);
+void IO_CONCAT(__IO_PREFIX,outl_p)(u32, unsigned long);
+
+void IO_CONCAT(__IO_PREFIX,insb)(unsigned long, void *dst, unsigned long count);
+void IO_CONCAT(__IO_PREFIX,insw)(unsigned long, void *dst, unsigned long count);
+void IO_CONCAT(__IO_PREFIX,insl)(unsigned long, void *dst, unsigned long count);
+void IO_CONCAT(__IO_PREFIX,outsb)(unsigned long, const void *src, unsigned long count);
+void IO_CONCAT(__IO_PREFIX,outsw)(unsigned long, const void *src, unsigned long count);
+void IO_CONCAT(__IO_PREFIX,outsl)(unsigned long, const void *src, unsigned long count);
+
+u8 IO_CONCAT(__IO_PREFIX,readb)(void __iomem *);
+u16 IO_CONCAT(__IO_PREFIX,readw)(void __iomem *);
+u32 IO_CONCAT(__IO_PREFIX,readl)(void __iomem *);
+void IO_CONCAT(__IO_PREFIX,writeb)(u8, void __iomem *);
+void IO_CONCAT(__IO_PREFIX,writew)(u16, void __iomem *);
+void IO_CONCAT(__IO_PREFIX,writel)(u32, void __iomem *);
 
-extern unsigned long generic_io_base;
+void *IO_CONCAT(__IO_PREFIX,ioremap)(unsigned long offset, unsigned long size);
+void IO_CONCAT(__IO_PREFIX,iounmap)(void *addr);
 
-extern unsigned char generic_inb(unsigned long port);
-extern unsigned short generic_inw(unsigned long port);
-extern unsigned int generic_inl(unsigned long port);
-
-extern void generic_outb(unsigned char value, unsigned long port);
-extern void generic_outw(unsigned short value, unsigned long port);
-extern void generic_outl(unsigned int value, unsigned long port);
-
-extern unsigned char generic_inb_p(unsigned long port);
-extern unsigned short generic_inw_p(unsigned long port);
-extern unsigned int generic_inl_p(unsigned long port);
-extern void generic_outb_p(unsigned char value, unsigned long port);
-extern void generic_outw_p(unsigned short value, unsigned long port);
-extern void generic_outl_p(unsigned int value, unsigned long port);
-
-extern void generic_insb(unsigned long port, void *addr, unsigned long count);
-extern void generic_insw(unsigned long port, void *addr, unsigned long count);
-extern void generic_insl(unsigned long port, void *addr, unsigned long count);
-extern void generic_outsb(unsigned long port, const void *addr, unsigned long count);
-extern void generic_outsw(unsigned long port, const void *addr, unsigned long count);
-extern void generic_outsl(unsigned long port, const void *addr, unsigned long count);
-
-extern unsigned char generic_readb(unsigned long addr);
-extern unsigned short generic_readw(unsigned long addr);
-extern unsigned int generic_readl(unsigned long addr);
-extern void generic_writeb(unsigned char b, unsigned long addr);
-extern void generic_writew(unsigned short b, unsigned long addr);
-extern void generic_writel(unsigned int b, unsigned long addr);
+void __iomem *IO_CONCAT(__IO_PREFIX,ioport_map)(unsigned long addr, unsigned int size);
+void IO_CONCAT(__IO_PREFIX,ioport_unmap)(void __iomem *addr);
 
-extern void *generic_ioremap(unsigned long offset, unsigned long size);
-extern void generic_iounmap(void *addr);
-
-extern unsigned long generic_isa_port2addr(unsigned long offset);
-
-#endif /* _ASM_SH_IO_GENERIC_H */
+#undef __IO_PREFIX

diff -urN -X exclude linux-2.6.15/include/asm-sh/machvec.h sh-2.6.15/include/asm-sh/machvec.h
--- linux-2.6.15/include/asm-sh/machvec.h	2006-01-04 14:20:02.000000000 +0200
+++ sh-2.6.15/include/asm-sh/machvec.h	2006-01-04 14:16:32.000000000 +0200
@@ -18,44 +18,37 @@
 #include <asm/machvec_init.h>
 
 struct device;
-struct timeval;
 
-struct sh_machine_vector
-{
+struct sh_machine_vector {
 	int mv_nr_irqs;
 
-	unsigned char (*mv_inb)(unsigned long);
-	unsigned short (*mv_inw)(unsigned long);
-	unsigned int (*mv_inl)(unsigned long);
-	void (*mv_outb)(unsigned char, unsigned long);
-	void (*mv_outw)(unsigned short, unsigned long);
-	void (*mv_outl)(unsigned int, unsigned long);
-
-	unsigned char (*mv_inb_p)(unsigned long);
-	unsigned short (*mv_inw_p)(unsigned long);
-	unsigned int (*mv_inl_p)(unsigned long);
-	void (*mv_outb_p)(unsigned char, unsigned long);
-	void (*mv_outw_p)(unsigned short, unsigned long);
-	void (*mv_outl_p)(unsigned int, unsigned long);
-
-	void (*mv_insb)(unsigned long port, void *addr, unsigned long count);
-	void (*mv_insw)(unsigned long port, void *addr, unsigned long count);
-	void (*mv_insl)(unsigned long port, void *addr, unsigned long count);
-	void (*mv_outsb)(unsigned long port, const void *addr, unsigned long count);
-	void (*mv_outsw)(unsigned long port, const void *addr, unsigned long count);
-	void (*mv_outsl)(unsigned long port, const void *addr, unsigned long count);
-
-	unsigned char (*mv_readb)(unsigned long);
-	unsigned short (*mv_readw)(unsigned long);
-	unsigned int (*mv_readl)(unsigned long);
-	void (*mv_writeb)(unsigned char, unsigned long);
-	void (*mv_writew)(unsigned short, unsigned long);
-	void (*mv_writel)(unsigned int, unsigned long);
-
-	void* (*mv_ioremap)(unsigned long offset, unsigned long size);
-	void (*mv_iounmap)(void *addr);
-
-	unsigned long (*mv_isa_port2addr)(unsigned long offset);
+	u8 (*mv_inb)(unsigned long);
+	u16 (*mv_inw)(unsigned long);
+	u32 (*mv_inl)(unsigned long);
+	void (*mv_outb)(u8, unsigned long);
+	void (*mv_outw)(u16, unsigned long);
+	void (*mv_outl)(u32, unsigned long);
+
+	u8 (*mv_inb_p)(unsigned long);
+	u16 (*mv_inw_p)(unsigned long);
+	u32 (*mv_inl_p)(unsigned long);
+	void (*mv_outb_p)(u8, unsigned long);
+	void (*mv_outw_p)(u16, unsigned long);
+	void (*mv_outl_p)(u32, unsigned long);
+
+	void (*mv_insb)(unsigned long, void *dst, unsigned long count);
+	void (*mv_insw)(unsigned long, void *dst, unsigned long count);
+	void (*mv_insl)(unsigned long, void *dst, unsigned long count);
+	void (*mv_outsb)(unsigned long, const void *src, unsigned long count);
+	void (*mv_outsw)(unsigned long, const void *src, unsigned long count);
+	void (*mv_outsl)(unsigned long, const void *src, unsigned long count);
+
+	u8 (*mv_readb)(void __iomem *);
+	u16 (*mv_readw)(void __iomem *);
+	u32 (*mv_readl)(void __iomem *);
+	void (*mv_writeb)(u8, void __iomem *);
+	void (*mv_writew)(u16, void __iomem *);
+	void (*mv_writel)(u32, void __iomem *);
 
 	int (*mv_irq_demux)(int irq);
 
@@ -66,6 +59,9 @@
 
 	void *(*mv_consistent_alloc)(struct device *, size_t, dma_addr_t *, gfp_t);
 	int (*mv_consistent_free)(struct device *, size_t, void *, dma_addr_t);
+
+	void __iomem *(*mv_ioport_map)(unsigned long port, unsigned int size);
+	void (*mv_ioport_unmap)(void __iomem *);
 };
 
 extern struct sh_machine_vector sh_mv;
