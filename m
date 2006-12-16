Return-Path: <linux-kernel-owner+w=401wt.eu-S1030537AbWLPBdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbWLPBdW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWLPBc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:32:58 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:38870 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030537AbWLPBcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:32:54 -0500
Message-id: <29302220751300732488@wsc.cz>
In-reply-to: <2880031291415520798@wsc.cz>
Subject: [PATCH 2/5] Char: isicom, fix probe race
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 16 Dec 2006 02:09:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, fix probe race

Fix two race conditions in the probe function with mutex.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e7087b32ad4b5ee1240fa7f9ba46a9b4566fe424
tree 28bc5ad2a47c03e1b7a09fce22afbe7000955e97
parent f2d37e8d3de070f8cda48a454f7b991d29b310be
author Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 21:08:11 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 21:08:11 +0059

 drivers/char/isicom.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 836e967..5d2c345 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1732,22 +1732,25 @@ end:
 /*
  *	Insmod can set static symbols so keep these static
  */
-static int card;
+static unsigned int card_count;
 
 static int __devinit isicom_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
+	static DEFINE_MUTEX(probe_lock);
 	unsigned int ioaddr, signature, index;
 	int retval = -EPERM;
-	u8 pciirq;
 	struct isi_board *board = NULL;
 
-	if (card >= BOARD_COUNT)
+	mutex_lock(&probe_lock);
+	if (card_count >= BOARD_COUNT) {
+		mutex_unlock(&probe_lock);
 		goto err;
+	}
+	card_count++;
 
 	ioaddr = pci_resource_start(pdev, 3);
 	/* i.e at offset 0x1c in the PCI configuration register space. */
-	pciirq = pdev->irq;
 	dev_info(&pdev->dev, "ISI PCI Card(Device ID 0x%x)\n", ent->device);
 
 	/* allot the first empty slot in the array */
@@ -1759,8 +1762,9 @@ static int __devinit isicom_probe(struct pci_dev *pdev,
 
 	board->index = index;
 	board->base = ioaddr;
-	board->irq = pciirq;
-	card++;
+	board->irq = pdev->irq;
+
+	mutex_unlock(&probe_lock);
 
 	pci_set_drvdata(pdev, board);
 
@@ -1770,7 +1774,7 @@ static int __devinit isicom_probe(struct pci_dev *pdev,
 			"will be disabled.\n", board->base, board->base + 15,
 			index + 1);
 		retval = -EBUSY;
-		goto err;
+		goto err_dec;
  	}
 
 	retval = request_irq(board->irq, isicom_interrupt,
@@ -1799,8 +1803,10 @@ errunri:
 	free_irq(board->irq, board);
 errunrr:
 	pci_release_region(pdev, 3);
-err:
+err_dec:
+	card_count--;
 	board->base = 0;
+err:
 	return retval;
 }
 
@@ -1814,6 +1820,8 @@ static void __devexit isicom_remove(struct pci_dev *pdev)
 
 	free_irq(board->irq, board);
 	pci_release_region(pdev, 3);
+	card_count--;
+	board->base = 0;
 }
 
 static int __init isicom_init(void)
@@ -1821,8 +1829,6 @@ static int __init isicom_init(void)
 	int retval, idx, channel;
 	struct isi_port *port;
 
-	card = 0;
-
 	for(idx = 0; idx < BOARD_COUNT; idx++) {
 		port = &isi_ports[idx * 16];
 		isi_card[idx].ports = port;
