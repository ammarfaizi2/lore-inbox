Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVCIUf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVCIUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVCIUfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:35:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34274 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261213AbVCIUSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:18:07 -0500
Message-ID: <422F59E8.2090707@pobox.com>
Date: Wed, 09 Mar 2005 15:17:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: stable@kernel.org, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x net driver oops fixes
Content-Type: multipart/mixed;
 boundary="------------020208010505070903000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208010505070903000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020208010505070903000204
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 drivers/net/sis900.c    |   41 +++++++++++++++++++++--------------------
 drivers/net/via-rhine.c |    3 +++
 2 files changed, 24 insertions(+), 20 deletions(-)

through these ChangeSets:

Herbert Xu:
  o sis900 kernel oops fix

Olof Johansson:
  o [VIA RHINE] older chips oops on shutdown


--------------020208010505070903000204
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2005-03-09 15:16:53 -05:00
+++ b/drivers/net/sis900.c	2005-03-09 15:16:53 -05:00
@@ -245,7 +245,7 @@
 	signature = (u16) read_eeprom(ioaddr, EEPROMSignature);    
 	if (signature == 0xffff || signature == 0x0000) {
 		printk (KERN_WARNING "%s: Error EERPOM read %x\n", 
-			net_dev->name, signature);
+			pci_name(pci_dev), signature);
 		return 0;
 	}
 
@@ -277,7 +277,8 @@
 	if (!isa_bridge)
 		isa_bridge = pci_get_device(PCI_VENDOR_ID_SI, 0x0018, isa_bridge);
 	if (!isa_bridge) {
-		printk(KERN_WARNING "%s: Can not find ISA bridge\n", net_dev->name);
+		printk(KERN_WARNING "%s: Can not find ISA bridge\n",
+		       pci_name(pci_dev));
 		return 0;
 	}
 	pci_read_config_byte(isa_bridge, 0x48, &reg);
@@ -396,6 +397,7 @@
 	long ioaddr;
 	int i, ret;
 	char *card_name = card_names[pci_id->driver_data];
+	const char *dev_name = pci_name(pci_dev);
 
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -473,17 +475,13 @@
 		sis_priv->msg_enable = sis900_debug;
 	else
 		sis_priv->msg_enable = SIS900_DEF_MSG;
-
-	ret = register_netdev(net_dev);
-	if (ret)
-		goto err_unmap_rx;
 		
 	/* Get Mac address according to the chip revision */
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &(sis_priv->chipset_rev));
 	if(netif_msg_probe(sis_priv))
 		printk(KERN_DEBUG "%s: detected revision %2.2x, "
 				"trying to get MAC address...\n",
-				net_dev->name, sis_priv->chipset_rev);
+				dev_name, sis_priv->chipset_rev);
 	
 	ret = 0;
 	if (sis_priv->chipset_rev == SIS630E_900_REV)
@@ -496,9 +494,9 @@
 		ret = sis900_get_mac_addr(pci_dev, net_dev);
 
 	if (ret == 0) {
-		printk(KERN_WARNING "%s: Cannot read MAC address.\n", net_dev->name);
+		printk(KERN_WARNING "%s: Cannot read MAC address.\n", dev_name);
 		ret = -ENODEV;
-		goto err_out_unregister;
+		goto err_unmap_rx;
 	}
 	
 	/* 630ET : set the mii access mode as software-mode */
@@ -507,9 +505,10 @@
 
 	/* probe for mii transceiver */
 	if (sis900_mii_probe(net_dev) == 0) {
-		printk(KERN_WARNING "%s: Error probing MII device.\n", net_dev->name);
+		printk(KERN_WARNING "%s: Error probing MII device.\n",
+		       dev_name);
 		ret = -ENODEV;
-		goto err_out_unregister;
+		goto err_unmap_rx;
 	}
 
 	/* save our host bridge revision */
@@ -519,6 +518,10 @@
 		pci_dev_put(dev);
 	}
 
+	ret = register_netdev(net_dev);
+	if (ret)
+		goto err_unmap_rx;
+
 	/* print some information about our NIC */
 	printk(KERN_INFO "%s: %s at %#lx, IRQ %d, ", net_dev->name,
 	       card_name, ioaddr, net_dev->irq);
@@ -528,8 +531,6 @@
 
 	return 0;
 
- err_out_unregister:
- 	unregister_netdev(net_dev);
  err_unmap_rx:
 	pci_free_consistent(pci_dev, RX_TOTAL_SIZE, sis_priv->rx_ring,
 		sis_priv->rx_ring_dma);
@@ -556,6 +557,7 @@
 static int __init sis900_mii_probe(struct net_device * net_dev)
 {
 	struct sis900_private * sis_priv = net_dev->priv;
+	const char *dev_name = pci_name(sis_priv->pci_dev);
 	u16 poll_bit = MII_STAT_LINK, status = 0;
 	unsigned long timeout = jiffies + 5 * HZ;
 	int phy_addr;
@@ -576,7 +578,7 @@
 			if (netif_msg_probe(sis_priv))
 				printk(KERN_DEBUG "%s: MII at address %d"
 						" not accessible\n",
-						net_dev->name, phy_addr);
+						dev_name, phy_addr);
 			continue;
 		}
 		
@@ -609,7 +611,7 @@
 					    (mii_status & (MII_STAT_CAN_TX_FDX | MII_STAT_CAN_TX)) ? LAN : HOME;
 				printk(KERN_INFO "%s: %s transceiver found "
 							"at address %d.\n",
-							net_dev->name,
+							dev_name,
 							mii_chip_table[i].name,
 							phy_addr);
 				break;
@@ -617,14 +619,13 @@
 			
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
 
@@ -649,7 +650,7 @@
 			poll_bit ^= (mdio_read(net_dev, sis_priv->cur_phy, MII_STATUS) & poll_bit);
 			if (time_after_eq(jiffies, timeout)) {
 				printk(KERN_WARNING "%s: reset phy and link down now\n",
-					net_dev->name);
+				       dev_name);
 				return -ETIME;
 			}
 		}
@@ -718,7 +719,7 @@
 		sis_priv->mii = default_phy;
 		sis_priv->cur_phy = default_phy->phy_addr;
 		printk(KERN_INFO "%s: Using transceiver found at address %d as default\n",
-					net_dev->name,sis_priv->cur_phy);
+		       pci_name(sis_priv->pci_dev), sis_priv->cur_phy);
 	}
 	
 	status = mdio_read(net_dev, sis_priv->cur_phy, MII_CONTROL);
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2005-03-09 15:16:53 -05:00
+++ b/drivers/net/via-rhine.c	2005-03-09 15:16:53 -05:00
@@ -1901,6 +1901,9 @@
 	struct rhine_private *rp = netdev_priv(dev);
 	void __iomem *ioaddr = rp->base;
 
+	if (!(rp->quirks & rqWOL))
+		return; /* Nothing to do for non-WOL adapters */
+
 	rhine_power_init(dev);
 
 	/* Make sure we use pattern 0, 1 and not 4, 5 */

--------------020208010505070903000204--
