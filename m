Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUESLIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUESLIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUESLIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:08:12 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:7642 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263600AbUESLCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:02:37 -0400
Date: Wed, 19 May 2004 13:02:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/4): network driver.
Message-ID: <20040519110232.GE5888@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Network driver changes:
 - iucv: Make grab_param function SMP safe.
 - lcs: Fix null-pointer dereference after unsuccessful set_online.
 - qeth: Fix kmalloc flags in qeth_alloc_reply.
 - qeth: Show broadcase capability also in route4/6 sysfs attributes.
 - qeth: Remove debug code.
 - qeth: Add option to qetharp user space interface to strip unused
         fields from query arp records.
 - qeth: Add shortcut in outbound path for HiperSockets.
 - qeth: Add more info to qeth_perf_stats.
 - qeth: Add support for direct SNMP interface to OSA express cards.

diffstat:
 drivers/s390/net/iucv.c      |   29 +-
 drivers/s390/net/lcs.c       |    9 
 drivers/s390/net/qeth.h      |   34 +++
 drivers/s390/net/qeth_main.c |  429 ++++++++++++++++++++++++++++++++++---------
 drivers/s390/net/qeth_mpc.h  |   27 ++
 drivers/s390/net/qeth_proc.c |   28 +-
 drivers/s390/net/qeth_sys.c  |   61 ++++--
 include/asm-s390/qeth.h      |   26 ++
 8 files changed, 506 insertions(+), 137 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Wed May 19 12:47:28 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.30 2004/05/13 09:21:23 braunu Exp $
+ * $Id: iucv.c,v 1.32 2004/05/18 09:28:43 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.30 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.32 $
  *
  */
 
@@ -285,6 +285,7 @@
 		iparml_set_mask p_set_mask;
 	} param;
 	atomic_t in_use;
+	__u32    res;
 }  __attribute__ ((aligned(8))) iucv_param;
 #define PARAM_POOL_SIZE (PAGE_SIZE / sizeof(iucv_param))
 
@@ -351,7 +352,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.30 $";
+	char vbuf[] = "$Revision: 1.32 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -469,17 +470,19 @@
 static __inline__ iucv_param *
 grab_param(void)
 {
-	iucv_param *ret;
-	static int i = 0;
+	iucv_param *ptr;
+        static int hint = 0;
 
-	while (atomic_compare_and_swap(0, 1, &iucv_param_pool[i].in_use)) {
-		i++;
-		if (i >= PARAM_POOL_SIZE)
-			i = 0;
-	}
-	ret = &iucv_param_pool[i];
-	memset(&ret->param, 0, sizeof(ret->param));
-	return ret;
+	ptr = iucv_param_pool + hint;
+	do {
+		ptr++;
+		if (ptr >= iucv_param_pool + PARAM_POOL_SIZE)
+			ptr = iucv_param_pool;
+	} while (atomic_compare_and_swap(0, 1, &ptr->in_use));
+	hint = ptr - iucv_param_pool;
+
+	memset(&ptr->param, 0, sizeof(ptr->param));
+	return ptr;
 }
 
 /**
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Wed May 19 12:47:28 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.80 $	 $Date: 2004/05/13 08:22:06 $
+ *    $Revision: 1.81 $	 $Date: 2004/05/14 13:54:33 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.80 $"
+#define VERSION_LCS_C  "$Revision: 1.81 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -1898,8 +1898,10 @@
 	lcs_setup_card(card);
 	rc = lcs_detect(card);
 	if (rc) {
+		LCS_DBF_TEXT(2, setup, "dtctfail");
+		PRINT_WARN("Detection of LCS card failed with return code "
+			   "%d (0x%x)\n", rc, rc);
 		lcs_stopcard(card);
-		lcs_cleanup_card(card);
 		goto out;
 	}
 	if (card->dev) {
@@ -1962,7 +1964,6 @@
 
 	ccw_device_set_offline(card->read.ccwdev);
 	ccw_device_set_offline(card->write.ccwdev);
-	lcs_cleanup_card(card);
 	return -ENODEV;
 }
 
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Wed May 19 12:47:28 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.107 $"
+#define VERSION_QETH_H 		"$Revision: 1.108 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -179,15 +179,26 @@
 
 	unsigned int sc_dp_p;
 	unsigned int sc_p_dp;
-
+	/* qdio_input_handler: number of times called, time spent in */
 	__u64 inbound_start_time;
 	unsigned int inbound_cnt;
 	unsigned int inbound_time;
+	/* qeth_send_packet: number of times called, time spent in */
 	__u64 outbound_start_time;
 	unsigned int outbound_cnt;
 	unsigned int outbound_time;
-	unsigned int inbound_do_qdio;
-	unsigned int outbound_do_qdio;
+	/* qdio_output_handler: number of times called, time spent in */
+	__u64 outbound_handler_start_time;
+	unsigned int outbound_handler_cnt;
+	unsigned int outbound_handler_time;
+	/* number of calls to and time spent in do_QDIO for inbound queue */
+	__u64 inbound_do_qdio_start_time;
+	unsigned int inbound_do_qdio_cnt;
+	unsigned int inbound_do_qdio_time;
+	/* number of calls to and time spent in do_QDIO for outbound queues */
+	__u64 outbound_do_qdio_start_time;
+	unsigned int outbound_do_qdio_cnt;
+	unsigned int outbound_do_qdio_time;
 };
 #endif /* CONFIG_QETH_PERF_STATS */
 
@@ -714,6 +725,15 @@
 
 extern struct qeth_card_list_struct qeth_card_list;
 
