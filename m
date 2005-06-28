Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVF1Xhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVF1Xhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVF1Xgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:36:55 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:11926 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S262226AbVF1XDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:53 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 14/16] IB uverbs: add mthca user CQ support
In-Reply-To: <2005628163.XfYnZThlsTGb61Td@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:44 -0700
Message-Id: <2005628163.jWivrrVepuPgy40z@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for userspace completion queues (CQs) to mthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cq.c       |   78 +++++++++++++++------------
 drivers/infiniband/hw/mthca/mthca_dev.h      |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c |   69 +++++++++++++++++++++--
 drivers/infiniband/hw/mthca/mthca_provider.h |    1 
 4 files changed, 111 insertions(+), 38 deletions(-)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-28 15:19:19.183721488 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-28 15:20:25.680347052 -0700
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
+ * Copyright (c) 2005 Cisco Systems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -742,6 +743,7 @@ err_out:
 }
 
 int mthca_init_cq(struct mthca_dev *dev, int nent,
+		  struct mthca_ucontext *ctx, u32 pdn,
 		  struct mthca_cq *cq)
 {
 	int size = nent * MTHCA_CQ_ENTRY_SIZE;
@@ -753,30 +755,33 @@ int mthca_init_cq(struct mthca_dev *dev,
 
 	might_sleep();
 
-	cq->ibcq.cqe = nent - 1;
+	cq->ibcq.cqe  = nent - 1;
+	cq->is_kernel = !ctx;
 
 	cq->cqn = mthca_alloc(&dev->cq_table.alloc);
 	if (cq->cqn == -1)
 		return -ENOMEM;
 
 	if (mthca_is_memfree(dev)) {
-		cq->arm_sn = 1;
-
 		err = mthca_table_get(dev, dev->cq_table.table, cq->cqn);
 		if (err)
 			goto err_out;
 
-		err = -ENOMEM;
+		if (cq->is_kernel) {
+			cq->arm_sn = 1;
+
+			err = -ENOMEM;
 
-		cq->set_ci_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_SET_CI,
-						     cq->cqn, &cq->set_ci_db);
-		if (cq->set_ci_db_index < 0)
-			goto err_out_icm;
-
-		cq->arm_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_ARM,
-						  cq->cqn, &cq->arm_db);
-		if (cq->arm_db_index < 0)
-			goto err_out_ci;
+			cq->set_ci_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_SET_CI,
+							     cq->cqn, &cq->set_ci_db);
+			if (cq->set_ci_db_index < 0)
+				goto err_out_icm;
+
+			cq->arm_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_ARM,
+							  cq->cqn, &cq->arm_db);
+			if (cq->arm_db_index < 0)
+				goto err_out_ci;
+		}
 	}
 
 	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
@@ -785,12 +790,14 @@ int mthca_init_cq(struct mthca_dev *dev,
 
 	cq_context = mailbox->buf;
 
-	err = mthca_alloc_cq_buf(dev, size, cq);
-	if (err)
-		goto err_out_mailbox;
+	if (cq->is_kernel) {
+		err = mthca_alloc_cq_buf(dev, size, cq);
+		if (err)
+			goto err_out_mailbox;
 
-	for (i = 0; i < nent; ++i)
-		set_cqe_hw(get_cqe(cq, i));
+		for (i = 0; i < nent; ++i)
+			set_cqe_hw(get_cqe(cq, i));
+	}
 
 	spin_lock_init(&cq->lock);
 	atomic_set(&cq->refcount, 1);
@@ -801,11 +808,14 @@ int mthca_init_cq(struct mthca_dev *dev,
 						  MTHCA_CQ_STATE_DISARMED |
 						  MTHCA_CQ_FLAG_TR);
 	cq_context->start           = cpu_to_be64(0);
-	cq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24 |
-						  dev->driver_uar.index);
+	cq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24);
+	if (ctx)
+		cq_context->logsize_usrpage |= cpu_to_be32(ctx->uar.index);
+	else
+		cq_context->logsize_usrpage |= cpu_to_be32(dev->driver_uar.index);
 	cq_context->error_eqn       = cpu_to_be32(dev->eq_table.eq[MTHCA_EQ_ASYNC].eqn);
 	cq_context->comp_eqn        = cpu_to_be32(dev->eq_table.eq[MTHCA_EQ_COMP].eqn);
-	cq_context->pd              = cpu_to_be32(dev->driver_pd.pd_num);
+	cq_context->pd              = cpu_to_be32(pdn);
 	cq_context->lkey            = cpu_to_be32(cq->mr.ibmr.lkey);
 	cq_context->cqn             = cpu_to_be32(cq->cqn);
 
@@ -843,18 +853,20 @@ int mthca_init_cq(struct mthca_dev *dev,
 	return 0;
 
 err_out_free_mr:
-	mthca_free_mr(dev, &cq->mr);
-	mthca_free_cq_buf(dev, cq);
+	if (cq->is_kernel) {
+		mthca_free_mr(dev, &cq->mr);
+		mthca_free_cq_buf(dev, cq);
+	}
 
 err_out_mailbox:
 	mthca_free_mailbox(dev, mailbox);
 
 err_out_arm:
-	if (mthca_is_memfree(dev))
+	if (cq->is_kernel && mthca_is_memfree(dev))
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
 
 err_out_ci:
-	if (mthca_is_memfree(dev))
+	if (cq->is_kernel && mthca_is_memfree(dev))
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
 
 err_out_icm:
@@ -892,7 +904,8 @@ void mthca_free_cq(struct mthca_dev *dev
 		int j;
 
 		printk(KERN_ERR "context for CQN %x (cons index %x, next sw %d)\n",
-		       cq->cqn, cq->cons_index, !!next_cqe_sw(cq));
+		       cq->cqn, cq->cons_index,
+		       cq->is_kernel ? !!next_cqe_sw(cq) : 0);
 		for (j = 0; j < 16; ++j)
 			printk(KERN_ERR "[%2x] %08x\n", j * 4, be32_to_cpu(ctx[j]));
 	}
