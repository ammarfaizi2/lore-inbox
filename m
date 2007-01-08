Return-Path: <linux-kernel-owner+w=401wt.eu-S965308AbXAHJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbXAHJsH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbXAHJsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:48:06 -0500
Received: from havoc.gtf.org ([69.61.125.42]:36557 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965304AbXAHJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:48:01 -0500
Date: Mon, 8 Jan 2007 04:47:59 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20070108094759.GA16681@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/e1000/e1000_main.c  |    6 ----
 drivers/net/ixgb/ixgb.h         |    1 +
 drivers/net/ixgb/ixgb_ethtool.c |    1 +
 drivers/net/ixgb/ixgb_hw.c      |    3 +-
 drivers/net/ixgb/ixgb_main.c    |   57 ++++++++++++++++++++++++++++++++++----
 drivers/net/qla3xxx.c           |   38 +++++++++++++++----------
 drivers/net/wireless/ipw2100.c  |    2 +-
 drivers/s390/net/qeth_main.c    |   13 +++++---
 include/net/ieee80211.h         |    2 +-
 9 files changed, 88 insertions(+), 35 deletions(-)

Aaron Salter (1):
      ixgb: Write RA register high word first, increment version

Heiko Carstens (1):
      qeth: fix uaccess handling and get rid of unused variable

Jeff Garzik (1):
      Revert "e1000: disable TSO on the 82544 with slab debugging"

Jesse Brandeburg (2):
      ixgb: Fix early TSO completion
      ixgb: Maybe stop TX if not enough free descriptors

Ron Mercer (2):
      qla3xxx: Remove NETIF_F_LLTX from driver features.
      qla3xxx: Add delay to NVRAM register access.

Zhu Yi (2):
      ieee80211: WLAN_GET_SEQ_SEQ fix (select correct region)
      ipw2100: Fix dropping fragmented small packet problem

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
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 2bde4f1..f17d7cf 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -2560,7 +2560,6 @@ qeth_process_inbound_buffer(struct qeth_card *card,
 	int offset;
 	int rxrc;
 	__u16 vlan_tag = 0;
-	__u16 *vlan_addr;
 
 	/* get first element of current buffer */
 	element = (struct qdio_buffer_element *)&buf->buffer->element[0];
@@ -4844,9 +4843,11 @@ qeth_arp_query(struct qeth_card *card, char __user *udata)
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
@@ -4992,8 +4993,10 @@ qeth_snmp_command(struct qeth_card *card, char __user *udata)
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
