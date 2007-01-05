Return-Path: <linux-kernel-owner+w=401wt.eu-S1161168AbXAERMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbXAERMK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbXAERMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:12:08 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:51025 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161168AbXAERMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:12:02 -0500
Message-id: <17884197232932515771@wsc.cz>
In-reply-to: <16079316021425814645@wsc.cz>
Subject: [PATCH 7/7] Char: moxa, pci probing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jan 2007 18:12:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, pci probing

Alter the driver to use the pci probing.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 4ee85fa4bf20967f94b61219c39189a8ae3c511c
tree c09d6cfa7b38541e2fa39f882fca88bee20e917c
parent cd7aa5e22313e6a0f2ec6a02960793fc54c26416
author Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 18:08:08 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 18:08:08 +0059

 drivers/char/moxa.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 9b7067b..7dbaee8 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -107,7 +107,6 @@ static struct moxa_board_conf {
 	int numPorts;
 	unsigned long baseAddr;
 	int busType;
-	struct pci_dev *pdev;
 
 	int loadstat;
 
@@ -319,8 +318,7 @@ static int __devinit moxa_pci_probe(struct pci_dev *pdev,
 		break;
 	}
 	board->busType = MOXA_BUS_TYPE_PCI;
-	/* don't lose the reference in the next pci_get_device iteration */
-	board->pdev = pci_dev_get(pdev);
+
 	pci_set_drvdata(pdev, board);
 
 	return (0);
@@ -334,13 +332,19 @@ static void __devexit moxa_pci_remove(struct pci_dev *pdev)
 
 	pci_iounmap(pdev, brd->basemem);
 	brd->basemem = NULL;
-	pci_dev_put(pdev);
 }
+
+static struct pci_driver moxa_pci_driver = {
+	.name = "moxa",
+	.id_table = moxa_pcibrds,
+	.probe = moxa_pci_probe,
+	.remove = __devexit_p(moxa_pci_remove)
+};
 #endif /* CONFIG_PCI */
 
 static int __init moxa_init(void)
 {
-	int i, numBoards;
+	int i, numBoards, retval = 0;
 	struct moxa_port *ch;
 
 	printk(KERN_INFO "MOXA Intellio family driver version %s\n", MOXA_VERSION);
@@ -430,25 +434,22 @@ static int __init moxa_init(void)
 		}
 	}
 #endif
-	/* Find PCI boards here */
+
 #ifdef CONFIG_PCI
-	{
-		struct pci_dev *p = NULL;
-		int n = ARRAY_SIZE(moxa_pcibrds) - 1;
-		i = 0;
-		while (i < n) {
-			while ((p = pci_get_device(moxa_pcibrds[i].vendor, moxa_pcibrds[i].device, p))!=NULL)
-				moxa_pci_probe(p, &moxa_pcibrds[i]);
-			i++;
-		}
+	retval = pci_register_driver(&moxa_pci_driver);
+	if (retval) {
+		printk(KERN_ERR "Can't register moxa pci driver!\n");
+		if (numBoards)
+			retval = 0;
 	}
 #endif
+
 	for (i = 0; i < numBoards; i++) {
 		moxa_boards[i].basemem = ioremap(moxa_boards[i].baseAddr,
 				0x4000);
 	}
 
-	return (0);
+	return retval;
 }
 
 static void __exit moxa_exit(void)
@@ -467,14 +468,13 @@ static void __exit moxa_exit(void)
 		printk("Couldn't unregister MOXA Intellio family serial driver\n");
 	put_tty_driver(moxaDriver);
 
-	for (i = 0; i < MAX_BOARDS; i++) {
 #ifdef CONFIG_PCI
-		if (moxa_boards[i].busType == MOXA_BUS_TYPE_PCI)
-			moxa_pci_remove(moxa_boards[i].pdev);
+	pci_unregister_driver(&moxa_pci_driver);
 #endif
+
+	for (i = 0; i < MAX_BOARDS; i++)
 		if (moxa_boards[i].basemem)
 			iounmap(moxa_boards[i].basemem);
-	}
 
 	if (verbose)
 		printk("Done\n");
