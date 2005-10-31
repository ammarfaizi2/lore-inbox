Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVJaWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVJaWfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVJaWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:35:06 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:59658 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964807AbVJaWeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:34:50 -0500
Subject: [git patch review 4/5] [IB] mthca: Avoid SRQ free WQE list corruption
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 22:34:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1130798082548-8e2587fc62785f94@cisco.com>
In-Reply-To: <1130798082548-f241f7f48ee0a31b@cisco.com>
X-OriginalArrivalTime: 31 Oct 2005 22:34:43.0834 (UTC) FILETIME=[4A3D85A0:01C5DE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wqe_to_link() to use a structure field that we know is definitely
always unused for receive work requests, so that it really avoids the
free list corruption bug that the comment claims it does.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_srq.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

applies-to: ffd7eba03f29dd2932dd32ac4adc2921bde7644b
e5b251a24a9cd34a7ef98e361eb94e7ab122a554
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 64f70aa..292f55b 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -75,15 +75,16 @@ static void *get_wqe(struct mthca_srq *s
 
 /*
  * Return a pointer to the location within a WQE that we're using as a
- * link when the WQE is in the free list.  We use an offset of 4
- * because in the Tavor case, posting a WQE may overwrite the first
- * four bytes of the previous WQE.  The offset avoids corrupting our
- * free list if the WQE has already completed and been put on the free
- * list when we post the next WQE.
+ * link when the WQE is in the free list.  We use the imm field
+ * because in the Tavor case, posting a WQE may overwrite the next
+ * segment of the previous WQE, but a receive WQE will never touch the
+ * imm field.  This avoids corrupting our free list if the previous
+ * WQE has already completed and been put on the free list when we
+ * post the next WQE.
  */
 static inline int *wqe_to_link(void *wqe)
 {
-	return (int *) (wqe + 4);
+	return (int *) (wqe + offsetof(struct mthca_next_seg, imm));
 }
 
 static void mthca_tavor_init_srq_context(struct mthca_dev *dev,
---
0.99.9
