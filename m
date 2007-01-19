Return-Path: <linux-kernel-owner+w=401wt.eu-S965069AbXATBLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbXATBLT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 20:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbXATBLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 20:11:19 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:29298 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965069AbXATBLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 20:11:18 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
       openib-general@openib.org
Subject: [PATCH 2.6.20 1/2] ehca: ehca_cq.c: fix unproper use of yield within spinlock context
Date: Fri, 19 Jan 2007 22:50:10 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701192250.10765.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland!
This is a patch for ehca_cq.c that fixes unproper use of yield within
spinlock context.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_cq.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 93995b6..6074c89 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -344,8 +344,11 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	while (my_cq->nr_callbacks)
+	while (my_cq->nr_callbacks) {
+		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		yield();
+		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+	}
 
 	idr_remove(&ehca_cq_idr, my_cq->token);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
