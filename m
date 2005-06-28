Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVF1Xcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVF1Xcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVF1XbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:31:06 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:63318 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S262231AbVF1XDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:55 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 10/16] IB uverbs: add mthca user context support
In-Reply-To: <2005628163.UOpVQTxEtDs4UiFi@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.o84QGfsM7oMSy0oU@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for managing userspace contexts to mthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   58 +++++++++++++++++++++++++++
 drivers/infiniband/hw/mthca/mthca_provider.h |   14 ++++++
 2 files changed, 72 insertions(+)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:00.882715841 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:16.611313860 -0700
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
+ * Copyright (c) 2005 Cisco Systems. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -37,6 +38,8 @@
 
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
+#include "mthca_user.h"
+#include "mthca_memfree.h"
 
 static int mthca_query_device(struct ib_device *ibdev,
 			      struct ib_device_attr *props)
@@ -284,6 +287,59 @@ static int mthca_query_gid(struct ib_dev
 	return err;
 }
 
+static struct ib_ucontext *mthca_alloc_ucontext(struct ib_device *ibdev,
+						struct ib_udata *udata)
+{
+	struct mthca_alloc_ucontext_resp uresp;
+	struct mthca_ucontext           *context;
+	int                              err;
+
+	memset(&uresp, 0, sizeof uresp);
+
+	uresp.qp_tab_size = to_mdev(ibdev)->limits.num_qps;
+	if (mthca_is_memfree(to_mdev(ibdev)))
+		uresp.uarc_size = to_mdev(ibdev)->uar_table.uarc_size;
+	else
+		uresp.uarc_size = 0;
+
+	context = kmalloc(sizeof *context, GFP_KERNEL);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	err = mthca_uar_alloc(to_mdev(ibdev), &context->uar);
+	if (err) {
+		kfree(context);
+		return ERR_PTR(err);
+	}
+
+	context->db_tab = mthca_init_user_db_tab(to_mdev(ibdev));
+	if (IS_ERR(context->db_tab)) {
+		err = PTR_ERR(context->db_tab);
+		mthca_uar_free(to_mdev(ibdev), &context->uar);
+		kfree(context);
+		return ERR_PTR(err);
+	}
+
+	if (ib_copy_to_udata(udata, &uresp, sizeof uresp)) {
+		mthca_cleanup_user_db_tab(to_mdev(ibdev), &context->uar, context->db_tab);
+		mthca_uar_free(to_mdev(ibdev), &context->uar);
+		kfree(context);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return &context->ibucontext;
+}
+
+static int mthca_dealloc_ucontext(struct ib_ucontext *context)
+{
+	mthca_cleanup_user_db_tab(to_mdev(context->device), &to_mucontext(context)->uar,
+				  to_mucontext(context)->db_tab);
+	mthca_uar_free(to_mdev(context->device), &to_mucontext(context)->uar);
+	kfree(to_mucontext(context));
+
+	return 0;
+}
+
 static struct ib_pd *mthca_alloc_pd(struct ib_device *ibdev,
 				    struct ib_ucontext *context,
 				    struct ib_udata *udata)
@@ -708,6 +764,8 @@ int mthca_register_device(struct mthca_d
 	dev->ib_dev.modify_port          = mthca_modify_port;
 	dev->ib_dev.query_pkey           = mthca_query_pkey;
 	dev->ib_dev.query_gid            = mthca_query_gid;
+	dev->ib_dev.alloc_ucontext       = mthca_alloc_ucontext;
+	dev->ib_dev.dealloc_ucontext     = mthca_dealloc_ucontext;
 	dev->ib_dev.alloc_pd             = mthca_alloc_pd;
 	dev->ib_dev.dealloc_pd           = mthca_dealloc_pd;
 	dev->ib_dev.create_ah            = mthca_ah_create;
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-28 15:19:22.365034436 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-28 15:20:16.612313643 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -54,6 +55,14 @@ struct mthca_uar {
 	int           index;
 };
 
+struct mthca_user_db_table;
+
+struct mthca_ucontext {
+	struct ib_ucontext          ibucontext;
+	struct mthca_uar            uar;
+	struct mthca_user_db_table *db_tab;
+};
+
 struct mthca_mtt;
 
 struct mthca_mr {
@@ -236,6 +245,11 @@ struct mthca_sqp {
 	dma_addr_t      header_dma;
 };
 
+static inline struct mthca_ucontext *to_mucontext(struct ib_ucontext *ibucontext)
+{
+	return container_of(ibucontext, struct mthca_ucontext, ibucontext);
+}
+
 static inline struct mthca_fmr *to_mfmr(struct ib_fmr *ibmr)
 {
 	return container_of(ibmr, struct mthca_fmr, ibmr);
