Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271294AbUJVMf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271294AbUJVMf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbUJVMfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:35:16 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:54983 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S271278AbUJVM1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:27:00 -0400
Date: Fri, 22 Oct 2004 14:26:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/6] s390: network driver.
Message-ID: <20041022122646.GG3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/6] s390: network driver.

From: Frank Pavlic <pavlic@de.ibm.com>
From: Thomas Spatzier <tspat@de.ibm.com>

s390 network driver changes:
 - ctc/iucv: Use DECLARE_PER_CPU instead of extern DEFINE_PER_CPU.
 - lcs: Always set channel state to CH_STATE_INIT when stopping channels.
 - qeth: vlan fixes.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctcdbug.h   |    6 -
 drivers/s390/net/iucv.h      |    2 
 drivers/s390/net/lcs.c       |    8 -
 drivers/s390/net/qeth.h      |    4 
 drivers/s390/net/qeth_main.c |  241 ++++++++++++++++++++-----------------------
 5 files changed, 126 insertions(+), 135 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-patched/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcdbug.h	2004-10-22 13:51:46.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.3 $)
+ * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.4 $)
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.3 $	 $Date: 2004/07/28 12:27:54 $
+ *    $Revision: 1.4 $	 $Date: 2004/10/15 09:26:58 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 		debug_event(ctc_dbf_##name,level,(void*)(addr),len); \
 	} while (0)
 
-extern DEFINE_PER_CPU(char[256], ctc_dbf_txt_buf);
+DECLARE_PER_CPU(char[256], ctc_dbf_txt_buf);
 extern debug_info_t *ctc_dbf_setup;
 extern debug_info_t *ctc_dbf_data;
 extern debug_info_t *ctc_dbf_trace;
diff -urN linux-2.6/drivers/s390/net/iucv.h linux-2.6-patched/drivers/s390/net/iucv.h
--- linux-2.6/drivers/s390/net/iucv.h	2004-10-22 13:51:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/iucv.h	2004-10-22 13:51:46.000000000 +0200
@@ -63,7 +63,7 @@
 		debug_event(iucv_dbf_##name,level,(void*)(addr),len); \
 	} while (0)
 
-extern DEFINE_PER_CPU(char[256], iucv_dbf_txt_buf);
+DECLARE_PER_CPU(char[256], iucv_dbf_txt_buf);
 
 #define IUCV_DBF_TEXT_(name,level,text...)				\
 	do {								\
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2004-10-22 13:51:46.000000000 +0200
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.92 $	 $Date: 2004/09/03 08:06:11 $
+ *    $Revision: 1.94 $	 $Date: 2004/10/19 09:30:54 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.92 $"
+#define VERSION_LCS_C  "$Revision: 1.94 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -549,6 +549,7 @@
 		return 0;
 	LCS_DBF_TEXT(4,trace,"haltsch");
 	LCS_DBF_TEXT_(4,trace,"%s", channel->ccwdev->dev.bus_id);
+	channel->state = CH_STATE_INIT;
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	rc = ccw_device_halt(channel->ccwdev, (addr_t) channel);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
@@ -1357,6 +1358,7 @@
 
 	LCS_DBF_TEXT_(5, trace, "Rint%s",cdev->dev.bus_id);
 	LCS_DBF_TEXT_(5, trace, "%4x%4x",irb->scsw.cstat, irb->scsw.dstat);
+	LCS_DBF_TEXT_(5, trace, "%4x%4x",irb->scsw.fctl, irb->scsw.actl);
 
 	/* How far in the ccw chain have we processed? */
 	if ((channel->state != CH_STATE_INIT) &&
@@ -1624,8 +1626,6 @@
 	/* start/reset card */
 	if (card->dev)
 		netif_stop_queue(card->dev);
-	card->write.state = CH_STATE_INIT;
-	card->read.state = CH_STATE_INIT;
 	rc = lcs_stop_channels(card);
 	if (rc == 0) {
 		rc = lcs_start_channels(card);
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2004-10-22 13:51:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2004-10-22 13:51:46.000000000 +0200
@@ -92,7 +92,7 @@
 		debug_event(qeth_dbf_##name,level,(void*)(addr),len); \
 	} while (0)
 
-extern DEFINE_PER_CPU(char[256], qeth_dbf_txt_buf);
+DECLARE_PER_CPU(char[256], qeth_dbf_txt_buf);
 
 #define QETH_DBF_TEXT_(name,level,text...)				\
 	do {								\
@@ -740,8 +740,6 @@
 #ifdef CONFIG_QETH_VLAN
 	spinlock_t vlanlock;
 	struct vlan_group *vlangrp;
-	__u8 vlans_current[VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8))];
-        __u8 vlans_new[VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8))];
 #endif
 	struct work_struct kernel_thread_starter;
 	spinlock_t thread_mask_lock;
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-10-22 13:51:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-10-22 13:51:46.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.145 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.155 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.145 $	 $Date: 2004/10/08 15:08:40 $
+ *    $Revision: 1.155 $	 $Date: 2004/10/21 13:27:46 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.145 $"
+#define VERSION_QETH_C "$Revision: 1.155 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2153,8 +2153,9 @@
 qeth_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
 	struct qeth_card *card;