+/*notifier list */
+struct qeth_notify_list_struct {
+	struct list_head list;
+	struct task_struct *task;
+	int signum;
+};
+extern spinlock_t qeth_notify_lock;
+extern struct list_head qeth_notify_list;
+
 /*some helper functions*/
 
 inline static __u8
@@ -997,6 +1017,12 @@
 extern void
 qeth_del_rxip(struct qeth_card *, enum qeth_prot_versions, const u8 *);
 
+extern int
+qeth_notifier_register(struct task_struct *, int );
+
+extern int
+qeth_notifier_unregister(struct task_struct * );
+
 extern void
 qeth_schedule_recovery(struct qeth_card *);
 
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Wed May 19 12:47:28 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.107 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.112 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.107 $	 $Date: 2004/05/13 16:07:59 $
+ *    $Revision: 1.112 $	 $Date: 2004/05/19 09:28:21 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.107 $"
+#define VERSION_QETH_C "$Revision: 1.112 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -100,6 +100,9 @@
 
 /* list of our cards */
 struct qeth_card_list_struct qeth_card_list;
+/*process list want to be notified*/
+spinlock_t qeth_notify_lock;
+struct list_head qeth_notify_list;
 
 static void qeth_send_control_data_cb(struct qeth_channel *,
 				      struct qeth_cmd_buffer *);
@@ -155,6 +158,68 @@
 static struct qeth_ipaddr *
 qeth_get_addr_buffer(enum qeth_prot_versions);
 
+static void
+qeth_notify_processes(void)
+{
+	/*notify all  registered processes */
+	struct qeth_notify_list_struct *n_entry;
+
+	QETH_DBF_TEXT(trace,3,"procnoti");
+	spin_lock(&qeth_notify_lock);
+	list_for_each_entry(n_entry, &qeth_notify_list, list) {
+		send_sig(n_entry->signum, n_entry->task, 1);
+	}
+	spin_unlock(&qeth_notify_lock);
+
+}
+int
+qeth_notifier_unregister(struct task_struct *p)
+{
+	struct qeth_notify_list_struct *n_entry, *tmp;
+
+	QETH_DBF_TEXT(trace, 2, "notunreg");
+	spin_lock(&qeth_notify_lock);
+	list_for_each_entry_safe(n_entry, tmp, &qeth_notify_list, list) {
+		if (n_entry->task == p) {
+			list_del(&n_entry->list);
+			kfree(n_entry);
+			goto out;
+		}
+	}
+out:
+	spin_unlock(&qeth_notify_lock);
+	return 0;
+}
+int
+qeth_notifier_register(struct task_struct *p, int signum)
+{
+	struct qeth_notify_list_struct *n_entry;
+
+	QETH_DBF_TEXT(trace, 2, "notreg");
+	/*check first if entry already exists*/
+	spin_lock(&qeth_notify_lock);
+	list_for_each_entry(n_entry, &qeth_notify_list, list) {
+		if (n_entry->task == p) {
+			n_entry->signum = signum;
+			spin_unlock(&qeth_notify_lock);
+			return 0;
+		}
+	}
+	spin_unlock(&qeth_notify_lock);
+
+	n_entry = (struct qeth_notify_list_struct *)
+		kmalloc(sizeof(struct qeth_notify_list_struct),GFP_KERNEL);
+	if (!n_entry)
+		return -ENOMEM;
+	n_entry->task = p;
+	n_entry->signum = signum;
+	spin_lock(&qeth_notify_lock);
+	list_add(&n_entry->list,&qeth_notify_list);
+	spin_unlock(&qeth_notify_lock);
+	return 0;
+}
+
+
 /**
  * free channel command buffers
  */
@@ -460,6 +525,7 @@
 	ccw_device_set_offline(CARD_RDEV(card));
 	if (recover_flag == CARD_STATE_UP)
 		card->state = CARD_STATE_RECOVER;
+	qeth_notify_processes();
 	return 0;
 }
 
@@ -1447,7 +1513,7 @@
 {
 	struct qeth_reply *reply;
 
-	reply = kmalloc(sizeof(struct qeth_reply), GFP_KERNEL|GFP_ATOMIC);
+	reply = kmalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
 	if (reply){
 		memset(reply, 0, sizeof(struct qeth_reply));
 		atomic_set(&reply->refcnt, 1);
@@ -1631,7 +1697,7 @@
 							(unsigned long)iob);
 			}
 			if (cmd)
