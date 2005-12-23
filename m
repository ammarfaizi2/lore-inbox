Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbVLWG2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbVLWG2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 01:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVLWG2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 01:28:50 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:58352 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030445AbVLWG2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 01:28:49 -0500
Date: Fri, 23 Dec 2005 07:31:32 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND patch 2/3] s390: minor qeth network driver fixes
Message-ID: <20051223073132.5c3f6b36@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/3] s390: minor qeth network driver fixes

From: Frank Pavlic <fpavlic@de.ibm.com>
	- use netif_carrier_on/off calls to tell network stack 
	  link carrier state
	- fix possible kfree on NULL 
	- PDU_LEN2 is at offset 0x29 otherwise OSN chpid won't initialize 

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth_eddp.c |    3 ++-
 qeth_main.c |   17 +++++++----------
 qeth_mpc.h  |    2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff -Naupr linux-orig/drivers/s390/net/qeth_eddp.c linux-patched/drivers/s390/net/qeth_eddp.c
--- linux-orig/drivers/s390/net/qeth_eddp.c	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_eddp.c	2005-12-12 18:56:23.000000000 +0100
@@ -62,7 +62,8 @@ qeth_eddp_free_context(struct qeth_eddp_
 	for (i = 0; i < ctx->num_pages; ++i)
 		free_page((unsigned long)ctx->pages[i]);
 	kfree(ctx->pages);
-	kfree(ctx->elements);
+	if (ctx->elements != NULL)
+		kfree(ctx->elements);
 	kfree(ctx);
 }
 
diff -Naupr linux-orig/drivers/s390/net/qeth_main.c linux-patched/drivers/s390/net/qeth_main.c
--- linux-orig/drivers/s390/net/qeth_main.c	2005-12-12 18:15:36.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_main.c	2005-12-12 18:56:23.000000000 +0100
@@ -518,7 +518,8 @@ __qeth_set_offline(struct ccwgroup_devic
 
 	QETH_DBF_TEXT(setup, 3, "setoffl");
 	QETH_DBF_HEX(setup, 3, &card, sizeof(void *));
-
+	
+	netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if (qeth_stop_card(card, recovery_mode) == -ERESTARTSYS){
 		PRINT_WARN("Stopping card %s interrupted by user!\n",
@@ -1020,7 +1021,6 @@ void
 qeth_schedule_recovery(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(trace,2,"startrec");
-
 	if (qeth_set_thread_start_bit(card, QETH_RECOVER_THREAD) == 0)
 		schedule_work(&card->kernel_thread_starter);
 }
@@ -1710,7 +1710,6 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   "IP address reset.\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
-				netif_carrier_on(card->dev);
 				qeth_schedule_recovery(card);
 				return NULL;
 			case IPA_CMD_MODCCID:
@@ -1959,7 +1958,7 @@ qeth_osn_send_ipa_cmd(struct qeth_card *
 {
 	u16 s1, s2;
 
-QETH_DBF_TEXT(trace,4,"osndipa");
+	QETH_DBF_TEXT(trace,4,"osndipa");
 
 	qeth_prepare_ipa_cmd(card, iob, QETH_PROT_OSN2);
 	s1 = (u16)(IPA_PDU_HEADER_SIZE + data_len);
@@ -3809,10 +3808,8 @@ qeth_open(struct net_device *dev)
 	card->data.state = CH_STATE_UP;
 	card->state = CARD_STATE_UP;
 
-	if (!card->lan_online){
-		if (netif_carrier_ok(dev))
-			netif_carrier_off(dev);
-	}
+	if (!card->lan_online && netif_carrier_ok(dev))
+		netif_carrier_off(dev);
 	return 0;
 }
 
@@ -7936,8 +7933,8 @@ __qeth_set_online(struct ccwgroup_device
 		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
 		goto out_remove;
 	}
-/*maybe it was set offline without ifconfig down
- * we can also use this state for recovery purposes*/
+	netif_carrier_on(card->dev);
+
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (recover_flag == CARD_STATE_RECOVER)
 		qeth_start_again(card, recovery_mode);
diff -Naupr linux-orig/drivers/s390/net/qeth_mpc.h linux-patched/drivers/s390/net/qeth_mpc.h
--- linux-orig/drivers/s390/net/qeth_mpc.h	2005-12-12 17:33:48.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_mpc.h	2005-12-12 18:56:23.000000000 +0100
@@ -21,7 +21,7 @@ extern const char *VERSION_QETH_MPC_C;
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer+0x0e)
 #define QETH_IPA_PDU_LEN_PDU1(buffer) (buffer+0x26)
-#define QETH_IPA_PDU_LEN_PDU2(buffer) (buffer+0x2a)
+#define QETH_IPA_PDU_LEN_PDU2(buffer) (buffer+0x29)
 #define QETH_IPA_PDU_LEN_PDU3(buffer) (buffer+0x3a)
 
 extern unsigned char IPA_PDU_HEADER[];
