Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUJ3NdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUJ3NdG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbUJ3NdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:33:06 -0400
Received: from havoc.gtf.org ([69.28.190.101]:64432 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261164AbUJ3Nci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:32:38 -0400
Date: Sat, 30 Oct 2004 09:32:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x net driver updates
Message-ID: <20041030133214.GA5657@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 MAINTAINERS             |    4 
 drivers/net/8390.c      |    2 
 drivers/net/amd8111e.c  |  220 +++++++++++++++++++++++++++---------------------
 drivers/net/amd8111e.h  |    3 
 drivers/net/smc91x.h    |    4 
 drivers/net/via-rhine.c |    2 
 6 files changed, 132 insertions(+), 103 deletions(-)

through these ChangeSets:

<rddunlap@osdl.org> (04/10/30 1.2350)
   [PATCH] via-rhine: references __init code during resume
   
   Fix __init section usage:
   rhine_resume calls enable_mmio, so latter cannot be __devinit;
   Error: ./drivers/net/via-rhine.o .text refers to 0000000000000925 R_X86_64_PC32
   .init.text+0xfffffffffffffffc
   
   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<benh@kernel.crashing.org> (04/10/30 1.2349)
   [PATCH] amd8111e: Add support for ppc64 eval board
   
   This patch adds a few memory barriers, cleans up a little bit the
   use of the "status" field in the rx & tx routines, and adds probing
   for the external PHY to the driver.
   
   Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<benh@kernel.crashing.org> (04/10/30 1.2348)
   [PATCH] amd8111e: Fix identation of amd8111e_rx_poll()
   
   This patch does an indentation fix to amd8111e_rx_poll() which was
   incorrectly shifting left in the middle of a while() loop, thus
   rendering the function difficult to read. There is no actual code
   change.
   
   Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<sfeldma@pobox.com> (04/10/30 1.2347)
   [PATCH] e100: update maintainer
   
   My intel.com address will bounce.
   
   Signed-off-by: Scott Feldman <sfeldma@pobox.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<nico@cam.org> (04/10/30 1.2346)
   [PATCH] fix smc91x compilation error
   
   It looks like this bit got mismerged (pci.h removed but DMA arguments
   convertion missing).
   
   Signed-off-by: Nicolas Pitre <nico@cam.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<rmk+lkml@arm.linux.org.uk> (04/10/30 1.2345)
   [PATCH] 8390.c: Use mdelay(10) rather than udelay(10*1000)
   
   ARM udelay can't cope with >2ms delays.
   
   Signed-off-by: Russell King <rmk@arm.linux.org.uk>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2004-10-30 09:31:01 -04:00
+++ b/MAINTAINERS	2004-10-30 09:31:01 -04:00
@@ -1110,8 +1110,8 @@
 M:	john.ronciak@intel.com
 P:	Ganesh Venkatesan
 M:	ganesh.venkatesan@intel.com
-P:	Scott Feldman
-M:	scott.feldman@intel.com
+P:	Jesse Brandeburg
+M:	jesse.brandeburg@intel.com
 W:	http://sourceforge.net/projects/e1000/
 S:	Supported
 
diff -Nru a/drivers/net/8390.c b/drivers/net/8390.c
--- a/drivers/net/8390.c	2004-10-30 09:31:01 -04:00
+++ b/drivers/net/8390.c	2004-10-30 09:31:01 -04:00
@@ -813,7 +813,7 @@
 	 * We wait at least 10ms.
 	 */
 
-	udelay(10*1000);
+	mdelay(10);
 
 	/*
 	 * Reset RBCR[01] back to zero as per magic incantation.
diff -Nru a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2004-10-30 09:31:01 -04:00
+++ b/drivers/net/amd8111e.c	2004-10-30 09:31:01 -04:00
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
@@ -740,11 +741,11 @@
 	do{   
 		/* process receive packets until we use the quota*/
 		/* If we own the next entry, it's a new packet. Send it up. */
-		while(!(lp->rx_ring[rx_index].rx_flags & OWN_BIT)){
-	       
-			/* check if err summary bit is set */ 
-			if(le16_to_cpu(lp->rx_ring[rx_index].rx_flags) 
-								& ERR_BIT){
+		while(1) {
+			status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
+			if (status & OWN_BIT)
+				break;
+
 			/* 
 			 * There is a tricky error noted by John Murphy,
 			 * <murf@perftech.com> to Russ Nelson: Even with
@@ -753,89 +754,88 @@
 			 * the last correctly noting the error.
 			 */
 
-			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
-			goto err_next_pkt;
-
+			if(status & ERR_BIT) {
+				/* reseting flags */
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
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
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
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
+			if (pkt_len < min_pkt_len) {
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+				lp->drv_rx_errors++;
+				goto err_next_pkt;
+			}
+			if(--rx_pkt_limit < 0)
+				goto rx_not_empty;
+			if(!(new_skb = dev_alloc_skb(lp->rx_buff_len))){
+				/* if allocation fail, 
+				   ignore that pkt and go to next one */
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+				lp->drv_rx_errors++;
+				goto err_next_pkt;
+			}
 		
-		skb_reserve(new_skb, 2);
-		skb = lp->rx_skbuff[rx_index];
-		pci_unmap_single(lp->pci_dev,lp->rx_dma_addr[rx_index],
-			lp->rx_buff_len-2, PCI_DMA_FROMDEVICE);
-		skb_put(skb, pkt_len);
-		skb->dev = dev;
-		lp->rx_skbuff[rx_index] = new_skb;
-		new_skb->dev = dev;
-		lp->rx_dma_addr[rx_index] = pci_map_single(lp->pci_dev,
-			new_skb->data, lp->rx_buff_len-2,PCI_DMA_FROMDEVICE);
+			skb_reserve(new_skb, 2);
+			skb = lp->rx_skbuff[rx_index];
+			pci_unmap_single(lp->pci_dev,lp->rx_dma_addr[rx_index],
+					 lp->rx_buff_len-2, PCI_DMA_FROMDEVICE);
+			skb_put(skb, pkt_len);
+			skb->dev = dev;
+			lp->rx_skbuff[rx_index] = new_skb;
+			new_skb->dev = dev;
+			lp->rx_dma_addr[rx_index] = pci_map_single(lp->pci_dev,
+								   new_skb->data,
+								   lp->rx_buff_len-2,
+								   PCI_DMA_FROMDEVICE);
 	
-		skb->protocol = eth_type_trans(skb, dev);
+			skb->protocol = eth_type_trans(skb, dev);
 
 #if AMD8111E_VLAN_TAG_USED		
-		
-		vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
-		if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
-			amd8111e_vlan_rx(lp, skb,
-				    lp->rx_ring[rx_index].tag_ctrl_info);
-		} else
+			if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
+				amd8111e_vlan_rx(lp, skb,
+					 le16_to_cpy(lp->rx_ring[rx_index].tag_ctrl_info));
+			} else
 #endif
-			
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
 	
-err_next_pkt:	
-		lp->rx_ring[rx_index].buff_phy_addr
-			 = cpu_to_le32(lp->rx_dma_addr[rx_index]);
-		lp->rx_ring[rx_index].buff_count = 
+		err_next_pkt:	
+			lp->rx_ring[rx_index].buff_phy_addr
+				= cpu_to_le32(lp->rx_dma_addr[rx_index]);
+			lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
-		lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
-		rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
-	}
-	/* Check the interrupt status register for more packets in the 
-	mean time. Process them since we have not used up our quota.*/
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
 
-	intr0 = readl(mmio + INT0);
-	/*Ack receive packets */
-	writel(intr0 & RINT0,mmio + INT0);
-
-	}while(intr0 & RINT0);
+	} while(intr0 & RINT0);
 
 	/* Receive descriptor is empty now */
 	dev->quota -= num_rx_pkt;
