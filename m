Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965660AbWKDU2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965660AbWKDU2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965663AbWKDU2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:28:16 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:21686 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965660AbWKDU2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:28:14 -0500
Message-id: <17413142092390932669@wsc.cz>
Subject: [PATCH 1/8] Char: istallion, convert to pci probing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:28:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, convert to pci probing

Use probing for pci devices. Change some __inits to __devinits to use these
functions in probe function. Create stli_cleanup_ports and move there
cleanup code from module_exit() code to not have duplicite cleanup code.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b90798585707a33d1835b752a18f1ca3b6a7da7b
tree 7c99e2bcca81b25dc3ffdcf288b5a9c35433c098
parent 7e8fb7980d776e6a7c0bd84cc48b1cb9de139b8f
author Jiri Slaby <jirislaby@gmail.com> Sun, 29 Oct 2006 23:37:48 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 18:26:39 +0059

 drivers/char/istallion.c |  116 +++++++++++++++++++++++++++-------------------
 1 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index f07716b..9e73d0d 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -402,7 +402,6 @@ static int	stli_eisamempsize = ARRAY_SIZ
 /*
  *	Define the Stallion PCI vendor and device IDs.
  */
-#ifdef CONFIG_PCI
 #ifndef	PCI_VENDOR_ID_STALLION
 #define	PCI_VENDOR_ID_STALLION		0x124d
 #endif
@@ -416,7 +415,7 @@ static struct pci_device_id istallion_pc
 };
 MODULE_DEVICE_TABLE(pci, istallion_pci_tbl);
 
-#endif /* CONFIG_PCI */
+static struct pci_driver stli_pcidriver;
 
 /*****************************************************************************/
 
@@ -728,10 +727,6 @@ static int	stli_initonb(stlibrd_t *brdp)
 static int	stli_eisamemprobe(stlibrd_t *brdp);
 static int	stli_initports(stlibrd_t *brdp);
 
-#ifdef	CONFIG_PCI
-static int	stli_initpcibrd(int brdtype, struct pci_dev *devp);
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -768,6 +763,21 @@ #define	STLI_TIMEOUT	(jiffies + 1)
 
 static struct class *istallion_class;
 
+static void stli_cleanup_ports(stlibrd_t *brdp)
+{
+	stliport_t *portp;
+	unsigned int j;
+
+	for (j = 0; j < STL_MAXPORTS; j++) {
+		portp = brdp->ports[j];
+		if (portp != NULL) {
+			if (portp->tty != NULL)
+				tty_hangup(portp->tty);
+			kfree(portp);
+		}
+	}
+}
+
 /*
  *	Loadable module initialization stuff.
  */
