Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUIENMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUIENMU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUIENMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:12:19 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:61841 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266627AbUIENKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:10:48 -0400
Date: Sun, 5 Sep 2004 15:10:19 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: linux-kernel@vger.kernel.org
cc: netdev@oss.sgi.com
Subject: [PATCH] backport of forcedeth 0.29 to 2.4
Message-ID: <Pine.LNX.4.44.0409051507530.16334-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

attached is as backport of the latest forcedeth driver to 2.4:

It adds gigabit ethernet support and lots of bugfixes from the 2.6
driver. The most notable change is gigabit ethernet support and a
complete rewrite of the PHY initialization and media detection code.

Please test it: It works for me (nForce 250-Gb), but I don't have
a non-GigE board to test the media detection.

The actual backport was done by Jane Liu:

- all occurrences of msleep changed to mdelay
- invocations of synchronize_irq changed to take no parameters
- SET_NETDEV_DEV calls removed
- module_param call changed to MODULE_PARM

--
	Manfred

// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 28
//  EXTRAVERSION = -pre2
--- 2.4/drivers/net/forcedeth.c	2004-04-14 15:05:30.000000000 +0200
+++ build-2.4/drivers/net/forcedeth.c	2004-09-05 14:34:44.019230793 +0200
@@ -10,8 +10,11 @@
  * trademarks of NVIDIA Corporation in the United States and other
  * countries.
  *
- * Copyright (C) 2003 Manfred Spraul
+ * Copyright (C) 2003,4 Manfred Spraul
  * Copyright (C) 2004 Andrew de Quincey (wol support)
+ * Copyright (C) 2004 Carl-Daniel Hailfinger (invalid MAC handling, insane
+ *		IRQ rate fixes, bigendian fixes, cleanups, verification)
+ * Copyright (c) 2004 NVIDIA Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -60,15 +63,19 @@
  * 	0.19: 29 Nov 2003: Handle RxNoBuf, detect & handle invalid mac
  * 			   addresses, really stop rx if already running
  * 			   in nv_start_rx, clean up a bit.
- * 				(C) Carl-Daniel Hailfinger
  * 	0.20: 07 Dec 2003: alloc fixes
  * 	0.21: 12 Jan 2004: additional alloc fix, nic polling fix.
  *	0.22: 19 Jan 2004: reprogram timer to a sane rate, avoid lockup
- * 			   on close.
- * 				(C) Carl-Daniel Hailfinger, Manfred Spraul
+ *			   on close.
  *	0.23: 26 Jan 2004: various small cleanups
  *	0.24: 27 Feb 2004: make driver even less anonymous in backtraces
  *	0.25: 09 Mar 2004: wol support
+ *	0.26: 03 Jun 2004: netdriver specific annotation, sparse-related fixes
+ *	0.27: 19 Jun 2004: Gigabit support, new descriptor rings,
+ *			   added CK804/MCP04 device IDs, code fixes
+ *			   for registers, link status and other minor fixes.
+ *	0.28: 21 Jun 2004: Big cleanup, making driver mostly endian safe
+ *	0.29: 31 Aug 2004: Add backup timer for link change notification.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -80,7 +87,8 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.25"
+#define FORCEDETH_VERSION		"0.29"
+#define DRV_NAME			"forcedeth"

 #include <linux/module.h>
 #include <linux/types.h>
@@ -113,16 +121,18 @@
  * Hardware access:
  */

