Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWELXqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWELXqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWELXp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:56 -0400
Received: from mx.pathscale.com ([64.160.42.68]:62889 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932285AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 41 of 53] ipath - disable interrupts while holding spinlock in
	RWQE get
X-Mercurial-Node: 83f1832c601594846868cf79d77373d9da50bb6d
Message-Id: <83f1832c601594846868.1147477406@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:26 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 160a111381ae -r 83f1832c6015 drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Fri May 12 15:55:29 2006 -0700
@@ -171,12 +171,13 @@ int ipath_get_rwqe(struct ipath_qp *qp, 
 			n = rq->head - rq->tail;
 		if (n < srq->limit) {
 			srq->limit = 0;
-			spin_unlock(&rq->lock);
+			spin_unlock_irqrestore(&rq->lock, flags);
 			ev.device = qp->ibqp.device;
 			ev.element.srq = qp->ibqp.srq;
 			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
 			srq->ibsrq.event_handler(&ev,
 						 srq->ibsrq.srq_context);
+			spin_lock_irqsave(&rq->lock, flags);
 		}
 	}
 done:
