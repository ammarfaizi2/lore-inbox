Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTIYRs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTIYRfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:35:54 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:24012 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261168AbTIYRWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:22:41 -0400
Date: Thu, 25 Sep 2003 19:21:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (16/19): qeth driver.
Message-ID: <20030925172155.GQ2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Create symlinks between netdev and groupdev.
 - Remove initialization of device.name.
 - Call qeth_free_card on removal.
 - Remove async hsi.
 - Remove contig memusage.
 - Add check for -EFAULT to copy_from_user/copy_to_user.
 - Inlining some functions to save kernel stack space.
 - vlan header fixes.
 - Replace atomic_return_sub with atomic_add_return.

diffstat:
 drivers/s390/net/qeth.c |  534 +++++++++++++++++-------------------------------
 drivers/s390/net/qeth.h |   47 ----
 2 files changed, 195 insertions(+), 386 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Thu Sep 25 18:33:27 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Thu Sep 25 18:33:33 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.126 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.154 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -106,13 +106,12 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 
-#include <linux/version.h>
-
 #include <asm/io.h>
 #include <asm/ebcdic.h>
 #include <linux/ctype.h>
@@ -160,12 +159,12 @@
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 static int qeth_sparebufs = 0;
-MODULE_PARM(qeth_sparebufs, "i");
+module_param(qeth_sparebufs, int, 0);
 MODULE_PARM_DESC(qeth_sparebufs, "the number of pre-allocated spare buffers "
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.126 $"
+#define VERSION_QETH_C "$Revision: 1.154 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -218,9 +217,9 @@
 /* thought I could get along without forward declarations...
  * just lazyness here */
 static int qeth_reinit_thread(void *);
-static void qeth_schedule_recovery(struct qeth_card *card);
+static inline void qeth_schedule_recovery(struct qeth_card *card);
 
-inline static int
+static inline int
 QETH_IP_VERSION(struct sk_buff *skb)
 {
 	switch (skb->protocol) {
@@ -648,10 +647,6 @@
 	case 1:
 		return 0;
 	case 4:
-		if ((card->can_do_async_iqd) &&
-		    (card->options.async_iqd == ASYNC_IQD)) {
-			return card->no_queues - 1;
-		}
 		if (card->is_multicast_different) {
 			if (multicast) {
 				return card->is_multicast_different &
@@ -706,11 +701,7 @@
 	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
 
 	atomic_set(&card->data_has_arrived, 1);
-	spin_lock(&card->wait_q_lock);
-	if (atomic_read(&card->wait_q_active)) {
-		wake_up(&card->wait_q);
-	}
-	spin_unlock(&card->wait_q_lock);
+	wake_up(&card->wait_q);
 }
 
 static int
@@ -1273,9 +1264,6 @@
 			goto nomem;
 	}
 
-	if (card->easy_copy_cap)
-		memcpy(skb_put(skb, length), data_ptr, length);
-
 	QETH_DBF_HEX6(0, trace, &data_ptr, sizeof (void *));
 	QETH_DBF_HEX6(0, trace, &skb, sizeof (void *));
 
@@ -1302,8 +1290,7 @@
 			dev_kfree_skb_irq(skb);
 			return NULL;
 		}
-		if (!card->easy_copy_cap)
-			memcpy(skb_put(skb, step), data_ptr, step);
+		memcpy(skb_put(skb, step), data_ptr, step);
 		len_togo -= step;
 		if (len_togo) {
 			pos_in_el = 0;
@@ -1603,11 +1590,14 @@
 #ifdef QETH_VLAN
 	struct qeth_card *card;
 
-	/* before we're going to overwrite this location with next hop ip */
+	/* 
+	 * before we're going to overwrite this location with next hop ip.
+	 * v6 uses passthrough, v4 sets the tag in the QDIO header.
+	 */
 	card = (struct qeth_card *) skb->dev->priv;
-	if ((card->vlangrp != NULL) &&
-	    vlan_tx_tag_present(skb) && (version == 4)) {
-		hdr->ext_flags = QETH_EXT_HEADER_VLAN_FRAME;
+	if ((card->vlangrp != NULL) && vlan_tx_tag_present(skb)) {
+		hdr->ext_flags = (version == 4) ? QETH_EXT_HEADER_VLAN_FRAME :
+			QETH_EXT_HEADER_INCLUDE_VLAN_TAG;
 		hdr->vlan_id = vlan_tx_tag_get(skb);
 	}
 #endif
@@ -1684,7 +1674,9 @@
 			    skb->dev->broadcast, 6)) {   /* broadcast? */
 			hdr->flags = QETH_CAST_BROADCAST | QETH_HEADER_PASSTHRU;
 		} else {
-			hdr->flags = QETH_CAST_UNICAST | QETH_HEADER_PASSTHRU;
+ 			hdr->flags = (multicast == RTN_MULTICAST) ?
+ 				QETH_CAST_MULTICAST | QETH_HEADER_PASSTHRU :
+ 				QETH_CAST_UNICAST | QETH_HEADER_PASSTHRU;
 		}
 	}
 	sprintf(dbf_text, "filhdr%2x", version);
@@ -2356,14 +2348,6 @@
 		}
 }
 
-static __inline__ int
-atomic_return_sub(int i, atomic_t * v)
-{
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "sr");
-	return old_val;
-}
-
 static inline void
 __qeth_dump_packet_info(struct qeth_card *card, int version, int multicast,
 			int queue)
