Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVCJUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVCJUal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVCJU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:28:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:49842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262973AbVCJUZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:25:59 -0500
Date: Thu, 10 Mar 2005 12:25:48 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Netdev <netdev@oss.sgi.com>, stable@kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [stable] [BK PATCHES] 2.6.x net driver oops fixes
Message-ID: <20050310202548.GV5389@shell0.pdx.osdl.net>
References: <422F59E8.2090707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422F59E8.2090707@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:

> This will update the following files:
> 
>  drivers/net/sis900.c    |   41 +++++++++++++++++++++--------------------
>  drivers/net/via-rhine.c |    3 +++

The via-rhine fix is already in the stable queue.  But the sis900 oops
fix does not apply to the stable tree.  It relies on a few intermediate
patches.  Appears to still be an issue for the older version which is in
2.6.11.  Here's a stab at a backport.  Would you like to review/validate
or drop this one?

thanks,
-chris

===== drivers/net/sis900.c 1.62 vs edited =====
--- 1.62/drivers/net/sis900.c	2005-01-10 08:52:27 -08:00
+++ edited/drivers/net/sis900.c	2005-03-10 12:23:49 -08:00
@@ -236,7 +236,7 @@ static int __devinit sis900_get_mac_addr
 	signature = (u16) read_eeprom(ioaddr, EEPROMSignature);    
 	if (signature == 0xffff || signature == 0x0000) {
 		printk (KERN_INFO "%s: Error EERPOM read %x\n", 
-			net_dev->name, signature);
+			pci_name(pci_dev), signature);
 		return 0;
 	}
 
@@ -268,7 +268,7 @@ static int __devinit sis630e_get_mac_add
 	if (!isa_bridge)
 		isa_bridge = pci_get_device(PCI_VENDOR_ID_SI, 0x0018, isa_bridge);
 	if (!isa_bridge) {
-		printk("%s: Can not find ISA bridge\n", net_dev->name);
+		printk("%s: Can not find ISA bridge\n", pci_name(pci_dev));
 		return 0;
 	}
 	pci_read_config_byte(isa_bridge, 0x48, &reg);
@@ -456,10 +456,6 @@ static int __devinit sis900_probe(struct
 	net_dev->tx_timeout = sis900_tx_timeout;
 	net_dev->watchdog_timeo = TX_TIMEOUT;
 	net_dev->ethtool_ops = &sis900_ethtool_ops;
-	
-	ret = register_netdev(net_dev);
-	if (ret)
-		goto err_unmap_rx;
 		
 	/* Get Mac address according to the chip revision */
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &revision);
@@ -476,7 +472,7 @@ static int __devinit sis900_probe(struct
 
 	if (ret == 0) {
 		ret = -ENODEV;
-		goto err_out_unregister;
+		goto err_unmap_rx;
 	}
 	
 	/* 630ET : set the mii access mode as software-mode */
@@ -486,7 +482,7 @@ static int __devinit sis900_probe(struct
 	/* probe for mii transceiver */
 	if (sis900_mii_probe(net_dev) == 0) {
 		ret = -ENODEV;
-		goto err_out_unregister;
+		goto err_unmap_rx;
 	}
 
 	/* save our host bridge revision */
@@ -496,6 +492,10 @@ static int __devinit sis900_probe(struct
 		pci_dev_put(dev);
 	}
 
+	ret = register_netdev(net_dev);
+	if (ret)
+		goto err_unmap_rx;
+
 	/* print some information about our NIC */
 	printk(KERN_INFO "%s: %s at %#lx, IRQ %d, ", net_dev->name,
 	       card_name, ioaddr, net_dev->irq);
@@ -505,8 +505,6 @@ static int __devinit sis900_probe(struct
 
 	return 0;
 
- err_out_unregister:
- 	unregister_netdev(net_dev);
  err_unmap_rx:
 	pci_free_consistent(pci_dev, RX_TOTAL_SIZE, sis_priv->rx_ring,
 		sis_priv->rx_ring_dma);
@@ -533,6 +531,7 @@ static int __devinit sis900_probe(struct
 static int __init sis900_mii_probe(struct net_device * net_dev)
 {
 	struct sis900_private * sis_priv = net_dev->priv;
+	const char *dev_name = pci_name(sis_priv->pci_dev);
 	u16 poll_bit = MII_STAT_LINK, status = 0;
 	unsigned long timeout = jiffies + 5 * HZ;
 	int phy_addr;
@@ -582,21 +581,20 @@ static int __init sis900_mii_probe(struc
 					mii_phy->phy_types =
 					    (mii_status & (MII_STAT_CAN_TX_FDX | MII_STAT_CAN_TX)) ? LAN : HOME;
 				printk(KERN_INFO "%s: %s transceiver found at address %d.\n",
-				       net_dev->name, mii_chip_table[i].name,
+				       dev_name, mii_chip_table[i].name,
 				       phy_addr);
 				break;
 			}
 			
 		if( !mii_chip_table[i].phy_id1 ) {
 			printk(KERN_INFO "%s: Unknown PHY transceiver found at address %d.\n",
-			       net_dev->name, phy_addr);
+			       dev_name, phy_addr);
 			mii_phy->phy_types = UNKNOWN;
 		}
 	}
 	
 	if (sis_priv->mii == NULL) {
-		printk(KERN_INFO "%s: No MII transceivers found!\n",
-			net_dev->name);
+		printk(KERN_INFO "%s: No MII transceivers found!\n", dev_name);
 		return 0;
 	}
 
@@ -621,7 +619,7 @@ static int __init sis900_mii_probe(struc
 			poll_bit ^= (mdio_read(net_dev, sis_priv->cur_phy, MII_STATUS) & poll_bit);
 			if (time_after_eq(jiffies, timeout)) {
 				printk(KERN_WARNING "%s: reset phy and link down now\n",
-					net_dev->name);
+				       dev_name);
 				return -ETIME;
 			}
 		}
@@ -691,7 +689,7 @@ static u16 sis900_default_phy(struct net
 		sis_priv->mii = default_phy;
 		sis_priv->cur_phy = default_phy->phy_addr;
 		printk(KERN_INFO "%s: Using transceiver found at address %d as default\n",
-					net_dev->name,sis_priv->cur_phy);
+		       pci_name(sis_priv->pci_dev), sis_priv->cur_phy);
 	}
 	
 	status = mdio_read(net_dev, sis_priv->cur_phy, MII_CONTROL);
