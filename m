Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVKJScD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVKJScD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKJScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:01 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22336 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751057AbVKJScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:00 -0500
Subject: [git patch review 1/7] [IB] Have cq_resize() method take an int,
	not int*
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-039f6ac6e65cc7ed@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:56.0777 (UTC) FILETIME=[07BA8590:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the struct ib_device.resize_cq() method to take a plain integer
that holds the new CQ size, rather than a pointer to an integer that
it uses to return the new size.  This makes the interface match the
exported ib_resize_cq() signature, and allows the low-level driver to
update the CQ size with proper locking if necessary.

No in-tree drivers are exporting this method yet.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/verbs.c |   12 ++----------
 include/rdma/ib_verbs.h         |    2 +-
 2 files changed, 3 insertions(+), 11 deletions(-)

applies-to: 08d94f59d6f80937db5d87f0bb60eafcedd811d1
40de2e548c225e3ef859e3c60de9785e37e1b5b1
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 72d3ef7..4f51d79 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -324,16 +324,8 @@ EXPORT_SYMBOL(ib_destroy_cq);
 int ib_resize_cq(struct ib_cq *cq,
                  int           cqe)
 {
-	int ret;
-
-	if (!cq->device->resize_cq)
-		return -ENOSYS;
-
-	ret = cq->device->resize_cq(cq, &cqe);
-	if (!ret)
-		cq->cqe = cqe;
-
-	return ret;
+	return cq->device->resize_cq ?
+		cq->device->resize_cq(cq, cqe) : -ENOSYS;
 }
 EXPORT_SYMBOL(ib_resize_cq);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f72d46d..a7f4c35 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -881,7 +881,7 @@ struct ib_device {
 						struct ib_ucontext *context,
 						struct ib_udata *udata);
 	int                        (*destroy_cq)(struct ib_cq *cq);
-	int                        (*resize_cq)(struct ib_cq *cq, int *cqe);
+	int                        (*resize_cq)(struct ib_cq *cq, int cqe);
 	int                        (*poll_cq)(struct ib_cq *cq, int num_entries,
 					      struct ib_wc *wc);
 	int                        (*peek_cq)(struct ib_cq *cq, int wc_cnt);
---
0.99.9e
