Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUDXFJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUDXFJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 01:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUDXFJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 01:09:53 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:38042 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261942AbUDXFI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 01:08:58 -0400
Date: Fri, 23 Apr 2004 22:08:25 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: vi and postfix ;)
MIME-Version: 1.0
To: romieu@fr.zoreil.com
Cc: luto@myrealbox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH r8169] ethtool support and sane speed selection/detection
Content-Type: text/plain; charset=us-ascii
Message-Id: <20040424050931.14C341D4F@luto.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds ethtool support to r8169.

Some notes:  I stole the RxUnderrun interrupt status bit because (1) I
don't know what a recieve underrun is, (2) the specs say that bit is
actually "link status changed" and (3) simple tests seem to confirm that.

Speed selection doesn't actually set a forced mode but just sets
autonegotiation to advertise only one speed.  (This way there is no ugly
special case for 1000Mbps.)

The link status is no longer checked on startup because it is slow and, with
ethtool support, unnecessary.

As an added benefit, my 8001S often fails to negotiate 1000Mbps when the
driver loads but will successfully negotiate it after a while.  Running
'ethtool -s ethx autoneg on' fixes it, but that's absurd.  This patch
will, ten seconds after the driver starts, check if 1000Mbps is advertised
but not selected, and, if so, force a renegotiation.

--Andy Lutomirski

Patch against 2.6.6-rc2-mm1.

--- linux-2.6.6-rc2/drivers/net/r8169.c~r8169_ethtool	2004-04-22 19:34:55.697270344 -0700
+++ linux-2.6.6-rc2/drivers/net/r8169.c	2004-04-22 21:57:40.445230744 -0700
@@ -1,11 +1,12 @@
 /*
 =========================================================================
- r8169.c: A RealTek RTL-8169 Gigabit Ethernet driver for Linux kernel 2.4.x.
+ r8169.c: A RealTek RTL-8169 Gigabit Ethernet driver for Linux kernel 2.6.x.
  --------------------------------------------------------------------
 
  History:
  Feb  4 2002	- created initially by ShuChen <shuchen@realtek.com.tw>.
  May 20 2002	- Add link status force-mode and TBI mode support.
+ Apr 22 2004	- Add ethtool support, clean up media selection.
 =========================================================================
   1. The media can be forced in 5 modes.
 	 Command: 'insmod r8169 media = SET_MEDIA'
@@ -19,6 +20,9 @@
  		_1000_Full	= 0x10
   
   2. Support TBI mode.
+
+  [UPDATE: Starting with version 1.3, the media parameter is deprecated.
+   Use ethtool instead.]
 =========================================================================
 VERSION 1.1	<2002/10/4>
 
@@ -33,6 +37,13 @@
 	- Copy mc_filter setup code from 8139cp
 	  (includes an optimization, and avoids set_bit use)
 
+VERSION 1.3	<2004/04/22>  (Andy Lutomirski - luto at myrealbox dot com)
+
+	- Add ethtool support
+	- Add linkwatch support
+	- Don't wait for link at startup
+	- If gigabit isn't negotiated at startup, try again in ten seconds
+
 */
 
 #include <linux/module.h>
@@ -50,7 +61,7 @@
 #define DMA_64BIT_MASK 0xffffffffffffffffULL
 #define DMA_32BIT_MASK 0xffffffffULL
 
-#define RTL8169_VERSION "1.2"
+#define RTL8169_VERSION "1.3"
 #define MODULENAME "r8169"
 #define RTL8169_DRIVER_NAME   MODULENAME " Gigabit Ethernet driver " RTL8169_VERSION
 #define PFX MODULENAME ": "
@@ -101,7 +112,7 @@
 
 #define RTL_MIN_IO_SIZE 0x80
 #define RTL8169_TX_TIMEOUT	(6*HZ)
-#define RTL8169_PHY_TIMEOUT	(HZ) 
+#define RTL8169_PHY_TIMEOUT	(10*HZ) 
 
 /* write/read MMIO register */
 #define RTL_W8(reg, val8)	writeb ((val8), ioaddr + (reg))
