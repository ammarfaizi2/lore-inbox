Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWC2Rrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWC2Rrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWC2Rrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:47:40 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:40110 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750876AbWC2Rrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:47:39 -0500
X-IronPort-AV: i="4.03,144,1141632000"; 
   d="scan'208"; a="421062849:sNHT39710792"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] InfiniBand updates for 2.6.17
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 29 Mar 2006 09:47:37 -0800
Message-ID: <adazmj95eiu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Mar 2006 17:47:38.0835 (UTC) FILETIME=[DEE40230:01C65358]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Hal Rosenstock:
      IB/mad: RMPP support for additional classes

Jack Morgenstein:
      IB/mthca: Fix check of size in SRQ creation
      IB/mad: include GID/class when matching receives

Roland Dreier:
      IB/srp: Fix unmapping of fake scatterlist
      IPoIB: Fix oops with raw sockets
      IB/mthca: Fix section mismatch problems

 drivers/infiniband/core/mad.c             |  112 ++++++++++++++++++++++++++---
 drivers/infiniband/core/mad_rmpp.c        |   54 ++++----------
 drivers/infiniband/core/user_mad.c        |   30 ++------
 drivers/infiniband/hw/mthca/mthca_av.c    |    2 -
 drivers/infiniband/hw/mthca/mthca_cq.c    |    2 -
 drivers/infiniband/hw/mthca/mthca_eq.c    |    6 +-
 drivers/infiniband/hw/mthca/mthca_mad.c   |    2 -
 drivers/infiniband/hw/mthca/mthca_mcg.c   |    2 -
 drivers/infiniband/hw/mthca/mthca_mr.c    |    4 +
 drivers/infiniband/hw/mthca/mthca_pd.c    |    2 -
 drivers/infiniband/hw/mthca/mthca_qp.c    |    2 -
 drivers/infiniband/hw/mthca/mthca_srq.c   |    4 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c |    2 -
 drivers/infiniband/ulp/srp/ib_srp.c       |    4 +
 include/rdma/ib_mad.h                     |   27 +++++++
 15 files changed, 166 insertions(+), 89 deletions(-)


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index f7854b6..ba54c85 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -227,6 +227,14 @@ struct ib_mad_agent *ib_register_mad_age
 			if (!is_vendor_oui(mad_reg_req->oui))
 				goto error1;
 		}
