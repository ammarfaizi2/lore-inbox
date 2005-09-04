Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVIDMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVIDMek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIDMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:34:40 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:39824 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750803AbVIDMej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:34:39 -0400
Message-ID: <431AE9B7.2040300@colorfullife.com>
Date: Sun, 04 Sep 2005 14:33:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
CC: Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: [CFT] forcedeth backport to 2.4
Content-Type: multipart/mixed;
 boundary="------------040003030102010107040708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003030102010107040708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Attached is a backport of the latest forcedeth version to 2.4. It 
includes lots of changes, among them:
- a critical bugfix for nv_open(): ifdown/ifup cycles resulted in an 
incomplete initialization that causes hangs after a few MB network traffic.
- jumbo frame support
- far better ethtool support
- 64-bit dma support
- support for additional nforce versions.

It compiles and boots, but I can't test it properly. Could you give it a 
try?

--
    Manfred

--------------040003030102010107040708
Content-Type: text/plain;
 name="patch-forcedeth-backport"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forcedeth-backport"

--- 2.4/drivers/net/forcedeth.c	2005-01-19 15:09:56.000000000 +0100
+++ build-2.4/drivers/net/forcedeth.c	2005-09-04 13:58:07.000000000 +0200
@@ -79,6 +79,22 @@
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
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -90,7 +106,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.30"
+#define FORCEDETH_VERSION		"0.42"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -108,6 +124,7 @@
 #include <linux/mii.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/if_vlan.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -125,11 +142,10 @@
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
 
 enum {
 	NvRegIrqStatus = 0x000,
@@ -140,13 +156,16 @@
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
+#define NVREG_IRQMASK_WANTED		0x00df
+
+#define NVREG_IRQ_UNKNOWN	(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR| \
+					NVREG_IRQ_TX_OK|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX_ERROR| \
+					NVREG_IRQ_TX1))
 
 	NvRegUnknownSetupReg6 = 0x008,
 #define NVREG_UNKSETUP6_VAL		3
@@ -211,6 +230,7 @@
 #define NVREG_LINKSPEED_10	1000
 #define NVREG_LINKSPEED_100	100
 #define NVREG_LINKSPEED_1000	50
+#define NVREG_LINKSPEED_MASK	(0xFFF)
 	NvRegUnknownSetupReg5 = 0x130,
 #define NVREG_UNKSETUP5_BIT31	(1<<31)
 	NvRegUnknownSetupReg3 = 0x13c,
@@ -279,6 +299,18 @@
 	u32 FlagLen;
 };
 
+struct ring_desc_ex {
+	u32 PacketBufferHigh;
+	u32 PacketBufferLow;
+	u32 Reserved;
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
@@ -286,7 +318,7 @@
 
 #define NV_TX_LASTPACKET	(1<<16)
 #define NV_TX_RETRYERROR	(1<<19)
-#define NV_TX_LASTPACKET1	(1<<24)
+#define NV_TX_FORCED_INTERRUPT	(1<<24)
 #define NV_TX_DEFERRED		(1<<26)
 #define NV_TX_CARRIERLOST	(1<<27)
 #define NV_TX_LATECOLLISION	(1<<28)
@@ -296,7 +328,7 @@
 
 #define NV_TX2_LASTPACKET	(1<<29)
 #define NV_TX2_RETRYERROR	(1<<18)
-#define NV_TX2_LASTPACKET1	(1<<23)
+#define NV_TX2_FORCED_INTERRUPT	(1<<30)
 #define NV_TX2_DEFERRED		(1<<25)
 #define NV_TX2_CARRIERLOST	(1<<26)
 #define NV_TX2_LATECOLLISION	(1<<27)
@@ -362,7 +394,7 @@
 
 #define RX_RING		128
 #define TX_RING		64
-/*
+/* 
  * If your nic mysteriously hangs then try to reduce the limits
  * to 1/0: It might be required to set NV_TX_LASTPACKET in the
  * last valid ring entry. But this would be impossible to
@@ -372,15 +404,19 @@
 #define TX_LIMIT_START	62
 
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
  * This field has two purposes:
  * - Newer nics uses a different ring layout. The layout is selected by
@@ -389,6 +425,7 @@
  */
 #define DESC_VER_1	0x0
 #define DESC_VER_2	(0x02100|NVREG_TXRXCTL_RXCHECK)
+#define DESC_VER_3      (0x02200|NVREG_TXRXCTL_RXCHECK)
 
 /* PHY defines */
 #define PHY_OUI_MARVELL	0x5043
@@ -442,6 +479,8 @@
 	int in_shutdown;
 	u32 linkspeed;
 	int duplex;
+	int autoneg;
+	int fixed_mode;
 	int phyaddr;
 	int wolenabled;
 	unsigned int phy_oui;
@@ -454,14 +493,17 @@
 	u32 irqmask;
 	u32 desc_ver;
 
+	void __iomem *base;
+
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
 
@@ -473,7 +515,7 @@
 	/*
 	 * tx specific fields.
 	 */
-	struct ring_desc *tx_ring;
+	ring_type tx_ring;
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
@@ -488,15 +530,15 @@
 
 static inline struct fe_priv *get_nvpriv(struct net_device *dev)
 {
-	return (struct fe_priv *) dev->priv;
+	return netdev_priv(dev);
 }
 
-static inline u8 *get_hwbase(struct net_device *dev)
+static inline u8 __iomem *get_hwbase(struct net_device *dev)
 {
-	return (u8 *) dev->base_addr;
+	return get_nvpriv(dev)->base;
 }
 
-static inline void pci_push(u8 * base)
+static inline void pci_push(u8 __iomem *base)
 {
 	/* force out pending posted writes */
 	readl(base);
@@ -508,10 +550,15 @@
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
@@ -533,7 +580,7 @@
  */
 static int mii_rw(struct net_device *dev, int addr, int miireg, int value)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 reg;
 	int retval;
 
@@ -604,7 +651,7 @@
 static int phy_init(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 phyinterface, phy_reserved, mii_status, mii_control, mii_control_1000,reg;
 
 	/* set advertise register */
@@ -681,7 +728,7 @@
 static void nv_start_rx(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_start_rx\n", dev->name);
 	/* Already running? Stop it. */
@@ -699,7 +746,7 @@
 
 static void nv_stop_rx(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_stop_rx\n", dev->name);
 	writel(0, base + NvRegReceiverControl);
@@ -713,7 +760,7 @@
 
 static void nv_start_tx(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_start_tx\n", dev->name);
 	writel(NVREG_XMITCTL_START, base + NvRegTransmitterControl);
@@ -722,7 +769,7 @@
 
 static void nv_stop_tx(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_stop_tx\n", dev->name);
 	writel(0, base + NvRegTransmitterControl);
@@ -737,7 +784,7 @@
 static void nv_txrx_reset(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	dprintk(KERN_DEBUG "%s: nv_txrx_reset\n", dev->name);
 	writel(NVREG_TXRXCTL_BIT2 | NVREG_TXRXCTL_RESET | np->desc_ver, base + NvRegTxRxControl);
@@ -764,50 +811,6 @@
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
@@ -825,7 +828,7 @@
 		nr = refill_rx % RX_RING;
 		if (np->rx_skbuff[nr] == NULL) {
 
-			skb = dev_alloc_skb(RX_ALLOC_BUFSIZE);
+			skb = dev_alloc_skb(np->rx_buf_sz + NV_RX_ALLOC_PAD);
 			if (!skb)
 				break;
 
@@ -836,9 +839,16 @@
 		}
 		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
 						PCI_DMA_FROMDEVICE);
-		np->rx_ring[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
-		wmb();
-		np->rx_ring[nr].FlagLen = cpu_to_le32(RX_NIC_BUFSIZE | NV_RX_AVAIL);
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
@@ -864,19 +874,37 @@
 	enable_irq(dev->irq);
 }
 
-static int nv_init_ring(struct net_device *dev)
+static void nv_init_rx(struct net_device *dev) 
 {
 	struct fe_priv *np = get_nvpriv(dev);
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
+	struct fe_priv *np = get_nvpriv(dev);
+	int i;
+
+	np->next_tx = np->nic_tx = 0;
+	for (i = 0; i < TX_RING; i++)
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			np->tx_ring.orig[i].FlagLen = 0;
+	        else
+			np->tx_ring.ex[i].FlagLen = 0;
+}
+
+static int nv_init_ring(struct net_device *dev)
+{
+	nv_init_tx(dev);
+	nv_init_rx(dev);
 	return nv_alloc_rx(dev);
 }
 
@@ -885,7 +913,10 @@
 	struct fe_priv *np = get_nvpriv(dev);
 	int i;
 	for (i = 0; i < TX_RING; i++) {
-		np->tx_ring[i].FlagLen = 0;
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			np->tx_ring.orig[i].FlagLen = 0;
+		else
+			np->tx_ring.ex[i].FlagLen = 0;
 		if (np->tx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->tx_dma[i],
 						np->tx_skbuff[i]->len,
@@ -902,7 +933,10 @@
 	struct fe_priv *np = get_nvpriv(dev);
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
@@ -933,11 +967,19 @@
 	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data,skb->len,
 					PCI_DMA_TODEVICE);
 
-	np->tx_ring[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+		np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+	else {
+		np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
+		np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
+	}
 
 	spin_lock_irq(&np->lock);
 	wmb();
-	np->tx_ring[nr].FlagLen = cpu_to_le32( (skb->len-1) | np->tx_flags );
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+		np->tx_ring.orig[nr].FlagLen = cpu_to_le32( (skb->len-1) | np->tx_flags );
+	else
+		np->tx_ring.ex[nr].FlagLen = cpu_to_le32( (skb->len-1) | np->tx_flags );
 	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission.\n",
 				dev->name, np->next_tx);
 	{
@@ -975,7 +1017,10 @@
 	while (np->nic_tx != np->next_tx) {
 		i = np->nic_tx % TX_RING;
 
-		Flags = le32_to_cpu(np->tx_ring[i].FlagLen);
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2)
+			Flags = le32_to_cpu(np->tx_ring.orig[i].FlagLen);
+		else
+			Flags = le32_to_cpu(np->tx_ring.ex[i].FlagLen);
 
 		dprintk(KERN_DEBUG "%s: nv_tx_done: looking at packet %d, Flags 0x%x.\n",
 					dev->name, np->nic_tx, Flags);
@@ -1024,11 +1069,58 @@
 static void nv_tx_timeout(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
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
@@ -1042,7 +1134,10 @@
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
 
@@ -1051,6 +1146,59 @@
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
 	struct fe_priv *np = get_nvpriv(dev);
@@ -1064,8 +1212,13 @@
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
+		}
 
 		dprintk(KERN_DEBUG "%s: nv_rx_process: looking at packet %d, Flags 0x%x.\n",
 					dev->name, np->cur_rx, Flags);
@@ -1102,7 +1255,7 @@
 				np->stats.rx_errors++;
 				goto next_pkt;
 			}
-			if (Flags & (NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3|NV_RX_ERROR4)) {
+			if (Flags & (NV_RX_ERROR1|NV_RX_ERROR2|NV_RX_ERROR3)) {
 				np->stats.rx_errors++;
 				goto next_pkt;
 			}
@@ -1116,22 +1269,24 @@
 				np->stats.rx_errors++;
 				goto next_pkt;
 			}
-			if (Flags & NV_RX_ERROR) {
-				/* framing errors are soft errors, the rest is fatal. */
-				if (Flags & NV_RX_FRAMINGERR) {
-					if (Flags & NV_RX_SUBSTRACT1) {
-						len--;
-					}
-				} else {
+			if (Flags & NV_RX_ERROR4) {
+				len = nv_getlen(dev, np->rx_skbuff[i]->data, len);
+				if (len < 0) {
 					np->stats.rx_errors++;
 					goto next_pkt;
 				}
 			}
+			/* framing errors are soft errors. */
+			if (Flags & NV_RX_FRAMINGERR) {
+				if (Flags & NV_RX_SUBSTRACT1) {
+					len--;
+				}
+			}
 		} else {
 			if (!(Flags & NV_RX2_DESCRIPTORVALID))
 				goto next_pkt;
 
-			if (Flags & (NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3|NV_RX2_ERROR4)) {
+			if (Flags & (NV_RX2_ERROR1|NV_RX2_ERROR2|NV_RX2_ERROR3)) {
 				np->stats.rx_errors++;
 				goto next_pkt;
 			}
@@ -1145,17 +1300,19 @@
 				np->stats.rx_errors++;
 				goto next_pkt;
 			}
-			if (Flags & NV_RX2_ERROR) {
-				/* framing errors are soft errors, the rest is fatal. */
-				if (Flags & NV_RX2_FRAMINGERR) {
-					if (Flags & NV_RX2_SUBSTRACT1) {
-						len--;
-					}
-				} else {
+			if (Flags & NV_RX2_ERROR4) {
+				len = nv_getlen(dev, np->rx_skbuff[i]->data, len);
+				if (len < 0) {
 					np->stats.rx_errors++;
 					goto next_pkt;
 				}
 			}
+			/* framing errors are soft errors */
+			if (Flags & NV_RX2_FRAMINGERR) {
+				if (Flags & NV_RX2_SUBSTRACT1) {
+					len--;
+				}
+			}
 			Flags &= NV_RX2_CHECKSUMMASK;
 			if (Flags == NV_RX2_CHECKSUMOK1 ||
 					Flags == NV_RX2_CHECKSUMOK2 ||
@@ -1183,15 +1340,133 @@
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
+	struct fe_priv *np = get_nvpriv(dev);
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
+		u8 *base = get_hwbase(dev);
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
+		writel(NVREG_TXRXCTL_KICK|np->desc_ver, get_hwbase(dev) + NvRegTxRxControl);
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
+	u8 *base = get_hwbase(dev);
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
+	struct fe_priv *np = get_nvpriv(dev);
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
 
@@ -1202,7 +1477,7 @@
 static void nv_set_multicast(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 addr[2];
 	u32 mask[2];
 	u32 pff;
@@ -1262,7 +1537,7 @@
 static int nv_update_linkspeed(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	int adv, lpa;
 	int newls = np->linkspeed;
 	int newdup = np->duplex;
@@ -1285,6 +1560,25 @@
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
@@ -1302,7 +1596,7 @@
 
 		if ((control_1000 & ADVERTISE_1000FULL) &&
 			(status_1000 & LPA_1000FULL)) {
-		dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
+			dprintk(KERN_DEBUG "%s: nv_update_linkspeed: GBit ethernet detected.\n",
 				dev->name);
 			newls = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_1000;
 			newdup = 1;
@@ -1361,9 +1655,9 @@
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
 
@@ -1397,7 +1691,7 @@
 
 static void nv_link_irq(struct net_device *dev)
 {
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 miistat;
 
 	miistat = readl(base + NvRegMIIStatus);
@@ -1413,7 +1707,7 @@
 {
 	struct net_device *dev = (struct net_device *) data;
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	u32 events;
 	int i;
 
@@ -1427,7 +1721,7 @@
 		if (!(events & np->irqmask))
 			break;
 
-		if (events & (NVREG_IRQ_TX1|NVREG_IRQ_TX2|NVREG_IRQ_TX_ERR)) {
+		if (events & (NVREG_IRQ_TX1|NVREG_IRQ_TX_OK|NVREG_IRQ_TX_ERROR|NVREG_IRQ_TX_ERR)) {
 			spin_lock(&np->lock);
 			nv_tx_done(dev);
 			spin_unlock(&np->lock);
@@ -1485,7 +1779,7 @@
 {
 	struct net_device *dev = (struct net_device *) data;
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 
 	disable_irq(dev->irq);
 	/* FIXME: Do we need synchronize_irq(dev->irq) here? */
@@ -1499,10 +1793,285 @@
 	enable_irq(dev->irq);
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void nv_poll_controller(struct net_device *dev)
+{
+	nv_do_nic_poll((unsigned long) dev);
+}
+#endif
+
+static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	struct fe_priv *np = get_nvpriv(dev);
+	strcpy(info->driver, "forcedeth");
+	strcpy(info->version, FORCEDETH_VERSION);
+	strcpy(info->bus_info, pci_name(np->pci_dev));
+}
+
+static void nv_get_wol(struct net_device *dev, struct ethtool_wolinfo *wolinfo)
+{
+	struct fe_priv *np = get_nvpriv(dev);
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
+	struct fe_priv *np = get_nvpriv(dev);
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
+	struct fe_priv *np = get_nvpriv(dev);
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
+	struct fe_priv *np = get_nvpriv(dev);
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
 static int nv_open(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
+	u8 __iomem *base = get_hwbase(dev);
 	int ret, oom, i;
 
 	dprintk(KERN_DEBUG "nv_open: begin\n");
@@ -1521,6 +2090,7 @@
 	writel(0, base + NvRegAdapterControl);
 
 	/* 2) initialize descriptor rings */
+	set_bufsize(dev);
 	oom = nv_init_ring(dev);
 
 	writel(0, base + NvRegLinkSpeed);
@@ -1531,27 +2101,18 @@
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
 	writel(np->desc_ver, base + NvRegTxRxControl);
@@ -1569,7 +2130,7 @@
 	writel(NVREG_MISC1_FORCE | NVREG_MISC1_HD, base + NvRegMisc1);
 	writel(readl(base + NvRegTransmitterStatus), base + NvRegTransmitterStatus);
 	writel(NVREG_PFF_ALWAYS, base + NvRegPacketFilterFlags);
-	writel(NVREG_OFFLOAD_NORMAL, base + NvRegOffloadConfig);
+	writel(np->rx_buf_sz, base + NvRegOffloadConfig);
 
 	writel(readl(base + NvRegReceiverStatus), base + NvRegReceiverStatus);
 	get_random_bytes(&i, sizeof(i));
@@ -1620,6 +2181,9 @@
 		writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
 		dprintk(KERN_INFO "startup: got 0x%08x.\n", miistat);
 	}
+	/* set linkspeed to invalid value, thus force nv_update_linkspeed
+	 * to init hw */
+	np->linkspeed = 0;
 	ret = nv_update_linkspeed(dev);
 	nv_start_rx(dev);
 	nv_start_tx(dev);
@@ -1643,7 +2207,7 @@
 static int nv_close(struct net_device *dev)
 {
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base;
+	u8 __iomem *base;
 
 	spin_lock_irq(&np->lock);
 	np->in_shutdown = 1;
@@ -1674,6 +2238,12 @@
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
@@ -1684,7 +2254,7 @@
 	struct net_device *dev;
 	struct fe_priv *np;
 	unsigned long addr;
-	u8 *base;
+	u8 __iomem *base;
 	int err, i;
 
 	dev = alloc_etherdev(sizeof(struct fe_priv));
@@ -1738,30 +2308,59 @@
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
+		}
+	} else if (id->driver_data & DEV_HAS_LARGEDESC) {
+		/* packet format 2: supports jumbo frames */
 		np->desc_ver = DESC_VER_2;
+	} else {
+		/* original packet format */
+		np->desc_ver = DESC_VER_1;
+	}
+
+	np->pkt_limit = NV_PKTLIMIT_1;
+	if (id->driver_data & DEV_HAS_LARGEDESC)
+		np->pkt_limit = NV_PKTLIMIT_2;
 
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
@@ -1806,17 +2405,10 @@
 
 	if (np->desc_ver == DESC_VER_1) {
 		np->tx_flags = NV_TX_LASTPACKET|NV_TX_VALID;
-		if (id->driver_data & DEV_NEED_LASTPACKET1)
-			np->tx_flags |= NV_TX_LASTPACKET1;
 	} else {
 		np->tx_flags = NV_TX2_LASTPACKET|NV_TX2_VALID;
-		if (id->driver_data & DEV_NEED_LASTPACKET1)
-			np->tx_flags |= NV_TX2_LASTPACKET1;
 	}
-	if (id->driver_data & DEV_IRQMASK_1)
-		np->irqmask = NVREG_IRQMASK_WANTED_1;
-	if (id->driver_data & DEV_IRQMASK_2)
-		np->irqmask = NVREG_IRQMASK_WANTED_2;
+	np->irqmask = NVREG_IRQMASK_WANTED;
 	if (id->driver_data & DEV_NEED_TIMERIRQ)
 		np->irqmask |= NVREG_IRQ_TIMER;
 	if (id->driver_data & DEV_NEED_LINKTIMER) {
@@ -1864,6 +2456,11 @@
 		phy_init(dev);
 	}
 
+	/* set default link speed settings */
+	np->linkspeed = NVREG_LINKSPEED_FORCE|NVREG_LINKSPEED_10;
+	np->duplex = 0;
+	np->autoneg = 1;
+
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", err);
@@ -1876,8 +2473,12 @@
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
@@ -1895,18 +2496,14 @@
 {
 	struct net_device *dev = pci_get_drvdata(pci_dev);
 	struct fe_priv *np = get_nvpriv(dev);
-	u8 *base = get_hwbase(dev);
 
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
@@ -1916,81 +2513,64 @@
 
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
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_5,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_5),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_6,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_6),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* nForce3 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_7,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_7),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* CK804 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_8,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_8),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_HIGH_DMA,
 	},
 	{	/* CK804 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_9,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_9),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_HIGH_DMA,
 	},
 	{	/* MCP04 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_10,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_10),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_HIGH_DMA,
 	},
 	{	/* MCP04 Ethernet Controller */
-		.vendor = PCI_VENDOR_ID_NVIDIA,
-		.device = PCI_DEVICE_ID_NVIDIA_NVENET_11,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ,
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_11),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_HIGH_DMA,
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
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_HIGH_DMA,
+	},
+	{	/* MCP55 Ethernet Controller */
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_15),
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC|DEV_HAS_HIGH_DMA,
 	},
 	{0,},
 };
@@ -2016,7 +2596,7 @@
 
 module_param(max_interrupt_work, int, 0);
 MODULE_PARM_DESC(max_interrupt_work, "forcedeth maximum events handled per interrupt");
- 
+
 MODULE_AUTHOR("Manfred Spraul <manfred@colorfullife.com>");
 MODULE_DESCRIPTION("Reverse Engineered nForce ethernet driver");
 MODULE_LICENSE("GPL");
--- 2.4/include/linux/pci_ids.h	2005-06-01 02:56:56.000000000 +0200
+++ build-2.4/include/linux/pci_ids.h	2005-09-04 13:55:37.000000000 +0200
@@ -1034,6 +1034,10 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_2		0x0202
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_DDC		0x0203
+#define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
+#define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
+#define PCI_DEVICE_ID_NVIDIA_NVENET_14		0x0372
+#define PCI_DEVICE_ID_NVIDIA_NVENET_15		0x0373
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849

--------------040003030102010107040708--
