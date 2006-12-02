Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162784AbWLBEiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162784AbWLBEiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162782AbWLBEix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:38:53 -0500
Received: from havoc.gtf.org ([69.61.125.42]:52632 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1162777AbWLBEis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:38:48 -0500
Date: Fri, 1 Dec 2006 23:38:47 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061202043846.GA15624@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/Kconfig                           |    4 +-
 drivers/net/bonding/bond_main.c               |   63 ++++++++++++++-----------
 drivers/net/cs89x0.c                          |    4 +-
 drivers/net/spider_net.c                      |   20 ++------
 drivers/net/spider_net.h                      |    8 ++-
 drivers/net/wireless/zd1211rw/zd_ieee80211.h  |    2 -
 drivers/net/wireless/zd1211rw/zd_mac.c        |    2 -
 drivers/net/wireless/zd1211rw/zd_mac.h        |    4 +-
 drivers/net/wireless/zd1211rw/zd_usb.c        |   26 +++++-----
 drivers/net/wireless/zd1211rw/zd_usb.h        |   14 +++---
 net/ieee80211/ieee80211_tx.c                  |    4 +-
 net/ieee80211/softmac/ieee80211softmac_scan.c |    2 -
 12 files changed, 76 insertions(+), 77 deletions(-)

George G. Davis:
      Fix an offset error when reading the CS89x0 ADD_PORT register

James K Lewis:
      Spidernet: remove ETH_ZLEN check in earlier patch

John W. Linville:
      Revert "zd1211rw: Removed unneeded packed attributes"

Laurent Riffard:
      bonding: fix an oops when slave device does not provide get_stats

Linas Vepstas:
      spidernet: poor network performance

Michael Buesch:
      softmac: remove netif_tx_disable when scanning

Ralf Baechle:
      drivers/net: SAA9730: Fix build error

Ulrich Kunitz:
      zd1211rw: Fix of a locking bug

Zhu Yi:
      ieee80211: Fix kernel panic when QoS is enabled

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6e863aa..30ae712 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1769,8 +1769,8 @@ config VIA_RHINE_NAPI
 	  information.
 
 config LAN_SAA9730
-	bool "Philips SAA9730 Ethernet support (EXPERIMENTAL)"
-	depends on NET_PCI && EXPERIMENTAL && MIPS
+	bool "Philips SAA9730 Ethernet support"
+	depends on NET_PCI && PCI && MIPS_ATLAS
 	help
 	  The SAA9730 is a combined multimedia and peripheral controller used
 	  in thin clients, Internet access terminals, and diskless
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17a4611..488d8ed 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1336,6 +1336,13 @@ int bond_enslave(struct net_device *bond
 		goto err_undo_flags;
 	}
 
+	if (slave_dev->get_stats == NULL) {
+		printk(KERN_NOTICE DRV_NAME
+			": %s: the driver for slave device %s does not provide "
+			"get_stats function, network statistics will be "
+			"inaccurate.\n", bond_dev->name, slave_dev->name);
+	}
+
 	new_slave = kmalloc(sizeof(struct slave), GFP_KERNEL);
 	if (!new_slave) {
 		res = -ENOMEM;
@@ -3605,33 +3612,35 @@ static struct net_device_stats *bond_get
 	read_lock_bh(&bond->lock);
 
 	bond_for_each_slave(bond, slave, i) {
-		sstats = slave->dev->get_stats(slave->dev);
-
-		stats->rx_packets += sstats->rx_packets;
-		stats->rx_bytes += sstats->rx_bytes;
-		stats->rx_errors += sstats->rx_errors;
-		stats->rx_dropped += sstats->rx_dropped;
-
-		stats->tx_packets += sstats->tx_packets;
-		stats->tx_bytes += sstats->tx_bytes;
-		stats->tx_errors += sstats->tx_errors;
-		stats->tx_dropped += sstats->tx_dropped;
-
-		stats->multicast += sstats->multicast;
-		stats->collisions += sstats->collisions;
-
-		stats->rx_length_errors += sstats->rx_length_errors;
-		stats->rx_over_errors += sstats->rx_over_errors;
-		stats->rx_crc_errors += sstats->rx_crc_errors;
-		stats->rx_frame_errors += sstats->rx_frame_errors;
-		stats->rx_fifo_errors += sstats->rx_fifo_errors;
-		stats->rx_missed_errors += sstats->rx_missed_errors;
-
-		stats->tx_aborted_errors += sstats->tx_aborted_errors;
-		stats->tx_carrier_errors += sstats->tx_carrier_errors;
-		stats->tx_fifo_errors += sstats->tx_fifo_errors;
-		stats->tx_heartbeat_errors += sstats->tx_heartbeat_errors;
-		stats->tx_window_errors += sstats->tx_window_errors;
+		if (slave->dev->get_stats) {
+			sstats = slave->dev->get_stats(slave->dev);
+
+			stats->rx_packets += sstats->rx_packets;
+			stats->rx_bytes += sstats->rx_bytes;
+			stats->rx_errors += sstats->rx_errors;
+			stats->rx_dropped += sstats->rx_dropped;
+
+			stats->tx_packets += sstats->tx_packets;
+			stats->tx_bytes += sstats->tx_bytes;
+			stats->tx_errors += sstats->tx_errors;
+			stats->tx_dropped += sstats->tx_dropped;
+
+			stats->multicast += sstats->multicast;
+			stats->collisions += sstats->collisions;
+
+			stats->rx_length_errors += sstats->rx_length_errors;
+			stats->rx_over_errors += sstats->rx_over_errors;
+			stats->rx_crc_errors += sstats->rx_crc_errors;
+			stats->rx_frame_errors += sstats->rx_frame_errors;
+			stats->rx_fifo_errors += sstats->rx_fifo_errors;
+			stats->rx_missed_errors += sstats->rx_missed_errors;
+
+			stats->tx_aborted_errors += sstats->tx_aborted_errors;
+			stats->tx_carrier_errors += sstats->tx_carrier_errors;
+			stats->tx_fifo_errors += sstats->tx_fifo_errors;
+			stats->tx_heartbeat_errors += sstats->tx_heartbeat_errors;
+			stats->tx_window_errors += sstats->tx_window_errors;
+		}
 	}
 
 	read_unlock_bh(&bond->lock);
diff --git a/drivers/net/cs89x0.c b/drivers/net/cs89x0.c
index 4ffc9b4..dec70c2 100644
--- a/drivers/net/cs89x0.c
+++ b/drivers/net/cs89x0.c
@@ -588,10 +588,10 @@ #endif
 				goto out2;
 			}
 	}
