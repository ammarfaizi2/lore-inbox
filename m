Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269851AbUJHSBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269851AbUJHSBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270075AbUJHRxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:53:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56753 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S270048AbUJHRjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:39:44 -0400
Date: Fri, 8 Oct 2004 19:39:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (8/12): qeth layer 2 support.
Message-ID: <20041008173932.GI7356@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: qeth layer 2 support.

From: Frank Pavlic <pavlic@de.ibm.com>
From: Thomas Spatzier <tspat@de.ibm.com>

qeth network driver changes:
 - Add Layer 2 support for OSA-Express.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth.h      |   51 ++-
 drivers/s390/net/qeth_main.c |  634 +++++++++++++++++++++++++++++++++++++------
 drivers/s390/net/qeth_mpc.h  |   39 ++
 drivers/s390/net/qeth_sys.c  |   93 ++++++
 4 files changed, 713 insertions(+), 104 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2004-08-14 12:54:47.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2004-10-08 19:19:15.000000000 +0200
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.113 $"
+#define VERSION_QETH_H 		"$Revision: 1.116 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -43,7 +43,7 @@
 #define QETH_DBF_SETUP_LEN 8
 #define QETH_DBF_SETUP_INDEX 3
 #define QETH_DBF_SETUP_NR_AREAS 1
-#define QETH_DBF_SETUP_LEVEL 3
+#define QETH_DBF_SETUP_LEVEL 5
 
 #define QETH_DBF_MISC_NAME "qeth_misc"
 #define QETH_DBF_MISC_LEN 128
@@ -61,13 +61,13 @@
 #define QETH_DBF_CONTROL_LEN 256
 #define QETH_DBF_CONTROL_INDEX 3
 #define QETH_DBF_CONTROL_NR_AREAS 2
-#define QETH_DBF_CONTROL_LEVEL 2
+#define QETH_DBF_CONTROL_LEVEL 5
 
 #define QETH_DBF_TRACE_NAME "qeth_trace"
 #define QETH_DBF_TRACE_LEN 8
 #define QETH_DBF_TRACE_INDEX 2
 #define QETH_DBF_TRACE_NR_AREAS 2
-#define QETH_DBF_TRACE_LEVEL 3
+#define QETH_DBF_TRACE_LEVEL 5
 
 #define QETH_DBF_SENSE_NAME "qeth_sense"
 #define QETH_DBF_SENSE_LEN 64
@@ -334,7 +334,7 @@
 #define QETH_EXT_HDR_TOKEN_ID          0x02
 #define QETH_EXT_HDR_INCLUDE_VLAN_TAG  0x04
 
-struct qeth_hdr {
+struct qeth_hdr_layer3 {
 	__u8  id;
 	__u8  flags;
 	__u16 inbound_checksum;
@@ -347,6 +347,26 @@
 	__u8  dest_addr[16];
 } __attribute__ ((packed));
 
+struct qeth_hdr_layer2 {
+	__u8 id;
+	__u8 flags[3];
+	__u8 port_no;
+	__u8 hdr_length;
+	__u16 pkt_length;
+	__u16 seq_no;
+	__u16 vlan_id;
+	__u32 reserved;
+	__u8 reserved2[16];
+} __attribute__ ((packed));
+
+struct qeth_hdr {
+	union {
+		struct qeth_hdr_layer2 l2;
+		struct qeth_hdr_layer3 l3;
+	} hdr;
+} __attribute__ ((packed));
+
+
 /* flags for qeth_hdr.flags */
 #define QETH_HDR_PASSTHRU 0x10
 #define QETH_HDR_IPV6     0x80
@@ -359,6 +379,17 @@
 	QETH_CAST_NOCAST    = 0x00,
 };
 
+enum qeth_layer2_frame_flags {
+	QETH_LAYER2_FLAG_MULTICAST = 0x01,
+	QETH_LAYER2_FLAG_BROADCAST = 0x02,
+	QETH_LAYER2_FLAG_UNICAST   = 0x04,
+	QETH_LAYER2_FLAG_VLAN      = 0x10,
+};
+
+enum qeth_header_ids {
+	QETH_HEADER_TYPE_LAYER3 = 0x01,
+	QETH_HEADER_TYPE_LAYER2 = 0x02,
+};
 /* flags for qeth_hdr.ext_flags */
 #define QETH_HDR_EXT_VLAN_FRAME      0x01
 #define QETH_HDR_EXT_CSUM_HDR_REQ    0x10
@@ -645,6 +676,7 @@
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
 	int guestlan;
+	int layer2_mac_registered;
 	int portname_required;
 	int portno;
 	char portname[9];
@@ -672,6 +704,7 @@
 	int fake_broadcast;
 	int add_hhlen;
 	int fake_ll;
+	int layer2;
 };
 
 /*
@@ -706,6 +739,8 @@
 #ifdef CONFIG_QETH_VLAN
 	spinlock_t vlanlock;
 	struct vlan_group *vlangrp;
+	__u8 vlans_current[VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8))];
+        __u8 vlans_new[VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8))];
 #endif
 	struct work_struct kernel_thread_starter;
 	spinlock_t thread_mask_lock;
@@ -779,9 +814,11 @@
 }
 
 inline static unsigned short
-qeth_get_netdev_flags(int cardtype)
+qeth_get_netdev_flags(struct qeth_card *card)
 {
-	switch (cardtype) {
+	if (card->options.layer2)
+		return 0;
+	switch (card->info.type) {
 	case QETH_CARD_TYPE_IQD:
 		return IFF_NOARP;
 #ifdef CONFIG_QETH_IPV6
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-10-08 19:19:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-10-08 19:19:15.000000000 +0200
@@ -29,7 +29,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-
 /***
  * eye catcher; just for debugging purposes
  */
@@ -197,7 +196,7 @@
 {
 	struct qeth_notify_list_struct *n_entry;
 
-	QETH_DBF_TEXT(trace, 2, "notreg");
+
 	/*check first if entry already exists*/
 	spin_lock(&qeth_notify_lock);
 	list_for_each_entry(n_entry, &qeth_notify_list, list) {
@@ -1010,6 +1009,7 @@
 	card->options.fake_broadcast = 0;
 	card->options.add_hhlen = DEFAULT_ADD_HHLEN;
 	card->options.fake_ll = 0;
+	card->options.layer2 = 0;
 }
 
 /**
@@ -1815,10 +1815,18 @@
 		  void *reply_param)
 {
 	int rc;
+	char prot_type;
 
 	QETH_DBF_TEXT(trace,4,"sendipa");
 
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
+
+	if (card->options.layer2)
+		prot_type = QETH_PROT_LAYER2;
+	else
+		prot_type = QETH_PROT_TCPIP;
+
+	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data),&prot_type,1);
 	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
 	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
 
@@ -1951,6 +1959,7 @@
 qeth_ulp_enable(struct qeth_card *card)
 {
 	int rc;
+	char prot_type;
 	struct qeth_cmd_buffer *iob;
 
 	/*FIXME: trace view callbacks*/
@@ -1961,7 +1970,12 @@
 
 	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) =
 		(__u8) card->info.portno;
+	if (card->options.layer2)
+		prot_type = QETH_PROT_LAYER2;
+	else
+		prot_type = QETH_PROT_TCPIP;
 
