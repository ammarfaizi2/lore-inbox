Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUILWgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUILWgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUILWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:36:21 -0400
Received: from pD9E7454A.dip0.t-ipconnect.de ([217.231.69.74]:21379 "EHLO
	achilles.nass-vogt.home") by vger.kernel.org with ESMTP
	id S263626AbUILWfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:35:55 -0400
From: Hans-Frieder Vogt <hfvogt@arcor.de>
Reply-To: hfvogt@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Date: Mon, 13 Sep 2004 00:35:50 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409130035.50823.hfvogt@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.9-rc1-bk11 introduced a patch for the Realtek 8169 network chip driver, 
that leads to a freeze of my system during bootup.
My system:
Athlon 64, VIA K8T800 chipset, RTL8110S-32 (equiv. to RTL8169), running in 
64bit mode

no unusual messages are on the console prior to the freeze.

I traced the problem back to the patch which was introduced in 2.6.9-rc1-bk11 
and is also part of 2.6.9-rc1-mm3 and -mm4:
--- a/drivers/net/r8169.c       2004-07-02 11:51:44 -07:00
+++ b/drivers/net/r8169.c       2004-08-31 00:15:35 -07:00
@@ -983,7 +983,7 @@

        tp->cp_cmd = PCIMulRW | RxChkSum;

-       if ((sizeof(dma_addr_t) > 32) &&
+       if ((sizeof(dma_addr_t) > 4) &&
            !pci_set_dma_mask(pdev, DMA_64BIT_MASK))
                tp->cp_cmd |= PCIDAC;
        else {

which now, on my 64bit-system, enables DAC. For whatever reason this freezes 
my system (I do not understand why, because the r8169 seems to understand DAC 
according to the available documentation, perhaps a VIA K8T800 bug?).
Until somebody comes up with a proper solution for this problem, I suggest as 
a work-around to introduce a parameter so that the DAC can be simply 
unselected if necessary, as outlined in the patch below.

Thanks for any suggestions as to what the problem might be.
Hans-Frieder

--- linux-2.6.9-rc1-mm4.orig/drivers/net/r8169.c 2004-09-08 15:43:31.525119800 
+0200
+++ linux-2.6.9-rc1-mm4/drivers/net/r8169.c 2004-09-11 12:54:53.910456828 
+0200
@@ -167,6 +167,7 @@
 MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
 
 static int rx_copybreak = 200;
+static int use_dac = 1;
 
 enum RTL8169_registers {
  MAC0 = 0,  /* Ethernet hardware address. */
@@ -398,6 +399,8 @@
 MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(rx_copybreak, "i");
+MODULE_PARM(use_dac, "i");
+MODULE_PARM_DESC(use_dac, "Use DAC addressing for DMA transfers on 64bit 
machines");
 MODULE_LICENSE("GPL");
 
 static int rtl8169_open(struct net_device *dev);
@@ -1152,7 +1155,7 @@
 
  dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
 
- if ((sizeof(dma_addr_t) > 4) && !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+ if ((sizeof(dma_addr_t) > 4) && use_dac && !pci_set_dma_mask(pdev, 
DMA_64BIT_MASK)) {
   tp->cp_cmd |= PCIDAC;
   dev->features |= NETIF_F_HIGHDMA;
  } else {

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt (at) arcor (dot) de
