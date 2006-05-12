Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWELXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWELXqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWELXp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:57 -0400
Received: from mx.pathscale.com ([64.160.42.68]:63145 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932286AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 43 of 53] ipath - fix memory leak when creating a QP fails
X-Mercurial-Node: 7634b2f0fc40d4998445bce71813f4482cbe9a3d
Message-Id: <7634b2f0fc40d4998445.1147477408@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:28 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 0aba84dce506 -r 7634b2f0fc40 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:29 2006 -0700
@@ -680,6 +680,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 	case IB_QPT_GSI:
 		qp = kmalloc(sizeof(*qp), GFP_KERNEL);
 		if (!qp) {
+			vfree(swq);
 			ret = ERR_PTR(-ENOMEM);
 			goto bail;
 		}
@@ -690,6 +691,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 		qp->r_rq.wq = vmalloc(qp->r_rq.size * sz);
 		if (!qp->r_rq.wq) {
 			kfree(qp);
+			vfree(swq);
 			ret = ERR_PTR(-ENOMEM);
 			goto bail;
 		}
