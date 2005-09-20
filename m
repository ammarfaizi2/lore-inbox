Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVITWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVITWKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVITWJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:09:05 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48177 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965126AbVITWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:27 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 06/10] IB/mthca: Fix posting work requests to shared receive queues
In-Reply-To: <2005920158.G3atJmbH9pmjSQjI@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.fH5cjWXDbJWaw3V6@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0884 (UTC) FILETIME=[CB061140:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling paths in mthca_tavor_post_srq_recv() and
mthca_arbel_post_srq_recv() are quite bogus, the result of a
screwed up merge.  Fix them so they work as intended.

Pointed out by Michael S. Tsirkin <mst@mellanox.co.il>

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_srq.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

b95e7b96cd976a5974fa2ae8f3a1af510cb8d4c9
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -409,7 +409,7 @@ int mthca_tavor_post_srq_recv(struct ib_
 			mthca_err(dev, "SRQ %06x full\n", srq->srqn);
 			err = -ENOMEM;
 			*bad_wr = wr;
-			return nreq;
+			break;
 		}
 
 		wqe       = get_wqe(srq, ind);
@@ -427,7 +427,7 @@ int mthca_tavor_post_srq_recv(struct ib_
 			err = -EINVAL;
 			*bad_wr = wr;
 			srq->last = prev_wqe;
-			return nreq;
+			break;
 		}
 
 		for (i = 0; i < wr->num_sge; ++i) {
@@ -456,8 +456,6 @@ int mthca_tavor_post_srq_recv(struct ib_
 		srq->first_free = next_ind;
 	}
 
-	return nreq;
-
 	if (likely(nreq)) {
 		__be32 doorbell[2];
 
@@ -501,7 +499,7 @@ int mthca_arbel_post_srq_recv(struct ib_
 			mthca_err(dev, "SRQ %06x full\n", srq->srqn);
 			err = -ENOMEM;
 			*bad_wr = wr;
-			return nreq;
+			break;
 		}
 
 		wqe       = get_wqe(srq, ind);
@@ -517,7 +515,7 @@ int mthca_arbel_post_srq_recv(struct ib_
 		if (unlikely(wr->num_sge > srq->max_gs)) {
 			err = -EINVAL;
 			*bad_wr = wr;
-			return nreq;
+			break;
 		}
 
 		for (i = 0; i < wr->num_sge; ++i) {
