Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWINU7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWINU7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWINU7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:59:54 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:40608 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1750746AbWINU7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:59:53 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 14 Sep 2006 13:59:48 -0700
Message-ID: <adar6yeuptn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Sep 2006 20:59:48.0918 (UTC) FILETIME=[B72ACD60:01C6D840]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This contains a few last-minute fixes -- a couple of one-liners, and a
panic fix that turns out to be pure deletions:

Eli Cohen:
      IPoIB: Retry failed send-only multicast group joins

Ishai Rabinovitz:
      IB/srp: Don't schedule reconnect from srp

Michael S. Tsirkin:
      RDMA/cma: Increase the IB CM retry count in CMA

 drivers/infiniband/core/cma.c                  |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    1 +
 drivers/infiniband/ulp/srp/ib_srp.c            |   14 --------------
 3 files changed, 2 insertions(+), 15 deletions(-)


diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index d6f99d5..5d625a8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -49,7 +49,7 @@ MODULE_DESCRIPTION("Generic RDMA CM Agen
 MODULE_LICENSE("Dual BSD/GPL");
 
 #define CMA_CM_RESPONSE_TIMEOUT 20
-#define CMA_MAX_CM_RETRIES 3
+#define CMA_MAX_CM_RETRIES 15
 
 static void cma_add_one(struct ib_device *device);
 static void cma_remove_one(struct ib_device *device);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index b5e6a7b..ec356ce 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -326,6 +326,7 @@ ipoib_mcast_sendonly_join_complete(int s
 
 		/* Clear the busy flag so we try again */
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+		mcast->query = NULL;
 	}
 
 	complete(&mcast->done);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 8257d5a..fd8344c 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -799,13 +799,6 @@ static void srp_process_rsp(struct srp_t
 	spin_unlock_irqrestore(target->scsi_host->host_lock, flags);
 }
 
-static void srp_reconnect_work(void *target_ptr)
-{
-	struct srp_target_port *target = target_ptr;
-
-	srp_reconnect_target(target);
-}
-
 static void srp_handle_recv(struct srp_target_port *target, struct ib_wc *wc)
 {
 	struct srp_iu *iu;
@@ -858,7 +851,6 @@ static void srp_completion(struct ib_cq 
 {
 	struct srp_target_port *target = target_ptr;
 	struct ib_wc wc;
-	unsigned long flags;
 
 	ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
 	while (ib_poll_cq(cq, 1, &wc) > 0) {
@@ -866,10 +858,6 @@ static void srp_completion(struct ib_cq 
 			printk(KERN_ERR PFX "failed %s status %d\n",
 			       wc.wr_id & SRP_OP_RECV ? "receive" : "send",
 			       wc.status);
-			spin_lock_irqsave(target->scsi_host->host_lock, flags);
-			if (target->state == SRP_TARGET_LIVE)
-				schedule_work(&target->work);
-			spin_unlock_irqrestore(target->scsi_host->host_lock, flags);
 			break;
 		}
 
@@ -1705,8 +1693,6 @@ static ssize_t srp_create_target(struct 
 	target->scsi_host  = target_host;
 	target->srp_host   = host;
 
-	INIT_WORK(&target->work, srp_reconnect_work, target);
-
 	INIT_LIST_HEAD(&target->free_reqs);
 	INIT_LIST_HEAD(&target->req_queue);
 	for (i = 0; i < SRP_SQ_SIZE; ++i) {
