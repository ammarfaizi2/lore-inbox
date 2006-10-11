Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161479AbWJKVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161479AbWJKVOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbWJKVOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:14:14 -0400
Received: from av2.karneval.cz ([81.27.192.122]:54307 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1161481AbWJKVOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:14:05 -0400
Message-id: <32432w23423423@karneval.cz>
Subject: [PATCH 3/4] Char: mxser_new, pci probing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Date: Wed, 11 Oct 2006 23:14:00 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, pci probing

Finally, the intention of the patch serie: PCI probing for this driver.
add pci_driver structure, (un)register it and add some stuff, which this
needs. Remove pdev pointer from board structure, because it's no longer
needed.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f745e78bdca36ec5e27de25694a4417a45ffb5de
tree 5d5e7d4c5d7aff1e111582c4f2d4812f5c2c1cb7
parent 5c3719e8b660b2813c8db5bec5a963d2702ad4fc
author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 22:46:41 +0200
committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 22:46:41 +0200

 drivers/char/mxser_new.c |  175 +++++++++++++++++++++++-----------------------
 1 files changed, 88 insertions(+), 87 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 8026047..8c62f80 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -283,8 +283,7 @@ struct mxser_port {
 };
 
 struct mxser_board {
-	struct pci_dev *pdev; /* temporary (until pci probing) */
-
+	unsigned int idx;
 	int irq;
 	const struct mxser_cardinfo *info;
 	unsigned long vector;
@@ -2383,10 +2382,9 @@ static const struct tty_operations mxser
  * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
 
-static void mxser_release_res(struct mxser_board *brd, unsigned int irq)
+static void mxser_release_res(struct mxser_board *brd, struct pci_dev *pdev,
+		unsigned int irq)
 {
-	struct pci_dev *pdev = brd->pdev;
-
 	if (irq)
 		free_irq(brd->irq, brd);
 	if (pdev != NULL) {	/* PCI */
@@ -2399,7 +2397,8 @@ static void mxser_release_res(struct mxs
 	}
 }
 
-static int __devinit mxser_initbrd(struct mxser_board *brd)
+static int __devinit mxser_initbrd(struct mxser_board *brd,
+		struct pci_dev *pdev)
 {
 	struct mxser_port *info;
 	unsigned int i;
@@ -2450,7 +2449,7 @@ static int __devinit mxser_initbrd(struc
 			"conflict with another device.\n",
 			brd->info->name, brd->irq);
 		/* We hold resources, we need to release them. */
-		mxser_release_res(brd, 0);
+		mxser_release_res(brd, pdev, 0);
 		return retval;
 	}
 	return 0;
@@ -2552,20 +2551,43 @@ static int __init mxser_get_ISA_conf(int
 	return brd->info->nports;
 }
 
-static int __init mxser_get_PCI_conf(const struct pci_device_id *ent,
-		struct mxser_board *brd, struct pci_dev *pdev)
+static int __devinit mxser_probe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
 {
+	struct mxser_board *brd;
 	unsigned int i, j;
 	unsigned long ioaddress;
-	int retval;
+	int retval = -EINVAL;
+
+	for (i = 0; i < MXSER_BOARDS; i++)
+		if (mxser_boards[i].info == NULL)
+			break;
+
+	if (i >= MXSER_BOARDS) {
+		printk(KERN_ERR "Too many Smartio/Industio family boards found "
+			"(maximum %d), board not configured\n", MXSER_BOARDS);
+		goto err;
+	}
+
+	brd = &mxser_boards[i];
+	brd->idx = i * MXSER_PORTS_PER_BOARD;
+	printk(KERN_INFO "Found MOXA %s board (BusNo=%d, DevNo=%d)\n",
+		mxser_cards[ent->driver_data].name,
+		pdev->bus->number, PCI_SLOT(pdev->devfn));
+
+	retval = pci_enable_device(pdev);
+	if (retval) {
+		printk(KERN_ERR "Moxa SmartI/O PCI enable fail !\n");
+		goto err;
+	}
 
 	/* io address */
-	brd->info = &mxser_cards[ent->driver_data];
 	ioaddress = pci_resource_start(pdev, 2);
 	retval = pci_request_region(pdev, 2, "mxser(IO)");
 	if (retval)
 		goto err;
 
+	brd->info = &mxser_cards[ent->driver_data];
 	for (i = 0; i < brd->info->nports; i++)
 		brd->ports[i].ioaddr = ioaddress + 8 * i;
 
@@ -2612,20 +2634,50 @@ static int __init mxser_get_PCI_conf(con
 		brd->vector_mask |= (1 << i);
 		brd->ports[i].baud_base = 921600;
 	}
+
+	/* mxser_initbrd will hook ISR. */
+	if (mxser_initbrd(brd, pdev) < 0)
+		goto err_relvec;
+
+	for (i = 0; i < brd->info->nports; i++)
+		tty_register_device(mxvar_sdriver, brd->idx + i, &pdev->dev);
+
+	pci_set_drvdata(pdev, brd);
+
 	return 0;
+err_relvec:
+	pci_release_region(pdev, 3);
 err_relio:
 	pci_release_region(pdev, 2);
+	brd->info = NULL;
 err:
 	return retval;
 }
 
+static void __devexit mxser_remove(struct pci_dev *pdev)
+{
+	struct mxser_board *brd = pci_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < brd->info->nports; i++)
+		tty_unregister_device(mxvar_sdriver, brd->idx + i);
+
+	mxser_release_res(brd, pdev, 1);
+}
+
+static struct pci_driver mxser_driver = {
+	.name = "mxser",
+	.id_table = mxser_pcibrds,
+	.probe = mxser_probe,
+	.remove = __devexit_p(mxser_remove)
+};
+
 static int __init mxser_module_init(void)
 {
-	struct pci_dev *pdev = NULL;
 	struct mxser_board *brd;
 	unsigned long cap;
 	unsigned int i, m, isaloop;
-	int retval, b, n;
+	int retval, b;
 
 	pr_debug("Loading module mxser ...\n");
 
@@ -2696,87 +2748,31 @@ static int __init mxser_module_init(void
 					printk(KERN_ERR "Invalid I/O address, "
 						"board not configured\n");
 
+				brd->info = NULL;
 				continue;
 			}
 
-			brd->pdev = NULL;
-
 			/* mxser_initbrd will hook ISR. */
-			if (mxser_initbrd(brd) < 0)
-				continue;
-
-			for (i = 0; i < brd->info->nports; i++)
-				tty_register_device(mxvar_sdriver,
-					m * MXSER_PORTS_PER_BOARD + i, NULL);
-
-			m++;
-		}
-
-	/* start finding PCI board here */
-	n = ARRAY_SIZE(mxser_pcibrds) - 1;
-	b = 0;
-	while (b < n) {
-		pdev = pci_get_device(mxser_pcibrds[b].vendor,
-				mxser_pcibrds[b].device, pdev);
-		if (pdev == NULL) {
-			b++;
-			continue;
-		}
-		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
-			mxser_cards[mxser_pcibrds[b].driver_data].name,
-			pdev->bus->number, PCI_SLOT(pdev->devfn));
-		if (m >= MXSER_BOARDS)
-			printk(KERN_ERR
-				"Too many Smartio/Industio family boards find "
-				"(maximum %d), board not configured\n",
-				MXSER_BOARDS);
-		else {
-			if (pci_enable_device(pdev)) {
-				printk(KERN_ERR "Moxa SmartI/O PCI enable "
-					"fail !\n");
-				continue;
-			}
-			brd = &mxser_boards[m];
-			brd->pdev = pdev;
-			retval = mxser_get_PCI_conf(&mxser_pcibrds[b],
-					brd, pdev);
-			if (retval < 0) {
-				if (retval == MXSER_ERR_IRQ)
-					printk(KERN_ERR
-						"Invalid interrupt number, "
-						"board not configured\n");
-				else if (retval == MXSER_ERR_IRQ_CONFLIT)
-					printk(KERN_ERR
-						"Invalid interrupt number, "
-						"board not configured\n");
-				else if (retval == MXSER_ERR_VECTOR)
-					printk(KERN_ERR
-						"Invalid interrupt vector, "
-						"board not configured\n");
-				else if (retval == MXSER_ERR_IOADDR)
-					printk(KERN_ERR
-						"Invalid I/O address, "
-						"board not configured\n");
+			if (mxser_initbrd(brd, NULL) < 0) {
+				brd->info = NULL;
 				continue;
 			}
-			/* mxser_initbrd will hook ISR. */
-			if (mxser_initbrd(brd) < 0)
-				continue;
+
+			brd->idx = m * MXSER_PORTS_PER_BOARD;
 			for (i = 0; i < brd->info->nports; i++)
-				tty_register_device(mxvar_sdriver,
-					m * MXSER_PORTS_PER_BOARD + i,
-					&pdev->dev);
+				tty_register_device(mxvar_sdriver, brd->idx + i,
+						NULL);
 
 			m++;
-			/* Keep an extra reference if we succeeded. It will
-			   be returned at unload time */
-			pci_dev_get(pdev);
 		}
-	}
 
-	if (!m) {
-		retval = -ENODEV;
-		goto err_unr;
+	retval = pci_register_driver(&mxser_driver);
+	if (retval) {
+		printk(KERN_ERR "Can't register pci driver\n");
+		if (!m) {
+			retval = -ENODEV;
+			goto err_unr;
+		} /* else: we have some ISA cards under control */
 	}
 
 	pr_debug("Done.\n");
@@ -2791,18 +2787,23 @@ err_put:
 
 static void __exit mxser_module_exit(void)
 {
-	unsigned int i;
+	unsigned int i, j;
 
 	pr_debug("Unloading module mxser ...\n");
 
-	for (i = 0; i < MXSER_PORTS; i++)
-		tty_unregister_device(mxvar_sdriver, i);
+	pci_unregister_driver(&mxser_driver);
+
+	for (i = 0; i < MXSER_BOARDS; i++) /* ISA remains */
+		if (mxser_boards[i].info != NULL)
+			for (j = 0; j < mxser_boards[i].info->nports; j++)
+				tty_unregister_device(mxvar_sdriver,
+						mxser_boards[i].idx + j);
 	tty_unregister_driver(mxvar_sdriver);
 	put_tty_driver(mxvar_sdriver);
 
 	for (i = 0; i < MXSER_BOARDS; i++)
 		if (mxser_boards[i].info != NULL)
-			mxser_release_res(&mxser_boards[i], 1);
+			mxser_release_res(&mxser_boards[i], NULL, 1);
 
 	pr_debug("Done.\n");
 }
