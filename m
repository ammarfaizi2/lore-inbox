Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVI3IQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVI3IQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVI3IQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:16:25 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:11502 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030265AbVI3IQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:16:21 -0400
Date: Fri, 30 Sep 2005 10:19:19 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2/2] s390: introducing support in qeth for new OSA CHPID type OSN
Message-ID: <20050930081919.GC7387@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/2] s390: introducing support in qeth for new OSA CHPID type OSN 

From: Ursula Braun <braunu@de.ibm.com>
	This patch introduces new feature in qeth: 
	qeth enhancement provides the device driver support for
        the Communication Controller for Linux on System z9 and zSeries
        (CCL), which is software that enables running the Network Control
        Program (NCP) on a zSeries machine. The OSA CDLC support is based
        on a new IBM mainframe CHPID type called Open Systems Adaper for
        NCP (OSN). In case of OSN qeth communicates with the type-OSN
        OSA-card on one hand, and with the CCL-kernel-component Network
        Device Handler (NDH) on the other.
	
Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 qeth.h      |   45 ++++++
 qeth_fs.h   |   12 +
 qeth_main.c |  419 +++++++++++++++++++++++++++++++++++++++++++++---------------
 qeth_mpc.c  |    6 
 qeth_mpc.h  |   15 +-
 qeth_sys.c  |   28 +++-
 6 files changed, 413 insertions(+), 112 deletions(-)

diff -Naupr linux-orig/drivers/s390/net/qeth_fs.h linux-patched/drivers/s390/net/qeth_fs.h
--- linux-orig/drivers/s390/net/qeth_fs.h	2005-09-29 16:10:16.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth_fs.h	2005-09-29 16:48:42.000000000 +0200
@@ -12,7 +12,7 @@
 #ifndef __QETH_FS_H__
 #define __QETH_FS_H__
 
-#define VERSION_QETH_FS_H "$Revision: 1.9 $"
+#define VERSION_QETH_FS_H "$Revision: 1.10 $"
 
 extern const char *VERSION_QETH_PROC_C;
 extern const char *VERSION_QETH_SYS_C;
@@ -43,6 +43,12 @@ extern void
 qeth_remove_device_attributes(struct device *dev);
 
 extern int
+qeth_create_device_attributes_osn(struct device *dev);
+
+extern void
+qeth_remove_device_attributes_osn(struct device *dev);
+		    
+extern int
 qeth_create_driver_attributes(void);
 
 extern void
@@ -108,6 +114,8 @@ qeth_get_cardname(struct qeth_card *card
 			return " OSD Express";
 		case QETH_CARD_TYPE_IQD:
 			return " HiperSockets";
+		case QETH_CARD_TYPE_OSN:
+			return " OSN QDIO";
 		default:
 			return " unknown";
 		}
@@ -153,6 +161,8 @@ qeth_get_cardname_short(struct qeth_card
 			}
 		case QETH_CARD_TYPE_IQD:
 			return "HiperSockets";
+		case QETH_CARD_TYPE_OSN:
+			return "OSN";
 		default:
 			return "unknown";
 		}
diff -Naupr linux-orig/drivers/s390/net/qeth.h linux-patched/drivers/s390/net/qeth.h
--- linux-orig/drivers/s390/net/qeth.h	2005-09-29 16:43:02.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth.h	2005-09-29 16:51:31.000000000 +0200
@@ -275,6 +275,10 @@ qeth_is_ipa_enabled(struct qeth_ipa_info
 	QETH_IDX_FUNC_LEVEL_IQD_ENA_IPAT, \
 	QETH_IDX_FUNC_LEVEL_IQD_DIS_IPAT, \
 	QETH_MAX_QUEUES,0x103}, \
+	{0x1731,0x06,0x1732,0x06,QETH_CARD_TYPE_OSN,0, \
+	QETH_IDX_FUNC_LEVEL_OSAE_ENA_IPAT, \
+	QETH_IDX_FUNC_LEVEL_OSAE_DIS_IPAT, \
+	QETH_MAX_QUEUES,0}, \
 	{0,0,0,0,0,0,0,0,0}}
 
 #define QETH_REAL_CARD		1
@@ -363,10 +367,22 @@ struct qeth_hdr_layer2 {
 	__u8 reserved2[16];
 } __attribute__ ((packed));
 
+struct qeth_hdr_osn {
+	__u8 id;
+	__u8 reserved;
+	__u16 seq_no;
+	__u16 reserved2;
+	__u16 control_flags;
+	__u16 pdu_length;
+	__u8 reserved3[18];
+	__u32 ccid;
+} __attribute__ ((packed));
+					    
 struct qeth_hdr {
 	union {
 		struct qeth_hdr_layer2 l2;
 		struct qeth_hdr_layer3 l3;
+		struct qeth_hdr_osn    osn;
 	} hdr;
 } __attribute__ ((packed));
 
@@ -413,6 +429,7 @@ enum qeth_header_ids {
 	QETH_HEADER_TYPE_LAYER3 = 0x01,
 	QETH_HEADER_TYPE_LAYER2 = 0x02,
 	QETH_HEADER_TYPE_TSO	= 0x03,
+	QETH_HEADER_TYPE_OSN    = 0x04,
 };
 /* flags for qeth_hdr.ext_flags */
 #define QETH_HDR_EXT_VLAN_FRAME       0x01
