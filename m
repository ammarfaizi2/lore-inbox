Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSG0MYn>; Sat, 27 Jul 2002 08:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318744AbSG0MYn>; Sat, 27 Jul 2002 08:24:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:252 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318743AbSG0MYm>; Sat, 27 Jul 2002 08:24:42 -0400
Date: Sat, 27 Jul 2002 14:27:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] make de2104x hotplugable
Message-ID: <Pine.NEB.4.44.0207271412150.9592-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

since drivers/net/tulip/de2104x.c does currently not compile in 2.5.29 due
to a .text.exit error when the driver is compiled into a kernel without
hotplug support I'm wondering whether the patch below would be correct to
make this PCI driver hotpluggable. Is my approach to change __init to
__devinit and __exit to __devexit correct or is there something I've
overseen?

cu
Adrian

--- drivers/net/tulip/de2104x.c.old	Sat Jul 27 11:43:47 2002
+++ drivers/net/tulip/de2104x.c	Sat Jul 27 11:46:00 2002
@@ -50,7 +50,7 @@
 #include <asm/unaligned.h>

 /* These identify the driver base version and may not be removed. */
-static char version[] __initdata =
+static char version[] __devinitdata =
 KERN_INFO DRV_NAME " PCI Ethernet driver v" DRV_VERSION " (" DRV_RELDATE ")\n";

 MODULE_AUTHOR("Jeff Garzik <jgarzik@mandrakesoft.com>");
@@ -330,7 +330,7 @@
 static unsigned int de_ok_to_advertise (struct de_private *de, u32 new_media);


-static struct pci_device_id de_pci_tbl[] __initdata = {
+static struct pci_device_id de_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP_PLUS,
@@ -1746,7 +1746,7 @@
 	return rc;
 }

-static void __init de21040_get_mac_address (struct de_private *de)
+static void __devinit de21040_get_mac_address (struct de_private *de)
 {
 	unsigned i;

@@ -1763,7 +1763,7 @@
 	}
 }

-static void __init de21040_get_media_info(struct de_private *de)
+static void __devinit de21040_get_media_info(struct de_private *de)
 {
 	unsigned int i;

@@ -1790,7 +1790,7 @@
 }

 /* Note: this routine returns extra data bits for size detection. */
-static unsigned __init tulip_read_eeprom(void *regs, int location, int addr_len)
+static unsigned __devinit tulip_read_eeprom(void *regs, int location, int addr_len)
 {
 	int i;
 	unsigned retval = 0;
@@ -1825,7 +1825,7 @@
 	return retval;
 }

-static void __init de21041_get_srom_info (struct de_private *de)
+static void __devinit de21041_get_srom_info (struct de_private *de)
 {
 	unsigned i, sa_offset = 0, ofs;
 	u8 ee_data[DE_EEPROM_SIZE + 6] = {};
@@ -1981,7 +1981,7 @@
 	goto fill_defaults;
 }

-static int __init de_init_one (struct pci_dev *pdev,
+static int __devinit de_init_one (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct net_device *dev;
@@ -2136,7 +2136,7 @@
 	return rc;
 }

-static void __exit de_remove_one (struct pci_dev *pdev)
+static void __devexit de_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct de_private *de = dev->priv;
@@ -2216,14 +2216,14 @@
 	name:		DRV_NAME,
 	id_table:	de_pci_tbl,
 	probe:		de_init_one,
-	remove:		de_remove_one,
+	remove:		__devexit_p(de_remove_one),
 #ifdef CONFIG_PM
 	suspend:	de_suspend,
 	resume:		de_resume,
 #endif
 };

-static int __init de_init (void)
+static int __devinit de_init (void)
 {
 #ifdef MODULE
 	printk("%s", version);
@@ -2231,7 +2231,7 @@
 	return pci_module_init (&de_driver);
 }

-static void __exit de_exit (void)
+static void __devexit de_exit (void)
 {
 	pci_unregister_driver (&de_driver);
 }


