Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVAVAdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVAVAdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVAVAaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:30:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37838 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262628AbVAVAZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:25:41 -0500
Date: Sat, 22 Jan 2005 00:25:28 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: linux-mips@linux-mips.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: TurboChannel Bsus sysfs port.
Message-ID: <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.8 DOMAIN_BODY            BODY: Domain registration spam body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Experimenting with sysfs to figure out how it works. So I'm attempting to 
port the TurboChannel bus code to sysfs. Its a test of concept and a 
learning experience. Comments welcomed.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/tc/Makefile fbdev-2.6/drivers/tc/Makefile
--- linus-2.6/drivers/tc/Makefile	2005-01-21 10:23:32.000000000 -0800
+++ fbdev-2.6/drivers/tc/Makefile	2005-01-20 14:14:54.000000000 -0800
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-$(CONFIG_TC) += tc.o
+obj-$(CONFIG_TC) += tc.o tc-driver.o
 obj-$(CONFIG_ZS) += zs.o
 obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/tc/tc-driver.c fbdev-2.6/drivers/tc/tc-driver.c
--- linus-2.6/drivers/tc/tc-driver.c	1969-12-31 16:00:00.000000000 -0800
+++ fbdev-2.6/drivers/tc/tc-driver.c	2005-01-21 10:22:29.000000000 -0800
@@ -0,0 +1,92 @@
+/*
+ *  TURBO Channel Driver Services
+ *
+ *  Copyright (C) 2005 James Simmons 
+ *
+ *  Loosely based on drivers/tc/dio-driver.c
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/tc.h>
+
+	/**
+	 *  tc_register_driver - register a new TC driver
+	 *  @drv: the driver structure to register
+	 *
+	 *  Adds the driver structure to the list of registered drivers
+	 *  Returns the number of TC devices which were claimed by the driver
+	 *  during registration.  The driver remains registered even if the
+	 *  return value is zero.
+	 */
+
+int tc_register_driver(struct tc_driver *drv)
+{
+	int count = 0;
+
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &tc_bus_type;
+
+	/* register with core */
+	count = driver_register(&drv->driver);
+	return count ? count : 1;
+}
+
+	/**
+	 *  tc_unregister_driver - unregister a TC driver
+	 *  @drv: the driver structure to unregister
+	 *
+	 *  Deletes the driver structure from the list of registered TC drivers,
+	 *  gives it a chance to clean up by calling its remove() function for
+	 *  each device it was responsible for, and marks those devices as
+	 *  driverless.
+	 */
+
+void tc_unregister_driver(struct tc_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+
+
+	/**
+	 *  tc_bus_match - Tell if a TC device structure has a matching TC
+	 *                  device id structure
+	 *  @ids: array of TC device id structures to search in
+	 *  @dev: the TC device structure to match against
+	 *
+	 *  Used by a driver to check whether a TC device present in the
+	 *  system is in its list of supported devices. Returns the matching
+	 *  tc_device_id structure or %NULL if there is no match.
+	 */
+
+static int tc_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct tc_driver *tc_drv = to_tc_driver(drv);
+	struct tc_dev *tdev = to_tc_dev(dev);
+
+	return (strncmp(tdev->name, drv->name, 9) == 0);
+}
+
+struct bus_type tc_bus_type = {
+	.name	= "tc",
+	.match	= tc_bus_match
+};
+
+
+static int __init tc_driver_init(void)
+{
+	return bus_register(&tc_bus_type);
+}
+
+postcore_initcall(tc_driver_init);
+
+EXPORT_SYMBOL(tc_match_device);
+EXPORT_SYMBOL(tc_register_driver);
+EXPORT_SYMBOL(tc_unregister_driver);
+EXPORT_SYMBOL(tc_dev_driver);
+EXPORT_SYMBOL(tc_bus_type);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/tc/tc.c fbdev-2.6/drivers/tc/tc.c
--- linus-2.6/drivers/tc/tc.c	2005-01-21 10:23:32.000000000 -0800
+++ fbdev-2.6/drivers/tc/tc.c	2005-01-21 10:28:15.000000000 -0800
@@ -26,9 +26,6 @@
 #define TC_DEBUG
 
 MODULE_LICENSE("GPL");
-slot_info tc_bus[MAX_SLOT];
-static int max_tcslot;
-static tcinfo *info;
 
 unsigned long system_base;
 
@@ -40,54 +37,14 @@
  * Interface to the world. Read comment in include/asm-mips/tc.h.
  */
 
