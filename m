Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVIFNC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVIFNC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVIFNC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:02:26 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:51414 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964777AbVIFNCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:02:24 -0400
Date: Tue, 6 Sep 2005 15:05:24 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/4] s390: qeth driver fixes
Message-ID: <20050906130524.GG9265@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 4/4] s390: qeth driver fixes .

From: Frank Pavlic <pavlic@de.ibm.com>
	- Clear read channel first prior to using ccw_device_set_offline.
	- use QETH_DBF_TEXT instead of QETH_DBF_SPRINTF
	- invoke qeth_halt_channel and qeth_clear_channel for all channels,
	  even if halt/clear for one of the channel fails.
	- enable qeth_arp_query function for GuestLAN devices

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 qeth.h      |    2 -
 qeth_main.c |  106 +++++++++++++++++++++++++-----------------------------------
 qeth_sys.c  |   11 +++---
 3 files changed, 53 insertions(+), 66 deletions(-)

diff -Naupr linux-2.6-orig/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6-orig/drivers/s390/net/qeth.h	2005-09-05 13:53:40.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-09-05 14:00:46.000000000 +0200
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.141 $"
+#define VERSION_QETH_H 		"$Revision: 1.142 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
diff -Naupr linux-2.6-orig/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6-orig/drivers/s390/net/qeth_main.c	2005-09-05 13:53:40.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-09-05 14:05:43.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.219 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.224 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.219 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.224 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,14 +29,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/***
- * eye catcher; just for debugging purposes
- */
-void volatile
-qeth_eyecatcher(void)
-{
-	return;
-}
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -80,7 +72,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.219 $"
+#define VERSION_QETH_C "$Revision: 1.224 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2759,11 +2751,9 @@ qeth_flush_buffers(struct qeth_qdio_out_
 		queue->card->perf_stats.outbound_do_qdio_start_time;
 #endif
 	if (rc){
-		QETH_DBF_SPRINTF(trace, 0, "qeth_flush_buffers: do_QDIO "
-				 "returned error (%i) on device %s.",
-				 rc, CARD_DDEV_ID(queue->card));
 		QETH_DBF_TEXT(trace, 2, "flushbuf");
 		QETH_DBF_TEXT_(trace, 2, " err%d", rc);
+		QETH_DBF_TEXT_(trace, 2, "%s", CARD_DDEV_ID(queue->card));
 		queue->card->stats.tx_errors += count;
 		/* this must not happen under normal circumstances. if it
 		 * happens something is really wrong -> recover */
@@ -2909,11 +2899,8 @@ qeth_qdio_output_handler(struct ccw_devi
 	QETH_DBF_TEXT(trace, 6, "qdouhdl");
 	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
 		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION){
-			QETH_DBF_SPRINTF(trace, 2, "On device %s: "
-					 "received active check "
-				         "condition (0x%08x).",
-					 CARD_BUS_ID(card), status);
-			QETH_DBF_TEXT(trace, 2, "chkcond");
+			QETH_DBF_TEXT(trace, 2, "achkcond");
+			QETH_DBF_TEXT_(trace, 2, "%s", CARD_BUS_ID(card));
 			QETH_DBF_TEXT_(trace, 2, "%08x", status);
 			netif_stop_queue(card->dev);
 			qeth_schedule_recovery(card);
@@ -3356,26 +3343,32 @@ qeth_halt_channel(struct qeth_channel *c
 static int
 qeth_halt_channels(struct qeth_card *card)
 {
-	int rc = 0;
+	int rc1 = 0, rc2=0, rc3 = 0;
 
 	QETH_DBF_TEXT(trace,3,"haltchs");
-	if ((rc = qeth_halt_channel(&card->read)))
-		return rc;
-	if ((rc = qeth_halt_channel(&card->write)))
-		return rc;
-	return  qeth_halt_channel(&card->data);
+	rc1 = qeth_halt_channel(&card->read);
+	rc2 = qeth_halt_channel(&card->write);
+	rc3 = qeth_halt_channel(&card->data);
+	if (rc1)
+		return rc1;
+	if (rc2) 
+		return rc2;
+	return rc3;
 }
 static int
 qeth_clear_channels(struct qeth_card *card)
 {
-	int rc = 0;
+	int rc1 = 0, rc2=0, rc3 = 0;
 
 	QETH_DBF_TEXT(trace,3,"clearchs");
-	if ((rc = qeth_clear_channel(&card->read)))
-		return rc;
-	if ((rc = qeth_clear_channel(&card->write)))
-		return rc;
-	return  qeth_clear_channel(&card->data);
+	rc1 = qeth_clear_channel(&card->read);
+	rc2 = qeth_clear_channel(&card->write);
+	rc3 = qeth_clear_channel(&card->data);
+	if (rc1)
+		return rc1;
+	if (rc2) 
+		return rc2;
+	return rc3;
 }
 
 static int
@@ -3445,23 +3438,23 @@ qeth_mpc_initialize(struct qeth_card *ca
 	}
 	if ((rc = qeth_cm_enable(card))){
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_cm_setup(card))){
 		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_ulp_enable(card))){
 		QETH_DBF_TEXT_(setup, 2, "4err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_ulp_setup(card))){
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_alloc_qdio_buffers(card))){
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_qdio_establish(card))){
 		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
@@ -4281,7 +4274,7 @@ qeth_send_packet(struct qeth_card *card,
 	int ipv = 0;
 	int cast_type;
 	struct qeth_qdio_out_q *queue;
-	struct qeth_hdr *hdr;
+	struct qeth_hdr *hdr = NULL;
 	int elements_needed = 0;
 	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
 	struct qeth_eddp_context *ctx = NULL;
@@ -4512,7 +4505,11 @@ qeth_arp_set_no_entries(struct qeth_card
 
 	QETH_DBF_TEXT(trace,3,"arpstnoe");
 
-	/* TODO: really not supported by GuestLAN? */
+	/*
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_SET_NO_ENTRIES;
+	 * thus we say EOPNOTSUPP for this ARP function
+	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -4689,14 +4686,6 @@ qeth_arp_query(struct qeth_card *card, c
 
 	QETH_DBF_TEXT(trace,3,"arpquery");
 
-	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
-	 */
-	/*if (card->info.guestlan)
-		return -EOPNOTSUPP; */
 	if (!qeth_is_supported(card,/*IPA_QUERY_ARP_ADDR_INFO*/
 			       IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
@@ -4902,10 +4891,9 @@ qeth_arp_add_entry(struct qeth_card *car
 	QETH_DBF_TEXT(trace,3,"arpadent");
 
 	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_ADD_ENTRY;
+	 * thus we say EOPNOTSUPP for this ARP function
 	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
@@ -4945,10 +4933,9 @@ qeth_arp_remove_entry(struct qeth_card *
 	QETH_DBF_TEXT(trace,3,"arprment");
 
 	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_REMOVE_ENTRY;
+	 * thus we say EOPNOTSUPP for this ARP function
 	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
@@ -4986,11 +4973,10 @@ qeth_arp_flush_cache(struct qeth_card *c
 	QETH_DBF_TEXT(trace,3,"arpflush");
 
 	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
-	 */
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_FLUSH_CACHE;
+	 * thus we say EOPNOTSUPP for this ARP function
+	*/
 	if (card->info.guestlan || (card->info.type == QETH_CARD_TYPE_IQD))
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -8266,7 +8252,6 @@ qeth_init(void)
 {
 	int rc=0;
 
-	qeth_eyecatcher();
 	PRINT_INFO("loading %s (%s/%s/%s/%s/%s/%s/%s %s %s)\n",
 		   version, VERSION_QETH_C, VERSION_QETH_H,
 		   VERSION_QETH_MPC_H, VERSION_QETH_MPC_C,
@@ -8347,7 +8332,6 @@ again:
 	printk("qeth: removed\n");
 }
 
-EXPORT_SYMBOL(qeth_eyecatcher);
 module_init(qeth_init);
 module_exit(qeth_exit);
 MODULE_AUTHOR("Frank Pavlic <pavlic@de.ibm.com>");
diff -Naupr linux-2.6-orig/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6-orig/drivers/s390/net/qeth_sys.c	2005-09-05 13:53:40.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2005-09-05 14:00:46.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.53 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.54 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.53 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.54 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -722,10 +722,13 @@ qeth_dev_layer2_store(struct device *dev
 
 	if (!card)
 		return -EINVAL;
+	if (card->info.type == QETH_CARD_TYPE_IQD) {
+                PRINT_WARN("Layer2 on Hipersockets is not supported! \n");
+                return -EPERM;
+        }
 
 	if (((card->state != CARD_STATE_DOWN) &&
-	     (card->state != CARD_STATE_RECOVER)) ||
-	    (card->info.type != QETH_CARD_TYPE_OSAE))
+	     (card->state != CARD_STATE_RECOVER)))
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