@@ -197,7 +208,7 @@
 	SWInt = 0x0100,
 	TxDescUnavail = 0x80,
 	RxFIFOOver = 0x40,
-	RxUnderrun = 0x20,
+	LinkChg = 0x20,
 	RxOverflow = 0x10,
 	TxErr = 0x08,
 	TxOK = 0x04,
@@ -327,8 +338,13 @@
 	struct sk_buff *Rx_skbuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct sk_buff *Tx_skbuff[NUM_TX_DESC];	/* Index of Transmit data buffer */
 	struct timer_list timer;
-	unsigned long phy_link_down_cnt;
+	int phy_reset_warned;
+	int phy_tried_renegotiate;
 	u16 cp_cmd;
+	int if_up;
+
+	int phy_auto_nego_reg;
+	int phy_1000_ctrl_reg;
 };
 
 MODULE_AUTHOR("Realtek");
@@ -349,7 +365,7 @@
 static struct net_device_stats *rtl8169_get_stats(struct net_device *netdev);
 
 static const u16 rtl8169_intr_mask =
-    RxUnderrun | RxOverflow | RxFIFOOver | TxErr | TxOK | RxErr | RxOK;
+    LinkChg | RxOverflow | RxFIFOOver | TxErr | TxOK | RxErr | RxOK;
 static const unsigned int rtl8169_rx_config =
     (RX_FIFO_THRESH << RxCfgFIFOShift) | (RX_DMA_BURST << RxCfgDMAShift);
 
@@ -393,6 +409,68 @@
 	return value;
 }
 
+static void rtl8169_set_speed(struct net_device *dev,
+			      u8 autoneg, u16 speed, u8 duplex)
+{
+	struct rtl8169_private *tp = dev->priv;
+	void *ioaddr = tp->mmio_addr;
+	unsigned long flags;
+	u8 status;
+
+	int auto_nego, giga_ctrl;
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	status = RTL_R8(PHYstatus);
+	if ((status & TBI_Enable) && autoneg == AUTONEG_DISABLE) {
+		autoneg = AUTONEG_ENABLE;
+		printk(KERN_WARNING PFX
+		       "%s: ignoring request to force speed in TBI mode\n",
+		       dev->name);
+	}
+
+	auto_nego = mdio_read(ioaddr, PHY_AUTO_NEGO_REG);
+	auto_nego &= ~(PHY_Cap_10_Half | PHY_Cap_10_Full |
+		       PHY_Cap_100_Half | PHY_Cap_100_Full);
+	giga_ctrl = mdio_read(ioaddr, PHY_1000_CTRL_REG);
+	giga_ctrl &= ~(PHY_Cap_1000_Full | PHY_Cap_Null);
+
+	if (autoneg == AUTONEG_ENABLE) {
+		auto_nego |= (PHY_Cap_10_Half | PHY_Cap_10_Full |
+			      PHY_Cap_100_Half | PHY_Cap_100_Full);
+		giga_ctrl |= PHY_Cap_1000_Full;
+	} else {
+		if (speed == SPEED_10)
+			auto_nego |= PHY_Cap_10_Half | PHY_Cap_10_Full;
+		else if (speed == SPEED_100)
+			auto_nego |= PHY_Cap_100_Half | PHY_Cap_100_Full;
+
+		if (speed == SPEED_1000)
+			giga_ctrl |= PHY_Cap_1000_Full;
+		else
+			giga_ctrl |= PHY_Cap_Null;
+
+		if (duplex == DUPLEX_HALF)
+			auto_nego &= ~(PHY_Cap_10_Full | PHY_Cap_100_Full);
+	}
+
+	tp->phy_auto_nego_reg = auto_nego;
+	tp->phy_1000_ctrl_reg = giga_ctrl;
+
+	if(!(status & TBI_Enable)) {
+		mdio_write(ioaddr, PHY_AUTO_NEGO_REG, auto_nego);
+		mdio_write(ioaddr, PHY_1000_CTRL_REG, giga_ctrl);
+	}
+
+	mdio_write(ioaddr, PHY_CTRL_REG,
+		   PHY_Enable_Auto_Nego | PHY_Restart_Auto_Nego);
+
+	if (tp->if_up && (giga_ctrl & PHY_Cap_1000_Full))
+		mod_timer(&tp->timer, jiffies + RTL8169_PHY_TIMEOUT);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+}
+
 static void rtl8169_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
