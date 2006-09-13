Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWIMQ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIMQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIMQ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:27:38 -0400
Received: from havoc.gtf.org ([69.61.125.42]:44259 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750708AbWIMQ1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:27:36 -0400
Date: Wed, 13 Sep 2006 12:27:35 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060913162735.GA8159@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/e1000/e1000_main.c          |    8 ++--
 drivers/net/mv643xx_eth.c               |    2 +
 drivers/net/wireless/zd1211rw/zd_chip.c |   61 ++++++++++++++++++++++++--------
 drivers/net/wireless/zd1211rw/zd_mac.c  |   43 ++++++++++++++++++----
 drivers/net/wireless/zd1211rw/zd_mac.h  |   11 +++--
 5 files changed, 94 insertions(+), 31 deletions(-)

Auke Kok:
      e1000: fix TX timout hang regression for 82542rev3

Dale Farnsworth:
      mv643xx_eth: Unmap DMA buffers in receive path

Ulrich Kunitz:
      zd1211rw: Fix of signal strength and quality measurement

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 726f43d..98ef9f8 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -1433,8 +1433,8 @@ e1000_configure_tx(struct e1000_adapter 
 		E1000_WRITE_REG(hw, TDBAL, (tdba & 0x00000000ffffffffULL));
 		E1000_WRITE_REG(hw, TDT, 0);
 		E1000_WRITE_REG(hw, TDH, 0);
-		adapter->tx_ring[0].tdh = E1000_TDH;
-		adapter->tx_ring[0].tdt = E1000_TDT;
+		adapter->tx_ring[0].tdh = ((hw->mac_type >= e1000_82543) ? E1000_TDH : E1000_82542_TDH);
+		adapter->tx_ring[0].tdt = ((hw->mac_type >= e1000_82543) ? E1000_TDT : E1000_82542_TDT);
 		break;
 	}
 
@@ -1840,8 +1840,8 @@ #endif
 		E1000_WRITE_REG(hw, RDBAL, (rdba & 0x00000000ffffffffULL));
 		E1000_WRITE_REG(hw, RDT, 0);
 		E1000_WRITE_REG(hw, RDH, 0);
-		adapter->rx_ring[0].rdh = E1000_RDH;
-		adapter->rx_ring[0].rdt = E1000_RDT;
+		adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ? E1000_RDH : E1000_82542_RDH);
+		adapter->rx_ring[0].rdt = ((hw->mac_type >= e1000_82543) ? E1000_RDT : E1000_82542_RDT);
 		break;
 	}
 
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 760c61b..eeab1df 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -385,6 +385,8 @@ static int mv643xx_eth_receive_queue(str
 	struct pkt_info pkt_info;
 
 	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
+		dma_unmap_single(NULL, pkt_info.buf_ptr, RX_SKB_SIZE,
+							DMA_FROM_DEVICE);
 		mp->rx_desc_count--;
 		received_packets++;
 
diff --git a/drivers/net/wireless/zd1211rw/zd_chip.c b/drivers/net/wireless/zd1211rw/zd_chip.c
index da9d06b..aa79282 100644
--- a/drivers/net/wireless/zd1211rw/zd_chip.c
+++ b/drivers/net/wireless/zd1211rw/zd_chip.c
@@ -1430,9 +1430,43 @@ static int ofdm_qual_db(u8 status_qualit
 			break;
 	}
 
+	switch (rate) {
+	case ZD_OFDM_RATE_6M:
+	case ZD_OFDM_RATE_9M:
+		i += 3;
+		break;
+	case ZD_OFDM_RATE_12M:
+	case ZD_OFDM_RATE_18M:
+		i += 5;
+		break;
+	case ZD_OFDM_RATE_24M:
+	case ZD_OFDM_RATE_36M:
+		i += 9;
+		break;
+	case ZD_OFDM_RATE_48M:
+	case ZD_OFDM_RATE_54M:
+		i += 15;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return i;
 }
 
+static int ofdm_qual_percent(u8 status_quality, u8 rate, unsigned int size)
+{
+	int r;
+
+	r = ofdm_qual_db(status_quality, rate, size);
+	ZD_ASSERT(r >= 0);
+	if (r < 0)
+		r = 0;
+
+	r = (r * 100)/29;
+	return r <= 100 ? r : 100;
+}
+
 static unsigned int log10times100(unsigned int x)
 {
 	static const u8 log10[] = {
@@ -1476,31 +1510,28 @@ static int cck_snr_db(u8 status_quality)
 	return r;
 }
 
-static int rx_qual_db(const void *rx_frame, unsigned int size,
-	              const struct rx_status *status)
+static int cck_qual_percent(u8 status_quality)
 {
-	return (status->frame_status&ZD_RX_OFDM) ?
-		ofdm_qual_db(status->signal_quality_ofdm,
-			     zd_ofdm_plcp_header_rate(rx_frame),
-			     size) :
-		cck_snr_db(status->signal_quality_cck);
+	int r;
+
+	r = cck_snr_db(status_quality);
+	r = (100*r)/17;
+	return r <= 100 ? r : 100;
 }
 
 u8 zd_rx_qual_percent(const void *rx_frame, unsigned int size,
 	              const struct rx_status *status)
 {
-	int r = rx_qual_db(rx_frame, size, status);
-	if (r < 0)
-		r = 0;
-	r = (r * 100) / 14;
-	if (r > 100)
-		r = 100;
-	return r;
+	return (status->frame_status&ZD_RX_OFDM) ?
+		ofdm_qual_percent(status->signal_quality_ofdm,
+			          zd_ofdm_plcp_header_rate(rx_frame),
+			          size) :
+		cck_qual_percent(status->signal_quality_cck);
 }
 
 u8 zd_rx_strength_percent(u8 rssi)
 {
-	int r = (rssi*100) / 30;
+	int r = (rssi*100) / 41;
 	if (r > 100)
 		r = 100;
 	return (u8) r;
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.c b/drivers/net/wireless/zd1211rw/zd_mac.c
index d6f3e02..a9bd80a 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -816,13 +816,25 @@ static int filter_rx(struct ieee80211_de
 	return -EINVAL;
 }
 
-static void update_qual_rssi(struct zd_mac *mac, u8 qual_percent, u8 rssi)
+static void update_qual_rssi(struct zd_mac *mac,
+			     const u8 *buffer, unsigned int length,
+			     u8 qual_percent, u8 rssi_percent)
 {
 	unsigned long flags;
+	struct ieee80211_hdr_3addr *hdr;
+	int i;
+
+	hdr = (struct ieee80211_hdr_3addr *)buffer;
+	if (length < offsetof(struct ieee80211_hdr_3addr, addr3))
+		return;
+	if (memcmp(hdr->addr2, zd_mac_to_ieee80211(mac)->bssid, ETH_ALEN) != 0)
+		return;
 
 	spin_lock_irqsave(&mac->lock, flags);
-	mac->qual_average = (7 * mac->qual_average + qual_percent) / 8;
-	mac->rssi_average = (7 * mac->rssi_average + rssi) / 8;
+	i = mac->stats_count % ZD_MAC_STATS_BUFFER_SIZE;
+	mac->qual_buffer[i] = qual_percent;
+	mac->rssi_buffer[i] = rssi_percent;
+	mac->stats_count++;
 	spin_unlock_irqrestore(&mac->lock, flags);
 }
 
@@ -853,7 +865,6 @@ static int fill_rx_stats(struct ieee8021
 	if (stats->rate)
 		stats->mask |= IEEE80211_STATMASK_RATE;
 
-	update_qual_rssi(mac, stats->signal, stats->rssi);
 	return 0;
 }
 
@@ -877,6 +888,8 @@ int zd_mac_rx(struct zd_mac *mac, const 
 		  sizeof(struct rx_status);
 	buffer += ZD_PLCP_HEADER_SIZE;
 
+	update_qual_rssi(mac, buffer, length, stats.signal, stats.rssi);
+
 	r = filter_rx(ieee, buffer, length, &stats);
 	if (r <= 0)
 		return r;
@@ -981,17 +994,31 @@ struct iw_statistics *zd_mac_get_wireles
 {
 	struct zd_mac *mac = zd_netdev_mac(ndev);
 	struct iw_statistics *iw_stats = &mac->iw_stats;
+	unsigned int i, count, qual_total, rssi_total;
 
 	memset(iw_stats, 0, sizeof(struct iw_statistics));
 	/* We are not setting the status, because ieee->state is not updated
 	 * at all and this driver doesn't track authentication state.
 	 */
 	spin_lock_irq(&mac->lock);
-	iw_stats->qual.qual = mac->qual_average;
-	iw_stats->qual.level = mac->rssi_average;
-	iw_stats->qual.updated = IW_QUAL_QUAL_UPDATED|IW_QUAL_LEVEL_UPDATED|
-		                 IW_QUAL_NOISE_INVALID;
+	count = mac->stats_count < ZD_MAC_STATS_BUFFER_SIZE ?
+		mac->stats_count : ZD_MAC_STATS_BUFFER_SIZE;
+	qual_total = rssi_total = 0;
+	for (i = 0; i < count; i++) {
+		qual_total += mac->qual_buffer[i];
+		rssi_total += mac->rssi_buffer[i];
+	}
 	spin_unlock_irq(&mac->lock);
+	iw_stats->qual.updated = IW_QUAL_NOISE_INVALID;
+	if (count > 0) {
+		iw_stats->qual.qual = qual_total / count;
+		iw_stats->qual.level = rssi_total / count;
+		iw_stats->qual.updated |=
+			IW_QUAL_QUAL_UPDATED|IW_QUAL_LEVEL_UPDATED;
+	} else {
+		iw_stats->qual.updated |=
+			IW_QUAL_QUAL_INVALID|IW_QUAL_LEVEL_INVALID;
+	}
 	/* TODO: update counter */
 	return iw_stats;
 }
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.h b/drivers/net/wireless/zd1211rw/zd_mac.h
index 71e382c..b3ba49b 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.h
+++ b/drivers/net/wireless/zd1211rw/zd_mac.h
@@ -1,4 +1,4 @@
-/* zd_mac.c
+/* zd_mac.h
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -87,9 +87,9 @@ struct rx_length_info {
 #define RX_LENGTH_INFO_TAG		0x697e
 
 struct rx_status {
+	u8 signal_quality_cck;
 	/* rssi */
 	u8 signal_strength;
-	u8 signal_quality_cck;
 	u8 signal_quality_ofdm;
 	u8 decryption_type;
 	u8 frame_status;
@@ -120,14 +120,17 @@ enum mac_flags {
 	MAC_FIXED_CHANNEL = 0x01,
 };
 
+#define ZD_MAC_STATS_BUFFER_SIZE 16
+
 struct zd_mac {
 	struct net_device *netdev;
 	struct zd_chip chip;
 	spinlock_t lock;
 	/* Unlocked reading possible */
 	struct iw_statistics iw_stats;
-	u8 qual_average;
-	u8 rssi_average;
+	unsigned int stats_count;
+	u8 qual_buffer[ZD_MAC_STATS_BUFFER_SIZE];
+	u8 rssi_buffer[ZD_MAC_STATS_BUFFER_SIZE];
 	u8 regdomain;
 	u8 default_regdomain;
 	u8 requested_channel;