-#define DEV_NEED_LASTPACKET1	0x0001
-#define DEV_IRQMASK_1		0x0002
-#define DEV_IRQMASK_2		0x0004
-#define DEV_NEED_TIMERIRQ	0x0008
+#define DEV_NEED_LASTPACKET1	0x0001	/* set LASTPACKET1 in tx flags */
+#define DEV_IRQMASK_1		0x0002  /* use NVREG_IRQMASK_WANTED_1 for irq mask */
+#define DEV_IRQMASK_2		0x0004  /* use NVREG_IRQMASK_WANTED_2 for irq mask */
+#define DEV_NEED_TIMERIRQ	0x0008  /* set the timer irq flag in the irq mask */
+#define DEV_NEED_LINKTIMER	0x0010	/* poll link settings. Relies on the timer irq */

 enum {
 	NvRegIrqStatus = 0x000,
 #define NVREG_IRQSTAT_MIIEVENT	0x040
 #define NVREG_IRQSTAT_MASK		0x1ff
 	NvRegIrqMask = 0x004,
+#define NVREG_IRQ_RX_ERROR		0x0001
 #define NVREG_IRQ_RX			0x0002
 #define NVREG_IRQ_RX_NOBUF		0x0004
 #define NVREG_IRQ_TX_ERR		0x0008
@@ -132,7 +142,7 @@ enum {
 #define NVREG_IRQ_TX1			0x0100
 #define NVREG_IRQMASK_WANTED_1		0x005f
 #define NVREG_IRQMASK_WANTED_2		0x0147
-#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
+#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))

 	NvRegUnknownSetupReg6 = 0x008,
 #define NVREG_UNKSETUP6_VAL		3
@@ -159,7 +169,7 @@ enum {

 	NvRegOffloadConfig = 0x90,
 #define NVREG_OFFLOAD_HOMEPHY	0x601
-#define NVREG_OFFLOAD_NORMAL	0x5ee
+#define NVREG_OFFLOAD_NORMAL	RX_NIC_BUFSIZE
 	NvRegReceiverControl = 0x094,
 #define NVREG_RCVCTL_START	0x01
 	NvRegReceiverStatus = 0x98,
@@ -168,6 +178,8 @@ enum {
 	NvRegRandomSeed = 0x9c,
 #define NVREG_RNDSEED_MASK	0x00ff
 #define NVREG_RNDSEED_FORCE	0x7f00
+#define NVREG_RNDSEED_FORCE2	0x2d00
+#define NVREG_RNDSEED_FORCE3	0x7400

 	NvRegUnknownSetupReg1 = 0xA0,
 #define NVREG_UNKSETUP1_VAL	0x16070f
@@ -181,6 +193,9 @@ enum {
 	NvRegMulticastMaskA = 0xB8,
 	NvRegMulticastMaskB = 0xBC,

+	NvRegPhyInterface = 0xC0,
+#define PHY_RGMII		0x10000000
+
 	NvRegTxRingPhysAddr = 0x100,
 	NvRegRxRingPhysAddr = 0x104,
 	NvRegRingSizes = 0x108,
@@ -189,12 +204,12 @@ enum {
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
@@ -213,15 +228,15 @@ enum {
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
@@ -253,34 +268,63 @@ enum {
 #define NVREG_POWERSTATE_D3		0x0003
 };

+/* Big endian: should work, but is untested */
 struct ring_desc {
 	u32 PacketBuffer;
-	u16 Length;
-	u16 Flags;
+	u32 FlagLen;
 };

-#define NV_TX_LASTPACKET	(1<<0)
-#define NV_TX_RETRYERROR	(1<<3)
-#define NV_TX_LASTPACKET1	(1<<8)
-#define NV_TX_DEFERRED		(1<<10)
-#define NV_TX_CARRIERLOST	(1<<11)
-#define NV_TX_LATECOLLISION	(1<<12)
-#define NV_TX_UNDERFLOW		(1<<13)
-#define NV_TX_ERROR		(1<<14)
-#define NV_TX_VALID		(1<<15)
-
-#define NV_RX_DESCRIPTORVALID	(1<<0)
-#define NV_RX_MISSEDFRAME	(1<<1)
-#define NV_RX_SUBSTRACT1	(1<<3)
-#define NV_RX_ERROR1		(1<<7)
-#define NV_RX_ERROR2		(1<<8)
-#define NV_RX_ERROR3		(1<<9)
-#define NV_RX_ERROR4		(1<<10)
-#define NV_RX_CRCERR		(1<<11)
-#define NV_RX_OVERFLOW		(1<<12)
-#define NV_RX_FRAMINGERR	(1<<13)
-#define NV_RX_ERROR		(1<<14)
-#define NV_RX_AVAIL		(1<<15)
+#define FLAG_MASK_V1 0xffff0000
+#define FLAG_MASK_V2 0xffffc000
+#define LEN_MASK_V1 (0xffffffff ^ FLAG_MASK_V1)
+#define LEN_MASK_V2 (0xffffffff ^ FLAG_MASK_V2)
+
+#define NV_TX_LASTPACKET	(1<<16)
+#define NV_TX_RETRYERROR	(1<<19)
+#define NV_TX_LASTPACKET1	(1<<24)
+#define NV_TX_DEFERRED		(1<<26)
+#define NV_TX_CARRIERLOST	(1<<27)
+#define NV_TX_LATECOLLISION	(1<<28)
+#define NV_TX_UNDERFLOW		(1<<29)
+#define NV_TX_ERROR		(1<<30)
+#define NV_TX_VALID		(1<<31)
+
+#define NV_TX2_LASTPACKET	(1<<29)
+#define NV_TX2_RETRYERROR	(1<<18)
+#define NV_TX2_LASTPACKET1	(1<<23)
+#define NV_TX2_DEFERRED		(1<<25)
+#define NV_TX2_CARRIERLOST	(1<<26)
+#define NV_TX2_LATECOLLISION	(1<<27)
+#define NV_TX2_UNDERFLOW	(1<<28)
+/* error and valid are the same for both */
+#define NV_TX2_ERROR		(1<<30)
+#define NV_TX2_VALID		(1<<31)
+
+#define NV_RX_DESCRIPTORVALID	(1<<16)
+#define NV_RX_MISSEDFRAME	(1<<17)
+#define NV_RX_SUBSTRACT1	(1<<18)
+#define NV_RX_ERROR1		(1<<23)
+#define NV_RX_ERROR2		(1<<24)
+#define NV_RX_ERROR3		(1<<25)
+#define NV_RX_ERROR4		(1<<26)
+#define NV_RX_CRCERR		(1<<27)
+#define NV_RX_OVERFLOW		(1<<28)
+#define NV_RX_FRAMINGERR	(1<<29)
+#define NV_RX_ERROR		(1<<30)
+#define NV_RX_AVAIL		(1<<31)
+
+#define NV_RX2_DESCRIPTORVALID	(1<<29)
+#define NV_RX2_SUBSTRACT1	(1<<25)
+#define NV_RX2_ERROR1		(1<<18)
+#define NV_RX2_ERROR2		(1<<19)
+#define NV_RX2_ERROR3		(1<<20)
+#define NV_RX2_ERROR4		(1<<21)
+#define NV_RX2_CRCERR		(1<<22)
+#define NV_RX2_OVERFLOW		(1<<23)
+#define NV_RX2_FRAMINGERR	(1<<24)
+/* error and avail are the same for both */
+#define NV_RX2_ERROR		(1<<30)
+#define NV_RX2_AVAIL		(1<<31)

 /* Miscelaneous hardware related defines: */
 #define NV_PCI_REGSZ		0x270
@@ -306,28 +350,67 @@ struct ring_desc {

 /* General driver defaults */
 #define NV_WATCHDOG_TIMEO	(5*HZ)
-#define DEFAULT_MTU		1500	/* also maximum supported, at least for now */

 #define RX_RING		128
-#define TX_RING		16
-/* limited to 1 packet until we understand NV_TX_LASTPACKET */
-#define TX_LIMIT_STOP	10
-#define TX_LIMIT_START	5
+#define TX_RING		64
+/*
+ * If your nic mysteriously hangs then try to reduce the limits
+ * to 1/0: It might be required to set NV_TX_LASTPACKET in the
+ * last valid ring entry. But this would be impossible to
+ * implement - probably a disassembly error.
+ */
+#define TX_LIMIT_STOP	63
+#define TX_LIMIT_START	62

 /* rx/tx mac addr + type + vlan + align + slack*/
-#define RX_NIC_BUFSIZE		(DEFAULT_MTU + 64)
+#define RX_NIC_BUFSIZE		(ETH_DATA_LEN + 64)
 /* even more slack */
-#define RX_ALLOC_BUFSIZE	(DEFAULT_MTU + 128)
+#define RX_ALLOC_BUFSIZE	(ETH_DATA_LEN + 128)

 #define OOM_REFILL	(1+HZ/20)
 #define POLL_WAIT	(1+HZ/100)
+#define LINK_TIMEOUT	(3*HZ)
+
+#define DESC_VER_1	0x0
+#define DESC_VER_2	0x02100
+
+/* PHY defines */
+#define PHY_OUI_MARVELL	0x5043
+#define PHY_OUI_CICADA	0x03f1
+#define PHYID1_OUI_MASK	0x03ff
+#define PHYID1_OUI_SHFT	6
+#define PHYID2_OUI_MASK	0xfc00
+#define PHYID2_OUI_SHFT	10
+#define PHY_INIT1	0x0f000
+#define PHY_INIT2	0x0e00
+#define PHY_INIT3	0x01000
+#define PHY_INIT4	0x0200
+#define PHY_INIT5	0x0004
+#define PHY_INIT6	0x02000
+#define PHY_GIGABIT	0x0100
+
+#define PHY_TIMEOUT	0x1
+#define PHY_ERROR	0x2
+
+#define PHY_100	0x1
+#define PHY_1000	0x2
+#define PHY_HALF	0x100
+
+/* FIXME: MII defines that should be added to <linux/mii.h> */
+#define MII_1000BT_CR	0x09
+#define MII_1000BT_SR	0x0a
+#define ADVERTISE_1000FULL	0x0200
+#define ADVERTISE_1000HALF	0x0100
+#define LPA_1000FULL	0x0800
+#define LPA_1000HALF	0x0400
+

 /*
  * SMP locking:
  * All hardware access under dev->priv->lock, except the performance
  * critical parts:
  * - rx is (pseudo-) lockless: it relies on the single-threading provided
- * 	by the arch code for interrupts.
+ *	by the arch code for interrupts.
  * - tx setup is lockless: it relies on dev->xmit_lock. Actual submission
  *	needs dev->priv->lock :-(
  * - set_multicast_list: preparation lockless, relies on dev->xmit_lock.
@@ -345,12 +428,15 @@ struct fe_priv {
 	int duplex;
 	int phyaddr;
 	int wolenabled;
+	unsigned int phy_oui;
+	u16 gigabit;

 	/* General data: RO fields */
 	dma_addr_t ring_addr;
 	struct pci_dev *pci_dev;
 	u32 orig_mac[2];
 	u32 irqmask;
+	u32 desc_ver;

 	/* rx specific fields.
 	 * Locking: Within irq hander or disable_irq+spin_lock(&np->lock);
@@ -363,6 +449,11 @@ struct fe_priv {
 	struct timer_list oom_kick;
 	struct timer_list nic_poll;

+	/* media detection workaround.
+	 * Locking: Within irq hander or disable_irq+spin_lock(&np->lock);
+	 */
+	int need_linktimer;
+	unsigned long link_timeout;
 	/*
 	 * tx specific fields.
 	 */
@@ -370,7 +461,7 @@ struct fe_priv {
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
-	u16 tx_flags;
+	u32 tx_flags;
 };

 /*
@@ -395,6 +486,12 @@ static inline void pci_push(u8 * base)
 	readl(base);
 }

+static inline u32 nv_descr_getlength(struct ring_desc *prd, u32 v)
+{
+	return le32_to_cpu(prd->FlagLen)
+		& ((v == DESC_VER_1) ? LEN_MASK_V1 : LEN_MASK_V2);
+}
+
 static int reg_delay(struct net_device *dev, int offset, u32 mask, u32 target,
 				int delay, int delaymax, const char *msg)
 {
@@ -421,24 +518,18 @@ static int reg_delay(struct net_device *
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
@@ -460,19 +551,117 @@ static int mii_rw(struct net_device *dev
 				dev->name, miireg, addr);
 		retval = -1;
 	} else {
-		/* FIXME: why is that required? */
-		udelay(50);
 		retval = readl(base + NvRegMIIData);
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
+	unsigned int tries = 0;
+
+	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+	miicontrol |= BMCR_RESET;
+	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
+		return -1;
+	}
+
+	/* wait for 500ms */
+	mdelay(500);
+
+	/* must wait till reset is deasserted */
+	while (miicontrol & BMCR_RESET) {
+		mdelay(10);
+		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		/* FIXME: 100 tries seem excessive */
+		if (tries++ > 100)
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
+
+	/* set advertise register */
+	reg = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+	reg |= (ADVERTISE_10HALF|ADVERTISE_10FULL|ADVERTISE_100HALF|ADVERTISE_100FULL|0x800|0x400);
+	if (mii_rw(dev, np->phyaddr, MII_ADVERTISE, reg)) {
+		printk(KERN_INFO "%s: phy write to advertise failed.\n", pci_name(np->pci_dev));
+		return PHY_ERROR;
+	}
+
+	/* get phy interface type */
+	phyinterface = readl(base + NvRegPhyInterface);
+
+	/* see if gigabit phy */
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
+			printk(KERN_INFO "%s: phy init failed.\n", pci_name(np->pci_dev));
+			return PHY_ERROR;
+		}
+	}
+	else
+		np->gigabit = 0;
+
+	/* reset the phy */
+	if (phy_reset(dev)) {
+		printk(KERN_INFO "%s: phy reset failed\n", pci_name(np->pci_dev));
+		return PHY_ERROR;
+	}
+
+	/* phy vendor specific configuration */
+	if ((np->phy_oui == PHY_OUI_CICADA) && (phyinterface & PHY_RGMII) ) {
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_RESV1, MII_READ);
+		phy_reserved &= ~(PHY_INIT1 | PHY_INIT2);
+		phy_reserved |= (PHY_INIT3 | PHY_INIT4);
+		if (mii_rw(dev, np->phyaddr, MII_RESV1, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", pci_name(np->pci_dev));
+			return PHY_ERROR;
+		}
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_NCONFIG, MII_READ);
+		phy_reserved |= PHY_INIT5;
+		if (mii_rw(dev, np->phyaddr, MII_NCONFIG, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", pci_name(np->pci_dev));
+			return PHY_ERROR;
+		}
+	}
+	if (np->phy_oui == PHY_OUI_CICADA) {
+		phy_reserved = mii_rw(dev, np->phyaddr, MII_SREVISION, MII_READ);
+		phy_reserved |= PHY_INIT6;
+		if (mii_rw(dev, np->phyaddr, MII_SREVISION, phy_reserved)) {
+			printk(KERN_INFO "%s: phy init failed.\n", pci_name(np->pci_dev));
+			return PHY_ERROR;
+		}
+	}
+
+	/* restart auto negotiation */
+	mii_control = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+	mii_control |= (BMCR_ANRESTART | BMCR_ANENABLE);
+	if (mii_rw(dev, np->phyaddr, MII_BMCR, mii_control)) {
+		return PHY_ERROR;
+	}
+
+	return 0;
+}
+
 static void nv_start_rx(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
@@ -487,6 +676,8 @@ static void nv_start_rx(struct net_devic
 	writel(np->linkspeed, base + NvRegLinkSpeed);
 	pci_push(base);
 	writel(NVREG_RCVCTL_START, base + NvRegReceiverControl);
+	dprintk(KERN_DEBUG "%s: nv_start_rx to duplex %d, speed 0x%08x.\n",
+				dev->name, np->duplex, np->linkspeed);
 	pci_push(base);
 }

@@ -497,8 +688,8 @@ static void nv_stop_rx(struct net_device
 	dprintk(KERN_DEBUG "%s: nv_stop_rx\n", dev->name);
 	writel(0, base + NvRegReceiverControl);
 	reg_delay(dev, NvRegReceiverStatus, NVREG_RCVSTAT_BUSY, 0,
-		       NV_RXSTOP_DELAY1, NV_RXSTOP_DELAY1MAX,
-		       KERN_INFO "nv_stop_rx: ReceiverStatus remained busy");
+			NV_RXSTOP_DELAY1, NV_RXSTOP_DELAY1MAX,
+			KERN_INFO "nv_stop_rx: ReceiverStatus remained busy");

 	udelay(NV_RXSTOP_DELAY2);
 	writel(0, base + NvRegLinkSpeed);
@@ -520,8 +711,8 @@ static void nv_stop_tx(struct net_device
 	dprintk(KERN_DEBUG "%s: nv_stop_tx\n", dev->name);
 	writel(0, base + NvRegTransmitterControl);
 	reg_delay(dev, NvRegTransmitterStatus, NVREG_XMITSTAT_BUSY, 0,
-		       NV_TXSTOP_DELAY1, NV_TXSTOP_DELAY1MAX,
-		       KERN_INFO "nv_stop_tx: TransmitterStatus remained busy");
+			NV_TXSTOP_DELAY1, NV_TXSTOP_DELAY1MAX,
+			KERN_INFO "nv_stop_tx: TransmitterStatus remained busy");

 	udelay(NV_TXSTOP_DELAY2);
 	writel(0, base + NvRegUnknownTransmitterReg);
@@ -529,13 +720,14 @@ static void nv_stop_tx(struct net_device

 static void nv_txrx_reset(struct net_device *dev)
 {
+	struct fe_priv *np = get_nvpriv(dev);
 	u8 *base = get_hwbase(dev);

 	dprintk(KERN_DEBUG "%s: nv_txrx_reset\n", dev->name);
-	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
 	udelay(NV_TXRX_RESET_DELAY);
-	writel(NVREG_TXRXCTL_BIT2, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | np->desc_ver, base + NvRegTxRxControl);
 	pci_push(base);
 }

@@ -556,7 +748,7 @@ static struct net_device_stats *nv_get_s
 	return &np->stats;
 }

-static int nv_ethtool_ioctl(struct net_device *dev, void *useraddr)
+static int nv_ethtool_ioctl(struct net_device *dev, void __user *useraddr)
 {
 	struct fe_priv *np = get_nvpriv(dev);
 	u8 *base = get_hwbase(dev);
@@ -634,7 +826,7 @@ static int nv_ioctl(struct net_device *d
 {
 	switch(cmd) {
 	case SIOCETHTOOL:
-		return nv_ethtool_ioctl(dev, (void *) rq->ifr_data);
+		return nv_ethtool_ioctl(dev, rq->ifr_data);

 	default:
 		return -EOPNOTSUPP;
@@ -650,11 +842,12 @@ static int nv_alloc_rx(struct net_device
 {
 	struct fe_priv *np = get_nvpriv(dev);
 	unsigned int refill_rx = np->refill_rx;
+	int nr;

 	while (np->cur_rx != refill_rx) {
-		int nr = refill_rx % RX_RING;
 		struct sk_buff *skb;

+		nr = refill_rx % RX_RING;
 		if (np->rx_skbuff[nr] == NULL) {

 			skb = dev_alloc_skb(RX_ALLOC_BUFSIZE);
@@ -669,10 +862,9 @@ static int nv_alloc_rx(struct net_device
 		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
 						PCI_DMA_FROMDEVICE);
 		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
-		np->rx_ring[nr].Length = cpu_to_le16(RX_NIC_BUFSIZE);
 		wmb();
-		np->rx_ring[nr].Flags = cpu_to_le16(NV_RX_AVAIL);
-		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet  %d marked as Available\n",
+		np->rx_ring[nr].FlagLen = cpu_to_le32(RX_NIC_BUFSIZE | NV_RX_AVAIL);
+		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet %d marked as Available\n",
 					dev->name, refill_rx);
 		refill_rx++;
 	}
@@ -703,15 +895,13 @@ static int nv_init_ring(struct net_devic
 	int i;

 	np->next_tx = np->nic_tx = 0;
-	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].Flags = 0;
-	}
+	for (i = 0; i < TX_RING; i++)
+		np->tx_ring[i].FlagLen = 0;

 	np->cur_rx = RX_RING;
 	np->refill_rx = 0;
-	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].Flags = 0;
-	}
+	for (i = 0; i < RX_RING; i++)
+		np->rx_ring[i].FlagLen = 0;
 	return nv_alloc_rx(dev);
 }

@@ -720,7 +910,7 @@ static void nv_drain_tx(struct net_devic
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].Flags = 0;
+		np->tx_ring[i].FlagLen = 0;
 		if (np->tx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->tx_dma[i],
 						np->tx_skbuff[i]->len,
@@ -737,7 +927,7 @@ static void nv_drain_rx(struct net_devic
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].Flags = 0;
+		np->rx_ring[i].FlagLen = 0;
 		wmb();
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->rx_dma[i],
@@ -769,11 +959,10 @@ static int nv_start_xmit(struct sk_buff
 					PCI_DMA_TODEVICE);

 	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-	np->tx_ring[nr].Length = cpu_to_le16(skb->len-1);

 	spin_lock_irq(&np->lock);
 	wmb();
-	np->tx_ring[nr].Flags = np->tx_flags;
+	np->tx_ring[nr].FlagLen = cpu_to_le32( (skb->len-1) | np->tx_flags );
 	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
 				dev->name, np->next_tx);
 	{
@@ -792,7 +981,7 @@ static int nv_start_xmit(struct sk_buff
 	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
 		netif_stop_queue(dev);
 	spin_unlock_irq(&np->lock);
-	writel(NVREG_TXRXCTL_KICK, get_hwbase(dev) + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
 	pci_push(get_hwbase(dev));
 	return 0;
 }
@@ -805,27 +994,42 @@ static int nv_start_xmit(struct sk_buff
 static void nv_tx_done(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
+	u32 Flags;
+	int i;

-	while (np->nic_tx < np->next_tx) {
-		struct ring_desc *prd;
-		int i = np->nic_tx % TX_RING;
+	while (np->nic_tx != np->next_tx) {
+		i = np->nic_tx % TX_RING;

-		prd = &np->tx_ring[i];
+		Flags = le32_to_cpu(np->tx_ring[i].FlagLen);

 		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
-					dev->name, np->nic_tx, prd->Flags);
-		if (prd->Flags & cpu_to_le16(NV_TX_VALID))
+					dev->name, np->nic_tx, Flags);
+		if (Flags & NV_TX_VALID)
 			break;
-		if (prd->Flags & cpu_to_le16(NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
-						NV_TX_UNDERFLOW|NV_TX_ERROR)) {
-			if (prd->Flags & cpu_to_le16(NV_TX_UNDERFLOW))
-				np->stats.tx_fifo_errors++;
-			if (prd->Flags & cpu_to_le16(NV_TX_CARRIERLOST))
-				np->stats.tx_carrier_errors++;
-			np->stats.tx_errors++;
+		if (np->desc_ver == DESC_VER_1) {
+			if (Flags & (NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
+							NV_TX_UNDERFLOW|NV_TX_ERROR)) {
+				if (Flags & NV_TX_UNDERFLOW)
+					np->stats.tx_fifo_errors++;
+				if (Flags & NV_TX_CARRIERLOST)
+					np->stats.tx_carrier_errors++;
+				np->stats.tx_errors++;
+			} else {
+				np->stats.tx_packets++;
+				np->stats.tx_bytes += np->tx_skbuff[i]->len;
+			}
 		} else {
-			np->stats.tx_packets++;
-			np->stats.tx_bytes += np->tx_skbuff[i]->len;
+			if (Flags & (NV_TX2_RETRYERROR|NV_TX2_CARRIERLOST|NV_TX2_LATECOLLISION|
+							NV_TX2_UNDERFLOW|NV_TX2_ERROR)) {
+				if (Flags & NV_TX2_UNDERFLOW)
+					np->stats.tx_fifo_errors++;
+				if (Flags & NV_TX2_CARRIERLOST)
+					np->stats.tx_carrier_errors++;
+				np->stats.tx_errors++;
+			} else {
+				np->stats.tx_packets++;
+				np->stats.tx_bytes += np->tx_skbuff[i]->len;
+			}
 		}
 		pci_unmap_single(np->pci_dev, np->tx_dma[i],
 					np->tx_skbuff[i]->len,
@@ -875,9 +1079,9 @@ static void nv_tx_timeout(struct net_dev
 static void nv_rx_process(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
+	u32 Flags;

 	for (;;) {
-		struct ring_desc *prd;
 		struct sk_buff *skb;
 		int len;
 		int i;
@@ -885,11 +1089,13 @@ static void nv_rx_process(struct net_dev
 			break;	/* we scanned the whole ring - do not continue */

 		i = np->cur_rx % RX_RING;
-		prd = &np->rx_ring[i];
+		Flags = le32_to_cpu(np->rx_ring[i].FlagLen);
+		len = nv_descr_getlength(&np->rx_ring[i], np->desc_ver);
+
 		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
-					dev->name, np->cur_rx, prd->Flags);
+					dev->name, np->cur_rx, Flags);

-		if (prd->Flags & cpu_to_le16(NV_RX_AVAIL))
+		if (Flags & NV_RX_AVAIL)
 			break;	/* still owned by hardware, */

 		/*
@@ -903,7 +1109,7 @@ static void nv_rx_process(struct net_dev

 		{
 			int j;
-			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",prd->Flags);
+			dprintk(KERN_DEBUG "Dumping packet (flags 0x%x).",Flags);
 			for (j=0; j<64; j++) {
 				if ((j%16) == 0)
 					dprintk("\n%03x:", j);
@@ -912,41 +1118,69 @@ static void nv_rx_process(struct net_dev
 			dprintk("\n");
 		}
 		/* look at what we actually got: */
-		if (!(prd->Flags & cpu_to_le16(NV_RX_DESCRIPTORVALID)))
-			goto next_pkt;
-
-
-		len = le16_to_cpu(prd->Length);
+		if (np->desc_ver == DESC_VER_1) {
+			if (!(Flags & NV_RX_DESCRIPTORVALID))
+				goto next_pkt;

-		if (prd->Flags & cpu_to_le16(NV_RX_MISSEDFRAME)) {
-			np->stats.rx_missed_errors++;
-			np->stats.rx_errors++;
-			goto next_pkt;
-		}
-		if (prd->Flags & cpu_to_le16(NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
-			np->stats.rx_errors++;
-			goto next_pkt;
-		}
-		if (prd->Flags & cpu_to_le16(NV_RX_CRCERR)) {
-			np->stats.rx_crc_errors++;
-			np->stats.rx_errors++;
-			goto next_pkt;
-		}
-		if (prd->Flags & cpu_to_le16(NV_RX_OVERFLOW)) {
-			np->stats.rx_over_errors++;
-			np->stats.rx_errors++;
-			goto next_pkt;
-		}
-		if (prd->Flags & cpu_to_le16(NV_RX_ERROR)) {
-			/* framing errors are soft errors, the rest is fatal. */
-			if (prd->Flags & cpu_to_le16(NV_RX_FRAMINGERR)) {
-				if (prd->Flags & cpu_to_le16(NV_RX_SUBSTRACT1)) {
-					len--;
+			if (Flags & NV_RX_MISSEDFRAME) {
+				np->stats.rx_missed_errors++;
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+			if (Flags & (NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+			if (Flags & NV_RX_CRCERR) {
+				np->stats.rx_crc_errors++;
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+			if (Flags & NV_RX_OVERFLOW) {
+				np->stats.rx_over_errors++;
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+			if (Flags & NV_RX_ERROR) {
+				/* framing errors are soft errors, the rest is fatal. */
+				if (Flags & NV_RX_FRAMINGERR) {
+					if (Flags & NV_RX_SUBSTRACT1) {
+						len--;
+					}
+				} else {
+					np->stats.rx_errors++;
+					goto next_pkt;
 				}
-			} else {
+			}
+		} else {
+			if (!(Flags & NV_RX2_DESCRIPTORVALID))
+				goto next_pkt;
+
+			if (Flags & (NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3|NV_RX2_ERROR4)) {
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+			if (Flags & NV_RX2_CRCERR) {
+				np->stats.rx_crc_errors++;
 				np->stats.rx_errors++;
 				goto next_pkt;
 			}
+			if (Flags & NV_RX2_OVERFLOW) {
+				np->stats.rx_over_errors++;
+				np->stats.rx_errors++;
+				goto next_pkt;
+			}
+			if (Flags & NV_RX2_ERROR) {
+				/* framing errors are soft errors, the rest is fatal. */
+				if (Flags & NV_RX2_FRAMINGERR) {
+					if (Flags & NV_RX2_SUBSTRACT1) {
+						len--;
+					}
+				} else {
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+			}
 		}
 		/* got a valid packet - forward it to the network core */
 		skb = np->rx_skbuff[i];
@@ -971,7 +1205,7 @@ next_pkt:
  */
 static int nv_change_mtu(struct net_device *dev, int new_mtu)
 {
-	if (new_mtu > DEFAULT_MTU)
+	if (new_mtu > ETH_DATA_LEN)
 		return -EINVAL;
 	dev->mtu = new_mtu;
 	return 0;
@@ -1035,6 +1269,8 @@ static void nv_set_multicast(struct net_
 	writel(mask[0], base + NvRegMulticastMaskA);
 	writel(mask[1], base + NvRegMulticastMaskB);
 	writel(pff, base + NvRegPacketFilterFlags);
+	dprintk(KERN_INFO "%s: reconfiguration for multicast lists.\n",
+		dev->name);
 	nv_start_rx(dev);
 	spin_unlock_irq(&np->lock);
 }
@@ -1042,16 +1278,62 @@ static void nv_set_multicast(struct net_
 static int nv_update_linkspeed(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	int adv, lpa, newls, newdup;
+	u8 *base = get_hwbase(dev);
+	int adv, lpa;
+	int newls = np->linkspeed;
+	int newdup = np->duplex;
+	int mii_status;
+	int retval = 0;
+	u32 control_1000, status_1000, phyreg;
+
+	/* BMSR_LSTATUS is latched, read it twice:
+	 * we want the current value.
+	 */
+	mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+	mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+
+	if (!(mii_status & BMSR_LSTATUS)) {
+		dprintk(KERN_DEBUG "%s: no link detected by phy - falling back to 10HD.\n",
+				dev->name);
+		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+		newdup = 0;
+		retval = 0;
+		goto set_speed;
+	}
+
+	/* check auto negotiation is complete */
+	if (!(mii_status & BMSR_ANEGCOMPLETE)) {
+		/* still in autonegotiation - configure nic for 10 MBit HD and wait. */
+		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+		newdup = 0;
+		retval = 0;
+		dprintk(KERN_DEBUG "%s: autoneg not completed - falling back to 10HD.\n", dev->name);
+		goto set_speed;
+	}
+
+	retval = 1;
+	if (np->gigabit == PHY_GIGABIT) {
+		control_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		status_1000 = mii_rw(dev, np->phyaddr, MII_1000BT_SR, MII_READ);
+
+		if ((control_1000 & ADVERTISE_1000FULL) &&
+			(status_1000 & LPA_1000FULL)) {
+		dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
+				dev->name);
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_1000;
+			newdup = 1;
+			goto set_speed;
+		}
+	}

 	adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
 	lpa = mii_rw(dev, np->phyaddr, MII_LPA, MII_READ);
 	dprintk(KERN_DEBUG "%s: nv_update_linkspeed: PHY advertises 0x%04x, lpa 0x%04x.\n",
 				dev->name, adv, lpa);

-	/* FIXME: handle parallel detection properly, handle gigabit ethernet */
+	/* FIXME: handle parallel detection properly */
 	lpa = lpa & adv;
-	if (lpa  & LPA_100FULL) {
+	if (lpa & LPA_100FULL) {
 		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
 		newdup = 1;
 	} else if (lpa & LPA_100HALF) {
@@ -1068,37 +1350,57 @@ static int nv_update_linkspeed(struct ne
 		newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
 		newdup = 0;
 	}
-	if (np->duplex != newdup || np->linkspeed != newls) {
-		np->duplex = newdup;
-		np->linkspeed = newls;
-		return 1;
-	}
-	return 0;
-}

-static void nv_link_irq(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
-	u32 miistat;
-	int miival;
+set_speed:
+	if (np->duplex == newdup && np->linkspeed == newls)
+		return retval;
+
+	dprintk(KERN_INFO "%s: changing link setting from %d/%d to %d/%d.\n",
+			dev->name, np->linkspeed, np->duplex, newls, newdup);
+
+	np->duplex = newdup;
+	np->linkspeed = newls;
+
+	if (np->gigabit == PHY_GIGABIT) {
+		phyreg = readl(base + NvRegRandomSeed);
+		phyreg &= ~(0x3FF00);
+		if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_10)
+			phyreg |= NVREG_RNDSEED_FORCE3;
+		else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_100)
+			phyreg |= NVREG_RNDSEED_FORCE2;
+		else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+			phyreg |= NVREG_RNDSEED_FORCE;
+		writel(phyreg, base + NvRegRandomSeed);
+	}
+
+	phyreg = readl(base + NvRegPhyInterface);
+	phyreg &= ~(PHY_HALF|PHY_100|PHY_1000);
+	if (np->duplex == 0)
+		phyreg |= PHY_HALF;
+	if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_100)
+		phyreg |= PHY_100;
+	else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+		phyreg |= PHY_1000;
+	writel(phyreg, base + NvRegPhyInterface);

-	miistat = readl(base + NvRegMIIStatus);
-	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
-	printk(KERN_DEBUG "%s: link change notification, status 0x%x.\n", dev->name, miistat);
+	writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
+		base + NvRegMisc1);
+	pci_push(base);
+	writel(np->linkspeed, base + NvRegLinkSpeed);
+	pci_push(base);

-	miival = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
-	if (miival & BMSR_ANEGCOMPLETE) {
-		nv_update_linkspeed(dev);
+	return retval;
+}

+static void nv_linkchange(struct net_device *dev)
+{
+	if (nv_update_linkspeed(dev)) {
 		if (netif_carrier_ok(dev)) {
 			nv_stop_rx(dev);
 		} else {
 			netif_carrier_on(dev);
 			printk(KERN_INFO "%s: link up.\n", dev->name);
 		}
-		writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
-					base + NvRegMisc1);
 		nv_start_rx(dev);
 	} else {
 		if (netif_carrier_ok(dev)) {
@@ -1106,11 +1408,23 @@ static void nv_link_irq(struct net_devic
 			printk(KERN_INFO "%s: link down.\n", dev->name);
 			nv_stop_rx(dev);
 		}
-		writel(np->linkspeed, base + NvRegLinkSpeed);
-		pci_push(base);
 	}
 }

+static void nv_link_irq(struct net_device *dev)
+{
+	u8 *base = get_hwbase(dev);
+	u32 miistat;
+
+	miistat = readl(base + NvRegMIIStatus);
+	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
+	dprintk(KERN_INFO "%s: link change irq, status 0x%x.\n", dev->name, miistat);
+
+	if (miistat & (NVREG_MIISTAT_LINKCHANGE))
+		nv_linkchange(dev);
+	dprintk(KERN_DEBUG "%s: link change notification done.\n", dev->name);
+}
+
 static irqreturn_t nv_nic_irq(int foo, void *data, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) data;
@@ -1135,7 +1449,7 @@ static irqreturn_t nv_nic_irq(int foo, v
 			spin_unlock(&np->lock);
 		}

-		if (events & (NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
+		if (events & (NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
 			nv_rx_process(dev);
 			if (nv_alloc_rx(dev)) {
 				spin_lock(&np->lock);
@@ -1150,6 +1464,12 @@ static irqreturn_t nv_nic_irq(int foo, v
 			nv_link_irq(dev);
 			spin_unlock(&np->lock);
 		}
+		if (np->need_linktimer && time_after(jiffies, np->link_timeout)) {
+			spin_lock(&np->lock);
+			nv_linkchange(dev);
+			spin_unlock(&np->lock);
+			np->link_timeout = jiffies + LINK_TIMEOUT;
+		}
 		if (events & (NVREG_IRQ_TX_ERR)) {
 			dprintk(KERN_DEBUG "%s: received irq with events 0x%x. Probably TX fail.\n",
 						dev->name, events);
@@ -1157,7 +1477,7 @@ static irqreturn_t nv_nic_irq(int foo, v
 		if (events & (NVREG_IRQ_UNKNOWN)) {
 			printk(KERN_DEBUG "%s: received irq with unknown events 0x%x. Please report\n",
 						dev->name, events);
- 		}
+		}
 		if (i > max_interrupt_work) {
 			spin_lock(&np->lock);
 			/* disable interrupts on the nic */
@@ -1210,21 +1530,27 @@ static int nv_open(struct net_device *de
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
 		u32 mac[2];

-		mac[0] = (dev->dev_addr[0] <<  0) + (dev->dev_addr[1] <<  8) +
+		mac[0] = (dev->dev_addr[0] << 0) + (dev->dev_addr[1] << 8) +
 				(dev->dev_addr[2] << 16) + (dev->dev_addr[3] << 24);
 		mac[1] = (dev->dev_addr[4] << 0) + (dev->dev_addr[5] << 8);

@@ -1232,53 +1558,31 @@ static int nv_open(struct net_device *de
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
+	writel(NVREG_TXRXCTL_BIT1|np->desc_ver, base + NvRegTxRxControl);
 	reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
 			NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
 			KERN_INFO "open: SetupReg5, Bit 31 remained off\n");
-	writel(0, base + NvRegUnknownSetupReg4);
-
-	/* 5) Find a suitable PHY */
-	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
-	for (i = 1; i < 32; i++) {
-		int id1, id2;
-
-		spin_lock_irq(&np->lock);
-		id1 = mii_rw(dev, i, MII_PHYSID1, MII_READ);
-		spin_unlock_irq(&np->lock);
-		if (id1 < 0 || id1 == 0xffff)
-			continue;
-		spin_lock_irq(&np->lock);
-		id2 = mii_rw(dev, i, MII_PHYSID2, MII_READ);
-		spin_unlock_irq(&np->lock);
-		if (id2 < 0 || id2 == 0xffff)
-			continue;
-		dprintk(KERN_DEBUG "%s: open: Found PHY %04x:%04x at address %d.\n",
-				dev->name, id1, id2, i);
-		np->phyaddr = i;
-
-		spin_lock_irq(&np->lock);
-		nv_update_linkspeed(dev);
-		spin_unlock_irq(&np->lock);

-		break;
-	}
-	if (i == 32) {
-		printk(KERN_INFO "%s: open: failing due to lack of suitable PHY.\n",
-				dev->name);
-		ret = -EINVAL;
-		goto out_drain;
-	}
+	writel(0, base + NvRegUnknownSetupReg4);
+	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
+	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);

 	/* 6) continue setup */
-	writel(NVREG_MISC1_FORCE | ( np->duplex ? 0 : NVREG_MISC1_HD),
-				base + NvRegMisc1);
+	writel(NVREG_MISC1_FORCE | NVREG_MISC1_HD, base + NvRegMisc1);
 	writel(readl(base + NvRegTransmitterStatus), base + NvRegTransmitterStatus);
 	writel(NVREG_PFF_ALWAYS, base + NvRegPacketFilterFlags);
 	writel(NVREG_OFFLOAD_NORMAL, base + NvRegOffloadConfig);
@@ -1290,17 +1594,12 @@ static int nv_open(struct net_device *de
 	writel(NVREG_UNKSETUP2_VAL, base + NvRegUnknownSetupReg2);
 	writel(NVREG_POLL_DEFAULT, base + NvRegPollingInterval);
 	writel(NVREG_UNKSETUP6_VAL, base + NvRegUnknownSetupReg6);
-	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID,
+	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID|NVREG_ADAPTCTL_RUNNING,
 			base + NvRegAdapterControl);
+	writel(NVREG_MIISPEED_BIT8|NVREG_MIIDELAY, base + NvRegMIISpeed);
 	writel(NVREG_UNKSETUP4_VAL, base + NvRegUnknownSetupReg4);
 	writel(NVREG_WAKEUPFLAGS_VAL, base + NvRegWakeUpFlags);

-	/* 7) start packet processing */
-	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
-	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
-	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
-			base + NvRegRingSizes);
-
 	i = readl(base + NvRegPowerState);
 	if ( (i & NVREG_POWERSTATE_POWEREDUP) == 0)
 		writel(NVREG_POWERSTATE_POWEREDUP|i, base + NvRegPowerState);
@@ -1308,13 +1607,9 @@ static int nv_open(struct net_device *de
 	pci_push(base);
 	udelay(10);
 	writel(readl(base + NvRegPowerState) | NVREG_POWERSTATE_VALID, base + NvRegPowerState);
-	writel(NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-

 	writel(0, base + NvRegIrqMask);
 	pci_push(base);
-	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
-	pci_push(base);
 	writel(NVREG_MIISTAT_MASK2, base + NvRegMIIStatus);
 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
 	pci_push(base);
@@ -1323,6 +1618,7 @@ static int nv_open(struct net_device *de
 	if (ret)
 		goto out_drain;

+	/* ask for interrupts */
 	writel(np->irqmask, base + NvRegIrqMask);

 	spin_lock_irq(&np->lock);
@@ -1331,18 +1627,27 @@ static int nv_open(struct net_device *de
 	writel(0, base + NvRegMulticastMaskA);
 	writel(0, base + NvRegMulticastMaskB);
 	writel(NVREG_PFF_ALWAYS|NVREG_PFF_MYADDR, base + NvRegPacketFilterFlags);
+	/* One manual link speed update: Interrupts are enabled, future link
+	 * speed changes cause interrupts and are handled by nv_link_irq().
+	 */
+	{
+		u32 miistat;
+		miistat = readl(base + NvRegMIIStatus);
+		writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
+		dprintk(KERN_INFO "startup: got 0x%08x.\n", miistat);
+	}
+	ret = nv_update_linkspeed(dev);
 	nv_start_rx(dev);
 	nv_start_tx(dev);
 	netif_start_queue(dev);
-	if (oom)
-		mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-	if (mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ) & BMSR_ANEGCOMPLETE) {
+	if (ret) {
 		netif_carrier_on(dev);
 	} else {
 		printk("%s: no link during initialization.\n", dev->name);
 		netif_carrier_off(dev);
 	}
-
+	if (oom)
+		mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
 	spin_unlock_irq(&np->lock);

 	return 0;
@@ -1406,7 +1711,6 @@ static int __devinit nv_probe(struct pci
 	np->pci_dev = pci_dev;
 	spin_lock_init(&np->lock);
 	SET_MODULE_OWNER(dev);
-	SET_NETDEV_DEV(dev, &pci_dev->dev);

 	init_timer(&np->oom_kick);
 	np->oom_kick.data = (unsigned long) dev;
@@ -1424,7 +1728,7 @@ static int __devinit nv_probe(struct pci

 	pci_set_master(pci_dev);

-	err = pci_request_regions(pci_dev, dev->name);
+	err = pci_request_regions(pci_dev, DRV_NAME);
 	if (err < 0)
 		goto out_disable;

@@ -1447,6 +1751,14 @@ static int __devinit nv_probe(struct pci
 		goto out_relreg;
 	}

+	/* handle different descriptor versions */
+	if (pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_1 ||
+		pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_2 ||
+		pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_3)
+		np->desc_ver = DESC_VER_1;
+	else
+		np->desc_ver = DESC_VER_2;
+
 	err = -ENOMEM;
 	dev->base_addr = (unsigned long) ioremap(addr, NV_PCI_REGSZ);
 	if (!dev->base_addr)
@@ -1506,15 +1818,65 @@ static int __devinit nv_probe(struct pci
 	writel(0, base + NvRegWakeUpFlags);
 	np->wolenabled = 0;

-	np->tx_flags = cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID);
-	if (id->driver_data & DEV_NEED_LASTPACKET1)
-		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
+	if (np->desc_ver == DESC_VER_1) {
+		np->tx_flags = NV_TX_LASTPACKET|NV_TX_VALID;
+		if (id->driver_data & DEV_NEED_LASTPACKET1)
+			np->tx_flags |= NV_TX_LASTPACKET1;
+	} else {
+		np->tx_flags = NV_TX2_LASTPACKET|NV_TX2_VALID;
+		if (id->driver_data & DEV_NEED_LASTPACKET1)
+			np->tx_flags |= NV_TX2_LASTPACKET1;
+	}
 	if (id->driver_data & DEV_IRQMASK_1)
 		np->irqmask = NVREG_IRQMASK_WANTED_1;
 	if (id->driver_data & DEV_IRQMASK_2)
 		np->irqmask = NVREG_IRQMASK_WANTED_2;
 	if (id->driver_data & DEV_NEED_TIMERIRQ)
 		np->irqmask |= NVREG_IRQ_TIMER;
+	if (id->driver_data & DEV_NEED_LINKTIMER) {
+		dprintk(KERN_INFO "%s: link timer on.\n", pci_name(pci_dev));
+		np->need_linktimer = 1;
+		np->link_timeout = jiffies + LINK_TIMEOUT;
+	} else {
+		dprintk(KERN_INFO "%s: link timer off.\n", pci_name(pci_dev));
+		np->need_linktimer = 0;
+	}
+
+	/* find a suitable phy */
+	for (i = 1; i < 32; i++) {
+		int id1, id2;
+
+		spin_lock_irq(&np->lock);
+		id1 = mii_rw(dev, i, MII_PHYSID1, MII_READ);
+		spin_unlock_irq(&np->lock);
+		if (id1 < 0 || id1 == 0xffff)
+			continue;
+		spin_lock_irq(&np->lock);
+		id2 = mii_rw(dev, i, MII_PHYSID2, MII_READ);
+		spin_unlock_irq(&np->lock);
+		if (id2 < 0 || id2 == 0xffff)
+			continue;
+
+		id1 = (id1 & PHYID1_OUI_MASK) << PHYID1_OUI_SHFT;
+		id2 = (id2 & PHYID2_OUI_MASK) >> PHYID2_OUI_SHFT;
+		dprintk(KERN_DEBUG "%s: open: Found PHY %04x:%04x at address %d.\n",
+				pci_name(pci_dev), id1, id2, i);
+		np->phyaddr = i;
+		np->phy_oui = id1 | id2;
+		break;
+	}
+	if (i == 32) {
+		/* PHY in isolate mode? No phy attached and user wants to
+		 * test loopback? Very odd, but can be correct.
+		 */
+		printk(KERN_INFO "%s: open: Could not find a valid PHY.\n",
+				pci_name(pci_dev));
+	}
+
+	if (i != 32) {
+		/* reset it */
+		phy_init(dev);
+	}

 	err = register_netdev(dev);
 	if (err) {
@@ -1569,21 +1931,77 @@ static void __devexit nv_remove(struct p
 static struct pci_device_id pci_tbl[] = {
 	{	/* nForce Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x1C3,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_1,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ,
+		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce2 Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x0066,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_2,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_3,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+	},
+	{	/* nForce3 Ethernet Controller */
+		.vendor = PCI_VENDOR_ID_NVIDIA,
+		.device = PCI_DEVICE_ID_NVIDIA_NVENET_4,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
 	},
 	{	/* nForce3 Ethernet Controller */
 		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = 0x00D6,
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
@@ -1612,7 +2030,7 @@ static void __exit exit_nic(void)

 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM_DESC(max_interrupt_work, "forcedeth maximum events handled per interrupt");
-
+
 MODULE_AUTHOR("Manfred Spraul <manfred@colorfullife.com>");
 MODULE_DESCRIPTION("Reverse Engineered nForce ethernet driver");
 MODULE_LICENSE("GPL");
--- 2.4/include/linux/pci_ids.h	2004-09-05 12:19:08.000000000 +0200
+++ build-2.4/include/linux/pci_ids.h	2004-09-05 14:34:14.043803399 +0200
@@ -981,21 +981,31 @@
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE	0x0035
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA	0x0036
+#define PCI_DEVICE_ID_NVIDIA_NVENET_10		0x0037
+#define PCI_DEVICE_ID_NVIDIA_NVENET_11		0x0038
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2	0x003e
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE	0x0053
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA	0x0054
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
+#define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
+#define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
+#define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
+#define PCI_DEVICE_ID_NVIDIA_NVENET_4		0x0086
+#define PCI_DEVICE_ID_NVIDIA_NVENET_5		0x008c
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
+#define PCI_DEVICE_ID_NVIDIA_NVENET_3		0x00d5
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
+#define PCI_DEVICE_ID_NVIDIA_NVENET_7		0x00df
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5
+#define PCI_DEVICE_ID_NVIDIA_NVENET_6		0x00e6
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
@@ -1012,6 +1022,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
 #define PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO		0x01b1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
+#define PCI_DEVICE_ID_NVIDIA_NVENET_1		0x01c3
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201

