Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWIQFH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWIQFH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIQFHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:07:23 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32665 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932167AbWIQFHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:07:17 -0400
Date: Sun, 17 Sep 2006 01:07:10 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20060917050710.GA15508@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/e1000/e1000_main.c          |    8 
 drivers/net/mv643xx_eth.c               |    2 
 drivers/net/wireless/zd1211rw/zd_chip.c |   61 ++-
 drivers/net/wireless/zd1211rw/zd_mac.c  |   43 ++
 drivers/net/wireless/zd1211rw/zd_mac.h  |   11 
 drivers/s390/net/Kconfig                |    9 
 drivers/s390/net/Makefile               |    1 
 drivers/s390/net/ctcmain.c              |    3 
 drivers/s390/net/iucv.c                 |    4 
 drivers/s390/net/lcs.c                  |   13 
 drivers/s390/net/netiucv.c              |   80 +++-
 drivers/s390/net/qeth.h                 |   73 ++--
 drivers/s390/net/qeth_eddp.c            |    5 
 drivers/s390/net/qeth_main.c            |  517 ++++++++++++++++----------------
 drivers/s390/net/qeth_proc.c            |   23 -
 drivers/s390/net/qeth_sys.c             |   64 +++
 drivers/s390/net/qeth_tso.h             |    2 
 17 files changed, 547 insertions(+), 372 deletions(-)

Auke Kok:
      e1000: fix TX timout hang regression for 82542rev3

Dale Farnsworth:
      mv643xx_eth: Unmap DMA buffers in receive path

Frank Pavlic:
      s390: minor s390 network driver fixes
      s390: netiucv driver fixes
      s390: Makefile cleanup
      s390: qeth driver fixes [1/6]
      s390: qeth driver fixes [2/6]
      s390: qeth driver fixes [3/6]
      s390: qeth driver fixes [4/6]
      s390: qeth driver fixes [5/6]
      s390: qeth driver fixes [6/6]

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
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 5488547..1a93fa6 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -92,15 +92,6 @@ config QETH_VLAN
 	  If CONFIG_QETH is switched on, this option will include IEEE
 	  802.1q VLAN support in the qeth device driver.
 
-config QETH_PERF_STATS
-	bool "Performance statistics in /proc"
-	depends on QETH
-	help
-	  When switched on, this option will add a file in the proc-fs
-	  (/proc/qeth_perf_stats) containing performance statistics. It
-	  may slightly impact performance, so this is only recommended for
-	  internal tuning of the device driver.
-
 config CCWGROUP
  	tristate
 	default (LCS || CTC || QETH)
diff --git a/drivers/s390/net/Makefile b/drivers/s390/net/Makefile
index 6775a83..4777e36 100644
--- a/drivers/s390/net/Makefile
+++ b/drivers/s390/net/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
 obj-$(CONFIG_CTC) += ctc.o fsm.o cu3088.o
 obj-$(CONFIG_LCS) += lcs.o cu3088.o
 obj-$(CONFIG_CLAW) += claw.o cu3088.o
-obj-$(CONFIG_MPC) += ctcmpc.o fsm.o cu3088.o
 qeth-y := qeth_main.o qeth_mpc.o qeth_sys.o qeth_eddp.o 
 qeth-$(CONFIG_PROC_FS) += qeth_proc.o
 obj-$(CONFIG_QETH) += qeth.o
diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
index 8a4b581..3257c22 100644
--- a/drivers/s390/net/ctcmain.c
+++ b/drivers/s390/net/ctcmain.c
@@ -1714,6 +1714,9 @@ add_channel(struct ccw_device *cdev, enu
 		kfree(ch);
 		return 0;
 	}
+
+	spin_lock_init(&ch->collect_lock);
+
 	fsm_settimer(ch->fsm, &ch->timer);
 	skb_queue_head_init(&ch->io_queue);
 	skb_queue_head_init(&ch->collect_queue);
