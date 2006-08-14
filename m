Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHNQaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHNQaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWHNQaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:30:07 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:16367 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750835AbWHNQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:30:03 -0400
Message-ID: <44E0A508.8040301@de.ibm.com>
Date: Mon, 14 Aug 2006 18:30:00 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 3/7] ehea: queue management
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


  drivers/net/ehea/ehea_qmr.c |  757 ++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/ehea/ehea_qmr.h |  392 ++++++++++++++++++++++
  2 files changed, 1149 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_qmr.c	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_qmr.c	2006-08-14 09:05:14.052552544 -0700
@@ -0,0 +1,757 @@
+/*
+ *  linux/drivers/net/ehea/ehea_qmr.c
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Heiko-Joerg Schick <schickhj@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "ehea.h"
+#include "ehea_phyp.h"
+#include "ehea_qmr.h"
+
+static void *hw_qpageit_get_inc(struct hw_queue *queue)
+{
+	void *retvalue = hw_qeit_get(queue);
+	queue->current_q_offset += queue->pagesize;
+	if (queue->current_q_offset > queue->queue_length) {
+		queue->current_q_offset -= queue->pagesize;
+		retvalue = NULL;
+	}
+	else if ((((u64) retvalue) & (EHEA_PAGESIZE-1)) != 0) {
+		EDEB_ERR(4, "ERROR!! not at PAGE-Boundary");
+		return NULL;
+	}
+	EDEB(7, "queue=%p retvalue=%p", queue, retvalue);
+	return retvalue;
+}
+
+static int hw_queue_ctor(struct hw_queue *queue, const u32 nr_of_pages,
+			  const u32 pagesize, const u32 qe_size)
+{
+	int pages_per_kpage = PAGE_SIZE / pagesize;
+	int i;
+
+	EDEB_EN(7, "nr_of_pages=%x pagesize=%x qe_size=%x pages_per_kpage=%x",
+		nr_of_pages, pagesize, qe_size, pages_per_kpage);
+	if (pagesize > PAGE_SIZE) {
+		EDEB_ERR(4, "FATAL ERROR: pagesize=%x is greater than "
+			 "kernel page size", pagesize);
+		return 0;
+	}
+	if (!pages_per_kpage) {
+		EDEB_ERR(4, "FATAL ERROR: invalid kernel page size. "
+			"pages_per_kpage=%x", pages_per_kpage);
+		return 0;
+	}
+	queue->queue_length = nr_of_pages * pagesize;
+	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
+	if (!queue->queue_pages) {
+		EDEB(4, "ERROR!! didn't get the memory");
+		return 0;
+	}
+	memset(queue->queue_pages, 0, nr_of_pages * sizeof(void *));
+	/*
+	 * allocate pages for queue:
+	 * outer loop allocates whole kernel pages (page aligned) and
+	 * inner loop divides a kernel page into smaller hea queue pages
+	 */
+	i = 0;
+	while (i < nr_of_pages) {
+		u8 *kpage = (u8*)get_zeroed_page(GFP_KERNEL);
+		int k;
+		if (!kpage)
+			goto hw_queue_ctor_exit0; /*NOMEM*/
+		for (k = 0; k < pages_per_kpage && i < nr_of_pages; k++) {
+			(queue->queue_pages)[i] = (struct ehea_page *)kpage;
+			kpage += pagesize;
+			i++;
+		}
+	}
+
+	queue->current_q_offset = 0;
+	queue->qe_size = qe_size;
+	queue->pagesize = pagesize;
+	queue->toggle_state = 1;
+	EDEB_EX(7, "queue_length=%x queue_pages=%p qe_size=%x",
+		queue->queue_length, queue->queue_pages,
+		queue->qe_size);
+	return 1;
+
+ hw_queue_ctor_exit0:
+	EDEB_ERR(4, "Couldn't get alloc pages queue=%p f=%x nr_of_pages=%x",
+		 queue, i, nr_of_pages);
+	for (i = 0; i < nr_of_pages; i += pages_per_kpage) {
+		if (!(queue->queue_pages)[i])
+			break;
+		free_page((unsigned long)(queue->queue_pages)[i]);
+	}
+	return 0;
+}
+
+static int hw_queue_dtor(struct hw_queue *queue)
+{
+	int pages_per_kpage = PAGE_SIZE / queue->pagesize;
+	int i;
+	int nr_pages;
+
+	EDEB_EN(7, "hw_queue pointer=%p", queue);
+	if (!queue || !queue->queue_pages) {
+		EDEB_ERR(4, "queue or queue_pages is NULL");
+		return 0;
+	}
+	EDEB(7, "destructing a queue with the following "
+	     "properties:\n pagesize=%x qe_size=%x",
+	     queue->pagesize, queue->qe_size);
+	nr_pages = queue->queue_length / queue->pagesize;
+	for (i = 0; i < nr_pages; i += pages_per_kpage)
+		free_page((unsigned long)(queue->queue_pages)[i]);
+	vfree(queue->queue_pages);
+
+	EDEB_EX(7, "queue freed!");
+	return 1;
+}
+
+struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
+			       int nr_of_cqe, u64 eq_handle, u32 cq_token)
+{
+	struct ehea_cq *cq = NULL;
+	struct h_epa epa;
+
+	u64 *cq_handle_ref;
+	u32 act_nr_of_entries;
+	u32 act_pages;
+	u64 hret = H_HARDWARE;
+	int hwret;
+	u32 counter;
+	void *vpage = NULL;
+	u64 rpage = 0;
+
+	EDEB_EN(7, "adapter=%p nr_of_cqe=%x , eq_handle: %016lX",
+		adapter, nr_of_cqe, eq_handle);
+
+	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	if (!cq) {
+		cq = NULL;
+		EDEB_ERR(4, "ehea_create_cq ret=%p (-ENOMEM)", cq);
+		goto create_cq_exit0;
+	}
+
+	cq->attr.max_nr_of_cqes = nr_of_cqe;
+	cq->attr.cq_token = cq_token;
+	cq->attr.eq_handle = eq_handle;
+
+	cq->adapter = adapter;
+
+	cq_handle_ref = &cq->fw_handle;
+	act_nr_of_entries = 0;
+	act_pages = 0;
+
+	hret = ehea_h_alloc_resource_cq(adapter->handle, cq, &cq->attr,
+					&cq->fw_handle, &cq->epas);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "ehea_h_alloc_resource_cq failed. hret=%lx", hret);
+		goto create_cq_exit1;
+	}
+
+	hwret = hw_queue_ctor(&cq->hw_queue, cq->attr.nr_pages,
+				EHEA_PAGESIZE, sizeof(struct ehea_cqe));
+	if (!hwret)
+		goto create_cq_exit2;
+
+	for (counter = 0; counter < cq->attr.nr_pages; counter++) {
+		vpage = hw_qpageit_get_inc(&cq->hw_queue);
+		if (!vpage) {
+			EDEB_ERR(4, "hw_qpageit_get_inc() "
+				 "returns NULL adapter=%p", adapter);
+			goto create_cq_exit3;
+		}
+
+		rpage = virt_to_abs(vpage);
+
+		hret = ehea_h_register_rpage_cq(adapter->handle,
+						cq->fw_handle,
+						0,
+						EHEA_CQ_REGISTER_ORIG,
+						rpage, 1, cq->epas.kernel);
+
+		if (hret < H_SUCCESS) {
+			EDEB_ERR(4, "ehea_h_register_rpage_cq() failed "
+				 "ehea_cq=%p hret=%lx "
+				 "counter=%i act_pages=%i",
+				 cq, hret, counter, cq->attr.nr_pages);
+			goto create_cq_exit3;
+		}
+
+		if (counter == (cq->attr.nr_pages - 1)) {
+			vpage = hw_qpageit_get_inc(&cq->hw_queue);
+
+			if ((hret != H_SUCCESS) || (vpage)) {
+				EDEB_ERR(4, "Registration of pages not "
+					 "complete ehea_cq=%p hret=%lx",
+					 cq, hret)
+				goto create_cq_exit3;
+			}
+		} else {
+			if ((hret != H_PAGE_REGISTERED) || (!vpage)) {
+				EDEB_ERR(4, "Registration of page failed "
+					 "ehea_cq=%p hret=%lx"
+					 "counter=%i act_pages=%i",
+					 cq, hret, counter, cq->attr.nr_pages);
+				goto create_cq_exit3;
+			}
+		}
+	}
+
+	hw_qeit_reset(&cq->hw_queue);
+	epa = cq->epas.kernel;
+	ehea_reset_cq_ep(cq);
+	ehea_reset_cq_n1(cq);
+
+	EDEB_EX(7, "ret=%p ", cq);
+	return cq;
+
+create_cq_exit3:
+	hw_queue_dtor(&cq->hw_queue);
+
+create_cq_exit2:
+	ehea_h_destroy_cq(adapter->handle, cq, cq->fw_handle, &cq->epas);
+
+create_cq_exit1:
+	kfree(cq);
+
+create_cq_exit0:
+	EDEB_EX(7, "ret=NULL");
+	return NULL;
+}
+
+int ehea_destroy_cq(struct ehea_cq *cq)
+{
+	int ret = 0;
+	u64 adapter_handle;
+	u64 hret = H_HARDWARE;
+
+	adapter_handle = cq->adapter->handle;
+	EDEB_EN(7, "adapter=%p cq=%p", cq->adapter, cq);
+
+	if (!cq)
+		return 0;
+
+	/* deregister all previous registered pages */
+	hret = ehea_h_destroy_cq(adapter_handle, cq, cq->fw_handle,
+				 &cq->epas);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "destroy CQ failed!");
+		return -EINVAL;
+	}
+	hw_queue_dtor(&cq->hw_queue);
+	kfree(cq);
+
+	EDEB_EX(7, "ret=%x ", ret);
+	return ret;
+}
+
+struct ehea_eq *ehea_create_eq(struct ehea_adapter *adapter,
+			       const enum ehea_eq_type type,
+			       const u32 max_nr_of_eqes, const u8 eqe_gen)
+{
+	u64 hret = H_HARDWARE;
+	int ret = 0;
+	u32 i;
+	void *vpage = NULL;
+	u64 rpage = 0;
+	struct ehea_eq *eq;
+
+	EDEB_EN(7, "adapter=%p, max_nr_of_eqes=%x", adapter, max_nr_of_eqes);
+
+	eq = kzalloc(sizeof(*eq), GFP_KERNEL);
+	if (!eq)
+		return NULL;
+
+	eq->adapter = adapter;
+	eq->attr.type = type;
+	eq->attr.max_nr_of_eqes = max_nr_of_eqes;
+	eq->attr.eqe_gen = eqe_gen;
+	spin_lock_init(&eq->spinlock);
+
+	hret = ehea_h_alloc_resource_eq(adapter->handle,
+					eq, &eq->attr, &eq->fw_handle);
+
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "ehea_h_alloc_resource_eq failed. hret=%lx", hret);
+		goto free_eq_mem;
+	}
+
+	ret = hw_queue_ctor(&eq->hw_queue, eq->attr.nr_pages,
+			      EHEA_PAGESIZE, sizeof(struct ehea_eqe));
+	if (!ret) {
+		EDEB_ERR(4, "can't allocate EQ pages");
+		goto alloc_pages_failed;
+	}
+
+	for (i = 0; i < eq->attr.nr_pages; i++) {
+		vpage = hw_qpageit_get_inc(&eq->hw_queue);
+		if (!vpage) {
+			hret = H_RESOURCE;
+			goto register_page_failed;
+		}
+
+		rpage = virt_to_abs(vpage);
+
+		hret = ehea_h_register_rpage_eq(adapter->handle,
+						eq->fw_handle,
+						0,
+					        EHEA_EQ_REGISTER_ORIG,
+						rpage, 1);
+
+		if (i == (eq->attr.nr_pages - 1)) {
+			/* last page */
+			vpage = hw_qpageit_get_inc(&eq->hw_queue);
+			if ((hret != H_SUCCESS) || (vpage)) {
+				goto register_page_failed;
+			}
+		} else {
+			if ((hret != H_PAGE_REGISTERED) || (!vpage)) {
+				goto register_page_failed;
+			}
+		}
+	}
+
+	hw_qeit_reset(&eq->hw_queue);
+
+	EDEB_EX(7, "hret=%lx", hret);
+	return eq;
+
+register_page_failed:
+	hw_queue_dtor(&eq->hw_queue);
+
+alloc_pages_failed:
+	ehea_h_destroy_eq(adapter->handle, eq, eq->fw_handle, &eq->epas);
+free_eq_mem:
+	kfree(eq);
+
+	EDEB_EX(7, "return with error hret=%lx", hret);
+	return NULL;
+}
+
+struct ehea_eqe *ehea_poll_eq(struct ehea_eq *eq)
+{
+	struct ehea_eqe *eqe = NULL;
+	unsigned long flags = 0;
+
+	EDEB_EN(7, "adapter=%p  eq=%p", eq->adapter, eq);
+
+	spin_lock_irqsave(&eq->spinlock, flags);
+	eqe = (struct ehea_eqe*)hw_eqit_eq_get_inc_valid(&eq->hw_queue);
+	spin_unlock_irqrestore(&eq->spinlock, flags);
+
+	EDEB_EX(7, "eqe=%p", eqe);
+
+	return eqe;
+}
+
+int ehea_destroy_eq(struct ehea_eq *eq)
+{
+	unsigned long flags = 0;
+	u64 hret = H_HARDWARE;
+
+	EDEB_EN(7, "adapter=%p  eq=%p", eq->adapter, eq);
+
+	if (!eq)
+		return 0;
+
+	spin_lock_irqsave(&eq->spinlock, flags);
+
+	hret = ehea_h_destroy_eq(eq->adapter->handle, eq, eq->fw_handle,
+				 &eq->epas);
+	spin_unlock_irqrestore(&eq->spinlock, flags);
+
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "Failed freeing EQ resources. hret=%lx", hret);
+		return -EINVAL;
+	}
+	hw_queue_dtor(&eq->hw_queue);
+	kfree(eq);
+	EDEB_EX(7, "");
+
+	return 0;
+}
+
+/**
+ * allocates memory for a queue and registers pages in phyp
+ */
+int ehea_qp_alloc_register(struct ehea_qp *qp,
+			   struct hw_queue *hw_queue,
+			   int nr_pages,
+			   int wqe_size,
+			   int act_nr_sges,
+			   struct ehea_adapter *adapter, int h_call_q_selector)
+{
+	u64 hret = H_HARDWARE;
+	u64 rpage = 0;
+	int iret = 0;
+	int cnt = 0;
+	void *vpage = NULL;
+
+	iret = hw_queue_ctor(hw_queue,
+			      nr_pages, EHEA_PAGESIZE, wqe_size);
+	if (!iret) {
+		EDEB_ERR(4, "Cannot allocate page for queue. iret=%x", iret);
+		return -ENOMEM;
+	}
+
+	EDEB(7, "queue_size=%x, alloc_len=%x, toggle_state=%d",
+	     hw_queue->qe_size,
+	     hw_queue->queue_length, hw_queue->toggle_state);
+
+	for (cnt = 0; cnt < nr_pages; cnt++) {
+		vpage = hw_qpageit_get_inc(hw_queue);
+		if (!vpage) {
+			EDEB_ERR(4, "SQ hw_qpageit_get_inc() "
+				 "failed p_vpage= %p", vpage);
+			goto qp_alloc_register_exit0;
+		}
+		rpage = virt_to_abs(vpage);
+
+		hret = ehea_h_register_rpage_qp(adapter->handle, qp->fw_handle,
+						0, h_call_q_selector, rpage, 1,
+						qp->epas.kernel);
+		if (hret < H_SUCCESS) {
+			EDEB_ERR(4, "ehea_h_register_rpage_qp failed. hret=%lx",
+				 hret);
+			goto qp_alloc_register_exit0;
+		}
+	}
+	hw_qeit_reset(hw_queue);
+
+	return 0;
+
+qp_alloc_register_exit0:
+	hw_queue_dtor(hw_queue);
+	return -EINVAL;
+}
+
+static inline u32 map_wqe_size(u8 wqe_enc_size)
+{
+	return 128 << wqe_enc_size;
+}
+
+struct ehea_qp *ehea_create_qp(struct ehea_adapter *adapter,
+			       u32 pd, struct ehea_qp_init_attr *init_attr)
+{
+	struct ehea_qp *qp;
+	u64 hret = H_HARDWARE;
+
+	u32 wqe_size_in_bytes_sq = 0;
+	u32 wqe_size_in_bytes_rq1 = 0;
+	u32 wqe_size_in_bytes_rq2 = 0;
+	u32 wqe_size_in_bytes_rq3 = 0;
+
+	int ret = -1;
+
+	EDEB_EN(7, "init_attr=%p", init_attr);
+
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+
+	if (!qp) {
+		EDEB_ERR(4, "pd=%X not enough memory to alloc qp", pd);
+		return NULL;
+	}
+	qp->adapter = adapter;
+
+	EDEB(7, "send_ehea_cq->fw_handle=0x%lX"
+	     "recv_ehea_cq->fw_handle=0x%lX", init_attr->send_cq_handle,
+	     init_attr->recv_cq_handle);
+
+
+	hret = ehea_h_alloc_resource_qp(adapter->handle, qp, init_attr, pd,
+					&qp->fw_handle, &qp->epas);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "ehea_h_alloc_resource_qp failed. hret=%lx", hret);
+		goto create_qp_exit1;
+	}
+
+	wqe_size_in_bytes_sq = map_wqe_size(init_attr->act_wqe_size_enc_sq);
+	EDEB(7, "SWQE SG %d", init_attr->wqe_size_enc_sq);
+
+	wqe_size_in_bytes_rq1 = map_wqe_size(init_attr->act_wqe_size_enc_rq1);
+	wqe_size_in_bytes_rq2 = map_wqe_size(init_attr->act_wqe_size_enc_rq2);
+	wqe_size_in_bytes_rq3 = map_wqe_size(init_attr->act_wqe_size_enc_rq3);
+
+	EDEB(7, "SQ pages: %d, SQ WQE size:%d, max SWQE size enc: %d",
+	     init_attr->nr_sq_pages,
+	     wqe_size_in_bytes_sq, init_attr->act_wqe_size_enc_sq);
+
+	EDEB(7, "RQ1 pages: %d, RQ1 WQE size:%d, max RWQE size enc: %d",
+	     init_attr->nr_rq1_pages,
+	     wqe_size_in_bytes_rq1, init_attr->act_wqe_size_enc_rq1);
+
+	EDEB(7, "RQ2 pages: %d, RQ2 WQE size:%d, max RWQE size enc: %d",
+	     init_attr->nr_rq2_pages,
+	     wqe_size_in_bytes_rq2, init_attr->act_wqe_size_enc_rq2);
+
+	EDEB(7, "RQ3 pages: %d, RQ3 WQE size:%d, max RWQE size enc: %d",
+	     init_attr->nr_rq3_pages,
+	     wqe_size_in_bytes_rq3, init_attr->act_wqe_size_enc_rq3);
+
+	ret = ehea_qp_alloc_register(qp,
+				     &qp->hw_squeue,
+				     init_attr->nr_sq_pages,
+				     wqe_size_in_bytes_sq,
+				     init_attr->act_wqe_size_enc_sq, adapter,
+				     0);
+	if (ret < H_SUCCESS) {
+		EDEB_ERR(4, "can't register for sq hret=%x", ret);
+		goto create_qp_exit2;
+	}
+
+	ret = ehea_qp_alloc_register(qp,
+				     &qp->hw_rqueue1,
+				     init_attr->nr_rq1_pages,
+				     wqe_size_in_bytes_rq1,
+				     init_attr->act_wqe_size_enc_rq1,
+				     adapter, 1);
+
+	if (ret < 0) {
+		EDEB_ERR(4, "can't register for rq1 hret=%x", ret);
+		goto create_qp_exit3;
+	}
+
+	if (init_attr->rq_count > 1) {
+		ret = ehea_qp_alloc_register(qp,
+					     &qp->hw_rqueue2,
+					     init_attr->nr_rq2_pages,
+					     wqe_size_in_bytes_rq2,
+					     init_attr->act_wqe_size_enc_rq2,
+					     adapter, 2);
+
+		if (ret < 0) {
+			EDEB_ERR(4, "can't register for rq2 hret=%x", ret);
+			goto create_qp_exit4;
+		}
+	}
+
+	if (init_attr->rq_count > 2) {
+		ret = ehea_qp_alloc_register(qp,
+					     &qp->hw_rqueue3,
+					     init_attr->nr_rq3_pages,
+					     wqe_size_in_bytes_rq3,
+					     init_attr->act_wqe_size_enc_rq3,
+					     adapter, 3);
+
+		if (ret != 0) {
+			EDEB_ERR(4, "can't register for rq3 hret=%x", ret);
+			goto create_qp_exit5;
+		}
+	}
+
+	qp->init_attr = *init_attr;
+
+	EDEB_EX(7, "");
+	return qp;
+
+create_qp_exit5:
+	hw_queue_dtor(&qp->hw_rqueue2);
+
+create_qp_exit4:
+	hw_queue_dtor(&qp->hw_rqueue1);
+
+create_qp_exit3:
+	hw_queue_dtor(&qp->hw_squeue);
+
+create_qp_exit2:
+	hret = ehea_h_destroy_qp(adapter->handle, qp, qp->fw_handle, &qp->epas);
+
+create_qp_exit1:
+	kfree(qp);
+
+	EDEB_EX(7, "hret=NULL");
+	return NULL;
+
+}
+
+int ehea_destroy_qp(struct ehea_qp *qp)
+{
+	int ret = 0;
+	u64 hret = H_HARDWARE;
+	struct ehea_qp_init_attr *qp_attr = &qp->init_attr;
+	EDEB_EX(7, "");
+
+	if (!qp)
+		return 0;
+
+	hret = ehea_h_destroy_qp(qp->adapter->handle, qp, qp->fw_handle,
+				 &qp->epas);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "destroy QP failed!");
+		ret = -EINVAL;
+	}
+
+	hw_queue_dtor(&qp->hw_squeue);
+	hw_queue_dtor(&qp->hw_rqueue1);
+
+   	if(qp_attr->rq_count > 1)
+		hw_queue_dtor(&qp->hw_rqueue2);
+   	if(qp_attr->rq_count > 2)
+		hw_queue_dtor(&qp->hw_rqueue3);
+	kfree(qp);
+
+	EDEB_EX(7, "hret=%lx", hret);
+
+	return ret;
+}
+
+int ehea_reg_mr_adapter(struct ehea_adapter *adapter)
+{
+	int i = 0;
+	int k = 0;
+	u64 hret = H_HARDWARE;
+	u64 start = KERNELBASE;
+	u64 end = (u64) high_memory;
+	u64 nr_pages = (end - start) / PAGE_SIZE;
+	u32 acc_ctrl = EHEA_MR_ACC_CTRL;
+	u64 pt_abs = 0;
+	u64 *pt;
+
+	EDEB_EN(7, "adapter=%p", adapter);
+	pt =  kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!pt) {
+		EDEB_ERR(4, "allocating page failed");
+		return -EINVAL;
+	}
+	pt_abs = virt_to_abs(pt);
+
+	hret = ehea_h_alloc_resource_mr(adapter->handle,
+					start,
+					end - start,
+					acc_ctrl,
+					adapter->pd,
+					&adapter->mr.handle,
+					&adapter->mr.lkey);
+	if (hret != H_SUCCESS) {
+		EDEB_EX(4, "Error: hret=%lX\n", hret);
+		return -EINVAL;
+	}
+
+	adapter->mr.vaddr = KERNELBASE;
+
+	while (nr_pages > 0) {
+		if (nr_pages > 1) {
+			u64 num_pages = min(nr_pages, (u64)512);
+			for (i = 0; i < num_pages; i++)
+				pt[i] = virt_to_abs((void *)(((u64)start)
+							     + ((k++) *
+								PAGE_SIZE)));
+
+			hret = ehea_h_register_rpage_mr(adapter->handle,
+							adapter->mr.handle, 0,
+							0, (u64)pt_abs,
+							num_pages);
+			nr_pages -= num_pages;
+		} else {
+			u64 abs_adr = virt_to_abs((void *)(((u64)start)
+							   + (k * PAGE_SIZE)));
+			hret = ehea_h_register_rpage_mr(adapter->handle,
+							adapter->mr.handle, 0,
+							0, abs_adr,1);
+			nr_pages--;
+		}
+
+		if ((hret != H_SUCCESS) && (hret != H_PAGE_REGISTERED)) {
+			ehea_h_free_resource_mr(adapter->handle,
+						adapter->mr.handle);
+			EDEB_EX(4, " register rpage_mr: hret=%lX\n", hret);
+			return -EINVAL;
+		}
+	}
+
+	if (hret != H_SUCCESS) {
+		ehea_h_free_resource_mr(adapter->handle, adapter->mr.handle);
+		EDEB_EX(4, " register rpage_mr failed for last page: hret=%lX",
+			hret);
+		return -EINVAL;
+	}
+
+	EDEB_EX(7, "lkey=0x%X, mr_handle=0x%lX", adapter->mr.lkey,
+		adapter->mr.handle);
+	return 0;
+}
+
+int ehea_reg_mr_pages(struct ehea_adapter *adapter,
+		      struct ehea_mr *mr,
+		      u64 start, u64 *pt, int nr_pages)
+{
+	u64 hret = H_HARDWARE;
+	u32 acc_ctrl = EHEA_MR_ACC_CTRL;
+
+	u64 pt_abs = virt_to_abs(pt);
+	u64 first_page = pt[0];
+
+	hret = ehea_h_alloc_resource_mr(adapter->handle,
+					start,
+					PAGE_SIZE * nr_pages,
+					acc_ctrl,
+					adapter->pd,
+					&mr->handle,
+					&mr->lkey);
+	if (hret != H_SUCCESS) {
+		EDEB_EX(4, "Error: hret=%lX\n", hret);
+		return -EINVAL;
+	}
+
+	if (nr_pages > 1)
+		hret = ehea_h_register_rpage_mr(adapter->handle,
+						mr->handle, 0, 0, (u64)pt_abs,
+						nr_pages);
+	else
+		hret = ehea_h_register_rpage_mr(adapter->handle,
+						mr->handle, 0, 0, first_page,
+						1);
+
+	if (hret != H_SUCCESS) {
+		ehea_h_free_resource_mr(adapter->handle, mr->handle);
+		EDEB_EX(4, " register rpage_mr failed for last page:"
+			"hret=%lX\n", hret);
+		return -EINVAL;
+	}
+	mr->vaddr = start;
+
+	EDEB_EX(7, "");
+	return 0;
+}
+
+
+
+int ehea_dereg_mr_adapter(struct ehea_adapter *adapter)
+{
+	u64 hret = H_HARDWARE;
+	EDEB_EN(7, "adapter=%p", adapter);
+	hret = ehea_h_free_resource_mr(adapter->handle, adapter->mr.handle);
+	if (hret != H_SUCCESS) {
+		EDEB_EX(4, "deregistering memory region failed");
+		return -EINVAL;
+	}
+	EDEB_EX(7, "");
+	return 0;
+}
--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_qmr.h	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_qmr.h	2006-08-14 09:05:13.905551232 -0700
@@ -0,0 +1,392 @@
+/*
+ *  linux/drivers/net/ehea/ehea_qmr.h
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Heiko-Joerg Schick <schickhj@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __EHEA_QMR_H__
+#define __EHEA_QMR_H__
+
+#include "ehea.h"
+#include "ehea_hw.h"
+
+
+/* Some abbreviations used here:
+ *
+ * WQE  - Work Queue Entry
+ * SWQE - Send Work Queue Entry
+ * RWQE - Receive Work Queue Entry
+ * CQE  - Completion Queue Entry
+ * EQE  - Event Queue Entry
+ * MR   - Memory Region
+ */
+
+/* Use of WR_ID field for EHEA */
+#define EHEA_WR_ID_COUNT   EHEA_BMASK_IBM(0, 19)
+#define EHEA_WR_ID_TYPE    EHEA_BMASK_IBM(20, 23)
+#define EHEA_SWQE2_TYPE    0x1
+#define EHEA_SWQE3_TYPE    0x2
+#define EHEA_RWQE2_TYPE    0x3	
+#define EHEA_RWQE3_TYPE    0x4	
+#define EHEA_WR_ID_INDEX   EHEA_BMASK_IBM(24, 47)
+#define EHEA_WR_ID_REFILL  EHEA_BMASK_IBM(48, 63)
+
+struct ehea_vsgentry {
+	u64 vaddr;
+	u32 l_key;
+	u32 len;
+};
+
+/* maximum number of sg entries allowed in a WQE */
+#define EHEA_MAX_WQE_SG_ENTRIES  	252
+#define SWQE2_MAX_IMM            	(0xD0 - 0x30)
+#define SWQE3_MAX_IMM            	224
+
+/* tx control flags for swqe */
+#define EHEA_SWQE_CRC                   0x8000
+#define EHEA_SWQE_IP_CHECKSUM           0x4000
+#define EHEA_SWQE_TCP_CHECKSUM          0x2000
+#define EHEA_SWQE_TSO                   0x1000
+#define EHEA_SWQE_SIGNALLED_COMPLETION  0x0800
+#define EHEA_SWQE_VLAN_INSERT           0x0400
+#define EHEA_SWQE_IMM_DATA_PRESENT      0x0200
+#define EHEA_SWQE_DESCRIPTORS_PRESENT   0x0100
+#define EHEA_SWQE_WRAP_CTL_REC          0x0080
+#define EHEA_SWQE_WRAP_CTL_FORCE        0x0040
+#define EHEA_SWQE_BIND                  0x0020
+#define EHEA_SWQE_PURGE                 0x0010
+
+#define SWQE_HEADER_SIZE		32
+
+struct ehea_swqe {
+	u64 wr_id;
+	u16 tx_control;
+	u16 vlan_tag;
+	u8 reserved1;
+	u8 ip_start;
+	u8 ip_end;
+	u8 immediate_data_length;
+	u8 tcp_offset;
+	u8 reserved2;
+	u16 tcp_end;
+	u8 wrap_tag;
+	u8 descriptors;		/* number of valid descriptors in WQE */
+	u16 reserved3;
+	u16 reserved4;
+	u16 mss;
+	u32 reserved5;
+	union {
+		/*  Send WQE Format 1 */
+		struct {
+			struct ehea_vsgentry sg_list[EHEA_MAX_WQE_SG_ENTRIES];
+		} no_immediate_data;
+
+		/*  Send WQE Format 2 */
+		struct {
+			struct ehea_vsgentry sg_entry;
+			/* 0x30 */
+			u8 immediate_data[SWQE2_MAX_IMM];
+			/* 0xd0 */
+			struct ehea_vsgentry sg_list[EHEA_MAX_WQE_SG_ENTRIES-1];
+		} immdata_desc __attribute__ ((packed));
+
+		/*  Send WQE Format 3 */
+		struct {
+			u8 immediate_data[SWQE3_MAX_IMM];
+		} immdata_nodesc;
+	} u;
+};
+
+struct ehea_rwqe {
+	u64 wr_id;		/* work request ID */
+	u8 reserved1[5];
+	u8 data_segments;
+	u16 reserved2;
+	u64 reserved3;
+	u64 reserved4;
+	struct ehea_vsgentry sg_list[EHEA_MAX_WQE_SG_ENTRIES];
+};
+
+#define EHEA_CQE_VLAN_TAG_XTRACT  0x0400
+
+#define EHEA_CQE_TYPE_RQ          0x60
+#define EHEA_CQE_STAT_ERR_MASK    0x7300
+#define EHEA_CQE_STAT_ERR_TCP     0x4000
+
+struct ehea_cqe {
+	u64 wr_id;		/* work request ID from WQE */
+	u8 type;
+	u8 valid;
+	u16 status;
+	u16 reserved1;
+	u16 num_bytes_transfered;
+	u16 vlan_tag;
+	u16 inet_checksum_value;
+	u8 reserved2;
+	u8 header_length;
+	u16 reserved3;
+	u16 page_offset;
+	u16 wqe_count;
+	u32 qp_token;
+	u32 timestamp;
+	u32 reserved4;
+	u64 reserved5[3];
+};
+
+#define EHEA_EQE_VALID           EHEA_BMASK_IBM(0, 0)
+#define EHEA_EQE_IS_CQE          EHEA_BMASK_IBM(1, 1)
+#define EHEA_EQE_IDENTIFIER      EHEA_BMASK_IBM(2, 7)
+#define EHEA_EQE_QP_CQ_NUMBER    EHEA_BMASK_IBM(8, 31)
+#define EHEA_EQE_QP_TOKEN        EHEA_BMASK_IBM(32, 63)
+#define EHEA_EQE_CQ_TOKEN        EHEA_BMASK_IBM(32, 63)
+#define EHEA_EQE_KEY             EHEA_BMASK_IBM(32, 63)
+#define EHEA_EQE_PORT_NUMBER     EHEA_BMASK_IBM(56, 63)
+#define EHEA_EQE_EQ_NUMBER       EHEA_BMASK_IBM(48, 63)
+#define EHEA_EQE_SM_ID           EHEA_BMASK_IBM(48, 63)
+#define EHEA_EQE_SM_MECH_NUMBER  EHEA_BMASK_IBM(48, 55)
+#define EHEA_EQE_SM_PORT_NUMBER  EHEA_BMASK_IBM(56, 63)
+
+struct ehea_eqe {
+	u64 entry;
+};
+
+static inline void *hw_qeit_calc(struct hw_queue *queue, u64 q_offset)
+{
+	struct ehea_page *current_page = NULL;
+	if (q_offset >= queue->queue_length)
+		q_offset -= queue->queue_length;
+	current_page = (queue->queue_pages)[q_offset >> EHEA_PAGESHIFT];
+	return &current_page->entries[q_offset & (EHEA_PAGESIZE - 1)];
+}
+
+static inline void *hw_qeit_get(struct hw_queue *queue)
+{
+	return hw_qeit_calc(queue, queue->current_q_offset);
+}
+
+static inline void hw_qeit_inc(struct hw_queue *queue)
+{
+	queue->current_q_offset += queue->qe_size;
+	if (queue->current_q_offset >= queue->queue_length) {
+		queue->current_q_offset = 0;
+		/* toggle the valid flag */
+		queue->toggle_state = (~queue->toggle_state) & 1;
+	}
+}
+
+static inline void *hw_qeit_get_inc(struct hw_queue *queue)
+{
+	void *retvalue = hw_qeit_get(queue);
+	hw_qeit_inc(queue);
+	EDEB(8, "queue=%p retvalue=%p new current_q_addr=%lx qe_size=%x",
+	     queue, retvalue, queue->current_q_offset, queue->qe_size);
+
+	return retvalue;
+}
+
+static inline void *hw_qeit_get_inc_valid(struct hw_queue *queue)
+{
+	struct ehea_cqe *retvalue = hw_qeit_get(queue);
+	void *pref;
+	u8 valid = retvalue->valid;
+	if ((valid >> 7) == (queue->toggle_state & 1)) {
+		/* this is a good one */
+		hw_qeit_inc(queue);
+		pref = hw_qeit_calc(queue, queue->current_q_offset);
+		prefetch(pref);
+		prefetch(pref + 128);
+	} else
+		retvalue = NULL;
+	return retvalue;
+}
+
+static inline void *hw_qeit_get_valid(struct hw_queue *queue)
+{
+	u8 valid = 0;
+
+	struct ehea_cqe *retvalue = hw_qeit_get(queue);
+	void *pref;
+	pref = hw_qeit_calc(queue, queue->current_q_offset);
+	prefetch(pref);
+	prefetch(pref + 128);
+	prefetch(pref + 256);
+	valid = retvalue->valid;
+	if (!((valid >> 7) == (queue->toggle_state & 1)))
+		retvalue = NULL;
+	return retvalue;
+}
+
+static inline void *hw_qeit_reset(struct hw_queue *queue)
+{
+	queue->current_q_offset = 0;
+	return hw_qeit_get(queue);
+}
+
+static inline void *hw_qeit_eq_get_inc(struct hw_queue *queue)
+{
+	void *retvalue = NULL;
+	u64 last_entry_in_q = queue->queue_length - queue->qe_size;
+
+	retvalue = hw_qeit_get(queue);
+	queue->current_q_offset += queue->qe_size;
+	if (queue->current_q_offset > last_entry_in_q) {
+		queue->current_q_offset = 0;
+		queue->toggle_state = (~queue->toggle_state) & 1;
+	}
+
+	EDEB(7, "queue=%p retvalue=%p new current_q_offset=%lx qe_size=%x",
+	     queue, retvalue, queue->current_q_offset, queue->qe_size);
+
+	return retvalue;
+}
+
+static inline void *hw_eqit_eq_get_inc_valid(struct hw_queue *queue)
+{
+	void *retvalue = hw_qeit_get(queue);
+	u32 qe = *(u8 *) retvalue;
+	EDEB(7, "hw_eqit_eq_get_inc_valid qe=%x", qe);
+	if ((qe >> 7) == (queue->toggle_state & 1))
+		hw_qeit_eq_get_inc(queue);
+	else
+		retvalue = NULL;
+	return retvalue;
+}
+
+static inline struct ehea_rwqe *ehea_get_next_rwqe(struct ehea_qp *qp,
+						   int rq_nr)
+{
+
+	struct ehea_rwqe *wqe_p = NULL;
+	struct hw_queue *queue = NULL;
+	struct ehea_qp *my_qp = qp;
+	EDEB_EN(8, "QP=%p, RQ_nr=%d", qp, rq_nr);
+
+	if (rq_nr == 1)
+		queue = &my_qp->hw_rqueue1;
+	else if (rq_nr == 2)
+		queue = &my_qp->hw_rqueue2;
+	else
+		queue = &my_qp->hw_rqueue3;
+	wqe_p = (struct ehea_rwqe *)hw_qeit_get_inc(queue);
+
+	EDEB_EX(8, "&RWQE=%p, queue=%p", wqe_p, queue);
+	return wqe_p;
+}
+
+static inline struct ehea_swqe *ehea_get_swqe(struct ehea_qp *my_qp,
+					      int *wqe_index)
+{
+	struct hw_queue *queue = &my_qp->hw_squeue;
+	struct ehea_swqe *wqe_p = NULL;
+	EDEB_EN(7, "QP=%p, queue=%p", my_qp, &my_qp->hw_squeue);
+	*wqe_index = (queue->current_q_offset) >> (7 + EHEA_SG_SQ);
+	wqe_p = (struct ehea_swqe *)hw_qeit_get_inc(&my_qp->hw_squeue);
+	EDEB_EX(7, "");
+	return wqe_p;
+}
+
+static inline void ehea_post_swqe(struct ehea_qp *my_qp, struct ehea_swqe *swqe)
+{
+
+	EDEB_EN(7, "QP=%p, SWQE=%p", my_qp, swqe);
+	EDEB(6, "SWQE workreqid = 0x%lX, imm_data_len=%d, descriptors=%d",
+	     (u64) swqe->wr_id, swqe->immediate_data_length, swqe->descriptors);
+	iosync();
+	ehea_update_sqa(my_qp, 1);
+	EDEB_EX(7, "");
+}
+
+static inline struct ehea_cqe *ehea_poll_rq1(struct ehea_qp *qp, int *wqe_index)
+{
+	struct hw_queue *queue = &qp->hw_rqueue1;
+	struct ehea_cqe *cqe = NULL;
+
+	EDEB_EN(7, "QP=%p, RQ1 toggle state = %d, current_q_offset=%lx", qp,
+		queue->toggle_state, queue->current_q_offset);
+	*wqe_index = (queue->current_q_offset) >> (7 + EHEA_SG_RQ1);
+	cqe = (struct ehea_cqe *)hw_qeit_get_valid(queue);
+	EDEB_EX(7, "cqe=%p, new toggle state %d, wqe_index = %d",
+		cqe, queue->toggle_state, *wqe_index);
+	return cqe;
+}
+
+static inline void ehea_inc_rq1(struct ehea_qp *qp)
+{
+	struct hw_queue *queue = &qp->hw_rqueue1;
+	hw_qeit_inc(queue);
+}
+
+static inline struct ehea_cqe *ehea_poll_cq(struct ehea_cq *my_cq)
+{
+
+	struct ehea_cqe *wqe_p = NULL;
+	EDEB_EN(7, "CQ=%p", my_cq);
+
+	EDEB(7, "queue_element_size=%x, alloc_len=%x, queue=%p",
+	     my_cq->hw_queue.qe_size,
+	     my_cq->hw_queue.queue_length, &my_cq->hw_queue);
+	wqe_p = (struct ehea_cqe *)hw_qeit_get_inc_valid(&my_cq->hw_queue);
+
+	EDEB_EX(7, "wqe_p=%p", wqe_p);
+	return wqe_p;
+};
+
+#define EHEA_CQ_REGISTER_ORIG 0
+#define EHEA_EQ_REGISTER_ORIG 0
+
+enum ehea_eq_type {
+	EHEA_EQ = 0,		/* event queue              */
+	EHEA_NEQ		/* notification event queue */
+};
+
+struct ehea_eq *ehea_create_eq(struct ehea_adapter *adapter,
+			       enum ehea_eq_type type,
+			       const u32 length, const u8 eqe_gen);
+
+int ehea_destroy_eq(struct ehea_eq *eq);
+
+struct ehea_eqe *ehea_poll_eq(struct ehea_eq *eq);
+
+struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter, int cqe,
+			       u64 eq_handle, u32 cq_token);
+
+int ehea_destroy_cq(struct ehea_cq *cq);
+
+
+struct ehea_qp *ehea_create_qp(struct ehea_adapter * adapter,
+			       u32 pd,
+			       struct ehea_qp_init_attr *init_attr);
+
+int ehea_destroy_qp(struct ehea_qp *qp);
+
+int ehea_reg_mr_adapter(struct ehea_adapter *adapter);
+int ehea_dereg_mr_adapter(struct ehea_adapter *adapter);
+
+int ehea_reg_mr_pages(struct ehea_adapter *adapter,
+		      struct ehea_mr *mr,
+		      u64 start, u64 *pt, int nr_pages);
+
+#endif	/* __EHEA_QMR_H__ */


