Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269369AbUJWA1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269369AbUJWA1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUJWAZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:25:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:700 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269369AbUJWATo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:19:44 -0400
Subject: [PATCH] amd8111e 2/2 : Add support for ppc64 eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Message-Id: <1098490707.11740.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 10:18:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds a few memory barriers, cleans up a little bit the
use of the "status" field in the rx & tx routines, and adds probing
for the external PHY to the driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/net/amd8111e.c
===================================================================
--- linux-work.orig/drivers/net/amd8111e.c	2004-10-23 09:59:44.318155200 +1000
+++ linux-work/drivers/net/amd8111e.c	2004-10-23 10:11:39.341455136 +1000
@@ -211,7 +211,7 @@
 	u32 bmcr,advert,tmp;
 	
 	/* Determine mii register values to set the speed */
-	advert = amd8111e_mdio_read(dev, PHY_ID, MII_ADVERTISE);
+	advert = amd8111e_mdio_read(dev, lp->ext_phy_addr, MII_ADVERTISE);
 	tmp = advert & ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
 	switch (lp->ext_phy_option){
 
@@ -235,11 +235,11 @@
 	}
 
 	if(advert != tmp)
-		amd8111e_mdio_write(dev, PHY_ID, MII_ADVERTISE, tmp);
+		amd8111e_mdio_write(dev, lp->ext_phy_addr, MII_ADVERTISE, tmp);
 	/* Restart auto negotiation */
-	bmcr = amd8111e_mdio_read(dev, PHY_ID, MII_BMCR);
+	bmcr = amd8111e_mdio_read(dev, lp->ext_phy_addr, MII_BMCR);
 	bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
-	amd8111e_mdio_write(dev, PHY_ID, MII_BMCR, bmcr);
+	amd8111e_mdio_write(dev, lp->ext_phy_addr, MII_BMCR, bmcr);
 
 }
 
@@ -350,6 +350,7 @@
 
 		lp->rx_ring[i].buff_phy_addr = cpu_to_le32(lp->rx_dma_addr[i]);
 		lp->rx_ring[i].buff_count = cpu_to_le16(lp->rx_buff_len-2);
+		wmb();
 		lp->rx_ring[i].rx_flags = cpu_to_le16(OWN_BIT);
 	}
 
@@ -529,7 +530,7 @@
 	writel(RUN, mmio + CMD0);
 
 	/* AUTOPOLL0 Register *//*TBD default value is 8100 in FPS */
-	writew( 0x8101, mmio + AUTOPOLL0);
+	writew( 0x8100 | lp->ext_phy_addr, mmio + AUTOPOLL0);
 
 	/* Clear RCV_RING_BASE_ADDR */
 	writel(0, mmio + RCV_RING_BASE_ADDR0);
