Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUDUOua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUDUOua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUDUOua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:50:30 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33202 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S263149AbUDUOr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:47:29 -0400
Date: Wed, 21 Apr 2004 16:47:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/9): network device drivers.
Message-ID: <20040421144712.GE2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Network driver changes:
 - qeth: Fix reference counting in regard to sysfs backing store patches.
 - qeth: Prefix kernel thread names with qeth_.
 - qeth: Remove inbound and outbound tasklets. Handle buffers directly
         in the interrupts handlers.
 - iucv: Add missing kfree in iucv_register_program.
 - iucv: Add missing return in netiucv_transmit_skb.
 - iucv: Check for NULL pointer in conn_action_txdone.

diffstat:
 drivers/s390/net/iucv.c      |    7 
 drivers/s390/net/netiucv.c   |   18 +-
 drivers/s390/net/qeth.h      |    5 
 drivers/s390/net/qeth_main.c |  328 ++++++++++++++++++-------------------------
 4 files changed, 154 insertions(+), 204 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Sun Apr  4 05:36:18 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Wed Apr 21 16:29:37 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.27 2004/03/22 07:43:43 braunu Exp $
+ * $Id: iucv.c,v 1.28 2004/04/15 06:34:58 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.27 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.28 $
  *
  */
 
@@ -351,7 +351,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.27 $";
+	char vbuf[] = "$Revision: 1.28 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -800,6 +800,7 @@
 		if (iucv_pathid_table == NULL) {
 			printk(KERN_WARNING "%s: iucv_pathid_table storage "
 			       "allocation failed\n", __FUNCTION__);
+			kfree(new_handler);
 			return NULL;
 		}
 		memset (iucv_pathid_table, 0, max_connections * sizeof(handler *));
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Wed Apr 21 16:29:37 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.48 2004/04/01 13:42:09 braunu Exp $
+ * $Id: netiucv.c,v 1.49 2004/04/15 06:37:54 braunu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.48 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.49 $
  *
  */
 
@@ -601,11 +601,12 @@
 		if ((skb = skb_dequeue(&conn->commit_queue))) {
 			atomic_dec(&skb->users);
 			dev_kfree_skb_any(skb);
-		}
-		if (privptr) {
-			privptr->stats.tx_packets++;
-			privptr->stats.tx_bytes +=
-				(skb->len - NETIUCV_HDRLEN - NETIUCV_HDRLEN);
+			if (privptr) {
+				privptr->stats.tx_packets++;
+				privptr->stats.tx_bytes +=
+					(skb->len - NETIUCV_HDRLEN 
+					 	  - NETIUCV_HDRLEN);
+			}
 		}
 	}
 	conn->tx_buff->data = conn->tx_buff->tail = conn->tx_buff->head;
@@ -1078,6 +1079,7 @@
 				       "%s: Could not allocate tx_skb\n",
 				       conn->netdev->name);
 				rc = -ENOMEM;
+				return rc;
 			} else {
 				skb_reserve(nskb, NETIUCV_HDRLEN);
 				memcpy(skb_put(nskb, skb->len),
@@ -1880,7 +1882,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.48 $";
+	char vbuf[] = "$Revision: 1.49 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Wed Apr 21 16:29:37 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.98 $"
+#define VERSION_QETH_H 		"$Revision: 1.100 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -423,14 +423,12 @@
 	struct qeth_qdio_out_buffer bufs[QDIO_MAX_BUFFERS_PER_Q];
 	int queue_no;
 	struct qeth_card *card;
-	struct tasklet_struct tasklet;
 	spinlock_t lock;
 	volatile int do_pack;
 	/*
 	 * index of buffer to be filled by driver; state EMPTY or PACKING
 	 */
 	volatile int next_buf_to_fill;
-	volatile int next_buf_to_flush;
 	/*
 	 * number of buffers that are currently filled (PRIMED)
 	 * -> these buffers are hardware-owned
@@ -447,7 +445,6 @@
 	struct qeth_qdio_buffer_pool in_buf_pool;
 	struct qeth_qdio_buffer_pool init_pool;
 	int in_buf_size;
-	struct tasklet_struct in_tasklet;
 
 	/* output */
 	int no_out_queues;
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Wed Apr 21 16:29:37 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.77 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.82 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.77 $	 $Date: 2004/04/06 14:38:19 $
+ *    $Revision: 1.82 $	 $Date: 2004/04/21 08:27:21 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.77 $"
+#define VERSION_QETH_C "$Revision: 1.82 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
 	VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
 	QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -486,6 +486,7 @@
 	list_del(&card->list);
 	write_unlock_irqrestore(&qeth_card_list.rwlock, flags);
 	unregister_netdev(card->dev);
+	qeth_remove_device_attributes(&cgdev->dev);
 	qeth_free_card(card);
 	cgdev->dev.driver_data = NULL;
 	put_device(&cgdev->dev);
@@ -822,7 +823,7 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) ptr;
-	daemonize("getmcaddr");
+	daemonize("qeth_reg_mcaddrs");
 	QETH_DBF_TEXT(trace,4,"regmcth1");
 	if (!qeth_do_run_thread(card, QETH_SET_MC_THREAD))
 		return 0;
@@ -843,7 +844,7 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) ptr;
-	daemonize("regip");
+	daemonize("qeth_reg_ip");
 	QETH_DBF_TEXT(trace,4,"regipth1");
 	if (!qeth_do_run_thread(card, QETH_SET_IP_THREAD))
 		return 0;
