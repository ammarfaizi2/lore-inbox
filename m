Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWI1QLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWI1QLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWI1QKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:10:32 -0400
Received: from mx.pathscale.com ([64.160.42.68]:61109 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751727AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 28] IB/ipath - lock and count allocated CQs properly
X-Mercurial-Node: fcd3e3bc98d8132c8fe959e6a4ea89ce19733659
Message-Id: <fcd3e3bc98d8132c8fe9.1159459203@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:03 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 0fe847c54458 -r fcd3e3bc98d8 drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Sep 28 08:57:12 2006 -0700
@@ -174,11 +174,6 @@ struct ib_cq *ipath_create_cq(struct ib_
 
 	if (entries < 1 || entries > ib_ipath_max_cqes) {
 		ret = ERR_PTR(-EINVAL);
-		goto done;
-	}
-
-	if (dev->n_cqs_allocated == ib_ipath_max_cqs) {
-		ret = ERR_PTR(-ENOMEM);
 		goto done;
 	}
 
@@ -237,6 +232,16 @@ struct ib_cq *ipath_create_cq(struct ib_
 	} else
 		cq->ip = NULL;
 
+	spin_lock(&dev->n_cqs_lock);
+	if (dev->n_cqs_allocated == ib_ipath_max_cqs) {
+		spin_unlock(&dev->n_cqs_lock);
+		ret = ERR_PTR(-ENOMEM);
+		goto bail_wc;
+	}
+
+	dev->n_cqs_allocated++;
+	spin_unlock(&dev->n_cqs_lock);
+
 	/*
 	 * ib_create_cq() will initialize cq->ibcq except for cq->ibcq.cqe.
 	 * The number of entries should be >= the number requested or return
@@ -253,7 +258,6 @@ struct ib_cq *ipath_create_cq(struct ib_
 
 	ret = &cq->ibcq;
 
-	dev->n_cqs_allocated++;
 	goto done;
 
 bail_wc:
@@ -280,7 +284,9 @@ int ipath_destroy_cq(struct ib_cq *ibcq)
 	struct ipath_cq *cq = to_icq(ibcq);
 
 	tasklet_kill(&cq->comptask);
+	spin_lock(&dev->n_cqs_lock);
 	dev->n_cqs_allocated--;
+	spin_unlock(&dev->n_cqs_lock);
 	if (cq->ip)
 		kref_put(&cq->ip->ref, ipath_release_mmap_info);
 	else