+	struct ethhdr *eth;
 
-	QETH_DBF_TEXT(trace,5,"typtrans");
+	QETH_DBF_TEXT(trace,6,"typtrans");
 
 	card = (struct qeth_card *)dev->priv;
 #ifdef CONFIG_TR
@@ -2162,7 +2163,23 @@
 	    (card->info.link_type == QETH_LINK_TYPE_LANE_TR))
 	 	return tr_type_trans(skb,dev);
 #endif /* CONFIG_TR */
-	return eth_type_trans(skb,dev);
+	skb->mac.raw = skb->data;
+	skb_pull(skb, ETH_HLEN );
+	eth = eth_hdr(skb);
+
+	if (*eth->h_dest & 1) {
+		if (memcmp(eth->h_dest, dev->broadcast, ETH_ALEN) == 0)
+			skb->pkt_type = PACKET_BROADCAST;
+		else
+			skb->pkt_type = PACKET_MULTICAST;
+	} else if (memcmp(eth->h_dest, dev->dev_addr, ETH_ALEN))
+		skb->pkt_type = PACKET_OTHERHOST;
+
+	if (ntohs(eth->h_proto) >= 1536)
+		return eth->h_proto;
+	if (*(unsigned short *) (skb->data) == 0xFFFF)
+		return htons(ETH_P_802_3);
+	return htons(ETH_P_802_2);
 }
 
 static inline void
