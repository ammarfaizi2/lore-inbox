Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKJMtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKJMtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVKJMtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:49:13 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63908 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750822AbVKJMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:49:09 -0500
Date: Thu, 10 Nov 2005 13:51:25 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 6/7] s390: introduce guestLan sniffer support in qeth
Message-ID: <20051110125125.GF7936@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/7] s390: introduce guestLan sniffer support in qeth

From: Peter Tiedemann  <ptiedem@de.ibm.com>
	- introduce guestLan sniffer support in qeth	
	  feature allows a linux in a virtual machine 
	  guest to become a network LAN sniffer, 
	  monitoring and recording the networking traffic 
	  within an entire guestLan.

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth.h      |    2 +
 qeth_main.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qeth_mpc.h  |   11 ++++---
 3 files changed, 102 insertions(+), 4 deletions(-)

diff -Naupr orig/drivers/s390/net/qeth.h patched-linux/drivers/s390/net/qeth.h
--- orig/drivers/s390/net/qeth.h	2005-11-09 20:49:36.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth.h	2005-11-09 20:52:27.000000000 +0100
@@ -750,6 +750,7 @@ struct qeth_card_info {
 	int unique_id;
 	struct qeth_card_blkt blkt;
 	__u32 csum_mask;
+	enum qeth_ipa_promisc_modes promisc_mode;
 };
 
 struct qeth_card_options {
@@ -776,6 +777,7 @@ struct qeth_card_options {
 enum qeth_threads {
 	QETH_SET_IP_THREAD  = 1,
 	QETH_RECOVER_THREAD = 2,
+	QETH_SET_PROMISC_MODE_THREAD = 4,
 };
 
 struct qeth_osn_info {
diff -Naupr orig/drivers/s390/net/qeth_main.c patched-linux/drivers/s390/net/qeth_main.c
--- orig/drivers/s390/net/qeth_main.c	2005-11-09 20:49:36.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth_main.c	2005-11-09 20:50:03.000000000 +0100
@@ -160,6 +160,9 @@ static void
 qeth_set_multicast_list(struct net_device *);
 
 static void
+qeth_setadp_promisc_mode(struct qeth_card *);
+
+static void
 qeth_notify_processes(void)
 {
 	/*notify all  registered processes */
@@ -965,6 +968,24 @@ qeth_register_ip_addresses(void *ptr)
 	return 0;
 }
 
+/*
+ * Drive the SET_PROMISC_MODE thread
+ */
+static int
+qeth_set_promisc_mode(void *ptr)
+{
+	struct qeth_card *card = (struct qeth_card *) ptr;
+
+	daemonize("qeth_setprm");
+	QETH_DBF_TEXT(trace,4,"setprm1");
+	if (!qeth_do_run_thread(card, QETH_SET_PROMISC_MODE_THREAD))
+		return 0;
+	QETH_DBF_TEXT(trace,4,"setprm2");
+	qeth_setadp_promisc_mode(card);
+	qeth_clear_thread_running_bit(card, QETH_SET_PROMISC_MODE_THREAD);
+	return 0;
+}
+
 static int
 qeth_recover(void *ptr)
 {
@@ -1031,6 +1052,8 @@ qeth_start_kernel_thread(struct qeth_car
 
 	if (qeth_do_start_thread(card, QETH_SET_IP_THREAD))
 		kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD);
+	if (qeth_do_start_thread(card, QETH_SET_PROMISC_MODE_THREAD))
+		kernel_thread(qeth_set_promisc_mode, (void *)card, SIGCHLD);
 	if (qeth_do_start_thread(card, QETH_RECOVER_THREAD))
 		kernel_thread(qeth_recover, (void *) card, SIGCHLD);
 }
@@ -5003,6 +5026,10 @@ qeth_default_setassparms_cb(struct qeth_
 			    unsigned long);
 
 static int
+qeth_default_setadapterparms_cb(struct qeth_card *card,
+                                struct qeth_reply *reply,
+                                unsigned long data);
+static int
 qeth_send_setassparms(struct qeth_card *, struct qeth_cmd_buffer *,
 		      __u16, long,
 		      int (*reply_cb)
@@ -5476,6 +5503,59 @@ qeth_vlan_rx_kill_vid(struct net_device 
 	qeth_set_multicast_list(card->dev);
 }
 #endif
+/**
+ * Examine hardware response to SET_PROMISC_MODE
+ */
+static int
+qeth_setadp_promisc_mode_cb(struct qeth_card *card, 
+			    struct qeth_reply *reply,
+			    unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipacmd_setadpparms *setparms;
+
+	QETH_DBF_TEXT(trace,4,"prmadpcb");
+
+	cmd = (struct qeth_ipa_cmd *) data;
+	setparms = &(cmd->data.setadapterparms);
+	
+        qeth_default_setadapterparms_cb(card, reply, (unsigned long)cmd);
+	if (cmd->hdr.return_code) { 
+		QETH_DBF_TEXT_(trace,4,"prmrc%2.2x",cmd->hdr.return_code);	
+		setparms->data.mode = SET_PROMISC_MODE_OFF;
+	}
+	card->info.promisc_mode = setparms->data.mode;
+	return 0;
+}
+/*
+ * Set promiscuous mode (on or off) (SET_PROMISC_MODE command)
+ */
+static void
+qeth_setadp_promisc_mode(struct qeth_card *card)
+{
+	enum qeth_ipa_promisc_modes mode;
+	struct net_device *dev = card->dev;
+	struct qeth_cmd_buffer *iob;
+	struct qeth_ipa_cmd *cmd;
+
+	QETH_DBF_TEXT(trace, 4, "setprom");
+
+	if (((dev->flags & IFF_PROMISC) &&
+	     (card->info.promisc_mode == SET_PROMISC_MODE_ON)) ||
+	    (!(dev->flags & IFF_PROMISC) &&
+	     (card->info.promisc_mode == SET_PROMISC_MODE_OFF)))
+		return;
+	mode = SET_PROMISC_MODE_OFF;
+	if (dev->flags & IFF_PROMISC)
+		mode = SET_PROMISC_MODE_ON;
+	QETH_DBF_TEXT_(trace, 4, "mode:%x", mode);
+
+	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_PROMISC_MODE,
+			sizeof(struct qeth_ipacmd_setadpparms));
+	cmd = (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
+	cmd->data.setadapterparms.data.mode = mode;
+	qeth_send_ipa_cmd(card, iob, qeth_setadp_promisc_mode_cb, NULL);
+}
 
 /**
  * set multicast address on card
@@ -5501,6 +5581,11 @@ qeth_set_multicast_list(struct net_devic
 out:
  	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
 		schedule_work(&card->kernel_thread_starter);
+	if (!qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
+		return;
+	if (qeth_set_thread_start_bit(card, QETH_SET_PROMISC_MODE_THREAD)==0)
+		schedule_work(&card->kernel_thread_starter);
+
 }
 
 static int
@@ -6510,6 +6595,8 @@ qeth_default_setadapterparms_cb(struct q
 	return 0;
 }
 
+
+
 static int
 qeth_query_setadapterparms_cb(struct qeth_card *card, struct qeth_reply *reply,
 			      unsigned long data)
@@ -6676,6 +6763,12 @@ qeth_layer2_initialize(struct qeth_card 
         QETH_DBF_TEXT(setup, 2, "doL2init");
         QETH_DBF_TEXT_(setup, 2, "doL2%s", CARD_BUS_ID(card));
 
+	rc = qeth_query_setadapterparms(card);
+	if (rc) {
+		PRINT_WARN("could not query adapter parameters on device %s: "
+			   "x%x\n", CARD_BUS_ID(card), rc);
+	}
+
 	rc = qeth_setadpparms_change_macaddr(card);
 	if (rc) {
 		PRINT_WARN("couldn't get MAC address on "
diff -Naupr orig/drivers/s390/net/qeth_mpc.h patched-linux/drivers/s390/net/qeth_mpc.h
--- orig/drivers/s390/net/qeth_mpc.h	2005-11-09 20:06:57.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth_mpc.h	2005-11-09 20:50:03.000000000 +0100
@@ -14,7 +14,7 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.43 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.44 $"
 
 extern const char *VERSION_QETH_MPC_C;
 
@@ -217,7 +217,7 @@ enum qeth_ipa_setadp_cmd {
 	IPA_SETADP_SEND_OSA_MESSAGE 		= 0x0100,
 	IPA_SETADP_SET_SNMP_CONTROL 		= 0x0200,
 	IPA_SETADP_READ_SNMP_PARMS 		= 0x0400,
-	IPA_SETADP_WRITE_SNMP_PARMS 		= 0x0800,
+	IPA_SETADP_SET_PROMISC_MODE		= 0x0800,
 	IPA_SETADP_QUERY_CARD_INFO 		= 0x1000,
 };
 enum qeth_ipa_mac_ops {
@@ -232,9 +232,12 @@ enum qeth_ipa_addr_ops {
 	CHANGE_ADDR_ADD_ADDR 		= 1,
 	CHANGE_ADDR_DEL_ADDR 		= 2,
 	CHANGE_ADDR_FLUSH_ADDR_TABLE 	= 4,
-
-
 };
+enum qeth_ipa_promisc_modes {
+	SET_PROMISC_MODE_OFF		= 0,
+	SET_PROMISC_MODE_ON		= 1,
+};
+
 /* (SET)DELIP(M) IPA stuff ***************************************************/
 struct qeth_ipacmd_setdelip4 {
 	__u8   ip_addr[4];