@@ -2580,50 +2564,21 @@
 static int
 qeth_sleepon(struct qeth_card *card, int timeout)
 {
-	unsigned long flags;
-	unsigned long start;
-	int retval;
 	char dbf_text[15];
 
-	DECLARE_WAITQUEUE(current_wait_q, current);
-
 	QETH_DBF_TEXT5(0, trace, "slpn");
 	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
 	sprintf(dbf_text, "%08x", timeout);
 	QETH_DBF_TEXT5(0, trace, dbf_text);
 
-	add_wait_queue(&card->wait_q, &current_wait_q);
-	atomic_set(&card->wait_q_active, 1);
-	start = qeth_get_millis();
-	for (;;) {
-		set_task_state(current, TASK_INTERRUPTIBLE);
-		if (atomic_read(&card->data_has_arrived)) {
-			atomic_set(&card->data_has_arrived, 0);
-			retval = 0;
-			goto out;
-		}
-		if (qeth_get_millis() - start > timeout) {
-			retval = -ETIME;
-			goto out;
-		}
-		schedule_timeout(((start + timeout -
-				   qeth_get_millis()) >> 10) * HZ);
-	}
-out:
-	spin_lock_irqsave(&card->wait_q_lock, flags);
-	atomic_set(&card->wait_q_active, 0);
-	spin_unlock_irqrestore(&card->wait_q_lock, flags);
-
-	/* we've got to check once again to close the window */
+	wait_event_interruptible_timeout(card->wait_q,
+					 atomic_read(&card->data_has_arrived),
+					 timeout * HZ);
 	if (atomic_read(&card->data_has_arrived)) {
 		atomic_set(&card->data_has_arrived, 0);
-		retval = 0;
+		return 0;
 	}
-
-	set_task_state(current, TASK_RUNNING);
-	remove_wait_queue(&card->wait_q, &current_wait_q);
-
-	return retval;
+	return -ETIME;
 }
 
 static void
@@ -2634,60 +2589,28 @@
 	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
 
 	atomic_set(&card->ioctl_data_has_arrived, 1);
-	spin_lock(&card->ioctl_wait_q_lock);
-	if (atomic_read(&card->ioctl_wait_q_active)) {
-		wake_up(&card->ioctl_wait_q);
-	}
-	spin_unlock(&card->ioctl_wait_q_lock);
+	wake_up(&card->ioctl_wait_q);
 }
 
 static int
 qeth_sleepon_ioctl(struct qeth_card *card, int timeout)
 {
-	unsigned long flags;
-	unsigned long start;
-	int retval;
 	char dbf_text[15];
 
-	DECLARE_WAITQUEUE(current_wait_q, current);
-
 	QETH_DBF_TEXT5(0, trace, "ioctlslpn");
 	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
 	sprintf(dbf_text, "%08x", timeout);
 	QETH_DBF_TEXT5(0, trace, dbf_text);
 
-	add_wait_queue(&card->ioctl_wait_q, &current_wait_q);
-	atomic_set(&card->ioctl_wait_q_active, 1);
-	start = qeth_get_millis();
-	for (;;) {
-		set_task_state(current, TASK_INTERRUPTIBLE);
-		if (atomic_read(&card->ioctl_data_has_arrived)) {
-			atomic_set(&card->ioctl_data_has_arrived, 0);
-			retval = 0;
-			goto out;
-		}
-		if (qeth_get_millis() - start > timeout) {
-			retval = -ETIME;
-			goto out;
-		}
-		schedule_timeout(((start + timeout -
-				   qeth_get_millis()) >> 10) * HZ);
-	}
-out:
-	spin_lock_irqsave(&card->ioctl_wait_q_lock, flags);
-	atomic_set(&card->ioctl_wait_q_active, 0);
-	spin_unlock_irqrestore(&card->ioctl_wait_q_lock, flags);
-
-	/* we've got to check once again to close the window */
+	wait_event_interruptible_timeout(card->ioctl_wait_q,
+					 atomic_read(&card->
+						     ioctl_data_has_arrived),
+					 timeout * HZ);
 	if (atomic_read(&card->ioctl_data_has_arrived)) {
 		atomic_set(&card->ioctl_data_has_arrived, 0);
-		retval = 0;
+		return 0;
 	}
-
-	set_task_state(current, TASK_RUNNING);
-	remove_wait_queue(&card->ioctl_wait_q, &current_wait_q);
-
-	return retval;
+	return -ETIME;
 }
 
 /*SNMP IOCTL on Procfile */
@@ -3227,8 +3150,9 @@
 		result = IPA_REPLY_SUCCESS;
 		memcpy(((char *) (card->ioctl_data_buffer)) + sizeof (__u16),
 		       &(card->number_of_entries), sizeof (int));
-		copy_to_user(req->ifr_ifru.ifru_data,
-			     card->ioctl_data_buffer, data_size);
+		if (copy_to_user(req->ifr_ifru.ifru_data,
+			     	card->ioctl_data_buffer, data_size))
+				result = -EFAULT;
 	}
 	card->ioctl_buffer_pointer = NULL;
 	vfree(card->ioctl_data_buffer);
@@ -3296,13 +3220,17 @@
 		goto snmp_out;
 	}
 	if (result == ARP_RETURNCODE_ERROR) {
-		copy_to_user(req->ifr_ifru.ifru_data + SNMP_REQUEST_DATA_OFFSET,
-			     card->ioctl_data_buffer, card->ioctl_buffersize);
 		result = IPA_REPLY_FAILED;
+		if (copy_to_user(req->ifr_ifru.ifru_data + 
+			     SNMP_REQUEST_DATA_OFFSET, card->ioctl_data_buffer,
+			     card->ioctl_buffersize))
+			result = -EFAULT;
 	} else {
-		copy_to_user(req->ifr_ifru.ifru_data + SNMP_REQUEST_DATA_OFFSET,
-			     card->ioctl_data_buffer, card->ioctl_buffersize);
 		result = IPA_REPLY_SUCCESS;
+		if (copy_to_user(req->ifr_ifru.ifru_data +
+				 SNMP_REQUEST_DATA_OFFSET, card->ioctl_data_buffer,
+				 card->ioctl_buffersize))
+			result = -EFAULT;
 	}
 snmp_out:
 	card->number_of_entries = 0;
