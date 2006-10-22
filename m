Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWJVPsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWJVPsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWJVPsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:48:20 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:17121 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751090AbWJVPsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:48:19 -0400
Message-id: <242814652263746404@wsc.cz>
Subject: [PATCH 1/4] Char: stallion, convert to pci probing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 22 Oct 2006 17:48:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, convert to pci probing

Convert stallion driver to pci probing instead of pci_dev_get iteration.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit c4a0f4d15661fe74b8c67b0258d5dfbcff57071b
tree 5da405798c9d47c7a07b63868e9fec1748908b6b
parent fcf3d1f86671d8e01a238935d906356442c92749
author Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:40:25 +0159
committer Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:40:25 +0159

 drivers/char/stallion.c |  165 ++++++++++++++++++++++++-----------------------
 1 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index d2cbdb7..592bd6e 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -381,8 +381,6 @@ #define	STL_CLOSEDELAY		(5 * HZ / 10)
 
 /*****************************************************************************/
 
-#ifdef CONFIG_PCI
-
 /*
  *	Define the Stallion PCI vendor and device IDs.
  */
@@ -402,22 +400,19 @@ #endif
 /*
  *	Define structure to hold all Stallion PCI boards.
  */
-typedef struct stlpcibrd {
-	unsigned short		vendid;
-	unsigned short		devid;
-	int			brdtype;
-} stlpcibrd_t;
-
-static stlpcibrd_t	stl_pcibrds[] = {
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864, BRD_ECH64PCI },
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI, BRD_EASYIOPCI },
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832, BRD_ECHPCI },
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, BRD_ECHPCI },
-};
 
-static int	stl_nrpcibrds = ARRAY_SIZE(stl_pcibrds);
-
-#endif
+static struct pci_device_id stl_pcibrds[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864),
+		.driver_data = BRD_ECH64PCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI),
+		.driver_data = BRD_EASYIOPCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832),
+		.driver_data = BRD_ECHPCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410),
+		.driver_data = BRD_ECHPCI },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, stl_pcibrds);
 
 /*****************************************************************************/
 
@@ -2392,24 +2387,52 @@ static int __init stl_getbrdnr(void)
 	return(-1);
 }
 
-/*****************************************************************************/
+static void stl_cleanup_panels(struct stlbrd *brdp)
+{
+	struct stlpanel *panelp;
+	struct stlport *portp;
+	unsigned int j, k;
 
-#ifdef	CONFIG_PCI
+	for (j = 0; j < STL_MAXPANELS; j++) {
+		panelp = brdp->panels[j];
+		if (panelp == NULL)
+			continue;
+		for (k = 0; k < STL_PORTSPERPANEL; k++) {
+			portp = panelp->ports[k];
+			if (portp == NULL)
+				continue;
+			if (portp->tty != NULL)
+				stl_hangup(portp->tty);
+			kfree(portp->tx.buf);
+			kfree(portp);
+		}
+		kfree(panelp);
+	}
+}
 
+/*****************************************************************************/
 /*
  *	We have a Stallion board. Allocate a board structure and
  *	initialize it. Read its IO and IRQ resources from PCI
  *	configuration space.
  */
 
-static int __init stl_initpcibrd(int brdtype, struct pci_dev *devp)
+static int __devinit stl_pciprobe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
 {
-	struct stlbrd	*brdp;
+	struct stlbrd *brdp;
+	unsigned int brdtype = ent->driver_data;
 
 	pr_debug("stl_initpcibrd(brdtype=%d,busnr=%x,devnr=%x)\n", brdtype,
-		devp->bus->number, devp->devfn);
+		pdev->bus->number, pdev->devfn);
+
+	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE)
+		return -ENODEV;
+
+	dev_info(&pdev->dev, "please, report this to LKML: %x/%x/%x\n",
+			pdev->vendor, pdev->device, pdev->class);
 
-	if (pci_enable_device(devp))
+	if (pci_enable_device(pdev))
 		return(-EIO);
 	if ((brdp = stl_allocbrd()) == NULL)
 		return(-ENOMEM);
@@ -2425,8 +2448,8 @@ static int __init stl_initpcibrd(int brd
  *	so set up io addresses based on board type.
  */
 	pr_debug("%s(%d): BAR[]=%Lx,%Lx,%Lx,%Lx IRQ=%x\n", __FILE__, __LINE__,
-		pci_resource_start(devp, 0), pci_resource_start(devp, 1),
-		pci_resource_start(devp, 2), pci_resource_start(devp, 3), devp->irq);
+		pci_resource_start(pdev, 0), pci_resource_start(pdev, 1),
+		pci_resource_start(pdev, 2), pci_resource_start(pdev, 3), pdev->irq);
 
 /*
  *	We have all resources from the board, so let's setup the actual
@@ -2434,63 +2457,52 @@ static int __init stl_initpcibrd(int brd
  */
 	switch (brdtype) {
 	case BRD_ECHPCI:
-		brdp->ioaddr2 = pci_resource_start(devp, 0);
-		brdp->ioaddr1 = pci_resource_start(devp, 1);
+		brdp->ioaddr2 = pci_resource_start(pdev, 0);
+		brdp->ioaddr1 = pci_resource_start(pdev, 1);
 		break;
 	case BRD_ECH64PCI:
-		brdp->ioaddr2 = pci_resource_start(devp, 2);
-		brdp->ioaddr1 = pci_resource_start(devp, 1);
+		brdp->ioaddr2 = pci_resource_start(pdev, 2);
+		brdp->ioaddr1 = pci_resource_start(pdev, 1);
 		break;
 	case BRD_EASYIOPCI:
-		brdp->ioaddr1 = pci_resource_start(devp, 2);
-		brdp->ioaddr2 = pci_resource_start(devp, 1);
+		brdp->ioaddr1 = pci_resource_start(pdev, 2);
+		brdp->ioaddr2 = pci_resource_start(pdev, 1);
 		break;
 	default:
 		printk("STALLION: unknown PCI board type=%d\n", brdtype);
 		break;
 	}
 