-				reply->rc = cmd->hdr.return_code;
+				reply->rc = (s16) cmd->hdr.return_code;
 			else if (iob->rc)
 				reply->rc = iob->rc;
 			if (keep_reply) {
@@ -2222,9 +2288,6 @@
 	while((skb = qeth_get_next_skb(card, buf->buffer, &element,
 				       &offset, &hdr))){
 		qeth_rebuild_skb(card, skb, hdr);
-		if (((*(int *)0xff0)==1) &&
-		    (skb->pkt_type == PACKET_BROADCAST))
-			qeth_hex_dump(skb->data, 100);
 		/* is device UP ? */
 		if (!(card->dev->flags & IFF_UP)){
 			dev_kfree_skb_irq(skb);
@@ -2328,11 +2391,16 @@
 		 * will be requeued the next time
 		 */
 #ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.inbound_do_qdio++;
+		card->perf_stats.inbound_do_qdio_cnt++;
+		card->perf_stats.inbound_do_qdio_start_time = qeth_get_micros();
 #endif
 		rc = do_QDIO(CARD_DDEV(card),
-			     QDIO_FLAG_SYNC_INPUT,
+			     QDIO_FLAG_SYNC_INPUT | QDIO_FLAG_UNDER_INTERRUPT,
 			     0, queue->next_buf_to_init, count, NULL);
+#ifdef CONFIG_QETH_PERF_STATS
+		card->perf_stats.inbound_do_qdio_time += qeth_get_micros() -
+			card->perf_stats.inbound_do_qdio_start_time;
+#endif
 		if (rc){
 			PRINT_WARN("qeth_queue_input_buffer's do_QDIO "
 				   "return %i (device %s).\n",
@@ -2454,6 +2522,9 @@
 		buf->buffer->element[buf->next_element_to_fill - 1].flags |=
 				SBAL_FLAGS_LAST_ENTRY;
 
+		if (queue->card->info.type == QETH_CARD_TYPE_IQD)
+			continue;
+
 		if (!queue->do_pack){
 			if ((atomic_read(&queue->used_buffers) >=
 		    		(QETH_HIGH_WATERMARK_PACK -
@@ -2485,7 +2556,8 @@
 
 	queue->card->dev->trans_start = jiffies;
 #ifdef CONFIG_QETH_PERF_STATS
-		queue->card->perf_stats.outbound_do_qdio++;
+	queue->card->perf_stats.outbound_do_qdio_cnt++;
+	queue->card->perf_stats.outbound_do_qdio_start_time = qeth_get_micros();
 #endif
 	if (under_int)
 		rc = do_QDIO(CARD_DDEV(queue->card),
@@ -2494,6 +2566,10 @@
 	else
 		rc = do_QDIO(CARD_DDEV(queue->card), QDIO_FLAG_SYNC_OUTPUT,
 			     queue->queue_no, index, count, NULL);
+#ifdef CONFIG_QETH_PERF_STATS
+	queue->card->perf_stats.outbound_do_qdio_time += qeth_get_micros() -
+		queue->card->perf_stats.outbound_do_qdio_start_time;
+#endif
 	if (rc){
 		QETH_DBF_SPRINTF(trace, 0, "qeth_flush_buffers: do_QDIO "
 				 "returned error (%i) on device %s.",
@@ -2598,6 +2674,10 @@
 		}
 	}
 
+#ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.outbound_handler_cnt++;
+	card->perf_stats.outbound_handler_start_time = qeth_get_micros();
+#endif
 	for(i = first_element; i < (first_element + count); ++i){
 		buffer = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
 		/*we only handle the KICK_IT error by doing a recovery */
@@ -2616,6 +2696,10 @@
 	}
 
 	netif_wake_queue(card->dev);
+#ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.outbound_handler_time += qeth_get_micros() -
+		card->perf_stats.outbound_handler_start_time;
+#endif
 }
 
 static char*
@@ -2857,9 +2941,6 @@
 	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
 		qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
 	card->qdio.in_q->next_buf_to_init = card->qdio.in_buf_pool.buf_count - 1;
-#ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.inbound_do_qdio++;
-#endif
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
 		     card->qdio.in_buf_pool.buf_count - 1, NULL);
 	if (rc) {
@@ -3193,10 +3274,6 @@
 		card->stats.tx_carrier_errors++;
 		return -EIO;
 	}
-	if (netif_queue_stopped(dev) ) {
-		card->stats.tx_dropped++;
-		return -EBUSY;
-	}
 #ifdef CONFIG_QETH_PERF_STATS
 	card->perf_stats.outbound_cnt++;
 	card->perf_stats.outbound_start_time = qeth_get_micros();
@@ -3612,33 +3689,59 @@
 }
 
 static inline int
-qeth_do_send_packet(struct qeth_card *card, struct sk_buff *skb,
-		    struct qeth_qdio_out_q *queue, int ipv,
-		    int cast_type)
+qeth_do_send_packet_fast(struct qeth_card *card, struct qeth_qdio_out_q *queue,
+			 struct sk_buff *skb, struct qeth_hdr *hdr,
+			 int elements_needed)
+{
+	struct qeth_qdio_out_buffer *buffer;
+	int index;
+	int rc = 0;
+
+	QETH_DBF_TEXT(trace, 6, "dosndpfa");
+
+	spin_lock(&queue->lock);
+	/* do we have empty buffers? */
+	if (atomic_read(&queue->used_buffers) >= (QDIO_MAX_BUFFERS_PER_Q - 1)){
+		card->stats.tx_dropped++;
+		rc = -EBUSY;
+		spin_unlock(&queue->lock);
+		goto out;
+	}
+	index = queue->next_buf_to_fill;
+	buffer = &queue->bufs[queue->next_buf_to_fill];
+	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
+	queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
+				  QDIO_MAX_BUFFERS_PER_Q;
+	atomic_inc(&queue->used_buffers);
+	spin_unlock(&queue->lock);
+
+	/* go on sending ... */
+	netif_wake_queue(skb->dev);
+	qeth_fill_buffer(queue, buffer, (char *)hdr, skb);
+	qeth_flush_buffers(queue, 0, index, 1);
+out:
+	return rc;
+}
+
+static inline int
+qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
+		    struct sk_buff *skb, struct qeth_hdr *hdr,
+		    int elements_needed)
 {
-	struct qeth_hdr *hdr;
 	struct qeth_qdio_out_buffer *buffer;
-	int elements_needed;
 	int start_index;
 	int flush_count = 0;
-	int rc;
+	int rc = 0;
 
 	QETH_DBF_TEXT(trace, 6, "dosndpkt");
 
-	if ((rc = qeth_prepare_skb(card, &skb, &hdr, ipv))){
-		QETH_DBF_TEXT_(trace, 4, "1err%d", rc);
-		return rc;
-	}
-	qeth_fill_header(card, hdr, skb, ipv, cast_type);
-	elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE) + skb->len)
-				>> PAGE_SHIFT);
-	if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
-		PRINT_ERR("qeth_do_send_packet: invalid size of "
-				 "IP packet. Discarded.");
-		return -EINVAL;
-	}
-
 	spin_lock(&queue->lock);
+	/* do we have empty buffers? */
+	if (atomic_read(&queue->used_buffers) >= (QDIO_MAX_BUFFERS_PER_Q - 2)){
+		card->stats.tx_dropped++;
+		rc = -EBUSY;
+		goto out;
+	}
 	start_index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
 	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
@@ -3657,12 +3760,8 @@
 		}
 	}
 
-	rc = qeth_fill_buffer(queue, buffer, (char *)hdr, skb);
-	if (rc) {
-		PRINT_WARN("qeth_do_send_packet: error during "
-			      "qeth_fill_buffer.");
-		card->stats.tx_dropped++;
-	} else if (buffer->state == QETH_QDIO_BUF_PRIMED){
+	qeth_fill_buffer(queue, buffer, (char *)hdr, skb);
+	if (buffer->state == QETH_QDIO_BUF_PRIMED){
 		/* next time fill the next buffer */
 		flush_count++;
 		atomic_inc(&queue->used_buffers);
@@ -3670,15 +3769,14 @@
 			QDIO_MAX_BUFFERS_PER_Q;
 	}
 	/* check if we need to switch packing state of this queue */
-	if (card->info.type != QETH_CARD_TYPE_IQD)
-		flush_count += qeth_switch_packing_state(queue);
+	flush_count += qeth_switch_packing_state(queue);
 
 	if (flush_count)
 		qeth_flush_buffers(queue, 0, start_index, flush_count);
 
 	if (!atomic_read(&queue->set_pci_flags_count))
 		qeth_flush_buffers_on_no_pci(queue, 0);
-
+out:
 	spin_unlock(&queue->lock);
 
 	return rc;
@@ -3690,6 +3788,8 @@
 	int ipv;
 	int cast_type;
 	struct qeth_qdio_out_q *queue;
+	struct qeth_hdr *hdr;
+	int elements_needed;
 	int rc;
 
 	QETH_DBF_TEXT(trace, 6, "sendpkt");
@@ -3698,16 +3798,26 @@
 	cast_type = qeth_get_cast_type(card, skb);
 	queue = card->qdio.out_qs
 		[qeth_get_priority_queue(card, skb, ipv, cast_type)];
-	/* do we have empty buffers? */
-	rc = (atomic_read(&queue->used_buffers) >=
-	      QDIO_MAX_BUFFERS_PER_Q - 1) ? -EBUSY : 0;
-	if (rc) {
-		card->stats.tx_dropped++;
+
+	if ((rc = qeth_prepare_skb(card, &skb, &hdr, ipv))){
 		QETH_DBF_TEXT_(trace, 4, "1err%d", rc);
 		return rc;
 	}
+	qeth_fill_header(card, hdr, skb, ipv, cast_type);
+	elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE) + skb->len)
+				>> PAGE_SHIFT);
+	if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
+		PRINT_ERR("qeth_do_send_packet: invalid size of "
+				 "IP packet. Discarded.");
+		return -EINVAL;
+	}
 
