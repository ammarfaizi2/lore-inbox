Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUFKRl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUFKRl4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUFKRkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:40:23 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:8361 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264270AbUFKRhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:37:11 -0400
Date: Fri, 11 Jun 2004 19:37:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: qeth network driver.
Message-ID: <20040611173716.GG3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: qeth network driver.

From: Frank Pavlic <pavlic@de.ibm.com>
From: Thomas Spatzier <tspat@de.ibm.com>

qeth network driver changes:
 - Use correct request length in arp/snmp requests.
 - Simplify handling of empty vs. primed buffers.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth.h      |    9 -
 drivers/s390/net/qeth_main.c |  209 +++++++++++++++++++++++++------------------
 2 files changed, 128 insertions(+), 90 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Fri Jun 11 19:09:24 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Fri Jun 11 19:09:59 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.109 $"
+#define VERSION_QETH_H 		"$Revision: 1.110 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -380,11 +380,6 @@
 	 * outbound: filled by driver; owned by hardware in order to be sent
 	 */
 	QETH_QDIO_BUF_PRIMED,
-	/*
-	 * inbound only: an error condition has been detected for a buffer
-	 *     the buffer will be discarded (not read out)
-	 */
-	QETH_QDIO_BUF_ERROR,
 };
 
 enum qeth_qdio_info_states {
@@ -423,7 +418,7 @@
 
 struct qeth_qdio_out_buffer {
 	struct qdio_buffer *buffer;
-	volatile enum qeth_qdio_buffer_states state;
+	atomic_t state;
 	volatile int next_element_to_fill;
 	struct sk_buff_head skb_list;
 };
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Fri Jun 11 19:09:24 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Fri Jun 11 19:09:59 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.118 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.121 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.118 $	 $Date: 2004/06/02 06:34:52 $
+ *    $Revision: 1.121 $	 $Date: 2004/06/11 16:32:15 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.118 $"
+#define VERSION_QETH_C "$Revision: 1.121 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2345,13 +2345,17 @@
 }
 
 static inline void
-qeth_clear_output_buffer(struct qeth_card *card,
+qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 			 struct qeth_qdio_out_buffer *buf)
 {
 	int i;
 	struct sk_buff *skb;
 
-	for(i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i){
+	/* is PCI flag set on buffer? */
+	if (buf->buffer->element[0].flags & 0x40)
+		atomic_dec(&queue->set_pci_flags_count);
+
+	for(i = 0; i < QETH_MAX_BUFFER_ELEMENTS(queue->card); ++i){
 		buf->buffer->element[i].length = 0;
 		buf->buffer->element[i].addr = NULL;
 		buf->buffer->element[i].flags = 0;
@@ -2361,7 +2365,7 @@
 		}
 	}
 	buf->next_element_to_fill = 0;
-	buf->state = QETH_QDIO_BUF_EMPTY;
+	atomic_set(&buf->state, QETH_QDIO_BUF_EMPTY);
 }
 
 static inline void
@@ -2578,8 +2582,17 @@
 		QETH_DBF_TEXT(trace, 2, "flushbuf");
 		QETH_DBF_TEXT_(trace, 2, " err%d", rc);
 		queue->card->stats.tx_errors += count;
+		/* ok, since do_QDIO went wrong the buffers have not been given
+		 * to the hardware. they still belong to us, so we can clear
+		 * them and reuse then, i.e. set back next_buf_to_fill*/
+		for (i = index; i < index + count; ++i) {
+			buf = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
+			qeth_clear_output_buffer(queue, buf);
+		}
+		queue->next_buf_to_fill = index;
 		return;
 	}
+	atomic_add(count, &queue->used_buffers);
 #ifdef CONFIG_QETH_PERF_STATS
 	queue->card->perf_stats.bufs_sent += count;
 #endif
@@ -2617,11 +2630,11 @@
 			queue->do_pack = 0;
 			/* flush packing buffers */
 			buffer = &queue->bufs[queue->next_buf_to_fill];