@@ -4387,7 +4315,8 @@
 
 #define QETH_STANDARD_RETVALS \
 		ret_val=-EIO; \
-		if (result==IPA_REPLY_SUCCESS) ret_val=0; \
+		if (result == -EFAULT) ret_val = -EFAULT; \
+                if (result==IPA_REPLY_SUCCESS) ret_val=0; \
 		if (result==IPA_REPLY_FAILED) ret_val=-EIO; \
 		if (result==IPA_REPLY_OPNOTSUPP) ret_val=-EOPNOTSUPP
 
@@ -4413,7 +4342,8 @@
 
 	if ((cmd < SIOCDEVPRIVATE) || (cmd > SIOCDEVPRIVATE + 5))
 		return -EOPNOTSUPP;
-	copy_from_user(buff, rq->ifr_ifru.ifru_data, sizeof (buff));
+	if (copy_from_user(buff, rq->ifr_ifru.ifru_data, sizeof (buff)))
+		return -EFAULT;
 	data = buff;
 
 	if ((!atomic_read(&card->is_registered)) ||
@@ -5957,7 +5887,7 @@
 	}
 }
 
-static void
+static inline void
 qeth_schedule_recovery(struct qeth_card *card)
 {
 	if (card) {
@@ -6172,8 +6102,9 @@
 		}
 	}
 
-	buffers_used = atomic_return_sub(count,
-					 &card->outbound_used_buffers[queue]);
+	buffers_used = atomic_add_return(-count,
+					 &card->outbound_used_buffers[queue])
+		       + count;
 
 	switch (card->send_state[queue]) {
 	case SEND_STATE_PACK:
@@ -6205,7 +6136,7 @@
 		PRINT_WARN("timeout on device %s\n", cdev->dev.bus_id);
 		break;
 	default:
-		PRINT_WARN("unknown error %d on device %s\n", PTR_ERR(irb),
+		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
 			   cdev->dev.bus_id);
 	}
 	return PTR_ERR(irb);
@@ -6504,7 +6435,7 @@
 		QETH_DBF_HEX0(0, sense, irb, QETH_DBF_SENSE_LEN);
 	}
 
-	if ((rqparam == READ_CONF_DATA_STATE) || (rqparam == NOP_STATE)) {
+	if (rqparam == NOP_STATE) {
 		qeth_wakeup(card);
 		return;
 	}
@@ -6645,18 +6576,17 @@
 }
 
 static void
-qeth_free_card(struct qeth_card *card)
+qeth_free_card_stuff(struct qeth_card *card)
 {
 	int i, j;
-	int element_count;
 	struct qeth_vipa_entry *e, *e2;
 
 	if (!card)
 		return;
 
-	QETH_DBF_TEXT3(0, trace, "free");
+	QETH_DBF_TEXT3(0, trace, "freest");
 	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT1(0, setup, "free");
+	QETH_DBF_TEXT1(0, setup, "freest");
 	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
 
 	write_lock(&card->vipa_list_lock);
@@ -6668,10 +6598,8 @@
 	}
 	write_unlock(&card->vipa_list_lock);
 
