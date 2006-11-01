Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946411AbWKACMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946411AbWKACMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946421AbWKACMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:12:41 -0500
Received: from havoc.gtf.org ([69.61.125.42]:60345 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1946413AbWKACMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:12:39 -0500
Date: Tue, 31 Oct 2006 21:12:36 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061101021236.GA21522@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/Kconfig             |    6 +++---
 drivers/net/arm/ep93xx_eth.c    |   40 ++++++++++-----------------------------
 drivers/net/ehea/ehea_main.c    |   11 +++++------
 drivers/net/irda/stir4200.c     |    3 +--
 drivers/net/myri10ge/myri10ge.c |    1 -
 drivers/net/s2io.c              |   11 ++++++++++-
 drivers/net/skge.c              |    3 +--
 drivers/net/sky2.c              |    9 ++++++---
 drivers/net/tokenring/proteon.c |    9 +++++++--
 drivers/net/tokenring/skisa.c   |    9 +++++++--
 drivers/net/wan/n2.c            |    6 +++---
 net/sched/sch_netem.c           |    2 +-
 12 files changed, 54 insertions(+), 56 deletions(-)

Akinobu Mita:
      tokenring: fix module_init error handling
      n2: fix confusing error code

Brice Goglin:
      myri10ge: ServerWorks HT2000 PCI id is already defined in pci_ids.h

David Rientjes:
      net s2io: return on NULL dev_alloc_skb()

Jan-Bernd Themann:
      ehea: kzalloc GFP_ATOMIC fix

Lennert Buytenhek:
      ep93xx_eth: fix RX/TXstatus ring full handling
      ep93xx_eth: fix unlikely(x) > y test
      ep93xx_eth: don't report RX errors

Stephen Hemminger:
      sky2: not experimental
      skge, sky2, et all. gplv2 only
      sky2: netpoll on dual port cards

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e38846e..28c17d1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2112,7 +2112,7 @@ config SKGE
 
 config SKY2
 	tristate "SysKonnect Yukon2 support (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on PCI
 	select CRC32
 	---help---
 	  This driver supports Gigabit Ethernet adapters based on the
@@ -2120,8 +2120,8 @@ config SKY2
 	  Marvell 88E8021/88E8022/88E8035/88E8036/88E8038/88E8050/88E8052/
 	  88E8053/88E8055/88E8061/88E8062, SysKonnect SK-9E21D/SK-9S21
 
-	  This driver does not support the original Yukon chipset: a seperate
-	  driver, skge, is provided for Yukon-based adapters.
+	  There is companion driver for the older Marvell Yukon and
+	  Genesis based adapters: skge.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called sky2.  This is recommended.
diff --git a/drivers/net/arm/ep93xx_eth.c b/drivers/net/arm/ep93xx_eth.c
index 127561c..8ebd68e 100644
--- a/drivers/net/arm/ep93xx_eth.c
+++ b/drivers/net/arm/ep93xx_eth.c
@@ -193,12 +193,9 @@ static struct net_device_stats *ep93xx_g
 static int ep93xx_rx(struct net_device *dev, int *budget)
 {
 	struct ep93xx_priv *ep = netdev_priv(dev);
-	int tail_offset;
 	int rx_done;
 	int processed;
 
-	tail_offset = rdl(ep, REG_RXSTSQCURADD) - ep->descs_dma_addr;
-
 	rx_done = 0;
 	processed = 0;
 	while (*budget > 0) {
@@ -211,36 +208,28 @@ static int ep93xx_rx(struct net_device *
 
 		entry = ep->rx_pointer;
 		rstat = ep->descs->rstat + entry;
-		if ((void *)rstat - (void *)ep->descs == tail_offset) {
+
+		rstat0 = rstat->rstat0;
+		rstat1 = rstat->rstat1;
+		if (!(rstat0 & RSTAT0_RFP) || !(rstat1 & RSTAT1_RFP)) {
 			rx_done = 1;
 			break;
 		}
 
-		rstat0 = rstat->rstat0;
-		rstat1 = rstat->rstat1;
 		rstat->rstat0 = 0;
 		rstat->rstat1 = 0;
 
-		if (!(rstat0 & RSTAT0_RFP))
-			printk(KERN_CRIT "ep93xx_rx: buffer not done "
-					 " %.8x %.8x\n", rstat0, rstat1);
 		if (!(rstat0 & RSTAT0_EOF))
 			printk(KERN_CRIT "ep93xx_rx: not end-of-frame "
 					 " %.8x %.8x\n", rstat0, rstat1);
 		if (!(rstat0 & RSTAT0_EOB))
 			printk(KERN_CRIT "ep93xx_rx: not end-of-buffer "
 					 " %.8x %.8x\n", rstat0, rstat1);
-		if (!(rstat1 & RSTAT1_RFP))
-			printk(KERN_CRIT "ep93xx_rx: buffer1 not done "
-					 " %.8x %.8x\n", rstat0, rstat1);
 		if ((rstat1 & RSTAT1_BUFFER_INDEX) >> 16 != entry)
 			printk(KERN_CRIT "ep93xx_rx: entry mismatch "
 					 " %.8x %.8x\n", rstat0, rstat1);
 
 		if (!(rstat0 & RSTAT0_RWE)) {
-			printk(KERN_NOTICE "ep93xx_rx: receive error "
-					 " %.8x %.8x\n", rstat0, rstat1);
-
 			ep->stats.rx_errors++;
 			if (rstat0 & RSTAT0_OE)
 				ep->stats.rx_fifo_errors++;
@@ -301,13 +290,8 @@ err:
 
 static int ep93xx_have_more_rx(struct ep93xx_priv *ep)
 {
-	struct ep93xx_rstat *rstat;
-	int tail_offset;
-
-	rstat = ep->descs->rstat + ep->rx_pointer;
-	tail_offset = rdl(ep, REG_RXSTSQCURADD) - ep->descs_dma_addr;
-
-	return !((void *)rstat - (void *)ep->descs == tail_offset);
+	struct ep93xx_rstat *rstat = ep->descs->rstat + ep->rx_pointer;
+	return !!((rstat->rstat0 & RSTAT0_RFP) && (rstat->rstat1 & RSTAT1_RFP));
 }
 
 static int ep93xx_poll(struct net_device *dev, int *budget)
@@ -347,7 +331,7 @@ static int ep93xx_xmit(struct sk_buff *s
 	struct ep93xx_priv *ep = netdev_priv(dev);
 	int entry;
 
-	if (unlikely(skb->len) > MAX_PKT_SIZE) {
+	if (unlikely(skb->len > MAX_PKT_SIZE)) {
 		ep->stats.tx_dropped++;
 		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
@@ -379,10 +363,8 @@ static int ep93xx_xmit(struct sk_buff *s
 static void ep93xx_tx_complete(struct net_device *dev)
 {
 	struct ep93xx_priv *ep = netdev_priv(dev);
-	int tail_offset;
 	int wake;
 
-	tail_offset = rdl(ep, REG_TXSTSQCURADD) - ep->descs_dma_addr;
 	wake = 0;
 
 	spin_lock(&ep->tx_pending_lock);
@@ -393,15 +375,13 @@ static void ep93xx_tx_complete(struct ne
 
 		entry = ep->tx_clean_pointer;
 		tstat = ep->descs->tstat + entry;
-		if ((void *)tstat - (void *)ep->descs == tail_offset)
-			break;
 
 		tstat0 = tstat->tstat0;
+		if (!(tstat0 & TSTAT0_TXFP))
+			break;
+
 		tstat->tstat0 = 0;
 
-		if (!(tstat0 & TSTAT0_TXFP))
-			printk(KERN_CRIT "ep93xx_tx_complete: buffer not done "
-					 " %.8x\n", tstat0);
 		if (tstat0 & TSTAT0_FA)
 			printk(KERN_CRIT "ep93xx_tx_complete: frame aborted "
 					 " %.8x\n", tstat0);
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index eb7d44d..4538c99 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -586,8 +586,8 @@ int ehea_sense_port_attr(struct ehea_por
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
-	if (!cb0) {
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);   /* May be called via */
+	if (!cb0) {                                  /* ehea_neq_tasklet() */
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
 		goto out;
@@ -765,8 +765,7 @@ static void ehea_parse_eqe(struct ehea_a
 
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
-				ret = ehea_sense_port_attr(
-					port);
+				ret = ehea_sense_port_attr(port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -1502,7 +1501,7 @@ static void ehea_promiscuous(struct net_
 	if ((enable && port->promisc) || (!enable && !port->promisc))
 		return;
 
-	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);
 	if (!cb7) {
 		ehea_error("no mem for cb7");
 		goto out;
@@ -1606,7 +1605,7 @@ static void ehea_add_multicast_entry(str
 	struct ehea_mc_list *ehea_mcl_entry;
 	u64 hret;
 
-	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_KERNEL);
+	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_ATOMIC);
 	if (!ehea_mcl_entry) {
 		ehea_error("no mem for mcl_entry");
 		return;
diff --git a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
index be8a66e..3b4c478 100644
--- a/drivers/net/irda/stir4200.c
+++ b/drivers/net/irda/stir4200.c
@@ -15,8 +15,7 @@
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
-*	the Free Software Foundation; either version 2 of the License, or
-*	(at your option) any later version.
+*	the Free Software Foundation; either version 2 of the License.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index fdbb0d7..806081b 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -2416,7 +2416,6 @@ static void myri10ge_enable_ecrc(struct 
  * firmware image, and set tx.boundary to 4KB.
  */
 
-#define PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE	0x0132
 #define PCI_DEVICE_ID_INTEL_E5000_PCIE23 0x25f7
 #define PCI_DEVICE_ID_INTEL_E5000_PCIE47 0x25fa
 
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index a231ab7..33569ec 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -5985,6 +5985,11 @@ static int set_rxd_buffer_pointer(nic_t 
 			((RxD3_t*)rxdp)->Buffer1_ptr = *temp1;
 		} else {
 			*skb = dev_alloc_skb(size);
+			if (!(*skb)) {
+				DBG_PRINT(ERR_DBG, "%s: dev_alloc_skb failed\n",
+					  dev->name);
+				return -ENOMEM;
+			}
 			((RxD3_t*)rxdp)->Buffer2_ptr = *temp2 =
 				pci_map_single(sp->pdev, (*skb)->data,
 					       dev->mtu + 4,
@@ -6007,7 +6012,11 @@ static int set_rxd_buffer_pointer(nic_t 
 			((RxD3_t*)rxdp)->Buffer2_ptr = *temp2;
 		} else {
 			*skb = dev_alloc_skb(size);
-
+			if (!(*skb)) {
+				DBG_PRINT(ERR_DBG, "%s: dev_alloc_skb failed\n",
+					  dev->name);
+				return -ENOMEM;
+			}
 			((RxD3_t*)rxdp)->Buffer0_ptr = *temp0 =
 				pci_map_single(sp->pdev, ba->ba_0, BUF0_LEN,
 					       PCI_DMA_FROMDEVICE);
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index e7e4149..b294903 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -11,8 +11,7 @@
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * the Free Software Foundation; either version 2 of the License.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 95efdb5..16616f5 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -10,8 +10,7 @@
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * the Free Software Foundation; either version 2 of the License.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -3239,7 +3238,11 @@ static __devinit struct net_device *sky2
 		dev->poll = sky2_poll;
 	dev->weight = NAPI_WEIGHT;
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = sky2_netpoll;
+	/* Network console (only works on port 0)
+	 * because netpoll makes assumptions about NAPI
+	 */
+	if (port == 0)
+		dev->poll_controller = sky2_netpoll;
 #endif
 
 	sky2 = netdev_priv(dev);
diff --git a/drivers/net/tokenring/proteon.c b/drivers/net/tokenring/proteon.c
index 4f75696..cb7dbb6 100644
--- a/drivers/net/tokenring/proteon.c
+++ b/drivers/net/tokenring/proteon.c
@@ -370,6 +370,10 @@ static int __init proteon_init(void)
 		dev->dma = dma[i];
 		pdev = platform_device_register_simple("proteon",
 			i, NULL, 0);
+		if (IS_ERR(pdev)) {
+			free_netdev(dev);
+			continue;
+		}
 		err = setup_card(dev, &pdev->dev);
 		if (!err) {
 			proteon_dev[i] = pdev;
@@ -385,9 +389,10 @@ static int __init proteon_init(void)
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "proteon.c: No cards found.\n");
-		return (-ENODEV);
+		platform_driver_unregister(&proteon_driver);
+		return -ENODEV;
 	}
-	return (0);
+	return 0;
 }
 
 static void __exit proteon_cleanup(void)
diff --git a/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
index d6ba41c..33afea3 100644
--- a/drivers/net/tokenring/skisa.c
+++ b/drivers/net/tokenring/skisa.c
@@ -380,6 +380,10 @@ static int __init sk_isa_init(void)
 		dev->dma = dma[i];
 		pdev = platform_device_register_simple("skisa",
 			i, NULL, 0);
+		if (IS_ERR(pdev)) {
+			free_netdev(dev);
+			continue;
+		}
 		err = setup_card(dev, &pdev->dev);
 		if (!err) {
 			sk_isa_dev[i] = pdev;
@@ -395,9 +399,10 @@ static int __init sk_isa_init(void)
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "skisa.c: No cards found.\n");
-		return (-ENODEV);
+		platform_driver_unregister(&sk_isa_driver);
+		return -ENODEV;
 	}
-	return (0);
+	return 0;
 }
 
 static void __exit sk_isa_cleanup(void)
diff --git a/drivers/net/wan/n2.c b/drivers/net/wan/n2.c
index dcf46ad..5c322df 100644
--- a/drivers/net/wan/n2.c
+++ b/drivers/net/wan/n2.c
@@ -500,7 +500,7 @@ static int __init n2_init(void)
 #ifdef MODULE
 		printk(KERN_INFO "n2: no card initialized\n");
 #endif
-		return -ENOSYS;	/* no parameters specified, abort */
+		return -EINVAL;	/* no parameters specified, abort */
 	}
 
 	printk(KERN_INFO "%s\n", version);
@@ -538,11 +538,11 @@ #endif
 			n2_run(io, irq, ram, valid[0], valid[1]);
 
 		if (*hw == '\x0')
-			return first_card ? 0 : -ENOSYS;
+			return first_card ? 0 : -EINVAL;
 	}while(*hw++ == ':');
 
 	printk(KERN_ERR "n2: invalid hardware parameters\n");
-	return first_card ? 0 : -ENOSYS;
+	return first_card ? 0 : -EINVAL;
 }
 
 
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index ef8874b..0441876 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -4,7 +4,7 @@
  * 		This program is free software; you can redistribute it and/or
  * 		modify it under the terms of the GNU General Public License
  * 		as published by the Free Software Foundation; either version
- * 		2 of the License, or (at your option) any later version.
+ * 		2 of the License.
  *
  *  		Many of the algorithms and ideas for this came from
  *		NIST Net which is not copyrighted. 