-	rc = qeth_do_send_packet(card, skb, queue, ipv, cast_type);
+	if (card->info.type != QETH_CARD_TYPE_IQD)
+		rc = qeth_do_send_packet(card, queue, skb, hdr,
+					 elements_needed);
+	else
+		rc = qeth_do_send_packet_fast(card, queue, skb, hdr,
+					      elements_needed);
 
 	if (!rc){
 		card->stats.tx_packets++;
@@ -3864,6 +3974,25 @@
 	return rc;
 }
 
+static inline void
+qeth_copy_arp_entries_stripped(struct qeth_arp_query_info *qinfo,
+		               struct qeth_arp_query_data *qdata,
+			       int entry_size, int uentry_size)
+{
+	char *entry_ptr;
+	char *uentry_ptr;
+	int i;
+
+	entry_ptr = (char *)&qdata->data;
+	uentry_ptr = (char *)(qinfo->udata + qinfo->udata_offset);
+	for (i = 0; i < qdata->no_entries; ++i){
+		/* strip off 32 bytes "media specific information" */
+		memcpy(uentry_ptr, (entry_ptr + 32), entry_size - 32);
+		entry_ptr += entry_size;
+		uentry_ptr += uentry_size;
+	}
+}
+
 static int
 qeth_arp_query_cb(struct qeth_card *card, struct qeth_reply *reply,
 		  unsigned long data)
@@ -3872,6 +4001,7 @@
 	struct qeth_arp_query_data *qdata;
 	struct qeth_arp_query_info *qinfo;
 	int entry_size;
+	int uentry_size;
 	int i;
 
 	QETH_DBF_TEXT(trace,4,"arpquecb");
