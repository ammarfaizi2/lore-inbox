Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932875AbWF2V6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWF2V6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWF2V6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:58:11 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34191 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932875AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 39] IB/ipath - enforce device resource limits
X-Mercurial-Node: a94e9f9c9c23c0140a766317589007f4ebb74a5b
Message-Id: <a94e9f9c9c23c0140a76.1151617264@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:04 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These limits are somewhat artificial in that we don't actually have any
device limits.  However, the verbs layer expects that such limits exist
and are enforced, so we make up arbitrary (but sensible) limits.

Signed-off-by: Robert Walsh <robert.walsh@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 21d5d64750ac -r a94e9f9c9c23 drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Jun 29 14:33:25 2006 -0700
@@ -158,9 +158,20 @@ struct ib_cq *ipath_create_cq(struct ib_
 			      struct ib_ucontext *context,
 			      struct ib_udata *udata)
 {
+	struct ipath_ibdev *dev = to_idev(ibdev);
 	struct ipath_cq *cq;
 	struct ib_wc *wc;
 	struct ib_cq *ret;
+
+	if (entries > ib_ipath_max_cqes) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
+	if (dev->n_cqs_allocated == ib_ipath_max_cqs) {
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
 
 	/*
 	 * Need to use vmalloc() if we want to support large #s of
@@ -197,6 +208,8 @@ struct ib_cq *ipath_create_cq(struct ib_
 
 	ret = &cq->ibcq;
 
+	dev->n_cqs_allocated++;
+
 bail:
 	return ret;
 }
@@ -211,9 +224,11 @@ bail:
  */
 int ipath_destroy_cq(struct ib_cq *ibcq)
 {
+	struct ipath_ibdev *dev = to_idev(ibcq->device);
 	struct ipath_cq *cq = to_icq(ibcq);
 
 	tasklet_kill(&cq->comptask);
+	dev->n_cqs_allocated--;
 	vfree(cq->queue);
 	kfree(cq);
 
diff -r 21d5d64750ac -r a94e9f9c9c23 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
@@ -661,8 +661,10 @@ struct ib_qp *ipath_create_qp(struct ib_
 	size_t sz;
 	struct ib_qp *ret;
 
-	if (init_attr->cap.max_send_sge > 255 ||
-	    init_attr->cap.max_recv_sge > 255) {
+	if (init_attr->cap.max_send_sge > ib_ipath_max_sges ||
+	    init_attr->cap.max_recv_sge > ib_ipath_max_sges ||
+	    init_attr->cap.max_send_wr > ib_ipath_max_qp_wrs ||
+	    init_attr->cap.max_recv_wr > ib_ipath_max_qp_wrs) {
 		ret = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
diff -r 21d5d64750ac -r a94e9f9c9c23 drivers/infiniband/hw/ipath/ipath_srq.c
--- a/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Jun 29 14:33:25 2006 -0700
@@ -126,11 +126,23 @@ struct ib_srq *ipath_create_srq(struct i
 				struct ib_srq_init_attr *srq_init_attr,
 				struct ib_udata *udata)
 {
+	struct ipath_ibdev *dev = to_idev(ibpd->device);
 	struct ipath_srq *srq;
 	u32 sz;
 	struct ib_srq *ret;
 
-	if (srq_init_attr->attr.max_sge < 1) {
+	if (dev->n_srqs_allocated == ib_ipath_max_srqs) {
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
+
+	if (srq_init_attr->attr.max_wr == 0) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
+	if ((srq_init_attr->attr.max_sge > ib_ipath_max_srq_sges) ||
+	    (srq_init_attr->attr.max_wr > ib_ipath_max_srq_wrs)) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
 	}
@@ -165,6 +177,8 @@ struct ib_srq *ipath_create_srq(struct i
 
 	ret = &srq->ibsrq;
 
+	dev->n_srqs_allocated++;
+
 bail:
 	return ret;
 }
@@ -182,24 +196,26 @@ int ipath_modify_srq(struct ib_srq *ibsr
 	unsigned long flags;
 	int ret;
 
-	if (attr_mask & IB_SRQ_LIMIT) {
-		spin_lock_irqsave(&srq->rq.lock, flags);
-		srq->limit = attr->srq_limit;
-		spin_unlock_irqrestore(&srq->rq.lock, flags);
-	}
+	if (attr_mask & IB_SRQ_MAX_WR)
+		if ((attr->max_wr > ib_ipath_max_srq_wrs) ||
+		    (attr->max_sge > srq->rq.max_sge)) {
+			ret = -EINVAL;
+			goto bail;
+		}
+
+	if (attr_mask & IB_SRQ_LIMIT)
+		if (attr->srq_limit >= srq->rq.size) {
+			ret = -EINVAL;
+			goto bail;
+		}
+
 	if (attr_mask & IB_SRQ_MAX_WR) {
-		u32 size = attr->max_wr + 1;
 		struct ipath_rwqe *wq, *p;
-		u32 n;
-		u32 sz;
-
-		if (attr->max_sge < srq->rq.max_sge) {
-			ret = -EINVAL;
-			goto bail;
-		}
+		u32 sz, size, n;
 
 		sz = sizeof(struct ipath_rwqe) +
 			attr->max_sge * sizeof(struct ipath_sge);
+		size = attr->max_wr + 1;
 		wq = vmalloc(size * sz);
 		if (!wq) {
 			ret = -ENOMEM;
@@ -243,6 +259,11 @@ int ipath_modify_srq(struct ib_srq *ibsr
 		spin_unlock_irqrestore(&srq->rq.lock, flags);
 	}
 
+	if (attr_mask & IB_SRQ_LIMIT) {
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		srq->limit = attr->srq_limit;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
 	ret = 0;
 
 bail:
@@ -266,7 +287,9 @@ int ipath_destroy_srq(struct ib_srq *ibs
 int ipath_destroy_srq(struct ib_srq *ibsrq)
 {
 	struct ipath_srq *srq = to_isrq(ibsrq);
-
+	struct ipath_ibdev *dev = to_idev(ibsrq->device);
+
+	dev->n_srqs_allocated--;
 	vfree(srq->rq.wq);
 	kfree(srq);
 
diff -r 21d5d64750ac -r a94e9f9c9c23 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
@@ -55,6 +55,59 @@ unsigned int ib_ipath_debug;	/* debug ma
 unsigned int ib_ipath_debug;	/* debug mask */
 module_param_named(debug, ib_ipath_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(debug, "Verbs debug mask");
+
+static unsigned int ib_ipath_max_pds = 0xFFFF;
+module_param_named(max_pds, ib_ipath_max_pds, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_pds,
+		 "Maximum number of protection domains to support");
+
+static unsigned int ib_ipath_max_ahs = 0xFFFF;
+module_param_named(max_ahs, ib_ipath_max_ahs, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_ahs, "Maximum number of address handles to support");
+
+unsigned int ib_ipath_max_cqes = 0x2FFFF;
+module_param_named(max_cqes, ib_ipath_max_cqes, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_cqes,
+		 "Maximum number of completion queue entries to support");
+
+unsigned int ib_ipath_max_cqs = 0x1FFFF;
+module_param_named(max_cqs, ib_ipath_max_cqs, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_cqs, "Maximum number of completion queues to support");
+
+unsigned int ib_ipath_max_qp_wrs = 0x3FFF;
+module_param_named(max_qp_wrs, ib_ipath_max_qp_wrs, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
+
+unsigned int ib_ipath_max_sges = 0x60;
+module_param_named(max_sges, ib_ipath_max_sges, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
+
+unsigned int ib_ipath_max_mcast_grps = 16384;
+module_param_named(max_mcast_grps, ib_ipath_max_mcast_grps, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_mcast_grps,
+		 "Maximum number of multicast groups to support");
+
+unsigned int ib_ipath_max_mcast_qp_attached = 16;
+module_param_named(max_mcast_qp_attached, ib_ipath_max_mcast_qp_attached,
+		   uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_mcast_qp_attached,
+		 "Maximum number of attached QPs to support");
+
+unsigned int ib_ipath_max_srqs = 1024;
+module_param_named(max_srqs, ib_ipath_max_srqs, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_srqs, "Maximum number of SRQs to support");
+
+unsigned int ib_ipath_max_srq_sges = 128;
+module_param_named(max_srq_sges, ib_ipath_max_srq_sges,
+		   uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_srq_sges, "Maximum number of SRQ SGEs to support");
+
+unsigned int ib_ipath_max_srq_wrs = 0x1FFFF;
+module_param_named(max_srq_wrs, ib_ipath_max_srq_wrs,
+		   uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_srq_wrs, "Maximum number of SRQ WRs support");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("QLogic <support@pathscale.com>");
@@ -581,24 +634,25 @@ static int ipath_query_device(struct ib_
 	props->sys_image_guid = dev->sys_image_guid;
 
 	props->max_mr_size = ~0ull;
-	props->max_qp = 0xffff;
-	props->max_qp_wr = 0xffff;
-	props->max_sge = 255;
-	props->max_cq = 0xffff;
-	props->max_cqe = 0xffff;
-	props->max_mr = 0xffff;
-	props->max_pd = 0xffff;
+	props->max_qp = dev->qp_table.max;
+	props->max_qp_wr = ib_ipath_max_qp_wrs;
+	props->max_sge = ib_ipath_max_sges;
+	props->max_cq = ib_ipath_max_cqs;
+	props->max_ah = ib_ipath_max_ahs;
+	props->max_cqe = ib_ipath_max_cqes;
+	props->max_mr = dev->lk_table.max;
+	props->max_pd = ib_ipath_max_pds;
 	props->max_qp_rd_atom = 1;
 	props->max_qp_init_rd_atom = 1;
 	/* props->max_res_rd_atom */
-	props->max_srq = 0xffff;
-	props->max_srq_wr = 0xffff;
-	props->max_srq_sge = 255;
+	props->max_srq = ib_ipath_max_srqs;
+	props->max_srq_wr = ib_ipath_max_srq_wrs;
+	props->max_srq_sge = ib_ipath_max_srq_sges;
 	/* props->local_ca_ack_delay */
 	props->atomic_cap = IB_ATOMIC_HCA;
 	props->max_pkeys = ipath_layer_get_npkeys(dev->dd);
-	props->max_mcast_grp = 0xffff;
-	props->max_mcast_qp_attach = 0xffff;
+	props->max_mcast_grp = ib_ipath_max_mcast_grps;
+	props->max_mcast_qp_attach = ib_ipath_max_mcast_qp_attached;
 	props->max_total_mcast_qp_attach = props->max_mcast_qp_attach *
 		props->max_mcast_grp;
 
@@ -741,8 +795,21 @@ static struct ib_pd *ipath_alloc_pd(stru
 				    struct ib_ucontext *context,
 				    struct ib_udata *udata)
 {
+	struct ipath_ibdev *dev = to_idev(ibdev);
 	struct ipath_pd *pd;
 	struct ib_pd *ret;
+
+	/*
+	 * This is actually totally arbitrary.	Some correctness tests
+	 * assume there's a maximum number of PDs that can be allocated.
+	 * We don't actually have this limit, but we fail the test if
+	 * we allow allocations of more than we report for this value.
+	 */
+
+	if (dev->n_pds_allocated == ib_ipath_max_pds) {
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
 
 	pd = kmalloc(sizeof *pd, GFP_KERNEL);
 	if (!pd) {
@@ -750,6 +817,8 @@ static struct ib_pd *ipath_alloc_pd(stru
 		goto bail;
 	}
 
+	dev->n_pds_allocated++;
+
 	/* ib_alloc_pd() will initialize pd->ibpd. */
 	pd->user = udata != NULL;
 
@@ -762,6 +831,9 @@ static int ipath_dealloc_pd(struct ib_pd
 static int ipath_dealloc_pd(struct ib_pd *ibpd)
 {
 	struct ipath_pd *pd = to_ipd(ibpd);
+	struct ipath_ibdev *dev = to_idev(ibpd->device);
+
+	dev->n_pds_allocated--;
 
 	kfree(pd);
 
@@ -780,6 +852,12 @@ static struct ib_ah *ipath_create_ah(str
 {
 	struct ipath_ah *ah;
 	struct ib_ah *ret;
+	struct ipath_ibdev *dev = to_idev(pd->device);
+
+	if (dev->n_ahs_allocated == ib_ipath_max_ahs) {
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
 
 	/* A multicast address requires a GRH (see ch. 8.4.1). */
 	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
@@ -794,7 +872,7 @@ static struct ib_ah *ipath_create_ah(str
 		goto bail;
 	}
 
-	if (ah_attr->port_num != 1 ||
+	if (ah_attr->port_num < 1 ||
 	    ah_attr->port_num > pd->device->phys_port_cnt) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
@@ -806,6 +884,8 @@ static struct ib_ah *ipath_create_ah(str
 		goto bail;
 	}
 
+	dev->n_ahs_allocated++;
+
 	/* ib_create_ah() will initialize ah->ibah. */
 	ah->attr = *ah_attr;
 
@@ -823,7 +903,10 @@ bail:
  */
 static int ipath_destroy_ah(struct ib_ah *ibah)
 {
+	struct ipath_ibdev *dev = to_idev(ibah->device);
 	struct ipath_ah *ah = to_iah(ibah);
+
+	dev->n_ahs_allocated--;
 
 	kfree(ah);
 
diff -r 21d5d64750ac -r a94e9f9c9c23 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
@@ -149,6 +149,7 @@ struct ipath_mcast {
 	struct list_head qp_list;
 	wait_queue_head_t wait;
 	atomic_t refcount;
+	int n_attached;
 };
 
 /* Memory region */
@@ -432,6 +433,11 @@ struct ipath_ibdev {
 	__be64 sys_image_guid;	/* in network order */
 	__be64 gid_prefix;	/* in network order */
 	__be64 mkey;
+	u32 n_pds_allocated;	/* number of PDs allocated for device */
+	u32 n_ahs_allocated;	/* number of AHs allocated for device */
+	u32 n_cqs_allocated;	/* number of CQs allocated for device */
+	u32 n_srqs_allocated;	/* number of SRQs allocated for device */
+	u32 n_mcast_grps_allocated; /* number of mcast groups allocated */
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
 	u64 ipath_spkts;	/* total packets sent (sample result) */
@@ -697,6 +703,24 @@ extern const int ib_ipath_state_ops[];
 
 extern unsigned int ib_ipath_lkey_table_size;
 
+extern unsigned int ib_ipath_max_cqes;
+
+extern unsigned int ib_ipath_max_cqs;
+
+extern unsigned int ib_ipath_max_qp_wrs;
+
+extern unsigned int ib_ipath_max_sges;
+
+extern unsigned int ib_ipath_max_mcast_grps;
+
+extern unsigned int ib_ipath_max_mcast_qp_attached;
+
+extern unsigned int ib_ipath_max_srqs;
+
+extern unsigned int ib_ipath_max_srq_sges;
+
+extern unsigned int ib_ipath_max_srq_wrs;
+
 extern const u32 ib_ipath_rnr_table[];
 
 #endif				/* IPATH_VERBS_H */
diff -r 21d5d64750ac -r a94e9f9c9c23 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Jun 29 14:33:25 2006 -0700
@@ -93,6 +93,7 @@ static struct ipath_mcast *ipath_mcast_a
 	INIT_LIST_HEAD(&mcast->qp_list);
 	init_waitqueue_head(&mcast->wait);
 	atomic_set(&mcast->refcount, 0);
+	mcast->n_attached = 0;
 
 bail:
 	return mcast;
@@ -158,7 +159,8 @@ bail:
  * the table but the QP was added.  Return ESRCH if the QP was already
  * attached and neither structure was added.
  */
-static int ipath_mcast_add(struct ipath_mcast *mcast,
+static int ipath_mcast_add(struct ipath_ibdev *dev,
+			   struct ipath_mcast *mcast,
 			   struct ipath_mcast_qp *mqp)
 {
 	struct rb_node **n = &mcast_tree.rb_node;
@@ -189,16 +191,28 @@ static int ipath_mcast_add(struct ipath_
 		/* Search the QP list to see if this is already there. */
 		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
 			if (p->qp == mqp->qp) {
-				spin_unlock_irqrestore(&mcast_lock, flags);
 				ret = ESRCH;
 				goto bail;
 			}
 		}
+		if (tmcast->n_attached == ib_ipath_max_mcast_qp_attached) {
+			ret = ENOMEM;
+			goto bail;
+		}
+
+		tmcast->n_attached++;
+
 		list_add_tail_rcu(&mqp->list, &tmcast->qp_list);
-		spin_unlock_irqrestore(&mcast_lock, flags);
 		ret = EEXIST;
 		goto bail;
 	}
+
+	if (dev->n_mcast_grps_allocated == ib_ipath_max_mcast_grps) {
+		ret = ENOMEM;
+		goto bail;
+	}
+
+	dev->n_mcast_grps_allocated++;
 
 	list_add_tail_rcu(&mqp->list, &mcast->qp_list);
 
@@ -206,17 +220,18 @@ static int ipath_mcast_add(struct ipath_
 	rb_link_node(&mcast->rb_node, pn, n);
 	rb_insert_color(&mcast->rb_node, &mcast_tree);
 
+	ret = 0;
+
+bail:
 	spin_unlock_irqrestore(&mcast_lock, flags);
 
-	ret = 0;
-
-bail:
 	return ret;
 }
 
 int ipath_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 {
 	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
 	struct ipath_mcast *mcast;
 	struct ipath_mcast_qp *mqp;
 	int ret;
@@ -236,7 +251,7 @@ int ipath_multicast_attach(struct ib_qp 
 		ret = -ENOMEM;
 		goto bail;
 	}
-	switch (ipath_mcast_add(mcast, mqp)) {
+	switch (ipath_mcast_add(dev, mcast, mqp)) {
 	case ESRCH:
 		/* Neither was used: can't attach the same QP twice. */
 		ipath_mcast_qp_free(mqp);
@@ -246,6 +261,12 @@ int ipath_multicast_attach(struct ib_qp 
 	case EEXIST:		/* The mcast wasn't used */
 		ipath_mcast_free(mcast);
 		break;
+	case ENOMEM:
+		/* Exceeded the maximum number of mcast groups. */
+		ipath_mcast_qp_free(mqp);
+		ipath_mcast_free(mcast);
+		ret = -ENOMEM;
+		goto bail;
 	default:
 		break;
 	}
@@ -259,6 +280,7 @@ int ipath_multicast_detach(struct ib_qp 
 int ipath_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 {
 	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
 	struct ipath_mcast *mcast = NULL;
 	struct ipath_mcast_qp *p, *tmp;
 	struct rb_node *n;
@@ -297,6 +319,7 @@ int ipath_multicast_detach(struct ib_qp 
 		 * link until we are sure there are no list walkers.
 		 */
 		list_del_rcu(&p->list);
+		mcast->n_attached--;
 
 		/* If this was the last attached QP, remove the GID too. */
 		if (list_empty(&mcast->qp_list)) {
@@ -320,6 +343,7 @@ int ipath_multicast_detach(struct ib_qp 
 		atomic_dec(&mcast->refcount);
 		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
 		ipath_mcast_free(mcast);
+		dev->n_mcast_grps_allocated--;
 	}
 
 	ret = 0;