@@ -860,7 +861,7 @@
 	int rc = 0;
 
 	card = (struct qeth_card *) ptr;
-	daemonize("recover");
+	daemonize("qeth_recover");
 	QETH_DBF_TEXT(trace,2,"recover1");
 	QETH_DBF_HEX(trace, 2, &card, sizeof(void *));
 	if (!qeth_do_run_thread(card, QETH_RECOVER_THREAD))
@@ -1969,45 +1970,6 @@
 	return rc;
 }
 
-static void
-qeth_qdio_input_handler(struct ccw_device * ccwdev, unsigned int status,
-		        unsigned int qdio_err, unsigned int siga_err,
-			unsigned int queue, int first_element, int count,
-			unsigned long card_ptr)
-{
-	struct net_device *net_dev;
-	struct qeth_card *card;
-	struct qeth_qdio_buffer *buffer;
-	int i;
-
-	QETH_DBF_TEXT(trace, 6, "qdinput");
-	card = (struct qeth_card *) card_ptr;
-	net_dev = card->dev;
-#ifdef CONFIG_QETH_PERF_STATS
-	card->perf_stats.inbound_start_time = qeth_get_micros();
-#endif
-	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
-		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION){
-			QETH_DBF_TEXT(trace, 1,"qdinchk");
-			QETH_DBF_TEXT_(trace,1,"%s",CARD_BUS_ID(card));
-			QETH_DBF_TEXT_(trace,1,"%04X%04X",first_element,count);
-			QETH_DBF_TEXT_(trace,1,"%04X%04X", queue, status);
-			qeth_schedule_recovery(card);
-			return;
-		}
-	}
-	for (i = first_element; i < (first_element + count); ++i) {
-		buffer = &card->qdio.in_q->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
-		if ((status == QDIO_STATUS_LOOK_FOR_ERROR) &&
-		    qeth_check_for_inbound_error(buffer, qdio_err, siga_err))
-			buffer->state = QETH_QDIO_BUF_ERROR;
-		else
-			buffer->state = QETH_QDIO_BUF_PRIMED;
-	}
-
-	tasklet_schedule(&card->qdio.in_tasklet);
-}
-
 static inline struct sk_buff *
 qeth_get_skb(unsigned int length)
 {
@@ -2127,7 +2089,6 @@
 	return htons(ETH_P_802_2);
 }
 
-
 static inline void
 qeth_rebuild_skb_fake_ll(struct qeth_card *card, struct sk_buff *skb,
 			 struct qeth_hdr *hdr)
@@ -2193,7 +2154,6 @@
 #endif /* CONFIG_QETH_VLAN */
 }
 
-
 static inline void
 qeth_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		 struct qeth_hdr *hdr)
@@ -2241,6 +2201,38 @@
 	qeth_rebuild_skb_vlan(card, skb, hdr);
 }
 
