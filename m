Return-Path: <linux-kernel-owner+w=401wt.eu-S1754453AbWLTMBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbWLTMBi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWLTMBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:01:38 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1543 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbWLTMBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:01:36 -0500
Date: Wed, 20 Dec 2006 12:01:30 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>,
       Jeff Garzik <jgarzik@pobox.com>, Antonino Daplas <adaplas@pol.net>,
       James.Bottomley@SteelEye.com
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 01/10] TURBOchannel update to the driver model
Message-ID: <Pine.LNX.4.64N.0612201139080.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a set of changes to convert support for the TURBOchannel bus to 
the driver model.  It implements the usual set of calls similar to what 
other bus drivers have: tc_register_driver(), tc_unregister_driver(), etc.  
All the platform-specific bits have been removed and headers from 
asm-mips/dec/ have been merged into linux/tc.h, which should be included 
by drivers.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-sysfs-78
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/MAINTAINERS linux-mips-2.6.18-20060920/MAINTAINERS
--- linux-mips-2.6.18-20060920.macro/MAINTAINERS	2006-09-20 04:56:08.000000000 +0000
+++ linux-mips-2.6.18-20060920/MAINTAINERS	2006-11-30 01:54:54.000000000 +0000
@@ -2910,6 +2910,11 @@ L:	vtun@office.satix.net
 W:	http://vtun.sourceforge.net/tun
 S:	Maintained
 
