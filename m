Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTHYVpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTHYVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:45:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46778 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262318AbTHYVp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:45:28 -0400
Message-ID: <3F4A82E5.215E29AA@us.ibm.com>
Date: Mon, 25 Aug 2003 14:43:01 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Greg KH <greg@kroah.com>,
       Randy Dunlap <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>
Subject: [PATCH 4/4] Net device error logging, revised (tg3)
References: <3F4A8027.6FE3F594@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------BFB5D3C9AFDADD903AFF3D3E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BFB5D3C9AFDADD903AFF3D3E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's a patch to modify the v2.6.0-test4 tg3 driver to use netdev_* macros.

Jim Keniston
IBM Linux Technology Center
--------------BFB5D3C9AFDADD903AFF3D3E
Content-Type: text/plain; charset=us-ascii;
 name="tg3-2.6.0-test4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tg3-2.6.0-test4.patch"

diff -Naur linux.org/drivers/net/tg3.c linux.tg3.patched/drivers/net/tg3.c
--- linux.org/drivers/net/tg3.c	Mon Aug 25 13:29:39 2003
+++ linux.tg3.patched/drivers/net/tg3.c	Mon Aug 25 13:29:39 2003
@@ -489,9 +489,8 @@
 		break;
 
 	default:
-		printk(KERN_WARNING PFX "%s: Invalid power state (%d) "
-		       "requested.\n",
-		       tp->dev->name, state);
+		netdev_warn(tp->dev,, "Invalid power state (%d) "
+			"requested.\n", state);
 		return -EINVAL;
 	};
 
