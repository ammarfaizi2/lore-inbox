Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWCYAA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWCYAA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWCYAA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:00:59 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14381 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750707AbWCYAA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:00:58 -0500
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] InfiniBand updates for 2.6.17
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Mar 2006 15:59:56 -0800
Message-ID: <adazmjffl6r.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Mar 2006 23:59:57.0928 (UTC) FILETIME=[0DF65680:01C64F9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Dotan Barak:
      IB/mthca: Check that sgid_index and path_mtu are valid in modify_qp

Jack Morgenstein:
      IB/mthca: Check that SRQ WQE size does not exceed device's max value
      IB/mthca: Check SRQ limit in modify SRQ operation
      IB/mthca: Fix uninitialized variable in mthca_alloc_qp()

Leonid Arsh:
      IPoIB: Pass correct pointer when flushing child interfaces
      IPoIB: Fix network interface "RUNNING" status
      IPoIB: P_Key change event handling

Roland Dreier:
      IB/srp: Use a fake scatterlist for non-SG SCSI commands
      IB/mthca: Fix indentation
      IB/mthca: Fix modify QP error path

 drivers/infiniband/hw/mthca/mthca_qp.c     |   61 ++++++++----
 drivers/infiniband/hw/mthca/mthca_srq.c    |    6 +
 drivers/infiniband/ulp/ipoib/ipoib.h       |   15 ++-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c    |   44 ++++++---
 drivers/infiniband/ulp/ipoib/ipoib_main.c  |    5 +
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c |    6 +
 drivers/infiniband/ulp/srp/ib_srp.c        |  143 +++++++++++++---------------
 drivers/infiniband/ulp/srp/ib_srp.h        |    7 +
 8 files changed, 169 insertions(+), 118 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index f673c46..1bc2678 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -483,13 +483,20 @@ out:
 	return err;
 }
 
-static void mthca_path_set(struct ib_ah_attr *ah, struct mthca_qp_path *path)
+static int mthca_path_set(struct mthca_dev *dev, struct ib_ah_attr *ah,
+			  struct mthca_qp_path *path)
 {
 	path->g_mylmc     = ah->src_path_bits & 0x7f;
 	path->rlid        = cpu_to_be16(ah->dlid);
 	path->static_rate = !!ah->static_rate;
 
 	if (ah->ah_flags & IB_AH_GRH) {
+		if (ah->grh.sgid_index >= dev->limits.gid_table_len) {
+			mthca_dbg(dev, "sgid_index (%u) too large. max is %d\n",
+				  ah->grh.sgid_index, dev->limits.gid_table_len-1);
+			return -1;
+		}
+
 		path->g_mylmc   |= 1 << 7;
 		path->mgid_index = ah->grh.sgid_index;
 		path->hop_limit  = ah->grh.hop_limit;
@@ -500,6 +507,8 @@ static void mthca_path_set(struct ib_ah_
 		memcpy(path->rgid, ah->grh.dgid.raw, 16);
 	} else
 		path->sl_tclass_flowlabel = cpu_to_be32(ah->sl << 28);
+
+	return 0;
 }
 
 int mthca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask)
@@ -592,8 +601,14 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 
 	if (qp->transport == MLX || qp->transport == UD)
 		qp_context->mtu_msgmax = (IB_MTU_2048 << 5) | 11;
-	else if (attr_mask & IB_QP_PATH_MTU)
+	else if (attr_mask & IB_QP_PATH_MTU) {
+		if (attr->path_mtu < IB_MTU_256 || attr->path_mtu > IB_MTU_2048) {
+			mthca_dbg(dev, "path MTU (%u) is invalid\n",
+				  attr->path_mtu);
+			return -EINVAL;
+		}
 		qp_context->mtu_msgmax = (attr->path_mtu << 5) | 31;
+	}
 
 	if (mthca_is_memfree(dev)) {
 		if (qp->rq.max)
@@ -642,7 +657,9 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_AV) {
-		mthca_path_set(&attr->ah_attr, &qp_context->pri_path);
+		if (mthca_path_set(dev, &attr->ah_attr, &qp_context->pri_path))
+			return -EINVAL;
+
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_PRIMARY_ADDR_PATH);
 	}
 