+static inline void
+qeth_process_inbound_buffer(struct qeth_card *card,
+			    struct qeth_qdio_buffer *buf, int index)
+{
+	struct qdio_buffer_element *element;
+	int offset;
+	struct sk_buff *skb;
+	struct qeth_hdr *hdr;
+	int rxrc;
+	
+	/* get first element of current buffer */
+	element = (struct qdio_buffer_element *)&buf->buffer->element[0];
+	offset = 0;
+#ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.bufs_rec++;
+#endif
+	while((skb = qeth_get_next_skb(card, buf->buffer, &element,
+				       &offset, &hdr))){
+		qeth_rebuild_skb(card, skb, hdr);
+
+#ifdef CONFIG_QETH_PERF_STATS
+		card->perf_stats.inbound_time += qeth_get_micros() -
+			card->perf_stats.inbound_start_time;
+		card->perf_stats.inbound_cnt++;
+#endif
+		skb->dev = card->dev;
+		rxrc = netif_rx(skb);
+		card->dev->last_rx = jiffies;
+		card->stats.rx_packets++;
+		card->stats.rx_bytes += skb->len;
+	}
+}
 
 static inline struct qeth_buffer_pool_entry *
 qeth_get_buffer_pool_entry(struct qeth_card *card)
@@ -2284,7 +2276,7 @@
 	buf->state = QETH_QDIO_BUF_EMPTY;
 }
 
-static void
+static inline void
 qeth_clear_output_buffer(struct qeth_card *card,
 			 struct qeth_qdio_out_buffer *buf)
 {
@@ -2355,61 +2347,43 @@
 }
 
 static void
-qeth_qdio_input_tasklet(unsigned long data)
+qeth_qdio_input_handler(struct ccw_device * ccwdev, unsigned int status,
+		        unsigned int qdio_err, unsigned int siga_err,
+			unsigned int queue, int first_element, int count,
+			unsigned long card_ptr)
 {
-	struct qeth_card *card = (struct qeth_card *) data;
-	int current_buf = card->qdio.in_q->next_buf_to_process;
-	struct qeth_qdio_buffer *buf;
-	struct qdio_buffer_element *element;
-	int offset;
-	struct sk_buff *skb;
-	struct qeth_hdr *hdr;
-	int rxrc;
-
-	QETH_DBF_TEXT(trace,6,"qdintlet");
-	buf = &card->qdio.in_q->bufs[current_buf];
-	while((buf->state == QETH_QDIO_BUF_PRIMED) ||
-	      (buf->state == QETH_QDIO_BUF_ERROR)){
-		if (buf->state == QETH_QDIO_BUF_ERROR)
-			goto clear_buffer;
-		if (netif_queue_stopped(card->dev))
-			goto clear_buffer;
-		/* get first element of current buffer */
-		element = (struct qdio_buffer_element *)
-			&buf->buffer->element[0];
-		offset = 0;
-#ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.bufs_rec++;
-#endif
-		while((skb = qeth_get_next_skb(card, buf->buffer, &element,
-					       &offset, &hdr))){
+	struct net_device *net_dev;
+	struct qeth_card *card;
+	struct qeth_qdio_buffer *buffer;
+	int index;
+	int i;
 
-			qeth_rebuild_skb(card, skb, hdr);
+	QETH_DBF_TEXT(trace, 6, "qdinput");
+	card = (struct qeth_card *) card_ptr;
+	net_dev = card->dev;
 #ifdef CONFIG_QETH_PERF_STATS
-			card->perf_stats.inbound_time += qeth_get_micros() -
-				card->perf_stats.inbound_start_time;
-			card->perf_stats.inbound_cnt++;
+	card->perf_stats.inbound_start_time = qeth_get_micros();
 #endif
-			skb->dev = card->dev;
-			if (netif_queue_stopped(card->dev)) {
-				dev_kfree_skb_irq(skb);
-				card->stats.rx_dropped++;
-			} else {
-				rxrc = netif_rx(skb);
-				card->dev->last_rx = jiffies;
-				card->stats.rx_packets++;
-				card->stats.rx_bytes += skb->len;
-			}
+	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
+		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION){
+			QETH_DBF_TEXT(trace, 1,"qdinchk");
+			QETH_DBF_TEXT_(trace,1,"%s",CARD_BUS_ID(card));
+			QETH_DBF_TEXT_(trace,1,"%04X%04X",first_element,count);
+			QETH_DBF_TEXT_(trace,1,"%04X%04X", queue, status);
+			qeth_schedule_recovery(card);
+			return;
 		}
-clear_buffer:
-		qeth_put_buffer_pool_entry(card, buf->pool_entry);
-		/* give buffer back to hardware */
-		qeth_queue_input_buffer(card, current_buf);
-		current_buf = (current_buf + 1) % QDIO_MAX_BUFFERS_PER_Q;
-		buf = &card->qdio.in_q->bufs[current_buf];
 	}
-	/* set index for next time the tasklet is scheduled */
-	card->qdio.in_q->next_buf_to_process = current_buf;
+	for (i = first_element; i < (first_element + count); ++i) {
+		index = i % QDIO_MAX_BUFFERS_PER_Q;
+		buffer = &card->qdio.in_q->bufs[index];
+		if (!((status == QDIO_STATUS_LOOK_FOR_ERROR) &&
+		      qeth_check_for_inbound_error(buffer, qdio_err, siga_err)))
+			qeth_process_inbound_buffer(card, buffer, index);
+		/* clear buffer and give back to hardware */
+		qeth_put_buffer_pool_entry(card, buffer->pool_entry);
+		qeth_queue_input_buffer(card, index);
+	}
 }
 
 static inline int
