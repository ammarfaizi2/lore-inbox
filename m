Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVB1NuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVB1NuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVB1Nsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:48:32 -0500
Received: from lumumba.luc.ac.be ([193.190.9.252]:17678 "EHLO
	lumumba.luc.ac.be") by vger.kernel.org with ESMTP id S261601AbVB1Nnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:43:33 -0500
Date: Mon, 28 Feb 2005 14:43:33 +0100
From: Panagiotis Issaris <takis@lumumba.luc.ac.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Possible ENI155P issues
Message-ID: <20050228144333.A32550@lumumba.luc.ac.be>
Reply-To: panagiotis.issaris@mech.kuleuven.ac.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the ENI155P device driver in six possible failure cases the requested
irq is not being released.

In three of the above possible failure cases additionally there seems to
be a memory leak.

The patch applies to 2.6.11-rc5-bk2.

diff -uprN linux-2.6.11-rc5-bk2/drivers/atm/eni.c linux-2.6.11-rc5-bk2-pi/drivers/atm/eni.c
--- linux-2.6.11-rc5-bk2/drivers/atm/eni.c	2005-02-28 13:31:21.000000000 +0100
+++ linux-2.6.11-rc5-bk2-pi/drivers/atm/eni.c	2005-02-28 14:16:13.000000000 +0100
@@ -59,7 +59,6 @@
  * - doesn't support OAM cells
  * - eni_put_free may hang if not putting memory fragments that _complete_
  *   2^n block (never happens in real life, though)
- * - keeps IRQ even if initialization fails
  */
 
 
@@ -1802,22 +1801,22 @@ static int __devinit eni_start(struct at
 	if (request_irq(eni_dev->irq,&eni_int,SA_SHIRQ,DEV_LABEL,dev)) {
 		printk(KERN_ERR DEV_LABEL "(itf %d): IRQ%d is already in use\n",
 		    dev->number,eni_dev->irq);
-		return -EAGAIN;
+		error = -EAGAIN;
+		goto out;
 	}
-	/* @@@ should release IRQ on error */
 	pci_set_master(eni_dev->pci_dev);
 	if ((error = pci_write_config_word(eni_dev->pci_dev,PCI_COMMAND,
 	    PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
 	    (eni_dev->asic ? PCI_COMMAND_PARITY | PCI_COMMAND_SERR : 0)))) {
 		printk(KERN_ERR DEV_LABEL "(itf %d): can't enable memory+"
 		    "master (0x%02x)\n",dev->number,error);
-		return error;
+		goto free_irq;
 	}
 	if ((error = pci_write_config_byte(eni_dev->pci_dev,PCI_TONGA_CTRL,
 	    END_SWAP_DMA))) {
 		printk(KERN_ERR DEV_LABEL "(itf %d): can't set endian swap "
 		    "(0x%02x)\n",dev->number,error);
-		return error;
+		goto free_irq;
 	}
 	/* determine addresses of internal tables */
 	eni_dev->vci = eni_dev->ram;
@@ -1839,7 +1838,8 @@ static int __devinit eni_start(struct at
 	if (!eni_dev->free_list) {
 		printk(KERN_ERR DEV_LABEL "(itf %d): couldn't get free page\n",
 		    dev->number);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto free_irq;
 	}
 	eni_dev->free_len = 0;
 	eni_put_free(eni_dev,buf,buffer_mem);
@@ -1855,17 +1855,26 @@ static int __devinit eni_start(struct at
 	 */
 	eni_out(0xffffffff,MID_IE);
 	error = start_tx(dev);
-	if (error) return error;
+	if (error) goto free_list;
 	error = start_rx(dev);
-	if (error) return error;
+	if (error) goto free_list;
 	error = dev->phy->start(dev);
-	if (error) return error;
+	if (error) goto free_list;
 	eni_out(eni_in(MID_MC_S) | (1 << MID_INT_SEL_SHIFT) |
 	    MID_TX_LOCK_MODE | MID_DMA_ENABLE | MID_TX_ENABLE | MID_RX_ENABLE,
 	    MID_MC_S);
 	    /* Tonga uses SBus INTReq1 */
 	(void) eni_in(MID_ISA); /* clear Midway interrupts */
 	return 0;
+
+free_list:
+	kfree(eni_dev->free_list);
+	
+free_irq:
+	free_irq(eni_dev->irq, eni_dev);
+	
+out:
+	return error;
 }
 
 
 
With friendly regards,
Takis
-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
