Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVF2Ce5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVF2Ce5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVF1Xed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:34:33 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:54439 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262228AbVF1XDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:54 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037104:sNHT29562068"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 02/16] IB uverbs: update kernel midlayer for new API
In-Reply-To: <2005628163.dSvxYW7XXf2cvPdt@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.TnJHv5fpNVcYsu6I@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update kernel InfiniBand midlayer to compile against the updated API
for low-level drivers.  This just amounts to passing NULL for all
userspace-related parameters, and setting userspace-related structure
members to NULL.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/verbs.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)



--- linux.orig/drivers/infiniband/core/verbs.c	2005-06-28 15:19:55.267928471 -0700
+++ linux/drivers/infiniband/core/verbs.c	2005-06-28 15:19:59.462022670 -0700
@@ -4,6 +4,7 @@
  * Copyright (c) 2004 Intel Corporation.  All rights reserved.
  * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
  * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -47,10 +48,11 @@ struct ib_pd *ib_alloc_pd(struct ib_devi
 {
 	struct ib_pd *pd;
 
-	pd = device->alloc_pd(device);
+	pd = device->alloc_pd(device, NULL, NULL);
 
 	if (!IS_ERR(pd)) {
-		pd->device = device;
+		pd->device  = device;
+		pd->uobject = NULL;
 		atomic_set(&pd->usecnt, 0);
 	}
 
@@ -76,8 +78,9 @@ struct ib_ah *ib_create_ah(struct ib_pd 
 	ah = pd->device->create_ah(pd, ah_attr);
 
 	if (!IS_ERR(ah)) {
-		ah->device = pd->device;
-		ah->pd     = pd;
+		ah->device  = pd->device;
+		ah->pd      = pd;
+		ah->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 	}
 
@@ -122,7 +125,7 @@ struct ib_qp *ib_create_qp(struct ib_pd 
 {
 	struct ib_qp *qp;
 
-	qp = pd->device->create_qp(pd, qp_init_attr);
+	qp = pd->device->create_qp(pd, qp_init_attr, NULL);
 
 	if (!IS_ERR(qp)) {
 		qp->device     	  = pd->device;
@@ -130,6 +133,7 @@ struct ib_qp *ib_create_qp(struct ib_pd 
 		qp->send_cq    	  = qp_init_attr->send_cq;
 		qp->recv_cq    	  = qp_init_attr->recv_cq;
 		qp->srq	       	  = qp_init_attr->srq;
+		qp->uobject       = NULL;
 		qp->event_handler = qp_init_attr->event_handler;
 		qp->qp_context    = qp_init_attr->qp_context;
 		qp->qp_type	  = qp_init_attr->qp_type;
@@ -197,10 +201,11 @@ struct ib_cq *ib_create_cq(struct ib_dev
 {
 	struct ib_cq *cq;
 
-	cq = device->create_cq(device, cqe);
+	cq = device->create_cq(device, cqe, NULL, NULL);
 
 	if (!IS_ERR(cq)) {
 		cq->device        = device;
+		cq->uobject       = NULL;
 		cq->comp_handler  = comp_handler;
 		cq->event_handler = event_handler;
 		cq->cq_context    = cq_context;
@@ -245,8 +250,9 @@ struct ib_mr *ib_get_dma_mr(struct ib_pd
 	mr = pd->device->get_dma_mr(pd, mr_access_flags);
 
 	if (!IS_ERR(mr)) {
-		mr->device = pd->device;
-		mr->pd     = pd;
+		mr->device  = pd->device;
+		mr->pd      = pd;
+		mr->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 		atomic_set(&mr->usecnt, 0);
 	}
@@ -267,8 +273,9 @@ struct ib_mr *ib_reg_phys_mr(struct ib_p
 				     mr_access_flags, iova_start);
 
 	if (!IS_ERR(mr)) {
-		mr->device = pd->device;
-		mr->pd     = pd;
+		mr->device  = pd->device;
+		mr->pd      = pd;
+		mr->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 		atomic_set(&mr->usecnt, 0);
 	}
@@ -344,8 +351,9 @@ struct ib_mw *ib_alloc_mw(struct ib_pd *
 
 	mw = pd->device->alloc_mw(pd);
 	if (!IS_ERR(mw)) {
-		mw->device = pd->device;
-		mw->pd     = pd;
+		mw->device  = pd->device;
+		mw->pd      = pd;
+		mw->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 	}
 
