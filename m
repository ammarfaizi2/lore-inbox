Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSLGWPl>; Sat, 7 Dec 2002 17:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLGWPl>; Sat, 7 Dec 2002 17:15:41 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:22631
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264822AbSLGWPi>; Sat, 7 Dec 2002 17:15:38 -0500
Date: Sat, 7 Dec 2002 17:23:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>, Andre Hedrick <andre@linux-ide.org>,
       Shawn Starr <spstarr@sh0n.net>
Subject: [PATCH][2.5][RFT] ide-pnp.c conversion to new PnP layer
Message-ID: <Pine.LNX.4.50.0212071511550.3130-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre, am i breaking any of your IDE core requirements by missing some
pci_dev entries?

Tested with the following hardware;
isapnp: Card 'OPL3-SAX Sound Board'
isapnp: 1 Plug & Play card detected total
...
ide2: ISA Plug and Play IDE interface
hde: Hewlett-Packard CD-Writer Plus 8100, ATAPI CD/DVD-ROM drive
hdf: ST38410A, ATA DISK drive
isa bounce pool size: 16 pages
ide2 at 0x1e8-0x1ef,0x3ee on irq 11
hdf: host protected area => 1
hdf: 16841664 sectors (8623 MB) w/512KiB Cache, CHS=16708/16/63
 hdf: hdf1 hdf2
...
hde: ATAPI 24X CD-ROM CD-R/RW drive, 1024kB Cache
Uniform CD-ROM driver Revision: 3.12

root@mondecino ~ {0} mount /dev/hdf2 /disk
root@mondecino /disk {0} dd if=/dev/hdf of=/dev/null &
root@mondecino /disk {0} find -exec cat {} > /dev/null \;

   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 2  0  1      0  81476  81840  69624    0    0   867    66 1176   142  4 12 84
 2  0  2      0  70052  90544  72184    0    0 11264     0 1823   366  4 96  0
 2  0  2      0  58740 100912  72952    0    0 11136     0 1812   370  8 92  0
 2  0  2      0  47316 109364  75768    0    0 11268     0 1828   362  6 94  0
 2  0  2      0  35948 118456  77944    0    0 11268     0 1822   363  6 94  0
 2  0  1      0  24860 128320  78968    0    0 10880    12 1791   369  7 93  0

Filesystem was still intact and passed 4 reboots and an fsck

Index: linux-2.5.50/drivers/ide/ide-pnp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.50/drivers/ide/ide-pnp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-pnp.c
--- linux-2.5.50/drivers/ide/ide-pnp.c	28 Nov 2002 01:35:04 -0000	1.1.1.1
+++ linux-2.5.50/drivers/ide/ide-pnp.c	7 Dec 2002 21:41:31 -0000
@@ -18,13 +18,11 @@

 #include <linux/ide.h>
 #include <linux/init.h>
-
-#include <linux/isapnp.h>
+#include <linux/pnp.h>

 #define DEV_IO(dev, index) (dev->resource[index].start)
 #define DEV_IRQ(dev, index) (dev->irq_resource[index].start)
-
-#define DEV_NAME(dev) (dev->bus->name ? dev->bus->name : "ISA PnP")
+#define DEV_NAME(dev) (dev->protocol->name ? dev->protocol->name : "ISA PnP")

 #define GENERIC_HD_DATA		0
 #define GENERIC_HD_ERROR	1
@@ -35,125 +33,125 @@
 #define GENERIC_HD_SELECT	6
 #define GENERIC_HD_STATUS	7