-	brdp->irq = devp->irq;
+	brdp->irq = pdev->irq;
 	stl_brdinit(brdp);
 
+	pci_set_drvdata(pdev, brdp);
+
 	return(0);
 }
 
-/*****************************************************************************/
-
-/*
- *	Find all Stallion PCI boards that might be installed. Initialize each
- *	one as it is found.
- */
-
-
-static int __init stl_findpcibrds(void)
+static void __devexit stl_pciremove(struct pci_dev *pdev)
 {
-	struct pci_dev	*dev = NULL;
-	int		i, rc;
-
-	pr_debug("stl_findpcibrds()\n");
+	struct stlbrd *brdp = pci_get_drvdata(pdev);
 
-	for (i = 0; (i < stl_nrpcibrds); i++)
-		while ((dev = pci_get_device(stl_pcibrds[i].vendid,
-		    stl_pcibrds[i].devid, dev))) {
+	free_irq(brdp->irq, brdp);
 
-/*
- *			Found a device on the PCI bus that has our vendor and
- *			device ID. Need to check now that it is really us.
- */
-			if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE)
-				continue;
+	stl_cleanup_panels(brdp);
 
-			rc = stl_initpcibrd(stl_pcibrds[i].brdtype, dev);
-			if (rc)
-				return(rc);
-		}
+	release_region(brdp->ioaddr1, brdp->iosize1);
+	if (brdp->iosize2 > 0)
+		release_region(brdp->ioaddr2, brdp->iosize2);
 
-	return(0);
+	stl_brds[brdp->brdnr] = NULL;
+	kfree(brdp);
 }
 
-#endif
+static struct pci_driver stl_pcidriver = {
+	.name = "stallion",
+	.id_table = stl_pcibrds,
+	.probe = stl_pciprobe,
+	.remove = __devexit_p(stl_pciremove)
+};
 
 /*****************************************************************************/
 
@@ -2537,9 +2549,6 @@ static int __init stl_initbrds(void)
  *	line options or auto-detected on the PCI bus.
  */
 	stl_argbrds();
-#ifdef CONFIG_PCI
-	stl_findpcibrds();
-#endif
 
 	return(0);
 }
@@ -4778,7 +4787,7 @@ static void stl_sc26198otherisr(struct s
  */
 static int __init stallion_module_init(void)
 {
-	unsigned int i;
+	unsigned int i, retval;
 
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
 
@@ -4787,6 +4796,10 @@ static int __init stallion_module_init(v
 
 	stl_initbrds();
 
+	retval = pci_register_driver(&stl_pcidriver);
+	if (retval)
+		goto err;
+
 	stl_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
 	if (!stl_serial)
 		return -1;
@@ -4822,14 +4835,14 @@ static int __init stallion_module_init(v
 	}
 
 	return 0;
+err:
+	return retval;
 }
 
 static void __exit stallion_module_exit(void)
 {
 	struct stlbrd	*brdp;
-	struct stlpanel	*panelp;
-	struct stlport	*portp;
-	int		i, j, k;
+	int		i;
 
 	pr_debug("cleanup_module()\n");
 
@@ -4856,27 +4869,15 @@ static void __exit stallion_module_exit(
 			"errno=%d\n", -i);
 	class_destroy(stallion_class);
 
+	pci_unregister_driver(&stl_pcidriver);
+
 	for (i = 0; (i < stl_nrbrds); i++) {
 		if ((brdp = stl_brds[i]) == NULL)
 			continue;
 
 		free_irq(brdp->irq, brdp);
 
-		for (j = 0; (j < STL_MAXPANELS); j++) {
-			panelp = brdp->panels[j];
-			if (panelp == NULL)
-				continue;
-			for (k = 0; (k < STL_PORTSPERPANEL); k++) {
-				portp = panelp->ports[k];
-				if (portp == NULL)
-					continue;
-				if (portp->tty != NULL)
-					stl_hangup(portp->tty);
-				kfree(portp->tx.buf);
-				kfree(portp);
-			}
-			kfree(panelp);
-		}
+		stl_cleanup_panels(brdp);
 
 		release_region(brdp->ioaddr1, brdp->iosize1);
 		if (brdp->iosize2 > 0)
