Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWELXof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWELXof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWELXoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34985 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932181AbWELXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:32 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 53] ipath - cap number of PDs that can be allocated
X-Mercurial-Node: 300f0aa6f034eec6a8063f32cf7a867af0b683df
Message-Id: <300f0aa6f034eec6a806.1147477369@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:49 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put an arbitrary cap on the maximum number of PDs that can be allocated
for a device.  This is arbitrary because the number we support
is constrained only by system memory and what kmalloc can give us.
Nevertheless, if we don't have a limit, some third-party  OpenIB stress
tests fail.  The limit can be changed on the fly using a module parameter.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 5d5e1e641b16 -r 300f0aa6f034 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -54,6 +54,11 @@ unsigned int ib_ipath_debug;	/* debug ma
 unsigned int ib_ipath_debug;	/* debug mask */
 module_param_named(debug, ib_ipath_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(debug, "Verbs debug mask");
+
+static unsigned int ib_ipath_max_pds = 0xFFFF;
+module_param_named(max_pds, ib_ipath_max_pds, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_pds,
+		 "Maximum number of protection domains to support");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("PathScale <support@pathscale.com>");
@@ -589,7 +594,7 @@ static int ipath_query_device(struct ib_
 	props->max_cq = 0xffff;
 	props->max_cqe = 0xffff;
 	props->max_mr = dev->lk_table.max;
-	props->max_pd = 0xffff;
+	props->max_pd = ib_ipath_max_pds;
 	props->max_qp_rd_atom = 1;
 	props->max_qp_init_rd_atom = 1;
 	/* props->max_res_rd_atom */
@@ -743,8 +748,23 @@ static struct ib_pd *ipath_alloc_pd(stru
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
+
+	dev->n_pds_allocated++;
 
 	pd = kmalloc(sizeof *pd, GFP_KERNEL);
 	if (!pd) {
@@ -764,6 +784,9 @@ static int ipath_dealloc_pd(struct ib_pd
 static int ipath_dealloc_pd(struct ib_pd *ibpd)
 {
 	struct ipath_pd *pd = to_ipd(ibpd);
+	struct ipath_ibdev *dev = to_idev(ibpd->device);
+
+	dev->n_pds_allocated--;
 
 	kfree(pd);
 
diff -r 5d5e1e641b16 -r 300f0aa6f034 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
@@ -431,6 +431,7 @@ struct ipath_ibdev {
 	__be64 sys_image_guid;	/* in network order */
 	__be64 gid_prefix;	/* in network order */
 	__be64 mkey;
+	u32 n_pds_allocated;	/* number of PDs allocated for device */
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
 	u64 ipath_spkts;	/* total packets sent (sample result) */
