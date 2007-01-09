Return-Path: <linux-kernel-owner+w=401wt.eu-S1751251AbXAIJvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbXAIJvP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXAIJvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:51:15 -0500
Received: from havoc.gtf.org ([69.61.125.42]:59068 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbXAIJvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:51:08 -0500
Date: Tue, 9 Jan 2007 04:50:59 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches, updated] net driver fixes
Message-ID: <20070109095058.GA12349@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[resend; updated with a few more bug fixes, since yesterday]

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/chelsio/my3126.c    |    5 +-
 drivers/net/e1000/e1000_main.c  |    6 -
 drivers/net/forcedeth.c         |  111 ++++++++++----------
 drivers/net/ixgb/ixgb.h         |    1 +
 drivers/net/ixgb/ixgb_ethtool.c |    1 +
 drivers/net/ixgb/ixgb_hw.c      |    3 +-
 drivers/net/ixgb/ixgb_main.c    |   57 +++++++++-
 drivers/net/pcmcia/pcnet_cs.c   |    2 +
 drivers/net/qla3xxx.c           |   38 ++++---
 drivers/net/wireless/ipw2100.c  |    2 +-
 drivers/s390/net/Kconfig        |    5 +-
 drivers/s390/net/qeth.h         |    2 +-
 drivers/s390/net/qeth_main.c    |  217 +++++++++++++++++----------------------
 include/net/ieee80211.h         |    2 +-
 14 files changed, 236 insertions(+), 216 deletions(-)

Aaron Salter (1):
      ixgb: Write RA register high word first, increment version

Ayaz Abdulla (1):
      forcedeth: sideband management fix

Frank Blaschka (3):
      s390: qeth driver fixes: VLAN hdr, perf stats
      s390: qeth driver fixes: packet socket
      s390: qeth driver fixes: atomic context fixups

Frank Pavlic (1):
      s390: iucv Kconfig help description changes

Heiko Carstens (1):
      qeth: fix uaccess handling and get rid of unused variable

Jeff Garzik (1):
      Revert "e1000: disable TSO on the 82544 with slab debugging"

Jesse Brandeburg (2):
      ixgb: Fix early TSO completion
      ixgb: Maybe stop TX if not enough free descriptors

Komuro (1):
      pcnet_cs : add new id

Ron Mercer (2):
      qla3xxx: Remove NETIF_F_LLTX from driver features.
      qla3xxx: Add delay to NVRAM register access.

Stephen Hemminger (1):
      chelsio: error path fix

Zhu Yi (2):
      ieee80211: WLAN_GET_SEQ_SEQ fix (select correct region)
      ipw2100: Fix dropping fragmented small packet problem

diff --git a/drivers/net/chelsio/my3126.c b/drivers/net/chelsio/my3126.c
index c7731b6..82fed1d 100644
--- a/drivers/net/chelsio/my3126.c
+++ b/drivers/net/chelsio/my3126.c
@@ -170,9 +170,10 @@ static struct cphy *my3126_phy_create(adapter_t *adapter,
 {
 	struct cphy *cphy = kzalloc(sizeof (*cphy), GFP_KERNEL);
 
-	if (cphy)
-		cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);
+	if (!cphy)
+		return NULL;
 
+	cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);
 	INIT_DELAYED_WORK(&cphy->phy_update, my3216_poll);
 	cphy->bmsr = 0;
 
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 4c1ff75..c6259c7 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -995,12 +995,6 @@ e1000_probe(struct pci_dev *pdev,
 	   (adapter->hw.mac_type != e1000_82547))
 		netdev->features |= NETIF_F_TSO;
 