@@ -403,8 +481,58 @@
 	strcpy(info->bus_info, pci_name(tp->pci_dev));
 }
 
+static int rtl8169_get_settings(struct net_device *dev,
+				   struct ethtool_cmd *cmd)
+{
+	struct rtl8169_private *tp = dev->priv;
+	void *ioaddr = tp->mmio_addr;
+	u8 status = RTL_R8(PHYstatus);
+
+	cmd->supported = SUPPORTED_10baseT_Half |
+			 SUPPORTED_10baseT_Full |
+			 SUPPORTED_100baseT_Half |
+			 SUPPORTED_100baseT_Full |
+			 SUPPORTED_1000baseT_Full |
+			 SUPPORTED_Autoneg |
+		         SUPPORTED_TP;
+
+	cmd->autoneg = 1;
+	cmd->advertising = ADVERTISED_TP | ADVERTISED_Autoneg;
+	if (tp->phy_auto_nego_reg & PHY_Cap_10_Half)
+		cmd->advertising |= ADVERTISED_10baseT_Half;
+	if (tp->phy_auto_nego_reg & PHY_Cap_10_Full)
+		cmd->advertising |= ADVERTISED_10baseT_Full;
+	if (tp->phy_auto_nego_reg & PHY_Cap_100_Half)
+		cmd->advertising |= ADVERTISED_100baseT_Half;
+	if (tp->phy_auto_nego_reg & PHY_Cap_100_Full)
+		cmd->advertising |= ADVERTISED_100baseT_Full;
+	if (tp->phy_1000_ctrl_reg & PHY_Cap_1000_Full)
+		cmd->advertising |= ADVERTISED_1000baseT_Full;
+
+	if (status & _1000bpsF) cmd->speed = SPEED_1000;
+	else if (status & _100bps) cmd->speed = SPEED_100;
+	else if (status & _10bps) cmd->speed = SPEED_10;
+
+	if (status & _1000bpsF || status & FullDup)
+		cmd->duplex = DUPLEX_FULL;
+	else
+		cmd->duplex = DUPLEX_HALF;
+
+	return 0;
+}
+
+static int rtl8169_set_settings(struct net_device *dev,
+				struct ethtool_cmd *cmd)
+{
+	rtl8169_set_speed(dev, cmd->autoneg, cmd->speed, cmd->duplex);
+	return 0;
+}
+
 static struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_drvinfo		= rtl8169_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_settings		= rtl8169_get_settings,
+	.set_settings		= rtl8169_set_settings,
 };
 
 static void rtl8169_write_gmii_reg_bit(void *ioaddr, int reg, int bitnum,
@@ -569,55 +697,41 @@
 	mdio_write(ioaddr, 31, 0x0000); //w 31 2 0 0
 }
 
