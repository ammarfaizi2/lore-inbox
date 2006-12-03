Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756305AbWLCQ3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbWLCQ3e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbWLCQ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:29:34 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:55222 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1756305AbWLCQ3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:29:33 -0500
Date: Sun, 3 Dec 2006 17:03:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steve Wise <swise@opengridcomputing.com>
cc: rdreier@cisco.com, netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 02/13] Device Discovery and ULLD Linkage
In-Reply-To: <20061202224937.27014.951.stgit@dell3.ogc.int>
Message-ID: <Pine.LNX.4.61.0612031658160.25425@yvahk01.tjqt.qr>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
 <20061202224937.27014.951.stgit@dell3.ogc.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



Some questions,suggestions,:

>+cxgb3_cpl_handler_func t3c_handlers[NUM_CPL_CMDS];

Can it be static'ified? (I suppose not.)

>+struct cxgb3_client t3c_client = {
>+	.name = "iw_cxgb3",
>+	.add = open_rnic_dev,
>+	.remove = close_rnic_dev,
>+	.handlers = t3c_handlers,
>+	.redirect = iwch_ep_redirect
>+};

Can it be const'ified?

>+static void rnic_init(struct iwch_dev *rnicp)
>+{
>+	PDBG("%s iwch_dev %p\n", __FUNCTION__,  rnicp);
>+	idr_init(&rnicp->cqidr);
>+	idr_init(&rnicp->qpidr);
>+	idr_init(&rnicp->mmidr);
>+	spin_lock_init(&rnicp->lock);
>+
>+	rnicp->attr.vendor_id = 0x168;
>+	rnicp->attr.vendor_part_id = 7;

Sugg.:

   typeof(rnicp->attr) *a = &rnicp->attr; // replace typeof with proper thing
   a->vendor_id = 0x168;
   a->vendor_part_id = 7;

shortens the lines a bit.

>+	rnicp->attr.max_qps = T3_MAX_NUM_QP - 32;
>+	rnicp->attr.max_wrs = (1UL << 24) - 1;
>+	rnicp->attr.max_sge_per_wr = T3_MAX_SGE;
>+	rnicp->attr.max_sge_per_rdma_write_wr = T3_MAX_SGE;
>+	rnicp->attr.max_cqs = T3_MAX_NUM_CQ - 1;
>+	rnicp->attr.max_cqes_per_cq = (1UL << 24) - 1;
>+	rnicp->attr.max_mem_regs = cxio_num_stags(&rnicp->rdev);
>+	rnicp->attr.max_phys_buf_entries = T3_MAX_PBL_SIZE;
>+	rnicp->attr.max_pds = T3_MAX_NUM_PD - 1;
>+	rnicp->attr.mem_pgsizes_bitmask = 0x7FFF;	/* 4KB-128MB */
>+	rnicp->attr.can_resize_wq = 0;
>+	rnicp->attr.max_rdma_reads_per_qp = 8;
>+	rnicp->attr.max_rdma_read_resources =
>+	    rnicp->attr.max_rdma_reads_per_qp * rnicp->attr.max_qps;
>+	rnicp->attr.max_rdma_read_qp_depth = 8;	/* IRD */
>+	rnicp->attr.max_rdma_read_depth =
>+	    rnicp->attr.max_rdma_read_qp_depth * rnicp->attr.max_qps;
>+	rnicp->attr.rq_overflow_handled = 0;
>+	rnicp->attr.can_modify_ird = 0;
>+	rnicp->attr.can_modify_ord = 0;
>+	rnicp->attr.max_mem_windows = rnicp->attr.max_mem_regs - 1;
>+	rnicp->attr.stag0_value = 1;
>+	rnicp->attr.zbva_support = 1;
>+	rnicp->attr.local_invalidate_fence = 1;
>+	rnicp->attr.cq_overflow_detection = 1;
>+	return;
>+}
>+
>--- /dev/null
>+++ b/drivers/infiniband/hw/cxgb3/iwch.h
>+static inline int t3b_device(struct iwch_dev *rhp)
>+{
>+	return (rhp->rdev.t3cdev_p->type == T3B);
>+}
>+
>+static inline int t3a_device(struct iwch_dev *rhp)
>+{
>+	return (rhp->rdev.t3cdev_p->type == T3A);
>+}

These two can be constified for sure: static inline int t3a_device(const 
struct iwch_dev *rhp)

>+
>+static inline struct iwch_cq *get_chp(struct iwch_dev *rhp, u32 cqid)
>+{
>+	return idr_find(&rhp->cqidr, cqid);
>+}
>+
>+static inline struct iwch_qp *get_qhp(struct iwch_dev *rhp, u32 qpid)
>+{
>+	return idr_find(&rhp->qpidr, qpid);
>+}
>+
>+static inline struct iwch_mr *get_mhp(struct iwch_dev *rhp, u32 mmid)
>+{
>+	return idr_find(&rhp->mmidr, mmid);
>+}

Here I am not sure.




	-`J'
-- 
