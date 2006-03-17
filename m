Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752458AbWCQAar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbWCQAar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbWCQAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:30:47 -0500
Received: from havoc.gtf.org ([69.61.125.42]:16356 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1752453AbWCQAaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:30:46 -0500
Date: Thu, 16 Mar 2006 19:30:41 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060317003041.GA28029@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/chelsio/sge.c            |    6 +++---
 drivers/net/e100.c                   |    5 ++++-
 drivers/net/e1000/e1000_main.c       |    8 ++++----
 net/ieee80211/ieee80211_crypt_ccmp.c |    2 +-
 net/ieee80211/ieee80211_rx.c         |    4 ++--
 5 files changed, 14 insertions(+), 11 deletions(-)

David S. Miller:
      e1000 endianness bugs

Hong Liu:
      ieee80211: Fix QoS is not active problem

Jesse Brandeburg:
      e100: fix eeh on pseries during ethtool -t

Scott Bardone:
      [netdrvr] fix array overflows in Chelsio driver

Zhu Yi:
      ieee80211: Fix CCMP decryption problem when QoS is enabled

diff --git a/drivers/net/chelsio/sge.c b/drivers/net/chelsio/sge.c
index 2c5b849..30ff8ea 100644
--- a/drivers/net/chelsio/sge.c
+++ b/drivers/net/chelsio/sge.c
@@ -1021,7 +1021,7 @@ static void restart_tx_queues(struct sge
 			if (test_and_clear_bit(nd->if_port,
 					       &sge->stopped_tx_queues) &&
 			    netif_running(nd)) {
-				sge->stats.cmdQ_restarted[3]++;
+				sge->stats.cmdQ_restarted[2]++;
 				netif_wake_queue(nd);
 			}
 		}
@@ -1350,7 +1350,7 @@ static int t1_sge_tx(struct sk_buff *skb
 	 	if (unlikely(credits < count)) {
 			netif_stop_queue(dev);
 			set_bit(dev->if_port, &sge->stopped_tx_queues);
-			sge->stats.cmdQ_full[3]++;
+			sge->stats.cmdQ_full[2]++;
 			spin_unlock(&q->lock);
 			if (!netif_queue_stopped(dev))
 				CH_ERR("%s: Tx ring full while queue awake!\n",
@@ -1358,7 +1358,7 @@ static int t1_sge_tx(struct sk_buff *skb
 			return NETDEV_TX_BUSY;
 		}
 		if (unlikely(credits - count < q->stop_thres)) {
-			sge->stats.cmdQ_full[3]++;
+			sge->stats.cmdQ_full[2]++;
 			netif_stop_queue(dev);
 			set_bit(dev->if_port, &sge->stopped_tx_queues);
 		}
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 24253c8..f57a85f 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2154,6 +2154,9 @@ static int e100_loopback_test(struct nic
 
 	msleep(10);
 
+	pci_dma_sync_single_for_cpu(nic->pdev, nic->rx_to_clean->dma_addr,
+			RFD_BUF_LEN, PCI_DMA_FROMDEVICE);
+
 	if(memcmp(nic->rx_to_clean->skb->data + sizeof(struct rfd),
 	   skb->data, ETH_DATA_LEN))
 		err = -EAGAIN;
@@ -2161,8 +2164,8 @@ static int e100_loopback_test(struct nic
 err_loopback_none:
 	mdio_write(nic->netdev, nic->mii.phy_id, MII_BMCR, 0);
 	nic->loopback = lb_none;
-	e100_hw_init(nic);
 	e100_clean_cbs(nic);
+	e100_hw_reset(nic);
 err_clean_rx:
 	e100_rx_clean_list(nic);
 	return err;
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 4c4db96..84dcca3 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3710,7 +3710,7 @@ e1000_clean_rx_irq(struct e1000_adapter 
 		e1000_rx_checksum(adapter,
 				  (uint32_t)(status) |
 				  ((uint32_t)(rx_desc->errors) << 24),
-				  rx_desc->csum, skb);
+				  le16_to_cpu(rx_desc->csum), skb);
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_E1000_NAPI
@@ -3854,11 +3854,11 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 		}
 
 		e1000_rx_checksum(adapter, staterr,
-				  rx_desc->wb.lower.hi_dword.csum_ip.csum, skb);
+				  le16_to_cpu(rx_desc->wb.lower.hi_dword.csum_ip.csum), skb);
 		skb->protocol = eth_type_trans(skb, netdev);
 
 		if (likely(rx_desc->wb.upper.header_status &
-			  E1000_RXDPS_HDRSTAT_HDRSP))
+			   cpu_to_le16(E1000_RXDPS_HDRSTAT_HDRSP)))
 			adapter->rx_hdr_split++;
 #ifdef CONFIG_E1000_NAPI
 		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
@@ -3884,7 +3884,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 #endif
 
 next_desc:
-		rx_desc->wb.middle.status_error &= ~0xFF;
+		rx_desc->wb.middle.status_error &= cpu_to_le32(~0xFF);
 		buffer_info->skb = NULL;
 
 		/* return some buffers to hardware, one at a time is too slow */
diff --git a/net/ieee80211/ieee80211_crypt_ccmp.c b/net/ieee80211/ieee80211_crypt_ccmp.c
index 4702217..3840d19 100644
--- a/net/ieee80211/ieee80211_crypt_ccmp.c
+++ b/net/ieee80211/ieee80211_crypt_ccmp.c
@@ -131,7 +131,7 @@ static void ccmp_init_blocks(struct cryp
 	a4_included = ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
 		       (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS));
 	qc_included = ((WLAN_FC_GET_TYPE(fc) == IEEE80211_FTYPE_DATA) &&
-		       (WLAN_FC_GET_STYPE(fc) & 0x08));
+		       (WLAN_FC_GET_STYPE(fc) & IEEE80211_STYPE_QOS_DATA));
 	aad_len = 22;
 	if (a4_included)
 		aad_len += 6;
diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index b410ab8..7ac6a71 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -1417,10 +1417,10 @@ static void ieee80211_process_probe_resp
 
 	if (is_beacon(beacon->header.frame_ctl)) {
 		if (ieee->handle_beacon != NULL)
-			ieee->handle_beacon(dev, beacon, &network);
+			ieee->handle_beacon(dev, beacon, target);
 	} else {
 		if (ieee->handle_probe_response != NULL)
-			ieee->handle_probe_response(dev, beacon, &network);
+			ieee->handle_probe_response(dev, beacon, target);
 	}
 }
 
