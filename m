Return-Path: <linux-kernel-owner+w=401wt.eu-S932431AbWLSAFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWLSAFb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWLSAFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:05:30 -0500
Received: from av3.karneval.cz ([81.27.192.17]:41013 "EHLO av3.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932430AbWLSAF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:05:29 -0500
Message-id: <192798269134416104@karneval.cz>
Subject: [PATCH 1/1] Char: isicom, correct probing/removing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Tue, 19 Dec 2006 01:04:53 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, correct probing/removing

Don't forget to decrease card_count in fail paths and in remove function.
Also null board->base in such cases to point out, that this structure is
unused and thus can be reassigned.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit ab95fdae2db7f8fded639796814079441f04a3e2
tree 07b12dfe0e0c1e79c79aac160a5ccd24e2cfa3d3
parent f2aae537dbeeed215a444f386f0cf6dd93a463fd
author Jiri Slaby <jirislaby@gmail.com> Tue, 19 Dec 2006 00:55:13 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 19 Dec 2006 00:55:13 +0100

 drivers/char/isicom.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index d99a73e..dd361ff 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1747,7 +1747,7 @@ end:
 /*
  *	Insmod can set static symbols so keep these static
  */
-static int card;
+static unsigned int card_count;
 
 static int __devinit isicom_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
@@ -1757,7 +1757,7 @@ static int __devinit isicom_probe(struct pci_dev *pdev,
 	u8 pciirq;
 	struct isi_board *board = NULL;
 
-	if (card >= BOARD_COUNT)
+	if (card_count >= BOARD_COUNT)
 		goto err;
 
 	ioaddr = pci_resource_start(pdev, 3);
@@ -1775,7 +1775,7 @@ static int __devinit isicom_probe(struct pci_dev *pdev,
 	board->index = index;
 	board->base = ioaddr;
 	board->irq = pciirq;
-	card++;
+	card_count++;
 
 	pci_set_drvdata(pdev, board);
 
@@ -1785,7 +1785,7 @@ static int __devinit isicom_probe(struct pci_dev *pdev,
 			"will be disabled.\n", board->base, board->base + 15,
 			index + 1);
 		retval = -EBUSY;
-		goto err;
+		goto errdec;
  	}
 
 	retval = request_irq(board->irq, isicom_interrupt,
@@ -1814,8 +1814,10 @@ errunri:
 	free_irq(board->irq, board);
 errunrr:
 	pci_release_region(pdev, 3);
-err:
+errdec:
 	board->base = 0;
+	card_count--;
+err:
 	return retval;
 }
 
@@ -1829,6 +1831,8 @@ static void __devexit isicom_remove(struct pci_dev *pdev)
 
 	free_irq(board->irq, board);
 	pci_release_region(pdev, 3);
+	board->base = 0;
+	card_count--;
 }
 
 static int __init isicom_init(void)
@@ -1836,8 +1840,6 @@ static int __init isicom_init(void)
 	int retval, idx, channel;
 	struct isi_port *port;
 
-	card = 0;
-
 	for(idx = 0; idx < BOARD_COUNT; idx++) {
 		port = &isi_ports[idx * 16];
 		isi_card[idx].ports = port;