-	element_count = (card->options.memusage == MEMUSAGE_DISCONTIG) ?
-	    BUFFER_MAX_ELEMENTS : 1;
 	for (i = 0; i < card->options.inbound_buffer_count; i++) {
-		for (j = 0; j < element_count; j++) {
+		for (j = 0; j < BUFFER_MAX_ELEMENTS; j++) {
 			if (card->inbound_buffer_pool_entry[i][j]) {
 				kfree(card->inbound_buffer_pool_entry[i][j]);
 				card->inbound_buffer_pool_entry[i][j] = NULL;
@@ -6687,7 +6615,22 @@
 	if (card->dma_stuff)
 		kfree(card->dma_stuff);
 	if (card->dev)
-		kfree(card->dev);
+		free_netdev(card->dev);
+
+}
+
+static void
+qeth_free_card(struct qeth_card *card)
+{
+
+	if (!card)
+		return;
+
+	QETH_DBF_TEXT3(0, trace, "free");
+	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_TEXT1(0, setup, "free");
+	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
+
 	vfree(card);		/* we checked against NULL already */
 }
 
@@ -6816,6 +6759,10 @@
 						   hard_start_xmit */
 
 	if (atomic_read(&card->is_registered)) {
+		/* Remove sysfs symlinks. */
+		sysfs_remove_link(&card->gdev->dev.kobj, card->dev_name);
+		sysfs_remove_link(&card->dev->class_dev.kobj,
+				  card->gdev->dev.bus_id);
 		QETH_DBF_TEXT2(0, trace, "unregdev");
 		qeth_unregister_netdev(card);
 		qeth_wait_nonbusy(QETH_REMOVE_WAIT_TIME);
@@ -6903,6 +6850,8 @@
 }
 
 /* returns last four digits of bus_id */
+/* FIXME: device driver shouldn't be aware of bus_id format - but don't know
+   what else to use... (CH) */
 static inline __u16
 __raw_devno_from_bus_id(char *id)
 {
@@ -7029,6 +6978,12 @@
 	    ((!QETH_IDX_NO_PORTNAME_REQUIRED(card->dma_stuff->recbuf)) &&
 	     (card->type == QETH_CARD_TYPE_OSAE));;
 
+	/*
+	 * however, as the portname indication of OSA is wrong, we have to
+	 * do this:
+	 */
+	card->portname_required = (card->type == QETH_CARD_TYPE_OSAE);
+
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->recbuf), 2);
 	if (temp != qeth_peer_func_level(card->func_level)) {
 		QETH_DBF_TEXT1(0, trace, "IRFL");
@@ -7076,14 +7031,14 @@
 	memcpy(QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->sendbuf),
 	       &card->func_level, 2);
 
-	temp = _ccw_device_get_device_number(card->ddev);
+	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
 	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(card->dma_stuff->sendbuf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(card->dma_stuff->sendbuf),
 	       &temp, 2);
 
 	QETH_DBF_TEXT2(0, trace, "iaww");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, trace, card->wdev->dev.bus_id);
 	QETH_DBF_HEX2(0, control, card->dma_stuff->sendbuf,
 		      QETH_DBF_CONTROL_LEN);
 
@@ -7112,7 +7067,7 @@
 
 	if (qeth_sleepon(card, QETH_MPC_TIMEOUT)) {
 		QETH_DBF_TEXT1(0, trace, "IWWT");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
 		PRINT_ERR("IDX_ACTIVATE(wr) on write channel device %s: "
 			  "timeout\n", card->wdev->dev.bus_id);
 		return -EIO;
@@ -7153,19 +7108,19 @@
 
 	if (qeth_sleepon(card, QETH_MPC_TIMEOUT)) {
 		QETH_DBF_TEXT1(0, trace, "IWRT");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
 		PRINT_ERR("IDX_ACTIVATE(rd) on write channel device %s: "
 			  "timeout\n", card->wdev->dev.bus_id);
 		return -EIO;
 	}
 	QETH_DBF_TEXT2(0, trace, "iawr");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, trace, card->wdev->dev.bus_id);
 	QETH_DBF_HEX2(0, control, card->dma_stuff->recbuf,
 		      QETH_DBF_CONTROL_LEN);
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(card->dma_stuff->recbuf))) {
 		QETH_DBF_TEXT1(0, trace, "IWNR");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
 		PRINT_ERR("IDX_ACTIVATE on write channel device %s: negative "
 			  "reply\n", card->wdev->dev.bus_id);
 		return -EIO;
@@ -7174,7 +7129,7 @@
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->recbuf), 2);
 	if ((temp & ~0x0100) != qeth_peer_func_level(card->func_level)) {
 		QETH_DBF_TEXT1(0, trace, "IWFM");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
 		sprintf(dbf_text, "%4x%4x", card->func_level, temp);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
 		PRINT_WARN("IDX_ACTIVATE on write channel device %s: function "
@@ -7345,7 +7300,7 @@
 	memcpy(QETH_ULP_SETUP_FILTER_TOKEN(card->send_buf),
 	       &card->token.ulp_filter_r, QETH_MPC_TOKEN_LENGTH);
 
-	temp = _ccw_device_get_device_number(card->ddev);
+	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
 	memcpy(QETH_ULP_SETUP_CUA(card->send_buf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_ULP_SETUP_REAL_DEVADDR(card->send_buf), &temp, 2);
@@ -8224,11 +8179,6 @@
 
 		card->dev->init = qeth_init_dev;
 
-		if (card->options.memusage == MEMUSAGE_CONTIG) {
-			card->easy_copy_cap =
-			    qeth_determine_easy_copy_cap(card->type);
-		} else
-			card->easy_copy_cap = 0;
 		card->ipa_timeout = qeth_get_ipa_timeout(card->type);
 	}
 
@@ -8492,30 +8442,21 @@
 	card->options.default_queue = QETH_DEFAULT_QUEUE;
 	card->options.inbound_buffer_count = DEFAULT_BUFFER_COUNT;
 	card->options.polltime = QETH_MAX_INPUT_THRESHOLD;
-	card->options.memusage = MEMUSAGE_DISCONTIG;
 	card->options.macaddr_mode = MACADDR_NONCANONICAL;
 	card->options.broadcast_mode = BROADCAST_ALLRINGS;
 	card->options.fake_broadcast = DONT_FAKE_BROADCAST;
 	card->options.ena_ipat = ENABLE_TAKEOVER;
 	card->options.add_hhlen = DEFAULT_ADD_HHLEN;
 	card->options.fake_ll = DONT_FAKE_LL;
-	card->options.async_iqd = SYNC_IQD;
 }
 
-static struct qeth_card *
-qeth_alloc_card(void)
+static int
+qeth_alloc_card_stuff(struct qeth_card *card)
 {
-	struct qeth_card *card;
-
-	QETH_DBF_TEXT3(0, trace, "alloccrd");
-	card = (struct qeth_card *) vmalloc(sizeof (struct qeth_card));
 	if (!card)
-		goto exit_card;
-	memset(card, 0, sizeof (struct qeth_card));
-	init_waitqueue_head(&card->wait_q);
-	init_waitqueue_head(&card->ioctl_wait_q);
+		return -EINVAL;
 
-	qeth_fill_qeth_card_options(card);
+	QETH_DBF_TEXT3(0, trace, "alccrdst");
 
 	card->dma_stuff =
 	    (struct qeth_dma_stuff *) kmalloc(sizeof (struct qeth_dma_stuff),
@@ -8549,7 +8490,42 @@
 		goto exit_stats;
 	memset(card->stats, 0, sizeof (struct net_device_stats));
 
-	spin_lock_init(&card->wait_q_lock);
+	/* setup net_device stuff */
+	card->dev->priv = card;
+
+	/* setup net_device_stats stuff */
+	/* =nothing yet */
+
+	return 0;
+
+	/* these are quick exits in case of failures of the kmallocs */
+exit_stats:
+	free_netdev(card->dev);
+exit_dev:
+	kfree(card->dma_stuff->sendbuf);
+exit_dma2:
+	kfree(card->dma_stuff->recbuf);
+exit_dma1:
+	kfree(card->dma_stuff);
+exit_dma:
+	return -ENOMEM;
+}
+
+static struct qeth_card *
+qeth_alloc_card(void)
+{
+	struct qeth_card *card;
+
+	QETH_DBF_TEXT3(0, trace, "alloccrd");
+	card = (struct qeth_card *) vmalloc(sizeof (struct qeth_card));
+	if (!card)
+		return NULL;
+	memset(card, 0, sizeof (struct qeth_card));
+	init_waitqueue_head(&card->wait_q);
+	init_waitqueue_head(&card->ioctl_wait_q);
+
+	qeth_fill_qeth_card_options(card);
+
 	spin_lock_init(&card->softsetup_lock);
 	spin_lock_init(&card->hardsetup_lock);
 	spin_lock_init(&card->ioctl_lock);
@@ -8576,30 +8552,9 @@
 
 	card->csum_enable_mask = IPA_CHECKSUM_DEFAULT_ENABLE_MASK;
 
-	/* setup net_device stuff */
-	card->dev->priv = card;
-
-	strncpy(card->dev->name, card->dev_name, IFNAMSIZ);
-
-	/* setup net_device_stats stuff */
-	/* =nothing yet */
-
 	/* and return to the sender */
 	return card;
 
-	/* these are quick exits in case of failures of the kmallocs */
-exit_stats:
-	kfree(card->dev);
-exit_dev:
-	kfree(card->dma_stuff->sendbuf);
-exit_dma2:
-	kfree(card->dma_stuff->recbuf);
-exit_dma1:
-	kfree(card->dma_stuff);
-exit_dma:
-	kfree(card);
-exit_card:
-	return NULL;
 }
 
 static int
@@ -8634,66 +8589,41 @@
 qeth_init_ringbuffers2(struct qeth_card *card)
 {
 	int i, j;
-	int failed = 0;
-	int discont_mem, element_count;
-	long alloc_size;
 
 	QETH_DBF_TEXT3(0, trace, "irb2");
 	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
 
-	discont_mem = (card->options.memusage == MEMUSAGE_DISCONTIG);
-	element_count = (discont_mem) ? BUFFER_MAX_ELEMENTS : 1;
-	alloc_size = (discont_mem) ? PAGE_SIZE : BUFFER_SIZE;
-	if (discont_mem) {
-		for (i = 0; i < card->options.inbound_buffer_count; i++) {
-			for (j = 0; j < element_count; j++) {
-				card->inbound_buffer_pool_entry[i][j] =
-				    kmalloc(alloc_size, GFP_KERNEL);
-				if (!card->inbound_buffer_pool_entry[i][j]) {
-					failed = 1;
-					goto out;
-				}
+	for (i = 0; i < card->options.inbound_buffer_count; i++) {
+		for (j = 0; j < BUFFER_MAX_ELEMENTS; j++) {
+			card->inbound_buffer_pool_entry[i][j] =
+				kmalloc(PAGE_SIZE, GFP_KERNEL);
+			if (!card->inbound_buffer_pool_entry[i][j]) {
+				goto out;
 			}
-			card->inbound_buffer_pool_entry_used[i] = BUFFER_UNUSED;
-		}
-	} else {
-		for (i = 0; i < card->options.inbound_buffer_count; i++) {
-			card->inbound_buffer_pool_entry[i][0] =
-			    kmalloc(alloc_size, GFP_KERNEL);
-			if (!card->inbound_buffer_pool_entry[i][0])
-				failed = 1;
-			for (j = 1; j < element_count; j++)
-				card->inbound_buffer_pool_entry[i][j] =
-				    card->inbound_buffer_pool_entry[i][0] +
-				    PAGE_SIZE * j;
-			card->inbound_buffer_pool_entry_used[i] = BUFFER_UNUSED;
 		}
+		card->inbound_buffer_pool_entry_used[i] = BUFFER_UNUSED;
 	}
 
+	spin_lock_init(&card->requeue_input_lock);
+
+	return 0;
 out:
-	if (failed) {
-		for (i = 0; i < card->options.inbound_buffer_count; i++) {
-			for (j = 0; j < QDIO_MAX_ELEMENTS_PER_BUFFER; j++) {
-				if (card->inbound_buffer_pool_entry[i][j]) {
-					if (j < element_count)
-						kfree(card->
-						      inbound_buffer_pool_entry
-						      [i][j]);
-					card->inbound_buffer_pool_entry
-					    [i][j] = NULL;
-				}
+	for (i = 0; i < card->options.inbound_buffer_count; i++) {
+		for (j = 0; j < QDIO_MAX_ELEMENTS_PER_BUFFER; j++) {
+			if (card->inbound_buffer_pool_entry[i][j]) {
+				if (j < BUFFER_MAX_ELEMENTS)
+					kfree(card->
+					      inbound_buffer_pool_entry[i][j]);
+				card->inbound_buffer_pool_entry[i][j] = NULL;
 			}
 		}
-		for (i = 0; i < card->no_queues; i++) {
-			vfree(card->outbound_ringbuffer[i]);
-			card->outbound_ringbuffer[i] = NULL;
-		}
-		return -ENOMEM;
 	}
+	for (i = 0; i < card->no_queues; i++) {
+		vfree(card->outbound_ringbuffer[i]);
+		card->outbound_ringbuffer[i] = NULL;
+	}
+	return -ENOMEM;
 
-	spin_lock_init(&card->requeue_input_lock);
-
-	return 0;
 }
 
 /* also locked from outside (setup_lock) */
@@ -8843,32 +8773,23 @@
 	__qeth_correct_routing_status_v6(card);
 }
 
-static struct net_device *
-qeth_init_netdev(struct net_device *dev)
+static int
+qeth_init_netdev(struct qeth_card *card)
 {
 
-	struct qeth_card *card = NULL;
 	int result;
 	char dbf_text[15];
 
-	if (!dev) {
-		PRINT_ERR("qeth_init_netdev called with no device!\n");
-		goto out;
-	}
-
-	card = (struct qeth_card *) dev->priv;
-	strcpy(card->dev_name, dev->name);
 	result = qeth_register_netdev(card);
 	if (result) {
 		PRINT_ALL("         register_netdev %s -- rc=%i\n",
-			  ((struct qeth_card *) firstcard->dev->priv)->
-			  dev_name, result);
+			  card->dev_name, result);
 		sprintf(dbf_text, "rgnd%4x", (__u16) result);
 		QETH_DBF_TEXT2(1, trace, dbf_text);
 		atomic_set(&card->is_registered, 0);
 		goto out;
 	}
-	strcpy(card->dev_name, dev->name);
+	strcpy(card->dev_name, card->dev->name);
 	atomic_set(&card->write_busy, 0);
 	atomic_set(&card->is_registered, 1);
 
@@ -8885,7 +8806,7 @@
 	schedule_work(&card->tqueue);
 out:
 	qeth_wakeup_procfile();
-	return dev;
+	return result;
 
 }
 
@@ -9092,11 +9013,11 @@
 	length += sprintf(buffer + length,
 			  "devices            CHPID     "
 			  "device     cardtype port chksum prio-q'ing "
-			  "rtr fsz C cnt\n");
+			  "rtr fsz cnt\n");
 	length += sprintf(buffer + length,
 			  "-------------------- --- ----"
 			  "------ -------------- --     -- ---------- "
-			  "--- --- - ---\n");
+			  "--- --- ---\n");
 	card = firstcard;
 	while (card) {
 		strcpy(checksum_str,
@@ -9212,7 +9133,7 @@
 		} else {
 			length += sprintf(buffer + length,
 					  "%s/%s/%s x%02X %10s %14s %2i"
-					  "     %2s %10s %3s %3s %c %3i\n",
+					  "     %2s %10s %3s %3s %3i\n",
 					  card->rdev->dev.bus_id,
 					  card->wdev->dev.bus_id,
 					  card->ddev->dev.bus_id,
@@ -9222,8 +9143,6 @@
 					   card->is_guest_lan),
 					  card->options.portno, checksum_str,
 					  queueing_str, router_str, bufsize_str,
-					  (card->options.memusage ==
-					   MEMUSAGE_CONTIG) ? 'c' : ' ',
 					  card->options.inbound_buffer_count);
 		}
 		card = card->next;
@@ -9662,7 +9581,8 @@
 	qeth_version = 0;
 	number_of_devices = 0;
 
-	copy_from_user((void *) parms, (void *) arg, sizeof (parms));
+	if (copy_from_user((void *) parms, (void *) arg, sizeof (parms)))
+		return -EFAULT;
 	memcpy(&data_size, parms, sizeof (__u32));
 
 	if (!(data_size > 0))
@@ -9725,7 +9645,8 @@
 	       sizeof (__u32));
 	memcpy(((char *) buffer_pointer) + (3 * sizeof (__u32)),
 	       &number_of_devices, sizeof (__u32));
-	copy_to_user((char *) arg, buffer, data_len);
+	if (copy_to_user((char *) arg, buffer, data_len))
+		result = -EFAULT;
 	vfree(buffer);
 out:
 	read_unlock(&list_lock);
@@ -10017,7 +9938,6 @@
 };
 
 static struct device qeth_root_dev = {
-	.name = "QETH Devices",
 	.bus_id = "qeth",
 };
 
@@ -10467,44 +10387,6 @@
 static DEVICE_ATTR(portno, 0644, qeth_portno_show, qeth_portno_store);
 
 static ssize_t
-qeth_contig_show(struct device *dev, char *buf)
-{
-	struct qeth_card *card = dev->driver_data;
-
-	if (!card)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n",
-		       (card->options.memusage == MEMUSAGE_CONTIG)?"yes":"no");
-}
-
-static ssize_t
-qeth_contig_store(struct device *dev, const char *buf, size_t count)
-{
-	struct qeth_card *card = dev->driver_data;
-	int i;
-	char *tmp;
-
-	if (!card)
-		return count;
-
-	if (atomic_read(&card->is_hardsetup))
-		return -EPERM;
-
-	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 0)
-		card->options.memusage = MEMUSAGE_DISCONTIG;
-	else if (i == 1)
-		card->options.memusage = MEMUSAGE_CONTIG;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR(contig, 0644, qeth_contig_show, qeth_contig_store);
-
-static ssize_t
 qeth_polltime_show(struct device *dev, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
@@ -10585,7 +10467,7 @@
 		return -EINVAL;
 
 	return sprintf(buf, "%s\n",
-		       (card->options.ena_ipat == ENABLE_TAKEOVER)?"yes":"no");
+		       (card->options.ena_ipat == ENABLE_TAKEOVER)?"1":"0");
 }
 
 static ssize_t
