Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264894AbSJVRzq>; Tue, 22 Oct 2002 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264893AbSJVRzQ>; Tue, 22 Oct 2002 13:55:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50194 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264892AbSJVRyj>;
	Tue, 22 Oct 2002 13:54:39 -0400
Date: Tue, 22 Oct 2002 19:00:46 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: grundler@cup.hp.com
Subject: [RFC] Debugging posted PCI writes
Message-ID: <20021022190046.C27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch attempts to emulate PCI write posting to help people debug
device drivers.  However, the problems are either worse than I thought,
or there's a bug in this code as enabling it doesn't let my box boot.
Both eepro100 and e100 have trouble, but maybe these are the only
busmastering devices in my box and there's some rule WRT DMA transactions
I've dishonoured with this patch.  Section 3.2.5 seems to be the relevant
one in the PCI 2.2 spec.

Perhaps a timer that writes the queue every second would help?  It may
be considered unreasonable for writes to be delayed _indefinitely_.

Anyway, here's the patch if anyone fancies debugging it for me ;-)

diff -urpNX dontdiff linux-2.5.44/arch/i386/Config.help linux-2.5.44-willy/arch/i386/Config.help
--- linux-2.5.44/arch/i386/Config.help	2002-10-22 05:50:16.000000000 -0700
+++ linux-2.5.44-willy/arch/i386/Config.help	2002-10-22 06:44:27.000000000 -0700
@@ -1102,3 +1102,9 @@ CONFIG_EDD
 
   This option is experimental, but believed to be safe,
   and most disk controller BIOS vendors do not yet implement this feature.
+
+CONFIG_DEBUG_PCI_WRITES
+  PCI Host Bridges and PCI-PCI Bridges may buffer posted writes to get
+  better performance.  Most x86 host bridges do not.  This config option
+  simulates posting writes to help debug problems that might otherwise
+  only show up behind a PCI bridge or on a different architecture.
diff -urpNX dontdiff linux-2.5.44/arch/i386/config.in linux-2.5.44-willy/arch/i386/config.in
--- linux-2.5.44/arch/i386/config.in	2002-10-22 05:50:16.000000000 -0700
+++ linux-2.5.44-willy/arch/i386/config.in	2002-10-22 06:35:24.000000000 -0700
@@ -460,6 +460,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    bool '  Check for stack overflows' CONFIG_DEBUG_STACKOVERFLOW
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
+   bool '  Simulate PCI posted writes' CONFIG_DEBUG_PCI_WRITES
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
diff -urpNX dontdiff linux-2.5.44/drivers/pci/Makefile linux-2.5.44-willy/drivers/pci/Makefile
--- linux-2.5.44/drivers/pci/Makefile	2002-10-22 05:50:19.000000000 -0700
+++ linux-2.5.44-willy/drivers/pci/Makefile	2002-10-22 06:35:26.000000000 -0700
@@ -14,6 +14,8 @@ ifndef CONFIG_SPARC64
 obj-$(CONFIG_PCI) += setup-res.o
 endif
 
+obj-$(CONFIG_DEBUG_PCI_WRITES) += write-debug.o
+
 #
 # Some architectures use the generic PCI setup functions
 #