+TURBOCHANNEL SUBSYSTEM
+P:	Maciej W. Rozycki
+M:	macro@linux-mips.org
+S:	Maintained
+
 U14-34F SCSI DRIVER
 P:	Dario Ballabio
 M:	ballabio_dario@emc.com
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/tc/Makefile linux-mips-2.6.18-20060920/drivers/tc/Makefile
--- linux-mips-2.6.18-20060920.macro/drivers/tc/Makefile	2003-06-05 04:03:00.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/tc/Makefile	2006-10-03 21:01:58.000000000 +0000
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-$(CONFIG_TC) += tc.o
+obj-$(CONFIG_TC) += tc.o tc-driver.o
 obj-$(CONFIG_ZS) += zs.o
 obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
 
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/tc/tc-driver.c linux-mips-2.6.18-20060920/drivers/tc/tc-driver.c
--- linux-mips-2.6.18-20060920.macro/drivers/tc/tc-driver.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/tc/tc-driver.c	2006-12-19 22:29:49.000000000 +0000
@@ -0,0 +1,110 @@
+/*
+ *	TURBOchannel driver services.
+ *
+ *	Copyright (c) 2005  James Simmons
+ *	Copyright (c) 2006  Maciej W. Rozycki
+ *
+ *	Loosely based on drivers/dio/dio-driver.c and
+ *	drivers/pci/pci-driver.c.
+ *
+ *	This file is subject to the terms and conditions of the GNU
+ *	General Public License.  See the file "COPYING" in the main
+ *	directory of this archive for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/tc.h>
+
+/**
+ * tc_register_driver - register a new TC driver
+ * @drv: the driver structure to register
+ *
+ * Adds the driver structure to the list of registered drivers
+ * Returns a negative value on error, otherwise 0.
+ * If no error occurred, the driver remains registered even if
+ * no device was claimed during registration.
+ */
+int tc_register_driver(struct tc_driver *tdrv)
+{
+	return driver_register(&tdrv->driver);
+}
+EXPORT_SYMBOL(tc_register_driver);
+
+/**
+ * tc_unregister_driver - unregister a TC driver
+ * @drv: the driver structure to unregister
+ *
+ * Deletes the driver structure from the list of registered TC drivers,
+ * gives it a chance to clean up by calling its remove() function for
+ * each device it was responsible for, and marks those devices as
+ * driverless.
+ */
+void tc_unregister_driver(struct tc_driver *tdrv)
+{
+	driver_unregister(&tdrv->driver);
+}
+EXPORT_SYMBOL(tc_unregister_driver);
+
+/**
+ * tc_match_device - tell if a TC device structure has a matching
+ *                   TC device ID structure
+ * @tdrv: the TC driver to earch for matching TC device ID strings
+ * @tdev: the TC device structure to match against
+ *
+ * Used by a driver to check whether a TC device present in the
+ * system is in its list of supported devices.  Returns the matching
+ * tc_device_id structure or %NULL if there is no match.
+ */
+const struct tc_device_id *tc_match_device(struct tc_driver *tdrv,
+					   struct tc_dev *tdev)
+{
+	const struct tc_device_id *id = tdrv->id_table;
+
+	if (id) {
+		while (id->name[0] || id->vendor[0]) {
+			if (strcmp(tdev->name, id->name) == 0 &&
+			    strcmp(tdev->vendor, id->vendor) == 0)
+				return id;
+			id++;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(tc_match_device);
+
+/**
+ * tc_bus_match - Tell if a device structure has a matching
+ *                TC device ID structure
+ * @dev: the device structure to match against
+ * @drv: the device driver to search for matching TC device ID strings
+ *
+ * Used by a driver to check whether a TC device present in the
+ * system is in its list of supported devices.  Returns 1 if there
+ * is a match or 0 otherwise.
+ */
+static int tc_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct tc_dev *tdev = to_tc_dev(dev);
+	struct tc_driver *tdrv = to_tc_driver(drv);
+	const struct tc_device_id *id;
+
+	id = tc_match_device(tdrv, tdev);
+	if (id)
+		return 1;
+
+	return 0;
+}
+
+struct bus_type tc_bus_type = {
+	.name	= "tc",
+	.match	= tc_bus_match,
+};
+EXPORT_SYMBOL(tc_bus_type);
+
+static int __init tc_driver_init(void)
+{
+	return bus_register(&tc_bus_type);
+}
+
+postcore_initcall(tc_driver_init);
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/tc/tc.c linux-mips-2.6.18-20060920/drivers/tc/tc.c
--- linux-mips-2.6.18-20060920.macro/drivers/tc/tc.c	2006-05-30 17:03:11.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/tc/tc.c	2006-12-19 23:03:11.000000000 +0000
@@ -1,254 +1,193 @@
 /*
- * tc-init: We assume the TURBOchannel to be up and running so
- * just probe for Modules and fill in the global data structure
- * tc_bus.
+ *	TURBOchannel bus services.
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ *	Copyright (c) Harald Koerfgen, 1998
+ *	Copyright (c) 2001, 2003, 2005, 2006  Maciej W. Rozycki
+ *	Copyright (c) 2005  James Simmons 
  *
- * Copyright (c) Harald Koerfgen, 1998
- * Copyright (c) 2001, 2003, 2005  Maciej W. Rozycki
+ *	This file is subject to the terms and conditions of the GNU
+ *	General Public License.  See the file "COPYING" in the main
+ *	directory of this archive for more details.
  */
+#include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/tc.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
-#include <asm/errno.h>
 #include <asm/io.h>
-#include <asm/paccess.h>
 
-#include <asm/dec/machtype.h>
-#include <asm/dec/prom.h>
-#include <asm/dec/tcinfo.h>
-#include <asm/dec/tcmodule.h>
-#include <asm/dec/interrupts.h>
-
-MODULE_LICENSE("GPL");
-slot_info tc_bus[MAX_SLOT];
-static int num_tcslots;
-static tcinfo *info;
+static struct tc_bus tc_bus = {
+	.name = "TURBOchannel",
+};
 
 /*
- * Interface to the world. Read comment in include/asm-mips/tc.h.
+ * Probing for TURBOchannel modules.
  */
-
-int search_tc_card(const char *name)
-{
-	int slot;
-	slot_info *sip;
-
-	for (slot = 0; slot < num_tcslots; slot++) {
-		sip = &tc_bus[slot];
-		if ((sip->flags & FREE) &&
-		    (strncmp(sip->name, name, strlen(name)) == 0)) {
-			return slot;
-		}
-	}
-
-	return -ENODEV;
-}
-
-void claim_tc_card(int slot)
-{
-	if (tc_bus[slot].flags & IN_USE) {
-		printk("claim_tc_card: attempting to claim a card already in use\n");
-		return;
-	}
-	tc_bus[slot].flags &= ~FREE;
-	tc_bus[slot].flags |= IN_USE;
-}
-
-void release_tc_card(int slot)
+static void __init tc_bus_add_devices(struct tc_bus *tbus)
 {
-	if (tc_bus[slot].flags & FREE) {
-		printk("release_tc_card: "
-		       "attempting to release a card already free\n");
-		return;
-	}
-	tc_bus[slot].flags &= ~IN_USE;
-	tc_bus[slot].flags |= FREE;
-}
-
-unsigned long get_tc_base_addr(int slot)
-{
-	return tc_bus[slot].base_addr;
-}
-
-unsigned long get_tc_irq_nr(int slot)
-{
-	return tc_bus[slot].interrupt;
-}
-
-unsigned long get_tc_speed(void)
-{
-	return 100000 * (10000 / (unsigned long)info->clk_period);
-}
-
-/*
- * Probing for TURBOchannel modules
- */
-static void __init tc_probe(unsigned long startaddr, unsigned long size,
-			    int slots)
-{
-	unsigned long slotaddr;
+	resource_size_t slotsize = tbus->info.slot_size << 20;
+	resource_size_t extslotsize = tbus->ext_slot_size;
+	resource_size_t slotaddr;
+	resource_size_t extslotaddr;
+	resource_size_t devsize;
+	void __iomem *module;
+	struct tc_dev *tdev;
 	int i, slot, err;
-	long offset;
 	u8 pattern[4];
-	volatile u8 *module;
+	long offset;
 
-	for (slot = 0; slot < slots; slot++) {
-		slotaddr = startaddr + slot * size;
-		module = ioremap_nocache(slotaddr, size);
+	for (slot = 0; slot < tbus->num_tcslots; slot++) {
+		slotaddr = tbus->slot_base + slot * slotsize;
+		extslotaddr = tbus->ext_slot_base + slot * extslotsize;
+		module = ioremap_nocache(slotaddr, slotsize);
 		BUG_ON(!module);
 
-		offset = OLDCARD;
+		offset = TC_OLDCARD;
 
 		err = 0;
-		err |= get_dbe(pattern[0], module + OLDCARD + TC_PATTERN0);
-		err |= get_dbe(pattern[1], module + OLDCARD + TC_PATTERN1);
-		err |= get_dbe(pattern[2], module + OLDCARD + TC_PATTERN2);
-		err |= get_dbe(pattern[3], module + OLDCARD + TC_PATTERN3);
-		if (err) {
-			iounmap(module);
-			continue;
-		}
+		err |= tc_preadb(pattern + 0, module + offset + TC_PATTERN0);
+		err |= tc_preadb(pattern + 1, module + offset + TC_PATTERN1);
+		err |= tc_preadb(pattern + 2, module + offset + TC_PATTERN2);
+		err |= tc_preadb(pattern + 3, module + offset + TC_PATTERN3);
+		if (err)
+			goto out_err;
 
 		if (pattern[0] != 0x55 || pattern[1] != 0x00 ||
 		    pattern[2] != 0xaa || pattern[3] != 0xff) {
-			offset = NEWCARD;
+			offset = TC_NEWCARD;
 
 			err = 0;
-			err |= get_dbe(pattern[0], module + TC_PATTERN0);
-			err |= get_dbe(pattern[1], module + TC_PATTERN1);
-			err |= get_dbe(pattern[2], module + TC_PATTERN2);
-			err |= get_dbe(pattern[3], module + TC_PATTERN3);
-			if (err) {
-				iounmap(module);
-				continue;
-			}
+			err |= tc_preadb(pattern + 0,
+					 module + offset + TC_PATTERN0);
+			err |= tc_preadb(pattern + 1,
+					 module + offset + TC_PATTERN1);
+			err |= tc_preadb(pattern + 2,
+					 module + offset + TC_PATTERN2);
+			err |= tc_preadb(pattern + 3,
+					 module + offset + TC_PATTERN3);
+			if (err)
+				goto out_err;
 		}
 
 		if (pattern[0] != 0x55 || pattern[1] != 0x00 ||
-		    pattern[2] != 0xaa || pattern[3] != 0xff) {
-			iounmap(module);
-			continue;
-		}
+		    pattern[2] != 0xaa || pattern[3] != 0xff)
+			goto out_err;
+
+		/* Found a board, allocate it an entry in the list */
+		tdev = kzalloc(sizeof(*tdev), GFP_KERNEL);
+		if (!tdev) {
+			printk(KERN_ERR "tc%x: unable to allocate tc_dev\n",
+			       slot);
+			goto out_err;
+		}
+		sprintf(tdev->dev.bus_id, "tc%x", slot);
+		tdev->bus = tbus;
+		tdev->dev.parent = &tbus->dev;
+		tdev->dev.bus = &tc_bus_type;
+		tdev->slot = slot;
 
-		tc_bus[slot].base_addr = slotaddr;
 		for (i = 0; i < 8; i++) {
-			tc_bus[slot].firmware[i] =
-				module[TC_FIRM_VER + offset + 4 * i];
-			tc_bus[slot].vendor[i] =
-				module[TC_VENDOR + offset + 4 * i];
-			tc_bus[slot].name[i] =
-				module[TC_MODULE + offset + 4 * i];
-		}
-		tc_bus[slot].firmware[8] = 0;
-		tc_bus[slot].vendor[8] = 0;
-		tc_bus[slot].name[8] = 0;
-		/*
-		 * Looks unneccesary, but we may change
-		 * TC? in the future
-		 */
-		switch (slot) {
-		case 0:
-			tc_bus[slot].interrupt = dec_interrupt[DEC_IRQ_TC0];
-			break;
-		case 1:
-			tc_bus[slot].interrupt = dec_interrupt[DEC_IRQ_TC1];
-			break;
-		case 2:
-			tc_bus[slot].interrupt = dec_interrupt[DEC_IRQ_TC2];
-			break;
-		/*
-		 * Yuck! DS5000/200 onboard devices
-		 */
-		case 5:
-			tc_bus[slot].interrupt = dec_interrupt[DEC_IRQ_TC5];
-			break;
-		case 6:
-			tc_bus[slot].interrupt = dec_interrupt[DEC_IRQ_TC6];
-			break;
-		default:
-			tc_bus[slot].interrupt = -1;
-			break;
-		}
+			tdev->firmware[i] =
+				readb(module + offset + TC_FIRM_VER + 4 * i);
+			tdev->vendor[i] =
+				readb(module + offset + TC_VENDOR + 4 * i);
+			tdev->name[i] =
+				readb(module + offset + TC_MODULE + 4 * i);
+		}
+		tdev->firmware[8] = 0;
+		tdev->vendor[8] = 0;
+		tdev->name[8] = 0;
+
+		pr_info("%s: %s %s %s\n", tdev->dev.bus_id, tdev->vendor,
+			tdev->name, tdev->firmware);
+
+		devsize = readb(module + offset + TC_SLOT_SIZE);
+		devsize <<= 22;
+		if (devsize <= slotsize) {
+			tdev->resource.start = slotaddr;
+			tdev->resource.end = slotaddr + devsize - 1;
+		} else if (devsize <= extslotsize) {
+			tdev->resource.start = extslotaddr;
+			tdev->resource.end = extslotaddr + devsize - 1;
+		} else {
+			printk(KERN_ERR "%s: Cannot provide slot space "
+			       "(%dMiB required, up to %dMiB supported)\n",
+			       tdev->dev.bus_id, devsize >> 20,
+			       max(slotsize, extslotsize) >> 20);
+			kfree(tdev);
+			goto out_err;
+		}
+		tdev->resource.name = tdev->name;
+		tdev->resource.flags = IORESOURCE_MEM;
+
+		tc_device_get_irq(tdev);
 
+		device_register(&tdev->dev);
+		list_add_tail(&tdev->node, &tbus->devices);
+
+out_err:
 		iounmap(module);
 	}
 }
 
 /*
- * the main entry
+ * The main entry.
  */
 static int __init tc_init(void)
 {
-	int tc_clock;
-	int i;
-	unsigned long slot0addr;
-	unsigned long slot_size;
-
-	if (!TURBOCHANNEL)
+	/* Initialize the TURBOchannel bus */
+	if (tc_bus_get_info(&tc_bus))
 		return 0;
 
-	for (i = 0; i < MAX_SLOT; i++) {
-		tc_bus[i].base_addr = 0;
-		tc_bus[i].name[0] = 0;
-		tc_bus[i].vendor[0] = 0;
-		tc_bus[i].firmware[0] = 0;
-		tc_bus[i].interrupt = -1;
-		tc_bus[i].flags = FREE;
-	}
-
-	info = rex_gettcinfo();
-	slot0addr = CPHYSADDR((long)rex_slot_address(0));
-
-	switch (mips_machtype) {
-	case MACH_DS5000_200:
-		num_tcslots = 7;
-		break;
-	case MACH_DS5000_1XX:
-	case MACH_DS5000_2X0:
-	case MACH_DS5900:
-		num_tcslots = 3;
-		break;
-	case MACH_DS5000_XX:
-	default:
-		num_tcslots = 2;
-		break;
-	}
-
-	tc_clock = 10000 / info->clk_period;
-
-	if (info->slot_size && slot0addr) {
-		pr_info("TURBOchannel rev. %d at %d.%d MHz (with%s parity)\n",
-			info->revision, tc_clock / 10, tc_clock % 10,
-			info->parity ? "" : "out");
-
-		slot_size = info->slot_size << 20;
-
-		tc_probe(slot0addr, slot_size, num_tcslots);
-
-		for (i = 0; i < num_tcslots; i++) {
-			if (!tc_bus[i].base_addr)
-				continue;
-			pr_info("    slot %d: %s %s %s\n", i, tc_bus[i].vendor,
-				tc_bus[i].name, tc_bus[i].firmware);
+	INIT_LIST_HEAD(&tc_bus.devices);
+	strcpy(tc_bus.dev.bus_id, "tc");
+	device_register(&tc_bus.dev);
+
+	if (tc_bus.info.slot_size) {
+		unsigned int tc_clock = tc_get_speed(&tc_bus) / 100000;
+
+		pr_info("tc: TURBOchannel rev. %d at %d.%d MHz "
+			"(with%s parity)\n", tc_bus.info.revision,
+			tc_clock / 10, tc_clock % 10,
+			tc_bus.info.parity ? "" : "out");
+
+		tc_bus.resource[0].start = tc_bus.slot_base;
+		tc_bus.resource[0].end = tc_bus.slot_base +
+					 (tc_bus.info.slot_size << 20) *
+					 tc_bus.num_tcslots;
+		tc_bus.resource[0].name = tc_bus.name;
+		tc_bus.resource[0].flags = IORESOURCE_MEM;
+		if (request_resource(&iomem_resource,
+				     &tc_bus.resource[0]) < 0) {
+			printk(KERN_ERR "tc: Cannot reserve resource\n");
+			return 0;
+		}
+		if (tc_bus.ext_slot_size) {
+			tc_bus.resource[1].start = tc_bus.ext_slot_base;
+			tc_bus.resource[1].end = tc_bus.ext_slot_base +
+						 tc_bus.ext_slot_size *
+						 tc_bus.num_tcslots;
+			tc_bus.resource[1].name = tc_bus.name;
+			tc_bus.resource[1].flags = IORESOURCE_MEM;
+			if (request_resource(&iomem_resource,
+					     &tc_bus.resource[1]) < 0) {
+				printk(KERN_ERR
+				       "tc: Cannot reserve resource\n");
+				release_resource(&tc_bus.resource[0]);
+				return 0;
+			}
 		}
+
+		tc_bus_add_devices(&tc_bus);
 	}
 
 	return 0;
 }
 
 subsys_initcall(tc_init);
-
-EXPORT_SYMBOL(search_tc_card);
-EXPORT_SYMBOL(claim_tc_card);
-EXPORT_SYMBOL(release_tc_card);
-EXPORT_SYMBOL(get_tc_base_addr);
-EXPORT_SYMBOL(get_tc_irq_nr);
-EXPORT_SYMBOL(get_tc_speed);
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/tc.h linux-mips-2.6.18-20060920/include/asm-mips/dec/tc.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/tc.h	2005-07-20 05:00:28.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/dec/tc.h	1970-01-01 00:00:00.000000000 +0000
@@ -1,41 +0,0 @@
-/*
- * Interface to the TURBOchannel related routines
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (c) 1998 Harald Koerfgen
- */
-#ifndef __ASM_DEC_TC_H
-#define __ASM_DEC_TC_H
-
-/*
- * Search for a TURBOchannel Option Module
- * with a certain name. Returns slot number
- * of the first card not in use or -ENODEV
- * if none found.
- */
-extern int search_tc_card(const char *);
-/*
- * Marks the card in slot as used
- */
-extern void claim_tc_card(int);
-/*
- * Marks the card in slot as free
- */
-extern void release_tc_card(int);
-/*
- * Return base address of card in slot
- */
-extern unsigned long get_tc_base_addr(int);
-/*
- * Return interrupt number of slot
- */
-extern unsigned long get_tc_irq_nr(int);
-/*
- * Return TURBOchannel clock frequency in Hz
- */
-extern unsigned long get_tc_speed(void);
-
-#endif /* __ASM_DEC_TC_H */
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/tcinfo.h linux-mips-2.6.18-20060920/include/asm-mips/dec/tcinfo.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/tcinfo.h	2002-08-06 03:57:30.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/dec/tcinfo.h	1970-01-01 00:00:00.000000000 +0000
@@ -1,47 +0,0 @@
-/*
- * Various TURBOchannel related stuff
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Information obtained through the get_tcinfo prom call
- * created from:
- *
- * TURBOchannel Firmware Specification
- *
- * EK-TCAAD-FS-004
- * from Digital Equipment Corporation
- *
- * Copyright (c) 1998 Harald Koerfgen
- */
-
-typedef struct {
-	int revision;
-	int clk_period;
-	int slot_size;
-	int io_timeout;
-	int dma_range;
-	int max_dma_burst;
-	int parity;
-	int reserved[4];
-} tcinfo;
-
-#define MAX_SLOT 7
-
-typedef struct {
-	unsigned long base_addr;
-	unsigned char name[9];
-	unsigned char vendor[9];
-	unsigned char firmware[9];
-	int interrupt;
-	int flags;
-} slot_info;
-
-/*
- * Values for flags
- */
-#define FREE 	1<<0
-#define IN_USE	1<<1
-
-
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/tcmodule.h linux-mips-2.6.18-20060920/include/asm-mips/dec/tcmodule.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/tcmodule.h	2002-08-06 03:57:30.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/dec/tcmodule.h	1970-01-01 00:00:00.000000000 +0000
@@ -1,39 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Offsets for the ROM header locations for
- * TURBOchannel cards
- *
- * created from:
- *
- * TURBOchannel Firmware Specification
- *
- * EK-TCAAD-FS-004
- * from Digital Equipment Corporation
- *
- * Jan.1998 Harald Koerfgen
- */
-#ifndef __ASM_DEC_TCMODULE_H
-#define __ASM_DEC_TCMODULE_H
-
-#define OLDCARD 0x3c0000
-#define NEWCARD 0x000000
-
-#define TC_ROM_WIDTH	0x3e0
-#define TC_ROM_STRIDE	0x3e4
-#define TC_ROM_SIZE	0x3e8
-#define TC_SLOT_SIZE	0x3ec
-#define TC_PATTERN0	0x3f0
-#define TC_PATTERN1	0x3f4
-#define TC_PATTERN2	0x3f8
-#define TC_PATTERN3	0x3fc
-#define TC_FIRM_VER	0x400
-#define TC_VENDOR	0x420
-#define TC_MODULE	0x440
-#define TC_FIRM_TYPE	0x460
-#define TC_FLAGS	0x470
-#define TC_ROM_OBJECTS	0x480
-
-#endif /* __ASM_DEC_TCMODULE_H */
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/tc.h linux-mips-2.6.18-20060920/include/linux/tc.h
--- linux-mips-2.6.18-20060920.macro/include/linux/tc.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/linux/tc.h	2006-12-19 22:33:29.000000000 +0000
@@ -0,0 +1,141 @@
+/*
+ *	Interface to the TURBOchannel related routines.
+ *
+ *	Copyright (c) 1998  Harald Koerfgen
+ *	Copyright (c) 2005  James Simmons
+ *	Copyright (c) 2006  Maciej W. Rozycki
+ *
+ *	Based on:
+ *
+ *	"TURBOchannel Firmware Specification", EK-TCAAD-FS-004
+ *
+ *	from Digital Equipment Corporation.
+ *
+ *	This file is subject to the terms and conditions of the GNU
+ *	General Public License.  See the file "COPYING" in the main
+ *	directory of this archive for more details.
+ */
+#ifndef _LINUX_TC_H
+#define _LINUX_TC_H
+
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+
+/*
+ * Offsets for the ROM header locations for TURBOchannel cards.
+ */
+#define TC_OLDCARD	0x3c0000
+#define TC_NEWCARD	0x000000
+
+#define TC_ROM_WIDTH	0x3e0
+#define TC_ROM_STRIDE	0x3e4
+#define TC_ROM_SIZE	0x3e8
+#define TC_SLOT_SIZE	0x3ec
+#define TC_PATTERN0	0x3f0
+#define TC_PATTERN1	0x3f4
+#define TC_PATTERN2	0x3f8
+#define TC_PATTERN3	0x3fc
+#define TC_FIRM_VER	0x400
+#define TC_VENDOR	0x420
+#define TC_MODULE	0x440
+#define TC_FIRM_TYPE	0x460
+#define TC_FLAGS	0x470
+#define TC_ROM_OBJECTS	0x480
+
+/*
+ * Information obtained through the get_tcinfo() PROM call.
+ */
+struct tcinfo {
+	s32		revision;	/* Hardware revision level. */
+	s32		clk_period;	/* Clock period in nanoseconds. */
+	s32		slot_size;	/* Slot size in megabytes. */
+	s32		io_timeout;	/* I/O timeout in cycles. */
+	s32		dma_range;	/* DMA address range in megabytes. */
+	s32		max_dma_burst;	/* Maximum DMA burst length. */
+	s32		parity;		/* System module supports TC parity. */
+	s32		reserved[4];
+};
+
+/*
+ * TURBOchannel bus.
+ */
+struct tc_bus {
+	struct list_head devices;	/* List of devices on this bus. */
+	struct resource	resource[2];	/* Address space routed to this bus. */
+
+	struct device	dev;
+	char		name[13];
+	resource_size_t	slot_base;
+	resource_size_t	ext_slot_base;
+	resource_size_t	ext_slot_size;
+	int		num_tcslots;
+	struct tcinfo	info;
+};
+
+/*
+ * TURBOchannel device.
+ */
+struct tc_dev {
+	struct list_head node;		/* Node in list of all TC devices. */
+	struct tc_bus	*bus;		/* Bus this device is on. */
+	struct tc_driver *driver;	/* Which driver has allocated this
+					   device. */
+	struct device	dev;		/* Generic device interface. */
+	struct resource	resource;	/* Address space of this device. */
+	char		vendor[9];
+	char		name[9];
+	char		firmware[9];
+	int		interrupt;
+	int		slot;
+};
+
+#define to_tc_dev(n) container_of(n, struct tc_dev, dev)
+
+struct tc_device_id {
+	char		vendor[9];
+	char		name[9];
+};
+
+/*
+ * TURBOchannel driver.
+ */
+struct tc_driver {
+	struct list_head node;
+	const struct tc_device_id *id_table;
+	struct device_driver driver;
+};
+
+#define to_tc_driver(drv) container_of(drv, struct tc_driver, driver)
+
+/*
+ * Return TURBOchannel clock frequency in Hz.
+ */
+static inline unsigned long tc_get_speed(struct tc_bus *tbus)
+{
+	return 100000 * (10000 / (unsigned long)tbus->info.clk_period);
+}
+
+#ifdef CONFIG_TC
+
+extern struct bus_type tc_bus_type;
+
+extern int tc_register_driver(struct tc_driver *tdrv);
+extern void tc_unregister_driver(struct tc_driver *tdrv);
+
+#else /* !CONFIG_TC */
+
+static inline int tc_register_driver(struct tc_driver *tdrv) { return 0; }
+static inline void tc_unregister_driver(struct tc_driver *tdrv) { }
+
+#endif /* CONFIG_TC */
+
+/*
+ * These have to be provided by the architecture.
+ */
+extern int tc_preadb(u8 *valp, void __iomem *addr);
+extern int tc_bus_get_info(struct tc_bus *tbus);
+extern void tc_device_get_irq(struct tc_dev *tdev);
+
+#endif /* _LINUX_TC_H */