@@ -2524,10 +2498,11 @@
  * switches between PACKING and non-PACKING state if needed.
  * has to be called holding queue->lock
  */
-static inline void
+static inline int
 qeth_switch_packing_state(struct qeth_qdio_out_q *queue)
 {
 	struct qeth_qdio_out_buffer *buffer;
+	int flush_count = 0;
 
 	QETH_DBF_TEXT(trace, 6, "swipack");
 	if (!queue->do_pack) {
@@ -2554,6 +2529,7 @@
 			BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
 			if (buffer->next_element_to_fill > 0) {
 				buffer->state = QETH_QDIO_BUF_PRIMED;
+				flush_count++;
 				atomic_inc(&queue->used_buffers);
 				queue->next_buf_to_fill =
 					(queue->next_buf_to_fill + 1) %
@@ -2561,6 +2537,25 @@
 		 	}
 		}
 	}
+	return flush_count;
+}
+
+static inline void
+qeth_flush_buffers_on_no_pci(struct qeth_qdio_out_q *queue, int under_int)
+{
+	struct qeth_qdio_out_buffer *buffer;
+	
+	buffer = &queue->bufs[queue->next_buf_to_fill];
+	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
+	if (buffer->next_element_to_fill > 0){
+		/* it's a packing buffer */
+		buffer->state = QETH_QDIO_BUF_PRIMED;
+		atomic_inc(&queue->used_buffers);
+		qeth_flush_buffers(queue, under_int, queue->next_buf_to_fill,
+				   1);
+		queue->next_buf_to_fill =
+			(queue->next_buf_to_fill + 1) % QDIO_MAX_BUFFERS_PER_Q;
+	}
 }
 
 static void
@@ -2603,58 +2598,12 @@
 			atomic_dec(&queue->set_pci_flags_count);
 
 		qeth_clear_output_buffer(card, buffer);
+		atomic_dec(&queue->used_buffers);
 	}
-	atomic_sub(count, &queue->used_buffers);
-
-	//if (!atomic_read(&queue->set_pci_flags_count))
-		tasklet_schedule(&queue->tasklet);
 
 	netif_wake_queue(card->dev);
 }
 
-static void
-qeth_qdio_output_tasklet(unsigned long data)
-{
-	struct qeth_qdio_out_q *queue = (struct qeth_qdio_out_q *) data;
-	struct qeth_qdio_out_buffer *buffer;
-	int index;
-	int count;
-
-	QETH_DBF_TEXT(trace, 6, "outtlet");
-
-	/* flush all PRIMED buffers */
-	index = queue->next_buf_to_flush;
-	count = 0;
-	while (queue->bufs[index].state == QETH_QDIO_BUF_PRIMED) {
-		count++;
-		index = (index + 1) % QDIO_MAX_BUFFERS_PER_Q;
-	}
-	qeth_flush_buffers(queue, 0, queue->next_buf_to_flush, count);
-	queue->next_buf_to_flush = index;
-
-	/* flush a buffer with data, if no more PCIs are
-	 * outstanding */
-	if (!atomic_read(&queue->set_pci_flags_count)){
-		spin_lock(&queue->lock);
-		buffer = &queue->bufs[index];
-		if (buffer->state == QETH_QDIO_BUF_PRIMED){
-			qeth_flush_buffers(queue, 0, index, 1);
-			index = (index + 1) % QDIO_MAX_BUFFERS_PER_Q;
-			queue->next_buf_to_flush = index;
-		} else if (buffer->next_element_to_fill > 0){
-			/* it's a packing buffer */
-			BUG_ON(index != queue->next_buf_to_fill);
-			buffer->state = QETH_QDIO_BUF_PRIMED;
-			atomic_inc(&queue->used_buffers);
-			qeth_flush_buffers(queue, 0, index, 1);
-			index = (index + 1) % QDIO_MAX_BUFFERS_PER_Q;
-			queue->next_buf_to_flush = index;
-			queue->next_buf_to_fill = index;
-		}
-		spin_unlock(&queue->lock);
-	}
-}
-
 static char*
 qeth_create_qib_param_field(struct qeth_card *card)
 {
@@ -2858,8 +2807,6 @@
 	card->qdio.in_buf_pool.buf_count = card->qdio.init_pool.buf_count;
 	INIT_LIST_HEAD(&card->qdio.in_buf_pool.entry_list);
 	INIT_LIST_HEAD(&card->qdio.init_pool.entry_list);
-	card->qdio.in_tasklet.data = (unsigned long) card;
-	card->qdio.in_tasklet.func = qeth_qdio_input_tasklet;
 	/* outbound */
 	card->qdio.do_prio_queueing = QETH_PRIOQ_DEFAULT;
 	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
@@ -2903,13 +2850,9 @@
 		}
 		card->qdio.out_qs[i]->card = card;
 		card->qdio.out_qs[i]->next_buf_to_fill = 0;
