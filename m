Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUJHGtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUJHGtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUJHGtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:49:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:32422 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268029AbUJHGsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:48:46 -0400
Subject: [PATCH] amd8111e endian & barrier fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097217683.892.115.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 16:41:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff !

This patch against the amd8111e makes it work on some about-to-be-released
piece of PPC hardware. It does:

 - Fix endian
 - Search for the PHY on MII instead of hard coding the ID
 - Add a couple of wmb's where needed on descriptor updates

I must appologize for having re-indented one of the rx functions, but I
just couldn't read/understand it without doing so, it was going back
leftward in the middle of a { } block ...

Comments welcome, I haven't tested for regressions on x86/x86_64 HW using
the AMD8111 chipset as I don't have access to such a machine.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/drivers/net/amd8111e.c linux-maple/drivers/net/amd8111e.c
--- linux-2.5/drivers/net/amd8111e.c	2004-09-30 18:31:33.000000000 +1000
+++ linux-maple/drivers/net/amd8111e.c	2004-10-08 16:24:08.633588314 +1000
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
@@ -685,6 +686,7 @@
 	struct amd8111e_priv* lp = netdev_priv(dev);
 	int tx_index = lp->tx_complete_idx & TX_RING_DR_MOD_MASK;
 	int status;
+
 	/* Complete all the transmit packet */
 	while (lp->tx_complete_idx != lp->tx_idx){
 		tx_index =  lp->tx_complete_idx & TX_RING_DR_MOD_MASK;
@@ -740,100 +742,103 @@
 	do{   
 		/* process receive packets until we use the quota*/
 		/* If we own the next entry, it's a new packet. Send it up. */
-		while(!(lp->rx_ring[rx_index].rx_flags & OWN_BIT)){
+		while(1) {
+			status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
+			if (status & OWN_BIT)
+				break;
 	       
 			/* check if err summary bit is set */ 
-			if(le16_to_cpu(lp->rx_ring[rx_index].rx_flags) 
-								& ERR_BIT){
-			/* 
-			 * There is a tricky error noted by John Murphy,
-			 * <murf@perftech.com> to Russ Nelson: Even with
-			 * full-sized * buffers it's possible for a  
-			 * jabber packet to use two buffers, with only 
-			 * the last correctly noting the error.
-			 */
-
-			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
-			goto err_next_pkt;
+			if(status & ERR_BIT){
+				/* 
+				 * There is a tricky error noted by John Murphy,
+				 * <murf@perftech.com> to Russ Nelson: Even with
+				 * full-sized * buffers it's possible for a  
+				 * jabber packet to use two buffers, with only 
+				 * the last correctly noting the error.
+				 */
+
+				/* reseting flags */
+				lp->rx_ring[rx_index].rx_flags = 0;
+				wmb();
+				goto err_next_pkt;
 
 			}
 			/* check for STP and ENP */
-		status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
-		if(!((status & STP_BIT) && (status & ENP_BIT))){
-			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
-			goto err_next_pkt;
-		}
-		pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
+			if(!((status & STP_BIT) && (status & ENP_BIT))){
+				/* reseting flags */
+				lp->rx_ring[rx_index].rx_flags = 0;
+				goto err_next_pkt;
+			}
+			pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
 
 #if AMD8111E_VLAN_TAG_USED		
-		vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
-		/*MAC will strip vlan tag*/ 
-		if(lp->vlgrp != NULL && vtag !=0)
-			min_pkt_len =MIN_PKT_LEN - 4;
-		else
+			vtag = status & TT_MASK;
+			/*MAC will strip vlan tag*/ 
+			if(lp->vlgrp != NULL && vtag !=0)
+				min_pkt_len =MIN_PKT_LEN - 4;
+			else
 #endif
-			min_pkt_len =MIN_PKT_LEN;
+				min_pkt_len =MIN_PKT_LEN;
 
-		if (pkt_len < min_pkt_len) {
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
-			lp->drv_rx_errors++;
-			goto err_next_pkt;
-		}
-		if(--rx_pkt_limit < 0)
-			goto rx_not_empty;
-		if(!(new_skb = dev_alloc_skb(lp->rx_buff_len))){
-			/* if allocation fail, 
-				ignore that pkt and go to next one */
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
-			lp->drv_rx_errors++;
-			goto err_next_pkt;
-		}
-		
-		skb_reserve(new_skb, 2);
-		skb = lp->rx_skbuff[rx_index];
-		pci_unmap_single(lp->pci_dev,lp->rx_dma_addr[rx_index],
+			if (pkt_len < min_pkt_len) {
+				lp->rx_ring[rx_index].rx_flags = 0;
+				lp->drv_rx_errors++;
+				goto err_next_pkt;
+			}
+			if(--rx_pkt_limit < 0)
+				goto rx_not_empty;
+			if(!(new_skb = dev_alloc_skb(lp->rx_buff_len))){
+				/* if allocation fail, 
+				   ignore that pkt and go to next one */
+				lp->rx_ring[rx_index].rx_flags = 0;
+				lp->drv_rx_errors++;
+				goto err_next_pkt;
+			}
+
+			skb_reserve(new_skb, 2);
+			skb = lp->rx_skbuff[rx_index];
+			pci_unmap_single(lp->pci_dev,lp->rx_dma_addr[rx_index],
 			lp->rx_buff_len-2, PCI_DMA_FROMDEVICE);
-		skb_put(skb, pkt_len);
-		skb->dev = dev;
-		lp->rx_skbuff[rx_index] = new_skb;
-		new_skb->dev = dev;
-		lp->rx_dma_addr[rx_index] = pci_map_single(lp->pci_dev,
-			new_skb->data, lp->rx_buff_len-2,PCI_DMA_FROMDEVICE);
+			skb_put(skb, pkt_len);
+			skb->dev = dev;
+			lp->rx_skbuff[rx_index] = new_skb;
+			new_skb->dev = dev;
+			lp->rx_dma_addr[rx_index] = pci_map_single(lp->pci_dev,
+								   new_skb->data, lp->rx_buff_len-2,PCI_DMA_FROMDEVICE);
 	
-		skb->protocol = eth_type_trans(skb, dev);
+			skb->protocol = eth_type_trans(skb, dev);
 
 #if AMD8111E_VLAN_TAG_USED		
 		
-		vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
-		if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
-			amd8111e_vlan_rx(lp, skb,
-				    lp->rx_ring[rx_index].tag_ctrl_info);
-		} else
+			vtag = status & TT_MASK;
+			if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
+				amd8111e_vlan_rx(lp, skb,
+						 le16_to_cpu(lp->rx_ring[rx_index].tag_ctrl_info));
+			} else
 #endif
 			
-			netif_receive_skb(skb);
-		/*COAL update rx coalescing parameters*/
-		lp->coal_conf.rx_packets++;
-		lp->coal_conf.rx_bytes += pkt_len;	
-		num_rx_pkt++;
-		dev->last_rx = jiffies;
+				netif_receive_skb(skb);
+			/*COAL update rx coalescing parameters*/
+			lp->coal_conf.rx_packets++;
+			lp->coal_conf.rx_bytes += pkt_len;	
+			num_rx_pkt++;
+			dev->last_rx = jiffies;
 	
 err_next_pkt:	
-		lp->rx_ring[rx_index].buff_phy_addr
-			 = cpu_to_le32(lp->rx_dma_addr[rx_index]);
-		lp->rx_ring[rx_index].buff_count = 
+			lp->rx_ring[rx_index].buff_phy_addr
+				= cpu_to_le32(lp->rx_dma_addr[rx_index]);
+			lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
-		lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
-		rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
-	}
-	/* Check the interrupt status register for more packets in the 
-	mean time. Process them since we have not used up our quota.*/
-
-	intr0 = readl(mmio + INT0);
-	/*Ack receive packets */
-	writel(intr0 & RINT0,mmio + INT0);
+			wmb();
+			lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
+			rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
+		}
+		/* Check the interrupt status register for more packets in the 
+		   mean time. Process them since we have not used up our quota.*/
+
+		intr0 = readl(mmio + INT0);
+		/*Ack receive packets */
+		writel(intr0 & RINT0,mmio + INT0);
 
 	}while(intr0 & RINT0);
 
@@ -873,31 +878,31 @@
 	
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
 			 * buffers it's possible for a jabber packet to use two
 			 * buffers, with only the last correctly noting the error.			 */
 			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+			lp->rx_ring[rx_index].rx_flags = 0;
 			goto err_next_pkt;
 		}
 		/* check for STP and ENP */
