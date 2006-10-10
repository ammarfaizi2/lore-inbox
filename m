Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWJJVDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWJJVDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWJJVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:03:11 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:63520 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1030378AbWJJVDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:03:04 -0400
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="330115465:sNHT513100090"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 14:03:02 -0700
Message-ID: <adau02bdgu1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Oct 2006 21:03:03.0457 (UTC) FILETIME=[79DC9910:01C6ECAF]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes various fixes found since 2.6.19-rc1:

Ishai Rabinovitz:
      IB/srp: Remove redundant memset()
      IB/srp: Enable multiple connections to the same target

Jack Morgenstein:
      IB/mthca: Query port fix

Michael S. Tsirkin:
      IB/mthca: Fix off-by-one in mthca SRQ creation

Roland Dreier:
      RDMA/amso1100: Fix build with debugging off
      IPoIB: Check for DMA mapping error for TX packets

Sean Hefty:
      IB/cm: Fix timewait crash after module unload
      IB/cm: Send DREP in response to unmatched DREQ

Tom Tucker:
      RDMA/amso1100: Add spinlocks to serialize ib_post_send/ib_post_recv

 drivers/infiniband/core/cm.c                 |   84 ++++++++++++++++++++------
 drivers/infiniband/hw/amso1100/c2_ae.c       |    2 -
 drivers/infiniband/hw/amso1100/c2_qp.c       |   16 ++++-
 drivers/infiniband/hw/mthca/mthca_provider.c |    2 +
 drivers/infiniband/hw/mthca/mthca_srq.c      |    6 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c      |    5 ++
 drivers/infiniband/ulp/srp/ib_srp.c          |   27 +++++---
 drivers/infiniband/ulp/srp/ib_srp.h          |    2 -
 8 files changed, 106 insertions(+), 38 deletions(-)


diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f35fcc4..25b1018 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -75,6 +75,7 @@ static struct ib_cm {
 	struct rb_root remote_sidr_table;
 	struct idr local_id_table;
 	__be32 random_id_operand;
+	struct list_head timewait_list;
 	struct workqueue_struct *wq;
 } cm;
 
