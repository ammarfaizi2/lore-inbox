Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbTBQXSW>; Mon, 17 Feb 2003 18:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTBQXRj>; Mon, 17 Feb 2003 18:17:39 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18593 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267492AbTBQXOk>;
	Mon, 17 Feb 2003 18:14:40 -0500
Date: Mon, 17 Feb 2003 18:24:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] pnp - Convert IDE driver (9/13)
Message-ID: <20030217182417.GA31471@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the ide pnp driver to the new pnp api.

Please apply,

Adam

diff -urN a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	Fri Feb 14 23:51:44 2003
+++ b/drivers/ide/Kconfig	Sat Feb 15 23:05:24 2003
@@ -239,14 +239,13 @@
 	  and your BIOS does not already do this for you, then say Y here.
 	  Otherwise say N.
 
-config BLK_DEV_ISAPNP
-	bool "ISA-PNP EIDE support"
-	depends on BLK_DEV_IDE && ISAPNP
+config BLK_DEV_IDEPNP
+	bool "PNP EIDE support"
+	depends on BLK_DEV_IDE && PNP
 	help
-	  If you have an ISA EIDE card that is PnP (Plug and Play) and
-	  requires setup first before scanning for devices, say Y here.
-
-	  If unsure, say N.
+	  If you have a PnP (Plug and Play) compatible EIDE card and
+	  would like the kernel to automatically detect and activate
+	  it, say Y here.
 
 config BLK_DEV_IDEPCI
 	bool "PCI IDE chipset support" if PCI
diff -urN a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	Fri Feb 14 23:51:45 2003
+++ b/drivers/ide/Makefile	Sat Feb 15 23:05:24 2003
@@ -21,7 +21,7 @@
 obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
 obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
 obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+= ide-tcq.o
-obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
 obj-$(CONFIG_PROC_FS)			+= ide-proc.o
diff -urN a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
--- a/drivers/ide/ide-pnp.c	Fri Feb 14 23:51:58 2003
+++ b/drivers/ide/ide-pnp.c	Sat Feb 15 23:05:24 2003
@@ -19,9 +19,7 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
-#include <linux/isapnp.h>
-
-#define DEV_NAME(dev) (dev->name)
+#include <linux/pnp.h>
 
 #define GENERIC_HD_DATA		0
 #define GENERIC_HD_ERROR	1
@@ -32,31 +30,27 @@
 #define GENERIC_HD_SELECT	6
 #define GENERIC_HD_STATUS	7
 
