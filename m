Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966446AbWKTWuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966446AbWKTWuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966669AbWKTWuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:50:12 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64123 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S966446AbWKTWuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:50:10 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
Subject: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address to determine pending work requests
Date: Mon, 20 Nov 2006 23:54:12 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202354.13030.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland!
This is a patch for ehca to fix a bug in prepare_sqe_to_rts() that used wqe address
to iterate pending work requests and might cause access violation since the queue
pages can not be supposed to follow consecutively each other. Thus, this patch
introduces a few queue functions e.g. to determine wqe offset based on its address
and uses wqe offset to iterate the pending work requests.
Would be glad to see this in 2.6.19 and appreciate your helps!
Regards
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---

 ehca_main.c |    4 ++--
 ehca_qp.c   |   22 +++++++++-------------
 ipz_pt_fn.c |   13 +++++++++++++
 ipz_pt_fn.h |   15 +++++++++++++++
 4 files changed, 39 insertions(+), 15 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c	2006-11-20 10:20:20.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c	2006-11-20 12:49:51.000000000 +0100
@@ -52,7 +52,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0018");
+MODULE_VERSION("SVNEHCA_0019");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -790,7 +789,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0018)\n");
+	                 "(Rel.: SVNEHCA_0019)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_qp.c infiniband_work/drivers/infiniband/hw/ehca/ehca_qp.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_qp.c	2006-11-20 10:20:20.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_qp.c	2006-11-20 12:49:51.000000000 +0100
@@ -732,8 +732,7 @@ static int prepare_sqe_rts(struct ehca_q
 	u64 h_ret;
 	struct ipz_queue *squeue;
 	void *bad_send_wqe_p, *bad_send_wqe_v;
-	void *squeue_start_p, *squeue_end_p;
-	void *squeue_start_v, *squeue_end_v;
+	u64 q_ofs;
 	struct ehca_wqe *wqe;
 	int qp_num = my_qp->ib_qp.qp_num;
 
@@ -755,26 +754,23 @@ static int prepare_sqe_rts(struct ehca_q
 	if (ehca_debug_level)
 		ehca_dmp(bad_send_wqe_v, 32, "qp_num=%x bad_wqe", qp_num);
 	squeue = &my_qp->ipz_squeue;
-	squeue_start_p = (void*)virt_to_abs(ipz_qeit_calc(squeue, 0L));
-	squeue_end_p = squeue_start_p+squeue->queue_length;
-	squeue_start_v = abs_to_virt((u64)squeue_start_p);
-	squeue_end_v = abs_to_virt((u64)squeue_end_p);
-	ehca_dbg(&shca->ib_device, "qp_num=%x squeue_start_v=%p squeue_end_v=%p",
-		 qp_num, squeue_start_v, squeue_end_v);
+	if (ipz_queue_abs_to_offset(squeue, (u64)bad_send_wqe_p, &q_ofs)) {
+		ehca_err(&shca->ib_device, "failed to get wqe offset qp_num=%x"
+			 " bad_send_wqe_p=%p", qp_num, bad_send_wqe_p);
+		return -EFAULT;
+	}
 
 	/* loop sets wqe's purge bit */
-	wqe = (struct ehca_wqe*)bad_send_wqe_v;
+	wqe = (struct ehca_wqe*)ipz_qeit_calc(squeue, q_ofs);
 	*bad_wqe_cnt = 0;
 	while (wqe->optype != 0xff && wqe->wqef != 0xff) {
 		if (ehca_debug_level)
 			ehca_dmp(wqe, 32, "qp_num=%x wqe", qp_num);
 		wqe->nr_of_data_seg = 0; /* suppress data access */
 		wqe->wqef = WQEF_PURGE; /* WQE to be purged */
-		wqe = (struct ehca_wqe*)((u8*)wqe+squeue->qe_size);
+		q_ofs = ipz_queue_advance_offset(squeue, q_ofs);
+		wqe = (struct ehca_wqe*)ipz_qeit_calc(squeue, q_ofs);
 		*bad_wqe_cnt = (*bad_wqe_cnt)+1;
-		if ((void*)wqe >= squeue_end_v) {
-			wqe = squeue_start_v;
-		}
 	}
 	/*
 	 * bad wqe will be reprocessed and ignored when pol_cq() is called,
diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ipz_pt_fn.c infiniband_work/drivers/infiniband/hw/ehca/ipz_pt_fn.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ipz_pt_fn.c	2006-11-20 10:20:20.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ipz_pt_fn.c	2006-11-20 12:49:51.000000000 +0100
@@ -70,6 +70,19 @@ void *ipz_qeit_eq_get_inc(struct ipz_que
 	return ret;
 }
 
+int ipz_queue_abs_to_offset(struct ipz_queue *queue, u64 addr, u64 *q_offset)
+{
+	int i;
+	for (i = 0; i < queue->queue_length / queue->pagesize; i++) {
+		u64 page = (u64)virt_to_abs(queue->queue_pages[i]);
+		if (addr >= page && addr < page + queue->pagesize) {
+			*q_offset = addr - page + i * queue->pagesize;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 int ipz_queue_ctor(struct ipz_queue *queue,
 		   const u32 nr_of_pages,
 		   const u32 pagesize, const u32 qe_size, const u32 nr_of_sg)
diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ipz_pt_fn.h infiniband_work/drivers/infiniband/hw/ehca/ipz_pt_fn.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ipz_pt_fn.h	2006-11-20 10:20:20.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ipz_pt_fn.h	2006-11-20 12:49:51.000000000 +0100
@@ -150,6 +150,21 @@ static inline void *ipz_qeit_reset(struc
 	return ipz_qeit_get(queue);
 }
 
+/*
+ * return the q_offset corresponding to an absolute address
+ */
+int ipz_queue_abs_to_offset(struct ipz_queue *queue, u64 addr, u64 *q_offset);
+
+/*
+ * return the next queue offset. don't modify the queue.
+ */
+static inline u64 ipz_queue_advance_offset(struct ipz_queue *queue, u64 offset)
+{
+	offset += queue->qe_size;
+	if (offset >= queue->queue_length) offset = 0;
+	return offset;
+}
+
 /* struct generic page table */
 struct ipz_pt {
 	u64 entries[EHCA_PT_ENTRIES];
