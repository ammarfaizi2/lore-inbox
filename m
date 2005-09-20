Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbVITWLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbVITWLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVITWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:59 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:52121 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965132AbVITWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:27 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 07/10] IB/mthca: Don't try to set srq->last for userspace SRQs
In-Reply-To: <2005920158.fH5cjWXDbJWaw3V6@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.JalL9e5rI88RbY2o@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0823 (UTC) FILETIME=[CAFCC270:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] IB/mthca: Don't try to set srq->last for userspace SRQs

Userspace SRQs don't have a buffer allocated for them in the kernel, so
it doesn't make sense to set srq->last during initialization.  In fact,
this can crash trying to follow a nonexistent buffer pointer.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_srq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

6577ae51cf52f5fb0e4a85e673dd7bf2d0074e3e
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -172,6 +172,8 @@ static int mthca_alloc_srq_buf(struct mt
 			scatter->lkey = cpu_to_be32(MTHCA_INVAL_LKEY);
 	}
 
+	srq->last = get_wqe(srq, srq->max - 1);
+
 	return 0;
 }
 
@@ -263,7 +265,6 @@ int mthca_alloc_srq(struct mthca_dev *de
 
 	srq->first_free = 0;
 	srq->last_free  = srq->max - 1;
-	srq->last	= get_wqe(srq, srq->max - 1);
 
 	return 0;
 
