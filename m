Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVBXAJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVBXAJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVBWXy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:54:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54745 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261686AbVBWXja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:39:30 -0500
Message-ID: <421D141C.4030602@pobox.com>
Date: Wed, 23 Feb 2005 18:39:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Francois Romieu <romieu@fr.zoreil.com>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x r8169 update
Content-Type: multipart/mixed;
 boundary="------------090502080105020908050300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502080105020908050300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Any chance to convince the alien who took control of Jeff's libata queue to
> push:
> 
> r8169: synchronization and balancing when the device is closed
> 
> (1.1982.1.58 ?)
> 
> Test case on current 2.6.11-rc4:
> - ifconfig ethX 10.0.0.1 up
> - ifconfig ethX down
> - ifconfig ethX 10.0.0.1 up
>   -> Rx does not work any more
> - ifconfig ethX down
>   -> command hangs


Agree it needs fixing, but I actually think the rx-offset stuff is more 
urgent than this.  For the future, it would be useful for both of us to 
have separate r8169-fixes and r8169-cleanups queues.

Anyway, here it is:

[see attached]



--------------090502080105020908050300
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 drivers/net/r8169.c |  218 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 138 insertions(+), 80 deletions(-)

through these ChangeSets:

François Romieu:
  o r8169: factor out some code
  o r8169: IRQ races during change of mtu
  o r8169: uniformize comments
  o r8169: removal of unused #define
  o r8169: skb alignment nitpicking
  o r8169: fix rx skb allocation error logging
  o r8169: synchronization and balancing when the device is closed
  o r8169: screaming irq when the device is closed
  o r8169: typo in debugging code
  o r8169: merge of Realtek's code
  o r8169: endianness fixes


--------------090502080105020908050300
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	2005-02-23 18:33:11 -05:00
+++ b/drivers/net/r8169.c	2005-02-23 18:33:11 -05:00
@@ -41,7 +41,14 @@
 	- Suspend/resume
 	- Endianness
 	- Misc Rx/Tx bugs
-*/
+
+VERSION 2.2LK	<2005/01/25>
+
+	- RX csum, TX csum/SG, TSO
+	- VLAN
+	- baby (< 7200) Jumbo frames support
+	- Merge of Realtek's version 2.2 (new phy)
+ */
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -62,7 +69,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#define RTL8169_VERSION "1.6LK"
+#define RTL8169_VERSION "2.2LK"
 #define MODULENAME "r8169"
 #define PFX MODULENAME ": "
 
@@ -72,7 +79,7 @@
 	        printk( "Assertion failed! %s,%s,%s,line=%d\n",	\
         	#expr,__FILE__,__FUNCTION__,__LINE__);		\
         }
-#define dprintk(fmt, args...)	do { printk(PFX fmt, ## args) } while (0)
+#define dprintk(fmt, args...)	do { printk(PFX fmt, ## args); } while (0)
 #else
 #define assert(expr) do {} while (0)
 #define dprintk(fmt, args...)	do {} while (0)
@@ -100,15 +107,13 @@
 static int max_interrupt_work = 20;
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
-   The RTL chips use a 64 element hash table based on the Ethernet CRC.  */
+   The RTL chips use a 64 element hash table based on the Ethernet CRC. */
 static int multicast_filter_limit = 32;
 
-/* MAC address length*/
+/* MAC address length */
 #define MAC_ADDR_LEN	6
 
-#define TX_FIFO_THRESH 256	/* In bytes */
-
-#define RX_FIFO_THRESH	7	/* 7 means NO threshold, Rx buffer level before first PCI xfer.  */
+#define RX_FIFO_THRESH	7	/* 7 means NO threshold, Rx buffer level before first PCI xfer. */
 #define RX_DMA_BURST	6	/* Maximum PCI burst, '6' is 1024 */
 #define TX_DMA_BURST	6	/* Maximum PCI burst, '6' is 1024 */
 #define EarlyTxThld 	0x3F	/* 0x3F means NO early transmit */
