Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSF3Npx>; Sun, 30 Jun 2002 09:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSF3Npw>; Sun, 30 Jun 2002 09:45:52 -0400
Received: from [193.14.93.89] ([193.14.93.89]:32004 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S315179AbSF3Npu>;
	Sun, 30 Jun 2002 09:45:50 -0400
From: Christer Weinigel <wingel@nano-system.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: SCx200 patches part 2/3 -- Flash driver
Message-Id: <20020630134805.45947F5B@acolyte.hack.org>
Date: Sun, 30 Jun 2002 15:48:05 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second part of the SCx200 patches.  This patch adds
support for a flash chip connected to the DOCCS chip select.

The patch is generated against a 2.4.19-pre10 kernel with the previous
patch since it needs the header file changes.

    /Christer

diff -urw ./linux/Documentation/Configure.help.orig ./linux/Documentation/Configure.help
--- ./linux/Documentation/Configure.help.orig	Sun Jun 30 14:46:24 2002
+++ ./linux/Documentation/Configure.help	Sun Jun 30 14:45:59 2002
@@ -24989,6 +24989,15 @@
 
   If compiled as a module, it will be called scx200_watchdog.o.
 
+Flash device mapped with DOCCS on NatSemi SCx200
+CONFIG_MTD_SCx200_DOCFLASH
+  Enable support for a flash chip mapped using the DOCCS signal on a
+  National Semiconductor SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_docflash.o.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
--- ./linux/drivers/mtd/maps/Config.in.orig	Sun Jun 30 14:40:12 2002
+++ ./linux/drivers/mtd/maps/Config.in	Sun Jun 30 14:40:14 2002
@@ -30,6 +30,8 @@
    dep_tristate '  JEDEC Flash device mapped on Mixcom piggyback card' CONFIG_MTD_MIXMEM $CONFIG_MTD_JEDEC
    dep_tristate '  JEDEC Flash device mapped on Octagon 5066 SBC' CONFIG_MTD_OCTAGON $CONFIG_MTD_JEDEC
    dep_tristate '  JEDEC Flash device mapped on Tempustech VMAX SBC301' CONFIG_MTD_VMAX $CONFIG_MTD_JEDEC
+   dep_tristate '  BIOS flash chip on Intel L440GX boards' CONFIG_MTD_L440GX $CONFIG_I386 $CONFIG_MTD_JEDEC
+   dep_tristate '  Flash device mapped with DOCCS on NatSemi SCx200' CONFIG_MTD_SCx200_DOCFLASH $CONFIG_MTD_CFI
    dep_tristate '  BIOS flash chip on Intel L440GX boards' CONFIG_MTD_L440GX $CONFIG_MTD_JEDECPROBE
    dep_tristate ' ROM connected to AMD766 southbridge' CONFIG_MTD_AMD766ROM $CONFIG_MTD_GEN_PROBE   
    dep_tristate ' ROM connected to Intel Hub Controller 2' CONFIG_MTD_ICH2ROM $CONFIG_MTD_JEDECPROBE
diff -urw ./linux/drivers/mtd/maps/Makefile.orig ./linux/drivers/mtd/maps/Makefile
--- ./linux/drivers/mtd/maps/Makefile.orig	Sun Jun 30 14:40:12 2002
+++ ./linux/drivers/mtd/maps/Makefile	Sun Jun 30 14:40:14 2002
@@ -38,6 +38,7 @@
 obj-$(CONFIG_MTD_PCI)		+= pci.o
 obj-$(CONFIG_MTD_PB1000)        += pb1xxx-flash.o
 obj-$(CONFIG_MTD_PB1500)        += pb1xxx-flash.o
+obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 obj-$(CONFIG_MTD_AUTCPU12)      += autcpu12-nvram.o
 
 include $(TOPDIR)/Rules.make
diff -urw ./linux/drivers/mtd/maps/scx200_docflash.c.orig ./linux/drivers/mtd/maps/scx200_docflash.c
--- ./linux/drivers/mtd/maps/scx200_docflash.c.orig	Sun Jun 30 14:40:14 2002
+++ ./linux/drivers/mtd/maps/scx200_docflash.c	Sun Jun 30 15:05:55 2002
@@ -0,0 +1,266 @@
+/* linux/drivers/mtd/maps/scx200_docflash.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 flash mapped with DOCCS
+*/
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <linux/pci.h>
+#include <linux/scx200.h>
+
+#define NAME "scx200_docflash"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@hack.org>");
+MODULE_DESCRIPTION("NatSemi SCx200 DOCCS Flash Driver");
+MODULE_LICENSE("GPL");
+
+/* Set this to one if you want to partition the flash */
+#define PARTITION 0
+
+MODULE_PARM(probe, "i");
+MODULE_PARM_DESC(probe, "Probe for a BIOS mapping");
+MODULE_PARM(size, "i");
+MODULE_PARM_DESC(size, "Size of the flash mapping");
+MODULE_PARM(width, "i");
+MODULE_PARM_DESC(width, "Data width of the flash mapping (8/16)");
+MODULE_PARM(flashtype, "s");
+MODULE_PARM_DESC(flashtype, "Type of MTD probe to do");
+
+static int probe = 0;		/* Don't autoprobe */
+static unsigned size = 0x1000000; /* 16 MB the whole ISA address space */
+static unsigned width = 8;	/* Default to 8 bits wide */
+static char *flashtype = "cfi_probe";
+
+static struct resource docmem = {
+	flags : IORESOURCE_MEM,
+	name : "NatSemi SCx200 DOCCS Flash",
+};
+
+static struct mtd_info *mymtd;
+
+#if PARTITION
+static struct mtd_partition partition_info[] = {
+	{ 
+		name: "DOCCS Boot kernel", 
+		offset: 0, 
+		size: 	0xc0000
+	},
+	{ 
+		name: "DOCCS Low BIOS", 
+		offset: 0xc0000, 
+		size: 	0x40000
+	},
+	{ 
+		name: "DOCCS File system", 
+		offset: 0x100000, 
+		size: 	~0	/* calculate from flash size */
+	},
+	{ 
+		name: "DOCCS High BIOS", 
+		offset: ~0, 	/* calculate from flash size */
+		size: 0x80000
+	},
+};
+#define NUM_PARTITIONS (sizeof(partition_info)/sizeof(partition_info[0]))
+#endif
+
+static __u8 scx200_docflash_read8(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readb(map->map_priv_1 + ofs);
+}
+
+static __u16 scx200_docflash_read16(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readw(map->map_priv_1 + ofs);
+}
+
+static void scx200_docflash_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
+{
+	memcpy_fromio(to, map->map_priv_1 + from, len);
+}
+
+static void scx200_docflash_write8(struct map_info *map, __u8 d, unsigned long adr)
+{
+	__raw_writeb(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void scx200_docflash_write16(struct map_info *map, __u16 d, unsigned long adr)
+{
+	__raw_writew(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void scx200_docflash_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
+{
+	memcpy_toio(map->map_priv_1 + to, from, len);
+}
+
+static struct map_info scx200_docflash_map = {
+	name: "NatSemi SCx200 DOCCS Flash",
+	read8: scx200_docflash_read8,
+	read16: scx200_docflash_read16,
+	copy_from: scx200_docflash_copy_from,
+	write8: scx200_docflash_write8,
+	write16: scx200_docflash_write16,
+	copy_to: scx200_docflash_copy_to
+};
+
+int __init init_scx200_docflash(void)
+{
+	unsigned u;
+	unsigned base;
+	unsigned ctrl;
+	unsigned pmr;
+	struct pci_dev *bridge;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 DOCCS Flash Driver\n");
+
+	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
+				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+				      NULL)) == NULL)
+		return -ENODEV;
+	
+	if (!scx200_cb_probe(SCx200_CB_BASE)) {
+		printk(KERN_WARNING NAME ": no configuration block found\n");
+		return -ENODEV;
+	}
+
+	if (probe) {
+		/* Try to use the present flash mapping if any */
+		pci_read_config_dword(bridge, SCx200_DOCCS_BASE, &base);
+		pci_read_config_dword(bridge, SCx200_DOCCS_CTRL, &ctrl);
+		pmr = inl(SCx200_CB_BASE + SCx200_PMR);
+
+		if (base == 0
+		    || (ctrl & 0x07000000) != 0x07000000
+		    || (ctrl & 0x0007ffff) == 0)
+			return -ENODEV;
+
+		size = ((ctrl&0x1fff)<<13) + (1<<13);
+
+		for (u = size; u > 1; u >>= 1)
+			;
+		if (u != 1)
+			return -ENODEV;
+
+		if (pmr & (1<<6))
+			width = 16;
+		else
+			width = 8;
+
+		docmem.start = base;
+		docmem.end = base + size;
+
+		if (request_resource(&iomem_resource, &docmem)) {
+			printk(KERN_ERR NAME ": unable to allocate memory for flash mapping\n");
+			return -ENOMEM;
+		}
+	} else {
+		for (u = size; u > 1; u >>= 1)
+			;
+		if (u != 1) {
+			printk(KERN_ERR NAME ": invalid size for flash mapping\n");
+			return -EINVAL;
+		}
+		
+		if (width != 8 && width != 16) {
+			printk(KERN_ERR NAME ": invalid bus width for flash mapping\n");
+			return -EINVAL;
+		}
+		
+		if (allocate_resource(&iomem_resource, &docmem, 
+				      size,
+				      0x80000000, 0xffffffff, 
+				      size, NULL, NULL)) {
+			printk(KERN_ERR NAME ": unable to allocate memory for flash mapping\n");
+			return -ENOMEM;
+		}
+		
+		ctrl = 0x07000000 | (size >> 13);
+		
+		pci_write_config_dword(bridge, SCx200_DOCCS_BASE, docmem.start);
+		pci_write_config_dword(bridge, SCx200_DOCCS_CTRL, ctrl);
+		pmr = inl(SCx200_CB_BASE + SCx200_PMR);
+		
+		if (width == 8) {
+			pmr &= ~(1<<6);
+		} else {
+			pmr |= (1<<6);
+		}
+		outl(pmr, SCx200_CB_BASE + SCx200_PMR);
+	}
+	
+       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%lx-0x%lx, width %d\n", 
+	       docmem.start, docmem.end, width);
+
+	scx200_docflash_map.size = size;
+	if (width == 8)
+		scx200_docflash_map.buswidth = 1;
+	else
+		scx200_docflash_map.buswidth = 2;
+
+	scx200_docflash_map.map_priv_1 = (unsigned long)ioremap(docmem.start, scx200_docflash_map.size);
+	if (!scx200_docflash_map.map_priv_1) {
+		printk(KERN_ERR NAME ": failed to ioremap the flash\n");
+		release_resource(&docmem);
+		return -EIO;
+	}
+
+	mymtd = do_map_probe(flashtype, &scx200_docflash_map);
+	if (!mymtd) {
+		printk(KERN_ERR NAME ": unable to detect flash\n");
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		release_resource(&docmem);
+		return -ENXIO;
+	}
+
+	if (size < mymtd->size)
+		printk(KERN_WARNING NAME ": warning, flash mapping is smaller than flash size\n");
+
+	mymtd->module = THIS_MODULE;
+
+#if PARTITION
+	partition_info[3].offset = mymtd->size-partition_info[3].size;
+	partition_info[2].size = partition_info[3].offset-partition_info[2].offset;
+	add_mtd_partitions(mymtd, partition_info, NUM_PARTITIONS);
+#else
+	add_mtd_device(mymtd);
+#endif
+	return 0;
+}
+
+static void __exit cleanup_scx200_docflash(void)
+{
+	if (mymtd) {
+#if PARTITION
+		del_mtd_partitions(mymtd);
+#else
+		del_mtd_device(mymtd);
+#endif
+		map_destroy(mymtd);
+	}
+	if (scx200_docflash_map.map_priv_1) {
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		release_resource(&docmem);
+	}
+}
+
+module_init(init_scx200_docflash);
+module_exit(cleanup_scx200_docflash);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=drivers/mtd/maps modules"
+        c-basic-offset: 8
+    End:
+*/


-- 
"Just how much can I get away with and still go to heaven?"
