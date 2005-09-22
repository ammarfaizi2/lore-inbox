Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVIVELO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVIVELO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVIVELO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:11:14 -0400
Received: from havoc.gtf.org ([69.61.125.42]:60897 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751432AbVIVELN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:11:13 -0400
Date: Thu, 22 Sep 2005 00:11:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20050922041109.GA6428@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the following fixes:


 drivers/net/bonding/bond_main.c |    3 
 drivers/net/r8169.c             |    4 
 drivers/net/skge.c              |  194 ++++++++++++++++++----------------------
 drivers/net/skge.h              |    2 
 4 files changed, 97 insertions(+), 106 deletions(-)


nsxfreddy@gmail.com:
  bonding: Fix link monitor capability check (was skge: set mac address oops with bonding)

Stephen Hemminger:
  skge: expand ethtool debug register dump
  skge: check length from PHY

Tommy Christensen:
  r8169: call proper VLAN receive function


diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1653,7 +1653,8 @@ static int bond_enslave(struct net_devic
 	int old_features = bond_dev->features;
 	int res = 0;
 
-	if (slave_dev->do_ioctl == NULL) {
+	if (!bond->params.use_carrier && slave_dev->ethtool_ops == NULL &&
+		slave_dev->do_ioctl == NULL) {
 		printk(KERN_WARNING DRV_NAME
 		       ": Warning : no link monitoring support for %s\n",
 		       slave_dev->name);
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -100,11 +100,11 @@ VERSION 2.2LK	<2005/01/25>
 
 #ifdef CONFIG_R8169_NAPI
 #define rtl8169_rx_skb			netif_receive_skb
-#define rtl8169_rx_hwaccel_skb		vlan_hwaccel_rx
+#define rtl8169_rx_hwaccel_skb		vlan_hwaccel_receive_skb
 #define rtl8169_rx_quota(count, quota)	min(count, quota)
 #else
 #define rtl8169_rx_skb			netif_rx
-#define rtl8169_rx_hwaccel_skb		vlan_hwaccel_receive_skb
+#define rtl8169_rx_hwaccel_skb		vlan_hwaccel_rx
 #define rtl8169_rx_quota(count, quota)	count
 #endif
 
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -42,7 +42,7 @@
 #include "skge.h"
 
 #define DRV_NAME		"skge"
-#define DRV_VERSION		"1.0"
+#define DRV_VERSION		"1.1"
 #define PFX			DRV_NAME " "
 
 #define DEFAULT_TX_RING_SIZE	128
@@ -105,41 +105,28 @@ static const u32 rxirqmask[] = { IS_R1_F
 static const u32 txirqmask[] = { IS_XA1_F, IS_XA2_F };
 static const u32 portirqmask[] = { IS_PORT_1, IS_PORT_2 };
 
-/* Don't need to look at whole 16K.
- * last interesting register is descriptor poll timer.
- */
-#define SKGE_REGS_LEN	(29*128)
-
 static int skge_get_regs_len(struct net_device *dev)
 {
-	return SKGE_REGS_LEN;
+	return 0x4000;
 }
 
 /*
- * Returns copy of control register region
- * I/O region is divided into banks and certain regions are unreadable
+ * Returns copy of whole control register region
+ * Note: skip RAM address register because accessing it will
+ * 	 cause bus hangs!
  */
 static void skge_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 			  void *p)
 {
 	const struct skge_port *skge = netdev_priv(dev);
-	unsigned long offs;
 	const void __iomem *io = skge->hw->regs;
-	static const unsigned long bankmap
-		= (1<<0) | (1<<2) | (1<<8) | (1<<9)
-		  | (1<<12) | (1<<13) | (1<<14) | (1<<15) | (1<<16)
-		  | (1<<17) | (1<<20) | (1<<21) | (1<<22) | (1<<23)
-		  | (1<<24)  | (1<<25) | (1<<26) | (1<<27) | (1<<28);
 
 	regs->version = 1;
-	for (offs = 0; offs < regs->len; offs += 128) {
-		u32 len = min_t(u32, 128, regs->len - offs);
+	memset(p, 0, regs->len);
+	memcpy_fromio(p, io, B3_RAM_ADDR);
 
-		if (bankmap & (1<<(offs/128)))
-			memcpy_fromio(p + offs, io + offs, len);
-		else
-			memset(p + offs, 0, len);
-	}
+	memcpy_fromio(p + B3_RI_WTO_R1, io + B3_RI_WTO_R1,
+		      regs->len - B3_RI_WTO_R1);
 }
 
 /* Wake on Lan only supported on Yukon chps with rev 1 or above */
@@ -775,17 +762,6 @@ static int skge_ring_alloc(struct skge_r
 	return 0;
 }
 
-static struct sk_buff *skge_rx_alloc(struct net_device *dev, unsigned int size)
-{
-	struct sk_buff *skb = dev_alloc_skb(size);
-
-	if (likely(skb)) {
-		skb->dev = dev;
-		skb_reserve(skb, NET_IP_ALIGN);
-	}
-	return skb;
-}
-
 /* Allocate and setup a new buffer for receiving */
 static void skge_rx_setup(struct skge_port *skge, struct skge_element *e,
 			  struct sk_buff *skb, unsigned int bufsize)
@@ -858,16 +834,17 @@ static int skge_rx_fill(struct skge_port
 {
 	struct skge_ring *ring = &skge->rx_ring;
 	struct skge_element *e;
-	unsigned int bufsize = skge->rx_buf_size;
 
 	e = ring->start;
 	do {
-		struct sk_buff *skb = skge_rx_alloc(skge->netdev, bufsize);
+		struct sk_buff *skb;
 
+		skb = dev_alloc_skb(skge->rx_buf_size + NET_IP_ALIGN);
 		if (!skb)
 			return -ENOMEM;
 
-		skge_rx_setup(skge, e, skb, bufsize);
+		skb_reserve(skb, NET_IP_ALIGN);
+		skge_rx_setup(skge, e, skb, skge->rx_buf_size);
 	} while ( (e = e->next) != ring->start);
 
 	ring->to_clean = ring->start;
@@ -2442,6 +2419,14 @@ static void yukon_set_multicast(struct n
 	gma_write16(hw, port, GM_RX_CTRL, reg);
 }
 
+static inline u16 phy_length(const struct skge_hw *hw, u32 status)
+{
+	if (hw->chip_id == CHIP_ID_GENESIS)
+		return status >> XMR_FS_LEN_SHIFT;
+	else
+		return status >> GMR_FS_LEN_SHIFT;
+}
+
 static inline int bad_phy_status(const struct skge_hw *hw, u32 status)
 {
 	if (hw->chip_id == CHIP_ID_GENESIS)
@@ -2451,80 +2436,99 @@ static inline int bad_phy_status(const s
 			(status & GMR_FS_RX_OK) == 0;
 }
 
-static void skge_rx_error(struct skge_port *skge, int slot,
-			  u32 control, u32 status)
-{
-	if (netif_msg_rx_err(skge))
-		printk(KERN_DEBUG PFX "%s: rx err, slot %d control 0x%x status 0x%x\n",
-		       skge->netdev->name, slot, control, status);
-
-	if ((control & (BMU_EOF|BMU_STF)) != (BMU_STF|BMU_EOF))
-		skge->net_stats.rx_length_errors++;
-	else if (skge->hw->chip_id == CHIP_ID_GENESIS) {
-		if (status & (XMR_FS_RUNT|XMR_FS_LNG_ERR))
-			skge->net_stats.rx_length_errors++;
-		if (status & XMR_FS_FRA_ERR)
-			skge->net_stats.rx_frame_errors++;
-		if (status & XMR_FS_FCS_ERR)
-			skge->net_stats.rx_crc_errors++;
-	} else {
-		if (status & (GMR_FS_LONG_ERR|GMR_FS_UN_SIZE))
-			skge->net_stats.rx_length_errors++;
-		if (status & GMR_FS_FRAGMENT)
-			skge->net_stats.rx_frame_errors++;
-		if (status & GMR_FS_CRC_ERR)
-			skge->net_stats.rx_crc_errors++;
-	}
-}
 
 /* Get receive buffer from descriptor.
  * Handles copy of small buffers and reallocation failures
  */
 static inline struct sk_buff *skge_rx_get(struct skge_port *skge,
 					  struct skge_element *e,
-					  unsigned int len)
+					  u32 control, u32 status, u16 csum)
 {
-	struct sk_buff *nskb, *skb;
+	struct sk_buff *skb;
+	u16 len = control & BMU_BBC;
+
+	if (unlikely(netif_msg_rx_status(skge)))
+		printk(KERN_DEBUG PFX "%s: rx slot %td status 0x%x len %d\n",
+		       skge->netdev->name, e - skge->rx_ring.start,
+		       status, len);
+
+	if (len > skge->rx_buf_size)
+		goto error;
+
+	if ((control & (BMU_EOF|BMU_STF)) != (BMU_STF|BMU_EOF))
+		goto error;
+
+	if (bad_phy_status(skge->hw, status))
+		goto error;
+
+	if (phy_length(skge->hw, status) != len)
+		goto error;
 
 	if (len < RX_COPY_THRESHOLD) {
-		nskb = skge_rx_alloc(skge->netdev, len + NET_IP_ALIGN);
-		if (unlikely(!nskb))
-			return NULL;
+		skb = dev_alloc_skb(len + 2);
+		if (!skb)
+			goto resubmit;
 
+		skb_reserve(skb, 2);
 		pci_dma_sync_single_for_cpu(skge->hw->pdev,
 					    pci_unmap_addr(e, mapaddr),
 					    len, PCI_DMA_FROMDEVICE);
-		memcpy(nskb->data, e->skb->data, len);
+		memcpy(skb->data, e->skb->data, len);
 		pci_dma_sync_single_for_device(skge->hw->pdev,
 					       pci_unmap_addr(e, mapaddr),
 					       len, PCI_DMA_FROMDEVICE);
-
-		if (skge->rx_csum) {
-			struct skge_rx_desc *rd = e->desc;
-			nskb->csum = le16_to_cpu(rd->csum2);
-			nskb->ip_summed = CHECKSUM_HW;
-		}
 		skge_rx_reuse(e, skge->rx_buf_size);
-		return nskb;
 	} else {
-		nskb = skge_rx_alloc(skge->netdev, skge->rx_buf_size);
-		if (unlikely(!nskb))
-			return NULL;
+		struct sk_buff *nskb;
+		nskb = dev_alloc_skb(skge->rx_buf_size + NET_IP_ALIGN);
+		if (!nskb)
+			goto resubmit;
 
 		pci_unmap_single(skge->hw->pdev,
 				 pci_unmap_addr(e, mapaddr),
 				 pci_unmap_len(e, maplen),
 				 PCI_DMA_FROMDEVICE);
 		skb = e->skb;
-		if (skge->rx_csum) {
-			struct skge_rx_desc *rd = e->desc;
-			skb->csum = le16_to_cpu(rd->csum2);
-			skb->ip_summed = CHECKSUM_HW;
-		}
-
+  		prefetch(skb->data);
 		skge_rx_setup(skge, e, nskb, skge->rx_buf_size);
-		return skb;
 	}
+
+	skb_put(skb, len);
+	skb->dev = skge->netdev;
+	if (skge->rx_csum) {
+		skb->csum = csum;
+		skb->ip_summed = CHECKSUM_HW;
+	}
+
+	skb->protocol = eth_type_trans(skb, skge->netdev);
+
+	return skb;
+error:
+
+	if (netif_msg_rx_err(skge))
+		printk(KERN_DEBUG PFX "%s: rx err, slot %td control 0x%x status 0x%x\n",
+		       skge->netdev->name, e - skge->rx_ring.start,
+		       control, status);
+
+	if (skge->hw->chip_id == CHIP_ID_GENESIS) {
+		if (status & (XMR_FS_RUNT|XMR_FS_LNG_ERR))
+			skge->net_stats.rx_length_errors++;
+		if (status & XMR_FS_FRA_ERR)
+			skge->net_stats.rx_frame_errors++;
+		if (status & XMR_FS_FCS_ERR)
+			skge->net_stats.rx_crc_errors++;
+	} else {
+		if (status & (GMR_FS_LONG_ERR|GMR_FS_UN_SIZE))
+			skge->net_stats.rx_length_errors++;
+		if (status & GMR_FS_FRAGMENT)
+			skge->net_stats.rx_frame_errors++;
+		if (status & GMR_FS_CRC_ERR)
+			skge->net_stats.rx_crc_errors++;
+	}
+
+resubmit:
+	skge_rx_reuse(e, skge->rx_buf_size);
+	return NULL;
 }
 
 
@@ -2540,32 +2544,16 @@ static int skge_poll(struct net_device *
 	for (e = ring->to_clean; work_done < to_do; e = e->next) {
 		struct skge_rx_desc *rd = e->desc;
 		struct sk_buff *skb;
-		u32 control, len, status;
+		u32 control;
 
 		rmb();
 		control = rd->control;
 		if (control & BMU_OWN)
 			break;
 
-		len = control & BMU_BBC;
-		status = rd->status;
-
-		if (unlikely((control & (BMU_EOF|BMU_STF)) != (BMU_STF|BMU_EOF)
-			     || bad_phy_status(hw, status))) {
-			skge_rx_error(skge, e - ring->start, control, status);
-			skge_rx_reuse(e, skge->rx_buf_size);
-			continue;
-		}
-
-		if (netif_msg_rx_status(skge))
-		    printk(KERN_DEBUG PFX "%s: rx slot %td status 0x%x len %d\n",
-			   dev->name, e - ring->start, rd->status, len);
-
-		skb = skge_rx_get(skge, e, len);
+ 		skb = skge_rx_get(skge, e, control, rd->status,
+ 				  le16_to_cpu(rd->csum2));
 		if (likely(skb)) {
-			skb_put(skb, len);
-			skb->protocol = eth_type_trans(skb, dev);
-
 			dev->last_rx = jiffies;
 			netif_receive_skb(skb);
 
diff --git a/drivers/net/skge.h b/drivers/net/skge.h
--- a/drivers/net/skge.h
+++ b/drivers/net/skge.h
@@ -953,6 +953,7 @@ enum {
  */
 enum {
 	XMR_FS_LEN	= 0x3fff<<18,	/* Bit 31..18:	Rx Frame Length */
+	XMR_FS_LEN_SHIFT = 18,
 	XMR_FS_2L_VLAN	= 1<<17, /* Bit 17:	tagged wh 2Lev VLAN ID*/
 	XMR_FS_1_VLAN	= 1<<16, /* Bit 16:	tagged wh 1ev VLAN ID*/
 	XMR_FS_BC	= 1<<15, /* Bit 15:	Broadcast Frame */
@@ -1868,6 +1869,7 @@ enum {
 /* Receive Frame Status Encoding */
 enum {
 	GMR_FS_LEN	= 0xffff<<16, /* Bit 31..16:	Rx Frame Length */
+	GMR_FS_LEN_SHIFT = 16,
 	GMR_FS_VLAN	= 1<<13, /* Bit 13:	VLAN Packet */
 	GMR_FS_JABBER	= 1<<12, /* Bit 12:	Jabber Packet */
 	GMR_FS_UN_SIZE	= 1<<11, /* Bit 11:	Undersize Packet */