@@ -10602,9 +10484,9 @@
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 0)
+	if (i == 1)
 		card->options.ena_ipat = ENABLE_TAKEOVER;
-	else if (i == 1)
+	else if (i == 0)
 		card->options.ena_ipat = DISABLE_TAKEOVER;
 	else
 		return -EINVAL;
@@ -10623,7 +10505,7 @@
 		return -EINVAL;
 
 	return sprintf(buf, "%s\n",
-		       (card->options.macaddr_mode == MACADDR_CANONICAL)?"yes":"no");
+		       (card->options.macaddr_mode == MACADDR_CANONICAL)?"1":"0");
 }
 
 static ssize_t
@@ -10661,7 +10543,7 @@
 		return -EINVAL;
 
 	return sprintf(buf, "%s\n",
-		       (card->options.fake_broadcast == FAKE_BROADCAST)?"yes":"no");
+		       (card->options.fake_broadcast == FAKE_BROADCAST)?"1":"0");
 }
 
 static ssize_t
@@ -10699,7 +10581,7 @@
 		return -EINVAL;
 
 	return sprintf(buf, "%s\n",
-		       (card->options.fake_ll == FAKE_LL)?"yes":"no");
+		       (card->options.fake_ll == FAKE_LL)?"1":"0");
 }
 
 static ssize_t