@@ -873,11 +873,12 @@
 	
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
@@ -888,7 +889,6 @@
 			goto err_next_pkt;
 		}
 		/* check for STP and ENP */
-		status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
 		if(!((status & STP_BIT) && (status & ENP_BIT))){
 			/* reseting flags */
 			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
@@ -897,7 +897,7 @@
 		pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
 
 #if AMD8111E_VLAN_TAG_USED		
-		vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
+		vtag = status & TT_MASK;
 		/*MAC will strip vlan tag*/ 
 		if(lp->vlgrp != NULL && vtag !=0)
 			min_pkt_len =MIN_PKT_LEN - 4;
@@ -931,12 +931,10 @@
 	
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
 			
@@ -952,6 +950,7 @@
 			 = cpu_to_le32(lp->rx_dma_addr[rx_index]);
 		lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
+		wmb();
 		lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
 		rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
 	}
@@ -1432,7 +1431,7 @@
 #if AMD8111E_VLAN_TAG_USED
 	if((lp->vlgrp != NULL) && vlan_tx_tag_present(skb)){
 		lp->tx_ring[tx_index].tag_ctrl_cmd |= 
-				cpu_to_le32(TCC_VLAN_INSERT);	
+				cpu_to_le16(TCC_VLAN_INSERT);	
 		lp->tx_ring[tx_index].tag_ctrl_info = 
 				cpu_to_le16(vlan_tx_tag_get(skb));
 
@@ -1444,6 +1443,7 @@
 	    (u32) cpu_to_le32(lp->tx_dma_addr[tx_index]);
 
 	/*  Set FCS and LTINT bits */
+	wmb();
 	lp->tx_ring[tx_index].tx_flags |=
 	    cpu_to_le16(OWN_BIT | STP_BIT | ENP_BIT|ADD_FCS_BIT|LTINT_BIT);
 
@@ -1667,7 +1667,7 @@
 
 	switch(cmd) {
 	case SIOCGMIIPHY:
-		data->phy_id = PHY_ID;
+		data->phy_id = lp->ext_phy_addr;
 
 	/* fallthru */
 	case SIOCGMIIREG: 
@@ -1940,6 +1940,26 @@
 
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
@@ -2010,12 +2030,6 @@
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
@@ -2063,7 +2077,15 @@
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
 
@@ -2096,6 +2118,12 @@
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
diff -Nru a/drivers/net/amd8111e.h b/drivers/net/amd8111e.h
--- a/drivers/net/amd8111e.h	2004-10-30 09:31:01 -04:00
+++ b/drivers/net/amd8111e.h	2004-10-30 09:31:01 -04:00
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
diff -Nru a/drivers/net/smc91x.h b/drivers/net/smc91x.h
--- a/drivers/net/smc91x.h	2004-10-30 09:31:01 -04:00
+++ b/drivers/net/smc91x.h	2004-10-30 09:31:01 -04:00
@@ -245,7 +245,7 @@
 	while (!(DCSR(dma) & DCSR_STOPSTATE))
 		cpu_relax();
 	DCSR(dma) = 0;
-	dma_unmap_single(NULL, dmabuf, len, PCI_DMA_FROMDEVICE);
+	dma_unmap_single(NULL, dmabuf, len, DMA_FROM_DEVICE);
 }
 #endif
 
@@ -273,7 +273,7 @@
 	}
 
 	len *= 2;
-	dmabuf = dma_map_single(NULL, buf, len, PCI_DMA_FROMDEVICE);
+	dmabuf = dma_map_single(NULL, buf, len, DMA_FROM_DEVICE);
 	DCSR(dma) = DCSR_NODESC;
 	DTADR(dma) = dmabuf;
 	DSADR(dma) = physaddr + reg;
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2004-10-30 09:31:01 -04:00
+++ b/drivers/net/via-rhine.c	2004-10-30 09:31:01 -04:00
@@ -627,7 +627,7 @@
 }
 
 #ifdef USE_MMIO
-static void __devinit enable_mmio(long pioaddr, u32 quirks)
+static void enable_mmio(long pioaddr, u32 quirks)
 {
 	int n;
 	if (quirks & rqRhineI) {