@@ -2234,26 +2251,21 @@
 qeth_layer2_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_hdr *hdr)
 {
-	__u32 cast_type = 0;
-	__u16 rc = 0;
+	unsigned short vlan_id = 0;
 
-	cast_type = *(__u32 *) hdr->hdr.l2.flags;
-	if (cast_type & (QETH_LAYER2_FLAG_UNICAST << 8))
-		skb->pkt_type = PACKET_HOST;
-	else if (cast_type & (QETH_LAYER2_FLAG_MULTICAST << 8))
-		skb->pkt_type = PACKET_MULTICAST;
-	else if (cast_type & (QETH_LAYER2_FLAG_BROADCAST << 8))
-		skb->pkt_type = PACKET_BROADCAST;
+	skb->pkt_type = PACKET_HOST;
+	if (card->options.checksum_type == NO_CHECKSUMMING)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
-		skb->pkt_type = PACKET_HOST;
+		skb->ip_summed = CHECKSUM_NONE;
 #ifdef CONFIG_QETH_VLAN
-	if (cast_type & (QETH_LAYER2_FLAG_VLAN << 8)) {
-		rc = hdr->hdr.l2.vlan_id;
+	if (hdr->hdr.l2.flags[2] & (QETH_LAYER2_FLAG_VLAN)) {
 		skb_pull(skb, VLAN_HLEN);
+		vlan_id = hdr->hdr.l2.vlan_id;
 	}
 #endif
-	skb->protocol = qeth_type_trans(skb, card->dev);
-	return rc;
+	skb->protocol = qeth_type_trans(skb, skb->dev);
+	return vlan_id;
 }
 
 static inline void
@@ -2261,7 +2273,8 @@
 		 struct qeth_hdr *hdr)
 {
 #ifdef CONFIG_QETH_IPV6
-	if (hdr->hdr.l3.flags & QETH_HDR_PASSTHRU){
+	if (hdr->hdr.l3.flags & QETH_HDR_PASSTHRU) {
+		skb->pkt_type = PACKET_HOST;
 		skb->protocol = qeth_type_trans(skb, card->dev);
 		return;
 	}
@@ -2322,6 +2335,7 @@
 #endif
 	while((skb = qeth_get_next_skb(card, buf->buffer, &element,
 				       &offset, &hdr))) {
+		skb->dev = card->dev;
 		if (hdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2)
 			vlan_tag = qeth_layer2_rebuild_skb(card, skb, hdr);
 		else
@@ -2331,13 +2345,12 @@
 			dev_kfree_skb_any(skb);
 			continue;
 		}
-		skb->dev = card->dev;
 #ifdef CONFIG_QETH_VLAN
 		if (vlan_tag)
 			vlan_hwaccel_rx(skb, card->vlangrp, vlan_tag);
 		else
 #endif
-			rxrc = netif_rx(skb);
+		rxrc = netif_rx(skb);
 		card->dev->last_rx = jiffies;
 		card->stats.rx_packets++;
 		card->stats.rx_bytes += skb->len;
@@ -3621,7 +3634,8 @@
 		*skb = new_skb;
 	}
 #ifdef CONFIG_QETH_VLAN
-	if (card->vlangrp && vlan_tx_tag_present(*skb) && (ipv == 6)){
+	if (card->vlangrp && vlan_tx_tag_present(*skb) &&
+	    ((ipv == 6) || card->options.layer2) ) {
 		/*
 		 * Move the mac addresses (6 bytes src, 6 bytes dest)
 		 * to the beginning of the new header.  We are using three
@@ -3631,14 +3645,13 @@
 		memcpy((*skb)->data, (*skb)->data + 4, 4);
 		memcpy((*skb)->data + 4, (*skb)->data + 8, 4);
 		memcpy((*skb)->data + 8, (*skb)->data + 12, 4);
-		tag = (u16 *) (*skb)->data + 12;
+		tag = (u16 *)((*skb)->data + 12);
 		/*
 		 * first two bytes  = ETH_P_8021Q (0x8100)
 		 * second two bytes = VLANID
 		 */
 		*tag = __constant_htons(ETH_P_8021Q);
-		*(tag + 1) = vlan_tx_tag_get(*skb);
-		*(tag + 1) = htons(*(tag + 1));
+		*(tag + 1) = htons(vlan_tx_tag_get(*skb));
 	}
 #endif
 	*hdr = (struct qeth_hdr *) skb_push(*skb, sizeof(struct qeth_hdr));
@@ -3734,7 +3747,7 @@
 		qeth_layer2_get_packet_type(card, hdr, skb);
 
 	hdr->hdr.l2.pkt_length = skb->len-QETH_HEADER_SIZE;
-#ifdef QETH_VLAN
+#ifdef CONFIG_QETH_VLAN
 	/* VSWITCH relies on the VLAN
 	 * information to be present in
 	 * the QDIO header */
@@ -4793,7 +4806,6 @@
 }
 
 #ifdef CONFIG_QETH_VLAN
-static void qeth_layer2_process_vlans(struct qeth_card *);
 static void
 qeth_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
@@ -4806,8 +4818,6 @@
 	spin_lock_irqsave(&card->vlanlock, flags);
 	card->vlangrp = grp;
 	spin_unlock_irqrestore(&card->vlanlock, flags);
-	if (card->options.layer2)
-		qeth_layer2_process_vlans(card);
 }
 
 static inline void
@@ -4902,12 +4912,69 @@
 }
 
 static void