@@ -112,6 +113,7 @@ struct cm_work {
 
 struct cm_timewait_info {
 	struct cm_work work;			/* Must be first. */
+	struct list_head list;
 	struct rb_node remote_qp_node;
 	struct rb_node remote_id_node;
 	__be64 remote_ca_guid;
@@ -647,13 +649,6 @@ static inline int cm_convert_to_ms(int i
 
 static void cm_cleanup_timewait(struct cm_timewait_info *timewait_info)
 {
-	unsigned long flags;
-
-	if (!timewait_info->inserted_remote_id &&
-	    !timewait_info->inserted_remote_qp)
-	    return;
-
-	spin_lock_irqsave(&cm.lock, flags);
 	if (timewait_info->inserted_remote_id) {
 		rb_erase(&timewait_info->remote_id_node, &cm.remote_id_table);
 		timewait_info->inserted_remote_id = 0;
@@ -663,7 +658,6 @@ static void cm_cleanup_timewait(struct c
 		rb_erase(&timewait_info->remote_qp_node, &cm.remote_qp_table);
 		timewait_info->inserted_remote_qp = 0;
 	}
-	spin_unlock_irqrestore(&cm.lock, flags);
 }
 
 static struct cm_timewait_info * cm_create_timewait_info(__be32 local_id)
@@ -684,8 +678,12 @@ static struct cm_timewait_info * cm_crea
 static void cm_enter_timewait(struct cm_id_private *cm_id_priv)
 {
 	int wait_time;
+	unsigned long flags;
 
+	spin_lock_irqsave(&cm.lock, flags);
 	cm_cleanup_timewait(cm_id_priv->timewait_info);
+	list_add_tail(&cm_id_priv->timewait_info->list, &cm.timewait_list);
+	spin_unlock_irqrestore(&cm.lock, flags);
 
 	/*
 	 * The cm_id could be destroyed by the user before we exit timewait.
@@ -701,9 +699,13 @@ static void cm_enter_timewait(struct cm_
 
 static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 {
+	unsigned long flags;
+
 	cm_id_priv->id.state = IB_CM_IDLE;
 	if (cm_id_priv->timewait_info) {
+		spin_lock_irqsave(&cm.lock, flags);
 		cm_cleanup_timewait(cm_id_priv->timewait_info);
+		spin_unlock_irqrestore(&cm.lock, flags);
 		kfree(cm_id_priv->timewait_info);
 		cm_id_priv->timewait_info = NULL;
 	}
@@ -1307,6 +1309,7 @@ static struct cm_id_private * cm_match_r
 	if (timewait_info) {
 		cur_cm_id_priv = cm_get_id(timewait_info->work.local_id,
 					   timewait_info->work.remote_id);
+		cm_cleanup_timewait(cm_id_priv->timewait_info);
 		spin_unlock_irqrestore(&cm.lock, flags);
 		if (cur_cm_id_priv) {
 			cm_dup_req_handler(work, cur_cm_id_priv);
@@ -1315,7 +1318,8 @@ static struct cm_id_private * cm_match_r
 			cm_issue_rej(work->port, work->mad_recv_wc,
 				     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REQ,
 				     NULL, 0);
-		goto error;
+		listen_cm_id_priv = NULL;
+		goto out;
 	}
 
 	/* Find matching listen request. */
@@ -1323,21 +1327,20 @@ static struct cm_id_private * cm_match_r
 					   req_msg->service_id,
 					   req_msg->private_data);
 	if (!listen_cm_id_priv) {
+		cm_cleanup_timewait(cm_id_priv->timewait_info);
 		spin_unlock_irqrestore(&cm.lock, flags);
 		cm_issue_rej(work->port, work->mad_recv_wc,
 			     IB_CM_REJ_INVALID_SERVICE_ID, CM_MSG_RESPONSE_REQ,
 			     NULL, 0);
-		goto error;
+		goto out;
 	}
 	atomic_inc(&listen_cm_id_priv->refcount);
 	atomic_inc(&cm_id_priv->refcount);
 	cm_id_priv->id.state = IB_CM_REQ_RCVD;
 	atomic_inc(&cm_id_priv->work_count);
 	spin_unlock_irqrestore(&cm.lock, flags);
+out:
 	return listen_cm_id_priv;
-
-error:	cm_cleanup_timewait(cm_id_priv->timewait_info);
-	return NULL;
 }
 
 static int cm_req_handler(struct cm_work *work)
@@ -1899,6 +1902,32 @@ out:	spin_unlock_irqrestore(&cm_id_priv-
 }
 EXPORT_SYMBOL(ib_send_cm_drep);
 
+static int cm_issue_drep(struct cm_port *port,
+			 struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct ib_mad_send_buf *msg = NULL;
+	struct cm_dreq_msg *dreq_msg;
+	struct cm_drep_msg *drep_msg;
+	int ret;
+
+	ret = cm_alloc_response_msg(port, mad_recv_wc, &msg);
+	if (ret)
+		return ret;
+
+	dreq_msg = (struct cm_dreq_msg *) mad_recv_wc->recv_buf.mad;
+	drep_msg = (struct cm_drep_msg *) msg->mad;
+
+	cm_format_mad_hdr(&drep_msg->hdr, CM_DREP_ATTR_ID, dreq_msg->hdr.tid);
+	drep_msg->remote_comm_id = dreq_msg->local_comm_id;
+	drep_msg->local_comm_id = dreq_msg->remote_comm_id;
+
+	ret = ib_post_send_mad(msg, NULL);
+	if (ret)
+		cm_free_msg(msg);
+
+	return ret;
+}
+
 static int cm_dreq_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
@@ -1910,8 +1939,10 @@ static int cm_dreq_handler(struct cm_wor
 	dreq_msg = (struct cm_dreq_msg *)work->mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(dreq_msg->remote_comm_id,
 				   dreq_msg->local_comm_id);
-	if (!cm_id_priv)
+	if (!cm_id_priv) {
+		cm_issue_drep(work->port, work->mad_recv_wc);
 		return -EINVAL;
+	}
 
 	work->cm_event.private_data = &dreq_msg->private_data;
 
@@ -2601,28 +2632,29 @@ static int cm_timewait_handler(struct cm
 {
 	struct cm_timewait_info *timewait_info;
 	struct cm_id_private *cm_id_priv;
-	unsigned long flags;
 	int ret;
 
 	timewait_info = (struct cm_timewait_info *)work;
-	cm_cleanup_timewait(timewait_info);
+	spin_lock_irq(&cm.lock);
+	list_del(&timewait_info->list);
+	spin_unlock_irq(&cm.lock);
 
 	cm_id_priv = cm_acquire_id(timewait_info->work.local_id,
 				   timewait_info->work.remote_id);
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_TIMEWAIT ||
 	    cm_id_priv->remote_qpn != timewait_info->remote_qpn) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		spin_unlock_irq(&cm_id_priv->lock);
 		goto out;
 	}
 	cm_id_priv->id.state = IB_CM_IDLE;
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!ret)
 		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	spin_unlock_irq(&cm_id_priv->lock);
 
 	if (ret)
 		cm_process_work(cm_id_priv, work);
@@ -3374,6 +3406,7 @@ static int __init ib_cm_init(void)
 	idr_init(&cm.local_id_table);
 	get_random_bytes(&cm.random_id_operand, sizeof cm.random_id_operand);
 	idr_pre_get(&cm.local_id_table, GFP_KERNEL);
+	INIT_LIST_HEAD(&cm.timewait_list);
 
 	cm.wq = create_workqueue("ib_cm");
 	if (!cm.wq)
@@ -3391,7 +3424,20 @@ error:
 
 static void __exit ib_cm_cleanup(void)
 {
+	struct cm_timewait_info *timewait_info, *tmp;
+
+	spin_lock_irq(&cm.lock);
+	list_for_each_entry(timewait_info, &cm.timewait_list, list)
+		cancel_delayed_work(&timewait_info->work.work);
+	spin_unlock_irq(&cm.lock);
+
 	destroy_workqueue(cm.wq);
+
+	list_for_each_entry_safe(timewait_info, tmp, &cm.timewait_list, list) {
+		list_del(&timewait_info->list);
+		kfree(timewait_info);
+	}
+
 	ib_unregister_client(&cm_client);
 	idr_destroy(&cm.local_id_table);
 }
diff --git a/drivers/infiniband/hw/amso1100/c2_ae.c b/drivers/infiniband/hw/amso1100/c2_ae.c
index 3aae497..a31439b 100644
--- a/drivers/infiniband/hw/amso1100/c2_ae.c
+++ b/drivers/infiniband/hw/amso1100/c2_ae.c
@@ -66,7 +66,6 @@ static int c2_convert_cm_status(u32 c2_s
 	}
 }
 
-#ifdef DEBUG
 static const char* to_event_str(int event)
 {
 	static const char* event_str[] = {
@@ -144,7 +143,6 @@ static const char *to_qp_state_str(int s
 		return "<invalid QP state>";
 	};
 }
-#endif
 
 void c2_ae_event(struct c2_dev *c2dev, u32 mq_index)
 {
diff --git a/drivers/infiniband/hw/amso1100/c2_qp.c b/drivers/infiniband/hw/amso1100/c2_qp.c
index 1226113..5bcf697 100644
--- a/drivers/infiniband/hw/amso1100/c2_qp.c
+++ b/drivers/infiniband/hw/amso1100/c2_qp.c
@@ -35,6 +35,8 @@
  *
  */
 
+#include <linux/delay.h>
+
 #include "c2.h"
 #include "c2_vq.h"
 #include "c2_status.h"
@@ -705,10 +707,8 @@ static inline void c2_activity(struct c2
 	 * cannot get on the bus and the card and system hang in a
 	 * deadlock -- thus the need for this code. [TOT]
 	 */
-	while (readl(c2dev->regs + PCI_BAR0_ADAPTER_HINT) & 0x80000000) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(0);
-	}
+	while (readl(c2dev->regs + PCI_BAR0_ADAPTER_HINT) & 0x80000000)
+		udelay(10);
 
 	__raw_writel(C2_HINT_MAKE(mq_index, shared),
 		     c2dev->regs + PCI_BAR0_ADAPTER_HINT);
@@ -766,6 +766,7 @@ int c2_post_send(struct ib_qp *ibqp, str
 	struct c2_dev *c2dev = to_c2dev(ibqp->device);
 	struct c2_qp *qp = to_c2qp(ibqp);
 	union c2wr wr;
+	unsigned long lock_flags;
 	int err = 0;
 
 	u32 flags;
@@ -881,8 +882,10 @@ int c2_post_send(struct ib_qp *ibqp, str
 		/*
 		 * Post the puppy!
 		 */
+		spin_lock_irqsave(&qp->lock, lock_flags);
 		err = qp_wr_post(&qp->sq_mq, &wr, qp, msg_size);
 		if (err) {
+			spin_unlock_irqrestore(&qp->lock, lock_flags);
 			break;
 		}
 
@@ -890,6 +893,7 @@ int c2_post_send(struct ib_qp *ibqp, str
 		 * Enqueue mq index to activity FIFO.
 		 */
 		c2_activity(c2dev, qp->sq_mq.index, qp->sq_mq.hint_count);
+		spin_unlock_irqrestore(&qp->lock, lock_flags);
 
 		ib_wr = ib_wr->next;
 	}
@@ -905,6 +909,7 @@ int c2_post_receive(struct ib_qp *ibqp, 
 	struct c2_dev *c2dev = to_c2dev(ibqp->device);
 	struct c2_qp *qp = to_c2qp(ibqp);
 	union c2wr wr;
+	unsigned long lock_flags;
 	int err = 0;
 
 	if (qp->state > IB_QPS_RTS)
@@ -945,8 +950,10 @@ int c2_post_receive(struct ib_qp *ibqp, 
 			break;
 		}
 
+		spin_lock_irqsave(&qp->lock, lock_flags);
 		err = qp_wr_post(&qp->rq_mq, &wr, qp, qp->rq_mq.msg_size);
 		if (err) {
+			spin_unlock_irqrestore(&qp->lock, lock_flags);
 			break;
 		}
 
@@ -954,6 +961,7 @@ int c2_post_receive(struct ib_qp *ibqp, 
 		 * Enqueue mq index to activity FIFO
 		 */
 		c2_activity(c2dev, qp->rq_mq.index, qp->rq_mq.hint_count);
+		spin_unlock_irqrestore(&qp->lock, lock_flags);
 
 		ib_wr = ib_wr->next;
 	}
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 981fe2e..fc67f78 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -179,6 +179,8 @@ static int mthca_query_port(struct ib_de
 	props->max_mtu           = out_mad->data[41] & 0xf;
 	props->active_mtu        = out_mad->data[36] >> 4;
 	props->subnet_timeout    = out_mad->data[51] & 0x1f;
+	props->max_vl_num        = out_mad->data[37] >> 4;
+	props->init_type_reply   = out_mad->data[41] >> 4;
 
  out:
 	kfree(in_mad);
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 0f316c8..92a72f5 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -201,6 +201,8 @@ int mthca_alloc_srq(struct mthca_dev *de
 
 	if (mthca_is_memfree(dev))
 		srq->max = roundup_pow_of_two(srq->max + 1);
+	else
+		srq->max = srq->max + 1;
 
 	ds = max(64UL,
 		 roundup_pow_of_two(sizeof (struct mthca_next_seg) +
@@ -277,7 +279,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 	srq->first_free = 0;
 	srq->last_free  = srq->max - 1;
 
-	attr->max_wr    = (mthca_is_memfree(dev)) ? srq->max - 1 : srq->max;
+	attr->max_wr    = srq->max - 1;
 	attr->max_sge   = srq->max_gs;
 
 	return 0;
@@ -413,7 +415,7 @@ int mthca_query_srq(struct ib_srq *ibsrq
 		srq_attr->srq_limit = be16_to_cpu(tavor_ctx->limit_watermark);
 	}
 
-	srq_attr->max_wr  = (mthca_is_memfree(dev)) ? srq->max - 1 : srq->max;
+	srq_attr->max_wr  = srq->max - 1;
 	srq_attr->max_sge = srq->max_gs;
 
 out:
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index f426a69..8bf5e9e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -355,6 +355,11 @@ void ipoib_send(struct net_device *dev, 
 	tx_req->skb = skb;
 	addr = dma_map_single(priv->ca->dma_device, skb->data, skb->len,
 			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(addr))) {
+		++priv->stats.tx_errors;
+		dev_kfree_skb_any(skb);
+		return;
+	}
 	pci_unmap_addr_set(tx_req, mapping, addr);
 
 	if (unlikely(post_send(priv, priv->tx_head & (ipoib_sendq_size - 1),
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 44b9e5b..4b09147 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -343,29 +343,32 @@ static int srp_send_req(struct srp_targe
 	 */
 	if (target->io_class == SRP_REV10_IB_IO_CLASS) {
 		memcpy(req->priv.initiator_port_id,
-		       target->srp_host->initiator_port_id + 8, 8);
+		       &target->path.sgid.global.interface_id, 8);
 		memcpy(req->priv.initiator_port_id + 8,
-		       target->srp_host->initiator_port_id, 8);
+		       &target->initiator_ext, 8);
 		memcpy(req->priv.target_port_id,     &target->ioc_guid, 8);
 		memcpy(req->priv.target_port_id + 8, &target->id_ext, 8);
 	} else {
 		memcpy(req->priv.initiator_port_id,
-		       target->srp_host->initiator_port_id, 16);
+		       &target->initiator_ext, 8);
+		memcpy(req->priv.initiator_port_id + 8,
+		       &target->path.sgid.global.interface_id, 8);
 		memcpy(req->priv.target_port_id,     &target->id_ext, 8);
 		memcpy(req->priv.target_port_id + 8, &target->ioc_guid, 8);
 	}
 
 	/*
 	 * Topspin/Cisco SRP targets will reject our login unless we
-	 * zero out the first 8 bytes of our initiator port ID.  The
-	 * second 8 bytes must be our local node GUID, but we always
-	 * use that anyway.
+	 * zero out the first 8 bytes of our initiator port ID and set
+	 * the second 8 bytes to the local node GUID.
 	 */
 	if (topspin_workarounds && !memcmp(&target->ioc_guid, topspin_oui, 3)) {
 		printk(KERN_DEBUG PFX "Topspin/Cisco initiator port ID workaround "
 		       "activated for target GUID %016llx\n",
 		       (unsigned long long) be64_to_cpu(target->ioc_guid));
 		memset(req->priv.initiator_port_id, 0, 8);
+		memcpy(req->priv.initiator_port_id + 8,
+		       &target->srp_host->dev->dev->node_guid, 8);
 	}
 
 	status = ib_send_cm_req(target->cm_id, &req->param);
@@ -1553,6 +1556,7 @@ enum {
 	SRP_OPT_MAX_SECT	= 1 << 5,
 	SRP_OPT_MAX_CMD_PER_LUN	= 1 << 6,
 	SRP_OPT_IO_CLASS	= 1 << 7,
+	SRP_OPT_INITIATOR_EXT	= 1 << 8,
 	SRP_OPT_ALL		= (SRP_OPT_ID_EXT	|
 				   SRP_OPT_IOC_GUID	|
 				   SRP_OPT_DGID		|
@@ -1569,6 +1573,7 @@ static match_table_t srp_opt_tokens = {
 	{ SRP_OPT_MAX_SECT,		"max_sect=%d" 		},
 	{ SRP_OPT_MAX_CMD_PER_LUN,	"max_cmd_per_lun=%d" 	},
 	{ SRP_OPT_IO_CLASS,		"io_class=%x"		},
+	{ SRP_OPT_INITIATOR_EXT,	"initiator_ext=%s"	},
 	{ SRP_OPT_ERR,			NULL 			}
 };
 
@@ -1668,6 +1673,12 @@ static int srp_parse_options(const char 
 			target->io_class = token;
 			break;
 
+		case SRP_OPT_INITIATOR_EXT:
+			p = match_strdup(args);
+			target->initiator_ext = cpu_to_be64(simple_strtoull(p, NULL, 16));
+			kfree(p);
+			break;
+
 		default:
 			printk(KERN_WARNING PFX "unknown parameter or missing value "
 			       "'%s' in target creation request\n", p);
@@ -1708,7 +1719,6 @@ static ssize_t srp_create_target(struct 
 	target_host->max_lun = SRP_MAX_LUN;
 
 	target = host_to_target(target_host);
-	memset(target, 0, sizeof *target);
 
 	target->io_class   = SRP_REV16A_IB_IO_CLASS;
 	target->scsi_host  = target_host;
@@ -1815,9 +1825,6 @@ static struct srp_host *srp_add_port(str
 	host->dev  = device;
 	host->port = port;
 
-	host->initiator_port_id[7] = port;
-	memcpy(host->initiator_port_id + 8, &device->dev->node_guid, 8);
-
 	host->class_dev.class = &srp_class;
 	host->class_dev.dev   = device->dev->dma_device;
 	snprintf(host->class_dev.class_id, BUS_ID_SIZE, "srp-%s-%d",
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 5b581fb..d4e35ef 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -91,7 +91,6 @@ struct srp_device {
 };
 
 struct srp_host {
-	u8			initiator_port_id[16];
 	struct srp_device      *dev;
 	u8			port;
 	struct class_device	class_dev;
@@ -122,6 +121,7 @@ struct srp_target_port {
 	__be64			id_ext;
 	__be64			ioc_guid;
 	__be64			service_id;
+	__be64			initiator_ext;
 	u16			io_class;
 	struct srp_host	       *srp_host;
 	struct Scsi_Host       *scsi_host;