@@ -664,7 +681,9 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 			return -EINVAL;
 		}
 
-		mthca_path_set(&attr->alt_ah_attr, &qp_context->alt_path);
+		if (mthca_path_set(dev, &attr->alt_ah_attr, &qp_context->alt_path))
+			return -EINVAL;
+
 		qp_context->alt_path.port_pkey |= cpu_to_be32(attr->alt_pkey_index |
 							      attr->alt_port_num << 24);
 		qp_context->alt_path.ackto = attr->alt_timeout << 3;
@@ -758,21 +777,20 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 
 	err = mthca_MODIFY_QP(dev, cur_state, new_state, qp->qpn, 0,
 			      mailbox, sqd_event, &status);
+	if (err)
+		goto out;
 	if (status) {
 		mthca_warn(dev, "modify QP %d->%d returned status %02x.\n",
 			   cur_state, new_state, status);
 		err = -EINVAL;
+		goto out;
 	}
 
-	if (!err) {
-		qp->state = new_state;
-		if (attr_mask & IB_QP_ACCESS_FLAGS)
-			qp->atomic_rd_en = attr->qp_access_flags;
-		if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
-			qp->resp_depth = attr->max_dest_rd_atomic;
-	}
-
-	mthca_free_mailbox(dev, mailbox);
+	qp->state = new_state;
+	if (attr_mask & IB_QP_ACCESS_FLAGS)
+		qp->atomic_rd_en = attr->qp_access_flags;
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
+		qp->resp_depth = attr->max_dest_rd_atomic;
 
 	if (is_sqp(dev, qp))
 		store_attrs(to_msqp(qp), attr, attr_mask);
@@ -797,7 +815,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	 * If we moved a kernel QP to RESET, clean up all old CQ
 	 * entries and reinitialize the QP.
 	 */
-	if (!err && new_state == IB_QPS_RESET && !qp->ibqp.uobject) {
+	if (new_state == IB_QPS_RESET && !qp->ibqp.uobject) {
 		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn,
 			       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 		if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
@@ -816,6 +834,8 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		}
 	}
 
+out:
+	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
 