-static void rtl8169_hw_phy_reset(struct net_device *dev)
-{
-	struct rtl8169_private *tp = dev->priv;
-	void *ioaddr = tp->mmio_addr;
-	int i, val;
-
-	printk(KERN_WARNING PFX "%s: Reset RTL8169s PHY\n", dev->name);
-
-	val = (mdio_read(ioaddr, 0) | 0x8000) & 0xffff;
-	mdio_write(ioaddr, 0, val);
-
-	for (i = 50; i >= 0; i--) {
-		if (!(mdio_read(ioaddr, 0) & 0x8000))
-			break;
-		udelay(100); /* Gross */
-	}
-
-	if (i < 0) {
-		printk(KERN_WARNING PFX "%s: no PHY Reset ack. Giving up.\n",
-		       dev->name);
-	}
-}
-
 static void rtl8169_phy_timer(unsigned long __opaque)
 {
 	struct net_device *dev = (struct net_device *)__opaque;
 	struct rtl8169_private *tp = dev->priv;
 	struct timer_list *timer = &tp->timer;
 	void *ioaddr = tp->mmio_addr;
+	int val;
+	u8 status;
 
 	assert(tp->mac_version > RTL_GIGA_MAC_VER_B);
 	assert(tp->phy_version < RTL_GIGA_PHY_VER_G);
 
-	if (RTL_R8(PHYstatus) & LinkStatus)
-		tp->phy_link_down_cnt = 0;
-	else {
-		tp->phy_link_down_cnt++;
-		if (tp->phy_link_down_cnt >= 12) {
-			int reg;
-
-			// If link on 1000, perform phy reset.
-			reg = mdio_read(ioaddr, PHY_1000_CTRL_REG);
-			if (reg & PHY_Cap_1000_Full) 
-				rtl8169_hw_phy_reset(dev);
+	if (!(tp->phy_1000_ctrl_reg & PHY_Cap_1000_Full))
+		return;
 
-			tp->phy_link_down_cnt = 0;
+	status = RTL_R8(PHYstatus);
+	if(status & LinkStatus) {
+		if (!tp->phy_tried_renegotiate && !(status & _1000bpsF)) {
+			mdio_write(ioaddr, PHY_CTRL_REG,
+			   PHY_Enable_Auto_Nego | PHY_Restart_Auto_Nego);
+			tp->phy_tried_renegotiate = 1;
 		}
+		return;
+	}
+
+	if (tp->phy_reset_warned == 0) {
+		printk(KERN_WARNING PFX
+		       "%s: Begin resetting PHY until link up\n",
+		       dev->name);
+		tp->phy_reset_warned = 1;
 	}
 
+	val = (mdio_read(ioaddr, 0) | 0x8000) & 0xffff;
+	mdio_write(ioaddr, 0, val);
+
 	mod_timer(timer, jiffies + RTL8169_PHY_TIMEOUT);
 }
 
@@ -631,8 +745,6 @@
 		return;
 
 	del_timer_sync(timer);
-
-	tp->phy_link_down_cnt = 0;
 }
 
 static inline void rtl8169_request_timer(struct net_device *dev)
@@ -644,7 +756,7 @@
 	    (tp->phy_version >= RTL_GIGA_PHY_VER_G))
 		return;
 
-	tp->phy_link_down_cnt = 0;
+	tp->phy_reset_warned = 0;
 
 	init_timer(timer);
 	timer->expires = jiffies + RTL8169_PHY_TIMEOUT;
@@ -804,7 +916,8 @@
 	static int board_idx = -1;
 	static int printed_version = 0;
 	int i, rc;
-	int option = -1, Cap10_100 = 0, Cap1000 = 0;
+	int option = -1;
+	int autoneg = AUTONEG_ENABLE, speed = SPEED_1000, duplex = DUPLEX_FULL;
 
 	assert(pdev != NULL);
 	assert(ent != NULL);
@@ -888,94 +1001,51 @@
 		mdio_write(ioaddr, 0x0b, 0x0000); //w 0x0b 15 0 0
 	}
 
