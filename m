Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWD0Kvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWD0Kvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWD0KtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:49:17 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:64426 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965097AbWD0Ks5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:48:57 -0400
Message-ID: <4450A1B3.5000100@de.ibm.com>
Date: Thu, 27 Apr 2006 12:49:23 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 11/16] ehca: completion queue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  ehca_cq.c |  445 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 445 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_cq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_cq.c	2006-04-24 15:12:03.000000000 +0200
@@ -0,0 +1,445 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Completion queue handling
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Khadija Souissi <souissi@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
+ *           Heiko J Schick <schickhj@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_cq.c,v 1.24 2006/04/24 13:12:03 schickhj Exp $
+ */
+
+#define DEB_PREFIX "e_cq"
+
+#include <asm/current.h>
+
+#include "ehca_kernel.h"
+#include "ehca_iverbs.h"
+#include "ehca_classes.h"
+#include "ehca_irq.h"
+#include "hcp_if.h"
+
+int ehca_cq_assign_qp(struct ehca_cq *cq, struct ehca_qp *qp)
+{
+	unsigned int qp_num = qp->real_qp_num;
+	unsigned int key = qp_num & (QP_HASHTAB_LEN-1);
+	unsigned long spl_flags = 0;
+
+	spin_lock_irqsave(&cq->spinlock, spl_flags);
+	hlist_add_head(&qp->list_entries, &cq->qp_hashtab[key]);
+	spin_unlock_irqrestore(&cq->spinlock, spl_flags);
+
+	EDEB(7, "cq_num=%x real_qp_num=%x", cq->cq_number, qp_num);
+
+	return 0;
+}
+
+int ehca_cq_unassign_qp(struct ehca_cq *cq, unsigned int real_qp_num)
+{
+	int ret = -EINVAL;
+	unsigned int key = real_qp_num & (QP_HASHTAB_LEN-1);
+	struct hlist_node *iter = NULL;
+	struct ehca_qp *qp = NULL;
+	unsigned long spl_flags = 0;
+
+	spin_lock_irqsave(&cq->spinlock, spl_flags);
+	hlist_for_each(iter, &cq->qp_hashtab[key]) {
+		qp = hlist_entry(iter, struct ehca_qp, list_entries);
+		if (qp->real_qp_num == real_qp_num) {
+			hlist_del(iter);
+			EDEB(7, "removed qp from cq .cq_num=%x real_qp_num=%x",
+			     cq->cq_number, real_qp_num);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&cq->spinlock, spl_flags);
+	if (ret!=0) {
+		EDEB_ERR(4, "qp not found cq_num=%x real_qp_num=%x",
+			 cq->cq_number, real_qp_num);
+	}
+
+	return ret;
+}
+
+struct ehca_qp* ehca_cq_get_qp(struct ehca_cq *cq, int real_qp_num)
+{
+	struct ehca_qp *ret = NULL;
+	unsigned int key = real_qp_num & (QP_HASHTAB_LEN-1);
+	struct hlist_node *iter = NULL;
+	struct ehca_qp *qp = NULL;
+	hlist_for_each(iter, &cq->qp_hashtab[key]) {
+		qp = hlist_entry(iter, struct ehca_qp, list_entries);
+		if (qp->real_qp_num == real_qp_num) {
+			ret = qp;
+			break;
+		}
+	}
+	return ret;
+}
+
+struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe,
+			     struct ib_ucontext *context,
+			     struct ib_udata *udata)
+{
+	extern struct ehca_module ehca_module;
+	struct ib_cq *cq = NULL;
+	struct ehca_cq *my_cq = NULL;
+	u32 number_of_entries = cqe;
+	struct ehca_shca *shca = NULL;
+	struct ipz_adapter_handle adapter_handle;
+	struct ipz_eq_handle eq_handle;
+	struct ipz_cq_handle *cq_handle_ref = NULL;
+	u32 act_nr_of_entries = 0;
+	u32 act_pages = 0;
+	u32 counter = 0;
+	void *vpage = NULL;
+	u64 rpage = 0;
+	struct h_galpa gal;
+	u64 cqx_fec = 0;
+	u64 hipz_rc = H_SUCCESS;
+	int ipz_rc = 0;
+	int ret = 0;
+	const u32 additional_cqe=20;
+	int i= 0;
+	unsigned long flags;
+
+	EHCA_CHECK_DEVICE_P(device);
+	EDEB_EN(7,  "device=%p cqe=%x context=%p", device, cqe, context);
+
+	/* CQs maximum depth is 4GB-64, but we need additional 20 as buffer
+         * for receiving errors CQEs.
+	 */
+	if (cqe >= 0xFFFFFFFF - 64 - additional_cqe)
+		return ERR_PTR(-EINVAL);
+	number_of_entries += additional_cqe;
+
+	my_cq = kmem_cache_alloc(ehca_module.cache_cq, SLAB_KERNEL);
+	if (my_cq == NULL) {
+		cq = ERR_PTR(-ENOMEM);
+		EDEB_ERR(4, "Out of memory for ehca_cq struct device=%p",
+			 device);
+		goto create_cq_exit0;
+	}
+
+	memset(my_cq, 0, sizeof(struct ehca_cq));
+	spin_lock_init(&my_cq->spinlock);
+	spin_lock_init(&my_cq->cb_lock);
+	spin_lock_init(&my_cq->task_lock);
+	my_cq->ownpid = current->tgid;
+
+	cq = &my_cq->ib_cq;
+
+	shca = container_of(device, struct ehca_shca, ib_device);
+	adapter_handle = shca->ipz_hca_handle;
+	eq_handle = shca->eq.ipz_eq_handle;
+	cq_handle_ref = &my_cq->ipz_cq_handle;
+
+	do {
+		if (!idr_pre_get(&ehca_cq_idr, GFP_KERNEL)) {
+			cq = ERR_PTR(-ENOMEM);
+			EDEB_ERR(4,
+				 "Can't reserve idr resources. "
+				 "device=%p", device);
+			goto create_cq_exit1;
+		}
+
+		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+		ret = idr_get_new(&ehca_cq_idr, my_cq, &my_cq->token);
+		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
+
+	} while (ret == -EAGAIN);
+
+	if (ret) {
+		cq = ERR_PTR(-ENOMEM);
+		EDEB_ERR(4,
+			 "Can't allocate new idr entry. "
+			 "device=%p", device);
+		goto create_cq_exit1;
+	}
+
+	hipz_rc = hipz_h_alloc_resource_cq(adapter_handle,
+					   &my_cq->pf,
+					   eq_handle,
+					   my_cq->token,
+					   number_of_entries,
+					   cq_handle_ref,
+					   &act_nr_of_entries,
+					   &act_pages,
+					   &my_cq->galpas);
+	if (hipz_rc != H_SUCCESS) {
+		EDEB_ERR(4,
+			 "hipz_h_alloc_resource_cq() failed "
+			 "hipz_rc=%lx device=%p", hipz_rc, device);
+		cq = ERR_PTR(ehca2ib_return_code(hipz_rc));
+		goto create_cq_exit2;
+	}
+
+	ipz_rc = ipz_queue_ctor(&my_cq->ipz_queue, act_pages,
+				EHCA_PAGESIZE, sizeof(struct ehca_cqe), 0);
+	if (!ipz_rc) {
+		EDEB_ERR(4,
+			 "ipz_queue_ctor() failed "
+			 "ipz_rc=%x device=%p", ipz_rc, device);
+		cq = ERR_PTR(-EINVAL);
+		goto create_cq_exit3;
+	}
+
+	for (counter = 0; counter < act_pages; counter++) {
+		vpage = ipz_qpageit_get_inc(&my_cq->ipz_queue);
+		if (!vpage) {
+			EDEB_ERR(4, "ipz_qpageit_get_inc() "
+				 "returns NULL device=%p", device);
+			cq = ERR_PTR(-EAGAIN);
+			goto create_cq_exit4;
+		}
+		rpage = virt_to_abs(vpage);
+
+		hipz_rc = hipz_h_register_rpage_cq(adapter_handle,
+						   my_cq->ipz_cq_handle,
+						   &my_cq->pf,
+						   0,
+						   0,
+						   rpage,
+						   1,
+						   my_cq->galpas.
+						   kernel);
+
+		if (hipz_rc < H_SUCCESS) {
+			EDEB_ERR(4, "hipz_h_register_rpage_cq() failed "
+				 "ehca_cq=%p cq_num=%x hipz_rc=%lx "
+				 "counter=%i act_pages=%i",
+				 my_cq, my_cq->cq_number,
+				 hipz_rc, counter, act_pages);
+			cq = ERR_PTR(-EINVAL);
+			goto create_cq_exit4;
+		}
+
+		if (counter == (act_pages - 1)) {
+			vpage = ipz_qpageit_get_inc(
+				&my_cq->ipz_queue);
+			if ((hipz_rc != H_SUCCESS) || (vpage != 0)) {
+				EDEB_ERR(4, "Registration of pages not "
+					 "complete ehca_cq=%p cq_num=%x "
+					 "hipz_rc=%lx",
+					 my_cq, my_cq->cq_number, hipz_rc);
+				cq = ERR_PTR(-EAGAIN);
+				goto create_cq_exit4;
+			}
+		} else {
+			if (hipz_rc != H_PAGE_REGISTERED) {
+				EDEB_ERR(4, "Registration of page failed "
+					 "ehca_cq=%p cq_num=%x hipz_rc=%lx"
+					 "counter=%i act_pages=%i",
+					 my_cq, my_cq->cq_number,
+					 hipz_rc, counter, act_pages);
+				cq = ERR_PTR(-ENOMEM);
+				goto create_cq_exit4;
+			}
+		}
+	}
+
+	ipz_qeit_reset(&my_cq->ipz_queue);
+
+	gal = my_cq->galpas.kernel;
+	cqx_fec = hipz_galpa_load(gal, CQTEMM_OFFSET(cqx_fec));
+	EDEB(8, "ehca_cq=%p cq_num=%x CQX_FEC=%lx",
+	     my_cq, my_cq->cq_number, cqx_fec);
+
+	my_cq->ib_cq.cqe = my_cq->nr_of_entries =
+		act_nr_of_entries-additional_cqe;
+	my_cq->cq_number = (my_cq->ipz_cq_handle.handle) & 0xffff;
+
+	for (i = 0; i < QP_HASHTAB_LEN; i++)
+		INIT_HLIST_HEAD(&my_cq->qp_hashtab[i]);
+
+	if (context) {
+		struct ipz_queue *ipz_queue = &my_cq->ipz_queue;
+		struct ehca_create_cq_resp resp;
+		struct vm_area_struct *vma = NULL;
+		memset(&resp, 0, sizeof(resp));
+		resp.cq_number = my_cq->cq_number;
+		resp.token = my_cq->token;
+		resp.ipz_queue.qe_size = ipz_queue->qe_size;
+		resp.ipz_queue.act_nr_of_sg = ipz_queue->act_nr_of_sg;
+		resp.ipz_queue.queue_length = ipz_queue->queue_length;
+		resp.ipz_queue.pagesize = ipz_queue->pagesize;
+		resp.ipz_queue.toggle_state = ipz_queue->toggle_state;
+		ehca_mmap_nopage(((u64) (my_cq->token) << 32) | 0x12000000,
+				 ipz_queue->queue_length,
+				 ((void**)&resp.ipz_queue.queue),
+				 &vma);
+		my_cq->uspace_queue = resp.ipz_queue.queue;
+		resp.galpas = my_cq->galpas;
+		ehca_mmap_register(my_cq->galpas.user.fw_handle,
+				   ((void**)&resp.galpas.kernel.fw_handle),
+				   &vma);
+		my_cq->uspace_fwh = (u64)resp.galpas.kernel.fw_handle;
+		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
+			EDEB_ERR(4,  "Copy to udata failed.");
+			goto create_cq_exit4;
+		}
+	}
+
+	EDEB_EX(7,"retcode=%p ehca_cq=%p cq_num=%x cq_size=%x",
+		cq, my_cq, my_cq->cq_number, act_nr_of_entries);
+	return cq;
+
+create_cq_exit4:
+	ipz_queue_dtor(&my_cq->ipz_queue);
+
+create_cq_exit3:
+	hipz_rc = hipz_h_destroy_cq(adapter_handle, my_cq, 1);
+	EDEB(3, "hipz_h_destroy_cq() failed ehca_cq=%p cq_num=%x hipz_rc=%lx",
+	     my_cq, my_cq->cq_number, hipz_rc);
+
+create_cq_exit2:
+	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+	idr_remove(&ehca_cq_idr, my_cq->token);
+	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
+
+create_cq_exit1:
+	kmem_cache_free(ehca_module.cache_cq, my_cq);
+
+create_cq_exit0:
+	EDEB_EX(7,  "An error has occured retcode=%p ", cq);
+	return cq;
+}
+
+int ehca_destroy_cq(struct ib_cq *cq)
+{
+	extern struct ehca_module ehca_module;
+	u64 hipz_rc = H_SUCCESS;
+	int retcode = 0;
+	struct ehca_cq *my_cq = NULL;
+	int cq_num = 0;
+	struct ib_device *device = NULL;
+	struct ehca_shca *shca = NULL;
+	struct ipz_adapter_handle adapter_handle;
+	u32 cur_pid = current->tgid;
+	unsigned long flags;
+
+	EHCA_CHECK_CQ(cq);
+	my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	cq_num = my_cq->cq_number;
+	device = cq->device;
+	EHCA_CHECK_DEVICE(device);
+	shca = container_of(device, struct ehca_shca, ib_device);
+	adapter_handle = shca->ipz_hca_handle;
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x",
+		my_cq, my_cq->cq_number);
+
+	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+	while (my_cq->nr_callbacks != 0)
+		yield();
+
+        idr_remove(&ehca_cq_idr, my_cq->token);
+        spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
+
+        if (my_cq->uspace_queue!=0 && my_cq->ownpid!=cur_pid) {
+                EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+                         cur_pid, my_cq->ownpid);
+                return -EINVAL;
+        }
+
+	/* un-mmap if vma alloc */
+	if (my_cq->uspace_queue!=0) {
+		retcode = ehca_munmap(my_cq->uspace_queue,
+				      my_cq->ipz_queue.queue_length);
+		retcode = ehca_munmap(my_cq->uspace_fwh, 4096);
+	}
+
+	hipz_rc = hipz_h_destroy_cq(adapter_handle, my_cq, 0);
+	if (hipz_rc == H_R_STATE) {
+		/* cq in err: read err data and destroy it forcibly */
+		EDEB(4, "ehca_cq=%p cq_num=%x ressource=%lx in err state. "
+		     "Try to delete it forcibly.",
+		     my_cq, my_cq->cq_number, my_cq->ipz_cq_handle.handle);
+		ehca_error_data(shca, my_cq, my_cq->ipz_cq_handle.handle);
+		hipz_rc = hipz_h_destroy_cq(adapter_handle, my_cq, 1);
+		if (hipz_rc == H_SUCCESS) {
+			EDEB(4, "ehca_cq=%p cq_num=%x deleted successfully.",
+			     my_cq, my_cq->cq_number);
+		}
+	}
+	if (hipz_rc != H_SUCCESS) {
+		EDEB_ERR(4,"hipz_h_destroy_cq() failed "
+			 "hipz_rc=%lx ehca_cq=%p cq_num=%x",
+			 hipz_rc, my_cq, my_cq->cq_number);
+		retcode = ehca2ib_return_code(hipz_rc);
+		goto destroy_cq_exit0;
+	}
+	ipz_queue_dtor(&my_cq->ipz_queue);
+	kmem_cache_free(ehca_module.cache_cq, my_cq);
+
+destroy_cq_exit0:
+	EDEB_EX(7, "ehca_cq=%p cq_num=%x retcode=%x ",
+		my_cq, cq_num, retcode);
+	return retcode;
+}
+
+int ehca_resize_cq(struct ib_cq *cq, int cqe, struct ib_udata *udata)
+{
+	int retcode = 0;
+	struct ehca_cq *my_cq = NULL;
+	u32 cur_pid = current->tgid;
+
+	if (unlikely(NULL == cq)) {
+		EDEB_ERR(4, "cq is NULL");
+		return -EFAULT;
+	}
+
+	my_cq = container_of(cq, struct ehca_cq, ib_cq);
+	EDEB_EN(7, "ehca_cq=%p cq_num=%x",
+		my_cq, my_cq->cq_number);
+
+        if (my_cq->uspace_queue!=0 && my_cq->ownpid!=cur_pid) {
+                EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+                         cur_pid, my_cq->ownpid);
+                return -EINVAL;
+        }
+
+	/* TODO: proper resize needs to be done */
+	retcode = -EFAULT;
+	EDEB_ERR(4, "not implemented yet");
+
+	EDEB_EX(7, "ehca_cq=%p cq_num=%x",
+		my_cq, my_cq->cq_number);
+	return retcode;
+}



