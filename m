Return-Path: <linux-kernel-owner+w=401wt.eu-S1161167AbXAERM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbXAERM7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbXAERMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:12:10 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:51022 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161154AbXAERLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:11:52 -0500
Message-id: <16195189622607828668@wsc.cz>
In-reply-to: <16079316021425814645@wsc.cz>
Subject: [PATCH 6/7] Char: moxa, pci_probing prepare
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jan 2007 18:12:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, pci_probing prepare

- change pci conf prototype and rename it to moxa_pci_probe
- move some code to moxa_pci_probe
- create moxa_pci_remove

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit cd7aa5e22313e6a0f2ec6a02960793fc54c26416
tree 8ff42a1436ecfa86ef0297f7d68317a0b8a454d3
parent d35a569e31595b9b8f70bfd1d3aae7f830d183fe
author Jiri Slaby <jirislaby@gmail.com> Wed, 03 Jan 2007 15:04:59 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 17:55:22 +0059

 drivers/char/moxa.c |   64 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 8849d66..9b7067b 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -275,10 +275,35 @@ static DEFINE_TIMER(moxaTimer, moxa_poll, 0, 0);
 static DEFINE_SPINLOCK(moxa_lock);
 
 #ifdef CONFIG_PCI
-static int moxa_get_PCI_conf(struct pci_dev *p, int board_type,
-		struct moxa_board_conf *board)
+static int __devinit moxa_pci_probe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
 {
-	board->baseAddr = pci_resource_start (p, 2);
+	struct moxa_board_conf *board;
+	unsigned int i;
+	int board_type = ent->driver_data;
+	int retval;
+
+	retval = pci_enable_device(pdev);
+	if (retval)
+		goto err;
+
+	for (i = 0; i < MAX_BOARDS; i++)
+		if (moxa_boards[i].basemem == NULL)
+			break;
+
+	retval = -ENODEV;
+	if (i >= MAX_BOARDS) {
+		if (verbose)
+			printk("More than %d MOXA Intellio family boards "
+				"found. Board is ignored.\n", MAX_BOARDS);
+		goto err;
+	}
+
+	board = &moxa_boards[i];
+	board->basemem = pci_iomap(pdev, 2, 0x4000);
+	if (board->basemem == NULL)
+		goto err;
+
 	board->boardType = board_type;
 	switch (board_type) {
 	case MOXA_BOARD_C218_ISA:
@@ -295,9 +320,21 @@ static int moxa_get_PCI_conf(struct pci_dev *p, int board_type,
 	}
 	board->busType = MOXA_BUS_TYPE_PCI;
 	/* don't lose the reference in the next pci_get_device iteration */
-	board->pdev = pci_dev_get(p);
+	board->pdev = pci_dev_get(pdev);
+	pci_set_drvdata(pdev, board);
 
 	return (0);
+err:
+	return retval;
+}
+
+static void __devexit moxa_pci_remove(struct pci_dev *pdev)
+{
+	struct moxa_board_conf *brd = pci_get_drvdata(pdev);
+
+	pci_iounmap(pdev, brd->basemem);
+	brd->basemem = NULL;
+	pci_dev_put(pdev);
 }
 #endif /* CONFIG_PCI */
 
@@ -401,18 +438,7 @@ static int __init moxa_init(void)
 		i = 0;
 		while (i < n) {
 			while ((p = pci_get_device(moxa_pcibrds[i].vendor, moxa_pcibrds[i].device, p))!=NULL)
-			{
-				if (pci_enable_device(p))
-					continue;
-				if (numBoards >= MAX_BOARDS) {
-					if (verbose)
-						printk("More than %d MOXA Intellio family boards found. Board is ignored.", MAX_BOARDS);
-				} else {
-					moxa_get_PCI_conf(p, moxa_pcibrds[i].driver_data,
-						&moxa_boards[numBoards]);
-					numBoards++;
-				}
-			}
+				moxa_pci_probe(p, &moxa_pcibrds[i]);
 			i++;
 		}
 	}
@@ -442,10 +468,12 @@ static void __exit moxa_exit(void)
 	put_tty_driver(moxaDriver);
 
 	for (i = 0; i < MAX_BOARDS; i++) {
+#ifdef CONFIG_PCI
+		if (moxa_boards[i].busType == MOXA_BUS_TYPE_PCI)
+			moxa_pci_remove(moxa_boards[i].pdev);
+#endif
 		if (moxa_boards[i].basemem)
 			iounmap(moxa_boards[i].basemem);
-		if (moxa_boards[i].busType == MOXA_BUS_TYPE_PCI)
-			pci_dev_put(moxa_boards[i].pdev);
 	}
 
 	if (verbose)