-		status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
 		if(!((status & STP_BIT) && (status & ENP_BIT))){
 			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+			lp->rx_ring[rx_index].rx_flags = 0;
 			goto err_next_pkt;
 		}
 		pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
 
 #if AMD8111E_VLAN_TAG_USED		
-		vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
+		vtag = status & TT_MASK;
 		/*MAC will strip vlan tag*/ 
 		if(lp->vlgrp != NULL && vtag !=0)
 			min_pkt_len =MIN_PKT_LEN - 4;
@@ -906,14 +911,14 @@
 			min_pkt_len =MIN_PKT_LEN;
 
 		if (pkt_len < min_pkt_len) {
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+			lp->rx_ring[rx_index].rx_flags = 0;
 			lp->drv_rx_errors++;
 			goto err_next_pkt;
 		}
 		if(!(new_skb = dev_alloc_skb(lp->rx_buff_len))){
 			/* if allocation fail, 
 				ignore that pkt and go to next one */
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+			lp->rx_ring[rx_index].rx_flags = 0;
 			lp->drv_rx_errors++;
 			goto err_next_pkt;
 		}
@@ -933,10 +938,10 @@
 
 #if AMD8111E_VLAN_TAG_USED		
 		
-		vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
+		vtag = status & TT_MASK;
 		if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
 			amd8111e_vlan_rx(lp, skb,
-				    lp->rx_ring[rx_index].tag_ctrl_info);
+					 le16_to_cpu(lp->rx_ring[rx_index].tag_ctrl_info));
 		} else
 #endif
 			