@@ -149,6 +154,7 @@
 	RTL_GIGA_PHY_VER_E = 0x05, /* PHY Reg 0x03 bit0-3 == 0x0000 */
 	RTL_GIGA_PHY_VER_F = 0x06, /* PHY Reg 0x03 bit0-3 == 0x0001 */
 	RTL_GIGA_PHY_VER_G = 0x07, /* PHY Reg 0x03 bit0-3 == 0x0002 */
+	RTL_GIGA_PHY_VER_H = 0x08, /* PHY Reg 0x03 bit0-3 == 0x0003 */
 };
 
 
@@ -162,7 +168,8 @@
 } rtl_chip_info[] = {
 	_R("RTL8169",		RTL_GIGA_MAC_VER_B, 0xff7e1880),
 	_R("RTL8169s/8110s",	RTL_GIGA_MAC_VER_D, 0xff7e1880),
-	_R("RTL8169s/8110s",	RTL_GIGA_MAC_VER_E, 0xff7e1880)
+	_R("RTL8169s/8110s",	RTL_GIGA_MAC_VER_E, 0xff7e1880),
+	_R("RTL8169s/8110s",	RTL_GIGA_MAC_VER_X, 0xff7e1880),
 };
 #undef _R
 
@@ -208,6 +215,7 @@
 	PHYstatus = 0x6C,
 	RxMaxSize = 0xDA,
 	CPlusCmd = 0xE0,
+	IntrMitigate = 0xE2,
 	RxDescAddrLow = 0xE4,
 	RxDescAddrHigh = 0xE8,
 	EarlyTxThres = 0xEC,
@@ -218,7 +226,7 @@
 };
 
 enum RTL8169_register_content {
-	/*InterruptStatusBits */
+	/* InterruptStatusBits */
 	SYSErr = 0x8000,
 	PCSTimeout = 0x4000,
 	SWInt = 0x0100,
@@ -231,23 +239,23 @@
 	RxErr = 0x02,
 	RxOK = 0x01,
 
-	/*RxStatusDesc */
+	/* RxStatusDesc */
 	RxRES = 0x00200000,
 	RxCRC = 0x00080000,
 	RxRUNT = 0x00100000,
 	RxRWT = 0x00400000,
 
-	/*ChipCmdBits */
+	/* ChipCmdBits */
 	CmdReset = 0x10,
 	CmdRxEnb = 0x08,
 	CmdTxEnb = 0x04,
 	RxBufEmpty = 0x01,
 
-	/*Cfg9346Bits */
+	/* Cfg9346Bits */
 	Cfg9346_Lock = 0x00,
 	Cfg9346_Unlock = 0xC0,
 
-	/*rx_mode_bits */
+	/* rx_mode_bits */
 	AcceptErr = 0x20,
 	AcceptRunt = 0x10,
 	AcceptBroadcast = 0x08,
@@ -255,11 +263,11 @@
 	AcceptMyPhys = 0x02,
 	AcceptAllPhys = 0x01,
 
-	/*RxConfigBits */
+	/* RxConfigBits */
 	RxCfgFIFOShift = 13,
 	RxCfgDMAShift = 8,
 
-	/*TxConfigBits */
+	/* TxConfigBits */
 	TxInterFrameGapShift = 24,
 	TxDMAShift = 8,	/* DMA burst value (0-7) is shift this many bits */
 
@@ -277,7 +285,7 @@
 	PCIDAC		= (1 << 4),
 	PCIMulRW	= (1 << 3),
 
-	/*rtl8169_PHYstatus */
+	/* rtl8169_PHYstatus */
 	TBI_Enable = 0x80,
 	TxFlowCtrl = 0x40,
 	RxFlowCtrl = 0x20,
@@ -287,38 +295,38 @@
 	LinkStatus = 0x02,
 	FullDup = 0x01,
 
-	/*GIGABIT_PHY_registers */
+	/* GIGABIT_PHY_registers */
 	PHY_CTRL_REG = 0,
 	PHY_STAT_REG = 1,
 	PHY_AUTO_NEGO_REG = 4,
 	PHY_1000_CTRL_REG = 9,
 
-	/*GIGABIT_PHY_REG_BIT */
+	/* GIGABIT_PHY_REG_BIT */
 	PHY_Restart_Auto_Nego = 0x0200,
 	PHY_Enable_Auto_Nego = 0x1000,
 
-	//PHY_STAT_REG = 1;
+	/* PHY_STAT_REG = 1 */
 	PHY_Auto_Neco_Comp = 0x0020,
 
-	//PHY_AUTO_NEGO_REG = 4;
+	/* PHY_AUTO_NEGO_REG = 4 */
 	PHY_Cap_10_Half = 0x0020,
 	PHY_Cap_10_Full = 0x0040,
 	PHY_Cap_100_Half = 0x0080,
 	PHY_Cap_100_Full = 0x0100,
 
-	//PHY_1000_CTRL_REG = 9;
+	/* PHY_1000_CTRL_REG = 9 */
 	PHY_Cap_1000_Full = 0x0200,
 
 	PHY_Cap_Null = 0x0,
 
-	/*_MediaType*/
+	/* _MediaType */
 	_10_Half = 0x01,
 	_10_Full = 0x02,
 	_100_Half = 0x04,
 	_100_Full = 0x08,
 	_1000_Full = 0x10,
 
-	/*_TBICSRBit*/
+	/* _TBICSRBit */
 	TBILinkOK = 0x02000000,
 };
 