@@ -639,10 +638,10 @@
 static void tg3_link_report(struct tg3 *tp)
 {
 	if (!netif_carrier_ok(tp->dev)) {
-		printk(KERN_INFO PFX "%s: Link is down.\n", tp->dev->name);
+		netdev_info(tp->dev, LINK, "Link is down.\n");
 	} else {
-		printk(KERN_INFO PFX "%s: Link is up at %d Mbps, %s duplex.\n",
-		       tp->dev->name,
+		netdev_info(tp->dev, LINK,
+		       "Link is up at %d Mbps, %s duplex.\n",
 		       (tp->link_config.active_speed == SPEED_1000 ?
 			1000 :
 			(tp->link_config.active_speed == SPEED_100 ?
@@ -650,9 +649,8 @@
 		       (tp->link_config.active_duplex == DUPLEX_FULL ?
 			"full" : "half"));
 
-		printk(KERN_INFO PFX "%s: Flow control is %s for TX and "
+		netdev_info(tp->dev, LINK, "Flow control is %s for TX and "
 		       "%s for RX.\n",
-		       tp->dev->name,
 		       (tp->tg3_flags & TG3_FLAG_TX_PAUSE) ? "on" : "off",
 		       (tp->tg3_flags & TG3_FLAG_RX_PAUSE) ? "on" : "off");
 	}
@@ -2231,8 +2229,7 @@
 {
 	struct tg3 *tp = dev->priv;
 
-	printk(KERN_ERR PFX "%s: transmit timed out, resetting\n",
-	       dev->name);
+	netdev_err(dev, TX_ERR, "transmit timed out, resetting\n");
 
 	schedule_work(&tp->reset_task);
 }
@@ -2379,8 +2376,7 @@
 	if (unlikely(TX_BUFFS_AVAIL(tp) <= (skb_shinfo(skb)->nr_frags + 1))) {
 		netif_stop_queue(dev);
 		spin_unlock_irqrestore(&tp->tx_lock, flags);
-		printk(KERN_ERR PFX "%s: BUG! Tx Ring full when queue awake!\n",
-		       dev->name);
+		netdev_err(dev, TX_ERR, "BUG! Tx Ring full when queue awake!\n");
 		return 1;
 	}
 
@@ -2397,7 +2393,8 @@
 			       TXD_FLAG_CPU_POST_DMA);
 
 		if (times++ < 5) {
-			printk("tg3_xmit: tso_size[%u] tso_segs[%u] len[%u]\n",
+			netdev_info(dev,,
+			       "tg3_xmit: tso_size[%u] tso_segs[%u] len[%u]\n",
 			       (unsigned int) skb_shinfo(skb)->tso_size,
 			       (unsigned int) skb_shinfo(skb)->tso_segs,
 			       skb->len);
@@ -2571,8 +2568,7 @@
 	if (unlikely(TX_BUFFS_AVAIL(tp) <= (skb_shinfo(skb)->nr_frags + 1))) {
 		netif_stop_queue(dev);
 		spin_unlock_irqrestore(&tp->tx_lock, flags);
-		printk(KERN_ERR PFX "%s: BUG! Tx Ring full when queue awake!\n",
-		       dev->name);
+		netdev_err(dev, TX_ERR, "BUG! Tx Ring full when queue awake!\n");
 		return 1;
 	}
 
@@ -2593,7 +2589,8 @@
 			       TXD_FLAG_CPU_POST_DMA);
 
 		if (times++ < 5) {
-			printk("tg3_xmit: tso_size[%u] tso_segs[%u] len[%u]\n",
+			netdev_info(dev,,
+			       "tg3_xmit: tso_size[%u] tso_segs[%u] len[%u]\n",
 			       (unsigned int) skb_shinfo(skb)->tso_size,
 			       (unsigned int) skb_shinfo(skb)->tso_segs,
 			       skb->len);
@@ -3017,7 +3014,7 @@
 	}
 
 	if (i == MAX_WAIT_CNT) {
-		printk(KERN_ERR PFX "tg3_stop_block timed out, "
+		netdev_err(tp->dev,, "tg3_stop_block timed out, "
 		       "ofs=%lx enable_bit=%x\n",
 		       ofs, enable_bit);
 		return -ENODEV;
@@ -3070,9 +3067,9 @@
 			break;
 	}
 	if (i >= MAX_WAIT_CNT) {
-		printk(KERN_ERR PFX "tg3_abort_hw timed out for %s, "
+		netdev_err(tp->dev,, "tg3_abort_hw timed out; "
 		       "TX_MODE_ENABLE will not clear MAC_TX_MODE=%08x\n",
-		       tp->dev->name, tr32(MAC_TX_MODE));
+		       tr32(MAC_TX_MODE));
 		return -ENODEV;
 	}
 
@@ -3208,9 +3205,8 @@
 
 	if (i >= 100000 &&
 	    !(tp->tg3_flags2 & TG3_FLG2_SUN_5704)) {
-		printk(KERN_ERR PFX "tg3_halt timed out for %s, "
-		       "firmware will not restart magic=%08x\n",
-		       tp->dev->name, val);
+		netdev_err(tp->dev,, "tg3_halt timed out, "
+		       "firmware will not restart magic=%08x\n", val);
 		return -ENODEV;
 	}
 
@@ -3384,9 +3380,7 @@
 	}
 
 	if (i >= 10000) {
-		printk(KERN_ERR PFX "tg3_reset_cpu timed out for %s, "
-		       "and %s CPU\n",
-		       tp->dev->name,
+		netdev_err(tp->dev,, "tg3_reset_cpu timed out for %s CPU\n",
 		       (offset == RX_CPU_BASE ? "RX" : "TX"));
 		return -ENODEV;
 	}
@@ -3498,9 +3492,9 @@
 		udelay(1000);
 	}
 	if (i >= 5) {
-		printk(KERN_ERR PFX "tg3_load_firmware fails for %s "
+		netdev_err(tp->dev,, "tg3_load_firmware fails "
 		       "to set RX CPU PC, is %08x should be %08x\n",
-		       tp->dev->name, tr32(RX_CPU_BASE + CPU_PC),
+		       tr32(RX_CPU_BASE + CPU_PC),
 		       TG3_FW_TEXT_ADDR);
 		return -ENODEV;
 	}
@@ -3826,9 +3820,9 @@
 		udelay(1000);
 	}
 	if (i >= 5) {
-		printk(KERN_ERR PFX "tg3_load_tso_firmware fails for %s "
+		netdev_err(tp->dev,, "tg3_load_tso_firmware fails "
 		       "to set TX CPU PC, is %08x should be %08x\n",
-		       tp->dev->name, tr32(TX_CPU_BASE + CPU_PC),
+		       tr32(TX_CPU_BASE + CPU_PC),
 		       TG3_TSO_FW_TEXT_ADDR);
 		return -ENODEV;
 	}
@@ -3953,9 +3947,8 @@
 	}
 	if (i >= 100000 &&
 	    !(tp->tg3_flags2 & TG3_FLG2_SUN_5704)) {
-		printk(KERN_ERR PFX "tg3_reset_hw timed out for %s, "
-		       "firmware will not restart magic=%08x\n",
-		       tp->dev->name, val);
+		netdev_err(tp->dev,, "tg3_reset_hw timed out, "
+		       "firmware will not restart magic=%08x\n", val);
 		return -ENODEV;
 	}
 
@@ -4060,8 +4053,7 @@
 		udelay(10);
 	}
 	if (i >= 2000) {
-		printk(KERN_ERR PFX "tg3_reset_hw cannot enable BUFMGR for %s.\n",
-		       tp->dev->name);
+		netdev_err(tp->dev,, "tg3_reset_hw cannot enable BUFMGR.\n");
 		return -ENODEV;
 	}
 
@@ -4073,8 +4065,7 @@
 		udelay(10);
 	}
 	if (i >= 2000) {
-		printk(KERN_ERR PFX "tg3_reset_hw cannot reset FTQ for %s.\n",
-		       tp->dev->name);
+		netdev_err(tp->dev,, "tg3_reset_hw cannot reset FTQ.\n");
 		return -ENODEV;
 	}
 
@@ -5222,14 +5213,12 @@
   
 static u32 tg3_get_msglevel(struct net_device *dev)
 {
-	struct tg3 *tp = dev->priv;
-	return tp->msg_enable;
+	return dev->msg_enable;
 }
   
 static void tg3_set_msglevel(struct net_device *dev, u32 value)
 {
-	struct tg3 *tp = dev->priv;
-	tp->msg_enable = value;
+	dev->msg_enable = value;
 }
   
 static int tg3_nway_reset(struct net_device *dev)
@@ -5550,7 +5539,7 @@
 	int i, saw_done_clear;
 
 	if (tp->tg3_flags2 & TG3_FLG2_SUN_5704) {
-		printk(KERN_ERR PFX "Attempt to do nvram_read on Sun 5704\n");
+		netdev_err(tp->dev,, "Attempt to do nvram_read on Sun 5704\n");
 		return -EINVAL;
 	}
 
@@ -6049,7 +6038,7 @@
 	/* Force the chip into D0. */
 	err = tg3_set_power_state(tp, 0);
 	if (err) {
-		printk(KERN_ERR PFX "(%s) transition to D0 failed\n",
+		netdev_err(tp->dev,, "(%s) transition to D0 failed\n",
 		       pci_name(tp->pdev));
 		return err;
 	}
@@ -6160,7 +6149,8 @@
 
 	err = tg3_phy_probe(tp);
 	if (err) {
-		printk(KERN_ERR PFX "(%s) phy probe failed, err %d\n",
+		netdev_err(tp->dev,,
+		       "(%s) phy probe failed, err %d\n",
 		       pci_name(tp->pdev), err);
 		/* ... but do not return immediately ... */
 	}
@@ -6643,20 +6633,21 @@
 	unsigned long tg3reg_base, tg3reg_len;
 	struct net_device *dev;
 	struct tg3 *tp;
-	int i, err, pci_using_dac, pm_cap;
+	int err, pci_using_dac, pm_cap;
+	unsigned char *mac;
 
 	if (tg3_version_printed++ == 0)
 		printk(KERN_INFO "%s", version);
 
 	err = pci_enable_device(pdev);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot enable PCI device, "
+		dev_err(&pdev->dev, "Cannot enable PCI device, "
 		       "aborting.\n");
 		return err;
 	}
 
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
-		printk(KERN_ERR PFX "Cannot find proper PCI device "
+		dev_err(&pdev->dev, "Cannot find proper PCI device "
 		       "base address, aborting.\n");
 		err = -ENODEV;
 		goto err_out_disable_pdev;
@@ -6664,7 +6655,7 @@
 
 	err = pci_request_regions(pdev, DRV_MODULE_NAME);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot obtain PCI resources, "
+		dev_err(&pdev->dev, "Cannot obtain PCI resources, "
 		       "aborting.\n");
 		goto err_out_disable_pdev;
 	}
@@ -6674,7 +6665,7 @@
 	/* Find power-management capability. */
 	pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
 	if (pm_cap == 0) {
-		printk(KERN_ERR PFX "Cannot find PowerManagement capability, "
+		dev_err(&pdev->dev, "Cannot find PowerManagement capability, "
 		       "aborting.\n");
 		goto err_out_free_res;
 	}
@@ -6683,14 +6674,14 @@
 	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
 		pci_using_dac = 1;
 		if (pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL)) {
-			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
+			dev_err(&pdev->dev, "Unable to obtain 64 bit DMA "
 			       "for consistent allocations\n");
 			goto err_out_free_res;
 		}
 	} else {
 		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
 		if (err) {
-			printk(KERN_ERR PFX "No usable DMA configuration, "
+			dev_err(&pdev->dev, "No usable DMA configuration, "
 			       "aborting.\n");
 			goto err_out_free_res;
 		}
@@ -6702,7 +6693,7 @@
 
 	dev = alloc_etherdev(sizeof(*tp));
 	if (!dev) {
-		printk(KERN_ERR PFX "Etherdev alloc failed, aborting.\n");
+		dev_err(&pdev->dev, "Etherdev alloc failed, aborting.\n");
 		err = -ENOMEM;
 		goto err_out_free_res;
 	}
@@ -6727,9 +6718,9 @@
 	tp->tx_mode = TG3_DEF_TX_MODE;
 	tp->mi_mode = MAC_MI_MODE_BASE;
 	if (tg3_debug > 0)
-		tp->msg_enable = tg3_debug;
+		dev->msg_enable = tg3_debug;
 	else
-		tp->msg_enable = TG3_DEF_MSG_ENABLE;
+		dev->msg_enable = TG3_DEF_MSG_ENABLE;
 
 	/* The word/byte swap controls here control register access byte
 	 * swapping.  DMA data byte swapping is controlled in the GRC_MODE
@@ -6759,7 +6750,7 @@
 
 	tp->regs = (unsigned long) ioremap(tg3reg_base, tg3reg_len);
 	if (tp->regs == 0UL) {
-		printk(KERN_ERR PFX "Cannot map device registers, "
+		netdev_err(dev,, "Cannot map device registers, "
 		       "aborting.\n");
 		err = -ENOMEM;
 		goto err_out_free_dev;
@@ -6789,21 +6780,21 @@
 
 	err = tg3_get_invariants(tp);
 	if (err) {
-		printk(KERN_ERR PFX "Problem fetching invariants of chip, "
+		netdev_err(dev,, "Problem fetching invariants of chip, "
 		       "aborting.\n");
 		goto err_out_iounmap;
 	}
 
 	err = tg3_get_device_address(tp);
 	if (err) {
-		printk(KERN_ERR PFX "Could not obtain valid ethernet address, "
+		netdev_err(dev,, "Could not obtain valid ethernet address, "
 		       "aborting.\n");
 		goto err_out_iounmap;
 	}
 
 	err = tg3_test_dma(tp);
 	if (err) {
-		printk(KERN_ERR PFX "DMA engine test failed, aborting.\n");
+		netdev_err(dev,, "DMA engine test failed, aborting.\n");
 		goto err_out_iounmap;
 	}
 
@@ -6829,7 +6820,7 @@
 
 	err = register_netdev(dev);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot register net device, "
+		netdev_err(dev,, "Cannot register net device, "
 		       "aborting.\n");
 		goto err_out_iounmap;
 	}
@@ -6842,8 +6833,9 @@
 	 */
 	pci_save_state(tp->pdev, tp->pci_cfg_state);
 
-	printk(KERN_INFO "%s: Tigon3 [partno(%s) rev %04x PHY(%s)] (PCI%s:%s:%s) %sBaseT Ethernet ",
-	       dev->name,
+	mac = dev->dev_addr;
+	netdev_info(dev, PROBE, "Tigon3 [partno(%s) rev %04x PHY(%s)] (PCI%s:%s:%s) %sBaseT Ethernet "
+	       "%02x:%02x:%02x:%02x:%02x:%02x\n",
 	       tp->board_part_number,
 	       tp->pci_chip_rev_id,
 	       tg3_phy_string(tp),
@@ -6852,11 +6844,8 @@
 		((tp->tg3_flags & TG3_FLAG_PCIX_MODE) ? "133MHz" : "66MHz") :
 		((tp->tg3_flags & TG3_FLAG_PCIX_MODE) ? "100MHz" : "33MHz")),
 	       ((tp->tg3_flags & TG3_FLAG_PCI_32BIT) ? "32-bit" : "64-bit"),
-	       (tp->tg3_flags & TG3_FLAG_10_100_ONLY) ? "10/100" : "10/100/1000");
-
-	for (i = 0; i < 6; i++)
-		printk("%2.2x%c", dev->dev_addr[i],
-		       i == 5 ? '\n' : ':');
+	       (tp->tg3_flags & TG3_FLAG_10_100_ONLY) ? "10/100" : "10/100/1000",
+	       mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 
 	return 0;
 

--------------BFB5D3C9AFDADD903AFF3D3E--