@@ -952,6 +957,7 @@
 			 = cpu_to_le32(lp->rx_dma_addr[rx_index]);
 		lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
+		wmb();
 		lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
 		rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
 	}
@@ -1432,7 +1438,7 @@
 #if AMD8111E_VLAN_TAG_USED
 	if((lp->vlgrp != NULL) && vlan_tx_tag_present(skb)){
 		lp->tx_ring[tx_index].tag_ctrl_cmd |= 
-				cpu_to_le32(TCC_VLAN_INSERT);	
+				cpu_to_le16(TCC_VLAN_INSERT);	
 		lp->tx_ring[tx_index].tag_ctrl_info = 
 				cpu_to_le16(vlan_tx_tag_get(skb));
 
@@ -1444,6 +1450,7 @@
 	    (u32) cpu_to_le32(lp->tx_dma_addr[tx_index]);
 
 	/*  Set FCS and LTINT bits */
+	wmb();
 	lp->tx_ring[tx_index].tx_flags |=
 	    cpu_to_le16(OWN_BIT | STP_BIT | ENP_BIT|ADD_FCS_BIT|LTINT_BIT);
 
@@ -1706,7 +1713,7 @@
 	case SIOCETHTOOL:
 		return amd8111e_ethtool_ioctl(dev, ifr->ifr_data);
 	case SIOCGMIIPHY:
-		data->phy_id = PHY_ID;
+		data->phy_id = lp->ext_phy_addr;
 
 	/* fallthru */
 	case SIOCGMIIREG: 
@@ -1979,6 +1986,26 @@
 
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
@@ -2049,12 +2076,6 @@
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
@@ -2101,7 +2122,15 @@
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
 
@@ -2129,11 +2158,19 @@
 	/*  display driver and device information */
 
     	chip_version = (readl(lp->mmio + CHIPID) & 0xf0000000)>>28;
-    	printk(KERN_INFO "%s: AMD-8111e Driver Version: %s\n",								 dev->name,MODULE_VERS);
-    	printk(KERN_INFO "%s: [ Rev %x ] PCI 10/100BaseT Ethernet ",							dev->name, chip_version);
+    	printk(KERN_INFO "%s: AMD-8111e Driver Version: %s\n",
+	       dev->name,MODULE_VERS);
+    	printk(KERN_INFO "%s: [ Rev %x ] PCI 10/100BaseT Ethernet ",
+	       dev->name, chip_version);
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
 	iounmap((void *) lp->mmio);
diff -urN linux-2.5/drivers/net/amd8111e.h linux-maple/drivers/net/amd8111e.h
--- linux-2.5/drivers/net/amd8111e.h	2004-09-30 18:31:33.000000000 +1000
+++ linux-maple/drivers/net/amd8111e.h	2004-10-08 15:52:58.419785509 +1000
@@ -644,12 +644,10 @@
 
 }RX_FLAG_BITS;
 
-#define RESET_RX_FLAGS		0x0000
 #define TT_MASK			0x000c
 #define TCC_MASK		0x0003
 
 /* driver ioctl parameters */
-#define PHY_ID 			0x01	/* currently it is fixed */
 #define AMD8111E_REG_DUMP_LEN	 13*sizeof(u32) 
 
 /* crc generator constants */
@@ -777,6 +775,8 @@
 	int options;		/* Options enabled/disabled for the device */
 
 	unsigned long ext_phy_option;
+	int ext_phy_addr;
+	u32 ext_phy_id;
 	
 	struct amd8111e_link_config link_config;
 	int pm_cap;