-		card->qdio.out_qs[i]->next_buf_to_flush = 0;
 		card->qdio.out_qs[i]->do_pack = 0;
 		atomic_set(&card->qdio.out_qs[i]->used_buffers,0);
 		atomic_set(&card->qdio.out_qs[i]->set_pci_flags_count, 0);
-		card->qdio.out_qs[i]->tasklet.data =
-			(unsigned long) card->qdio.out_qs[i];
-		card->qdio.out_qs[i]->tasklet.func = qeth_qdio_output_tasklet;
 		spin_lock_init(&card->qdio.out_qs[i]->lock);
 	}
 	return 0;
@@ -3653,6 +3596,8 @@
 	struct qeth_hdr *hdr;
 	struct qeth_qdio_out_buffer *buffer;
 	int elements_needed;
+	int start_index;
+	int flush_count = 0;
 	int rc;
 
 	QETH_DBF_TEXT(trace, 6, "dosndpkt");
@@ -3671,9 +3616,7 @@
 	}
 
 	spin_lock(&queue->lock);
-	/* check if we need to switch packing state of this queue */
-	if (card->info.type != QETH_CARD_TYPE_IQD)
-		qeth_switch_packing_state(queue);
+	start_index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
 	BUG_ON(buffer->state == QETH_QDIO_BUF_PRIMED);
 	if (queue->do_pack){
@@ -3682,6 +3625,7 @@
 				< elements_needed){
 			/* ... no -> set state PRIMED */
 			buffer->state = QETH_QDIO_BUF_PRIMED;
+			flush_count++;
 			atomic_inc(&queue->used_buffers);
 			queue->next_buf_to_fill =
 				(queue->next_buf_to_fill + 1) %
@@ -3695,19 +3639,25 @@
 		PRINT_WARN("qeth_do_send_packet: error during "
 			      "qeth_fill_buffer.");
 		card->stats.tx_dropped++;
-		spin_unlock(&queue->lock);
-		return rc;
-	}
-	if (buffer->state == QETH_QDIO_BUF_PRIMED){
+	} else if (buffer->state == QETH_QDIO_BUF_PRIMED){
 		/* next time fill the next buffer */
+		flush_count++;
 		atomic_inc(&queue->used_buffers);
 		queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
 			QDIO_MAX_BUFFERS_PER_Q;
 	}
+	/* check if we need to switch packing state of this queue */
+	if (card->info.type != QETH_CARD_TYPE_IQD)
+		flush_count += qeth_switch_packing_state(queue);
+	
+	if (flush_count)
+		qeth_flush_buffers(queue, 0, start_index, flush_count);
+
+	if (!atomic_read(&queue->set_pci_flags_count))
+		qeth_flush_buffers_on_no_pci(queue, 0);
+	
 	spin_unlock(&queue->lock);
-
-	tasklet_schedule(&queue->tasklet);
-
+	
 	return rc;
 }
 
@@ -4424,6 +4374,10 @@
 		if (!ipm->is_multicast)
 			continue;
 		iptodo = qeth_get_addr_buffer(ipm->proto);
+		if (!iptodo) {
+			QETH_DBF_TEXT(trace, 2, "dmcnomem");
+			continue;
+		}
 		memcpy(iptodo, ipm, sizeof(struct qeth_ipaddr));
 		iptodo->users = iptodo->users * -1;
 		if (!__qeth_insert_ip_todo(card, iptodo, 0))
