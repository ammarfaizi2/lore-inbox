Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWBGQCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWBGQCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWBGQCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:02:10 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17548 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S965149AbWBGQCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:02:08 -0500
Date: Tue, 7 Feb 2006 17:04:36 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [patch 1/2] s390: lcs performance enhancements
Message-ID: <20060207170436.12a555e9@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/2] s390: lcs performance enhancements 

From: Klaus Wacker <kdwacker@de.ibm.com>
	- When flood pinging (with large packet size) an LCS device,
	  about 90 % of all packets are dropped by driver.
	- increased number of lcs IO buffers to 32. 
	- use netif_stop_queue/netif_wake_queue in lcs_start_xmit routine
	- don't lock the whole xmit routine but just the piece of code where
	  tx_buffer is touched. 
	
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 lcs.c |   31 +++++++++++++++++--------------
 lcs.h |    2 +-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff -Naupr git-orig/drivers/s390/net/lcs.c git-patched/drivers/s390/net/lcs.c
--- git-orig/drivers/s390/net/lcs.c	2006-02-07 10:55:28.000000000 +0100
+++ git-patched/drivers/s390/net/lcs.c	2006-02-07 11:06:37.000000000 +0100
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
 
diff -Naupr git-orig/drivers/s390/net/lcs.h git-patched/drivers/s390/net/lcs.h
--- git-orig/drivers/s390/net/lcs.h	2006-02-07 10:55:28.000000000 +0100
+++ git-patched/drivers/s390/net/lcs.h	2006-02-07 11:00:08.000000000 +0100
@@ -95,7 +95,7 @@ do {                                    
  */
 #define LCS_ILLEGAL_OFFSET		0xffff
 #define LCS_IOBUFFERSIZE		0x5000
-#define LCS_NUM_BUFFS			8	/* needs to be power of 2 */
+#define LCS_NUM_BUFFS			32	/* needs to be power of 2 */
 #define LCS_MAC_LENGTH			6
 #define LCS_INVALID_PORT_NO		-1
 #define LCS_LANCMD_TIMEOUT_DEFAULT      5
