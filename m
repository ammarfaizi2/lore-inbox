Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUFSHOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUFSHOv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 03:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUFSHOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 03:14:51 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:3594 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S261951AbUFSHMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 03:12:51 -0400
Subject: [PATCH 2.6.7 and 2.4.27-pre6] new device support for forcedeth.c
From: Brian Lazara <blazara@nvidia.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-epFNDHU2IzhNusp4pyEz"
Message-Id: <1087629194.19311.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 00:13:14 -0700
X-OriginalArrivalTime: 19 Jun 2004 07:12:49.0518 (UTC) FILETIME=[D43578E0:01C455CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-epFNDHU2IzhNusp4pyEz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Updated forcedeth.c network driver for NVIDIA nForce chipsets. Includes
new devices and support for gigabit.

Regards,
Brian 

--=-epFNDHU2IzhNusp4pyEz
Content-Disposition: attachment; filename=linux-2.6.7-forcedeth.patch
Content-Type: text/plain; name=linux-2.6.7-forcedeth.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.7/drivers/net/forcedeth.c	2004-06-18 22:31:30.000000000 -0700
+++ linux-2.6.7-forcedeth/drivers/net/forcedeth.c	2004-06-18 23:39:22.000000000 -0700
@@ -12,6 +12,7 @@
  *
  * Copyright (C) 2003 Manfred Spraul
  * Copyright (C) 2004 Andrew de Quincey (wol support)
+ * Copyright (c) 2004 NVIDIA Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -69,6 +70,9 @@
  *	0.23: 26 Jan 2004: various small cleanups
  *	0.24: 27 Feb 2004: make driver even less anonymous in backtraces
  *	0.25: 09 Mar 2004: wol support
+ *	0.26: 18 May 2004: Gigabit support, new descriptor rings, 
+ *                         added CK804/MCP04 device IDs, code fixes
+ *                         for registers, link status and other minor fixes.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -80,7 +84,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.25"
+#define FORCEDETH_VERSION		"0.26"
 
 #include <linux/module.h>
 #include <linux/types.h>
@@ -96,6 +100,7 @@
 #include <linux/mii.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/version.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -110,6 +115,24 @@
 
 
 /*
+ * This is in since 2.5.69 and 2.4.22
+ */
+#ifndef IRQ_NONE
+#define IRQ_NONE
+#define IRQ_HANDLED
+#define IRQ_RETVAL(x)
+typedef void irqreturn_t;
+#endif
+
+#ifndef pci_name
+#define pci_name(pdev) ((pdev)->slot_name)
+#endif
+
+#ifndef free_netdev
+#define free_netdev(dev) kfree(dev);
+#endif
+
+/*
  * Hardware access:
  */
 
@@ -123,6 +146,7 @@ enum {
 #define NVREG_IRQSTAT_MIIEVENT	0x040
 #define NVREG_IRQSTAT_MASK		0x1ff
 	NvRegIrqMask = 0x004,
+#define NVREG_IRQ_RX_ERROR              0x0001
 #define NVREG_IRQ_RX			0x0002
 #define NVREG_IRQ_RX_NOBUF		0x0004
 #define NVREG_IRQ_TX_ERR		0x0008
@@ -132,7 +156,7 @@ enum {
 #define NVREG_IRQ_TX1			0x0100
 #define NVREG_IRQMASK_WANTED_1		0x005f
 #define NVREG_IRQMASK_WANTED_2		0x0147
-#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
+#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
 
 	NvRegUnknownSetupReg6 = 0x008,
 #define NVREG_UNKSETUP6_VAL		3
@@ -159,7 +183,7 @@ enum {
 
 	NvRegOffloadConfig = 0x90,
 #define NVREG_OFFLOAD_HOMEPHY	0x601
-#define NVREG_OFFLOAD_NORMAL	0x5ee
+#define NVREG_OFFLOAD_NORMAL	RX_NIC_BUFSIZE
 	NvRegReceiverControl = 0x094,
 #define NVREG_RCVCTL_START	0x01
 	NvRegReceiverStatus = 0x98,
@@ -168,6 +192,8 @@ enum {
 	NvRegRandomSeed = 0x9c,
 #define NVREG_RNDSEED_MASK	0x00ff
 #define NVREG_RNDSEED_FORCE	0x7f00
+#define NVREG_RNDSEED_FORCE2    0x2d00
+#define NVREG_RNDSEED_FORCE3    0x7400
 
 	NvRegUnknownSetupReg1 = 0xA0,
 #define NVREG_UNKSETUP1_VAL	0x16070f
@@ -181,6 +207,9 @@ enum {
 	NvRegMulticastMaskA = 0xB8,
 	NvRegMulticastMaskB = 0xBC,
 
+	NvRegPhyInterface   = 0xC0,
+#define PHY_RGMII         0x10000000
+
 	NvRegTxRingPhysAddr = 0x100,
 	NvRegRxRingPhysAddr = 0x104,
 	NvRegRingSizes = 0x108,
@@ -189,12 +218,12 @@ enum {
 	NvRegUnknownTransmitterReg = 0x10c,
 	NvRegLinkSpeed = 0x110,
 #define NVREG_LINKSPEED_FORCE 0x10000
-#define NVREG_LINKSPEED_10	10
+#define NVREG_LINKSPEED_10	1000
 #define NVREG_LINKSPEED_100	100
-#define NVREG_LINKSPEED_1000	1000
+#define NVREG_LINKSPEED_1000	50
 	NvRegUnknownSetupReg5 = 0x130,
 #define NVREG_UNKSETUP5_BIT31	(1<<31)
-	NvRegUnknownSetupReg3 = 0x134,
+	NvRegUnknownSetupReg3 = 0x13c,
 #define NVREG_UNKSETUP3_VAL1	0x200010
 	NvRegTxRxControl = 0x144,
 #define NVREG_TXRXCTL_KICK	0x0001
@@ -213,15 +242,15 @@ enum {
 	NvRegAdapterControl = 0x188,
 #define NVREG_ADAPTCTL_START	0x02
 #define NVREG_ADAPTCTL_LINKUP	0x04
-#define NVREG_ADAPTCTL_PHYVALID	0x4000
+#define NVREG_ADAPTCTL_PHYVALID	0x40000
 #define NVREG_ADAPTCTL_RUNNING	0x100000
 #define NVREG_ADAPTCTL_PHYSHIFT	24
 	NvRegMIISpeed = 0x18c,
 #define NVREG_MIISPEED_BIT8	(1<<8)
 #define NVREG_MIIDELAY	5
 	NvRegMIIControl = 0x190,
-#define NVREG_MIICTL_INUSE	0x10000
-#define NVREG_MIICTL_WRITE	0x08000
+#define NVREG_MIICTL_INUSE	0x08000
+#define NVREG_MIICTL_WRITE	0x00400
 #define NVREG_MIICTL_ADDRSHIFT	5
 	NvRegMIIData = 0x194,
 	NvRegWakeUpFlags = 0x200,
@@ -253,10 +282,20 @@ enum {
 #define NVREG_POWERSTATE_D3		0x0003
 };
 
+/*FIXME big endian */
+
 struct ring_desc {
 	u32 PacketBuffer;
-	u16 Length;
-	u16 Flags;
+	union {
+		struct {
+			u16 Length;
+			u16 Flags;
+		} v1;
+		struct {
+			u32 Length:14;
+			u32 Flags:18;
+		} v2;
+	} u;
 };
 
 #define NV_TX_LASTPACKET	(1<<0)
@@ -269,9 +308,19 @@ struct ring_desc {
 #define NV_TX_ERROR		(1<<14)
 #define NV_TX_VALID		(1<<15)
 
+#define NV_TX2_LASTPACKET	(1<<15)
+#define NV_TX2_RETRYERROR	(1<<4)
+#define NV_TX2_LASTPACKET1	(1<<9)
+#define NV_TX2_DEFERRED		(1<<11)
+#define NV_TX2_CARRIERLOST	(1<<12)
+#define NV_TX2_LATECOLLISION	(1<<13)
+#define NV_TX2_UNDERFLOW	(1<<14)
+#define NV_TX2_ERROR		(1<<16)
+#define NV_TX2_VALID		(1<<17)
+
 #define NV_RX_DESCRIPTORVALID	(1<<0)
 #define NV_RX_MISSEDFRAME	(1<<1)
-#define NV_RX_SUBSTRACT1	(1<<3)
+#define NV_RX_SUBSTRACT1	(1<<2)
 #define NV_RX_ERROR1		(1<<7)
 #define NV_RX_ERROR2		(1<<8)
 #define NV_RX_ERROR3		(1<<9)
@@ -282,6 +331,18 @@ struct ring_desc {
 #define NV_RX_ERROR		(1<<14)
 #define NV_RX_AVAIL		(1<<15)
 
+#define NV_RX2_DESCRIPTORVALID	(1<<15)
+#define NV_RX2_SUBSTRACT1	(1<<11)
+#define NV_RX2_ERROR1		(1<<4)
+#define NV_RX2_ERROR2		(1<<5)
+#define NV_RX2_ERROR3		(1<<6)
+#define NV_RX2_ERROR4		(1<<7)
+#define NV_RX2_CRCERR		(1<<8)
+#define NV_RX2_OVERFLOW		(1<<9)
+#define NV_RX2_FRAMINGERR	(1<<10)
+#define NV_RX2_ERROR		(1<<16)
+#define NV_RX2_AVAIL		(1<<17)
+
 /* Miscelaneous hardware related defines: */
 #define NV_PCI_REGSZ		0x270
 
@@ -309,10 +370,10 @@ struct ring_desc {
 #define DEFAULT_MTU		1500	/* also maximum supported, at least for now */
 
 #define RX_RING		128
-#define TX_RING		16
+#define TX_RING		64
 /* limited to 1 packet until we understand NV_TX_LASTPACKET */
-#define TX_LIMIT_STOP	10
-#define TX_LIMIT_START	5
+#define TX_LIMIT_STOP	63
+#define TX_LIMIT_START	62
 
 /* rx/tx mac addr + type + vlan + align + slack*/
 #define RX_NIC_BUFSIZE		(DEFAULT_MTU + 64)
@@ -322,6 +383,52 @@ struct ring_desc {
 #define OOM_REFILL	(1+HZ/20)
 #define POLL_WAIT	(1+HZ/100)
 
+#define PCI_DEVICE_ID_NVIDIA_NVENET_1  0x01C3
+#define PCI_DEVICE_ID_NVIDIA_NVENET_2  0x0066
+#define PCI_DEVICE_ID_NVIDIA_NVENET_3  0x00D6
+#define PCI_DEVICE_ID_NVIDIA_NVENET_4  0x0086
+#define PCI_DEVICE_ID_NVIDIA_NVENET_5  0x008C
+#define PCI_DEVICE_ID_NVIDIA_NVENET_6  0x00E6
+#define PCI_DEVICE_ID_NVIDIA_NVENET_7  0x00DF
+#define PCI_DEVICE_ID_NVIDIA_NVENET_8  0x0056
+#define PCI_DEVICE_ID_NVIDIA_NVENET_9  0x0057
+#define PCI_DEVICE_ID_NVIDIA_NVENET_10 0x0037
+#define PCI_DEVICE_ID_NVIDIA_NVENET_11 0x0038
+
+#define DESC_VER_1   0x0
+#define DESC_VER_2   0x02100
+
+/* PHY defines */
+#define PHY_OUI_MARVELL   0x5043
+#define PHY_OUI_CICADA    0x03f1
+#define PHYID1_OUI_MASK   0x03ff
+#define PHYID1_OUI_SHFT   6
+#define PHYID2_OUI_MASK   0xfc00
+#define PHYID2_OUI_SHFT   10
+#define PHY_INIT1         0x0f000
+#define PHY_INIT2         0x0e00
+#define PHY_INIT3         0x01000
+#define PHY_INIT4         0x0200
+#define PHY_INIT5         0x0004
+#define PHY_INIT6         0x02000  
+#define PHY_GIGABIT       0x0100
+
+#define PHY_TIMEOUT       0x1
+#define PHY_ERROR         0x2
+
+#define PHY_100           0x1
+#define PHY_1000          0x2
+#define PHY_HALF          0x100
+
+/* MII defines that should be added to <linux/mii.h> */
+#define MII_1000BT_CR     0x09
+#define MII_1000BT_SR     0x0a
+#define ADVERTISE_1000FULL  0x0200
+#define ADVERTISE_1000HALF  0x0100
+#define LPA_1000FULL        0x0800
+#define LPA_1000HALF        0x0400
+
+
 /*
  * SMP locking:
  * All hardware access under dev->priv->lock, except the performance
@@ -345,12 +452,15 @@ struct fe_priv {
 	int duplex;
 	int phyaddr;
 	int wolenabled;
+        unsigned int phy_oui;
+        u16 gigabit;
 
 	/* General data: RO fields */
 	dma_addr_t ring_addr;
 	struct pci_dev *pci_dev;
 	u32 orig_mac[2];
 	u32 irqmask;
+	u32 desc_ver;
 
 	/* rx specific fields.
 	 * Locking: Within irq hander or disable_irq+spin_lock(&np->lock);
@@ -370,10 +480,18 @@ struct fe_priv {
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
-	u16 tx_flags;
+	u32 tx_flags;
 };
 
 /*
+ *  Function pointers based on descriptor version
+ */
+int (*nv_alloc_rx)(struct net_device *dev);
+int (*nv_start_xmit)(struct sk_buff *skb, struct net_device *dev);
+void (*nv_tx_done)(struct net_device *dev);
+void (*nv_rx_process)(struct net_device *dev);
+
+/*
  * Maximum number of loops until we assume that a bit in the irq mask
  * is stuck. Overridable with module param.
  */
@@ -421,24 +539,18 @@ static int reg_delay(struct net_device *
 static int mii_rw(struct net_device *dev, int addr, int miireg, int value)
 {
 	u8 *base = get_hwbase(dev);
-	int was_running;
 	u32 reg;
 	int retval;
 
 	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
-	was_running = 0;
-	reg = readl(base + NvRegAdapterControl);
-	if (reg & NVREG_ADAPTCTL_RUNNING) {
-		was_running = 1;
-		writel(reg & ~NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-	}
+
 	reg = readl(base + NvRegMIIControl);
 	if (reg & NVREG_MIICTL_INUSE) {
 		writel(NVREG_MIICTL_INUSE, base + NvRegMIIControl);
 		udelay(NV_MIIBUSY_DELAY);
 	}
 
-	reg = NVREG_MIICTL_INUSE | (addr << NVREG_MIICTL_ADDRSHIFT) | miireg;
+	reg = (addr << NVREG_MIICTL_ADDRSHIFT) | miireg;
 	if (value != MII_READ) {
 		writel(value, base + NvRegMIIData);
 		reg |= NVREG_MIICTL_WRITE;
@@ -466,13 +578,135 @@ static int mii_rw(struct net_device *dev
 		dprintk(KERN_DEBUG "%s: mii_rw read from reg %d at PHY %d: 0x%x.\n",
 				dev->name, miireg, addr, retval);
 	}
-	if (was_running) {
-		reg = readl(base + NvRegAdapterControl);
-		writel(reg | NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-	}
+
 	return retval;
 }
 
+static int phy_reset(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u32 miicontrol;
+	u32 microseconds = 0;
+	u32 milliseconds = 0;
+	
+	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+	miicontrol |= BMCR_RESET;
+	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
+	        return -1;
+	}
+
+	//wait for 500ms
+	mdelay(500);
+	
+	//must wait till reset is deasserted
+	while (miicontrol & BMCR_RESET) {
+		udelay(NV_MIIBUSY_DELAY);
+		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		microseconds++;
+		if (microseconds == 20) {
+			microseconds = 0;
+			milliseconds++;
+		}
+		if (milliseconds > 50)
+			return -1;
+	}
+	return 0;
+}
+
+static int phy_init(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u8 *base = get_hwbase(dev);
+	u32 phyinterface, phy_reserved, mii_status, mii_control, mii_control_1000,reg;
+	u32 microseconds = 0;
+	u32 milliseconds = 0;
+
+	// set advertise register
+	reg = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+	reg |= (ADVERTISE_10HALF|ADVERTISE_10FULL|ADVERTISE_100HALF|ADVERTISE_100FULL|0x800|0x400);
+	if (mii_rw(dev, np->phyaddr, MII_ADVERTISE, reg)) {
+		printk(KERN_INFO "%s: phy write to advertise failed.\n", dev->name);
+		return PHY_ERROR;
+	}   
+
+	// get phy interface type
+	phyinterface = readl(base + NvRegPhyInterface);
+
+	// see if gigabit phy
+	mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+	if (mii_status & PHY_GIGABIT) {
+		np->gigabit = PHY_GIGABIT;
+		mii_control_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		mii_control_1000 &= ~ADVERTISE_1000HALF;
+		if (phyinterface & PHY_RGMII)
+			mii_control_1000 |= ADVERTISE_1000FULL;
+		else
+			mii_control_1000 &= ~ADVERTISE_1000FULL;
+		
+		if (mii_rw(dev, np->phyaddr, MII_1000BT_CR, mii_control_1000)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return PHY_ERROR;
+		}   
+	}
+	else
+		np->gigabit = 0;
+
+	// reset the phy
+	if (phy_reset(dev)) {
+		printk(KERN_INFO "%s: phy reset failed\n", dev->name);
+		return PHY_ERROR;
+	}
+
+	// phy vendor specific configuration
+	if ((np->phy_oui == PHY_OUI_CICADA) && (phyinterface & PHY_RGMII) ) {
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_RESV1, MII_READ);
+		phy_reserved &= ~(PHY_INIT1 | PHY_INIT2);
+		phy_reserved |= (PHY_INIT3 | PHY_INIT4);
+		if (mii_rw(dev, np->phyaddr, MII_RESV1, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return -1;
+		}
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_NCONFIG, MII_READ);
+		phy_reserved |= PHY_INIT5;
+		if (mii_rw(dev, np->phyaddr, MII_NCONFIG, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return PHY_ERROR;
+		}   
+	}
+	if (np->phy_oui == PHY_OUI_CICADA) {
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_SREVISION, MII_READ);
+		phy_reserved |= PHY_INIT6;
+		if (mii_rw(dev, np->phyaddr, MII_SREVISION, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return PHY_ERROR;
+		}
+	}
+
+	// restart auto negotiation
+	mii_control = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+	mii_control |= (BMCR_ANRESTART | BMCR_ANENABLE);
+	if (mii_rw(dev, np->phyaddr, MII_BMCR, mii_control)) {
+		return PHY_ERROR;
+	}
+  
+	// check auto negotiation is complete
+	mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+	while (!(mii_status & BMSR_ANEGCOMPLETE)) {
+		udelay(NV_MIIBUSY_DELAY);
+		mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+		microseconds++;
+		if (microseconds == 20) {
+			microseconds = 0;
+			milliseconds++;
+		}
+		if (milliseconds > 1200) {
+			printk(KERN_INFO "%s: phy init failed to autoneg.\n", dev->name);
+			return PHY_TIMEOUT;
+		}
+	}
+	return 0;
+}
+
 static void nv_start_rx(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
@@ -529,13 +763,14 @@ static void nv_stop_tx(struct net_device
 
 static void nv_txrx_reset(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = get_nvpriv(dev);
+        u8 *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_txrx_reset\n", dev->name);
-	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
 	udelay(NV_TXRX_RESET_DELAY);
-	writel(NVREG_TXRXCTL_BIT2, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
 }
 
@@ -646,7 +881,43 @@ static int nv_ioctl(struct net_device *d
  * Return 1 if the allocations for the skbs failed and the
  * rx engine is without Available descriptors
  */
-static int nv_alloc_rx(struct net_device *dev)
+static int nv_alloc_rx_v1(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	unsigned int refill_rx = np->refill_rx;
+
+	while (np->cur_rx != refill_rx) {
+		int nr = refill_rx % RX_RING;
+		struct sk_buff *skb;
+
+		if (np->rx_skbuff[nr] == NULL) {
+
+			skb = dev_alloc_skb(RX_ALLOC_BUFSIZE);
+			if (!skb)
+				break;
+
+			skb->dev = dev;
+			np->rx_skbuff[nr] = skb;
+		} else {
+			skb = np->rx_skbuff[nr];
+		}
+		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
+						PCI_DMA_FROMDEVICE);
+		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
+		np->rx_ring[nr].u.v1.Length = cpu_to_le16(RX_NIC_BUFSIZE);
+		wmb();
+		np->rx_ring[nr].u.v1.Flags = cpu_to_le16(NV_RX_AVAIL);
+		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet  %d marked as Available\n",
+					dev->name, refill_rx);
+		refill_rx++;
+	}
+	np->refill_rx = refill_rx;
+	if (np->cur_rx - refill_rx == RX_RING)
+		return 1;
+	return 0;
+}
+
+static int nv_alloc_rx_v2(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 	unsigned int refill_rx = np->refill_rx;
@@ -669,9 +940,9 @@ static int nv_alloc_rx(struct net_device
 		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
 						PCI_DMA_FROMDEVICE);
 		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
-		np->rx_ring[nr].Length = cpu_to_le16(RX_NIC_BUFSIZE);
+		np->rx_ring[nr].u.v2.Length = cpu_to_le16(RX_NIC_BUFSIZE);
 		wmb();
-		np->rx_ring[nr].Flags = cpu_to_le16(NV_RX_AVAIL);
+		np->rx_ring[nr].u.v2.Flags = cpu_to_le32(NV_RX2_AVAIL);
 		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet  %d marked as Available\n",
 					dev->name, refill_rx);
 		refill_rx++;
@@ -704,13 +975,19 @@ static int nv_init_ring(struct net_devic
 
 	np->next_tx = np->nic_tx = 0;
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->tx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->tx_ring[i].u.v2.Flags = 0;
 	}
 
 	np->cur_rx = RX_RING;
 	np->refill_rx = 0;
 	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->rx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->rx_ring[i].u.v2.Flags = 0;
 	}
 	return nv_alloc_rx(dev);
 }
@@ -720,7 +997,10 @@ static void nv_drain_tx(struct net_devic
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->tx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->tx_ring[i].u.v2.Flags = 0;
 		if (np->tx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->tx_dma[i],
 						np->tx_skbuff[i]->len,
@@ -737,7 +1017,10 @@ static void nv_drain_rx(struct net_devic
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->rx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->rx_ring[i].u.v2.Flags = 0;
 		wmb();
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->rx_dma[i],
@@ -759,7 +1042,45 @@ static void drain_ring(struct net_device
  * nv_start_xmit: dev->hard_start_xmit function
  * Called with dev->xmit_lock held.
  */
-static int nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static int nv_start_xmit_v1(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	int nr = np->next_tx % TX_RING;
+
+	np->tx_skbuff[nr] = skb;
+	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data,skb->len,
+					PCI_DMA_TODEVICE);
+
+	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+	np->tx_ring[nr].u.v1.Length = cpu_to_le16(skb->len-1);
+
+	spin_lock_irq(&np->lock);
+	wmb();
+	np->tx_ring[nr].u.v1.Flags = np->tx_flags;
+	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
+				dev->name, np->next_tx);
+	{
+		int j;
+		for (j=0; j<64; j++) {
+			if ((j%16) == 0)
+				dprintk("\n%03x:", j);
+			dprintk(" %02x", ((unsigned char*)skb->data)[j]);
+		}
+		dprintk("\n");
+	}
+
+	np->next_tx++;
+
+	dev->trans_start = jiffies;
+	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
+		netif_stop_queue(dev);
+	spin_unlock_irq(&np->lock);
+	writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
+	pci_push(get_hwbase(dev));
+	return 0;
+}
+
+static int nv_start_xmit_v2(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 	int nr = np->next_tx % TX_RING;
@@ -769,11 +1090,11 @@ static int nv_start_xmit(struct sk_buff 
 					PCI_DMA_TODEVICE);
 
 	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-	np->tx_ring[nr].Length = cpu_to_le16(skb->len-1);
+	np->tx_ring[nr].u.v2.Length = cpu_to_le16(skb->len-1);
 
 	spin_lock_irq(&np->lock);
 	wmb();
-	np->tx_ring[nr].Flags = np->tx_flags;
+	np->tx_ring[nr].u.v2.Flags = np->tx_flags;
 	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
 				dev->name, np->next_tx);
 	{
@@ -792,7 +1113,7 @@ static int nv_start_xmit(struct sk_buff 
 	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
 		netif_stop_queue(dev);
 	spin_unlock_irq(&np->lock);
-	writel(NVREG_TXRXCTL_KICK, get_hwbase(dev) + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
 	pci_push(get_hwbase(dev));
 	return 0;
 }
@@ -802,25 +1123,60 @@ static int nv_start_xmit(struct sk_buff 
  *
  * Caller must own np->lock.
  */
-static void nv_tx_done(struct net_device *dev)
+static void nv_tx_done_v1(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 
-	while (np->nic_tx < np->next_tx) {
+	while (np->nic_tx != np->next_tx) {
 		struct ring_desc *prd;
 		int i = np->nic_tx % TX_RING;
 
 		prd = &np->tx_ring[i];
 
 		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
-					dev->name, np->nic_tx, prd->Flags);
-		if (prd->Flags & cpu_to_le16(NV_TX_VALID))
+					dev->name, np->nic_tx, prd->u.v1.Flags);
+		if (prd->u.v1.Flags & cpu_to_le16(NV_TX_VALID))
 			break;
-		if (prd->Flags & cpu_to_le16(NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
+		if (prd->u.v1.Flags & cpu_to_le16(NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
 						NV_TX_UNDERFLOW|NV_TX_ERROR)) {
-			if (prd->Flags & cpu_to_le16(NV_TX_UNDERFLOW))
+			if (prd->u.v1.Flags & cpu_to_le16(NV_TX_UNDERFLOW))
+				np->stats.tx_fifo_errors++;
+			if (prd->u.v1.Flags & cpu_to_le16(NV_TX_CARRIERLOST))
+				np->stats.tx_carrier_errors++;
+			np->stats.tx_errors++;
+		} else {
+			np->stats.tx_packets++;
+			np->stats.tx_bytes += np->tx_skbuff[i]->len;
+		}
+		pci_unmap_single(np->pci_dev, np->tx_dma[i],
+					np->tx_skbuff[i]->len,
+					PCI_DMA_TODEVICE);
+		dev_kfree_skb_irq(np->tx_skbuff[i]);
+		np->tx_skbuff[i] = NULL;
+		np->nic_tx++;
+	}
+	if (np->next_tx - np->nic_tx < TX_LIMIT_START)
+		netif_wake_queue(dev);
+}
+static void nv_tx_done_v2(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	while (np->nic_tx != np->next_tx) {
+		struct ring_desc *prd;
+		int i = np->nic_tx % TX_RING;
+
+		prd = &np->tx_ring[i];
+
+		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
+					dev->name, np->nic_tx, prd->u.v2.Flags);
+		if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_VALID))
+			break;
+		if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_RETRYERROR|NV_TX2_CARRIERLOST|NV_TX2_LATECOLLISION|
+						NV_TX2_UNDERFLOW|NV_TX2_ERROR)) {
+			if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_UNDERFLOW))
 				np->stats.tx_fifo_errors++;
-			if (prd->Flags & cpu_to_le16(NV_TX_CARRIERLOST))
+			if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_CARRIERLOST))
 				np->stats.tx_carrier_errors++;
 			np->stats.tx_errors++;
 		} else {
@@ -872,7 +1228,7 @@ static void nv_tx_timeout(struct net_dev
 	spin_unlock_irq(&np->lock);
 }
 
-static void nv_rx_process(struct net_device *dev)
+static void nv_rx_process_v1(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 
@@ -887,9 +1243,9 @@ static void nv_rx_process(struct net_dev
 		i = np->cur_rx % RX_RING;
 		prd = &np->rx_ring[i];
 		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
-					dev->name, np->cur_rx, prd->Flags);
+					dev->name, np->cur_rx, prd->u.v1.Flags);
 
-		if (prd->Flags & cpu_to_le16(NV_RX_AVAIL))
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_AVAIL))
 			break;	/* still owned by hardware, */
 
 		/*
@@ -903,7 +1259,7 @@ static void nv_rx_process(struct net_dev
 
 		{
 			int j;
-			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->Flags);
+			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->u.v1.Flags);
 			for (j=0; j<64; j++) {
 				if ((j%16) == 0)
 					dprintk("\n%03x:", j);
@@ -912,35 +1268,123 @@ static void nv_rx_process(struct net_dev
 			dprintk("\n");
 		}
 		/* look at what we actually got: */
-		if (!(prd->Flags & cpu_to_le16(NV_RX_DESCRIPTORVALID)))
+		if (!(prd->u.v1.Flags & cpu_to_le16(NV_RX_DESCRIPTORVALID)))
 			goto next_pkt;
 
 
-		len = le16_to_cpu(prd->Length);
+		len = le16_to_cpu(prd->u.v1.Length);
 
-		if (prd->Flags & cpu_to_le16(NV_RX_MISSEDFRAME)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_MISSEDFRAME)) {
 			np->stats.rx_missed_errors++;
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_CRCERR)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_CRCERR)) {
 			np->stats.rx_crc_errors++;
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_OVERFLOW)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_OVERFLOW)) {
 			np->stats.rx_over_errors++;
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_ERROR)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_ERROR)) {
 			/* framing errors are soft errors, the rest is fatal. */
-			if (prd->Flags & cpu_to_le16(NV_RX_FRAMINGERR)) {
-				if (prd->Flags & cpu_to_le16(NV_RX_SUBSTRACT1)) {
+			if (prd->u.v1.Flags & cpu_to_le16(NV_RX_FRAMINGERR)) {
+				if (prd->u.v1.Flags & cpu_to_le16(NV_RX_SUBSTRACT1)) {
+					len--;
+				}
+			} else {
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+		}
+		/* got a valid packet - forward it to the network core */
+		skb = np->rx_skbuff[i];
+		np->rx_skbuff[i] = NULL;
+
+		skb_put(skb, len);
+		skb->protocol = eth_type_trans(skb, dev);
+		dprintk(KERN_DEBUG "%s: nv_rx_process: packet %d with %d bytes, proto %d accepted.\n",
+					dev->name, np->cur_rx, len, skb->protocol);
+		netif_rx(skb);
+		dev->last_rx = jiffies;
+		np->stats.rx_packets++;
+		np->stats.rx_bytes += len;
+next_pkt:
+		np->cur_rx++;
+	}
+}
+
+static void nv_rx_process_v2(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	for (;;) {
+		struct ring_desc *prd;
+		struct sk_buff *skb;
+		int len;
+		int i;
+		if (np->cur_rx - np->refill_rx >= RX_RING)
+			break;	/* we scanned the whole ring - do not continue */
+
+		i = np->cur_rx % RX_RING;
+		prd = &np->rx_ring[i];
+		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
+					dev->name, np->cur_rx, prd->u.v2.Flags);
+
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_AVAIL))
+			break;	/* still owned by hardware, */
+
+		/*
+		 * the packet is for us - immediately tear down the pci mapping.
+		 * TODO: check if a prefetch of the first cacheline improves
+		 * the performance.
+		 */
+		pci_unmap_single(np->pci_dev, np->rx_dma[i],
+				np->rx_skbuff[i]->len,
+				PCI_DMA_FROMDEVICE);
+
+		{
+			int j;
+			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->u.v2.Flags);
+			for (j=0; j<64; j++) {
+				if ((j%16) == 0)
+					dprintk("\n%03x:", j);
+				dprintk(" %02x", ((unsigned char*)np->rx_skbuff[i]->data)[j]);
+			}
+			dprintk("\n");
+		}
+		/* look at what we actually got: */
+		if (!(prd->u.v2.Flags & cpu_to_le32(NV_RX2_DESCRIPTORVALID)))
+			goto next_pkt;
+
+
+		len = le16_to_cpu(prd->u.v2.Length);
+
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3|NV_RX2_ERROR4)) {
+			np->stats.rx_errors++;
+			goto next_pkt;
+		}
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_CRCERR)) {
+			np->stats.rx_crc_errors++;
+			np->stats.rx_errors++;
+			goto next_pkt;
+		}
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_OVERFLOW)) {
+			np->stats.rx_over_errors++;
+			np->stats.rx_errors++;
+			goto next_pkt;
+		}
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_ERROR)) {
+			/* framing errors are soft errors, the rest is fatal. */
+			if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_FRAMINGERR)) {
+				if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_SUBSTRACT1)) {
 					len--;
 				}
 			} else {
@@ -1042,14 +1486,30 @@ static void nv_set_multicast(struct net_
 static int nv_update_linkspeed(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	int adv, lpa, newls, newdup;
-
+	u8 *base = get_hwbase(dev);
+	int adv, lpa;
+	int newls = np->linkspeed;
+	int newdup = np->duplex;
+	u32 control_1000, status_1000, phyreg;
+
+	if (np->gigabit == PHY_GIGABIT) {
+		control_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		status_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_SR, MII_READ);
+		
+		if ((control_1000 & ADVERTISE_1000FULL) &&
+		    (status_1000 & LPA_1000FULL)) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_1000;
+			newdup = 1;
+			goto set_speed;
+		}
+	}
+	
 	adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
 	lpa = mii_rw(dev, np->phyaddr, MII_LPA, MII_READ);
 	dprintk(KERN_DEBUG "%s: nv_update_linkspeed: PHY advertises 0x%04x, lpa 0x%04x.\n",
 				dev->name, adv, lpa);
 
-	/* FIXME: handle parallel detection properly, handle gigabit ethernet */
+	/* FIXME: handle parallel detection properly */
 	lpa = lpa & adv;
 	if (lpa  & LPA_100FULL) {
 		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
@@ -1068,11 +1528,35 @@ static int nv_update_linkspeed(struct ne
 		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
 		newdup = 0;
 	}
+	
+set_speed:
 	if (np->duplex != newdup || np->linkspeed != newls) {
 		np->duplex = newdup;
 		np->linkspeed = newls;
-		return 1;
-	}
+	}	
+
+	if (np->gigabit == PHY_GIGABIT) {
+		phyreg = readl(base + NvRegRandomSeed);
+		phyreg &= ~(0x3FF00);
+		if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_10)
+			phyreg |=  NVREG_RNDSEED_FORCE3;
+		else if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_100)
+			phyreg |= NVREG_RNDSEED_FORCE2;
+		else if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_1000)
+			phyreg |= NVREG_RNDSEED_FORCE;
+		writel(phyreg, base + NvRegRandomSeed);
+	}
+	
+	phyreg = readl(base + NvRegPhyInterface);
+	phyreg &= ~(0x3);
+	if (np->duplex == 0)
+		phyreg |= PHY_HALF;
+	if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_100)
+		phyreg |=  PHY_100;
+	else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+		phyreg |= PHY_1000;
+	writel(phyreg, base + NvRegPhyInterface);
+
 	return 0;
 }
 