-#ifdef CONFIG_DEBUG_SLAB
-	/* 82544's work arounds do not play nicely with DEBUG SLAB */
-	if (adapter->hw.mac_type == e1000_82544)
-		netdev->features &= ~NETIF_F_TSO;
-#endif
-
 #ifdef NETIF_F_TSO6
 	if (adapter->hw.mac_type > e1000_82547_rev_2)
 		netdev->features |= NETIF_F_TSO6;
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 2f48fe9..93f2b7a 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -234,6 +234,7 @@ enum {
 #define NVREG_XMITCTL_HOST_SEMA_MASK	0x0000f000
 #define NVREG_XMITCTL_HOST_SEMA_ACQ	0x0000f000
 #define NVREG_XMITCTL_HOST_LOADED	0x00004000
+#define NVREG_XMITCTL_TX_PATH_EN	0x01000000
 	NvRegTransmitterStatus = 0x088,
 #define NVREG_XMITSTAT_BUSY	0x01
 
@@ -249,6 +250,7 @@ enum {
 #define NVREG_OFFLOAD_NORMAL	RX_NIC_BUFSIZE
 	NvRegReceiverControl = 0x094,
 #define NVREG_RCVCTL_START	0x01
+#define NVREG_RCVCTL_RX_PATH_EN	0x01000000
 	NvRegReceiverStatus = 0x98,
 #define NVREG_RCVSTAT_BUSY	0x01
 
@@ -1169,16 +1171,21 @@ static void nv_start_rx(struct net_device *dev)
 {
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
+	u32 rx_ctrl = readl(base + NvRegReceiverControl);
 
 	dprintk(KERN_DEBUG "%s: nv_start_rx\n", dev->name);
 	/* Already running? Stop it. */
-	if (readl(base + NvRegReceiverControl) & NVREG_RCVCTL_START) {
-		writel(0, base + NvRegReceiverControl);
+	if ((readl(base + NvRegReceiverControl) & NVREG_RCVCTL_START) && !np->mac_in_use) {
+		rx_ctrl &= ~NVREG_RCVCTL_START;
+		writel(rx_ctrl, base + NvRegReceiverControl);
 		pci_push(base);
 	}
 	writel(np->linkspeed, base + NvRegLinkSpeed);
 	pci_push(base);
-	writel(NVREG_RCVCTL_START, base + NvRegReceiverControl);
+        rx_ctrl |= NVREG_RCVCTL_START;
+        if (np->mac_in_use)
+		rx_ctrl &= ~NVREG_RCVCTL_RX_PATH_EN;
+	writel(rx_ctrl, base + NvRegReceiverControl);
 	dprintk(KERN_DEBUG "%s: nv_start_rx to duplex %d, speed 0x%08x.\n",
 				dev->name, np->duplex, np->linkspeed);
 	pci_push(base);
@@ -1186,39 +1193,59 @@ static void nv_start_rx(struct net_device *dev)
 
 static void nv_stop_rx(struct net_device *dev)
 {
+	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
+	u32 rx_ctrl = readl(base + NvRegReceiverControl);
 
 	dprintk(KERN_DEBUG "%s: nv_stop_rx\n", dev->name);
-	writel(0, base + NvRegReceiverControl);
+	if (!np->mac_in_use)
+		rx_ctrl &= ~NVREG_RCVCTL_START;
+	else
+		rx_ctrl |= NVREG_RCVCTL_RX_PATH_EN;
+	writel(rx_ctrl, base + NvRegReceiverControl);
 	reg_delay(dev, NvRegReceiverStatus, NVREG_RCVSTAT_BUSY, 0,
 			NV_RXSTOP_DELAY1, NV_RXSTOP_DELAY1MAX,
 			KERN_INFO "nv_stop_rx: ReceiverStatus remained busy");
 
 	udelay(NV_RXSTOP_DELAY2);
-	writel(0, base + NvRegLinkSpeed);
+	if (!np->mac_in_use)
+		writel(0, base + NvRegLinkSpeed);
 }
 
 static void nv_start_tx(struct net_device *dev)
 {
+	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
+	u32 tx_ctrl = readl(base + NvRegTransmitterControl);
 
 	dprintk(KERN_DEBUG "%s: nv_start_tx\n", dev->name);
-	writel(NVREG_XMITCTL_START, base + NvRegTransmitterControl);
+	tx_ctrl |= NVREG_XMITCTL_START;
+	if (np->mac_in_use)
+		tx_ctrl &= ~NVREG_XMITCTL_TX_PATH_EN;
+	writel(tx_ctrl, base + NvRegTransmitterControl);
 	pci_push(base);
 }
 
 static void nv_stop_tx(struct net_device *dev)
 {
+	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
+	u32 tx_ctrl = readl(base + NvRegTransmitterControl);
 
 	dprintk(KERN_DEBUG "%s: nv_stop_tx\n", dev->name);
-	writel(0, base + NvRegTransmitterControl);
+	if (!np->mac_in_use)
+		tx_ctrl &= ~NVREG_XMITCTL_START;
+	else
+		tx_ctrl |= NVREG_XMITCTL_TX_PATH_EN;
+	writel(tx_ctrl, base + NvRegTransmitterControl);
 	reg_delay(dev, NvRegTransmitterStatus, NVREG_XMITSTAT_BUSY, 0,
 			NV_TXSTOP_DELAY1, NV_TXSTOP_DELAY1MAX,
 			KERN_INFO "nv_stop_tx: TransmitterStatus remained busy");
 
 	udelay(NV_TXSTOP_DELAY2);
-	writel(readl(base + NvRegTransmitPoll) & NVREG_TRANSMITPOLL_MAC_ADDR_REV, base + NvRegTransmitPoll);
+	if (!np->mac_in_use)
+		writel(readl(base + NvRegTransmitPoll) & NVREG_TRANSMITPOLL_MAC_ADDR_REV,
+		       base + NvRegTransmitPoll);
 }
 
 static void nv_txrx_reset(struct net_device *dev)
@@ -4148,20 +4175,6 @@ static int nv_mgmt_acquire_sema(struct net_device *dev)
 	return 0;
 }
 
-/* Indicate to mgmt unit whether driver is loaded or not */
-static void nv_mgmt_driver_loaded(struct net_device *dev, int loaded)
-{
-	u8 __iomem *base = get_hwbase(dev);
-	u32 tx_ctrl;
-
-	tx_ctrl = readl(base + NvRegTransmitterControl);
-	if (loaded)
-		tx_ctrl |= NVREG_XMITCTL_HOST_LOADED;
-	else
-		tx_ctrl &= ~NVREG_XMITCTL_HOST_LOADED;
-	writel(tx_ctrl, base + NvRegTransmitterControl);
-}
-
 static int nv_open(struct net_device *dev)
 {
 	struct fe_priv *np = netdev_priv(dev);
@@ -4659,33 +4672,24 @@ static int __devinit nv_probe(struct pci_dev *pci_dev, const struct pci_device_i
 	writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
 
 	if (id->driver_data & DEV_HAS_MGMT_UNIT) {
-		writel(0x1, base + 0x204); pci_push(base);
-		msleep(500);
 		/* management unit running on the mac? */
-		np->mac_in_use = readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_MGMT_ST;
-		if (np->mac_in_use) {
-			u32 mgmt_sync;
-			/* management unit setup the phy already? */
-			mgmt_sync = readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_SYNC_MASK;
-			if (mgmt_sync == NVREG_XMITCTL_SYNC_NOT_READY) {
-				if (!nv_mgmt_acquire_sema(dev)) {
-					for (i = 0; i < 5000; i++) {
-						msleep(1);
-						mgmt_sync = readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_SYNC_MASK;
-						if (mgmt_sync == NVREG_XMITCTL_SYNC_NOT_READY)
-							continue;
-						if (mgmt_sync == NVREG_XMITCTL_SYNC_PHY_INIT)
-							phyinitialized = 1;
-						break;
+		if (readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_SYNC_PHY_INIT) {
+			np->mac_in_use = readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_MGMT_ST;
+			dprintk(KERN_INFO "%s: mgmt unit is running. mac in use %x.\n", pci_name(pci_dev), np->mac_in_use);
+			for (i = 0; i < 5000; i++) {
+				msleep(1);
+				if (nv_mgmt_acquire_sema(dev)) {
+					/* management unit setup the phy already? */
+					if ((readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_SYNC_MASK) ==
+					    NVREG_XMITCTL_SYNC_PHY_INIT) {
+						/* phy is inited by mgmt unit */
+						phyinitialized = 1;
+						dprintk(KERN_INFO "%s: Phy already initialized by mgmt unit.\n", pci_name(pci_dev));
+					} else {
+						/* we need to init the phy */
 					}
-				} else {
-					/* we need to init the phy */
+					break;
 				}
-			} else if (mgmt_sync == NVREG_XMITCTL_SYNC_PHY_INIT) {
-				/* phy is inited by SMU */
-				phyinitialized = 1;
-			} else {
-				/* we need to init the phy */
 			}
 		}
 	}
@@ -4724,10 +4728,12 @@ static int __devinit nv_probe(struct pci_dev *pci_dev, const struct pci_device_i
 	if (!phyinitialized) {
 		/* reset it */
 		phy_init(dev);
-	}
-
-	if (id->driver_data & DEV_HAS_MGMT_UNIT) {
-		nv_mgmt_driver_loaded(dev, 1);
+	} else {
+		/* see if it is a gigabit phy */
+		u32 mii_status = mii_rw(dev, np->phyaddr, MII_BMSR, MII_READ);
+		if (mii_status & PHY_GIGABIT) {
+			np->gigabit = PHY_GIGABIT;
+		}
 	}
 
 	/* set default link speed settings */
@@ -4749,8 +4755,6 @@ static int __devinit nv_probe(struct pci_dev *pci_dev, const struct pci_device_i
 out_error:
 	if (phystate_orig)
 		writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
-	if (np->mac_in_use)
-		nv_mgmt_driver_loaded(dev, 0);
 	pci_set_drvdata(pci_dev, NULL);
 out_freering:
 	free_rings(dev);
@@ -4780,9 +4784,6 @@ static void __devexit nv_remove(struct pci_dev *pci_dev)
 	writel(np->orig_mac[0], base + NvRegMacAddrA);
 	writel(np->orig_mac[1], base + NvRegMacAddrB);
 
-	if (np->mac_in_use)
-		nv_mgmt_driver_loaded(dev, 0);
-
 	/* free all structures */
 	free_rings(dev);
 	iounmap(get_hwbase(dev));
diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
index 50ffe90..f4aba43 100644
--- a/drivers/net/ixgb/ixgb.h
+++ b/drivers/net/ixgb/ixgb.h
@@ -171,6 +171,7 @@ struct ixgb_adapter {
 
 	/* TX */
 	struct ixgb_desc_ring tx_ring ____cacheline_aligned_in_smp;
+	unsigned int restart_queue;
 	unsigned long timeo_start;
 	uint32_t tx_cmd_type;
 	uint64_t hw_csum_tx_good;
diff --git a/drivers/net/ixgb/ixgb_ethtool.c b/drivers/net/ixgb/ixgb_ethtool.c
index cd22523..82c044d 100644
--- a/drivers/net/ixgb/ixgb_ethtool.c
+++ b/drivers/net/ixgb/ixgb_ethtool.c
@@ -79,6 +79,7 @@ static struct ixgb_stats ixgb_gstrings_stats[] = {
 	{"tx_window_errors", IXGB_STAT(net_stats.tx_window_errors)},
 	{"tx_deferred_ok", IXGB_STAT(stats.dc)},
 	{"tx_timeout_count", IXGB_STAT(tx_timeout_count) },
+	{"tx_restart_queue", IXGB_STAT(restart_queue) },
 	{"rx_long_length_errors", IXGB_STAT(stats.roc)},
 	{"rx_short_length_errors", IXGB_STAT(stats.ruc)},
 #ifdef NETIF_F_TSO
diff --git a/drivers/net/ixgb/ixgb_hw.c b/drivers/net/ixgb/ixgb_hw.c
index 02089b6..ecbf458 100644
--- a/drivers/net/ixgb/ixgb_hw.c
+++ b/drivers/net/ixgb/ixgb_hw.c
@@ -399,8 +399,9 @@ ixgb_init_rx_addrs(struct ixgb_hw *hw)
 	/* Zero out the other 15 receive addresses. */
 	DEBUGOUT("Clearing RAR[1-15]\n");
 	for(i = 1; i < IXGB_RAR_ENTRIES; i++) {
-		IXGB_WRITE_REG_ARRAY(hw, RA, (i << 1), 0);
+		/* Write high reg first to disable the AV bit first */
 		IXGB_WRITE_REG_ARRAY(hw, RA, ((i << 1) + 1), 0);
+		IXGB_WRITE_REG_ARRAY(hw, RA, (i << 1), 0);
 	}
 
 	return;
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index e628126..a083a91 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -36,7 +36,7 @@ static char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-#define DRV_VERSION		"1.0.117-k2"DRIVERNAPI
+#define DRV_VERSION		"1.0.126-k2"DRIVERNAPI
 char ixgb_driver_version[] = DRV_VERSION;
 static char ixgb_copyright[] = "Copyright (c) 1999-2006 Intel Corporation.";
 
@@ -1287,6 +1287,7 @@ ixgb_tx_map(struct ixgb_adapter *adapter, struct sk_buff *skb,
 	struct ixgb_buffer *buffer_info;
 	int len = skb->len;
 	unsigned int offset = 0, size, count = 0, i;
+	unsigned int mss = skb_shinfo(skb)->gso_size;
 
 	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int f;
@@ -1298,6 +1299,11 @@ ixgb_tx_map(struct ixgb_adapter *adapter, struct sk_buff *skb,
 	while(len) {
 		buffer_info = &tx_ring->buffer_info[i];
 		size = min(len, IXGB_MAX_DATA_PER_TXD);
+		/* Workaround for premature desc write-backs
+		 * in TSO mode.  Append 4-byte sentinel desc */
+		if (unlikely(mss && !nr_frags && size == len && size > 8))
+			size -= 4;
+
 		buffer_info->length = size;
 		WARN_ON(buffer_info->dma != 0);
 		buffer_info->dma =
@@ -1324,6 +1330,13 @@ ixgb_tx_map(struct ixgb_adapter *adapter, struct sk_buff *skb,
 		while(len) {
 			buffer_info = &tx_ring->buffer_info[i];
 			size = min(len, IXGB_MAX_DATA_PER_TXD);
+
+			/* Workaround for premature desc write-backs
+			 * in TSO mode.  Append 4-byte sentinel desc */
+			if (unlikely(mss && !nr_frags && size == len
+			             && size > 8))
+				size -= 4;
+
 			buffer_info->length = size;
 			buffer_info->dma =
 				pci_map_page(adapter->pdev,
@@ -1398,11 +1411,43 @@ ixgb_tx_queue(struct ixgb_adapter *adapter, int count, int vlan_id,int tx_flags)
 	IXGB_WRITE_REG(&adapter->hw, TDT, i);
 }
 
+static int __ixgb_maybe_stop_tx(struct net_device *netdev, int size)
+{
+	struct ixgb_adapter *adapter = netdev_priv(netdev);
+	struct ixgb_desc_ring *tx_ring = &adapter->tx_ring;
+
+	netif_stop_queue(netdev);
+	/* Herbert's original patch had:
+	 *  smp_mb__after_netif_stop_queue();
+	 * but since that doesn't exist yet, just open code it. */
+	smp_mb();
+
+	/* We need to check again in a case another CPU has just
+	 * made room available. */
+	if (likely(IXGB_DESC_UNUSED(tx_ring) < size))
+		return -EBUSY;
+
+	/* A reprieve! */
+	netif_start_queue(netdev);
+	++adapter->restart_queue;
+	return 0;
+}
+
+static int ixgb_maybe_stop_tx(struct net_device *netdev,
+                              struct ixgb_desc_ring *tx_ring, int size)
+{
+	if (likely(IXGB_DESC_UNUSED(tx_ring) >= size))
+		return 0;
+	return __ixgb_maybe_stop_tx(netdev, size);
+}
+
+
 /* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S) (((S) >> IXGB_MAX_TXD_PWR) + \
 			 (((S) & (IXGB_MAX_DATA_PER_TXD - 1)) ? 1 : 0))
-#define DESC_NEEDED TXD_USE_COUNT(IXGB_MAX_DATA_PER_TXD) + \
-	MAX_SKB_FRAGS * TXD_USE_COUNT(PAGE_SIZE) + 1
+#define DESC_NEEDED TXD_USE_COUNT(IXGB_MAX_DATA_PER_TXD) /* skb->date */ + \
+	MAX_SKB_FRAGS * TXD_USE_COUNT(PAGE_SIZE) + 1 /* for context */ \
+	+ 1 /* one more needed for sentinel TSO workaround */
 
 static int
 ixgb_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
@@ -1430,7 +1475,8 @@ ixgb_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	spin_lock_irqsave(&adapter->tx_lock, flags);
 #endif
 
-	if(unlikely(IXGB_DESC_UNUSED(&adapter->tx_ring) < DESC_NEEDED)) {
+	if (unlikely(ixgb_maybe_stop_tx(netdev, &adapter->tx_ring,
+                     DESC_NEEDED))) {
 		netif_stop_queue(netdev);
 		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 		return NETDEV_TX_BUSY;
@@ -1468,8 +1514,7 @@ ixgb_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 
 #ifdef NETIF_F_LLTX
 	/* Make sure there is space in the ring for the next send. */
-	if(unlikely(IXGB_DESC_UNUSED(&adapter->tx_ring) < DESC_NEEDED))
-		netif_stop_queue(netdev);
+	ixgb_maybe_stop_tx(netdev, &adapter->tx_ring, DESC_NEEDED);
 
 	spin_unlock_irqrestore(&adapter->tx_lock, flags);
 
diff --git a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
index 2b1238e..d88e9b2 100644
--- a/drivers/net/pcmcia/pcnet_cs.c
+++ b/drivers/net/pcmcia/pcnet_cs.c
@@ -1617,6 +1617,7 @@ static struct pcmcia_device_id pcnet_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("corega K.K.", "corega FastEther PCC-TX", 0x5261440f, 0x485e85d9),
 	PCMCIA_DEVICE_PROD_ID12("Corega,K.K.", "Ethernet LAN Card", 0x110d26d9, 0x9fd2f0a2),
 	PCMCIA_DEVICE_PROD_ID12("corega,K.K.", "Ethernet LAN Card", 0x9791a90e, 0x9fd2f0a2),
+	PCMCIA_DEVICE_PROD_ID12("corega K.K.", "(CG-LAPCCTXD)", 0x5261440f, 0x73ec0d88),
 	PCMCIA_DEVICE_PROD_ID12("CouplerlessPCMCIA", "100BASE", 0xee5af0ad, 0x7c2add04),
 	PCMCIA_DEVICE_PROD_ID12("CyQ've", "ELA-010", 0x77008979, 0x9d8d445d),
 	PCMCIA_DEVICE_PROD_ID12("CyQ've", "ELA-110E 10/100M LAN Card", 0x77008979, 0xfd184814),
@@ -1667,6 +1668,7 @@ static struct pcmcia_device_id pcnet_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("Logitec", "LPM-LN100TX", 0x88fcdeda, 0x6d772737),
 	PCMCIA_DEVICE_PROD_ID12("Logitec", "LPM-LN100TE", 0x88fcdeda, 0x0e714bee),
 	PCMCIA_DEVICE_PROD_ID12("Logitec", "LPM-LN20T", 0x88fcdeda, 0x81090922),
+	PCMCIA_DEVICE_PROD_ID12("Logitec", "LPM-LN10TE", 0x88fcdeda, 0xc1e2521c),
 	PCMCIA_DEVICE_PROD_ID12("LONGSHINE", "PCMCIA Ethernet Card", 0xf866b0b0, 0x6f6652e0),
 	PCMCIA_DEVICE_PROD_ID12("MACNICA", "ME1-JEIDA", 0x20841b68, 0xaf8a3578),
 	PCMCIA_DEVICE_PROD_ID12("Macsense", "MPC-10", 0xd830297f, 0xd265c307),
diff --git a/drivers/net/qla3xxx.c b/drivers/net/qla3xxx.c
index d79d141..8844c20 100644
--- a/drivers/net/qla3xxx.c
+++ b/drivers/net/qla3xxx.c
@@ -208,6 +208,15 @@ static void ql_write_common_reg(struct ql3_adapter *qdev,
 	return;
 }
 
+static void ql_write_nvram_reg(struct ql3_adapter *qdev,
+				u32 __iomem *reg, u32 value)
+{
+	writel(value, reg);
+	readl(reg);
+	udelay(1);
+	return;
+}
+
 static void ql_write_page0_reg(struct ql3_adapter *qdev,
 			       u32 __iomem *reg, u32 value)
 {
@@ -336,9 +345,9 @@ static void fm93c56a_select(struct ql3_adapter *qdev)
 	    		qdev->mem_map_registers;
 
 	qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_1;
-	ql_write_common_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
+	ql_write_nvram_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
 			    ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
-	ql_write_common_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
+	ql_write_nvram_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
 			    ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
 }
 
@@ -355,14 +364,14 @@ static void fm93c56a_cmd(struct ql3_adapter *qdev, u32 cmd, u32 eepromAddr)
 	    		qdev->mem_map_registers;
 
 	/* Clock in a zero, then do the start bit */
-	ql_write_common_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
+	ql_write_nvram_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
 			    ISP_NVRAM_MASK | qdev->eeprom_cmd_data |
 			    AUBURN_EEPROM_DO_1);
-	ql_write_common_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
+	ql_write_nvram_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
 			    ISP_NVRAM_MASK | qdev->
 			    eeprom_cmd_data | AUBURN_EEPROM_DO_1 |
 			    AUBURN_EEPROM_CLK_RISE);
-	ql_write_common_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
+	ql_write_nvram_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
 			    ISP_NVRAM_MASK | qdev->
 			    eeprom_cmd_data | AUBURN_EEPROM_DO_1 |
 			    AUBURN_EEPROM_CLK_FALL);
@@ -378,20 +387,20 @@ static void fm93c56a_cmd(struct ql3_adapter *qdev, u32 cmd, u32 eepromAddr)
 			 * If the bit changed, then change the DO state to
 			 * match
 			 */
-			ql_write_common_reg(qdev,
+			ql_write_nvram_reg(qdev,
 					    &port_regs->CommonRegs.
 					    serialPortInterfaceReg,
 					    ISP_NVRAM_MASK | qdev->
 					    eeprom_cmd_data | dataBit);
 			previousBit = dataBit;
 		}
-		ql_write_common_reg(qdev,
+		ql_write_nvram_reg(qdev,
 				    &port_regs->CommonRegs.
 				    serialPortInterfaceReg,
 				    ISP_NVRAM_MASK | qdev->
 				    eeprom_cmd_data | dataBit |
 				    AUBURN_EEPROM_CLK_RISE);
-		ql_write_common_reg(qdev,
+		ql_write_nvram_reg(qdev,
 				    &port_regs->CommonRegs.
 				    serialPortInterfaceReg,
 				    ISP_NVRAM_MASK | qdev->
@@ -412,20 +421,20 @@ static void fm93c56a_cmd(struct ql3_adapter *qdev, u32 cmd, u32 eepromAddr)
 			 * If the bit changed, then change the DO state to
 			 * match
 			 */
-			ql_write_common_reg(qdev,
+			ql_write_nvram_reg(qdev,
 					    &port_regs->CommonRegs.
 					    serialPortInterfaceReg,
 					    ISP_NVRAM_MASK | qdev->
 					    eeprom_cmd_data | dataBit);
 			previousBit = dataBit;
 		}
-		ql_write_common_reg(qdev,
+		ql_write_nvram_reg(qdev,
 				    &port_regs->CommonRegs.
 				    serialPortInterfaceReg,
 				    ISP_NVRAM_MASK | qdev->
 				    eeprom_cmd_data | dataBit |
 				    AUBURN_EEPROM_CLK_RISE);
-		ql_write_common_reg(qdev,
+		ql_write_nvram_reg(qdev,
 				    &port_regs->CommonRegs.
 				    serialPortInterfaceReg,
 				    ISP_NVRAM_MASK | qdev->
@@ -443,7 +452,7 @@ static void fm93c56a_deselect(struct ql3_adapter *qdev)
 	struct ql3xxx_port_registers __iomem *port_regs =
 	    		qdev->mem_map_registers;
 	qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_0;
-	ql_write_common_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
+	ql_write_nvram_reg(qdev, &port_regs->CommonRegs.serialPortInterfaceReg,
 			    ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
 }
 
@@ -461,12 +470,12 @@ static void fm93c56a_datain(struct ql3_adapter *qdev, unsigned short *value)
 	/* Read the data bits */
 	/* The first bit is a dummy.  Clock right over it. */
 	for (i = 0; i < dataBits; i++) {
-		ql_write_common_reg(qdev,
+		ql_write_nvram_reg(qdev,
 				    &port_regs->CommonRegs.
 				    serialPortInterfaceReg,
 				    ISP_NVRAM_MASK | qdev->eeprom_cmd_data |
 				    AUBURN_EEPROM_CLK_RISE);
-		ql_write_common_reg(qdev,
+		ql_write_nvram_reg(qdev,
 				    &port_regs->CommonRegs.
 				    serialPortInterfaceReg,
 				    ISP_NVRAM_MASK | qdev->eeprom_cmd_data |
@@ -3370,7 +3379,6 @@ static int __devinit ql3xxx_probe(struct pci_dev *pdev,
 	SET_MODULE_OWNER(ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
-	ndev->features = NETIF_F_LLTX;
 	if (pci_using_dac)
 		ndev->features |= NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 0e94fbb..b85857a 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -2664,7 +2664,7 @@ static void __ipw2100_rx_process(struct ipw2100_priv *priv)
 				break;
 			}
 #endif
-			if (stats.len < sizeof(u->rx_data.header))
+			if (stats.len < sizeof(struct ieee80211_hdr_3addr))
 				break;
 			switch (WLAN_FC_GET_TYPE(u->rx_data.header.frame_ctl)) {
 			case IEEE80211_FTYPE_MGMT:
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 1a93fa6..5262515 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -27,10 +27,7 @@ config IUCV
 	help
 	  Select this option if you want to use inter-user communication
 	  under VM or VIF. If unsure, say "Y" to enable a fast communication
-	  link between VM guests. At boot time the user ID of the guest needs
-	  to be passed to the kernel. Note that both kernels need to be
-	  compiled with this option and both need to be booted with the user ID
-	  of the other VM guest.
+	  link between VM guests.
 
 config NETIUCV
 	tristate "IUCV network device support (VM only)"
diff --git a/drivers/s390/net/qeth.h b/drivers/s390/net/qeth.h
index 53c358c..e95c281 100644
--- a/drivers/s390/net/qeth.h
+++ b/drivers/s390/net/qeth.h
@@ -710,7 +710,7 @@ struct qeth_reply {
 	int (*callback)(struct qeth_card *,struct qeth_reply *,unsigned long);
  	u32 seqno;
 	unsigned long offset;
-	int received;
+	atomic_t received;
 	int rc;
 	void *param;
 	struct qeth_card *card;
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 2bde4f1..d2efa5f 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -471,7 +471,7 @@ qeth_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 	    channel->state == CH_STATE_UP)
 		qeth_issue_next_read(card);
 
-	tasklet_schedule(&channel->irq_tasklet);
+	qeth_irq_tasklet((unsigned long)channel);
 	return;
 out:
 	wake_up(&card->wait_q);
@@ -951,40 +951,6 @@ qeth_do_run_thread(struct qeth_card *card, unsigned long thread)
 }
 
 static int
-qeth_register_ip_addresses(void *ptr)
-{
-	struct qeth_card *card;
-
-	card = (struct qeth_card *) ptr;
-	daemonize("qeth_reg_ip");
-	QETH_DBF_TEXT(trace,4,"regipth1");
-	if (!qeth_do_run_thread(card, QETH_SET_IP_THREAD))
-		return 0;
-	QETH_DBF_TEXT(trace,4,"regipth2");
-	qeth_set_ip_addr_list(card);
-	qeth_clear_thread_running_bit(card, QETH_SET_IP_THREAD);
-	return 0;
-}
-
-/*
- * Drive the SET_PROMISC_MODE thread
- */
-static int
-qeth_set_promisc_mode(void *ptr)
-{
-	struct qeth_card *card = (struct qeth_card *) ptr;
-
-	daemonize("qeth_setprm");
-	QETH_DBF_TEXT(trace,4,"setprm1");
-	if (!qeth_do_run_thread(card, QETH_SET_PROMISC_MODE_THREAD))
-		return 0;
-	QETH_DBF_TEXT(trace,4,"setprm2");
-	qeth_setadp_promisc_mode(card);
-	qeth_clear_thread_running_bit(card, QETH_SET_PROMISC_MODE_THREAD);
-	return 0;
-}
-
-static int
 qeth_recover(void *ptr)
 {
 	struct qeth_card *card;
@@ -1047,11 +1013,6 @@ qeth_start_kernel_thread(struct work_struct *work)
 	if (card->read.state != CH_STATE_UP &&
 	    card->write.state != CH_STATE_UP)
 		return;
-
-	if (qeth_do_start_thread(card, QETH_SET_IP_THREAD))
-		kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD);
-	if (qeth_do_start_thread(card, QETH_SET_PROMISC_MODE_THREAD))
-		kernel_thread(qeth_set_promisc_mode, (void *)card, SIGCHLD);
 	if (qeth_do_start_thread(card, QETH_RECOVER_THREAD))
 		kernel_thread(qeth_recover, (void *) card, SIGCHLD);
 }
@@ -1074,7 +1035,7 @@ qeth_set_intial_options(struct qeth_card *card)
 		card->options.layer2 = 1;
 	else
 		card->options.layer2 = 0;
-	card->options.performance_stats = 1;
+	card->options.performance_stats = 0;
 }
 
 /**
@@ -1613,8 +1574,6 @@ qeth_issue_next_read(struct qeth_card *card)
 		return -ENOMEM;
 	}
 	qeth_setup_ccw(&card->read, iob->data, QETH_BUFSIZE);
-	wait_event(card->wait_q,
-		   atomic_cmpxchg(&card->read.irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(trace, 6, "noirqpnd");
 	rc = ccw_device_start(card->read.ccwdev, &card->read.ccw,
 			      (addr_t) iob, 0, 0);
@@ -1635,6 +1594,7 @@ qeth_alloc_reply(struct qeth_card *card)
 	reply = kzalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
 	if (reply){
 		atomic_set(&reply->refcnt, 1);
+		atomic_set(&reply->received, 0);
 		reply->card = card;
 	};
 	return reply;
@@ -1655,31 +1615,6 @@ qeth_put_reply(struct qeth_reply *reply)
 		kfree(reply);
 }
 
-static void
-qeth_cmd_timeout(unsigned long data)
-{
-	struct qeth_reply *reply, *list_reply, *r;
-	unsigned long flags;
-
-	reply = (struct qeth_reply *) data;
-	spin_lock_irqsave(&reply->card->lock, flags);
-	list_for_each_entry_safe(list_reply, r,
-				 &reply->card->cmd_waiter_list, list) {
-		if (reply == list_reply){
-			qeth_get_reply(reply);
-			list_del_init(&reply->list);
-			spin_unlock_irqrestore(&reply->card->lock, flags);
-			reply->rc = -ETIME;
-			reply->received = 1;
-			wake_up(&reply->wait_q);
-			qeth_put_reply(reply);
-			return;
-		}
-	}
-	spin_unlock_irqrestore(&reply->card->lock, flags);
-}
-
-
 static struct qeth_ipa_cmd *
 qeth_check_ipa_data(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
@@ -1745,7 +1680,7 @@ qeth_clear_ipacmd_list(struct qeth_card *card)
 	list_for_each_entry_safe(reply, r, &card->cmd_waiter_list, list) {
 		qeth_get_reply(reply);
 		reply->rc = -EIO;
-		reply->received = 1;
+		atomic_inc(&reply->received);
 		list_del_init(&reply->list);
 		wake_up(&reply->wait_q);
 		qeth_put_reply(reply);
@@ -1814,7 +1749,7 @@ qeth_send_control_data_cb(struct qeth_channel *channel,
 					      &card->cmd_waiter_list);
 				spin_unlock_irqrestore(&card->lock, flags);
 			} else {
-				reply->received = 1;
+				atomic_inc(&reply->received);
 				wake_up(&reply->wait_q);
 			}
 			qeth_put_reply(reply);
@@ -1858,7 +1793,7 @@ qeth_send_control_data(struct qeth_card *card, int len,
 	int rc;
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
-	struct timer_list timer;
+	unsigned long timeout;
 
 	QETH_DBF_TEXT(trace, 2, "sendctl");
 
@@ -1873,21 +1808,20 @@ qeth_send_control_data(struct qeth_card *card, int len,
 		reply->seqno = QETH_IDX_COMMAND_SEQNO;
 	else
 		reply->seqno = card->seqno.ipa++;
-	init_timer(&timer);
-	timer.function = qeth_cmd_timeout;
-	timer.data = (unsigned long) reply;
 	init_waitqueue_head(&reply->wait_q);
 	spin_lock_irqsave(&card->lock, flags);
 	list_add_tail(&reply->list, &card->cmd_waiter_list);
 	spin_unlock_irqrestore(&card->lock, flags);
 	QETH_DBF_HEX(control, 2, iob->data, QETH_DBF_CONTROL_LEN);
-	wait_event(card->wait_q,
-		   atomic_cmpxchg(&card->write.irq_pending, 0, 1) == 0);
+
+	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
 	qeth_prepare_control_data(card, len, iob);
+
 	if (IS_IPA(iob->data))
-		timer.expires = jiffies + QETH_IPA_TIMEOUT;
+		timeout = jiffies + QETH_IPA_TIMEOUT;
 	else
-		timer.expires = jiffies + QETH_TIMEOUT;
+		timeout = jiffies + QETH_TIMEOUT;
+
 	QETH_DBF_TEXT(trace, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
 	rc = ccw_device_start(card->write.ccwdev, &card->write.ccw,
@@ -1906,9 +1840,16 @@ qeth_send_control_data(struct qeth_card *card, int len,
 		wake_up(&card->wait_q);
 		return rc;
 	}
-	add_timer(&timer);
-	wait_event(reply->wait_q, reply->received);
-	del_timer_sync(&timer);
+	while (!atomic_read(&reply->received)) {
+		if (time_after(jiffies, timeout)) {
+			spin_lock_irqsave(&reply->card->lock, flags);
+			list_del_init(&reply->list);
+			spin_unlock_irqrestore(&reply->card->lock, flags);
+			reply->rc = -ETIME;
+			atomic_inc(&reply->received);
+			wake_up(&reply->wait_q);
+		}
+	};
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
@@ -2466,32 +2407,17 @@ qeth_rebuild_skb_fake_ll(struct qeth_card *card, struct sk_buff *skb,
 		qeth_rebuild_skb_fake_ll_eth(card, skb, hdr);
 }
 
-static inline __u16
+static inline void
 qeth_layer2_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_hdr *hdr)
 {
-	unsigned short vlan_id = 0;
-#ifdef CONFIG_QETH_VLAN
-	struct vlan_hdr *vhdr;
-#endif
-
 	skb->pkt_type = PACKET_HOST;
 	skb->protocol = qeth_type_trans(skb, skb->dev);
 	if (card->options.checksum_type == NO_CHECKSUMMING)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
 		skb->ip_summed = CHECKSUM_NONE;
-#ifdef CONFIG_QETH_VLAN
-	if (hdr->hdr.l2.flags[2] & (QETH_LAYER2_FLAG_VLAN)) {
-		vhdr = (struct vlan_hdr *) skb->data;
-		skb->protocol =
-			__constant_htons(vhdr->h_vlan_encapsulated_proto);
-		vlan_id = hdr->hdr.l2.vlan_id;
-		skb_pull(skb, VLAN_HLEN);
-	}
-#endif
 	*((__u32 *)skb->cb) = ++card->seqno.pkt_seqno;
-	return vlan_id;
 }
 
 static inline __u16
@@ -2560,7 +2486,6 @@ qeth_process_inbound_buffer(struct qeth_card *card,
 	int offset;
 	int rxrc;
 	__u16 vlan_tag = 0;
-	__u16 *vlan_addr;
 
 	/* get first element of current buffer */
 	element = (struct qdio_buffer_element *)&buf->buffer->element[0];
@@ -2571,7 +2496,7 @@ qeth_process_inbound_buffer(struct qeth_card *card,
 				       &offset, &hdr))) {
 		skb->dev = card->dev;
 		if (hdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2)
-			vlan_tag = qeth_layer2_rebuild_skb(card, skb, hdr);
+			qeth_layer2_rebuild_skb(card, skb, hdr);
 		else if (hdr->hdr.l3.id == QETH_HEADER_TYPE_LAYER3)
 			vlan_tag = qeth_rebuild_skb(card, skb, hdr);
 		else { /*in case of OSN*/
@@ -3968,13 +3893,22 @@ static inline struct sk_buff *
 qeth_prepare_skb(struct qeth_card *card, struct sk_buff *skb,
 		 struct qeth_hdr **hdr, int ipv)
 {
-	struct sk_buff *new_skb;
+	struct sk_buff *new_skb, *new_skb2;
 	
 	QETH_DBF_TEXT(trace, 6, "prepskb");
-
-        new_skb = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
-       	if (new_skb == NULL)
+	new_skb = skb;
+	new_skb = qeth_pskb_unshare(skb, GFP_ATOMIC);
+	if (!new_skb)
+		return NULL;
+	new_skb2 = qeth_realloc_headroom(card, new_skb,
+					 sizeof(struct qeth_hdr));
+	if (!new_skb2) {
+		__qeth_free_new_skb(skb, new_skb);
 		return NULL;
+	}
+	if (new_skb != skb)
+		__qeth_free_new_skb(new_skb2, new_skb);
+	new_skb = new_skb2;
 	*hdr = __qeth_prepare_skb(card, new_skb, ipv);
 	if (*hdr == NULL) {
 		__qeth_free_new_skb(skb, new_skb);
@@ -4844,9 +4778,11 @@ qeth_arp_query(struct qeth_card *card, char __user *udata)
 			   "(0x%x/%d)\n",
 			   QETH_CARD_IFNAME(card), qeth_arp_get_error_cause(&rc),
 			   tmp, tmp);
-		copy_to_user(udata, qinfo.udata, 4);
+		if (copy_to_user(udata, qinfo.udata, 4))
+			rc = -EFAULT;
 	} else {
-		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
+		if (copy_to_user(udata, qinfo.udata, qinfo.udata_len))
+			rc = -EFAULT;
 	}
 	kfree(qinfo.udata);
 	return rc;
@@ -4992,8 +4928,10 @@ qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	if (rc)
 		PRINT_WARN("SNMP command failed on %s: (0x%x)\n",
 			   QETH_CARD_IFNAME(card), rc);
-	 else
-		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
+	else {
+		if (copy_to_user(udata, qinfo.udata, qinfo.udata_len))
+			rc = -EFAULT;
+	}
 
 	kfree(ureq);
 	kfree(qinfo.udata);
@@ -5544,12 +5482,10 @@ qeth_set_multicast_list(struct net_device *dev)
 	qeth_add_multicast_ipv6(card);
 #endif
 out:
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 	if (!qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
 		return;
-	if (qeth_set_thread_start_bit(card, QETH_SET_PROMISC_MODE_THREAD)==0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_setadp_promisc_mode(card);
 }
 
 static int
@@ -6351,6 +6287,42 @@ static struct ethtool_ops qeth_ethtool_ops = {
 };
 
 static int
+qeth_hard_header_parse(struct sk_buff *skb, unsigned char *haddr)
+{
+	struct qeth_card *card;
+	struct ethhdr *eth;
+
+	card = qeth_get_card_from_dev(skb->dev);
+	if (card->options.layer2)
+		goto haveheader;
+#ifdef CONFIG_QETH_IPV6
+	/* cause of the manipulated arp constructor and the ARP
+	   flag for OSAE devices we have some nasty exceptions */
+	if (card->info.type == QETH_CARD_TYPE_OSAE) {
+		if (!card->options.fake_ll) {
+			if ((skb->pkt_type==PACKET_OUTGOING) &&
+			    (skb->protocol==ETH_P_IPV6))
+				goto haveheader;
+			else
+				return 0;
+		} else {
+			if ((skb->pkt_type==PACKET_OUTGOING) &&
+			    (skb->protocol==ETH_P_IP))
+				return 0;
+			else
+				goto haveheader;
+		}
+	}
+#endif
+	if (!card->options.fake_ll)
+		return 0;
+haveheader:
+	eth = eth_hdr(skb);
+	memcpy(haddr, eth->h_source, ETH_ALEN);
+	return ETH_ALEN;
+}
+
+static int
 qeth_netdev_init(struct net_device *dev)
 {
 	struct qeth_card *card;
@@ -6388,7 +6360,10 @@ qeth_netdev_init(struct net_device *dev)
 	if (card->options.fake_ll &&
 		(qeth_get_netdev_flags(card) & IFF_NOARP))
 			dev->hard_header = qeth_fake_header;
-	dev->hard_header_parse = NULL;
+	if (dev->type == ARPHRD_IEEE802_TR)
+		dev->hard_header_parse = NULL;
+	else
+		dev->hard_header_parse = qeth_hard_header_parse;
 	dev->set_mac_address = qeth_layer2_set_mac_address;
 	dev->flags |= qeth_get_netdev_flags(card);
 	if ((card->options.fake_broadcast) ||
@@ -8235,8 +8210,7 @@ qeth_add_vipa(struct qeth_card *card, enum qeth_prot_versions proto,
 	}
 	if (!qeth_add_ip(card, ipaddr))
 		kfree(ipaddr);
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 	return rc;
 }
 
@@ -8264,8 +8238,7 @@ qeth_del_vipa(struct qeth_card *card, enum qeth_prot_versions proto,
 		return;
 	if (!qeth_delete_ip(card, ipaddr))
 		kfree(ipaddr);
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 }
 
 /*
@@ -8308,8 +8281,7 @@ qeth_add_rxip(struct qeth_card *card, enum qeth_prot_versions proto,
 	}
 	if (!qeth_add_ip(card, ipaddr))
 		kfree(ipaddr);
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 	return 0;
 }
 
@@ -8337,8 +8309,7 @@ qeth_del_rxip(struct qeth_card *card, enum qeth_prot_versions proto,
 		return;
 	if (!qeth_delete_ip(card, ipaddr))
 		kfree(ipaddr);
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 }
 
 /**
@@ -8380,8 +8351,7 @@ qeth_ip_event(struct notifier_block *this,
 	default:
 		break;
 	}
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 out:
 	return NOTIFY_DONE;
 }
@@ -8433,8 +8403,7 @@ qeth_ip6_event(struct notifier_block *this,
 	default:
 		break;
 	}
- 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_ip_addr_list(card);
 out:
 	return NOTIFY_DONE;
 }
diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
index e6af381..e02d85f 100644
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -218,7 +218,7 @@ struct ieee80211_snap_hdr {
 #define WLAN_FC_GET_STYPE(fc) ((fc) & IEEE80211_FCTL_STYPE)
 
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & IEEE80211_SCTL_FRAG)
-#define WLAN_GET_SEQ_SEQ(seq)  ((seq) & IEEE80211_SCTL_SEQ)
+#define WLAN_GET_SEQ_SEQ(seq)  (((seq) & IEEE80211_SCTL_SEQ) >> 4)
 
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
