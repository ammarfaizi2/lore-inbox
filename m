Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWCJAgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWCJAgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWCJAgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:05 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16526 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752160AbWCJAfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:51 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 20] ipath - misc infiniband code, part 1
X-Mercurial-Node: 44cd07539d66a6382882e4ee4d3572272dacf0b3
Message-Id: <44cd07539d66a6382882.1141950945@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:45 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Completion queues, local and remote memory keys, and memory region
support.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 70e3edb0d82d -r 44cd07539d66 drivers/infiniband/hw/ipath/ipath_cq.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Mar  9 16:16:44 2006 -0800
@@ -0,0 +1,277 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+
+#include "ipath_verbs.h"
+
+/**
+ * ipath_cq_enter - add a new entry to the completion queue
+ * @cq: completion queue
+ * @entry: work completion entry to add
+ * @sig: true if @entry is a solicitated entry
+ *
+ * This may be called with one of the qp->s_lock or qp->r_rq.lock held.
+ */
+void ipath_cq_enter(struct ipath_cq *cq, struct ib_wc *entry, int solicited)
+{
+	unsigned long flags;
+	u32 next;
+
+	spin_lock_irqsave(&cq->lock, flags);
+
+	if (cq->head == cq->ibcq.cqe)
+		next = 0;
+	else
+		next = cq->head + 1;
+	if (unlikely(next == cq->tail)) {
+		spin_unlock_irqrestore(&cq->lock, flags);
+		if (cq->ibcq.event_handler) {
+			struct ib_event ev;
+
+			ev.device = cq->ibcq.device;
+			ev.element.cq = &cq->ibcq;
+			ev.event = IB_EVENT_CQ_ERR;
+			cq->ibcq.event_handler(&ev, cq->ibcq.cq_context);
+		}
+		return;
+	}
+	cq->queue[cq->head] = *entry;
+	cq->head = next;
+
+	if (cq->notify == IB_CQ_NEXT_COMP ||
+	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
+		cq->notify = IB_CQ_NONE;
+		cq->triggered++;
+		/*
+		 * This will cause send_complete() to be called in
+		 * another thread.
+		 */
+		tasklet_hi_schedule(&cq->comptask);
+	}
+
+	spin_unlock_irqrestore(&cq->lock, flags);
+
+	if (entry->status != IB_WC_SUCCESS)
+		to_idev(cq->ibcq.device)->n_wqe_errs++;
+}
+
+/**
+ * ipath_poll_cq - poll for work completion entries
+ * @ibcq: the completion queue to poll
+ * @num_entries: the maximum number of entries to return
+ * @entry: pointer to array where work completions are placed
+ *
+ * Returns the number of completion entries polled.
+ *
+ * This may be called from interrupt context.  Also called by ib_poll_cq()
+ * in the generic verbs code.
+ */
+int ipath_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+	unsigned long flags;
+	int npolled;
+
+	spin_lock_irqsave(&cq->lock, flags);
+
+	for (npolled = 0; npolled < num_entries; ++npolled, ++entry) {
+		if (cq->tail == cq->head)
+			break;
+		*entry = cq->queue[cq->tail];
+		if (cq->tail == cq->ibcq.cqe)
+			cq->tail = 0;
+		else
+			cq->tail++;
+	}
+
+	spin_unlock_irqrestore(&cq->lock, flags);
+
+	return npolled;
+}
+
+static void send_complete(unsigned long data)
+{
+	struct ipath_cq *cq = (struct ipath_cq *)data;
+
+	/*
+	 * The completion handler will most likely rearm the notification
+	 * and poll for all pending entries.  If a new completion entry
+	 * is added while we are in this routine, tasklet_hi_schedule()
+	 * won't call us again until we return so we check triggered to
+	 * see if we need to call the handler again.
+	 */
+	for (;;) {
+		u8 triggered = cq->triggered;
+
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
+		if (cq->triggered == triggered)
+			return;
+	}
+}
+
+/**
+ * ipath_create_cq - create a completion queue
+ * @ibdev: the device this completion queue is attached to
+ * @entries: the minimum size of the completion queue
+ * @context: unused by the InfiniPath driver
+ * @udata: unused by the InfiniPath driver
+ *
+ * Returns a pointer to the completion queue or negative errno values
+ * for failure.
+ *
+ * Called by ib_create_cq() in the generic verbs code.
+ */
+struct ib_cq *ipath_create_cq(struct ib_device *ibdev, int entries,
+			      struct ib_ucontext *context,
+			      struct ib_udata *udata)
+{
+	struct ipath_cq *cq;
+	struct ib_wc *wc;
+
+	/*
+	 * Need to use vmalloc() if we want to support large #s of
+	 * entries.
+	 */
+	cq = vmalloc(sizeof(*cq));
+	if (!cq)
+		return ERR_PTR(-ENOMEM);
+
+	/* Need to use vmalloc() if we want to support large #s of entries. */
+	wc = vmalloc(sizeof(*wc) * (entries + 1));
+	if (!wc) {
+		kfree(cq);
+		return ERR_PTR(-ENOMEM);
+	}
+	/*
+	 * ib_create_cq() will initialize cq->ibcq except for cq->ibcq.cqe.
+	 * The number of entries should be >= the number requested or return
+	 * an error.
+	 */
+	cq->ibcq.cqe = entries;
+	cq->notify = IB_CQ_NONE;
+	cq->triggered = 0;
+	spin_lock_init(&cq->lock);
+	tasklet_init(&cq->comptask, send_complete, (unsigned long)cq);
+	cq->head = 0;
+	cq->tail = 0;
+	cq->queue = wc;
+
+	return &cq->ibcq;
+}
+
+/**
+ * ipath_destroy_cq - destroy a completion queue
+ * @ibcq: the completion queue to destroy.
+ *
+ * Returns 0 for success.
+ *
+ * Called by ib_destroy_cq() in the generic verbs code.
+ */
+int ipath_destroy_cq(struct ib_cq *ibcq)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+
+	tasklet_kill(&cq->comptask);
+	vfree(cq->queue);
+	kfree(cq);
+
+	return 0;
+}
+
+/**
+ * ipath_req_notify_cq - change the notification type for a completion queue
+ * @ibcq: the completion queue
+ * @notify: the type of notification to request
+ *
+ * Returns 0 for success.
+ *
+ * This may be called from interrupt context.  Also called by
+ * ib_req_notify_cq() in the generic verbs code.
+ */
+int ipath_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cq->lock, flags);
+	/*
+	 * Don't change IB_CQ_NEXT_COMP to IB_CQ_SOLICITED but allow
+	 * any other transitions.
+	 */
+	if (cq->notify != IB_CQ_NEXT_COMP)
+		cq->notify = notify;
+	spin_unlock_irqrestore(&cq->lock, flags);
+	return 0;
+}
+
+int ipath_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+	struct ib_wc *wc, *old_wc;
+	u32 n;
+
+	/* Need to use vmalloc() if we want to support large #s of entries. */
+	wc = vmalloc(sizeof(*wc) * (cqe + 1));
+	if (!wc)
+		return -ENOMEM;
+
+	spin_lock_irq(&cq->lock);
+	if (cq->head < cq->tail)
+		n = cq->ibcq.cqe + 1 + cq->head - cq->tail;
+	else
+		n = cq->head - cq->tail;
+	if (unlikely((u32)cqe < n)) {
+		spin_unlock_irq(&cq->lock);
+		vfree(wc);
+		return -EOVERFLOW;
+	}
+	for (n = 0; cq->tail != cq->head; n++) {
+		wc[n] = cq->queue[cq->tail];
+		if (cq->tail == cq->ibcq.cqe)
+			cq->tail = 0;
+		else
+			cq->tail++;
+	}
+	cq->ibcq.cqe = cqe;
+	cq->head = n;
+	cq->tail = 0;
+	old_wc = cq->queue;
+	cq->queue = wc;
+	spin_unlock_irq(&cq->lock);
+
+	vfree(old_wc);
+
+	return 0;
+}
diff -r 70e3edb0d82d -r 44cd07539d66 drivers/infiniband/hw/ipath/ipath_keys.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Mar  9 16:16:44 2006 -0800
@@ -0,0 +1,212 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <asm/io.h>
+
+#include "ipath_verbs.h"
+
+/**
+ * ipath_alloc_lkey - allocate an lkey
+ * @rkt: lkey table in which to allocate the lkey
+ * @mr: memory region that this lkey protects
+ *
+ * Returns 1 if successful, otherwise returns 0.
+ */
+
+int ipath_alloc_lkey(struct ipath_lkey_table *rkt, struct ipath_mregion *mr)
+{
+	unsigned long flags;
+	u32 r;
+	u32 n;
+
+	spin_lock_irqsave(&rkt->lock, flags);
+
+	/* Find the next available LKEY */
+	r = n = rkt->next;
+	for (;;) {
+		if (rkt->table[r] == NULL)
+			break;
+		r = (r + 1) & (rkt->max - 1);
+		if (r == n) {
+			spin_unlock_irqrestore(&rkt->lock, flags);
+			_VERBS_INFO("LKEY table full\n");
+			return 0;
+		}
+	}
+	rkt->next = (r + 1) & (rkt->max - 1);
+	/*
+	 * Make sure lkey is never zero which is reserved to indicate an
+	 * unrestricted LKEY.
+	 */
+	rkt->gen++;
+	mr->lkey = (r << (32 - ib_ipath_lkey_table_size)) |
+		((((1 << (24 - ib_ipath_lkey_table_size)) - 1) & rkt->gen)
+		 << 8);
+	if (mr->lkey == 0) {
+		mr->lkey |= 1 << 8;
+		rkt->gen++;
+	}
+	rkt->table[r] = mr;
+	spin_unlock_irqrestore(&rkt->lock, flags);
+
+	return 1;
+}
+
+/**
+ * ipath_free_lkey - free an lkey
+ * @rkt: table from which to free the lkey
+ * @lkey: lkey id to free
+ */
+void ipath_free_lkey(struct ipath_lkey_table *rkt, u32 lkey)
+{
+	unsigned long flags;
+	u32 r;
+
+	if (lkey == 0)
+		return;
+	r = lkey >> (32 - ib_ipath_lkey_table_size);
+	spin_lock_irqsave(&rkt->lock, flags);
+	rkt->table[r] = NULL;
+	spin_unlock_irqrestore(&rkt->lock, flags);
+}
+
+/**
+ * ipath_lkey_ok - check IB SGE for validity and initialize
+ * @rkt: table containing lkey to check SGE against
+ * @isge: outgoing internal SGE
+ * @sge: SGE to check
+ * @acc: access flags
+ *
+ * Return 1 if valid and successful, otherwise returns 0.
+ *
+ * Check the IB SGE for validity and initialize our internal version
+ * of it.
+ */
+int ipath_lkey_ok(struct ipath_lkey_table *rkt, struct ipath_sge *isge,
+		  struct ib_sge *sge, int acc)
+{
+	struct ipath_mregion *mr;
+	size_t off;
+
+	/*
+	 * We use LKEY == zero to mean a physical kmalloc() address.
+	 * This is a bit of a hack since we rely on dma_map_single()
+	 * being reversible by calling bus_to_virt().
+	 */
+	if (sge->lkey == 0) {
+		isge->mr = NULL;
+		isge->vaddr = bus_to_virt(sge->addr);
+		isge->length = sge->length;
+		isge->sge_length = sge->length;
+		return 1;
+	}
+	spin_lock(&rkt->lock);
+	mr = rkt->table[(sge->lkey >> (32 - ib_ipath_lkey_table_size))];
+	spin_unlock(&rkt->lock);
+	if (unlikely(mr == NULL || mr->lkey != sge->lkey))
+		return 0;
+
+	off = sge->addr - mr->user_base;
+	if (unlikely(sge->addr < mr->user_base ||
+		     off + sge->length > mr->length ||
+		     (mr->access_flags & acc) != acc))
+		return 0;
+
+	off += mr->offset;
+	isge->mr = mr;
+	isge->m = 0;
+	isge->n = 0;
+	while (off >= mr->map[isge->m]->segs[isge->n].length) {
+		off -= mr->map[isge->m]->segs[isge->n].length;
+		isge->n++;
+		if (isge->n >= IPATH_SEGSZ) {
+			isge->m++;
+			isge->n = 0;
+		}
+	}
+	isge->vaddr = mr->map[isge->m]->segs[isge->n].vaddr + off;
+	isge->length = mr->map[isge->m]->segs[isge->n].length - off;
+	isge->sge_length = sge->length;
+	return 1;
+}
+
+/**
+ * ipath_rkey_ok - check the IB virtual address, length, and RKEY
+ * @dev: infiniband device
+ * @ss: SGE state
+ * @len: length of data
+ * @vaddr: virtual address to place data
+ * @rkey: rkey to check
+ * @acc: access flags
+ *
+ * Return 1 if successful, otherwise 0.
+ *
+ * The QP r_rq.lock should be held.
+ */
+int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
+		  u32 len, u64 vaddr, u32 rkey, int acc)
+{
+	struct ipath_lkey_table *rkt = &dev->lk_table;
+	struct ipath_sge *sge = &ss->sge;
+	struct ipath_mregion *mr;
+	size_t off;
+
+	spin_lock(&rkt->lock);
+	mr = rkt->table[(rkey >> (32 - ib_ipath_lkey_table_size))];
+	spin_unlock(&rkt->lock);
+	if (unlikely(mr == NULL || mr->lkey != rkey))
+		return 0;
+
+	off = vaddr - mr->iova;
+	if (unlikely(vaddr < mr->iova || off + len > mr->length ||
+		     (mr->access_flags & acc) == 0))
+		return 0;
+
+	off += mr->offset;
+	sge->mr = mr;
+	sge->m = 0;
+	sge->n = 0;
+	while (off >= mr->map[sge->m]->segs[sge->n].length) {
+		off -= mr->map[sge->m]->segs[sge->n].length;
+		sge->n++;
+		if (sge->n >= IPATH_SEGSZ) {
+			sge->m++;
+			sge->n = 0;
+		}
+	}
+	sge->vaddr = mr->map[sge->m]->segs[sge->n].vaddr + off;
+	sge->length = mr->map[sge->m]->segs[sge->n].length - off;
+	sge->sge_length = len;
+	ss->sg_list = NULL;
+	ss->num_sge = 1;
+	return 1;
+}
diff -r 70e3edb0d82d -r 44cd07539d66 drivers/infiniband/hw/ipath/ipath_mr.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_mr.c	Thu Mar  9 16:16:44 2006 -0800
@@ -0,0 +1,353 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <rdma/ib_pack.h>
+#include <rdma/ib_smi.h>
+
+#include "ipath_verbs.h"
+
+/**
+ * ipath_get_dma_mr - get a DMA memory region
+ * @pd: protection domain for this memory region
+ * @acc: access flags
+ *
+ * Returns the memory region on success, otherwise returns an errno.
+ */
+struct ib_mr *ipath_get_dma_mr(struct ib_pd *pd, int acc)
+{
+	struct ipath_mr *mr;
+
+	mr = kzalloc(sizeof *mr, GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr->mr.access_flags = acc;
+	return &mr->ibmr;
+}
+
+static struct ipath_mr *alloc_mr(int count,
+				 struct ipath_lkey_table *lk_table)
+{
+	struct ipath_mr *mr;
+	int m, i = 0;
+
+	/* Allocate struct plus pointers to first level page tables. */
+	m = (count + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
+	mr = kmalloc(sizeof *mr + m * sizeof mr->mr.map[0], GFP_KERNEL);
+	if (!mr)
+		goto done;
+
+	/* Allocate first level page tables. */
+	for (; i < m; i++) {
+		mr->mr.map[i] = kmalloc(sizeof *mr->mr.map[0], GFP_KERNEL);
+		if (!mr->mr.map[i])
+			goto bail;
+	}
+	mr->mr.mapsz = m;
+
+	/*
+	 * ib_reg_phys_mr() will initialize mr->ibmr except for
+	 * lkey and rkey.
+	 */
+	if (!ipath_alloc_lkey(lk_table, &mr->mr))
+		goto bail;
+	mr->ibmr.rkey = mr->ibmr.lkey = mr->mr.lkey;
+
+	goto done;
+
+bail:
+	while (i) {
+		i--;
+		kfree(mr->mr.map[i]);
+	}
+	kfree(mr);
+	mr = NULL;
+
+done:
+	return mr;
+}
+
+/**
+ * ipath_reg_phys_mr - register a physical memory region
+ * @pd: protection domain for this memory region
+ * @buffer_list: pointer to the list of physical buffers to register
+ * @num_phys_buf: the number of physical buffers to register
+ * @iova_start: the starting address passed over IB which maps to this MR
+ *
+ * Returns the memory region on success, otherwise returns an errno.
+ */
+struct ib_mr *ipath_reg_phys_mr(struct ib_pd *pd,
+				struct ib_phys_buf *buffer_list,
+				int num_phys_buf, int acc, u64 *iova_start)
+{
+	struct ipath_mr *mr;
+	int n, m, i;
+
+	mr = alloc_mr(num_phys_buf, &to_idev(pd->device)->lk_table);
+	if (mr == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	mr->mr.user_base = *iova_start;
+	mr->mr.iova = *iova_start;
+	mr->mr.length = 0;
+	mr->mr.offset = 0;
+	mr->mr.access_flags = acc;
+	mr->mr.max_segs = num_phys_buf;
+
+	m = 0;
+	n = 0;
+	for (i = 0; i < num_phys_buf; i++) {
+		mr->mr.map[m]->segs[n].vaddr =
+			phys_to_virt(buffer_list[i].addr);
+		mr->mr.map[m]->segs[n].length = buffer_list[i].size;
+		mr->mr.length += buffer_list[i].size;
+		n++;
+		if (n == IPATH_SEGSZ) {
+			m++;
+			n = 0;
+		}
+	}
+
+	return &mr->ibmr;
+}
+
+/**
+ * ipath_reg_user_mr - register a userspace memory region
+ * @pd: protection domain for this memory region
+ * @region: the user memory region
+ * @mr_access_flags: access flags for this memory region
+ * @udata: unused by the InfiniPath driver
+ *
+ * Returns the memory region on success, otherwise returns an errno.
+ */
+struct ib_mr *ipath_reg_user_mr(struct ib_pd *pd, struct ib_umem *region,
+				int mr_access_flags, struct ib_udata *udata)
+{
+	struct ipath_mr *mr;
+	struct ib_umem_chunk *chunk;
+	int n, m, i;
+
+	n = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list)
+		n += chunk->nents;
+
+	mr = alloc_mr(n, &to_idev(pd->device)->lk_table);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr->mr.user_base = region->user_base;
+	mr->mr.iova = region->virt_base;
+	mr->mr.length = region->length;
+	mr->mr.offset = region->offset;
+	mr->mr.access_flags = mr_access_flags;
+	mr->mr.max_segs = n;
+
+	m = 0;
+	n = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list) {
+		for (i = 0; i < chunk->nmap; i++) {
+			mr->mr.map[m]->segs[n].vaddr =
+				page_address(chunk->page_list[i].page);
+			mr->mr.map[m]->segs[n].length = region->page_size;
+			n++;
+			if (n == IPATH_SEGSZ) {
+				m++;
+				n = 0;
+			}
+		}
+	}
+	return &mr->ibmr;
+}
+
+/**
+ * ipath_dereg_mr - unregister and free a memory region
+ * @ibmr: the memory region to free
+ *
+ * Returns 0 on success.
+ *
+ * Note that this is called to free MRs created by ipath_get_dma_mr()
+ * or ipath_reg_user_mr().
+ */
+int ipath_dereg_mr(struct ib_mr *ibmr)
+{
+	struct ipath_mr *mr = to_imr(ibmr);
+	int i;
+
+	ipath_free_lkey(&to_idev(ibmr->device)->lk_table, ibmr->lkey);
+	i = mr->mr.mapsz;
+	while (i) {
+		i--;
+		kfree(mr->mr.map[i]);
+	}
+	kfree(mr);
+	return 0;
+}
+
+/**
+ * ipath_alloc_fmr - allocate a fast memory region
+ * @pd: the protection domain for this memory region
+ * @mr_access_flags: access flags for this memory region
+ * @fmr_attr: fast memory region attributes
+ *
+ * Returns the memory region on success, otherwise returns an errno.
+ */
+struct ib_fmr *ipath_alloc_fmr(struct ib_pd *pd, int mr_access_flags,
+			       struct ib_fmr_attr *fmr_attr)
+{
+	struct ipath_fmr *fmr;
+	int m, i = 0;
+
+	/* Allocate struct plus pointers to first level page tables. */
+	m = (fmr_attr->max_pages + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
+	fmr = kmalloc(sizeof *fmr + m * sizeof fmr->mr.map[0], GFP_KERNEL);
+	if (!fmr)
+		goto bail;
+
+	/* Allocate first level page tables. */
+	for (; i < m; i++) {
+		fmr->mr.map[i] = kmalloc(sizeof *fmr->mr.map[0],
+					 GFP_KERNEL);
+		if (!fmr->mr.map[i])
+			goto bail;
+	}
+	fmr->mr.mapsz = m;
+
+	/*
+	 * ib_alloc_fmr() will initialize fmr->ibfmr except for lkey &
+	 * rkey.
+	 */
+	if (!ipath_alloc_lkey(&to_idev(pd->device)->lk_table, &fmr->mr))
+		goto bail;
+	fmr->ibfmr.rkey = fmr->ibfmr.lkey = fmr->mr.lkey;
+	/*
+	 * Resources are allocated but no valid mapping (RKEY can't be
+	 * used).
+	 */
+	fmr->mr.user_base = 0;
+	fmr->mr.iova = 0;
+	fmr->mr.length = 0;
+	fmr->mr.offset = 0;
+	fmr->mr.access_flags = mr_access_flags;
+	fmr->mr.max_segs = fmr_attr->max_pages;
+	fmr->page_shift = fmr_attr->page_shift;
+
+	return &fmr->ibfmr;
+bail:
+	while (i)
+		kfree(fmr->mr.map[--i]);
+	kfree(fmr);
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * ipath_map_phys_fmr - set up a fast memory region
+ * @ibmfr: the fast memory region to set up
+ * @page_list: the list of pages to associate with the fast memory region
+ * @list_len: the number of pages to associate with the fast memory region
+ * @iova: the virtual address of the start of the fast memory region
+ *
+ * This may be called from interrupt context.
+ */
+
+int ipath_map_phys_fmr(struct ib_fmr *ibfmr, u64 * page_list,
+		       int list_len, u64 iova)
+{
+	struct ipath_fmr *fmr = to_ifmr(ibfmr);
+	struct ipath_lkey_table *rkt;
+	unsigned long flags;
+	int m, n, i;
+	u32 ps;
+
+	if (list_len > fmr->mr.max_segs)
+		return -EINVAL;
+	rkt = &to_idev(ibfmr->device)->lk_table;
+	spin_lock_irqsave(&rkt->lock, flags);
+	fmr->mr.user_base = iova;
+	fmr->mr.iova = iova;
+	ps = 1 << fmr->page_shift;
+	fmr->mr.length = list_len * ps;
+	m = 0;
+	n = 0;
+	ps = 1 << fmr->page_shift;
+	for (i = 0; i < list_len; i++) {
+		fmr->mr.map[m]->segs[n].vaddr = phys_to_virt(page_list[i]);
+		fmr->mr.map[m]->segs[n].length = ps;
+		if (++n == IPATH_SEGSZ) {
+			m++;
+			n = 0;
+		}
+	}
+	spin_unlock_irqrestore(&rkt->lock, flags);
+	return 0;
+}
+
+/**
+ * ipath_unmap_fmr - unmap fast memory regions
+ * @fmr_list: the list of fast memory regions to unmap
+ *
+ * Returns 0 on success.
+ */
+int ipath_unmap_fmr(struct list_head *fmr_list)
+{
+	struct ipath_fmr *fmr;
+	struct ipath_lkey_table *rkt;
+	unsigned long flags;
+
+	list_for_each_entry(fmr, fmr_list, ibfmr.list) {
+		rkt = &to_idev(fmr->ibfmr.device)->lk_table;
+		spin_lock_irqsave(&rkt->lock, flags);
+		fmr->mr.user_base = 0;
+		fmr->mr.iova = 0;
+		fmr->mr.length = 0;
+		spin_unlock_irqrestore(&rkt->lock, flags);
+	}
+	return 0;
+}
+
+/**
+ * ipath_dealloc_fmr - deallocate a fast memory region
+ * @ibfmr: the fast memory region to deallocate
+ *
+ * Returns 0 on success.
+ */
+int ipath_dealloc_fmr(struct ib_fmr *ibfmr)
+{
+	struct ipath_fmr *fmr = to_ifmr(ibfmr);
+	int i;
+
+	ipath_free_lkey(&to_idev(ibfmr->device)->lk_table, ibfmr->lkey);
+	i = fmr->mr.mapsz;
+	while (i)
+		kfree(fmr->mr.map[--i]);
+	kfree(fmr);
+	return 0;
+}
diff -r 70e3edb0d82d -r 44cd07539d66 drivers/infiniband/hw/ipath/ipath_srq.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Mar  9 16:16:44 2006 -0800
@@ -0,0 +1,246 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+
+#include "ipath_verbs.h"
+
+/**
+ * ipath_post_srq_receive - post a receive on a shared receive queue
+ * @ibsrq: the SRQ to post the receive on
+ * @wr: the list of work requests to post
+ * @bad_wr: the first WR to cause a problem is put here
+ *
+ * This may be called from interrupt context.
+ */
+int ipath_post_srq_receive(struct ib_srq *ibsrq, struct ib_recv_wr *wr,
+			   struct ib_recv_wr **bad_wr)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+	struct ipath_ibdev *dev = to_idev(ibsrq->device);
+	unsigned long flags;
+
+	for (; wr; wr = wr->next) {
+		struct ipath_rwqe *wqe;
+		u32 next;
+		int i, j;
+
+		if (wr->num_sge > srq->rq.max_sge) {
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		next = srq->rq.head + 1;
+		if (next >= srq->rq.size)
+			next = 0;
+		if (next == srq->rq.tail) {
+			spin_unlock_irqrestore(&srq->rq.lock, flags);
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		wqe = get_rwqe_ptr(&srq->rq, srq->rq.head);
+		wqe->wr_id = wr->wr_id;
+		wqe->sg_list[0].mr = NULL;
+		wqe->sg_list[0].vaddr = NULL;
+		wqe->sg_list[0].length = 0;
+		wqe->sg_list[0].sge_length = 0;
+		wqe->length = 0;
+		for (i = 0, j = 0; i < wr->num_sge; i++) {
+			/* Check LKEY */
+			if (to_ipd(srq->ibsrq.pd)->user &&
+			    wr->sg_list[i].lkey == 0) {
+				spin_unlock_irqrestore(&srq->rq.lock,
+						       flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			if (wr->sg_list[i].length == 0)
+				continue;
+			if (!ipath_lkey_ok(&dev->lk_table,
+					   &wqe->sg_list[j],
+					   &wr->sg_list[i],
+					   IB_ACCESS_LOCAL_WRITE)) {
+				spin_unlock_irqrestore(&srq->rq.lock,
+						       flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			wqe->length += wr->sg_list[i].length;
+			j++;
+		}
+		wqe->num_sge = j;
+		srq->rq.head = next;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
+	return 0;
+}
+
+/**
+ * ipath_create_srq - create a shared receive queue
+ * @ibpd: the protection domain of the SRQ to create
+ * @attr: the attributes of the SRQ
+ * @udata: not used by the InfiniPath verbs driver
+ */
+struct ib_srq *ipath_create_srq(struct ib_pd *ibpd,
+				struct ib_srq_init_attr *srq_init_attr,
+				struct ib_udata *udata)
+{
+	struct ipath_srq *srq;
+	u32 sz;
+
+	if (srq_init_attr->attr.max_sge < 1)
+		return ERR_PTR(-EINVAL);
+
+	srq = kmalloc(sizeof(*srq), GFP_KERNEL);
+	if (!srq)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Need to use vmalloc() if we want to support large #s of entries.
+	 */
+	srq->rq.size = srq_init_attr->attr.max_wr + 1;
+	sz = sizeof(struct ipath_sge) * srq_init_attr->attr.max_sge +
+		sizeof(struct ipath_rwqe);
+	srq->rq.wq = vmalloc(srq->rq.size * sz);
+	if (!srq->rq.wq) {
+		kfree(srq);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * ib_create_srq() will initialize srq->ibsrq.
+	 */
+	spin_lock_init(&srq->rq.lock);
+	srq->rq.head = 0;
+	srq->rq.tail = 0;
+	srq->rq.max_sge = srq_init_attr->attr.max_sge;
+	srq->limit = srq_init_attr->attr.srq_limit;
+
+	return &srq->ibsrq;
+}
+
+/**
+ * ipath_modify_srq - modify a shared receive queue
+ * @ibsrq: the SRQ to modify
+ * @attr: the new attributes of the SRQ
+ * @attr_mask: indicates which attributes to modify
+ */
+int ipath_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
+		     enum ib_srq_attr_mask attr_mask)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+	unsigned long flags;
+
+	if (attr_mask & IB_SRQ_LIMIT) {
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		srq->limit = attr->srq_limit;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
+	if (attr_mask & IB_SRQ_MAX_WR) {
+		u32 size = attr->max_wr + 1;
+		struct ipath_rwqe *wq, *p;
+		u32 n;
+		u32 sz;
+
+		if (attr->max_sge < srq->rq.max_sge)
+			return -EINVAL;
+
+		sz = sizeof(struct ipath_rwqe) +
+			attr->max_sge * sizeof(struct ipath_sge);
+		wq = vmalloc(size * sz);
+		if (!wq)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		if (srq->rq.head < srq->rq.tail)
+			n = srq->rq.size + srq->rq.head - srq->rq.tail;
+		else
+			n = srq->rq.head - srq->rq.tail;
+		if (size <= n || size <= srq->limit) {
+			spin_unlock_irqrestore(&srq->rq.lock, flags);
+			vfree(wq);
+			return -EINVAL;
+		}
+		n = 0;
+		p = wq;
+		while (srq->rq.tail != srq->rq.head) {
+			struct ipath_rwqe *wqe;
+			int i;
+
+			wqe = get_rwqe_ptr(&srq->rq, srq->rq.tail);
+			p->wr_id = wqe->wr_id;
+			p->length = wqe->length;
+			p->num_sge = wqe->num_sge;
+			for (i = 0; i < wqe->num_sge; i++)
+				p->sg_list[i] = wqe->sg_list[i];
+			n++;
+			p = (struct ipath_rwqe *)((char *) p + sz);
+			if (++srq->rq.tail >= srq->rq.size)
+				srq->rq.tail = 0;
+		}
+		vfree(srq->rq.wq);
+		srq->rq.wq = wq;
+		srq->rq.size = size;
+		srq->rq.head = n;
+		srq->rq.tail = 0;
+		srq->rq.max_sge = attr->max_sge;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
+	return 0;
+}
+
+int ipath_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+
+	attr->max_wr = srq->rq.size - 1;
+	attr->max_sge = srq->rq.max_sge;
+	attr->srq_limit = srq->limit;
+	return 0;
+}
+
+/**
+ * ipath_destroy_srq - destroy a shared receive queue
+ * @ibsrq: the SRQ to destroy
+ */
+int ipath_destroy_srq(struct ib_srq *ibsrq)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+
+	vfree(srq->rq.wq);
+	kfree(srq);
+
+	return 0;
+}