@@ -1177,10 +1197,6 @@ int mthca_alloc_qp(struct mthca_dev *dev
 {
 	int err;
 
-	err = mthca_set_qp_size(dev, cap, pd, qp);
-	if (err)
-		return err;
-
 	switch (type) {
 	case IB_QPT_RC: qp->transport = RC; break;
 	case IB_QPT_UC: qp->transport = UC; break;
@@ -1188,6 +1204,10 @@ int mthca_alloc_qp(struct mthca_dev *dev
 	default: return -EINVAL;
 	}
 
+	err = mthca_set_qp_size(dev, cap, pd, qp);
+	if (err)
+		return err;
+
 	qp->qpn = mthca_alloc(&dev->qp_table.alloc);
 	if (qp->qpn == -1)
 		return -ENOMEM;
@@ -1220,6 +1240,7 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	u32 mqpn = qpn * 2 + dev->qp_table.sqp_start + port - 1;
 	int err;
 
+	sqp->qp.transport = MLX;
 	err = mthca_set_qp_size(dev, cap, pd, &sqp->qp);
 	if (err)
 		return err;
@@ -1980,8 +2001,8 @@ int mthca_arbel_post_send(struct ib_qp *
 		wmb();
 		((struct mthca_next_seg *) prev_wqe)->ee_nds =
 			cpu_to_be32(MTHCA_NEXT_DBD | size |
-                                    ((wr->send_flags & IB_SEND_FENCE) ?
-                                    MTHCA_NEXT_FENCE : 0));
+				    ((wr->send_flags & IB_SEND_FENCE) ?
+				     MTHCA_NEXT_FENCE : 0));
 
 		if (!size0) {
 			size0 = size;
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 47a6a75..0cfd158 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -205,6 +205,10 @@ int mthca_alloc_srq(struct mthca_dev *de
 	ds = max(64UL,
 		 roundup_pow_of_two(sizeof (struct mthca_next_seg) +
 				    srq->max_gs * sizeof (struct mthca_data_seg)));
+
+	if (ds > dev->limits.max_desc_sz)
+		return -EINVAL;
+
 	srq->wqe_shift = long_log2(ds);
 
 	srq->srqn = mthca_alloc(&dev->srq_table.alloc);
@@ -354,6 +358,8 @@ int mthca_modify_srq(struct ib_srq *ibsr
 		return -EINVAL;
 
 	if (attr_mask & IB_SRQ_LIMIT) {
+		if (attr->srq_limit > srq->max)
+			return -EINVAL;
 		ret = mthca_ARM_SRQ(dev, srq->srqn, attr->srq_limit, &status);
 		if (ret)
 			return ret;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 1251f86..b640107 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -72,13 +72,14 @@ enum {
 	IPOIB_MAX_MCAST_QUEUE     = 3,
 
 	IPOIB_FLAG_OPER_UP 	  = 0,
-	IPOIB_FLAG_ADMIN_UP 	  = 1,
-	IPOIB_PKEY_ASSIGNED 	  = 2,
-	IPOIB_PKEY_STOP 	  = 3,
-	IPOIB_FLAG_SUBINTERFACE   = 4,
-	IPOIB_MCAST_RUN 	  = 5,
-	IPOIB_STOP_REAPER         = 6,
-	IPOIB_MCAST_STARTED       = 7,
+	IPOIB_FLAG_INITIALIZED    = 1,
+	IPOIB_FLAG_ADMIN_UP 	  = 2,
+	IPOIB_PKEY_ASSIGNED 	  = 3,
+	IPOIB_PKEY_STOP 	  = 4,
+	IPOIB_FLAG_SUBINTERFACE   = 5,
+	IPOIB_MCAST_RUN 	  = 6,
+	IPOIB_STOP_REAPER         = 7,
+	IPOIB_MCAST_STARTED       = 8,
 
 	IPOIB_MAX_BACKOFF_SECONDS = 16,
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index a1f5a05..ed65202 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -423,13 +423,33 @@ int ipoib_ib_dev_open(struct net_device 
 	clear_bit(IPOIB_STOP_REAPER, &priv->flags);
 	queue_delayed_work(ipoib_workqueue, &priv->ah_reap_task, HZ);
 
+	set_bit(IPOIB_FLAG_INITIALIZED, &priv->flags);
+
 	return 0;
 }
 
+static void ipoib_pkey_dev_check_presence(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	u16 pkey_index = 0;
+
+	if (ib_find_cached_pkey(priv->ca, priv->port, priv->pkey, &pkey_index))
+		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+	else
+		set_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+}
+
 int ipoib_ib_dev_up(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
+	ipoib_pkey_dev_check_presence(dev);
+
+	if (!test_bit(IPOIB_PKEY_ASSIGNED, &priv->flags)) {
+		ipoib_dbg(priv, "PKEY is not assigned.\n");
+		return 0;
+	}
+
 	set_bit(IPOIB_FLAG_OPER_UP, &priv->flags);
 
 	return ipoib_mcast_start_thread(dev);
@@ -483,6 +503,8 @@ int ipoib_ib_dev_stop(struct net_device 
 	struct ipoib_tx_buf *tx_req;
 	int i;
 
+	clear_bit(IPOIB_FLAG_INITIALIZED, &priv->flags);
+
 	/*
 	 * Move our QP to the error state and then reinitialize in
 	 * when all work requests have completed or have been flushed.
@@ -587,8 +609,15 @@ void ipoib_ib_dev_flush(void *_dev)
 	struct net_device *dev = (struct net_device *)_dev;
 	struct ipoib_dev_priv *priv = netdev_priv(dev), *cpriv;
 
-	if (!test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
+	if (!test_bit(IPOIB_FLAG_INITIALIZED, &priv->flags) ) {
+		ipoib_dbg(priv, "Not flushing - IPOIB_FLAG_INITIALIZED not set.\n");
+		return;
+	}
+
+	if (!test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)) {
+		ipoib_dbg(priv, "Not flushing - IPOIB_FLAG_ADMIN_UP not set.\n");
 		return;
+	}
 
 	ipoib_dbg(priv, "flushing\n");
 
@@ -605,7 +634,7 @@ void ipoib_ib_dev_flush(void *_dev)
 
 	/* Flush any child interfaces too */
 	list_for_each_entry(cpriv, &priv->child_intfs, list)
-		ipoib_ib_dev_flush(&cpriv->dev);
+		ipoib_ib_dev_flush(cpriv->dev);
 
 	mutex_unlock(&priv->vlan_mutex);
 }
@@ -632,17 +661,6 @@ void ipoib_ib_dev_cleanup(struct net_dev
  * change async notification is available.
  */
 
-static void ipoib_pkey_dev_check_presence(struct net_device *dev)
-{
-	struct ipoib_dev_priv *priv = netdev_priv(dev);
-	u16 pkey_index = 0;
-
-	if (ib_find_cached_pkey(priv->ca, priv->port, priv->pkey, &pkey_index))
-		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
-	else
-		set_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
-}
-
 void ipoib_pkey_poll(void *dev_ptr)
 {
 	struct net_device *dev = dev_ptr;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 37da8d3..53a32f6 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -736,6 +736,11 @@ static void ipoib_set_mcast_list(struct 
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
+	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags)) {
+		ipoib_dbg(priv, "IPOIB_FLAG_OPER_UP not set");
+		return;
+	}
+
 	queue_work(ipoib_workqueue, &priv->restart_task);
 }
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 18d2f53..5f03880 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -251,10 +251,12 @@ void ipoib_event(struct ib_event_handler
 	struct ipoib_dev_priv *priv =
 		container_of(handler, struct ipoib_dev_priv, event_handler);
 
-	if (record->event == IB_EVENT_PORT_ACTIVE ||
+	if (record->event == IB_EVENT_PORT_ERR    ||
+	    record->event == IB_EVENT_PKEY_CHANGE ||
+	    record->event == IB_EVENT_PORT_ACTIVE ||
 	    record->event == IB_EVENT_LID_CHANGE  ||
 	    record->event == IB_EVENT_SM_CHANGE) {
-		ipoib_dbg(priv, "Port active event\n");
+		ipoib_dbg(priv, "Port state change event\n");
 		queue_work(ipoib_workqueue, &priv->flush_task);
 	}
 }
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index a13dcdf..61924cc 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -503,8 +503,10 @@ err:
 static int srp_map_data(struct scsi_cmnd *scmnd, struct srp_target_port *target,
 			struct srp_request *req)
 {
+	struct scatterlist *scat;
 	struct srp_cmd *cmd = req->cmd->buf;
-	int len;
+	int len, nents, count;
+	int i;
 	u8 fmt;
 
 	if (!scmnd->request_buffer || scmnd->sc_data_direction == DMA_NONE)
@@ -517,82 +519,66 @@ static int srp_map_data(struct scsi_cmnd
 		return -EINVAL;
 	}
 
-	if (scmnd->use_sg) {
-		struct scatterlist *scat = scmnd->request_buffer;
-		int n;
-		int i;
+	/*
+	 * This handling of non-SG commands can be killed when the
+	 * SCSI midlayer no longer generates non-SG commands.
+	 */
+	if (likely(scmnd->use_sg)) {
+		nents = scmnd->use_sg;
+		scat  = scmnd->request_buffer;
+	} else {
+		nents = 1;
+		scat  = &req->fake_sg;
+		sg_init_one(scat, scmnd->request_buffer, scmnd->request_bufflen);
+	}
 
-		n = dma_map_sg(target->srp_host->dev->dma_device,
-			       scat, scmnd->use_sg, scmnd->sc_data_direction);
+	count = dma_map_sg(target->srp_host->dev->dma_device, scat, nents,
+			   scmnd->sc_data_direction);
 
-		if (n == 1) {
-			struct srp_direct_buf *buf = (void *) cmd->add_data;
+	if (count == 1) {
+		struct srp_direct_buf *buf = (void *) cmd->add_data;
 
-			fmt = SRP_DATA_DESC_DIRECT;
+		fmt = SRP_DATA_DESC_DIRECT;
 
-			buf->va  = cpu_to_be64(sg_dma_address(scat));
-			buf->key = cpu_to_be32(target->srp_host->mr->rkey);
-			buf->len = cpu_to_be32(sg_dma_len(scat));
+		buf->va  = cpu_to_be64(sg_dma_address(scat));
+		buf->key = cpu_to_be32(target->srp_host->mr->rkey);
+		buf->len = cpu_to_be32(sg_dma_len(scat));
 
-			len = sizeof (struct srp_cmd) +
-				sizeof (struct srp_direct_buf);
-		} else {
-			struct srp_indirect_buf *buf = (void *) cmd->add_data;
-			u32 datalen = 0;
+		len = sizeof (struct srp_cmd) +
+			sizeof (struct srp_direct_buf);
+	} else {
+		struct srp_indirect_buf *buf = (void *) cmd->add_data;
+		u32 datalen = 0;
 
-			fmt = SRP_DATA_DESC_INDIRECT;
+		fmt = SRP_DATA_DESC_INDIRECT;
 
-			if (scmnd->sc_data_direction == DMA_TO_DEVICE)
-				cmd->data_out_desc_cnt = n;
-			else
-				cmd->data_in_desc_cnt = n;
+		if (scmnd->sc_data_direction == DMA_TO_DEVICE)
+			cmd->data_out_desc_cnt = count;
+		else
+			cmd->data_in_desc_cnt = count;
 
-			buf->table_desc.va  = cpu_to_be64(req->cmd->dma +
-							  sizeof *cmd +
-							  sizeof *buf);
-			buf->table_desc.key =
+		buf->table_desc.va  = cpu_to_be64(req->cmd->dma +
+						  sizeof *cmd +
+						  sizeof *buf);
+		buf->table_desc.key =
+			cpu_to_be32(target->srp_host->mr->rkey);
+		buf->table_desc.len =
+			cpu_to_be32(count * sizeof (struct srp_direct_buf));
+
+		for (i = 0; i < count; ++i) {
+			buf->desc_list[i].va  = cpu_to_be64(sg_dma_address(&scat[i]));
+			buf->desc_list[i].key =
 				cpu_to_be32(target->srp_host->mr->rkey);
-			buf->table_desc.len =
-				cpu_to_be32(n * sizeof (struct srp_direct_buf));
-
-			for (i = 0; i < n; ++i) {
-				buf->desc_list[i].va  = cpu_to_be64(sg_dma_address(&scat[i]));
-				buf->desc_list[i].key =
-					cpu_to_be32(target->srp_host->mr->rkey);
-				buf->desc_list[i].len = cpu_to_be32(sg_dma_len(&scat[i]));
-
-				datalen += sg_dma_len(&scat[i]);
-			}
-
-			buf->len = cpu_to_be32(datalen);
+			buf->desc_list[i].len = cpu_to_be32(sg_dma_len(&scat[i]));
 
-			len = sizeof (struct srp_cmd) +
-				sizeof (struct srp_indirect_buf) +
-				n * sizeof (struct srp_direct_buf);
-		}
-	} else {
-		struct srp_direct_buf *buf = (void *) cmd->add_data;
-		dma_addr_t dma;
-
-		dma = dma_map_single(target->srp_host->dev->dma_device,
-				     scmnd->request_buffer, scmnd->request_bufflen,
-				     scmnd->sc_data_direction);
-		if (dma_mapping_error(dma)) {
-			printk(KERN_WARNING PFX "unable to map %p/%d (dir %d)\n",
-			       scmnd->request_buffer, (int) scmnd->request_bufflen,
-			       scmnd->sc_data_direction);
-			return -EINVAL;
+			datalen += sg_dma_len(&scat[i]);
 		}
 
-		pci_unmap_addr_set(req, direct_mapping, dma);
-
-		buf->va  = cpu_to_be64(dma);
-		buf->key = cpu_to_be32(target->srp_host->mr->rkey);
-		buf->len = cpu_to_be32(scmnd->request_bufflen);
-
-		fmt = SRP_DATA_DESC_DIRECT;
+		buf->len = cpu_to_be32(datalen);
 
-		len = sizeof (struct srp_cmd) + sizeof (struct srp_direct_buf);
+		len = sizeof (struct srp_cmd) +
+			sizeof (struct srp_indirect_buf) +
+			count * sizeof (struct srp_direct_buf);
 	}
 
 	if (scmnd->sc_data_direction == DMA_TO_DEVICE)
@@ -600,7 +586,6 @@ static int srp_map_data(struct scsi_cmnd
 	else
 		cmd->buf_fmt = fmt;
 
-
 	return len;
 }
 
@@ -608,20 +593,28 @@ static void srp_unmap_data(struct scsi_c
 			   struct srp_target_port *target,
 			   struct srp_request *req)
 {
+	struct scatterlist *scat;
+	int nents;
+
 	if (!scmnd->request_buffer ||
 	    (scmnd->sc_data_direction != DMA_TO_DEVICE &&
 	     scmnd->sc_data_direction != DMA_FROM_DEVICE))
-	    return;
+		return;
 
-	if (scmnd->use_sg)
-		dma_unmap_sg(target->srp_host->dev->dma_device,
-			     (struct scatterlist *) scmnd->request_buffer,
-			     scmnd->use_sg, scmnd->sc_data_direction);
-	else
-		dma_unmap_single(target->srp_host->dev->dma_device,
-				 pci_unmap_addr(req, direct_mapping),
-				 scmnd->request_bufflen,
-				 scmnd->sc_data_direction);
+	/*
+	 * This handling of non-SG commands can be killed when the
+	 * SCSI midlayer no longer generates non-SG commands.
+	 */
+	if (likely(scmnd->use_sg)) {
+		nents = scmnd->use_sg;
+		scat  = (struct scatterlist *) scmnd->request_buffer;
+	} else {
+		nents = 1;
+		scat  = (struct scatterlist *) scmnd->request_buffer;
+	}
+
+	dma_unmap_sg(target->srp_host->dev->dma_device, scat, nents,
+		     scmnd->sc_data_direction);
 }
 
 static void srp_process_rsp(struct srp_target_port *target, struct srp_rsp *rsp)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 4e7727d..bd7f7c3 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -38,6 +38,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/scatterlist.h>
 
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -94,7 +95,11 @@ struct srp_request {
 	struct scsi_cmnd       *scmnd;
 	struct srp_iu	       *cmd;
 	struct srp_iu	       *tsk_mgmt;
-	DECLARE_PCI_UNMAP_ADDR(direct_mapping)
+	/*
+	 * Fake scatterlist used when scmnd->use_sg==0.  Can be killed
+	 * when the SCSI midlayer no longer generates non-SG commands.
+	 */
+	struct scatterlist	fake_sg;
 	struct completion	done;
 	short			next;
 	u8			cmd_done;
