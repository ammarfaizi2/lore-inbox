Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUD1TO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUD1TO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUD1TMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:12:43 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6826 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S264952AbUD1QuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:50:21 -0400
Date: Wed, 28 Apr 2004 18:50:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/6): network driver.
Message-ID: <20040428165009.GD2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Network driver changes:
 - ctc: Add missing irb error checking.
 - iucv: Add name of net_device to iucvMagic to more than one
         connection between two guests.
 - qeth: Don't send IPA command if card is not in state SOFTSETUP or UP.
 - qeth: Fix number base in simple_strtoul call for buffer_count attribute.
 - qeth: Fix reallocating of buffers when buffer_count attribute is changed.
 - qeth: Correct handling of return codes in qeth_realloc_buffer_pool.
 - qeth: Don't call dev_close/dev_open on STOPLAN/STARTLAN commands.
         Use netif_carrier_off/netif_carrier_on instead.

diffstat:
 drivers/s390/net/ctcmain.c   |   35 ++++++-
 drivers/s390/net/netiucv.c   |   35 +++++--
 drivers/s390/net/qeth.h      |   27 ++---
 drivers/s390/net/qeth_main.c |  209 ++++++++++++++++++++++++++++++-------------
 drivers/s390/net/qeth_sys.c  |   78 ++++++----------
 5 files changed, 251 insertions(+), 133 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Sun Apr  4 05:36:56 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Wed Apr 28 17:51:39 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.58 2004/03/24 10:51:56 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.59 2004/04/21 17:10:13 ptiedem Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.58 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.59 $
  *
  */
 
@@ -319,7 +319,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.58 $";
+	char vbuf[] = "$Revision: 1.59 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2045,6 +2045,32 @@
 	return ret;
 }
 
