Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbTGQQ2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271340AbTGQQ2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:28:10 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:40102 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S271319AbTGQQZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:25:36 -0400
Date: Thu, 17 Jul 2003 18:39:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (5/6): qeth network driver.
Message-ID: <20030717163923.GF2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Reset netdevice to defaults in offline processing.
 - Fix checksumming.
 - Fix routing status display.
 - Get rid of _ccw_device_get_device_number in qeth.
 - Inline some functions to save stack space.

diffstat:
 drivers/s390/net/qeth.c     |  155 +++++++++++++++++++++++++++-----------------
 drivers/s390/net/qeth.h     |    6 +
 drivers/s390/net/qeth_mpc.h |    4 -
 3 files changed, 103 insertions(+), 62 deletions(-)

diff -urN linux-2.6.0-test1/drivers/s390/net/qeth.c linux-2.6.0-s390/drivers/s390/net/qeth.c
--- linux-2.6.0-test1/drivers/s390/net/qeth.c	Mon Jul 14 05:39:34 2003
+++ linux-2.6.0-s390/drivers/s390/net/qeth.c	Thu Jul 17 17:27:34 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.118 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.126 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -165,7 +165,7 @@
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.118 $"
+#define VERSION_QETH_C "$Revision: 1.126 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -1156,7 +1156,7 @@
 	return skb;
 }
 
-static struct sk_buff *
+static inline struct sk_buff *
 qeth_get_next_skb(struct qeth_card *card,
 		  int *element_ptr, int *pos_in_el_ptr,
 		  void **hdr_ptr, struct qdio_buffer *buffer)
@@ -1464,8 +1464,21 @@
 	skb->ip_summed = card->options.checksum_type;
 	if (card->options.checksum_type == HW_CHECKSUMMING) {
 		/* do we have a checksummed packet? */
-		if (*(__u8 *) (hdr_ptr + 11) & QETH_EXT_HEADER_CSUM_TRANSP_REQ) {
-			/* skb->ip_summed is set already */
+
+		/* 
+		 * we only check for TCP/UDP checksums when the pseudo
+		 * header was also checked successfully -- for the
+		 * rest of the packets, it's not clear, whether the
+		 * upper layer csum is alright. And they shouldn't
+		 * occur too often anyway in real life 
+		 */
+
+		if ((*(__u8*)(hdr_ptr+11) & (QETH_EXT_HEADER_CSUM_HDR_REQ |
+					     QETH_EXT_HEADER_CSUM_TRANSP_REQ)) ==
+		    (QETH_EXT_HEADER_CSUM_HDR_REQ |
+		     QETH_EXT_HEADER_CSUM_TRANSP_REQ)) {
+#if 0
+			/* csum does not need to be set inbound anyway */
 			
 			/* 
 			 * vlan is not an issue here, it's still in
@@ -1485,11 +1498,15 @@
 					(&skb->data[ip_len +
 						    QETH_TCP_CSUM_OFFSET]);
 			}
+#endif /* 0 */
+			skb->ip_summed=CHECKSUM_UNNECESSARY;
 		} else {
 			/* make the stack check it */
 			skb->ip_summed = SW_CHECKSUMMING;
 		}
-	}
+	} else
+		skb->ip_summed=card->options.checksum_type;
+
 	__qeth_rebuild_skb_vlan(card, skb, hdr_ptr);
 }
 
@@ -1596,7 +1613,7 @@
 #endif
 }
 
-static __u8
+static inline __u8
 __qeth_get_flags_v4(int multicast)
 {
 	if (multicast == RTN_MULTICAST)
@@ -1606,7 +1623,7 @@
 	return QETH_CAST_UNICAST;
 }
 
-static __u8
+static inline __u8
 __qeth_get_flags_v6(int multicast)
 {
 	if (multicast == RTN_MULTICAST)
@@ -1625,7 +1642,7 @@
 		QETH_HEADER_IPV6;
 }
 
-static void
+static inline void
 qeth_fill_header(struct qeth_hdr *hdr, struct sk_buff *skb,
 		 int version, int multicast)
 {
@@ -1681,7 +1698,7 @@
 		      __max(QETH_DBF_DATA_LEN, QETH_DBF_DATA_LEN));
 }
 
-static int inline
+static inline int
 qeth_fill_buffer(struct qdio_buffer *buffer, char *dataptr,
 		 int length, int element)
 {
@@ -1735,7 +1752,7 @@
 	return element;
 }
 
-static void
+static inline void
 qeth_flush_packed_packets(struct qeth_card *card, int queue, int under_int)
 {
 	struct qdio_buffer *buffer;
@@ -1900,7 +1917,7 @@
 	return ERROR_LINK_FAILURE;	/* should never happen */
 }
 
-static void
+static inline void
 qeth_free_buffer(struct qeth_card *card, int queue, int bufno,
 		 int qdio_error, int siga_error)
 {
@@ -2013,7 +2030,7 @@
 	card->send_retries[queue][bufno] = 0;
 }
 
-static void
+static inline void
 qeth_free_all_skbs(struct qeth_card *card)
 {
 	int q, b;
@@ -2049,7 +2066,7 @@
 }
 
 #ifdef QETH_VLAN
-void
+static inline void
 qeth_insert_ipv6_vlan_tag(struct sk_buff *__skb)
 {
 
@@ -2088,7 +2105,7 @@
 #endif
 }
 
-static void
+static inline void
 qeth_send_packet_fast(struct qeth_card *card, struct sk_buff *skb,
 		      struct net_device *dev,
 		      int queue, int version, int multicast)
@@ -2183,7 +2200,7 @@
 
 /* no checks, if all elements are used, as then we would not be here (at most
    127 buffers are enqueued) */
-static void
+static inline void
 qeth_send_packet_packed(struct qeth_card *card, struct sk_buff *skb,
 			struct net_device *dev,
 			int queue, int version, int multicast)
@@ -2391,7 +2408,7 @@
 	}
 }
 
-static int
+static inline int
 qeth_do_send_packet(struct qeth_card *card, struct sk_buff *skb,
 		    struct net_device *dev)
 {
@@ -2829,23 +2846,27 @@
 
 	if (!buffer) {
 		if (atomic_read(&card->escape_softsetup))
-			result = 0;
+			return 0;
 		else
-			result = -1;
-	} else {
-		reply = (struct ipa_cmd *) PDU_ENCAPSULATION(buffer);
-		if ((update_cmd) && (reply))
-			memcpy(cmd, reply, sizeof (struct ipa_cmd));
-		result = reply->return_code;
-
-		/* some special sausages: */
-		if ((ipa_cmd == IPA_CMD_SETASSPARMS) && (result == 0)) {
-			result = reply->data.setassparms.return_code;
-		}
-		if ((ipa_cmd == IPA_CMD_SETADAPTERPARMS) && (result == 0)) {
-			result = reply->data.setadapterparms.return_code;
-		}
+			return -1;
+	}
+	reply = (struct ipa_cmd *) PDU_ENCAPSULATION(buffer);
+	if ((update_cmd) && (reply))
+		memcpy(cmd, reply, sizeof (struct ipa_cmd));
+	result = reply->return_code;
+
+	/* some special sausages: */
+	if ((ipa_cmd == IPA_CMD_SETASSPARMS) && (result == 0)) {
+		result = reply->data.setassparms.return_code;
+		if ((reply->data.setassparms.assist_no==IPA_INBOUND_CHECKSUM) &&
+		    (reply->data.setassparms.command_code == IPA_CMD_ASS_START))
+			card->csum_enable_mask =
+				reply->data.setassparms.data.flags_32bit;
+	}
+	if ((ipa_cmd == IPA_CMD_SETADAPTERPARMS) && (result == 0)) {
+		result = reply->data.setadapterparms.return_code;
 	}
+
 	return result;
 }
 
