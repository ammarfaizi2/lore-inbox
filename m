Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVA3WrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVA3WrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVA3WrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:47:19 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:41440 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261307AbVA3Wqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:46:35 -0500
Date: Mon, 31 Jan 2005 07:46:18 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6.11-rc2-mm2] mips: iomap
Message-Id: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds iomap functions to MIPS system.

Some MIPS systems are unable to define PIO space by PIO_MASK/PIO_RESERVED.
This is the reason that I didn't use the general iomap implementation.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/lib/Makefile a/arch/mips/lib/Makefile
--- a-orig/arch/mips/lib/Makefile	Sat Jan 22 10:47:00 2005
+++ a/arch/mips/lib/Makefile	Mon Jan 31 01:55:51 2005
@@ -2,7 +2,7 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o dec_and_lock.o memcpy.o promlib.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o
+lib-y	+= csum_partial_copy.o dec_and_lock.o iomap.o memcpy.o promlib.o \
+	   strlen_user.o strncpy_user.o strnlen_user.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff a-orig/arch/mips/lib/iomap.c a/arch/mips/lib/iomap.c
--- a-orig/arch/mips/lib/iomap.c	Thu Jan  1 09:00:00 1970
+++ a/arch/mips/lib/iomap.c	Mon Jan 31 01:55:51 2005
@@ -0,0 +1,78 @@
+/*
+ *  iomap.c, Memory Mapped I/O routines for MIPS architecture.
+ *
+ *  This code is based on lib/iomap.c, by Linus Torvalds.
+ *
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+
+void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	unsigned long end;
+
+	end = port + nr - 1UL;
+	if (ioport_resource.start > port ||
+	    ioport_resource.end < end || port > end)
+		return NULL;
+
+	return (void __iomem *)(mips_io_port_base + port);
+}
+
+void ioport_unmap(void __iomem *addr)
+{
+}
+EXPORT_SYMBOL(ioport_map);
+EXPORT_SYMBOL(ioport_unmap);
+
+void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	unsigned long start, len, flags;
+
+	if (dev == NULL)
+		return NULL;
+
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	if (!start || !len)
+		return NULL;
+
+	if (maxlen != 0 && len > maxlen)
+		len = maxlen;
+
+	flags = pci_resource_flags(dev, bar);
+	if (flags & IORESOURCE_IO)
+		return ioport_map(start, len);
+	if (flags & IORESOURCE_MEM) {
+		if (flags & IORESOURCE_CACHEABLE)
+			return ioremap_cacheable_cow(start, len);
+		return ioremap_nocache(start, len);
+	}
+
+	return NULL;
+}
+
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iomap);
+EXPORT_SYMBOL(pci_iounmap);
diff -urN -X dontdiff a-orig/include/asm-mips/io.h a/include/asm-mips/io.h
--- a-orig/include/asm-mips/io.h	Mon Jan 31 00:42:41 2005
+++ a/include/asm-mips/io.h	Mon Jan 31 01:55:51 2005
@@ -481,6 +481,34 @@
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
 /*
+ * Memory Mapped I/O
+ */
+#define ioread8(addr)		readb(addr)
+#define ioread16(addr)		readw(addr)
+#define ioread32(addr)		readl(addr)
+
+#define iowrite8(b,addr)	writeb(b,addr)
+#define iowrite16(w,addr)	writew(w,addr)
+#define iowrite32(l,addr)	writel(l,addr)
+
+#define ioread8_rep(a,b,c)	readsb(a,b,c)
+#define ioread16_rep(a,b,c)	readsw(a,b,c)
+#define ioread32_rep(a,b,c)	readsl(a,b,c)
+
+#define iowrite8_rep(a,b,c)	writesb(a,b,c)
+#define iowrite16_rep(a,b,c)	writesw(a,b,c)
+#define iowrite32_rep(a,b,c)	writesl(a,b,c)
+
+/* Create a virtual mapping cookie for an IO port range */
+extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+extern void ioport_unmap(void __iomem *);
+
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+
+/*
  * ISA space is 'always mapped' on currently supported MIPS systems, no need
  * to explicitly ioremap() it. The fact that the ISA IO space is mapped
  * to PAGE_OFFSET is pure coincidence - it does not mean ISA values