+	memcpy(QETH_ULP_ENABLE_PROT_TYPE(iob->data),&prot_type,1);
 	memcpy(QETH_ULP_ENABLE_DEST_ADDR(iob->data),
 	       &card->token.cm_connection_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_ULP_ENABLE_FILTER_TOKEN(iob->data),
@@ -2084,7 +2098,11 @@
 	*hdr = element->addr + offset;
 
 	offset += sizeof(struct qeth_hdr);
-	skb_len = (*hdr)->length;
+	if (card->options.layer2)
+		skb_len = (*hdr)->hdr.l2.pkt_length;
+	else
+		skb_len = (*hdr)->hdr.l3.length;
+
 	if (!skb_len)
 		return NULL;
 	if (card->options.fake_ll){
@@ -2134,7 +2152,6 @@
 static inline unsigned short
 qeth_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
-	struct ethhdr *eth;
 	struct qeth_card *card;
 
 	QETH_DBF_TEXT(trace,5,"typtrans");
@@ -2145,24 +2162,7 @@
 	    (card->info.link_type == QETH_LINK_TYPE_LANE_TR))
 	 	return tr_type_trans(skb,dev);
 #endif /* CONFIG_TR */
-
-	skb->mac.raw = skb->data;
-	skb_pull(skb, ETH_ALEN * 2 + sizeof (short));
-	eth = eth_hdr(skb);
-
-	if (*eth->h_dest & 1) {
-		if (memcmp(eth->h_dest, dev->broadcast, ETH_ALEN) == 0)
-			skb->pkt_type = PACKET_BROADCAST;
-		else
-			skb->pkt_type = PACKET_MULTICAST;
-	} else {
-		skb->pkt_type = PACKET_OTHERHOST;
-	}
-	if (ntohs(eth->h_proto) >= 1536)
-		return eth->h_proto;
-	if (*(unsigned short *) (skb->data) == 0xFFFF)
-		return htons(ETH_P_802_3);
-	return htons(ETH_P_802_2);
+	return eth_type_trans(skb,dev);
 }
 
 static inline void
@@ -2206,8 +2206,8 @@
 		memcpy(fake_hdr->h_dest, card->dev->dev_addr, ETH_ALEN);
 	}
 	/* the source MAC address */
-	if (hdr->ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
-		memcpy(fake_hdr->h_source, &hdr->dest_addr[2], ETH_ALEN);
+	if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
+		memcpy(fake_hdr->h_source, &hdr->hdr.l3.dest_addr[2], ETH_ALEN);
 	else
 		memset(fake_hdr->h_source, 0, ETH_ALEN);
 	/* the protocol */
@@ -2221,28 +2221,54 @@
 #ifdef CONFIG_QETH_VLAN
 	u16 *vlan_tag;
 
-	if (hdr->ext_flags & QETH_HDR_EXT_VLAN_FRAME) {
+	if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME) {
 		vlan_tag = (u16 *) skb_push(skb, VLAN_HLEN);
-		*vlan_tag = hdr->vlan_id;
+		*vlan_tag = hdr->hdr.l3.vlan_id;
 		*(vlan_tag + 1) = skb->protocol;
 		skb->protocol = __constant_htons(ETH_P_8021Q);
 	}
 #endif /* CONFIG_QETH_VLAN */
 }
 