-	// if TBI is not endbled
-	if (!(RTL_R8(PHYstatus) & TBI_Enable)) {
-		int val = mdio_read(ioaddr, PHY_AUTO_NEGO_REG);
-
-		option = (board_idx >= MAX_UNITS) ? 0 : media[board_idx];
-		// Force RTL8169 in 10/100/1000 Full/Half mode.
-		if (option > 0) {
-			printk(KERN_INFO "%s: Force-mode Enabled.\n",
-			       dev->name);
-			Cap10_100 = 0, Cap1000 = 0;
-			switch (option) {
-			case _10_Half:
-				Cap10_100 = PHY_Cap_10_Half_Or_Less;
-				Cap1000 = PHY_Cap_Null;
-				break;
-			case _10_Full:
-				Cap10_100 = PHY_Cap_10_Full_Or_Less;
-				Cap1000 = PHY_Cap_Null;
-				break;
-			case _100_Half:
-				Cap10_100 = PHY_Cap_100_Half_Or_Less;
-				Cap1000 = PHY_Cap_Null;
-				break;
-			case _100_Full:
-				Cap10_100 = PHY_Cap_100_Full_Or_Less;
-				Cap1000 = PHY_Cap_Null;
-				break;
-			case _1000_Full:
-				Cap10_100 = PHY_Cap_100_Full_Or_Less;
-				Cap1000 = PHY_Cap_1000_Full;
-				break;
-			default:
-				break;
-			}
-			mdio_write(ioaddr, PHY_AUTO_NEGO_REG, Cap10_100 | (val & 0x1F));	//leave PHY_AUTO_NEGO_REG bit4:0 unchanged
-			mdio_write(ioaddr, PHY_1000_CTRL_REG, Cap1000);
-		} else {
-			printk(KERN_INFO "%s: Auto-negotiation Enabled.\n",
-			       dev->name);
-
-			// enable 10/100 Full/Half Mode, leave PHY_AUTO_NEGO_REG bit4:0 unchanged
-			mdio_write(ioaddr, PHY_AUTO_NEGO_REG,
-				   PHY_Cap_100_Full_Or_Less | (val & 0x1f));
-
-			// enable 1000 Full Mode
-			mdio_write(ioaddr, PHY_1000_CTRL_REG,
-				   PHY_Cap_1000_Full);
+	rtl8169_request_timer(dev);
 
+	option = (board_idx >= MAX_UNITS) ? 0 : media[board_idx];
+	if (option > 0) {
+		printk(KERN_WARNING PFX "%s: media option is deprecated.\n",
+		       dev->name);
+		switch (option) {
+		case _10_Half:
+			autoneg = AUTONEG_DISABLE;
+			speed = SPEED_10;
+			duplex = DUPLEX_HALF;
+			break;
+		case _10_Full:
+			autoneg = AUTONEG_DISABLE;
+			speed = SPEED_10;
+			duplex = DUPLEX_FULL;
+			break;
+		case _100_Half:
+			autoneg = AUTONEG_DISABLE;
+			speed = SPEED_100;
+			duplex = DUPLEX_HALF;
+			break;
+		case _100_Full:
+			autoneg = AUTONEG_DISABLE;
+			speed = SPEED_100;
+			duplex = DUPLEX_FULL;
+			break;
+		case _1000_Full:
+			autoneg = AUTONEG_DISABLE;
+			speed = SPEED_1000;
+			duplex = DUPLEX_FULL;
+			break;
+		default:
+			break;
 		}
+	}
 
-		// Enable auto-negotiation and restart auto-nigotiation
-		mdio_write(ioaddr, PHY_CTRL_REG,
-			   PHY_Enable_Auto_Nego | PHY_Restart_Auto_Nego);
-		udelay(100);
-
-		// wait for auto-negotiation process
-		for (i = 10000; i > 0; i--) {
-			//check if auto-negotiation complete
-			if (mdio_read(ioaddr, PHY_STAT_REG) &
-			    PHY_Auto_Neco_Comp) {
-				udelay(100);
-				option = RTL_R8(PHYstatus);
-				if (option & _1000bpsF) {
-					printk(KERN_INFO
-					       "%s: 1000Mbps Full-duplex operation.\n",
-					       dev->name);
-				} else {
-					printk(KERN_INFO
-					       "%s: %sMbps %s-duplex operation.\n",
-					       dev->name,
-					       (option & _100bps) ? "100" :
-					       "10",
-					       (option & FullDup) ? "Full" :
-					       "Half");
-				}
-				break;
-			} else {
-				udelay(100);
-			}
-		}		// end for-loop to wait for auto-negotiation process
+	rtl8169_set_speed(dev, autoneg, speed, duplex);
 
-	} else {
+	if (RTL_R8(PHYstatus) & TBI_Enable) {
 		udelay(100);
 		printk(KERN_INFO
 		       "%s: 1000Mbps Full-duplex operation, TBI Link %s!\n",
 		       dev->name,
 		       (RTL_R32(TBICSR) & TBILinkOK) ? "OK" : "Failed");
-
 	}
 
 	return 0;
@@ -995,6 +1065,7 @@
 	pci_release_regions(pdev);
 
 	pci_disable_device(pdev);
+	rtl8169_delete_timer(dev);
 	free_netdev(dev);
 	pci_set_drvdata(pdev, NULL);
 }
@@ -1074,9 +1145,9 @@
 	if (retval < 0)
 		goto err_free_rx;
 
-	rtl8169_hw_start(dev);
+	tp->if_up = 1;
 
-	rtl8169_request_timer(dev);
+	rtl8169_hw_start(dev);
 out:
 	return retval;
 
@@ -1153,13 +1224,23 @@
 	/* Enable all known interrupts by setting the interrupt mask. */
 	RTL_W16(IntrMask, rtl8169_intr_mask);
 
+	/* Check for link */
+	spin_lock_irq(&tp->lock);
+	if (RTL_R8(PHYstatus) & LinkStatus)
+		netif_carrier_on(dev);
+	else {
+		netif_carrier_off(dev);
+		mod_timer(&tp->timer, jiffies + RTL8169_PHY_TIMEOUT);
+	}
+	spin_unlock_irq(&tp->lock);
+
 	netif_start_queue(dev);
 
 }
 
 static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
 {
-	desc->addr = 0x0badbadbadbadbad;
+	desc->addr = 0x0badbadbadbadbadULL;
 	desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);
 }
 
