Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVE0JXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVE0JXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVE0JXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:23:44 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27344 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262400AbVE0JDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:03:37 -0400
Date: Fri, 27 May 2005 11:05:09 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 10/10] s390: qeth bug fixes
Message-ID: <20050527090509.GJ8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 10/10] s390: qeth bug fixes.

From: Frank Pavlic <pavlic@de.ibm.com>

qeth network driver related changes:
 - due to OSA hardware changes in TCP Segmentation Offload
   support we are able now to pack TSO packets too.
   This fits perfectly in design of qeth buffer handling and
   sending data respectively.
 - remove skb_realloc_headroom from the sending path since
   hard_header_len value provides enough headroom now.
 - device recovery behaviour improvement
 - bug fixed in Enhanced Device Driver Packing functionality

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/Makefile    |    2 
 drivers/s390/net/qeth.h      |   41 ++++--
 drivers/s390/net/qeth_eddp.c |   40 +++---
 drivers/s390/net/qeth_main.c |  145 +++++++++++++++++-------
 drivers/s390/net/qeth_tso.c  |  256 -------------------------------------------
 drivers/s390/net/qeth_tso.h  |  197 ++++++++++++++++++++-------------
 6 files changed, 275 insertions(+), 406 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/Makefile linux-2.6-patched/drivers/s390/net/Makefile
--- linux-2.6/drivers/s390/net/Makefile	2005-05-06 11:26:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/Makefile	2005-05-06 11:26:18.000000000 +0200
@@ -10,6 +10,6 @@ obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
 obj-$(CONFIG_CTC) += ctc.o fsm.o cu3088.o
 obj-$(CONFIG_LCS) += lcs.o cu3088.o
 obj-$(CONFIG_CLAW) += claw.o cu3088.o
-qeth-y := qeth_main.o qeth_mpc.o qeth_sys.o qeth_eddp.o qeth_tso.o
+qeth-y := qeth_main.o qeth_mpc.o qeth_sys.o qeth_eddp.o 
 qeth-$(CONFIG_PROC_FS) += qeth_proc.o
 obj-$(CONFIG_QETH) += qeth.o
diff -urpN linux-2.6/drivers/s390/net/qeth_eddp.c linux-2.6-patched/drivers/s390/net/qeth_eddp.c
--- linux-2.6/drivers/s390/net/qeth_eddp.c	2005-05-06 11:26:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_eddp.c	2005-05-06 11:26:19.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.12 $)
+ * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.13 $)
  *
  * Enhanced Device Driver Packing (EDDP) support for the qeth driver.
  *
@@ -8,7 +8,7 @@
  *
  *    Author(s): Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.12 $	 $Date: 2005/04/01 21:40:40 $
+ *    $Revision: 1.13 $	 $Date: 2005/05/04 20:19:18 $
  *
  */
 #include <linux/config.h>
@@ -85,7 +85,7 @@ void
 qeth_eddp_buf_release_contexts(struct qeth_qdio_out_buffer *buf)
 {
 	struct qeth_eddp_context_reference *ref;
-
+	
 	QETH_DBF_TEXT(trace, 6, "eddprctx");
 	while (!list_empty(&buf->ctx_list)){
 		ref = list_entry(buf->ctx_list.next,
@@ -139,7 +139,7 @@ qeth_eddp_fill_buffer(struct qeth_qdio_o
 					   "buffer!\n");
 				goto out;
 			}
-		}
+		}		
 		/* check if the whole next skb fits into current buffer */
 		if ((QETH_MAX_BUFFER_ELEMENTS(queue->card) -
 					buf->next_element_to_fill)
@@ -152,7 +152,7 @@ qeth_eddp_fill_buffer(struct qeth_qdio_o
 			 * and increment ctx's refcnt */
 			must_refcnt = 1;
 			continue;
-		}
+		}	
 		if (must_refcnt){
 			must_refcnt = 0;
 			if (qeth_eddp_buf_ref_context(buf, ctx)){
@@ -204,27 +204,27 @@ out:
 
 static inline void
 qeth_eddp_create_segment_hdrs(struct qeth_eddp_context *ctx,
-			      struct qeth_eddp_data *eddp)
+			      struct qeth_eddp_data *eddp, int data_len)
 {
 	u8 *page;
 	int page_remainder;
 	int page_offset;
-	int hdr_len;
+	int pkt_len;
 	struct qeth_eddp_element *element;
 
 	QETH_DBF_TEXT(trace, 5, "eddpcrsh");
 	page = ctx->pages[ctx->offset >> PAGE_SHIFT];
 	page_offset = ctx->offset % PAGE_SIZE;
 	element = &ctx->elements[ctx->num_elements];
-	hdr_len = eddp->nhl + eddp->thl;
+	pkt_len = eddp->nhl + eddp->thl + data_len;
 	/* FIXME: layer2 and VLAN !!! */
 	if (eddp->qh.hdr.l2.id == QETH_HEADER_TYPE_LAYER2)
-		hdr_len += ETH_HLEN;
+		pkt_len += ETH_HLEN;
 	if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q))
-		hdr_len += VLAN_HLEN;
-	/* does complete header fit in current page ? */
+		pkt_len += VLAN_HLEN;
+	/* does complete packet fit in current page ? */
 	page_remainder = PAGE_SIZE - page_offset;