+		/* Make sure class supplied is consistent with RMPP */
+		if (ib_is_mad_class_rmpp(mad_reg_req->mgmt_class)) {
+			if (!rmpp_version)
+				goto error1;
+		} else {
+			if (rmpp_version)
+				goto error1;
+		}
 		/* Make sure class supplied is consistent with QP type */
 		if (qp_type == IB_QPT_SMI) {
 			if ((mad_reg_req->mgmt_class !=
@@ -890,6 +898,35 @@ struct ib_mad_send_buf * ib_create_send_
 }
 EXPORT_SYMBOL(ib_create_send_mad);
 
+int ib_get_mad_data_offset(u8 mgmt_class)
+{
+	if (mgmt_class == IB_MGMT_CLASS_SUBN_ADM)
+		return IB_MGMT_SA_HDR;
+	else if ((mgmt_class == IB_MGMT_CLASS_DEVICE_MGMT) ||
+		 (mgmt_class == IB_MGMT_CLASS_DEVICE_ADM) ||
+		 (mgmt_class == IB_MGMT_CLASS_BIS))
+		return IB_MGMT_DEVICE_HDR;
+	else if ((mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
+		 (mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END))
+		return IB_MGMT_VENDOR_HDR;
+	else
+		return IB_MGMT_MAD_HDR;
+}
+EXPORT_SYMBOL(ib_get_mad_data_offset);
+
+int ib_is_mad_class_rmpp(u8 mgmt_class)
+{
+	if ((mgmt_class == IB_MGMT_CLASS_SUBN_ADM) ||
+	    (mgmt_class == IB_MGMT_CLASS_DEVICE_MGMT) ||
+	    (mgmt_class == IB_MGMT_CLASS_DEVICE_ADM) ||
+	    (mgmt_class == IB_MGMT_CLASS_BIS) ||
+	    ((mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
+	     (mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END)))
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL(ib_is_mad_class_rmpp);
+
 void *ib_get_rmpp_segment(struct ib_mad_send_buf *send_buf, int seg_num)
 {
 	struct ib_mad_send_wr_private *mad_send_wr;
@@ -1022,6 +1059,13 @@ int ib_post_send_mad(struct ib_mad_send_
 			goto error;
 		}
 
+		if (!ib_is_mad_class_rmpp(((struct ib_mad_hdr *) send_buf->mad)->mgmt_class)) {
+			if (mad_agent_priv->agent.rmpp_version) {
+				ret = -EINVAL;
+				goto error;
+			}
+		}
+
 		/*
 		 * Save pointer to next work request to post in case the
 		 * current one completes, and the user modifies the work
@@ -1618,14 +1662,59 @@ static int is_data_mad(struct ib_mad_age
 		(rmpp_mad->rmpp_hdr.rmpp_type == IB_MGMT_RMPP_TYPE_DATA);
 }
 
+static inline int rcv_has_same_class(struct ib_mad_send_wr_private *wr,
+				     struct ib_mad_recv_wc *rwc)
+{
+	return ((struct ib_mad *)(wr->send_buf.mad))->mad_hdr.mgmt_class ==
+		rwc->recv_buf.mad->mad_hdr.mgmt_class;
+}
+
+static inline int rcv_has_same_gid(struct ib_mad_send_wr_private *wr,
+				   struct ib_mad_recv_wc *rwc )
+{
+	struct ib_ah_attr attr;
+	u8 send_resp, rcv_resp;
+
+	send_resp = ((struct ib_mad *)(wr->send_buf.mad))->
+		     mad_hdr.method & IB_MGMT_METHOD_RESP;
+	rcv_resp = rwc->recv_buf.mad->mad_hdr.method & IB_MGMT_METHOD_RESP;
+
+	if (!send_resp && rcv_resp)
+		/* is request/response. GID/LIDs are both local (same). */
+		return 1;
+
+	if (send_resp == rcv_resp)
+		/* both requests, or both responses. GIDs different */
+		return 0;
+
+	if (ib_query_ah(wr->send_buf.ah, &attr))
+		/* Assume not equal, to avoid false positives. */
+		return 0;
+
+	if (!(attr.ah_flags & IB_AH_GRH) && !(rwc->wc->wc_flags & IB_WC_GRH))
+		return attr.dlid == rwc->wc->slid;
+	else if ((attr.ah_flags & IB_AH_GRH) &&
+		 (rwc->wc->wc_flags & IB_WC_GRH))
+		return memcmp(attr.grh.dgid.raw,
+			      rwc->recv_buf.grh->sgid.raw, 16) == 0;
+	else
+		/* one has GID, other does not.  Assume different */
+		return 0;
+}
 struct ib_mad_send_wr_private*
-ib_find_send_mad(struct ib_mad_agent_private *mad_agent_priv, __be64 tid)
+ib_find_send_mad(struct ib_mad_agent_private *mad_agent_priv,
+		 struct ib_mad_recv_wc *mad_recv_wc)
 {
 	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad *mad;
+
+	mad = (struct ib_mad *)mad_recv_wc->recv_buf.mad;
 
 	list_for_each_entry(mad_send_wr, &mad_agent_priv->wait_list,
 			    agent_list) {
-		if (mad_send_wr->tid == tid)
+		if ((mad_send_wr->tid == mad->mad_hdr.tid) &&
+		    rcv_has_same_class(mad_send_wr, mad_recv_wc) &&
+		    rcv_has_same_gid(mad_send_wr, mad_recv_wc))
 			return mad_send_wr;
 	}
 
@@ -1636,7 +1725,10 @@ ib_find_send_mad(struct ib_mad_agent_pri
 	list_for_each_entry(mad_send_wr, &mad_agent_priv->send_list,
 			    agent_list) {
 		if (is_data_mad(mad_agent_priv, mad_send_wr->send_buf.mad) &&
-		    mad_send_wr->tid == tid && mad_send_wr->timeout) {
+		    mad_send_wr->tid == mad->mad_hdr.tid &&
+		    mad_send_wr->timeout &&
+		    rcv_has_same_class(mad_send_wr, mad_recv_wc) &&
+		    rcv_has_same_gid(mad_send_wr, mad_recv_wc)) {
 			/* Verify request has not been canceled */
 			return (mad_send_wr->status == IB_WC_SUCCESS) ?
 				mad_send_wr : NULL;
@@ -1661,7 +1753,6 @@ static void ib_mad_complete_recv(struct 
 	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc mad_send_wc;
 	unsigned long flags;
-	__be64 tid;
 
 	INIT_LIST_HEAD(&mad_recv_wc->rmpp_list);
 	list_add(&mad_recv_wc->recv_buf.list, &mad_recv_wc->rmpp_list);
@@ -1677,9 +1768,8 @@ static void ib_mad_complete_recv(struct 
 
 	/* Complete corresponding request */
 	if (response_mad(mad_recv_wc->recv_buf.mad)) {
-		tid = mad_recv_wc->recv_buf.mad->mad_hdr.tid;
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		mad_send_wr = ib_find_send_mad(mad_agent_priv, tid);
+		mad_send_wr = ib_find_send_mad(mad_agent_priv, mad_recv_wc);
 		if (!mad_send_wr) {
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 			ib_free_recv_mad(mad_recv_wc);
@@ -2408,11 +2498,11 @@ static int ib_mad_post_receive_mads(stru
 			}
 		}
 		sg_list.addr = dma_map_single(qp_info->port_priv->
-						device->dma_device,
-					&mad_priv->grh,
-					sizeof *mad_priv -
-						sizeof mad_priv->header,
-					DMA_FROM_DEVICE);
+					      	device->dma_device,
+					      &mad_priv->grh,
+					      sizeof *mad_priv -
+					      	sizeof mad_priv->header,
+					      DMA_FROM_DEVICE);
 		pci_unmap_addr_set(&mad_priv->header, mapping, sg_list.addr);
 		recv_wr.wr_id = (unsigned long)&mad_priv->header.mad_list;
 		mad_priv->header.mad_list.mad_queue = recv_queue;
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index bacfdd5..dfd4e58 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2005 Intel Inc. All rights reserved.
- * Copyright (c) 2005 Voltaire, Inc. All rights reserved.
+ * Copyright (c) 2005-2006 Voltaire, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -100,17 +100,6 @@ void ib_cancel_rmpp_recvs(struct ib_mad_
 	}
 }
 
-static int data_offset(u8 mgmt_class)
-{
-	if (mgmt_class == IB_MGMT_CLASS_SUBN_ADM)
-		return IB_MGMT_SA_HDR;
-	else if ((mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
-		 (mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END))
-		return IB_MGMT_VENDOR_HDR;
-	else
-		return IB_MGMT_RMPP_HDR;
-}
-
 static void format_ack(struct ib_mad_send_buf *msg,
 		       struct ib_rmpp_mad *data,
 		       struct mad_rmpp_recv *rmpp_recv)
@@ -137,7 +126,7 @@ static void ack_recv(struct mad_rmpp_rec
 	struct ib_mad_send_buf *msg;
 	int ret, hdr_len;
 
-	hdr_len = data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
+	hdr_len = ib_get_mad_data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
 	msg = ib_create_send_mad(&rmpp_recv->agent->agent, recv_wc->wc->src_qp,
 				 recv_wc->wc->pkey_index, 1, hdr_len,
 				 0, GFP_KERNEL);
@@ -163,7 +152,7 @@ static struct ib_mad_send_buf *alloc_res
 	if (IS_ERR(ah))
 		return (void *) ah;
 
-	hdr_len = data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
+	hdr_len = ib_get_mad_data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
 	msg = ib_create_send_mad(agent, recv_wc->wc->src_qp,
 				 recv_wc->wc->pkey_index, 1,
 				 hdr_len, 0, GFP_KERNEL);
@@ -408,7 +397,7 @@ static inline int get_mad_len(struct mad
 
 	rmpp_mad = (struct ib_rmpp_mad *)rmpp_recv->cur_seg_buf->mad;
 
-	hdr_size = data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	hdr_size = ib_get_mad_data_offset(rmpp_mad->mad_hdr.mgmt_class);
 	data_size = sizeof(struct ib_rmpp_mad) - hdr_size;
 	pad = IB_MGMT_RMPP_DATA - be32_to_cpu(rmpp_mad->rmpp_hdr.paylen_newwin);
 	if (pad > IB_MGMT_RMPP_DATA || pad < 0)
@@ -562,15 +551,15 @@ static int send_next_seg(struct ib_mad_s
 	return ib_send_mad(mad_send_wr);
 }
 
-static void abort_send(struct ib_mad_agent_private *agent, __be64 tid,
-		       u8 rmpp_status)
+static void abort_send(struct ib_mad_agent_private *agent,
+		       struct ib_mad_recv_wc *mad_recv_wc, u8 rmpp_status)
 {
 	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc wc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&agent->lock, flags);
-	mad_send_wr = ib_find_send_mad(agent, tid);
+	mad_send_wr = ib_find_send_mad(agent, mad_recv_wc);
 	if (!mad_send_wr)
 		goto out;	/* Unmatched send */
 
@@ -612,8 +601,7 @@ static void process_rmpp_ack(struct ib_m
 
 	rmpp_mad = (struct ib_rmpp_mad *)mad_recv_wc->recv_buf.mad;
 	if (rmpp_mad->rmpp_hdr.rmpp_status) {
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_BAD_STATUS);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BAD_STATUS);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BAD_STATUS);
 		return;
 	}
@@ -621,14 +609,13 @@ static void process_rmpp_ack(struct ib_m
 	seg_num = be32_to_cpu(rmpp_mad->rmpp_hdr.seg_num);
 	newwin = be32_to_cpu(rmpp_mad->rmpp_hdr.paylen_newwin);
 	if (newwin < seg_num) {
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_W2S);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_W2S);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_W2S);
 		return;
 	}
 
 	spin_lock_irqsave(&agent->lock, flags);
-	mad_send_wr = ib_find_send_mad(agent, rmpp_mad->mad_hdr.tid);
+	mad_send_wr = ib_find_send_mad(agent, mad_recv_wc);
 	if (!mad_send_wr)
 		goto out;	/* Unmatched ACK */
 
@@ -639,8 +626,7 @@ static void process_rmpp_ack(struct ib_m
 	if (seg_num > mad_send_wr->send_buf.seg_count ||
 	    seg_num > mad_send_wr->newwin) {
 		spin_unlock_irqrestore(&agent->lock, flags);
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_S2B);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_S2B);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_S2B);
 		return;
 	}
@@ -728,12 +714,10 @@ static void process_rmpp_stop(struct ib_
 	rmpp_mad = (struct ib_rmpp_mad *)mad_recv_wc->recv_buf.mad;
 
 	if (rmpp_mad->rmpp_hdr.rmpp_status != IB_MGMT_RMPP_STATUS_RESX) {
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_BAD_STATUS);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BAD_STATUS);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BAD_STATUS);
 	} else
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   rmpp_mad->rmpp_hdr.rmpp_status);
+		abort_send(agent, mad_recv_wc, rmpp_mad->rmpp_hdr.rmpp_status);
 }
 
 static void process_rmpp_abort(struct ib_mad_agent_private *agent,
@@ -745,12 +729,10 @@ static void process_rmpp_abort(struct ib
 
 	if (rmpp_mad->rmpp_hdr.rmpp_status < IB_MGMT_RMPP_STATUS_ABORT_MIN ||
 	    rmpp_mad->rmpp_hdr.rmpp_status > IB_MGMT_RMPP_STATUS_ABORT_MAX) {
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_BAD_STATUS);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BAD_STATUS);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BAD_STATUS);
 	} else
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   rmpp_mad->rmpp_hdr.rmpp_status);
+		abort_send(agent, mad_recv_wc, rmpp_mad->rmpp_hdr.rmpp_status);
 }
 
 struct ib_mad_recv_wc *
