Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUG1HhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUG1HhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUG1HgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:36:01 -0400
Received: from ozlabs.org ([203.10.76.45]:8586 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266805AbUG1HLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:49 -0400
Date: Wed, 28 Jul 2004 16:59:13 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [11/15] orinoco merge preliminaries - use name/version macros
Message-ID: <20040728065913.GN16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax> <20040728065800.GL16908@zax> <20040728065827.GM16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065827.GM16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use some macros defining driver names and version to reduce the number
of places that need to be changed when the version changes.  Also use
these to make it easier to keep printk() messages with a consistent
prefix.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:47.239464344 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:49.947052728 +1000
@@ -419,6 +419,8 @@
  * hw_unavailable is non-zero).
  */
 
+#define DRIVER_NAME "orinoco"
+
 #include <linux/config.h>
 
 #include <linux/module.h>
@@ -4179,7 +4181,8 @@
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init init_orinoco(void)
 {
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2004-07-28 15:05:39.587627600 +1000
+++ working-2.6/drivers/net/wireless/orinoco.h	2004-07-28 15:05:49.948052576 +1000
@@ -7,6 +7,8 @@
 #ifndef _ORINOCO_H
 #define _ORINOCO_H
 
+#define DRIVER_VERSION "0.13e"
+
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/netdevice.h>
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:40.437498400 +1000
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:49.950052272 +1000
@@ -10,6 +10,9 @@
  * Copyright notice & release notes in file orinoco.c
  */
 
+#define DRIVER_NAME "orinoco_cs"
+#define PFX DRIVER_NAME ": "
+
 #include <linux/config.h>
 #ifdef  __IN_PCMCIA_PACKAGE__
 #include <pcmcia/k_compat.h>
@@ -74,7 +77,7 @@
  * device driver with appropriate cards, through the card
  * configuration database.
  */
-static dev_info_t dev_info = "orinoco_cs";
+static dev_info_t dev_info = DRIVER_NAME;
 
 /********************************************************************/
 /* Data structures						    */
@@ -240,9 +243,9 @@
 
 	/* Unlink device structure, and free it */
 	*linkp = link->next;
-	DEBUG(0, "orinoco_cs: detach: link=%p link->dev=%p\n", link, link->dev);
+	DEBUG(0, PFX "detach: link=%p link->dev=%p\n", link, link->dev);
 	if (link->dev) {
-		DEBUG(0, "orinoco_cs: About to unregister net device %p\n",
+		DEBUG(0, PFX "About to unregister net device %p\n",
 		      dev);
 		unregister_netdev(dev);
 	}
@@ -400,7 +403,7 @@
 			pcmcia_release_io(link->handle, &link->io);
 		last_ret = pcmcia_get_next_tuple(handle, &tuple);
 		if (last_ret  == CS_NO_MORE_ITEMS) {
-			printk(KERN_ERR "GetNextTuple().  No matching "
+			printk(KERN_ERR PFX "GetNextTuple(): No matching "
 			       "CIS configuration, maybe you need the "
 			       "ignore_cis_vcc=1 parameter.\n");
 			goto cs_failed;
@@ -453,7 +456,7 @@
 	dev->name[0] = '\0';
 	/* Tell the stack we exist */
 	if (register_netdev(dev) != 0) {
-		printk(KERN_ERR "orinoco_cs: register_netdev() failed\n");
+		printk(KERN_ERR PFX "register_netdev() failed\n");
 		goto failed;
 	}
 
@@ -625,12 +628,13 @@
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	"(David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static struct pcmcia_driver orinoco_driver = {
 	.owner		= THIS_MODULE,
 	.drv		= {
-		.name	= "orinoco_cs",
+		.name	= DRIVER_NAME,
 	},
 	.attach		= orinoco_cs_attach,
 	.detach		= orinoco_cs_detach,
@@ -650,7 +654,7 @@
 	pcmcia_unregister_driver(&orinoco_driver);
 
 	if (dev_list)
-		DEBUG(0, "orinoco_cs: Removing leftover devices.\n");
+		DEBUG(0, PFX "Removing leftover devices.\n");
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG)
 			orinoco_cs_release(dev_list);
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:43.820984032 +1000
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:49.952051968 +1000
@@ -85,6 +85,9 @@
  * Jean II
  */
 
+#define DRIVER_NAME "orinoco_pci"
+#define PFX DRIVER_NAME ": "
+
 #include <linux/config.h>
 
 #include <linux/module.h>
@@ -174,7 +177,7 @@
 	}
 	/* Did we timeout ? */
 	if(time_after_eq(jiffies, timeout)) {
-		printk(KERN_ERR "orinoco_pci: Busy timeout\n");
+		printk(KERN_ERR PFX "Busy timeout\n");
 		return -ETIMEDOUT;
 	}
 	printk(KERN_NOTICE "pci_cor : reg = 0x%X - %lX - %lX\n", reg, timeout, jiffies);
@@ -220,7 +223,7 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	printk(KERN_DEBUG
+	printk(KERN_DEBUG PFX
 	       "Detected Orinoco/Prism2 PCI device at %s, mem:0x%lX to 0x%lX -> 0x%p, irq:%d\n",
 	       pci_name(pdev), dev->mem_start, dev->mem_end, pci_ioaddr, pdev->irq);
 
@@ -231,7 +234,7 @@
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR "orinoco_pci: Error allocating IRQ %d.\n",
+		printk(KERN_ERR PFX "Error allocating IRQ %d.\n",
 		       pdev->irq);
 		err = -EBUSY;
 		goto fail;
@@ -368,7 +371,7 @@
 MODULE_DEVICE_TABLE(pci, orinoco_pci_pci_id_table);
 
 static struct pci_driver orinoco_pci_driver = {
-	.name		= "orinoco_pci",
+	.name		= DRIVER_NAME,
 	.id_table	= orinoco_pci_pci_id_table,
 	.probe		= orinoco_pci_init_one,
 	.remove		= __devexit_p(orinoco_pci_remove_one),
@@ -376,7 +379,8 @@
 	.resume		= orinoco_pci_resume,
 };
 
-static char version[] __initdata = "orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)";
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)";
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using direct PCI interface");
 MODULE_LICENSE("Dual MPL/GPL");
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:43.819984184 +1000
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:49.954051664 +1000
@@ -108,6 +108,9 @@
  * going, might not have time for a while..
  */
 
+#define DRIVER_NAME "orinoco_plx"
+#define PFX DRIVER_NAME ": "
+
 #include <linux/config.h>
 
 #include <linux/module.h>
@@ -135,8 +138,6 @@
 #include "hermes.h"
 #include "orinoco.h"
 
-static char dev_info[] = "orinoco_plx";
-
 #define COR_OFFSET	(0x3e0/2) /* COR attribute offset of Prism2 PC card */
 #define COR_VALUE	(COR_LEVEL_REQ | COR_FUNC_ENA) /* Enable PC card with interrupt in level trigger */
 
@@ -218,7 +219,7 @@
 	/* and 3 to the PCMCIA slot I/O address space */
 	pccard_ioaddr = pci_resource_start(pdev, 3);
 	pccard_iolen = pci_resource_len(pdev, 3);
-	if (! request_region(pccard_ioaddr, pccard_iolen, dev_info)) {
+	if (! request_region(pccard_ioaddr, pccard_iolen, DRIVER_NAME)) {
 		printk(KERN_ERR "orinoco_plx: I/O resource 0x%lx @ 0x%lx busy\n",
 		       pccard_iolen, pccard_ioaddr);
 		pccard_ioaddr = 0;
@@ -238,7 +239,7 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	printk(KERN_DEBUG "Detected Orinoco/Prism2 PLX device "
+	printk(KERN_DEBUG PFX "Detected Orinoco/Prism2 PLX device "
 	       "at %s irq:%d, io addr:0x%lx\n", pci_name(pdev), pdev->irq,
 	       pccard_ioaddr);
 
@@ -249,7 +250,7 @@
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR "orinoco_plx: Error allocating IRQ %d.\n", pdev->irq);
+		printk(KERN_ERR PFX "Error allocating IRQ %d.\n", pdev->irq);
 		err = -EBUSY;
 		goto fail;
 	}
@@ -262,7 +263,7 @@
 	return 0;
 
  fail:
-	printk(KERN_DEBUG "orinoco_plx: init_one(), FAIL!\n");
+	printk(KERN_DEBUG PFX "init_one(), FAIL!\n");
 
 	if (dev) {
 		if (dev->irq)
@@ -324,13 +325,14 @@
 MODULE_DEVICE_TABLE(pci, orinoco_plx_pci_id_table);
 
 static struct pci_driver orinoco_plx_driver = {
-	.name		= "orinoco_plx",
+	.name		= DRIVER_NAME,
 	.id_table	= orinoco_plx_pci_id_table,
 	.probe		= orinoco_plx_init_one,
 	.remove		= __devexit_p(orinoco_plx_remove_one),
 };
 
-static char version[] __initdata = "orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
 MODULE_LICENSE("Dual MPL/GPL");
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:47.241464040 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:49.956051360 +1000
@@ -49,6 +49,9 @@
  * Pheecom sells cards with the TMD chip as "ASIC version"
  */
 
+#define DRIVER_NAME "orinoco_tmd"
+#define PFX DRIVER_NAME ": "
+
 #include <linux/config.h>
 
 #include <linux/module.h>
@@ -76,8 +79,6 @@
 #include "hermes.h"
 #include "orinoco.h"
 
-static char dev_info[] = "orinoco_tmd";
-
 #define COR_VALUE	(COR_LEVEL_REQ | COR_FUNC_ENA) /* Enable PC card with interrupt in level trigger */
 
 static int orinoco_tmd_init_one(struct pci_dev *pdev,
@@ -94,11 +95,11 @@
 	if (err)
 		return -EIO;
 
-	printk(KERN_DEBUG "TMD setup\n");
+	printk(KERN_DEBUG PFX "TMD setup\n");
 	pccard_ioaddr = pci_resource_start(pdev, 2);
 	pccard_iolen = pci_resource_len(pdev, 2);
-	if (! request_region(pccard_ioaddr, pccard_iolen, dev_info)) {
-		printk(KERN_ERR "orinoco_tmd: I/O resource at 0x%lx len 0x%lx busy\n",
+	if (! request_region(pccard_ioaddr, pccard_iolen, DRIVER_NAME)) {
+		printk(KERN_ERR PFX "I/O resource at 0x%lx len 0x%lx busy\n",
 			pccard_ioaddr, pccard_iolen);
 		pccard_ioaddr = 0;
 		err = -EBUSY;
@@ -109,7 +110,7 @@
 	mdelay(1);
 	reg = inb(addr);
 	if (reg != COR_VALUE) {
-		printk(KERN_ERR "orinoco_tmd: Error setting TMD COR values %x should be %x\n", reg, COR_VALUE);
+		printk(KERN_ERR PFX "Error setting TMD COR values %x should be %x\n", reg, COR_VALUE);
 		err = -EIO;
 		goto fail;
 	}
@@ -126,7 +127,7 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	printk(KERN_DEBUG "Detected Orinoco/Prism2 TMD device "
+	printk(KERN_DEBUG PFX "Detected Orinoco/Prism2 TMD device "
 	       "at %s irq:%d, io addr:0x%lx\n", pci_name(pdev), pdev->irq,
 	       pccard_ioaddr);
 
@@ -137,7 +138,7 @@
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR "orinoco_tmd: Error allocating IRQ %d.\n",
+		printk(KERN_ERR PFX "Error allocating IRQ %d.\n",
 		       pdev->irq);
 		err = -EBUSY;
 		goto fail;
@@ -151,7 +152,7 @@
 	return 0;
 
  fail:
-	printk(KERN_DEBUG "orinoco_tmd: init_one(), FAIL!\n");
+	printk(KERN_DEBUG PFX "init_one(), FAIL!\n");
 
 	if (dev) {
 		if (dev->irq)
@@ -197,13 +198,14 @@
 MODULE_DEVICE_TABLE(pci, orinoco_tmd_pci_id_table);
 
 static struct pci_driver orinoco_tmd_driver = {
-	.name		= "orinoco_tmd",
+	.name		= DRIVER_NAME,
 	.id_table	= orinoco_tmd_pci_id_table,
 	.probe		= orinoco_tmd_init_one,
 	.remove		= __devexit_p(orinoco_tmd_remove_one),
 };
 
-static char version[] __initdata = "orinoco_tmd.c 0.01 (Joerg Dorchain <joerg@dorchain.net>)";
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (Joerg Dorchain <joerg@dorchain.net>)";
 MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the TMD7160 PCI bridge");
 MODULE_LICENSE("Dual MPL/GPL");
Index: working-2.6/drivers/net/wireless/airport.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/airport.c	2004-07-28 15:05:31.219899688 +1000
+++ working-2.6/drivers/net/wireless/airport.c	2004-07-28 15:05:49.958051056 +1000
@@ -11,6 +11,9 @@
  *  0.06 : fix possible hang on powerup, add sleep support
  */
 
+#define DRIVER_NAME "airport"
+#define PFX DRIVER_NAME ": "
+
 #include <linux/config.h>
 
 #include <linux/module.h>
@@ -194,14 +197,14 @@
 	hermes_t *hw;
 
 	if (macio_resource_count(mdev) < 1 || macio_irq_count(mdev) < 1) {
-		printk(KERN_ERR "airport: wrong interrupt/addresses in OF tree\n");
+		printk(KERN_ERR PFX "wrong interrupt/addresses in OF tree\n");
 		return -ENODEV;
 	}
 
 	/* Allocate space for private device-specific data */
 	dev = alloc_orinocodev(sizeof(*card), airport_hard_reset);
 	if (! dev) {
-		printk(KERN_ERR "airport: can't allocate device datas\n");
+		printk(KERN_ERR PFX "can't allocate device datas\n");
 		return -ENODEV;
 	}
 	priv = netdev_priv(dev);
@@ -211,7 +214,7 @@
 	card->mdev = mdev;
 
 	if (macio_request_resource(mdev, 0, "airport")) {
-		printk(KERN_ERR "airport: can't request IO resource !\n");
+		printk(KERN_ERR PFX "can't request IO resource !\n");
 		free_netdev(dev);
 		return -EBUSY;
 	}
@@ -224,11 +227,11 @@
 	/* Setup interrupts & base address */
 	dev->irq = macio_irq(mdev, 0);
 	phys_addr = macio_resource_start(mdev, 0);  /* Physical address */
-	printk(KERN_DEBUG "Airport at physical address %lx\n", phys_addr);
+	printk(KERN_DEBUG PFX "Airport at physical address %lx\n", phys_addr);
 	dev->base_addr = phys_addr;
 	card->vaddr = ioremap(phys_addr, AIRPORT_IO_LEN);
 	if (!card->vaddr) {
-		printk("airport: ioremap() failed\n");
+		printk(PFX "ioremap() failed\n");
 		goto failed;
 	}
 
@@ -244,17 +247,17 @@
 	hermes_init(hw);
 
 	if (request_irq(dev->irq, orinoco_interrupt, 0, "Airport", dev)) {
-		printk(KERN_ERR "airport: Couldn't get IRQ %d\n", dev->irq);
+		printk(KERN_ERR PFX "Couldn't get IRQ %d\n", dev->irq);
 		goto failed;
 	}
 	card->irq_requested = 1;
 
 	/* Tell the stack we exist */
 	if (register_netdev(dev) != 0) {
-		printk(KERN_ERR "airport: register_netdev() failed\n");
+		printk(KERN_ERR PFX "register_netdev() failed\n");
 		goto failed;
 	}
-	printk(KERN_DEBUG "airport: card registered for interface %s\n", dev->name);
+	printk(KERN_DEBUG PFX "card registered for interface %s\n", dev->name);
 	card->ndev_registered = 1;
 	return 0;
  failed:
@@ -263,7 +266,8 @@
 }				/* airport_attach */
 
 
-static char version[] __initdata = "airport.c 0.13e (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
+	" (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
@@ -280,7 +284,7 @@
 
 static struct macio_driver airport_driver = 
 {
-	.name 		= "airport",
+	.name 		= DRIVER_NAME,
 	.match_table	= airport_match,
 	.probe		= airport_attach,
 	.remove		= airport_detach,

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
