Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWI1QG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWI1QG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWI1QC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:27 -0400
Received: from mx.pathscale.com ([64.160.42.68]:5558 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751931AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 27 of 28] IB/ipath - fix races with ib_resize_cq()
X-Mercurial-Node: 944d7e53a04937d735135d1842e74d0f9db43d8d
Message-Id: <944d7e53a04937d73513.1159459223@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:23 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The resize CQ function changes the memory used to store the queue.
Other routines need to honor the lock before accessing the pointer
to the queue and verify that the head and tail are in range.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 8b45b43df5ad -r 944d7e53a049 drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Sep 28 08:57:13 2006 -0700
@@ -46,7 +46,7 @@
  */
 void ipath_cq_enter(struct ipath_cq *cq, struct ib_wc *entry, int solicited)
 {
-	struct ipath_cq_wc *wc = cq->queue;
+	struct ipath_cq_wc *wc;
 	unsigned long flags;
 	u32 head;
 	u32 next;
@@ -57,6 +57,7 @@ void ipath_cq_enter(struct ipath_cq *cq,
 	 * Note that the head pointer might be writable by user processes.
 	 * Take care to verify it is a sane value.
 	 */
+	wc = cq->queue;
 	head = wc->head;
 	if (head >= (unsigned) cq->ibcq.cqe) {
 		head = cq->ibcq.cqe;
@@ -109,21 +110,27 @@ int ipath_poll_cq(struct ib_cq *ibcq, in
 int ipath_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry)
 {
 	struct ipath_cq *cq = to_icq(ibcq);
-	struct ipath_cq_wc *wc = cq->queue;
+	struct ipath_cq_wc *wc;
 	unsigned long flags;
 	int npolled;
+	u32 tail;
 
 	spin_lock_irqsave(&cq->lock, flags);
 
+	wc = cq->queue;
+	tail = wc->tail;
+	if (tail > (u32) cq->ibcq.cqe)
+		tail = (u32) cq->ibcq.cqe;
 	for (npolled = 0; npolled < num_entries; ++npolled, ++entry) {
-		if (wc->tail == wc->head)
+		if (tail == wc->head)
 			break;
-		*entry = wc->queue[wc->tail];
-		if (wc->tail >= cq->ibcq.cqe)
-			wc->tail = 0;
+		*entry = wc->queue[tail];
+		if (tail >= cq->ibcq.cqe)
+			tail = 0;
 		else
-			wc->tail++;
-	}
+			tail++;
+	}
+	wc->tail = tail;
 
 	spin_unlock_irqrestore(&cq->lock, flags);
 
@@ -322,10 +329,16 @@ int ipath_req_notify_cq(struct ib_cq *ib
 	return 0;
 }
 
+/**
+ * ipath_resize_cq - change the size of the CQ
+ * @ibcq: the completion queue
+ *
+ * Returns 0 for success.
+ */
 int ipath_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 {
 	struct ipath_cq *cq = to_icq(ibcq);
-	struct ipath_cq_wc *old_wc = cq->queue;
+	struct ipath_cq_wc *old_wc;
 	struct ipath_cq_wc *wc;
 	u32 head, tail, n;
 	int ret;
@@ -361,6 +374,7 @@ int ipath_resize_cq(struct ib_cq *ibcq, 
 	 * Make sure head and tail are sane since they
 	 * might be user writable.
 	 */
+	old_wc = cq->queue;
 	head = old_wc->head;
 	if (head > (u32) cq->ibcq.cqe)
 		head = (u32) cq->ibcq.cqe;
