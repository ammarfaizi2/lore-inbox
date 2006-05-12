Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWELXpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWELXpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWELXoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:46 -0400
Received: from mx.pathscale.com ([64.160.42.68]:55465 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932209AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 53] ipath - make max mcast sizes configurable
X-Mercurial-Node: df954e47ff670c3a28d685ac3589da248f55c507
Message-Id: <df954e47ff670c3a28d6.1147477383@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:03 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the max IB mcast sizes configurable.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c5f3731224bb -r df954e47ff67 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -81,6 +81,32 @@ unsigned int ib_ipath_max_sges = 0xFF;
 unsigned int ib_ipath_max_sges = 0xFF;
 module_param_named(max_sges, ib_ipath_max_sges, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
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
 MODULE_AUTHOR("PathScale <support@pathscale.com>");
@@ -621,14 +647,14 @@ static int ipath_query_device(struct ib_
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
 
diff -r c5f3731224bb -r df954e47ff67 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
@@ -148,6 +148,7 @@ struct ipath_mcast {
 	struct list_head qp_list;
 	wait_queue_head_t wait;
 	atomic_t refcount;
+	int n_attached;
 };
 
 /* Memory region */
@@ -434,6 +435,7 @@ struct ipath_ibdev {
 	u32 n_pds_allocated;	/* number of PDs allocated for device */
 	u32 n_ahs_allocated;	/* number of AHs allocated for device */
 	u32 n_cqs_allocated;	/* number of CQs allocated for device */
+	u32 n_mcast_grps_allocated; /* number of mcast groups allocated */
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
 	u64 ipath_spkts;	/* total packets sent (sample result) */
@@ -699,6 +701,16 @@ extern unsigned int ib_ipath_max_qp_wrs;
 
 extern unsigned int ib_ipath_max_sges;
 
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
diff -r c5f3731224bb -r df954e47ff67 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri May 12 15:55:28 2006 -0700
@@ -92,6 +92,7 @@ static struct ipath_mcast *ipath_mcast_a
 	INIT_LIST_HEAD(&mcast->qp_list);
 	init_waitqueue_head(&mcast->wait);
 	atomic_set(&mcast->refcount, 0);
+	mcast->n_attached = 0;
 
 bail:
 	return mcast;
@@ -157,7 +158,8 @@ bail:
  * the table but the QP was added.  Return ESRCH if the QP was already
  * attached and neither structure was added.
  */
-static int ipath_mcast_add(struct ipath_mcast *mcast,
+static int ipath_mcast_add(struct ipath_ibdev *dev,
+			   struct ipath_mcast *mcast,
 			   struct ipath_mcast_qp *mqp)
 {
 	struct rb_node **n = &mcast_tree.rb_node;
@@ -188,16 +190,28 @@ static int ipath_mcast_add(struct ipath_
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
 
@@ -205,17 +219,18 @@ static int ipath_mcast_add(struct ipath_
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
@@ -235,7 +250,7 @@ int ipath_multicast_attach(struct ib_qp 
 		ret = -ENOMEM;
 		goto bail;
 	}
-	switch (ipath_mcast_add(mcast, mqp)) {
+	switch (ipath_mcast_add(dev, mcast, mqp)) {
 	case ESRCH:
 		/* Neither was used: can't attach the same QP twice. */
 		ipath_mcast_qp_free(mqp);
@@ -245,6 +260,12 @@ int ipath_multicast_attach(struct ib_qp 
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
@@ -258,6 +279,7 @@ int ipath_multicast_detach(struct ib_qp 
 int ipath_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 {
 	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
 	struct ipath_mcast *mcast = NULL;
 	struct ipath_mcast_qp *p, *tmp;
 	struct rb_node *n;
@@ -296,6 +318,7 @@ int ipath_multicast_detach(struct ib_qp 
 		 * link until we are sure there are no list walkers.
 		 */
 		list_del_rcu(&p->list);
+		mcast->n_attached--;
 
 		/* If this was the last attached QP, remove the GID too. */
 		if (list_empty(&mcast->qp_list)) {
@@ -319,6 +342,7 @@ int ipath_multicast_detach(struct ib_qp 
 		atomic_dec(&mcast->refcount);
 		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
 		ipath_mcast_free(mcast);
+		dev->n_mcast_grps_allocated--;
 	}
 
 	ret = 0;