@@ -5599,7 +5620,7 @@
 			}
 			result=qeth_send_setassparms_simple_with_data
 				(card,IPA_INBOUND_CHECKSUM,
-				 IPA_CMD_ASS_ENABLE, IPA_CHECKSUM_ENABLE_MASK);
+				 IPA_CMD_ASS_ENABLE, card->csum_enable_mask);
 			if (result) {
 				PRINT_WARN("Could not enable inbound " \
 					   "checksumming on %s: 0x%x, " \
@@ -6881,6 +6902,14 @@
 	return level;		/* hmmm... don't know what to do with that level. */
 }
 
+/* returns last four digits of bus_id */
+static inline __u16
+__raw_devno_from_bus_id(char *id)
+{
+	id += (strlen(id) - 4); 
+	return (__u16) simple_strtoul(id, &id, 16);
+}
+
 static int
 qeth_idx_activate_read(struct qeth_card *card)
 {
@@ -6905,7 +6934,7 @@
 	memcpy(QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->sendbuf),
 	       &card->func_level, 2);
 
-	temp = _ccw_device_get_device_number(card->ddev);
+	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
 	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(card->dma_stuff->sendbuf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(card->dma_stuff->sendbuf),
@@ -7501,10 +7530,8 @@
 	for (; tmp && (!result); tmp = tmp->next) {
 		if (atomic_read(&tmp->shutdown_phase))
 			continue;
-		if (dev == tmp->dev) {
-			result = QETH_VERIFY_IS_REAL_DEV;
-		}
-		result = __qeth_verify_dev_vlan(dev, tmp);
+		result = (dev == tmp->dev)?
+			QETH_VERIFY_IS_REAL_DEV:__qeth_verify_dev_vlan(dev, tmp);
 	}
 	read_unlock(&list_lock);
 	return result;
@@ -8547,6 +8574,8 @@
 	card->ip_mc_new_state.ipm6_ifa = NULL;
 #endif /* QETH_IPV6 */
 
+	card->csum_enable_mask = IPA_CHECKSUM_DEFAULT_ENABLE_MASK;
+
 	/* setup net_device stuff */
 	card->dev->priv = card;
 
@@ -9087,21 +9116,19 @@
 		/* FIXME: this is really a mess... */
 
 #ifdef QETH_IPV6
-		if (atomic_read(&card->rt4fld) && atomic_read(&card->rt6fld))
-			strcpy(router_str, "no");
-		else if (atomic_read(&card->rt4fld)
-			 || atomic_read(&card->rt6fld))
-			strcpy(router_str, "mix");
+		if (atomic_read(&card->rt4fld) || atomic_read(&card->rt6fld))
+			strcpy(router_str, "FLD");
 #else/* QETH_IPV6 */
 		if (atomic_read(&card->rt4fld))
-			strcpy(router_str, "no");
+			strcpy(router_str, "FLD");
 #endif /* QETH_IPV6 */
 		else if (((card->options.routing_type4 & ROUTER_MASK) ==
 			  PRIMARY_ROUTER)
 #ifdef QETH_IPV6
 			 &&
-			 ((card->options.routing_type6 & ROUTER_MASK) ==
-			  PRIMARY_ROUTER)
+			 (((card->options.routing_type6 & ROUTER_MASK) ==
+			  PRIMARY_ROUTER) ||
+			  (!qeth_is_supported(IPA_IPv6)))
 #endif /* QETH_IPV6 */
 		    ) {
 			strcpy(router_str, "pri");
@@ -9110,8 +9137,9 @@
 			 SECONDARY_ROUTER)
 #ifdef QETH_IPV6
 			&&
-			((card->options.routing_type6 & ROUTER_MASK) ==
-			 SECONDARY_ROUTER)
+			(((card->options.routing_type6 & ROUTER_MASK) ==
+			 SECONDARY_ROUTER) ||
+			 (!qeth_is_supported(IPA_IPv6)))
 #endif /* QETH_IPV6 */
 		    ) {
 			strcpy(router_str, "sec");
@@ -9120,8 +9148,9 @@
 			 MULTICAST_ROUTER)
 #ifdef QETH_IPV6
 			&&
-			((card->options.routing_type6 & ROUTER_MASK) ==
-			 MULTICAST_ROUTER)
+			(((card->options.routing_type6 & ROUTER_MASK) ==
+			 MULTICAST_ROUTER) ||
+			 (!qeth_is_supported(IPA_IPv6)))
 #endif /* QETH_IPV6 */
 		    ) {
 			strcpy(router_str, "mc");
@@ -9130,8 +9159,9 @@
 			 PRIMARY_CONNECTOR)
 #ifdef QETH_IPV6
 			&&
-			((card->options.routing_type6 & ROUTER_MASK) ==
-			 PRIMARY_CONNECTOR)
+			(((card->options.routing_type6 & ROUTER_MASK) ==
+			 PRIMARY_CONNECTOR) ||
+			 (!qeth_is_supported(IPA_IPv6)))
 #endif /* QETH_IPV6 */
 		    ) {
 			strcpy(router_str, "p.c");
@@ -9140,8 +9170,9 @@
 			 SECONDARY_CONNECTOR)
 #ifdef QETH_IPV6
 			&&
-			((card->options.routing_type6 & ROUTER_MASK) ==
-			 SECONDARY_CONNECTOR)
+			(((card->options.routing_type6 & ROUTER_MASK) ==
+			 SECONDARY_CONNECTOR) ||
+			 (!qeth_is_supported(IPA_IPv6)))
 #endif /* QETH_IPV6 */
 		    ) {
 			strcpy(router_str, "s.c");
@@ -9150,8 +9181,9 @@
 			 NO_ROUTER)
 #ifdef QETH_IPV6
 			&&