-static int generic_ide_offsets[IDE_NR_PORTS] __initdata = {
+static int generic_ide_offsets[IDE_NR_PORTS] = {
 	GENERIC_HD_DATA, GENERIC_HD_ERROR, GENERIC_HD_NSECTOR,
 	GENERIC_HD_SECTOR, GENERIC_HD_LCYL, GENERIC_HD_HCYL,
 	GENERIC_HD_SELECT, GENERIC_HD_STATUS, -1, -1
 };

 /* ISA PnP device table entry */
-struct pnp_dev_t {
-	unsigned short card_vendor, card_device, vendor, device;
-	int (*init_fn)(struct pci_dev *dev, int enable);
+struct idepnp_private {
+	struct pnp_dev *dev;
+	struct pci_dev pci_dev; /* we need this for the upper layers */
+	int (*init_fn)(struct idepnp_private *device, int enable);
 };

-/* Generic initialisation function for ISA PnP IDE interface */
+/* Barf bags at the ready! Enough to satisfy IDE core */
+static void pnp_to_pci(struct pnp_dev *pnp_dev, struct pci_dev *pci_dev)
+{
+	pci_dev->dev = pnp_dev->dev;
+	pci_dev->driver_data = pnp_get_drvdata(pnp_dev);
+	pci_dev->irq = DEV_IRQ(pnp_dev, 0);
+	pci_set_dma_mask(pci_dev, 0x00ffffff);
+}

-static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
+/* Generic initialisation function for ISA PnP IDE interface */
+static int pnpide_generic_init(struct idepnp_private *device, int enable)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
 	int index;
+	struct pnp_dev *dev = device->dev;

-	if (!enable)
+	if (!enable) {
+		/* nothing to do for now */
 		return 0;
+	}

 	if (!(DEV_IO(dev, 0) && DEV_IO(dev, 1) && DEV_IRQ(dev, 0)))
-		return 1;
+		return -EINVAL;

 	ide_setup_ports(&hw, (ide_ioreg_t) DEV_IO(dev, 0),
 			generic_ide_offsets,
 			(ide_ioreg_t) DEV_IO(dev, 1),
 			0, NULL,
-//			generic_pnp_ide_iops,
+			/* generic_pnp_ide_iops, */
 			DEV_IRQ(dev, 0));

 	index = ide_register_hw(&hw, &hwif);

 	if (index != -1) {
 	    	printk(KERN_INFO "ide%d: %s IDE interface\n", index, DEV_NAME(dev));
-		hwif->pci_dev = dev;
+		hwif->pci_dev = &device->pci_dev;
 		return 0;
 	}

-	return 1;
+	return -ENODEV;
 }

 /* Add your devices here :)) */
-struct pnp_dev_t idepnp_devices[] __initdata = {
-  	/* Generic ESDI/IDE/ATA compatible hard disk controller */
-	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_DEVICE(0x0600),
-		pnpide_generic_init },
-	{	0 }
+#define IDEPNP_GENERIC_INIT	0
+static const struct pnp_device_id pnp_ide_devs[] = {
+	/* Generic ESDI/IDE/ATA compatible hard disk controller */
+	{"PNP0600", IDEPNP_GENERIC_INIT},
+	{"", 0}
 };

 #define NR_PNP_DEVICES 8
-struct pnp_dev_inst {
-	struct pci_dev *dev;
-	struct pnp_dev_t *dev_type;
-};
-static struct pnp_dev_inst devices[NR_PNP_DEVICES];
-static int pnp_ide_dev_idx = 0;
+/* Nb. pnpide_generic_init is indexed as IDEPNP_GENERIC_INIT */
+static int (*init_functions[])(struct idepnp_private *device, int enable) = {pnpide_generic_init};
+static struct idepnp_private devices[NR_PNP_DEVICES];
+static int pnp_ide_dev_idx;

 /*
  * Probe for ISA PnP IDE interfaces.
  */
-
-void __init pnpide_init(int enable)
+static int pnp_ide_probe(struct pnp_dev *pdev, const struct pnp_device_id *dev_id)
 {
-	struct pci_dev *dev = NULL;
-	struct pnp_dev_t *dev_type;
+	int ret;
+	struct idepnp_private *p;

-	if (!isapnp_present())
-		return;
+	/*
+	 * Register device in the array to
+	 * deactivate it on a module unload.
+	 */
+	if (pnp_ide_dev_idx >= NR_PNP_DEVICES)
+		return -ENOSPC;
+
+	p = &devices[pnp_ide_dev_idx];
+	p->init_fn = init_functions[dev_id->driver_data];
+	p->dev = pdev;
+	pnp_set_drvdata(pdev, p);
+	pnp_to_pci(p->dev, &p->pci_dev);
+	ret = p->init_fn(p, 1);
+	if (!ret)
+		pnp_ide_dev_idx++;
+
+	return ret;
+}

-	/* Module unload, deactivate all registered devices. */
-	if (!enable) {
-		int i;
-		for (i = 0; i < pnp_ide_dev_idx; i++) {
-			dev = devices[i].dev;
-			devices[i].dev_type->init_fn(dev, 0);
-			if (dev->deactivate)
-				dev->deactivate(dev);
-		}
-		return;
-	}
+static void pnp_ide_remove(struct pnp_dev *dev)
+{
+	struct idepnp_private *p = pnp_get_drvdata(dev);
+
+	/* if p is null you have a bug elsewhere */
+	p->init_fn(p, 0);
+	pnp_ide_dev_idx--;
+	return;
+}

-	for (dev_type = idepnp_devices; dev_type->vendor; dev_type++) {
-		while ((dev = isapnp_find_dev(NULL, dev_type->vendor,
-			dev_type->device, dev))) {
-
-			if (dev->active)
-				continue;
-
-       			if (dev->prepare && dev->prepare(dev) < 0) {
-				printk(KERN_ERR"ide-pnp: %s prepare failed\n", DEV_NAME(dev));
-				continue;
-			}
-
-			if (dev->activate && dev->activate(dev) < 0) {
-				printk(KERN_ERR"ide: %s activate failed\n", DEV_NAME(dev));
-				continue;
-			}
-
-			/* Call device initialization function */
-			if (dev_type->init_fn(dev, 1)) {
-				if (dev->deactivate(dev))
-					dev->deactivate(dev);
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
+static struct pnp_driver idepnp_driver = {
+	.name		= "ide-pnp",
+	.id_table	= pnp_ide_devs,
+	.probe		= pnp_ide_probe,
+	.remove		= pnp_ide_remove
+};
+
+void pnpide_init(int enable)
+{
+	if (enable)
+		pnp_register_driver(&idepnp_driver);
+	else
+		pnp_unregister_driver(&idepnp_driver);
 }
+
-- 
function.linuxpower.ca
