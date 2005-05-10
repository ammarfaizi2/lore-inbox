Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVEJTl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVEJTl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEJTl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:41:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:49644 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261758AbVEJTlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:41:20 -0400
Date: Tue, 10 May 2005 21:45:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Chas Williams <chas@cmf.nrl.navy.mil>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Christophe Lizzi <lizzi@cnam.fr>,
       eric kinzie <ekinzie@cmf.nrl.navy.mil>,
       Werner Almesberger <werner@almesberger.net>
Subject: [PATCH] atm: kill pointless NULL checks and casts before kfree()
Message-ID: <Pine.LNX.4.62.0505102126330.2386@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC when replying)

This patch removes redundant NULL pointer checks before kfree() as well as 
a pointless cast for drivers/atm/

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/atm/fore200e.c |    6 ++----
 drivers/atm/he.c       |    6 ++----
 drivers/atm/zatm.c     |   11 ++++-------
 3 files changed, 8 insertions(+), 15 deletions(-)

diff -upr linux-2.6.12-rc3-mm3-orig/drivers/atm/fore200e.c linux-2.6.12-rc3-mm3/drivers/atm/fore200e.c
--- linux-2.6.12-rc3-mm3-orig/drivers/atm/fore200e.c	2005-05-06 23:21:07.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/atm/fore200e.c	2005-05-10 21:19:30.000000000 +0200
@@ -383,8 +383,7 @@ fore200e_shutdown(struct fore200e* fore2
     switch(fore200e->state) {
 
     case FORE200E_STATE_COMPLETE:
-	if (fore200e->stats)
-	    kfree(fore200e->stats);
+	kfree(fore200e->stats);
 
     case FORE200E_STATE_IRQ:
 	free_irq(fore200e->irq, fore200e->atm_dev);
@@ -963,8 +962,7 @@ fore200e_tx_irq(struct fore200e* fore200
 		entry, txq->tail, entry->vc_map, entry->skb);
 
 	/* free copy of misaligned data */
-	if (entry->data)
-	    kfree(entry->data);
+	kfree(entry->data);
 	
 	/* remove DMA mapping */
 	fore200e->bus->dma_unmap(fore200e, entry->tpd->tsd[ 0 ].buffer, entry->tpd->tsd[ 0 ].length,
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/atm/he.c linux-2.6.12-rc3-mm3/drivers/atm/he.c
--- linux-2.6.12-rc3-mm3-orig/drivers/atm/he.c	2005-05-06 23:21:07.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/atm/he.c	2005-05-10 21:19:59.000000000 +0200
@@ -412,8 +412,7 @@ he_init_one(struct pci_dev *pci_dev, con
 init_one_failure:
 	if (atm_dev)
 		atm_dev_deregister(atm_dev);
-	if (he_dev)
-		kfree(he_dev);
+	kfree(he_dev);
 	pci_disable_device(pci_dev);
 	return err;
 }
@@ -2534,8 +2533,7 @@ he_open(struct atm_vcc *vcc)
 open_failed:
 
 	if (err) {
-		if (he_vcc)
-			kfree(he_vcc);
+		kfree(he_vcc);
 		clear_bit(ATM_VF_ADDR, &vcc->flags);
 	}
 	else
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/atm/zatm.c linux-2.6.12-rc3-mm3/drivers/atm/zatm.c
--- linux-2.6.12-rc3-mm3-orig/drivers/atm/zatm.c	2005-04-30 18:24:53.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/atm/zatm.c	2005-05-10 21:24:54.000000000 +0200
@@ -902,7 +902,7 @@ static void close_tx(struct atm_vcc *vcc
 		zatm_dev->tx_bw += vcc->qos.txtp.min_pcr;
 		dealloc_shaper(vcc->dev,zatm_vcc->shaper);
 	}
-	if (zatm_vcc->ring) kfree(zatm_vcc->ring);
+	kfree(zatm_vcc->ring);
 }
 
 
@@ -1339,12 +1339,9 @@ static int __init zatm_start(struct atm_
 	return 0;
     out:
 	for (i = 0; i < NR_MBX; i++)
-		if (zatm_dev->mbx_start[i] != 0)
-			kfree((void *) zatm_dev->mbx_start[i]);
-	if (zatm_dev->rx_map != NULL)
-		kfree(zatm_dev->rx_map);
-	if (zatm_dev->tx_map != NULL)
-		kfree(zatm_dev->tx_map);
+		kfree(zatm_dev->mbx_start[i]);
+	kfree(zatm_dev->rx_map);
+	kfree(zatm_dev->tx_map);
 	free_irq(zatm_dev->irq, dev);
 	return error;
 }



