Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUILX04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUILX04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUILX04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:26:56 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:40662 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263818AbUILX0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:26:52 -0400
Date: Mon, 13 Sep 2004 01:26:04 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hans-Frieder Vogt <hfvogt@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Message-ID: <20040912232604.GC27282@electric-eye.fr.zoreil.com>
References: <200409130035.50823.hfvogt@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <200409130035.50823.hfvogt@arcor.de>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hans-Frieder Vogt <hfvogt@arcor.de> :
[2.6.9-rc1-bk11 r8169 freeze on amd64]
> Until somebody comes up with a proper solution for this problem, I suggest as 
> a work-around to introduce a parameter so that the DAC can be simply 
> unselected if necessary, as outlined in the patch below.
> 
> Thanks for any suggestions as to what the problem might be.

Remove the workaround, apply the attached patch and watch the oops.

If it happens in rtl8169_rx_interrupt(), you may notice that R12 is set to 0xbfc.
R12 is pkt_len in rtl8169_rx_interrupt. This value is twice too high. I have not
figured why so far and I'll go to bed.

Please Cc: netdev and jgarzik@pobox.com on followup.

--
Ueimor

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-dbg-b.patch"

--- linux-2.6.9-rc1-bk17.orig/drivers/net/r8169.c	2004-09-10 21:57:57.000000000 +0200
+++ linux-2.6.9-rc1-bk17/drivers/net/r8169.c	2004-09-11 14:06:33.000000000 +0200
@@ -984,9 +984,10 @@ rtl8169_init_board(struct pci_dev *pdev,
 	tp->cp_cmd = PCIMulRW | RxChkSum;
 
 	if ((sizeof(dma_addr_t) > 4) &&
-	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK))
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		tp->cp_cmd |= PCIDAC;
-	else {
+		dev->features |= NETIF_F_HIGHDMA;
+	} else {
 		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc < 0) {
 			printk(KERN_ERR PFX "DMA configuration failed.\n");
@@ -1308,7 +1309,7 @@ rtl8169_hw_start(struct net_device *dev)
 	RTL_W8(EarlyTxThres, EarlyTxThld);
 
 	// For gigabit rtl8169
-	RTL_W16(RxMaxSize, RxPacketMaxSize);
+	RTL_W16(RxMaxSize, RX_BUF_SIZE);
 
 	// Set Rx Config register
 	i = rtl8169_rx_config |
@@ -1681,7 +1682,7 @@ rtl8169_rx_interrupt(struct net_device *
 		} else {
 			struct RxDesc *desc = tp->RxDescArray + entry;
 			struct sk_buff *skb = tp->Rx_skbuff[entry];
-			int pkt_size = (status & 0x00001FFF) - 4;
+			int pkt_size = (status & 0x00003FFF) - 4;
 			void (*pci_action)(struct pci_dev *, dma_addr_t,
 				size_t, int) = pci_dma_sync_single_for_device;
 
@@ -1698,6 +1699,7 @@ rtl8169_rx_interrupt(struct net_device *
 			pci_action(tp->pci_dev, le64_to_cpu(desc->addr),
 				   RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
 
+			BUG_ON(pkt_size > (RX_BUF_SIZE - 4));
 			skb_put(skb, pkt_size);
 			skb->protocol = eth_type_trans(skb, dev);
 			rtl8169_rx_skb(skb);

--4Ckj6UjgE2iN1+kY--