@@ -764,8 +746,7 @@ ib_process_rmpp_recv_wc(struct ib_mad_ag
 		return mad_recv_wc;
 
 	if (rmpp_mad->rmpp_hdr.rmpp_version != IB_MGMT_RMPP_VERSION) {
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_UNV);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_UNV);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_UNV);
 		goto out;
 	}
@@ -783,8 +764,7 @@ ib_process_rmpp_recv_wc(struct ib_mad_ag
 		process_rmpp_abort(agent, mad_recv_wc);
 		break;
 	default:
-		abort_send(agent, rmpp_mad->mad_hdr.tid,
-			   IB_MGMT_RMPP_STATUS_BADT);
+		abort_send(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BADT);
 		nack_recv(agent, mad_recv_wc, IB_MGMT_RMPP_STATUS_BADT);
 		break;
 	}
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index fb6cd42..afe70a5 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -177,17 +177,6 @@ static int queue_packet(struct ib_umad_f
 	return ret;
 }
 
-static int data_offset(u8 mgmt_class)
-{
-	if (mgmt_class == IB_MGMT_CLASS_SUBN_ADM)
-		return IB_MGMT_SA_HDR;
-	else if ((mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
-		 (mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END))
-		return IB_MGMT_VENDOR_HDR;
-	else
-		return IB_MGMT_RMPP_HDR;
-}
-
 static void send_handler(struct ib_mad_agent *agent,
 			 struct ib_mad_send_wc *send_wc)
 {
@@ -283,7 +272,7 @@ static ssize_t copy_recv_mad(char __user
 			 */
 			return -ENOSPC;
 		}
-		offset = data_offset(recv_buf->mad->mad_hdr.mgmt_class);
+		offset = ib_get_mad_data_offset(recv_buf->mad->mad_hdr.mgmt_class);
 		max_seg_payload = sizeof (struct ib_mad) - offset;
 
 		for (left = packet->length - seg_payload, buf += seg_payload;
@@ -441,21 +430,14 @@ static ssize_t ib_umad_write(struct file
 	}
 
 	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
-		hdr_len = IB_MGMT_SA_HDR;
-		copy_offset = IB_MGMT_RMPP_HDR;
-		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
-			      IB_MGMT_RMPP_FLAG_ACTIVE;
-	} else if (rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START &&
-		   rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END) {
-		hdr_len = IB_MGMT_VENDOR_HDR;
+	hdr_len = ib_get_mad_data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	if (!ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)) {
+		copy_offset = IB_MGMT_MAD_HDR;
+		rmpp_active = 0;
+	} else {
 		copy_offset = IB_MGMT_RMPP_HDR;
 		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
 			      IB_MGMT_RMPP_FLAG_ACTIVE;
-	} else {
-		hdr_len = IB_MGMT_MAD_HDR;
-		copy_offset = IB_MGMT_MAD_HDR;
-		rmpp_active = 0;
 	}
 
 	data_len = count - sizeof (struct ib_user_mad) - hdr_len;
diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
index f023d39..bc5bdcb 100644
--- a/drivers/infiniband/hw/mthca/mthca_av.c
+++ b/drivers/infiniband/hw/mthca/mthca_av.c
@@ -265,7 +265,7 @@ int __devinit mthca_init_av_table(struct
 	return -ENOMEM;
 }
 
-void __devexit mthca_cleanup_av_table(struct mthca_dev *dev)
+void mthca_cleanup_av_table(struct mthca_dev *dev)
 {
 	if (mthca_is_memfree(dev))
 		return;
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 76aabc5..312cf90 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -973,7 +973,7 @@ int __devinit mthca_init_cq_table(struct
 	return err;
 }
 
-void __devexit mthca_cleanup_cq_table(struct mthca_dev *dev)
+void mthca_cleanup_cq_table(struct mthca_dev *dev)
 {
 	mthca_array_cleanup(&dev->cq_table.cq, dev->limits.num_cqs);
 	mthca_alloc_cleanup(&dev->cq_table.alloc);
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
index cbdc348..99f109c 100644
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -765,7 +765,7 @@ static int __devinit mthca_map_eq_regs(s
 
 }
 
-static void __devexit mthca_unmap_eq_regs(struct mthca_dev *dev)
+static void mthca_unmap_eq_regs(struct mthca_dev *dev)
 {
 	if (mthca_is_memfree(dev)) {
 		mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
@@ -821,7 +821,7 @@ int __devinit mthca_map_eq_icm(struct mt
 	return ret;
 }
 
-void __devexit mthca_unmap_eq_icm(struct mthca_dev *dev)
+void mthca_unmap_eq_icm(struct mthca_dev *dev)
 {
 	u8 status;
 
@@ -954,7 +954,7 @@ err_out_free:
 	return err;
 }
 
-void __devexit mthca_cleanup_eq_table(struct mthca_dev *dev)
+void mthca_cleanup_eq_table(struct mthca_dev *dev)
 {
 	u8 status;
 	int i;
diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
index 4ace6a3..dfb482e 100644
--- a/drivers/infiniband/hw/mthca/mthca_mad.c
+++ b/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -271,7 +271,7 @@ err:
 	return PTR_ERR(agent);
 }
 
-void mthca_free_agents(struct mthca_dev *dev)
+void __devexit mthca_free_agents(struct mthca_dev *dev)
 {
 	struct ib_mad_agent *agent;
 	int p, q;
diff --git a/drivers/infiniband/hw/mthca/mthca_mcg.c b/drivers/infiniband/hw/mthca/mthca_mcg.c
index 9965bda..47ca8a9 100644
--- a/drivers/infiniband/hw/mthca/mthca_mcg.c
+++ b/drivers/infiniband/hw/mthca/mthca_mcg.c
@@ -388,7 +388,7 @@ int __devinit mthca_init_mcg_table(struc
 	return 0;
 }
 
-void __devexit mthca_cleanup_mcg_table(struct mthca_dev *dev)
+void mthca_cleanup_mcg_table(struct mthca_dev *dev)
 {
 	mthca_alloc_cleanup(&dev->mcg_table.alloc);
 }
diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index 698b621..25e1c1d 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -170,7 +170,7 @@ err_out:
 	return -ENOMEM;
 }
 
-static void __devexit mthca_buddy_cleanup(struct mthca_buddy *buddy)
+static void mthca_buddy_cleanup(struct mthca_buddy *buddy)
 {
 	int i;
 
@@ -866,7 +866,7 @@ err_mtt_buddy:
 	return err;
 }
 
-void __devexit mthca_cleanup_mr_table(struct mthca_dev *dev)
+void mthca_cleanup_mr_table(struct mthca_dev *dev)
 {
 	/* XXX check if any MRs are still allocated? */
 	if (dev->limits.fmr_reserved_mtts)
diff --git a/drivers/infiniband/hw/mthca/mthca_pd.c b/drivers/infiniband/hw/mthca/mthca_pd.c
index 105fc5f..59df516 100644
--- a/drivers/infiniband/hw/mthca/mthca_pd.c
+++ b/drivers/infiniband/hw/mthca/mthca_pd.c
@@ -77,7 +77,7 @@ int __devinit mthca_init_pd_table(struct
 				dev->limits.reserved_pds);
 }
 
-void __devexit mthca_cleanup_pd_table(struct mthca_dev *dev)
+void mthca_cleanup_pd_table(struct mthca_dev *dev)
 {
 	/* XXX check if any PDs are still allocated? */
 	mthca_alloc_cleanup(&dev->pd_table.alloc);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 1bc2678..057c8e6 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -2204,7 +2204,7 @@ int __devinit mthca_init_qp_table(struct
 	return err;
 }
 
-void __devexit mthca_cleanup_qp_table(struct mthca_dev *dev)
+void mthca_cleanup_qp_table(struct mthca_dev *dev)
 {
 	int i;
 	u8 status;
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 0cfd158..2dd3aea 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -206,7 +206,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 		 roundup_pow_of_two(sizeof (struct mthca_next_seg) +
 				    srq->max_gs * sizeof (struct mthca_data_seg)));
 
-	if (ds > dev->limits.max_desc_sz)
+	if (!mthca_is_memfree(dev) && (ds > dev->limits.max_desc_sz))
 		return -EINVAL;
 
 	srq->wqe_shift = long_log2(ds);
@@ -684,7 +684,7 @@ int __devinit mthca_init_srq_table(struc
 	return err;
 }
 
-void __devexit mthca_cleanup_srq_table(struct mthca_dev *dev)
+void mthca_cleanup_srq_table(struct mthca_dev *dev)
 {
 	if (!(dev->mthca_flags & MTHCA_FLAG_SRQ))
 		return;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 53a32f6..9b0bd7c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -723,7 +723,7 @@ static int ipoib_hard_header(struct sk_b
 	 * destination address onto the front of the skb so we can
 	 * figure out where to send the packet later.
 	 */
-	if (!skb->dst || !skb->dst->neighbour) {
+	if ((!skb->dst || !skb->dst->neighbour) && daddr) {
 		struct ipoib_pseudoheader *phdr =
 			(struct ipoib_pseudoheader *) skb_push(skb, sizeof *phdr);
 		memcpy(phdr->hwaddr, daddr, INFINIBAND_ALEN);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 61924cc..fd8a95a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -607,10 +607,10 @@ static void srp_unmap_data(struct scsi_c
 	 */
 	if (likely(scmnd->use_sg)) {
 		nents = scmnd->use_sg;
-		scat  = (struct scatterlist *) scmnd->request_buffer;
+		scat  = scmnd->request_buffer;
 	} else {
 		nents = 1;
-		scat  = (struct scatterlist *) scmnd->request_buffer;
+		scat  = &req->fake_sg;
 	}
 
 	dma_unmap_sg(target->srp_host->dev->dma_device, scat, nents,
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 51ab8ed..5ff7755 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
  * Copyright (c) 2004 Intel Corporation.  All rights reserved.
  * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
- * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+ * Copyright (c) 2004-2006 Voltaire Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -55,6 +55,10 @@
 #define IB_MGMT_CLASS_DEVICE_MGMT		0x06
 #define IB_MGMT_CLASS_CM			0x07
 #define IB_MGMT_CLASS_SNMP			0x08
+#define IB_MGMT_CLASS_DEVICE_ADM		0x10
+#define IB_MGMT_CLASS_BOOT_MGMT			0x11
+#define IB_MGMT_CLASS_BIS			0x12
+#define IB_MGMT_CLASS_CONG_MGMT			0x21
 #define IB_MGMT_CLASS_VENDOR_RANGE2_START	0x30
 #define IB_MGMT_CLASS_VENDOR_RANGE2_END		0x4F
 
@@ -117,6 +121,8 @@ enum {
 	IB_MGMT_VENDOR_DATA = 216,
 	IB_MGMT_SA_HDR = 56,
 	IB_MGMT_SA_DATA = 200,
+	IB_MGMT_DEVICE_HDR = 64,
+	IB_MGMT_DEVICE_DATA = 192,
 };
 
 struct ib_mad_hdr {
@@ -603,6 +609,25 @@ struct ib_mad_send_buf * ib_create_send_
 					    gfp_t gfp_mask);
 
 /**
+ * ib_is_mad_class_rmpp - returns whether given management class
+ * supports RMPP.
+ * @mgmt_class: management class
+ *
+ * This routine returns whether the management class supports RMPP.
+ */
+int ib_is_mad_class_rmpp(u8 mgmt_class);
+
+/**
+ * ib_get_mad_data_offset - returns the data offset for a given
+ * management class.
+ * @mgmt_class: management class
+ *
+ * This routine returns the data offset in the MAD for the management
+ * class requested.
+ */
+int ib_get_mad_data_offset(u8 mgmt_class);
+
+/**
  * ib_get_rmpp_segment - returns the data buffer for a given RMPP segment.
  * @send_buf: Previously allocated send data buffer.
  * @seg_num: number of segment to return