@@ -1527,6 +1608,20 @@
 		printk(KERN_EMERG "%s: Rx buffers exhausted\n", dev->name);
 }
 
+static void rtl8169_link_interrupt(struct net_device *dev,
+				   struct rtl8169_private *tp, void *ioaddr)
+{
+	spin_lock(&tp->lock);
+	if (RTL_R8(PHYstatus) & LinkStatus) {
+		netif_carrier_on(dev);
+		tp->phy_reset_warned = 0;
+	} else {
+		netif_carrier_off(dev);
+		mod_timer(&tp->timer, jiffies + RTL8169_PHY_TIMEOUT);
+	}
+	spin_unlock(&tp->lock);
+}
+
 /* The interrupt handler does all of the Rx thread work and cleans up after the Tx thread. */
 static irqreturn_t
 rtl8169_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
@@ -1546,10 +1641,8 @@
 			break;
 
 		handled = 1;
-/*
-		if (status & RxUnderrun)
-			link_changed = RTL_R16 (CSCR) & CSCR_LinkChangeBit;
-*/
+
+
 		RTL_W16(IntrStatus,
 			(status & RxFIFOOver) ? (status | RxOverflow) : status);
 
@@ -1557,7 +1650,7 @@
 			break;
 
 		// Rx interrupt 
-		if (status & (RxOK | RxUnderrun | RxOverflow | RxFIFOOver)) {
+		if (status & (RxOK | RxOverflow | RxFIFOOver)) {
 			rtl8169_rx_interrupt(dev, tp, ioaddr);
 		}
 		// Tx interrupt
@@ -1566,6 +1659,9 @@
 			rtl8169_tx_interrupt(dev, tp, ioaddr);
 			spin_unlock(&tp->lock);
 		}
+		// Link interrupt
+		if (status & LinkChg)
+			rtl8169_link_interrupt(dev, tp, ioaddr);
 
 		boguscnt--;
 	} while (boguscnt > 0);
@@ -1588,8 +1684,6 @@
 
 	netif_stop_queue(dev);
 
-	rtl8169_delete_timer(dev);
-
 	spin_lock_irq(&tp->lock);
 
 	/* Stop the chip's Tx and Rx DMA processes. */
@@ -1605,6 +1699,7 @@
 	spin_unlock_irq(&tp->lock);
 
 	synchronize_irq(dev->irq);
+	tp->if_up = 0;
 	free_irq(dev->irq, dev);
 
 	rtl8169_tx_clear(tp);