-			BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
-			if (buffer->next_element_to_fill > 0) {
-				buffer->state = QETH_QDIO_BUF_PRIMED;
+			if ((atomic_read(&buffer->state) ==
+						QETH_QDIO_BUF_EMPTY) &&
+			    (buffer->next_element_to_fill > 0)) {
+				atomic_set(&buffer->state,QETH_QDIO_BUF_PRIMED);
 				flush_count++;
-				atomic_inc(&queue->used_buffers);
 				queue->next_buf_to_fill =
 					(queue->next_buf_to_fill + 1) %
 					QDIO_MAX_BUFFERS_PER_Q;
@@ -2635,17 +2648,17 @@
 qeth_flush_buffers_on_no_pci(struct qeth_qdio_out_q *queue, int under_int)
 {
 	struct qeth_qdio_out_buffer *buffer;
+	int index;
 
-	buffer = &queue->bufs[queue->next_buf_to_fill];
-	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
-	if (buffer->next_element_to_fill > 0){
+	index = queue->next_buf_to_fill;
+	buffer = &queue->bufs[index];
+	if((atomic_read(&buffer->state) == QETH_QDIO_BUF_EMPTY) &&
+	   (buffer->next_element_to_fill > 0)){
 		/* it's a packing buffer */
-		buffer->state = QETH_QDIO_BUF_PRIMED;
-		atomic_inc(&queue->used_buffers);
-		qeth_flush_buffers(queue, under_int, queue->next_buf_to_fill,
-				   1);
+		atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
 		queue->next_buf_to_fill =
 			(queue->next_buf_to_fill + 1) % QDIO_MAX_BUFFERS_PER_Q;
+		qeth_flush_buffers(queue, under_int, index, 1);
 	}
 }
 
@@ -2688,13 +2701,9 @@
 			qeth_schedule_recovery(card);
 			return;
 		}
-		/* is PCI flag set on buffer? */
-		if (buffer->buffer->element[0].flags & 0x40)
-			atomic_dec(&queue->set_pci_flags_count);
-
-		qeth_clear_output_buffer(card, buffer);
-		atomic_dec(&queue->used_buffers);
+		qeth_clear_output_buffer(queue, buffer);
 	}
+	atomic_sub(count, &queue->used_buffers);
 
 	netif_wake_queue(card->dev);
 #ifdef CONFIG_QETH_PERF_STATS
@@ -2887,8 +2896,8 @@
 	/* free outbound qdio_qs */
 	for (i = 0; i < card->qdio.no_out_queues; ++i){
 		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j)
-			qeth_clear_output_buffer(card, &card->qdio.
-						out_qs[i]->bufs[j]);
+			qeth_clear_output_buffer(card->qdio.out_qs[i],
+					&card->qdio.out_qs[i]->bufs[j]);
 		kfree(card->qdio.out_qs[i]);
 	}
 	kfree(card->qdio.out_qs);
@@ -2905,8 +2914,8 @@
 	for (i = 0; i < card->qdio.no_out_queues; ++i)
 		if (card->qdio.out_qs[i]){
 			for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j)
-				qeth_clear_output_buffer(card, &card->qdio.
-						out_qs[i]->bufs[j]);
+				qeth_clear_output_buffer(card->qdio.out_qs[i],
+						&card->qdio.out_qs[i]->bufs[j]);
 		}
 }
 
@@ -2958,8 +2967,8 @@
 		memset(card->qdio.out_qs[i]->qdio_bufs, 0,
 		       QDIO_MAX_BUFFERS_PER_Q * sizeof(struct qdio_buffer));
 		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j){
-			qeth_clear_output_buffer(card, &card->qdio.
-						 out_qs[i]->bufs[j]);
+			qeth_clear_output_buffer(card->qdio.out_qs[i],
+					&card->qdio.out_qs[i]->bufs[j]);
 		}
 		card->qdio.out_qs[i]->card = card;
 		card->qdio.out_qs[i]->next_buf_to_fill = 0;
@@ -3671,7 +3680,7 @@
 	if (!queue->do_pack) {
 		QETH_DBF_TEXT(trace, 6, "fillbfnp");
 		/* set state to PRIMED -> will be flushed */
-		buf->state = QETH_QDIO_BUF_PRIMED;
+		atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
 	} else {
 		QETH_DBF_TEXT(trace, 6, "fillbfpa");
 #ifdef CONFIG_QETH_PERF_STATS
@@ -3683,7 +3692,7 @@
 			 * packed buffer if full -> set state PRIMED
 			 * -> will be flushed
 			 */
-			buf->state = QETH_QDIO_BUF_PRIMED;
+			atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
 		}
 	}
 	return 0;