@@ -1088,26 +1572,28 @@ static void nv_link_irq(struct net_devic
 	printk(KERN_DEBUG "%s: link change notification, status 0x%x.\n", dev->name, miistat);
 
 	miival = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
-	if (miival & BMSR_ANEGCOMPLETE) {
-		nv_update_linkspeed(dev);
+	if (miistat & NVREG_MIISTAT_LINKCHANGE) {
+		if (miival & BMSR_LSTATUS) {
+			nv_update_linkspeed(dev);
 
-		if (netif_carrier_ok(dev)) {
-			nv_stop_rx(dev);
+			if (netif_carrier_ok(dev)) {
+				nv_stop_rx(dev);
+			} else {
+				netif_carrier_on(dev);
+				printk(KERN_INFO "%s: link up.\n", dev->name);
+			}
+			writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
+			       base + NvRegMisc1);
+			nv_start_rx(dev);
 		} else {
-			netif_carrier_on(dev);
-			printk(KERN_INFO "%s: link up.\n", dev->name);
-		}
-		writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
-					base + NvRegMisc1);
-		nv_start_rx(dev);
-	} else {
-		if (netif_carrier_ok(dev)) {
-			netif_carrier_off(dev);
-			printk(KERN_INFO "%s: link down.\n", dev->name);
-			nv_stop_rx(dev);
+			if (netif_carrier_ok(dev)) {
+				netif_carrier_off(dev);
+				printk(KERN_INFO "%s: link down.\n", dev->name);
+				nv_stop_rx(dev);
+			}
+			writel(np->linkspeed, base + NvRegLinkSpeed);
+			pci_push(base);
 		}
-		writel(np->linkspeed, base + NvRegLinkSpeed);
-		pci_push(base);
 	}
 }
 
