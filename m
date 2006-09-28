Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWI1QIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWI1QIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWI1QII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:08:08 -0400
Received: from mx.pathscale.com ([64.160.42.68]:61621 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751753AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 28] IB/ipath - count SRQs properly
X-Mercurial-Node: cc3350eeb557466198c10c88372babc54c0f95a6
Message-Id: <cc3350eeb557466198c1.1159459204@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:04 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r fcd3e3bc98d8 -r cc3350eeb557 drivers/infiniband/hw/ipath/ipath_srq.c
--- a/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Sep 28 08:57:12 2006 -0700
@@ -103,11 +103,6 @@ struct ib_srq *ipath_create_srq(struct i
 	struct ipath_srq *srq;
 	u32 sz;
 	struct ib_srq *ret;
-
-	if (dev->n_srqs_allocated == ib_ipath_max_srqs) {
-		ret = ERR_PTR(-ENOMEM);
-		goto done;
-	}
 
 	if (srq_init_attr->attr.max_wr == 0) {
 		ret = ERR_PTR(-EINVAL);
@@ -180,10 +175,17 @@ struct ib_srq *ipath_create_srq(struct i
 	spin_lock_init(&srq->rq.lock);
 	srq->rq.wq->head = 0;
 	srq->rq.wq->tail = 0;
-	srq->rq.max_sge = srq_init_attr->attr.max_sge;
 	srq->limit = srq_init_attr->attr.srq_limit;
 
-	dev->n_srqs_allocated++;
+	spin_lock(&dev->n_srqs_lock);
+	if (dev->n_srqs_allocated == ib_ipath_max_srqs) {
+		spin_unlock(&dev->n_srqs_lock);
+		ret = ERR_PTR(-ENOMEM);
+		goto bail_wq;
+	}
+
+ 	dev->n_srqs_allocated++;
+	spin_unlock(&dev->n_srqs_lock);
 
 	ret = &srq->ibsrq;
 	goto done;
@@ -351,8 +353,13 @@ int ipath_destroy_srq(struct ib_srq *ibs
 	struct ipath_srq *srq = to_isrq(ibsrq);
 	struct ipath_ibdev *dev = to_idev(ibsrq->device);
 
+	spin_lock(&dev->n_srqs_lock);
 	dev->n_srqs_allocated--;
-	vfree(srq->rq.wq);
+	spin_unlock(&dev->n_srqs_lock);
+	if (srq->ip)
+		kref_put(&srq->ip->ref, ipath_release_mmap_info);
+	else
+		vfree(srq->rq.wq);
 	kfree(srq);
 
 	return 0;