@@ -3890,37 +4020,54 @@
 	qdata = &cmd->data.setassparms.data.query_arp;
 	switch(qdata->reply_bits){
 	case 5:
-		entry_size = sizeof(struct qeth_arp_qi_entry5);
+		uentry_size = entry_size = sizeof(struct qeth_arp_qi_entry5);
+		if (qinfo->mask_bits & QETH_QARP_STRIP_ENTRIES)
+			uentry_size = sizeof(struct qeth_arp_qi_entry5_short);
 		break;
 	case 7:
-		entry_size = sizeof(struct qeth_arp_qi_entry7);
-		break;
+		/* fall through to default */
 	default:
 		/* tr is the same as eth -> entry7 */
-		entry_size = sizeof(struct qeth_arp_qi_entry7);
+		uentry_size = entry_size = sizeof(struct qeth_arp_qi_entry7);
+		if (qinfo->mask_bits & QETH_QARP_STRIP_ENTRIES)
+			uentry_size = sizeof(struct qeth_arp_qi_entry7_short);
 		break;
 	}
 	/* check if there is enough room in userspace */
 	if ((qinfo->udata_len - qinfo->udata_offset) <
-			qdata->no_entries * entry_size){
+			qdata->no_entries * uentry_size){
 		QETH_DBF_TEXT_(trace, 4, "qaer3%i", -ENOMEM);
 		cmd->hdr.return_code = -ENOMEM;
+		PRINT_WARN("query ARP user space buffer is too small for "
+			   "the returned number of ARP entries. "
+			   "Aborting query!\n");
 		goto out_error;
 	}
 	QETH_DBF_TEXT_(trace, 4, "anore%i",
 		       cmd->data.setassparms.hdr.number_of_replies);
 	QETH_DBF_TEXT_(trace, 4, "aseqn%i", cmd->data.setassparms.hdr.seq_no);
 	QETH_DBF_TEXT_(trace, 4, "anoen%i", qdata->no_entries);
-	/*copy entries to user buffer*/
-	memcpy(qinfo->udata + qinfo->udata_offset,
-	       (char *)&qdata->data, qdata->no_entries*entry_size);
+
+	if (qinfo->mask_bits & QETH_QARP_STRIP_ENTRIES) {
+		/* strip off "media specific information" */
+		qeth_copy_arp_entries_stripped(qinfo, qdata, entry_size,
+					       uentry_size);
+	} else
+		/*copy entries to user buffer*/
+		memcpy(qinfo->udata + qinfo->udata_offset,
+		       (char *)&qdata->data, qdata->no_entries*uentry_size);
+
 	qinfo->no_entries += qdata->no_entries;
-	qinfo->udata_offset += (qdata->no_entries*entry_size);
+	qinfo->udata_offset += (qdata->no_entries*uentry_size);
 	/* check if all replies received ... */
 	if (cmd->data.setassparms.hdr.seq_no <
 	    cmd->data.setassparms.hdr.number_of_replies)
 		return 1;
 	memcpy(qinfo->udata, &qinfo->no_entries, 4);
+	/* keep STRIP_ENTRIES flag so the user program can distinguish
+	 * stripped entries from normal ones */
+	if (qinfo->mask_bits & QETH_QARP_STRIP_ENTRIES)
+		qdata->reply_bits |= QETH_QARP_STRIP_ENTRIES;
 	memcpy(qinfo->udata + QETH_QARP_MASK_OFFSET,&qdata->reply_bits,2);
 	return 0;
 out_error:
@@ -3975,8 +4122,8 @@
 			   "on %s!\n", card->info.if_name);
 		return -EOPNOTSUPP;
 	}
-
-	if (copy_from_user(&qinfo.udata_len, udata, 4))
+	/* get size of userspace buffer and mask_bits -> 6 bytes */
+	if (copy_from_user(&qinfo, udata, 6))
 		return -EFAULT;
 	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL)))
 		return -ENOMEM;
@@ -4004,6 +4151,140 @@
 	return rc;
 }
 
