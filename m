Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVIFUmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVIFUmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVIFUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:42:50 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:47620 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750901AbVIFUms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:42:48 -0400
Date: Tue, 6 Sep 2005 16:41:49 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.13 1/2] 3c59x: convert to use of pci_iomap API
Message-ID: <20050906204147.GC20145@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	akpm@osdl.org, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 3c59x driver to use pci_iomap API.  This makes it easier to
enable the use of memory-mapped PCI I/O resources.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/3c59x.c |  507 ++++++++++++++++++++++++++--------------------------
 1 files changed, 260 insertions(+), 247 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -602,7 +602,7 @@ MODULE_DEVICE_TABLE(pci, vortex_pci_tbl)
    First the windows.  There are eight register windows, with the command
    and status registers available in each.
    */
-#define EL3WINDOW(win_num) outw(SelectWindow + (win_num), ioaddr + EL3_CMD)
+#define EL3WINDOW(win_num) iowrite16(SelectWindow + (win_num), ioaddr + EL3_CMD)
 #define EL3_CMD 0x0e
 #define EL3_STATUS 0x0e
 
@@ -776,7 +776,8 @@ struct vortex_private {
 
 	/* PCI configuration space information. */
 	struct device *gendev;
-	char __iomem *cb_fn_base;		/* CardBus function status addr space. */
+	void __iomem *ioaddr;			/* IO address space */
+	void __iomem *cb_fn_base;		/* CardBus function status addr space. */
 
 	/* Some values here only for performance evaluation and path-coverage */
 	int rx_nocopy, rx_copy, queued_packet, rx_csumhits;
@@ -869,12 +870,12 @@ static struct {
 /* number of ETHTOOL_GSTATS u64's */
 #define VORTEX_NUM_STATS     3
 
-static int vortex_probe1(struct device *gendev, long ioaddr, int irq,
+static int vortex_probe1(struct device *gendev, void __iomem *ioaddr, int irq,
 				   int chip_idx, int card_idx);
 static void vortex_up(struct net_device *dev);
 static void vortex_down(struct net_device *dev, int final);
 static int vortex_open(struct net_device *dev);
-static void mdio_sync(long ioaddr, int bits);
+static void mdio_sync(void __iomem *ioaddr, int bits);
 static int mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *vp, int phy_id, int location, int value);
 static void vortex_timer(unsigned long arg);
@@ -887,7 +888,7 @@ static irqreturn_t vortex_interrupt(int 
 static irqreturn_t boomerang_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static int vortex_close(struct net_device *dev);
 static void dump_tx_ring(struct net_device *dev);
-static void update_stats(long ioaddr, struct net_device *dev);
+static void update_stats(void __iomem *ioaddr, struct net_device *dev);
 static struct net_device_stats *vortex_get_stats(struct net_device *dev);
 static void set_rx_mode(struct net_device *dev);
 #ifdef CONFIG_PCI
@@ -1013,18 +1014,19 @@ static struct eisa_driver vortex_eisa_dr
 
 static int vortex_eisa_probe (struct device *device)
 {
-	long ioaddr;
+	void __iomem *ioaddr;
 	struct eisa_device *edev;
 
 	edev = to_eisa_device (device);
-	ioaddr = edev->base_addr;
 
-	if (!request_region(ioaddr, VORTEX_TOTAL_SIZE, DRV_NAME))
+	if (!request_region(edev->base_addr, VORTEX_TOTAL_SIZE, DRV_NAME))
 		return -EBUSY;
 
-	if (vortex_probe1(device, ioaddr, inw(ioaddr + 0xC88) >> 12,
+	ioaddr = ioport_map(edev->base_addr, VORTEX_TOTAL_SIZE);
+
+	if (vortex_probe1(device, ioaddr, ioread16(ioaddr + 0xC88) >> 12,
 					  edev->id.driver_data, vortex_cards_found)) {
-		release_region (ioaddr, VORTEX_TOTAL_SIZE);
+		release_region (edev->base_addr, VORTEX_TOTAL_SIZE);
 		return -ENODEV;
 	}
 
@@ -1038,7 +1040,7 @@ static int vortex_eisa_remove (struct de
 	struct eisa_device *edev;
 	struct net_device *dev;
 	struct vortex_private *vp;
-	long ioaddr;
+	void __iomem *ioaddr;
 
 	edev = to_eisa_device (device);
 	dev = eisa_get_drvdata (edev);
@@ -1049,11 +1051,11 @@ static int vortex_eisa_remove (struct de
 	}
 
 	vp = netdev_priv(dev);
-	ioaddr = dev->base_addr;
+	ioaddr = vp->ioaddr;
 	
 	unregister_netdev (dev);
-	outw (TotalReset|0x14, ioaddr + EL3_CMD);
-	release_region (ioaddr, VORTEX_TOTAL_SIZE);
+	iowrite16 (TotalReset|0x14, ioaddr + EL3_CMD);
+	release_region (dev->base_addr, VORTEX_TOTAL_SIZE);
 
 	free_netdev (dev);
 	return 0;
@@ -1080,8 +1082,8 @@ static int __init vortex_eisa_init (void
 	
 	/* Special code to work-around the Compaq PCI BIOS32 problem. */
 	if (compaq_ioaddr) {
-		vortex_probe1(NULL, compaq_ioaddr, compaq_irq,
-					  compaq_device_id, vortex_cards_found++);
+		vortex_probe1(NULL, ioport_map(compaq_ioaddr, VORTEX_TOTAL_SIZE),
+			      compaq_irq, compaq_device_id, vortex_cards_found++);
 	}
 
 	return vortex_cards_found - orig_cards_found + eisa_found;
@@ -1098,8 +1100,8 @@ static int __devinit vortex_init_one (st
 	if (rc < 0)
 		goto out;
 
-	rc = vortex_probe1 (&pdev->dev, pci_resource_start (pdev, 0),
-						pdev->irq, ent->driver_data, vortex_cards_found);
+	rc = vortex_probe1 (&pdev->dev, pci_iomap(pdev, 0, 0),
+			    pdev->irq, ent->driver_data, vortex_cards_found);
 	if (rc < 0) {
 		pci_disable_device (pdev);
 		goto out;
@@ -1118,7 +1120,7 @@ out:
  * NOTE: pdev can be NULL, for the case of a Compaq device
  */
 static int __devinit vortex_probe1(struct device *gendev,
-				   long ioaddr, int irq,
+				   void __iomem *ioaddr, int irq,
 				   int chip_idx, int card_idx)
 {
 	struct vortex_private *vp;
@@ -1186,15 +1188,16 @@ static int __devinit vortex_probe1(struc
 	if (print_info)
 		printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
 
-	printk(KERN_INFO "%s: 3Com %s %s at 0x%lx. Vers " DRV_VERSION "\n",
+	printk(KERN_INFO "%s: 3Com %s %s at %p. Vers " DRV_VERSION "\n",
 	       print_name,
 	       pdev ? "PCI" : "EISA",
 	       vci->name,
 	       ioaddr);
 
-	dev->base_addr = ioaddr;
+	dev->base_addr = (unsigned long)ioaddr;
 	dev->irq = irq;
 	dev->mtu = mtu;
+	vp->ioaddr = ioaddr;
 	vp->large_frames = mtu > 1500;
 	vp->drv_flags = vci->drv_flags;
 	vp->has_nway = (vci->drv_flags & HAS_NWAY) ? 1 : 0;
@@ -1210,7 +1213,7 @@ static int __devinit vortex_probe1(struc
 	if (pdev) {
 		/* EISA resources already marked, so only PCI needs to do this here */
 		/* Ignore return value, because Cardbus drivers already allocate for us */
-		if (request_region(ioaddr, vci->io_size, print_name) != NULL)
+		if (request_region(dev->base_addr, vci->io_size, print_name) != NULL)
 			vp->must_free_region = 1;
 
 		/* enable bus-mastering if necessary */		
@@ -1300,14 +1303,14 @@ static int __devinit vortex_probe1(struc
 
 		for (i = 0; i < 0x40; i++) {
 			int timer;
-			outw(base + i, ioaddr + Wn0EepromCmd);
+			iowrite16(base + i, ioaddr + Wn0EepromCmd);
 			/* Pause for at least 162 us. for the read to take place. */
 			for (timer = 10; timer >= 0; timer--) {
 				udelay(162);
-				if ((inw(ioaddr + Wn0EepromCmd) & 0x8000) == 0)
+				if ((ioread16(ioaddr + Wn0EepromCmd) & 0x8000) == 0)
 					break;
 			}
-			eeprom[i] = inw(ioaddr + Wn0EepromData);
+			eeprom[i] = ioread16(ioaddr + Wn0EepromData);
 		}
 	}
 	for (i = 0; i < 0x18; i++)
@@ -1335,7 +1338,7 @@ static int __devinit vortex_probe1(struc
 	}
 	EL3WINDOW(2);
 	for (i = 0; i < 6; i++)
-		outb(dev->dev_addr[i], ioaddr + i);
+		iowrite8(dev->dev_addr[i], ioaddr + i);
 
 #ifdef __sparc__
 	if (print_info)
@@ -1350,7 +1353,7 @@ static int __devinit vortex_probe1(struc
 #endif
 
 	EL3WINDOW(4);
-	step = (inb(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
+	step = (ioread8(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
 	if (print_info) {
 		printk(KERN_INFO "  product code %02x%02x rev %02x.%d date %02d-"
 			"%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
@@ -1359,31 +1362,30 @@ static int __devinit vortex_probe1(struc
 
 
 	if (pdev && vci->drv_flags & HAS_CB_FNS) {
-		unsigned long fn_st_addr;			/* Cardbus function status space */
 		unsigned short n;
 
-		fn_st_addr = pci_resource_start (pdev, 2);
-		if (fn_st_addr) {
-			vp->cb_fn_base = ioremap(fn_st_addr, 128);
+		vp->cb_fn_base = pci_iomap(pdev, 2, 0);
+		if (!vp->cb_fn_base) {
 			retval = -ENOMEM;
-			if (!vp->cb_fn_base)
-				goto free_ring;
+			goto free_ring;
 		}
+		
 		if (print_info) {
 			printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
-				print_name, fn_st_addr, vp->cb_fn_base);
+				print_name, pci_resource_start(pdev, 2),
+				vp->cb_fn_base);
 		}
 		EL3WINDOW(2);
 
-		n = inw(ioaddr + Wn2_ResetOptions) & ~0x4010;
+		n = ioread16(ioaddr + Wn2_ResetOptions) & ~0x4010;
 		if (vp->drv_flags & INVERT_LED_PWR)
 			n |= 0x10;
 		if (vp->drv_flags & INVERT_MII_PWR)
 			n |= 0x4000;
-		outw(n, ioaddr + Wn2_ResetOptions);
+		iowrite16(n, ioaddr + Wn2_ResetOptions);
 		if (vp->drv_flags & WNO_XCVR_PWR) {
 			EL3WINDOW(0);
-			outw(0x0800, ioaddr);
+			iowrite16(0x0800, ioaddr);
 		}
 	}
 
@@ -1402,13 +1404,13 @@ static int __devinit vortex_probe1(struc
 		static const char * ram_split[] = {"5:3", "3:1", "1:1", "3:5"};
 		unsigned int config;
 		EL3WINDOW(3);
-		vp->available_media = inw(ioaddr + Wn3_Options);
+		vp->available_media = ioread16(ioaddr + Wn3_Options);
 		if ((vp->available_media & 0xff) == 0)		/* Broken 3c916 */
 			vp->available_media = 0x40;
-		config = inl(ioaddr + Wn3_Config);
+		config = ioread32(ioaddr + Wn3_Config);
 		if (print_info) {
 			printk(KERN_DEBUG "  Internal config register is %4.4x, "
-				   "transceivers %#x.\n", config, inw(ioaddr + Wn3_Options));
+				   "transceivers %#x.\n", config, ioread16(ioaddr + Wn3_Options));
 			printk(KERN_INFO "  %dK %s-wide RAM %s Rx:Tx split, %s%s interface.\n",
 				   8 << RAM_SIZE(config),
 				   RAM_WIDTH(config) ? "word" : "byte",
@@ -1539,7 +1541,7 @@ free_ring:
 						vp->rx_ring_dma);
 free_region:
 	if (vp->must_free_region)
-		release_region(ioaddr, vci->io_size);
+		release_region(dev->base_addr, vci->io_size);
 	free_netdev(dev);
 	printk(KERN_ERR PFX "vortex_probe1 fails.  Returns %d\n", retval);
 out:
@@ -1549,17 +1551,19 @@ out:
 static void
 issue_and_wait(struct net_device *dev, int cmd)
 {
+	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	int i;
 
-	outw(cmd, dev->base_addr + EL3_CMD);
+	iowrite16(cmd, ioaddr + EL3_CMD);
 	for (i = 0; i < 2000; i++) {
-		if (!(inw(dev->base_addr + EL3_STATUS) & CmdInProgress))
+		if (!(ioread16(ioaddr + EL3_STATUS) & CmdInProgress))
 			return;
 	}
 
 	/* OK, that didn't work.  Do it the slow way.  One second */
 	for (i = 0; i < 100000; i++) {
-		if (!(inw(dev->base_addr + EL3_STATUS) & CmdInProgress)) {
+		if (!(ioread16(ioaddr + EL3_STATUS) & CmdInProgress)) {
 			if (vortex_debug > 1)
 				printk(KERN_INFO "%s: command 0x%04x took %d usecs\n",
 					   dev->name, cmd, i * 10);
@@ -1568,14 +1572,14 @@ issue_and_wait(struct net_device *dev, i
 		udelay(10);
 	}
 	printk(KERN_ERR "%s: command 0x%04x did not complete! Status=0x%x\n",
-			   dev->name, cmd, inw(dev->base_addr + EL3_STATUS));
+			   dev->name, cmd, ioread16(ioaddr + EL3_STATUS));
 }
 
 static void
 vortex_up(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
 	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned int config;
 	int i;
 
@@ -1588,7 +1592,7 @@ vortex_up(struct net_device *dev)
 
 	/* Before initializing select the active media port. */
 	EL3WINDOW(3);
-	config = inl(ioaddr + Wn3_Config);
+	config = ioread32(ioaddr + Wn3_Config);
 
 	if (vp->media_override != 7) {
 		printk(KERN_INFO "%s: Media override to transceiver %d (%s).\n",
@@ -1635,7 +1639,7 @@ vortex_up(struct net_device *dev)
 	config = BFINS(config, dev->if_port, 20, 4);
 	if (vortex_debug > 6)
 		printk(KERN_DEBUG "vortex_up(): writing 0x%x to InternalConfig\n", config);
-	outl(config, ioaddr + Wn3_Config);
+	iowrite32(config, ioaddr + Wn3_Config);
 
 	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
 		int mii_reg1, mii_reg5;
@@ -1663,7 +1667,7 @@ vortex_up(struct net_device *dev)
 	}
 
 	/* Set the full-duplex bit. */
-	outw(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
+	iowrite16(	((vp->info1 & 0x8000) || vp->full_duplex ? 0x20 : 0) |
 		 	(vp->large_frames ? 0x40 : 0) |
 			((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 			ioaddr + Wn3_MAC_Ctrl);
@@ -1679,51 +1683,51 @@ vortex_up(struct net_device *dev)
 	 */
 	issue_and_wait(dev, RxReset|0x04);
 
-	outw(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
+	iowrite16(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
 
 	if (vortex_debug > 1) {
 		EL3WINDOW(4);
 		printk(KERN_DEBUG "%s: vortex_up() irq %d media status %4.4x.\n",
-			   dev->name, dev->irq, inw(ioaddr + Wn4_Media));
+			   dev->name, dev->irq, ioread16(ioaddr + Wn4_Media));
 	}
 
 	/* Set the station address and mask in window 2 each time opened. */
 	EL3WINDOW(2);
 	for (i = 0; i < 6; i++)
-		outb(dev->dev_addr[i], ioaddr + i);
+		iowrite8(dev->dev_addr[i], ioaddr + i);
 	for (; i < 12; i+=2)
-		outw(0, ioaddr + i);
+		iowrite16(0, ioaddr + i);
 
 	if (vp->cb_fn_base) {
-		unsigned short n = inw(ioaddr + Wn2_ResetOptions) & ~0x4010;
+		unsigned short n = ioread16(ioaddr + Wn2_ResetOptions) & ~0x4010;
 		if (vp->drv_flags & INVERT_LED_PWR)
 			n |= 0x10;
 		if (vp->drv_flags & INVERT_MII_PWR)
 			n |= 0x4000;
-		outw(n, ioaddr + Wn2_ResetOptions);
+		iowrite16(n, ioaddr + Wn2_ResetOptions);
 	}
 
 	if (dev->if_port == XCVR_10base2)
 		/* Start the thinnet transceiver. We should really wait 50ms...*/
-		outw(StartCoax, ioaddr + EL3_CMD);
+		iowrite16(StartCoax, ioaddr + EL3_CMD);
 	if (dev->if_port != XCVR_NWAY) {
 		EL3WINDOW(4);
-		outw((inw(ioaddr + Wn4_Media) & ~(Media_10TP|Media_SQE)) |
+		iowrite16((ioread16(ioaddr + Wn4_Media) & ~(Media_10TP|Media_SQE)) |
 			 media_tbl[dev->if_port].media_bits, ioaddr + Wn4_Media);
 	}
 
 	/* Switch to the stats window, and clear all stats by reading. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
+	iowrite16(StatsDisable, ioaddr + EL3_CMD);
 	EL3WINDOW(6);
 	for (i = 0; i < 10; i++)
-		inb(ioaddr + i);
-	inw(ioaddr + 10);
-	inw(ioaddr + 12);
+		ioread8(ioaddr + i);
+	ioread16(ioaddr + 10);
+	ioread16(ioaddr + 12);
 	/* New: On the Vortex we must also clear the BadSSD counter. */
 	EL3WINDOW(4);
-	inb(ioaddr + 12);
+	ioread8(ioaddr + 12);
 	/* ..and on the Boomerang we enable the extra statistics bits. */
-	outw(0x0040, ioaddr + Wn4_NetDiag);
+	iowrite16(0x0040, ioaddr + Wn4_NetDiag);
 
 	/* Switch to register set 7 for normal use. */
 	EL3WINDOW(7);
@@ -1731,30 +1735,30 @@ vortex_up(struct net_device *dev)
 	if (vp->full_bus_master_rx) { /* Boomerang bus master. */
 		vp->cur_rx = vp->dirty_rx = 0;
 		/* Initialize the RxEarly register as recommended. */
-		outw(SetRxThreshold + (1536>>2), ioaddr + EL3_CMD);
-		outl(0x0020, ioaddr + PktStatus);
-		outl(vp->rx_ring_dma, ioaddr + UpListPtr);
+		iowrite16(SetRxThreshold + (1536>>2), ioaddr + EL3_CMD);
+		iowrite32(0x0020, ioaddr + PktStatus);
+		iowrite32(vp->rx_ring_dma, ioaddr + UpListPtr);
 	}
 	if (vp->full_bus_master_tx) { 		/* Boomerang bus master Tx. */
 		vp->cur_tx = vp->dirty_tx = 0;
 		if (vp->drv_flags & IS_BOOMERANG)
-			outb(PKT_BUF_SZ>>8, ioaddr + TxFreeThreshold); /* Room for a packet. */
+			iowrite8(PKT_BUF_SZ>>8, ioaddr + TxFreeThreshold); /* Room for a packet. */
 		/* Clear the Rx, Tx rings. */
 		for (i = 0; i < RX_RING_SIZE; i++)	/* AKPM: this is done in vortex_open, too */
 			vp->rx_ring[i].status = 0;
 		for (i = 0; i < TX_RING_SIZE; i++)
 			vp->tx_skbuff[i] = NULL;
-		outl(0, ioaddr + DownListPtr);
+		iowrite32(0, ioaddr + DownListPtr);
 	}
 	/* Set receiver mode: presumably accept b-case and phys addr only. */
 	set_rx_mode(dev);
 	/* enable 802.1q tagged frames */
 	set_8021q_mode(dev, 1);
-	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
+	iowrite16(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
 //	issue_and_wait(dev, SetTxStart|0x07ff);
-	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
-	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
+	iowrite16(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
+	iowrite16(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
 	/* Allow status bits to be seen. */
 	vp->status_enable = SetStatusEnb | HostError|IntReq|StatsFull|TxComplete|
 		(vp->full_bus_master_tx ? DownComplete : TxAvailable) |
@@ -1764,13 +1768,13 @@ vortex_up(struct net_device *dev)
 		(vp->full_bus_master_rx ? 0 : RxComplete) |
 		StatsFull | HostError | TxComplete | IntReq
 		| (vp->bus_master ? DMADone : 0) | UpComplete | DownComplete;
-	outw(vp->status_enable, ioaddr + EL3_CMD);
+	iowrite16(vp->status_enable, ioaddr + EL3_CMD);
 	/* Ack all pending events, and set active indicator mask. */
-	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
+	iowrite16(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
 		 ioaddr + EL3_CMD);
-	outw(vp->intr_enable, ioaddr + EL3_CMD);
+	iowrite16(vp->intr_enable, ioaddr + EL3_CMD);
 	if (vp->cb_fn_base)			/* The PCMCIA people are idiots.  */
-		writel(0x8000, vp->cb_fn_base + 4);
+		iowrite32(0x8000, vp->cb_fn_base + 4);
 	netif_start_queue (dev);
 }
 
@@ -1836,7 +1840,7 @@ vortex_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	int next_tick = 60*HZ;
 	int ok = 0;
 	int media_status, mii_status, old_window;
@@ -1850,9 +1854,9 @@ vortex_timer(unsigned long data)
 	if (vp->medialock)
 		goto leave_media_alone;
 	disable_irq(dev->irq);
-	old_window = inw(ioaddr + EL3_CMD) >> 13;
+	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
 	EL3WINDOW(4);
-	media_status = inw(ioaddr + Wn4_Media);
+	media_status = ioread16(ioaddr + Wn4_Media);
 	switch (dev->if_port) {
 	case XCVR_10baseT:  case XCVR_100baseTx:  case XCVR_100baseFx:
 		if (media_status & Media_LnkBeat) {
@@ -1892,7 +1896,7 @@ vortex_timer(unsigned long data)
 							vp->phys[0], mii_reg5);
 						/* Set the full-duplex bit. */
 						EL3WINDOW(3);
-						outw(	(vp->full_duplex ? 0x20 : 0) |
+						iowrite16(	(vp->full_duplex ? 0x20 : 0) |
 								(vp->large_frames ? 0x40 : 0) |
 								((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ? 0x100 : 0),
 								ioaddr + Wn3_MAC_Ctrl);
@@ -1933,15 +1937,15 @@ vortex_timer(unsigned long data)
 					   dev->name, media_tbl[dev->if_port].name);
 			next_tick = media_tbl[dev->if_port].wait;
 		}
-		outw((media_status & ~(Media_10TP|Media_SQE)) |
+		iowrite16((media_status & ~(Media_10TP|Media_SQE)) |
 			 media_tbl[dev->if_port].media_bits, ioaddr + Wn4_Media);
 
 		EL3WINDOW(3);
-		config = inl(ioaddr + Wn3_Config);
+		config = ioread32(ioaddr + Wn3_Config);
 		config = BFINS(config, dev->if_port, 20, 4);
-		outl(config, ioaddr + Wn3_Config);
+		iowrite32(config, ioaddr + Wn3_Config);
 
-		outw(dev->if_port == XCVR_10base2 ? StartCoax : StopCoax,
+		iowrite16(dev->if_port == XCVR_10base2 ? StartCoax : StopCoax,
 			 ioaddr + EL3_CMD);
 		if (vortex_debug > 1)
 			printk(KERN_DEBUG "wrote 0x%08x to Wn3_Config\n", config);
@@ -1957,29 +1961,29 @@ leave_media_alone:
 
 	mod_timer(&vp->timer, RUN_AT(next_tick));
 	if (vp->deferred)
-		outw(FakeIntr, ioaddr + EL3_CMD);
+		iowrite16(FakeIntr, ioaddr + EL3_CMD);
 	return;
 }
 
 static void vortex_tx_timeout(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 
 	printk(KERN_ERR "%s: transmit timed out, tx_status %2.2x status %4.4x.\n",
-		   dev->name, inb(ioaddr + TxStatus),
-		   inw(ioaddr + EL3_STATUS));
+		   dev->name, ioread8(ioaddr + TxStatus),
+		   ioread16(ioaddr + EL3_STATUS));
 	EL3WINDOW(4);
 	printk(KERN_ERR "  diagnostics: net %04x media %04x dma %08x fifo %04x\n",
-			inw(ioaddr + Wn4_NetDiag),
-			inw(ioaddr + Wn4_Media),
-			inl(ioaddr + PktStatus),
-			inw(ioaddr + Wn4_FIFODiag));
+			ioread16(ioaddr + Wn4_NetDiag),
+			ioread16(ioaddr + Wn4_Media),
+			ioread32(ioaddr + PktStatus),
+			ioread16(ioaddr + Wn4_FIFODiag));
 	/* Slight code bloat to be user friendly. */
-	if ((inb(ioaddr + TxStatus) & 0x88) == 0x88)
+	if ((ioread8(ioaddr + TxStatus) & 0x88) == 0x88)
 		printk(KERN_ERR "%s: Transmitter encountered 16 collisions --"
 			   " network cable problem?\n", dev->name);
-	if (inw(ioaddr + EL3_STATUS) & IntLatch) {
+	if (ioread16(ioaddr + EL3_STATUS) & IntLatch) {
 		printk(KERN_ERR "%s: Interrupt posted but not delivered --"
 			   " IRQ blocked by another device?\n", dev->name);
 		/* Bad idea here.. but we might as well handle a few events. */
@@ -2005,21 +2009,21 @@ static void vortex_tx_timeout(struct net
 	vp->stats.tx_errors++;
 	if (vp->full_bus_master_tx) {
 		printk(KERN_DEBUG "%s: Resetting the Tx ring pointer.\n", dev->name);
-		if (vp->cur_tx - vp->dirty_tx > 0  &&  inl(ioaddr + DownListPtr) == 0)
-			outl(vp->tx_ring_dma + (vp->dirty_tx % TX_RING_SIZE) * sizeof(struct boom_tx_desc),
+		if (vp->cur_tx - vp->dirty_tx > 0  &&  ioread32(ioaddr + DownListPtr) == 0)
+			iowrite32(vp->tx_ring_dma + (vp->dirty_tx % TX_RING_SIZE) * sizeof(struct boom_tx_desc),
 				 ioaddr + DownListPtr);
 		if (vp->cur_tx - vp->dirty_tx < TX_RING_SIZE)
 			netif_wake_queue (dev);
 		if (vp->drv_flags & IS_BOOMERANG)
-			outb(PKT_BUF_SZ>>8, ioaddr + TxFreeThreshold);
-		outw(DownUnstall, ioaddr + EL3_CMD);
+			iowrite8(PKT_BUF_SZ>>8, ioaddr + TxFreeThreshold);
+		iowrite16(DownUnstall, ioaddr + EL3_CMD);
 	} else {
 		vp->stats.tx_dropped++;
 		netif_wake_queue(dev);
 	}
 	
 	/* Issue Tx Enable */
-	outw(TxEnable, ioaddr + EL3_CMD);
+	iowrite16(TxEnable, ioaddr + EL3_CMD);
 	dev->trans_start = jiffies;
 	
 	/* Switch to register set 7 for normal use. */
@@ -2034,7 +2038,7 @@ static void
 vortex_error(struct net_device *dev, int status)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	int do_tx_reset = 0, reset_mask = 0;
 	unsigned char tx_status = 0;
 
@@ -2043,7 +2047,7 @@ vortex_error(struct net_device *dev, int
 	}
 
 	if (status & TxComplete) {			/* Really "TxError" for us. */
-		tx_status = inb(ioaddr + TxStatus);
+		tx_status = ioread8(ioaddr + TxStatus);
 		/* Presumably a tx-timeout. We must merely re-enable. */
 		if (vortex_debug > 2
 			|| (tx_status != 0x88 && vortex_debug > 0)) {
@@ -2057,20 +2061,20 @@ vortex_error(struct net_device *dev, int
 		}
 		if (tx_status & 0x14)  vp->stats.tx_fifo_errors++;
 		if (tx_status & 0x38)  vp->stats.tx_aborted_errors++;
-		outb(0, ioaddr + TxStatus);
+		iowrite8(0, ioaddr + TxStatus);
 		if (tx_status & 0x30) {			/* txJabber or txUnderrun */
 			do_tx_reset = 1;
 		} else if ((tx_status & 0x08) && (vp->drv_flags & MAX_COLLISION_RESET)) {	/* maxCollisions */
 			do_tx_reset = 1;
 			reset_mask = 0x0108;		/* Reset interface logic, but not download logic */
 		} else {						/* Merely re-enable the transmitter. */
-			outw(TxEnable, ioaddr + EL3_CMD);
+			iowrite16(TxEnable, ioaddr + EL3_CMD);
 		}
 	}
 
 	if (status & RxEarly) {				/* Rx early is unused. */
 		vortex_rx(dev);
-		outw(AckIntr | RxEarly, ioaddr + EL3_CMD);
+		iowrite16(AckIntr | RxEarly, ioaddr + EL3_CMD);
 	}
 	if (status & StatsFull) {			/* Empty statistics. */
 		static int DoneDidThat;
@@ -2080,29 +2084,29 @@ vortex_error(struct net_device *dev, int
 		/* HACK: Disable statistics as an interrupt source. */
 		/* This occurs when we have the wrong media type! */
 		if (DoneDidThat == 0  &&
-			inw(ioaddr + EL3_STATUS) & StatsFull) {
+			ioread16(ioaddr + EL3_STATUS) & StatsFull) {
 			printk(KERN_WARNING "%s: Updating statistics failed, disabling "
 				   "stats as an interrupt source.\n", dev->name);
 			EL3WINDOW(5);
-			outw(SetIntrEnb | (inw(ioaddr + 10) & ~StatsFull), ioaddr + EL3_CMD);
+			iowrite16(SetIntrEnb | (ioread16(ioaddr + 10) & ~StatsFull), ioaddr + EL3_CMD);
 			vp->intr_enable &= ~StatsFull;
 			EL3WINDOW(7);
 			DoneDidThat++;
 		}
 	}
 	if (status & IntReq) {		/* Restore all interrupt sources.  */
-		outw(vp->status_enable, ioaddr + EL3_CMD);
-		outw(vp->intr_enable, ioaddr + EL3_CMD);
+		iowrite16(vp->status_enable, ioaddr + EL3_CMD);
+		iowrite16(vp->intr_enable, ioaddr + EL3_CMD);
 	}
 	if (status & HostError) {
 		u16 fifo_diag;
 		EL3WINDOW(4);
-		fifo_diag = inw(ioaddr + Wn4_FIFODiag);
+		fifo_diag = ioread16(ioaddr + Wn4_FIFODiag);
 		printk(KERN_ERR "%s: Host error, FIFO diagnostic register %4.4x.\n",
 			   dev->name, fifo_diag);
 		/* Adapter failure requires Tx/Rx reset and reinit. */
 		if (vp->full_bus_master_tx) {
-			int bus_status = inl(ioaddr + PktStatus);
+			int bus_status = ioread32(ioaddr + PktStatus);
 			/* 0x80000000 PCI master abort. */
 			/* 0x40000000 PCI target abort. */
 			if (vortex_debug)
@@ -2122,14 +2126,14 @@ vortex_error(struct net_device *dev, int
 			set_rx_mode(dev);
 			/* enable 802.1q VLAN tagged frames */
 			set_8021q_mode(dev, 1);
-			outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
-			outw(AckIntr | HostError, ioaddr + EL3_CMD);
+			iowrite16(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
+			iowrite16(AckIntr | HostError, ioaddr + EL3_CMD);
 		}
 	}
 
 	if (do_tx_reset) {
 		issue_and_wait(dev, TxReset|reset_mask);
-		outw(TxEnable, ioaddr + EL3_CMD);
+		iowrite16(TxEnable, ioaddr + EL3_CMD);
 		if (!vp->full_bus_master_tx)
 			netif_wake_queue(dev);
 	}
@@ -2139,29 +2143,29 @@ static int
 vortex_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 
 	/* Put out the doubleword header... */
-	outl(skb->len, ioaddr + TX_FIFO);
+	iowrite32(skb->len, ioaddr + TX_FIFO);
 	if (vp->bus_master) {
 		/* Set the bus-master controller to transfer the packet. */
 		int len = (skb->len + 3) & ~3;
-		outl(	vp->tx_skb_dma = pci_map_single(VORTEX_PCI(vp), skb->data, len, PCI_DMA_TODEVICE),
+		iowrite32(	vp->tx_skb_dma = pci_map_single(VORTEX_PCI(vp), skb->data, len, PCI_DMA_TODEVICE),
 				ioaddr + Wn7_MasterAddr);
-		outw(len, ioaddr + Wn7_MasterLen);
+		iowrite16(len, ioaddr + Wn7_MasterLen);
 		vp->tx_skb = skb;
-		outw(StartDMADown, ioaddr + EL3_CMD);
+		iowrite16(StartDMADown, ioaddr + EL3_CMD);
 		/* netif_wake_queue() will be called at the DMADone interrupt. */
 	} else {
 		/* ... and the packet rounded to a doubleword. */
-		outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
+		iowrite32_rep(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
 		dev_kfree_skb (skb);
-		if (inw(ioaddr + TxFree) > 1536) {
+		if (ioread16(ioaddr + TxFree) > 1536) {
 			netif_start_queue (dev);	/* AKPM: redundant? */
 		} else {
 			/* Interrupt us when the FIFO has room for max-sized packet. */
 			netif_stop_queue(dev);
-			outw(SetTxThreshold + (1536>>2), ioaddr + EL3_CMD);
+			iowrite16(SetTxThreshold + (1536>>2), ioaddr + EL3_CMD);
 		}
 	}
 
@@ -2172,7 +2176,7 @@ vortex_start_xmit(struct sk_buff *skb, s
 		int tx_status;
 		int i = 32;
 
-		while (--i > 0	&&	(tx_status = inb(ioaddr + TxStatus)) > 0) {
+		while (--i > 0	&&	(tx_status = ioread8(ioaddr + TxStatus)) > 0) {
 			if (tx_status & 0x3C) {		/* A Tx-disabling error occurred.  */
 				if (vortex_debug > 2)
 				  printk(KERN_DEBUG "%s: Tx error, status %2.2x.\n",
@@ -2182,9 +2186,9 @@ vortex_start_xmit(struct sk_buff *skb, s
 				if (tx_status & 0x30) {
 					issue_and_wait(dev, TxReset);
 				}
-				outw(TxEnable, ioaddr + EL3_CMD);
+				iowrite16(TxEnable, ioaddr + EL3_CMD);
 			}
-			outb(0x00, ioaddr + TxStatus); /* Pop the status stack. */
+			iowrite8(0x00, ioaddr + TxStatus); /* Pop the status stack. */
 		}
 	}
 	return 0;
@@ -2194,7 +2198,7 @@ static int
 boomerang_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	/* Calculate the next Tx descriptor entry. */
 	int entry = vp->cur_tx % TX_RING_SIZE;
 	struct boom_tx_desc *prev_entry = &vp->tx_ring[(vp->cur_tx-1) % TX_RING_SIZE];
@@ -2258,8 +2262,8 @@ boomerang_start_xmit(struct sk_buff *skb
 	/* Wait for the stall to complete. */
 	issue_and_wait(dev, DownStall);
 	prev_entry->next = cpu_to_le32(vp->tx_ring_dma + entry * sizeof(struct boom_tx_desc));
-	if (inl(ioaddr + DownListPtr) == 0) {
-		outl(vp->tx_ring_dma + entry * sizeof(struct boom_tx_desc), ioaddr + DownListPtr);
+	if (ioread32(ioaddr + DownListPtr) == 0) {
+		iowrite32(vp->tx_ring_dma + entry * sizeof(struct boom_tx_desc), ioaddr + DownListPtr);
 		vp->queued_packet++;
 	}
 
@@ -2274,7 +2278,7 @@ boomerang_start_xmit(struct sk_buff *skb
 		prev_entry->status &= cpu_to_le32(~TxIntrUploaded);
 #endif
 	}
-	outw(DownUnstall, ioaddr + EL3_CMD);
+	iowrite16(DownUnstall, ioaddr + EL3_CMD);
 	spin_unlock_irqrestore(&vp->lock, flags);
 	dev->trans_start = jiffies;
 	return 0;
@@ -2293,15 +2297,15 @@ vortex_interrupt(int irq, void *dev_id, 
 {
 	struct net_device *dev = dev_id;
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr;
+	void __iomem *ioaddr;
 	int status;
 	int work_done = max_interrupt_work;
 	int handled = 0;
 
-	ioaddr = dev->base_addr;
+	ioaddr = vp->ioaddr;
 	spin_lock(&vp->lock);
 
-	status = inw(ioaddr + EL3_STATUS);
+	status = ioread16(ioaddr + EL3_STATUS);
 
 	if (vortex_debug > 6)
 		printk("vortex_interrupt(). status=0x%4x\n", status);
@@ -2320,7 +2324,7 @@ vortex_interrupt(int irq, void *dev_id, 
 
 	if (vortex_debug > 4)
 		printk(KERN_DEBUG "%s: interrupt, status %4.4x, latency %d ticks.\n",
-			   dev->name, status, inb(ioaddr + Timer));
+			   dev->name, status, ioread8(ioaddr + Timer));
 
 	do {
 		if (vortex_debug > 5)
@@ -2333,16 +2337,16 @@ vortex_interrupt(int irq, void *dev_id, 
 			if (vortex_debug > 5)
 				printk(KERN_DEBUG "	TX room bit was handled.\n");
 			/* There's room in the FIFO for a full-sized packet. */
-			outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
+			iowrite16(AckIntr | TxAvailable, ioaddr + EL3_CMD);
 			netif_wake_queue (dev);
 		}
 
 		if (status & DMADone) {
-			if (inw(ioaddr + Wn7_MasterStatus) & 0x1000) {
-				outw(0x1000, ioaddr + Wn7_MasterStatus); /* Ack the event. */
+			if (ioread16(ioaddr + Wn7_MasterStatus) & 0x1000) {
+				iowrite16(0x1000, ioaddr + Wn7_MasterStatus); /* Ack the event. */
 				pci_unmap_single(VORTEX_PCI(vp), vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, PCI_DMA_TODEVICE);
 				dev_kfree_skb_irq(vp->tx_skb); /* Release the transferred buffer */
-				if (inw(ioaddr + TxFree) > 1536) {
+				if (ioread16(ioaddr + TxFree) > 1536) {
 					/*
 					 * AKPM: FIXME: I don't think we need this.  If the queue was stopped due to
 					 * insufficient FIFO room, the TxAvailable test will succeed and call
@@ -2350,7 +2354,7 @@ vortex_interrupt(int irq, void *dev_id, 
 					 */
 					netif_wake_queue(dev);
 				} else { /* Interrupt when FIFO has room for max-sized packet. */
-					outw(SetTxThreshold + (1536>>2), ioaddr + EL3_CMD);
+					iowrite16(SetTxThreshold + (1536>>2), ioaddr + EL3_CMD);
 					netif_stop_queue(dev);
 				}
 			}
@@ -2368,17 +2372,17 @@ vortex_interrupt(int irq, void *dev_id, 
 			/* Disable all pending interrupts. */
 			do {
 				vp->deferred |= status;
-				outw(SetStatusEnb | (~vp->deferred & vp->status_enable),
+				iowrite16(SetStatusEnb | (~vp->deferred & vp->status_enable),
 					 ioaddr + EL3_CMD);
-				outw(AckIntr | (vp->deferred & 0x7ff), ioaddr + EL3_CMD);
-			} while ((status = inw(ioaddr + EL3_CMD)) & IntLatch);
+				iowrite16(AckIntr | (vp->deferred & 0x7ff), ioaddr + EL3_CMD);
+			} while ((status = ioread16(ioaddr + EL3_CMD)) & IntLatch);
 			/* The timer will reenable interrupts. */
 			mod_timer(&vp->timer, jiffies + 1*HZ);
 			break;
 		}
 		/* Acknowledge the IRQ. */
-		outw(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD);
-	} while ((status = inw(ioaddr + EL3_STATUS)) & (IntLatch | RxComplete));
+		iowrite16(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD);
+	} while ((status = ioread16(ioaddr + EL3_STATUS)) & (IntLatch | RxComplete));
 
 	if (vortex_debug > 4)
 		printk(KERN_DEBUG "%s: exiting interrupt, status %4.4x.\n",
@@ -2398,11 +2402,11 @@ boomerang_interrupt(int irq, void *dev_i
 {
 	struct net_device *dev = dev_id;
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr;
+	void __iomem *ioaddr;
 	int status;
 	int work_done = max_interrupt_work;
 
-	ioaddr = dev->base_addr;
+	ioaddr = vp->ioaddr;
 
 	/*
 	 * It seems dopey to put the spinlock this early, but we could race against vortex_tx_timeout
@@ -2410,7 +2414,7 @@ boomerang_interrupt(int irq, void *dev_i
 	 */
 	spin_lock(&vp->lock);
 
-	status = inw(ioaddr + EL3_STATUS);
+	status = ioread16(ioaddr + EL3_STATUS);
 
 	if (vortex_debug > 6)
 		printk(KERN_DEBUG "boomerang_interrupt. status=0x%4x\n", status);
@@ -2431,13 +2435,13 @@ boomerang_interrupt(int irq, void *dev_i
 
 	if (vortex_debug > 4)
 		printk(KERN_DEBUG "%s: interrupt, status %4.4x, latency %d ticks.\n",
-			   dev->name, status, inb(ioaddr + Timer));
+			   dev->name, status, ioread8(ioaddr + Timer));
 	do {
 		if (vortex_debug > 5)
 				printk(KERN_DEBUG "%s: In interrupt loop, status %4.4x.\n",
 					   dev->name, status);
 		if (status & UpComplete) {
-			outw(AckIntr | UpComplete, ioaddr + EL3_CMD);
+			iowrite16(AckIntr | UpComplete, ioaddr + EL3_CMD);
 			if (vortex_debug > 5)
 				printk(KERN_DEBUG "boomerang_interrupt->boomerang_rx\n");
 			boomerang_rx(dev);
@@ -2446,11 +2450,11 @@ boomerang_interrupt(int irq, void *dev_i
 		if (status & DownComplete) {
 			unsigned int dirty_tx = vp->dirty_tx;
 
-			outw(AckIntr | DownComplete, ioaddr + EL3_CMD);
+			iowrite16(AckIntr | DownComplete, ioaddr + EL3_CMD);
 			while (vp->cur_tx - dirty_tx > 0) {
 				int entry = dirty_tx % TX_RING_SIZE;
 #if 1	/* AKPM: the latter is faster, but cyclone-only */
-				if (inl(ioaddr + DownListPtr) ==
+				if (ioread32(ioaddr + DownListPtr) ==
 					vp->tx_ring_dma + entry * sizeof(struct boom_tx_desc))
 					break;			/* It still hasn't been processed. */
 #else
@@ -2497,20 +2501,20 @@ boomerang_interrupt(int irq, void *dev_i
 			/* Disable all pending interrupts. */
 			do {
 				vp->deferred |= status;
-				outw(SetStatusEnb | (~vp->deferred & vp->status_enable),
+				iowrite16(SetStatusEnb | (~vp->deferred & vp->status_enable),
 					 ioaddr + EL3_CMD);
-				outw(AckIntr | (vp->deferred & 0x7ff), ioaddr + EL3_CMD);
-			} while ((status = inw(ioaddr + EL3_CMD)) & IntLatch);
+				iowrite16(AckIntr | (vp->deferred & 0x7ff), ioaddr + EL3_CMD);
+			} while ((status = ioread16(ioaddr + EL3_CMD)) & IntLatch);
 			/* The timer will reenable interrupts. */
 			mod_timer(&vp->timer, jiffies + 1*HZ);
 			break;
 		}
 		/* Acknowledge the IRQ. */
-		outw(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD);
+		iowrite16(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD);
 		if (vp->cb_fn_base)			/* The PCMCIA people are idiots.  */
-			writel(0x8000, vp->cb_fn_base + 4);
+			iowrite32(0x8000, vp->cb_fn_base + 4);
 
-	} while ((status = inw(ioaddr + EL3_STATUS)) & IntLatch);
+	} while ((status = ioread16(ioaddr + EL3_STATUS)) & IntLatch);
 
 	if (vortex_debug > 4)
 		printk(KERN_DEBUG "%s: exiting interrupt, status %4.4x.\n",
@@ -2523,16 +2527,16 @@ handler_exit:
 static int vortex_rx(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	int i;
 	short rx_status;
 
 	if (vortex_debug > 5)
 		printk(KERN_DEBUG "vortex_rx(): status %4.4x, rx_status %4.4x.\n",
-			   inw(ioaddr+EL3_STATUS), inw(ioaddr+RxStatus));
-	while ((rx_status = inw(ioaddr + RxStatus)) > 0) {
+			   ioread16(ioaddr+EL3_STATUS), ioread16(ioaddr+RxStatus));
+	while ((rx_status = ioread16(ioaddr + RxStatus)) > 0) {
 		if (rx_status & 0x4000) { /* Error, update stats. */
-			unsigned char rx_error = inb(ioaddr + RxErrors);
+			unsigned char rx_error = ioread8(ioaddr + RxErrors);
 			if (vortex_debug > 2)
 				printk(KERN_DEBUG " Rx error: status %2.2x.\n", rx_error);
 			vp->stats.rx_errors++;
@@ -2555,27 +2559,28 @@ static int vortex_rx(struct net_device *
 				skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				if (vp->bus_master &&
-					! (inw(ioaddr + Wn7_MasterStatus) & 0x8000)) {
+					! (ioread16(ioaddr + Wn7_MasterStatus) & 0x8000)) {
 					dma_addr_t dma = pci_map_single(VORTEX_PCI(vp), skb_put(skb, pkt_len),
 									   pkt_len, PCI_DMA_FROMDEVICE);
-					outl(dma, ioaddr + Wn7_MasterAddr);
-					outw((skb->len + 3) & ~3, ioaddr + Wn7_MasterLen);
-					outw(StartDMAUp, ioaddr + EL3_CMD);
-					while (inw(ioaddr + Wn7_MasterStatus) & 0x8000)
+					iowrite32(dma, ioaddr + Wn7_MasterAddr);
+					iowrite16((skb->len + 3) & ~3, ioaddr + Wn7_MasterLen);
+					iowrite16(StartDMAUp, ioaddr + EL3_CMD);
+					while (ioread16(ioaddr + Wn7_MasterStatus) & 0x8000)
 						;
 					pci_unmap_single(VORTEX_PCI(vp), dma, pkt_len, PCI_DMA_FROMDEVICE);
 				} else {
-					insl(ioaddr + RX_FIFO, skb_put(skb, pkt_len),
-						 (pkt_len + 3) >> 2);
+					ioread32_rep(ioaddr + RX_FIFO,
+					             skb_put(skb, pkt_len),
+						     (pkt_len + 3) >> 2);
 				}
-				outw(RxDiscard, ioaddr + EL3_CMD); /* Pop top Rx packet. */
+				iowrite16(RxDiscard, ioaddr + EL3_CMD); /* Pop top Rx packet. */
 				skb->protocol = eth_type_trans(skb, dev);
 				netif_rx(skb);
 				dev->last_rx = jiffies;
 				vp->stats.rx_packets++;
 				/* Wait a limited time to go to next packet. */
 				for (i = 200; i >= 0; i--)
-					if ( ! (inw(ioaddr + EL3_STATUS) & CmdInProgress))
+					if ( ! (ioread16(ioaddr + EL3_STATUS) & CmdInProgress))
 						break;
 				continue;
 			} else if (vortex_debug > 0)
@@ -2594,12 +2599,12 @@ boomerang_rx(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
 	int entry = vp->cur_rx % RX_RING_SIZE;
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	int rx_status;
 	int rx_work_limit = vp->dirty_rx + RX_RING_SIZE - vp->cur_rx;
 
 	if (vortex_debug > 5)
-		printk(KERN_DEBUG "boomerang_rx(): status %4.4x\n", inw(ioaddr+EL3_STATUS));
+		printk(KERN_DEBUG "boomerang_rx(): status %4.4x\n", ioread16(ioaddr+EL3_STATUS));
 
 	while ((rx_status = le32_to_cpu(vp->rx_ring[entry].status)) & RxDComplete){
 		if (--rx_work_limit < 0)
@@ -2682,7 +2687,7 @@ boomerang_rx(struct net_device *dev)
 			vp->rx_skbuff[entry] = skb;
 		}
 		vp->rx_ring[entry].status = 0;	/* Clear complete bit. */
-		outw(UpUnstall, ioaddr + EL3_CMD);
+		iowrite16(UpUnstall, ioaddr + EL3_CMD);
 	}
 	return 0;
 }
@@ -2711,7 +2716,7 @@ static void
 vortex_down(struct net_device *dev, int final_down)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 
 	netif_stop_queue (dev);
 
@@ -2719,26 +2724,26 @@ vortex_down(struct net_device *dev, int 
 	del_timer_sync(&vp->timer);
 
 	/* Turn off statistics ASAP.  We update vp->stats below. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
+	iowrite16(StatsDisable, ioaddr + EL3_CMD);
 
 	/* Disable the receiver and transmitter. */
-	outw(RxDisable, ioaddr + EL3_CMD);
-	outw(TxDisable, ioaddr + EL3_CMD);
+	iowrite16(RxDisable, ioaddr + EL3_CMD);
+	iowrite16(TxDisable, ioaddr + EL3_CMD);
 
 	/* Disable receiving 802.1q tagged frames */
 	set_8021q_mode(dev, 0);
 
 	if (dev->if_port == XCVR_10base2)
 		/* Turn off thinnet power.  Green! */
-		outw(StopCoax, ioaddr + EL3_CMD);
+		iowrite16(StopCoax, ioaddr + EL3_CMD);
 
-	outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
+	iowrite16(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
 
 	update_stats(ioaddr, dev);
 	if (vp->full_bus_master_rx)
-		outl(0, ioaddr + UpListPtr);
+		iowrite32(0, ioaddr + UpListPtr);
 	if (vp->full_bus_master_tx)
-		outl(0, ioaddr + DownListPtr);
+		iowrite32(0, ioaddr + DownListPtr);
 
 	if (final_down && VORTEX_PCI(vp)) {
 		vp->pm_state_valid = 1;
@@ -2751,7 +2756,7 @@ static int
 vortex_close(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	int i;
 
 	if (netif_device_present(dev))
@@ -2759,7 +2764,7 @@ vortex_close(struct net_device *dev)
 
 	if (vortex_debug > 1) {
 		printk(KERN_DEBUG"%s: vortex_close() status %4.4x, Tx status %2.2x.\n",
-			   dev->name, inw(ioaddr + EL3_STATUS), inb(ioaddr + TxStatus));
+			   dev->name, ioread16(ioaddr + EL3_STATUS), ioread8(ioaddr + TxStatus));
 		printk(KERN_DEBUG "%s: vortex close stats: rx_nocopy %d rx_copy %d"
 			   " tx_queued %d Rx pre-checksummed %d.\n",
 			   dev->name, vp->rx_nocopy, vp->rx_copy, vp->queued_packet, vp->rx_csumhits);
@@ -2813,18 +2818,18 @@ dump_tx_ring(struct net_device *dev)
 {
 	if (vortex_debug > 0) {
 	struct vortex_private *vp = netdev_priv(dev);
-		long ioaddr = dev->base_addr;
+		void __iomem *ioaddr = vp->ioaddr;
 		
 		if (vp->full_bus_master_tx) {
 			int i;
-			int stalled = inl(ioaddr + PktStatus) & 0x04;	/* Possible racy. But it's only debug stuff */
+			int stalled = ioread32(ioaddr + PktStatus) & 0x04;	/* Possible racy. But it's only debug stuff */
 
 			printk(KERN_ERR "  Flags; bus-master %d, dirty %d(%d) current %d(%d)\n",
 					vp->full_bus_master_tx,
 					vp->dirty_tx, vp->dirty_tx % TX_RING_SIZE,
 					vp->cur_tx, vp->cur_tx % TX_RING_SIZE);
 			printk(KERN_ERR "  Transmit list %8.8x vs. %p.\n",
-				   inl(ioaddr + DownListPtr),
+				   ioread32(ioaddr + DownListPtr),
 				   &vp->tx_ring[vp->dirty_tx % TX_RING_SIZE]);
 			issue_and_wait(dev, DownStall);
 			for (i = 0; i < TX_RING_SIZE; i++) {
@@ -2838,7 +2843,7 @@ dump_tx_ring(struct net_device *dev)
 					   le32_to_cpu(vp->tx_ring[i].status));
 			}
 			if (!stalled)
-				outw(DownUnstall, ioaddr + EL3_CMD);
+				iowrite16(DownUnstall, ioaddr + EL3_CMD);
 		}
 	}
 }
@@ -2846,11 +2851,12 @@ dump_tx_ring(struct net_device *dev)
 static struct net_device_stats *vortex_get_stats(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 
 	if (netif_device_present(dev)) {	/* AKPM: Used to be netif_running */
 		spin_lock_irqsave (&vp->lock, flags);
-		update_stats(dev->base_addr, dev);
+		update_stats(ioaddr, dev);
 		spin_unlock_irqrestore (&vp->lock, flags);
 	}
 	return &vp->stats;
@@ -2863,37 +2869,37 @@ static struct net_device_stats *vortex_g
 	table.  This is done by checking that the ASM (!) code generated uses
 	atomic updates with '+='.
 	*/
-static void update_stats(long ioaddr, struct net_device *dev)
+static void update_stats(void __iomem *ioaddr, struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	int old_window = inw(ioaddr + EL3_CMD);
+	int old_window = ioread16(ioaddr + EL3_CMD);
 
 	if (old_window == 0xffff)	/* Chip suspended or ejected. */
 		return;
 	/* Unlike the 3c5x9 we need not turn off stats updates while reading. */
 	/* Switch to the stats window, and read everything. */
 	EL3WINDOW(6);
-	vp->stats.tx_carrier_errors		+= inb(ioaddr + 0);
-	vp->stats.tx_heartbeat_errors		+= inb(ioaddr + 1);
-	vp->stats.collisions			+= inb(ioaddr + 3);
-	vp->stats.tx_window_errors		+= inb(ioaddr + 4);
-	vp->stats.rx_fifo_errors		+= inb(ioaddr + 5);
-	vp->stats.tx_packets			+= inb(ioaddr + 6);
-	vp->stats.tx_packets			+= (inb(ioaddr + 9)&0x30) << 4;
-	/* Rx packets	*/			inb(ioaddr + 7);   /* Must read to clear */
+	vp->stats.tx_carrier_errors		+= ioread8(ioaddr + 0);
+	vp->stats.tx_heartbeat_errors		+= ioread8(ioaddr + 1);
+	vp->stats.collisions			+= ioread8(ioaddr + 3);
+	vp->stats.tx_window_errors		+= ioread8(ioaddr + 4);
+	vp->stats.rx_fifo_errors		+= ioread8(ioaddr + 5);
+	vp->stats.tx_packets			+= ioread8(ioaddr + 6);
+	vp->stats.tx_packets			+= (ioread8(ioaddr + 9)&0x30) << 4;
+	/* Rx packets	*/			ioread8(ioaddr + 7);   /* Must read to clear */
 	/* Don't bother with register 9, an extension of registers 6&7.
 	   If we do use the 6&7 values the atomic update assumption above
 	   is invalid. */
-	vp->stats.rx_bytes 			+= inw(ioaddr + 10);
-	vp->stats.tx_bytes 			+= inw(ioaddr + 12);
+	vp->stats.rx_bytes 			+= ioread16(ioaddr + 10);
+	vp->stats.tx_bytes 			+= ioread16(ioaddr + 12);
 	/* Extra stats for get_ethtool_stats() */
-	vp->xstats.tx_multiple_collisions	+= inb(ioaddr + 2);
-	vp->xstats.tx_deferred			+= inb(ioaddr + 8);
+	vp->xstats.tx_multiple_collisions	+= ioread8(ioaddr + 2);
+	vp->xstats.tx_deferred			+= ioread8(ioaddr + 8);
 	EL3WINDOW(4);
-	vp->xstats.rx_bad_ssd			+= inb(ioaddr + 12);
+	vp->xstats.rx_bad_ssd			+= ioread8(ioaddr + 12);
 
 	{
-		u8 up = inb(ioaddr + 13);
+		u8 up = ioread8(ioaddr + 13);
 		vp->stats.rx_bytes += (up & 0x0f) << 16;
 		vp->stats.tx_bytes += (up & 0xf0) << 12;
 	}
@@ -2905,7 +2911,7 @@ static void update_stats(long ioaddr, st
 static int vortex_nway_reset(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 	int rc;
 
@@ -2919,7 +2925,7 @@ static int vortex_nway_reset(struct net_
 static u32 vortex_get_link(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 	int rc;
 
@@ -2933,7 +2939,7 @@ static u32 vortex_get_link(struct net_de
 static int vortex_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 	int rc;
 
@@ -2947,7 +2953,7 @@ static int vortex_get_settings(struct ne
 static int vortex_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 	int rc;
 
@@ -2977,10 +2983,11 @@ static void vortex_get_ethtool_stats(str
 	struct ethtool_stats *stats, u64 *data)
 {
 	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vp->lock, flags);
-	update_stats(dev->base_addr, dev);
+	update_stats(ioaddr, dev);
 	spin_unlock_irqrestore(&vp->lock, flags);
 
 	data[0] = vp->xstats.tx_deferred;
@@ -3040,7 +3047,7 @@ static int vortex_ioctl(struct net_devic
 {
 	int err;
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 	unsigned long flags;
 	int state = 0;
 
@@ -3068,7 +3075,8 @@ static int vortex_ioctl(struct net_devic
    the chip has a very clean way to set the mode, unlike many others. */
 static void set_rx_mode(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
+	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	int new_mode;
 
 	if (dev->flags & IFF_PROMISC) {
@@ -3080,7 +3088,7 @@ static void set_rx_mode(struct net_devic
 	} else
 		new_mode = SetRxFilter | RxStation | RxBroadcast;
 
-	outw(new_mode, ioaddr + EL3_CMD);
+	iowrite16(new_mode, ioaddr + EL3_CMD);
 }
 
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
@@ -3094,8 +3102,8 @@ static void set_rx_mode(struct net_devic
 static void set_8021q_mode(struct net_device *dev, int enable)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	int old_window = inw(ioaddr + EL3_CMD);
+	void __iomem *ioaddr = vp->ioaddr;
+	int old_window = ioread16(ioaddr + EL3_CMD);
 	int mac_ctrl;
 
 	if ((vp->drv_flags&IS_CYCLONE) || (vp->drv_flags&IS_TORNADO)) {
@@ -3107,24 +3115,24 @@ static void set_8021q_mode(struct net_de
 			max_pkt_size += 4;	/* 802.1Q VLAN tag */
 
 		EL3WINDOW(3);
-		outw(max_pkt_size, ioaddr+Wn3_MaxPktSize);
+		iowrite16(max_pkt_size, ioaddr+Wn3_MaxPktSize);
 
 		/* set VlanEtherType to let the hardware checksumming
 		   treat tagged frames correctly */
 		EL3WINDOW(7);
-		outw(VLAN_ETHER_TYPE, ioaddr+Wn7_VlanEtherType);
+		iowrite16(VLAN_ETHER_TYPE, ioaddr+Wn7_VlanEtherType);
 	} else {
 		/* on older cards we have to enable large frames */
 
 		vp->large_frames = dev->mtu > 1500 || enable;
 
 		EL3WINDOW(3);
-		mac_ctrl = inw(ioaddr+Wn3_MAC_Ctrl);
+		mac_ctrl = ioread16(ioaddr+Wn3_MAC_Ctrl);
 		if (vp->large_frames)
 			mac_ctrl |= 0x40;
 		else
 			mac_ctrl &= ~0x40;
-		outw(mac_ctrl, ioaddr+Wn3_MAC_Ctrl);
+		iowrite16(mac_ctrl, ioaddr+Wn3_MAC_Ctrl);
 	}
 
 	EL3WINDOW(old_window);
@@ -3146,7 +3154,7 @@ static void set_8021q_mode(struct net_de
 /* The maximum data clock rate is 2.5 Mhz.  The minimum timing is usually
    met by back-to-back PCI I/O cycles, but we insert a delay to avoid
    "overclocking" issues. */
-#define mdio_delay() inl(mdio_addr)
+#define mdio_delay() ioread32(mdio_addr)
 
 #define MDIO_SHIFT_CLK	0x01
 #define MDIO_DIR_WRITE	0x04
@@ -3157,15 +3165,15 @@ static void set_8021q_mode(struct net_de
 
 /* Generate the preamble required for initial synchronization and
    a few older transceivers. */
-static void mdio_sync(long ioaddr, int bits)
+static void mdio_sync(void __iomem *ioaddr, int bits)
 {
-	long mdio_addr = ioaddr + Wn4_PhysicalMgmt;
+	void __iomem *mdio_addr = ioaddr + Wn4_PhysicalMgmt;
 
 	/* Establish sync by sending at least 32 logic ones. */
 	while (-- bits >= 0) {
-		outw(MDIO_DATA_WRITE1, mdio_addr);
+		iowrite16(MDIO_DATA_WRITE1, mdio_addr);
 		mdio_delay();
-		outw(MDIO_DATA_WRITE1 | MDIO_SHIFT_CLK, mdio_addr);
+		iowrite16(MDIO_DATA_WRITE1 | MDIO_SHIFT_CLK, mdio_addr);
 		mdio_delay();
 	}
 }
@@ -3173,10 +3181,11 @@ static void mdio_sync(long ioaddr, int b
 static int mdio_read(struct net_device *dev, int phy_id, int location)
 {
 	int i;
-	long ioaddr = dev->base_addr;
+	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	int read_cmd = (0xf6 << 10) | (phy_id << 5) | location;
 	unsigned int retval = 0;
-	long mdio_addr = ioaddr + Wn4_PhysicalMgmt;
+	void __iomem *mdio_addr = ioaddr + Wn4_PhysicalMgmt;
 
 	if (mii_preamble_required)
 		mdio_sync(ioaddr, 32);
@@ -3184,17 +3193,17 @@ static int mdio_read(struct net_device *
 	/* Shift the read command bits out. */
 	for (i = 14; i >= 0; i--) {
 		int dataval = (read_cmd&(1<<i)) ? MDIO_DATA_WRITE1 : MDIO_DATA_WRITE0;
-		outw(dataval, mdio_addr);
+		iowrite16(dataval, mdio_addr);
 		mdio_delay();
-		outw(dataval | MDIO_SHIFT_CLK, mdio_addr);
+		iowrite16(dataval | MDIO_SHIFT_CLK, mdio_addr);
 		mdio_delay();
 	}
 	/* Read the two transition, 16 data, and wire-idle bits. */
 	for (i = 19; i > 0; i--) {
-		outw(MDIO_ENB_IN, mdio_addr);
+		iowrite16(MDIO_ENB_IN, mdio_addr);
 		mdio_delay();
-		retval = (retval << 1) | ((inw(mdio_addr) & MDIO_DATA_READ) ? 1 : 0);
-		outw(MDIO_ENB_IN | MDIO_SHIFT_CLK, mdio_addr);
+		retval = (retval << 1) | ((ioread16(mdio_addr) & MDIO_DATA_READ) ? 1 : 0);
+		iowrite16(MDIO_ENB_IN | MDIO_SHIFT_CLK, mdio_addr);
 		mdio_delay();
 	}
 	return retval & 0x20000 ? 0xffff : retval>>1 & 0xffff;
@@ -3202,9 +3211,10 @@ static int mdio_read(struct net_device *
 
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
 {
-	long ioaddr = dev->base_addr;
+	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
 	int write_cmd = 0x50020000 | (phy_id << 23) | (location << 18) | value;
-	long mdio_addr = ioaddr + Wn4_PhysicalMgmt;
+	void __iomem *mdio_addr = ioaddr + Wn4_PhysicalMgmt;
 	int i;
 
 	if (mii_preamble_required)
@@ -3213,16 +3223,16 @@ static void mdio_write(struct net_device
 	/* Shift the command bits out. */
 	for (i = 31; i >= 0; i--) {
 		int dataval = (write_cmd&(1<<i)) ? MDIO_DATA_WRITE1 : MDIO_DATA_WRITE0;
-		outw(dataval, mdio_addr);
+		iowrite16(dataval, mdio_addr);
 		mdio_delay();
-		outw(dataval | MDIO_SHIFT_CLK, mdio_addr);
+		iowrite16(dataval | MDIO_SHIFT_CLK, mdio_addr);
 		mdio_delay();
 	}
 	/* Leave the interface idle. */
 	for (i = 1; i >= 0; i--) {
-		outw(MDIO_ENB_IN, mdio_addr);
+		iowrite16(MDIO_ENB_IN, mdio_addr);
 		mdio_delay();
-		outw(MDIO_ENB_IN | MDIO_SHIFT_CLK, mdio_addr);
+		iowrite16(MDIO_ENB_IN | MDIO_SHIFT_CLK, mdio_addr);
 		mdio_delay();
 	}
 	return;
@@ -3233,15 +3243,15 @@ static void mdio_write(struct net_device
 static void acpi_set_WOL(struct net_device *dev)
 {
 	struct vortex_private *vp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = vp->ioaddr;
 
 	if (vp->enable_wol) {
 		/* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
 		EL3WINDOW(7);
-		outw(2, ioaddr + 0x0c);
+		iowrite16(2, ioaddr + 0x0c);
 		/* The RxFilter must accept the WOL frames. */
-		outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
-		outw(RxEnable, ioaddr + EL3_CMD);
+		iowrite16(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
+		iowrite16(RxEnable, ioaddr + EL3_CMD);
 
 		pci_enable_wake(VORTEX_PCI(vp), 0, 1);
 
@@ -3263,10 +3273,9 @@ static void __devexit vortex_remove_one 
 
 	vp = netdev_priv(dev);
 
-	/* AKPM: FIXME: we should have
-	 *	if (vp->cb_fn_base) iounmap(vp->cb_fn_base);
-	 * here
-	 */
+	if (vp->cb_fn_base)
+		pci_iounmap(VORTEX_PCI(vp), vp->cb_fn_base);
+
 	unregister_netdev(dev);
 
 	if (VORTEX_PCI(vp)) {
@@ -3276,8 +3285,10 @@ static void __devexit vortex_remove_one 
 		pci_disable_device(VORTEX_PCI(vp));
 	}
 	/* Should really use issue_and_wait() here */
-	outw(TotalReset | ((vp->drv_flags & EEPROM_RESET) ? 0x04 : 0x14),
-	     dev->base_addr + EL3_CMD);
+	iowrite16(TotalReset | ((vp->drv_flags & EEPROM_RESET) ? 0x04 : 0x14),
+	     vp->ioaddr + EL3_CMD);
+
+	pci_iounmap(VORTEX_PCI(vp), vp->ioaddr);
 
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
@@ -3325,7 +3336,7 @@ static int __init vortex_init (void)
 static void __exit vortex_eisa_cleanup (void)
 {
 	struct vortex_private *vp;
-	long ioaddr;
+	void __iomem *ioaddr;
 
 #ifdef CONFIG_EISA
 	/* Take care of the EISA devices */
@@ -3334,11 +3345,13 @@ static void __exit vortex_eisa_cleanup (
 	
 	if (compaq_net_device) {
 		vp = compaq_net_device->priv;
-		ioaddr = compaq_net_device->base_addr;
+		ioaddr = ioport_map(compaq_net_device->base_addr,
+		                    VORTEX_TOTAL_SIZE);
 
 		unregister_netdev (compaq_net_device);
-		outw (TotalReset, ioaddr + EL3_CMD);
-		release_region (ioaddr, VORTEX_TOTAL_SIZE);
+		iowrite16 (TotalReset, ioaddr + EL3_CMD);
+		release_region(compaq_net_device->base_addr,
+		               VORTEX_TOTAL_SIZE);
 
 		free_netdev (compaq_net_device);
 	}
-- 
John W. Linville
linville@tuxdriver.com
