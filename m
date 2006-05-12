Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWELXpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWELXpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWELXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:39 -0400
Received: from mx.pathscale.com ([64.160.42.68]:51625 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932194AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 53] ipath - cap number of CQEs
X-Mercurial-Node: 1d3e85454b5370a7f386ffd5a868c4b1aaac7afa
Message-Id: <1d3e85454b5370a7f386.1147477373@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:53 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cap the number of CQEs.  Not a real limitation for us, but expected by
the verbs code.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e823378bd19c -r 1d3e85454b53 drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Fri May 12 15:55:27 2006 -0700
@@ -161,6 +161,11 @@ struct ib_cq *ipath_create_cq(struct ib_
 	struct ib_wc *wc;
 	struct ib_cq *ret;
 
+	if (entries > ib_ipath_max_cqe) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
 	/*
 	 * Need to use vmalloc() if we want to support large #s of
 	 * entries.
diff -r e823378bd19c -r 1d3e85454b53 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -64,6 +64,11 @@ module_param_named(max_ahs, ib_ipath_max
 module_param_named(max_ahs, ib_ipath_max_ahs, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_ahs,
 		 "Maximum number of address handles to support");
+
+unsigned int ib_ipath_max_cqe = 0xFFFF;
+module_param_named(max_cqe, ib_ipath_max_cqe, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_cqe,
+		 "Maximum number of completion queue entries to support");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("PathScale <support@pathscale.com>");
@@ -598,7 +603,7 @@ static int ipath_query_device(struct ib_
 	props->max_sge = 255;
 	props->max_cq = 0xffff;
 	props->max_ah = ib_ipath_max_ahs;
-	props->max_cqe = 0xffff;
+	props->max_cqe = ib_ipath_max_cqe;
 	props->max_mr = dev->lk_table.max;
 	props->max_pd = ib_ipath_max_pds;
 	props->max_qp_rd_atom = 1;
diff -r e823378bd19c -r 1d3e85454b53 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
@@ -690,6 +690,8 @@ extern const int ib_ipath_state_ops[];
 
 extern unsigned int ib_ipath_lkey_table_size;
 
+extern unsigned int ib_ipath_max_cqe;
+
 extern const u32 ib_ipath_rnr_table[];
 
 #endif				/* IPATH_VERBS_H */