diff --git a/drivers/s390/net/iucv.c b/drivers/s390/net/iucv.c
index 0e863df..821dde8 100644
--- a/drivers/s390/net/iucv.c
+++ b/drivers/s390/net/iucv.c
@@ -335,8 +335,8 @@ do { \
 
 #else
 
-#define iucv_debug(lvl, fmt, args...)
-#define iucv_dumpit(title, buf, len)
+#define iucv_debug(lvl, fmt, args...)	do { } while (0)
+#define iucv_dumpit(title, buf, len)	do { } while (0)
 
 #endif
 
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 2eded55..16ac68c 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -670,9 +670,8 @@ lcs_ready_buffer(struct lcs_channel *cha
 	int index, rc;
 
 	LCS_DBF_TEXT(5, trace, "rdybuff");
-	if (buffer->state != BUF_STATE_LOCKED &&
-	    buffer->state != BUF_STATE_PROCESSED)
-		BUG();
+	BUG_ON(buffer->state != BUF_STATE_LOCKED &&
+	       buffer->state != BUF_STATE_PROCESSED);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	buffer->state = BUF_STATE_READY;
 	index = buffer - channel->iob;
@@ -696,8 +695,7 @@ __lcs_processed_buffer(struct lcs_channe
 	int index, prev, next;
 
 	LCS_DBF_TEXT(5, trace, "prcsbuff");
-	if (buffer->state != BUF_STATE_READY)
-		BUG();
+	BUG_ON(buffer->state != BUF_STATE_READY);
 	buffer->state = BUF_STATE_PROCESSED;
 	index = buffer - channel->iob;
 	prev = (index - 1) & (LCS_NUM_BUFFS - 1);
@@ -729,9 +727,8 @@ lcs_release_buffer(struct lcs_channel *c
 	unsigned long flags;
 
 	LCS_DBF_TEXT(5, trace, "relbuff");
-	if (buffer->state != BUF_STATE_LOCKED &&
-	    buffer->state != BUF_STATE_PROCESSED)
-		BUG();
+	BUG_ON(buffer->state != BUF_STATE_LOCKED &&
+	       buffer->state != BUF_STATE_PROCESSED);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	buffer->state = BUF_STATE_EMPTY;
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 5d6e6cb..d7d1cc0 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -112,7 +112,12 @@ struct iucv_connection {
 /**
  * Linked list of all connection structs.
  */
-static struct iucv_connection *iucv_connections;
+struct iucv_connection_struct {
+	struct iucv_connection *iucv_connections;
+	rwlock_t iucv_rwlock;
+};
+
+static struct iucv_connection_struct iucv_conns;
 
 /**
  * Representation of event-data for the
@@ -1368,8 +1373,10 @@ user_write (struct device *dev, struct d
 	struct net_device *ndev = priv->conn->netdev;
 	char    *p;
 	char    *tmp;
-	char 	username[10];
+	char 	username[9];
 	int 	i;
+	struct iucv_connection **clist = &iucv_conns.iucv_connections;
+	unsigned long flags;
 
 	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (count>9) {
@@ -1382,7 +1389,7 @@ user_write (struct device *dev, struct d
 	tmp = strsep((char **) &buf, "\n");
 	for (i=0, p=tmp; i<8 && *p; i++, p++) {
 		if (isalnum(*p) || (*p == '$'))
-			username[i]= *p;
+			username[i]= toupper(*p);
 		else if (*p == '\n') {
 			/* trailing lf, grr */
 			break;
@@ -1395,11 +1402,11 @@ user_write (struct device *dev, struct d
 			return -EINVAL;
 		}
 	}
-	while (i<9)
+	while (i<8)
 		username[i++] = ' ';
-	username[9] = '\0';
+	username[8] = '\0';
 
-	if (memcmp(username, priv->conn->userid, 8)) {
+	if (memcmp(username, priv->conn->userid, 9)) {
 		/* username changed */
 		if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
 			PRINT_WARN(
@@ -1410,6 +1417,19 @@ user_write (struct device *dev, struct d
 			return -EBUSY;
 		}
 	}
+	read_lock_irqsave(&iucv_conns.iucv_rwlock, flags);
+	while (*clist) {
+                if (!strncmp(username, (*clist)->userid, 9) ||
+		    ((*clist)->netdev != ndev))
+                        break;
+                clist = &((*clist)->next);
+        }
+	read_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
+        if (*clist) {
+                PRINT_WARN("netiucv: Connection to %s already exists\n",
+                        username);
+                return -EEXIST;
+        }
 	memcpy(priv->conn->userid, username, 9);
 
 	return count;
@@ -1781,13 +1801,15 @@ netiucv_unregister_device(struct device 
 static struct iucv_connection *
 netiucv_new_connection(struct net_device *dev, char *username)
 {
-	struct iucv_connection **clist = &iucv_connections;
+	unsigned long flags;
+	struct iucv_connection **clist = &iucv_conns.iucv_connections;
 	struct iucv_connection *conn =
 		kzalloc(sizeof(struct iucv_connection), GFP_KERNEL);
 
 	if (conn) {
 		skb_queue_head_init(&conn->collect_queue);
 		skb_queue_head_init(&conn->commit_queue);
+		spin_lock_init(&conn->collect_lock);
 		conn->max_buffsize = NETIUCV_BUFSIZE_DEFAULT;
 		conn->netdev = dev;
 
@@ -1822,8 +1844,10 @@ netiucv_new_connection(struct net_device
 			fsm_newstate(conn->fsm, CONN_STATE_STOPPED);
 		}
 
+		write_lock_irqsave(&iucv_conns.iucv_rwlock, flags);
 		conn->next = *clist;
 		*clist = conn;
+		write_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
 	}
 	return conn;
 }
@@ -1835,14 +1859,17 @@ netiucv_new_connection(struct net_device
 static void
 netiucv_remove_connection(struct iucv_connection *conn)
 {
-	struct iucv_connection **clist = &iucv_connections;
+	struct iucv_connection **clist = &iucv_conns.iucv_connections;
+	unsigned long flags;
 
 	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (conn == NULL)
 		return;
+	write_lock_irqsave(&iucv_conns.iucv_rwlock, flags);
 	while (*clist) {
 		if (*clist == conn) {
 			*clist = conn->next;
+			write_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
 			if (conn->handle) {
 				iucv_unregister_program(conn->handle);
 				conn->handle = NULL;
@@ -1855,6 +1882,7 @@ netiucv_remove_connection(struct iucv_co
 		}
 		clist = &((*clist)->next);
 	}
+	write_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
 }
 
 /**
@@ -1947,9 +1975,11 @@ static ssize_t
 conn_write(struct device_driver *drv, const char *buf, size_t count)
 {
 	char *p;
-	char username[10];
+	char username[9];
 	int i, ret;
 	struct net_device *dev;
+	struct iucv_connection **clist = &iucv_conns.iucv_connections;
+	unsigned long flags;
 
 	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (count>9) {
@@ -1960,7 +1990,7 @@ conn_write(struct device_driver *drv, co
 
 	for (i=0, p=(char *)buf; i<8 && *p; i++, p++) {
 		if (isalnum(*p) || (*p == '$'))
-			username[i]= *p;
+			username[i]= toupper(*p);
 		else if (*p == '\n') {
 			/* trailing lf, grr */
 			break;
@@ -1971,9 +2001,22 @@ conn_write(struct device_driver *drv, co
 			return -EINVAL;
 		}
 	}
-	while (i<9)
+	while (i<8)
 		username[i++] = ' ';
-	username[9] = '\0';
+	username[8] = '\0';
+
+	read_lock_irqsave(&iucv_conns.iucv_rwlock, flags);
+	while (*clist) {
+		if (!strncmp(username, (*clist)->userid, 9))
+			break;
+		clist = &((*clist)->next);
+	}
+	read_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
+	if (*clist) {
+		PRINT_WARN("netiucv: Connection to %s already exists\n",
+			username);
+		return -EEXIST;
+	}
 	dev = netiucv_init_netdevice(username);
 	if (!dev) {
 		PRINT_WARN(
@@ -2015,7 +2058,8 @@ DRIVER_ATTR(connection, 0200, NULL, conn
 static ssize_t
 remove_write (struct device_driver *drv, const char *buf, size_t count)
 {
-	struct iucv_connection **clist = &iucv_connections;
+	struct iucv_connection **clist = &iucv_conns.iucv_connections;
+	unsigned long flags;
         struct net_device *ndev;
         struct netiucv_priv *priv;
         struct device *dev;
@@ -2026,7 +2070,7 @@ remove_write (struct device_driver *drv,
         IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
         if (count >= IFNAMSIZ)
-                count = IFNAMSIZ-1;
+                count = IFNAMSIZ - 1;;
 
         for (i=0, p=(char *)buf; i<count && *p; i++, p++) {
                 if ((*p == '\n') || (*p == ' ')) {
@@ -2038,6 +2082,7 @@ remove_write (struct device_driver *drv,
         }
         name[i] = '\0';
 
+	read_lock_irqsave(&iucv_conns.iucv_rwlock, flags);
         while (*clist) {
                 ndev = (*clist)->netdev;
                 priv = (struct netiucv_priv*)ndev->priv;
@@ -2047,6 +2092,7 @@ remove_write (struct device_driver *drv,
                         clist = &((*clist)->next);
                         continue;
                 }
+		read_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
                 if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
                         PRINT_WARN(
                                 "netiucv: net device %s active with peer %s\n",
@@ -2060,6 +2106,7 @@ remove_write (struct device_driver *drv,
                 netiucv_unregister_device(dev);
                 return count;
         }
+	read_unlock_irqrestore(&iucv_conns.iucv_rwlock, flags);
         PRINT_WARN("netiucv: net device %s unknown\n", name);
 	IUCV_DBF_TEXT(data, 2, "remove_write: unknown device\n");
         return -EINVAL;
@@ -2077,8 +2124,8 @@ static void __exit
 netiucv_exit(void)
 {
 	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
-	while (iucv_connections) {
-		struct net_device *ndev = iucv_connections->netdev;
+	while (iucv_conns.iucv_connections) {
+		struct net_device *ndev = iucv_conns.iucv_connections->netdev;
 		struct netiucv_priv *priv = (struct netiucv_priv*)ndev->priv;
 		struct device *dev = priv->dev;
 
@@ -2120,6 +2167,7 @@ netiucv_init(void)
 	if (!ret) {
 		ret = driver_create_file(&netiucv_driver, &driver_attr_remove);
 		netiucv_banner();
+		rwlock_init(&iucv_conns.iucv_rwlock);
 	} else {
 		PRINT_ERR("NETIUCV: failed to add driver attribute.\n");
 		IUCV_DBF_TEXT_(setup, 2, "ret %d from driver_create_file\n", ret);
diff --git a/drivers/s390/net/qeth.h b/drivers/s390/net/qeth.h
index 619f4a0..821383d 100644
--- a/drivers/s390/net/qeth.h
+++ b/drivers/s390/net/qeth.h
@@ -176,7 +176,6 @@ #define CARD_FROM_CDEV(cdev) (struct qet
 /**
  * card stuff
  */
-#ifdef CONFIG_QETH_PERF_STATS
 struct qeth_perf_stats {
 	unsigned int bufs_rec;
 	unsigned int bufs_sent;
@@ -211,8 +210,10 @@ struct qeth_perf_stats {
 	unsigned int large_send_cnt;
 	unsigned int sg_skbs_sent;
 	unsigned int sg_frags_sent;
+	/* initial values when measuring starts */
+	unsigned long initial_rx_packets;
+	unsigned long initial_tx_packets;
 };
-#endif /* CONFIG_QETH_PERF_STATS */
 
 /* Routing stuff */
 struct qeth_routing_info {
@@ -462,6 +463,7 @@ enum qeth_qdio_info_states {
 	QETH_QDIO_UNINITIALIZED,
 	QETH_QDIO_ALLOCATED,
 	QETH_QDIO_ESTABLISHED,
+	QETH_QDIO_CLEANING
 };
 
 struct qeth_buffer_pool_entry {
@@ -536,7 +538,7 @@ struct qeth_qdio_out_q {
 } __attribute__ ((aligned(256)));
 
 struct qeth_qdio_info {
-	volatile enum qeth_qdio_info_states state;
+	atomic_t state;
 	/* input */
 	struct qeth_qdio_q *in_q;
 	struct qeth_qdio_buffer_pool in_buf_pool;
@@ -767,6 +769,7 @@ #endif /* QETH_IPV6 */
 	int fake_ll;
 	int layer2;
 	enum qeth_large_send_types large_send;
+	int performance_stats;
 };
 
 /*
@@ -819,9 +822,7 @@ #endif
 	struct list_head cmd_waiter_list;
 	/* QDIO buffer handling */
 	struct qeth_qdio_info qdio;
-#ifdef CONFIG_QETH_PERF_STATS
 	struct qeth_perf_stats perf_stats;
-#endif /* CONFIG_QETH_PERF_STATS */
 	int use_hard_stop;
 	int (*orig_hard_header)(struct sk_buff *,struct net_device *,
 				unsigned short,void *,void *,unsigned);
@@ -859,23 +860,18 @@ qeth_get_ipa_adp_type(enum qeth_link_typ
 	}
 }
 
-static inline int
-qeth_realloc_headroom(struct qeth_card *card, struct sk_buff **skb, int size)
+static inline struct sk_buff *
+qeth_realloc_headroom(struct qeth_card *card, struct sk_buff *skb, int size)
 {
-	struct sk_buff *new_skb = NULL;
-
-	if (skb_headroom(*skb) < size){
-		new_skb = skb_realloc_headroom(*skb, size);
-		if (!new_skb) {
-                        PRINT_ERR("qeth_prepare_skb: could "
-                                  "not realloc headroom for qeth_hdr "
-                                  "on interface %s", QETH_CARD_IFNAME(card));
-                        return -ENOMEM;
-                }
-		kfree_skb(*skb);
-                *skb = new_skb;
-	}
-	return 0;
+	struct sk_buff *new_skb = skb;
+
+	if (skb_headroom(skb) >= size)
+		return skb;
+	new_skb = skb_realloc_headroom(skb, size);
+	if (!new_skb) 
+		PRINT_ERR("Could not realloc headroom for qeth_hdr "
+			  "on interface %s", QETH_CARD_IFNAME(card));
+	return new_skb;
 }
 
 static inline struct sk_buff *
@@ -885,16 +881,15 @@ qeth_pskb_unshare(struct sk_buff *skb, i
         if (!skb_cloned(skb))
                 return skb;
         nskb = skb_copy(skb, pri);
-        kfree_skb(skb); /* free our shared copy */
         return nskb;
 }
 
 static inline void *
-qeth_push_skb(struct qeth_card *card, struct sk_buff **skb, int size)
+qeth_push_skb(struct qeth_card *card, struct sk_buff *skb, int size)
 {
         void *hdr;
 
-	hdr = (void *) skb_push(*skb, size);
+	hdr = (void *) skb_push(skb, size);
         /*
          * sanity check, the Linux memory allocation scheme should
          * never present us cases like this one (the qdio header size plus
@@ -903,8 +898,7 @@ qeth_push_skb(struct qeth_card *card, st
         if ((((unsigned long) hdr) & (~(PAGE_SIZE - 1))) !=
             (((unsigned long) hdr + size +
               QETH_IP_HEADER_SIZE) & (~(PAGE_SIZE - 1)))) {
-                PRINT_ERR("qeth_prepare_skb: misaligned "
-                          "packet on interface %s. Discarded.",
+                PRINT_ERR("Misaligned packet on interface %s. Discarded.",
                           QETH_CARD_IFNAME(card));
                 return NULL;
         }
@@ -1056,13 +1050,11 @@ qeth_get_arphdr_type(int cardtype, int l
 	}
 }
 
-#ifdef CONFIG_QETH_PERF_STATS
 static inline int
 qeth_get_micros(void)
 {
 	return (int) (get_clock() >> 12);
 }
-#endif
 
 static inline int
 qeth_get_qdio_q_format(struct qeth_card *card)
@@ -1096,10 +1088,11 @@ qeth_string_to_ipaddr4(const char *buf, 
 {
 	int count = 0, rc = 0;
 	int in[4];
+	char c;
 
-	rc = sscanf(buf, "%d.%d.%d.%d%n",
-		    &in[0], &in[1], &in[2], &in[3], &count);
-	if (rc != 4  || count<=0)
+	rc = sscanf(buf, "%u.%u.%u.%u%c",
+		    &in[0], &in[1], &in[2], &in[3], &c);
+	if (rc != 4 && (rc != 5 || c != '\n'))
 		return -EINVAL;
 	for (count = 0; count < 4; count++) {
 		if (in[count] > 255)
@@ -1123,24 +1116,28 @@ qeth_ipaddr6_to_string(const __u8 *addr,
 static inline int
 qeth_string_to_ipaddr6(const char *buf, __u8 *addr)
 {
-	char *end, *start;
+	const char *end, *end_tmp, *start;
 	__u16 *in;
         char num[5];
         int num2, cnt, out, found, save_cnt;
         unsigned short in_tmp[8] = {0, };
 
 	cnt = out = found = save_cnt = num2 = 0;
-        end = start = (char *) buf;
+        end = start = buf;
 	in = (__u16 *) addr;
 	memset(in, 0, 16);
-        while (end) {
-                end = strchr(end,':');
+        while (*end) {
+                end = strchr(start,':');
                 if (end == NULL) {
-                        end = (char *)buf + (strlen(buf));
-                        out = 1;
+                        end = buf + strlen(buf);
+			if ((end_tmp = strchr(start, '\n')) != NULL)
+				end = end_tmp;
+			out = 1;
                 }
                 if ((end - start)) {
                         memset(num, 0, 5);
+			if ((end - start) > 4)
+				return -EINVAL;
                         memcpy(num, start, end - start);
 			if (!qeth_isxdigit(num))
 				return -EINVAL;
@@ -1158,6 +1155,8 @@ qeth_string_to_ipaddr6(const char *buf, 
 		}
 		start = ++end;
         }
+	if (cnt + save_cnt > 8)
+		return -EINVAL;
         cnt = 7;
 	while (save_cnt)
                 in[cnt--] = in_tmp[--save_cnt];
diff --git a/drivers/s390/net/qeth_eddp.c b/drivers/s390/net/qeth_eddp.c
index 8491598..a363721 100644
--- a/drivers/s390/net/qeth_eddp.c
+++ b/drivers/s390/net/qeth_eddp.c
@@ -179,9 +179,8 @@ out_check:
 			flush_cnt++;
 		}
 	} else {
-#ifdef CONFIG_QETH_PERF_STATS
-		queue->card->perf_stats.skbs_sent_pack++;
-#endif
+		if (queue->card->options.performance_stats)
+			queue->card->perf_stats.skbs_sent_pack++;
 		QETH_DBF_TEXT(trace, 6, "fillbfpa");
 		if (buf->next_element_to_fill >=
 				QETH_MAX_BUFFER_ELEMENTS(queue->card)) {
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index e1327b8..5613b45 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1073,6 +1073,7 @@ #endif /* QETH_IPV6 */
 		card->options.layer2 = 1;
 	else
 		card->options.layer2 = 0;
+	card->options.performance_stats = 1;
 }
 
 /**
@@ -1708,6 +1709,7 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   "IP address reset.\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
+				netif_carrier_on(card->dev);
 				qeth_schedule_recovery(card);
 				return NULL;
 			case IPA_CMD_MODCCID:
@@ -2464,24 +2466,6 @@ qeth_rebuild_skb_fake_ll(struct qeth_car
 		qeth_rebuild_skb_fake_ll_eth(card, skb, hdr);
 }
 
-static inline void
-qeth_rebuild_skb_vlan(struct qeth_card *card, struct sk_buff *skb,
-		      struct qeth_hdr *hdr)
-{
-#ifdef CONFIG_QETH_VLAN
-	u16 *vlan_tag;
-
-	if (hdr->hdr.l3.ext_flags &
-	    (QETH_HDR_EXT_VLAN_FRAME | QETH_HDR_EXT_INCLUDE_VLAN_TAG)) {
-		vlan_tag = (u16 *) skb_push(skb, VLAN_HLEN);
-		*vlan_tag = (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME)?
-			hdr->hdr.l3.vlan_id : *((u16 *)&hdr->hdr.l3.dest_addr[12]);
-		*(vlan_tag + 1) = skb->protocol;
-		skb->protocol = __constant_htons(ETH_P_8021Q);
-	}
-#endif /* CONFIG_QETH_VLAN */
-}
-
 static inline __u16
 qeth_layer2_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_hdr *hdr)
@@ -2510,15 +2494,16 @@ #endif
 	return vlan_id;
 }
 
-static inline void
+static inline __u16
 qeth_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		 struct qeth_hdr *hdr)
 {
+	unsigned short vlan_id = 0;
 #ifdef CONFIG_QETH_IPV6
 	if (hdr->hdr.l3.flags & QETH_HDR_PASSTHRU) {
 		skb->pkt_type = PACKET_HOST;
 		skb->protocol = qeth_type_trans(skb, card->dev);
-		return;
+		return 0;
 	}
 #endif /* CONFIG_QETH_IPV6 */
 	skb->protocol = htons((hdr->hdr.l3.flags & QETH_HDR_IPV6)? ETH_P_IPV6 :
@@ -2540,7 +2525,13 @@ #endif /* CONFIG_QETH_IPV6 */
 	default:
 		skb->pkt_type = PACKET_HOST;
 	}
-	qeth_rebuild_skb_vlan(card, skb, hdr);
+
+	if (hdr->hdr.l3.ext_flags &
+	    (QETH_HDR_EXT_VLAN_FRAME | QETH_HDR_EXT_INCLUDE_VLAN_TAG)) {
+		vlan_id = (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME)?
+			hdr->hdr.l3.vlan_id : *((u16 *)&hdr->hdr.l3.dest_addr[12]);
+	}
+
 	if (card->options.fake_ll)
 		qeth_rebuild_skb_fake_ll(card, skb, hdr);
 	else
@@ -2556,6 +2547,7 @@ #endif /* CONFIG_QETH_IPV6 */
 		else
 			skb->ip_summed = SW_CHECKSUMMING;
 	}
+	return vlan_id;
 }
 
 static inline void
@@ -2568,20 +2560,20 @@ qeth_process_inbound_buffer(struct qeth_
 	int offset;
 	int rxrc;
 	__u16 vlan_tag = 0;
+	__u16 *vlan_addr;
 
 	/* get first element of current buffer */
 	element = (struct qdio_buffer_element *)&buf->buffer->element[0];
 	offset = 0;
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.bufs_rec++;
-#endif
+	if (card->options.performance_stats)
+		card->perf_stats.bufs_rec++;
 	while((skb = qeth_get_next_skb(card, buf->buffer, &element,
 				       &offset, &hdr))) {
 		skb->dev = card->dev;
 		if (hdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2)
 			vlan_tag = qeth_layer2_rebuild_skb(card, skb, hdr);
 		else if (hdr->hdr.l3.id == QETH_HEADER_TYPE_LAYER3)
-			qeth_rebuild_skb(card, skb, hdr);
+			vlan_tag = qeth_rebuild_skb(card, skb, hdr);
 		else { /*in case of OSN*/
 			skb_push(skb, sizeof(struct qeth_hdr));
 			memcpy(skb->data, hdr, sizeof(struct qeth_hdr));
@@ -2591,14 +2583,19 @@ #endif
 			dev_kfree_skb_any(skb);
 			continue;
 		}
+		if (card->info.type == QETH_CARD_TYPE_OSN)
+			rxrc = card->osn_info.data_cb(skb);
+		else
 #ifdef CONFIG_QETH_VLAN
 		if (vlan_tag)
-			vlan_hwaccel_rx(skb, card->vlangrp, vlan_tag);
+			if (card->vlangrp)
+				vlan_hwaccel_rx(skb, card->vlangrp, vlan_tag);
+			else {
+				dev_kfree_skb_any(skb);
+				continue;
+			}
 		else
 #endif
-		if (card->info.type == QETH_CARD_TYPE_OSN)
-			rxrc = card->osn_info.data_cb(skb);
-		else
 			rxrc = netif_rx(skb);
 		card->dev->last_rx = jiffies;
 		card->stats.rx_packets++;
@@ -2626,7 +2623,7 @@ qeth_init_input_buffer(struct qeth_card 
 {
 	struct qeth_buffer_pool_entry *pool_entry;
 	int i;
-
+ 
 	pool_entry = qeth_get_buffer_pool_entry(card);
 	/*
 	 * since the buffer is accessed only from the input_tasklet
@@ -2700,17 +2697,18 @@ qeth_queue_input_buffer(struct qeth_card
 		 * 'index') un-requeued -> this buffer is the first buffer that
 		 * will be requeued the next time
 		 */
-#ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.inbound_do_qdio_cnt++;
-		card->perf_stats.inbound_do_qdio_start_time = qeth_get_micros();
-#endif
+		if (card->options.performance_stats) {
+			card->perf_stats.inbound_do_qdio_cnt++;
+			card->perf_stats.inbound_do_qdio_start_time =
+				qeth_get_micros();
+		}
 		rc = do_QDIO(CARD_DDEV(card),
 			     QDIO_FLAG_SYNC_INPUT | QDIO_FLAG_UNDER_INTERRUPT,
 			     0, queue->next_buf_to_init, count, NULL);
-#ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.inbound_do_qdio_time += qeth_get_micros() -
-			card->perf_stats.inbound_do_qdio_start_time;
-#endif
+		if (card->options.performance_stats)
+			card->perf_stats.inbound_do_qdio_time +=
+				qeth_get_micros() -
+				card->perf_stats.inbound_do_qdio_start_time;
 		if (rc){
 			PRINT_WARN("qeth_queue_input_buffer's do_QDIO "
 				   "return %i (device %s).\n",
@@ -2746,10 +2744,10 @@ qeth_qdio_input_handler(struct ccw_devic
 	QETH_DBF_TEXT(trace, 6, "qdinput");
 	card = (struct qeth_card *) card_ptr;
 	net_dev = card->dev;
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.inbound_cnt++;
-	card->perf_stats.inbound_start_time = qeth_get_micros();
-#endif
+	if (card->options.performance_stats) {
+		card->perf_stats.inbound_cnt++;
+		card->perf_stats.inbound_start_time = qeth_get_micros();
+	}
 	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
 		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION){
 			QETH_DBF_TEXT(trace, 1,"qdinchk");
@@ -2771,10 +2769,9 @@ #endif
 		qeth_put_buffer_pool_entry(card, buffer->pool_entry);
 		qeth_queue_input_buffer(card, index);
 	}
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.inbound_time += qeth_get_micros() -
-		card->perf_stats.inbound_start_time;
-#endif
+	if (card->options.performance_stats)
+		card->perf_stats.inbound_time += qeth_get_micros() -
+			card->perf_stats.inbound_start_time;
 }
 
 static inline int
@@ -2864,10 +2861,11 @@ qeth_flush_buffers(struct qeth_qdio_out_
 	}
 
 	queue->card->dev->trans_start = jiffies;
-#ifdef CONFIG_QETH_PERF_STATS
-	queue->card->perf_stats.outbound_do_qdio_cnt++;
-	queue->card->perf_stats.outbound_do_qdio_start_time = qeth_get_micros();
-#endif
+	if (queue->card->options.performance_stats) {
+		queue->card->perf_stats.outbound_do_qdio_cnt++;
+		queue->card->perf_stats.outbound_do_qdio_start_time =
+			qeth_get_micros();
+	}
 	if (under_int)
 		rc = do_QDIO(CARD_DDEV(queue->card),
 			     QDIO_FLAG_SYNC_OUTPUT | QDIO_FLAG_UNDER_INTERRUPT,
@@ -2875,10 +2873,10 @@ #endif
 	else
 		rc = do_QDIO(CARD_DDEV(queue->card), QDIO_FLAG_SYNC_OUTPUT,
 			     queue->queue_no, index, count, NULL);
-#ifdef CONFIG_QETH_PERF_STATS
-	queue->card->perf_stats.outbound_do_qdio_time += qeth_get_micros() -
-		queue->card->perf_stats.outbound_do_qdio_start_time;
-#endif
+	if (queue->card->options.performance_stats)
+		queue->card->perf_stats.outbound_do_qdio_time +=
+			qeth_get_micros() -
+			queue->card->perf_stats.outbound_do_qdio_start_time;
 	if (rc){
 		QETH_DBF_TEXT(trace, 2, "flushbuf");
 		QETH_DBF_TEXT_(trace, 2, " err%d", rc);
@@ -2890,9 +2888,8 @@ #endif
 		return;
 	}
 	atomic_add(count, &queue->used_buffers);
-#ifdef CONFIG_QETH_PERF_STATS
-	queue->card->perf_stats.bufs_sent += count;
-#endif
+	if (queue->card->options.performance_stats)
+		queue->card->perf_stats.bufs_sent += count;
 }
 
 /*
@@ -2907,9 +2904,8 @@ qeth_switch_to_packing_if_needed(struct 
 		    >= QETH_HIGH_WATERMARK_PACK){
 			/* switch non-PACKING -> PACKING */
 			QETH_DBF_TEXT(trace, 6, "np->pack");
-#ifdef CONFIG_QETH_PERF_STATS
-			queue->card->perf_stats.sc_dp_p++;
-#endif
+			if (queue->card->options.performance_stats)
+				queue->card->perf_stats.sc_dp_p++;
 			queue->do_pack = 1;
 		}
 	}
@@ -2932,9 +2928,8 @@ qeth_switch_to_nonpacking_if_needed(stru
 		    <= QETH_LOW_WATERMARK_PACK) {
 			/* switch PACKING -> non-PACKING */
 			QETH_DBF_TEXT(trace, 6, "pack->np");
-#ifdef CONFIG_QETH_PERF_STATS
-			queue->card->perf_stats.sc_p_dp++;
-#endif
+			if (queue->card->options.performance_stats)
+				queue->card->perf_stats.sc_p_dp++;
 			queue->do_pack = 0;
 			/* flush packing buffers */
 			buffer = &queue->bufs[queue->next_buf_to_fill];
@@ -2946,7 +2941,7 @@ #endif
 				queue->next_buf_to_fill =
 					(queue->next_buf_to_fill + 1) %
 					QDIO_MAX_BUFFERS_PER_Q;
-		 	}
+			}
 		}
 	}
 	return flush_count;
@@ -3002,11 +2997,10 @@ qeth_check_outbound_queue(struct qeth_qd
 			    !atomic_read(&queue->set_pci_flags_count))
 				flush_cnt +=
 					qeth_flush_buffers_on_no_pci(queue);
-#ifdef CONFIG_QETH_PERF_STATS
-			if (q_was_packing)
+			if (queue->card->options.performance_stats &&
+			    q_was_packing)
 				queue->card->perf_stats.bufs_sent_pack +=
 					flush_cnt;
-#endif
 			if (flush_cnt)
 				qeth_flush_buffers(queue, 1, index, flush_cnt);
 			atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
@@ -3036,10 +3030,11 @@ qeth_qdio_output_handler(struct ccw_devi
 			return;
 		}
 	}
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.outbound_handler_cnt++;
-	card->perf_stats.outbound_handler_start_time = qeth_get_micros();
-#endif
+	if (card->options.performance_stats) {
+		card->perf_stats.outbound_handler_cnt++;
+		card->perf_stats.outbound_handler_start_time =
+			qeth_get_micros();
+	}
 	for(i = first_element; i < (first_element + count); ++i){
 		buffer = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
 		/*we only handle the KICK_IT error by doing a recovery */
@@ -3058,10 +3053,9 @@ #endif
 		qeth_check_outbound_queue(queue);
 
 	netif_wake_queue(queue->card->dev);
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.outbound_handler_time += qeth_get_micros() -
-		card->perf_stats.outbound_handler_start_time;
-#endif
+	if (card->options.performance_stats)
+		card->perf_stats.outbound_handler_time += qeth_get_micros() -
+			card->perf_stats.outbound_handler_start_time;
 }
 
 static void
@@ -3185,13 +3179,14 @@ qeth_alloc_qdio_buffers(struct qeth_card
 
 	QETH_DBF_TEXT(setup, 2, "allcqdbf");
 
-	if (card->qdio.state == QETH_QDIO_ALLOCATED)
+	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED,
+		QETH_QDIO_ALLOCATED) != QETH_QDIO_UNINITIALIZED)
 		return 0;
 
 	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q),
 				  GFP_KERNEL|GFP_DMA);
 	if (!card->qdio.in_q)
-		return - ENOMEM;
+		goto out_nomem;
 	QETH_DBF_TEXT(setup, 2, "inq");
 	QETH_DBF_HEX(setup, 2, &card->qdio.in_q, sizeof(void *));
 	memset(card->qdio.in_q, 0, sizeof(struct qeth_qdio_q));
@@ -3200,27 +3195,19 @@ qeth_alloc_qdio_buffers(struct qeth_card
 		card->qdio.in_q->bufs[i].buffer =
 			&card->qdio.in_q->qdio_bufs[i];
 	/* inbound buffer pool */
-	if (qeth_alloc_buffer_pool(card)){
-		kfree(card->qdio.in_q);
-		return -ENOMEM;
-	}
+	if (qeth_alloc_buffer_pool(card))
+		goto out_freeinq;
 	/* outbound */
 	card->qdio.out_qs =
 		kmalloc(card->qdio.no_out_queues *
 			sizeof(struct qeth_qdio_out_q *), GFP_KERNEL);
-	if (!card->qdio.out_qs){
-		qeth_free_buffer_pool(card);
-		return -ENOMEM;
-	}
-	for (i = 0; i < card->qdio.no_out_queues; ++i){
+	if (!card->qdio.out_qs)
+		goto out_freepool;
+	for (i = 0; i < card->qdio.no_out_queues; ++i) {
 		card->qdio.out_qs[i] = kmalloc(sizeof(struct qeth_qdio_out_q),
 					       GFP_KERNEL|GFP_DMA);
-		if (!card->qdio.out_qs[i]){
-			while (i > 0)
-				kfree(card->qdio.out_qs[--i]);
-			kfree(card->qdio.out_qs);
-			return -ENOMEM;
-		}
+		if (!card->qdio.out_qs[i])
+			goto out_freeoutq;
 		QETH_DBF_TEXT_(setup, 2, "outq %i", i);
 		QETH_DBF_HEX(setup, 2, &card->qdio.out_qs[i], sizeof(void *));
 		memset(card->qdio.out_qs[i], 0, sizeof(struct qeth_qdio_out_q));
@@ -3237,8 +3224,19 @@ qeth_alloc_qdio_buffers(struct qeth_card
 			INIT_LIST_HEAD(&card->qdio.out_qs[i]->bufs[j].ctx_list);
 		}
 	}
-	card->qdio.state = QETH_QDIO_ALLOCATED;
 	return 0;
+
+out_freeoutq:
+	while (i > 0)
+		kfree(card->qdio.out_qs[--i]);
+	kfree(card->qdio.out_qs);
+out_freepool:
+	qeth_free_buffer_pool(card);
+out_freeinq:
+	kfree(card->qdio.in_q);
+out_nomem:
+	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
+	return -ENOMEM;
 }
 
 static void
@@ -3247,7 +3245,8 @@ qeth_free_qdio_buffers(struct qeth_card 
 	int i, j;
 
 	QETH_DBF_TEXT(trace, 2, "freeqdbf");
-	if (card->qdio.state == QETH_QDIO_UNINITIALIZED)
+	if (atomic_swap(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
+		QETH_QDIO_UNINITIALIZED)
 		return;
 	kfree(card->qdio.in_q);
 	/* inbound buffer pool */
@@ -3260,7 +3259,6 @@ qeth_free_qdio_buffers(struct qeth_card 
 		kfree(card->qdio.out_qs[i]);
 	}
 	kfree(card->qdio.out_qs);
-	card->qdio.state = QETH_QDIO_UNINITIALIZED;
 }
 
 static void
@@ -3282,7 +3280,7 @@ static void
 qeth_init_qdio_info(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(setup, 4, "intqdinf");
-	card->qdio.state = QETH_QDIO_UNINITIALIZED;
+	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
 	/* inbound */
 	card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
 	card->qdio.init_pool.buf_count = QETH_IN_BUF_COUNT_DEFAULT;
@@ -3345,7 +3343,7 @@ qeth_qdio_establish(struct qeth_card *ca
 	struct qdio_buffer **in_sbal_ptrs;
 	struct qdio_buffer **out_sbal_ptrs;
 	int i, j, k;
-	int rc;
+	int rc = 0;
 
 	QETH_DBF_TEXT(setup, 2, "qdioest");
 
@@ -3404,8 +3402,10 @@ qeth_qdio_establish(struct qeth_card *ca
 	init_data.input_sbal_addr_array  = (void **) in_sbal_ptrs;
 	init_data.output_sbal_addr_array = (void **) out_sbal_ptrs;
 
-	if (!(rc = qdio_initialize(&init_data)))
-		card->qdio.state = QETH_QDIO_ESTABLISHED;
+	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_ALLOCATED,
+		QETH_QDIO_ESTABLISHED) == QETH_QDIO_ALLOCATED)
+		if ((rc = qdio_initialize(&init_data)))
+			atomic_set(&card->qdio.state, QETH_QDIO_ALLOCATED);
 
 	kfree(out_sbal_ptrs);
 	kfree(in_sbal_ptrs);
@@ -3521,13 +3521,20 @@ qeth_qdio_clear_card(struct qeth_card *c
 	int rc = 0;
 
 	QETH_DBF_TEXT(trace,3,"qdioclr");
-	if (card->qdio.state == QETH_QDIO_ESTABLISHED){
+	switch (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_ESTABLISHED,
+		QETH_QDIO_CLEANING)) {
+	case QETH_QDIO_ESTABLISHED:
 		if ((rc = qdio_cleanup(CARD_DDEV(card),
-			     (card->info.type == QETH_CARD_TYPE_IQD) ?
-			     QDIO_FLAG_CLEANUP_USING_HALT :
-			     QDIO_FLAG_CLEANUP_USING_CLEAR)))
+				(card->info.type == QETH_CARD_TYPE_IQD) ?
+				QDIO_FLAG_CLEANUP_USING_HALT :
+				QDIO_FLAG_CLEANUP_USING_CLEAR)))
 			QETH_DBF_TEXT_(trace, 3, "1err%d", rc);
-		card->qdio.state = QETH_QDIO_ALLOCATED;
+		atomic_set(&card->qdio.state, QETH_QDIO_ALLOCATED);
+		break;
+	case QETH_QDIO_CLEANING:
+		return rc;
+	default:
+		break;
 	}
 	if ((rc = qeth_clear_halt_card(card, use_halt)))
 		QETH_DBF_TEXT_(trace, 3, "2err%d", rc);
@@ -3687,10 +3694,10 @@ qeth_hard_start_xmit(struct sk_buff *skb
 		/* return OK; otherwise ksoftirqd goes to 100% */
 		return NETDEV_TX_OK;
 	}
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.outbound_cnt++;
-	card->perf_stats.outbound_start_time = qeth_get_micros();
-#endif
+	if (card->options.performance_stats) {
+		card->perf_stats.outbound_cnt++;
+		card->perf_stats.outbound_start_time = qeth_get_micros();
+	}
 	netif_stop_queue(dev);
 	if ((rc = qeth_send_packet(card, skb))) {
 		if (rc == -EBUSY) {
@@ -3704,10 +3711,9 @@ #endif
 		}
 	}
 	netif_wake_queue(dev);
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.outbound_time += qeth_get_micros() -
-		card->perf_stats.outbound_start_time;
-#endif
+	if (card->options.performance_stats)
+		card->perf_stats.outbound_time += qeth_get_micros() -
+			card->perf_stats.outbound_start_time;
 	return rc;
 }
 
@@ -3922,49 +3928,59 @@ qeth_get_ip_version(struct sk_buff *skb)
 	}
 }
 
-static inline int
-qeth_prepare_skb(struct qeth_card *card, struct sk_buff **skb,
-		 struct qeth_hdr **hdr, int ipv)
+static inline struct qeth_hdr *
+__qeth_prepare_skb(struct qeth_card *card, struct sk_buff *skb, int ipv)
 {
-	int rc = 0;
 #ifdef CONFIG_QETH_VLAN
 	u16 *tag;
-#endif
-
-	QETH_DBF_TEXT(trace, 6, "prepskb");
-	if (card->info.type == QETH_CARD_TYPE_OSN) {
-		*hdr = (struct qeth_hdr *)(*skb)->data;
-		return rc;
-	}
-        rc = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
-        if (rc)
-                return rc;
-#ifdef CONFIG_QETH_VLAN
-	if (card->vlangrp && vlan_tx_tag_present(*skb) &&
+	if (card->vlangrp && vlan_tx_tag_present(skb) &&
 	    ((ipv == 6) || card->options.layer2) ) {
 		/*
 		 * Move the mac addresses (6 bytes src, 6 bytes dest)
 		 * to the beginning of the new header.  We are using three
 		 * memcpys instead of one memmove to save cycles.
 		 */
-		skb_push(*skb, VLAN_HLEN);
-		memcpy((*skb)->data, (*skb)->data + 4, 4);
-		memcpy((*skb)->data + 4, (*skb)->data + 8, 4);
-		memcpy((*skb)->data + 8, (*skb)->data + 12, 4);
-		tag = (u16 *)((*skb)->data + 12);
+		skb_push(skb, VLAN_HLEN);
+		memcpy(skb->data, skb->data + 4, 4);
+		memcpy(skb->data + 4, skb->data + 8, 4);
+		memcpy(skb->data + 8, skb->data + 12, 4);
+		tag = (u16 *)(skb->data + 12);
 		/*
 		 * first two bytes  = ETH_P_8021Q (0x8100)
 		 * second two bytes = VLANID
 		 */
 		*tag = __constant_htons(ETH_P_8021Q);
-		*(tag + 1) = htons(vlan_tx_tag_get(*skb));
+		*(tag + 1) = htons(vlan_tx_tag_get(skb));
 	}
 #endif
-	*hdr = (struct qeth_hdr *)
-		qeth_push_skb(card, skb, sizeof(struct qeth_hdr));
-	if (*hdr == NULL)
-		return -EINVAL;
-	return 0;
+	return ((struct qeth_hdr *)
+		qeth_push_skb(card, skb, sizeof(struct qeth_hdr)));
+}
+
+static inline void
+__qeth_free_new_skb(struct sk_buff *orig_skb, struct sk_buff *new_skb)
+{
+	if (orig_skb != new_skb)
+		dev_kfree_skb_any(new_skb);
+}
+
+static inline struct sk_buff *
+qeth_prepare_skb(struct qeth_card *card, struct sk_buff *skb,
+		 struct qeth_hdr **hdr, int ipv)
+{
+	struct sk_buff *new_skb;
+	
+	QETH_DBF_TEXT(trace, 6, "prepskb");
+
+        new_skb = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
+       	if (new_skb == NULL)
+		return NULL;
+	*hdr = __qeth_prepare_skb(card, new_skb, ipv);
+	if (*hdr == NULL) {
+		__qeth_free_new_skb(skb, new_skb);
+		return NULL;
+	}
+	return new_skb;
 }
 
 static inline u8
@@ -4206,9 +4222,8 @@ qeth_fill_buffer(struct qeth_qdio_out_q 
 		flush_cnt = 1;
 	} else {
 		QETH_DBF_TEXT(trace, 6, "fillbfpa");
-#ifdef CONFIG_QETH_PERF_STATS
-		queue->card->perf_stats.skbs_sent_pack++;
-#endif
+		if (queue->card->options.performance_stats)
+			queue->card->perf_stats.skbs_sent_pack++;
 		if (buf->next_element_to_fill >=
 				QETH_MAX_BUFFER_ELEMENTS(queue->card)) {
 			/*
@@ -4245,21 +4260,15 @@ qeth_do_send_packet_fast(struct qeth_car
 	 * check if buffer is empty to make sure that we do not 'overtake'
 	 * ourselves and try to fill a buffer that is already primed
 	 */
-	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) {
-		card->stats.tx_dropped++;
-		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
-		return -EBUSY;
-	}
+	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) 
+		goto out;
 	if (ctx == NULL)
 		queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
 					  QDIO_MAX_BUFFERS_PER_Q;
 	else {
 		buffers_needed = qeth_eddp_check_buffers_for_context(queue,ctx);
-		if (buffers_needed < 0) {
-			card->stats.tx_dropped++;
-			atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
-			return -EBUSY;
-		}
+		if (buffers_needed < 0) 
+			goto out;
 		queue->next_buf_to_fill =
 			(queue->next_buf_to_fill + buffers_needed) %
 			QDIO_MAX_BUFFERS_PER_Q;
@@ -4274,6 +4283,9 @@ qeth_do_send_packet_fast(struct qeth_car
 		qeth_flush_buffers(queue, 0, index, flush_cnt);
 	}
 	return 0;
+out:
+	atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
+	return -EBUSY;
 }
 
 static inline int
@@ -4299,8 +4311,7 @@ qeth_do_send_packet(struct qeth_card *ca
 	 * check if buffer is empty to make sure that we do not 'overtake'
 	 * ourselves and try to fill a buffer that is already primed
 	 */
-	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY){
-		card->stats.tx_dropped++;
+	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) {
 		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 		return -EBUSY;
 	}
@@ -4323,7 +4334,6 @@ qeth_do_send_packet(struct qeth_card *ca
 				 * again */
 				if (atomic_read(&buffer->state) !=
 						QETH_QDIO_BUF_EMPTY){
-					card->stats.tx_dropped++;
 					qeth_flush_buffers(queue, 0, start_index, flush_count);
 					atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 					return -EBUSY;
@@ -4334,7 +4344,6 @@ qeth_do_send_packet(struct qeth_card *ca
 			 * free buffers) to handle eddp context */
 			if (qeth_eddp_check_buffers_for_context(queue,ctx) < 0){
 				printk("eddp tx_dropped 1\n");
-				card->stats.tx_dropped++;
 				rc = -EBUSY;
 				goto out;
 			}
@@ -4346,7 +4355,6 @@ qeth_do_send_packet(struct qeth_card *ca
 		tmp = qeth_eddp_fill_buffer(queue,ctx,queue->next_buf_to_fill);
 		if (tmp < 0) {
 			printk("eddp tx_dropped 2\n");
-			card->stats.tx_dropped++;
 			rc = - EBUSY;
 			goto out;
 		}
@@ -4380,10 +4388,8 @@ out:
 			qeth_flush_buffers(queue, 0, start_index, flush_count);
 	}
 	/* at this point the queue is UNLOCKED again */
-#ifdef CONFIG_QETH_PERF_STATS
-	if (do_pack)
+	if (queue->card->options.performance_stats && do_pack)
 		queue->card->perf_stats.bufs_sent_pack += flush_count;
-#endif /* CONFIG_QETH_PERF_STATS */
 
 	return rc;
 }
@@ -4394,21 +4400,21 @@ qeth_get_elements_no(struct qeth_card *c
 {
 	int elements_needed = 0;
 
-        if (skb_shinfo(skb)->nr_frags > 0) {
+        if (skb_shinfo(skb)->nr_frags > 0) 
                 elements_needed = (skb_shinfo(skb)->nr_frags + 1);
-	}
-        if (elements_needed == 0 )
+        if (elements_needed == 0)
                 elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
                                         + skb->len) >> PAGE_SHIFT);
 	if ((elements_needed + elems) > QETH_MAX_BUFFER_ELEMENTS(card)){
-                PRINT_ERR("qeth_do_send_packet: invalid size of "
-                          "IP packet (Number=%d / Length=%d). Discarded.\n",
+                PRINT_ERR("Invalid size of IP packet "
+			  "(Number=%d / Length=%d). Discarded.\n",
                           (elements_needed+elems), skb->len);
                 return 0;
         }
         return elements_needed;
 }
 
+
 static inline int
 qeth_send_packet(struct qeth_card *card, struct sk_buff *skb)
 {
@@ -4420,112 +4426,112 @@ qeth_send_packet(struct qeth_card *card,
 	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
 	struct qeth_eddp_context *ctx = NULL;
 	int tx_bytes = skb->len;
-#ifdef CONFIG_QETH_PERF_STATS
 	unsigned short nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned short tso_size = skb_shinfo(skb)->gso_size;
-#endif
+	struct sk_buff *new_skb, *new_skb2;
 	int rc;
 
 	QETH_DBF_TEXT(trace, 6, "sendpkt");
 
+	new_skb = skb;
+	if ((card->info.type == QETH_CARD_TYPE_OSN) &&
+	    (skb->protocol == htons(ETH_P_IPV6)))
+		return -EPERM;
+	cast_type = qeth_get_cast_type(card, skb);
+	if ((cast_type == RTN_BROADCAST) &&
+	    (card->info.broadcast_capable == 0))
+		return -EPERM;
+	queue = card->qdio.out_qs
+		[qeth_get_priority_queue(card, skb, ipv, cast_type)];
 	if (!card->options.layer2) {
 		ipv = qeth_get_ip_version(skb);
 		if ((card->dev->hard_header == qeth_fake_header) && ipv) {
-               		if ((skb = qeth_pskb_unshare(skb,GFP_ATOMIC)) == NULL) {
-                        	card->stats.tx_dropped++;
-                        	dev_kfree_skb_irq(skb);
-                        	return 0;
-                	}
+			new_skb = qeth_pskb_unshare(skb, GFP_ATOMIC);
+			if (!new_skb)
+				return -ENOMEM;
 			if(card->dev->type == ARPHRD_IEEE802_TR){
-				skb_pull(skb, QETH_FAKE_LL_LEN_TR);
+				skb_pull(new_skb, QETH_FAKE_LL_LEN_TR);
 			} else {
-                		skb_pull(skb, QETH_FAKE_LL_LEN_ETH);
+				skb_pull(new_skb, QETH_FAKE_LL_LEN_ETH);
 			}
 		}
 	}
-	if ((card->info.type == QETH_CARD_TYPE_OSN) &&
-		(skb->protocol == htons(ETH_P_IPV6))) {
-		dev_kfree_skb_any(skb);
-		return 0;
-	}
-	cast_type = qeth_get_cast_type(card, skb);
-	if ((cast_type == RTN_BROADCAST) &&
-	    (card->info.broadcast_capable == 0)){
-		card->stats.tx_dropped++;
-		card->stats.tx_errors++;
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
-	queue = card->qdio.out_qs
-		[qeth_get_priority_queue(card, skb, ipv, cast_type)];
-
 	if (skb_is_gso(skb))
 		large_send = card->options.large_send;
-
-	/*are we able to do TSO ? If so ,prepare and send it from here */
+	/* check on OSN device*/
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		hdr = (struct qeth_hdr *)new_skb->data;
+	/*are we able to do TSO ? */
 	if ((large_send == QETH_LARGE_SEND_TSO) &&
 	    (cast_type == RTN_UNSPEC)) {
-		rc = qeth_tso_prepare_packet(card, skb, ipv, cast_type);
+		rc = qeth_tso_prepare_packet(card, new_skb, ipv, cast_type);
 		if (rc) {
-			card->stats.tx_dropped++;
-			card->stats.tx_errors++;
-			dev_kfree_skb_any(skb);
-			return NETDEV_TX_OK;
+			__qeth_free_new_skb(skb, new_skb);
+			return rc;
 		}
 		elements_needed++;
-	} else {
-		if ((rc = qeth_prepare_skb(card, &skb, &hdr, ipv))) {
-			QETH_DBF_TEXT_(trace, 4, "pskbe%d", rc);
-			return rc;
+	} else if (card->info.type != QETH_CARD_TYPE_OSN) {
+		new_skb2 = qeth_prepare_skb(card, new_skb, &hdr, ipv);
+		if (!new_skb2) {
+			__qeth_free_new_skb(skb, new_skb);
+			return -EINVAL;
 		}
-		if (card->info.type != QETH_CARD_TYPE_OSN)
-			qeth_fill_header(card, hdr, skb, ipv, cast_type);
+		if (new_skb != skb)
+			__qeth_free_new_skb(new_skb2, new_skb);
+		new_skb = new_skb2;
+		qeth_fill_header(card, hdr, new_skb, ipv, cast_type);
 	}
-
 	if (large_send == QETH_LARGE_SEND_EDDP) {
-		ctx = qeth_eddp_create_context(card, skb, hdr);
+		ctx = qeth_eddp_create_context(card, new_skb, hdr);
 		if (ctx == NULL) {
+			__qeth_free_new_skb(skb, new_skb);
 			PRINT_WARN("could not create eddp context\n");
 			return -EINVAL;
 		}
 	} else {
-		int elems = qeth_get_elements_no(card,(void*) hdr, skb,
+		int elems = qeth_get_elements_no(card,(void*) hdr, new_skb,
 						 elements_needed);
-		if (!elems)
+		if (!elems) {
+			__qeth_free_new_skb(skb, new_skb);
 			return -EINVAL;
+		}
 		elements_needed += elems;
 	}
 
 	if (card->info.type != QETH_CARD_TYPE_IQD)
-		rc = qeth_do_send_packet(card, queue, skb, hdr,
+		rc = qeth_do_send_packet(card, queue, new_skb, hdr,
 					 elements_needed, ctx);
 	else
-		rc = qeth_do_send_packet_fast(card, queue, skb, hdr,
+		rc = qeth_do_send_packet_fast(card, queue, new_skb, hdr,
 					      elements_needed, ctx);
-	if (!rc){
+	if (!rc) {
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += tx_bytes;
-#ifdef CONFIG_QETH_PERF_STATS
-		if (tso_size &&
-		   !(large_send == QETH_LARGE_SEND_NO)) {
-			card->perf_stats.large_send_bytes += tx_bytes;
-			card->perf_stats.large_send_cnt++;
-		}
- 		if (nr_frags > 0){
-			card->perf_stats.sg_skbs_sent++;
-			/* nr_frags + skb->data */
-			card->perf_stats.sg_frags_sent +=
-				nr_frags + 1;
+		if (new_skb != skb)
+			dev_kfree_skb_any(skb);
+		if (card->options.performance_stats) {
+			if (tso_size &&
+			    !(large_send == QETH_LARGE_SEND_NO)) {
+				card->perf_stats.large_send_bytes += tx_bytes;
+				card->perf_stats.large_send_cnt++;
+			}
+			if (nr_frags > 0) {
+				card->perf_stats.sg_skbs_sent++;
+				/* nr_frags + skb->data */
+				card->perf_stats.sg_frags_sent +=
+					nr_frags + 1;
+			}
 		}
-#endif /* CONFIG_QETH_PERF_STATS */
+	} else {
+		card->stats.tx_dropped++;
+		__qeth_free_new_skb(skb, new_skb);
 	}
 	if (ctx != NULL) {
 		/* drop creator's reference */
 		qeth_eddp_put_context(ctx);
 		/* free skb; it's not referenced by a buffer */
-		if (rc == 0)
-			dev_kfree_skb_any(skb);
-
+		if (!rc)
+		       dev_kfree_skb_any(new_skb);
 	}
 	return rc;
 }
@@ -7338,6 +7344,8 @@ qeth_setrouting_v6(struct qeth_card *car
 	QETH_DBF_TEXT(trace,3,"setrtg6");
 #ifdef CONFIG_QETH_IPV6
 
+	if (!qeth_is_supported(card, IPA_IPV6))
+		return 0;
 	qeth_correct_routing_type(card, &card->options.route6.type,
 				  QETH_PROT_IPV6);
 
@@ -7876,12 +7884,12 @@ __qeth_set_online(struct ccwgroup_device
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
 		goto out_remove;
 	}
-	card->state = CARD_STATE_SOFTSETUP;
 
 	if ((rc = qeth_init_qdio_queues(card))){
 		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
 		goto out_remove;
 	}
+	card->state = CARD_STATE_SOFTSETUP;
 	netif_carrier_on(card->dev);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
@@ -8538,34 +8546,44 @@ #endif /* CONFIG_QETH_IPV6 */
 static void
 qeth_sysfs_unregister(void)
 {
+	s390_root_dev_unregister(qeth_root_dev);
 	qeth_remove_driver_attributes();
 	ccw_driver_unregister(&qeth_ccw_driver);
 	ccwgroup_driver_unregister(&qeth_ccwgroup_driver);
-	s390_root_dev_unregister(qeth_root_dev);
 }
+
 /**
  * register qeth at sysfs
  */
 static int
 qeth_sysfs_register(void)
 {
-	int rc=0;
+	int rc;
 
 	rc = ccwgroup_driver_register(&qeth_ccwgroup_driver);
 	if (rc)
-		return rc;
+		goto out;
+
 	rc = ccw_driver_register(&qeth_ccw_driver);
 	if (rc)
-	 	return rc;
+		goto out_ccw_driver;
+
 	rc = qeth_create_driver_attributes();
 	if (rc)
-		return rc;
+		goto out_qeth_attr;
+
 	qeth_root_dev = s390_root_dev_register("qeth");
-	if (IS_ERR(qeth_root_dev)) {
-		rc = PTR_ERR(qeth_root_dev);
-		return rc;
-	}
-	return 0;
+	rc = IS_ERR(qeth_root_dev) ? PTR_ERR(qeth_root_dev) : 0;
+	if (!rc)
+		goto out;
+
+	qeth_remove_driver_attributes();
+out_qeth_attr:
+	ccw_driver_unregister(&qeth_ccw_driver);
+out_ccw_driver:
+	ccwgroup_driver_unregister(&qeth_ccwgroup_driver);
+out:
+	return rc;
 }
 
 /***
@@ -8574,7 +8592,7 @@ qeth_sysfs_register(void)
 static int __init
 qeth_init(void)
 {
-	int rc=0;
+	int rc;
 
 	PRINT_INFO("loading %s\n", version);
 
@@ -8583,20 +8601,26 @@ qeth_init(void)
 	spin_lock_init(&qeth_notify_lock);
 	rwlock_init(&qeth_card_list.rwlock);
 
-	if (qeth_register_dbf_views())
+	rc = qeth_register_dbf_views();
+	if (rc)
 		goto out_err;
-	if (qeth_sysfs_register())
-		goto out_sysfs;
+
+	rc = qeth_sysfs_register();
+	if (rc)
+		goto out_dbf;
 
 #ifdef CONFIG_QETH_IPV6
-	if (qeth_ipv6_init()) {
-		PRINT_ERR("Out of memory during ipv6 init.\n");
+	rc = qeth_ipv6_init();
+	if (rc) {
+		PRINT_ERR("Out of memory during ipv6 init code = %d\n", rc);
 		goto out_sysfs;
 	}
 #endif /* QETH_IPV6 */
-	if (qeth_register_notifiers())
+	rc = qeth_register_notifiers();
+	if (rc)
 		goto out_ipv6;
-	if (qeth_create_procfs_entries())
+	rc = qeth_create_procfs_entries();
+	if (rc)
 		goto out_notifiers;
 
 	return rc;
@@ -8606,12 +8630,13 @@ out_notifiers:
 out_ipv6:
 #ifdef CONFIG_QETH_IPV6
 	qeth_ipv6_uninit();
-#endif /* QETH_IPV6 */
 out_sysfs:
+#endif /* QETH_IPV6 */
 	qeth_sysfs_unregister();
+out_dbf:
 	qeth_unregister_dbf_views();
 out_err:
-	PRINT_ERR("Initialization failed");
+	PRINT_ERR("Initialization failed with code %d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
index 66f2da1..faa768e 100644
--- a/drivers/s390/net/qeth_proc.c
+++ b/drivers/s390/net/qeth_proc.c
@@ -173,7 +173,6 @@ static struct file_operations qeth_procf
 #define QETH_PERF_PROCFILE_NAME "qeth_perf"
 static struct proc_dir_entry *qeth_perf_procfile;
 
-#ifdef CONFIG_QETH_PERF_STATS
 static int
 qeth_perf_procfile_seq_show(struct seq_file *s, void *it)
 {
@@ -192,14 +191,21 @@ qeth_perf_procfile_seq_show(struct seq_f
 			CARD_DDEV_ID(card),
 			QETH_CARD_IFNAME(card)
 		  );
+	if (!card->options.performance_stats)
+		seq_printf(s, "Performance statistics are deactivated.\n");
 	seq_printf(s, "  Skb's/buffers received                 : %lu/%u\n"
 		      "  Skb's/buffers sent                     : %lu/%u\n\n",
-		        card->stats.rx_packets, card->perf_stats.bufs_rec,
-		        card->stats.tx_packets, card->perf_stats.bufs_sent
+		        card->stats.rx_packets -
+				card->perf_stats.initial_rx_packets,
+			card->perf_stats.bufs_rec,
+		        card->stats.tx_packets -
+				card->perf_stats.initial_tx_packets,
+			card->perf_stats.bufs_sent
 		  );
 	seq_printf(s, "  Skb's/buffers sent without packing     : %lu/%u\n"
 		      "  Skb's/buffers sent with packing        : %u/%u\n\n",
-		   card->stats.tx_packets - card->perf_stats.skbs_sent_pack,
+		   card->stats.tx_packets - card->perf_stats.initial_tx_packets
+					  - card->perf_stats.skbs_sent_pack,
 		   card->perf_stats.bufs_sent - card->perf_stats.bufs_sent_pack,
 		   card->perf_stats.skbs_sent_pack,
 		   card->perf_stats.bufs_sent_pack
@@ -275,11 +281,6 @@ static struct file_operations qeth_perf_
 	.release = seq_release,
 };
 
-#define qeth_perf_procfile_created qeth_perf_procfile
-#else
-#define qeth_perf_procfile_created 1
-#endif /* CONFIG_QETH_PERF_STATS */
-
 int __init
 qeth_create_procfs_entries(void)
 {
@@ -288,15 +289,13 @@ qeth_create_procfs_entries(void)
 	if (qeth_procfile)
 		qeth_procfile->proc_fops = &qeth_procfile_fops;
 
-#ifdef CONFIG_QETH_PERF_STATS
 	qeth_perf_procfile = create_proc_entry(QETH_PERF_PROCFILE_NAME,
 					   S_IFREG | 0444, NULL);
 	if (qeth_perf_procfile)
 		qeth_perf_procfile->proc_fops = &qeth_perf_procfile_fops;
-#endif /* CONFIG_QETH_PERF_STATS */
 
 	if (qeth_procfile &&
-	    qeth_perf_procfile_created)
+	    qeth_perf_procfile)
 		return 0;
 	else
 		return -ENOMEM;
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
index 001497b..5836737 100644
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
@@ -743,6 +743,47 @@ static DEVICE_ATTR(layer2, 0644, qeth_de
 		   qeth_dev_layer2_store);
 
 static ssize_t
+qeth_dev_performance_stats_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct qeth_card *card = dev->driver_data;
+
+	if (!card)
+		return -EINVAL;
+
+	return sprintf(buf, "%i\n", card->options.performance_stats ? 1:0);
+}
+
+static ssize_t
+qeth_dev_performance_stats_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct qeth_card *card = dev->driver_data;
+	char *tmp;
+	int i;
+
+	if (!card)
+		return -EINVAL;
+
+	i = simple_strtoul(buf, &tmp, 16);
+	if ((i == 0) || (i == 1)) {
+		if (i == card->options.performance_stats)
+			return count;
+		card->options.performance_stats = i;
+		if (i == 0)
+			memset(&card->perf_stats, 0,
+				sizeof(struct qeth_perf_stats));
+		card->perf_stats.initial_rx_packets = card->stats.rx_packets;
+		card->perf_stats.initial_tx_packets = card->stats.tx_packets;
+	} else {
+		PRINT_WARN("performance_stats: write 0 or 1 to this file!\n");
+		return -EINVAL;
+	}
+	return count;
+}
+
+static DEVICE_ATTR(performance_stats, 0644, qeth_dev_performance_stats_show,
+		   qeth_dev_performance_stats_store);
+
+static ssize_t
 qeth_dev_large_send_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
@@ -928,6 +969,7 @@ #endif
 	&dev_attr_canonical_macaddr,
 	&dev_attr_layer2,
 	&dev_attr_large_send,
+	&dev_attr_performance_stats,
 	NULL,
 };
 
@@ -1110,12 +1152,12 @@ qeth_parse_ipatoe(const char* buf, enum 
 {
 	const char *start, *end;
 	char *tmp;
-	char buffer[49] = {0, };
+	char buffer[40] = {0, };
 
 	start = buf;
 	/* get address string */
 	end = strchr(start, '/');
-	if (!end || (end-start >= 49)){
+	if (!end || (end - start >= 40)){
 		PRINT_WARN("Invalid format for ipato_addx/delx. "
 			   "Use <ip addr>/<mask bits>\n");
 		return -EINVAL;
@@ -1127,7 +1169,12 @@ qeth_parse_ipatoe(const char* buf, enum 
 	}
 	start = end + 1;
 	*mask_bits = simple_strtoul(start, &tmp, 10);
-
+	if (!strlen(start) ||
+	    (tmp == start) ||
+	    (*mask_bits > ((proto == QETH_PROT_IPV4) ? 32 : 128))) {
+		PRINT_WARN("Invalid mask bits for ipato_addx/delx !\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -1698,11 +1745,16 @@ qeth_create_device_attributes(struct dev
 		sysfs_remove_group(&dev->kobj, &qeth_device_attr_group);
 		sysfs_remove_group(&dev->kobj, &qeth_device_ipato_group);
 		sysfs_remove_group(&dev->kobj, &qeth_device_vipa_group);
+		return ret;
 	}
-	if ((ret = sysfs_create_group(&dev->kobj, &qeth_device_blkt_group)))
+	if ((ret = sysfs_create_group(&dev->kobj, &qeth_device_blkt_group))){
+		sysfs_remove_group(&dev->kobj, &qeth_device_attr_group);
+		sysfs_remove_group(&dev->kobj, &qeth_device_ipato_group);
+		sysfs_remove_group(&dev->kobj, &qeth_device_vipa_group);
+		sysfs_remove_group(&dev->kobj, &qeth_device_rxip_group);
 		return ret;
-
-	return ret;
+	}
+	return 0;
 }
 
 void
diff --git a/drivers/s390/net/qeth_tso.h b/drivers/s390/net/qeth_tso.h
index 593f298..14504af 100644
--- a/drivers/s390/net/qeth_tso.h
+++ b/drivers/s390/net/qeth_tso.h
@@ -24,7 +24,7 @@ static inline struct qeth_hdr_tso *
 qeth_tso_prepare_skb(struct qeth_card *card, struct sk_buff **skb)
 {
 	QETH_DBF_TEXT(trace, 5, "tsoprsk");
-	return qeth_push_skb(card, skb, sizeof(struct qeth_hdr_tso));
+	return qeth_push_skb(card, *skb, sizeof(struct qeth_hdr_tso));
 }
 
 /**