@@ -740,34 +741,34 @@
 	do{   
 		/* process receive packets until we use the quota*/
 		/* If we own the next entry, it's a new packet. Send it up. */
-		while(!(lp->rx_ring[rx_index].rx_flags & OWN_BIT)){
-	       
-			/* check if err summary bit is set */ 
-			if(le16_to_cpu(lp->rx_ring[rx_index].rx_flags) 
-								& ERR_BIT){
-				/* 
-				 * There is a tricky error noted by John Murphy,
-				 * <murf@perftech.com> to Russ Nelson: Even with
-				 * full-sized * buffers it's possible for a  
-				 * jabber packet to use two buffers, with only 
-				 * the last correctly noting the error.
-				 */
+		while(1) {
+			status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
+			if (status & OWN_BIT)
+				break;
+
+			/* 
+			 * There is a tricky error noted by John Murphy,
+			 * <murf@perftech.com> to Russ Nelson: Even with
+			 * full-sized * buffers it's possible for a  
+			 * jabber packet to use two buffers, with only 
+			 * the last correctly noting the error.
+			 */
 
+			if(status & ERR_BIT) {
 				/* reseting flags */
-				lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
 				goto err_next_pkt;
 			}
 			/* check for STP and ENP */
-			status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
 			if(!((status & STP_BIT) && (status & ENP_BIT))){
 				/* reseting flags */
-				lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
 				goto err_next_pkt;
 			}
 			pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
 
 #if AMD8111E_VLAN_TAG_USED		
-			vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
+			vtag = status & TT_MASK;
 			/*MAC will strip vlan tag*/ 
 			if(lp->vlgrp != NULL && vtag !=0)
 				min_pkt_len =MIN_PKT_LEN - 4;
@@ -806,10 +807,9 @@
 			skb->protocol = eth_type_trans(skb, dev);
 
 #if AMD8111E_VLAN_TAG_USED		
-			vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
 			if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
 				amd8111e_vlan_rx(lp, skb,
-				    lp->rx_ring[rx_index].tag_ctrl_info);
+					 le16_to_cpy(lp->rx_ring[rx_index].tag_ctrl_info));
 			} else
 #endif
 				netif_receive_skb(skb);
@@ -824,6 +824,7 @@
 				= cpu_to_le32(lp->rx_dma_addr[rx_index]);
 			lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
+			wmb();
 			lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
 			rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
 		}
@@ -872,11 +873,12 @@
 	
 	/* If we own the next entry, it's a new packet. Send it up. */
 	while(++num_rx_pkt <= max_rx_pkt){
-		if(lp->rx_ring[rx_index].rx_flags & OWN_BIT)
+		status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
+		if(status & OWN_BIT)
 			return 0;
 	       
 		/* check if err summary bit is set */ 
-		if(le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & ERR_BIT){
+		if(status & ERR_BIT){
 			/* 
 			 * There is a tricky error noted by John Murphy,
 			 * <murf@perftech.com> to Russ Nelson: Even with full-sized
@@ -887,7 +889,6 @@
 			goto err_next_pkt;
 		}
 		/* check for STP and ENP */
-		status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
 		if(!((status & STP_BIT) && (status & ENP_BIT))){
 			/* reseting flags */
 			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
@@ -896,7 +897,7 @@
 		pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
 
 #if AMD8111E_VLAN_TAG_USED		
-		vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
+		vtag = status & TT_MASK;
 		/*MAC will strip vlan tag*/ 
 		if(lp->vlgrp != NULL && vtag !=0)
 			min_pkt_len =MIN_PKT_LEN - 4;
@@ -930,12 +931,10 @@
 	
 		skb->protocol = eth_type_trans(skb, dev);
 
-#if AMD8111E_VLAN_TAG_USED		
-		
-		vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
+#if AMD8111E_VLAN_TAG_USED				
 		if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
 			amd8111e_vlan_rx(lp, skb,
-				    lp->rx_ring[rx_index].tag_ctrl_info);
+				 le16_to_cpu(lp->rx_ring[rx_index].tag_ctrl_info));
 		} else
 #endif
 			
@@ -951,6 +950,7 @@
 			 = cpu_to_le32(lp->rx_dma_addr[rx_index]);
 		lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
+		wmb();
 		lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
 		rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
 	}
@@ -1431,7 +1431,7 @@
 #if AMD8111E_VLAN_TAG_USED
 	if((lp->vlgrp != NULL) && vlan_tx_tag_present(skb)){
 		lp->tx_ring[tx_index].tag_ctrl_cmd |= 
-				cpu_to_le32(TCC_VLAN_INSERT);	
+				cpu_to_le16(TCC_VLAN_INSERT);	
 		lp->tx_ring[tx_index].tag_ctrl_info = 
 				cpu_to_le16(vlan_tx_tag_get(skb));
 
@@ -1443,6 +1443,7 @@
 	    (u32) cpu_to_le32(lp->tx_dma_addr[tx_index]);
 
 	/*  Set FCS and LTINT bits */
+	wmb();
 	lp->tx_ring[tx_index].tx_flags |=
 	    cpu_to_le16(OWN_BIT | STP_BIT | ENP_BIT|ADD_FCS_BIT|LTINT_BIT);
 
@@ -1666,7 +1667,7 @@
 
 	switch(cmd) {
 	case SIOCGMIIPHY:
-		data->phy_id = PHY_ID;
+		data->phy_id = lp->ext_phy_addr;
 
 	/* fallthru */
 	case SIOCGMIIREG: 
@@ -1939,6 +1940,26 @@
 
 }
 
+static void __devinit amd8111e_probe_ext_phy(struct net_device* dev)
+{
+	struct amd8111e_priv *lp = netdev_priv(dev);
+	int i;
+
+	for (i = 0x1e; i >= 0; i--) {
+		u32 id1, id2;
+
+		if (amd8111e_read_phy(lp, i, MII_PHYSID1, &id1))
+			continue;
+		if (amd8111e_read_phy(lp, i, MII_PHYSID2, &id2))
+			continue;
+		lp->ext_phy_id = (id1 << 16) | id2;
+		lp->ext_phy_addr = i;
+		return;
+	}
+	lp->ext_phy_id = 0;
+	lp->ext_phy_addr = 1;
+}
+
 static int __devinit amd8111e_probe_one(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
@@ -2009,12 +2030,6 @@
 	lp->amd8111e_net_dev = dev;
 	lp->pm_cap = pm_cap;
 
-	/* setting mii default values */
-	lp->mii_if.dev = dev;
-	lp->mii_if.mdio_read = amd8111e_mdio_read;
-	lp->mii_if.mdio_write = amd8111e_mdio_write;
-	lp->mii_if.phy_id = PHY_ID;
-
 	spin_lock_init(&lp->lock);
 
 	lp->mmio = ioremap(reg_addr, reg_len);
@@ -2062,7 +2077,15 @@
 	dev->vlan_rx_register =amd8111e_vlan_rx_register;
 	dev->vlan_rx_kill_vid = amd8111e_vlan_rx_kill_vid;
 #endif	
-	
+	/* Probe the external PHY */
+	amd8111e_probe_ext_phy(dev);
+
+	/* setting mii default values */
+	lp->mii_if.dev = dev;
+	lp->mii_if.mdio_read = amd8111e_mdio_read;
+	lp->mii_if.mdio_write = amd8111e_mdio_write;
+	lp->mii_if.phy_id = lp->ext_phy_addr;
+
 	/* Set receive buffer length and set jumbo option*/
 	amd8111e_set_rx_buff_len(dev);
 
@@ -2095,6 +2118,12 @@
     	for (i = 0; i < 6; i++)
 		printk("%2.2x%c",dev->dev_addr[i],i == 5 ? ' ' : ':');
     	printk( "\n");	
+	if (lp->ext_phy_id)
+		printk(KERN_INFO "%s: Found MII PHY ID 0x%08x at address 0x%02x\n",
+		       dev->name, lp->ext_phy_id, lp->ext_phy_addr);
+	else
+		printk(KERN_INFO "%s: Couldn't detect MII PHY, assuming address 0x01\n",
+		       dev->name);
     	return 0;
 err_iounmap:
 	iounmap(lp->mmio);
Index: linux-work/drivers/net/amd8111e.h
===================================================================
--- linux-work.orig/drivers/net/amd8111e.h	2004-10-20 13:01:01.000000000 +1000
+++ linux-work/drivers/net/amd8111e.h	2004-10-23 10:01:06.925596960 +1000
@@ -649,7 +649,6 @@
 #define TCC_MASK		0x0003
 
 /* driver ioctl parameters */
-#define PHY_ID 			0x01	/* currently it is fixed */
 #define AMD8111E_REG_DUMP_LEN	 13*sizeof(u32) 
 
 /* crc generator constants */
@@ -777,6 +776,8 @@
 	int options;		/* Options enabled/disabled for the device */
 
 	unsigned long ext_phy_option;
+	int ext_phy_addr;
+	u32 ext_phy_id;
 	
 	struct amd8111e_link_config link_config;
 	int pm_cap;


