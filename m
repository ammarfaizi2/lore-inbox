Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422743AbWHYS1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743AbWHYS1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWHYSZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:38 -0400
Received: from mx.pathscale.com ([64.160.42.68]:45442 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422777AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19 of 23] IB/ipath - handle sq_sig_all field correctly
X-Mercurial-Node: 263d5f544bb43586b9b8c6a29d2ea8cbcdd634e9
Message-Id: <263d5f544bb43586b9b8.1156530284@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:44 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -606,9 +606,10 @@ int ipath_query_qp(struct ib_qp *ibqp, s
 	init_attr->recv_cq = qp->ibqp.recv_cq;
 	init_attr->srq = qp->ibqp.srq;
 	init_attr->cap = attr->cap;
-	init_attr->sq_sig_type =
-		(qp->s_flags & (1 << IPATH_S_SIGNAL_REQ_WR))
-		? IB_SIGNAL_REQ_WR : 0;
+	if (qp->s_flags & (1 << IPATH_S_SIGNAL_REQ_WR))
+		init_attr->sq_sig_type = IB_SIGNAL_REQ_WR;
+	else
+		init_attr->sq_sig_type = IB_SIGNAL_ALL_WR;
 	init_attr->qp_type = qp->ibqp.qp_type;
 	init_attr->port_num = 1;
 	return 0;
@@ -776,8 +777,10 @@ struct ib_qp *ipath_create_qp(struct ib_
 		qp->s_wq = swq;
 		qp->s_size = init_attr->cap.max_send_wr + 1;
 		qp->s_max_sge = init_attr->cap.max_send_sge;
-		qp->s_flags = init_attr->sq_sig_type == IB_SIGNAL_REQ_WR ?
-			1 << IPATH_S_SIGNAL_REQ_WR : 0;
+		if (init_attr->sq_sig_type == IB_SIGNAL_REQ_WR)
+			qp->s_flags = 1 << IPATH_S_SIGNAL_REQ_WR;
+		else
+			qp->s_flags = 0;
 		dev = to_idev(ibpd->device);
 		err = ipath_alloc_qpn(&dev->qp_table, qp,
 				      init_attr->qp_type);
