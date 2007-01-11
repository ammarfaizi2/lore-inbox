Return-Path: <linux-kernel-owner+w=401wt.eu-S1751427AbXAKTMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXAKTMz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXAKTMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:12:55 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:43740 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXAKTMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:12:53 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 4/5] ehca: queue pair: remove use of do_mmap()
Date: Thu, 11 Jan 2007 20:09:08 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701112009.08712.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland and Christoph H.!
This is a patch for ehca_qp.c. It removes all direct calls of do_mmap()/munmap()
when creating and destroying a queue pair respectively.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_qp.c |   78 +++++++++++---------------------------------------------------
 1 files changed, 14 insertions(+), 64 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 34b8555..95efef9 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -637,7 +637,6 @@ struct ib_qp *ehca_create_qp(struct ib_p
 		struct ipz_queue *ipz_rqueue = &my_qp->ipz_rqueue;
 		struct ipz_queue *ipz_squeue = &my_qp->ipz_squeue;
 		struct ehca_create_qp_resp resp;
-		struct vm_area_struct * vma;
 		memset(&resp, 0, sizeof(resp));
 
 		resp.qp_num = my_qp->real_qp_num;
@@ -651,59 +650,21 @@ struct ib_qp *ehca_create_qp(struct ib_p
 		resp.ipz_rqueue.queue_length = ipz_rqueue->queue_length;
 		resp.ipz_rqueue.pagesize = ipz_rqueue->pagesize;
 		resp.ipz_rqueue.toggle_state = ipz_rqueue->toggle_state;
-		ret = ehca_mmap_nopage(((u64)(my_qp->token) << 32) | 0x22000000,
-				       ipz_rqueue->queue_length,
-				       (void**)&resp.ipz_rqueue.queue,
-				       &vma);
-		if (ret) {
-			ehca_err(pd->device, "Could not mmap rqueue pages");
-			goto create_qp_exit3;
-		}
-		my_qp->uspace_rqueue = resp.ipz_rqueue.queue;
 		/* squeue properties */
 		resp.ipz_squeue.qe_size = ipz_squeue->qe_size;
 		resp.ipz_squeue.act_nr_of_sg = ipz_squeue->act_nr_of_sg;
 		resp.ipz_squeue.queue_length = ipz_squeue->queue_length;
 		resp.ipz_squeue.pagesize = ipz_squeue->pagesize;
 		resp.ipz_squeue.toggle_state = ipz_squeue->toggle_state;
-		ret = ehca_mmap_nopage(((u64)(my_qp->token) << 32) | 0x23000000,
-				       ipz_squeue->queue_length,
-				       (void**)&resp.ipz_squeue.queue,
-				       &vma);
-		if (ret) {
-			ehca_err(pd->device, "Could not mmap squeue pages");
-			goto create_qp_exit4;
-		}
-		my_qp->uspace_squeue = resp.ipz_squeue.queue;
-		/* fw_handle */
-		resp.galpas = my_qp->galpas;
-		ret = ehca_mmap_register(my_qp->galpas.user.fw_handle,
-					 (void**)&resp.galpas.kernel.fw_handle,
-					 &vma);
-		if (ret) {
-			ehca_err(pd->device, "Could not mmap fw_handle");
-			goto create_qp_exit5;
-		}
-		my_qp->uspace_fwh = (u64)resp.galpas.kernel.fw_handle;
-
 		if (ib_copy_to_udata(udata, &resp, sizeof resp)) {
 			ehca_err(pd->device, "Copy to udata failed");
 			ret = -EINVAL;
-			goto create_qp_exit6;
+			goto create_qp_exit3;
 		}
 	}
 
 	return &my_qp->ib_qp;
 
-create_qp_exit6:
-	ehca_munmap(my_qp->uspace_fwh, EHCA_PAGESIZE);
-
-create_qp_exit5:
-	ehca_munmap(my_qp->uspace_squeue, my_qp->ipz_squeue.queue_length);
-
-create_qp_exit4:
-	ehca_munmap(my_qp->uspace_rqueue, my_qp->ipz_rqueue.queue_length);
-
 create_qp_exit3:
 	ipz_queue_dtor(&my_qp->ipz_rqueue);
 	ipz_queue_dtor(&my_qp->ipz_squeue);
@@ -931,7 +892,7 @@ static int internal_modify_qp(struct ib_
 	     my_qp->qp_type == IB_QPT_SMI) &&
 	    statetrans == IB_QPST_SQE2RTS) {
 		/* mark next free wqe if kernel */
-		if (my_qp->uspace_squeue == 0) {
+		if (!ibqp->uobject) {
 			struct ehca_wqe *wqe;
 			/* lock send queue */
 			spin_lock_irqsave(&my_qp->spinlock_s, spl_flags);
@@ -1417,11 +1378,18 @@ int ehca_destroy_qp(struct ib_qp *ibqp)
 	enum ib_qp_type	qp_type;
 	unsigned long flags;
 
-	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
-	    my_pd->ownpid != cur_pid) {
-		ehca_err(ibqp->device, "Invalid caller pid=%x ownpid=%x",
-			 cur_pid, my_pd->ownpid);
-		return -EINVAL;
+	if (ibqp->uobject) {
+		if (my_qp->mm_count_galpa ||
+		    my_qp->mm_count_rqueue || my_qp->mm_count_squeue) {
+			ehca_err(ibqp->device, "Resources still referenced in "
+				 "user space qp_num=%x", ibqp->qp_num);
+			return -EINVAL;
+		}
+		if (my_pd->ownpid != cur_pid) {
+			ehca_err(ibqp->device, "Invalid caller pid=%x ownpid=%x",
+				 cur_pid, my_pd->ownpid);
+			return -EINVAL;
+		}
 	}
 
 	if (my_qp->send_cq) {
@@ -1439,24 +1407,6 @@ int ehca_destroy_qp(struct ib_qp *ibqp)
 	idr_remove(&ehca_qp_idr, my_qp->token);
 	spin_unlock_irqrestore(&ehca_qp_idr_lock, flags);
 
-	/* un-mmap if vma alloc */
-	if (my_qp->uspace_rqueue) {
-		ret = ehca_munmap(my_qp->uspace_rqueue,
-				  my_qp->ipz_rqueue.queue_length);
-		if (ret)
-			ehca_err(ibqp->device, "Could not munmap rqueue "
-				 "qp_num=%x", qp_num);
-		ret = ehca_munmap(my_qp->uspace_squeue,
-				  my_qp->ipz_squeue.queue_length);
-		if (ret)
-			ehca_err(ibqp->device, "Could not munmap squeue "
-				 "qp_num=%x", qp_num);
-		ret = ehca_munmap(my_qp->uspace_fwh, EHCA_PAGESIZE);
-		if (ret)
-			ehca_err(ibqp->device, "Could not munmap fwh qp_num=%x",
-				 qp_num);
-	}
-
 	h_ret = hipz_h_destroy_qp(shca->ipz_hca_handle, my_qp);
 	if (h_ret != H_SUCCESS) {
 		ehca_err(ibqp->device, "hipz_h_destroy_qp() failed rc=%lx "