+qeth_layer2_send_setdelvlan(struct qeth_card *card, __u16 i,
+			    enum qeth_ipa_cmds ipacmd)
+{
+ 	int rc;
+	struct qeth_ipa_cmd *cmd;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_DBF_TEXT_(trace, 4, "L2sdv%x",ipacmd);
+	iob = qeth_get_ipacmd_buffer(card, ipacmd, QETH_PROT_IPV4);
+	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+        cmd->data.setdelvlan.vlan_id = i;
+
+	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
+        if (rc) {
+                PRINT_ERR("Error in processing VLAN %i on %s: 0x%x. "
+			  "Continuing\n",i, card->info.if_name, rc);
+		QETH_DBF_TEXT_(trace, 2, "L2VL%4x", ipacmd);
+		QETH_DBF_TEXT_(trace, 2, "L2%s", CARD_BUS_ID(card));
+		QETH_DBF_TEXT_(trace, 2, "err%d", rc);
+        }
+}
+
+static void
+qeth_layer2_process_vlans(struct qeth_card *card, int clear)
+{
+        unsigned short  i;
+
+	QETH_DBF_TEXT(trace, 3, "L2prcvln");
+
+	if (!card->vlangrp)
+		return;
+	for (i = 0; i < VLAN_GROUP_ARRAY_LEN; i++) {
+		if (card->vlangrp->vlan_devices[i] == NULL)
+			continue;
+		if (clear)
+			qeth_layer2_send_setdelvlan(card, i, IPA_CMD_DELVLAN);
+		else
+			qeth_layer2_send_setdelvlan(card, i, IPA_CMD_SETVLAN);
+        }
+}
+
+/*add_vid is layer 2 used only ....*/
+static void
+qeth_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
+{
+	struct qeth_card *card;
+
+	QETH_DBF_TEXT_(trace, 4, "aid:%d", vid);
+
+	card = (struct qeth_card *) dev->priv;
+	if (!card->options.layer2)
+		return;
+	qeth_layer2_send_setdelvlan(card, vid, IPA_CMD_SETVLAN);
+}
+
+/*... kill_vid used for both modes*/
+static void
 qeth_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
 {
 	struct qeth_card *card;
 	unsigned long flags;
 
-	QETH_DBF_TEXT(trace,4,"vlkilvid");
+	QETH_DBF_TEXT_(trace, 4, "kid:%d", vid);
 
 	card = (struct qeth_card *) dev->priv;
 	/* free all skbs for the vlan device */
@@ -4920,7 +4987,7 @@
 		card->vlangrp->vlan_devices[vid] = NULL;
 	spin_unlock_irqrestore(&card->vlanlock, flags);
 	if (card->options.layer2)
-		qeth_layer2_process_vlans(card);
+		qeth_layer2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
  	if ( (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0) ||
 	     (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0) )
 		schedule_work(&card->kernel_thread_starter);
@@ -5328,93 +5395,6 @@
 	return rc;
 }
 
-#ifdef CONFIG_QETH_VLAN
-/* ATT: not a very readable order: bytes count from lower numbers, bits
-   count from lsb */
-static void
-qeth_layer2_set_bit(__u8 *ptr,int i)
-{
-        ptr[i/8]|=0x80>>(i%8);
-}
-
-static int
-qeth_layer2_get_bit(__u8 *ptr,int i)
-{
-        return (ptr[i/8]&(0x80>>(i%8)))?1:0;
-}
-
-static void
-qeth_layer2_takeover_vlans(struct qeth_card *card)
-{
-        int i;
-
-	QETH_DBF_TEXT(trace, 3, "L2tkvlan");
-        /* copy new to current */
-        memcpy(&card->vlans_current[0],
-               &card->vlans_new[0],
-               VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8)));
-
-        /* clear new vector */
-        memset(&card->vlans_new[0], 0,
-	       VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8)));
-
-        for (i=0; i<VLAN_GROUP_ARRAY_LEN; i++) {
-                if ( (card->vlangrp) &&
-                     (card->vlangrp->vlan_devices[i]) )
-                        qeth_layer2_set_bit(&card->vlans_new[0], i);
-        }
-}
-
-static void
-qeth_layer2_send_setdelvlan(struct qeth_card *card, __u16 i,
-			    enum qeth_ipa_cmds ipacmd)
-{
- 	int rc;
-	struct qeth_ipa_cmd *cmd;
-	struct qeth_cmd_buffer *iob;
-
-	QETH_DBF_TEXT(trace, 4, "L2sdvlan");
-	iob = qeth_get_ipacmd_buffer(card, ipacmd, QETH_PROT_IPV4);
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-        cmd->data.setdelvlan.vlan_id = i;
-
-	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
-        if (rc) {
-                PRINT_ERR("Error in processing VLAN %i on %s: 0x%x. "
-			  "Continuing\n",i, card->info.if_name, rc);
-		QETH_DBF_TEXT_(trace, 2, "L2VL%4x", ipacmd);
-		QETH_DBF_TEXT_(trace, 2, "L2%s", CARD_BUS_ID(card));
-		QETH_DBF_TEXT_(trace, 2, "err%d", rc);
-        }
-}
-
-static void
-qeth_layer2_register_vlans(struct qeth_card *card)
-{
-        __u16 i;
-
-	QETH_DBF_TEXT(trace, 3, "L2regvln");
-        for (i=0; i<VLAN_GROUP_ARRAY_LEN; i++) {
-                if ( (qeth_layer2_get_bit(&card->vlans_current[0], i)) &&
-                     (!qeth_layer2_get_bit(&card->vlans_new[0], i)) )
-                        qeth_layer2_send_setdelvlan(card, i, IPA_CMD_DELVLAN);
-                if ( (!qeth_layer2_get_bit(&card->vlans_current[0], i)) &&
-                     (qeth_layer2_get_bit(&card->vlans_new[0], i)) )
-                        qeth_layer2_send_setdelvlan(card, i, IPA_CMD_SETVLAN);
-        }
-}
-
-static void
-qeth_layer2_process_vlans(struct qeth_card *card)
-{
-	QETH_DBF_TEXT(trace, 2, "L2provln");
-
-	qeth_layer2_takeover_vlans(card);
-	qeth_layer2_register_vlans(card);
-}
-
-#endif
-
 static int
 qeth_layer2_register_addr_entry(struct qeth_card *card,
 				struct qeth_ipaddr *addr)