-	printk(KERN_DEBUG "PP_addr at %x[%x]: 0x%x\n",
-			ioaddr, ADD_PORT, readword(ioaddr, ADD_PORT));
 
 	ioaddr &= ~3;
+	printk(KERN_DEBUG "PP_addr at %x[%x]: 0x%x\n",
+			ioaddr, ADD_PORT, readword(ioaddr, ADD_PORT));
 	writeword(ioaddr, ADD_PORT, PP_ChipID);
 
 	tmp = readword(ioaddr, DATA_PORT);
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
index 418138d..cef7e66 100644
--- a/drivers/net/spider_net.c
+++ b/drivers/net/spider_net.c
@@ -644,20 +644,12 @@ spider_net_prepare_tx_descr(struct spide
 	struct spider_net_descr *descr;
 	dma_addr_t buf;
 	unsigned long flags;
-	int length;
 
-	length = skb->len;
-	if (length < ETH_ZLEN) {
-		if (skb_pad(skb, ETH_ZLEN-length))
-			return 0;
-		length = ETH_ZLEN;
-	}
-
-	buf = pci_map_single(card->pdev, skb->data, length, PCI_DMA_TODEVICE);
+	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(buf)) {
 		if (netif_msg_tx_err(card) && net_ratelimit())
 			pr_err("could not iommu-map packet (%p, %i). "
-				  "Dropping packet\n", skb->data, length);
+				  "Dropping packet\n", skb->data, skb->len);
 		card->spider_stats.tx_iommu_map_error++;
 		return -ENOMEM;
 	}