+static long
+__ctc_check_irb_error(struct ccw_device *cdev, struct irb *irb)
+{
+	if (!IS_ERR(irb))
+		return 0;
+
+	switch (PTR_ERR(irb)) {
+	case -EIO:
+		ctc_pr_warn("i/o-error on device %s\n", cdev->dev.bus_id);
+//		CTC_DBF_TEXT(trace, 2, "ckirberr");
+//		CTC_DBF_TEXT_(trace, 2, "  rc%d", -EIO);
+		break;
+	case -ETIMEDOUT:
+		ctc_pr_warn("timeout on device %s\n", cdev->dev.bus_id);
+//		CTC_DBF_TEXT(trace, 2, "ckirberr");
+//		CTC_DBF_TEXT_(trace, 2, "  rc%d", -ETIMEDOUT);
+		break;
+	default:
+		ctc_pr_warn("unknown error %ld on device %s\n", PTR_ERR(irb),
+			   cdev->dev.bus_id);
+//		CTC_DBF_TEXT(trace, 2, "ckirberr");
+//		CTC_DBF_TEXT(trace, 2, "  rc???");
+	}
+	return PTR_ERR(irb);
+}
+
 /**
  * Main IRQ handler.
  *
@@ -2059,6 +2085,9 @@
 	struct net_device *dev;
 	struct ctc_priv *priv;
 
+	if (__ctc_check_irb_error(cdev, irb))
+		return;
+
 	/* Check for unsolicited interrupts. */
 	if (!cdev->dev.driver_data) {
 		ctc_pr_warn("ctc: Got unsolicited irq: %s c-%02x d-%02x\n",
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Wed Apr 28 17:51:39 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.49 2004/04/15 06:37:54 braunu Exp $
+ * $Id: netiucv.c,v 1.51 2004/04/23 08:11:21 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.49 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.51 $
  *
  */
 
@@ -169,10 +169,10 @@
 }
 
 static __u8 iucv_host[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
-static __u8 iucvMagic[16] = {
-	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
-	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
-};
+//static __u8 iucvMagic[16] = {
+//	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
+//	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
+//};
 
 /**
  * This mask means the 16-byte IUCV "magic" and the origin userid must
@@ -693,13 +693,20 @@
 conn_action_connreject(fsm_instance *fi, int event, void *arg)
 {
 	struct iucv_event *ev = (struct iucv_event *)arg;
-	// struct iucv_connection *conn = ev->conn;
+	struct iucv_connection *conn = ev->conn;
+	struct net_device *netdev = conn->netdev;
 	iucv_ConnectionPending *eib = (iucv_ConnectionPending *)ev->data;
 	__u8 udata[16];
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	iucv_sever(eib->ippathid, udata);
+	if (eib->ippathid != conn->pathid) {
+		printk(KERN_INFO
+			"%s: IR pathid %d does not match original pathid %d\n",
+			netdev->name, eib->ippathid, conn->pathid);
+		iucv_sever(conn->pathid, udata);
+	}
 }
 
 static void
@@ -715,7 +722,12 @@
 
 	fsm_deltimer(&conn->timer);
 	fsm_newstate(fi, CONN_STATE_IDLE);
-	conn->pathid = eib->ippathid;
+	if (eib->ippathid != conn->pathid) {
+		printk(KERN_INFO
+			"%s: IR pathid %d does not match original pathid %d\n",
+			netdev->name, eib->ippathid, conn->pathid);
+		conn->pathid = eib->ippathid;
+	}
 	netdev->tx_queue_len = eib->ipmsglim;
 	fsm_event(privptr->fsm, DEV_EVENT_CONUP, netdev);
 }
@@ -759,9 +771,14 @@
 	struct iucv_connection *conn = ev->conn;
 	__u16 msglimit;
 	int rc;
+	__u8 iucvMagic[16] = {
+	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
+        0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
+	};
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
+	memcpy(iucvMagic, conn->netdev->name, IFNAMSIZ);
 	if (conn->handle == 0) {
 		conn->handle =
 			iucv_register_program(iucvMagic, conn->userid, mask,
@@ -1882,7 +1899,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.49 $";
+	char vbuf[] = "$Revision: 1.51 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Wed Apr 28 17:51:39 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.100 $"
+#define VERSION_QETH_H 		"$Revision: 1.102 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -398,11 +398,6 @@
 	struct qdio_buffer qdio_bufs[QDIO_MAX_BUFFERS_PER_Q];
 	struct qeth_qdio_buffer bufs[QDIO_MAX_BUFFERS_PER_Q];
 	/*
-	 * buf_to_process means "buffer primed by hardware,
-	 * has to be read in by driver"; current state PRIMED
-	 */
-	volatile int next_buf_to_process;
-	/*
 	 * buf_to_init means "buffer must be initialized by driver and must
 	 * be made available for hardware" -> state is set to EMPTY
 	 */
@@ -493,8 +488,7 @@
 	CARD_STATE_DOWN,
 	CARD_STATE_HARDSETUP,
 	CARD_STATE_SOFTSETUP,
-	CARD_STATE_UP_LAN_OFFLINE,
-	CARD_STATE_UP_LAN_ONLINE,
+	CARD_STATE_UP,
 	CARD_STATE_RECOVER,
 };
 
@@ -981,24 +975,27 @@
 extern int
 qeth_setrouting_v6(struct qeth_card *);
 
-int
+extern int
 qeth_add_ipato_entry(struct qeth_card *, struct qeth_ipato_entry *);
 
-void
+extern void
 qeth_del_ipato_entry(struct qeth_card *, enum qeth_prot_versions, u8 *, int);
 
-int
+extern int
 qeth_add_vipa(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 
-void
+extern void
 qeth_del_vipa(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 
-int
+extern int
 qeth_add_rxip(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 
-void
+extern void
 qeth_del_rxip(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 
-void
+extern void
 qeth_schedule_recovery(struct qeth_card *);
+
+extern int
+qeth_realloc_buffer_pool(struct qeth_card *, int);
 #endif /* __QETH_H__ */
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Wed Apr 28 17:51:39 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.82 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.89 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.82 $	 $Date: 2004/04/21 08:27:21 $
+ *    $Revision: 1.89 $	 $Date: 2004/04/27 16:27:26 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.82 $"
+#define VERSION_QETH_C "$Revision: 1.89 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
 	VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
 	QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -457,8 +457,7 @@
 	ccw_device_set_offline(CARD_DDEV(card));
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
-	if ((recover_flag == CARD_STATE_UP_LAN_ONLINE) ||
-	    (recover_flag == CARD_STATE_UP_LAN_OFFLINE))
+	if (recover_flag == CARD_STATE_UP)
 		card->state = CARD_STATE_RECOVER;
 	return 0;
 }
@@ -485,7 +484,8 @@
 	write_lock_irqsave(&qeth_card_list.rwlock, flags);
 	list_del(&card->list);
 	write_unlock_irqrestore(&qeth_card_list.rwlock, flags);
-	unregister_netdev(card->dev);
+	if (card->dev)
+		unregister_netdev(card->dev);
 	qeth_remove_device_attributes(&cgdev->dev);
 	qeth_free_card(card);
 	cgdev->dev.driver_data = NULL;
@@ -1504,11 +1504,21 @@
 	spin_unlock_irqrestore(&reply->card->lock, flags);
 }
 
+static void
+qeth_reset_ip_addresses(struct qeth_card *card)
+{
+	QETH_DBF_TEXT(trace, 2, "rstipadd");
+
+	qeth_clear_ip_list(card, 0, 1);
+	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
+	qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD);
+	schedule_work(&card->kernel_thread_starter);
+}
+
 static struct qeth_ipa_cmd *
 qeth_check_ipa_data(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
 	struct qeth_ipa_cmd *cmd = NULL;
-	enum qeth_card_states old_state;
 
 	QETH_DBF_TEXT(trace,5,"chkipad");
 	if (IS_IPA(iob->data)){
@@ -1521,30 +1531,27 @@
 				PRINT_WARN("Link failure on %s (CHPID 0x%X) - "
 					   "there is a network problem or "
 					   "someone pulled the cable or "
-					   "disabled the port. Setting state "
-					   "of interface to DOWN.\n",
+					   "disabled the port.\n",
 					   card->info.if_name,
 					   card->info.chpid);
 				card->lan_online = 0;
-				old_state = card->state;
-				rtnl_lock();
-				dev_close(card->dev);
-				rtnl_unlock();
-				if ((old_state == CARD_STATE_UP_LAN_ONLINE) ||
-				    (old_state == CARD_STATE_UP_LAN_OFFLINE))
-					card->state = CARD_STATE_UP_LAN_OFFLINE;
+				if (netif_carrier_ok(card->dev)) {
+					netif_carrier_off(card->dev);
+					netif_stop_queue(card->dev);
+				}
 				return NULL;
 			case IPA_CMD_STARTLAN:
 				PRINT_INFO("Link reestablished on %s "
-					   "(CHPID 0x%X)\n",
+					   "(CHPID 0x%X). Scheduling "
+					   "IP address reset.\n",
 					   card->info.if_name,
 					   card->info.chpid);
 				card->lan_online = 1;
-				if (card->state == CARD_STATE_UP_LAN_OFFLINE){
-					rtnl_lock();
-					dev_open(card->dev);
-					rtnl_unlock();
+				if (!netif_carrier_ok(card->dev)) {
+					netif_carrier_on(card->dev);
+					netif_wake_queue(card->dev);
 				}
+				qeth_reset_ip_addresses(card);
 				return NULL;
 			case IPA_CMD_REGISTER_LOCAL_ADDR:
 				QETH_DBF_TEXT(trace,3, "irla");
@@ -2674,6 +2681,7 @@
 	void *ptr;
 	int i, j;
 
+	QETH_DBF_TEXT(trace,5,"clwkpool");
 	for (i = 0; i < card->qdio.init_pool.buf_count; ++i){
 	 	pool_entry = kmalloc(sizeof(*pool_entry), GFP_KERNEL);
 		if (!pool_entry){
@@ -2694,12 +2702,27 @@
 		}
 		list_add(&pool_entry->init_list,
 			 &card->qdio.init_pool.entry_list);
-		list_add(&pool_entry->list,
-			 &card->qdio.in_buf_pool.entry_list);
 	}
 	return 0;
 }
 
+int
+qeth_realloc_buffer_pool(struct qeth_card *card, int bufcnt)
+{
+	QETH_DBF_TEXT(trace, 2, "realcbp");
+
+	if ((card->state != CARD_STATE_DOWN) &&
+	    (card->state != CARD_STATE_RECOVER))
+		return -EPERM;
+
+	/* TODO: steel/add buffers from/to a running card's buffer pool (?) */
+	qeth_clear_working_pool_list(card);
+	qeth_free_buffer_pool(card);
+	card->qdio.in_buf_pool.buf_count = bufcnt;
+	card->qdio.init_pool.buf_count = bufcnt;
+	return qeth_alloc_buffer_pool(card);
+}
+
 static int
 qeth_alloc_qdio_buffers(struct qeth_card *card)
 {
@@ -2707,10 +2730,9 @@
 
 	QETH_DBF_TEXT(setup, 2, "allcqdbf");
 
-	if (card->qdio.state == QETH_QDIO_ALLOCATED) {
-		qeth_initialize_working_pool_list(card);
+	if (card->qdio.state == QETH_QDIO_ALLOCATED)
 		return 0;
-	}
+
 	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q), GFP_KERNEL);
 	if (!card->qdio.in_q)
 		return - ENOMEM;
@@ -2823,14 +2845,13 @@
 	/* inbound queue */
 	memset(card->qdio.in_q->qdio_bufs, 0,
 	       QDIO_MAX_BUFFERS_PER_Q * sizeof(struct qdio_buffer));
-	card->qdio.in_q->next_buf_to_process = 0;
-	card->qdio.in_q->next_buf_to_init = 0;
+	qeth_initialize_working_pool_list(card);
 	/*give only as many buffers to hardware as we have buffer pool entries*/
-	for (i = 0; i < card->qdio.in_buf_pool.buf_count; ++i)
+	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
 		qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
-	card->qdio.in_q->next_buf_to_init = card->qdio.in_buf_pool.buf_count;
+	card->qdio.in_q->next_buf_to_init = card->qdio.in_buf_pool.buf_count - 1;
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
-		     card->qdio.in_buf_pool.buf_count, NULL);
+		     card->qdio.in_buf_pool.buf_count - 1, NULL);
 	if (rc) {
 		QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
 		return rc;
@@ -3168,7 +3189,7 @@
 		card->stats.tx_errors++;
 		return -EIO;
 	}
-	if (card->state != CARD_STATE_UP_LAN_ONLINE) {
+	if ((card->state != CARD_STATE_UP) || !netif_carrier_ok(dev)) {
 		card->stats.tx_dropped++;
 		card->stats.tx_errors++;
 		card->stats.tx_carrier_errors++;
@@ -3271,18 +3292,19 @@
 
 	card = (struct qeth_card *) dev->priv;
 
-	if ((card->state != CARD_STATE_SOFTSETUP) &&
-	    (card->state != CARD_STATE_UP_LAN_OFFLINE))
+	if (card->state != CARD_STATE_SOFTSETUP)
 		return -ENODEV;
-	if (!card->lan_online){
-		card->state = CARD_STATE_UP_LAN_OFFLINE;
-		return -EIO;
-	}
 
 	card->dev->flags |= IFF_UP;
 	netif_start_queue(dev);
 	card->data.state = CH_STATE_UP;
-	card->state = CARD_STATE_UP_LAN_ONLINE;
+	card->state = CARD_STATE_UP;
+
+	if (!card->lan_online){
+		if (netif_carrier_ok(dev))
+			netif_carrier_off(dev);
+		netif_stop_queue(dev);
+	}
 	return 0;
 }
 
@@ -3297,8 +3319,7 @@
 
 	netif_stop_queue(dev);
 	card->dev->flags &= ~IFF_UP;
-	if ((card->state == CARD_STATE_UP_LAN_ONLINE) ||
-	    (card->state == CARD_STATE_UP_LAN_OFFLINE))
+	if (card->state == CARD_STATE_UP)
 		card->state = CARD_STATE_SOFTSETUP;
 	return 0;
 }
@@ -3925,13 +3946,17 @@
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SETASSPARMS, proto);
 
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
-	/* adjust sizes in IPA_PDU_HEADER */
-	s1 = (u32) IPA_PDU_HEADER_SIZE + QETH_ARP_CMD_BASE_LEN + data_len;
-	s2 = (u32) QETH_ARP_CMD_BASE_LEN + data_len;
-	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
+
+	if ((IPA_PDU_HEADER_SIZE + QETH_ARP_CMD_BASE_LEN + data_len) > 256) {
+		/* adjust sizes in IPA_PDU_HEADER */
+		s1 = (u32) IPA_PDU_HEADER_SIZE + QETH_ARP_CMD_BASE_LEN +
+			   data_len;
+		s2 = (u32) QETH_ARP_CMD_BASE_LEN + data_len;
+		memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
+		memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
+		memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
+		memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
+	}
 
 	cmd = (struct qeth_ipa_arp_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	cmd->shdr.assist_no = IPA_ARP_PROCESSING;
@@ -3975,7 +4000,12 @@
 
 	QETH_DBF_TEXT(trace,3,"arpquery");
 
-	/* TODO: really not supported by GuestLAN? */
+	/*
+	 * currently GuestLAN  does only deliver all zeros on query arp,
+	 * even though arp processing is supported (according to IPA supp.
+	 * funcs flags); since all zeros is no valueable information,
+	 * we say EOPNOTSUPP for all ARP functions
+	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -3997,9 +4027,11 @@
 		return -ENOMEM;
 	}
 	memset(qdata, 0, sizeof(struct qeth_arp_query_data));
+	/* do not give sizeof(struct qeth_arp_query_data) to next command;
+	 * this would cause the IPA PDU size to be set to a value of > 256
+	 * and this is to much for HiperSockets */
 	iob = qeth_get_ipa_arp_cmd_buffer(card, IPA_CMD_ASS_ARP_QUERY_INFO,
-					  sizeof(struct qeth_arp_query_data),
-					  QETH_PROT_IPV4);
+					  0, QETH_PROT_IPV4);
 	rc = qeth_send_ipa_arp_cmd(card, iob,
 				   (char *) qdata,
 				   sizeof(struct qeth_arp_query_data),
@@ -4043,7 +4075,12 @@
 
 	QETH_DBF_TEXT(trace,3,"arpadent");
 
-	/* TODO: really not supported by GuestLAN? */
+	/*
+	 * currently GuestLAN  does only deliver all zeros on query arp,
+	 * even though arp processing is supported (according to IPA supp.
+	 * funcs flags); since all zeros is no valueable information,
+	 * we say EOPNOTSUPP for all ARP functions
+	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -4081,7 +4118,12 @@
 
 	QETH_DBF_TEXT(trace,3,"arprment");
 
-	/* TODO: really not supported by GuestLAN? */
+	/*
+	 * currently GuestLAN  does only deliver all zeros on query arp,
+	 * even though arp processing is supported (according to IPA supp.
+	 * funcs flags); since all zeros is no valueable information,
+	 * we say EOPNOTSUPP for all ARP functions
+	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -4117,7 +4159,12 @@
 
 	QETH_DBF_TEXT(trace,3,"arpflush");
 
-	/* TODO: really not supported by GuestLAN? */
+	/*
+	 * currently GuestLAN  does only deliver all zeros on query arp,
+	 * even though arp processing is supported (according to IPA supp.
+	 * funcs flags); since all zeros is no valueable information,
+	 * we say EOPNOTSUPP for all ARP functions
+	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -4147,8 +4194,7 @@
 	if (!card)
 		return -ENODEV;
 
-	if ((card->state != CARD_STATE_UP_LAN_ONLINE) &&
-	    (card->state != CARD_STATE_UP_LAN_OFFLINE))
+	if (card->state != CARD_STATE_UP)
 		return -ENODEV;
 
 	switch (cmd){
@@ -5551,6 +5597,47 @@
 
 }
 
+static void
+qeth_correct_routing_type(struct qeth_card *card, enum qeth_routing_types *type,
+			enum qeth_prot_versions prot)
+{
+	if (card->info.type == QETH_CARD_TYPE_IQD) {
+		switch (*type) {
+		case NO_ROUTER:
+		case PRIMARY_CONNECTOR:
+		case SECONDARY_CONNECTOR:
+		case MULTICAST_ROUTER:
+			return;
+		default:
+			goto out_inval;
+		}
+	} else {
+		switch (*type) {
+		case NO_ROUTER:
+		case PRIMARY_ROUTER:
+		case SECONDARY_ROUTER:
+			return;
+		case MULTICAST_ROUTER:
+			if (qeth_is_ipafunc_supported(card, prot,
+						      IPA_OSA_MC_ROUTER))
+				return;
+		default:
+			goto out_inval;
+		}
+	}
+out_inval:
+	PRINT_WARN("Routing type '%s' not supported for interface %s.\n"
+		   "Router status set to 'no router'.\n",
+		   ((*type == PRIMARY_ROUTER)? "primary router" :
+		    (*type == SECONDARY_ROUTER)? "secondary router" :
+		    (*type == PRIMARY_CONNECTOR)? "primary connector" :
+		    (*type == SECONDARY_CONNECTOR)? "secondary connector" :
+		    (*type == MULTICAST_ROUTER)? "multicast router" :
+		    "unknown"),
+		   card->dev->name);
+	*type = NO_ROUTER;
+}
+
 int
 qeth_setrouting_v4(struct qeth_card *card)
 {
@@ -5558,8 +5645,8 @@
 
 	QETH_DBF_TEXT(trace,3,"setrtg4");
 
-	if (card->options.route4.type == NO_ROUTER)
-		return 0;
+	qeth_correct_routing_type(card, &card->options.route4.type,
+				  QETH_PROT_IPV4);
 
 	rc = qeth_send_setrouting(card, card->options.route4.type,
 				  QETH_PROT_IPV4);
@@ -5580,6 +5667,9 @@
 	QETH_DBF_TEXT(trace,3,"setrtg6");
 #ifdef CONFIG_QETH_IPV6
 
+	qeth_correct_routing_type(card, &card->options.route6.type,
+				  QETH_PROT_IPV6);
+
 	if ((card->options.route6.type == NO_ROUTER) ||
 	    ((card->info.type == QETH_CARD_TYPE_OSAE) &&
 	     (card->options.route6.type == MULTICAST_ROUTER) &&
@@ -5775,8 +5865,7 @@
 		return -ERESTARTSYS;
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
-	    ((card->state == CARD_STATE_UP_LAN_ONLINE) ||
-	     (card->state == CARD_STATE_UP_LAN_OFFLINE))) {
+	    (card->state == CARD_STATE_UP)) {
 		recover_flag = 1;
 		rtnl_lock();
 		dev_close(card->dev);
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-s390/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_sys.c	Wed Apr 28 17:51:39 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.19 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.24 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -41,10 +41,11 @@
 		return sprintf(buf, "HARDSETUP\n");
 	case CARD_STATE_SOFTSETUP:
 		return sprintf(buf, "SOFTSETUP\n");
-	case CARD_STATE_UP_LAN_OFFLINE:
-		return sprintf(buf, "UP (LAN OFFLINE)\n");
-	case CARD_STATE_UP_LAN_ONLINE:
+	case CARD_STATE_UP:
+		if (card->lan_online)
 		return sprintf(buf, "UP (LAN ONLINE)\n");
+		else
+			return sprintf(buf, "UP (LAN OFFLINE)\n");
 	case CARD_STATE_RECOVER:
 		return sprintf(buf, "RECOVER\n");
 	default:
@@ -293,7 +294,8 @@
 {
 	struct qeth_card *card = dev->driver_data;
 	char *tmp;
-	unsigned int cnt;
+	int cnt, old_cnt;
+	int rc;
 
 	if (!card)
 		return -EINVAL;
@@ -302,12 +304,15 @@
 	    (card->state != CARD_STATE_RECOVER))
 		return -EPERM;
 
-	cnt = simple_strtoul(buf, &tmp, 16);
+	old_cnt = card->qdio.in_buf_pool.buf_count;
+	cnt = simple_strtoul(buf, &tmp, 10);
 	cnt = (cnt < QETH_IN_BUF_COUNT_MIN) ? QETH_IN_BUF_COUNT_MIN :
 		((cnt > QETH_IN_BUF_COUNT_MAX) ? QETH_IN_BUF_COUNT_MAX : cnt);
-	card->qdio.in_buf_pool.buf_count = cnt;
-	/* TODO: steel/add buffers from/to a running card's buffer pool (?) */
-
+	if (old_cnt != cnt) {
+		if ((rc = qeth_realloc_buffer_pool(card, cnt)))
+			PRINT_WARN("Error (%d) while setting "
+				   "buffer count.\n", rc);
+	}
 	return count;
 }
 
