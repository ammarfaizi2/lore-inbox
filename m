Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWELXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWELXpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWELXon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:43 -0400
Received: from mx.pathscale.com ([64.160.42.68]:52137 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932195AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 53] ipath - cap number of CQs
X-Mercurial-Node: a89145f4846ccd643c8e85ccbf10c3817a03e540
Message-Id: <a89145f4846ccd643c8e.1147477374@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:54 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cap the number of CQs that can be created.  Not a real limitation for us,
but the user verbs code expects a real number.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1d3e85454b53 -r a89145f4846c drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Fri May 12 15:55:27 2006 -0700
@@ -157,12 +157,18 @@ struct ib_cq *ipath_create_cq(struct ib_
 			      struct ib_ucontext *context,
 			      struct ib_udata *udata)
 {
+	struct ipath_ibdev *dev = to_idev(ibdev);
 	struct ipath_cq *cq;
 	struct ib_wc *wc;
 	struct ib_cq *ret;
 
 	if (entries > ib_ipath_max_cqe) {
 		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
+	if (dev->n_cqs_allocated == ib_ipath_max_cqs) {
+		ret = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
 
@@ -201,6 +207,8 @@ struct ib_cq *ipath_create_cq(struct ib_
 
 	ret = &cq->ibcq;
 
+	dev->n_cqs_allocated++;
+
 bail:
 	return ret;
 }
@@ -215,9 +223,11 @@ bail:
  */
 int ipath_destroy_cq(struct ib_cq *ibcq)
 {
+	struct ipath_ibdev *dev = to_idev(ibcq->device);
 	struct ipath_cq *cq = to_icq(ibcq);
 
 	tasklet_kill(&cq->comptask);
+	dev->n_cqs_allocated--;
 	vfree(cq->queue);
 	kfree(cq);
 
diff -r 1d3e85454b53 -r a89145f4846c drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -69,6 +69,11 @@ module_param_named(max_cqe, ib_ipath_max
 module_param_named(max_cqe, ib_ipath_max_cqe, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_cqe,
 		 "Maximum number of completion queue entries to support");
+
+unsigned int ib_ipath_max_cqs = 0xFFFF;
+module_param_named(max_cqs, ib_ipath_max_cqs, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_cqs,
+		 "Maximum number of completion queues to support");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("PathScale <support@pathscale.com>");
@@ -601,7 +606,7 @@ static int ipath_query_device(struct ib_
 	props->max_qp = dev->qp_table.max;
 	props->max_qp_wr = 0xffff;
 	props->max_sge = 255;
-	props->max_cq = 0xffff;
+	props->max_cq = ib_ipath_max_cqs;
 	props->max_ah = ib_ipath_max_ahs;
 	props->max_cqe = ib_ipath_max_cqe;
 	props->max_mr = dev->lk_table.max;
diff -r 1d3e85454b53 -r a89145f4846c drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
@@ -433,6 +433,7 @@ struct ipath_ibdev {
 	__be64 mkey;
 	u32 n_pds_allocated;	/* number of PDs allocated for device */
 	u32 n_ahs_allocated;	/* number of AHs allocated for device */
+	u32 n_cqs_allocated;	/* number of CQs allocated for device */
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
 	u64 ipath_spkts;	/* total packets sent (sample result) */
@@ -692,6 +693,8 @@ extern unsigned int ib_ipath_lkey_table_
 
 extern unsigned int ib_ipath_max_cqe;
 
+extern unsigned int ib_ipath_max_cqs;
+
 extern const u32 ib_ipath_rnr_table[];
 
 #endif				/* IPATH_VERBS_H */