+/**
+ * SNMP command callback
+ */
+static int
+qeth_snmp_command_cb(struct qeth_card *card, struct qeth_reply *reply,
+		     unsigned long sdata)
+{
+	struct qeth_ipa_cmd *cmd;
+	struct qeth_arp_query_info *qinfo;
+	struct qeth_snmp_cmd *snmp;
+	unsigned char *data;
+	__u16 data_len;
+
+	QETH_DBF_TEXT(trace,3,"snpcmdcb");
+
+	cmd = (struct qeth_ipa_cmd *) sdata;
+	data = (unsigned char *)((char *)cmd - reply->offset);
+	qinfo = (struct qeth_arp_query_info *) reply->param;
+	snmp = &cmd->data.setadapterparms.data.snmp;
+
+	if (cmd->hdr.return_code) {
+		QETH_DBF_TEXT_(trace,4,"scer1%i", cmd->hdr.return_code);
+		return 0;
+	}
+	if (cmd->data.setadapterparms.hdr.return_code) {
+		cmd->hdr.return_code = cmd->data.setadapterparms.hdr.return_code;
+		QETH_DBF_TEXT_(trace,4,"scer2%i", cmd->hdr.return_code);
+		return 0;
+	}
+	data_len = *((__u16*)QETH_IPA_PDU_LEN_PDU1(data));
+	if (cmd->data.setadapterparms.hdr.seq_no == 1)
+		data_len -= (__u16)((char*)&snmp->request - (char *)cmd);
+	else
+		data_len -= (__u16)((char *)&snmp->data - (char *)cmd);
+	/* check if there is enough room in userspace */
+	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
+		QETH_DBF_TEXT_(trace, 4, "scer3%i", -ENOMEM);
+		cmd->hdr.return_code = -ENOMEM;
+		return 0;
+	}
+	QETH_DBF_TEXT_(trace, 4, "snore%i",
+		       cmd->data.setadapterparms.hdr.used_total);
+	QETH_DBF_TEXT_(trace, 4, "sseqn%i", cmd->data.setassparms.hdr.seq_no);
+	/*copy entries to user buffer*/
+	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
+		memcpy(qinfo->udata + qinfo->udata_offset,
+		       (char *)snmp,offsetof(struct qeth_snmp_cmd,data));
+		qinfo->udata_offset += offsetof(struct qeth_snmp_cmd, data);
+	}
+	memcpy(qinfo->udata + qinfo->udata_offset,
+	       (char *)&snmp->data, data_len);
+	qinfo->udata_offset += data_len;
+	/* check if all replies received ... */
+		QETH_DBF_TEXT_(trace, 4, "srtot%i",
+			       cmd->data.setadapterparms.hdr.used_total);
+		QETH_DBF_TEXT_(trace, 4, "srseq%i",
+			       cmd->data.setadapterparms.hdr.seq_no);
+	if (cmd->data.setadapterparms.hdr.seq_no <
+	    cmd->data.setadapterparms.hdr.used_total)
+		return 1;
+	return 0;
+
+}
+
+static struct qeth_cmd_buffer *
+qeth_get_ipacmd_buffer(struct qeth_card *, enum qeth_ipa_cmds,
+		       enum qeth_prot_versions );
+
+static struct qeth_cmd_buffer *
+qeth_get_adapter_cmd(struct qeth_card *card, __u32 command, __u32 cmdlen)
+{
+	struct qeth_cmd_buffer *iob;
+	struct qeth_ipa_cmd *cmd;
+
+	iob = qeth_get_ipacmd_buffer(card,IPA_CMD_SETADAPTERPARMS,
+				     QETH_PROT_IPV4);
+	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd->data.setadapterparms.hdr.cmdlength = cmdlen;
+	cmd->data.setadapterparms.hdr.command_code = command;
+	cmd->data.setadapterparms.hdr.used_total = 1;
+	cmd->data.setadapterparms.hdr.seq_no = 1;
+
+	return iob;
+}
+
+/**
+ * function to send SNMP commands to OSA-E card
+ */
+static int
+qeth_snmp_command(struct qeth_card *card, char *udata)
+{
+	struct qeth_cmd_buffer *iob;
+	struct qeth_ipa_cmd *cmd;
+	struct qeth_snmp_ureq ureq;
+	struct qeth_arp_query_info qinfo = {0, };
+	int rc = 0;
+
+	QETH_DBF_TEXT(trace,3,"snmpcmd");
+
+	if (card->info.guestlan)
+		return -EOPNOTSUPP;
+	if (!qeth_adp_supported(card,IPA_SETADP_SET_SNMP_CONTROL)) {
+		PRINT_WARN("SNMP Query MIBS not supported "
+			   "on %s!\n", card->info.if_name);
+		return -EOPNOTSUPP;
+	}
+	if (copy_from_user(&ureq, udata, sizeof(struct qeth_snmp_ureq)))
+		return -EFAULT;
+	qinfo.udata_len = ureq.hdr.data_len;
+	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL)))
+		return -ENOMEM;
+	memset(qinfo.udata, 0, qinfo.udata_len);
+	qinfo.udata_offset = sizeof(struct qeth_snmp_ureq_hdr);
+
+	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL,
+				   QETH_SNMP_SETADP_CMDLENGTH+ureq.hdr.req_len);
+	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	memcpy(&cmd->data.setadapterparms.data.snmp, &ureq.cmd,
+	       sizeof(struct qeth_snmp_cmd));
+	rc = qeth_send_ipa_arp_cmd(card, iob,
+				   QETH_SETADP_BASE_LEN + QETH_ARP_DATA_SIZE +
+				   ureq.hdr.req_len, qeth_snmp_command_cb,
+				   (void *)&qinfo);
+	if (rc)
+		PRINT_WARN("SNMP command failed on %s: (0x%x)\n",
+			   card->info.if_name, rc);
+	 else
+		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
+
+
+	kfree(qinfo.udata);
+	return rc;
+}
+
 static int
 qeth_default_setassparms_cb(struct qeth_card *, struct qeth_reply *,
 			    unsigned long);
@@ -4192,6 +4473,7 @@
 		rc = qeth_arp_flush_cache(card);
 		break;
 	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
+		rc = qeth_snmp_command(card, rq->ifr_ifru.ifru_data);
 		break;
 	case SIOC_QETH_GET_CARD_TYPE:
 		break;
@@ -4955,23 +5237,6 @@
 	return rc;
 }
 
-static struct qeth_cmd_buffer *
-qeth_get_adapter_cmd(struct qeth_card *card, __u32 command, __u32 cmdlen)
-{
-	struct qeth_cmd_buffer *iob;
-	struct qeth_ipa_cmd *cmd;
-
-	iob = qeth_get_ipacmd_buffer(card,IPA_CMD_SETADAPTERPARMS,
-				     QETH_PROT_IPV4);
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	cmd->data.setadapterparms.hdr.cmdlength = cmdlen;
-	cmd->data.setadapterparms.hdr.command_code = command;
-	cmd->data.setadapterparms.hdr.used_total = 1;
-	cmd->data.setadapterparms.hdr.seq_no = 1;
-
-	return iob;
-}
-
 static int
 qeth_default_setassparms_cb(struct qeth_card *card, struct qeth_reply *reply,
 			    unsigned long data)
@@ -6174,7 +6439,7 @@
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (recover_flag == CARD_STATE_RECOVER)
 		qeth_start_again(card);
-
+	qeth_notify_processes();
 	return 0;
 out_remove:
 	card->use_hard_stop = 1;
@@ -6848,6 +7113,8 @@
 		   QETH_VERSION_VLAN);
 
 	INIT_LIST_HEAD(&qeth_card_list.list);
+	INIT_LIST_HEAD(&qeth_notify_list);
+	spin_lock_init(&qeth_notify_lock);
 	rwlock_init(&qeth_card_list.rwlock);
 
 	if (qeth_register_dbf_views())