-int search_tc_card(char *name)
-{
-	int slot;
-	slot_info *sip;
-
-	for (slot = 0; slot <= max_tcslot; slot++) {
-		sip = &tc_bus[slot];
-		if ((sip->flags & FREE) && (strncmp(sip->name, name, strlen(name)) == 0)) {
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
-{
-	if (tc_bus[slot].flags & FREE) {
-		printk("release_tc_card: attempting to release a card already free\n");
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
 unsigned long get_tc_irq_nr(int slot)
 {
-	return tc_bus[slot].interrupt;
+	return tc_devices[slot].interrupt;
 }
 
 unsigned long get_tc_speed(void)
 {
-	return 100000 * (10000 / (unsigned long)info->clk_period);
+	return 100000 * (10000 / (unsigned long)tc_bus.info->clk_period);
 }
 
 /*
@@ -98,138 +55,144 @@
 	regs->cp0_epc += 4;
 }
 
-static void __init tc_probe(unsigned long startaddr, unsigned long size, int max_slot)
+static void __init tc_bus_add_devices(struct tc_bus *bus, unsigned long startaddr)
 {
-	int i, slot;
-	long offset;
-	unsigned char *module;
+	unsigned long size = bus->info->slot_size << 20;
 	void (*old_be_handler)(struct pt_regs *regs);
+	unsigned char *module;
+	struct tc_device *dev;	
+	long offset;
+	int i, slot;
 
+	switch (mips_machtype) {
+	case MACH_DS5000_200:
+		bus->max_tcslot = 6;
+		break;
+	case MACH_DS5000_1XX:
+	case MACH_DS5000_2X0:
+		bus->max_tcslot = 2;
+		break;
+	case MACH_DS5000_XX:
+	default:
+		bus->max_tcslot = 1;
+		break;
+	}
+	
 	/* Install our exception handler temporarily */
-
 	old_be_handler = dbe_board_handler;
 	dbe_board_handler = my_dbe_handler;
-	for (slot = 0; slot <= max_slot; slot++) {
+	
+	for (slot = 0; slot <= bus->max_slot; slot++) {
 		module = (char *)(startaddr + slot * size);
 		offset = -1;
-		if (module[OLDCARD + TC_PATTERN0] == 0x55 && module[OLDCARD + TC_PATTERN1] == 0x00
-		  && module[OLDCARD + TC_PATTERN2] == 0xaa && module[OLDCARD + TC_PATTERN3] == 0xff)
+		if (module[OLDCARD + TC_PATTERN0] == 0x55 &&
+		    module[OLDCARD + TC_PATTERN1] == 0x00 &&
+		    module[OLDCARD + TC_PATTERN2] == 0xaa &&
+		    module[OLDCARD + TC_PATTERN3] == 0xff)
 			offset = OLDCARD;
-		if (module[TC_PATTERN0] == 0x55 && module[TC_PATTERN1] == 0x00
-		  && module[TC_PATTERN2] == 0xaa && module[TC_PATTERN3] == 0xff)
+		if (module[TC_PATTERN0] == 0x55 && module[TC_PATTERN1] == 0x00 && 
+		    module[TC_PATTERN2] == 0xaa && module[TC_PATTERN3] == 0xff)
 			offset = 0;
 
 		if (offset != -1) {
-			tc_bus[slot].base_addr = (unsigned long)module;
+			/* Found a board, allocate it an entry in the list */
+			dev = kmalloc(sizeof(struct tc_dev), GFP_KERNEL);
+			if (!dev)
+				return 0;
+			memset(dev, 0, sizeof(struct tc_dev));
+			dev->bus = &tc_bus;
+			dev->dev.parent = &tc_bus.dev;
+			dev->dev.bus = &tc_bus_type;
+			dev->slot = slot;		
+			
+			dev->base_addr = (unsigned long)module;
 			for(i = 0; i < 8; i++) {
-				tc_bus[slot].firmware[i] = module[TC_FIRM_VER + offset + 4 * i];
-				tc_bus[slot].vendor[i] = module[TC_VENDOR + offset + 4 * i];
-				tc_bus[slot].name[i] = module[TC_MODULE + offset + 4 * i];
+				dev->firmware[i] = module[TC_FIRM_VER + offset + 4 * i];
+				dev->vendor[i] = module[TC_VENDOR + offset + 4 * i];
+				dev->name[i] = module[TC_MODULE + offset + 4 * i];
 			}
-			tc_bus[slot].firmware[8] = 0;
-			tc_bus[slot].vendor[8] = 0;
-			tc_bus[slot].name[8] = 0;
+			dev->firmware[8] = 0;
+			dev->vendor[8] = 0;
+			dev->name[8] = 0;
+
 			/*
 			 * Looks unneccesary, but we may change
 			 * TC? in the future
 			 */
 			switch (slot) {
 			case 0:
-				tc_bus[slot].interrupt = TC0;
+				dev->interrupt = TC0;
 				break;
 			case 1:
-				tc_bus[slot].interrupt = TC1;
+				dev->interrupt = TC1;
 				break;
 			case 2:
-				tc_bus[slot].interrupt = TC2;
+				dev->interrupt = TC2;
 				break;
 			/*
 			 * Yuck! DS5000/200 onboard devices
 			 */
 			case 5:
-				tc_bus[slot].interrupt = SCSI_INT;
+				dev->interrupt = SCSI_INT;
 				break;
 			case 6:
-				tc_bus[slot].interrupt = ETHER;
+				dev->interrupt = ETHER;
 				break;
 			default:
-				tc_bus[slot].interrupt = -1;
+				dev->interrupt = -1;
 				break;
-			}	
+			}
 		}
 	}
-
 	dbe_board_handler = old_be_handler;
+
+  	/*
+  	 * All TURBOchannel DECstations have the onboard devices
+ 	 * where the (max_tcslot + 1 or 2 on DS5k/xx) Option Module
+ 	 * would be.
+ 	 */
+ 	if (mips_machtype == MACH_DS5000_XX)
+ 		i = 2;
+	else
+ 		i = 1;
+        system_base = startaddr + size * (bus->max_tcslot + i);
 }
 
 /*
  * the main entry
  */
-void __init tc_init(void)
+static int __init tc_init(void)
 {
-	int tc_clock;
-	int i;
 	unsigned long slot0addr;
 	unsigned long slot_size;
-
+	int tc_clock;
+	int i;
+	
 	if (!TURBOCHANNEL)
 		return;
 
-	for (i = 0; i < MAX_SLOT; i++) {
-		tc_bus[i].base_addr = 0;
-		tc_bus[i].name[0] = 0;
-		tc_bus[i].vendor[0] = 0;
-		tc_bus[i].firmware[0] = 0;
-		tc_bus[i].interrupt = -1;
-		tc_bus[i].flags = FREE;
-	}
+	/* Initialize the Turbo Channel bus */
+	INIT_LIST_HEAD(&tc_bus.devices);
+	strcpy(tc_bus.dev.bus_id, "TURBO Channel");
+	device_register(&tc_bus.dev);
 
-	info = (tcinfo *) rex_gettcinfo();
+	tc_bus.info = (tcinfo *) rex_gettcinfo();
 	slot0addr = (unsigned long)KSEG1ADDR(rex_slot_address(0));
 
-	switch (mips_machtype) {
-	case MACH_DS5000_200:
-		max_tcslot = 6;
-		break;
-	case MACH_DS5000_1XX:
-	case MACH_DS5000_2X0:
-		max_tcslot = 2;
-		break;
-	case MACH_DS5000_XX:
-	default:
-		max_tcslot = 1;
-		break;
-	}
-
-	tc_clock = 10000 / info->clk_period;
+	tc_clock = 10000 / tc_bus.info->clk_period;
 
-	if (TURBOCHANNEL && info->slot_size && slot0addr) {
-		printk("TURBOchannel rev. %1d at %2d.%1d MHz ", info->revision,
+	if (tc_bus.info->slot_size && slot0addr) {
+		printk("TURBOchannel rev. %1d at %2d.%1d MHz", tc_bus.info->revision,
 			tc_clock / 10, tc_clock % 10);
-		printk("(with%s parity)\n", info->parity ? "" : "out");
-
-		slot_size = info->slot_size << 20;
-
-		tc_probe(slot0addr, slot_size, max_tcslot);
-
-  		/*
-  		 * All TURBOchannel DECstations have the onboard devices
- 		 * where the (max_tcslot + 1 or 2 on DS5k/xx) Option Module
- 		 * would be.
- 		 */
- 		if(mips_machtype == MACH_DS5000_XX)
- 			i = 2;
-		else
- 			i = 1;
- 		
- 	        system_base = slot0addr + slot_size * (max_tcslot + i);
+		printk("(with%s parity)\n", tc_bus.info->parity ? "" : "out");
 
+		tc_bus_add_devices(&tc_bus, slot0addr);
 #ifdef TC_DEBUG
-		for (i = 0; i <= max_tcslot; i++)
-			if (tc_bus[i].base_addr) {
+		for (i = 0; i <= tc_bus.max_tcslot; i++)
+			if (tc_devices[i].base_addr) {
 				printk("    slot %d: ", i);
-				printk("%s %s %s\n", tc_bus[i].vendor,
-					tc_bus[i].name, tc_bus[i].firmware);
+				printk("%s %s %s\n", tc_devices[i].vendor,
+					tc_devices[i].name, tc_devices[i].firmware);
 			}
 #endif
 		ioport_resource.end = KSEG2 - 1;
@@ -238,9 +201,6 @@
 
 subsys_initcall(tc_init);
 
-EXPORT_SYMBOL(search_tc_card);
-EXPORT_SYMBOL(claim_tc_card);
-EXPORT_SYMBOL(release_tc_card);
 EXPORT_SYMBOL(get_tc_base_addr);
 EXPORT_SYMBOL(get_tc_irq_nr);
 EXPORT_SYMBOL(get_tc_speed);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/pmag-ba-fb.c fbdev-2.6/drivers/video/pmag-ba-fb.c
--- linus-2.6/drivers/video/pmag-ba-fb.c	2005-01-21 10:23:49.000000000 -0800
+++ fbdev-2.6/drivers/video/pmag-ba-fb.c	2005-01-21 10:26:48.000000000 -0800
@@ -118,12 +118,12 @@
 	.fb_cursor	= soft_cursor,
 };
 
-int __init pmagbafb_init_one(int slot)
+static int __devinit pmagbafb_probe(struct tc_dev *dev)
 {
-	unsigned long base_addr = get_tc_base_addr(slot);
-	struct fb_info *info = &pmagba_fb_info[slot]; 
+	struct fb_info *info = &pmagba_fb_info[dev->slot]; 
+	unsigned long base_addr = dev->base_addr;
 
-	printk("PMAG-BA framebuffer in slot %d\n", slot);
+	printk("PMAG-BA framebuffer in slot %d\n", dev->slot);
 	/*
 	 * Framebuffer display memory base address and friends
 	 */
@@ -155,24 +155,28 @@
  * Initialise the framebuffer
  */
 
+static struct tc_device_id pmagbafb_tc_tbl[] = {
+	{ "PMAG-BA" },
+	{ 0 }
+};
+
+
+static struct tc_driver pmagbafb_driver = {
+	.name      = "PMAG-BA",
+	.id_table  = pmagbafb_tc_tbl,
+	.probe     = pmagbafb_probe,
+};
+
 int __init pmagbafb_init(void)
 {
-	int sid;
-	int found = 0;
-
 	if (fb_get_options("pmagbafb", NULL))
 		return -ENODEV;
+	return tc_register_driver(&pmagbafb_driver);
+}
 
-	if (TURBOCHANNEL) {
-		while ((sid = search_tc_card("PMAG-BA")) >= 0) {
-			found = 1;
-			claim_tc_card(sid);
-			pmagbafb_init_one(sid);
-		}
-		return found ? 0 : -ENODEV;
-	} else {
-		return -ENODEV;
-	}
+void __exit pmagbafb_exit(void)
+{
+	tc_unregister_driver(&pmagbafb_driver);
 }
 
 module_init(pmagbafb_init);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/asm-mips/dec/tc.h fbdev-2.6/include/asm-mips/dec/tc.h
--- linus-2.6/include/asm-mips/dec/tc.h	2005-01-21 10:25:17.000000000 -0800
+++ fbdev-2.6/include/asm-mips/dec/tc.h	2005-01-20 21:23:47.000000000 -0800
@@ -10,6 +10,47 @@
 #ifndef ASM_TC_H
 #define ASM_TC_H
 
+#include <linux/device.h>
+
+/*
+ * TURBOchannel Bus
+ */
+
+struct tc_bus {
+	struct list_head devices;	/* list of devices on this bus */
+	unsigned int num_resources;	/* number of resources */
+	struct resource resources[2];	/* address space routed to this bus */
+	
+	struct device dev;
+	char name[10];
+	int max_tcslot;
+	tcinfo *info;
+};
+
+#define MAX_SLOT 7
+
+struct tc_dev {
+	struct tc_driver *driver;
+	struct tc_bus *bus;
+	struct device *dev;
+	unsigned long base_addr;
+	unsigned char name[9];
+	unsigned char vendor[9];
+	unsigned char firmware[9];
+	int interrupt;
+	int flags;
+	int slot;
+};
+
+/*
+ *  * Values for flags
+ *   */
+#define FREE    1<<0
+#define IN_USE  1<<1
+
+typedef char* tc_device_id;
+
+
 extern unsigned long system_base;
 
 /*
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/asm-mips/dec/tcinfo.h fbdev-2.6/include/asm-mips/dec/tcinfo.h
--- linus-2.6/include/asm-mips/dec/tcinfo.h	2005-01-21 10:25:17.000000000 -0800
+++ fbdev-2.6/include/asm-mips/dec/tcinfo.h	2005-01-20 20:34:25.000000000 -0800
@@ -27,21 +27,3 @@
 	int reserved[4];
 } tcinfo;
 
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

