Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVIFNCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVIFNCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVIFNCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:02:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:6834 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932458AbVIFNCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:02:03 -0400
Date: Tue, 6 Sep 2005 15:05:03 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/4] s390: TSO related fixes in qeth driver
Message-ID: <20050906130503.GF9265@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 3/4] s390: TSO related fixes in qeth driver 

From: Frank Pavlic <pavlic@de.ibm.com>
	TSO related fixes :
	  - changing value of large_send attribute while network traffic
	    is running caused program check and thus device recovery.
	  - Due to hardware restriction discard packet when it exceeds 60K
	    otherwise qeth will cause program checks and thus traffic stall 
	    when trying to send such huge packets.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 qeth.h      |    4 ++--
 qeth_main.c |   33 +++++++++++++++++++++------------
 qeth_sys.c  |   10 +++-------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff -Naupr linux-2.6-orig/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6-orig/drivers/s390/net/qeth.h	2005-09-05 11:46:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-09-05 12:16:08.000000000 +0200
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.139 $"
+#define VERSION_QETH_H 		"$Revision: 1.141 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -1172,7 +1172,7 @@ extern int
 qeth_realloc_buffer_pool(struct qeth_card *, int);
 
 extern int
-qeth_set_large_send(struct qeth_card *);
+qeth_set_large_send(struct qeth_card *, enum qeth_large_send_types);
 
 extern void
 qeth_fill_header(struct qeth_card *, struct qeth_hdr *,
diff -Naupr linux-2.6-orig/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6-orig/drivers/s390/net/qeth_main.c	2005-09-05 11:46:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-09-05 12:17:38.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.214 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.219 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.214 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.219 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -80,7 +80,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.214 $"
+#define VERSION_QETH_C "$Revision: 1.219 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -3795,12 +3795,16 @@ static inline int
 qeth_prepare_skb(struct qeth_card *card, struct sk_buff **skb,
 		 struct qeth_hdr **hdr, int ipv)
 {
+	int rc;
 #ifdef CONFIG_QETH_VLAN
 	u16 *tag;
 #endif
 
 	QETH_DBF_TEXT(trace, 6, "prepskb");
 
+        rc = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
+        if (rc)
+                return rc;
 #ifdef CONFIG_QETH_VLAN
 	if (card->vlangrp && vlan_tx_tag_present(*skb) &&
 	    ((ipv == 6) || card->options.layer2) ) {
@@ -4251,7 +4255,8 @@ out:
 }
 
 static inline int
-qeth_get_elements_no(struct qeth_card *card, void *hdr, struct sk_buff *skb)
+qeth_get_elements_no(struct qeth_card *card, void *hdr, 
+		     struct sk_buff *skb, int elems)
 {
 	int elements_needed = 0;
 
@@ -4261,9 +4266,10 @@ qeth_get_elements_no(struct qeth_card *c
         if (elements_needed == 0 )
                 elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
                                         + skb->len) >> PAGE_SHIFT);
-        if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
+	if ((elements_needed + elems) > QETH_MAX_BUFFER_ELEMENTS(card)){
                 PRINT_ERR("qeth_do_send_packet: invalid size of "
-                          "IP packet. Discarded.");
+                          "IP packet (Number=%d / Length=%d). Discarded.\n",
+                          (elements_needed+elems), skb->len);
                 return 0;
         }
         return elements_needed;
@@ -4337,9 +4343,11 @@ qeth_send_packet(struct qeth_card *card,
 			return -EINVAL;
 		}
 	} else {
-		elements_needed += qeth_get_elements_no(card,(void*) hdr, skb);
-		if (!elements_needed)
+		int elems = qeth_get_elements_no(card,(void*) hdr, skb,
+						 elements_needed);
+		if (!elems)
 			return -EINVAL;
+		elements_needed += elems;
 	}
 
 	if (card->info.type != QETH_CARD_TYPE_IQD)
@@ -7038,14 +7046,16 @@ qeth_setrouting_v6(struct qeth_card *car
 }
 
 int
-qeth_set_large_send(struct qeth_card *card)
+qeth_set_large_send(struct qeth_card *card, enum qeth_large_send_types type)
 {
 	int rc = 0;
 
-	if (card->dev == NULL)
+	if (card->dev == NULL) {
+		card->options.large_send = type;
 		return 0;
-
+	}
 	netif_stop_queue(card->dev);
+	card->options.large_send = type;
 	switch (card->options.large_send) {
 	case QETH_LARGE_SEND_EDDP:
 		card->dev->features |= NETIF_F_TSO | NETIF_F_SG;
@@ -7066,7 +7076,6 @@ qeth_set_large_send(struct qeth_card *ca
 		card->dev->features &= ~(NETIF_F_TSO | NETIF_F_SG);
 		break;
 	}
-
 	netif_wake_queue(card->dev);
 	return rc;
 }
diff -Naupr linux-2.6-orig/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6-orig/drivers/s390/net/qeth_sys.c	2005-09-05 11:46:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2005-09-05 12:14:30.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.51 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.53 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.51 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.53 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -771,9 +771,7 @@ qeth_dev_large_send_store(struct device 
 
 	if (!card)
 		return -EINVAL;
-
 	tmp = strsep((char **) &buf, "\n");
-
 	if (!strcmp(tmp, "no")){
 		type = QETH_LARGE_SEND_NO;
 	} else if (!strcmp(tmp, "EDDP")) {
@@ -786,10 +784,8 @@ qeth_dev_large_send_store(struct device 
 	}
 	if (card->options.large_send == type)
 		return count;
-	card->options.large_send = type;
-	if ((rc = qeth_set_large_send(card)))
+	if ((rc = qeth_set_large_send(card, type)))	
 		return rc;
-
 	return count;
 }
 
