Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbUK3PSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUK3PSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUK3PSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:18:01 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:57058 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262120AbUK3PKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:10:14 -0500
Date: Tue, 30 Nov 2004 16:10:13 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/6] s390: qeth network driver.
Message-ID: <20041130151013.GG4758@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/6] s390: qeth network driver.

From: Thomas Spatzier <tspat@de.ibm.com>

network driver changes:
 - qeth: Handle both VLAN_FRAME and INCLUDES_VLAN_TAG in qdio header.
 - qeth: Always save IP addresses registered on a card when going offline.
 - qeth: Check size of printk buffer to 4K for ipa_takeover, vipa & rxip.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth.h      |   16 +++++++---------
 drivers/s390/net/qeth_main.c |   21 +++++++++++----------
 drivers/s390/net/qeth_sys.c  |   31 +++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 21 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2004-11-30 14:03:18.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2004-11-30 14:03:21.000000000 +0100
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.123 $"
+#define VERSION_QETH_H 		"$Revision: 1.124 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -330,10 +330,6 @@
 #define QETH_WATERMARK_PACK_FUZZ 1
 
 #define QETH_IP_HEADER_SIZE 40
-/* VLAN defines */
-#define QETH_EXT_HDR_VLAN_FRAME        0x01
-#define QETH_EXT_HDR_TOKEN_ID          0x02
-#define QETH_EXT_HDR_INCLUDE_VLAN_TAG  0x04
 
 struct qeth_hdr_layer3 {
 	__u8  id;
@@ -392,10 +388,12 @@
 	QETH_HEADER_TYPE_LAYER2 = 0x02,
 };
 /* flags for qeth_hdr.ext_flags */
-#define QETH_HDR_EXT_VLAN_FRAME      0x01
-#define QETH_HDR_EXT_CSUM_HDR_REQ    0x10
-#define QETH_HDR_EXT_CSUM_TRANSP_REQ 0x20
-#define QETH_HDR_EXT_SRC_MAC_ADDR    0x08
+#define QETH_HDR_EXT_VLAN_FRAME       0x01
+#define QETH_HDR_EXT_TOKEN_ID         0x02
+#define QETH_HDR_EXT_INCLUDE_VLAN_TAG 0x04
+#define QETH_HDR_EXT_SRC_MAC_ADDR     0x08
+#define QETH_HDR_EXT_CSUM_HDR_REQ     0x10
+#define QETH_HDR_EXT_CSUM_TRANSP_REQ  0x20
 
 static inline int
 qeth_is_last_sbale(struct qdio_buffer_element *sbale)
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-11-30 14:03:18.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-11-30 14:03:21.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.168 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.170 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.168 $	 $Date: 2004/11/08 15:55:12 $
+ *    $Revision: 1.170 $	 $Date: 2004/11/17 09:54:06 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.168 $"
+#define VERSION_QETH_C "$Revision: 1.170 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2236,9 +2236,11 @@
 #ifdef CONFIG_QETH_VLAN
 	u16 *vlan_tag;
 
-	if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME) {
+	if (hdr->hdr.l3.ext_flags &
+	    (QETH_HDR_EXT_VLAN_FRAME | QETH_HDR_EXT_INCLUDE_VLAN_TAG)) {
 		vlan_tag = (u16 *) skb_push(skb, VLAN_HLEN);
-		*vlan_tag = hdr->hdr.l3.vlan_id;
+		*vlan_tag = (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME)?
+			hdr->hdr.l3.vlan_id : *((u16 *)&hdr->hdr.l3.dest_addr[12]);
 		*(vlan_tag + 1) = skb->protocol;
 		skb->protocol = __constant_htons(ETH_P_8021Q);
 	}
@@ -3789,8 +3791,8 @@
 	 */
 	if (card->vlangrp && vlan_tx_tag_present(skb)) {
 		hdr->hdr.l3.ext_flags = (ipv == 4) ?
-			QETH_EXT_HDR_VLAN_FRAME :
-			QETH_EXT_HDR_INCLUDE_VLAN_TAG;
+			QETH_HDR_EXT_VLAN_FRAME :
+			QETH_HDR_EXT_INCLUDE_VLAN_TAG;
 		hdr->hdr.l3.vlan_id = vlan_tx_tag_get(skb);
 	}
 #endif /* CONFIG_QETH_VLAN */
@@ -6702,7 +6704,6 @@
 static int
 qeth_stop_card(struct qeth_card *card)
 {
-	int recover_flag = 0;
 	int rc = 0;
 
 	QETH_DBF_TEXT(setup ,2,"stopcard");
@@ -6714,7 +6715,6 @@
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
 	    (card->state == CARD_STATE_UP)) {
-		recover_flag = 1;
 		rtnl_lock();
 		dev_close(card->dev);
 		rtnl_unlock();
@@ -6733,7 +6733,7 @@
 		if (card->options.layer2)
 			qeth_layer2_process_vlans(card, 1);
 #endif
-		qeth_clear_ip_list(card, !card->use_hard_stop, recover_flag);
+		qeth_clear_ip_list(card, !card->use_hard_stop, 1);
 		qeth_clear_ipacmd_list(card);
 		card->state = CARD_STATE_HARDSETUP;
 	}
@@ -6901,6 +6901,7 @@
 	rtnl_lock();
 	dev_open(card->dev);
 	rtnl_unlock();
+	/* this also sets saved unicast addresses */
 	qeth_set_multicast_list(card->dev);
 }
 
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2004-11-30 14:03:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2004-11-30 14:03:21.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.35 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.38 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.35 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.38 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -886,6 +886,15 @@
 	list_for_each_entry(ipatoe, &card->ipato.entries, entry){
 		if (ipatoe->proto != proto)
 			continue;
+		/* String must not be longer than PAGE_SIZE. So we check for
+		 * length >= 3900 here. Then we can savely display the next
+		 * IPv6 address and our info message below */
+		if (i >= 3900) {
+			i += sprintf(buf + i,
+				     "... Too many entries to be displayed. "
+				     "Skipping remaining entries.\n");
+			break;
+		}
 		qeth_ipaddr_to_string(proto, ipatoe->addr, addr_str);
 		i += sprintf(buf + i, "%s/%i\n", addr_str, ipatoe->mask_bits);
 	}
@@ -1135,6 +1144,15 @@
 			continue;
 		if (ipaddr->type != QETH_IP_TYPE_VIPA)
 			continue;
+		/* String must not be longer than PAGE_SIZE. So we check for
+		 * length >= 3900 here. Then we can savely display the next
+		 * IPv6 address and our info message below */
+		if (i >= 3900) {
+			i += sprintf(buf + i,
+				     "... Too many entries to be displayed. "
+				     "Skipping remaining entries.\n");
+			break;
+		}
 		qeth_ipaddr_to_string(proto, (const u8 *)&ipaddr->u, addr_str);
 		i += sprintf(buf + i, "%s\n", addr_str);
 	}
@@ -1308,6 +1326,15 @@
 			continue;
 		if (ipaddr->type != QETH_IP_TYPE_RXIP)
 			continue;
+		/* String must not be longer than PAGE_SIZE. So we check for
+		 * length >= 3900 here. Then we can savely display the next
+		 * IPv6 address and our info message below */
+		if (i >= 3900) {
+			i += sprintf(buf + i,
+				     "... Too many entries to be displayed. "
+				     "Skipping remaining entries.\n");
+			break;
+		}
 		qeth_ipaddr_to_string(proto, (const u8 *)&ipaddr->u, addr_str);
 		i += sprintf(buf + i, "%s\n", addr_str);
 	}