@@ -3696,32 +3705,27 @@
 {
 	struct qeth_qdio_out_buffer *buffer;
 	int index;
-	int rc = 0;
 
 	QETH_DBF_TEXT(trace, 6, "dosndpfa");
 
 	spin_lock(&queue->lock);
-	/* do we have empty buffers? */
-	if (atomic_read(&queue->used_buffers) >= (QDIO_MAX_BUFFERS_PER_Q - 1)){
+	index = queue->next_buf_to_fill;
+	buffer = &queue->bufs[queue->next_buf_to_fill];
+	/*
+	 * check if buffer is empty to make sure that we do not 'overtake'
+	 * ourselves and try to fill a buffer that is already primed
+	 */
+	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) {
 		card->stats.tx_dropped++;
-		rc = -EBUSY;
 		spin_unlock(&queue->lock);
-		goto out;
+		return -EBUSY;
 	}
-	index = queue->next_buf_to_fill;
-	buffer = &queue->bufs[queue->next_buf_to_fill];
-	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
 	queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
 				  QDIO_MAX_BUFFERS_PER_Q;
-	atomic_inc(&queue->used_buffers);
-	spin_unlock(&queue->lock);
-
-	/* go on sending ... */
-	netif_wake_queue(skb->dev);
 	qeth_fill_buffer(queue, buffer, (char *)hdr, skb);
 	qeth_flush_buffers(queue, 0, index, 1);
-out:
-	return rc;
+	spin_unlock(&queue->lock);
+	return 0;
 }
 
 static inline int
@@ -3737,35 +3741,43 @@
 	QETH_DBF_TEXT(trace, 6, "dosndpkt");
 
 	spin_lock(&queue->lock);
-	/* do we have empty buffers? */
-	if (atomic_read(&queue->used_buffers) >= (QDIO_MAX_BUFFERS_PER_Q - 2)){
-		card->stats.tx_dropped++;
-		rc = -EBUSY;
-		goto out;
-	}
 	start_index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
-	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
+	/*
+	 * check if buffer is empty to make sure that we do not 'overtake'
+	 * ourselves and try to fill a buffer that is already primed
+	 */
+	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY){
+		card->stats.tx_dropped++;
+		spin_unlock(&queue->lock);
+		return -EBUSY;
+	}
 	if (queue->do_pack){
 		/* does packet fit in current buffer? */
-		if((QETH_MAX_BUFFER_ELEMENTS(card) - buffer->next_element_to_fill)
-				< elements_needed){
+		if((QETH_MAX_BUFFER_ELEMENTS(card) -
+		    buffer->next_element_to_fill) < elements_needed){
 			/* ... no -> set state PRIMED */
-			buffer->state = QETH_QDIO_BUF_PRIMED;
+			atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
 			flush_count++;
-			atomic_inc(&queue->used_buffers);
 			queue->next_buf_to_fill =
 				(queue->next_buf_to_fill + 1) %
 				QDIO_MAX_BUFFERS_PER_Q;
 			buffer = &queue->bufs[queue->next_buf_to_fill];
+			/* we did a step forward, so check buffer state again */
+			if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY){
+				card->stats.tx_dropped++;
+				qeth_flush_buffers(queue, 0, start_index, 1);
+				spin_unlock(&queue->lock);
+				/* return EBUSY because we sent old packet, not
+				 * the current one */
+				return -EBUSY;
+			}
 		}
 	}
-
 	qeth_fill_buffer(queue, buffer, (char *)hdr, skb);
-	if (buffer->state == QETH_QDIO_BUF_PRIMED){
+	if (atomic_read(&buffer->state) == QETH_QDIO_BUF_PRIMED){
 		/* next time fill the next buffer */
 		flush_count++;
-		atomic_inc(&queue->used_buffers);
 		queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
 			QDIO_MAX_BUFFERS_PER_Q;
 	}
@@ -3777,9 +3789,8 @@
 
 	if (!atomic_read(&queue->set_pci_flags_count))
 		qeth_flush_buffers_on_no_pci(queue, 0);
-out:
-	spin_unlock(&queue->lock);
 
+	spin_unlock(&queue->lock);
 	return rc;
 }
 
@@ -4079,21 +4090,43 @@
 
 static int
 qeth_send_ipa_arp_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
