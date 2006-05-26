Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWEZAJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWEZAJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWEZAJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:09:13 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:55596 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965209AbWEZAJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:09:12 -0400
X-IronPort-AV: i="4.05,174,1146466800"; 
   d="scan'208"; a="1813085876:sNHT109401464"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 25 May 2006 17:09:10 -0700
Message-ID: <adapsi1hck9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 May 2006 00:09:11.0400 (UTC) FILETIME=[9D77F680:01C68058]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree has one bug fix (really the second half of a fix for a bug
that appeared two different places):

Michael S. Tsirkin:
      IB/mthca: Fix posting lists of 256 receive requests to SRQ for Tavor

 drivers/infiniband/hw/mthca/mthca_srq.c |   41 ++++++++++++++++---------------
 1 files changed, 21 insertions(+), 20 deletions(-)


diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 1ea4332..b292fef 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -490,26 +490,7 @@ int mthca_tavor_post_srq_recv(struct ib_
 
 	first_ind = srq->first_free;
 
-	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(nreq == MTHCA_TAVOR_MAX_WQES_PER_RECV_DB)) {
-			nreq = 0;
-
-			doorbell[0] = cpu_to_be32(first_ind << srq->wqe_shift);
-			doorbell[1] = cpu_to_be32(srq->srqn << 8);
-
-			/*
-			 * Make sure that descriptors are written
-			 * before doorbell is rung.
-			 */
-			wmb();
-
-			mthca_write64(doorbell,
-				      dev->kar + MTHCA_RECEIVE_DOORBELL,
-				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
-
-			first_ind = srq->first_free;
-		}
-
+	for (nreq = 0; wr; wr = wr->next) {
 		ind = srq->first_free;
 
 		if (ind < 0) {
@@ -569,6 +550,26 @@ int mthca_tavor_post_srq_recv(struct ib_
 
 		srq->wrid[ind]  = wr->wr_id;
 		srq->first_free = next_ind;
+
+		++nreq;
+		if (unlikely(nreq == MTHCA_TAVOR_MAX_WQES_PER_RECV_DB)) {
+			nreq = 0;
+
+			doorbell[0] = cpu_to_be32(first_ind << srq->wqe_shift);
+			doorbell[1] = cpu_to_be32(srq->srqn << 8);
+
+			/*
+			 * Make sure that descriptors are written
+			 * before doorbell is rung.
+			 */
+			wmb();
+
+			mthca_write64(doorbell,
+				      dev->kar + MTHCA_RECEIVE_DOORBELL,
+				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+
+			first_ind = srq->first_free;
+		}
 	}
 
 	if (likely(nreq)) {