@@ -356,45 +361,31 @@
 
 	if (!strcmp(tmp, "no_router")){
 		route->type = NO_ROUTER;
-		goto check_reset;
-	}
-
-	if (card->info.type == QETH_CARD_TYPE_IQD) {
-		if (!strcmp(tmp, "primary_connector")) {
-			route->type = PRIMARY_CONNECTOR;
-		} else if (!strcmp(tmp, "secondary_connector")) {
-			route->type = SECONDARY_CONNECTOR;
-		} else if (!strcmp(tmp, "multicast_router")) {
-			route->type = MULTICAST_ROUTER;
-		} else
-			goto out_inval;
+	} else if (!strcmp(tmp, "primary_connector")) {
+		route->type = PRIMARY_CONNECTOR;
+	} else if (!strcmp(tmp, "secondary_connector")) {
+		route->type = SECONDARY_CONNECTOR;
+	} else if (!strcmp(tmp, "multicast_router")) {
+		route->type = MULTICAST_ROUTER;
+	} else if (!strcmp(tmp, "primary_router")) {
+		route->type = PRIMARY_ROUTER;
+	} else if (!strcmp(tmp, "secondary_router")) {
+		route->type = SECONDARY_ROUTER;
+	} else if (!strcmp(tmp, "multicast_router")) {
+		route->type = MULTICAST_ROUTER;
 	} else {
-		if (!strcmp(tmp, "primary_router")) {
-			route->type = PRIMARY_ROUTER;
-		} else if (!strcmp(tmp, "secondary_router")) {
-			route->type = SECONDARY_ROUTER;
-		} else if (!strcmp(tmp, "multicast_router")) {
-			if (qeth_is_ipafunc_supported(card, prot,
-						      IPA_OSA_MC_ROUTER))
-				route->type = MULTICAST_ROUTER;
-			else
-				goto out_inval;
-		} else
-			goto out_inval;
+		PRINT_WARN("Invalid routing type '%s'.\n", tmp);
+		return -EINVAL;
 	}
