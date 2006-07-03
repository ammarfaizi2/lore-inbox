Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWGCWuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWGCWuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWGCWuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:50:22 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:56796 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932170AbWGCWuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:50:20 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Message-Id: <20060703225019.7379.96075.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH] mthca: initialize send and receive queue locks separately
Date: Mon,  3 Jul 2006 15:50:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mthca: initialize send and receive queue locks separately

lockdep identifies a lock by the call site of its initialization.  By
initializing the send and receive queue locks in mthca_wq_init() we confuse
lockdep.  It warns that that the ordered acquiry of both locks in
mthca_modify_qp() is recursive acquiry of one lock:

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
modprobe/1192 is trying to acquire lock:
 (&wq->lock){....}, at: [<f892b4db>] mthca_modify_qp+0x60/0xa7b [ib_mthca]
but task is already holding lock:
 (&wq->lock){....}, at: [<f892b4ce>] mthca_modify_qp+0x53/0xa7b [ib_mthca]

Initializing the locks separately in mthca_alloc_qp_common() stops the warning
and will let lockdep enforce proper ordering on paths that acquire both locks.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 drivers/infiniband/hw/mthca/mthca_qp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: 2.6.17-mm6/drivers/infiniband/hw/mthca/mthca_qp.c
===================================================================
--- 2.6.17-mm6.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2006-07-03 08:41:16.000000000 -0400
+++ 2.6.17-mm6/drivers/infiniband/hw/mthca/mthca_qp.c	2006-07-03 10:05:52.000000000 -0400
@@ -224,7 +224,7 @@
 
 static void mthca_wq_init(struct mthca_wq *wq)
 {
-	spin_lock_init(&wq->lock);
+	/* mthca_alloc_qp_common() initializes the locks */
 	wq->next_ind  = 0;
 	wq->last_comp = wq->max - 1;
 	wq->head      = 0;
@@ -1114,6 +1114,9 @@
 	qp->sq_policy    = send_policy;
 	mthca_wq_init(&qp->sq);
 	mthca_wq_init(&qp->rq);
+	/* these are initialized separately so lockdep can tell them apart */
+	spin_lock_init(&qp->sq.lock);
+	spin_lock_init(&qp->rq.lock);
 
 	ret = mthca_map_memfree(dev, qp);
 	if (ret)