+static inline __u16
+qeth_layer2_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
+			struct qeth_hdr *hdr)
+{
+	__u32 cast_type = 0;
+	__u16 rc = 0;
+
+	cast_type = *(__u32 *) hdr->hdr.l2.flags;
+	if (cast_type & (QETH_LAYER2_FLAG_UNICAST << 8))
+		skb->pkt_type = PACKET_HOST;
+	else if (cast_type & (QETH_LAYER2_FLAG_MULTICAST << 8))
+		skb->pkt_type = PACKET_MULTICAST;
+	else if (cast_type & (QETH_LAYER2_FLAG_BROADCAST << 8))
+		skb->pkt_type = PACKET_BROADCAST;
+	else
+		skb->pkt_type = PACKET_HOST;
+#ifdef CONFIG_QETH_VLAN
+	if (cast_type & (QETH_LAYER2_FLAG_VLAN << 8)) {
+		rc = hdr->hdr.l2.vlan_id;
+		skb_pull(skb, VLAN_HLEN);
+	}
+#endif
+	skb->protocol = qeth_type_trans(skb, card->dev);
+	return rc;
+}
+
 static inline void
 qeth_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		 struct qeth_hdr *hdr)
 {
 #ifdef CONFIG_QETH_IPV6
-	if (hdr->flags & QETH_HDR_PASSTHRU){
+	if (hdr->hdr.l3.flags & QETH_HDR_PASSTHRU){
 		skb->protocol = qeth_type_trans(skb, card->dev);
 		return;
 	}
 #endif /* CONFIG_QETH_IPV6 */
-	skb->protocol = htons((hdr->flags & QETH_HDR_IPV6)? ETH_P_IPV6 :
+	skb->protocol = htons((hdr->hdr.l3.flags & QETH_HDR_IPV6)? ETH_P_IPV6 :
 			      ETH_P_IP);
-	switch (hdr->flags & QETH_HDR_CAST_MASK){
+	switch (hdr->hdr.l3.flags & QETH_HDR_CAST_MASK){
 	case QETH_CAST_UNICAST:
 		skb->pkt_type = PACKET_HOST;
 		break;
@@ -2259,13 +2285,14 @@
 	default:
 		skb->pkt_type = PACKET_HOST;
 	}
+	qeth_rebuild_skb_vlan(card, skb, hdr);
 	if (card->options.fake_ll)
 		qeth_rebuild_skb_fake_ll(card, skb, hdr);
 	else
 		skb->mac.raw = skb->data;
 	skb->ip_summed = card->options.checksum_type;
 	if (card->options.checksum_type == HW_CHECKSUMMING){
-		if ( (hdr->ext_flags &
+		if ( (hdr->hdr.l3.ext_flags &
 		      (QETH_HDR_EXT_CSUM_HDR_REQ |
 		       QETH_HDR_EXT_CSUM_TRANSP_REQ)) ==
 		     (QETH_HDR_EXT_CSUM_HDR_REQ |
@@ -2274,7 +2301,6 @@
 		else
 			skb->ip_summed = SW_CHECKSUMMING;
 	}
-	qeth_rebuild_skb_vlan(card, skb, hdr);
 }
 
 static inline void
@@ -2282,10 +2308,11 @@
 			    struct qeth_qdio_buffer *buf, int index)
 {
 	struct qdio_buffer_element *element;
-	int offset;
 	struct sk_buff *skb;
 	struct qeth_hdr *hdr;
+	int offset;
 	int rxrc;
+	__u16 vlan_tag = 0;
 
 	/* get first element of current buffer */
 	element = (struct qdio_buffer_element *)&buf->buffer->element[0];
@@ -2294,15 +2321,23 @@
 	card->perf_stats.bufs_rec++;
 #endif
 	while((skb = qeth_get_next_skb(card, buf->buffer, &element,
-				       &offset, &hdr))){
-		qeth_rebuild_skb(card, skb, hdr);
+				       &offset, &hdr))) {
+		if (hdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2)
+			vlan_tag = qeth_layer2_rebuild_skb(card, skb, hdr);
+		else
+			qeth_rebuild_skb(card, skb, hdr);
 		/* is device UP ? */
 		if (!(card->dev->flags & IFF_UP)){
 			dev_kfree_skb_any(skb);
 			continue;
 		}
 		skb->dev = card->dev;
-		rxrc = netif_rx(skb);
+#ifdef CONFIG_QETH_VLAN
+		if (vlan_tag)
+			vlan_hwaccel_rx(skb, card->vlangrp, vlan_tag);
+		else
+#endif
+			rxrc = netif_rx(skb);
 		card->dev->last_rx = jiffies;
 		card->stats.rx_packets++;
 		card->stats.rx_bytes += skb->len;
@@ -3442,6 +3477,11 @@
 	if (card->state != CARD_STATE_SOFTSETUP)
 		return -ENODEV;
 
+	if ( (card->options.layer2) &&
+	     (!card->info.layer2_mac_registered)) {
+		QETH_DBF_TEXT(trace,4,"nomacadr");
+		return -EPERM;
+	}
 	card->dev->flags |= IFF_UP;
 	netif_start_queue(dev);
 	card->data.state = CH_STATE_UP;
@@ -3491,12 +3531,12 @@
 	else if (skb->protocol == ETH_P_IP)
 		return ((skb->nh.raw[16] & 0xf0) == 0xe0) ? RTN_MULTICAST : 0;
 	/* ... */
-	if (!memcmp(skb->nh.raw, skb->dev->broadcast, 6))
+	if (!memcmp(skb->data, skb->dev->broadcast, 6))
 		return RTN_BROADCAST;
 	else {
 		u16 hdr_mac;
 
-	        hdr_mac = *((u16 *)skb->nh.raw);
+	        hdr_mac = *((u16 *)skb->data);
 	        /* tr multicast? */
 	        switch (card->info.link_type) {
 	        case QETH_LINK_TYPE_HSTR:
@@ -3642,50 +3682,120 @@
 }
 
 static inline void
+qeth_layer2_get_packet_type(struct qeth_card *card, struct qeth_hdr *hdr,
+			    struct sk_buff *skb)
+{
+	__u16 hdr_mac;
+
+	if (!memcmp(skb->data+QETH_HEADER_SIZE,
+		    skb->dev->broadcast,6)) { /* broadcast? */
+		*(__u32 *)hdr->hdr.l2.flags |=
+			 QETH_LAYER2_FLAG_BROADCAST << 8;
+		return;
+	}
+	hdr_mac=*((__u16*)skb->data);
+	/* tr multicast? */
+	switch (card->info.link_type) {
+	case QETH_LINK_TYPE_HSTR:
+	case QETH_LINK_TYPE_LANE_TR:
+		if ((hdr_mac == QETH_TR_MAC_NC) ||
+		    (hdr_mac == QETH_TR_MAC_C) )
+			*(__u32 *)hdr->hdr.l2.flags |=
+				QETH_LAYER2_FLAG_MULTICAST << 8;
+		else
+			*(__u32 *)hdr->hdr.l2.flags |=
+				QETH_LAYER2_FLAG_UNICAST << 8;
+		break;
+		/* eth or so multicast? */
+	default:
+		if ( (hdr_mac==QETH_ETH_MAC_V4) ||
+		     (hdr_mac==QETH_ETH_MAC_V6) )
+			*(__u32 *)hdr->hdr.l2.flags |=
+				QETH_LAYER2_FLAG_MULTICAST << 8;
+		else
+			*(__u32 *)hdr->hdr.l2.flags |=
+				QETH_LAYER2_FLAG_UNICAST << 8;
+	}
+}
+
+static inline void
+qeth_layer2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
+			struct sk_buff *skb, int cast_type)
+{
+	memset(hdr, 0, sizeof(struct qeth_hdr));
+	hdr->hdr.l2.id = QETH_HEADER_TYPE_LAYER2;
+
+	/* set byte 0 to "0x02" and byte 3 to casting flags */
+	if (cast_type==RTN_MULTICAST)
+		*(__u32 *)hdr->hdr.l2.flags |= QETH_LAYER2_FLAG_MULTICAST << 8;
+	else if (cast_type==RTN_BROADCAST)
+		*(__u32 *)hdr->hdr.l2.flags |= QETH_LAYER2_FLAG_BROADCAST << 8;
+	 else
+		qeth_layer2_get_packet_type(card, hdr, skb);
+
+	hdr->hdr.l2.pkt_length = skb->len-QETH_HEADER_SIZE;
+#ifdef QETH_VLAN
+	/* VSWITCH relies on the VLAN
+	 * information to be present in
+	 * the QDIO header */
+	if ((card->vlangrp != NULL) &&
+	    vlan_tx_tag_present(skb)) {
+		*(__u32 *)hdr->hdr.l2.flags |= QETH_LAYER2_FLAG_VLAN << 8;
+		hdr->hdr.l2.vlan_id = vlan_tx_tag_get(skb);
+	}
+#endif
+}
+
+static inline void
 qeth_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		struct sk_buff *skb, int ipv, int cast_type)
 {
-	hdr->id = 1;
-	hdr->ext_flags = 0;
-
 	QETH_DBF_TEXT(trace, 6, "fillhdr");
+
+	if (card->options.layer2) {
+		qeth_layer2_fill_header(card, hdr, skb, cast_type);
+		return;
+	}
+	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
+	hdr->hdr.l3.ext_flags = 0;
 #ifdef CONFIG_QETH_VLAN
 	/*
 	 * before we're going to overwrite this location with next hop ip.
 	 * v6 uses passthrough, v4 sets the tag in the QDIO header.
 	 */
 	if (card->vlangrp && vlan_tx_tag_present(skb)) {
-		hdr->ext_flags = (ipv == 4)? QETH_EXT_HDR_VLAN_FRAME :
-					     QETH_EXT_HDR_INCLUDE_VLAN_TAG;
-		hdr->vlan_id = vlan_tx_tag_get(skb);
+		hdr->hdr.l3.ext_flags = (ipv == 4) ?
+			QETH_EXT_HDR_VLAN_FRAME :
+			QETH_EXT_HDR_INCLUDE_VLAN_TAG;
+		hdr->hdr.l3.vlan_id = vlan_tx_tag_get(skb);
 	}
 #endif /* CONFIG_QETH_VLAN */
-	hdr->length = skb->len - sizeof(struct qeth_hdr);
+	hdr->hdr.l3.length = skb->len - sizeof(struct qeth_hdr);
 	if (ipv == 4) {	 /* IPv4 */
-		hdr->flags = qeth_get_qeth_hdr_flags4(cast_type);
-		memset(hdr->dest_addr, 0, 12);
+		hdr->hdr.l3.flags = qeth_get_qeth_hdr_flags4(cast_type);
+		memset(hdr->hdr.l3.dest_addr, 0, 12);
 		if ((skb->dst) && (skb->dst->neighbour)) {
-			*((u32 *) (&hdr->dest_addr[12])) =
+			*((u32 *) (&hdr->hdr.l3.dest_addr[12])) =
 			    *((u32 *) skb->dst->neighbour->primary_key);
 		} else {
 			/* fill in destination address used in ip header */
-			*((u32 *) (&hdr->dest_addr[12])) = skb->nh.iph->daddr;
+			*((u32 *) (&hdr->hdr.l3.dest_addr[12])) = skb->nh.iph->daddr;
 		}
 	} else if (ipv == 6) { /* IPv6 or passthru */
-		hdr->flags = qeth_get_qeth_hdr_flags6(cast_type);
+		hdr->hdr.l3.flags = qeth_get_qeth_hdr_flags6(cast_type);
 		if ((skb->dst) && (skb->dst->neighbour)) {
-			memcpy(hdr->dest_addr,
+			memcpy(hdr->hdr.l3.dest_addr,
 			       skb->dst->neighbour->primary_key, 16);
 		} else {
 			/* fill in destination address used in ip header */
-			memcpy(hdr->dest_addr, &skb->nh.ipv6h->daddr, 16);
+			memcpy(hdr->hdr.l3.dest_addr, &skb->nh.ipv6h->daddr, 16);
 		}
 	} else { /* passthrough */
 		if (!memcmp(skb->data + sizeof(struct qeth_hdr),
 			    skb->dev->broadcast, 6)) {   /* broadcast? */
-			hdr->flags = QETH_CAST_BROADCAST | QETH_HDR_PASSTHRU;
+			hdr->hdr.l3.flags = QETH_CAST_BROADCAST | QETH_HDR_PASSTHRU;
 		} else {
- 			hdr->flags = (cast_type == RTN_MULTICAST) ?
+ 			hdr->hdr.l3.flags = (cast_type == RTN_MULTICAST) ?
  				QETH_CAST_MULTICAST | QETH_HDR_PASSTHRU :
  				QETH_CAST_UNICAST | QETH_HDR_PASSTHRU;
 		}
@@ -3874,7 +3984,7 @@
 static inline int
 qeth_send_packet(struct qeth_card *card, struct sk_buff *skb)
 {
-	int ipv;
+	int ipv = 0;
 	int cast_type;
 	struct qeth_qdio_out_q *queue;
 	struct qeth_hdr *hdr;
@@ -3883,7 +3993,8 @@
 
 	QETH_DBF_TEXT(trace, 6, "sendpkt");
 
-	ipv = qeth_get_ip_version(skb);
+	if (!card->options.layer2)
+		ipv = qeth_get_ip_version(skb);
 	cast_type = qeth_get_cast_type(card, skb);
 	queue = card->qdio.out_qs
 		[qeth_get_priority_queue(card, skb, ipv, cast_type)];
@@ -4226,8 +4337,8 @@
 	 * funcs flags); since all zeros is no valueable information,
 	 * we say EOPNOTSUPP for all ARP functions
 	 */
-	if (card->info.guestlan)
-		return -EOPNOTSUPP;
+	/*if (card->info.guestlan)
+		return -EOPNOTSUPP; */
 	if (!qeth_is_supported(card,/*IPA_QUERY_ARP_ADDR_INFO*/
 			       IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
@@ -4555,21 +4666,24 @@
 
 	switch (cmd){
 	case SIOC_QETH_ARP_SET_NO_ENTRIES:
-		if (!capable(CAP_NET_ADMIN)){
+		if ( !capable(CAP_NET_ADMIN) ||
+		     (card->options.layer2) ) {
 			rc = -EPERM;
 			break;
 		}
 		rc = qeth_arp_set_no_entries(card, rq->ifr_ifru.ifru_ivalue);
 		break;
 	case SIOC_QETH_ARP_QUERY_INFO:
-		if (!capable(CAP_NET_ADMIN)){
+		if ( !capable(CAP_NET_ADMIN) ||
+		     (card->options.layer2) ) {
 			rc = -EPERM;
 			break;
 		}
 		rc = qeth_arp_query(card, rq->ifr_ifru.ifru_data);
 		break;
 	case SIOC_QETH_ARP_ADD_ENTRY:
-		if (!capable(CAP_NET_ADMIN)){
+		if ( !capable(CAP_NET_ADMIN) ||
+		     (card->options.layer2) ) {
 			rc = -EPERM;
 			break;
 		}
@@ -4580,7 +4694,8 @@
 			rc = qeth_arp_add_entry(card, &arp_entry);
 		break;
 	case SIOC_QETH_ARP_REMOVE_ENTRY:
-		if (!capable(CAP_NET_ADMIN)){
+		if ( !capable(CAP_NET_ADMIN) ||
+		     (card->options.layer2) ) {
 			rc = -EPERM;
 			break;
 		}
@@ -4591,7 +4706,8 @@
 			rc = qeth_arp_remove_entry(card, &arp_entry);
 		break;
 	case SIOC_QETH_ARP_FLUSH_CACHE:
-		if (!capable(CAP_NET_ADMIN)){
+		if ( !capable(CAP_NET_ADMIN) ||
+		     (card->options.layer2) ) {
 			rc = -EPERM;
 			break;
 		}
@@ -4677,6 +4793,7 @@
 }
 
 #ifdef CONFIG_QETH_VLAN
+static void qeth_layer2_process_vlans(struct qeth_card *);
 static void
 qeth_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
@@ -4689,6 +4806,8 @@
 	spin_lock_irqsave(&card->vlanlock, flags);
 	card->vlangrp = grp;
 	spin_unlock_irqrestore(&card->vlanlock, flags);
+	if (card->options.layer2)
+		qeth_layer2_process_vlans(card);
 }
 
 static inline void
@@ -4741,7 +4860,7 @@
 	in_dev = __in_dev_get(card->vlangrp->vlan_devices[vid]);
 	if (!in_dev)
 		goto out;
-	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next){
+	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next) {
 		addr = qeth_get_addr_buffer(QETH_PROT_IPV4);
 		if (addr){
 			addr->u.a4.addr = ifa->ifa_address;
@@ -4800,6 +4919,8 @@
 	if (card->vlangrp)
 		card->vlangrp->vlan_devices[vid] = NULL;
 	spin_unlock_irqrestore(&card->vlanlock, flags);
+	if (card->options.layer2)
+		qeth_layer2_process_vlans(card);
  	if ( (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0) ||
 	     (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0) )
 		schedule_work(&card->kernel_thread_starter);
@@ -4912,8 +5033,9 @@
 	int i;
 
 	QETH_DBF_TEXT(trace,4,"addmcvl");
-	if (!qeth_is_supported(card,IPA_FULL_VLAN) ||
-	    (card->vlangrp == NULL))
+	if ( ((card->options.layer2 == 0) &&
+	      (!qeth_is_supported(card,IPA_FULL_VLAN))) ||
+	     (card->vlangrp == NULL) )
 		return ;
 
 	vg = card->vlangrp;
@@ -4980,8 +5102,9 @@
 	int i;
 
 	QETH_DBF_TEXT(trace,4,"admc6vl");
-	if (!qeth_is_supported(card,IPA_FULL_VLAN) ||
-	    (card->vlangrp == NULL))
+	if ( ((card->options.layer2 == 0) &&
+	      (!qeth_is_supported(card,IPA_FULL_VLAN))) ||
+	     (card->vlangrp == NULL))
 		return ;
 
 	vg = card->vlangrp;
@@ -5020,6 +5143,73 @@
 }
 #endif /* CONFIG_QETH_IPV6 */
 
+static int
+qeth_layer2_send_setdelmac(struct qeth_card *card, __u8 *mac,
+			   enum qeth_ipa_cmds ipacmd)
+{
+	struct qeth_ipa_cmd *cmd;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_DBF_TEXT(trace, 2, "L2sdmac");
+	iob = qeth_get_ipacmd_buffer(card, ipacmd, QETH_PROT_IPV4);
+	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+        cmd->data.setdelmac.mac_length = OSA_ADDR_LEN;
+        memcpy(&cmd->data.setdelmac.mac, mac, OSA_ADDR_LEN);
+	return qeth_send_ipa_cmd(card, iob, NULL, NULL);
+}
+
+
+static int
+qeth_layer2_set_mac_address(struct net_device *dev, void *p)
+{
+	struct sockaddr *addr = p;
+	struct qeth_card *card;
+	int rc = 0;
+
+	QETH_DBF_TEXT(trace, 3, "setmac");
+
+	if (qeth_verify_dev(dev) != QETH_REAL_CARD) {
+		QETH_DBF_TEXT(trace, 3, "setmcINV");
+		return -EOPNOTSUPP;
+	}
+	card = (struct qeth_card *) dev->priv;
+
+	if (!card->options.layer2) {
+		PRINT_WARN("Setting MAC address on %s is not supported"
+			   "in Layer 3 mode.\n", dev->name);
+		QETH_DBF_TEXT(trace, 3, "setmcLY3");
+		return -EOPNOTSUPP;
+	}
+	QETH_DBF_TEXT_(trace, 3, "%s", CARD_BUS_ID(card));
+	QETH_DBF_HEX(trace, 3, addr->sa_data, OSA_ADDR_LEN);
+	if (card->info.layer2_mac_registered)
+		rc = qeth_layer2_send_setdelmac(card, &card->dev->dev_addr[0],
+						IPA_CMD_DELVMAC);
+	if (rc) {
+		PRINT_WARN("Error in deregistering MAC address on " \
+			   "device %s: x%x\n", CARD_BUS_ID(card), rc);
+		QETH_DBF_TEXT_(trace, 2, "err%d", rc);
+		return -EIO;
+	}
+	card->info.layer2_mac_registered = 0;
+
+	rc = qeth_layer2_send_setdelmac(card, addr->sa_data, IPA_CMD_SETVMAC);
+	if (rc) {
+		PRINT_WARN("Error in registering MAC address on " \
+			   "device %s: x%x\n", CARD_BUS_ID(card), rc);
+		QETH_DBF_TEXT_(trace, 2, "2err%d", rc);
+		return -EIO;
+	}
+	card->info.layer2_mac_registered = 1;
+	memcpy(dev->dev_addr, addr->sa_data, OSA_ADDR_LEN);
+	PRINT_INFO("MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
+		   "successfully registered on device %s\n",
+		   dev->dev_addr[0],dev->dev_addr[1],dev->dev_addr[2],
+		   dev->dev_addr[3],dev->dev_addr[4],dev->dev_addr[5],
+		   dev->name);
+
+	return rc;
+}
 /**
  * set multicast address on card
  */
@@ -5045,7 +5235,10 @@
 	cmd->hdr.seqno = card->seqno.ipa;
 	cmd->hdr.adapter_type = qeth_get_ipa_adp_type(card->info.link_type);
 	cmd->hdr.rel_adapter_no = (__u8) card->info.portno;
-	cmd->hdr.prim_version_no = 1;
+	if (card->options.layer2)
+		cmd->hdr.prim_version_no = 2;
+	else
+		cmd->hdr.prim_version_no = 1;
 	cmd->hdr.param_count = 1;
 	cmd->hdr.prot_version = prot;
 	cmd->hdr.ipa_supported = 0;
@@ -5135,8 +5328,141 @@
 	return rc;
 }
 
+#ifdef CONFIG_QETH_VLAN
+/* ATT: not a very readable order: bytes count from lower numbers, bits
+   count from lsb */
+static void
+qeth_layer2_set_bit(__u8 *ptr,int i)
+{
+        ptr[i/8]|=0x80>>(i%8);
+}
+
 static int
-qeth_register_addr_entry(struct qeth_card *card, struct qeth_ipaddr *addr)
+qeth_layer2_get_bit(__u8 *ptr,int i)
+{
+        return (ptr[i/8]&(0x80>>(i%8)))?1:0;
+}
+
+static void
+qeth_layer2_takeover_vlans(struct qeth_card *card)
+{
+        int i;
+
+	QETH_DBF_TEXT(trace, 3, "L2tkvlan");
+        /* copy new to current */
+        memcpy(&card->vlans_current[0],
+               &card->vlans_new[0],
+               VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8)));
+
+        /* clear new vector */
+        memset(&card->vlans_new[0], 0,
+	       VLAN_GROUP_ARRAY_LEN/(8*sizeof(__u8)));
+
+        for (i=0; i<VLAN_GROUP_ARRAY_LEN; i++) {
+                if ( (card->vlangrp) &&
+                     (card->vlangrp->vlan_devices[i]) )
+                        qeth_layer2_set_bit(&card->vlans_new[0], i);
+        }
+}
+
+static void
+qeth_layer2_send_setdelvlan(struct qeth_card *card, __u16 i,
+			    enum qeth_ipa_cmds ipacmd)
+{
+ 	int rc;
+	struct qeth_ipa_cmd *cmd;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_DBF_TEXT(trace, 4, "L2sdvlan");
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
+qeth_layer2_register_vlans(struct qeth_card *card)
+{
+        __u16 i;
+
+	QETH_DBF_TEXT(trace, 3, "L2regvln");
+        for (i=0; i<VLAN_GROUP_ARRAY_LEN; i++) {
+                if ( (qeth_layer2_get_bit(&card->vlans_current[0], i)) &&
+                     (!qeth_layer2_get_bit(&card->vlans_new[0], i)) )
+                        qeth_layer2_send_setdelvlan(card, i, IPA_CMD_DELVLAN);
+                if ( (!qeth_layer2_get_bit(&card->vlans_current[0], i)) &&
+                     (qeth_layer2_get_bit(&card->vlans_new[0], i)) )
+                        qeth_layer2_send_setdelvlan(card, i, IPA_CMD_SETVLAN);
+        }
+}
+
+static void
+qeth_layer2_process_vlans(struct qeth_card *card)
+{
+	QETH_DBF_TEXT(trace, 2, "L2provln");
+
+	qeth_layer2_takeover_vlans(card);
+	qeth_layer2_register_vlans(card);
+}
+
+#endif
+
+static int
+qeth_layer2_register_addr_entry(struct qeth_card *card,
+				struct qeth_ipaddr *addr)
+{
+	int rc = 0;
+
+	if (!addr->is_multicast)
+		return 0;
+
+	QETH_DBF_TEXT(trace, 2, "setgmac");
+	QETH_DBF_HEX(trace,3,&addr->mac[0],OSA_ADDR_LEN);
+	rc = qeth_layer2_send_setdelmac(card, &addr->mac[0],
+					IPA_CMD_SETGMAC);
+	if (rc)
+		PRINT_ERR("Could not set group MAC " \
+			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
+			  addr->mac[0],addr->mac[1],addr->mac[2],
+			  addr->mac[3],addr->mac[4],addr->mac[5],
+			  card->info.if_name,rc);
+	return rc;
+}
+
+static int
+qeth_layer2_deregister_addr_entry(struct qeth_card *card,
+				  struct qeth_ipaddr *addr)
+{
+	int rc = 0;
+
+	if (!addr->is_multicast)
+		return 0;
+
+	QETH_DBF_TEXT(trace, 2, "delgmac");
+	QETH_DBF_HEX(trace,3,&addr->mac[0],OSA_ADDR_LEN);
+	rc = qeth_layer2_send_setdelmac(card, &addr->mac[0],
+					IPA_CMD_DELGMAC);
+	if (rc)
+		PRINT_ERR("Could not delete group MAC " \
+			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
+			  addr->mac[0],addr->mac[1],addr->mac[2],
+			  addr->mac[3],addr->mac[4],addr->mac[5],
+			  card->info.if_name,rc);
+	return rc;
+
+}
+
+static int
+qeth_layer3_register_addr_entry(struct qeth_card *card,
+				struct qeth_ipaddr *addr)
 {
 	//char buf[50];
 	int rc;
@@ -5175,7 +5501,8 @@
 }
 
 static int
-qeth_deregister_addr_entry(struct qeth_card *card, struct qeth_ipaddr *addr)
+qeth_layer3_deregister_addr_entry(struct qeth_card *card,
+				  struct qeth_ipaddr *addr)
 {
 	//char buf[50];
 	int rc;
@@ -5209,6 +5536,24 @@
 }
 
 static int
+qeth_register_addr_entry(struct qeth_card *card, struct qeth_ipaddr *addr)
+{
+	if (card->options.layer2)
+		return qeth_layer2_register_addr_entry(card, addr);
+
+	return qeth_layer3_register_addr_entry(card, addr);
+}
+
+static int
+qeth_deregister_addr_entry(struct qeth_card *card, struct qeth_ipaddr *addr)
+{
+	if (card->options.layer2)
+		return qeth_layer2_deregister_addr_entry(card, addr);
+
+	return qeth_layer3_deregister_addr_entry(card, addr);
+}
+
+static int
 qeth_netdev_init(struct net_device *dev)
 {
 	struct qeth_card *card;
@@ -5231,7 +5576,7 @@
 	dev->vlan_rx_register = qeth_vlan_rx_register;
 	dev->vlan_rx_kill_vid = qeth_vlan_rx_kill_vid;
 #endif
-	if (qeth_get_netdev_flags(card->info.type) & IFF_NOARP) {
+	if (qeth_get_netdev_flags(card) & IFF_NOARP) {
 		dev->rebuild_header = NULL;
 		dev->hard_header = NULL;
 		dev->header_cache_update = NULL;
@@ -5246,8 +5591,8 @@
 
 #endif
 	dev->hard_header_parse = NULL;
-	dev->set_mac_address = NULL;
-	dev->flags |= qeth_get_netdev_flags(card->info.type);
+	dev->set_mac_address = qeth_layer2_set_mac_address;
+	dev->flags |= qeth_get_netdev_flags(card);
 	if ((card->options.fake_broadcast) ||
 	    (card->info.broadcast_capable))
 		dev->flags |= IFF_BROADCAST;
@@ -5560,6 +5905,37 @@
 	return rc;
 }
 
+static int
+qeth_layer2_initialize(struct qeth_card *card)
+{
+        int rc = 0;
+
+
+        QETH_DBF_TEXT(setup, 2, "doL2init");
+        QETH_DBF_TEXT_(setup, 2, "doL2%s", CARD_BUS_ID(card));
+
+	rc = qeth_setadpparms_change_macaddr(card);
+	if (rc) {
+		PRINT_WARN("couldn't get MAC address on "
+			   "device %s: x%x\n",
+			   CARD_BUS_ID(card), rc);
+		QETH_DBF_TEXT_(setup, 2,"1err%d",rc);
+		return rc;
+        }
+	QETH_DBF_HEX(setup,2, card->dev->dev_addr, OSA_ADDR_LEN);
+
+	rc = qeth_layer2_send_setdelmac(card, &card->dev->dev_addr[0],
+					IPA_CMD_SETVMAC);
+        if (rc) {
+		card->info.layer2_mac_registered = 0;
+                PRINT_WARN("Error in processing MAC address on " \
+                           "device %s: x%x\n",CARD_BUS_ID(card),rc);
+		QETH_DBF_TEXT_(setup, 2,"2err%d",rc);
+        } else
+		card->info.layer2_mac_registered = 1;
+        return 0;
+}
+
 
 static int
 qeth_send_startstoplan(struct qeth_card *card, enum qeth_ipa_cmds ipacmd,
@@ -5629,6 +6005,10 @@
 	struct qeth_cmd_buffer *iob;
 
 	QETH_DBF_TEXT_(setup, 2, "qipassi%i", prot);
+	if (card->options.layer2) {
+		QETH_DBF_TEXT(setup, 2, "noprmly2");
+		return -EPERM;
+	}
 
 	iob = qeth_get_ipacmd_buffer(card,IPA_CMD_QIPASSIST,prot);
 	rc = qeth_send_ipa_cmd(card, iob, qeth_query_ipassists_cb, NULL);
@@ -6177,6 +6557,21 @@
 			return rc;
 	} else
 		card->lan_online = 1;
+	if (card->options.layer2) {
+		card->dev->features |=
+			NETIF_F_HW_VLAN_TX |
+			NETIF_F_HW_VLAN_RX;
+		card->dev->flags|=IFF_MULTICAST|IFF_BROADCAST;
+		card->info.broadcast_capable=1;
+		if ((rc = qeth_layer2_initialize(card))) {
+			QETH_DBF_TEXT_(setup, 2, "L2err%d", rc);
+			return rc;
+		}
+#ifdef CONFIG_QETH_VLAN
+		qeth_layer2_process_vlans(card);
+#endif
+		goto out;
+	}
 	if ((rc = qeth_setadapter_parms(card)))
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
 	if ((rc = qeth_start_ipassists(card)))
@@ -6185,6 +6580,7 @@
 		QETH_DBF_TEXT_(setup, 2, "4err%d", rc);
 	if ((rc = qeth_setrouting_v6(card)))
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
+out:
 	netif_stop_queue(card->dev);
 	return 0;
 }
@@ -6330,9 +6726,14 @@
 		rtnl_lock();
 		dev_close(card->dev);
 		rtnl_unlock();
-		if (!card->use_hard_stop)
+		if (!card->use_hard_stop) {
+			__u8 *mac = &card->dev->dev_addr[0];
+			if ((rc = qeth_layer2_send_setdelmac(card, mac,
+							    IPA_CMD_DELVMAC)));
+				QETH_DBF_TEXT_(setup, 2, "Lerr%d", rc);
 			if ((rc = qeth_send_stoplan(card)))
 				QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
+		}
 		card->state = CARD_STATE_SOFTSETUP;
 	}
 	if (card->state == CARD_STATE_SOFTSETUP) {
@@ -6341,7 +6742,8 @@
 		card->state = CARD_STATE_HARDSETUP;
 	}
 	if (card->state == CARD_STATE_HARDSETUP) {
-		if (!card->use_hard_stop)
+		if ((!card->use_hard_stop) &&
+		    (!card->options.layer2))
 			if ((rc = qeth_put_unique_id(card)))
 				QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
 		qeth_qdio_clear_card(card, 0);
@@ -6507,6 +6909,57 @@
 		schedule_work(&card->kernel_thread_starter);
 }
 
+
+/* Layer 2 specific stuff */
+#define IGNORE_PARAM_EQ(option,value,reset_value,msg) \
+        if (card->options.option == value) { \
+                PRINT_ERR("%s not supported with layer 2 " \
+                          "functionality, ignoring option on read" \
+			  "channel device %s .\n",msg,CARD_RDEV_ID(card)); \
+                card->options.option = reset_value; \
+        }
+#define IGNORE_PARAM_NEQ(option,value,reset_value,msg) \
+        if (card->options.option != value) { \
+                PRINT_ERR("%s not supported with layer 2 " \
+                          "functionality, ignoring option on read" \
+			  "channel device %s .\n",msg,CARD_RDEV_ID(card)); \
+                card->options.option = reset_value; \
+        }
+
+
+static void qeth_make_parameters_consistent(struct qeth_card *card)
+{
+
+        if (card->options.layer2) {
+                if (card->info.type == QETH_CARD_TYPE_IQD) {
+                        PRINT_ERR("Device %s does not support " \
+                                  "layer 2 functionality. "  \
+                                  "Ignoring layer2 option.\n",CARD_BUS_ID(card));
+                }
+                IGNORE_PARAM_NEQ(route4.type, NO_ROUTER, NO_ROUTER,
+                                 "Routing options are");
+#ifdef CONFIG_QETH_IPV6
+                IGNORE_PARAM_NEQ(route6.type, NO_ROUTER, NO_ROUTER,
+                                 "Routing options are");
+#endif
+                IGNORE_PARAM_EQ(checksum_type, HW_CHECKSUMMING,
+                                QETH_CHECKSUM_DEFAULT,
+                                "Checksumming options are");
+                IGNORE_PARAM_NEQ(broadcast_mode, QETH_TR_BROADCAST_ALLRINGS,
+                                 QETH_TR_BROADCAST_ALLRINGS,
+                                 "Broadcast mode options are");
+                IGNORE_PARAM_NEQ(macaddr_mode, QETH_TR_MACADDR_NONCANONICAL,
+                                 QETH_TR_MACADDR_NONCANONICAL,
+                                 "Canonical MAC addr options are");
+                IGNORE_PARAM_NEQ(fake_broadcast, 0, 0,
+				 "Broadcast faking options are");
+                IGNORE_PARAM_NEQ(add_hhlen, DEFAULT_ADD_HHLEN,
+                                 DEFAULT_ADD_HHLEN,"Option add_hhlen is");
+                IGNORE_PARAM_NEQ(fake_ll, 0, 0,"Option fake_ll is");
+        }
+}
+
+
 static int
 qeth_set_online(struct ccwgroup_device *gdev)
 {
@@ -6533,35 +6986,35 @@
 		return -EIO;
 	}
 
+	if (card->options.layer2)
+		qeth_make_parameters_consistent(card);
+
 	if ((rc = qeth_hardsetup_card(card))){
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
 		goto out_remove;
 	}
 	card->state = CARD_STATE_HARDSETUP;
 
-	if ((rc = qeth_query_ipassists(card,QETH_PROT_IPV4))){
-		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
-		/*TODO: rc !=0*/
-	} else
+	if (!(rc = qeth_query_ipassists(card,QETH_PROT_IPV4)))
 		rc = qeth_get_unique_id(card);
 
-	if (rc) {
-		QETH_DBF_TEXT_(setup, 2, "4err%d", rc);
+	if (rc && card->options.layer2 == 0) {
+		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
 		goto out_remove;
 	}
 	qeth_print_status_message(card);
 	if ((rc = qeth_register_netdev(card))){
-		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
+		QETH_DBF_TEXT_(setup, 2, "4err%d", rc);
 		goto out_remove;
 	}
 	if ((rc = qeth_softsetup_card(card))){
-		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
+		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
 		goto out_remove;
 	}
 	card->state = CARD_STATE_SOFTSETUP;
 
 	if ((rc = qeth_init_qdio_queues(card))){
-		QETH_DBF_TEXT_(setup, 2, "7err%d", rc);
+		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
 		goto out_remove;
 	}
 /*maybe it was set offline without ifconfig down
@@ -6714,10 +7167,13 @@
 	struct net_device *dev = neigh->dev;
 	struct in_device *in_dev;
 	struct neigh_parms *parms;
+	struct qeth_card *card;
 
-	if (!qeth_verify_dev(dev)) {
-		return qeth_old_arp_constructor(neigh);
-	}
+	card = qeth_get_card_from_dev(dev);
+	if (card == NULL)
+		goto out;
+	if(card->options.layer2)
+		goto out;
 
 	rcu_read_lock();
 	in_dev = rcu_dereference(__in_dev_get(dev));
@@ -6736,6 +7192,8 @@
 	neigh->ops = arp_direct_ops;
 	neigh->output = neigh->ops->queue_xmit;
 	return 0;
+out:
+	return qeth_old_arp_constructor(neigh);
 }
 #endif  /*CONFIG_QETH_IPV6*/
 
@@ -7019,6 +7477,8 @@
 	card = qeth_get_card_from_dev(dev);
 	if (!card)
 		return NOTIFY_DONE;
+	if (card->options.layer2)
+		return NOTIFY_DONE;
 
 	addr = qeth_get_addr_buffer(QETH_PROT_IPV4);
 	if (addr != NULL) {
diff -urN linux-2.6/drivers/s390/net/qeth_mpc.h linux-2.6-patched/drivers/s390/net/qeth_mpc.h
--- linux-2.6/drivers/s390/net/qeth_mpc.h	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_mpc.h	2004-10-08 19:19:15.000000000 +0200
@@ -14,7 +14,7 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.36 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.38 $"
 
 extern const char *VERSION_QETH_MPC_C;
 
@@ -105,6 +105,12 @@
 enum qeth_ipa_cmds {
 	IPA_CMD_STARTLAN              = 0x01,
 	IPA_CMD_STOPLAN               = 0x02,
+	IPA_CMD_SETVMAC 	      = 0x21,
+	IPA_CMD_DELVMAC 	      =	0x22,
+	IPA_CMD_SETGMAC  	      = 0x23,
+	IPA_CMD_DELGMAC 	      = 0x24,
+	IPA_CMD_SETVLAN 	      = 0x25,
+	IPA_CMD_DELVLAN 	      = 0x26,
 	IPA_CMD_SETIP                 = 0xb1,
 	IPA_CMD_DELIP                 = 0xb7,
 	IPA_CMD_QIPASSIST             = 0xb2,
@@ -239,6 +245,16 @@
 	__u8 ip4[4];
 } __attribute__ ((packed));
 
+struct qeth_ipacmd_layer2setdelmac {
+	__u32 mac_length;
+	__u8 mac[6];
+} __attribute__ ((packed));
+
+struct qeth_ipacmd_layer2setdelvlan {
+	__u16 vlan_id;
+} __attribute__ ((packed));
+
+
 struct qeth_ipacmd_setassparms_hdr {
 	__u32 assist_no;
 	__u16 length;
@@ -381,13 +397,15 @@
 struct qeth_ipa_cmd {
 	struct qeth_ipacmd_hdr hdr;
 	union {
-		struct qeth_ipacmd_setdelip4   	setdelip4;
-		struct qeth_ipacmd_setdelip6   	setdelip6;
-		struct qeth_ipacmd_setdelipm	setdelipm;
-		struct qeth_ipacmd_setassparms 	setassparms;
-		struct qeth_create_destroy_address create_destroy_addr;
-		struct qeth_ipacmd_setadpparms 	setadapterparms;
-		struct qeth_set_routing setrtg;
+		struct qeth_ipacmd_setdelip4   		setdelip4;
+		struct qeth_ipacmd_setdelip6   		setdelip6;
+		struct qeth_ipacmd_setdelipm		setdelipm;
+		struct qeth_ipacmd_setassparms 		setassparms;
+		struct qeth_ipacmd_layer2setdelmac  	setdelmac;
+		struct qeth_ipacmd_layer2setdelvlan 	setdelvlan;
+		struct qeth_create_destroy_address 	create_destroy_addr;
+		struct qeth_ipacmd_setadpparms 		setadapterparms;
+		struct qeth_set_routing 		setrtg;
 	} data;
 } __attribute__ ((packed));
 
@@ -459,6 +477,11 @@
 		(PDU_ENCAPSULATION(buffer) + 0x17)
 #define QETH_ULP_ENABLE_RESP_LINK_TYPE(buffer) \
 		(PDU_ENCAPSULATION(buffer)+ 0x2b)
+/* Layer 2 defintions */
+#define QETH_PROT_LAYER2 0x08
+#define QETH_PROT_TCPIP  0x03
+#define QETH_ULP_ENABLE_PROT_TYPE(buffer) (buffer+0x50)
+#define QETH_IPA_CMD_PROT_TYPE(buffer) (buffer+0x19)
 
 extern unsigned char ULP_SETUP[];
 #define ULP_SETUP_SIZE 0x6c
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2004-08-14 12:55:33.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2004-10-08 19:19:15.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.33 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.35 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.33 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.35 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -694,6 +694,44 @@
 static DEVICE_ATTR(canonical_macaddr, 0644, qeth_dev_canonical_macaddr_show,
 		   qeth_dev_canonical_macaddr_store);
 
+static ssize_t
+qeth_dev_layer2_show(struct device *dev, char *buf)
+{
+	struct qeth_card *card = dev->driver_data;
+
+	if (!card)
+		return -EINVAL;
+
+	return sprintf(buf, "%i\n", card->options.layer2 ? 1:0);
+}
+
+static ssize_t
+qeth_dev_layer2_store(struct device *dev, const char *buf, size_t count)
+{
+	struct qeth_card *card = dev->driver_data;
+	char *tmp;
+	int i;
+
+	if (!card)
+		return -EINVAL;
+
+	if ((card->state != CARD_STATE_DOWN) &&
+	    (card->state != CARD_STATE_RECOVER))
+		return -EPERM;
+
+	i = simple_strtoul(buf, &tmp, 16);
+	if ((i == 0) || (i == 1))
+		card->options.layer2 = i;
+	else {
+		PRINT_WARN("layer2: write 0 or 1 to this file!\n");
+		return -EINVAL;
+	}
+	return count;
+}
+
+static DEVICE_ATTR(layer2, 0644, qeth_dev_layer2_show,
+		   qeth_dev_layer2_store);
+
 static struct device_attribute * qeth_device_attrs[] = {
 	&dev_attr_state,
 	&dev_attr_chpid,
@@ -714,6 +752,7 @@
 	&dev_attr_recover,
 	&dev_attr_broadcast_mode,
 	&dev_attr_canonical_macaddr,
+	&dev_attr_layer2,
 	NULL,
 };
 
@@ -729,6 +768,15 @@
 	.store	= _store,						     \
 };
 
+int
+qeth_check_layer2(struct qeth_card *card)
+{
+	if (card->options.layer2)
+		return -EPERM;
+	return 0;
+}
+
+
 static ssize_t
 qeth_dev_ipato_enable_show(struct device *dev, char *buf)
 {
@@ -737,6 +785,8 @@
 	if (!card)
 		return -EINVAL;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	return sprintf(buf, "%i\n", card->ipato.enabled? 1:0);
 }
 
@@ -753,6 +803,9 @@
 	    (card->state != CARD_STATE_RECOVER))
 		return -EPERM;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	tmp = strsep((char **) &buf, "\n");
 	if (!strcmp(tmp, "toggle")){
 		card->ipato.enabled = (card->ipato.enabled)? 0 : 1;
@@ -780,6 +833,9 @@
 	if (!card)
 		return -EINVAL;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	return sprintf(buf, "%i\n", card->ipato.invert4? 1:0);
 }
 
@@ -792,6 +848,9 @@
 	if (!card)
 		return -EINVAL;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	tmp = strsep((char **) &buf, "\n");
 	if (!strcmp(tmp, "toggle")){
 		card->ipato.invert4 = (card->ipato.invert4)? 0 : 1;
@@ -820,6 +879,9 @@
 	char addr_str[49];
 	int i = 0;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	spin_lock_irqsave(&card->ip_lock, flags);
 	list_for_each_entry(ipatoe, &card->ipato.entries, entry){
 		if (ipatoe->proto != proto)
@@ -880,6 +942,8 @@
 	int mask_bits;
 	int rc;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	if ((rc = qeth_parse_ipatoe(buf, proto, addr, &mask_bits)))
 		return rc;
 
@@ -923,6 +987,8 @@
 	int mask_bits;
 	int rc;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	if ((rc = qeth_parse_ipatoe(buf, proto, addr, &mask_bits)))
 		return rc;
 
@@ -954,6 +1020,9 @@
 	if (!card)
 		return -EINVAL;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	return sprintf(buf, "%i\n", card->ipato.invert6? 1:0);
 }
 
@@ -966,6 +1035,9 @@
 	if (!card)
 		return -EINVAL;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	tmp = strsep((char **) &buf, "\n");
 	if (!strcmp(tmp, "toggle")){
 		card->ipato.invert6 = (card->ipato.invert6)? 0 : 1;
@@ -1054,6 +1126,9 @@
 	unsigned long flags;
 	int i = 0;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	spin_lock_irqsave(&card->ip_lock, flags);
 	list_for_each_entry(ipaddr, &card->ip_list, entry){
 		if (ipaddr->proto != proto)
@@ -1098,6 +1173,8 @@
 	u8 addr[16] = {0, };
 	int rc;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	if ((rc = qeth_parse_vipae(buf, proto, addr)))
 		return rc;
 
@@ -1129,6 +1206,8 @@
 	u8 addr[16];
 	int rc;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	if ((rc = qeth_parse_vipae(buf, proto, addr)))
 		return rc;
 
@@ -1186,6 +1265,9 @@
 	if (!card)
 		return -EINVAL;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	return qeth_dev_vipa_del_store(buf, count, card, QETH_PROT_IPV6);
 }
 
@@ -1217,6 +1299,9 @@
 	unsigned long flags;
 	int i = 0;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
+
 	spin_lock_irqsave(&card->ip_lock, flags);
 	list_for_each_entry(ipaddr, &card->ip_list, entry){
 		if (ipaddr->proto != proto)
@@ -1261,6 +1346,8 @@
 	u8 addr[16] = {0, };
 	int rc;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	if ((rc = qeth_parse_rxipe(buf, proto, addr)))
 		return rc;
 
@@ -1292,6 +1379,8 @@
 	u8 addr[16];
 	int rc;
 
+	if (qeth_check_layer2(card))
+		return -EPERM;
 	if ((rc = qeth_parse_rxipe(buf, proto, addr)))
 		return rc;
 