@@ -10729,44 +10611,6 @@
 static DEVICE_ATTR(fake_ll, 0644, qeth_fakell_show, qeth_fakell_store);
 
 static ssize_t
-qeth_hsi_show(struct device *dev, char *buf)
-{
-	struct qeth_card *card = dev->driver_data;
-
-	if (!card)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n",
-		       (card->options.async_iqd == ASYNC_IQD)?"async":"sync");
-}
-
-static ssize_t
-qeth_hsi_store(struct device *dev, const char *buf, size_t count)
-{
-	struct qeth_card *card = dev->driver_data;
-	int i;
-	char *tmp;
-
-	if (!card)
-		return count;
-
-	if (atomic_read(&card->is_hardsetup))
-		return -EPERM;
-
-	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 0)
-		card->options.async_iqd = SYNC_IQD;
-	else if (i == 1)
-		card->options.async_iqd = ASYNC_IQD;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR(async_hsi, 0644, qeth_hsi_show, qeth_hsi_store);
-
-static ssize_t
 qeth_broadcast_show(struct device *dev, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
@@ -10900,6 +10744,7 @@
 	}
 
 	gdev->dev.driver_data = card;
+	card->gdev = gdev;
 
 	card->rdev = gdev->cdev[0];
 	gdev->cdev[0]->handler = qeth_interrupt_handler_read;
