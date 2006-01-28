Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWA1Vol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWA1Vol (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWA1Vol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:44:41 -0500
Received: from havoc.gtf.org ([69.61.125.42]:6637 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750762AbWA1Voj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:44:39 -0500
Date: Sat, 28 Jan 2006 16:44:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060128214438.GA7340@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 arch/ppc/syslib/mv64x60.c         |    4 -
 drivers/net/acenic.c              |    4 +
 drivers/net/b44.c                 |    5 +
 drivers/net/bonding/bond_main.c   |    2 
 drivers/net/mv643xx_eth.c         |  108 ++++++++++++++++----------------------
 drivers/net/s2io.c                |    2 
 drivers/net/wireless/orinoco_cs.c |    4 -
 include/net/ieee80211.h           |    4 -
 net/ieee80211/ieee80211_rx.c      |   22 +++++--
 net/ieee80211/ieee80211_wx.c      |   12 +++-
 10 files changed, 89 insertions(+), 78 deletions(-)

Ananda Raju:
      s2io: scatter-gather fix

Dale Farnsworth:
      mv643xx_eth: Fix spinlock recursion bug
      mv643xx_eth: Whitespace cleanup
      mv643xx_eth: Fix for building as a module

Eric Sesterhenn:
      bonding: fix ->get_settings error checking
      acenic: fix checking of read_eeprom_byte() return values

Paolo Galtieri:
      mv643xx_eth: Update dev->last_rx on packet receive

Stephen Hemminger:
      b44: fix laptop carrier detect

Valdis.Kletnieks@vt.edu:
      orinoco_cs: tweak Vcc debugging messages

Zhu Yi:
      ieee80211: Fix problem with not decrypting broadcast packets
      ieee80211: Fix iwlist scan can only show about 20 APs
      ieee80211: Fix A band min and max channel definitions

diff --git a/arch/ppc/syslib/mv64x60.c b/arch/ppc/syslib/mv64x60.c
index 94ea346..1f01b7e 100644
--- a/arch/ppc/syslib/mv64x60.c
+++ b/arch/ppc/syslib/mv64x60.c
@@ -313,7 +313,7 @@ static struct platform_device mpsc1_devi
 };
 #endif
 
-#ifdef CONFIG_MV643XX_ETH
+#if defined(CONFIG_MV643XX_ETH) || defined(CONFIG_MV643XX_ETH_MODULE)
 static struct resource mv64x60_eth_shared_resources[] = {
 	[0] = {
 		.name	= "ethernet shared base",
@@ -456,7 +456,7 @@ static struct platform_device *mv64x60_p
 	&mpsc0_device,
 	&mpsc1_device,
 #endif
-#ifdef CONFIG_MV643XX_ETH
+#if defined(CONFIG_MV643XX_ETH) || defined(CONFIG_MV643XX_ETH_MODULE)
 	&mv64x60_eth_shared_device,
 #endif
 #ifdef CONFIG_MV643XX_ETH_0
diff --git a/drivers/net/acenic.c b/drivers/net/acenic.c
index b8953de..b508812 100644
--- a/drivers/net/acenic.c
+++ b/drivers/net/acenic.c
@@ -1002,6 +1002,8 @@ static int __devinit ace_init(struct net
 
 	mac1 = 0;
 	for(i = 0; i < 4; i++) {
+		int tmp;
+
 		mac1 = mac1 << 8;
 		tmp = read_eeprom_byte(dev, 0x8c+i);
 		if (tmp < 0) {
@@ -1012,6 +1014,8 @@ static int __devinit ace_init(struct net
 	}
 	mac2 = 0;
 	for(i = 4; i < 8; i++) {
+		int tmp;
+
 		mac2 = mac2 << 8;
 		tmp = read_eeprom_byte(dev, 0x8c+i);
 		if (tmp < 0) {
diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index df9d6e8..c3267e4 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -1399,7 +1399,6 @@ static int b44_open(struct net_device *d
 	b44_init_rings(bp);
 	b44_init_hw(bp);
 
-	netif_carrier_off(dev);
 	b44_check_phy(bp);
 
 	err = request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev);
@@ -1464,7 +1463,7 @@ static int b44_close(struct net_device *
 #endif
 	b44_halt(bp);
 	b44_free_rings(bp);
-	netif_carrier_off(bp->dev);
+	netif_carrier_off(dev);
 
 	spin_unlock_irq(&bp->lock);
 
@@ -2000,6 +1999,8 @@ static int __devinit b44_init_one(struct
 	dev->irq = pdev->irq;
 	SET_ETHTOOL_OPS(dev, &b44_ethtool_ops);
 
+	netif_carrier_off(dev);
+
 	err = b44_get_invariants(bp);
 	if (err) {
 		printk(KERN_ERR PFX "Problem fetching invariants of chip, "
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2582d98..4ff006c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -576,7 +576,7 @@ static int bond_update_speed_duplex(stru
 	slave->duplex = DUPLEX_FULL;
 
 	if (slave_dev->ethtool_ops) {
-		u32 res;
+		int res;
 
 		if (!slave_dev->ethtool_ops->get_settings) {
 			return -1;
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 40ae36b..7ef4b04 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -444,6 +444,7 @@ static int mv643xx_eth_receive_queue(str
 			netif_rx(skb);
 #endif
 		}
+		dev->last_rx = jiffies;
 	}
 
 	return received_packets;
@@ -461,7 +462,7 @@ static int mv643xx_eth_receive_queue(str
  */
 
 static irqreturn_t mv643xx_eth_int_handler(int irq, void *dev_id,
-							struct pt_regs *regs)
+						struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct mv643xx_private *mp = netdev_priv(dev);
@@ -1047,16 +1048,15 @@ static int mv643xx_poll(struct net_devic
 
 static inline unsigned int has_tiny_unaligned_frags(struct sk_buff *skb)
 {
-        unsigned int frag;
-        skb_frag_t *fragp;
+	unsigned int frag;
+	skb_frag_t *fragp;
 
-        for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
-                fragp = &skb_shinfo(skb)->frags[frag];
-                if (fragp->size <= 8 && fragp->page_offset & 0x7)
-                        return 1;
-
-        }
-        return 0;
+	for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
+		fragp = &skb_shinfo(skb)->frags[frag];
+		if (fragp->size <= 8 && fragp->page_offset & 0x7)
+			return 1;
+	}
+	return 0;
 }
 
 
@@ -2137,26 +2137,26 @@ static void eth_port_set_multicast_list(
 	 */
 	if ((dev->flags & IFF_PROMISC) || (dev->flags & IFF_ALLMULTI)) {
 		for (table_index = 0; table_index <= 0xFC; table_index += 4) {
-			 /* Set all entries in DA filter special multicast
-			  * table (Ex_dFSMT)
-			  * Set for ETH_Q0 for now
-			  * Bits
-			  * 0	  Accept=1, Drop=0
-			  * 3-1  Queue	 ETH_Q0=0
-			  * 7-4  Reserved = 0;
-			  */
-			 mv_write(MV643XX_ETH_DA_FILTER_SPECIAL_MULTICAST_TABLE_BASE(eth_port_num) + table_index, 0x01010101);
-
-			 /* Set all entries in DA filter other multicast
-			  * table (Ex_dFOMT)
-			  * Set for ETH_Q0 for now
-			  * Bits
-			  * 0	  Accept=1, Drop=0
-			  * 3-1  Queue	 ETH_Q0=0
-			  * 7-4  Reserved = 0;
-			  */
-			 mv_write(MV643XX_ETH_DA_FILTER_OTHER_MULTICAST_TABLE_BASE(eth_port_num) + table_index, 0x01010101);
-       	}
+			/* Set all entries in DA filter special multicast
+			 * table (Ex_dFSMT)
+			 * Set for ETH_Q0 for now
+			 * Bits
+			 * 0	  Accept=1, Drop=0
+			 * 3-1  Queue	 ETH_Q0=0
+			 * 7-4  Reserved = 0;
+			 */
+			mv_write(MV643XX_ETH_DA_FILTER_SPECIAL_MULTICAST_TABLE_BASE(eth_port_num) + table_index, 0x01010101);
+
+			/* Set all entries in DA filter other multicast
+			 * table (Ex_dFOMT)
+			 * Set for ETH_Q0 for now
+			 * Bits
+			 * 0	  Accept=1, Drop=0
+			 * 3-1  Queue	 ETH_Q0=0
+			 * 7-4  Reserved = 0;
+			 */
+			mv_write(MV643XX_ETH_DA_FILTER_OTHER_MULTICAST_TABLE_BASE(eth_port_num) + table_index, 0x01010101);
+		}
 		return;
 	}
 
@@ -2617,7 +2617,6 @@ static ETH_FUNC_RET_STATUS eth_port_send
 	struct eth_tx_desc *current_descriptor;
 	struct eth_tx_desc *first_descriptor;
 	u32 command;
-	unsigned long flags;
 
 	/* Do not process Tx ring in case of Tx ring resource error */
 	if (mp->tx_resource_err)
@@ -2634,8 +2633,6 @@ static ETH_FUNC_RET_STATUS eth_port_send
 		return ETH_ERROR;
 	}
 
-	spin_lock_irqsave(&mp->lock, flags);
-
 	mp->tx_ring_skbs++;
 	BUG_ON(mp->tx_ring_skbs > mp->tx_ring_size);
 
@@ -2685,15 +2682,11 @@ static ETH_FUNC_RET_STATUS eth_port_send
 		mp->tx_resource_err = 1;
 		mp->tx_curr_desc_q = tx_first_desc;
 
-		spin_unlock_irqrestore(&mp->lock, flags);
-
 		return ETH_QUEUE_LAST_RESOURCE;
 	}
 
 	mp->tx_curr_desc_q = tx_next_desc;
 
-	spin_unlock_irqrestore(&mp->lock, flags);
-
 	return ETH_OK;
 }
 #else
@@ -2704,14 +2697,11 @@ static ETH_FUNC_RET_STATUS eth_port_send
 	int tx_desc_used;
 	struct eth_tx_desc *current_descriptor;
 	unsigned int command_status;
-	unsigned long flags;
 
 	/* Do not process Tx ring in case of Tx ring resource error */
 	if (mp->tx_resource_err)
 		return ETH_QUEUE_FULL;
 
-	spin_lock_irqsave(&mp->lock, flags);
-
 	mp->tx_ring_skbs++;
 	BUG_ON(mp->tx_ring_skbs > mp->tx_ring_size);
 
@@ -2742,12 +2732,9 @@ static ETH_FUNC_RET_STATUS eth_port_send
 	/* Check for ring index overlap in the Tx desc ring */
 	if (tx_desc_curr == tx_desc_used) {
 		mp->tx_resource_err = 1;
-
-		spin_unlock_irqrestore(&mp->lock, flags);
 		return ETH_QUEUE_LAST_RESOURCE;
 	}
 
-	spin_unlock_irqrestore(&mp->lock, flags);
 	return ETH_OK;
 }
 #endif
@@ -2898,8 +2885,10 @@ static ETH_FUNC_RET_STATUS eth_port_rece
 	p_pkt_info->return_info = mp->rx_skb[rx_curr_desc];
 	p_pkt_info->l4i_chk = p_rx_desc->buf_size;
 
-	/* Clean the return info field to indicate that the packet has been */
-	/* moved to the upper layers					    */
+	/*
+	 * Clean the return info field to indicate that the
+	 * packet has been moved to the upper layers
+	 */
 	mp->rx_skb[rx_curr_desc] = NULL;
 
 	/* Update current index in data structure */
@@ -2980,7 +2969,7 @@ struct mv643xx_stats {
 };
 
 #define MV643XX_STAT(m) sizeof(((struct mv643xx_private *)0)->m), \
-		      offsetof(struct mv643xx_private, m)
+					offsetof(struct mv643xx_private, m)
 
 static const struct mv643xx_stats mv643xx_gstrings_stats[] = {
 	{ "rx_packets", MV643XX_STAT(stats.rx_packets) },
@@ -3131,9 +3120,8 @@ mv643xx_get_settings(struct net_device *
 	return 0;
 }
 
-static void
-mv643xx_get_drvinfo(struct net_device *netdev,
-                       struct ethtool_drvinfo *drvinfo)
+static void mv643xx_get_drvinfo(struct net_device *netdev,
+				struct ethtool_drvinfo *drvinfo)
 {
 	strncpy(drvinfo->driver,  mv643xx_driver_name, 32);
 	strncpy(drvinfo->version, mv643xx_driver_version, 32);
@@ -3142,39 +3130,37 @@ mv643xx_get_drvinfo(struct net_device *n
 	drvinfo->n_stats = MV643XX_STATS_LEN;
 }
 
-static int 
-mv643xx_get_stats_count(struct net_device *netdev)
+static int mv643xx_get_stats_count(struct net_device *netdev)
 {
 	return MV643XX_STATS_LEN;
 }
 
-static void 
-mv643xx_get_ethtool_stats(struct net_device *netdev, 
-		struct ethtool_stats *stats, uint64_t *data)
+static void mv643xx_get_ethtool_stats(struct net_device *netdev,
+				struct ethtool_stats *stats, uint64_t *data)
 {
 	struct mv643xx_private *mp = netdev->priv;
 	int i;
 
 	eth_update_mib_counters(mp);
 
-	for(i = 0; i < MV643XX_STATS_LEN; i++) {
+	for (i = 0; i < MV643XX_STATS_LEN; i++) {
 		char *p = (char *)mp+mv643xx_gstrings_stats[i].stat_offset;	
-		data[i] = (mv643xx_gstrings_stats[i].sizeof_stat == 
+		data[i] = (mv643xx_gstrings_stats[i].sizeof_stat ==
 			sizeof(uint64_t)) ? *(uint64_t *)p : *(uint32_t *)p;
 	}
 }
 
-static void 
-mv643xx_get_strings(struct net_device *netdev, uint32_t stringset, uint8_t *data)
+static void mv643xx_get_strings(struct net_device *netdev, uint32_t stringset,
+				uint8_t *data)
 {
 	int i;
 
 	switch(stringset) {
 	case ETH_SS_STATS:
 		for (i=0; i < MV643XX_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN, 
-			mv643xx_gstrings_stats[i].stat_string,
-			ETH_GSTRING_LEN);
+			memcpy(data + i * ETH_GSTRING_LEN,
+					mv643xx_gstrings_stats[i].stat_string,
+					ETH_GSTRING_LEN);
 		}
 		break;
 	}
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index 89c4678..49b597c 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -3586,7 +3586,7 @@ static int s2io_xmit(struct sk_buff *skb
 		txdp->Buffer_Pointer = (u64) pci_map_page
 		    (sp->pdev, frag->page, frag->page_offset,
 		     frag->size, PCI_DMA_TODEVICE);
-		txdp->Control_1 |= TXD_BUFFER0_SIZE(frag->size);
+		txdp->Control_1 = TXD_BUFFER0_SIZE(frag->size);
 		if (skb_shinfo(skb)->ufo_size)
 			txdp->Control_1 |= TXD_UFO_EN;
 	}
diff --git a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
index b664708..3c128b6 100644
--- a/drivers/net/wireless/orinoco_cs.c
+++ b/drivers/net/wireless/orinoco_cs.c
@@ -261,13 +261,13 @@ orinoco_cs_config(dev_link_t *link)
 		/* Note that the CIS values need to be rescaled */
 		if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
 			if (conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000) {
-				DEBUG(2, "orinoco_cs_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
+				DEBUG(2, "orinoco_cs_config: Vcc mismatch (conf.Vcc = %d, cfg CIS = %d)\n",  conf.Vcc, cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
 				if (!ignore_cis_vcc)
 					goto next_entry;
 			}
 		} else if (dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
 			if (conf.Vcc != dflt.vcc.param[CISTPL_POWER_VNOM] / 10000) {
-				DEBUG(2, "orinoco_cs_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, dflt.vcc.param[CISTPL_POWER_VNOM] / 10000);
+				DEBUG(2, "orinoco_cs_config: Vcc mismatch (conf.Vcc = %d, dflt CIS = %d)\n",  conf.Vcc, dflt.vcc.param[CISTPL_POWER_VNOM] / 10000);
 				if(!ignore_cis_vcc)
 					goto next_entry;
 			}
diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
index df05f46..9a92aef 100644
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -803,9 +803,9 @@ enum ieee80211_state {
 #define IEEE80211_24GHZ_MAX_CHANNEL 14
 #define IEEE80211_24GHZ_CHANNELS    14
 
-#define IEEE80211_52GHZ_MIN_CHANNEL 36
+#define IEEE80211_52GHZ_MIN_CHANNEL 34
 #define IEEE80211_52GHZ_MAX_CHANNEL 165
-#define IEEE80211_52GHZ_CHANNELS    32
+#define IEEE80211_52GHZ_CHANNELS    131
 
 enum {
 	IEEE80211_CH_PASSIVE_ONLY = (1 << 0),
diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index 7a12180..695d047 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -350,6 +350,7 @@ int ieee80211_rx(struct ieee80211_device
 	u8 src[ETH_ALEN];
 	struct ieee80211_crypt_data *crypt = NULL;
 	int keyidx = 0;
+	int can_be_decrypted = 0;
 
 	hdr = (struct ieee80211_hdr_4addr *)skb->data;
 	stats = &ieee->stats;
@@ -410,12 +411,23 @@ int ieee80211_rx(struct ieee80211_device
 		return 1;
 	}
 
-	if (is_multicast_ether_addr(hdr->addr1)
-	    ? ieee->host_mc_decrypt : ieee->host_decrypt) {
+	can_be_decrypted = (is_multicast_ether_addr(hdr->addr1) ||
+			    is_broadcast_ether_addr(hdr->addr2)) ?
+	    ieee->host_mc_decrypt : ieee->host_decrypt;
+
+	if (can_be_decrypted) {
 		int idx = 0;
-		if (skb->len >= hdrlen + 3)
+		if (skb->len >= hdrlen + 3) {
+			/* Top two-bits of byte 3 are the key index */
 			idx = skb->data[hdrlen + 3] >> 6;
+		}
+
+		/* ieee->crypt[] is WEP_KEY (4) in length.  Given that idx
+		 * is only allowed 2-bits of storage, no value of idx can
+		 * be provided via above code that would result in idx
+		 * being out of range */
 		crypt = ieee->crypt[idx];
+
 #ifdef NOT_YET
 		sta = NULL;
 
@@ -553,7 +565,7 @@ int ieee80211_rx(struct ieee80211_device
 
 	/* skb: hdr + (possibly fragmented, possibly encrypted) payload */
 
-	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_PROTECTED) &&
+	if ((fc & IEEE80211_FCTL_PROTECTED) && can_be_decrypted &&
 	    (keyidx = ieee80211_rx_frame_decrypt(ieee, skb, crypt)) < 0)
 		goto rx_dropped;
 
@@ -617,7 +629,7 @@ int ieee80211_rx(struct ieee80211_device
 
 	/* skb: hdr + (possible reassembled) full MSDU payload; possibly still
 	 * encrypted/authenticated */
-	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_PROTECTED) &&
+	if ((fc & IEEE80211_FCTL_PROTECTED) && can_be_decrypted &&
 	    ieee80211_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt))
 		goto rx_dropped;
 
diff --git a/net/ieee80211/ieee80211_wx.c b/net/ieee80211/ieee80211_wx.c
index 23e1630..f87c6b8 100644
--- a/net/ieee80211/ieee80211_wx.c
+++ b/net/ieee80211/ieee80211_wx.c
@@ -232,15 +232,18 @@ static char *ipw2100_translate_scan(stru
 	return start;
 }
 
+#define SCAN_ITEM_SIZE 128
+
 int ieee80211_wx_get_scan(struct ieee80211_device *ieee,
 			  struct iw_request_info *info,
 			  union iwreq_data *wrqu, char *extra)
 {
 	struct ieee80211_network *network;
 	unsigned long flags;
+	int err = 0;
 
 	char *ev = extra;
-	char *stop = ev + IW_SCAN_MAX_DATA;
+	char *stop = ev + wrqu->data.length;
 	int i = 0;
 
 	IEEE80211_DEBUG_WX("Getting scan\n");
@@ -249,6 +252,11 @@ int ieee80211_wx_get_scan(struct ieee802
 
 	list_for_each_entry(network, &ieee->network_list, list) {
 		i++;
+		if (stop - ev < SCAN_ITEM_SIZE) {
+			err = -E2BIG;
+			break;
+		}
+
 		if (ieee->scan_age == 0 ||
 		    time_after(network->last_scanned + ieee->scan_age, jiffies))
 			ev = ipw2100_translate_scan(ieee, ev, stop, network);
@@ -270,7 +278,7 @@ int ieee80211_wx_get_scan(struct ieee802
 
 	IEEE80211_DEBUG_WX("exit: %d networks returned.\n", i);
 
-	return 0;
+	return err;
 }
 
 int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