@@ -910,12 +923,13 @@ void mthca_free_cq(struct mthca_dev *dev
 	atomic_dec(&cq->refcount);
 	wait_event(cq->wait, !atomic_read(&cq->refcount));
 
-	mthca_free_mr(dev, &cq->mr);
-	mthca_free_cq_buf(dev, cq);
-
-	if (mthca_is_memfree(dev)) {
-		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
-		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+	if (cq->is_kernel) {
+		mthca_free_mr(dev, &cq->mr);
+		mthca_free_cq_buf(dev, cq);
+		if (mthca_is_memfree(dev)) {
+			mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
+			mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+		}
 	}
 
 	mthca_table_put(dev, dev->cq_table.table, cq->cqn);
--- linux.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-28 15:20:20.514467380 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-28 15:20:25.681346835 -0700
@@ -414,6 +414,7 @@ int mthca_poll_cq(struct ib_cq *ibcq, in
 int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
 int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
 int mthca_init_cq(struct mthca_dev *dev, int nent,
+		  struct mthca_ucontext *ctx, u32 pdn,
 		  struct mthca_cq *cq);
 void mthca_free_cq(struct mthca_dev *dev,
 		   struct mthca_cq *cq);
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:23.354851384 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:25.681346835 -0700
@@ -497,28 +497,85 @@ static struct ib_cq *mthca_create_cq(str
 				     struct ib_ucontext *context,
 				     struct ib_udata *udata)
 {
+	struct mthca_create_cq ucmd;
 	struct mthca_cq *cq;
 	int nent;
 	int err;
 
+	if (context) {
+		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
+			return ERR_PTR(-EFAULT);
+
+		err = mthca_map_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+					to_mucontext(context)->db_tab,
+					ucmd.set_db_index, ucmd.set_db_page);
+		if (err)
+			return ERR_PTR(err);
+
+		err = mthca_map_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+					to_mucontext(context)->db_tab,
+					ucmd.arm_db_index, ucmd.arm_db_page);
+		if (err)
+			goto err_unmap_set;
+	}
+
 	cq = kmalloc(sizeof *cq, GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
+	if (!cq) {
+		err = -ENOMEM;
+		goto err_unmap_arm;
+	}
+
+	if (context) {
+		cq->mr.ibmr.lkey    = ucmd.lkey;
+		cq->set_ci_db_index = ucmd.set_db_index;
+		cq->arm_db_index    = ucmd.arm_db_index;
+	}
 
 	for (nent = 1; nent <= entries; nent <<= 1)
 		; /* nothing */
 
-	err = mthca_init_cq(to_mdev(ibdev), nent, cq);
-	if (err) {
-		kfree(cq);
-		cq = ERR_PTR(err);
+	err = mthca_init_cq(to_mdev(ibdev), nent, 
+			    context ? to_mucontext(context) : NULL,
+			    context ? ucmd.pdn : to_mdev(ibdev)->driver_pd.pd_num,
+			    cq);
+	if (err)
+		goto err_free;
+
+	if (context && ib_copy_to_udata(udata, &cq->cqn, sizeof (__u32))) {
+		mthca_free_cq(to_mdev(ibdev), cq);
+		goto err_free;
 	}
 
 	return &cq->ibcq;
+
+err_free:
+	kfree(cq);
+
+err_unmap_arm:
+	if (context)
+		mthca_unmap_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+				    to_mucontext(context)->db_tab, ucmd.arm_db_index);
+
+err_unmap_set:
+	if (context)
+		mthca_unmap_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+				    to_mucontext(context)->db_tab, ucmd.set_db_index);
+
+	return ERR_PTR(err);
 }
 
 static int mthca_destroy_cq(struct ib_cq *cq)
 {
+	if (cq->uobject) {
+		mthca_unmap_user_db(to_mdev(cq->device),
+				    &to_mucontext(cq->uobject->context)->uar,
+				    to_mucontext(cq->uobject->context)->db_tab,
+				    to_mcq(cq)->arm_db_index);
+		mthca_unmap_user_db(to_mdev(cq->device),
+				    &to_mucontext(cq->uobject->context)->uar,
+				    to_mucontext(cq->uobject->context)->db_tab,
+				    to_mcq(cq)->set_ci_db_index);
+	}
 	mthca_free_cq(to_mdev(cq->device), to_mcq(cq));
 	kfree(cq);
 
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-28 15:20:20.514467380 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.h	2005-06-28 15:20:25.682346619 -0700
@@ -177,6 +177,7 @@ struct mthca_cq {
 	int                    cqn;
 	u32                    cons_index;
 	int                    is_direct;
+	int                    is_kernel;
 
 	/* Next fields are Arbel only */
 	int                    set_ci_db_index;