@@ -10917,7 +10762,6 @@
 	if (ret != 0)
 		goto out;
 
-	snprintf(gdev->dev.name, DEVICE_NAME_SIZE, "qeth device");
 	return 0;
 out:
 	put_device(&gdev->dev);
@@ -10980,8 +10824,20 @@
 	/* this was previously done in chandev_initnetdevice */
 	snprintf(card->dev->name, 8, "%s%%d",
 		 qeth_get_dev_basename(card->type, card->link_type));
-	qeth_init_netdev(card->dev);
+	if (qeth_init_netdev(card))
+		goto out_remove;
 
+	if (sysfs_create_link(&card->gdev->dev.kobj, &card->dev->class_dev.kobj,
+			      card->dev_name)) {
+		qeth_unregister_netdev(card);
+		goto out_remove;
+	}
+	if (sysfs_create_link(&card->dev->class_dev.kobj, &card->gdev->dev.kobj,
+			      card->gdev->dev.bus_id)) {
+		sysfs_remove_link(&card->gdev->dev.kobj, card->dev_name);
+		qeth_unregister_netdev(card);
+		goto out_remove;
+	}
 	return 0;		/* success */
 
 out_remove:
@@ -11006,7 +10862,7 @@
 	__qeth_remove_attributes(&gdev->dev);
 	gdev->dev.driver_data = NULL;
 	if (card)
-		kfree(card);
+		qeth_free_card(card);
 	put_device(&gdev->dev);
 	return 0;
 }
@@ -11014,17 +10870,15 @@
 static int
 qeth_set_online(struct ccwgroup_device *gdev)
 {
+	int rc;
 	struct qeth_card *card = gdev->dev.driver_data;
-	int ret;
 
 	BUG_ON(!card);
 
-	ret = qeth_activate(card);
-	if (ret == 0)
-		snprintf(gdev->dev.name, DEVICE_NAME_SIZE, "%s",
-			 qeth_get_cardname_short(card->type, card->link_type,
-						 card->is_guest_lan));
-	return ret;
+	rc = qeth_alloc_card_stuff(card);
+
+	return rc ? rc : qeth_activate(card);
+
 }
 
 static int
@@ -11040,14 +10894,12 @@
 
 	QETH_DBF_TEXT4(0, trace, "freecard");
 
-	memset(card->dev, 0, sizeof (struct net_device));
-	card->dev->priv = card;
-	strncpy(card->dev->name, card->dev_name, IFNAMSIZ);
-
 	ccw_device_set_offline(card->ddev);
 	ccw_device_set_offline(card->wdev);
 	ccw_device_set_offline(card->rdev);
 
+	qeth_free_card_stuff(card);
+
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Thu Sep 25 18:33:33 2003
@@ -14,7 +14,7 @@
 
 #define QETH_NAME " qeth"
 
-#define VERSION_QETH_H "$Revision: 1.49 $"
+#define VERSION_QETH_H "$Revision: 1.56 $"
 
 /******************** CONFIG STUFF ***********************/
 //#define QETH_DBF_LIKE_HELL
@@ -567,13 +567,6 @@
 #define QETH_LOCK_NORMAL 1
 #define QETH_LOCK_FLUSH 2
 
