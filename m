Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWHKQA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWHKQA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWHKQA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:00:27 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:46684 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932172AbWHKQA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:00:27 -0400
To: openib-general@openib.org, mingo@redhat.com, arjan@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix potential deadlock in mthca
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 11 Aug 2006 09:00:22 -0700
Message-ID: <adad5b7ntyh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Aug 2006 16:00:25.0368 (UTC) FILETIME=[42031980:01C6BD5F]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a long-standing bug that lockdep found very nicely.

Ingo/Arjan, can you confirm that the fix looks OK and I am using
spin_lock_nested() properly?  I couldn't find much documentation or
many examples of it, so I'm not positive this is the right way to
handle this fix.

I'm inclined to put this fix in 2.6.18, since this is a kernel
deadlock that is triggerable from userspace via uverbs.  Comments?

Thanks,
  Roland

commit a19aa5c5fdda8b556ab238177ee27c5ef7873c94
Author: Roland Dreier <rolandd@cisco.com>
Date:   Fri Aug 11 08:56:57 2006 -0700

    IB/mthca: Fix potential AB-BA deadlock with CQ locks
    
    When destroying a QP, mthca locks both the QP's send CQ and receive
    CQ.  However, the following scenario is perfectly valid:
    
        QP_a: send_cq == CQ_x, recv_cq == CQ_y
        QP_b: send_cq == CQ_y, recv_cq == CQ_x
    
    The old mthca code simply locked send_cq and then recv_cq, which in
    this case could lead to an AB-BA deadlock if QP_a and QP_b were
    destroyed simultaneously.
    
    We can fix this by changing the locking code to lock the CQ with the
    lower CQ number first, which will create a consistent lock ordering.
    Also, the second CQ is locked with spin_lock_nested() to tell lockdep
    that we know what we're doing with the lock nesting.
    
    This bug was found by lockdep.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 8de2887..9a5bece 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -136,8 +136,8 @@ struct mthca_ah {
  * We have one global lock that protects dev->cq/qp_table.  Each
  * struct mthca_cq/qp also has its own lock.  An individual qp lock
  * may be taken inside of an individual cq lock.  Both cqs attached to
- * a qp may be locked, with the send cq locked first.  No other
- * nesting should be done.
+ * a qp may be locked, with the cq with the lower cqn locked first.
+ * No other nesting should be done.
  *
  * Each struct mthca_cq/qp also has an ref count, protected by the
  * corresponding table lock.  The pointer from the cq/qp_table to the
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 157b4f8..2e8f6f3 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1263,6 +1263,32 @@ int mthca_alloc_qp(struct mthca_dev *dev
 	return 0;
 }
 
+static void mthca_lock_cqs(struct mthca_cq *send_cq, struct mthca_cq *recv_cq)
+{
+	if (send_cq == recv_cq)
+		spin_lock_irq(&send_cq->lock);
+	else if (send_cq->cqn < recv_cq->cqn) {
+		spin_lock_irq(&send_cq->lock);
+		spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock_irq(&recv_cq->lock);
+		spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static void mthca_unlock_cqs(struct mthca_cq *send_cq, struct mthca_cq *recv_cq)
+{
+	if (send_cq == recv_cq)
+		spin_unlock_irq(&send_cq->lock);
+	else if (send_cq->cqn < recv_cq->cqn) {
+		spin_unlock(&recv_cq->lock);
+		spin_unlock_irq(&send_cq->lock);
+	} else {
+		spin_unlock(&send_cq->lock);
+		spin_unlock_irq(&recv_cq->lock);
+	}
+}
+
 int mthca_alloc_sqp(struct mthca_dev *dev,
 		    struct mthca_pd *pd,
 		    struct mthca_cq *send_cq,
@@ -1315,17 +1341,13 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	 * Lock CQs here, so that CQ polling code can do QP lookup
 	 * without taking a lock.
 	 */
-	spin_lock_irq(&send_cq->lock);
-	if (send_cq != recv_cq)
-		spin_lock(&recv_cq->lock);
+	mthca_lock_cqs(send_cq, recv_cq);
 
 	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp, mqpn);
 	spin_unlock(&dev->qp_table.lock);
 
-	if (send_cq != recv_cq)
-		spin_unlock(&recv_cq->lock);
-	spin_unlock_irq(&send_cq->lock);
+	mthca_unlock_cqs(send_cq, recv_cq);
 
  err_out:
 	dma_free_coherent(&dev->pdev->dev, sqp->header_buf_size,
@@ -1359,9 +1381,7 @@ void mthca_free_qp(struct mthca_dev *dev
 	 * Lock CQs here, so that CQ polling code can do QP lookup
 	 * without taking a lock.
 	 */
-	spin_lock_irq(&send_cq->lock);
-	if (send_cq != recv_cq)
-		spin_lock(&recv_cq->lock);
+	mthca_lock_cqs(send_cq, recv_cq);
 
 	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp,
@@ -1369,9 +1389,7 @@ void mthca_free_qp(struct mthca_dev *dev
 	--qp->refcount;
 	spin_unlock(&dev->qp_table.lock);
 
-	if (send_cq != recv_cq)
-		spin_unlock(&recv_cq->lock);
-	spin_unlock_irq(&send_cq->lock);
+	mthca_unlock_cqs(send_cq, recv_cq);
 
 	wait_event(qp->wait, !get_qp_refcount(dev, qp));
 
