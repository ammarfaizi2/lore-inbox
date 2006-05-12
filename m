Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWELXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWELXpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWELXow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:52 -0400
Received: from mx.pathscale.com ([64.160.42.68]:64425 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932294AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 48 of 53] ipath - QP should ignore receive queue size if SRQ
	specified
X-Mercurial-Node: 49b446b12f169810697575d6f3b45dac0e124efe
Message-Id: <49b446b12f1698106975.1147477413@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:33 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r a1615956e57f -r 49b446b12f16 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:29 2006 -0700
@@ -684,16 +684,22 @@ struct ib_qp *ipath_create_qp(struct ib_
 			ret = ERR_PTR(-ENOMEM);
 			goto bail;
 		}
-		qp->r_rq.size = init_attr->cap.max_recv_wr + 1;
-		sz = sizeof(struct ipath_sge) *
-			init_attr->cap.max_recv_sge +
-			sizeof(struct ipath_rwqe);
-		qp->r_rq.wq = vmalloc(qp->r_rq.size * sz);
-		if (!qp->r_rq.wq) {
-			kfree(qp);
-			vfree(swq);
-			ret = ERR_PTR(-ENOMEM);
-			goto bail;
+		if (init_attr->srq) {
+			qp->r_rq.size = 0;
+			qp->r_rq.max_sge = 0;
+			qp->r_rq.wq = NULL;
+		} else {
+			qp->r_rq.size = init_attr->cap.max_recv_wr + 1;
+			qp->r_rq.max_sge = init_attr->cap.max_recv_sge;
+			sz = (sizeof(struct ipath_sge) * qp->r_rq.max_sge) +
+				sizeof(struct ipath_rwqe);
+			qp->r_rq.wq = vmalloc(qp->r_rq.size * sz);
+			if (!qp->r_rq.wq) {
+				kfree(qp);
+				vfree(swq);
+				ret = ERR_PTR(-ENOMEM);
+				goto bail;
+			}
 		}
 
 		/*
@@ -712,7 +718,6 @@ struct ib_qp *ipath_create_qp(struct ib_
 		qp->s_wq = swq;
 		qp->s_size = init_attr->cap.max_send_wr + 1;
 		qp->s_max_sge = init_attr->cap.max_send_sge;
-		qp->r_rq.max_sge = init_attr->cap.max_recv_sge;
 		qp->s_flags = init_attr->sq_sig_type == IB_SIGNAL_REQ_WR ?
 			1 << IPATH_S_SIGNAL_REQ_WR : 0;
 		dev = to_idev(ibpd->device);