diff -urpNX dontdiff linux-2.5.44/drivers/pci/write-debug.c linux-2.5.44-willy/drivers/pci/write-debug.c
--- linux-2.5.44/drivers/pci/write-debug.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.44-willy/drivers/pci/write-debug.c	2002-10-22 06:32:27.000000000 -0700
@@ -0,0 +1,135 @@
+/*
+ * PCI posted write debugging code
+ *
+ * Copyright (c) 2002 Matthew Wilcox <willy@debian.org> for Hewlett-Packard
+ *
+ * Distributed under the terms of the GPL, version 2.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+
+static spinlock_t dbg_data_lock = SPIN_LOCK_UNLOCKED;
+
+unsigned int dbg_data_count;
+
+struct {
+	unsigned long long data;
+	void *addr;
+	unsigned long size;
+} dbg_data[256];
+
+static void write_delayed_data(void)
+{
+	int i;
+	for (i = 0; i < dbg_data_count; i++) {
+		void *addr = dbg_data[i].addr;
+		unsigned long data = dbg_data[i].data;
+		unsigned long size = dbg_data[i].size;
+		if (size == 8) {
+			*(volatile unsigned char *) addr = data;
+		} else if (size == 16) {
+			*(volatile unsigned short *) addr = data;
+		} else if (size == 32) {
+			*(volatile unsigned int *) addr = data;
+		} else if (size == 64) {
+			*(volatile unsigned long long *) addr = data;
+		} else {
+			panic("bad size %lu in PCI debug write", size);
+		}
+	}
+}
+
+unsigned char __dbg_readb(void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count)
+		write_delayed_data();
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+	return *(volatile unsigned char *) addr;
+}
+
+unsigned short __dbg_readw(void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count)
+		write_delayed_data();
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+	return *(volatile unsigned short *) addr;
+}
+
+unsigned int __dbg_readl(void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count)
+		write_delayed_data();
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+	return *(volatile unsigned int *) addr;
+}
+
+unsigned int __dbg_readq(void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count)
+		write_delayed_data();
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+	return *(volatile unsigned long long *) addr;
+}
+
+void __dbg_writeb(unsigned char data, void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count >= 255)
+		write_delayed_data();
+	dbg_data[dbg_data_count].addr = addr;
+	dbg_data[dbg_data_count].data = data;
+	dbg_data[dbg_data_count].size = 8;
+	dbg_data_count++;
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+}
+
+void __dbg_writew(unsigned short data, void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count >= 255)
+		write_delayed_data();
+	dbg_data[dbg_data_count].addr = addr;
+	dbg_data[dbg_data_count].data = data;
+	dbg_data[dbg_data_count].size = 16;
+	dbg_data_count++;
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+}
+
+void __dbg_writel(unsigned int data, void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count >= 255)
+		write_delayed_data();
+	dbg_data[dbg_data_count].addr = addr;
+	dbg_data[dbg_data_count].data = data;
+	dbg_data[dbg_data_count].size = 32;
+	dbg_data_count++;
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+}
+
+void __dbg_writeq(unsigned char data, void *addr)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dbg_data_lock, flags);
+	if (dbg_data_count >= 255)
+		write_delayed_data();
+	dbg_data[dbg_data_count].addr = addr;
+	dbg_data[dbg_data_count].data = data;
+	dbg_data[dbg_data_count].size = 64;
+	dbg_data_count++;
+	spin_unlock_irqrestore(&dbg_data_lock, flags);
+}
+
diff -urpNX dontdiff linux-2.5.44/include/asm-i386/io.h linux-2.5.44-willy/include/asm-i386/io.h
--- linux-2.5.44/include/asm-i386/io.h	2002-10-14 14:37:23.000000000 -0700
+++ linux-2.5.44-willy/include/asm-i386/io.h	2002-10-22 06:20:31.000000000 -0700
@@ -150,16 +150,32 @@ extern void bt_iounmap(void *addr, unsig
  * memory location directly.
  */
 
+#ifdef CONFIG_DEBUG_PCI_WRITES
+extern unsigned char __dbg_readb(void * addr);
+extern unsigned short __dbg_readw(void * addr);
+extern unsigned int __dbg_readl(void * addr);
+extern void __dbg_writeb(unsigned char data, void * addr);
+extern void __dbg_writew(unsigned short data, void * addr);
+extern void __dbg_writel(unsigned int data, void * addr);
+#define readb(addr) __dbg_readb(__io_virt(addr))
+#define readw(addr) __dbg_readw(__io_virt(addr))
+#define readl(addr) __dbg_readl(__io_virt(addr))
+#define writeb(b, addr) __dbg_writeb(b, __io_virt(addr))
+#define writew(b, addr) __dbg_writew(b, __io_virt(addr))
+#define writel(b, addr) __dbg_writel(b, __io_virt(addr))
+#else
 #define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
 #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
 #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
+#define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
+#define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
+#define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
+#endif
+
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
 
-#define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
-#define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
-#define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel

-- 
Revolutions do not require corporate support.