-check_reset:
-	if (old_route_type != route->type){
+	if (((card->state == CARD_STATE_SOFTSETUP) ||
+	     (card->state == CARD_STATE_UP)) &&
+	    (old_route_type != route->type)){
 		if (prot == QETH_PROT_IPV4)
 			rc = qeth_setrouting_v4(card);
 		else if (prot == QETH_PROT_IPV6)
 			rc = qeth_setrouting_v6(card);
 	}
 	return count;
-out_inval:
-	PRINT_WARN("Routing type '%s' not supported for interface %s.\n"
-		   "Router status not changed.\n",
-		   tmp, card->info.if_name);
-	return -EINVAL;
 }
 
 static ssize_t
@@ -572,8 +563,7 @@
 	if (!card)
 		return -EINVAL;
 
-	if ((card->state != CARD_STATE_UP_LAN_ONLINE) &&
-	    (card->state != CARD_STATE_UP_LAN_OFFLINE))
+	if (card->state != CARD_STATE_UP)
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
@@ -585,7 +575,6 @@
 
 static DEVICE_ATTR(recover, 0200, NULL, qeth_dev_recover_store);
 
-/* TODO */
 static ssize_t
 qeth_dev_broadcast_mode_show(struct device *dev, char *buf)
 {
@@ -603,7 +592,6 @@
 		       "all rings":"local");
 }
 
-/* TODO */
 static ssize_t
 qeth_dev_broadcast_mode_store(struct device *dev, const char *buf, size_t count)
 {
@@ -642,7 +630,6 @@
 static DEVICE_ATTR(broadcast_mode, 0644, qeth_dev_broadcast_mode_show,
 		   qeth_dev_broadcast_mode_store);
 
-/* TODO */
 static ssize_t
 qeth_dev_canonical_macaddr_show(struct device *dev, char *buf)
 {
@@ -659,7 +646,6 @@
 				     QETH_TR_MACADDR_CANONICAL)? 1:0);
 }
 
-/* TODO */
 static ssize_t
 qeth_dev_canonical_macaddr_store(struct device *dev, const char *buf,
 				  size_t count)