@@ -5575,6 +5555,7 @@
 #ifdef CONFIG_QETH_VLAN
 	dev->vlan_rx_register = qeth_vlan_rx_register;
 	dev->vlan_rx_kill_vid = qeth_vlan_rx_kill_vid;
+	dev->vlan_rx_add_vid = qeth_vlan_rx_add_vid;
 #endif
 	if (qeth_get_netdev_flags(card) & IFF_NOARP) {
 		dev->rebuild_header = NULL;
@@ -5596,9 +5577,8 @@
 	if ((card->options.fake_broadcast) ||
 	    (card->info.broadcast_capable))
 		dev->flags |= IFF_BROADCAST;
-
 	dev->hard_header_len =
-		qeth_get_hlen(card->info.link_type) + card->options.add_hhlen;
+			qeth_get_hlen(card->info.link_type) + card->options.add_hhlen;
 	dev->addr_len = OSA_ADDR_LEN;
 	dev->mtu = card->info.initial_mtu;
 
@@ -6187,7 +6167,10 @@
 			   card->info.if_name, rc);
 	} else {
 		PRINT_INFO("VLAN enabled \n");
-		card->dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
+		card->dev->features |=
+			NETIF_F_HW_VLAN_FILTER |
+			NETIF_F_HW_VLAN_TX |
+			NETIF_F_HW_VLAN_RX;
 	}
 #endif /* QETH_VLAN */
 	return rc;
@@ -6559,6 +6542,7 @@
 		card->lan_online = 1;
 	if (card->options.layer2) {
 		card->dev->features |=
+			NETIF_F_HW_VLAN_FILTER |
 			NETIF_F_HW_VLAN_TX |
 			NETIF_F_HW_VLAN_RX;
 		card->dev->flags|=IFF_MULTICAST|IFF_BROADCAST;
@@ -6568,7 +6552,7 @@
 			return rc;
 		}
 #ifdef CONFIG_QETH_VLAN
-		qeth_layer2_process_vlans(card);
+		qeth_layer2_process_vlans(card, 0);
 #endif
 		goto out;
 	}
@@ -6737,6 +6721,10 @@
 		card->state = CARD_STATE_SOFTSETUP;
 	}
 	if (card->state == CARD_STATE_SOFTSETUP) {
+#ifdef CONFIG_QETH_VLAN
+		if (card->options.layer2)
+			qeth_layer2_process_vlans(card, 1);
+#endif
 		qeth_clear_ip_list(card, !card->use_hard_stop, recover_flag);
 		qeth_clear_ipacmd_list(card);
 		card->state = CARD_STATE_HARDSETUP;
@@ -7019,7 +7007,12 @@
 	}
 /*maybe it was set offline without ifconfig down
  * we can also use this state for recovery purposes*/
-	qeth_set_allowed_threads(card, 0xffffffff, 0);
+	if (card->options.layer2)
+		qeth_set_allowed_threads(card,
+					 QETH_RECOVER_THREAD |
+					 QETH_SET_MC_THREAD,0);
+	else
+		qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (recover_flag == CARD_STATE_RECOVER)
 		qeth_start_again(card);
 	qeth_notify_processes();
