Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWERTdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWERTdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWERTdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:33:42 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42359 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932137AbWERTdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:33:41 -0400
X-IronPort-AV: i="4.05,142,1146466800"; 
   d="scan'208"; a="279126082:sNHT34357598"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] Please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 18 May 2006 12:33:39 -0700
Message-ID: <ada7j4j1624.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 May 2006 19:33:40.0324 (UTC) FILETIME=[F749B240:01C67AB1]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The changes and patch are:

Ishai Rabinovitz:
      IB/srp: Complete correct SCSI commands on device reset

Michael S. Tsirkin:
      IB/mthca: Fix posting lists of 256 receive requests for Tavor

Roland Dreier:
      IB/mthca: Make fw_cmd_doorbell default to 0
      IB/srp: Don't wait for disconnection if sending DREQ fails
      IB/srp: Get rid of extra scsi_host_put()s if reconnection fails
      IB/uverbs: Don't leak ref to mm on error path

 drivers/infiniband/core/uverbs_mem.c    |    4 +++-
 drivers/infiniband/hw/mthca/mthca_cmd.c |    2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c  |   35 ++++++++++++++++---------------
 drivers/infiniband/ulp/srp/ib_srp.c     |   10 ++++-----
 4 files changed, 27 insertions(+), 24 deletions(-)


diff --git a/drivers/infiniband/core/uverbs_mem.c b/drivers/infiniband/core/uverbs_mem.c
index 36a32c3..efe147d 100644
--- a/drivers/infiniband/core/uverbs_mem.c
+++ b/drivers/infiniband/core/uverbs_mem.c
@@ -211,8 +211,10 @@ void ib_umem_release_on_close(struct ib_
 	 */
 
 	work = kmalloc(sizeof *work, GFP_KERNEL);
-	if (!work)
+	if (!work) {
+		mmput(mm);
 		return;
+	}
 
 	INIT_WORK(&work->work, ib_umem_account, work);
 	work->mm   = mm;
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 1985b5d..798e13e 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -182,7 +182,7 @@ struct mthca_cmd_context {
 	u8                status;
 };
 
-static int fw_cmd_doorbell = 1;
+static int fw_cmd_doorbell = 0;
 module_param(fw_cmd_doorbell, int, 0644);
 MODULE_PARM_DESC(fw_cmd_doorbell, "post FW commands through doorbell page if nonzero "
 		 "(and supported by FW)");
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 19765f6..07c13be 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1727,23 +1727,7 @@ int mthca_tavor_post_receive(struct ib_q
 
 	ind = qp->rq.next_ind;
 
-	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(nreq == MTHCA_TAVOR_MAX_WQES_PER_RECV_DB)) {
-			nreq = 0;
-
-			doorbell[0] = cpu_to_be32((qp->rq.next_ind << qp->rq.wqe_shift) | size0);
-			doorbell[1] = cpu_to_be32(qp->qpn << 8);
-
-			wmb();
-
-			mthca_write64(doorbell,
-				      dev->kar + MTHCA_RECEIVE_DOORBELL,
-				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
-
-			qp->rq.head += MTHCA_TAVOR_MAX_WQES_PER_RECV_DB;
-			size0 = 0;
-		}
-
+	for (nreq = 0; wr; wr = wr->next) {
 		if (mthca_wq_overflow(&qp->rq, nreq, qp->ibqp.recv_cq)) {
 			mthca_err(dev, "RQ %06x full (%u head, %u tail,"
 					" %d max, %d nreq)\n", qp->qpn,
@@ -1797,6 +1781,23 @@ int mthca_tavor_post_receive(struct ib_q
 		++ind;
 		if (unlikely(ind >= qp->rq.max))
 			ind -= qp->rq.max;
+
+		++nreq;
+		if (unlikely(nreq == MTHCA_TAVOR_MAX_WQES_PER_RECV_DB)) {
+			nreq = 0;
+
+			doorbell[0] = cpu_to_be32((qp->rq.next_ind << qp->rq.wqe_shift) | size0);
+			doorbell[1] = cpu_to_be32(qp->qpn << 8);
+
+			wmb();
+
+			mthca_write64(doorbell,
+				      dev->kar + MTHCA_RECEIVE_DOORBELL,
+				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+
+			qp->rq.head += MTHCA_TAVOR_MAX_WQES_PER_RECV_DB;
+			size0 = 0;
+		}
 	}
 
 out:
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index c32ce43..9cbdffa 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -340,7 +340,10 @@ static void srp_disconnect_target(struct
 	/* XXX should send SRP_I_LOGOUT request */
 
 	init_completion(&target->done);
-	ib_send_cm_dreq(target->cm_id, NULL, 0);
+	if (ib_send_cm_dreq(target->cm_id, NULL, 0)) {
+		printk(KERN_DEBUG PFX "Sending CM DREQ failed\n");
+		return;
+	}
 	wait_for_completion(&target->done);
 }
 
@@ -351,7 +354,6 @@ static void srp_remove_work(void *target
 	spin_lock_irq(target->scsi_host->host_lock);
 	if (target->state != SRP_TARGET_DEAD) {
 		spin_unlock_irq(target->scsi_host->host_lock);
-		scsi_host_put(target->scsi_host);
 		return;
 	}
 	target->state = SRP_TARGET_REMOVED;
@@ -365,8 +367,6 @@ static void srp_remove_work(void *target
 	ib_destroy_cm_id(target->cm_id);
 	srp_free_target_ib(target);
 	scsi_host_put(target->scsi_host);
-	/* And another put to really free the target port... */
-	scsi_host_put(target->scsi_host);
 }
 
 static int srp_connect_target(struct srp_target_port *target)
@@ -1241,7 +1241,7 @@ static int srp_reset_device(struct scsi_
 	list_for_each_entry_safe(req, tmp, &target->req_queue, list)
 		if (req->scmnd->device == scmnd->device) {
 			req->scmnd->result = DID_RESET << 16;
-			scmnd->scsi_done(scmnd);
+			req->scmnd->scsi_done(req->scmnd);
 			srp_remove_req(target, req);
 		}
 
