Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSKWCCm>; Fri, 22 Nov 2002 21:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSKWCCm>; Fri, 22 Nov 2002 21:02:42 -0500
Received: from host194.steeleye.com ([66.206.164.34]:49926 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266917AbSKWCCc>; Fri, 22 Nov 2002 21:02:32 -0500
Message-Id: <200211230209.gAN29Vo08627@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Cc: Project MCA Team <mcalinux@acc.umu.se>, David Weinehall <tao@acc.umu.se>,
       James.Bottomley@HansenPartnership.com
Subject: [PATCH] MCA sysfs part V - update smc-mca driver (and updates to API)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_725415800"
Date: Fri, 22 Nov 2002 20:09:31 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_725415800
Content-Type: text/plain; charset=us-ascii

This tidies up the mca driver API and places it into its own file.

The main part converts the smc-mca driver to using the sysfs probe interface 
(and thus no-longer needs its entry in Space.c).  I had to rename the io and 
irq parameters to be ultra_io and ultra_irq to prevent clashes.

I think this one concludes all the modifications to drivers of actual MCA 
cards I have access to.

James


--==_Exmh_725415800
Content-Type: text/plain ; name="mca-sysfs-V.diff"; charset=us-ascii
Content-Description: mca-sysfs-V.diff
Content-Disposition: attachment; filename="mca-sysfs-V.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.847   -> 1.850  
#	 drivers/net/Space.c	1.12    -> 1.13   
#	drivers/net/smc-mca.c	1.6     -> 1.7    
#	drivers/mca/mca-bus.c	1.2     -> 1.3    
#	 include/linux/mca.h	1.4     -> 1.5    
#	drivers/mca/Makefile	1.2     -> 1.3    
#	               (new)	        -> 1.1     drivers/mca/mca-driver.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/22	jejb@mulgrave.(none)	1.848
# add mca-driver handling
# 
# Tidies up the handling of MCA drivers
# --------------------------------------------
# 02/11/22	jejb@mulgrave.(none)	1.849
# update smc-mca to new MCA API
# 
# This updates to the new API and means that smc-mca is now probed similarly to a PCI device
# --------------------------------------------
# 02/11/22	jejb@mulgrave.(none)	1.850
# add mca-driver.c file
# --------------------------------------------
#
diff -Nru a/drivers/mca/Makefile b/drivers/mca/Makefile
--- a/drivers/mca/Makefile	Fri Nov 22 20:02:17 2002
+++ b/drivers/mca/Makefile	Fri Nov 22 20:02:17 2002
@@ -1,9 +1,9 @@
 # Makefile for the Linux MCA bus support
 
-obj-y	:= mca-bus.o mca-device.o mca-legacy.o
+obj-y	:= mca-bus.o mca-device.o mca-driver.o mca-legacy.o
 
 obj-$(CONFIG_PROC_FS)	+= mca-proc.o
 
-export-objs	:= mca-bus.o mca-legacy.o mca-proc.o
+export-objs	:= mca-bus.o mca-legacy.o mca-proc.o mca-driver.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/mca/mca-bus.c b/drivers/mca/mca-bus.c
--- a/drivers/mca/mca-bus.c	Fri Nov 22 20:02:17 2002
+++ b/drivers/mca/mca-bus.c	Fri Nov 22 20:02:17 2002
@@ -30,8 +30,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/list.h>
-#include <asm/io.h>
 
 /* Very few machines have more than one MCA bus.  However, there are
  * those that do (Voyager 35xx/5xxx), so we do it this way for future
@@ -50,15 +48,16 @@
 	struct mca_device *mca_dev = to_mca_device (dev);
 	struct mca_driver *mca_drv = to_mca_driver (drv);
 	const short *mca_ids = mca_drv->id_table;
+	int i;
 
 	if (!mca_ids)
 		return 0;
 
-	while (*mca_ids) {
-		if (*mca_ids == mca_dev->pos_id)
+	for(i = 0; mca_ids[i]; i++) {
+		if (mca_ids[i] == mca_dev->pos_id) {
+			mca_dev->index = i;
 			return 1;
-
-		mca_ids++;
+		}
 	}
 
 	return 0;
@@ -70,24 +69,6 @@
 };
 EXPORT_SYMBOL (mca_bus_type);
 
-int mca_driver_register (struct mca_driver *mca_drv)
-{
-	int r;
-	
-	mca_drv->driver.bus = &mca_bus_type;
-	if ((r = driver_register (&mca_drv->driver)) < 0)
-		return r;
-
-	return 1;
-}
-
-void mca_driver_unregister (struct mca_driver *mca_drv)
-{
-	bus_remove_driver (&mca_drv->driver);
-	driver_unregister (&mca_drv->driver);
-}
-
-
 static ssize_t mca_show_pos_id(struct device *dev, char *buf, size_t count,
 			       loff_t off)
 {
@@ -135,7 +116,7 @@
 static DEVICE_ATTR(id, S_IRUGO, mca_show_pos_id, NULL);
 static DEVICE_ATTR(pos, S_IRUGO, mca_show_pos, NULL);
 
-int __init mca_register_device (int bus, struct mca_device *mca_dev)
+int __init mca_register_device(int bus, struct mca_device *mca_dev)
 {
 	struct mca_bus *mca_bus = mca_root_busses[bus];
 
@@ -184,6 +165,3 @@
 {
 	return bus_register(&mca_bus_type);
 }
-
-EXPORT_SYMBOL (mca_driver_register);
-EXPORT_SYMBOL (mca_driver_unregister);
diff -Nru a/drivers/mca/mca-driver.c b/drivers/mca/mca-driver.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mca/mca-driver.c	Fri Nov 22 20:02:17 2002
@@ -0,0 +1,47 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/*
+ * MCA driver support functions for sysfs.
+ *
+ * (C) 2002 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**-----------------------------------------------------------------------------
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+ */
+
+#include <linux/device.h>
+#include <linux/mca.h>
+#include <linux/module.h>
+
+int mca_register_driver(struct mca_driver *mca_drv)
+{
+	int r;
+
+	mca_drv->driver.bus = &mca_bus_type;
+	if ((r = driver_register(&mca_drv->driver)) < 0)
+		return r;
+
+	return 0;
+}
+EXPORT_SYMBOL(mca_register_driver);
+
+void mca_unregister_driver(struct mca_driver *mca_drv)
+{
+	driver_unregister(&mca_drv->driver);
+}
+EXPORT_SYMBOL(mca_unregister_driver);
diff -Nru a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c	Fri Nov 22 20:02:17 2002
+++ b/drivers/net/Space.c	Fri Nov 22 20:02:17 2002
@@ -48,7 +48,6 @@
 extern int hp100_probe(struct net_device *dev);
 extern int ultra_probe(struct net_device *dev);
 extern int ultra32_probe(struct net_device *dev);
-extern int ultramca_probe(struct net_device *dev);
 extern int wd_probe(struct net_device *dev);
 extern int el2_probe(struct net_device *dev);
 extern int ne_probe(struct net_device *dev);
@@ -192,9 +191,6 @@
 
 
 static struct devprobe mca_probes[] __initdata = {
-#ifdef CONFIG_ULTRAMCA 
-	{ultramca_probe, 0},
-#endif
 #ifdef CONFIG_NE2_MCA
 	{ne2_probe, 0},
 #endif
diff -Nru a/drivers/net/smc-mca.c b/drivers/net/smc-mca.c
--- a/drivers/net/smc-mca.c	Fri Nov 22 20:02:17 2002
+++ b/drivers/net/smc-mca.c	Fri Nov 22 20:02:17 2002
@@ -53,8 +53,6 @@
 #include "smc-mca.h"
 #include <linux/mca.h>
 
-int ultramca_probe(struct net_device *dev);
-
 static int ultramca_open(struct net_device *dev);
 static void ultramca_reset_8390(struct net_device *dev);
 static void ultramca_get_8390_hdr(struct net_device *dev,
@@ -91,37 +89,57 @@
 	char *name;
 };
 
-static struct smc_mca_adapters_t smc_mca_adapters[] __initdata = {
-    { 0x61c8, "SMC Ethercard PLUS Elite/A BNC/AUI (WD8013EP/A)" },
-    { 0x61c9, "SMC Ethercard PLUS Elite/A UTP/AUI (WD8013WP/A)" },
-    { 0x6fc0, "WD Ethercard PLUS/A (WD8003E/A or WD8003ET/A)" },
-    { 0x6fc1, "WD Starcard PLUS/A (WD8003ST/A)" },
-    { 0x6fc2, "WD Ethercard PLUS 10T/A (WD8003W/A)" },
-    { 0xefd4, "IBM PS/2 Adapter/A for Ethernet UTP/AUI (WD8013WP/A)" },
-    { 0xefd5, "IBM PS/2 Adapter/A for Ethernet BNC/AUI (WD8013EP/A)" },
-    { 0xefe5, "IBM PS/2 Adapter/A for Ethernet" },
-    { 0x0000, NULL }
+#define MAX_ULTRAMCA_CARDS 4	/* Max number of Ultra cards per module */
+
+static int ultra_io[MAX_ULTRAMCA_CARDS];
+static int ultra_irq[MAX_ULTRAMCA_CARDS];
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(ultra_io, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
+MODULE_PARM(ultra_irq, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
+MODULE_PARM_DESC(ultra_io, "SMC Ultra/EtherEZ MCA I/O base address(es)");
+MODULE_PARM_DESC(ultra_irq, "SMC Ultra/EtherEZ MCA IRQ number(s)");
+
+static short smc_mca_adapter_ids[] __initdata = {
+	0x61c8,
+	0x61c9,
+	0x6fc0,
+	0x6fc1,
+	0x6fc2,
+	0xefd4,
+	0xefd5,
+	0xefe5,
+	0x0000
+};
+
+static char *smc_mca_adapter_names[] __initdata = {
+	"SMC Ethercard PLUS Elite/A BNC/AUI (WD8013EP/A)",
+	"SMC Ethercard PLUS Elite/A UTP/AUI (WD8013WP/A)",
+	"WD Ethercard PLUS/A (WD8003E/A or WD8003ET/A)",
+	"WD Starcard PLUS/A (WD8003ST/A)",
+	"WD Ethercard PLUS 10T/A (WD8003W/A)",
+	"IBM PS/2 Adapter/A for Ethernet UTP/AUI (WD8013WP/A)",
+	"IBM PS/2 Adapter/A for Ethernet BNC/AUI (WD8013EP/A)",
+	"IBM PS/2 Adapter/A for Ethernet",
+	NULL
 };
 
-int __init ultramca_probe(struct net_device *dev)
+static int ultra_found = 0;
+
+int __init ultramca_probe(struct device *gen_dev)
 {
 	unsigned short ioaddr;
+	struct net_device *dev;
 	unsigned char reg4, num_pages;
-	char slot = -1;
+	struct mca_device *mca_dev = to_mca_device(gen_dev);
+	char slot = mca_dev->slot;
 	unsigned char pos2 = 0xff, pos3 = 0xff, pos4 = 0xff, pos5 = 0xff;
-	int i, j;
-	int adapter_found = 0;
-	int adapter = 0;
+	int i;
+	int adapter = mca_dev->index;
 	int tbase = 0;
 	int tirq = 0;
-	int base_addr = dev->base_addr;
-	int irq = dev->irq;
-
-	if (!MCA_bus) {
-		return -ENODEV;
-	}
-
-	SET_MODULE_OWNER(dev);
+	int base_addr = ultra_io[ultra_found];
+	int irq = ultra_irq[ultra_found];
 
 	if (base_addr || irq) {
 		printk(KERN_INFO "Probing for SMC MCA adapter");
@@ -134,82 +152,76 @@
 		}
 	}
 
-        /* proper multicard detection by ZP Gu (zpg@castle.net) */
-
-	for (j = 0; (smc_mca_adapters[j].name != NULL) && !adapter_found; j++) {
-		slot = mca_find_unused_adapter(smc_mca_adapters[j].id, 0);
+	tirq = 0;
+	tbase = 0;
 
-		while((slot != MCA_NOTFOUND) && !adapter_found) {
-			tirq = 0;
-			tbase = 0;
-
-                        /* If we're trying to match a specificied irq or
-			 * io address, we'll reject the adapter
-			 * found unless it's the one we're looking for
-			 */
-
-			pos2 = mca_read_stored_pos(slot, 2); /* io_addr */
-			pos3 = mca_read_stored_pos(slot, 3); /* shared mem */
-			pos4 = mca_read_stored_pos(slot, 4); /* ROM bios addr
-							      * range */
-			pos5 = mca_read_stored_pos(slot, 5); /* irq, media
-							      * and RIPL */
-
-			/* Test the following conditions:
-			 * - If an irq parameter is supplied, compare it
-			 *   with the irq of the adapter we found
-			 * - If a base_addr paramater is given, compare it
-			 *   with the base_addr of the adapter we found
-			 * - Check that the irq and the base_addr of the
-			 *   adapter we found is not already in use by
-			 *   this driver
-			 */
-
-			switch (j) { /* j = card-idx (card array above) [hs] */
-				case _61c8_SMC_Ethercard_PLUS_Elite_A_BNC_AUI_WD8013EP_A:
-		                case _61c9_SMC_Ethercard_PLUS_Elite_A_UTP_AUI_WD8013EP_A:
-				case _efd4_IBM_PS2_Adapter_A_for_Ethernet_UTP_AUI_WD8013WP_A:
-				case _efd5_IBM_PS2_Adapter_A_for_Ethernet_BNC_AUI_WD8013WP_A:
-				{
-					tbase = addr_table[(pos2 & 0xf0) >> 4].base_addr;
-					tirq  = irq_table[(pos5 & 0xc) >> 2].new_irq;
-					break;
-				}
-				case _6fc0_WD_Ethercard_PLUS_A_WD8003E_A_OR_WD8003ET_A:
-				case _6fc1_WD_Starcard_PLUS_A_WD8003ST_A:
-				case _6fc2_WD_Ethercard_PLUS_10T_A_WD8003W_A:
-				case _efe5_IBM_PS2_Adapter_A_for_Ethernet:
-				{
-					tbase = ((pos2 & 0x0fe) * 0x10);
-					tirq  = irq_table[(pos5 & 3)].old_irq;
-					break;
-				}
-			}
+	/* If we're trying to match a specificied irq or io address,
+	 * we'll reject the adapter found unless it's the one we're
+	 * looking for */
+
+	pos2 = mca_device_read_stored_pos(mca_dev, 2); /* io_addr */
+	pos3 = mca_device_read_stored_pos(mca_dev, 3); /* shared mem */
+	pos4 = mca_device_read_stored_pos(mca_dev, 4); /* ROM bios addr range */
+	pos5 = mca_device_read_stored_pos(mca_dev, 5); /* irq, media and RIPL */
+
+	/* Test the following conditions:
+	 * - If an irq parameter is supplied, compare it
+	 *   with the irq of the adapter we found
+	 * - If a base_addr paramater is given, compare it
+	 *   with the base_addr of the adapter we found
+	 * - Check that the irq and the base_addr of the
+	 *   adapter we found is not already in use by
+	 *   this driver
+	 */
 
-			if(!tirq || !tbase || (irq && irq != tirq) || (base_addr && tbase != base_addr)) {
-				slot = mca_find_unused_adapter(smc_mca_adapters[j].id, slot + 1);
-			} else {
-				adapter_found = 1;
-				adapter = j;
-			}
+	switch (mca_dev->index) {
+	case _61c8_SMC_Ethercard_PLUS_Elite_A_BNC_AUI_WD8013EP_A:
+	case _61c9_SMC_Ethercard_PLUS_Elite_A_UTP_AUI_WD8013EP_A:
+	case _efd4_IBM_PS2_Adapter_A_for_Ethernet_UTP_AUI_WD8013WP_A:
+	case _efd5_IBM_PS2_Adapter_A_for_Ethernet_BNC_AUI_WD8013WP_A:
+		{
+			tbase = addr_table[(pos2 & 0xf0) >> 4].base_addr;
+			tirq  = irq_table[(pos5 & 0xc) >> 2].new_irq;
+			break;
+		}
+	case _6fc0_WD_Ethercard_PLUS_A_WD8003E_A_OR_WD8003ET_A:
+	case _6fc1_WD_Starcard_PLUS_A_WD8003ST_A:
+	case _6fc2_WD_Ethercard_PLUS_10T_A_WD8003W_A:
+	case _efe5_IBM_PS2_Adapter_A_for_Ethernet:
+		{
+			tbase = ((pos2 & 0x0fe) * 0x10);
+			tirq  = irq_table[(pos5 & 3)].old_irq;
+			break;
 		}
 	}
-
-	if(!adapter_found) {
-		return ((base_addr || irq) ? -ENXIO : -ENODEV);
-	}
+	
+	if(!tirq || !tbase 
+	   || (irq && irq != tirq) 
+	   || (base_addr && tbase != base_addr))
+		/* FIXME: we're trying to force the ordering of the
+		 * devices here, there should be a way of getting this
+		 * to happen */
+		return -ENXIO;
 
         /* Adapter found. */
+	dev  = alloc_etherdev(0);
+	if(!dev)
+		return -ENODEV;
+
+	SET_MODULE_OWNER(dev);
+
+	if((i = register_netdev(dev)) != 0)
+		return i;
 
 	printk(KERN_INFO "%s: %s found in slot %d\n",
-	       dev->name, smc_mca_adapters[adapter].name, slot + 1);
+	       dev->name, smc_mca_adapter_names[adapter], slot + 1);
 
-	mca_set_adapter_name(slot, smc_mca_adapters[adapter].name);
-	mca_mark_as_used(slot);
+	strncpy(gen_dev->name, smc_mca_adapter_names[adapter], sizeof(gen_dev->name));
+	mca_device_set_claim(mca_dev, 1);
 
 
-	dev->base_addr = ioaddr = tbase;
-	dev->irq       = tirq;
+	dev->base_addr = ioaddr = mca_device_transform_ioport(mca_dev, tbase);
+	dev->irq       = mca_device_transform_irq(mca_dev, tirq);
 	dev->mem_start = 0;
 	num_pages      = 40;
 
@@ -220,7 +232,8 @@
 			for (i = 0; i < 16; i++) { /* taking 16 counts
 						    * up to 15 [hs] */
 				if (mem_table[i].mem_index == (pos3 & ~MEM_MASK)) {
-					dev->mem_start = mem_table[i].mem_start;
+					dev->mem_start = (unsigned long)
+					  mca_device_transform_memory(mca_dev, (void *)mem_table[i].mem_start);
 					num_pages = mem_table[i].num_pages;
 				}
 			}
@@ -231,7 +244,8 @@
 		case _6fc2_WD_Ethercard_PLUS_10T_A_WD8003W_A:
 		case _efe5_IBM_PS2_Adapter_A_for_Ethernet:
 		{
-			dev->mem_start = ((pos3 & 0xfc) * 0x1000);
+			dev->mem_start = (unsigned long)
+			  mca_device_transform_memory(mca_dev, (void *)((pos3 & 0xfc) * 0x1000));
 			num_pages = 0x40;
 			break;
 		}
@@ -242,7 +256,8 @@
 			 * the index of the 0x2000 step.
 			 * beware different number of pages [hs]
 			 */
-			dev->mem_start = 0xc0000 + (0x2000 * (pos3 & 0xf));
+			dev->mem_start = (unsigned long) 
+			  mca_device_transform_memory(mca_dev, (void *)(0xc0000 + (0x2000 * (pos3 & 0xf))));
 			num_pages = 0x20 + (2 * (pos3 & 0x10));
 			break;
 		}
@@ -260,7 +275,7 @@
 	printk(KERN_INFO "%s: Parameters: %#3x,", dev->name, ioaddr);
 
 	for (i = 0; i < 6; i++)
-		printk(KERN_INFO " %2.2X", dev->dev_addr[i] = inb(ioaddr + 8 + i));
+		printk(" %2.2X", dev->dev_addr[i] = inb(ioaddr + 8 + i));
 
 	/* Switch from the station address to the alternate register set
 	 * and read the useful registers there.
@@ -283,10 +298,11 @@
 	 */
 
 	if (ethdev_init(dev)) {
-		printk (KERN_INFO ", no memory for dev->priv.\n");
+		printk (", no memory for dev->priv.\n");
 		release_region(ioaddr, ULTRA_IO_EXTENT);
 		return -ENOMEM;
 	}
+	gen_dev->driver_data = dev;
 
 	/* The 8390 isn't at the base address, so fake the offset
 	 */
@@ -303,7 +319,7 @@
 	dev->mem_end = ei_status.rmem_end =
 	dev->mem_start + (ei_status.stop_page - START_PG) * 256;
 
-	printk(KERN_INFO ", IRQ %d memory %#lx-%#lx.\n",
+	printk(", IRQ %d memory %#lx-%#lx.\n",
 	dev->irq, dev->mem_start, dev->mem_end - 1);
 
 	ei_status.reset_8390 = &ultramca_reset_8390;
@@ -315,6 +331,7 @@
 
 	dev->open = &ultramca_open;
 	dev->stop = &ultramca_close_card;
+
 	NS8390_init(dev, 0);
 
 	return 0;
@@ -428,69 +445,48 @@
 	return 0;
 }
 
+static int ultramca_remove(struct device *gen_dev)
+{
+	struct mca_device *mca_dev = to_mca_device(gen_dev);
+	struct net_device *dev = (struct net_device *)gen_dev->driver_data;
 
-#ifdef MODULE
-#undef MODULE        /* don't want to bother now! */
+	if(dev && dev->priv) {
+		/* NB: ultra_close_card() does free_irq */
+		int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET;
 
-#define MAX_ULTRAMCA_CARDS 4	/* Max number of Ultra cards per module */
+		mca_device_set_claim(mca_dev, 0);
+		release_region(ioaddr, ULTRA_IO_EXTENT);
+		unregister_netdev(dev);
+		kfree(dev->priv);
+	}
+	return 0;
+}
 
-static struct net_device dev_ultra[MAX_ULTRAMCA_CARDS];
-static int io[MAX_ULTRAMCA_CARDS];
-static int irq[MAX_ULTRAMCA_CARDS];
-MODULE_LICENSE("GPL");
 
-MODULE_PARM(io, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
-MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
-MODULE_PARM_DESC(io, "SMC Ultra/EtherEZ MCA I/O base address(es)");
-MODULE_PARM_DESC(irq, "SMC Ultra/EtherEZ MCA IRQ number(s)");
+static struct mca_driver ultra_driver = {
+	.id_table = smc_mca_adapter_ids,
+	.driver = {
+		.name = "smc-mca",
+		.bus = &mca_bus_type,
+		.probe = ultramca_probe,
+		.remove = ultramca_remove,
+	}
+};
 
-int init_module(void)
+static int __init ultramca_init_module(void)
 {
-	int this_dev, found = 0;
+	if(!MCA_bus)
+		return -ENXIO;
 
-	for (this_dev = 0; this_dev < MAX_ULTRAMCA_CARDS; this_dev++) {
-		struct net_device *dev = &dev_ultra[this_dev];
-		dev->irq = irq[this_dev];
-		dev->base_addr = io[this_dev];
-		dev->init = ultramca_probe;
-
-		if (register_netdev(dev) != 0) {
-			if (found != 0) {	/* Got at least one. */
-				return 0;
-			}
-			printk(KERN_NOTICE "smc-mca.c: No SMC Ultra card found (i/o = 0x%x).\n", io[this_dev]);
-			return -ENXIO;
-		}
-		found++;
-	}
-	return 0;
+	mca_register_driver(&ultra_driver);
+
+	return ultra_found ? 0 : -ENXIO;
 }
 
-void cleanup_module(void)
+static void __exit ultramca_cleanup_module(void)
 {
-	int this_dev;
-
-	for (this_dev = 0; this_dev < MAX_ULTRAMCA_CARDS; this_dev++) {
-		struct net_device *dev = &dev_ultra[this_dev];
-		if (dev->priv != NULL) {
-			void *priv = dev->priv;
-			/* NB: ultra_close_card() does free_irq */
-			int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET;
-			mca_mark_as_unused(ei_status.priv);
-			release_region(ioaddr, ULTRA_IO_EXTENT);
-			unregister_netdev(dev);
-			kfree(priv);
-		}
-	}
+	mca_unregister_driver(&ultra_driver);
 }
-#endif /* MODULE */
+module_init(ultramca_init_module);
+module_exit(ultramca_cleanup_module);
 
-/*
- * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -Wall -O6 -I/usr/src/linux/net/inet -c smc-mca.c"
- *  version-control: t
- *  kept-new-versions: 5
- *  c-indent-level: 8
- *  tab-width: 8
- * End:
- */
diff -Nru a/include/linux/mca.h b/include/linux/mca.h
--- a/include/linux/mca.h	Fri Nov 22 20:02:17 2002
+++ b/include/linux/mca.h	Fri Nov 22 20:02:17 2002
@@ -52,6 +52,9 @@
 	int			pos_id;
 	int			slot;
 
+	/* index into id_table, set by the bus match routine */
+	int			index;
+
 	/* is there a driver installed? 0 - No, 1 - Yes */
 	int			driver_loaded;
 	/* POS registers */
@@ -100,8 +103,6 @@
 #define to_mca_driver(mdriver) container_of(mdriver, struct mca_driver, driver)
 
 /* Ongoing supported API functions */
-extern int mca_driver_register(struct mca_driver *);
-extern int mca_register_device(int bus, struct mca_device *);
 extern struct mca_device *mca_find_device_by_slot(int slot);
 extern int mca_system_init(void);
 extern struct mca_bus *mca_attach_bus(int);
@@ -121,10 +122,11 @@
 
 extern struct bus_type mca_bus_type;
 
-static inline void mca_register_driver(struct mca_driver *drv)
-{
-	driver_register(&drv->driver);
-}
+extern int mca_register_driver(struct mca_driver *drv);
+extern void mca_unregister_driver(struct mca_driver *drv);
+
+/* WARNING: only called by the boot time device setup */
+extern int mca_register_device(int bus, struct mca_device *mca_dev);
 
 /* for now, include the legacy API */
 #include <linux/mca-legacy.h>

--==_Exmh_725415800--