-	if (page_remainder < (sizeof(struct qeth_hdr) + hdr_len)){
+	if (page_remainder < (sizeof(struct qeth_hdr) + pkt_len)){
 		/* no -> go to start of next page */
 		ctx->offset += page_remainder;
 		page = ctx->pages[ctx->offset >> PAGE_SHIFT];
@@ -270,7 +270,7 @@ qeth_eddp_copy_data_tcp(char *dst, struc
 	int left_in_frag;
 	int copy_len;
 	u8 *src;
-
+	
 	QETH_DBF_TEXT(trace, 5, "eddpcdtc");
 	if (skb_shinfo(eddp->skb)->nr_frags == 0) {
 		memcpy(dst, eddp->skb->data + eddp->skb_offset, len);
@@ -281,7 +281,7 @@ qeth_eddp_copy_data_tcp(char *dst, struc
 		while (len > 0) {
 			if (eddp->frag < 0) {
 				/* we're in skb->data */
-				left_in_frag = qeth_get_skb_data_len(eddp->skb)
+				left_in_frag = (eddp->skb->len - eddp->skb->data_len)
 						- eddp->skb_offset;
 				src = eddp->skb->data + eddp->skb_offset;
 			} else {
@@ -413,7 +413,7 @@ __qeth_eddp_fill_context_tcp(struct qeth
 	struct tcphdr *tcph;
 	int data_len;
 	u32 hcsum;
-
+	
 	QETH_DBF_TEXT(trace, 5, "eddpftcp");
 	eddp->skb_offset = sizeof(struct qeth_hdr) + eddp->nhl + eddp->thl;
 	tcph = eddp->skb->h.th;
@@ -453,7 +453,7 @@ __qeth_eddp_fill_context_tcp(struct qeth
 		else
 			hcsum = qeth_eddp_check_tcp6_hdr(eddp, data_len);
 		/* fill the next segment into the context */
-		qeth_eddp_create_segment_hdrs(ctx, eddp);
+		qeth_eddp_create_segment_hdrs(ctx, eddp, data_len);
 		qeth_eddp_create_segment_data_tcp(ctx, eddp, data_len, hcsum);
 		if (eddp->skb_offset >= eddp->skb->len)
 			break;
@@ -463,13 +463,13 @@ __qeth_eddp_fill_context_tcp(struct qeth
 		eddp->th.tcp.h.seq += data_len;
 	}
 }
-
+			   
 static inline int
 qeth_eddp_fill_context_tcp(struct qeth_eddp_context *ctx,
 			   struct sk_buff *skb, struct qeth_hdr *qhdr)
 {
 	struct qeth_eddp_data *eddp = NULL;
-
+	
 	QETH_DBF_TEXT(trace, 5, "eddpficx");
 	/* create our segmentation headers and copy original headers */
 	if (skb->protocol == ETH_P_IP)
@@ -509,7 +509,7 @@ qeth_eddp_calc_num_pages(struct qeth_edd
 			 int hdr_len)
 {
 	int skbs_per_page;
-
+	
 	QETH_DBF_TEXT(trace, 5, "eddpcanp");
 	/* can we put multiple skbs in one page? */
 	skbs_per_page = PAGE_SIZE / (skb_shinfo(skb)->tso_size + hdr_len);
@@ -589,7 +589,7 @@ qeth_eddp_create_context_tcp(struct qeth
 			     struct qeth_hdr *qhdr)
 {
 	struct qeth_eddp_context *ctx = NULL;
-
+	
 	QETH_DBF_TEXT(trace, 5, "creddpct");
 	if (skb->protocol == ETH_P_IP)
 		ctx = qeth_eddp_create_context_generic(card, skb,
diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2005-05-06 11:26:16.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-05-06 11:26:19.000000000 +0200
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.137 $"
+#define VERSION_QETH_H 		"$Revision: 1.139 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -370,6 +370,25 @@ struct qeth_hdr {
 	} hdr;
 } __attribute__ ((packed));
 
+/*TCP Segmentation Offload header*/
+struct qeth_hdr_ext_tso {
+        __u16 hdr_tot_len;
+        __u8  imb_hdr_no;
+        __u8  reserved;
+        __u8  hdr_type;
+        __u8  hdr_version;
+        __u16 hdr_len;
+        __u32 payload_len;
+        __u16 mss;
+        __u16 dg_hdr_len;
+        __u8  padding[16];
+} __attribute__ ((packed));
+
+struct qeth_hdr_tso {
+        struct qeth_hdr hdr; 	/*hdr->hdr.l3.xxx*/
+	struct qeth_hdr_ext_tso ext;
+} __attribute__ ((packed));
+
 
 /* flags for qeth_hdr.flags */
 #define QETH_HDR_PASSTHRU 0x10
@@ -867,16 +886,6 @@ qeth_push_skb(struct qeth_card *card, st
         return hdr;
 }
 
-static inline int
-qeth_get_skb_data_len(struct sk_buff *skb)
-{
-	int len = skb->len;
-	int i;
-
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; ++i)
-		len -= skb_shinfo(skb)->frags[i].size;
-	return len;
-}
 
 inline static int
 qeth_get_hlen(__u8 link_type)
@@ -885,19 +894,19 @@ qeth_get_hlen(__u8 link_type)
 	switch (link_type) {
 	case QETH_LINK_TYPE_HSTR:
 	case QETH_LINK_TYPE_LANE_TR:
-		return sizeof(struct qeth_hdr) + TR_HLEN;
+		return sizeof(struct qeth_hdr_tso) + TR_HLEN;
 	default:
 #ifdef CONFIG_QETH_VLAN
-		return sizeof(struct qeth_hdr) + VLAN_ETH_HLEN;
+		return sizeof(struct qeth_hdr_tso) + VLAN_ETH_HLEN;
 #else
-		return sizeof(struct qeth_hdr) + ETH_HLEN;
+		return sizeof(struct qeth_hdr_tso) + ETH_HLEN;
 #endif
 	}
 #else  /* CONFIG_QETH_IPV6 */
 #ifdef CONFIG_QETH_VLAN
-	return sizeof(struct qeth_hdr) + VLAN_HLEN;
+	return sizeof(struct qeth_hdr_tso) + VLAN_HLEN;
 #else
-	return sizeof(struct qeth_hdr);
+	return sizeof(struct qeth_hdr_tso);
 #endif
 #endif /* CONFIG_QETH_IPV6 */
 }
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-05-06 11:26:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-05-06 11:26:19.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.210 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.214 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.210 $	 $Date: 2005/04/18 17:27:39 $
+ *    $Revision: 1.214 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -80,7 +80,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.210 $"
+#define VERSION_QETH_C "$Revision: 1.214 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -158,6 +158,9 @@ qeth_irq_tasklet(unsigned long);
 static int
 qeth_set_online(struct ccwgroup_device *);
 
+static int
+__qeth_set_online(struct ccwgroup_device *gdev, int recovery_mode);
+
 static struct qeth_ipaddr *
 qeth_get_addr_buffer(enum qeth_prot_versions);
 
@@ -510,10 +513,10 @@ qeth_irq_tasklet(unsigned long data)
 	wake_up(&card->wait_q);
 }
 
-static int qeth_stop_card(struct qeth_card *);
+static int qeth_stop_card(struct qeth_card *, int);
 
 static int
-qeth_set_offline(struct ccwgroup_device *cgdev)
+__qeth_set_offline(struct ccwgroup_device *cgdev, int recovery_mode)
 {
 	struct qeth_card *card = (struct qeth_card *) cgdev->dev.driver_data;
 	int rc = 0;
@@ -523,7 +526,7 @@ qeth_set_offline(struct ccwgroup_device 
 	QETH_DBF_HEX(setup, 3, &card, sizeof(void *));
 
 	recover_flag = card->state;
-	if (qeth_stop_card(card) == -ERESTARTSYS){
+	if (qeth_stop_card(card, recovery_mode) == -ERESTARTSYS){
 		PRINT_WARN("Stopping card %s interrupted by user!\n",
 			   CARD_BUS_ID(card));
 		return -ERESTARTSYS;
@@ -540,6 +543,12 @@ qeth_set_offline(struct ccwgroup_device 
 }
 
 static int
+qeth_set_offline(struct ccwgroup_device *cgdev)
+{
+	return  __qeth_set_offline(cgdev, 0);
+}
+
+static int
 qeth_wait_for_threads(struct qeth_card *card, unsigned long threads);
 
 
@@ -953,8 +962,8 @@ qeth_recover(void *ptr)
 	PRINT_WARN("Recovery of device %s started ...\n",
 		   CARD_BUS_ID(card));
 	card->use_hard_stop = 1;
-	qeth_set_offline(card->gdev);
-	rc = qeth_set_online(card->gdev);
+	__qeth_set_offline(card->gdev,1);
+	rc = __qeth_set_online(card->gdev,1);
 	if (!rc)
 		PRINT_INFO("Device %s successfully recovered!\n",
 			   CARD_BUS_ID(card));
@@ -3786,16 +3795,12 @@ static inline int
 qeth_prepare_skb(struct qeth_card *card, struct sk_buff **skb,
 		 struct qeth_hdr **hdr, int ipv)
 {
-	int rc = 0;
 #ifdef CONFIG_QETH_VLAN
 	u16 *tag;
 #endif
 
 	QETH_DBF_TEXT(trace, 6, "prepskb");
 
-	rc = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
-	if (rc)
-		return rc;
 #ifdef CONFIG_QETH_VLAN
 	if (card->vlangrp && vlan_tx_tag_present(*skb) &&
 	    ((ipv == 6) || card->options.layer2) ) {
@@ -3977,25 +3982,28 @@ qeth_fill_header(struct qeth_card *card,
 
 static inline void
 __qeth_fill_buffer(struct sk_buff *skb, struct qdio_buffer *buffer,
-		   int *next_element_to_fill)
+		   int is_tso, int *next_element_to_fill)
 {
 	int length = skb->len;
 	int length_here;
 	int element;
 	char *data;
-	int first_lap = 1;
+	int first_lap ;
 
 	element = *next_element_to_fill;
 	data = skb->data;
+	first_lap = (is_tso == 0 ? 1 : 0);
+
 	while (length > 0) {
 		/* length_here is the remaining amount of data in this page */
 		length_here = PAGE_SIZE - ((unsigned long) data % PAGE_SIZE);
 		if (length < length_here)
 			length_here = length;
+
 		buffer->element[element].addr = data;
 		buffer->element[element].length = length_here;
 		length -= length_here;
-		if (!length){
+		if (!length) {
 			if (first_lap)
 				buffer->element[element].flags = 0;
 			else
@@ -4022,17 +4030,35 @@ qeth_fill_buffer(struct qeth_qdio_out_q 
 		 struct sk_buff *skb)
 {
 	struct qdio_buffer *buffer;
-	int flush_cnt = 0;
+	struct qeth_hdr_tso *hdr;
+	int flush_cnt = 0, hdr_len, large_send = 0;
 
 	QETH_DBF_TEXT(trace, 6, "qdfillbf");
+
 	buffer = buf->buffer;
 	atomic_inc(&skb->users);
 	skb_queue_tail(&buf->skb_list, skb);
+
+	hdr  = (struct qeth_hdr_tso *) skb->data;
+	/*check first on TSO ....*/
+	if (hdr->hdr.hdr.l3.id == QETH_HEADER_TYPE_TSO) {
+		int element = buf->next_element_to_fill;
+
+		hdr_len = sizeof(struct qeth_hdr_tso) + hdr->ext.dg_hdr_len;
+		/*fill first buffer entry only with header information */
+		buffer->element[element].addr = skb->data;
+		buffer->element[element].length = hdr_len;
+		buffer->element[element].flags = SBAL_FLAGS_FIRST_FRAG;
+		buf->next_element_to_fill++;
+		skb->data += hdr_len;
+		skb->len  -= hdr_len;
+		large_send = 1;
+	}
 	if (skb_shinfo(skb)->nr_frags == 0)
-		__qeth_fill_buffer(skb, buffer,
+		__qeth_fill_buffer(skb, buffer, large_send,
 				   (int *)&buf->next_element_to_fill);
 	else
-		__qeth_fill_buffer_frag(skb, buffer, 0,
+		__qeth_fill_buffer_frag(skb, buffer, large_send,
 					(int *)&buf->next_element_to_fill);
 
 	if (!queue->do_pack) {
@@ -4225,6 +4251,25 @@ out:
 }
 
 static inline int
+qeth_get_elements_no(struct qeth_card *card, void *hdr, struct sk_buff *skb)
+{
+	int elements_needed = 0;
+
+        if (skb_shinfo(skb)->nr_frags > 0) {
+                elements_needed = (skb_shinfo(skb)->nr_frags + 1);
+	}
+        if (elements_needed == 0 )
+                elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
+                                        + skb->len) >> PAGE_SHIFT);
+        if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
+                PRINT_ERR("qeth_do_send_packet: invalid size of "
+                          "IP packet. Discarded.");
+                return 0;
+        }
+        return elements_needed;
+}
+
+static inline int
 qeth_send_packet(struct qeth_card *card, struct sk_buff *skb)
 {
 	int ipv = 0;
@@ -4266,19 +4311,25 @@ qeth_send_packet(struct qeth_card *card,
 	if (skb_shinfo(skb)->tso_size)
 		large_send = card->options.large_send;
 
-	if ((rc = qeth_prepare_skb(card, &skb, &hdr, ipv))){
-		QETH_DBF_TEXT_(trace, 4, "pskbe%d", rc);
-		return rc;
-	}
 	/*are we able to do TSO ? If so ,prepare and send it from here */
 	if ((large_send == QETH_LARGE_SEND_TSO) &&
 	    (cast_type == RTN_UNSPEC)) {
-		rc = qeth_tso_send_packet(card, skb, queue,
-					  ipv, cast_type);
-		goto do_statistics;
+		rc = qeth_tso_prepare_packet(card, skb, ipv, cast_type);
+		if (rc) {
+			card->stats.tx_dropped++;
+			card->stats.tx_errors++;
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		} 
+		elements_needed++;
+	} else {
+		if ((rc = qeth_prepare_skb(card, &skb, &hdr, ipv))) {
+			QETH_DBF_TEXT_(trace, 4, "pskbe%d", rc);
+			return rc;
+		}
+		qeth_fill_header(card, hdr, skb, ipv, cast_type);
 	}
 
-	qeth_fill_header(card, hdr, skb, ipv, cast_type);
 	if (large_send == QETH_LARGE_SEND_EDDP) {
 		ctx = qeth_eddp_create_context(card, skb, hdr);
 		if (ctx == NULL) {
@@ -4286,7 +4337,7 @@ qeth_send_packet(struct qeth_card *card,
 			return -EINVAL;
 		}
 	} else {
-		elements_needed = qeth_get_elements_no(card,(void*) hdr, skb);
+		elements_needed += qeth_get_elements_no(card,(void*) hdr, skb);
 		if (!elements_needed)
 			return -EINVAL;
 	}
@@ -4297,12 +4348,12 @@ qeth_send_packet(struct qeth_card *card,
 	else
 		rc = qeth_do_send_packet_fast(card, queue, skb, hdr,
 					      elements_needed, ctx);
-do_statistics:
 	if (!rc){
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += skb->len;
 #ifdef CONFIG_QETH_PERF_STATS
-		if (skb_shinfo(skb)->tso_size) {
+		if (skb_shinfo(skb)->tso_size &&
+		   !(large_send == QETH_LARGE_SEND_NO)) {
 			card->perf_stats.large_send_bytes += skb->len;
 			card->perf_stats.large_send_cnt++;
 		}
@@ -7199,7 +7250,7 @@ qeth_wait_for_threads(struct qeth_card *
 }
 
 static int
-qeth_stop_card(struct qeth_card *card)
+qeth_stop_card(struct qeth_card *card, int recovery_mode)
 {
 	int rc = 0;
 
@@ -7212,9 +7263,13 @@ qeth_stop_card(struct qeth_card *card)
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
 	    (card->state == CARD_STATE_UP)) {
-		rtnl_lock();
-		dev_close(card->dev);
-		rtnl_unlock();
+		if(recovery_mode) {
+			qeth_stop(card->dev);
+		} else {
+			rtnl_lock();
+			dev_close(card->dev);
+			rtnl_unlock();
+		}
 		if (!card->use_hard_stop) {
 			__u8 *mac = &card->dev->dev_addr[0];
 			rc = qeth_layer2_send_delmac(card, mac);
@@ -7386,13 +7441,17 @@ qeth_register_netdev(struct qeth_card *c
 }
 
 static void
-qeth_start_again(struct qeth_card *card)
+qeth_start_again(struct qeth_card *card, int recovery_mode)
 {
 	QETH_DBF_TEXT(setup ,2, "startag");
 
-	rtnl_lock();
-	dev_open(card->dev);
-	rtnl_unlock();
+	if(recovery_mode) {
+		qeth_open(card->dev);
+	} else {
+		rtnl_lock();
+		dev_open(card->dev);
+		rtnl_unlock();
+	}
 	/* this also sets saved unicast addresses */
 	qeth_set_multicast_list(card->dev);
 }
@@ -7449,7 +7508,7 @@ static void qeth_make_parameters_consist
 
 
 static int
-qeth_set_online(struct ccwgroup_device *gdev)
+__qeth_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 {
 	struct qeth_card *card = gdev->dev.driver_data;
 	int rc = 0;
@@ -7509,12 +7568,12 @@ qeth_set_online(struct ccwgroup_device *
  * we can also use this state for recovery purposes*/
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (recover_flag == CARD_STATE_RECOVER)
-		qeth_start_again(card);
+		qeth_start_again(card, recovery_mode);
 	qeth_notify_processes();
 	return 0;
 out_remove:
 	card->use_hard_stop = 1;
-	qeth_stop_card(card);
+	qeth_stop_card(card, 0);
 	ccw_device_set_offline(CARD_DDEV(card));
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
@@ -7525,6 +7584,12 @@ out_remove:
 	return -ENODEV;
 }
 
+static int
+qeth_set_online(struct ccwgroup_device *gdev)
+{
+	return __qeth_set_online(gdev, 0);
+}
+
 static struct ccw_device_id qeth_ids[] = {
 	{CCW_DEVICE(0x1731, 0x01), driver_info:QETH_CARD_TYPE_OSAE},
 	{CCW_DEVICE(0x1731, 0x05), driver_info:QETH_CARD_TYPE_IQD},
diff -urpN linux-2.6/drivers/s390/net/qeth_tso.c linux-2.6-patched/drivers/s390/net/qeth_tso.c
--- linux-2.6/drivers/s390/net/qeth_tso.c	2005-05-06 11:26:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_tso.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,256 +0,0 @@
-/*
- * linux/drivers/s390/net/qeth_tso.c ($Revision: 1.7 $)
- *
- * Header file for qeth TCP Segmentation Offload support.
- *
- * Copyright 2004 IBM Corporation
- *
- *    Author(s): Frank Pavlic <pavlic@de.ibm.com>
- *
- *    $Revision: 1.7 $	 $Date: 2005/04/01 21:40:41 $
- *
- */
-
-#include <linux/skbuff.h>
-#include <linux/tcp.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <net/ip6_checksum.h>
-#include "qeth.h"
-#include "qeth_mpc.h"
-#include "qeth_tso.h"
-
-/**
- * skb already partially prepared
- * classic qdio header in skb->data
- * */
-static inline struct qeth_hdr_tso *
-qeth_tso_prepare_skb(struct qeth_card *card, struct sk_buff **skb)
-{
-	int rc = 0;
-
-	QETH_DBF_TEXT(trace, 5, "tsoprsk");
-	rc = qeth_realloc_headroom(card, skb,sizeof(struct qeth_hdr_ext_tso));
-	if (rc)
-		return NULL;
-
-	return qeth_push_skb(card, skb, sizeof(struct qeth_hdr_ext_tso));
-}
-
-/**
- * fill header for a TSO packet
- */
-static inline void
-qeth_tso_fill_header(struct qeth_card *card, struct sk_buff *skb)
-{
-	struct qeth_hdr_tso *hdr;
-	struct tcphdr *tcph;
-	struct iphdr *iph;
-
-	QETH_DBF_TEXT(trace, 5, "tsofhdr");
-
-	hdr  = (struct qeth_hdr_tso *) skb->data;
-	iph  = skb->nh.iph;
-	tcph = skb->h.th;
-	/*fix header to TSO values ...*/
-	hdr->hdr.hdr.l3.id = QETH_HEADER_TYPE_TSO;
-	/*set values which are fix for the first approach ...*/
-	hdr->ext.hdr_tot_len = (__u16) sizeof(struct qeth_hdr_ext_tso);
-	hdr->ext.imb_hdr_no  = 1;
-	hdr->ext.hdr_type    = 1;
-	hdr->ext.hdr_version = 1;
-	hdr->ext.hdr_len     = 28;
-	/*insert non-fix values */
-	hdr->ext.mss = skb_shinfo(skb)->tso_size;
-	hdr->ext.dg_hdr_len = (__u16)(iph->ihl*4 + tcph->doff*4);
-	hdr->ext.payload_len = (__u16)(skb->len - hdr->ext.dg_hdr_len -
-				       sizeof(struct qeth_hdr_tso));
-}
-
-/**
- * change some header values as requested by hardware
- */
-static inline void
-qeth_tso_set_tcpip_header(struct qeth_card *card, struct sk_buff *skb)
-{
-	struct iphdr *iph;
-	struct ipv6hdr *ip6h;
-	struct tcphdr *tcph;
-
-	iph  = skb->nh.iph;
-	ip6h = skb->nh.ipv6h;
-	tcph = skb->h.th;
-
-	tcph->check = 0;
-	if (skb->protocol == ETH_P_IPV6) {
-		ip6h->payload_len = 0;
-		tcph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
-					       0, IPPROTO_TCP, 0);
-		return;
-	}
-	/*OSA want us to set these values ...*/
-	tcph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
-					 0, IPPROTO_TCP, 0);
-	iph->tot_len = 0;
-	iph->check = 0;
-}
-
-static inline struct qeth_hdr_tso *
-qeth_tso_prepare_packet(struct qeth_card *card, struct sk_buff *skb,
-			int ipv, int cast_type)
-{
-	struct qeth_hdr_tso *hdr;
-	int rc = 0;
-
-	QETH_DBF_TEXT(trace, 5, "tsoprep");
-
-	/*get headroom for tso qdio header */
-	hdr = (struct qeth_hdr_tso *) qeth_tso_prepare_skb(card, &skb);
-	if (hdr == NULL) {
-		QETH_DBF_TEXT_(trace, 4, "2err%d", rc);
-		return NULL;
-	}
-	memset(hdr, 0, sizeof(struct qeth_hdr_tso));
-	/*fill first 32 bytes of  qdio header as used
-	 *FIXME: TSO has two struct members
-	 * with different names but same size
-	 * */
-	qeth_fill_header(card, &hdr->hdr, skb, ipv, cast_type);
-	qeth_tso_fill_header(card, skb);
-	qeth_tso_set_tcpip_header(card, skb);
-	return hdr;
-}
-
-static inline int
-qeth_tso_get_queue_buffer(struct qeth_qdio_out_q *queue)
-{
-	struct qeth_qdio_out_buffer *buffer;
-	int flush_cnt = 0;
-
-	QETH_DBF_TEXT(trace, 5, "tsobuf");
-
-	/* force to non-packing*/
-	if (queue->do_pack)
-		queue->do_pack = 0;
-	buffer = &queue->bufs[queue->next_buf_to_fill];
-	/* get a new buffer if current is already in use*/
-	if ((atomic_read(&buffer->state) == QETH_QDIO_BUF_EMPTY) &&
-	    (buffer->next_element_to_fill > 0)) {
-		atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
-		queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
-					  QDIO_MAX_BUFFERS_PER_Q;
-		flush_cnt++;
-	}
-	return flush_cnt;
-}
-
-
-static inline int
-qeth_tso_fill_buffer(struct qeth_qdio_out_buffer *buf,
-		     struct sk_buff *skb)
-{
-        int length, length_here, element;
-        int hdr_len;
-	struct qdio_buffer *buffer;
-	struct qeth_hdr_tso *hdr;
-	char *data;
-
-        QETH_DBF_TEXT(trace, 3, "tsfilbuf");
-
-	/*increment user count and queue skb ...*/
-        atomic_inc(&skb->users);
-        skb_queue_tail(&buf->skb_list, skb);
-
-	/*initialize all variables...*/
-        buffer = buf->buffer;
-	hdr = (struct qeth_hdr_tso *)skb->data;
-	hdr_len = sizeof(struct qeth_hdr_tso) + hdr->ext.dg_hdr_len;
-	data = skb->data + hdr_len;
-	length = skb->len - hdr_len;
-        element = buf->next_element_to_fill;
-	/*fill first buffer entry only with header information */
-	buffer->element[element].addr = skb->data;
-	buffer->element[element].length = hdr_len;
-	buffer->element[element].flags = SBAL_FLAGS_FIRST_FRAG;
-	buf->next_element_to_fill++;
-	/*check if we have frags ...*/
-	if (skb_shinfo(skb)->nr_frags > 0) {
-		skb->len = length;
-		skb->data = data;
-                 __qeth_fill_buffer_frag(skb, buffer,1,
-					(int *)&buf->next_element_to_fill);
-                 goto out;
-        }
-
-       /*... if not, use this */
-        element++;
-        while (length > 0) {
-                /* length_here is the remaining amount of data in this page */
-		length_here = PAGE_SIZE - ((unsigned long) data % PAGE_SIZE);
-		if (length < length_here)
-			length_here = length;
-                buffer->element[element].addr = data;
-                buffer->element[element].length = length_here;
-                length -= length_here;
-                if (!length)
-                        buffer->element[element].flags =
-                                SBAL_FLAGS_LAST_FRAG;
-                 else
-                         buffer->element[element].flags =
-                                 SBAL_FLAGS_MIDDLE_FRAG;
-                data += length_here;
-                element++;
-        }
-        buf->next_element_to_fill = element;
-out:
-        /*prime buffer now  ...*/
-	atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
-        return 1;
-}
-
-int
-qeth_tso_send_packet(struct qeth_card *card, struct sk_buff *skb,
-		     struct qeth_qdio_out_q *queue, int ipv, int cast_type)
-{
-	int flush_cnt = 0;
-	struct qeth_hdr_tso *hdr;
-	struct qeth_qdio_out_buffer *buffer;
-        int start_index;
-
-	QETH_DBF_TEXT(trace, 3, "tsosend");
-
-	if (!(hdr = qeth_tso_prepare_packet(card, skb, ipv, cast_type)))
-	     	return -ENOMEM;
-	/*check if skb fits in one SBAL ...*/
-	if (!(qeth_get_elements_no(card, (void*)hdr, skb)))
-		return -EINVAL;
-	/*lock queue, force switching to non-packing and send it ...*/
-	while (atomic_compare_and_swap(QETH_OUT_Q_UNLOCKED,
-                                       QETH_OUT_Q_LOCKED,
-                                       &queue->state));
-        start_index = queue->next_buf_to_fill;
-        buffer = &queue->bufs[queue->next_buf_to_fill];
-	/*check if card is too busy ...*/
-	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY){
-		card->stats.tx_dropped++;
-		goto out;
-	}
-	/*let's force to non-packing and get a new SBAL*/
-	flush_cnt += qeth_tso_get_queue_buffer(queue);
-	buffer = &queue->bufs[queue->next_buf_to_fill];
-	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) {
-		card->stats.tx_dropped++;
-		goto out;
-	}
-	flush_cnt += qeth_tso_fill_buffer(buffer, skb);
-	queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
-				   QDIO_MAX_BUFFERS_PER_Q;
-out:
-	atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
-	if (flush_cnt)
-		qeth_flush_buffers(queue, 0, start_index, flush_cnt);
-	/*do some statistics */
-	card->stats.tx_packets++;
-	card->stats.tx_bytes += skb->len;
-	return 0;
-}
diff -urpN linux-2.6/drivers/s390/net/qeth_tso.h linux-2.6-patched/drivers/s390/net/qeth_tso.h
--- linux-2.6/drivers/s390/net/qeth_tso.h	2005-05-06 11:26:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_tso.h	2005-05-06 11:26:19.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.5 $)
+ * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.7 $)
  *
  * Header file for qeth TCP Segmentation Offload support.
  *
@@ -7,97 +7,148 @@
  *
  *    Author(s): Frank Pavlic <pavlic@de.ibm.com>
  *
- *    $Revision: 1.5 $	 $Date: 2005/04/01 21:40:41 $
+ *    $Revision: 1.7 $	 $Date: 2005/05/04 20:19:18 $
  *
  */
 #ifndef __QETH_TSO_H__
 #define __QETH_TSO_H__
 
+#include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ip6_checksum.h>
+#include "qeth.h"
+#include "qeth_mpc.h"
 
-extern int
-qeth_tso_send_packet(struct qeth_card *, struct sk_buff *,
-		     struct qeth_qdio_out_q *, int , int);
-
-struct qeth_hdr_ext_tso {
-        __u16 hdr_tot_len;
-        __u8  imb_hdr_no;
-        __u8  reserved;
-        __u8  hdr_type;
-        __u8  hdr_version;
-        __u16 hdr_len;
-        __u32 payload_len;
-        __u16 mss;
-        __u16 dg_hdr_len;
-        __u8  padding[16];
-} __attribute__ ((packed));
-
-struct qeth_hdr_tso {
-        struct qeth_hdr hdr; 	/*hdr->hdr.l3.xxx*/
-	struct qeth_hdr_ext_tso ext;
-} __attribute__ ((packed));
 
-/*some helper functions*/
+static inline struct qeth_hdr_tso *
+qeth_tso_prepare_skb(struct qeth_card *card, struct sk_buff **skb)
+{
+	QETH_DBF_TEXT(trace, 5, "tsoprsk");
+	return qeth_push_skb(card, skb, sizeof(struct qeth_hdr_tso));
+}
+
+/**
+ * fill header for a TSO packet
+ */
+static inline void
+qeth_tso_fill_header(struct qeth_card *card, struct sk_buff *skb)
+{
+	struct qeth_hdr_tso *hdr;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+
+	QETH_DBF_TEXT(trace, 5, "tsofhdr");
+
+	hdr  = (struct qeth_hdr_tso *) skb->data;
+	iph  = skb->nh.iph;
+	tcph = skb->h.th;
+	/*fix header to TSO values ...*/
+	hdr->hdr.hdr.l3.id = QETH_HEADER_TYPE_TSO;
+	/*set values which are fix for the first approach ...*/
+	hdr->ext.hdr_tot_len = (__u16) sizeof(struct qeth_hdr_ext_tso);
+	hdr->ext.imb_hdr_no  = 1;
+	hdr->ext.hdr_type    = 1;
+	hdr->ext.hdr_version = 1;
+	hdr->ext.hdr_len     = 28;
+	/*insert non-fix values */
+	hdr->ext.mss = skb_shinfo(skb)->tso_size;
+	hdr->ext.dg_hdr_len = (__u16)(iph->ihl*4 + tcph->doff*4);
+	hdr->ext.payload_len = (__u16)(skb->len - hdr->ext.dg_hdr_len -
+				       sizeof(struct qeth_hdr_tso));
+}
+
+/**
+ * change some header values as requested by hardware
+ */
+static inline void
+qeth_tso_set_tcpip_header(struct qeth_card *card, struct sk_buff *skb)
+{
+	struct iphdr *iph;
+	struct ipv6hdr *ip6h;
+	struct tcphdr *tcph;
+
+	iph  = skb->nh.iph;
+	ip6h = skb->nh.ipv6h;
+	tcph = skb->h.th;
+
+	tcph->check = 0;
+	if (skb->protocol == ETH_P_IPV6) {
+		ip6h->payload_len = 0;
+		tcph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
+					       0, IPPROTO_TCP, 0);
+		return;
+	}
+	/*OSA want us to set these values ...*/
+	tcph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					 0, IPPROTO_TCP, 0);
+	iph->tot_len = 0;
+	iph->check = 0;
+}
+
 static inline int
-qeth_get_elements_no(struct qeth_card *card, void *hdr, struct sk_buff *skb)
+qeth_tso_prepare_packet(struct qeth_card *card, struct sk_buff *skb,
+			int ipv, int cast_type)
 {
-	int elements_needed = 0;
+	struct qeth_hdr_tso *hdr;
+
+	QETH_DBF_TEXT(trace, 5, "tsoprep");
 
-        if (skb_shinfo(skb)->nr_frags > 0)
-                elements_needed = (skb_shinfo(skb)->nr_frags + 1);
-        if (elements_needed == 0 )
-                elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
-                                        + skb->len) >> PAGE_SHIFT);
-        if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
-                PRINT_ERR("qeth_do_send_packet: invalid size of "
-                          "IP packet. Discarded.");
-                return 0;
-        }
-        return elements_needed;
+	hdr = (struct qeth_hdr_tso *) qeth_tso_prepare_skb(card, &skb);
+	if (hdr == NULL) {
+		QETH_DBF_TEXT(trace, 4, "tsoperr");
+		return -ENOMEM;
+	}
+	memset(hdr, 0, sizeof(struct qeth_hdr_tso));
+	/*fill first 32 bytes of  qdio header as used
+	 *FIXME: TSO has two struct members
+	 * with different names but same size
+	 * */
+	qeth_fill_header(card, &hdr->hdr, skb, ipv, cast_type);
+	qeth_tso_fill_header(card, skb);
+	qeth_tso_set_tcpip_header(card, skb);
+	return 0;
 }
 
 static inline void
 __qeth_fill_buffer_frag(struct sk_buff *skb, struct qdio_buffer *buffer,
 			int is_tso, int *next_element_to_fill)
 {
-	int length = skb->len;
 	struct skb_frag_struct *frag;
 	int fragno;
 	unsigned long addr;
-	int element;
-	int first_lap = 1;
-
-	fragno = skb_shinfo(skb)->nr_frags; /* start with last frag */
-	element = *next_element_to_fill + fragno;
-	while (length > 0) {
-		if (fragno > 0) {
-			frag = &skb_shinfo(skb)->frags[fragno - 1];
-			addr = (page_to_pfn(frag->page) << PAGE_SHIFT) +
-				frag->page_offset;
-			buffer->element[element].addr = (char *)addr;
-			buffer->element[element].length = frag->size;
-			length -= frag->size;
-			if (first_lap)
-				buffer->element[element].flags =
-				    SBAL_FLAGS_LAST_FRAG;
-			else
-				buffer->element[element].flags =
-				    SBAL_FLAGS_MIDDLE_FRAG;
-		} else {
-			buffer->element[element].addr = skb->data;
-			buffer->element[element].length = length;
-			length = 0;
-			if (is_tso)
-				buffer->element[element].flags =
-					SBAL_FLAGS_MIDDLE_FRAG;
-			else
-				buffer->element[element].flags =
-					SBAL_FLAGS_FIRST_FRAG;
-		}
-		element--;
-		fragno--;
-		first_lap = 0;
+	int element, cnt, dlen;
+	
+	fragno = skb_shinfo(skb)->nr_frags;
+	element = *next_element_to_fill;
+	dlen = 0;
+	
+	if (is_tso)
+		buffer->element[element].flags =
+			SBAL_FLAGS_MIDDLE_FRAG;
+	else
+		buffer->element[element].flags =
+			SBAL_FLAGS_FIRST_FRAG;
+	if ( (dlen = (skb->len - skb->data_len)) ) {
+		buffer->element[element].addr = skb->data;
+		buffer->element[element].length = dlen;
+		element++;
 	}
-	*next_element_to_fill += skb_shinfo(skb)->nr_frags + 1;
+	for (cnt = 0; cnt < fragno; cnt++) {
+		frag = &skb_shinfo(skb)->frags[cnt];
+		addr = (page_to_pfn(frag->page) << PAGE_SHIFT) +
+			frag->page_offset;
+		buffer->element[element].addr = (char *)addr;
+		buffer->element[element].length = frag->size;
+		if (cnt < (fragno - 1))
+			buffer->element[element].flags =
+				SBAL_FLAGS_MIDDLE_FRAG;
+		else
+			buffer->element[element].flags =
+				SBAL_FLAGS_LAST_FRAG;
+		element++;
+	}
+	*next_element_to_fill = element;
 }
-
 #endif /* __QETH_TSO_H__ */
 Makefile    |    2 
 qeth.h      |   41 +++++----
 qeth_eddp.c |   40 ++++-----
 qeth_main.c |  145 ++++++++++++++++++++++++---------
 qeth_tso.c  |  256 ------------------------------------------------------------
 qeth_tso.h  |  197 +++++++++++++++++++++++++++++-----------------
 6 files changed, 275 insertions(+), 406 deletions(-)
