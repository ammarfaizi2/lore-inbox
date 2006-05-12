Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWEMAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWEMAEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEMAEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:04:33 -0400
Received: from mx.pathscale.com ([64.160.42.68]:51369 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932191AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 53] ipath - cap maximum number of AHs
X-Mercurial-Node: e823378bd19cc552e9a9bb2a2d9568007b131329
Message-Id: <e823378bd19cc552e9a9.1147477372@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:52 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cap the maximum number of address handles.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r def81ab50644 -r e823378bd19c drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -59,6 +59,11 @@ module_param_named(max_pds, ib_ipath_max
 module_param_named(max_pds, ib_ipath_max_pds, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_pds,
 		 "Maximum number of protection domains to support");
+
+static unsigned int ib_ipath_max_ahs = 0xFFFF;
+module_param_named(max_ahs, ib_ipath_max_ahs, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_ahs,
+		 "Maximum number of address handles to support");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("PathScale <support@pathscale.com>");
@@ -592,6 +597,7 @@ static int ipath_query_device(struct ib_
 	props->max_qp_wr = 0xffff;
 	props->max_sge = 255;
 	props->max_cq = 0xffff;
+	props->max_ah = ib_ipath_max_ahs;
 	props->max_cqe = 0xffff;
 	props->max_mr = dev->lk_table.max;
 	props->max_pd = ib_ipath_max_pds;
@@ -764,13 +770,13 @@ static struct ib_pd *ipath_alloc_pd(stru
 		goto bail;
 	}
 
-	dev->n_pds_allocated++;
-
 	pd = kmalloc(sizeof *pd, GFP_KERNEL);
 	if (!pd) {
 		ret = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
+
+	dev->n_pds_allocated++;
 
 	/* ib_alloc_pd() will initialize pd->ibpd. */
 	pd->user = udata != NULL;
@@ -805,6 +811,12 @@ static struct ib_ah *ipath_create_ah(str
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
@@ -848,7 +860,10 @@ bail:
  */
 static int ipath_destroy_ah(struct ib_ah *ibah)
 {
+	struct ipath_ibdev *dev = to_idev(ibah->device);
 	struct ipath_ah *ah = to_iah(ibah);
+
+	dev->n_ahs_allocated--;
 
 	kfree(ah);
 
diff -r def81ab50644 -r e823378bd19c drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:27 2006 -0700
@@ -432,6 +432,7 @@ struct ipath_ibdev {
 	__be64 gid_prefix;	/* in network order */
 	__be64 mkey;
 	u32 n_pds_allocated;	/* number of PDs allocated for device */
+	u32 n_ahs_allocated;	/* number of AHs allocated for device */
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
 	u64 ipath_spkts;	/* total packets sent (sample result) */
