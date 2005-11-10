Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVKJMtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKJMtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKJMtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:49:06 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:56228 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750792AbVKJMtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:49:02 -0500
Date: Thu, 10 Nov 2005 13:51:17 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 5/7] s390: fix recovery failure of non-guestLAN devices
Message-ID: <20051110125117.GE7936@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/7] s390: fix recovery failure of non-guestLAN devices 

From: Frank Pavlic <fpavlic@de.ibm.com>
	- Recovery of non-guestLAN Layer 2 device failed due to
	  trying to register the real MAC address we got from
	  the READ_MAC adapter parameters command.
	  We have to keep the "old" MAC address when we process
	  the reply of a READ_MAC.
	
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth.h      |   12 ++++++------
 qeth_main.c |   27 ++++++++++++++++-----------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff -Naupr orig/drivers/s390/net/qeth.h patched-linux/drivers/s390/net/qeth.h
--- orig/drivers/s390/net/qeth.h	2005-11-09 20:16:39.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth.h	2005-11-09 20:43:33.000000000 +0100
@@ -25,7 +25,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.151 $"
+#define VERSION_QETH_H 		"$Revision: 1.152 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -719,8 +719,6 @@ struct qeth_reply {
 	atomic_t refcnt;
 };
 
-#define QETH_BROADCAST_WITH_ECHO    1
-#define QETH_BROADCAST_WITHOUT_ECHO 2
 
 struct qeth_card_blkt {
 	int time_total;
@@ -728,8 +726,10 @@ struct qeth_card_blkt {
 	int inter_packet_jumbo;
 };
 
-
-
+#define QETH_BROADCAST_WITH_ECHO    0x01
+#define QETH_BROADCAST_WITHOUT_ECHO 0x02
+#define QETH_LAYER2_MAC_READ	    0x01
+#define QETH_LAYER2_MAC_REGISTERED  0x02
 struct qeth_card_info {
 	unsigned short unit_addr2;
 	unsigned short cula;
@@ -737,7 +737,7 @@ struct qeth_card_info {
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
 	int guestlan;
-	int layer2_mac_registered;
+	int mac_bits;
 	int portname_required;
 	int portno;
 	char portname[9];
diff -Naupr orig/drivers/s390/net/qeth_main.c patched-linux/drivers/s390/net/qeth_main.c
--- orig/drivers/s390/net/qeth_main.c	2005-11-09 20:42:41.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth_main.c	2005-11-09 20:45:34.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.238 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.242 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.238 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.242 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.238 $"
+#define VERSION_QETH_C "$Revision: 1.242 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -3775,7 +3775,7 @@ qeth_open(struct net_device *dev)
 
 	if ( (card->info.type != QETH_CARD_TYPE_OSN) &&
 	     (card->options.layer2) &&
-	     (!card->info.layer2_mac_registered)) {
+	     (!(card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))) {
 		QETH_DBF_TEXT(trace,4,"nomacadr");
 		return -EPERM;
 	}
@@ -5894,10 +5894,10 @@ qeth_layer2_send_setmac_cb(struct qeth_c
 		PRINT_WARN("Error in registering MAC address on " \
 			   "device %s: x%x\n", CARD_BUS_ID(card),
 			   cmd->hdr.return_code);
-		card->info.layer2_mac_registered = 0;
+		card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 		cmd->hdr.return_code = -EIO;
 	} else {
-		card->info.layer2_mac_registered = 1;
+		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
 		memcpy(card->dev->dev_addr,cmd->data.setdelmac.mac,
 		       OSA_ADDR_LEN);
 		PRINT_INFO("MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
@@ -5935,7 +5935,7 @@ qeth_layer2_send_delmac_cb(struct qeth_c
 		cmd->hdr.return_code = -EIO;
 		return 0;
 	}
-	card->info.layer2_mac_registered = 0;
+	card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 
 	return 0;
 }
@@ -5943,7 +5943,7 @@ static int
 qeth_layer2_send_delmac(struct qeth_card *card, __u8 *mac)
 {
 	QETH_DBF_TEXT(trace, 2, "L2Delmac");
-	if (!card->info.layer2_mac_registered)
+	if (!(card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
 		return 0;
 	return qeth_layer2_send_setdelmac(card, mac, IPA_CMD_DELVMAC,
 					  qeth_layer2_send_delmac_cb);
@@ -5965,7 +5965,7 @@ qeth_layer2_set_mac_address(struct net_d
 	card = (struct qeth_card *) dev->priv;
 
 	if (!card->options.layer2) {
-		PRINT_WARN("Setting MAC address on %s is not supported"
+		PRINT_WARN("Setting MAC address on %s is not supported "
 			   "in Layer 3 mode.\n", dev->name);
 		QETH_DBF_TEXT(trace, 3, "setmcLY3");
 		return -EOPNOTSUPP;
@@ -6550,8 +6550,13 @@ qeth_setadpparms_change_macaddr_cb(struc
 	QETH_DBF_TEXT(trace,4,"chgmaccb");
 
 	cmd = (struct qeth_ipa_cmd *) data;
-	memcpy(card->dev->dev_addr,
-	       &cmd->data.setadapterparms.data.change_addr.addr,OSA_ADDR_LEN);
+	if (!card->options.layer2 || card->info.guestlan ||
+	    !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {	
+		memcpy(card->dev->dev_addr,
+		       &cmd->data.setadapterparms.data.change_addr.addr,
+		       OSA_ADDR_LEN);
+		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
+	}
 	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