-static int generic_ide_offsets[IDE_NR_PORTS] __initdata = {
+static int generic_ide_offsets[IDE_NR_PORTS] = {
 	GENERIC_HD_DATA, GENERIC_HD_ERROR, GENERIC_HD_NSECTOR, 
 	GENERIC_HD_SECTOR, GENERIC_HD_LCYL, GENERIC_HD_HCYL,
 	GENERIC_HD_SELECT, GENERIC_HD_STATUS, -1, -1
 };
 
-/* ISA PnP device table entry */
-struct pnp_dev_t {
-	unsigned short card_vendor, card_device, vendor, device;
-	int (*init_fn)(struct pnp_dev *dev, int enable);
+/* Add your devices here :)) */
+struct pnp_device_id idepnp_devices[] = {
+  	/* Generic ESDI/IDE/ATA compatible hard disk controller */
+	{.id = "PNP0600", .driver_data = 0},
+	{.id = ""}
 };
 
-/* Generic initialisation function for ISA PnP IDE interface */
-
-static int __init pnpide_generic_init(struct pnp_dev *dev, int enable)
+static int idepnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
 	int index;
 
-	if (!enable)
-		return 0;
-
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
-		return 1;
+		return -1;
 
 	ide_setup_ports(&hw, (ide_ioreg_t) pnp_port_start(dev, 0),
 			generic_ide_offsets,
@@ -68,82 +62,36 @@
 	index = ide_register_hw(&hw, &hwif);
 
 	if (index != -1) {
-	    	printk(KERN_INFO "ide%d: %s IDE interface\n", index, DEV_NAME(dev));
+	    	printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
+		pnp_set_drvdata(dev,hwif);
 		hwif->pnp_dev = dev;
 		return 0;
 	}
 
-	return 1;
+	return -1;
 }
 
-/* Add your devices here :)) */
-struct pnp_dev_t idepnp_devices[] __initdata = {
-  	/* Generic ESDI/IDE/ATA compatible hard disk controller */
-	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_DEVICE(0x0600),
-		pnpide_generic_init },
-	{	0 }
-};
+static void idepnp_remove(struct pnp_dev * dev)
+{
+	ide_hwif_t *hwif = pnp_get_drvdata(dev);
+	if (hwif) {
+		ide_unregister(hwif->index);
+	} else
+		printk(KERN_ERR "idepnp: Unable to remove device, please report.\n");
+}
 
-#define NR_PNP_DEVICES 8
-struct pnp_dev_inst {
-	struct pnp_dev *dev;
-	struct pnp_dev_t *dev_type;
+static struct pnp_driver idepnp_driver = {
+	.name		= "ide",
+	.id_table	= idepnp_devices,
+	.probe		= idepnp_probe,
+	.remove		= idepnp_remove,
 };
-static struct pnp_dev_inst devices[NR_PNP_DEVICES];
-static int pnp_ide_dev_idx = 0;
 
-/*
- * Probe for ISA PnP IDE interfaces.
- */
 
-void __init pnpide_init(int enable)
+void pnpide_init(int enable)
 {
-	struct pnp_dev *dev = NULL;
-	struct pnp_dev_t *dev_type;
-
-	if (!isapnp_present())
-		return;
-
-	/* Module unload, deactivate all registered devices. */
-	if (!enable) {
-		int i;
-		for (i = 0; i < pnp_ide_dev_idx; i++) {
-			dev = devices[i].dev;
-			devices[i].dev_type->init_fn(dev, 0);
-			pnp_device_detach(dev);
-		}
-		return;
-	}
-
-	for (dev_type = idepnp_devices; dev_type->vendor; dev_type++) {
-		while ((dev = pnp_find_dev(NULL, dev_type->vendor,
-			dev_type->device, dev))) {
-			
-			if (pnp_device_attach(dev) < 0)
-				continue;
-				
-			if (pnp_activate_dev(dev, NULL) < 0) {
-				printk(KERN_ERR"ide: %s activate failed\n", DEV_NAME(dev));
-				continue;
-			}
-
-			/* Call device initialization function */
-			if (dev_type->init_fn(dev, 1)) {
-				pnp_device_detach(dev);
-			} else {
-#ifdef MODULE
-				/*
-				 * Register device in the array to
-				 * deactivate it on a module unload.
-				 */
-				if (pnp_ide_dev_idx >= NR_PNP_DEVICES)
-					return;
-				devices[pnp_ide_dev_idx].dev = dev;
-				devices[pnp_ide_dev_idx].dev_type = dev_type;
-				pnp_ide_dev_idx++;
-#endif
-			}
-		}
-	}
+	if(enable)
+		pnp_register_driver(&idepnp_driver);
+	else
+		pnp_unregister_driver(&idepnp_driver);
 }
diff -urN a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Fri Feb 14 23:51:25 2003
+++ b/drivers/ide/ide.c	Sat Feb 15 23:05:24 2003
@@ -817,6 +817,7 @@
 
 EXPORT_SYMBOL(ide_unregister);
 
+
 /**
  *	ide_setup_ports 	-	set up IDE interface ports
  *	@hw: register descriptions
@@ -2071,12 +2072,12 @@
 		buddha_init();
 	}
 #endif /* CONFIG_BLK_DEV_BUDDHA */
-#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP)
+#if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP)
 	{
 		extern void pnpide_init(int enable);
 		pnpide_init(1);
 	}
-#endif /* CONFIG_BLK_DEV_ISAPNP */
+#endif /* CONFIG_BLK_DEV_IDEPNP */
 }
 
 void __init ide_init_builtin_drivers (void)
@@ -2247,9 +2248,9 @@
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return 1;
 	}
-#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP) && defined(MODULE)
+#if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP) && defined(MODULE)
 	pnpide_init(0);
-#endif /* CONFIG_BLK_DEV_ISAPNP */
+#endif /* CONFIG_BLK_DEV_IDEPNP */
 #ifdef CONFIG_PROC_FS
 	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
diff -urN a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Fri Feb 14 23:51:30 2003
+++ b/include/linux/ide.h	Sat Feb 15 23:05:24 2003
@@ -1721,6 +1721,7 @@
 #endif
 
 extern void hwif_unregister(ide_hwif_t *);
+extern void ide_unregister (unsigned int index);
 
 extern void export_ide_init_queue(ide_drive_t *);
 extern u8 export_probe_for_drive(ide_drive_t *);
