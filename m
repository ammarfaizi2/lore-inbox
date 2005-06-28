Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVF1Xni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVF1Xni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVF1Xmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:42:33 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:11926 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S262221AbVF1XDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:51 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 12/16] IB uverbs: add mthca user PD support
In-Reply-To: <2005628163.gtJFW6uLUrGQteys@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.px5sYyzsYWf21dJY@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for userspace protection domains (PDs) to mthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_dev.h      |    3 ++-
 drivers/infiniband/hw/mthca/mthca_main.c     |    2 +-
 drivers/infiniband/hw/mthca/mthca_pd.c       |   24 +++++++++++++++---------
 drivers/infiniband/hw/mthca/mthca_provider.c |   10 +++++++++-
 drivers/infiniband/hw/mthca/mthca_provider.h |    1 +
 5 files changed, 28 insertions(+), 12 deletions(-)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-28 15:19:20.685397179 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-28 15:20:20.514467380 -0700
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -378,7 +379,7 @@ void mthca_unregister_device(struct mthc
 int mthca_uar_alloc(struct mthca_dev *dev, struct mthca_uar *uar);
 void mthca_uar_free(struct mthca_dev *dev, struct mthca_uar *uar);
 
-int mthca_pd_alloc(struct mthca_dev *dev, struct mthca_pd *pd);
+int mthca_pd_alloc(struct mthca_dev *dev, int privileged, struct mthca_pd *pd);
 void mthca_pd_free(struct mthca_dev *dev, struct mthca_pd *pd);
 
 struct mthca_mtt *mthca_alloc_mtt(struct mthca_dev *dev, int size);
--- linux.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-28 15:19:20.685397179 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-28 15:20:20.515467163 -0700
@@ -665,7 +665,7 @@ static int __devinit mthca_setup_hca(str
 		goto err_pd_table_free;
 	}
 
-	err = mthca_pd_alloc(dev, &dev->driver_pd);
+	err = mthca_pd_alloc(dev, 1, &dev->driver_pd);
 	if (err) {
 		mthca_err(dev, "Failed to create driver PD, "
 			  "aborting.\n");
--- linux.orig/drivers/infiniband/hw/mthca/mthca_pd.c	2005-06-28 15:19:20.684397395 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_pd.c	2005-06-28 15:20:20.513467597 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -37,23 +38,27 @@
 
 #include "mthca_dev.h"
 
-int mthca_pd_alloc(struct mthca_dev *dev, struct mthca_pd *pd)
+int mthca_pd_alloc(struct mthca_dev *dev, int privileged, struct mthca_pd *pd)
 {
-	int err;
+	int err = 0;
 
 	might_sleep();
 
+	pd->privileged = privileged;
+
 	atomic_set(&pd->sqp_count, 0);
 	pd->pd_num = mthca_alloc(&dev->pd_table.alloc);
 	if (pd->pd_num == -1)
 		return -ENOMEM;
 
-	err = mthca_mr_alloc_notrans(dev, pd->pd_num,
-				     MTHCA_MPT_FLAG_LOCAL_READ |
-				     MTHCA_MPT_FLAG_LOCAL_WRITE,
-				     &pd->ntmr);
-	if (err)
-		mthca_free(&dev->pd_table.alloc, pd->pd_num);
+	if (privileged) {
+		err = mthca_mr_alloc_notrans(dev, pd->pd_num,
+					     MTHCA_MPT_FLAG_LOCAL_READ |
+					     MTHCA_MPT_FLAG_LOCAL_WRITE,
+					     &pd->ntmr);
+		if (err)
+			mthca_free(&dev->pd_table.alloc, pd->pd_num);
+	}
 
 	return err;
 }
@@ -61,7 +66,8 @@ int mthca_pd_alloc(struct mthca_dev *dev
 void mthca_pd_free(struct mthca_dev *dev, struct mthca_pd *pd)
 {
 	might_sleep();
-	mthca_free_mr(dev, &pd->ntmr);
+	if (pd->privileged)
+		mthca_free_mr(dev, &pd->ntmr);
 	mthca_free(&dev->pd_table.alloc, pd->pd_num);
 }
 
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:18.380930082 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:20.513467597 -0700
@@ -368,12 +368,20 @@ static struct ib_pd *mthca_alloc_pd(stru
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	err = mthca_pd_alloc(to_mdev(ibdev), pd);
+	err = mthca_pd_alloc(to_mdev(ibdev), !context, pd);
 	if (err) {
 		kfree(pd);
 		return ERR_PTR(err);
 	}
 
+	if (context) {
+		if (ib_copy_to_udata(udata, &pd->pd_num, sizeof (__u32))) {
+			mthca_pd_free(to_mdev(ibdev), pd);
+			kfree(pd);
+			return ERR_PTR(-EFAULT);
+		}
+	}
+
 	return &pd->ibpd;
 }
 
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-28 15:20:16.612313643 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-28 15:20:20.514467380 -0700
@@ -92,6 +92,7 @@ struct mthca_pd {
 	u32             pd_num;
 	atomic_t        sqp_count;
 	struct mthca_mr ntmr;
+	int             privileged;
 };
 
 struct mthca_eq {