@@ -374,7 +382,7 @@
 
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
-	struct pci_dev *pci_dev;	/* Index of PCI device  */
+	struct pci_dev *pci_dev;	/* Index of PCI device */
 	struct net_device_stats stats;	/* statistics of net device */
 	spinlock_t lock;		/* spin lock flag */
 	int chipset;
@@ -407,7 +415,7 @@
 	struct work_struct task;
 };
 
-MODULE_AUTHOR("Realtek");
+MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@oss.sgi.com>");
 MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
 module_param_array(media, int, &num_media, 0);
 module_param(rx_copybreak, int, 0);
@@ -455,7 +463,7 @@
 	udelay(1000);
 
 	for (i = 2000; i > 0; i--) {
-		// Check if the RTL8169 has completed writing to the specified MII register
+		/* Check if the RTL8169 has completed writing to the specified MII register */
 		if (!(RTL_R32(PHYAR) & 0x80000000)) 
 			break;
 		udelay(100);
@@ -470,7 +478,7 @@
 	udelay(1000);
 
 	for (i = 2000; i > 0; i--) {
-		// Check if the RTL8169 has completed retrieving data from the specified MII register
+		/* Check if the RTL8169 has completed retrieving data from the specified MII register */
 		if (RTL_R32(PHYAR) & 0x80000000) {
 			value = (int) (RTL_R32(PHYAR) & 0xFFFF);
 			break;
@@ -480,6 +488,20 @@
 	return value;
 }
 
+static void rtl8169_irq_mask_and_ack(void __iomem *ioaddr)
+{
+	RTL_W16(IntrMask, 0x0000);
+
+	RTL_W16(IntrStatus, 0xffff);
+}
+
+static void rtl8169_asic_down(void __iomem *ioaddr)
+{
+	RTL_W8(ChipCmd, 0x00);
+	rtl8169_irq_mask_and_ack(ioaddr);
+	RTL_R16(CPlusCmd);
+}
+
 static unsigned int rtl8169_tbi_reset_pending(void __iomem *ioaddr)
 {
 	return RTL_R32(TBICSR) & TBIReset;
@@ -698,7 +720,7 @@
 				      struct sk_buff *skb)
 {
 	return (tp->vlgrp && vlan_tx_tag_present(skb)) ?
-		TxVlanTag | cpu_to_be16(vlan_tx_tag_get(skb)) : 0x00;
+		TxVlanTag | swab16(vlan_tx_tag_get(skb)) : 0x00;
 }
 
 static void rtl8169_vlan_rx_register(struct net_device *dev,
@@ -733,12 +755,12 @@
 static int rtl8169_rx_vlan_skb(struct rtl8169_private *tp, struct RxDesc *desc,
 			       struct sk_buff *skb)
 {
-	u32 opts2 = desc->opts2;
+	u32 opts2 = le32_to_cpu(desc->opts2);
 	int ret;
 
 	if (tp->vlgrp && (opts2 & RxVlanTag)) {
 		rtl8169_rx_hwaccel_skb(skb, tp->vlgrp,
-				       be16_to_cpu(opts2 & 0xffff));
+				       swab16(opts2 & 0xffff));
 		ret = 0;
 	} else
 		ret = -1;
@@ -1002,7 +1024,7 @@
 
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_B)
 		return;
-	if (tp->phy_version >= RTL_GIGA_PHY_VER_F) 
+	if (tp->phy_version >= RTL_GIGA_PHY_VER_H)
 		return;
 
 	dprintk("MAC version != 0 && PHY version == 0 or 1\n");
@@ -1010,7 +1032,19 @@
 
 	/* Shazam ! */
 
-	// phy config for RTL8169s mac_version C chip
+	if (tp->mac_version == RTL_GIGA_MAC_VER_X) {
+		mdio_write(ioaddr, 31, 0x0001);
+		mdio_write(ioaddr,  9, 0x273a);
+		mdio_write(ioaddr, 14, 0x7bfb);
+		mdio_write(ioaddr, 27, 0x841e);
+
+		mdio_write(ioaddr, 31, 0x0002);
+		mdio_write(ioaddr,  1, 0x90d0);
+		mdio_write(ioaddr, 31, 0x0000);
+		return;
+	}
+
+	/* phy config for RTL8169s mac_version C chip */
 	mdio_write(ioaddr, 31, 0x0001);			//w 31 2 0 1
 	mdio_write(ioaddr, 21, 0x1000);			//w 21 15 0 1000
 	mdio_write(ioaddr, 24, 0x65c7);			//w 24 15 0 65c7
@@ -1038,7 +1072,7 @@
 	unsigned long timeout = RTL8169_PHY_TIMEOUT;
 
 	assert(tp->mac_version > RTL_GIGA_MAC_VER_B);
-	assert(tp->phy_version < RTL_GIGA_PHY_VER_G);
+	assert(tp->phy_version < RTL_GIGA_PHY_VER_H);
 
 	if (!(tp->phy_1000_ctrl_reg & PHY_Cap_1000_Full))
 		return;
@@ -1073,7 +1107,7 @@
 	struct timer_list *timer = &tp->timer;
 
 	if ((tp->mac_version <= RTL_GIGA_MAC_VER_B) ||
-	    (tp->phy_version >= RTL_GIGA_PHY_VER_G))
+	    (tp->phy_version >= RTL_GIGA_PHY_VER_H))
 		return;
 
 	del_timer_sync(timer);
@@ -1085,7 +1119,7 @@
 	struct timer_list *timer = &tp->timer;
 
 	if ((tp->mac_version <= RTL_GIGA_MAC_VER_B) ||
-	    (tp->phy_version >= RTL_GIGA_PHY_VER_G))
+	    (tp->phy_version >= RTL_GIGA_PHY_VER_H))
 		return;
 
 	init_timer(timer);