-#define QETH_MAX_DEVICES 16
-	/* DEPENDENCY ON QETH_MAX_DEVICES.
-	 *__MOUDLE_STRING expects simple literals */
-#define QETH_MAX_DEVICES_TIMES_4 64
-#define QETH_MAX_DEVNAMES 16
-#define QETH_DEVNAME "eth"
-
 #define QETH_TX_TIMEOUT 100*HZ	/* 100 seconds */
 
 #define QETH_REMOVE_WAIT_TIME 200
@@ -581,8 +574,6 @@
 #define QETH_IDLE_WAIT_TIME 10
 #define QETH_WAIT_BEFORE_2ND_DOIO 1000
 
-#define QETH_MAX_PARM_LEN 128
-
 #define QETH_FAKE_LL_LEN ETH_HLEN	/* 14 */
 #define QETH_FAKE_LL_PROT_LEN 2
 #define QETH_FAKE_LL_ADDR_LEN ETH_ALEN	/* 6 */
@@ -609,16 +600,12 @@
 				 IPA_PDU_HEADER_SIZE+sizeof(struct ipa_cmd)), \
 			   QETH_RCD_LENGTH)
 
-#define QETH_FINAL_STATUS_TIMEOUT 1500
-#define QETH_CLEAR_TIMEOUT 1500
-#define QETH_RCD_TIMEOUT 1500
 #define QETH_NOP_TIMEOUT 1500
 #define QETH_QUIESCE_NETDEV_TIME 300
 #define QETH_QUIESCE_WAIT_BEFORE_CLEAR 4000
 #define QETH_QUIESCE_WAIT_AFTER_CLEAR 4000
 
 #define NOP_STATE 0x1001
-#define READ_CONF_DATA_STATE 0x1002
 #define IDX_ACTIVATE_READ_STATE 0x1003
 #define IDX_ACTIVATE_WRITE_STATE 0x1004
 #define MPC_SETUP_STATE 0x1005
@@ -647,8 +634,6 @@
 #define BROADCAST_LOCAL 1
 #define MACADDR_NONCANONICAL 0
 #define MACADDR_CANONICAL 1
-#define MEMUSAGE_DISCONTIG 0
-#define MEMUSAGE_CONTIG 1
 #define ENABLE_TAKEOVER 0
 #define DISABLE_TAKEOVER 1
 #define FAKE_BROADCAST 0
@@ -656,8 +641,6 @@
 
 #define FAKE_LL 0
 #define DONT_FAKE_LL 1
-#define SYNC_IQD 0
-#define ASYNC_IQD 1
 
 #define QETH_BREAKOUT_LEAVE 1
 #define QETH_BREAKOUT_AGAIN 2
@@ -684,9 +667,6 @@
 #define SENSE_RESETTING_EVENT_BYTE 1
 #define SENSE_RESETTING_EVENT_FLAG 0x80
 
-#define DEFAULT_RCD_CMD 0x72
-#define DEFAULT_RCD_COUNT 0x80
-
 #define BUFFER_USED 1
 #define BUFFER_UNUSED -1
 
@@ -744,14 +724,12 @@
 	int polltime;
 	char portname[9];
 	int portno;
-	int memusage;
 	int broadcast_mode;
 	int macaddr_mode;
 	int ena_ipat;
 	int fake_broadcast;
 	int add_hhlen;
 	int fake_ll;
-	int async_iqd;
 };
 
 struct qeth_hdr {
@@ -811,7 +789,6 @@
 
 /* ugly. I know. */
 struct qeth_card {	/* pointed to by dev->priv */
-	int easy_copy_cap;
 
 	/* pointer to options (defaults + parameters) */
 	struct qeth_card_options options;
@@ -930,8 +907,6 @@
 	int is_multicast_different;	/* if multicast traffic is to be sent
 					   on a different queue, this is the
 					   queue+no_queues */
-	int can_do_async_iqd;	/* 1 only on IQD that provides async
-				   unicast sigas */
 	__u32 ipa_supported;
 	__u32 ipa_enabled;
 	__u32 ipa6_supported;
@@ -950,6 +925,7 @@
 	int unique_id;
 
 	/* device and I/O data */
+	struct ccwgroup_device *gdev;
 	struct ccw_device *rdev;
 	struct ccw_device *wdev;
 	struct ccw_device *ddev;
@@ -969,8 +945,6 @@
 
 	atomic_t ioctl_data_has_arrived;
 	wait_queue_head_t ioctl_wait_q;
-	atomic_t ioctl_wait_q_active;
-	spinlock_t ioctl_wait_q_lock;
 
 /* stuff under 2 gb */
 	struct qeth_dma_stuff *dma_stuff;
@@ -987,8 +961,6 @@
 	atomic_t shutdown_phase;
 	atomic_t data_has_arrived;
 	wait_queue_head_t wait_q;
-	atomic_t wait_q_active;
-	spinlock_t wait_q_lock;	/* for wait_q_active and wait_q */
 
 	atomic_t clear_succeeded0;
 	atomic_t clear_succeeded1;
@@ -1034,21 +1006,6 @@
 	}
 }
 
-inline static int
-qeth_determine_easy_copy_cap(int cardtype)
-{
-	switch (cardtype) {
-	case QETH_CARD_TYPE_UNKNOWN:
-		return 0;	/* better be cautious */
-	case QETH_CARD_TYPE_OSAE:
-		return 1;
-	case QETH_CARD_TYPE_IQD:
-		return 0;
-	default:
-		return 0;	/* ?? */
-	}
-}
-
 inline static __u8
 qeth_get_adapter_type_for_ipa(int link_type)
 {
