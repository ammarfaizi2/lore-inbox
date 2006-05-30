Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWE3WSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWE3WSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWE3WSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:18:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47883 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932524AbWE3WSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:18:32 -0400
Date: Wed, 31 May 2006 00:03:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: marcelo@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH-2.4] forcedeth update to 0.50
Message-ID: <20060530220319.GA6945@w.ods.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Manfred,

Today I had an opportunity to perform some functional and performance
tests on a SunFire X2100, which is a PCI Express-based Dual Core Opteron 
equipped with a broadcom gigabit LAN chip (tg3) and an Nforce4 Pro
chipset offering a second LAN port (forcedeth).

With the forcedeth driver version 0.30 as shipped in 2.4.33-pre*, ping
was OK, but the driver hanged after a few megabytes of Gigabit-speed
outgoing traffic, with some "NETDEV transmit time out" messages. It was
necessary to unload then reload it. So I decided it was time to give
your updates a try.

I started from the latest backport you sent in september (0.42) and
incrementally applied 2.6 updates. I stopped at 0.50 which provides
VLAN support, because after this one, there are some 2.4-incompatible
changes (64bit consistent memory allocation for rings, and MSI/MSIX
support).

It compiled and worked immediately, and now shows very high performance !
Right now, there's a test running at 925 Mbps and 400 kpps, but I could
reach 1.09 Mpps of input traffic and full gigabit speed above 400 bytes
per packet without any trouble. The test above has been running for 6
hours now, which represents 2.5 TB and 8.6 billions of packets. Moreover,
the test only consumes 15% CPU after I set the poll_interval limit to 10
microseconds.

However, I had to increase the max_interrupt_work to 10, because at 5,
I would receive the following message almost every second (both in 0.30
and 0.50) : "too many iterations (6) in nv_nic_irq". At 10, it never
happened.

I guess we should raise it both in 2.4 and 2.6, but I did not do it in
the patch below because I wanted the code to be as similar as possible
between the two trees.

Given that the driver is almost not usable in 0.30, I suspect that very
few people currently use it as-is with kernel 2.4. And since it shows
excellent performance in 0.50, and does not exhibit any instability, I
think that there would be far more benefits than risks in merging it.

How do you feel about this ?

BTW, I have CCed John Linville who maintains network drivers for RHEL3
and who might be interested too.

Regard,
Willy


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.32-forcedeth-0.50.diff"

>From nobody Mon Sep 17 00:00:00 2001
From: Willy TARREAU <willy@pcw.(none)>
Date: Tue, 30 May 2006 23:26:28 +0200
Subject: [NETDRV] updated the forcedeth driver to 0.50

While testing the forcedeth driver on a SunFire X2100 (Opteron Dual
Core), I encountered problems with the driver hanging after a few
megabytes while pushing traffic at Gbps speed. The driver was at 0.30.
An mostly trivial update to 0.50 fixed all the problems and brought a
huge performance boost. However, max_interrupt_work should be set to
10 not 5 above 400 kpps.

---

 drivers/net/forcedeth.c | 1567 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/pci_ids.h |    4 
 2 files changed, 1200 insertions(+), 371 deletions(-)

001a72816f856774c12fd2863f55b8ddf26d0095
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 7605eb7..bab7893 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -10,7 +10,7 @@
  * trademarks of NVIDIA Corporation in the United States and other
  * countries.
  *
- * Copyright (C) 2003,4 Manfred Spraul
+ * Copyright (C) 2003,4,5 Manfred Spraul
  * Copyright (C) 2004 Andrew de Quincey (wol support)
  * Copyright (C) 2004 Carl-Daniel Hailfinger (invalid MAC handling, insane
  *		IRQ rate fixes, bigendian fixes, cleanups, verification)
@@ -79,6 +79,30 @@
  *	0.30: 25 Sep 2004: rx checksum support for nf 250 Gb. Add rx reset
  *			   into nv_close, otherwise reenabling for wol can
  *			   cause DMA to kfree'd memory.
+ *	0.31: 14 Nov 2004: ethtool support for getting/setting link
+ *			   capabilities.
+ *	0.32: 16 Apr 2005: RX_ERROR4 handling added.
+ *	0.33: 16 May 2005: Support for MCP51 added.
+ *	0.34: 18 Jun 2005: Add DEV_NEED_LINKTIMER to all nForce nics.
+ *	0.35: 26 Jun 2005: Support for MCP55 added.
+ *	0.36: 28 Jun 2005: Add jumbo frame support.
+ *	0.37: 10 Jul 2005: Additional ethtool support, cleanup of pci id list
+ *	0.38: 16 Jul 2005: tx irq rewrite: Use global flags instead of
+ *			   per-packet flags.
+ *	0.39: 18 Jul 2005: Add 64bit descriptor support.
+ *	0.40: 19 Jul 2005: Add support for mac address change.
+ *	0.41: 30 Jul 2005: Write back original MAC in nv_close instead
+ *			   of nv_remove
+ *	0.42: 06 Aug 2005: Fix lack of link speed initialization
+ *			   in the second (and later) nv_open call
+ *	0.43: 10 Aug 2005: Add support for tx checksum.
+ *	0.44: 20 Aug 2005: Add support for scatter gather and segmentation.
+ *	0.45: 18 Sep 2005: Remove nv_stop/start_rx from every link check
+ *	0.46: 20 Oct 2005: Add irq optimization modes.
+ *	0.47: 26 Oct 2005: Add phyaddr 0 in phy scan.
+ *	0.48: 24 Dec 2005: Disable TSO, bugfix for pci_map_single
+ *	0.49: 10 Dec 2005: Fix tso for large buffers.
+ *	0.50: 20 Jan 2006: Add 8021pq tagging support.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -90,7 +114,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.30"
+#define FORCEDETH_VERSION		"0.50"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -108,6 +132,7 @@ #include <linux/skbuff.h>
 #include <linux/mii.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/if_vlan.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -120,16 +145,22 @@ #else
 #define dprintk(x...)		do { } while (0)
 #endif
 
+/* not present in 2.4 */
+#ifndef NETDEV_TX_OK
+#define NETDEV_TX_OK	0
+#define NETDEV_TX_BUSY	1
+#endif
 
 /*
  * Hardware access:
  */
 
-#define DEV_NEED_LASTPACKET1	0x0001	/* set LASTPACKET1 in tx flags */
-#define DEV_IRQMASK_1		0x0002  /* use NVREG_IRQMASK_WANTED_1 for irq mask */
-#define DEV_IRQMASK_2		0x0004  /* use NVREG_IRQMASK_WANTED_2 for irq mask */
-#define DEV_NEED_TIMERIRQ	0x0008  /* set the timer irq flag in the irq mask */
-#define DEV_NEED_LINKTIMER	0x0010	/* poll link settings. Relies on the timer irq */
+#define DEV_NEED_TIMERIRQ	0x0001	/* set the timer irq flag in the irq mask */
+#define DEV_NEED_LINKTIMER	0x0002	/* poll link settings. Relies on the timer irq */
+#define DEV_HAS_LARGEDESC	0x0004	/* device supports jumbo frames and needs packet format 2 */
+#define DEV_HAS_HIGH_DMA	0x0008	/* device supports 64bit dma */
+#define DEV_HAS_CHECKSUM	0x0010	/* device supports tx and rx checksum offloads */
+#define DEV_HAS_VLAN		0x0020	/* device supports vlan tagging and striping */
 
 enum {
 	NvRegIrqStatus = 0x000,
@@ -140,13 +171,17 @@ #define NVREG_IRQ_RX_ERROR		0x0001
 #define NVREG_IRQ_RX			0x0002
 #define NVREG_IRQ_RX_NOBUF		0x0004
 #define NVREG_IRQ_TX_ERR		0x0008
-#define NVREG_IRQ_TX2			0x0010
+#define NVREG_IRQ_TX_OK			0x0010
 #define NVREG_IRQ_TIMER			0x0020
 #define NVREG_IRQ_LINK			0x0040
+#define NVREG_IRQ_TX_ERROR		0x0080
 #define NVREG_IRQ_TX1			0x0100
-#define NVREG_IRQMASK_WANTED_1		0x005f
-#define NVREG_IRQMASK_WANTED_2		0x0147
-#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
+#define NVREG_IRQMASK_THROUGHPUT	0x00df
+#define NVREG_IRQMASK_CPU		0x0040
+
+#define NVREG_IRQ_UNKNOWN	(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR| \
+					NVREG_IRQ_TX_OK|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX_ERROR| \
+					NVREG_IRQ_TX1))
 
 	NvRegUnknownSetupReg6 = 0x008,
 #define NVREG_UNKSETUP6_VAL		3
@@ -156,7 +191,8 @@ #define NVREG_UNKSETUP6_VAL		3
  * NVREG_POLL_DEFAULT=97 would result in an interval length of 1 ms
  */
 	NvRegPollingInterval = 0x00c,
-#define NVREG_POLL_DEFAULT	970
+#define NVREG_POLL_DEFAULT_THROUGHPUT	970
+#define NVREG_POLL_DEFAULT_CPU	13
 	NvRegMisc1 = 0x080,
 #define NVREG_MISC1_HD		0x02
 #define NVREG_MISC1_FORCE	0x3b0f3c
@@ -211,6 +247,7 @@ #define NVREG_LINKSPEED_FORCE 0x10000
 #define NVREG_LINKSPEED_10	1000
 #define NVREG_LINKSPEED_100	100
 #define NVREG_LINKSPEED_1000	50
+#define NVREG_LINKSPEED_MASK	(0xFFF)
 	NvRegUnknownSetupReg5 = 0x130,
 #define NVREG_UNKSETUP5_BIT31	(1<<31)
 	NvRegUnknownSetupReg3 = 0x13c,
@@ -222,6 +259,11 @@ #define NVREG_TXRXCTL_BIT2	0x0004
 #define NVREG_TXRXCTL_IDLE	0x0008
 #define NVREG_TXRXCTL_RESET	0x0010
 #define NVREG_TXRXCTL_RXCHECK	0x0400
+#define NVREG_TXRXCTL_DESC_1	0
+#define NVREG_TXRXCTL_DESC_2	0x02100
+#define NVREG_TXRXCTL_DESC_3	0x02200
+#define NVREG_TXRXCTL_VLANSTRIP 0x00040
+#define NVREG_TXRXCTL_VLANINS	0x00080
 	NvRegMIIStatus = 0x180,
 #define NVREG_MIISTAT_ERROR		0x0001
 #define NVREG_MIISTAT_LINKCHANGE	0x0008
@@ -271,6 +313,8 @@ #define NVREG_POWERSTATE_D0		0x0000
 #define NVREG_POWERSTATE_D1		0x0001
 #define NVREG_POWERSTATE_D2		0x0002
 #define NVREG_POWERSTATE_D3		0x0003
+	NvRegVlanControl = 0x300,
+#define NVREG_VLANCONTROL_ENABLE	0x2000
 };
 
 /* Big endian: should work, but is untested */
@@ -279,6 +323,18 @@ struct ring_desc {
 	u32 FlagLen;
 };
 