diff -urN linux-2.6/drivers/s390/net/qeth_mpc.h linux-2.6-s390/drivers/s390/net/qeth_mpc.h
--- linux-2.6/drivers/s390/net/qeth_mpc.h	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_mpc.h	Wed May 19 12:47:28 2004
@@ -14,7 +14,7 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.34 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.35 $"
 
 extern const char *VERSION_QETH_MPC_C;
 
@@ -258,6 +258,7 @@
 /* used as parameter for arp_query reply */
 struct qeth_arp_query_info {
 	__u32 udata_len;
+	__u16 mask_bits;
 	__u32 udata_offset;
 	__u32 no_entries;
 	char *udata;
@@ -296,6 +297,29 @@
 	__u8 addr[OSA_ADDR_LEN];
 } __attribute__ ((packed));
 
+
+struct qeth_snmp_cmd {
+	__u8  token[16];
+	__u32 request;
+	__u32 interface;
+	__u32 returncode;
+	__u32 firmwarelevel;
+	__u32 seqno;
+	__u8  data;
+} __attribute__ ((packed));
+
+struct qeth_snmp_ureq_hdr {
+	__u32   data_len;
+	__u32   req_len;
+	__u32   reserved1;
+	__u32   reserved2;
+} __attribute__ ((packed));
+
+struct qeth_snmp_ureq {
+	struct qeth_snmp_ureq_hdr hdr;
+	struct qeth_snmp_cmd cmd;
+} __attribute__((packed));
+
 struct qeth_ipacmd_setadpparms_hdr {
 	__u32 supp_hw_cmds;
 	__u32 reserved1;
@@ -313,6 +337,7 @@
 	union {
 		struct qeth_query_cmds_supp query_cmds_supp;
 		struct qeth_change_addr change_addr;
+		struct qeth_snmp_cmd snmp;
 		__u32 mode;
 	} data;
 } __attribute__ ((packed));
diff -urN linux-2.6/drivers/s390/net/qeth_proc.c linux-2.6-s390/drivers/s390/net/qeth_proc.c
--- linux-2.6/drivers/s390/net/qeth_proc.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_proc.c	Wed May 19 12:47:28 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.9 $)
+ * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.10 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to procfs.
@@ -21,7 +21,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_PROC_C = "$Revision: 1.9 $";
+const char *VERSION_QETH_PROC_C = "$Revision: 1.10 $";
 
 /***** /proc/qeth *****/
 #define QETH_PROCFILE_NAME "qeth"
@@ -237,9 +237,11 @@
 		   card->perf_stats.bufs_sent_pack
 		  );
 	seq_printf(s, "  Packing state changes no pkg.->packing : %i/%i\n"
+		      "  Watermarks L/H                         : %i/%i\n"
 		      "  Current buffer usage (outbound q's)    : "
 		      "%i/%i/%i/%i\n\n",
 		        card->perf_stats.sc_dp_p, card->perf_stats.sc_p_dp,
+			QETH_LOW_WATERMARK_PACK, QETH_HIGH_WATERMARK_PACK,
 			atomic_read(&card->qdio.out_qs[0]->used_buffers),
 			(card->qdio.no_out_queues > 1)?
 				atomic_read(&card->qdio.out_qs[1]->used_buffers)
@@ -251,20 +253,26 @@
 				atomic_read(&card->qdio.out_qs[3]->used_buffers)
 				: 0
 		  );
-	seq_printf(s, "  Inbound time (in us)                   : %i\n"
-		      "  Inbound count                          : %i\n"
-		      "  Inboud do_QDIO count                   : %i\n"
+	seq_printf(s, "  Inbound handler time (in us)           : %i\n"
+		      "  Inbound handler count                  : %i\n"
+		      "  Inbound do_QDIO time (in us)           : %i\n"
+		      "  Inbound do_QDIO count                  : %i\n\n"
+		      "  Outbound handler time (in us)          : %i\n"
+		      "  Outbound handler count                 : %i\n\n"
 		      "  Outbound time (in us, incl QDIO)       : %i\n"
 		      "  Outbound count                         : %i\n"
-		      "  Outbound do_QDIO count                 : %i\n"
-		      "  Watermarks L/H                         : %i/%i\n\n",
+		      "  Outbound do_QDIO time (in us)          : %i\n"
+		      "  Outbound do_QDIO count                 : %i\n",
 		        card->perf_stats.inbound_time,
 			card->perf_stats.inbound_cnt,
-			card->perf_stats.inbound_do_qdio,
+		        card->perf_stats.inbound_do_qdio_time,
+			card->perf_stats.inbound_do_qdio_cnt,
+			card->perf_stats.outbound_handler_time,
+			card->perf_stats.outbound_handler_cnt,
 			card->perf_stats.outbound_time,
 			card->perf_stats.outbound_cnt,
-			card->perf_stats.outbound_do_qdio,
-			QETH_LOW_WATERMARK_PACK, QETH_HIGH_WATERMARK_PACK
+		        card->perf_stats.outbound_do_qdio_time,
+			card->perf_stats.outbound_do_qdio_cnt
 		  );
 
 	return 0;
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-s390/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_sys.c	Wed May 19 12:47:28 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.29 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.30 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.29 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.30 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -322,7 +322,8 @@
 		qeth_dev_bufcnt_store);
 
 static inline ssize_t
