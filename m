Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422772AbWHYS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbWHYS1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWHYSZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:35 -0400
Received: from mx.pathscale.com ([64.160.42.68]:44930 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422772AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 23] IB/ipath - put a limit on the number of QPs that can
	be created
X-Mercurial-Node: 02d9f3ef2291dea0f4d818952d7f8b219d6e12d6
Message-Id: <02d9f3ef2291dea0f4d8.1156530283@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:43 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -833,9 +833,21 @@ struct ib_qp *ipath_create_qp(struct ib_
 		}
 	}
 
+	spin_lock(&dev->n_qps_lock);
+	if (dev->n_qps_allocated == ib_ipath_max_qps) {
+		spin_unlock(&dev->n_qps_lock);
+		ret = ERR_PTR(-ENOMEM);
+		goto bail_ip;
+	}
+
+	dev->n_qps_allocated++;
+	spin_unlock(&dev->n_qps_lock);
+
 	ret = &qp->ibqp;
 	goto bail;
 
+bail_ip:
+	kfree(qp->ip);
 bail_rwq:
 	vfree(qp->r_rq.wq);
 bail_qp:
@@ -864,6 +876,9 @@ int ipath_destroy_qp(struct ib_qp *ibqp)
 	spin_lock_irqsave(&qp->s_lock, flags);
 	qp->state = IB_QPS_ERR;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
+	spin_lock(&dev->n_qps_lock);
+	dev->n_qps_allocated--;
+	spin_unlock(&dev->n_qps_lock);
 
 	/* Stop the sending tasklet. */
 	tasklet_kill(&qp->s_task);
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -72,6 +72,10 @@ module_param_named(max_qp_wrs, ib_ipath_
 module_param_named(max_qp_wrs, ib_ipath_max_qp_wrs, uint,
 		   S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
+
+unsigned int ib_ipath_max_qps = 16384;
+module_param_named(max_qps, ib_ipath_max_qps, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_qps, "Maximum number of QPs to support");
 
 unsigned int ib_ipath_max_sges = 0x60;
 module_param_named(max_sges, ib_ipath_max_sges, uint, S_IWUSR | S_IRUGO);
@@ -958,7 +962,7 @@ static int ipath_query_device(struct ib_
 	props->sys_image_guid = dev->sys_image_guid;
 
 	props->max_mr_size = ~0ull;
-	props->max_qp = dev->qp_table.max;
+	props->max_qp = ib_ipath_max_qps;
 	props->max_qp_wr = ib_ipath_max_qp_wrs;
 	props->max_sge = ib_ipath_max_sges;
 	props->max_cq = ib_ipath_max_cqs;
@@ -1420,6 +1424,7 @@ int ipath_register_ib_device(struct ipat
 	spin_lock_init(&idev->n_pds_lock);
 	spin_lock_init(&idev->n_ahs_lock);
 	spin_lock_init(&idev->n_cqs_lock);
+	spin_lock_init(&idev->n_qps_lock);
 	spin_lock_init(&idev->n_srqs_lock);
 	spin_lock_init(&idev->n_mcast_grps_lock);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
@@ -482,6 +482,8 @@ struct ipath_ibdev {
 	spinlock_t n_ahs_lock;
 	u32 n_cqs_allocated;	/* number of CQs allocated for device */
 	spinlock_t n_cqs_lock;
+	u32 n_qps_allocated;	/* number of QPs allocated for device */
+	spinlock_t n_qps_lock;
 	u32 n_srqs_allocated;	/* number of SRQs allocated for device */
 	spinlock_t n_srqs_lock;
 	u32 n_mcast_grps_allocated; /* number of mcast groups allocated */
@@ -792,6 +794,8 @@ extern unsigned int ib_ipath_max_cqs;
 
 extern unsigned int ib_ipath_max_qp_wrs;
 
+extern unsigned int ib_ipath_max_qps;
+
 extern unsigned int ib_ipath_max_sges;
 
 extern unsigned int ib_ipath_max_mcast_grps;
