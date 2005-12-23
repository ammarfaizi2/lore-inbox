Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVLWG2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVLWG2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 01:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVLWG2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 01:28:45 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:19140 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030419AbVLWG2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 01:28:44 -0500
Date: Fri, 23 Dec 2005 07:31:26 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND patch 1/3] s390: some minor qeth driver fixes
Message-ID: <20051223073126.5640fd9d@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,
I am not sure if my first try did make his way since I had some fights with my exim4 configuration.
Anyway I resend the patches .

Thanks 

Frank


[patch 1/3] s390: some minor qeth driver fixes

From: Frank Pavlic <fpavlic@de.ibm.com>
	- let's have just one function for both ,input and output queue
	  to check qdio errors
	- add /proc/s390dbf/qeth_qerr entries for outbound processing
	- check removed for layer2 device in qeth_add_multicast_ipv6
	- NULL pointer dereference with bonding and VLAN device fixed
	- minimum length check for portname fixed
	
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
qeth_main.c |   42 +++++++++++++++++++++---------------------
qeth_sys.c  |    6 +++---
2 files changed, 24 insertions(+), 24 deletions(-)

diff -Naupr linux-orig/drivers/s390/net/qeth_main.c linux-patched/drivers/s390/net/qeth_main.c
--- linux-orig/drivers/s390/net/qeth_main.c	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_main.c	2005-12-12 17:46:31.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.242 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.246 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.242 $"
+#define VERSION_QETH_C "$Revision: 1.246 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2203,24 +2203,21 @@ qeth_ulp_setup(struct qeth_card *card)
 }
 
 static inline int
-qeth_check_for_inbound_error(struct qeth_qdio_buffer *buf,
-			     unsigned int qdio_error,
-			     unsigned int siga_error)
+qeth_check_qdio_errors(struct qdio_buffer *buf, unsigned int qdio_error,
+		       unsigned int siga_error, const char *dbftext)
 {
-	int rc = 0;
-
 	if (qdio_error || siga_error) {
-		QETH_DBF_TEXT(trace, 2, "qdinerr");
-		QETH_DBF_TEXT(qerr, 2, "qdinerr");
+		QETH_DBF_TEXT(trace, 2, dbftext);
+		QETH_DBF_TEXT(qerr, 2, dbftext);
 		QETH_DBF_TEXT_(qerr, 2, " F15=%02X",
-			       buf->buffer->element[15].flags & 0xff);
+			       buf->element[15].flags & 0xff);
 		QETH_DBF_TEXT_(qerr, 2, " F14=%02X",
-			       buf->buffer->element[14].flags & 0xff);
+			       buf->element[14].flags & 0xff);
 		QETH_DBF_TEXT_(qerr, 2, " qerr=%X", qdio_error);
 		QETH_DBF_TEXT_(qerr, 2, " serr=%X", siga_error);
-		rc = 1;
+		return 1;
 	}
-	return rc;
+	return 0;
 }
 
 static inline struct sk_buff *
@@ -2769,8 +2766,9 @@ qeth_qdio_input_handler(struct ccw_devic
 	for (i = first_element; i < (first_element + count); ++i) {
 		index = i % QDIO_MAX_BUFFERS_PER_Q;
 		buffer = &card->qdio.in_q->bufs[index];
-		if (!((status == QDIO_STATUS_LOOK_FOR_ERROR) &&
-		      qeth_check_for_inbound_error(buffer, qdio_err, siga_err)))
+		if (!((status & QDIO_STATUS_LOOK_FOR_ERROR) &&
+		      qeth_check_qdio_errors(buffer->buffer, 
+					     qdio_err, siga_err,"qinerr")))
 			qeth_process_inbound_buffer(card, buffer, index);
 		/* clear buffer and give back to hardware */
 		qeth_put_buffer_pool_entry(card, buffer->pool_entry);
@@ -2785,12 +2783,13 @@ qeth_qdio_input_handler(struct ccw_devic
 static inline int
 qeth_handle_send_error(struct qeth_card *card,
 		       struct qeth_qdio_out_buffer *buffer,
-		       int qdio_err, int siga_err)
+		       unsigned int qdio_err, unsigned int siga_err)
 {
 	int sbalf15 = buffer->buffer->element[15].flags & 0xff;
 	int cc = siga_err & 3;
 
 	QETH_DBF_TEXT(trace, 6, "hdsnderr");
+	qeth_check_qdio_errors(buffer->buffer, qdio_err, siga_err, "qouterr");
 	switch (cc) {
 	case 0:
 		if (qdio_err){
@@ -3047,7 +3046,8 @@ qeth_qdio_output_handler(struct ccw_devi
 	for(i = first_element; i < (first_element + count); ++i){
 		buffer = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
 		/*we only handle the KICK_IT error by doing a recovery */
-		if (qeth_handle_send_error(card, buffer, qdio_error, siga_error)
+		if (qeth_handle_send_error(card, buffer,
+					   qdio_error, siga_error)
 				== QETH_SEND_ERROR_KICK_IT){
 			netif_stop_queue(card->dev);
 			qeth_schedule_recovery(card);
@@ -3289,7 +3289,6 @@ qeth_init_qdio_info(struct qeth_card *ca
 	card->qdio.in_buf_pool.buf_count = card->qdio.init_pool.buf_count;
 	INIT_LIST_HEAD(&card->qdio.in_buf_pool.entry_list);
 	INIT_LIST_HEAD(&card->qdio.init_pool.entry_list);
-	/* outbound */
 }
 
 static int
@@ -3731,6 +3730,9 @@ qeth_verify_vlan_dev(struct net_device *
 			break;
 		}
 	}
+	if (rc && !(VLAN_DEV_INFO(dev)->real_dev->priv == (void *)card))
+		return 0;
+
 #endif
 	return rc;
 }
@@ -5870,10 +5872,8 @@ qeth_add_multicast_ipv6(struct qeth_card
 	struct inet6_dev *in6_dev;
 
 	QETH_DBF_TEXT(trace,4,"chkmcv6");
-	if ((card->options.layer2 == 0) &&
-	    (!qeth_is_supported(card, IPA_IPV6)) )
+	if (!qeth_is_supported(card, IPA_IPV6)) 
 		return ;
-
 	in6_dev = in6_dev_get(card->dev);
 	if (in6_dev == NULL)
 		return;
diff -Naupr linux-orig/drivers/s390/net/qeth_sys.c linux-patched/drivers/s390/net/qeth_sys.c
--- linux-orig/drivers/s390/net/qeth_sys.c	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_sys.c	2005-12-12 17:39:41.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.58 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.59 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.58 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.59 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -160,7 +160,7 @@ qeth_dev_portname_store(struct device *d
 		return -EPERM;
 
 	tmp = strsep((char **) &buf, "\n");
-	if ((strlen(tmp) > 8) || (strlen(tmp) < 2))
+	if ((strlen(tmp) > 8) || (strlen(tmp) == 0))
 		return -EINVAL;
 
 	card->info.portname[0] = strlen(tmp);
