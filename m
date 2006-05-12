Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWELXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWELXpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWELXok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:40 -0400
Received: from mx.pathscale.com ([64.160.42.68]:53929 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932203AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 53] ipath - limit number of SGEs and WRs per QP
X-Mercurial-Node: 02a05b853d209c1de666fe7a69ec49af1c34ba24
Message-Id: <02a05b853d209c1de666.1147477378@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:58 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can't create more than a certain number of SGEs or WRs per QP.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ab2b013f1f95 -r 02a05b853d20 drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Fri May 12 15:55:28 2006 -0700
@@ -162,7 +162,7 @@ struct ib_cq *ipath_create_cq(struct ib_
 	struct ib_wc *wc;
 	struct ib_cq *ret;
 
-	if (entries > ib_ipath_max_cqe) {
+	if (entries > ib_ipath_max_cqes) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
 	}
diff -r ab2b013f1f95 -r 02a05b853d20 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:28 2006 -0700
@@ -663,8 +663,10 @@ struct ib_qp *ipath_create_qp(struct ib_
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
diff -r ab2b013f1f95 -r 02a05b853d20 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -62,18 +62,25 @@ MODULE_PARM_DESC(max_pds,
 
 static unsigned int ib_ipath_max_ahs = 0xFFFF;
 module_param_named(max_ahs, ib_ipath_max_ahs, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(max_ahs,
-		 "Maximum number of address handles to support");
-
-unsigned int ib_ipath_max_cqe = 0xFFFF;
-module_param_named(max_cqe, ib_ipath_max_cqe, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(max_cqe,
+MODULE_PARM_DESC(max_ahs, "Maximum number of address handles to support");
+
+unsigned int ib_ipath_max_cqes = 0xFFFF;
+module_param_named(max_cqes, ib_ipath_max_cqes, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_cqes,
 		 "Maximum number of completion queue entries to support");
 
 unsigned int ib_ipath_max_cqs = 0xFFFF;
 module_param_named(max_cqs, ib_ipath_max_cqs, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(max_cqs,
-		 "Maximum number of completion queues to support");
+MODULE_PARM_DESC(max_cqs, "Maximum number of completion queues to support");
+
+unsigned int ib_ipath_max_qp_wrs = 255;
+module_param_named(max_qp_wrs, ib_ipath_max_qp_wrs, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
+
+unsigned int ib_ipath_max_sges = 255;
+module_param_named(max_sges, ib_ipath_max_sges, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("PathScale <support@pathscale.com>");
@@ -604,11 +611,11 @@ static int ipath_query_device(struct ib_
 
 	props->max_mr_size = ~0ull;
 	props->max_qp = dev->qp_table.max;
-	props->max_qp_wr = 0xffff;
-	props->max_sge = 255;
+	props->max_qp_wr = ib_ipath_max_qp_wrs;
+	props->max_sge = ib_ipath_max_sges;
 	props->max_cq = ib_ipath_max_cqs;
 	props->max_ah = ib_ipath_max_ahs;
-	props->max_cqe = ib_ipath_max_cqe;
+	props->max_cqe = ib_ipath_max_cqes;
 	props->max_mr = dev->lk_table.max;
 	props->max_pd = ib_ipath_max_pds;
 	props->max_qp_rd_atom = 1;
diff -r ab2b013f1f95 -r 02a05b853d20 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
@@ -691,10 +691,14 @@ extern const int ib_ipath_state_ops[];
 
 extern unsigned int ib_ipath_lkey_table_size;
 
-extern unsigned int ib_ipath_max_cqe;
+extern unsigned int ib_ipath_max_cqes;
 
 extern unsigned int ib_ipath_max_cqs;
 
+extern unsigned int ib_ipath_max_qp_wrs;
+
+extern unsigned int ib_ipath_max_sges;
+
 extern const u32 ib_ipath_rnr_table[];
 
 #endif				/* IPATH_VERBS_H */