-qeth_dev_route_show(struct qeth_routing_info *route, char *buf)
+qeth_dev_route_show(struct qeth_card *card, struct qeth_routing_info *route,
+		    char *buf)
 {
 	switch (route->type) {
 	case PRIMARY_ROUTER:
@@ -330,11 +331,20 @@
 	case SECONDARY_ROUTER:
 		return sprintf(buf, "%s\n", "secondary router");
 	case MULTICAST_ROUTER:
-		return sprintf(buf, "%s\n", "multicast router");
+		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
+			return sprintf(buf, "%s\n", "multicast router+");
+		else
+			return sprintf(buf, "%s\n", "multicast router");
 	case PRIMARY_CONNECTOR:
-		return sprintf(buf, "%s\n", "primary connector");
+		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
+			return sprintf(buf, "%s\n", "primary connector+");
+		else
+			return sprintf(buf, "%s\n", "primary connector");
 	case SECONDARY_CONNECTOR:
-		return sprintf(buf, "%s\n", "secondary connector");
+		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
+			return sprintf(buf, "%s\n", "secondary connector+");
+		else
+			return sprintf(buf, "%s\n", "secondary connector");
 	default:
 		return sprintf(buf, "%s\n", "no");
 	}
@@ -348,7 +358,7 @@
 	if (!card)
 		return -EINVAL;
 
-	return qeth_dev_route_show(&card->options.route4, buf);
+	return qeth_dev_route_show(card, &card->options.route4, buf);
 }
 
 static inline ssize_t
@@ -416,7 +426,7 @@
 	if (!qeth_is_supported(card, IPA_IPV6))
 		return sprintf(buf, "%s\n", "n/a");
 
-	return qeth_dev_route_show(&card->options.route6, buf);
+	return qeth_dev_route_show(card, &card->options.route6, buf);
 }
 
 static ssize_t
@@ -1432,22 +1442,31 @@
 static DRIVER_ATTR(group, 0200, 0, qeth_driver_group_store);
 
 static ssize_t
-qeth_driver_snmp_register_show(struct device_driver *ddrv, char *buf)
-{
-	/* TODO */
-	return 0;
-}
-
-static ssize_t
-qeth_driver_snmp_register_store(struct device_driver *ddrv, const char *buf,
+qeth_driver_notifier_register_store(struct device_driver *ddrv, const char *buf,
 				size_t count)
 {
-	/* TODO */
+	int rc;
+	int signum;
+	char *tmp;
+
+	tmp = strsep((char **) &buf, "\n");
+	if (!strcmp(tmp, "unregister")){
+		return qeth_notifier_unregister(current);
+	}
+
+	signum = simple_strtoul(buf, &tmp, 10);
+	if ((signum < 0) || (signum > 32)){
+		PRINT_WARN("Signal number %d is out of range\n", signum);
+		return -EINVAL;
+	}
+	if ((rc = qeth_notifier_register(current, signum)))
+		return rc;
+
 	return count;
 }
 
-static DRIVER_ATTR(snmp_register, 0644, qeth_driver_snmp_register_show,
-		   qeth_driver_snmp_register_store);
+static DRIVER_ATTR(notifier_register, 0644, 0,
+		   qeth_driver_notifier_register_store);
 
 int
 qeth_create_driver_attributes(void)
@@ -1458,7 +1477,7 @@
 				     &driver_attr_group)))
 		return rc;
 	return driver_create_file(&qeth_ccwgroup_driver.driver,
-				  &driver_attr_snmp_register);
+				  &driver_attr_notifier_register);
 }
 
 void
@@ -1467,5 +1486,5 @@
 	driver_remove_file(&qeth_ccwgroup_driver.driver,
 			&driver_attr_group);
 	driver_remove_file(&qeth_ccwgroup_driver.driver,
-			&driver_attr_snmp_register);
+			&driver_attr_notifier_register);
 }
diff -urN linux-2.6/include/asm-s390/qeth.h linux-2.6-s390/include/asm-s390/qeth.h
--- linux-2.6/include/asm-s390/qeth.h	Wed May 19 12:47:10 2004
+++ linux-2.6-s390/include/asm-s390/qeth.h	Wed May 19 12:47:28 2004
@@ -8,8 +8,8 @@
  * Author(s):	Thomas Spatzier <tspat@de.ibm.com>
  *
  */
-#ifndef __ASM_S390_IOCTL_H__
-#define __ASM_S390_IOCTL_H__
+#ifndef __ASM_S390_QETH_IOCTL_H__
+#define __ASM_S390_QETH_IOCTL_H__
 #include <linux/ioctl.h>
 
 #define SIOC_QETH_ARP_SET_NO_ENTRIES    (SIOCDEVPRIVATE)
@@ -35,6 +35,13 @@
 	__u8 ipaddr[4];
 } __attribute__((packed));
 
+struct qeth_arp_qi_entry7_short {
+	__u8 macaddr_type;
+	__u8 ipaddr_type;
+	__u8 macaddr[6];
+	__u8 ipaddr[4];
+} __attribute__((packed));
+
 struct qeth_arp_qi_entry5 {
 	__u8 media_specific[32];
 	__u8 macaddr_type;
@@ -42,6 +49,19 @@
 	__u8 ipaddr[4];
 } __attribute__((packed));
 
+struct qeth_arp_qi_entry5_short {
+	__u8 macaddr_type;
+	__u8 ipaddr_type;
+	__u8 ipaddr[4];
+} __attribute__((packed));
+
+/*
+ * can be set by user if no "media specific information" is wanted
+ * -> saves a lot of space in user space buffer
+ */
+#define QETH_QARP_STRIP_ENTRIES  0x8000
+#define QETH_QARP_REQUEST_MASK   0x00ff
+
 /* data sent to user space as result of query arp ioctl */
 #define QETH_QARP_USER_DATA_SIZE 20000
 #define QETH_QARP_MASK_OFFSET    4
@@ -55,4 +75,4 @@
 	char *entries;
 } __attribute__((packed));
 
-#endif /* __ASM_S390_IOCTL_H__ */
+#endif /* __ASM_S390_QETH_IOCTL_H__ */
