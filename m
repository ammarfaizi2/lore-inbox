Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTJUPMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbTJUPLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:11:10 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:7651 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263152AbTJUPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:09:22 -0400
Date: Tue, 21 Oct 2003 17:09:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/8): network driver fixes.
Message-ID: <20031021150925.GD1690@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - ctc/iucv: Add module author/description/license to fsm.c
 - qeth: use correct length in clearing of MAC address.
 - qeth: queue multicast and broadcast packets into the last
   queue on HiperSocket.

diffstat:
 drivers/s390/net/fsm.c  |    6 +++++-
 drivers/s390/net/qeth.c |   42 ++++++++++++++++++++++++++++++++----------
 drivers/s390/net/qeth.h |    8 +++++++-
 3 files changed, 44 insertions(+), 12 deletions(-)

diff -urN linux-2.6/drivers/s390/net/fsm.c linux-2.6-s390/drivers/s390/net/fsm.c
--- linux-2.6/drivers/s390/net/fsm.c	Fri Oct 17 23:43:11 2003
+++ linux-2.6-s390/drivers/s390/net/fsm.c	Tue Oct 21 16:37:37 2003
@@ -1,5 +1,5 @@
 /**
- * $Id: fsm.c,v 1.4 2003/03/28 08:54:40 mschwide Exp $
+ * $Id: fsm.c,v 1.6 2003/10/15 11:37:29 mschwide Exp $
  *
  * A generic FSM based on fsm used in isdn4linux
  *
@@ -10,6 +10,10 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 
+MODULE_AUTHOR("(C) 2000 IBM Corp. by Fritz Elfert (felfert@millenux.com)");
+MODULE_DESCRIPTION("Finite state machine helper functions");
+MODULE_LICENSE("GPL");
+
 fsm_instance *
 init_fsm(char *name, const char **state_names, const char **event_names, int nr_states,
 		int nr_events, const fsm_node *tmpl, int tmpl_len, int order)
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Tue Oct 21 16:37:36 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Tue Oct 21 16:37:38 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.161 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.163 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -165,7 +165,7 @@
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.161 $"
+#define VERSION_QETH_C "$Revision: 1.163 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -612,6 +612,10 @@
 qeth_is_multicast_skb_at_all(struct sk_buff *skb, int version)
 {
 	int i;
+	struct qeth_card *card;
+
+	i = RTN_UNSPEC;
+	card = (struct qeth_card *)skb->dev->priv;
 	if (skb->dst && skb->dst->neighbour) {
 		i = skb->dst->neighbour->type;
 		return ((i == RTN_BROADCAST) ||
@@ -622,20 +626,38 @@
 		return ((skb->nh.raw[16] & 0xf0) == 0xe0) ? RTN_MULTICAST : 0;
 	} else if (version == 6) {
 		return (skb->nh.raw[24] == 0xff) ? RTN_MULTICAST : 0;
-	} else {
-		PRINT_STUPID("QETH_IP_VERSION is %x\n", version);
-		PRINT_STUPID("skb->protocol=x%x=%i\n",
-			     skb->protocol, skb->protocol);
-		HEXDUMP16(STUPID, "skb:", skb->data);
 	}
-	return 0;
+	if (!memcmp(skb->nh.raw, skb->dev->broadcast, 6)) {
+		i = RTN_BROADCAST;
+	} else {
+		__u16 hdr_mac;
+
+	        hdr_mac = *((__u16*)skb->nh.raw);
+	        /* tr multicast? */
+	        switch (card->link_type) {
+	        case QETH_MPC_LINK_TYPE_HSTR:
+	        case QETH_MPC_LINK_TYPE_LANE_TR:
+	        	if ((hdr_mac == QETH_TR_MAC_NC) ||
+			    (hdr_mac == QETH_TR_MAC_C))
+				i = RTN_MULTICAST;
+			break;
+	        /* eth or so multicast? */
+                default:
+                      	if ((hdr_mac == QETH_ETH_MAC_V4) ||
+			    (hdr_mac == QETH_ETH_MAC_V6))
+			        i = RTN_MULTICAST;
+	        }
+        }
+	return ((i == RTN_BROADCAST)||
+	        (i == RTN_MULTICAST)||
+	        (i == RTN_ANYCAST)) ? i : 0;
 }
 
 static int
 qeth_get_prioqueue(struct qeth_card *card, struct sk_buff *skb,
 		   int multicast, int version)
 {
-	if (!version)
+	if (!version && (card->type == QETH_CARD_TYPE_OSAE))
 		return QETH_DEFAULT_QUEUE;
 	switch (card->no_queues) {
 	case 1:
@@ -1327,7 +1349,7 @@
 		       QETH_FAKE_LL_ADDR_LEN);
 	} else {
 		/* clear source MAC for security reasons */
-		memset(skb->mac.raw + QETH_FAKE_LL_DEST_MAC_POS,
+		memset(skb->mac.raw + QETH_FAKE_LL_SRC_MAC_POS,
 		       0, QETH_FAKE_LL_ADDR_LEN);
 	}
 	memcpy(skb->mac.raw + QETH_FAKE_LL_PROT_POS,
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Fri Oct 17 23:42:53 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Tue Oct 21 16:37:38 2003
@@ -14,7 +14,7 @@
 
 #define QETH_NAME " qeth"
 
-#define VERSION_QETH_H "$Revision: 1.58 $"
+#define VERSION_QETH_H "$Revision: 1.59 $"
 
 /******************** CONFIG STUFF ***********************/
 //#define QETH_DBF_LIKE_HELL
@@ -288,6 +288,12 @@
 #define QETH_HEADER_PASSTHRU	0x10
 #define QETH_HEADER_IPV6	0x80
 
+#define QETH_ETH_MAC_V4      0x0100 /* like v4 */
+#define QETH_ETH_MAC_V6      0x3333 /* like v6 */
+/* tr mc mac is longer, but that will be enough to detect mc frames */
+#define QETH_TR_MAC_NC       0xc000 /* non-canonical */
+#define QETH_TR_MAC_C        0x0300 /* canonical */
+
 #define QETH_CAST_FLAGS		0x07
 #define QETH_CAST_UNICAST	6
 #define QETH_CAST_MULTICAST	4