@@ -582,7 +599,6 @@ enum qeth_card_states {
  * Protocol versions
  */
 enum qeth_prot_versions {
-	QETH_PROT_SNA  = 0x0001,
 	QETH_PROT_IPV4 = 0x0004,
 	QETH_PROT_IPV6 = 0x0006,
 };
@@ -761,6 +777,11 @@ enum qeth_threads {
 	QETH_RECOVER_THREAD = 2,
 };
 
+struct qeth_osn_info {
+	int (*assist_cb)(struct net_device *dev, void *data);
+	int (*data_cb)(struct sk_buff *skb);
+};
+
 struct qeth_card {
 	struct list_head list;
 	enum qeth_card_states state;
@@ -803,6 +824,7 @@ struct qeth_card {
 	int use_hard_stop;
 	int (*orig_hard_header)(struct sk_buff *,struct net_device *,
 				unsigned short,void *,void *,unsigned);
+	struct qeth_osn_info osn_info; 
 };
 
 struct qeth_card_list_struct {
@@ -916,10 +938,12 @@ qeth_get_hlen(__u8 link_type)
 static inline unsigned short
 qeth_get_netdev_flags(struct qeth_card *card)
 {
-	if (card->options.layer2)
+	if (card->options.layer2 &&
+	   (card->info.type == QETH_CARD_TYPE_OSAE))
 		return 0;
 	switch (card->info.type) {
 	case QETH_CARD_TYPE_IQD:
+	case QETH_CARD_TYPE_OSN:	
 		return IFF_NOARP;
 #ifdef CONFIG_QETH_IPV6
 	default:
@@ -956,9 +980,10 @@ static inline int
 qeth_get_max_mtu_for_card(int cardtype)
 {
 	switch (cardtype) {
+		
 	case QETH_CARD_TYPE_UNKNOWN:
-		return 61440;
 	case QETH_CARD_TYPE_OSAE:
+	case QETH_CARD_TYPE_OSN:
 		return 61440;
 	case QETH_CARD_TYPE_IQD:
 		return 57344;
@@ -1004,6 +1029,7 @@ qeth_mtu_is_valid(struct qeth_card * car
 	case QETH_CARD_TYPE_IQD:
 		return ((mtu >= 576) &&
 			(mtu <= card->info.max_mtu + 4096 - 32));
+	case QETH_CARD_TYPE_OSN:
 	case QETH_CARD_TYPE_UNKNOWN:
 	default:
 		return 1;
@@ -1015,6 +1041,7 @@ qeth_get_arphdr_type(int cardtype, int l
 {
 	switch (cardtype) {
 	case QETH_CARD_TYPE_OSAE:
+	case QETH_CARD_TYPE_OSN:
 		switch (linktype) {
 		case QETH_LINK_TYPE_LANE_TR:
 		case QETH_LINK_TYPE_HSTR:
@@ -1182,4 +1209,16 @@ qeth_fill_header(struct qeth_card *, str
 extern void
 qeth_flush_buffers(struct qeth_qdio_out_q *, int, int, int);
 
+extern int
+qeth_osn_assist(struct net_device *, void *, int);
+
+extern int
+qeth_osn_register(unsigned char *read_dev_no,
+                 struct net_device **,
+                 int (*assist_cb)(struct net_device *, void *),
+                 int (*data_cb)(struct sk_buff *));
+
+extern void
+qeth_osn_deregister(struct net_device *);
+		
 #endif /* __QETH_H__ */
diff -Naupr linux-orig/drivers/s390/net/qeth_main.c linux-patched/drivers/s390/net/qeth_main.c
--- linux-orig/drivers/s390/net/qeth_main.c	2005-09-29 16:43:02.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth_main.c	2005-09-29 16:57:23.000000000 +0200
@@ -196,7 +196,6 @@ qeth_notifier_register(struct task_struc
 {
 	struct qeth_notify_list_struct *n_entry;
 
-
 	/*check first if entry already exists*/
 	spin_lock(&qeth_notify_lock);
 	list_for_each_entry(n_entry, &qeth_notify_list, list) {
@@ -1024,7 +1023,10 @@ qeth_set_intial_options(struct qeth_card
 	card->options.fake_broadcast = 0;
 	card->options.add_hhlen = DEFAULT_ADD_HHLEN;
 	card->options.fake_ll = 0;
-	card->options.layer2 = 0;
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		card->options.layer2 = 1;
+	else
+		card->options.layer2 = 0;
 }
 
 /**
@@ -1113,19 +1115,20 @@ qeth_determine_card_type(struct qeth_car
 
 	QETH_DBF_TEXT(setup, 2, "detcdtyp");
 
+	card->qdio.do_prio_queueing = QETH_PRIOQ_DEFAULT;
+	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 	while (known_devices[i][4]) {
 		if ((CARD_RDEV(card)->id.dev_type == known_devices[i][2]) &&
 		    (CARD_RDEV(card)->id.dev_model == known_devices[i][3])) {
 			card->info.type = known_devices[i][4];
+			card->qdio.no_out_queues = known_devices[i][8];
+			card->info.is_multicast_different = known_devices[i][9];
 			if (is_1920_device(card)) {
 				PRINT_INFO("Priority Queueing not able "
 					   "due to hardware limitations!\n");
 				card->qdio.no_out_queues = 1;
 				card->qdio.default_out_queue = 0;
-			} else {
-				card->qdio.no_out_queues = known_devices[i][8];
-			}
-			card->info.is_multicast_different = known_devices[i][9];
+			} 
 			return 0;
 		}
 		i++;
@@ -1149,6 +1152,8 @@ qeth_probe_device(struct ccwgroup_device
 	if (!get_device(dev))
 		return -ENODEV;
 
+	QETH_DBF_TEXT_(setup, 2, "%s", gdev->dev.bus_id);
+	
 	card = qeth_alloc_card();
 	if (!card) {
 		put_device(dev);
@@ -1158,28 +1163,27 @@ qeth_probe_device(struct ccwgroup_device
 	card->read.ccwdev  = gdev->cdev[0];
 	card->write.ccwdev = gdev->cdev[1];
 	card->data.ccwdev  = gdev->cdev[2];
-
-	if ((rc = qeth_setup_card(card))){
-		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
-		put_device(dev);
-		qeth_free_card(card);
-		return rc;
-	}
 	gdev->dev.driver_data = card;
 	card->gdev = gdev;
 	gdev->cdev[0]->handler = qeth_irq;
 	gdev->cdev[1]->handler = qeth_irq;
 	gdev->cdev[2]->handler = qeth_irq;
 
-	rc = qeth_create_device_attributes(dev);
-	if (rc) {
+	if ((rc = qeth_determine_card_type(card))){
+		PRINT_WARN("%s: not a valid card type\n", __func__);
+		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
+		put_device(dev);
+		qeth_free_card(card);
+		return rc;
+	}			    
+	if ((rc = qeth_setup_card(card))){
+		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
 		put_device(dev);
 		qeth_free_card(card);
 		return rc;
 	}
-	if ((rc = qeth_determine_card_type(card))){
-		PRINT_WARN("%s: not a valid card type\n", __func__);
-		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
+	rc = qeth_create_device_attributes(dev);
+	if (rc) {
 		put_device(dev);
 		qeth_free_card(card);
 		return rc;
@@ -1660,6 +1664,8 @@ qeth_check_ipa_data(struct qeth_card *ca
 				netif_carrier_on(card->dev);
 				qeth_schedule_recovery(card);
 				return NULL;
+			case IPA_CMD_MODCCID:
+				return cmd;
 			case IPA_CMD_REGISTER_LOCAL_ADDR:
 				QETH_DBF_TEXT(trace,3, "irla");
 				break;
@@ -1721,6 +1727,14 @@ qeth_send_control_data_cb(struct qeth_ch
 	cmd = qeth_check_ipa_data(card, iob);
 	if ((cmd == NULL) && (card->state != CARD_STATE_DOWN))
 		goto out;
+	/*in case of OSN : check if cmd is set */
+	if (card->info.type == QETH_CARD_TYPE_OSN &&
+	    cmd &&
+	    cmd->hdr.command != IPA_CMD_STARTLAN &&
+	    card->osn_info.assist_cb != NULL) {
+		card->osn_info.assist_cb(card->dev, cmd);
+		goto out;
+	}
 
 	spin_lock_irqsave(&card->lock, flags);
 	list_for_each_entry_safe(reply, r, &card->cmd_waiter_list, list) {
@@ -1737,8 +1751,7 @@ qeth_send_control_data_cb(struct qeth_ch
 					keep_reply = reply->callback(card,
 							reply,
 							(unsigned long)cmd);
-				}
-				else
+				} else
 					keep_reply = reply->callback(card,
 							reply,
 							(unsigned long)iob);
@@ -1768,6 +1781,24 @@ out:
 	qeth_release_buffer(channel,iob);
 }
 
+static inline void
+qeth_prepare_control_data(struct qeth_card *card, int len,
+struct qeth_cmd_buffer *iob)
+{
+	qeth_setup_ccw(&card->write,iob->data,len);
+	iob->callback = qeth_release_buffer;
+
+	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
+	       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
+	card->seqno.trans_hdr++;
+	memcpy(QETH_PDU_HEADER_SEQ_NO(iob->data),
+	       &card->seqno.pdu_hdr, QETH_SEQ_NO_LENGTH);
+	card->seqno.pdu_hdr++;
+	memcpy(QETH_PDU_HEADER_ACK_SEQ_NO(iob->data),
+	       &card->seqno.pdu_hdr_ack, QETH_SEQ_NO_LENGTH);
+	QETH_DBF_HEX(control, 2, iob->data, QETH_DBF_CONTROL_LEN);
+}
+						    
 static int
 qeth_send_control_data(struct qeth_card *card, int len,
 		       struct qeth_cmd_buffer *iob,
@@ -1778,24 +1809,11 @@ qeth_send_control_data(struct qeth_card 
 {
 	int rc;
 	unsigned long flags;
-	struct qeth_reply *reply;
+	struct qeth_reply *reply = NULL;
 	struct timer_list timer;
 
 	QETH_DBF_TEXT(trace, 2, "sendctl");
 
-	qeth_setup_ccw(&card->write,iob->data,len);
-
-	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
-	       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
-	card->seqno.trans_hdr++;
-
-	memcpy(QETH_PDU_HEADER_SEQ_NO(iob->data),
-	       &card->seqno.pdu_hdr, QETH_SEQ_NO_LENGTH);
-	card->seqno.pdu_hdr++;
-	memcpy(QETH_PDU_HEADER_ACK_SEQ_NO(iob->data),
-	       &card->seqno.pdu_hdr_ack, QETH_SEQ_NO_LENGTH);
-	iob->callback = qeth_release_buffer;
-
 	reply = qeth_alloc_reply(card);
 	if (!reply) {
 		PRINT_WARN("Could no alloc qeth_reply!\n");
@@ -1810,10 +1828,6 @@ qeth_send_control_data(struct qeth_card 
 	init_timer(&timer);
 	timer.function = qeth_cmd_timeout;
 	timer.data = (unsigned long) reply;
-	if (IS_IPA(iob->data))
-		timer.expires = jiffies + QETH_IPA_TIMEOUT;
-	else
-		timer.expires = jiffies + QETH_TIMEOUT;
 	init_waitqueue_head(&reply->wait_q);
 	spin_lock_irqsave(&card->lock, flags);
 	list_add_tail(&reply->list, &card->cmd_waiter_list);
@@ -1821,6 +1835,11 @@ qeth_send_control_data(struct qeth_card 
 	QETH_DBF_HEX(control, 2, iob->data, QETH_DBF_CONTROL_LEN);
 	wait_event(card->wait_q,
 		   atomic_compare_and_swap(0,1,&card->write.irq_pending) == 0);
+	qeth_prepare_control_data(card, len, iob);
+	if (IS_IPA(iob->data))
+		timer.expires = jiffies + QETH_IPA_TIMEOUT;
+	else
+		timer.expires = jiffies + QETH_TIMEOUT;
 	QETH_DBF_TEXT(trace, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
 	rc = ccw_device_start(card->write.ccwdev, &card->write.ccw,
@@ -1848,6 +1867,62 @@ qeth_send_control_data(struct qeth_card 
 }
 
 static int
+qeth_osn_send_control_data(struct qeth_card *card, int len,
+			   struct qeth_cmd_buffer *iob)
+{
+	unsigned long flags;
+	int rc = 0;
+
+	QETH_DBF_TEXT(trace, 5, "osndctrd");
+
+	wait_event(card->wait_q,
+		   atomic_compare_and_swap(0,1,&card->write.irq_pending) == 0);
+	qeth_prepare_control_data(card, len, iob);
+	QETH_DBF_TEXT(trace, 6, "osnoirqp");
+	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
+	rc = ccw_device_start(card->write.ccwdev, &card->write.ccw,
+			      (addr_t) iob, 0, 0);
+	spin_unlock_irqrestore(get_ccwdev_lock(card->write.ccwdev), flags);
+	if (rc){
+		PRINT_WARN("qeth_osn_send_control_data: "
+			   "ccw_device_start rc = %i\n", rc);
+		QETH_DBF_TEXT_(trace, 2, " err%d", rc);
+		qeth_release_buffer(iob->channel, iob);
+		atomic_set(&card->write.irq_pending, 0);
+		wake_up(&card->wait_q);
+	}
+	return rc;
+}					
+
+static inline void
+qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+		     char prot_type)
+{
+	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
+	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data),&prot_type,1);
+	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
+	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
+}
+
+static int
+qeth_osn_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+		      int data_len)
+{
+	u16 s1, s2;
+
+QETH_DBF_TEXT(trace,4,"osndipa");
+
+	qeth_prepare_ipa_cmd(card, iob, QETH_PROT_OSN2);
+	s1 = (u16)(IPA_PDU_HEADER_SIZE + data_len);
+	s2 = (u16)data_len;
+	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
+	return qeth_osn_send_control_data(card, s1, iob);
+}
+							    
+static int
 qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 		  int (*reply_cb)
 		  (struct qeth_card *,struct qeth_reply*, unsigned long),
@@ -1858,17 +1933,14 @@ qeth_send_ipa_cmd(struct qeth_card *card
 
 	QETH_DBF_TEXT(trace,4,"sendipa");
 
-	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
-
 	if (card->options.layer2)
-		prot_type = QETH_PROT_LAYER2;
+		if (card->info.type == QETH_CARD_TYPE_OSN)
+			prot_type = QETH_PROT_OSN2;
+		else
+			prot_type = QETH_PROT_LAYER2;
 	else
 		prot_type = QETH_PROT_TCPIP;
-
-	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data),&prot_type,1);
-	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
-	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
-
+	qeth_prepare_ipa_cmd(card,iob,prot_type);
 	rc = qeth_send_control_data(card, IPA_CMD_LENGTH, iob,
 				    reply_cb, reply_param);
 	return rc;
@@ -2010,7 +2082,10 @@ qeth_ulp_enable(struct qeth_card *card)
 	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) =
 		(__u8) card->info.portno;
 	if (card->options.layer2)
-		prot_type = QETH_PROT_LAYER2;
+		if (card->info.type == QETH_CARD_TYPE_OSN)
+			prot_type = QETH_PROT_OSN2;
+		else
+			prot_type = QETH_PROT_LAYER2;
 	else
 		prot_type = QETH_PROT_TCPIP;
 
@@ -2100,15 +2175,21 @@ qeth_check_for_inbound_error(struct qeth
 }
 
 static inline struct sk_buff *
-qeth_get_skb(unsigned int length)
+qeth_get_skb(unsigned int length, struct qeth_hdr *hdr)
 {
 	struct sk_buff* skb;
+	int add_len;
+
+	add_len = 0;
+	if (hdr->hdr.osn.id == QETH_HEADER_TYPE_OSN)
+		add_len = sizeof(struct qeth_hdr);
 #ifdef CONFIG_QETH_VLAN
-	if ((skb = dev_alloc_skb(length + VLAN_HLEN)))
-		skb_reserve(skb, VLAN_HLEN);
-#else
-	skb = dev_alloc_skb(length);
+	else
+		add_len = VLAN_HLEN;
 #endif
+	skb = dev_alloc_skb(length + add_len);
+	if (skb && add_len)
+		skb_reserve(skb, add_len);
 	return skb;
 }
 
@@ -2138,7 +2219,10 @@ qeth_get_next_skb(struct qeth_card *card
 
 	offset += sizeof(struct qeth_hdr);
 	if (card->options.layer2)
-		skb_len = (*hdr)->hdr.l2.pkt_length;
+		if (card->info.type == QETH_CARD_TYPE_OSN)
+			skb_len = (*hdr)->hdr.osn.pdu_length;
+		else
+			skb_len = (*hdr)->hdr.l2.pkt_length;
 	else
 		skb_len = (*hdr)->hdr.l3.length;
 
@@ -2146,15 +2230,15 @@ qeth_get_next_skb(struct qeth_card *card
 		return NULL;
 	if (card->options.fake_ll){
 		if(card->dev->type == ARPHRD_IEEE802_TR){
-			if (!(skb = qeth_get_skb(skb_len+QETH_FAKE_LL_LEN_TR)))
+			if (!(skb = qeth_get_skb(skb_len+QETH_FAKE_LL_LEN_TR, *hdr)))
 				goto no_mem;
 			skb_reserve(skb,QETH_FAKE_LL_LEN_TR);
 		} else {
-			if (!(skb = qeth_get_skb(skb_len+QETH_FAKE_LL_LEN_ETH)))
+			if (!(skb = qeth_get_skb(skb_len+QETH_FAKE_LL_LEN_ETH, *hdr)))
 				goto no_mem;
 			skb_reserve(skb,QETH_FAKE_LL_LEN_ETH);
 		}
-	} else if (!(skb = qeth_get_skb(skb_len)))
+	} else if (!(skb = qeth_get_skb(skb_len, *hdr)))
 		goto no_mem;
 	data_ptr = element->addr + offset;
 	while (skb_len) {
@@ -2453,8 +2537,12 @@ qeth_process_inbound_buffer(struct qeth_
 		skb->dev = card->dev;
 		if (hdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2)
 			vlan_tag = qeth_layer2_rebuild_skb(card, skb, hdr);
-		else
+		else if (hdr->hdr.l3.id == QETH_HEADER_TYPE_LAYER3)     
 			qeth_rebuild_skb(card, skb, hdr);
+		else { /*in case of OSN*/
+			skb_push(skb, sizeof(struct qeth_hdr));
+			memcpy(skb->data, hdr, sizeof(struct qeth_hdr));
+		}
 		/* is device UP ? */
 		if (!(card->dev->flags & IFF_UP)){
 			dev_kfree_skb_any(skb);
@@ -2465,7 +2553,10 @@ qeth_process_inbound_buffer(struct qeth_
 			vlan_hwaccel_rx(skb, card->vlangrp, vlan_tag);
 		else
 #endif
-		rxrc = netif_rx(skb);
+		if (card->info.type == QETH_CARD_TYPE_OSN)
+			rxrc = card->osn_info.data_cb(skb);
+		else
+			rxrc = netif_rx(skb);
 		card->dev->last_rx = jiffies;
 		card->stats.rx_packets++;
 		card->stats.rx_bytes += skb->len;
@@ -3150,8 +3241,6 @@ qeth_init_qdio_info(struct qeth_card *ca
 	INIT_LIST_HEAD(&card->qdio.in_buf_pool.entry_list);
 	INIT_LIST_HEAD(&card->qdio.init_pool.entry_list);
 	/* outbound */
-	card->qdio.do_prio_queueing = QETH_PRIOQ_DEFAULT;
-	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 }
 
 static int
@@ -3466,7 +3555,7 @@ qeth_mpc_initialize(struct qeth_card *ca
 
 	return 0;
 out_qdio:
-	qeth_qdio_clear_card(card, card->info.type==QETH_CARD_TYPE_OSAE);
+	qeth_qdio_clear_card(card, card->info.type!=QETH_CARD_TYPE_IQD);
 	return rc;
 }
 
@@ -3491,6 +3580,9 @@ qeth_get_netdevice(enum qeth_card_types 
 	case QETH_CARD_TYPE_IQD:
 		dev = alloc_netdev(0, "hsi%d", ether_setup);
 		break;
+	case QETH_CARD_TYPE_OSN:
+		dev = alloc_netdev(0, "osn%d", ether_setup);
+		break;
 	default:
 		dev = alloc_etherdev(0);
 	}
@@ -3655,7 +3747,8 @@ qeth_open(struct net_device *dev)
 	if (card->state != CARD_STATE_SOFTSETUP)
 		return -ENODEV;
 
-	if ( (card->options.layer2) &&
+	if ( (card->info.type != QETH_CARD_TYPE_OSN) &&
+	     (card->options.layer2) &&
 	     (!card->info.layer2_mac_registered)) {
 		QETH_DBF_TEXT(trace,4,"nomacadr");
 		return -EPERM;
@@ -3693,6 +3786,9 @@ qeth_get_cast_type(struct qeth_card *car
 {
 	int cast_type = RTN_UNSPEC;
 
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		return cast_type;
+
 	if (skb->dst && skb->dst->neighbour){
 		cast_type = skb->dst->neighbour->type;
 		if ((cast_type == RTN_BROADCAST) ||
@@ -3782,13 +3878,16 @@ static inline int
 qeth_prepare_skb(struct qeth_card *card, struct sk_buff **skb,
 		 struct qeth_hdr **hdr, int ipv)
 {
-	int rc;
+	int rc = 0;
 #ifdef CONFIG_QETH_VLAN
 	u16 *tag;
 #endif
 
 	QETH_DBF_TEXT(trace, 6, "prepskb");
-
+	if (card->info.type == QETH_CARD_TYPE_OSN) {
+		*hdr = (struct qeth_hdr *)(*skb)->data;
+		return rc;
+	}
         rc = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
         if (rc)
                 return rc;
@@ -4291,8 +4390,14 @@ qeth_send_packet(struct qeth_card *card,
 			}
 		}
 	}
+	if ((card->info.type == QETH_CARD_TYPE_OSN) &&
+		(skb->protocol == htons(ETH_P_IPV6))) {
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
 	cast_type = qeth_get_cast_type(card, skb);
-	if ((cast_type == RTN_BROADCAST) && (card->info.broadcast_capable == 0)){
+	if ((cast_type == RTN_BROADCAST) && 
+	    (card->info.broadcast_capable == 0)){
 		card->stats.tx_dropped++;
 		card->stats.tx_errors++;
 		dev_kfree_skb_any(skb);
@@ -4320,7 +4425,8 @@ qeth_send_packet(struct qeth_card *card,
 			QETH_DBF_TEXT_(trace, 4, "pskbe%d", rc);
 			return rc;
 		}
-		qeth_fill_header(card, hdr, skb, ipv, cast_type);
+		if (card->info.type != QETH_CARD_TYPE_OSN)
+			qeth_fill_header(card, hdr, skb, ipv, cast_type);
 	}
 
 	if (large_send == QETH_LARGE_SEND_EDDP) {
@@ -4381,6 +4487,7 @@ qeth_mdio_read(struct net_device *dev, i
 	case MII_BMCR: /* Basic mode control register */
 		rc = BMCR_FULLDPLX;
 		if ((card->info.link_type != QETH_LINK_TYPE_GBIT_ETH)&&
+		    (card->info.link_type != QETH_LINK_TYPE_OSN) &&
 		    (card->info.link_type != QETH_LINK_TYPE_10GBIT_ETH))
 			rc |= BMCR_SPEED100;
 		break;
@@ -5004,6 +5111,9 @@ qeth_do_ioctl(struct net_device *dev, st
             (card->state != CARD_STATE_SOFTSETUP))
 		return -ENODEV;
 
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		return -EPERM;
+
 	switch (cmd){
 	case SIOC_QETH_ARP_SET_NO_ENTRIES:
 		if ( !capable(CAP_NET_ADMIN) ||
@@ -5329,6 +5439,9 @@ qeth_set_multicast_list(struct net_devic
 {
 	struct qeth_card *card = (struct qeth_card *) dev->priv;
 
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		return ;
+	 
 	QETH_DBF_TEXT(trace,3,"setmulti");
 	qeth_delete_mc_addresses(card);
 	qeth_add_multicast_ipv4(card);
@@ -5370,6 +5483,94 @@ qeth_get_addr_buffer(enum qeth_prot_vers
 	return addr;
 }
 
+int
+qeth_osn_assist(struct net_device *dev,
+		void *data,
+		int data_len)
+{
+	struct qeth_cmd_buffer *iob;
+	struct qeth_card *card;
+	int rc;
+	
+	QETH_DBF_TEXT(trace, 2, "osnsdmc");
+	if (!dev)
+		return -ENODEV;
+	card = (struct qeth_card *)dev->priv;
+	if (!card)
+		return -ENODEV;
+	if ((card->state != CARD_STATE_UP) &&
+	    (card->state != CARD_STATE_SOFTSETUP))
+		return -ENODEV;
+	iob = qeth_wait_for_buffer(&card->write);
+	memcpy(iob->data+IPA_PDU_HEADER_SIZE, data, data_len);
+	rc = qeth_osn_send_ipa_cmd(card, iob, data_len);
+	return rc;
+}
+
+static struct net_device *
+qeth_netdev_by_devno(unsigned char *read_dev_no)
+{
+	struct qeth_card *card;
+	struct net_device *ndev;
+	unsigned char *readno;
+	__u16 temp_dev_no, card_dev_no;
+	char *endp;
+	unsigned long flags;
+
+	ndev = NULL;
+	memcpy(&temp_dev_no, read_dev_no, 2);
+	read_lock_irqsave(&qeth_card_list.rwlock, flags);
+	list_for_each_entry(card, &qeth_card_list.list, list) {
+		readno = CARD_RDEV_ID(card);
+		readno += (strlen(readno) - 4);
+		card_dev_no = simple_strtoul(readno, &endp, 16);
+		if (card_dev_no == temp_dev_no) {
+			ndev = card->dev;
+			break;
+		}
+	}
+	read_unlock_irqrestore(&qeth_card_list.rwlock, flags);
+	return ndev;
+}
+
+int
+qeth_osn_register(unsigned char *read_dev_no,
+		  struct net_device **dev,
+		  int (*assist_cb)(struct net_device *, void *),
+		  int (*data_cb)(struct sk_buff *))
+{
+	struct qeth_card * card;
+
+	QETH_DBF_TEXT(trace, 2, "osnreg");
+	*dev = qeth_netdev_by_devno(read_dev_no);
+	if (*dev == NULL)
+		return -ENODEV;
+	card = (struct qeth_card *)(*dev)->priv;
+	if (!card)
+		return -ENODEV;
+	if ((assist_cb == NULL) || (data_cb == NULL))
+		return -EINVAL;
+	card->osn_info.assist_cb = assist_cb;
+	card->osn_info.data_cb = data_cb;
+	return 0;
+}
+
+void
+qeth_osn_deregister(struct net_device * dev)
+{
+	struct qeth_card *card;
+
+	QETH_DBF_TEXT(trace, 2, "osndereg");
+	if (!dev)
+		return;
+	card = (struct qeth_card *)dev->priv;
+	if (!card)
+		return;
+	card->osn_info.assist_cb = NULL;
+	card->osn_info.data_cb = NULL;
+	return;
+}
+					   
 static void
 qeth_delete_mc_addresses(struct qeth_card *card)
 {
@@ -5700,6 +5901,12 @@ qeth_layer2_set_mac_address(struct net_d
 		QETH_DBF_TEXT(trace, 3, "setmcLY3");
 		return -EOPNOTSUPP;
 	}
+	if (card->info.type == QETH_CARD_TYPE_OSN) {
+		PRINT_WARN("Setting MAC address on %s is not supported.\n",
+			   dev->name);
+		QETH_DBF_TEXT(trace, 3, "setmcOSN");
+		return -EOPNOTSUPP;
+	}
 	QETH_DBF_TEXT_(trace, 3, "%s", CARD_BUS_ID(card));
 	QETH_DBF_HEX(trace, 3, addr->sa_data, OSA_ADDR_LEN);
 	rc = qeth_layer2_send_delmac(card, &card->dev->dev_addr[0]);
@@ -6076,9 +6283,8 @@ qeth_netdev_init(struct net_device *dev)
 			qeth_get_hlen(card->info.link_type) + card->options.add_hhlen;
 	dev->addr_len = OSA_ADDR_LEN;
 	dev->mtu = card->info.initial_mtu;
-
-	SET_ETHTOOL_OPS(dev, &qeth_ethtool_ops);
-
+	if (card->info.type != QETH_CARD_TYPE_OSN)
+		SET_ETHTOOL_OPS(dev, &qeth_ethtool_ops);
 	SET_MODULE_OWNER(dev);
 	return 0;
 }
@@ -6095,6 +6301,7 @@ qeth_init_func_level(struct qeth_card *c
 					QETH_IDX_FUNC_LEVEL_OSAE_ENA_IPAT;
 	} else {
 		if (card->info.type == QETH_CARD_TYPE_IQD)
+		/*FIXME:why do we have same values for  dis and ena for osae??? */
 			card->info.func_level =
 				QETH_IDX_FUNC_LEVEL_IQD_DIS_IPAT;
 		else
@@ -6124,7 +6331,7 @@ retry:
 		ccw_device_set_online(CARD_WDEV(card));
 		ccw_device_set_online(CARD_DDEV(card));
 	}
-	rc = qeth_qdio_clear_card(card,card->info.type==QETH_CARD_TYPE_OSAE);
+	rc = qeth_qdio_clear_card(card,card->info.type!=QETH_CARD_TYPE_IQD);
 	if (rc == -ERESTARTSYS) {
 		QETH_DBF_TEXT(setup, 2, "break1");
 		return rc;
@@ -6176,8 +6383,8 @@ retry:
 	card->dev = qeth_get_netdevice(card->info.type,
 				       card->info.link_type);
 	if (!card->dev){
-		qeth_qdio_clear_card(card, card->info.type ==
-				     QETH_CARD_TYPE_OSAE);
+		qeth_qdio_clear_card(card, card->info.type !=
+				     QETH_CARD_TYPE_IQD);
 		rc = -ENODEV;
 		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
 		goto out;
@@ -7084,6 +7291,8 @@ qeth_softsetup_card(struct qeth_card *ca
 			return rc;
 	} else
 		card->lan_online = 1;
+	if (card->info.type==QETH_CARD_TYPE_OSN)
+		goto out;
 	if (card->options.layer2) {
 		card->dev->features |=
 			NETIF_F_HW_VLAN_FILTER |
@@ -7255,7 +7464,8 @@ qeth_stop_card(struct qeth_card *card, i
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
 	    (card->state == CARD_STATE_UP)) {
-		if(recovery_mode) {
+		if (recovery_mode && 
+		    card->info.type != QETH_CARD_TYPE_OSN) {
 			qeth_stop(card->dev);
 		} else {
 			rtnl_lock();
@@ -7437,7 +7647,8 @@ qeth_start_again(struct qeth_card *card,
 {
 	QETH_DBF_TEXT(setup ,2, "startag");
 
-	if(recovery_mode) {
+	if (recovery_mode && 
+	    card->info.type != QETH_CARD_TYPE_OSN) {
 		qeth_open(card->dev);
 	} else {
 		rtnl_lock();
@@ -7469,33 +7680,36 @@ qeth_start_again(struct qeth_card *card,
 static void qeth_make_parameters_consistent(struct qeth_card *card)
 {
 
-        if (card->options.layer2) {
-                if (card->info.type == QETH_CARD_TYPE_IQD) {
-                        PRINT_ERR("Device %s does not support " \
-                                  "layer 2 functionality. "  \
-                                  "Ignoring layer2 option.\n",CARD_BUS_ID(card));
-                }
-                IGNORE_PARAM_NEQ(route4.type, NO_ROUTER, NO_ROUTER,
-                                 "Routing options are");
+	if (card->options.layer2 == 0)
+		return;
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		return;
+	if (card->info.type == QETH_CARD_TYPE_IQD) {
+       		PRINT_ERR("Device %s does not support layer 2 functionality." \
+	               	  " Ignoring layer2 option.\n",CARD_BUS_ID(card));
+       		card->options.layer2 = 0;
+		return;
+	}
+       	IGNORE_PARAM_NEQ(route4.type, NO_ROUTER, NO_ROUTER,
+               	         "Routing options are");
 #ifdef CONFIG_QETH_IPV6
-                IGNORE_PARAM_NEQ(route6.type, NO_ROUTER, NO_ROUTER,
-                                 "Routing options are");
+       	IGNORE_PARAM_NEQ(route6.type, NO_ROUTER, NO_ROUTER,
+               	         "Routing options are");
 #endif
-                IGNORE_PARAM_EQ(checksum_type, HW_CHECKSUMMING,
-                                QETH_CHECKSUM_DEFAULT,
-                                "Checksumming options are");
-                IGNORE_PARAM_NEQ(broadcast_mode, QETH_TR_BROADCAST_ALLRINGS,
-                                 QETH_TR_BROADCAST_ALLRINGS,
-                                 "Broadcast mode options are");
-                IGNORE_PARAM_NEQ(macaddr_mode, QETH_TR_MACADDR_NONCANONICAL,
-                                 QETH_TR_MACADDR_NONCANONICAL,
-                                 "Canonical MAC addr options are");
-                IGNORE_PARAM_NEQ(fake_broadcast, 0, 0,
-				 "Broadcast faking options are");
-                IGNORE_PARAM_NEQ(add_hhlen, DEFAULT_ADD_HHLEN,
-                                 DEFAULT_ADD_HHLEN,"Option add_hhlen is");
-                IGNORE_PARAM_NEQ(fake_ll, 0, 0,"Option fake_ll is");
-        }
+       	IGNORE_PARAM_EQ(checksum_type, HW_CHECKSUMMING,
+                       	QETH_CHECKSUM_DEFAULT,
+               	        "Checksumming options are");
+       	IGNORE_PARAM_NEQ(broadcast_mode, QETH_TR_BROADCAST_ALLRINGS,
+                       	 QETH_TR_BROADCAST_ALLRINGS,
+               	         "Broadcast mode options are");
+       	IGNORE_PARAM_NEQ(macaddr_mode, QETH_TR_MACADDR_NONCANONICAL,
+                       	 QETH_TR_MACADDR_NONCANONICAL,
+               	         "Canonical MAC addr options are");
+       	IGNORE_PARAM_NEQ(fake_broadcast, 0, 0,
+			 "Broadcast faking options are");
+       	IGNORE_PARAM_NEQ(add_hhlen, DEFAULT_ADD_HHLEN,
+       	                 DEFAULT_ADD_HHLEN,"Option add_hhlen is");
+        IGNORE_PARAM_NEQ(fake_ll, 0, 0,"Option fake_ll is");
 }
 
 
@@ -7525,8 +7739,7 @@ __qeth_set_online(struct ccwgroup_device
 		return -EIO;
 	}
 
-	if (card->options.layer2)
-		qeth_make_parameters_consistent(card);
+	qeth_make_parameters_consistent(card);
 
 	if ((rc = qeth_hardsetup_card(card))){
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
@@ -7585,6 +7798,7 @@ qeth_set_online(struct ccwgroup_device *
 static struct ccw_device_id qeth_ids[] = {
 	{CCW_DEVICE(0x1731, 0x01), driver_info:QETH_CARD_TYPE_OSAE},
 	{CCW_DEVICE(0x1731, 0x05), driver_info:QETH_CARD_TYPE_IQD},
+	{CCW_DEVICE(0x1731, 0x06), driver_info:QETH_CARD_TYPE_OSN},
 	{},
 };
 MODULE_DEVICE_TABLE(ccw, qeth_ids);
@@ -8329,6 +8543,9 @@ again:
 	printk("qeth: removed\n");
 }
 
+EXPORT_SYMBOL(qeth_osn_register);
+EXPORT_SYMBOL(qeth_osn_deregister);
+EXPORT_SYMBOL(qeth_osn_assist);
 module_init(qeth_init);
 module_exit(qeth_exit);
 MODULE_AUTHOR("Frank Pavlic <pavlic@de.ibm.com>");
diff -Naupr linux-orig/drivers/s390/net/qeth_mpc.c linux-patched/drivers/s390/net/qeth_mpc.c
--- linux-orig/drivers/s390/net/qeth_mpc.c	2005-09-29 16:10:16.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth_mpc.c	2005-09-29 16:48:42.000000000 +0200
@@ -11,7 +11,7 @@
 #include <asm/cio.h>
 #include "qeth_mpc.h"
 
-const char *VERSION_QETH_MPC_C = "$Revision: 1.11 $";
+const char *VERSION_QETH_MPC_C = "$Revision: 1.12 $";
 
 unsigned char IDX_ACTIVATE_READ[]={
 	0x00,0x00,0x80,0x00, 0x00,0x00,0x00,0x00,
@@ -138,7 +138,9 @@ unsigned char IPA_PDU_HEADER[]={
 		sizeof(struct qeth_ipa_cmd)%256,
 	0x00,
 		sizeof(struct qeth_ipa_cmd)/256,
-		sizeof(struct qeth_ipa_cmd),0x05, 0x77,0x77,0x77,0x77,
+		sizeof(struct qeth_ipa_cmd)%256,
+	0x05,
+	0x77,0x77,0x77,0x77,
 	0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,
 	0x01,0x00,
 		sizeof(struct qeth_ipa_cmd)/256,
diff -Naupr linux-orig/drivers/s390/net/qeth_mpc.h linux-patched/drivers/s390/net/qeth_mpc.h
--- linux-orig/drivers/s390/net/qeth_mpc.h	2005-09-29 16:10:16.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth_mpc.h	2005-09-29 16:48:42.000000000 +0200
@@ -46,13 +46,16 @@ extern unsigned char IPA_PDU_HEADER[];
 /* IP Assist related definitions                                             */
 /*****************************************************************************/
 #define IPA_CMD_INITIATOR_HOST  0x00
-#define IPA_CMD_INITIATOR_HYDRA 0x01
+#define IPA_CMD_INITIATOR_OSA   0x01
+#define IPA_CMD_INITIATOR_HOST_REPLY  0x80
+#define IPA_CMD_INITIATOR_OSA_REPLY   0x81
 #define IPA_CMD_PRIM_VERSION_NO 0x01
 
 enum qeth_card_types {
 	QETH_CARD_TYPE_UNKNOWN = 0,
 	QETH_CARD_TYPE_OSAE    = 10,
 	QETH_CARD_TYPE_IQD     = 1234,
+	QETH_CARD_TYPE_OSN     = 11,
 };
 
 #define QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE 0x18
@@ -61,6 +64,7 @@ enum qeth_link_types {
 	QETH_LINK_TYPE_FAST_ETH     = 0x01,
 	QETH_LINK_TYPE_HSTR         = 0x02,
 	QETH_LINK_TYPE_GBIT_ETH     = 0x03,
+	QETH_LINK_TYPE_OSN          = 0x04,
 	QETH_LINK_TYPE_10GBIT_ETH   = 0x10,
 	QETH_LINK_TYPE_LANE_ETH100  = 0x81,
 	QETH_LINK_TYPE_LANE_TR      = 0x82,
@@ -111,6 +115,9 @@ enum qeth_ipa_cmds {
 	IPA_CMD_DELGMAC 	      = 0x24,
 	IPA_CMD_SETVLAN 	      = 0x25,
 	IPA_CMD_DELVLAN 	      = 0x26,
+	IPA_CMD_SETCCID               = 0x41,
+	IPA_CMD_DELCCID               = 0x42,
+	IPA_CMD_MODCCID               = 0x43,
 	IPA_CMD_SETIP                 = 0xb1,
 	IPA_CMD_DELIP                 = 0xb7,
 	IPA_CMD_QIPASSIST             = 0xb2,
@@ -437,8 +444,9 @@ enum qeth_ipa_arp_return_codes {
 #define QETH_ARP_DATA_SIZE 3968
 #define QETH_ARP_CMD_LEN (QETH_ARP_DATA_SIZE + 8)
 /* Helper functions */
-#define IS_IPA_REPLY(cmd) (cmd->hdr.initiator == IPA_CMD_INITIATOR_HOST)
-
+#define IS_IPA_REPLY(cmd) ((cmd->hdr.initiator == IPA_CMD_INITIATOR_HOST) || \
+			   (cmd->hdr.initiator == IPA_CMD_INITIATOR_OSA_REPLY))
+	
 /*****************************************************************************/
 /* END OF   IP Assist related definitions                                    */
 /*****************************************************************************/
@@ -483,6 +491,7 @@ extern unsigned char ULP_ENABLE[];
 /* Layer 2 defintions */
 #define QETH_PROT_LAYER2 0x08
 #define QETH_PROT_TCPIP  0x03
+#define QETH_PROT_OSN2   0x0a     
 #define QETH_ULP_ENABLE_PROT_TYPE(buffer) (buffer+0x50)
 #define QETH_IPA_CMD_PROT_TYPE(buffer) (buffer+0x19)
 
diff -Naupr linux-orig/drivers/s390/net/qeth_sys.c linux-patched/drivers/s390/net/qeth_sys.c
--- linux-orig/drivers/s390/net/qeth_sys.c	2005-09-29 16:10:16.000000000 +0200
+++ linux-patched/drivers/s390/net/qeth_sys.c	2005-09-29 16:48:42.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.54 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.55 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.54 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.55 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -937,6 +937,19 @@ static struct attribute_group qeth_devic
 	.attrs = (struct attribute **)qeth_device_attrs,
 };
 
+static struct device_attribute * qeth_osn_device_attrs[] = {
+	&dev_attr_state,
+	&dev_attr_chpid,
+	&dev_attr_if_name,
+	&dev_attr_card_type,
+	&dev_attr_buffer_count,
+	&dev_attr_recover,
+	NULL,
+};
+
+static struct attribute_group qeth_osn_device_attr_group = {
+	.attrs = (struct attribute **)qeth_osn_device_attrs,
+};
 
 #define QETH_DEVICE_ATTR(_id,_name,_mode,_show,_store)			     \
 struct device_attribute dev_attr_##_id = {				     \
@@ -1667,7 +1680,12 @@ int
 qeth_create_device_attributes(struct device *dev)
 {
 	int ret;
+	struct qeth_card *card = dev->driver_data;
 
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		return sysfs_create_group(&dev->kobj,
+					  &qeth_osn_device_attr_group);
+   	
 	if ((ret = sysfs_create_group(&dev->kobj, &qeth_device_attr_group)))
 		return ret;
 	if ((ret = sysfs_create_group(&dev->kobj, &qeth_device_ipato_group))){
@@ -1693,6 +1711,12 @@ qeth_create_device_attributes(struct dev
 void
 qeth_remove_device_attributes(struct device *dev)
 {
+	struct qeth_card *card = dev->driver_data;
+
+	if (card->info.type == QETH_CARD_TYPE_OSN)
+		return sysfs_remove_group(&dev->kobj,
+					  &qeth_osn_device_attr_group);
+		      
 	sysfs_remove_group(&dev->kobj, &qeth_device_attr_group);
 	sysfs_remove_group(&dev->kobj, &qeth_device_ipato_group);
 	sysfs_remove_group(&dev->kobj, &qeth_device_vipa_group);