@@ -1132,7 +1166,7 @@
 
 	assert(ioaddr_out != NULL);
 
-	// dev zeroed in alloc_etherdev 
+	/* dev zeroed in alloc_etherdev */
 	dev = alloc_etherdev(sizeof (*tp));
 	if (dev == NULL) {
 		printk(KERN_ERR PFX "unable to alloc new ethernet\n");
@@ -1143,7 +1177,7 @@
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	tp = netdev_priv(dev);
 
-	// enable device (incl. PCI PM wakeup and hotplug setup)
+	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pci_enable_device(pdev);
 	if (rc) {
 		printk(KERN_ERR PFX "%s: enable failure\n", pdev->slot_name);
@@ -1167,14 +1201,14 @@
 		goto err_out_mwi;
 	}
 
-	// make sure PCI base addr 1 is MMIO
+	/* make sure PCI base addr 1 is MMIO */
 	if (!(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
 		printk(KERN_ERR PFX
 		       "region #1 not an MMIO resource, aborting\n");
 		rc = -ENODEV;
 		goto err_out_mwi;
 	}
-	// check for weird/broken PCI region reporting
+	/* check for weird/broken PCI region reporting */
 	if (pci_resource_len(pdev, 1) < R8169_REGS_SIZE) {
 		printk(KERN_ERR PFX "Invalid PCI region size(s), aborting\n");
 		rc = -ENODEV;
@@ -1204,7 +1238,7 @@
 
 	pci_set_master(pdev);
 
-	// ioremap MMIO region 
+	/* ioremap MMIO region */
 	ioaddr = ioremap(pci_resource_start(pdev, 1), R8169_REGS_SIZE);
 	if (ioaddr == NULL) {
 		printk(KERN_ERR PFX "cannot remap MMIO, aborting\n");
@@ -1212,17 +1246,20 @@
 		goto err_out_free_res;
 	}
 
-	// Soft reset the chip. 
+	/* Unneeded ? Don't mess with Mrs. Murphy. */
+	rtl8169_irq_mask_and_ack(ioaddr);
+
+	/* Soft reset the chip. */
 	RTL_W8(ChipCmd, CmdReset);
 
-	// Check that the chip has finished the reset.
+	/* Check that the chip has finished the reset. */
 	for (i = 1000; i > 0; i--) {
 		if ((RTL_R8(ChipCmd) & CmdReset) == 0)
 			break;
 		udelay(10);
 	}
 
-	// Identify chip attached to board
+	/* Identify chip attached to board */
 	rtl8169_get_mac_version(tp, ioaddr);
 	rtl8169_get_phy_version(tp, ioaddr);
 
@@ -1310,7 +1347,7 @@
 		tp->link_ok = rtl8169_xmii_link_ok;
 	}
 
-	// Get MAC address.  FIXME: read EEPROM
+	/* Get MAC address.  FIXME: read EEPROM */
 	for (i = 0; i < MAC_ADDR_LEN; i++)
 		dev->dev_addr[i] = RTL_R8(MAC0 + i);
 
@@ -1518,7 +1555,7 @@
 static void rtl8169_hw_reset(void __iomem *ioaddr)
 {
 	/* Disable interrupts */
-	RTL_W16(IntrMask, 0x0000);
+	rtl8169_irq_mask_and_ack(ioaddr);
 
 	/* Reset the chipset */
 	RTL_W8(ChipCmd, CmdReset);
@@ -1548,10 +1585,10 @@
 	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
 	RTL_W8(EarlyTxThres, EarlyTxThld);
 
-	// For gigabit rtl8169, MTU + header + CRC + VLAN
+	/* For gigabit rtl8169, MTU + header + CRC + VLAN */
 	RTL_W16(RxMaxSize, tp->rx_buf_sz);
 
-	// Set Rx Config register
+	/* Set Rx Config register */
 	i = rtl8169_rx_config |
 		(RTL_R32(RxConfig) & rtl_chip_info[tp->chipset].RxConfigMask);
 	RTL_W32(RxConfig, i);
@@ -1563,13 +1600,20 @@
 	tp->cp_cmd |= RTL_R16(CPlusCmd);
 	RTL_W16(CPlusCmd, tp->cp_cmd);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_D) {
+	if ((tp->mac_version == RTL_GIGA_MAC_VER_D) ||
+	    (tp->mac_version == RTL_GIGA_MAC_VER_E)) {
 		dprintk(KERN_INFO PFX "Set MAC Reg C+CR Offset 0xE0. "
 			"Bit-3 and bit-14 MUST be 1\n");
 		tp->cp_cmd |= (1 << 14) | PCIMulRW;
 		RTL_W16(CPlusCmd, tp->cp_cmd);
 	}
 
+	/*
+	 * Undocumented corner. Supposedly:
+	 * (TxTimer << 12) | (TxPackets << 8) | (RxTimer << 4) | RxPackets
+	 */
+	RTL_W16(IntrMitigate, 0x0000);
+
 	RTL_W32(TxDescStartAddrLow, ((u64) tp->TxPhyAddr & DMA_32BIT_MASK));
 	RTL_W32(TxDescStartAddrHigh, ((u64) tp->TxPhyAddr >> 32));
 	RTL_W32(RxDescAddrLow, ((u64) tp->RxPhyAddr & DMA_32BIT_MASK));
@@ -1611,10 +1655,10 @@
 	if (ret < 0)
 		goto out;
 
-	rtl8169_hw_start(dev);
-
 	netif_poll_enable(dev);
 
+	rtl8169_hw_start(dev);
+
 	rtl8169_request_timer(dev);
 
 out:
@@ -1658,11 +1702,11 @@
 	dma_addr_t mapping;
 	int ret = 0;
 
-	skb = dev_alloc_skb(rx_buf_sz);
+	skb = dev_alloc_skb(rx_buf_sz + NET_IP_ALIGN);
 	if (!skb)
 		goto err_out;
 
-	skb_reserve(skb, 2);
+	skb_reserve(skb, NET_IP_ALIGN);
 	*sk_buff = skb;
 
 	mapping = pci_map_single(pdev, skb->tail, rx_buf_sz,
@@ -1795,9 +1839,7 @@
 	/* Wait for any pending NAPI task to complete */
 	netif_poll_disable(dev);
 
-	RTL_W16(IntrMask, 0x0000);
-
-	RTL_W16(IntrStatus, 0xffff);
+	rtl8169_irq_mask_and_ack(ioaddr);
 
 	netif_poll_enable(dev);
 }
@@ -1974,7 +2016,7 @@
 
 	smp_wmb();
 
-	RTL_W8(TxPoll, 0x40);	//set polling bit
+	RTL_W8(TxPoll, 0x40);	/* set polling bit */
 
 	if (TX_BUFFS_AVAIL(tp) < MAX_SKB_FRAGS) {
 		netif_stop_queue(dev);
@@ -2084,7 +2126,7 @@
 
 static inline void rtl8169_rx_csum(struct sk_buff *skb, struct RxDesc *desc)
 {
-	u32 opts1 = desc->opts1;
+	u32 opts1 = le32_to_cpu(desc->opts1);
 	u32 status = opts1 & RxProtoMask;
 
 	if (((status == RxProtoTCP) && !(opts1 & TCPFail)) ||
@@ -2103,9 +2145,9 @@
 	if (pkt_size < rx_copybreak) {
 		struct sk_buff *skb;
 
-		skb = dev_alloc_skb(pkt_size + 2);
+		skb = dev_alloc_skb(pkt_size + NET_IP_ALIGN);
 		if (skb) {
-			skb_reserve(skb, 2);
+			skb_reserve(skb, NET_IP_ALIGN);
 			eth_copy_and_sum(skb, sk_buff[0]->tail, pkt_size, 0);
 			*sk_buff = skb;
 			rtl8169_return_to_asic(desc, rx_buf_sz);
@@ -2119,8 +2161,8 @@
 rtl8169_rx_interrupt(struct net_device *dev, struct rtl8169_private *tp,
 		     void __iomem *ioaddr)
 {
-	unsigned int cur_rx, rx_left, count;
-	int delta;
+	unsigned int cur_rx, rx_left;
+	unsigned int delta, count;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -2188,10 +2230,8 @@
 	tp->cur_rx = cur_rx;
 
 	delta = rtl8169_rx_fill(tp, dev, tp->dirty_rx, tp->cur_rx);
-	if (delta < 0) {
+	if (!delta && count)
 		printk(KERN_INFO "%s: no Rx buffer allocated\n", dev->name);
-		delta = 0;
-	}
 	tp->dirty_rx += delta;
 
 	/*
@@ -2215,12 +2255,9 @@
 	struct rtl8169_private *tp = netdev_priv(dev);
 	int boguscnt = max_interrupt_work;
 	void __iomem *ioaddr = tp->mmio_addr;
-	int status = 0;
+	int status;
 	int handled = 0;
 
-	if (unlikely(!netif_running(dev)))
-		goto out;
-
 	do {
 		status = RTL_R16(IntrStatus);
 
@@ -2230,6 +2267,11 @@
 
 		handled = 1;
 
+		if (unlikely(!netif_running(dev))) {
+			rtl8169_asic_down(ioaddr);
+			goto out;
+		}
+
 		status &= tp->intr_mask;
 		RTL_W16(IntrStatus,
 			(status & RxFIFOOver) ? (status | RxOverflow) : status);
@@ -2257,11 +2299,11 @@
 		}
 		break;
 #else
-		// Rx interrupt 
+		/* Rx interrupt */
 		if (status & (RxOK | RxOverflow | RxFIFOOver)) {
 			rtl8169_rx_interrupt(dev, tp, ioaddr);
 		}
-		// Tx interrupt
+		/* Tx interrupt */
 		if (status & (TxOK | TxErr))
 			rtl8169_tx_interrupt(dev, tp, ioaddr);
 #endif
@@ -2292,7 +2334,7 @@
 	*budget -= work_done;
 	dev->quota -= work_done;
 
-	if ((work_done < work_to_do) || !netif_running(dev)) {
+	if (work_done < work_to_do) {
 		netif_rx_complete(dev);
 		tp->intr_mask = 0xffff;
 		/*
@@ -2313,6 +2355,7 @@
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->mmio_addr;
+	unsigned int poll_locked = 0;
 
 	rtl8169_delete_timer(dev);
 
@@ -2320,13 +2363,10 @@
 
 	flush_scheduled_work();
 
+core_down:
 	spin_lock_irq(&tp->lock);
 
-	/* Stop the chip's Tx and Rx DMA processes. */
-	RTL_W8(ChipCmd, 0x00);
-
-	/* Disable interrupts by clearing the interrupt mask. */
-	RTL_W16(IntrMask, 0x0000);
+	rtl8169_asic_down(ioaddr);
 
 	/* Update the error counts. */
 	tp->stats.rx_missed_errors += RTL_R32(RxMissed);
@@ -2336,11 +2376,27 @@
 
 	synchronize_irq(dev->irq);
 
-	netif_poll_disable(dev);
+	if (!poll_locked) {
+		netif_poll_disable(dev);
+		poll_locked++;
+	}
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(1);
+	synchronize_kernel();
+
+	/*
+	 * And now for the 50k$ question: are IRQ disabled or not ?
+	 *
+	 * Two paths lead here:
+	 * 1) dev->close
+	 *    -> netif_running() is available to sync the current code and the
+	 *       IRQ handler. See rtl8169_interrupt for details.
+	 * 2) dev->change_mtu
+	 *    -> rtl8169_poll can not be issued again and re-enable the
+	 *       interruptions. Let's simply issue the IRQ down sequence again.
+	 */
+	if (RTL_R16(IntrMask))
+		goto core_down;
 
 	rtl8169_tx_clear(tp);
 
@@ -2355,6 +2411,8 @@
 	rtl8169_down(dev);
 
 	free_irq(dev->irq, dev);
+
+	netif_poll_enable(dev);
 
 	pci_free_consistent(pdev, R8169_RX_RING_BYTES, tp->RxDescArray,
 			    tp->RxPhyAddr);

--------------090502080105020908050300--