@@ -1135,7 +1621,7 @@ static irqreturn_t nv_nic_irq(int foo, v
 			spin_unlock(&np->lock);
 		}
 
-		if (events & (NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
+		if (events & (NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
 			nv_rx_process(dev);
 			if (nv_alloc_rx(dev)) {
 				spin_lock(&np->lock);
@@ -1200,6 +1686,7 @@ static int nv_open(struct net_device *de
 	struct fe_priv *np = get_nvpriv(dev);
 	u8 *base = get_hwbase(dev);
 	int ret, oom, i;
+	int phy_status = 0;
 
 	dprintk(KERN_DEBUG "nv_open: begin\n");
 
@@ -1210,15 +1697,21 @@ static int nv_open(struct net_device *de
 	writel(0, base + NvRegMulticastMaskA);
 	writel(0, base + NvRegMulticastMaskB);
 	writel(0, base + NvRegPacketFilterFlags);
+	
+	writel(0, base + NvRegTransmitterControl);
+	writel(0, base + NvRegReceiverControl);
+	
 	writel(0, base + NvRegAdapterControl);
+	
+	/* 2) initialize descriptor rings */
+	oom = nv_init_ring(dev);
+		
 	writel(0, base + NvRegLinkSpeed);
 	writel(0, base + NvRegUnknownTransmitterReg);
 	nv_txrx_reset(dev);
 	writel(0, base + NvRegUnknownSetupReg6);
 
-	/* 2) initialize descriptor rings */
 	np->in_shutdown = 0;
-	oom = nv_init_ring(dev);
 
 	/* 3) set mac address */
 	{
@@ -1232,20 +1725,30 @@ static int nv_open(struct net_device *de
 		writel(mac[1], base + NvRegMacAddrB);
 	}
 
-	/* 4) continue setup */
+	/* 4) give hw rings */
+	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
+	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
+		base + NvRegRingSizes);
+
+	/* 5) continue setup */
 	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
 	np->duplex = 0;
+	
+	writel(np->linkspeed, base + NvRegLinkSpeed);
 	writel(NVREG_UNKSETUP3_VAL1, base + NvRegUnknownSetupReg3);
-	writel(0, base + NvRegTxRxControl);
+	writel(np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
-	writel(NVREG_TXRXCTL_BIT1, base + NvRegTxRxControl);
-	reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
-			NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
-			KERN_INFO "open: SetupReg5, Bit 31 remained off\n");
+	writel(NVREG_TXRXCTL_BIT1|np->desc_ver, base + NvRegTxRxControl);
+        reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
+		  NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
+		  KERN_INFO "open: SetupReg5, Bit 31 remained off\n");  
+
 	writel(0, base + NvRegUnknownSetupReg4);
+	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
+	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 
-	/* 5) Find a suitable PHY */
-	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
+	/* 6a) Find a suitable PHY */
 	for (i = 1; i < 32; i++) {
 		int id1, id2;
 
@@ -1259,13 +1762,13 @@ static int nv_open(struct net_device *de
 		spin_unlock_irq(&np->lock);
 		if (id2 < 0 || id2 == 0xffff)
 			continue;
+
+		id1 = (id1 & PHYID1_OUI_MASK) << PHYID1_OUI_SHFT;
+		id2 = (id2 & PHYID2_OUI_MASK) >> PHYID2_OUI_SHFT;
 		dprintk(KERN_DEBUG "%s: open: Found PHY %04x:%04x at address %d.\n",
 				dev->name, id1, id2, i);
 		np->phyaddr = i;
-
-		spin_lock_irq(&np->lock);
-		nv_update_linkspeed(dev);
-		spin_unlock_irq(&np->lock);
+		np->phy_oui = id1 | id2;
 
 		break;
 	}
@@ -1276,9 +1779,25 @@ static int nv_open(struct net_device *de
 		goto out_drain;
 	}
 
-	/* 6) continue setup */
+	/* 6b) Initialize PHY */
+	spin_lock_irq(&np->lock);
+	
+	/* synchronous init */
+	phy_status = phy_init(dev);
+	if (phy_status == PHY_ERROR) {
+		printk(KERN_INFO "%s: open: failing due to PHY Init.\n", dev->name);
+		ret = -EINVAL;
+		spin_unlock_irq(&np->lock);
+		goto out_drain;
+	}
+	else if (phy_status != PHY_TIMEOUT)
+		nv_update_linkspeed(dev);
+
+	spin_unlock_irq(&np->lock);
+
+	/* 7) continue setup */
 	writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
-				base + NvRegMisc1);
+	       base + NvRegMisc1);
 	writel(readl(base + NvRegTransmitterStatus), base + NvRegTransmitterStatus);
 	writel(NVREG_PFF_ALWAYS, base + NvRegPacketFilterFlags);
 	writel(NVREG_OFFLOAD_NORMAL, base + NvRegOffloadConfig);
@@ -1290,35 +1809,26 @@ static int nv_open(struct net_device *de
 	writel(NVREG_UNKSETUP2_VAL, base + NvRegUnknownSetupReg2);
 	writel(NVREG_POLL_DEFAULT, base + NvRegPollingInterval);
 	writel(NVREG_UNKSETUP6_VAL, base + NvRegUnknownSetupReg6);
-	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID,
-			base + NvRegAdapterControl);
+	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID|NVREG_ADAPTCTL_RUNNING,
+	       base + NvRegAdapterControl);
+	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
 	writel(NVREG_UNKSETUP4_VAL, base + NvRegUnknownSetupReg4);
 	writel(NVREG_WAKEUPFLAGS_VAL, base + NvRegWakeUpFlags);
-
-	/* 7) start packet processing */
-	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
-	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
-	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
-			base + NvRegRingSizes);
-
+	
 	i = readl(base + NvRegPowerState);
 	if ( (i & NVREG_POWERSTATE_POWEREDUP) == 0)
 		writel(NVREG_POWERSTATE_POWEREDUP|i, base + NvRegPowerState);
-
+	
 	pci_push(base);
 	udelay(10);
 	writel(readl(base + NvRegPowerState) | NVREG_POWERSTATE_VALID, base + NvRegPowerState);
-	writel(NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-
-
+	
 	writel(0, base + NvRegIrqMask);
 	pci_push(base);
-	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
-	pci_push(base);
 	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 	pci_push(base);
-
+	
 	ret = request_irq(dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev);
 	if (ret)
 		goto out_drain;
@@ -1336,7 +1846,7 @@ static int nv_open(struct net_device *de
 	netif_start_queue(dev);
 	if (oom)
 		mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-	if (mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ) & BMSR_ANEGCOMPLETE) {
+	if (mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ) & BMSR_LSTATUS) {
 		netif_carrier_on(dev);
 	} else {
 		printk("%s: no link during initialization.\n", dev->name);
@@ -1406,7 +1916,9 @@ static int __devinit nv_probe(struct pci
 	np->pci_dev = pci_dev;
 	spin_lock_init(&np->lock);
 	SET_MODULE_OWNER(dev);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 5, 0)
 	SET_NETDEV_DEV(dev, &pci_dev->dev);
+#endif
 
 	init_timer(&np->oom_kick);
 	np->oom_kick.data = (unsigned long) dev;
@@ -1447,6 +1959,24 @@ static int __devinit nv_probe(struct pci
 		goto out_relreg;
 	}
 
+	/* setup function pointers */
+	if (pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_1 ||
+	    pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_2 ||
+	    pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_3) {
+		np->desc_ver = DESC_VER_1;
+		nv_alloc_rx = nv_alloc_rx_v1;
+		nv_start_xmit = nv_start_xmit_v1;
+		nv_tx_done = nv_tx_done_v1;
+		nv_rx_process = nv_rx_process_v1;
+	}
+	else {
+		np->desc_ver = DESC_VER_2;
+		nv_alloc_rx = nv_alloc_rx_v2;
+		nv_start_xmit = nv_start_xmit_v2;
+		nv_tx_done = nv_tx_done_v2;
+		nv_rx_process = nv_rx_process_v2;
+	}
+
 	err = -ENOMEM;
 	dev->base_addr = (unsigned long) ioremap(addr, NV_PCI_REGSZ);
 	if (!dev->base_addr)
@@ -1505,10 +2035,17 @@ static int __devinit nv_probe(struct pci
 	/* disable WOL */
 	writel(0, base + NvRegWakeUpFlags);
 	np->wolenabled = 0;
-
-	np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
-	if (id->driver_data & DEV_NEED_LASTPACKET1)
-		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
+	
+	if (np->desc_ver == DESC_VER_1) {
+		np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
+		if (id->driver_data & DEV_NEED_LASTPACKET1)
+			np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
+        }
+	else {
+		np->tx_flags = cpu_to_le32(NV_TX2_LASTPACKET|NV_TX2_LASTPACKET1|NV_TX2_VALID);
+		if (id->driver_data & DEV_NEED_LASTPACKET1)
+			np->tx_flags |= cpu_to_le32(NV_TX2_LASTPACKET1);	
+	}
 	if (id->driver_data & DEV_IRQMASK_1)
 		np->irqmask = NVREG_IRQMASK_WANTED_1;
 	if (id->driver_data & DEV_IRQMASK_2)
@@ -1569,21 +2106,77 @@ static void __devexit nv_remove(struct p
 static struct pci_device_id pci_tbl[] = {
 	{	/* nForce Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x1C3,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_1,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ,
 	},
 	{	/* nForce2 Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x0066,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_2,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
 	},
 	{	/* nForce3 Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x00D6,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_3,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_4,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_5,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_6,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_7,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* CK804 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_8,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* CK804 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_9,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* MCP04 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_10,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* MCP04 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_11,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,

--=-epFNDHU2IzhNusp4pyEz
Content-Disposition: attachment; filename=linux-2.4.27-pre6-forcedeth.patch
Content-Type: text/plain; name=linux-2.4.27-pre6-forcedeth.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.4.27-pre6/drivers/net/forcedeth.c	2004-04-14 06:05:30.000000000 -0700
+++ linux-2.4.27-pre6-forcedeth/drivers/net/forcedeth.c	2004-06-18 21:07:02.000000000 -0700
@@ -12,6 +12,7 @@
  *
  * Copyright (C) 2003 Manfred Spraul
  * Copyright (C) 2004 Andrew de Quincey (wol support)
+ * Copyright (c) 2004 NVIDIA Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -69,6 +70,9 @@
  *	0.23: 26 Jan 2004: various small cleanups
  *	0.24: 27 Feb 2004: make driver even less anonymous in backtraces
  *	0.25: 09 Mar 2004: wol support
+ *	0.26: 18 May 2004: Gigabit support, new descriptor rings, 
+ *                         added CK804/MCP04 device IDs, code fixes
+ *                         for registers, link status and other minor fixes.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -80,7 +84,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.25"
+#define FORCEDETH_VERSION		"0.26"
 
 #include <linux/module.h>
 #include <linux/types.h>
@@ -96,6 +100,7 @@
 #include <linux/mii.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/version.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -110,6 +115,24 @@
 
 
 /*
+ * This is in since 2.5.69 and 2.4.22
+ */
+#ifndef IRQ_NONE
+#define IRQ_NONE
+#define IRQ_HANDLED
+#define IRQ_RETVAL(x)
+typedef void irqreturn_t;
+#endif
+
+#ifndef pci_name
+#define pci_name(pdev) ((pdev)->slot_name)
+#endif
+
+#ifndef free_netdev
+#define free_netdev(dev) kfree(dev);
+#endif
+
+/*
  * Hardware access:
  */
 
@@ -123,6 +146,7 @@ enum {
 #define NVREG_IRQSTAT_MIIEVENT	0x040
 #define NVREG_IRQSTAT_MASK		0x1ff
 	NvRegIrqMask = 0x004,
+#define NVREG_IRQ_RX_ERROR              0x0001
 #define NVREG_IRQ_RX			0x0002
 #define NVREG_IRQ_RX_NOBUF		0x0004
 #define NVREG_IRQ_TX_ERR		0x0008
@@ -132,7 +156,7 @@ enum {
 #define NVREG_IRQ_TX1			0x0100
 #define NVREG_IRQMASK_WANTED_1		0x005f
 #define NVREG_IRQMASK_WANTED_2		0x0147
-#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
+#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
 
 	NvRegUnknownSetupReg6 = 0x008,
 #define NVREG_UNKSETUP6_VAL		3
@@ -159,7 +183,7 @@ enum {
 
 	NvRegOffloadConfig = 0x90,
 #define NVREG_OFFLOAD_HOMEPHY	0x601
-#define NVREG_OFFLOAD_NORMAL	0x5ee
+#define NVREG_OFFLOAD_NORMAL	RX_NIC_BUFSIZE
 	NvRegReceiverControl = 0x094,
 #define NVREG_RCVCTL_START	0x01
 	NvRegReceiverStatus = 0x98,
@@ -168,6 +192,8 @@ enum {
 	NvRegRandomSeed = 0x9c,
 #define NVREG_RNDSEED_MASK	0x00ff
 #define NVREG_RNDSEED_FORCE	0x7f00
+#define NVREG_RNDSEED_FORCE2    0x2d00
+#define NVREG_RNDSEED_FORCE3    0x7400
 
 	NvRegUnknownSetupReg1 = 0xA0,
 #define NVREG_UNKSETUP1_VAL	0x16070f
@@ -181,6 +207,9 @@ enum {
 	NvRegMulticastMaskA = 0xB8,
 	NvRegMulticastMaskB = 0xBC,
 
+	NvRegPhyInterface   = 0xC0,
+#define PHY_RGMII         0x10000000
+
 	NvRegTxRingPhysAddr = 0x100,
 	NvRegRxRingPhysAddr = 0x104,
 	NvRegRingSizes = 0x108,
@@ -189,12 +218,12 @@ enum {
 	NvRegUnknownTransmitterReg = 0x10c,
 	NvRegLinkSpeed = 0x110,
 #define NVREG_LINKSPEED_FORCE 0x10000
-#define NVREG_LINKSPEED_10	10
+#define NVREG_LINKSPEED_10	1000
 #define NVREG_LINKSPEED_100	100
-#define NVREG_LINKSPEED_1000	1000
+#define NVREG_LINKSPEED_1000	50
 	NvRegUnknownSetupReg5 = 0x130,
 #define NVREG_UNKSETUP5_BIT31	(1<<31)
-	NvRegUnknownSetupReg3 = 0x134,
+	NvRegUnknownSetupReg3 = 0x13c,
 #define NVREG_UNKSETUP3_VAL1	0x200010
 	NvRegTxRxControl = 0x144,
 #define NVREG_TXRXCTL_KICK	0x0001
@@ -213,15 +242,15 @@ enum {
 	NvRegAdapterControl = 0x188,
 #define NVREG_ADAPTCTL_START	0x02
 #define NVREG_ADAPTCTL_LINKUP	0x04
-#define NVREG_ADAPTCTL_PHYVALID	0x4000
+#define NVREG_ADAPTCTL_PHYVALID	0x40000
 #define NVREG_ADAPTCTL_RUNNING	0x100000
 #define NVREG_ADAPTCTL_PHYSHIFT	24
 	NvRegMIISpeed = 0x18c,
 #define NVREG_MIISPEED_BIT8	(1<<8)
 #define NVREG_MIIDELAY	5
 	NvRegMIIControl = 0x190,
-#define NVREG_MIICTL_INUSE	0x10000
-#define NVREG_MIICTL_WRITE	0x08000
+#define NVREG_MIICTL_INUSE	0x08000
+#define NVREG_MIICTL_WRITE	0x00400
 #define NVREG_MIICTL_ADDRSHIFT	5
 	NvRegMIIData = 0x194,
 	NvRegWakeUpFlags = 0x200,
@@ -253,10 +282,20 @@ enum {
 #define NVREG_POWERSTATE_D3		0x0003
 };
 
+/*FIXME big endian */
+
 struct ring_desc {
 	u32 PacketBuffer;
-	u16 Length;
-	u16 Flags;
+	union {
+		struct {
+			u16 Length;
+			u16 Flags;
+		} v1;
+		struct {
+			u32 Length:14;
+			u32 Flags:18;
+		} v2;
+	} u;
 };
 
 #define NV_TX_LASTPACKET	(1<<0)
@@ -269,9 +308,19 @@ struct ring_desc {
 #define NV_TX_ERROR		(1<<14)
 #define NV_TX_VALID		(1<<15)
 
+#define NV_TX2_LASTPACKET	(1<<15)
+#define NV_TX2_RETRYERROR	(1<<4)
+#define NV_TX2_LASTPACKET1	(1<<9)
+#define NV_TX2_DEFERRED		(1<<11)
+#define NV_TX2_CARRIERLOST	(1<<12)
+#define NV_TX2_LATECOLLISION	(1<<13)
+#define NV_TX2_UNDERFLOW	(1<<14)
+#define NV_TX2_ERROR		(1<<16)
+#define NV_TX2_VALID		(1<<17)
+
 #define NV_RX_DESCRIPTORVALID	(1<<0)
 #define NV_RX_MISSEDFRAME	(1<<1)
-#define NV_RX_SUBSTRACT1	(1<<3)
+#define NV_RX_SUBSTRACT1	(1<<2)
 #define NV_RX_ERROR1		(1<<7)
 #define NV_RX_ERROR2		(1<<8)
 #define NV_RX_ERROR3		(1<<9)
@@ -282,6 +331,18 @@ struct ring_desc {
 #define NV_RX_ERROR		(1<<14)
 #define NV_RX_AVAIL		(1<<15)
 
+#define NV_RX2_DESCRIPTORVALID	(1<<15)
+#define NV_RX2_SUBSTRACT1	(1<<11)
+#define NV_RX2_ERROR1		(1<<4)
+#define NV_RX2_ERROR2		(1<<5)
+#define NV_RX2_ERROR3		(1<<6)
+#define NV_RX2_ERROR4		(1<<7)
+#define NV_RX2_CRCERR		(1<<8)
+#define NV_RX2_OVERFLOW		(1<<9)
+#define NV_RX2_FRAMINGERR	(1<<10)
+#define NV_RX2_ERROR		(1<<16)
+#define NV_RX2_AVAIL		(1<<17)
+
 /* Miscelaneous hardware related defines: */
 #define NV_PCI_REGSZ		0x270
 
@@ -309,10 +370,10 @@ struct ring_desc {
 #define DEFAULT_MTU		1500	/* also maximum supported, at least for now */
 
 #define RX_RING		128
-#define TX_RING		16
+#define TX_RING		64
 /* limited to 1 packet until we understand NV_TX_LASTPACKET */
-#define TX_LIMIT_STOP	10
-#define TX_LIMIT_START	5
+#define TX_LIMIT_STOP	63
+#define TX_LIMIT_START	62
 
 /* rx/tx mac addr + type + vlan + align + slack*/
 #define RX_NIC_BUFSIZE		(DEFAULT_MTU + 64)
@@ -322,6 +383,52 @@ struct ring_desc {
 #define OOM_REFILL	(1+HZ/20)
 #define POLL_WAIT	(1+HZ/100)
 
+#define PCI_DEVICE_ID_NVIDIA_NVENET_1  0x01C3
+#define PCI_DEVICE_ID_NVIDIA_NVENET_2  0x0066
+#define PCI_DEVICE_ID_NVIDIA_NVENET_3  0x00D6
+#define PCI_DEVICE_ID_NVIDIA_NVENET_4  0x0086
+#define PCI_DEVICE_ID_NVIDIA_NVENET_5  0x008C
+#define PCI_DEVICE_ID_NVIDIA_NVENET_6  0x00E6
+#define PCI_DEVICE_ID_NVIDIA_NVENET_7  0x00DF
+#define PCI_DEVICE_ID_NVIDIA_NVENET_8  0x0056
+#define PCI_DEVICE_ID_NVIDIA_NVENET_9  0x0057
+#define PCI_DEVICE_ID_NVIDIA_NVENET_10 0x0037
+#define PCI_DEVICE_ID_NVIDIA_NVENET_11 0x0038
+
+#define DESC_VER_1   0x0
+#define DESC_VER_2   0x02100
+
+/* PHY defines */
+#define PHY_OUI_MARVELL   0x5043
+#define PHY_OUI_CICADA    0x03f1
+#define PHYID1_OUI_MASK   0x03ff
+#define PHYID1_OUI_SHFT   6
+#define PHYID2_OUI_MASK   0xfc00
+#define PHYID2_OUI_SHFT   10
+#define PHY_INIT1         0x0f000
+#define PHY_INIT2         0x0e00
+#define PHY_INIT3         0x01000
+#define PHY_INIT4         0x0200
+#define PHY_INIT5         0x0004
+#define PHY_INIT6         0x02000  
+#define PHY_GIGABIT       0x0100
+
+#define PHY_TIMEOUT       0x1
+#define PHY_ERROR         0x2
+
+#define PHY_100           0x1
+#define PHY_1000          0x2
+#define PHY_HALF          0x100
+
+/* MII defines that should be added to <linux/mii.h> */
+#define MII_1000BT_CR     0x09
+#define MII_1000BT_SR     0x0a
+#define ADVERTISE_1000FULL  0x0200
+#define ADVERTISE_1000HALF  0x0100
+#define LPA_1000FULL        0x0800
+#define LPA_1000HALF        0x0400
+
+
 /*
  * SMP locking:
  * All hardware access under dev->priv->lock, except the performance
@@ -345,12 +452,15 @@ struct fe_priv {
 	int duplex;
 	int phyaddr;
 	int wolenabled;
+        unsigned int phy_oui;
+        u16 gigabit;
 
 	/* General data: RO fields */
 	dma_addr_t ring_addr;
 	struct pci_dev *pci_dev;
 	u32 orig_mac[2];
 	u32 irqmask;
+	u32 desc_ver;
 
 	/* rx specific fields.
 	 * Locking: Within irq hander or disable_irq+spin_lock(&np->lock);
@@ -370,10 +480,18 @@ struct fe_priv {
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
-	u16 tx_flags;
+	u32 tx_flags;
 };
 
 /*
+ *  Function pointers based on descriptor version
+ */
+int (*nv_alloc_rx)(struct net_device *dev);
+int (*nv_start_xmit)(struct sk_buff *skb, struct net_device *dev);
+void (*nv_tx_done)(struct net_device *dev);
+void (*nv_rx_process)(struct net_device *dev);
+
+/*
  * Maximum number of loops until we assume that a bit in the irq mask
  * is stuck. Overridable with module param.
  */
@@ -421,24 +539,18 @@ static int reg_delay(struct net_device *
 static int mii_rw(struct net_device *dev, int addr, int miireg, int value)
 {
 	u8 *base = get_hwbase(dev);
-	int was_running;
 	u32 reg;
 	int retval;
 
 	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
-	was_running = 0;
-	reg = readl(base + NvRegAdapterControl);
-	if (reg & NVREG_ADAPTCTL_RUNNING) {
-		was_running = 1;
-		writel(reg & ~NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-	}
+
 	reg = readl(base + NvRegMIIControl);
 	if (reg & NVREG_MIICTL_INUSE) {
 		writel(NVREG_MIICTL_INUSE, base + NvRegMIIControl);
 		udelay(NV_MIIBUSY_DELAY);
 	}
 
-	reg = NVREG_MIICTL_INUSE | (addr << NVREG_MIICTL_ADDRSHIFT) | miireg;
+	reg = (addr << NVREG_MIICTL_ADDRSHIFT) | miireg;
 	if (value != MII_READ) {
 		writel(value, base + NvRegMIIData);
 		reg |= NVREG_MIICTL_WRITE;
@@ -466,13 +578,135 @@ static int mii_rw(struct net_device *dev
 		dprintk(KERN_DEBUG "%s: mii_rw read from reg %d at PHY %d: 0x%x.\n",
 				dev->name, miireg, addr, retval);
 	}
-	if (was_running) {
-		reg = readl(base + NvRegAdapterControl);
-		writel(reg | NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-	}
+
 	return retval;
 }
 
+static int phy_reset(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u32 miicontrol;
+	u32 microseconds = 0;
+	u32 milliseconds = 0;
+	
+	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+	miicontrol |= BMCR_RESET;
+	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
+	        return -1;
+	}
+
+	//wait for 500ms
+	mdelay(500);
+	
+	//must wait till reset is deasserted
+	while (miicontrol & BMCR_RESET) {
+		udelay(NV_MIIBUSY_DELAY);
+		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		microseconds++;
+		if (microseconds == 20) {
+			microseconds = 0;
+			milliseconds++;
+		}
+		if (milliseconds > 50)
+			return -1;
+	}
+	return 0;
+}
+
+static int phy_init(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	u8 *base = get_hwbase(dev);
+	u32 phyinterface, phy_reserved, mii_status, mii_control, mii_control_1000,reg;
+	u32 microseconds = 0;
+	u32 milliseconds = 0;
+
+	// set advertise register
+	reg = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+	reg |= (ADVERTISE_10HALF|ADVERTISE_10FULL|ADVERTISE_100HALF|ADVERTISE_100FULL|0x800|0x400);
+	if (mii_rw(dev, np->phyaddr, MII_ADVERTISE, reg)) {
+		printk(KERN_INFO "%s: phy write to advertise failed.\n", dev->name);
+		return PHY_ERROR;
+	}   
+
+	// get phy interface type
+	phyinterface = readl(base + NvRegPhyInterface);
+
+	// see if gigabit phy
+	mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+	if (mii_status & PHY_GIGABIT) {
+		np->gigabit = PHY_GIGABIT;
+		mii_control_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		mii_control_1000 &= ~ADVERTISE_1000HALF;
+		if (phyinterface & PHY_RGMII)
+			mii_control_1000 |= ADVERTISE_1000FULL;
+		else
+			mii_control_1000 &= ~ADVERTISE_1000FULL;
+		
+		if (mii_rw(dev, np->phyaddr, MII_1000BT_CR, mii_control_1000)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return PHY_ERROR;
+		}   
+	}
+	else
+		np->gigabit = 0;
+
+	// reset the phy
+	if (phy_reset(dev)) {
+		printk(KERN_INFO "%s: phy reset failed\n", dev->name);
+		return PHY_ERROR;
+	}
+
+	// phy vendor specific configuration
+	if ((np->phy_oui == PHY_OUI_CICADA) && (phyinterface & PHY_RGMII) ) {
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_RESV1, MII_READ);
+		phy_reserved &= ~(PHY_INIT1 | PHY_INIT2);
+		phy_reserved |= (PHY_INIT3 | PHY_INIT4);
+		if (mii_rw(dev, np->phyaddr, MII_RESV1, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return -1;
+		}
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_NCONFIG, MII_READ);
+		phy_reserved |= PHY_INIT5;
+		if (mii_rw(dev, np->phyaddr, MII_NCONFIG, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return PHY_ERROR;
+		}   
+	}
+	if (np->phy_oui == PHY_OUI_CICADA) {
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_SREVISION, MII_READ);
+		phy_reserved |= PHY_INIT6;
+		if (mii_rw(dev, np->phyaddr, MII_SREVISION, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", dev->name);
+			return PHY_ERROR;
+		}
+	}
+
+	// restart auto negotiation
+	mii_control = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+	mii_control |= (BMCR_ANRESTART | BMCR_ANENABLE);
+	if (mii_rw(dev, np->phyaddr, MII_BMCR, mii_control)) {
+		return PHY_ERROR;
+	}
+  
+	// check auto negotiation is complete
+	mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+	while (!(mii_status & BMSR_ANEGCOMPLETE)) {
+		udelay(NV_MIIBUSY_DELAY);
+		mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+		microseconds++;
+		if (microseconds == 20) {
+			microseconds = 0;
+			milliseconds++;
+		}
+		if (milliseconds > 1200) {
+			printk(KERN_INFO "%s: phy init failed to autoneg.\n", dev->name);
+			return PHY_TIMEOUT;
+		}
+	}
+	return 0;
+}
+
 static void nv_start_rx(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
@@ -529,13 +763,14 @@ static void nv_stop_tx(struct net_device
 
 static void nv_txrx_reset(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = get_nvpriv(dev);
+        u8 *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_txrx_reset\n", dev->name);
-	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
 	udelay(NV_TXRX_RESET_DELAY);
-	writel(NVREG_TXRXCTL_BIT2, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
 }
 
@@ -646,7 +881,43 @@ static int nv_ioctl(struct net_device *d
  * Return 1 if the allocations for the skbs failed and the
  * rx engine is without Available descriptors
  */
-static int nv_alloc_rx(struct net_device *dev)
+static int nv_alloc_rx_v1(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	unsigned int refill_rx = np->refill_rx;
+
+	while (np->cur_rx != refill_rx) {
+		int nr = refill_rx % RX_RING;
+		struct sk_buff *skb;
+
+		if (np->rx_skbuff[nr] == NULL) {
+
+			skb = dev_alloc_skb(RX_ALLOC_BUFSIZE);
+			if (!skb)
+				break;
+
+			skb->dev = dev;
+			np->rx_skbuff[nr] = skb;
+		} else {
+			skb = np->rx_skbuff[nr];
+		}
+		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
+						PCI_DMA_FROMDEVICE);
+		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
+		np->rx_ring[nr].u.v1.Length = cpu_to_le16(RX_NIC_BUFSIZE);
+		wmb();
+		np->rx_ring[nr].u.v1.Flags = cpu_to_le16(NV_RX_AVAIL);
+		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet  %d marked as Available\n",
+					dev->name, refill_rx);
+		refill_rx++;
+	}
+	np->refill_rx = refill_rx;
+	if (np->cur_rx - refill_rx == RX_RING)
+		return 1;
+	return 0;
+}
+
+static int nv_alloc_rx_v2(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 	unsigned int refill_rx = np->refill_rx;
@@ -669,9 +940,9 @@ static int nv_alloc_rx(struct net_device
 		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
 						PCI_DMA_FROMDEVICE);
 		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
-		np->rx_ring[nr].Length = cpu_to_le16(RX_NIC_BUFSIZE);
+		np->rx_ring[nr].u.v2.Length = cpu_to_le16(RX_NIC_BUFSIZE);
 		wmb();
-		np->rx_ring[nr].Flags = cpu_to_le16(NV_RX_AVAIL);
+		np->rx_ring[nr].u.v2.Flags = cpu_to_le32(NV_RX2_AVAIL);
 		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet  %d marked as Available\n",
 					dev->name, refill_rx);
 		refill_rx++;
@@ -704,13 +975,19 @@ static int nv_init_ring(struct net_devic
 
 	np->next_tx = np->nic_tx = 0;
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->tx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->tx_ring[i].u.v2.Flags = 0;
 	}
 
 	np->cur_rx = RX_RING;
 	np->refill_rx = 0;
 	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->rx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->rx_ring[i].u.v2.Flags = 0;
 	}
 	return nv_alloc_rx(dev);
 }
@@ -720,7 +997,10 @@ static void nv_drain_tx(struct net_devic
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->tx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->tx_ring[i].u.v2.Flags = 0;
 		if (np->tx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->tx_dma[i],
 						np->tx_skbuff[i]->len,
@@ -737,7 +1017,10 @@ static void nv_drain_rx(struct net_devic
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].Flags = 0;
+	  if (np->desc_ver == DESC_VER_1)
+	    np->rx_ring[i].u.v1.Flags = 0;
+	  else
+	    np->rx_ring[i].u.v2.Flags = 0;
 		wmb();
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->rx_dma[i],
@@ -759,7 +1042,7 @@ static void drain_ring(struct net_device
  * nv_start_xmit: dev->hard_start_xmit function
  * Called with dev->xmit_lock held.
  */
-static int nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static int nv_start_xmit_v1(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 	int nr = np->next_tx % TX_RING;
@@ -769,11 +1052,11 @@ static int nv_start_xmit(struct sk_buff 
 					PCI_DMA_TODEVICE);
 
 	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-	np->tx_ring[nr].Length = cpu_to_le16(skb->len-1);
+	np->tx_ring[nr].u.v1.Length = cpu_to_le16(skb->len-1);
 
 	spin_lock_irq(&np->lock);
 	wmb();
-	np->tx_ring[nr].Flags = np->tx_flags;
+	np->tx_ring[nr].u.v1.Flags = np->tx_flags;
 	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
 				dev->name, np->next_tx);
 	{
@@ -792,7 +1075,45 @@ static int nv_start_xmit(struct sk_buff 
 	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
 		netif_stop_queue(dev);
 	spin_unlock_irq(&np->lock);
-	writel(NVREG_TXRXCTL_KICK, get_hwbase(dev) + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
+	pci_push(get_hwbase(dev));
+	return 0;
+}
+
+static int nv_start_xmit_v2(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	int nr = np->next_tx % TX_RING;
+
+	np->tx_skbuff[nr] = skb;
+	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data,skb->len,
+					PCI_DMA_TODEVICE);
+
+	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+	np->tx_ring[nr].u.v2.Length = cpu_to_le16(skb->len-1);
+
+	spin_lock_irq(&np->lock);
+	wmb();
+	np->tx_ring[nr].u.v2.Flags = np->tx_flags;
+	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
+				dev->name, np->next_tx);
+	{
+		int j;
+		for (j=0; j<64; j++) {
+			if ((j%16) == 0)
+				dprintk("\n%03x:", j);
+			dprintk(" %02x", ((unsigned char*)skb->data)[j]);
+		}
+		dprintk("\n");
+	}
+
+	np->next_tx++;
+
+	dev->trans_start = jiffies;
+	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
+		netif_stop_queue(dev);
+	spin_unlock_irq(&np->lock);
+	writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
 	pci_push(get_hwbase(dev));
 	return 0;
 }
@@ -802,25 +1123,60 @@ static int nv_start_xmit(struct sk_buff 
  *
  * Caller must own np->lock.
  */
-static void nv_tx_done(struct net_device *dev)
+static void nv_tx_done_v1(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 
-	while (np->nic_tx < np->next_tx) {
+	while (np->nic_tx != np->next_tx) {
 		struct ring_desc *prd;
 		int i = np->nic_tx % TX_RING;
 
 		prd = &np->tx_ring[i];
 
 		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
-					dev->name, np->nic_tx, prd->Flags);
-		if (prd->Flags & cpu_to_le16(NV_TX_VALID))
+					dev->name, np->nic_tx, prd->u.v1.Flags);
+		if (prd->u.v1.Flags & cpu_to_le16(NV_TX_VALID))
 			break;
-		if (prd->Flags & cpu_to_le16(NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
+		if (prd->u.v1.Flags & cpu_to_le16(NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
 						NV_TX_UNDERFLOW|NV_TX_ERROR)) {
-			if (prd->Flags & cpu_to_le16(NV_TX_UNDERFLOW))
+			if (prd->u.v1.Flags & cpu_to_le16(NV_TX_UNDERFLOW))
+				np->stats.tx_fifo_errors++;
+			if (prd->u.v1.Flags & cpu_to_le16(NV_TX_CARRIERLOST))
+				np->stats.tx_carrier_errors++;
+			np->stats.tx_errors++;
+		} else {
+			np->stats.tx_packets++;
+			np->stats.tx_bytes += np->tx_skbuff[i]->len;
+		}
+		pci_unmap_single(np->pci_dev, np->tx_dma[i],
+					np->tx_skbuff[i]->len,
+					PCI_DMA_TODEVICE);
+		dev_kfree_skb_irq(np->tx_skbuff[i]);
+		np->tx_skbuff[i] = NULL;
+		np->nic_tx++;
+	}
+	if (np->next_tx - np->nic_tx < TX_LIMIT_START)
+		netif_wake_queue(dev);
+}
+static void nv_tx_done_v2(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	while (np->nic_tx != np->next_tx) {
+		struct ring_desc *prd;
+		int i = np->nic_tx % TX_RING;
+
+		prd = &np->tx_ring[i];
+
+		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
+					dev->name, np->nic_tx, prd->u.v2.Flags);
+		if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_VALID))
+			break;
+		if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_RETRYERROR|NV_TX2_CARRIERLOST|NV_TX2_LATECOLLISION|
+						NV_TX2_UNDERFLOW|NV_TX2_ERROR)) {
+			if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_UNDERFLOW))
 				np->stats.tx_fifo_errors++;
-			if (prd->Flags & cpu_to_le16(NV_TX_CARRIERLOST))
+			if (prd->u.v2.Flags & cpu_to_le32(NV_TX2_CARRIERLOST))
 				np->stats.tx_carrier_errors++;
 			np->stats.tx_errors++;
 		} else {
@@ -872,7 +1228,7 @@ static void nv_tx_timeout(struct net_dev
 	spin_unlock_irq(&np->lock);
 }
 
-static void nv_rx_process(struct net_device *dev)
+static void nv_rx_process_v1(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 
@@ -887,9 +1243,9 @@ static void nv_rx_process(struct net_dev
 		i = np->cur_rx % RX_RING;
 		prd = &np->rx_ring[i];
 		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
-					dev->name, np->cur_rx, prd->Flags);
+					dev->name, np->cur_rx, prd->u.v1.Flags);
 
-		if (prd->Flags & cpu_to_le16(NV_RX_AVAIL))
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_AVAIL))
 			break;	/* still owned by hardware, */
 
 		/*
@@ -903,7 +1259,7 @@ static void nv_rx_process(struct net_dev
 
 		{
 			int j;
-			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->Flags);
+			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->u.v1.Flags);
 			for (j=0; j<64; j++) {
 				if ((j%16) == 0)
 					dprintk("\n%03x:", j);
@@ -912,35 +1268,123 @@ static void nv_rx_process(struct net_dev
 			dprintk("\n");
 		}
 		/* look at what we actually got: */
-		if (!(prd->Flags & cpu_to_le16(NV_RX_DESCRIPTORVALID)))
+		if (!(prd->u.v1.Flags & cpu_to_le16(NV_RX_DESCRIPTORVALID)))
 			goto next_pkt;
 
 
-		len = le16_to_cpu(prd->Length);
+		len = le16_to_cpu(prd->u.v1.Length);
 
-		if (prd->Flags & cpu_to_le16(NV_RX_MISSEDFRAME)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_MISSEDFRAME)) {
 			np->stats.rx_missed_errors++;
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_CRCERR)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_CRCERR)) {
 			np->stats.rx_crc_errors++;
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_OVERFLOW)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_OVERFLOW)) {
 			np->stats.rx_over_errors++;
 			np->stats.rx_errors++;
 			goto next_pkt;
 		}
-		if (prd->Flags & cpu_to_le16(NV_RX_ERROR)) {
+		if (prd->u.v1.Flags & cpu_to_le16(NV_RX_ERROR)) {
 			/* framing errors are soft errors, the rest is fatal. */
-			if (prd->Flags & cpu_to_le16(NV_RX_FRAMINGERR)) {
-				if (prd->Flags & cpu_to_le16(NV_RX_SUBSTRACT1)) {
+			if (prd->u.v1.Flags & cpu_to_le16(NV_RX_FRAMINGERR)) {
+				if (prd->u.v1.Flags & cpu_to_le16(NV_RX_SUBSTRACT1)) {
+					len--;
+				}
+			} else {
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+		}
+		/* got a valid packet - forward it to the network core */
+		skb = np->rx_skbuff[i];
+		np->rx_skbuff[i] = NULL;
+
+		skb_put(skb, len);
+		skb->protocol = eth_type_trans(skb, dev);
+		dprintk(KERN_DEBUG "%s: nv_rx_process: packet %d with %d bytes, proto %d accepted.\n",
+					dev->name, np->cur_rx, len, skb->protocol);
+		netif_rx(skb);
+		dev->last_rx = jiffies;
+		np->stats.rx_packets++;
+		np->stats.rx_bytes += len;
+next_pkt:
+		np->cur_rx++;
+	}
+}
+
+static void nv_rx_process_v2(struct net_device *dev)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+
+	for (;;) {
+		struct ring_desc *prd;
+		struct sk_buff *skb;
+		int len;
+		int i;
+		if (np->cur_rx - np->refill_rx >= RX_RING)
+			break;	/* we scanned the whole ring - do not continue */
+
+		i = np->cur_rx % RX_RING;
+		prd = &np->rx_ring[i];
+		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
+					dev->name, np->cur_rx, prd->u.v2.Flags);
+
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_AVAIL))
+			break;	/* still owned by hardware, */
+
+		/*
+		 * the packet is for us - immediately tear down the pci mapping.
+		 * TODO: check if a prefetch of the first cacheline improves
+		 * the performance.
+		 */
+		pci_unmap_single(np->pci_dev, np->rx_dma[i],
+				np->rx_skbuff[i]->len,
+				PCI_DMA_FROMDEVICE);
+
+		{
+			int j;
+			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->u.v2.Flags);
+			for (j=0; j<64; j++) {
+				if ((j%16) == 0)
+					dprintk("\n%03x:", j);
+				dprintk(" %02x", ((unsigned char*)np->rx_skbuff[i]->data)[j]);
+			}
+			dprintk("\n");
+		}
+		/* look at what we actually got: */
+		if (!(prd->u.v2.Flags & cpu_to_le32(NV_RX2_DESCRIPTORVALID)))
+			goto next_pkt;
+
+
+		len = le16_to_cpu(prd->u.v2.Length);
+
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3|NV_RX2_ERROR4)) {
+			np->stats.rx_errors++;
+			goto next_pkt;
+		}
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_CRCERR)) {
+			np->stats.rx_crc_errors++;
+			np->stats.rx_errors++;
+			goto next_pkt;
+		}
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_OVERFLOW)) {
+			np->stats.rx_over_errors++;
+			np->stats.rx_errors++;
+			goto next_pkt;
+		}
+		if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_ERROR)) {
+			/* framing errors are soft errors, the rest is fatal. */
+			if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_FRAMINGERR)) {
+				if (prd->u.v2.Flags & cpu_to_le32(NV_RX2_SUBSTRACT1)) {
 					len--;
 				}
 			} else {
@@ -1042,14 +1486,30 @@ static void nv_set_multicast(struct net_
 static int nv_update_linkspeed(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	int adv, lpa, newls, newdup;
-
+	u8 *base = get_hwbase(dev);
+	int adv, lpa;
+	int newls = np->linkspeed;
+	int newdup = np->duplex;
+	u32 control_1000, status_1000, phyreg;
+
+	if (np->gigabit == PHY_GIGABIT) {
+		control_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		status_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_SR, MII_READ);
+		
+		if ((control_1000 & ADVERTISE_1000FULL) &&
+		    (status_1000 & LPA_1000FULL)) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_1000;
+			newdup = 1;
+			goto set_speed;
+		}
+	}
+	
 	adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
 	lpa = mii_rw(dev, np->phyaddr, MII_LPA, MII_READ);
 	dprintk(KERN_DEBUG "%s: nv_update_linkspeed: PHY advertises 0x%04x, lpa 0x%04x.\n",
 				dev->name, adv, lpa);
 
-	/* FIXME: handle parallel detection properly, handle gigabit ethernet */
+	/* FIXME: handle parallel detection properly */
 	lpa = lpa & adv;
 	if (lpa  & LPA_100FULL) {
 		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
@@ -1068,11 +1528,35 @@ static int nv_update_linkspeed(struct ne
 		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
 		newdup = 0;
 	}
+	
+set_speed:
 	if (np->duplex != newdup || np->linkspeed != newls) {
 		np->duplex = newdup;
 		np->linkspeed = newls;
-		return 1;
-	}
+	}	
+
+	if (np->gigabit == PHY_GIGABIT) {
+		phyreg = readl(base + NvRegRandomSeed);
+		phyreg &= ~(0x3FF00);
+		if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_10)
+			phyreg |=  NVREG_RNDSEED_FORCE3;
+		else if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_100)
+			phyreg |= NVREG_RNDSEED_FORCE2;
+		else if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_1000)
+			phyreg |= NVREG_RNDSEED_FORCE;
+		writel(phyreg, base + NvRegRandomSeed);
+	}
+	
+	phyreg = readl(base + NvRegPhyInterface);
+	phyreg &= ~(0x3);
+	if (np->duplex == 0)
+		phyreg |= PHY_HALF;
+	if ((np->linkspeed & 0xFFF) ==  NVREG_LINKSPEED_100)
+		phyreg |=  PHY_100;
+	else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+		phyreg |= PHY_1000;
+	writel(phyreg, base + NvRegPhyInterface);
+
 	return 0;
 }
 
@@ -1088,26 +1572,28 @@ static void nv_link_irq(struct net_devic
 	printk(KERN_DEBUG "%s: link change notification, status 0x%x.\n", dev->name, miistat);
 
 	miival = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
-	if (miival & BMSR_ANEGCOMPLETE) {
-		nv_update_linkspeed(dev);
+	if (miistat & NVREG_MIISTAT_LINKCHANGE) {
+		if (miival & BMSR_LSTATUS) {
+			nv_update_linkspeed(dev);
 
-		if (netif_carrier_ok(dev)) {
-			nv_stop_rx(dev);
+			if (netif_carrier_ok(dev)) {
+				nv_stop_rx(dev);
+			} else {
+				netif_carrier_on(dev);
+				printk(KERN_INFO "%s: link up.\n", dev->name);
+			}
+			writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
+			       base + NvRegMisc1);
+			nv_start_rx(dev);
 		} else {
-			netif_carrier_on(dev);
-			printk(KERN_INFO "%s: link up.\n", dev->name);
-		}
-		writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
-					base + NvRegMisc1);
-		nv_start_rx(dev);
-	} else {
-		if (netif_carrier_ok(dev)) {
-			netif_carrier_off(dev);
-			printk(KERN_INFO "%s: link down.\n", dev->name);
-			nv_stop_rx(dev);
+			if (netif_carrier_ok(dev)) {
+				netif_carrier_off(dev);
+				printk(KERN_INFO "%s: link down.\n", dev->name);
+				nv_stop_rx(dev);
+			}
+			writel(np->linkspeed, base + NvRegLinkSpeed);
+			pci_push(base);
 		}
-		writel(np->linkspeed, base + NvRegLinkSpeed);
-		pci_push(base);
 	}
 }
 
@@ -1135,7 +1621,7 @@ static irqreturn_t nv_nic_irq(int foo, v
 			spin_unlock(&np->lock);
 		}
 
-		if (events & (NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
+		if (events & (NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
 			nv_rx_process(dev);
 			if (nv_alloc_rx(dev)) {
 				spin_lock(&np->lock);
@@ -1200,6 +1686,7 @@ static int nv_open(struct net_device *de
 	struct fe_priv *np = get_nvpriv(dev);
 	u8 *base = get_hwbase(dev);
 	int ret, oom, i;
+	int phy_status = 0;
 
 	dprintk(KERN_DEBUG "nv_open: begin\n");
 
@@ -1210,15 +1697,21 @@ static int nv_open(struct net_device *de
 	writel(0, base + NvRegMulticastMaskA);
 	writel(0, base + NvRegMulticastMaskB);
 	writel(0, base + NvRegPacketFilterFlags);
+	
+	writel(0, base + NvRegTransmitterControl);
+	writel(0, base + NvRegReceiverControl);
+	
 	writel(0, base + NvRegAdapterControl);
+	
+	/* 2) initialize descriptor rings */
+	oom = nv_init_ring(dev);
+		
 	writel(0, base + NvRegLinkSpeed);
 	writel(0, base + NvRegUnknownTransmitterReg);
 	nv_txrx_reset(dev);
 	writel(0, base + NvRegUnknownSetupReg6);
 
-	/* 2) initialize descriptor rings */
 	np->in_shutdown = 0;
-	oom = nv_init_ring(dev);
 
 	/* 3) set mac address */
 	{
@@ -1232,20 +1725,30 @@ static int nv_open(struct net_device *de
 		writel(mac[1], base + NvRegMacAddrB);
 	}
 
-	/* 4) continue setup */
+	/* 4) give hw rings */
+	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
+	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
+		base + NvRegRingSizes);
+
+	/* 5) continue setup */
 	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
 	np->duplex = 0;
+	
+	writel(np->linkspeed, base + NvRegLinkSpeed);
 	writel(NVREG_UNKSETUP3_VAL1, base + NvRegUnknownSetupReg3);
-	writel(0, base + NvRegTxRxControl);
+	writel(np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
-	writel(NVREG_TXRXCTL_BIT1, base + NvRegTxRxControl);
-	reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
-			NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
-			KERN_INFO "open: SetupReg5, Bit 31 remained off\n");
+	writel(NVREG_TXRXCTL_BIT1|np->desc_ver, base + NvRegTxRxControl);
+        reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
+		  NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
+		  KERN_INFO "open: SetupReg5, Bit 31 remained off\n");  
+
 	writel(0, base + NvRegUnknownSetupReg4);
+	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
+	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 
-	/* 5) Find a suitable PHY */
-	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
+	/* 6a) Find a suitable PHY */
 	for (i = 1; i < 32; i++) {
 		int id1, id2;
 
@@ -1259,13 +1762,13 @@ static int nv_open(struct net_device *de
 		spin_unlock_irq(&np->lock);
 		if (id2 < 0 || id2 == 0xffff)
 			continue;
+
+		id1 = (id1 & PHYID1_OUI_MASK) << PHYID1_OUI_SHFT;
+		id2 = (id2 & PHYID2_OUI_MASK) >> PHYID2_OUI_SHFT;
 		dprintk(KERN_DEBUG "%s: open: Found PHY %04x:%04x at address %d.\n",
 				dev->name, id1, id2, i);
 		np->phyaddr = i;
-
-		spin_lock_irq(&np->lock);
-		nv_update_linkspeed(dev);
-		spin_unlock_irq(&np->lock);
+		np->phy_oui = id1 | id2;
 
 		break;
 	}
@@ -1276,9 +1779,25 @@ static int nv_open(struct net_device *de
 		goto out_drain;
 	}
 
-	/* 6) continue setup */
+	/* 6b) Initialize PHY */
+	spin_lock_irq(&np->lock);
+	
+	/* synchronous init */
+	phy_status = phy_init(dev);
+	if (phy_status == PHY_ERROR) {
+		printk(KERN_INFO "%s: open: failing due to PHY Init.\n", dev->name);
+		ret = -EINVAL;
+		spin_unlock_irq(&np->lock);
+		goto out_drain;
+	}
+	else if (phy_status != PHY_TIMEOUT)
+		nv_update_linkspeed(dev);
+
+	spin_unlock_irq(&np->lock);
+
+	/* 7) continue setup */
 	writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
-				base + NvRegMisc1);
+	       base + NvRegMisc1);
 	writel(readl(base + NvRegTransmitterStatus), base + NvRegTransmitterStatus);
 	writel(NVREG_PFF_ALWAYS, base + NvRegPacketFilterFlags);
 	writel(NVREG_OFFLOAD_NORMAL, base + NvRegOffloadConfig);
@@ -1290,35 +1809,26 @@ static int nv_open(struct net_device *de
 	writel(NVREG_UNKSETUP2_VAL, base + NvRegUnknownSetupReg2);
 	writel(NVREG_POLL_DEFAULT, base + NvRegPollingInterval);
 	writel(NVREG_UNKSETUP6_VAL, base + NvRegUnknownSetupReg6);
-	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID,
-			base + NvRegAdapterControl);
+	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID|NVREG_ADAPTCTL_RUNNING,
+	       base + NvRegAdapterControl);
+	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
 	writel(NVREG_UNKSETUP4_VAL, base + NvRegUnknownSetupReg4);
 	writel(NVREG_WAKEUPFLAGS_VAL, base + NvRegWakeUpFlags);
-
-	/* 7) start packet processing */
-	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
-	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
-	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
-			base + NvRegRingSizes);
-
+	
 	i = readl(base + NvRegPowerState);
 	if ( (i & NVREG_POWERSTATE_POWEREDUP) == 0)
 		writel(NVREG_POWERSTATE_POWEREDUP|i, base + NvRegPowerState);
-
+	
 	pci_push(base);
 	udelay(10);
 	writel(readl(base + NvRegPowerState) | NVREG_POWERSTATE_VALID, base + NvRegPowerState);
-	writel(NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-
-
+	
 	writel(0, base + NvRegIrqMask);
 	pci_push(base);
-	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
-	pci_push(base);
 	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 	pci_push(base);
-
+	
 	ret = request_irq(dev->irq, &nv_nic_irq, SA_SHIRQ, dev->name, dev);
 	if (ret)
 		goto out_drain;
@@ -1336,7 +1846,7 @@ static int nv_open(struct net_device *de
 	netif_start_queue(dev);
 	if (oom)
 		mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-	if (mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ) & BMSR_ANEGCOMPLETE) {
+	if (mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ) & BMSR_LSTATUS) {
 		netif_carrier_on(dev);
 	} else {
 		printk("%s: no link during initialization.\n", dev->name);
@@ -1359,7 +1869,11 @@ static int nv_close(struct net_device *d
 	spin_lock_irq(&np->lock);
 	np->in_shutdown = 1;
 	spin_unlock_irq(&np->lock);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 28)
 	synchronize_irq();
+#else
+	synchronize_irq(dev->irq);
+#endif
 
 	del_timer_sync(&np->oom_kick);
 	del_timer_sync(&np->nic_poll);
@@ -1406,7 +1920,9 @@ static int __devinit nv_probe(struct pci
 	np->pci_dev = pci_dev;
 	spin_lock_init(&np->lock);
 	SET_MODULE_OWNER(dev);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 5, 0)
 	SET_NETDEV_DEV(dev, &pci_dev->dev);
+#endif
 
 	init_timer(&np->oom_kick);
 	np->oom_kick.data = (unsigned long) dev;
@@ -1447,6 +1963,24 @@ static int __devinit nv_probe(struct pci
 		goto out_relreg;
 	}
 
+	/* setup function pointers */
+	if (pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_1 ||
+	    pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_2 ||
+	    pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_3) {
+		np->desc_ver = DESC_VER_1;
+		nv_alloc_rx = nv_alloc_rx_v1;
+		nv_start_xmit = nv_start_xmit_v1;
+		nv_tx_done = nv_tx_done_v1;
+		nv_rx_process = nv_rx_process_v1;
+	}
+	else {
+		np->desc_ver = DESC_VER_2;
+		nv_alloc_rx = nv_alloc_rx_v2;
+		nv_start_xmit = nv_start_xmit_v2;
+		nv_tx_done = nv_tx_done_v2;
+		nv_rx_process = nv_rx_process_v2;
+	}
+
 	err = -ENOMEM;
 	dev->base_addr = (unsigned long) ioremap(addr, NV_PCI_REGSZ);
 	if (!dev->base_addr)
@@ -1505,10 +2039,17 @@ static int __devinit nv_probe(struct pci
 	/* disable WOL */
 	writel(0, base + NvRegWakeUpFlags);
 	np->wolenabled = 0;
-
-	np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
-	if (id->driver_data & DEV_NEED_LASTPACKET1)
-		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
+	
+	if (np->desc_ver == DESC_VER_1) {
+		np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
+		if (id->driver_data & DEV_NEED_LASTPACKET1)
+			np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
+        }
+	else {
+		np->tx_flags = cpu_to_le32(NV_TX2_LASTPACKET|NV_TX2_LASTPACKET1|NV_TX2_VALID);
+		if (id->driver_data & DEV_NEED_LASTPACKET1)
+			np->tx_flags |= cpu_to_le32(NV_TX2_LASTPACKET1);	
+	}
 	if (id->driver_data & DEV_IRQMASK_1)
 		np->irqmask = NVREG_IRQMASK_WANTED_1;
 	if (id->driver_data & DEV_IRQMASK_2)
@@ -1569,21 +2110,77 @@ static void __devexit nv_remove(struct p
 static struct pci_device_id pci_tbl[] = {
 	{	/* nForce Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x1C3,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_1,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ,
 	},
 	{	/* nForce2 Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x0066,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_2,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_3,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_4,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_5,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_6,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
 	},
 	{	/* nForce3 Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x00D6,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_7,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* CK804 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_8,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* CK804 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_9,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* MCP04 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_10,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+	},
+	{	/* MCP04 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_11,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,

--=-epFNDHU2IzhNusp4pyEz--