-		      int len, int (*reply_cb)
-			      		(struct qeth_card *,
-					 struct qeth_reply*, unsigned long),
+		      int len, int (*reply_cb)(struct qeth_card *,
+					       struct qeth_reply *,
+					       unsigned long),
 		      void *reply_param)
 {
-	int rc;
-
 	QETH_DBF_TEXT(trace,4,"sendarp");
 
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
 	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
 	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
-	rc = qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
-				    reply_cb, reply_param);
-	return rc;
+	return qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
+				      reply_cb, reply_param);
+}
+
+static int
+qeth_send_ipa_snmp_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+		      int len, int (*reply_cb)(struct qeth_card *,
+					       struct qeth_reply *,
+					       unsigned long),
+		      void *reply_param)
+{
+	u16 s1, s2;
+
+	QETH_DBF_TEXT(trace,4,"sendsnmp");
+
+	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
+	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
+	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
+	/* adjust PDU length fields in IPA_PDU_HEADER */
+	s1 = (u32) IPA_PDU_HEADER_SIZE + len;
+	s2 = (u32) len;
+	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
+	return qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
+				      reply_cb, reply_param);
 }
 
 static struct qeth_cmd_buffer *
@@ -4136,8 +4169,7 @@
 
 	rc = qeth_send_ipa_arp_cmd(card, iob,
 				   QETH_SETASS_BASE_LEN+QETH_ARP_CMD_LEN,
-				   qeth_arp_query_cb,
-				   (void *)&qinfo);
+				   qeth_arp_query_cb, (void *)&qinfo);
 	if (rc) {
 		tmp = rc;
 		PRINT_WARN("Error while querying ARP cache on %s: %s "
@@ -4247,7 +4279,8 @@
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
-	struct qeth_snmp_ureq ureq;
+	struct qeth_snmp_ureq *ureq;
+	int req_len;
 	struct qeth_arp_query_info qinfo = {0, };
 	int rc = 0;
 
@@ -4260,29 +4293,39 @@
 			   "on %s!\n", card->info.if_name);
 		return -EOPNOTSUPP;
 	}
-	if (copy_from_user(&ureq, udata, sizeof(struct qeth_snmp_ureq)))
+	/* skip 4 bytes (data_len struct member) to get req_len */
+	if (copy_from_user(&req_len, udata + sizeof(int), sizeof(int)))
 		return -EFAULT;
-	qinfo.udata_len = ureq.hdr.data_len;
-	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL)))
+	ureq = kmalloc(req_len, GFP_KERNEL);
+	if (!ureq) {
+		QETH_DBF_TEXT(trace, 2, "snmpnome");
 		return -ENOMEM;
+	}
+	if (copy_from_user(ureq, udata, req_len)){
+		kfree(ureq);
+		return -EFAULT;
+	}
+	qinfo.udata_len = ureq->hdr.data_len;
+	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL))){
+		kfree(ureq);
+		return -ENOMEM;
+	}
 	memset(qinfo.udata, 0, qinfo.udata_len);
 	qinfo.udata_offset = sizeof(struct qeth_snmp_ureq_hdr);
 
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL,
-				   QETH_SNMP_SETADP_CMDLENGTH+ureq.hdr.req_len);
+				   QETH_SNMP_SETADP_CMDLENGTH + req_len);
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	memcpy(&cmd->data.setadapterparms.data.snmp, &ureq.cmd,
-	       sizeof(struct qeth_snmp_cmd));
-	rc = qeth_send_ipa_arp_cmd(card, iob,
-				   QETH_SETADP_BASE_LEN + QETH_ARP_DATA_SIZE +
-				   ureq.hdr.req_len, qeth_snmp_command_cb,
-				   (void *)&qinfo);
+	memcpy(&cmd->data.setadapterparms.data.snmp, &ureq->cmd, req_len);
+	rc = qeth_send_ipa_snmp_cmd(card, iob, QETH_SETADP_BASE_LEN + req_len,
+				    qeth_snmp_command_cb, (void *)&qinfo);
 	if (rc)
 		PRINT_WARN("SNMP command failed on %s: (0x%x)\n",
 			   card->info.if_name, rc);
 	 else
 		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
 
+	kfree(ureq);
 	kfree(qinfo.udata);
 	return rc;
 }