+struct ring_desc_ex {
+	u32 PacketBufferHigh;
+	u32 PacketBufferLow;
+	u32 TxVlan;
+	u32 FlagLen;
+};
+
+typedef union _ring_type {
+	struct ring_desc* orig;
+	struct ring_desc_ex* ex;
+} ring_type;
+
 #define FLAG_MASK_V1 0xffff0000
 #define FLAG_MASK_V2 0xffffc000
 #define LEN_MASK_V1 (0xffffffff ^ FLAG_MASK_V1)
@@ -286,7 +342,7 @@ #define LEN_MASK_V2 (0xffffffff ^ FLAG_M
 
 #define NV_TX_LASTPACKET	(1<<16)
 #define NV_TX_RETRYERROR	(1<<19)
-#define NV_TX_LASTPACKET1	(1<<24)
+#define NV_TX_FORCED_INTERRUPT	(1<<24)
 #define NV_TX_DEFERRED		(1<<26)
 #define NV_TX_CARRIERLOST	(1<<27)
 #define NV_TX_LATECOLLISION	(1<<28)
@@ -296,7 +352,7 @@ #define NV_TX_VALID		(1<<31)
 
 #define NV_TX2_LASTPACKET	(1<<29)
 #define NV_TX2_RETRYERROR	(1<<18)
-#define NV_TX2_LASTPACKET1	(1<<23)
+#define NV_TX2_FORCED_INTERRUPT	(1<<30)
 #define NV_TX2_DEFERRED		(1<<25)
 #define NV_TX2_CARRIERLOST	(1<<26)
 #define NV_TX2_LATECOLLISION	(1<<27)
@@ -304,6 +360,14 @@ #define NV_TX2_UNDERFLOW	(1<<28)
 /* error and valid are the same for both */
 #define NV_TX2_ERROR		(1<<30)
 #define NV_TX2_VALID		(1<<31)
+#define NV_TX2_TSO		(1<<28)
+#define NV_TX2_TSO_SHIFT	14
+#define NV_TX2_TSO_MAX_SHIFT	14
+#define NV_TX2_TSO_MAX_SIZE	(1<<NV_TX2_TSO_MAX_SHIFT)
+#define NV_TX2_CHECKSUM_L3	(1<<27)
+#define NV_TX2_CHECKSUM_L4	(1<<26)
+
+#define NV_TX3_VLAN_TAG_PRESENT (1<<18)
 
 #define NV_RX_DESCRIPTORVALID	(1<<16)
 #define NV_RX_MISSEDFRAME	(1<<17)
@@ -335,6 +399,9 @@ #define NV_RX2_FRAMINGERR	(1<<24)
 #define NV_RX2_ERROR		(1<<30)
 #define NV_RX2_AVAIL		(1<<31)
 
+#define NV_RX3_VLAN_TAG_PRESENT (1<<16)
+#define NV_RX3_VLAN_TAG_MASK	(0x0000FFFF)
+
 /* Miscelaneous hardware related defines: */
 #define NV_PCI_REGSZ		0x270
 
@@ -361,34 +428,39 @@ #define NV_WAKEUPMASKENTRIES	4
 #define NV_WATCHDOG_TIMEO	(5*HZ)
 
 #define RX_RING		128
-#define TX_RING		64
-/*
+#define TX_RING		256
+/* 
  * If your nic mysteriously hangs then try to reduce the limits
  * to 1/0: It might be required to set NV_TX_LASTPACKET in the
  * last valid ring entry. But this would be impossible to
  * implement - probably a disassembly error.
  */
-#define TX_LIMIT_STOP	63
-#define TX_LIMIT_START	62
+#define TX_LIMIT_STOP	255
+#define TX_LIMIT_START	254
 
 /* rx/tx mac addr + type + vlan + align + slack*/
-#define RX_NIC_BUFSIZE		(ETH_DATA_LEN + 64)
-/* even more slack */
-#define RX_ALLOC_BUFSIZE	(ETH_DATA_LEN + 128)
+#define NV_RX_HEADERS		(64)
+/* even more slack. */
+#define NV_RX_ALLOC_PAD		(64)
+
+/* maximum mtu size */
+#define NV_PKTLIMIT_1	ETH_DATA_LEN	/* hard limit not known */
+#define NV_PKTLIMIT_2	9100	/* Actual limit according to NVidia: 9202 */
 
 #define OOM_REFILL	(1+HZ/20)
 #define POLL_WAIT	(1+HZ/100)
 #define LINK_TIMEOUT	(3*HZ)
 
-/*
+/* 
  * desc_ver values:
- * This field has two purposes:
- * - Newer nics uses a different ring layout. The layout is selected by
- *   comparing np->desc_ver with DESC_VER_xy.
- * - It contains bits that are forced on when writing to NvRegTxRxControl.
+ * The nic supports three different descriptor types:
+ * - DESC_VER_1: Original
+ * - DESC_VER_2: support for jumbo frames.
+ * - DESC_VER_3: 64-bit format.
  */
-#define DESC_VER_1	0x0
-#define DESC_VER_2	(0x02100|NVREG_TXRXCTL_RXCHECK)
+#define DESC_VER_1	1
+#define DESC_VER_2	2
+#define DESC_VER_3	3
 
 /* PHY defines */
 #define PHY_OUI_MARVELL	0x5043