@@ -667,7 +659,7 @@ spider_net_prepare_tx_descr(struct spide
 	card->tx_chain.head = descr->next;
 
 	descr->buf_addr = buf;
-	descr->buf_size = length;
+	descr->buf_size = skb->len;
 	descr->next_descr_addr = 0;
 	descr->skb = skb;
 	descr->data_status = 0;
@@ -802,8 +794,8 @@ spider_net_release_tx_chain(struct spide
 
 		/* unmap the skb */
 		if (skb) {
-			int len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
-			pci_unmap_single(card->pdev, buf_addr, len, PCI_DMA_TODEVICE);
+			pci_unmap_single(card->pdev, buf_addr, skb->len,
+					PCI_DMA_TODEVICE);
 			dev_kfree_skb(skb);
 		}
 	}
@@ -1641,7 +1633,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTBSTA | SPIDER_NET_GDTDCEIDIS);
+			     SPIDER_NET_GDTBSTA);
 }
 
 /**
diff --git a/drivers/net/spider_net.h b/drivers/net/spider_net.h
index b3b4611..3e196df 100644
--- a/drivers/net/spider_net.h
+++ b/drivers/net/spider_net.h
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.1 A"
+#define VERSION "1.6 A"
 
 #include "sungem_phy.h"
 
@@ -217,8 +217,7 @@ #define SPIDER_NET_TX_DMA_EN           0
 #define SPIDER_NET_GDTBSTA             0x00000300
 #define SPIDER_NET_GDTDCEIDIS          0x00000002
 #define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
-                                       SPIDER_NET_GDTBSTA | \
-                                       SPIDER_NET_GDTDCEIDIS
+                                       SPIDER_NET_GDTBSTA
 
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
@@ -328,7 +327,8 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) | \
+                             (1 << SPIDER_NET_GDTDCEINT) )
 
 /* We rely on flagged descriptor interrupts */
 #define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
diff --git a/drivers/net/wireless/zd1211rw/zd_ieee80211.h b/drivers/net/wireless/zd1211rw/zd_ieee80211.h
index f63245b..3632989 100644
--- a/drivers/net/wireless/zd1211rw/zd_ieee80211.h
+++ b/drivers/net/wireless/zd1211rw/zd_ieee80211.h
@@ -64,7 +64,7 @@ struct cck_plcp_header {
 	u8 service;
 	__le16 length;
 	__le16 crc16;
-};
+} __attribute__((packed));
 
 static inline u8 zd_cck_plcp_header_rate(const struct cck_plcp_header *header)
 {
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.c b/drivers/net/wireless/zd1211rw/zd_mac.c
index a7d29bd..e5fedf9 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -721,7 +721,7 @@ struct zd_rt_hdr {
 	u8  rt_rate;
 	u16 rt_channel;
 	u16 rt_chbitmask;
-};
+} __attribute__((packed));
 
 static void fill_rt_header(void *buffer, struct zd_mac *mac,
 	                   const struct ieee80211_rx_stats *stats,
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.h b/drivers/net/wireless/zd1211rw/zd_mac.h
index b8ea3de..e4dd40a 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.h
+++ b/drivers/net/wireless/zd1211rw/zd_mac.h
@@ -82,7 +82,7 @@ #define ZD_PLCP_HEADER_SIZE		5
 struct rx_length_info {
 	__le16 length[3];
 	__le16 tag;
-};
+} __attribute__((packed));
 
 #define RX_LENGTH_INFO_TAG		0x697e
 
@@ -93,7 +93,7 @@ struct rx_status {
 	u8 signal_quality_ofdm;
 	u8 decryption_type;
 	u8 frame_status;
-};
+} __attribute__((packed));
 
 /* rx_status field decryption_type */
 #define ZD_RX_NO_WEP	0
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index 3faaeb2..a15b095 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -366,15 +366,6 @@ error:
 	return r;
 }
 
-static void disable_read_regs_int(struct zd_usb *usb)
-{
-	struct zd_usb_interrupt *intr = &usb->intr;
-
-	spin_lock(&intr->lock);
-	intr->read_regs_enabled = 0;
-	spin_unlock(&intr->lock);
-}
-
 #define urb_dev(urb) (&(urb)->dev->dev)
 
 static inline void handle_regs_int(struct urb *urb)