@@ -4694,14 +4648,14 @@
 
 	if (addr->proto == QETH_PROT_IPV4) {
 		QETH_DBF_TEXT(trace, 2,"setaddr4");
-		QETH_DBF_HEX(trace, 4, &addr->u.a4.addr, sizeof(int));
+		QETH_DBF_HEX(trace, 3, &addr->u.a4.addr, sizeof(int));
 	} else if (addr->proto == QETH_PROT_IPV6) {
 		QETH_DBF_TEXT(trace, 2, "setaddr6");
-		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,4);
-		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+4,4);
+		QETH_DBF_HEX(trace,3,&addr->u.a6.addr,8);
+		QETH_DBF_HEX(trace,3,((char *)&addr->u.a6.addr)+8,8);
 	} else {
 		QETH_DBF_TEXT(trace, 2, "setaddr?");
-		QETH_DBF_HEX(trace, 4, addr, sizeof(struct qeth_ipaddr));
+		QETH_DBF_HEX(trace, 3, addr, sizeof(struct qeth_ipaddr));
 	}
 	do {
 		if (addr->is_multicast)
@@ -4732,14 +4686,14 @@
 
 	if (addr->proto == QETH_PROT_IPV4) {
 		QETH_DBF_TEXT(trace, 2,"deladdr4");
-		QETH_DBF_HEX(trace, 2, &addr->u.a4.addr, sizeof(int));
+		QETH_DBF_HEX(trace, 3, &addr->u.a4.addr, sizeof(int));
 	} else if (addr->proto == QETH_PROT_IPV6) {
 		QETH_DBF_TEXT(trace, 2, "deladdr6");
-		QETH_DBF_HEX(trace, 2, &addr->u.a6.addr,
-			     sizeof(struct in6_addr));
+		QETH_DBF_HEX(trace,3,&addr->u.a6.addr,8);
+		QETH_DBF_HEX(trace,3,((char *)&addr->u.a6.addr)+8,8);
 	} else {
 		QETH_DBF_TEXT(trace, 2, "deladdr?");
-		QETH_DBF_HEX(trace, 2, addr, sizeof(struct qeth_ipaddr));
+		QETH_DBF_HEX(trace, 3, addr, sizeof(struct qeth_ipaddr));
 	}
 	if (addr->is_multicast)
 		rc = qeth_send_setdelmc(card, addr, IPA_CMD_DELIPM);
@@ -6515,26 +6469,24 @@
 		addr->u.a4.addr = ifa->ifa_address;
 		addr->u.a4.mask = ifa->ifa_mask;
 		addr->type = QETH_IP_TYPE_NORMAL;
-	}
+	} else
+		goto out;
+
 	switch(event) {
 	case NETDEV_UP:
-		if (addr) {
-			if (!qeth_add_ip(card, addr))
-				kfree(addr);
-		}
+		if (!qeth_add_ip(card, addr))
+			kfree(addr);
 		break;
 	case NETDEV_DOWN:
-		if (addr) {
-			if (!qeth_delete_ip(card, addr))
-				kfree(addr);
-		}
+		if (!qeth_delete_ip(card, addr))
+			kfree(addr);
 		break;
 	default:
 		break;
 	}
 	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
 	schedule_work(&card->kernel_thread_starter);
-
+out:	
 	return NOTIFY_DONE;
 }
 
@@ -6570,26 +6522,24 @@
 		memcpy(&addr->u.a6.addr, &ifa->addr, sizeof(struct in6_addr));
 		addr->u.a6.pfxlen = ifa->prefix_len;
 		addr->type = QETH_IP_TYPE_NORMAL;
-	}
+	} else
+		goto out;
+
 	switch(event) {
 	case NETDEV_UP:
-		if (addr){
-			if (!qeth_add_ip(card, addr))
-				kfree(addr);
-		}
+		if (!qeth_add_ip(card, addr))
+			kfree(addr);
 		break;
 	case NETDEV_DOWN:
-		if (addr){
-			if (!qeth_delete_ip(card, addr))
-				kfree(addr);
-		}
+		if (!qeth_delete_ip(card, addr))
+			kfree(addr);
 		break;
 	default:
 		break;
 	}
 	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
 	schedule_work(&card->kernel_thread_starter);
-
+out:
 	return NOTIFY_DONE;
 }
 