@@ -442,6 +514,8 @@ struct fe_priv {
 	int in_shutdown;
 	u32 linkspeed;
 	int duplex;
+	int autoneg;
+	int fixed_mode;
 	int phyaddr;
 	int wolenabled;
 	unsigned int phy_oui;
@@ -453,15 +527,20 @@ struct fe_priv {
 	u32 orig_mac[2];
 	u32 irqmask;
 	u32 desc_ver;
+	u32 txrxctl_bits;
+	u32 vlanctl_bits;
+
+	void __iomem *base;
 
 	/* rx specific fields.
 	 * Locking: Within irq hander or disable_irq+spin_lock(&np->lock);
 	 */
-	struct ring_desc *rx_ring;
+	ring_type rx_ring;
 	unsigned int cur_rx, refill_rx;
 	struct sk_buff *rx_skbuff[RX_RING];
 	dma_addr_t rx_dma[RX_RING];
 	unsigned int rx_buf_sz;
+	unsigned int pkt_limit;
 	struct timer_list oom_kick;
 	struct timer_list nic_poll;
 
@@ -473,11 +552,15 @@ struct fe_priv {
 	/*
 	 * tx specific fields.
 	 */
-	struct ring_desc *tx_ring;
+	ring_type tx_ring;
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
+	unsigned int tx_dma_len[TX_RING];
 	u32 tx_flags;
+
+	/* vlan fields */
+	struct vlan_group *vlangrp;
 };
 
 /*
@@ -486,17 +569,36 @@ struct fe_priv {
  */
 static int max_interrupt_work = 5;
 
+/*
+ * Optimization can be either throuput mode or cpu mode
+ * 
+ * Throughput Mode: Every tx and rx packet will generate an interrupt.
+ * CPU Mode: Interrupts are controlled by a timer.
+ */
+#define NV_OPTIMIZATION_MODE_THROUGHPUT 0
+#define NV_OPTIMIZATION_MODE_CPU        1
+static int optimization_mode = NV_OPTIMIZATION_MODE_THROUGHPUT;
+
+/*
+ * Poll interval for timer irq
+ *
+ * This interval determines how frequent an interrupt is generated.
+ * The is value is determined by [(time_in_micro_secs * 100) / (2^10)]
+ * Min = 0, and Max = 65535
+ */
+static int poll_interval = -1;
+
 static inline struct fe_priv *get_nvpriv(struct net_device *dev)
 {
-	return (struct fe_priv *) dev->priv;
+	return netdev_priv(dev);
 }
 
-static inline u8 *get_hwbase(struct net_device *dev)
+static inline u8 __iomem *get_hwbase(struct net_device *dev)
 {
-	return (u8 *) dev->base_addr;
+	return ((struct fe_priv *)netdev_priv(dev))->base;
 }
 
-static inline void pci_push(u8 * base)
+static inline void pci_push(u8 __iomem *base)
 {
 	/* force out pending posted writes */
 	readl(base);
@@ -508,10 +610,15 @@ static inline u32 nv_descr_getlength(str
 		& ((v == DESC_VER_1) ? LEN_MASK_V1 : LEN_MASK_V2);
 }
 
+static inline u32 nv_descr_getlength_ex(struct ring_desc_ex *prd, u32 v)
+{
+	return le32_to_cpu(prd->FlagLen) & LEN_MASK_V2;
+}
+
 static int reg_delay(struct net_device *dev, int offset, u32 mask, u32 target,
 				int delay, int delaymax, const char *msg)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	pci_push(base);
 	do {
@@ -533,7 +640,7 @@ #define MII_READ	(-1)
  */
 static int mii_rw(struct net_device *dev, int addr, int miireg, int value)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 reg;
 	int retval;
 
@@ -577,7 +684,7 @@ static int mii_rw(struct net_device *dev
 
 static int phy_reset(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 	u32 miicontrol;
 	unsigned int tries = 0;
 
@@ -604,7 +711,7 @@ static int phy_reset(struct net_device *
 static int phy_init(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 phyinterface, phy_reserved, mii_status, mii_control, mii_control_1000,reg;
 
 	/* set advertise register */
@@ -680,8 +787,8 @@ static int phy_init(struct net_device *d
 
 static void nv_start_rx(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_start_rx\n", dev->name);
 	/* Already running? Stop it. */
@@ -699,7 +806,7 @@ static void nv_start_rx(struct net_devic
 
 static void nv_stop_rx(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_stop_rx\n", dev->name);
 	writel(0, base + NvRegReceiverControl);
@@ -713,7 +820,7 @@ static void nv_stop_rx(struct net_device
 
 static void nv_start_tx(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_start_tx\n", dev->name);
 	writel(NVREG_XMITCTL_START, base + NvRegTransmitterControl);
@@ -722,7 +829,7 @@ static void nv_start_tx(struct net_devic
 
 static void nv_stop_tx(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_stop_tx\n", dev->name);
 	writel(0, base + NvRegTransmitterControl);
@@ -736,14 +843,14 @@ static void nv_stop_tx(struct net_device
 
 static void nv_txrx_reset(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_txrx_reset\n", dev->name);
-	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->desc_ver, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->txrxctl_bits, base + NvRegTxRxControl);
 	pci_push(base);
 	udelay(NV_TXRX_RESET_DELAY);
-	writel(NVREG_TXRXCTL_BIT2 | np->desc_ver, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT2 | np->txrxctl_bits, base + NvRegTxRxControl);
 	pci_push(base);
 }
 
@@ -755,7 +862,7 @@ static void nv_txrx_reset(struct net_dev
  */
 static struct net_device_stats *nv_get_stats(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 
 	/* It seems that the nic always generates interrupts and doesn't
 	 * accumulate errors internally. Thus the current values in np->stats
@@ -764,50 +871,6 @@ static struct net_device_stats *nv_get_s
 	return &np->stats;
 }
 
-static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	strcpy(info->driver, "forcedeth");
-	strcpy(info->version, FORCEDETH_VERSION);
-	strcpy(info->bus_info, pci_name(np->pci_dev));
-}
-
-static void nv_get_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	wolinfo->supported = WAKE_MAGIC;
-
-	spin_lock_irq(&np->lock);
-	if (np->wolenabled)
-		wolinfo->wolopts = WAKE_MAGIC;
-	spin_unlock_irq(&np->lock);
-}
-
-static int nv_set_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
-
-	spin_lock_irq(&np->lock);
-	if (wolinfo->wolopts == 0) {
-		writel(0, base + NvRegWakeUpFlags);
-		np->wolenabled = 0;
-	}
-	if (wolinfo->wolopts & WAKE_MAGIC) {
-		writel(NVREG_WAKEUPFLAGS_ENABLE, base + NvRegWakeUpFlags);
-		np->wolenabled = 1;
-	}
-	spin_unlock_irq(&np->lock);
-	return 0;
-}
-
-static struct ethtool_ops ops = {
-	.get_drvinfo = nv_get_drvinfo,
-	.get_link = ethtool_op_get_link,
-	.get_wol = nv_get_wol,
-	.set_wol = nv_set_wol,
-};
-
 /*
  * nv_alloc_rx: fill rx ring entries.
  * Return 1 if the allocations for the skbs failed and the
@@ -815,7 +878,7 @@ static struct ethtool_ops ops = {
  */
 static int nv_alloc_rx(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 	unsigned int refill_rx = np->refill_rx;
 	int nr;
 
@@ -825,7 +888,7 @@ static int nv_alloc_rx(struct net_device
 		nr = refill_rx % RX_RING;
 		if (np->rx_skbuff[nr] == NULL) {
 
-			skb = dev_alloc_skb(RX_ALLOC_BUFSIZE);
+			skb = dev_alloc_skb(np->rx_buf_sz + NV_RX_ALLOC_PAD);
 			if (!skb)
 				break;
 
@@ -834,11 +897,18 @@ static int nv_alloc_rx(struct net_device
 		} else {
 			skb = np->rx_skbuff[nr];
 		}
-		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
-						PCI_DMA_FROMDEVICE);
-		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
-		wmb();
-		np->rx_ring[nr].FlagLen = cpu_to_le32(RX_NIC_BUFSIZE | NV_RX_AVAIL);
+		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data,
+					skb->end-skb->data, PCI_DMA_FROMDEVICE);
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+			np->rx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
+			wmb();
+			np->rx_ring.orig[nr].FlagLen = cpu_to_le32(np->rx_buf_sz | NV_RX_AVAIL);
+		} else {
+			np->rx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->rx_dma[nr]) >> 32;
+			np->rx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->rx_dma[nr]) & 0x0FFFFFFFF;
+			wmb();
+			np->rx_ring.ex[nr].FlagLen = cpu_to_le32(np->rx_buf_sz | NV_RX2_AVAIL);
+		}
 		dprintk(KERN_DEBUG "%s: nv_alloc_rx: Packet %d marked as Available\n",
 					dev->name, refill_rx);
 		refill_rx++;
@@ -852,7 +922,7 @@ static int nv_alloc_rx(struct net_device
 static void nv_do_rx_refill(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *) data;
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 
 	disable_irq(dev->irq);
 	if (nv_alloc_rx(dev)) {
@@ -864,49 +934,94 @@ static void nv_do_rx_refill(unsigned lon
 	enable_irq(dev->irq);
 }
 
-static int nv_init_ring(struct net_device *dev)
+static void nv_init_rx(struct net_device *dev) 
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 	int i;
 
-	np->next_tx = np->nic_tx = 0;
-	for (i = 0; i < TX_RING; i++)
-		np->tx_ring[i].FlagLen = 0;
-
 	np->cur_rx = RX_RING;
 	np->refill_rx = 0;
 	for (i = 0; i < RX_RING; i++)
-		np->rx_ring[i].FlagLen = 0;
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			np->rx_ring.orig[i].FlagLen = 0;
+	        else
+			np->rx_ring.ex[i].FlagLen = 0;
+}
+
+static void nv_init_tx(struct net_device *dev)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	int i;
+
+	np->next_tx = np->nic_tx = 0;
+	for (i = 0; i < TX_RING; i++) {
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			np->tx_ring.orig[i].FlagLen = 0;
+	        else
+			np->tx_ring.ex[i].FlagLen = 0;
+		np->tx_skbuff[i] = NULL;
+		np->tx_dma[i] = 0;
+	}
+}
+
+static int nv_init_ring(struct net_device *dev)
+{
+	nv_init_tx(dev);
+	nv_init_rx(dev);
 	return nv_alloc_rx(dev);
 }
 
+static int nv_release_txskb(struct net_device *dev, unsigned int skbnr)
+{
+	struct fe_priv *np = netdev_priv(dev);
+
+	dprintk(KERN_INFO "%s: nv_release_txskb for skbnr %d\n",
+		dev->name, skbnr);
+
+	if (np->tx_dma[skbnr]) {
+		pci_unmap_page(np->pci_dev, np->tx_dma[skbnr],
+			       np->tx_dma_len[skbnr],
+			       PCI_DMA_TODEVICE);
+		np->tx_dma[skbnr] = 0;
+	}
+
+	if (np->tx_skbuff[skbnr]) {
+		dev_kfree_skb_irq(np->tx_skbuff[skbnr]);
+		np->tx_skbuff[skbnr] = NULL;
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 static void nv_drain_tx(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	int i;
+	struct fe_priv *np = netdev_priv(dev);
+	unsigned int i;
+	
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].FlagLen = 0;
-		if (np->tx_skbuff[i]) {
-			pci_unmap_single(np->pci_dev, np->tx_dma[i],
-						np->tx_skbuff[i]->len,
-						PCI_DMA_TODEVICE);
-			dev_kfree_skb(np->tx_skbuff[i]);
-			np->tx_skbuff[i] = NULL;
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			np->tx_ring.orig[i].FlagLen = 0;
+		else
+			np->tx_ring.ex[i].FlagLen = 0;
+		if (nv_release_txskb(dev, i))
 			np->stats.tx_dropped++;
-		}
 	}
 }
 
 static void nv_drain_rx(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 	int i;
 	for (i = 0; i < RX_RING; i++) {
-		np->rx_ring[i].FlagLen = 0;
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			np->rx_ring.orig[i].FlagLen = 0;
+		else
+			np->rx_ring.ex[i].FlagLen = 0;
 		wmb();
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->rx_dma[i],
-						np->rx_skbuff[i]->len,
+						np->rx_skbuff[i]->end-np->rx_skbuff[i]->data,
 						PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(np->rx_skbuff[i]);
 			np->rx_skbuff[i] = NULL;
@@ -926,20 +1041,113 @@ static void drain_ring(struct net_device
  */
 static int nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	int nr = np->next_tx % TX_RING;
+	struct fe_priv *np = netdev_priv(dev);
+	u32 tx_flags = 0;
+	u32 tx_flags_extra = (np->desc_ver == DESC_VER_1 ? NV_TX_LASTPACKET : NV_TX2_LASTPACKET);
+	unsigned int fragments = skb_shinfo(skb)->nr_frags;
+	unsigned int nr = (np->next_tx - 1) % TX_RING;
+	unsigned int start_nr = np->next_tx % TX_RING;
+	unsigned int i;
+	u32 offset = 0;
+	u32 bcnt;
+	u32 size = skb->len-skb->data_len;
+	u32 entries = (size >> NV_TX2_TSO_MAX_SHIFT) + ((size & (NV_TX2_TSO_MAX_SIZE-1)) ? 1 : 0);
+	u32 tx_flags_vlan = 0;
+
+	/* add fragments to entries count */
+	for (i = 0; i < fragments; i++) {
+		entries += (skb_shinfo(skb)->frags[i].size >> NV_TX2_TSO_MAX_SHIFT) +
+			   ((skb_shinfo(skb)->frags[i].size & (NV_TX2_TSO_MAX_SIZE-1)) ? 1 : 0);
+	}
+
+	spin_lock_irq(&np->lock);
+
+	if ((np->next_tx - np->nic_tx + entries - 1) > TX_LIMIT_STOP) {
+		spin_unlock_irq(&np->lock);
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* setup the header buffer */
+	do {
+		bcnt = (size > NV_TX2_TSO_MAX_SIZE) ? NV_TX2_TSO_MAX_SIZE : size;
+		nr = (nr + 1) % TX_RING;
+
+		np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data + offset, bcnt,
+						PCI_DMA_TODEVICE);
+		np->tx_dma_len[nr] = bcnt;
+
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+			np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+			np->tx_ring.orig[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+		} else {
+			np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
+			np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
+			np->tx_ring.ex[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+		}
+		tx_flags = np->tx_flags;
+		offset += bcnt;
+		size -= bcnt;
+	} while(size);
+
+	/* setup the fragments */
+	for (i = 0; i < fragments; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		u32 size = frag->size;
+		offset = 0;
+
+		do {
+			bcnt = (size > NV_TX2_TSO_MAX_SIZE) ? NV_TX2_TSO_MAX_SIZE : size;
+			nr = (nr + 1) % TX_RING;
+
+			np->tx_dma[nr] = pci_map_page(np->pci_dev, frag->page, frag->page_offset+offset, bcnt,
+						      PCI_DMA_TODEVICE);
+			np->tx_dma_len[nr] = bcnt;
+
+			if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+				np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+				np->tx_ring.orig[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+			} else {
+				np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
+				np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
+				np->tx_ring.ex[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+			}
+			offset += bcnt;
+			size -= bcnt;
+		} while (size);
+	}
+
+	/* set last fragment flag  */
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+		np->tx_ring.orig[nr].FlagLen |= cpu_to_le32(tx_flags_extra);
+	} else {
+		np->tx_ring.ex[nr].FlagLen |= cpu_to_le32(tx_flags_extra);
+	}
 
 	np->tx_skbuff[nr] = skb;
-	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data,skb->len,
-					PCI_DMA_TODEVICE);
 
-	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+#ifdef NETIF_F_TSO
+	if (skb_shinfo(skb)->tso_size)
+		tx_flags_extra = NV_TX2_TSO | (skb_shinfo(skb)->tso_size << NV_TX2_TSO_SHIFT);
+	else
+#endif
+	tx_flags_extra = (skb->ip_summed == CHECKSUM_HW ? (NV_TX2_CHECKSUM_L3|NV_TX2_CHECKSUM_L4) : 0);
 
-	spin_lock_irq(&np->lock);
-	wmb();
-	np->tx_ring[nr].FlagLen = cpu_to_le32( (skb->len-1) | np->tx_flags );
-	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
-				dev->name, np->next_tx);
+	/* vlan tag */
+	if (np->vlangrp && vlan_tx_tag_present(skb)) {
+		tx_flags_vlan = NV_TX3_VLAN_TAG_PRESENT | vlan_tx_tag_get(skb);
+	}
+
+	/* set tx flags */
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+		np->tx_ring.orig[start_nr].FlagLen |= cpu_to_le32(tx_flags | tx_flags_extra);
+	} else {
+		np->tx_ring.ex[start_nr].TxVlan = cpu_to_le32(tx_flags_vlan);
+		np->tx_ring.ex[start_nr].FlagLen |= cpu_to_le32(tx_flags | tx_flags_extra);
+	}	
+
+	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet %d (entries %d) queued for transmission. tx_flags_extra: %x\n",
+		dev->name, np->next_tx, entries, tx_flags_extra);
 	{
 		int j;
 		for (j=0; j<64; j++) {
@@ -950,15 +1158,13 @@ static int nv_start_xmit(struct sk_buff 
 		dprintk("\n");
 	}
 
-	np->next_tx++;
+	np->next_tx += entries;
 
 	dev->trans_start = jiffies;
-	if (np->next_tx - np->nic_tx >= TX_LIMIT_STOP)
-		netif_stop_queue(dev);
 	spin_unlock_irq(&np->lock);
-	writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_KICK|np->txrxctl_bits, get_hwbase(dev) + NvRegTxRxControl);
 	pci_push(get_hwbase(dev));
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 /*
@@ -968,49 +1174,55 @@ static int nv_start_xmit(struct sk_buff 
  */
 static void nv_tx_done(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 	u32 Flags;
-	int i;
+	unsigned int i;
+	struct sk_buff *skb;
 
 	while (np->nic_tx != np->next_tx) {
 		i = np->nic_tx % TX_RING;
 
-		Flags = le32_to_cpu(np->tx_ring[i].FlagLen);
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			Flags = le32_to_cpu(np->tx_ring.orig[i].FlagLen);
+		else
+			Flags = le32_to_cpu(np->tx_ring.ex[i].FlagLen);
 
 		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
 					dev->name, np->nic_tx, Flags);
 		if (Flags & NV_TX_VALID)
 			break;
 		if (np->desc_ver == DESC_VER_1) {
-			if (Flags & (NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
-							NV_TX_UNDERFLOW|NV_TX_ERROR)) {
-				if (Flags & NV_TX_UNDERFLOW)
-					np->stats.tx_fifo_errors++;
-				if (Flags & NV_TX_CARRIERLOST)
-					np->stats.tx_carrier_errors++;
-				np->stats.tx_errors++;
-			} else {
-				np->stats.tx_packets++;
-				np->stats.tx_bytes += np->tx_skbuff[i]->len;
+			if (Flags & NV_TX_LASTPACKET) {
+				skb = np->tx_skbuff[i];
+				if (Flags & (NV_TX_RETRYERROR|NV_TX_CARRIERLOST|NV_TX_LATECOLLISION|
+					     NV_TX_UNDERFLOW|NV_TX_ERROR)) {
+					if (Flags & NV_TX_UNDERFLOW)
+						np->stats.tx_fifo_errors++;
+					if (Flags & NV_TX_CARRIERLOST)
+						np->stats.tx_carrier_errors++;
+					np->stats.tx_errors++;
+				} else {
+					np->stats.tx_packets++;
+					np->stats.tx_bytes += skb->len;
+				}
 			}
 		} else {
-			if (Flags & (NV_TX2_RETRYERROR|NV_TX2_CARRIERLOST|NV_TX2_LATECOLLISION|
-							NV_TX2_UNDERFLOW|NV_TX2_ERROR)) {
-				if (Flags & NV_TX2_UNDERFLOW)
-					np->stats.tx_fifo_errors++;
-				if (Flags & NV_TX2_CARRIERLOST)
-					np->stats.tx_carrier_errors++;
-				np->stats.tx_errors++;
-			} else {
-				np->stats.tx_packets++;
-				np->stats.tx_bytes += np->tx_skbuff[i]->len;
+			if (Flags & NV_TX2_LASTPACKET) {
+				skb = np->tx_skbuff[i];
+				if (Flags & (NV_TX2_RETRYERROR|NV_TX2_CARRIERLOST|NV_TX2_LATECOLLISION|
+					     NV_TX2_UNDERFLOW|NV_TX2_ERROR)) {
+					if (Flags & NV_TX2_UNDERFLOW)
+						np->stats.tx_fifo_errors++;
+					if (Flags & NV_TX2_CARRIERLOST)
+						np->stats.tx_carrier_errors++;
+					np->stats.tx_errors++;
+				} else {
+					np->stats.tx_packets++;
+					np->stats.tx_bytes += skb->len;
+				}				
 			}
 		}
-		pci_unmap_single(np->pci_dev, np->tx_dma[i],
-					np->tx_skbuff[i]->len,
-					PCI_DMA_TODEVICE);
-		dev_kfree_skb_irq(np->tx_skbuff[i]);
-		np->tx_skbuff[i] = NULL;
+		nv_release_txskb(dev, i);
 		np->nic_tx++;
 	}
 	if (np->next_tx - np->nic_tx < TX_LIMIT_START)
@@ -1023,12 +1235,59 @@ static void nv_tx_done(struct net_device
  */
 static void nv_tx_timeout(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
-	dprintk(KERN_DEBUG "%s: Got tx_timeout. irq: %08x\n", dev->name,
+	printk(KERN_INFO "%s: Got tx_timeout. irq: %08x\n", dev->name,
 			readl(base + NvRegIrqStatus) & NVREG_IRQSTAT_MASK);
 
+	{
+		int i;
+
+		printk(KERN_INFO "%s: Ring at %lx: next %d nic %d\n",
+				dev->name, (unsigned long)np->ring_addr,
+				np->next_tx, np->nic_tx);
+		printk(KERN_INFO "%s: Dumping tx registers\n", dev->name);
+		for (i=0;i<0x400;i+= 32) {
+			printk(KERN_INFO "%3x: %08x %08x %08x %08x %08x %08x %08x %08x\n",
+					i,
+					readl(base + i + 0), readl(base + i + 4),
+					readl(base + i + 8), readl(base + i + 12),
+					readl(base + i + 16), readl(base + i + 20),
+					readl(base + i + 24), readl(base + i + 28));
+		}
+		printk(KERN_INFO "%s: Dumping tx ring\n", dev->name);
+		for (i=0;i<TX_RING;i+= 4) {
+			if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+				printk(KERN_INFO "%03x: %08x %08x // %08x %08x // %08x %08x // %08x %08x\n",
+				       i, 
+				       le32_to_cpu(np->tx_ring.orig[i].PacketBuffer),
+				       le32_to_cpu(np->tx_ring.orig[i].FlagLen),
+				       le32_to_cpu(np->tx_ring.orig[i+1].PacketBuffer),
+				       le32_to_cpu(np->tx_ring.orig[i+1].FlagLen),
+				       le32_to_cpu(np->tx_ring.orig[i+2].PacketBuffer),
+				       le32_to_cpu(np->tx_ring.orig[i+2].FlagLen),
+				       le32_to_cpu(np->tx_ring.orig[i+3].PacketBuffer),
+				       le32_to_cpu(np->tx_ring.orig[i+3].FlagLen));
+			} else {
+				printk(KERN_INFO "%03x: %08x %08x %08x // %08x %08x %08x // %08x %08x %08x // %08x %08x %08x\n",
+				       i, 
+				       le32_to_cpu(np->tx_ring.ex[i].PacketBufferHigh),
+				       le32_to_cpu(np->tx_ring.ex[i].PacketBufferLow),
+				       le32_to_cpu(np->tx_ring.ex[i].FlagLen),
+				       le32_to_cpu(np->tx_ring.ex[i+1].PacketBufferHigh),
+				       le32_to_cpu(np->tx_ring.ex[i+1].PacketBufferLow),
+				       le32_to_cpu(np->tx_ring.ex[i+1].FlagLen),
+				       le32_to_cpu(np->tx_ring.ex[i+2].PacketBufferHigh),
+				       le32_to_cpu(np->tx_ring.ex[i+2].PacketBufferLow),
+				       le32_to_cpu(np->tx_ring.ex[i+2].FlagLen),
+				       le32_to_cpu(np->tx_ring.ex[i+3].PacketBufferHigh),
+				       le32_to_cpu(np->tx_ring.ex[i+3].PacketBufferLow),
+				       le32_to_cpu(np->tx_ring.ex[i+3].FlagLen));
+			}
+		}
+	}
+
 	spin_lock_irq(&np->lock);
 
 	/* 1) stop tx engine */
@@ -1042,7 +1301,10 @@ static void nv_tx_timeout(struct net_dev
 		printk(KERN_DEBUG "%s: tx_timeout: dead entries!\n", dev->name);
 		nv_drain_tx(dev);
 		np->next_tx = np->nic_tx = 0;
-		writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+		else
+			writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc_ex)), base + NvRegTxRingPhysAddr);
 		netif_wake_queue(dev);
 	}
 
@@ -1051,10 +1313,65 @@ static void nv_tx_timeout(struct net_dev
 	spin_unlock_irq(&np->lock);
 }
 
+/*
+ * Called when the nic notices a mismatch between the actual data len on the
+ * wire and the len indicated in the 802 header
+ */
+static int nv_getlen(struct net_device *dev, void *packet, int datalen)
+{
+	int hdrlen;	/* length of the 802 header */
+	int protolen;	/* length as stored in the proto field */
+
+	/* 1) calculate len according to header */
+	if ( ((struct vlan_ethhdr *)packet)->h_vlan_proto == __constant_htons(ETH_P_8021Q)) {
+		protolen = ntohs( ((struct vlan_ethhdr *)packet)->h_vlan_encapsulated_proto );
+		hdrlen = VLAN_HLEN;
+	} else {
+		protolen = ntohs( ((struct ethhdr *)packet)->h_proto);
+		hdrlen = ETH_HLEN;
+	}
+	dprintk(KERN_DEBUG "%s: nv_getlen: datalen %d, protolen %d, hdrlen %d\n",
+				dev->name, datalen, protolen, hdrlen);
+	if (protolen > ETH_DATA_LEN)
+		return datalen; /* Value in proto field not a len, no checks possible */
+
+	protolen += hdrlen;
+	/* consistency checks: */
+	if (datalen > ETH_ZLEN) {
+		if (datalen >= protolen) {
+			/* more data on wire than in 802 header, trim of
+			 * additional data.
+			 */
+			dprintk(KERN_DEBUG "%s: nv_getlen: accepting %d bytes.\n",
+					dev->name, protolen);
+			return protolen;
+		} else {
+			/* less data on wire than mentioned in header.
+			 * Discard the packet.
+			 */
+			dprintk(KERN_DEBUG "%s: nv_getlen: discarding long packet.\n",
+					dev->name);
+			return -1;
+		}
+	} else {
+		/* short packet. Accept only if 802 values are also short */
+		if (protolen > ETH_ZLEN) {
+			dprintk(KERN_DEBUG "%s: nv_getlen: discarding short packet.\n",
+					dev->name);
+			return -1;
+		}
+		dprintk(KERN_DEBUG "%s: nv_getlen: accepting %d bytes.\n",
+				dev->name, datalen);
+		return datalen;
+	}
+}
+
 static void nv_rx_process(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
+	struct fe_priv *np = netdev_priv(dev);
 	u32 Flags;
+	u32 vlanflags = 0;
+
 
 	for (;;) {
 		struct sk_buff *skb;
@@ -1064,8 +1381,14 @@ static void nv_rx_process(struct net_dev
 			break;	/* we scanned the whole ring - do not continue */
 
 		i = np->cur_rx % RX_RING;
-		Flags = le32_to_cpu(np->rx_ring[i].FlagLen);
-		len = nv_descr_getlength(&np->rx_ring[i], np->desc_ver);
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+			Flags = le32_to_cpu(np->rx_ring.orig[i].FlagLen);
+			len = nv_descr_getlength(&np->rx_ring.orig[i], np->desc_ver);
+		} else {
+			Flags = le32_to_cpu(np->rx_ring.ex[i].FlagLen);
+			len = nv_descr_getlength_ex(&np->rx_ring.ex[i], np->desc_ver);
+			vlanflags = le32_to_cpu(np->rx_ring.ex[i].PacketBufferLow);
+		}
 
 		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
 					dev->name, np->cur_rx, Flags);
@@ -1079,7 +1402,7 @@ static void nv_rx_process(struct net_dev
 		 * the performance.
 		 */
 		pci_unmap_single(np->pci_dev, np->rx_dma[i],
-				np->rx_skbuff[i]->len,
+				np->rx_skbuff[i]->end-np->rx_skbuff[i]->data,
 				PCI_DMA_FROMDEVICE);
 
 		{
@@ -1097,63 +1420,71 @@ static void nv_rx_process(struct net_dev
 			if (!(Flags & NV_RX_DESCRIPTORVALID))
 				goto next_pkt;
 
-			if (Flags & NV_RX_MISSEDFRAME) {
-				np->stats.rx_missed_errors++;
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
-			if (Flags & (NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
-			if (Flags & NV_RX_CRCERR) {
-				np->stats.rx_crc_errors++;
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
-			if (Flags & NV_RX_OVERFLOW) {
-				np->stats.rx_over_errors++;
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
 			if (Flags & NV_RX_ERROR) {
-				/* framing errors are soft errors, the rest is fatal. */
+				if (Flags & NV_RX_MISSEDFRAME) {
+					np->stats.rx_missed_errors++;
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & (NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3)) {
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & NV_RX_CRCERR) {
+					np->stats.rx_crc_errors++;
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & NV_RX_OVERFLOW) {
+					np->stats.rx_over_errors++;
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & NV_RX_ERROR4) {
+					len = nv_getlen(dev, np->rx_skbuff[i]->data, len);
+					if (len < 0) {
+						np->stats.rx_errors++;
+						goto next_pkt;
+					}
+				}
+				/* framing errors are soft errors. */
 				if (Flags & NV_RX_FRAMINGERR) {
 					if (Flags & NV_RX_SUBSTRACT1) {
 						len--;
 					}
-				} else {
-					np->stats.rx_errors++;
-					goto next_pkt;
 				}
 			}
 		} else {
 			if (!(Flags & NV_RX2_DESCRIPTORVALID))
 				goto next_pkt;
 
-			if (Flags & (NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3|NV_RX2_ERROR4)) {
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
-			if (Flags & NV_RX2_CRCERR) {
-				np->stats.rx_crc_errors++;
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
-			if (Flags & NV_RX2_OVERFLOW) {
-				np->stats.rx_over_errors++;
-				np->stats.rx_errors++;
-				goto next_pkt;
-			}
 			if (Flags & NV_RX2_ERROR) {
-				/* framing errors are soft errors, the rest is fatal. */
+				if (Flags & (NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3)) {
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & NV_RX2_CRCERR) {
+					np->stats.rx_crc_errors++;
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & NV_RX2_OVERFLOW) {
+					np->stats.rx_over_errors++;
+					np->stats.rx_errors++;
+					goto next_pkt;
+				}
+				if (Flags & NV_RX2_ERROR4) {
+					len = nv_getlen(dev, np->rx_skbuff[i]->data, len);
+					if (len < 0) {
+						np->stats.rx_errors++;
+						goto next_pkt;
+					}
+				}
+				/* framing errors are soft errors */
 				if (Flags & NV_RX2_FRAMINGERR) {
 					if (Flags & NV_RX2_SUBSTRACT1) {
 						len--;
 					}
-				} else {
-					np->stats.rx_errors++;
-					goto next_pkt;
 				}
 			}
 			Flags &= NV_RX2_CHECKSUMMASK;
@@ -1174,7 +1505,11 @@ static void nv_rx_process(struct net_dev
 		skb->protocol = eth_type_trans(skb, dev);
 		dprintk(KERN_DEBUG "%s: nv_rx_process: packet %d with %d bytes, proto %d accepted.\n",
 					dev->name, np->cur_rx, len, skb->protocol);
-		netif_rx(skb);
+		if (np->vlangrp && (vlanflags & NV_RX3_VLAN_TAG_PRESENT)) {
+			vlan_hwaccel_rx(skb, np->vlangrp, vlanflags & NV_RX3_VLAN_TAG_MASK);
+		} else {
+			netif_rx(skb);
+		}
 		dev->last_rx = jiffies;
 		np->stats.rx_packets++;
 		np->stats.rx_bytes += len;
@@ -1183,15 +1518,133 @@ next_pkt:
 	}
 }
 
+static void set_bufsize(struct net_device *dev)
+{
+	struct fe_priv *np = netdev_priv(dev);
+
+	if (dev->mtu <= ETH_DATA_LEN)
+		np->rx_buf_sz = ETH_DATA_LEN + NV_RX_HEADERS;
+	else
+		np->rx_buf_sz = dev->mtu + NV_RX_HEADERS;
+}
+
 /*
  * nv_change_mtu: dev->change_mtu function
  * Called with dev_base_lock held for read.
  */
 static int nv_change_mtu(struct net_device *dev, int new_mtu)
 {
-	if (new_mtu > ETH_DATA_LEN)
+	struct fe_priv *np = netdev_priv(dev);
+	int old_mtu;
+
+	if (new_mtu < 64 || new_mtu > np->pkt_limit)
 		return -EINVAL;
+
+	old_mtu = dev->mtu;
 	dev->mtu = new_mtu;
+
+	/* return early if the buffer sizes will not change */
+	if (old_mtu <= ETH_DATA_LEN && new_mtu <= ETH_DATA_LEN)
+		return 0;
+	if (old_mtu == new_mtu)
+		return 0;
+
+	/* synchronized against open : rtnl_lock() held by caller */
+	if (netif_running(dev)) {
+		u8 __iomem *base = get_hwbase(dev);
+		/*
+		 * It seems that the nic preloads valid ring entries into an
+		 * internal buffer. The procedure for flushing everything is
+		 * guessed, there is probably a simpler approach.
+		 * Changing the MTU is a rare event, it shouldn't matter.
+		 */
+		disable_irq(dev->irq);
+		spin_lock_bh(&dev->xmit_lock);
+		spin_lock(&np->lock);
+		/* stop engines */
+		nv_stop_rx(dev);
+		nv_stop_tx(dev);
+		nv_txrx_reset(dev);
+		/* drain rx queue */
+		nv_drain_rx(dev);
+		nv_drain_tx(dev);
+		/* reinit driver view of the rx queue */
+		nv_init_rx(dev);
+		nv_init_tx(dev);
+		/* alloc new rx buffers */
+		set_bufsize(dev);
+		if (nv_alloc_rx(dev)) {
+			if (!np->in_shutdown)
+				mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
+		}
+		/* reinit nic view of the rx queue */
+		writel(np->rx_buf_sz, base + NvRegOffloadConfig);
+		writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+		else
+			writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc_ex)), base + NvRegTxRingPhysAddr);
+		writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
+			base + NvRegRingSizes);
+		pci_push(base);
+		writel(NVREG_TXRXCTL_KICK|np->txrxctl_bits, get_hwbase(dev) + NvRegTxRxControl);
+		pci_push(base);
+
+		/* restart rx engine */
+		nv_start_rx(dev);
+		nv_start_tx(dev);
+		spin_unlock(&np->lock);
+		spin_unlock_bh(&dev->xmit_lock);
+		enable_irq(dev->irq);
+	}
+	return 0;
+}
+
+static void nv_copy_mac_to_hw(struct net_device *dev)
+{
+	u8 __iomem *base = get_hwbase(dev);
+	u32 mac[2];
+
+	mac[0] = (dev->dev_addr[0] << 0) + (dev->dev_addr[1] << 8) +
+			(dev->dev_addr[2] << 16) + (dev->dev_addr[3] << 24);
+	mac[1] = (dev->dev_addr[4] << 0) + (dev->dev_addr[5] << 8);
+
+	writel(mac[0], base + NvRegMacAddrA);
+	writel(mac[1], base + NvRegMacAddrB);
+}
+
+/*
+ * nv_set_mac_address: dev->set_mac_address function
+ * Called with rtnl_lock() held.
+ */
+static int nv_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	struct sockaddr *macaddr = (struct sockaddr*)addr;
+
+	if(!is_valid_ether_addr(macaddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	/* synchronized against open : rtnl_lock() held by caller */
+	memcpy(dev->dev_addr, macaddr->sa_data, ETH_ALEN);
+
+	if (netif_running(dev)) {
+		spin_lock_bh(&dev->xmit_lock);
+		spin_lock_irq(&np->lock);
+
+		/* stop rx engine */
+		nv_stop_rx(dev);
+
+		/* set mac address */
+		nv_copy_mac_to_hw(dev);
+
+		/* restart rx engine */
+		nv_start_rx(dev);
+		spin_unlock_irq(&np->lock);
+		spin_unlock_bh(&dev->xmit_lock);
+	} else {
+		nv_copy_mac_to_hw(dev);
+	}
 	return 0;
 }
 
@@ -1201,8 +1654,8 @@ static int nv_change_mtu(struct net_devi
  */
 static void nv_set_multicast(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 addr[2];
 	u32 mask[2];
 	u32 pff;
@@ -1259,10 +1712,21 @@ static void nv_set_multicast(struct net_
 	spin_unlock_irq(&np->lock);
 }
 
+/**
+ * nv_update_linkspeed: Setup the MAC according to the link partner
+ * @dev: Network device to be configured
+ *
+ * The function queries the PHY and checks if there is a link partner.
+ * If yes, then it sets up the MAC accordingly. Otherwise, the MAC is
+ * set to 10 MBit HD.
+ *
+ * The function returns 0 if there is no link partner and 1 if there is
+ * a good link partner.
+ */
 static int nv_update_linkspeed(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	int adv, lpa;
 	int newls = np->linkspeed;
 	int newdup = np->duplex;
@@ -1285,6 +1749,25 @@ static int nv_update_linkspeed(struct ne
 		goto set_speed;
 	}
 
+	if (np->autoneg == 0) {
+		dprintk(KERN_DEBUG "%s: nv_update_linkspeed: autoneg off, PHY set to 0x%04x.\n",
+				dev->name, np->fixed_mode);
+		if (np->fixed_mode & LPA_100FULL) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
+			newdup = 1;
+		} else if (np->fixed_mode & LPA_100HALF) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_100;
+			newdup = 0;
+		} else if (np->fixed_mode & LPA_10FULL) {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+			newdup = 1;
+		} else {
+			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+			newdup = 0;
+		}
+		retval = 1;
+		goto set_speed;
+	}
 	/* check auto negotiation is complete */
 	if (!(mii_status & BMSR_ANEGCOMPLETE)) {
 		/* still in autonegotiation - configure nic for 10 MBit HD and wait. */
@@ -1302,7 +1785,7 @@ static int nv_update_linkspeed(struct ne
 
 		if ((control_1000 & ADVERTISE_1000FULL) &&
 			(status_1000 & LPA_1000FULL)) {
-		dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
+			dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
 				dev->name);
 			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_1000;
 			newdup = 1;
@@ -1361,9 +1844,9 @@ set_speed:
 	phyreg &= ~(PHY_HALF|PHY_100|PHY_1000);
 	if (np->duplex == 0)
 		phyreg |= PHY_HALF;
-	if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_100)
+	if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_100)
 		phyreg |= PHY_100;
-	else if ((np->linkspeed & 0xFFF) == NVREG_LINKSPEED_1000)
+	else if ((np->linkspeed & NVREG_LINKSPEED_MASK) == NVREG_LINKSPEED_1000)
 		phyreg |= PHY_1000;
 	writel(phyreg, base + NvRegPhyInterface);
 
@@ -1379,13 +1862,11 @@ set_speed:
 static void nv_linkchange(struct net_device *dev)
 {
 	if (nv_update_linkspeed(dev)) {
-		if (netif_carrier_ok(dev)) {
-			nv_stop_rx(dev);
-		} else {
+		if (!netif_carrier_ok(dev)) {
 			netif_carrier_on(dev);
 			printk(KERN_INFO "%s: link up.\n", dev->name);
+			nv_start_rx(dev);
 		}
-		nv_start_rx(dev);
 	} else {
 		if (netif_carrier_ok(dev)) {
 			netif_carrier_off(dev);
@@ -1397,7 +1878,7 @@ static void nv_linkchange(struct net_dev
 
 static void nv_link_irq(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 miistat;
 
 	miistat = readl(base + NvRegMIIStatus);
@@ -1412,8 +1893,8 @@ static void nv_link_irq(struct net_devic
 static irqreturn_t nv_nic_irq(int foo, void *data, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) data;
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 events;
 	int i;
 
@@ -1427,22 +1908,18 @@ static irqreturn_t nv_nic_irq(int foo, v
 		if (!(events & np->irqmask))
 			break;
 
-		if (events & (NVREG_IRQ_TX1|NVREG_IRQ_TX2|NVREG_IRQ_TX_ERR)) {
+		spin_lock(&np->lock);
+		nv_tx_done(dev);
+		spin_unlock(&np->lock);
+		
+		nv_rx_process(dev);
+		if (nv_alloc_rx(dev)) {
 			spin_lock(&np->lock);
-			nv_tx_done(dev);
+			if (!np->in_shutdown)
+				mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
 			spin_unlock(&np->lock);
 		}
-
-		if (events & (NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF)) {
-			nv_rx_process(dev);
-			if (nv_alloc_rx(dev)) {
-				spin_lock(&np->lock);
-				if (!np->in_shutdown)
-					mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-				spin_unlock(&np->lock);
-			}
-		}
-
+		
 		if (events & NVREG_IRQ_LINK) {
 			spin_lock(&np->lock);
 			nv_link_irq(dev);
@@ -1484,8 +1961,8 @@ static irqreturn_t nv_nic_irq(int foo, v
 static void nv_do_nic_poll(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *) data;
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	disable_irq(dev->irq);
 	/* FIXME: Do we need synchronize_irq(dev->irq) here? */
@@ -1499,10 +1976,313 @@ static void nv_do_nic_poll(unsigned long
 	enable_irq(dev->irq);
 }
 
-static int nv_open(struct net_device *dev)
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void nv_poll_controller(struct net_device *dev)
+{
+	nv_do_nic_poll((unsigned long) dev);
+}
+#endif
+
+static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	strcpy(info->driver, "forcedeth");
+	strcpy(info->version, FORCEDETH_VERSION);
+	strcpy(info->bus_info, pci_name(np->pci_dev));
+}
+
+static void nv_get_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	wolinfo->supported = WAKE_MAGIC;
+
+	spin_lock_irq(&np->lock);
+	if (np->wolenabled)
+		wolinfo->wolopts = WAKE_MAGIC;
+	spin_unlock_irq(&np->lock);
+}
+
+static int nv_set_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
+
+	spin_lock_irq(&np->lock);
+	if (wolinfo->wolopts == 0) {
+		writel(0, base + NvRegWakeUpFlags);
+		np->wolenabled = 0;
+	}
+	if (wolinfo->wolopts & WAKE_MAGIC) {
+		writel(NVREG_WAKEUPFLAGS_ENABLE, base + NvRegWakeUpFlags);
+		np->wolenabled = 1;
+	}
+	spin_unlock_irq(&np->lock);
+	return 0;
+}
+
+static int nv_get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	int adv;
+
+	spin_lock_irq(&np->lock);
+	ecmd->port = PORT_MII;
+	if (!netif_running(dev)) {
+		/* We do not track link speed / duplex setting if the
+		 * interface is disabled. Force a link check */
+		nv_update_linkspeed(dev);
+	}
+	switch(np->linkspeed & (NVREG_LINKSPEED_MASK)) {
+		case NVREG_LINKSPEED_10:
+			ecmd->speed = SPEED_10;
+			break;
+		case NVREG_LINKSPEED_100:
+			ecmd->speed = SPEED_100;
+			break;
+		case NVREG_LINKSPEED_1000:
+			ecmd->speed = SPEED_1000;
+			break;
+	}
+	ecmd->duplex = DUPLEX_HALF;
+	if (np->duplex)
+		ecmd->duplex = DUPLEX_FULL;
+
+	ecmd->autoneg = np->autoneg;
+
+	ecmd->advertising = ADVERTISED_MII;
+	if (np->autoneg) {
+		ecmd->advertising |= ADVERTISED_Autoneg;
+		adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+	} else {
+		adv = np->fixed_mode;
+	}
+	if (adv & ADVERTISE_10HALF)
+		ecmd->advertising |= ADVERTISED_10baseT_Half;
+	if (adv & ADVERTISE_10FULL)
+		ecmd->advertising |= ADVERTISED_10baseT_Full;
+	if (adv & ADVERTISE_100HALF)
+		ecmd->advertising |= ADVERTISED_100baseT_Half;
+	if (adv & ADVERTISE_100FULL)
+		ecmd->advertising |= ADVERTISED_100baseT_Full;
+	if (np->autoneg && np->gigabit == PHY_GIGABIT) {
+		adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+		if (adv & ADVERTISE_1000FULL)
+			ecmd->advertising |= ADVERTISED_1000baseT_Full;
+	}
+
+	ecmd->supported = (SUPPORTED_Autoneg |
+		SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
+		SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
+		SUPPORTED_MII);
+	if (np->gigabit == PHY_GIGABIT)
+		ecmd->supported |= SUPPORTED_1000baseT_Full;
+
+	ecmd->phy_address = np->phyaddr;
+	ecmd->transceiver = XCVR_EXTERNAL;
+
+	/* ignore maxtxpkt, maxrxpkt for now */
+	spin_unlock_irq(&np->lock);
+	return 0;
+}
+
+static int nv_set_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	struct fe_priv *np = netdev_priv(dev);
+
+	if (ecmd->port != PORT_MII)
+		return -EINVAL;
+	if (ecmd->transceiver != XCVR_EXTERNAL)
+		return -EINVAL;
+	if (ecmd->phy_address != np->phyaddr) {
+		/* TODO: support switching between multiple phys. Should be
+		 * trivial, but not enabled due to lack of test hardware. */
+		return -EINVAL;
+	}
+	if (ecmd->autoneg == AUTONEG_ENABLE) {
+		u32 mask;
+
+		mask = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full |
+			  ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
+		if (np->gigabit == PHY_GIGABIT)
+			mask |= ADVERTISED_1000baseT_Full;
+
+		if ((ecmd->advertising & mask) == 0)
+			return -EINVAL;
+
+	} else if (ecmd->autoneg == AUTONEG_DISABLE) {
+		/* Note: autonegotiation disable, speed 1000 intentionally
+		 * forbidden - noone should need that. */
+
+		if (ecmd->speed != SPEED_10 && ecmd->speed != SPEED_100)
+			return -EINVAL;
+		if (ecmd->duplex != DUPLEX_HALF && ecmd->duplex != DUPLEX_FULL)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	spin_lock_irq(&np->lock);
+	if (ecmd->autoneg == AUTONEG_ENABLE) {
+		int adv, bmcr;
+
+		np->autoneg = 1;
+
+		/* advertise only what has been requested */
+		adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+		adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+		if (ecmd->advertising & ADVERTISED_10baseT_Half)
+			adv |= ADVERTISE_10HALF;
+		if (ecmd->advertising & ADVERTISED_10baseT_Full)
+			adv |= ADVERTISE_10FULL;
+		if (ecmd->advertising & ADVERTISED_100baseT_Half)
+			adv |= ADVERTISE_100HALF;
+		if (ecmd->advertising & ADVERTISED_100baseT_Full)
+			adv |= ADVERTISE_100FULL;
+		mii_rw(dev, np->phyaddr, MII_ADVERTISE, adv);
+
+		if (np->gigabit == PHY_GIGABIT) {
+			adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+			adv &= ~ADVERTISE_1000FULL;
+			if (ecmd->advertising & ADVERTISED_1000baseT_Full)
+				adv |= ADVERTISE_1000FULL;
+			mii_rw(dev, np->phyaddr, MII_1000BT_CR, adv);
+		}
+
+		bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+		mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+	} else {
+		int adv, bmcr;
+
+		np->autoneg = 0;
+
+		adv = mii_rw(dev, np->phyaddr, MII_ADVERTISE, MII_READ);
+		adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+		if (ecmd->speed == SPEED_10 && ecmd->duplex == DUPLEX_HALF)
+			adv |= ADVERTISE_10HALF;
+		if (ecmd->speed == SPEED_10 && ecmd->duplex == DUPLEX_FULL)
+			adv |= ADVERTISE_10FULL;
+		if (ecmd->speed == SPEED_100 && ecmd->duplex == DUPLEX_HALF)
+			adv |= ADVERTISE_100HALF;
+		if (ecmd->speed == SPEED_100 && ecmd->duplex == DUPLEX_FULL)
+			adv |= ADVERTISE_100FULL;
+		mii_rw(dev, np->phyaddr, MII_ADVERTISE, adv);
+		np->fixed_mode = adv;
+
+		if (np->gigabit == PHY_GIGABIT) {
+			adv = mii_rw(dev, np->phyaddr, MII_1000BT_CR, MII_READ);
+			adv &= ~ADVERTISE_1000FULL;
+			mii_rw(dev, np->phyaddr, MII_1000BT_CR, adv);
+		}
+
+		bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		bmcr |= ~(BMCR_ANENABLE|BMCR_SPEED100|BMCR_FULLDPLX);
+		if (adv & (ADVERTISE_10FULL|ADVERTISE_100FULL))
+			bmcr |= BMCR_FULLDPLX;
+		if (adv & (ADVERTISE_100HALF|ADVERTISE_100FULL))
+			bmcr |= BMCR_SPEED100;
+		mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+		if (netif_running(dev)) {
+			/* Wait a bit and then reconfigure the nic. */
+			udelay(10);
+			nv_linkchange(dev);
+		}
+	}
+	spin_unlock_irq(&np->lock);
+
+	return 0;
+}
+
+#define FORCEDETH_REGS_VER	1
+#define FORCEDETH_REGS_SIZE	0x400 /* 256 32-bit registers */
+
+static int nv_get_regs_len(struct net_device *dev)
+{
+	return FORCEDETH_REGS_SIZE;
+}
+
+static void nv_get_regs(struct net_device *dev, struct ethtool_regs *regs, void *buf)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
+	u32 *rbuf = buf;
+	int i;
+
+	regs->version = FORCEDETH_REGS_VER;
+	spin_lock_irq(&np->lock);
+	for (i=0;i<FORCEDETH_REGS_SIZE/sizeof(u32);i++)
+		rbuf[i] = readl(base + i*sizeof(u32));
+	spin_unlock_irq(&np->lock);
+}
+
+static int nv_nway_reset(struct net_device *dev)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	int ret;
+
+	spin_lock_irq(&np->lock);
+	if (np->autoneg) {
+		int bmcr;
+
+		bmcr = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
+		bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+		mii_rw(dev, np->phyaddr, MII_BMCR, bmcr);
+
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+	spin_unlock_irq(&np->lock);
+
+	return ret;
+}
+
+static struct ethtool_ops ops = {
+	.get_drvinfo = nv_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_wol = nv_get_wol,
+	.set_wol = nv_set_wol,
+	.get_settings = nv_get_settings,
+	.set_settings = nv_set_settings,
+	.get_regs_len = nv_get_regs_len,
+	.get_regs = nv_get_regs,
+	.nway_reset = nv_nway_reset,
+};
+
+static void nv_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+
+	spin_lock_irq(&np->lock);
+
+	/* save vlan group */
+	np->vlangrp = grp;
+
+	if (grp) {
+		/* enable vlan on MAC */
+		np->txrxctl_bits |= NVREG_TXRXCTL_VLANSTRIP | NVREG_TXRXCTL_VLANINS;
+	} else {
+		/* disable vlan on MAC */
+		np->txrxctl_bits &= ~NVREG_TXRXCTL_VLANSTRIP;
+		np->txrxctl_bits &= ~NVREG_TXRXCTL_VLANINS;
+	}
+
+	writel(np->txrxctl_bits, get_hwbase(dev) + NvRegTxRxControl);
+
+	spin_unlock_irq(&np->lock);
+};
+
+static void nv_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
+{
+	/* nothing to do */
+};
+
+static int nv_open(struct net_device *dev)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	int ret, oom, i;
 
 	dprintk(KERN_DEBUG "nv_open: begin\n");
@@ -1521,6 +2301,7 @@ static int nv_open(struct net_device *de
 	writel(0, base + NvRegAdapterControl);
 
 	/* 2) initialize descriptor rings */
+	set_bufsize(dev);
 	oom = nv_init_ring(dev);
 
 	writel(0, base + NvRegLinkSpeed);
@@ -1531,32 +2312,24 @@ static int nv_open(struct net_device *de
 	np->in_shutdown = 0;
 
 	/* 3) set mac address */
-	{
-		u32 mac[2];
-
-		mac[0] = (dev->dev_addr[0] << 0) + (dev->dev_addr[1] << 8) +
-				(dev->dev_addr[2] << 16) + (dev->dev_addr[3] << 24);
-		mac[1] = (dev->dev_addr[4] << 0) + (dev->dev_addr[5] << 8);
-
-		writel(mac[0], base + NvRegMacAddrA);
-		writel(mac[1], base + NvRegMacAddrB);
-	}
+	nv_copy_mac_to_hw(dev);
 
 	/* 4) give hw rings */
 	writel((u32) np->ring_addr, base + NvRegRxRingPhysAddr);
-	writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+		writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc)), base + NvRegTxRingPhysAddr);
+	else
+		writel((u32) (np->ring_addr + RX_RING*sizeof(struct ring_desc_ex)), base + NvRegTxRingPhysAddr);
 	writel( ((RX_RING-1) << NVREG_RINGSZ_RXSHIFT) + ((TX_RING-1) << NVREG_RINGSZ_TXSHIFT),
 		base + NvRegRingSizes);
 
 	/* 5) continue setup */
-	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
-	np->duplex = 0;
-
 	writel(np->linkspeed, base + NvRegLinkSpeed);
 	writel(NVREG_UNKSETUP3_VAL1, base + NvRegUnknownSetupReg3);
-	writel(np->desc_ver, base + NvRegTxRxControl);
+	writel(np->txrxctl_bits, base + NvRegTxRxControl);
+	writel(np->vlanctl_bits, base + NvRegVlanControl);
 	pci_push(base);
-	writel(NVREG_TXRXCTL_BIT1|np->desc_ver, base + NvRegTxRxControl);
+	writel(NVREG_TXRXCTL_BIT1|np->txrxctl_bits, base + NvRegTxRxControl);
 	reg_delay(dev, NvRegUnknownSetupReg5, NVREG_UNKSETUP5_BIT31, NVREG_UNKSETUP5_BIT31,
 			NV_SETUP5_DELAY, NV_SETUP5_DELAYMAX,
 			KERN_INFO "open: SetupReg5, Bit 31 remained off\n");
@@ -1569,14 +2342,21 @@ static int nv_open(struct net_device *de
 	writel(NVREG_MISC1_FORCE | NVREG_MISC1_HD, base + NvRegMisc1);
 	writel(readl(base + NvRegTransmitterStatus), base + NvRegTransmitterStatus);
 	writel(NVREG_PFF_ALWAYS, base + NvRegPacketFilterFlags);
-	writel(NVREG_OFFLOAD_NORMAL, base + NvRegOffloadConfig);
+	writel(np->rx_buf_sz, base + NvRegOffloadConfig);
 
 	writel(readl(base + NvRegReceiverStatus), base + NvRegReceiverStatus);
 	get_random_bytes(&i, sizeof(i));
 	writel(NVREG_RNDSEED_FORCE | (i&NVREG_RNDSEED_MASK), base + NvRegRandomSeed);
 	writel(NVREG_UNKSETUP1_VAL, base + NvRegUnknownSetupReg1);
 	writel(NVREG_UNKSETUP2_VAL, base + NvRegUnknownSetupReg2);
-	writel(NVREG_POLL_DEFAULT, base + NvRegPollingInterval);
+	if (poll_interval == -1) {
+		if (optimization_mode == NV_OPTIMIZATION_MODE_THROUGHPUT)
+			writel(NVREG_POLL_DEFAULT_THROUGHPUT, base + NvRegPollingInterval);
+		else
+			writel(NVREG_POLL_DEFAULT_CPU, base + NvRegPollingInterval);
+	}
+	else
+		writel(poll_interval & 0xFFFF, base + NvRegPollingInterval);
 	writel(NVREG_UNKSETUP6_VAL, base + NvRegUnknownSetupReg6);
 	writel((np->phyaddr << NVREG_ADAPTCTL_PHYSHIFT)|NVREG_ADAPTCTL_PHYVALID|NVREG_ADAPTCTL_RUNNING,
 			base + NvRegAdapterControl);
@@ -1620,6 +2400,9 @@ static int nv_open(struct net_device *de
 		writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
 		dprintk(KERN_INFO "startup: got 0x%08x.\n", miistat);
 	}
+	/* set linkspeed to invalid value, thus force nv_update_linkspeed
+	 * to init hw */
+	np->linkspeed = 0;
 	ret = nv_update_linkspeed(dev);
 	nv_start_rx(dev);
 	nv_start_tx(dev);
@@ -1642,8 +2425,8 @@ out_drain:
 
 static int nv_close(struct net_device *dev)
 {
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base;
+	struct fe_priv *np = netdev_priv(dev);
+	u8 __iomem *base;
 
 	spin_lock_irq(&np->lock);
 	np->in_shutdown = 1;
@@ -1674,6 +2457,12 @@ static int nv_close(struct net_device *d
 	if (np->wolenabled)
 		nv_start_rx(dev);
 
+	/* special op: write back the misordered MAC address - otherwise
+	 * the next nv_probe would see a wrong address.
+	 */
+	writel(np->orig_mac[0], base + NvRegMacAddrA);
+	writel(np->orig_mac[1], base + NvRegMacAddrB);
+
 	/* FIXME: power down nic */
 
 	return 0;
@@ -1684,7 +2473,7 @@ static int __devinit nv_probe(struct pci
 	struct net_device *dev;
 	struct fe_priv *np;
 	unsigned long addr;
-	u8 *base;
+	u8 __iomem *base;
 	int err, i;
 
 	dev = alloc_etherdev(sizeof(struct fe_priv));
@@ -1692,7 +2481,7 @@ static int __devinit nv_probe(struct pci
 	if (!dev)
 		goto out;
 
-	np = get_nvpriv(dev);
+	np = netdev_priv(dev);
 	np->pci_dev = pci_dev;
 	spin_lock_init(&np->lock);
 	SET_MODULE_OWNER(dev);
@@ -1738,30 +2527,80 @@ static int __devinit nv_probe(struct pci
 	}
 
 	/* handle different descriptor versions */
-	if (pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_1 ||
-		pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_2 ||
-		pci_dev->device == PCI_DEVICE_ID_NVIDIA_NVENET_3)
-		np->desc_ver = DESC_VER_1;
-	else
+	if (id->driver_data & DEV_HAS_HIGH_DMA) {
+		/* packet format 3: supports 40-bit addressing */
+		np->desc_ver = DESC_VER_3;
+		if (pci_set_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
+			printk(KERN_INFO "forcedeth: 64-bit DMA failed, using 32-bit addressing for device %s.\n",
+					pci_name(pci_dev));
+		} else {
+			dev->features |= NETIF_F_HIGHDMA;
+		}
+		np->txrxctl_bits = NVREG_TXRXCTL_DESC_3;
+	} else if (id->driver_data & DEV_HAS_LARGEDESC) {
+		/* packet format 2: supports jumbo frames */
 		np->desc_ver = DESC_VER_2;
+		np->txrxctl_bits = NVREG_TXRXCTL_DESC_2;
+	} else {
+		/* original packet format */
+		np->desc_ver = DESC_VER_1;
+		np->txrxctl_bits = NVREG_TXRXCTL_DESC_1;
+	}
+
+	np->pkt_limit = NV_PKTLIMIT_1;
+	if (id->driver_data & DEV_HAS_LARGEDESC)
+		np->pkt_limit = NV_PKTLIMIT_2;
+
+	if (id->driver_data & DEV_HAS_CHECKSUM) {
+		np->txrxctl_bits |= NVREG_TXRXCTL_RXCHECK;
+		dev->features |= NETIF_F_HW_CSUM | NETIF_F_SG;
+#ifdef NETIF_F_TSO
+		dev->features |= NETIF_F_TSO;
+#endif
+ 	}
+
+	np->vlanctl_bits = 0;
+	if (id->driver_data & DEV_HAS_VLAN) {
+		np->vlanctl_bits = NVREG_VLANCONTROL_ENABLE;
+		dev->features |= NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_TX;
+		dev->vlan_rx_register = nv_vlan_rx_register;
+		dev->vlan_rx_kill_vid = nv_vlan_rx_kill_vid;
+	}
 
 	err = -ENOMEM;
-	dev->base_addr = (unsigned long) ioremap(addr, NV_PCI_REGSZ);
-	if (!dev->base_addr)
+	np->base = ioremap(addr, NV_PCI_REGSZ);
+	if (!np->base)
 		goto out_relreg;
+	dev->base_addr = (unsigned long)np->base;
+
 	dev->irq = pci_dev->irq;
-	np->rx_ring = pci_alloc_consistent(pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING),
-						&np->ring_addr);
-	if (!np->rx_ring)
-		goto out_unmap;
-	np->tx_ring = &np->rx_ring[RX_RING];
+
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+		np->rx_ring.orig = pci_alloc_consistent(pci_dev,
+					sizeof(struct ring_desc) * (RX_RING + TX_RING),
+					&np->ring_addr);
+		if (!np->rx_ring.orig)
+			goto out_unmap;
+		np->tx_ring.orig = &np->rx_ring.orig[RX_RING];
+	} else {
+		np->rx_ring.ex = pci_alloc_consistent(pci_dev,
+					sizeof(struct ring_desc_ex) * (RX_RING + TX_RING),
+					&np->ring_addr);
+		if (!np->rx_ring.ex)
+			goto out_unmap;
+		np->tx_ring.ex = &np->rx_ring.ex[RX_RING];
+	}
 
 	dev->open = nv_open;
 	dev->stop = nv_close;
 	dev->hard_start_xmit = nv_start_xmit;
 	dev->get_stats = nv_get_stats;
 	dev->change_mtu = nv_change_mtu;
+	dev->set_mac_address = nv_set_mac_address;
 	dev->set_multicast_list = nv_set_multicast;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = nv_poll_controller;
+#endif
 	SET_ETHTOOL_OPS(dev, &ops);
 	dev->tx_timeout = nv_tx_timeout;
 	dev->watchdog_timeo = NV_WATCHDOG_TIMEO;
@@ -1805,18 +2644,15 @@ static int __devinit nv_probe(struct pci
 	np->wolenabled = 0;
 
 	if (np->desc_ver == DESC_VER_1) {
-		np->tx_flags = NV_TX_LASTPACKET|NV_TX_VALID;
-		if (id->driver_data & DEV_NEED_LASTPACKET1)
-			np->tx_flags |= NV_TX_LASTPACKET1;
+		np->tx_flags = NV_TX_VALID;
 	} else {
-		np->tx_flags = NV_TX2_LASTPACKET|NV_TX2_VALID;
-		if (id->driver_data & DEV_NEED_LASTPACKET1)
-			np->tx_flags |= NV_TX2_LASTPACKET1;
-	}
-	if (id->driver_data & DEV_IRQMASK_1)
-		np->irqmask = NVREG_IRQMASK_WANTED_1;
-	if (id->driver_data & DEV_IRQMASK_2)
-		np->irqmask = NVREG_IRQMASK_WANTED_2;
+		np->tx_flags = NV_TX2_VALID;
+	}
+	if (optimization_mode == NV_OPTIMIZATION_MODE_THROUGHPUT)
+		np->irqmask = NVREG_IRQMASK_THROUGHPUT;
+	else
+		np->irqmask = NVREG_IRQMASK_CPU;
+
 	if (id->driver_data & DEV_NEED_TIMERIRQ)
 		np->irqmask |= NVREG_IRQ_TIMER;
 	if (id->driver_data & DEV_NEED_LINKTIMER) {
@@ -1829,16 +2665,17 @@ static int __devinit nv_probe(struct pci
 	}
 
 	/* find a suitable phy */
-	for (i = 1; i < 32; i++) {
+	for (i = 1; i <= 32; i++) {
 		int id1, id2;
+		int phyaddr = i & 0x1F;
 
 		spin_lock_irq(&np->lock);
-		id1 = mii_rw(dev, i, MII_PHYSID1, MII_READ);
+		id1 = mii_rw(dev, phyaddr, MII_PHYSID1, MII_READ);
 		spin_unlock_irq(&np->lock);
 		if (id1 < 0 || id1 == 0xffff)
 			continue;
 		spin_lock_irq(&np->lock);
-		id2 = mii_rw(dev, i, MII_PHYSID2, MII_READ);
+		id2 = mii_rw(dev, phyaddr, MII_PHYSID2, MII_READ);
 		spin_unlock_irq(&np->lock);
 		if (id2 < 0 || id2 == 0xffff)
 			continue;
@@ -1846,23 +2683,24 @@ static int __devinit nv_probe(struct pci
 		id1 = (id1 & PHYID1_OUI_MASK) << PHYID1_OUI_SHFT;
 		id2 = (id2 & PHYID2_OUI_MASK) >> PHYID2_OUI_SHFT;
 		dprintk(KERN_DEBUG "%s: open: Found PHY %04x:%04x at address %d.\n",
-				pci_name(pci_dev), id1, id2, i);
-		np->phyaddr = i;
+			pci_name(pci_dev), id1, id2, phyaddr);
+		np->phyaddr = phyaddr;
 		np->phy_oui = id1 | id2;
 		break;
 	}
-	if (i == 32) {
-		/* PHY in isolate mode? No phy attached and user wants to
-		 * test loopback? Very odd, but can be correct.
-		 */
+	if (i == 33) {
 		printk(KERN_INFO "%s: open: Could not find a valid PHY.\n",
-				pci_name(pci_dev));
+		       pci_name(pci_dev));
+		goto out_freering;
 	}
+	
+	/* reset it */
+	phy_init(dev);
 
-	if (i != 32) {
-		/* reset it */
-		phy_init(dev);
-	}
+	/* set default link speed settings */
+	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+	np->duplex = 0;
+	np->autoneg = 1;
 
 	err = register_netdev(dev);
 	if (err) {
@@ -1876,8 +2714,12 @@ static int __devinit nv_probe(struct pci
 	return 0;
 
 out_freering:
-	pci_free_consistent(np->pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING),
-				np->rx_ring, np->ring_addr);
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+		pci_free_consistent(np->pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING),
+				    np->rx_ring.orig, np->ring_addr);
+	else
+		pci_free_consistent(np->pci_dev, sizeof(struct ring_desc_ex) * (RX_RING + TX_RING),
+				    np->rx_ring.ex, np->ring_addr);
 	pci_set_drvdata(pci_dev, NULL);
 out_unmap:
 	iounmap(get_hwbase(dev));
@@ -1894,19 +2736,15 @@ out:
 static void __devexit nv_remove(struct pci_dev *pci_dev)
 {
 	struct net_device *dev = pci_get_drvdata(pci_dev);
-	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	struct fe_priv *np = netdev_priv(dev);
 
 	unregister_netdev(dev);
 
-	/* special op: write back the misordered MAC address - otherwise
-	 * the next nv_probe would see a wrong address.
-	 */
-	writel(np->orig_mac[0], base + NvRegMacAddrA);
-	writel(np->orig_mac[1], base + NvRegMacAddrB);
-
 	/* free all structures */
-	pci_free_consistent(np->pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING), np->rx_ring, np->ring_addr);
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+		pci_free_consistent(np->pci_dev, sizeof(struct ring_desc) * (RX_RING + TX_RING), np->rx_ring.orig, np->ring_addr);
+	else
+		pci_free_consistent(np->pci_dev, sizeof(struct ring_desc_ex) * (RX_RING + TX_RING), np->rx_ring.ex, np->ring_addr);
 	iounmap(get_hwbase(dev));
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
@@ -1916,81 +2754,64 @@ static void __devexit nv_remove(struct p
 
 static struct pci_device_id pci_tbl[] = {
 	{	/* nForce Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_1,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_1),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce2 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_2,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_2),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_3,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_3),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_4,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_4),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_5,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_5),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_6,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_6),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_7,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_7),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM,
 	},
 	{	/* CK804 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_8,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_8),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA,
 	},
 	{	/* CK804 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_9,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_9),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA,
 	},
 	{	/* MCP04 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_10,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_10),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA,
 	},
 	{	/* MCP04 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_11,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_11),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA,
+	},
+	{	/* MCP51 Ethernet Controller */
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_12),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_HIGH_DMA,
+	},
+	{	/* MCP51 Ethernet Controller */
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_13),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_HIGH_DMA,
+	},
+	{	/* MCP55 Ethernet Controller */
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_14),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA|DEV_HAS_VLAN,
+	},
+	{	/* MCP55 Ethernet Controller */
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_15),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_CHECKSUM|DEV_HAS_HIGH_DMA|DEV_HAS_VLAN,
 	},
 	{0,},
 };
@@ -2016,7 +2837,11 @@ static void __exit exit_nic(void)
 
 module_param(max_interrupt_work, int, 0);
 MODULE_PARM_DESC(max_interrupt_work, "forcedeth maximum events handled per interrupt");
- 
+module_param(optimization_mode, int, 0);
+MODULE_PARM_DESC(optimization_mode, "In throughput mode (0), every tx & rx packet will generate an interrupt. In CPU mode (1), interrupts are controlled by a timer.");
+module_param(poll_interval, int, 0);
+MODULE_PARM_DESC(poll_interval, "Interval determines how frequent timer interrupt is generated by [(time_in_micro_secs * 100) / (2^10)]. Min is 0 and Max is 65535.");
+
 MODULE_AUTHOR("Manfred Spraul <manfred@colorfullife.com>");
 MODULE_DESCRIPTION("Reverse Engineered nForce ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1924277..8bc6afd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1045,7 +1045,11 @@ #define PCI_DEVICE_ID_NVIDIA_QUADRO_DDC	
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
+#define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
+#define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
+#define PCI_DEVICE_ID_NVIDIA_NVENET_14		0x0372
+#define PCI_DEVICE_ID_NVIDIA_NVENET_15		0x0373
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x037E
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2	0x037F
 
-- 
1.3.3


--BXVAT5kNtrzKuDFl--