@@ -1156,10 +1147,19 @@ static void prepare_read_regs_int(struct
 {
 	struct zd_usb_interrupt *intr = &usb->intr;
 
-	spin_lock(&intr->lock);
+	spin_lock_irq(&intr->lock);
 	intr->read_regs_enabled = 1;
 	INIT_COMPLETION(intr->read_regs.completion);
-	spin_unlock(&intr->lock);
+	spin_unlock_irq(&intr->lock);
+}
+
+static void disable_read_regs_int(struct zd_usb *usb)
+{
+	struct zd_usb_interrupt *intr = &usb->intr;
+
+	spin_lock_irq(&intr->lock);
+	intr->read_regs_enabled = 0;
+	spin_unlock_irq(&intr->lock);
 }
 
 static int get_results(struct zd_usb *usb, u16 *values,
@@ -1171,7 +1171,7 @@ static int get_results(struct zd_usb *us
 	struct read_regs_int *rr = &intr->read_regs;
 	struct usb_int_regs *regs = (struct usb_int_regs *)rr->buffer;
 
-	spin_lock(&intr->lock);
+	spin_lock_irq(&intr->lock);
 
 	r = -EIO;
 	/* The created block size seems to be larger than expected.
@@ -1204,7 +1204,7 @@ static int get_results(struct zd_usb *us
 
 	r = 0;
 error_unlock:
-	spin_unlock(&intr->lock);
+	spin_unlock_irq(&intr->lock);
 	return r;
 }
 
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.h b/drivers/net/wireless/zd1211rw/zd_usb.h
index e81a2d3..317d37c 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.h
+++ b/drivers/net/wireless/zd1211rw/zd_usb.h
@@ -74,17 +74,17 @@ enum control_requests {
 struct usb_req_read_regs {
 	__le16 id;
 	__le16 addr[0];
-};
+} __attribute__((packed));
 
 struct reg_data {
 	__le16 addr;
 	__le16 value;
-};
+} __attribute__((packed));
 
 struct usb_req_write_regs {
 	__le16 id;
 	struct reg_data reg_writes[0];
-};
+} __attribute__((packed));
 
 enum {
 	RF_IF_LE = 0x02,
@@ -101,7 +101,7 @@ struct usb_req_rfwrite {
 	/* RF2595: 24 */
 	__le16 bit_values[0];
 	/* (CR203 & ~(RF_IF_LE | RF_CLK | RF_DATA)) | (bit ? RF_DATA : 0) */
-};
+} __attribute__((packed));
 
 /* USB interrupt */
 
@@ -118,12 +118,12 @@ enum usb_int_flags {
 struct usb_int_header {
 	u8 type;	/* must always be 1 */
 	u8 id;
-};
+} __attribute__((packed));
 
 struct usb_int_regs {
 	struct usb_int_header hdr;
 	struct reg_data regs[0];
-};
+} __attribute__((packed));
 
 struct usb_int_retry_fail {
 	struct usb_int_header hdr;
@@ -131,7 +131,7 @@ struct usb_int_retry_fail {
 	u8 _dummy;
 	u8 addr[ETH_ALEN];
 	u8 ibss_wakeup_dest;
-};
+} __attribute__((packed));
 
 struct read_regs_int {
 	struct completion completion;
diff --git a/net/ieee80211/ieee80211_tx.c b/net/ieee80211/ieee80211_tx.c
index ae25449..854fc13 100644
--- a/net/ieee80211/ieee80211_tx.c
+++ b/net/ieee80211/ieee80211_tx.c
@@ -390,7 +390,7 @@ int ieee80211_xmit(struct sk_buff *skb, 
 		 * this stack is providing the full 802.11 header, one will
 		 * eventually be affixed to this fragment -- so we must account
 		 * for it when determining the amount of payload space. */
-		bytes_per_frag = frag_size - IEEE80211_3ADDR_LEN;
+		bytes_per_frag = frag_size - hdr_len;
 		if (ieee->config &
 		    (CFG_IEEE80211_COMPUTE_FCS | CFG_IEEE80211_RESERVE_FCS))
 			bytes_per_frag -= IEEE80211_FCS_LEN;
@@ -412,7 +412,7 @@ int ieee80211_xmit(struct sk_buff *skb, 
 	} else {
 		nr_frags = 1;
 		bytes_per_frag = bytes_last_frag = bytes;
-		frag_size = bytes + IEEE80211_3ADDR_LEN;
+		frag_size = bytes + hdr_len;
 	}
 
 	rts_required = (frag_size > ieee->rts
diff --git a/net/ieee80211/softmac/ieee80211softmac_scan.c b/net/ieee80211/softmac/ieee80211softmac_scan.c
index d31cf77..ad67368 100644
--- a/net/ieee80211/softmac/ieee80211softmac_scan.c
+++ b/net/ieee80211/softmac/ieee80211softmac_scan.c
@@ -47,7 +47,6 @@ ieee80211softmac_start_scan(struct ieee8
 	sm->scanning = 1;
 	spin_unlock_irqrestore(&sm->lock, flags);
 
-	netif_tx_disable(sm->ieee->dev);
 	ret = sm->start_scan(sm->dev);
 	if (ret) {
 		spin_lock_irqsave(&sm->lock, flags);
@@ -248,7 +247,6 @@ void ieee80211softmac_scan_finished(stru
 		if (net)
 			sm->set_channel(sm->dev, net->channel);
 	}
-	netif_wake_queue(sm->ieee->dev);
 	ieee80211softmac_call_events(sm, IEEE80211SOFTMAC_EVENT_SCAN_FINISHED, NULL);
 }
 EXPORT_SYMBOL_GPL(ieee80211softmac_scan_finished);
