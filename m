Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVI3IO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVI3IO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVI3IO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:14:28 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59328 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030250AbVI3IO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:14:26 -0400
Date: Fri, 30 Sep 2005 10:17:24 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/2] s390: qeth driver fixes
Message-ID: <20050930081724.GB7387@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/2] s390: qeth driver fixes

From: Ursula Braun  <braunu@de.ibm.com>
From: Peter Tiedemann <ptiedem@de.ibm.com>
From: Frank Pavlic <pavlic@de.ibm.com>
	minor qeth fixes:
	- free old skb in qeth_realloc_headroom after duplicating skb
	- disable IPV6 support for Hipersockets devices
	- call ccw_device_set_offline on every channel regardless
	  of the return value of the prior ccw_device_set_offline calls
	- allocate qdio structures in DMA-area 
	- schedule recovery of appropriate card
	  when cable has been inserted again.
	- add missing initialization of card->lock
	- write sequence number in skb->cb for SNA protocol which 
	  requires strictly serialized packets.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 qeth.h      |    2 ++
 qeth_main.c |   37 +++++++++++++++++--------------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff -Naupr linux-orig/drivers/s390/net/qeth.h linux-patched/drivers/s390/net/qeth.h
--- linux-orig/drivers/s390/net/qeth.h	2005-09-28 14:22:54.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth.h	2005-09-28 17:33:54.000000000 +0200
@@ -686,6 +686,7 @@ struct qeth_seqno {
 	__u32 pdu_hdr;
 	__u32 pdu_hdr_ack;
 	__u16 ipa;
+	__u32 pkt_seqno;
 };
 
 struct qeth_reply {
@@ -848,6 +849,7 @@ qeth_realloc_headroom(struct qeth_card *
                                   "on interface %s", QETH_CARD_IFNAME(card));
                         return -ENOMEM;
                 }
+		kfree_skb(*skb);
                 *skb = new_skb;
 	}
 	return 0;
diff -Naupr linux-orig/drivers/s390/net/qeth_main.c linux-patched/drivers/s390/net/qeth_main.c
--- linux-orig/drivers/s390/net/qeth_main.c	2005-09-28 14:22:54.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth_main.c	2005-09-28 17:39:41.000000000 +0200
@@ -511,7 +511,7 @@ static int
 __qeth_set_offline(struct ccwgroup_device *cgdev, int recovery_mode)
 {
 	struct qeth_card *card = (struct qeth_card *) cgdev->dev.driver_data;
-	int rc = 0;
+	int rc = 0, rc2 = 0, rc3 = 0;
 	enum qeth_card_states recover_flag;
 
 	QETH_DBF_TEXT(setup, 3, "setoffl");
@@ -523,11 +523,13 @@ __qeth_set_offline(struct ccwgroup_devic
 			   CARD_BUS_ID(card));
 		return -ERESTARTSYS;
 	}
-	if ((rc = ccw_device_set_offline(CARD_DDEV(card))) ||
-	    (rc = ccw_device_set_offline(CARD_WDEV(card))) ||
-	    (rc = ccw_device_set_offline(CARD_RDEV(card)))) {
+	rc  = ccw_device_set_offline(CARD_DDEV(card));
+	rc2 = ccw_device_set_offline(CARD_WDEV(card));
+	rc3 = ccw_device_set_offline(CARD_RDEV(card));
+	if (!rc)
+		rc = (rc2) ? rc2 : rc3;
+	if (rc)
 		QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
-	}
 	if (recover_flag == CARD_STATE_UP)
 		card->state = CARD_STATE_RECOVER;
 	qeth_notify_processes();
@@ -1046,6 +1048,7 @@ qeth_setup_card(struct qeth_card *card)
 	spin_lock_init(&card->vlanlock);
 	card->vlangrp = NULL;
 #endif
+	spin_lock_init(&card->lock);
 	spin_lock_init(&card->ip_lock);
 	spin_lock_init(&card->thread_mask_lock);
 	card->thread_start_mask = 0;
@@ -1626,16 +1629,6 @@ qeth_cmd_timeout(unsigned long data)
 	spin_unlock_irqrestore(&reply->card->lock, flags);
 }
 
-static void
-qeth_reset_ip_addresses(struct qeth_card *card)
-{
-	QETH_DBF_TEXT(trace, 2, "rstipadd");
-
-	qeth_clear_ip_list(card, 0, 1);
-	/* this function will also schedule the SET_IP_THREAD */
-	qeth_set_multicast_list(card->dev);
-}
-
 static struct qeth_ipa_cmd *
 qeth_check_ipa_data(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
@@ -1664,9 +1657,8 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   "IP address reset.\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
-				card->lan_online = 1;
 				netif_carrier_on(card->dev);
-				qeth_reset_ip_addresses(card);
+				qeth_schedule_recovery(card);
 				return NULL;
 			case IPA_CMD_REGISTER_LOCAL_ADDR:
 				QETH_DBF_TEXT(trace,3, "irla");
@@ -2387,6 +2379,7 @@ qeth_layer2_rebuild_skb(struct qeth_card
 		skb_pull(skb, VLAN_HLEN);
 	}
 #endif
+	*((__u32 *)skb->cb) = ++card->seqno.pkt_seqno;
 	return vlan_id;
 }
 
@@ -3014,7 +3007,7 @@ qeth_alloc_buffer_pool(struct qeth_card 
 			return -ENOMEM;
 		}
 		for(j = 0; j < QETH_MAX_BUFFER_ELEMENTS(card); ++j){
-			ptr = (void *) __get_free_page(GFP_KERNEL);
+			ptr = (void *) __get_free_page(GFP_KERNEL|GFP_DMA);
 			if (!ptr) {
 				while (j > 0)
 					free_page((unsigned long)
@@ -3058,7 +3051,8 @@ qeth_alloc_qdio_buffers(struct qeth_card
 	if (card->qdio.state == QETH_QDIO_ALLOCATED)
 		return 0;
 
-	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q), GFP_KERNEL);
+	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q), 
+				  GFP_KERNEL|GFP_DMA);
 	if (!card->qdio.in_q)
 		return - ENOMEM;
 	QETH_DBF_TEXT(setup, 2, "inq");
@@ -3083,7 +3077,7 @@ qeth_alloc_qdio_buffers(struct qeth_card
 	}
 	for (i = 0; i < card->qdio.no_out_queues; ++i){
 		card->qdio.out_qs[i] = kmalloc(sizeof(struct qeth_qdio_out_q),
-					       GFP_KERNEL);
+					       GFP_KERNEL|GFP_DMA);
 		if (!card->qdio.out_qs[i]){
 			while (i > 0)
 				kfree(card->qdio.out_qs[--i]);
@@ -6470,6 +6464,9 @@ qeth_query_ipassists_cb(struct qeth_card
 	if (cmd->hdr.prot_version == QETH_PROT_IPV4) {
 		card->options.ipa4.supported_funcs = cmd->hdr.ipa_supported;
 		card->options.ipa4.enabled_funcs = cmd->hdr.ipa_enabled;
+		/* Disable IPV6 support hard coded for Hipersockets */
+		if(card->info.type == QETH_CARD_TYPE_IQD)
+			card->options.ipa4.supported_funcs &= ~IPA_IPV6;
 	} else {
 #ifdef CONFIG_QETH_IPV6
 		card->options.ipa6.supported_funcs = cmd->hdr.ipa_supported;