-			((card->options.routing_type6 & ROUTER_MASK) ==
-			 NO_ROUTER)
+			(((card->options.routing_type6 & ROUTER_MASK) ==
+			 NO_ROUTER) ||
+			 (!qeth_is_supported(IPA_IPv6)))
 #endif /* QETH_IPV6 */
 		    ) {
 			strcpy(router_str, "no");
@@ -10115,7 +10147,7 @@
 		return -EINVAL;
 
 	if (atomic_read(&card->rt4fld))
-		return sprintf(buf, "%s\n", "no");
+		return sprintf(buf, "%s\n", "FLD");
 
 	switch (card->options.routing_type4 & ROUTER_MASK) {
 	case PRIMARY_ROUTER:
@@ -10202,7 +10234,10 @@
 		return -EINVAL;
 
 	if (atomic_read(&card->rt6fld))
-		return sprintf(buf, "%s\n", "no");
+		return sprintf(buf, "%s\n", "FLD");
+
+	if (!qeth_is_supported(IPA_IPv6))
+		return sprintf(buf, "%s\n", "n/a");
 
 	switch (card->options.routing_type6 & ROUTER_MASK) {
 	case PRIMARY_ROUTER:
@@ -11061,6 +11096,10 @@
 
 	QETH_DBF_TEXT4(0, trace, "freecard");
 
+	memset(card->dev, 0, sizeof (struct net_device));
+	card->dev->priv = card;
+	strncpy(card->dev->name, card->dev_name, IFNAMSIZ);
+
 	ccw_device_set_offline(card->ddev);
 	ccw_device_set_offline(card->wdev);
 	ccw_device_set_offline(card->rdev);
diff -urN linux-2.6.0-test1/drivers/s390/net/qeth.h linux-2.6.0-s390/drivers/s390/net/qeth.h
--- linux-2.6.0-test1/drivers/s390/net/qeth.h	Mon Jul 14 05:28:56 2003
+++ linux-2.6.0-s390/drivers/s390/net/qeth.h	Thu Jul 17 17:27:34 2003
@@ -14,7 +14,7 @@
 
 #define QETH_NAME " qeth"
 
-#define VERSION_QETH_H "$Revision: 1.47 $"
+#define VERSION_QETH_H "$Revision: 1.49 $"
 
 /******************** CONFIG STUFF ***********************/
 //#define QETH_DBF_LIKE_HELL
@@ -938,6 +938,8 @@
 	__u32 ipa6_enabled;
 	__u32 adp_supported;
 
+	__u32 csum_enable_mask;
+
 	atomic_t startlan_attempts;
 	atomic_t enable_routing_attempts4;
 	atomic_t rt4fld;
@@ -1021,7 +1023,7 @@
 		case QETH_MPC_LINK_TYPE_LANE_TR:
 			/* fallthrough */
 		case QETH_MPC_LINK_TYPE_HSTR:
-			return ARPHRD_IEEE802;
+			return ARPHRD_IEEE802_TR;
 		default:
 			return ARPHRD_ETHER;
 		}
diff -urN linux-2.6.0-test1/drivers/s390/net/qeth_mpc.h linux-2.6.0-s390/drivers/s390/net/qeth_mpc.h
--- linux-2.6.0-test1/drivers/s390/net/qeth_mpc.h	Mon Jul 14 05:34:02 2003
+++ linux-2.6.0-s390/drivers/s390/net/qeth_mpc.h	Thu Jul 17 17:27:34 2003
@@ -10,7 +10,7 @@
 #ifndef __QETH_MPC_H__
 #define __QETH_MPC_H__
 
-#define VERSION_QETH_MPC_H "$Revision: 1.15 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.16 $"
 
 #define QETH_IPA_TIMEOUT (card->ipa_timeout)
 #define QETH_MPC_TIMEOUT 2000
@@ -188,7 +188,7 @@
 #define IPA_CMD_ASS_ARP_QUERY_INFO 0x0104
 #define IPA_CMD_ASS_ARP_QUERY_STATS 0x0204
 
-#define IPA_CHECKSUM_ENABLE_MASK 0x001a
+#define IPA_CHECKSUM_DEFAULT_ENABLE_MASK 0x001a
 
 #define IPA_CMD_ASS_FILTER_SET_TYPES 0x0003
 