@@ -783,12 +793,12 @@ static int __init istallion_module_init(
 static void __exit istallion_module_exit(void)
 {
 	stlibrd_t	*brdp;
-	stliport_t	*portp;
-	int		i, j;
+	int		i;
 
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
 		stli_drvversion);
 
+	pci_unregister_driver(&stli_pcidriver);
 	/*
 	 *	Free up all allocated resources used by the ports. This includes
 	 *	memory and interrupts.
@@ -817,14 +827,8 @@ static void __exit istallion_module_exit
 	for (i = 0; (i < stli_nrbrds); i++) {
 		if ((brdp = stli_brds[i]) == NULL)
 			continue;
-		for (j = 0; (j < STL_MAXPORTS); j++) {
-			portp = brdp->ports[j];
-			if (portp != NULL) {
-				if (portp->tty != NULL)
-					tty_hangup(portp->tty);
-				kfree(portp);
-			}
-		}
+
+		stli_cleanup_ports(brdp);
 
 		iounmap(brdp->membase);
 		if (brdp->iosize > 0)
@@ -3777,7 +3781,7 @@ stli_donestartup:
  *	Probe and initialize the specified board.
  */
 
-static int __init stli_brdinit(stlibrd_t *brdp)
+static int __devinit stli_brdinit(stlibrd_t *brdp)
 {
 	stli_brds[brdp->brdnr] = brdp;
 
@@ -4019,58 +4023,72 @@ static int stli_findeisabrds(void)
 
 /*****************************************************************************/
 
-#ifdef	CONFIG_PCI
-
 /*
  *	We have a Stallion board. Allocate a board structure and
  *	initialize it. Read its IO and MEMORY resources from PCI
  *	configuration space.
  */
 
-static int stli_initpcibrd(int brdtype, struct pci_dev *devp)
+static int __devinit stli_pciprobe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
 {
 	stlibrd_t *brdp;
-
-	if (pci_enable_device(devp))
-		return -EIO;
-	if ((brdp = stli_allocbrd()) == NULL)
-		return -ENOMEM;
-	if ((brdp->brdnr = stli_getbrdnr()) < 0) {
+	int retval = -EIO;
+
+	retval = pci_enable_device(pdev);
+	if (retval)
+		goto err;
+	brdp = stli_allocbrd();
+	if (brdp == NULL) {
+		retval = -ENOMEM;
+		goto err;
+	}
+	if ((brdp->brdnr = stli_getbrdnr()) < 0) { /* TODO: locking */
 		printk(KERN_INFO "STALLION: too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
-		return 0;
+		retval = -EIO;
+		goto err_fr;
 	}
-	brdp->brdtype = brdtype;
+	brdp->brdtype = BRD_ECPPCI;
 /*
  *	We have all resources from the board, so lets setup the actual
  *	board structure now.
  */
-	brdp->iobase = pci_resource_start(devp, 3);
-	brdp->memaddr = pci_resource_start(devp, 2);
-	stli_brdinit(brdp);
+	brdp->iobase = pci_resource_start(pdev, 3);
+	brdp->memaddr = pci_resource_start(pdev, 2);
+	retval = stli_brdinit(brdp);
+	if (retval)
+		goto err_fr;
+
+	pci_set_drvdata(pdev, brdp);
 
 	return 0;
+err_fr:
+	kfree(brdp);
+err:
+	return retval;
 }
 
-/*****************************************************************************/
+static void stli_pciremove(struct pci_dev *pdev)
+{
+	stlibrd_t *brdp = pci_get_drvdata(pdev);
 
-/*
- *	Find all Stallion PCI boards that might be installed. Initialize each
- *	one as it is found.
- */
+	stli_cleanup_ports(brdp);
 
-static int stli_findpcibrds(void)
-{
-	struct pci_dev *dev = NULL;
+	iounmap(brdp->membase);
+	if (brdp->iosize > 0)
+		release_region(brdp->iobase, brdp->iosize);
 
-	while ((dev = pci_get_device(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA, dev))) {
-		stli_initpcibrd(BRD_ECPPCI, dev);
-	}
-	return 0;
+	stli_brds[brdp->brdnr] = NULL;
+	kfree(brdp);
 }
 
-#endif
-
+static struct pci_driver stli_pcidriver = {
+	.name = "istallion",
+	.id_table = istallion_pci_tbl,
+	.probe = stli_pciprobe,
+	.remove = __devexit_p(stli_pciremove)
+};
 /*****************************************************************************/
 
 /*
@@ -4102,7 +4120,7 @@ static int stli_initbrds(void)
 {
 	stlibrd_t *brdp, *nxtbrdp;
 	stlconf_t *confp;
-	int i, j;
+	int i, j, retval;
 
 	if (stli_nrbrds > STL_MAXBRDS) {
 		printk(KERN_INFO "STALLION: too many boards in configuration "
@@ -4134,9 +4152,9 @@ static int stli_initbrds(void)
 	stli_argbrds();
 	if (STLI_EISAPROBE)
 		stli_findeisabrds();
-#ifdef CONFIG_PCI
-	stli_findpcibrds();
-#endif
+
+	retval = pci_register_driver(&stli_pcidriver);
+	/* TODO: check retval and do something */
 
 /*
  *	All found boards are initialized. Now for a little optimization, if
