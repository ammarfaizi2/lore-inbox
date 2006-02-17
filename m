Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWBQVYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWBQVYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWBQVYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:24:07 -0500
Received: from havoc.gtf.org ([69.61.125.42]:64399 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751757AbWBQVYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:24:05 -0500
Date: Fri, 17 Feb 2006 16:24:03 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060217212403.GA23243@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/Kconfig               |    5 -
 drivers/net/bonding/bond_main.c   |    1 
 drivers/net/sis190.c              |    4 -
 drivers/net/skge.c                |   10 +++
 drivers/net/sky2.c                |   31 ++++++++++
 drivers/net/tokenring/smctr.h     |    2 
 drivers/net/wireless/atmel.c      |   98 ++++++++++++++++++++-------------
 drivers/net/wireless/wavelan_cs.c |   16 +----
 drivers/s390/net/lcs.c            |   31 +++++-----
 drivers/s390/net/lcs.h            |    2 
 drivers/s390/net/qeth.h           |  112 +++++++++++++++-----------------------
 drivers/s390/net/qeth_eddp.c      |   11 +++
 drivers/s390/net/qeth_main.c      |   17 ++---
 13 files changed, 189 insertions(+), 151 deletions(-)

Andrew Morton:
      smctr warning fix

Dan Williams:
      wireless/atmel: fix setting TX key only in ENCODEEXT
      wireless/atmel: fix Open System authentication process bugs

Francois Romieu:
      sis190: early setting of the pci driver private data

Frank Pavlic:
      s390: lcs performance enhancements
      s390: some qeth driver fixes

Jay Vosburgh:
      bonding: fix a locking bug in bond_release

Jean Tourrilhes:
      Wavelan_cs bitfield fixes

Stephen Hemminger:
      sk98lin: no d-link support (kconfig)
      skge: no longer experimental
      skge: speed setting
      sky2: speed setting fix

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 47c72a6..e45a8f9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2020,8 +2020,8 @@ config SIS190
 	  will be called sis190.  This is recommended.
 
 config SKGE
-	tristate "New SysKonnect GigaEthernet support (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	tristate "New SysKonnect GigaEthernet support"
+	depends on PCI
 	select CRC32
 	---help---
 	  This driver support the Marvell Yukon or SysKonnect SK-98xx/SK-95xx
@@ -2082,7 +2082,6 @@ config SK98LIN
 	    - Allied Telesyn AT-2971SX Gigabit Ethernet Adapter
 	    - Allied Telesyn AT-2971T Gigabit Ethernet Adapter
 	    - Belkin Gigabit Desktop Card 10/100/1000Base-T Adapter, Copper RJ-45
-	    - DGE-530T Gigabit Ethernet Adapter
 	    - EG1032 v2 Instant Gigabit Network Adapter
 	    - EG1064 v2 Instant Gigabit Network Adapter
 	    - Marvell 88E8001 Gigabit LOM Ethernet Adapter (Abit)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e0f51af..bcf9f17 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1581,6 +1581,7 @@ int bond_release(struct net_device *bond
 		printk(KERN_INFO DRV_NAME
 		       ": %s: %s not enslaved\n",
 		       bond_dev->name, slave_dev->name);
+		write_unlock_bh(&bond->lock);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/sis190.c b/drivers/net/sis190.c
index b420182..ed4bc91 100644
--- a/drivers/net/sis190.c
+++ b/drivers/net/sis190.c
@@ -1791,6 +1791,8 @@ static int __devinit sis190_init_one(str
 		goto out;
 	}
 
+	pci_set_drvdata(pdev, dev);
+
 	tp = netdev_priv(dev);
 	ioaddr = tp->mmio_addr;
 
@@ -1827,8 +1829,6 @@ static int __devinit sis190_init_one(str
 	if (rc < 0)
 		goto err_remove_mii;
 
-	pci_set_drvdata(pdev, dev);
-
 	net_probe(tp, KERN_INFO "%s: %s at %p (IRQ: %d), "
 	       "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x\n",
 	       pci_name(pdev), sis_chip_info[ent->driver_data].name,
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index bf55a4c..67fb19b 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -1697,6 +1697,7 @@ static void yukon_mac_init(struct skge_h
 	skge_write32(hw, SK_REG(port, GPHY_CTRL), reg | GPC_RST_SET);
 	skge_write32(hw, SK_REG(port, GPHY_CTRL), reg | GPC_RST_CLR);
 	skge_write32(hw, SK_REG(port, GMAC_CTRL), GMC_PAUSE_ON | GMC_RST_CLR);
+
 	if (skge->autoneg == AUTONEG_DISABLE) {
 		reg = GM_GPCR_AU_ALL_DIS;
 		gma_write16(hw, port, GM_GP_CTRL,
@@ -1704,16 +1705,23 @@ static void yukon_mac_init(struct skge_h
 
 		switch (skge->speed) {
 		case SPEED_1000:
+			reg &= ~GM_GPCR_SPEED_100;
 			reg |= GM_GPCR_SPEED_1000;
-			/* fallthru */
+			break;
 		case SPEED_100:
+			reg &= ~GM_GPCR_SPEED_1000;
 			reg |= GM_GPCR_SPEED_100;
+			break;
+		case SPEED_10:
+			reg &= ~(GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100);
+			break;
 		}
 
 		if (skge->duplex == DUPLEX_FULL)
 			reg |= GM_GPCR_DUP_FULL;
 	} else
 		reg = GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100 | GM_GPCR_DUP_FULL;
+
 	switch (skge->flow_control) {
 	case FLOW_MODE_NONE:
 		skge_write32(hw, SK_REG(port, GMAC_CTRL), GMC_PAUSE_OFF);
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index cae2edf..bfeba5b 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -520,10 +520,16 @@ static void sky2_mac_init(struct sky2_hw
 
 		switch (sky2->speed) {
 		case SPEED_1000:
+			reg &= ~GM_GPCR_SPEED_100;
 			reg |= GM_GPCR_SPEED_1000;
-			/* fallthru */
+			break;
 		case SPEED_100:
+			reg &= ~GM_GPCR_SPEED_1000;
 			reg |= GM_GPCR_SPEED_100;
+			break;
+		case SPEED_10:
+			reg &= ~(GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100);
+			break;
 		}
 
 		if (sky2->duplex == DUPLEX_FULL)
@@ -1446,6 +1452,29 @@ static void sky2_link_up(struct sky2_por
 	sky2_write8(hw, SK_REG(port, GMAC_IRQ_MSK), GMAC_DEF_MSK);
 
 	reg = gma_read16(hw, port, GM_GP_CTRL);
+	if (sky2->autoneg == AUTONEG_DISABLE) {
+		reg |= GM_GPCR_AU_ALL_DIS;
+
+		/* Is write/read necessary?  Copied from sky2_mac_init */
+		gma_write16(hw, port, GM_GP_CTRL, reg);
+		gma_read16(hw, port, GM_GP_CTRL);
+
+		switch (sky2->speed) {
+		case SPEED_1000:
+			reg &= ~GM_GPCR_SPEED_100;
+			reg |= GM_GPCR_SPEED_1000;
+			break;
+		case SPEED_100:
+			reg &= ~GM_GPCR_SPEED_1000;
+			reg |= GM_GPCR_SPEED_100;
+			break;
+		case SPEED_10:
+			reg &= ~(GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100);
+			break;
+		}
+	} else
+		reg &= ~GM_GPCR_AU_ALL_DIS;
+
 	if (sky2->duplex == DUPLEX_FULL || sky2->autoneg == AUTONEG_ENABLE)
 		reg |= GM_GPCR_DUP_FULL;
 
diff --git a/drivers/net/tokenring/smctr.h b/drivers/net/tokenring/smctr.h
index b306c7e..88dfa2e 100644
--- a/drivers/net/tokenring/smctr.h
+++ b/drivers/net/tokenring/smctr.h
@@ -1042,7 +1042,7 @@ typedef struct net_local {
         __u16            functional_address[2];
         __u16            bitwise_group_address[2];
 
-	__u8            *ptr_ucode;
+	const __u8       *ptr_ucode;
 
 	__u8		cleanup;
 
diff --git a/drivers/net/wireless/atmel.c b/drivers/net/wireless/atmel.c
index 98a76f1..dfc2401 100644
--- a/drivers/net/wireless/atmel.c
+++ b/drivers/net/wireless/atmel.c
@@ -1872,7 +1872,7 @@ static int atmel_set_encodeext(struct ne
 	struct atmel_private *priv = netdev_priv(dev);
 	struct iw_point *encoding = &wrqu->encoding;
 	struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
-	int idx, key_len;
+	int idx, key_len, alg = ext->alg, set_key = 1;
 
 	/* Determine and validate the key index */
 	idx = encoding->flags & IW_ENCODE_INDEX;
@@ -1883,39 +1883,42 @@ static int atmel_set_encodeext(struct ne
 	} else
 		idx = priv->default_key;
 
-	if ((encoding->flags & IW_ENCODE_DISABLED) ||
-	    ext->alg == IW_ENCODE_ALG_NONE) {
-		priv->wep_is_on = 0;
-		priv->encryption_level = 0;
-		priv->pairwise_cipher_suite = CIPHER_SUITE_NONE;
-	}
+	if (encoding->flags & IW_ENCODE_DISABLED)
+	    alg = IW_ENCODE_ALG_NONE;
 
-	if (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
+	if (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY) {
 		priv->default_key = idx;
+		set_key = ext->key_len > 0 ? 1 : 0;
+	}
 
-	/* Set the requested key */
-	switch (ext->alg) {
-	case IW_ENCODE_ALG_NONE:
-		break;
-	case IW_ENCODE_ALG_WEP:
-		if (ext->key_len > 5) {
-			priv->wep_key_len[idx] = 13;
-			priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_128;
-			priv->encryption_level = 2;
-		} else if (ext->key_len > 0) {
-			priv->wep_key_len[idx] = 5;
-			priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_64;
-			priv->encryption_level = 1;
-		} else {
+	if (set_key) {
+		/* Set the requested key first */
+		switch (alg) {
+		case IW_ENCODE_ALG_NONE:
+			priv->wep_is_on = 0;
+			priv->encryption_level = 0;
+			priv->pairwise_cipher_suite = CIPHER_SUITE_NONE;
+			break;
+		case IW_ENCODE_ALG_WEP:
+			if (ext->key_len > 5) {
+				priv->wep_key_len[idx] = 13;
+				priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_128;
+				priv->encryption_level = 2;
+			} else if (ext->key_len > 0) {
+				priv->wep_key_len[idx] = 5;
+				priv->pairwise_cipher_suite = CIPHER_SUITE_WEP_64;
+				priv->encryption_level = 1;
+			} else {
+				return -EINVAL;
+			}
+			priv->wep_is_on = 1;
+			memset(priv->wep_keys[idx], 0, 13);
+			key_len = min ((int)ext->key_len, priv->wep_key_len[idx]);
+			memcpy(priv->wep_keys[idx], ext->key, key_len);
+			break;
+		default:
 			return -EINVAL;
 		}
-		priv->wep_is_on = 1;
-		memset(priv->wep_keys[idx], 0, 13);
-		key_len = min ((int)ext->key_len, priv->wep_key_len[idx]);
-		memcpy(priv->wep_keys[idx], ext->key, key_len);
-		break;
-	default:
-		return -EINVAL;
 	}
 
 	return -EINPROGRESS;
@@ -3061,17 +3064,26 @@ static void authenticate(struct atmel_pr
 	}
 
 	if (status == C80211_MGMT_SC_Success && priv->wep_is_on) {
+		int should_associate = 0;
 		/* WEP */
 		if (trans_seq_no != priv->ExpectedAuthentTransactionSeqNum)
 			return;
 
-		if (trans_seq_no == 0x0002 &&
-		    auth->el_id == C80211_MGMT_ElementID_ChallengeText) {
-			send_authentication_request(priv, system, auth->chall_text, auth->chall_text_len);
-			return;
+		if (system == C80211_MGMT_AAN_OPENSYSTEM) {
+			if (trans_seq_no == 0x0002) {
+				should_associate = 1;
+			}
+		} else if (system == C80211_MGMT_AAN_SHAREDKEY) {
+			if (trans_seq_no == 0x0002 &&
+			    auth->el_id == C80211_MGMT_ElementID_ChallengeText) {
+				send_authentication_request(priv, system, auth->chall_text, auth->chall_text_len);
+				return;
+			} else if (trans_seq_no == 0x0004) {
+				should_associate = 1;
+			}
 		}
 
-		if (trans_seq_no == 0x0004) {
+		if (should_associate) {
 			if(priv->station_was_associated) {
 				atmel_enter_state(priv, STATION_STATE_REASSOCIATING);
 				send_association_request(priv, 1);
@@ -3084,11 +3096,13 @@ static void authenticate(struct atmel_pr
 		}
 	}
 
-	if (status == C80211_MGMT_SC_AuthAlgNotSupported) {
+	if (status == WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG) {
 		/* Do opensystem first, then try sharedkey */
-		if (system ==  C80211_MGMT_AAN_OPENSYSTEM) {
+		if (system == WLAN_AUTH_OPEN) {
 			priv->CurrentAuthentTransactionSeqNum = 0x001;
-			send_authentication_request(priv, C80211_MGMT_AAN_SHAREDKEY, NULL, 0);
+			priv->exclude_unencrypted = 1;
+			send_authentication_request(priv, WLAN_AUTH_SHARED_KEY, NULL, 0);
+			return;
 		} else if (priv->connect_to_any_BSS) {
 			int bss_index;
 
@@ -3439,10 +3453,13 @@ static void atmel_management_timer(u_lon
 			priv->AuthenticationRequestRetryCnt = 0;
 			restart_search(priv);
 		} else {
+			int auth = C80211_MGMT_AAN_OPENSYSTEM;
 			priv->AuthenticationRequestRetryCnt++;
 			priv->CurrentAuthentTransactionSeqNum = 0x0001;
 			mod_timer(&priv->management_timer, jiffies + MGMT_JIFFIES);
-			send_authentication_request(priv, C80211_MGMT_AAN_OPENSYSTEM, NULL, 0);
+			if (priv->wep_is_on && priv->exclude_unencrypted)
+				auth = C80211_MGMT_AAN_SHAREDKEY;
+			send_authentication_request(priv, auth, NULL, 0);
 	  }
 	  break;
 
@@ -3541,12 +3558,15 @@ static void atmel_command_irq(struct atm
 				priv->station_was_associated = priv->station_is_associated;
 				atmel_enter_state(priv, STATION_STATE_READY);
 			} else {
+				int auth = C80211_MGMT_AAN_OPENSYSTEM;
 				priv->AuthenticationRequestRetryCnt = 0;
 				atmel_enter_state(priv, STATION_STATE_AUTHENTICATING);
 
 				mod_timer(&priv->management_timer, jiffies + MGMT_JIFFIES);
 				priv->CurrentAuthentTransactionSeqNum = 0x0001;
-				send_authentication_request(priv, C80211_MGMT_AAN_SHAREDKEY, NULL, 0);
+				if (priv->wep_is_on && priv->exclude_unencrypted)
+					auth = C80211_MGMT_AAN_SHAREDKEY;
+				send_authentication_request(priv, auth, NULL, 0);
 			}
 			return;
 		}
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index cf37362..98122f3 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -950,16 +950,8 @@ wv_82593_cmd(struct net_device *	dev,
 static inline int
 wv_diag(struct net_device *	dev)
 {
-  int		ret = FALSE;
-
-  if(wv_82593_cmd(dev, "wv_diag(): diagnose",
-		  OP0_DIAGNOSE, SR0_DIAGNOSE_PASSED))
-    ret = TRUE;
-
-#ifdef DEBUG_CONFIG_ERRORS
-  printk(KERN_INFO "wavelan_cs: i82593 Self Test failed!\n");
-#endif
-  return(ret);
+  return(wv_82593_cmd(dev, "wv_diag(): diagnose",
+		      OP0_DIAGNOSE, SR0_DIAGNOSE_PASSED));
 } /* wv_diag */
 
 /*------------------------------------------------------------------*/
@@ -3604,8 +3596,8 @@ wv_82593_config(struct net_device *	dev)
   cfblk.lin_prio = 0;   	/* conform to 802.3 backoff algoritm */
   cfblk.exp_prio = 5;	        /* conform to 802.3 backoff algoritm */
   cfblk.bof_met = 1;	        /* conform to 802.3 backoff algoritm */
-  cfblk.ifrm_spc = 0x20;	/* 32 bit times interframe spacing */
-  cfblk.slottim_low = 0x20;	/* 32 bit times slot time */
+  cfblk.ifrm_spc = 0x20 >> 4;	/* 32 bit times interframe spacing */
+  cfblk.slottim_low = 0x20 >> 5;	/* 32 bit times slot time */
   cfblk.slottim_hi = 0x0;
   cfblk.max_retr = 15;
   cfblk.prmisc = ((lp->promiscuous) ? TRUE: FALSE);	/* Promiscuous mode */
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 6229ba4..9cf88d7 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -98,9 +98,9 @@ lcs_register_debug_facility(void)
 		return -ENOMEM;
 	}
 	debug_register_view(lcs_dbf_setup, &debug_hex_ascii_view);
-	debug_set_level(lcs_dbf_setup, 4);
+	debug_set_level(lcs_dbf_setup, 2);
 	debug_register_view(lcs_dbf_trace, &debug_hex_ascii_view);
-	debug_set_level(lcs_dbf_trace, 4);
+	debug_set_level(lcs_dbf_trace, 2);
 	return 0;
 }
 
@@ -1292,9 +1292,8 @@ lcs_set_multicast_list(struct net_device
         LCS_DBF_TEXT(4, trace, "setmulti");
         card = (struct lcs_card *) dev->priv;
 
-        if (!lcs_set_thread_start_bit(card, LCS_SET_MC_THREAD)) {
+        if (!lcs_set_thread_start_bit(card, LCS_SET_MC_THREAD)) 
 		schedule_work(&card->kernel_thread_starter);
-	}
 }
 
 #endif /* CONFIG_IP_MULTICAST */
@@ -1459,6 +1458,8 @@ lcs_txbuffer_cb(struct lcs_channel *chan
 	lcs_release_buffer(channel, buffer);
 	card = (struct lcs_card *)
 		((char *) channel - offsetof(struct lcs_card, write));
+	if (netif_queue_stopped(card->dev))
+		netif_wake_queue(card->dev);
 	spin_lock(&card->lock);
 	card->tx_emitted--;
 	if (card->tx_emitted <= 0 && card->tx_buffer != NULL)
@@ -1478,6 +1479,7 @@ __lcs_start_xmit(struct lcs_card *card, 
 		 struct net_device *dev)
 {
 	struct lcs_header *header;
+	int rc = 0;
 
 	LCS_DBF_TEXT(5, trace, "hardxmit");
 	if (skb == NULL) {
@@ -1492,10 +1494,8 @@ __lcs_start_xmit(struct lcs_card *card, 
 		card->stats.tx_carrier_errors++;
 		return 0;
 	}
-	if (netif_queue_stopped(dev) ) {
-		card->stats.tx_dropped++;
-		return -EBUSY;
-	}
+	netif_stop_queue(card->dev);
+	spin_lock(&card->lock);
 	if (card->tx_buffer != NULL &&
 	    card->tx_buffer->count + sizeof(struct lcs_header) +
 	    skb->len + sizeof(u16) > LCS_IOBUFFERSIZE)
@@ -1506,7 +1506,8 @@ __lcs_start_xmit(struct lcs_card *card, 
 		card->tx_buffer = lcs_get_buffer(&card->write);
 		if (card->tx_buffer == NULL) {
 			card->stats.tx_dropped++;
-			return -EBUSY;
+			rc = -EBUSY;
+			goto out;
 		}
 		card->tx_buffer->callback = lcs_txbuffer_cb;
 		card->tx_buffer->count = 0;
@@ -1518,13 +1519,18 @@ __lcs_start_xmit(struct lcs_card *card, 
 	header->type = card->lan_type;
 	header->slot = card->portno;
 	memcpy(header + 1, skb->data, skb->len);
+	spin_unlock(&card->lock);
 	card->stats.tx_bytes += skb->len;
 	card->stats.tx_packets++;
 	dev_kfree_skb(skb);
-	if (card->tx_emitted <= 0)
+	netif_wake_queue(card->dev);
+	spin_lock(&card->lock);
+	if (card->tx_emitted <= 0 && card->tx_buffer != NULL)
 		/* If this is the first tx buffer emit it immediately. */
 		__lcs_emit_txbuffer(card);
-	return 0;
+out:
+	spin_unlock(&card->lock);
+	return rc;
 }
 
 static int
@@ -1535,9 +1541,7 @@ lcs_start_xmit(struct sk_buff *skb, stru
 
 	LCS_DBF_TEXT(5, trace, "pktxmit");
 	card = (struct lcs_card *) dev->priv;
-	spin_lock(&card->lock);
 	rc = __lcs_start_xmit(card, skb, dev);
-	spin_unlock(&card->lock);
 	return rc;
 }
 
@@ -2319,7 +2323,6 @@ __init lcs_init_module(void)
 		PRINT_ERR("Initialization failed\n");
 		return rc;
 	}
-
 	return 0;
 }
 
diff --git a/drivers/s390/net/lcs.h b/drivers/s390/net/lcs.h
index 08e60ad..2fad5e4 100644
--- a/drivers/s390/net/lcs.h
+++ b/drivers/s390/net/lcs.h
@@ -95,7 +95,7 @@ do {                                    
  */
 #define LCS_ILLEGAL_OFFSET		0xffff
 #define LCS_IOBUFFERSIZE		0x5000
-#define LCS_NUM_BUFFS			8	/* needs to be power of 2 */
+#define LCS_NUM_BUFFS			32	/* needs to be power of 2 */
 #define LCS_MAC_LENGTH			6
 #define LCS_INVALID_PORT_NO		-1
 #define LCS_LANCMD_TIMEOUT_DEFAULT      5
diff --git a/drivers/s390/net/qeth.h b/drivers/s390/net/qeth.h
index 9a064d4..4df0fcd 100644
--- a/drivers/s390/net/qeth.h
+++ b/drivers/s390/net/qeth.h
@@ -1076,16 +1076,6 @@ qeth_get_qdio_q_format(struct qeth_card 
 }
 
 static inline int
-qeth_isdigit(char * buf)
-{
-	while (*buf) {
-		if (!isdigit(*buf++))
-			return 0;
-	}
-	return 1;
-}
-
-static inline int
 qeth_isxdigit(char * buf)
 {
 	while (*buf) {
@@ -1104,33 +1094,17 @@ qeth_ipaddr4_to_string(const __u8 *addr,
 static inline int
 qeth_string_to_ipaddr4(const char *buf, __u8 *addr)
 {
-	const char *start, *end;
-	char abuf[4];
-	char *tmp;
-	int len;
-	int i;
-
-	start = buf;
-	for (i = 0; i < 4; i++) {
-		if (i == 3) {
-			end = strchr(start,0xa);
-			if (end)
-				len = end - start;
-			else		
-				len = strlen(start);
-		}
-		else {
-			end = strchr(start, '.');
-			len = end - start;
-		}
-		if ((len <= 0) || (len > 3))
-			return -EINVAL;
-		memset(abuf, 0, 4);
-		strncpy(abuf, start, len);
-		if (!qeth_isdigit(abuf))
+	int count = 0, rc = 0;
+	int in[4];
+
+	rc = sscanf(buf, "%d.%d.%d.%d%n", 
+		    &in[0], &in[1], &in[2], &in[3], &count);
+	if (rc != 4  || count) 
+		return -EINVAL;
+	for (count = 0; count < 4; count++) {
+		if (in[count] > 255)
 			return -EINVAL;
-		addr[i] = simple_strtoul(abuf, &tmp, 10);
-		start = end + 1;
+		addr[count] = in[count];
 	}
 	return 0;
 }
@@ -1149,36 +1123,44 @@ qeth_ipaddr6_to_string(const __u8 *addr,
 static inline int
 qeth_string_to_ipaddr6(const char *buf, __u8 *addr)
 {
-	const char *start, *end;
-	u16 *tmp_addr;
-	char abuf[5];
-	char *tmp;
-	int len;
-	int i;
-
-	tmp_addr = (u16 *)addr;
-	start = buf;
-	for (i = 0; i < 8; i++) {
-		if (i == 7) {
-			end = strchr(start,0xa);
-			if (end)
-				len = end - start;
-			else
-				len = strlen(start);
+	char *end, *start;
+	__u16 *in;
+        char num[5];
+        int num2, cnt, out, found, save_cnt;
+        unsigned short in_tmp[8] = {0, };
+
+	cnt = out = found = save_cnt = num2 = 0;
+        end = start = (char *) buf;
+	in = (__u16 *) addr;	
+	memset(in, 0, 16);
+        while (end) {
+                end = strchr(end,':');
+                if (end == NULL) {
+                        end = (char *)buf + (strlen(buf));
+                        out = 1;
+                }
+                if ((end - start)) { 
+                        memset(num, 0, 5);
+                        memcpy(num, start, end - start);
+			if (!qeth_isxdigit(num))
+				return -EINVAL;
+                        sscanf(start, "%x", &num2);
+                        if (found)
+                                in_tmp[save_cnt++] = num2;
+                        else
+                                in[cnt++] = num2;
+                        if (out)
+                                break;
+                } else {
+			if (found)
+				return -EINVAL;
+                        found = 1;
 		}
-		else {
-			end = strchr(start, ':');
-			len = end - start;
-		}
-		if ((len <= 0) || (len > 4))
-			return -EINVAL;
-		memset(abuf, 0, 5);
-		strncpy(abuf, start, len);
-		if (!qeth_isxdigit(abuf))
-			return -EINVAL;
-		tmp_addr[i] = simple_strtoul(abuf, &tmp, 16);
-		start = end + 1;
-	}
+		start = ++end;
+        }
+        cnt = 7;
+	while (save_cnt)
+                in[cnt--] = in_tmp[--save_cnt];
 	return 0;
 }
 
diff --git a/drivers/s390/net/qeth_eddp.c b/drivers/s390/net/qeth_eddp.c
index b023131..82cb4af 100644
--- a/drivers/s390/net/qeth_eddp.c
+++ b/drivers/s390/net/qeth_eddp.c
@@ -59,8 +59,7 @@ qeth_eddp_free_context(struct qeth_eddp_
 	for (i = 0; i < ctx->num_pages; ++i)
 		free_page((unsigned long)ctx->pages[i]);
 	kfree(ctx->pages);
-	if (ctx->elements != NULL)
-		kfree(ctx->elements);
+	kfree(ctx->elements);
 	kfree(ctx);
 }
 
@@ -413,6 +412,13 @@ __qeth_eddp_fill_context_tcp(struct qeth
 	
 	QETH_DBF_TEXT(trace, 5, "eddpftcp");
 	eddp->skb_offset = sizeof(struct qeth_hdr) + eddp->nhl + eddp->thl;
+       if (eddp->qh.hdr.l2.id == QETH_HEADER_TYPE_LAYER2) {
+               eddp->skb_offset += sizeof(struct ethhdr);
+#ifdef CONFIG_QETH_VLAN
+               if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q))
+                       eddp->skb_offset += VLAN_HLEN;
+#endif /* CONFIG_QETH_VLAN */
+       }
 	tcph = eddp->skb->h.th;
 	while (eddp->skb_offset < eddp->skb->len) {
 		data_len = min((int)skb_shinfo(eddp->skb)->tso_size,
@@ -483,6 +489,7 @@ qeth_eddp_fill_context_tcp(struct qeth_e
 		return -ENOMEM;
 	}
 	if (qhdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2) {
+		skb->mac.raw = (skb->data) + sizeof(struct qeth_hdr);
 		memcpy(&eddp->mac, eth_hdr(skb), ETH_HLEN);
 #ifdef CONFIG_QETH_VLAN
 		if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q)) {
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 410abea..dba7f7f 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -516,7 +516,8 @@ __qeth_set_offline(struct ccwgroup_devic
 	QETH_DBF_TEXT(setup, 3, "setoffl");
 	QETH_DBF_HEX(setup, 3, &card, sizeof(void *));
 	
-	netif_carrier_off(card->dev);
+	if (card->dev && netif_carrier_ok(card->dev))
+		netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if (qeth_stop_card(card, recovery_mode) == -ERESTARTSYS){
 		PRINT_WARN("Stopping card %s interrupted by user!\n",
@@ -1679,6 +1680,7 @@ qeth_cmd_timeout(unsigned long data)
 	spin_unlock_irqrestore(&reply->card->lock, flags);
 }
 
+
 static struct qeth_ipa_cmd *
 qeth_check_ipa_data(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
@@ -1699,7 +1701,8 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
 				card->lan_online = 0;
-				netif_carrier_off(card->dev);
+				if (card->dev && netif_carrier_ok(card->dev))
+					netif_carrier_off(card->dev);
 				return NULL;
 			case IPA_CMD_STARTLAN:
 				PRINT_INFO("Link reestablished on %s "
@@ -5562,7 +5565,7 @@ qeth_set_multicast_list(struct net_devic
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		return ;
 	 
-	QETH_DBF_TEXT(trace,3,"setmulti");
+	QETH_DBF_TEXT(trace, 3, "setmulti");
 	qeth_delete_mc_addresses(card);
 	if (card->options.layer2) {
 		qeth_layer2_add_multicast(card);
@@ -5579,7 +5582,6 @@ out:
 		return;
 	if (qeth_set_thread_start_bit(card, QETH_SET_PROMISC_MODE_THREAD)==0)
 		schedule_work(&card->kernel_thread_starter);
-
 }
 
 static int
@@ -7452,6 +7454,7 @@ qeth_softsetup_card(struct qeth_card *ca
 		card->lan_online = 1;
 	if (card->info.type==QETH_CARD_TYPE_OSN)
 		goto out;
+	qeth_set_large_send(card, card->options.large_send);
 	if (card->options.layer2) {
 		card->dev->features |=
 			NETIF_F_HW_VLAN_FILTER |
@@ -7468,12 +7471,6 @@ qeth_softsetup_card(struct qeth_card *ca
 #endif
 		goto out;
 	}
-	if ((card->options.large_send == QETH_LARGE_SEND_EDDP) ||
-	    (card->options.large_send == QETH_LARGE_SEND_TSO))
-		card->dev->features |= NETIF_F_TSO | NETIF_F_SG;
-	else
-		card->dev->features &= ~(NETIF_F_TSO | NETIF_F_SG);
-
 	if ((rc = qeth_setadapter_parms(card)))
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
 	if ((rc = qeth_start_ipassists(card)))
