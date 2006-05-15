Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWEORnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWEORnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEORmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:42:52 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9278 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965014AbWEORmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:42:45 -0400
Message-ID: <4468BDAD.3020701@de.ibm.com>
Date: Mon, 15 May 2006 19:43:09 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 14/16] ehca: queue page table handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  drivers/infiniband/hw/ehca/ipz_pt_fn.c |  177 ++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ipz_pt_fn.h |  254 +++++++++++++++++++++++++++++++++
  2 files changed, 431 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ipz_pt_fn.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ipz_pt_fn.h	2006-05-12 12:25:43.000000000 +0200
@@ -0,0 +1,254 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  internal queue handling
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
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
+ */
+
+#ifndef __IPZ_PT_FN_H__
+#define __IPZ_PT_FN_H__
+
+#include "ehca_qes.h"
+#define EHCA_PAGESHIFT   12
+#define EHCA_PAGESIZE   4096UL
+#define EHCA_PT_ENTRIES 512UL
+
+#include "ehca_tools.h"
+#include "ehca_qes.h"
+
+/* struct generic ehca page
+ */
+struct ipz_page {
+	u8 entries[EHCA_PAGESIZE];
+};
+
+/* struct generic queue in linux kernel virtual memory (kv)
+ */
+struct ipz_queue {
+	u64 current_q_offset;	/* current queue entry */
+
+	struct ipz_page **queue_pages;	/* array of pages belonging to queue */
+	u32 qe_size;		/* queue entry size */
+	u32 act_nr_of_sg;
+	u32 queue_length;	/* queue length allocated in bytes */
+	u32 pagesize;
+	u32 toggle_state;	/* toggle flag - per page */
+	u32 dummy3;		/* 64 bit alignment */
+};
+
+/*  return current Queue Entry for a certain q_offset
+ *   returns address (kv) of Queue Entry
+ */
+static inline void *ipz_qeit_calc(struct ipz_queue *queue, u64 q_offset)
+{
+	struct ipz_page *current_page = NULL;
+	if (q_offset >= queue->queue_length)
+		return NULL;
+	current_page = (queue->queue_pages)[q_offset >> EHCA_PAGESHIFT];
+	return  &current_page->entries[q_offset & (EHCA_PAGESIZE - 1)];
+}
+
+/*  return current Queue Entry
+ *   returns address (kv) of Queue Entry
+ */
+static inline void *ipz_qeit_get(struct ipz_queue *queue)
+{
+	return ipz_qeit_calc(queue, queue->current_q_offset);
+}
+
+/*  return current Queue Page , increment Queue Page iterator from
+ *   page to page in struct ipz_queue, last increment will return 0! and
+ *   NOT wrap
+ *   returns address (kv) of Queue Page
+ *   warning don't use in parallel with ipz_QE_get_inc()
+ */
+void *ipz_qpageit_get_inc(struct ipz_queue *queue);
+
+/*  return current Queue Entry, increment Queue Entry iterator by one
+ *   step in struct ipz_queue, will wrap in ringbuffer
+ *   @returns address (kv) of Queue Entry BEFORE increment
+ *   warning don't use in parallel with ipz_qpageit_get_inc()
+ *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ */
+static inline void *ipz_qeit_get_inc(struct ipz_queue *queue)
+{
+	void *ret = NULL;
+
+	ret = ipz_qeit_get(queue);
+	queue->current_q_offset += queue->qe_size;
+	if (queue->current_q_offset >= queue->queue_length) {
+		queue->current_q_offset = 0;
+		/* toggle the valid flag */
+		queue->toggle_state = (~queue->toggle_state) & 1;
+	}
+
+	EDEB(7, "queue=%p ret=%p new current_q_addr=%lx qe_size=%x",
+	     queue, ret, queue->current_q_offset, queue->qe_size);
+
+	return ret;
+}
+
+/*  return current Queue Entry, increment Queue Entry iterator by one
+ *   step in struct ipz_queue, will wrap in ringbuffer
+ *   returns address (kv) of Queue Entry BEFORE increment
+ *   returns 0 and does not increment, if wrong valid state
+ *   warning don't use in parallel with ipz_qpageit_get_inc()
+ *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ */
+static inline void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
+{
+	struct ehca_cqe *cqe = ipz_qeit_get(queue);
+	u32 cqe_flags = cqe->cqe_flags;
+
+	if ((cqe_flags >> 7) != (queue->toggle_state & 1))
+		return NULL;
+
+	ipz_qeit_get_inc(queue);
+	return cqe;
+}
+
+/*  returns and resets Queue Entry iterator
+ *   returns address (kv) of first Queue Entry
+ */
+static inline void *ipz_qeit_reset(struct ipz_queue *queue)
+{
+	queue->current_q_offset = 0;
+	return ipz_qeit_get(queue);
+}
+
+/** struct generic page table
+ */
+struct ipz_pt {
+	u64 entries[EHCA_PT_ENTRIES];
+};
+
+/* struct page table for a queue, only to be used in pf
+ */
+struct ipz_qpt {
+	/* queue page tables (kv), use u64 because we know the element length */
+	u64 *qpts;
+	u32 allocated_qpts_entries;
+	u32 nr_of_PTEs;		/*  number of page table entries PTE iterators */
+	u64 *current_pte_addr;
+};
+
+/* constructor for a ipz_queue_t, placement new for ipz_queue_t,
+ *  new for all dependent datastructors
+ *
+ *  all QP Tables are the same
+ *  flow:
+ *     allocate+pin queue
+ *  see ipz_qpt_ctor()
+ *  returns true if ok, false if out of memory
+ */
+int ipz_queue_ctor(struct ipz_queue *queue, const u32 nr_of_pages,
+		   const u32 pagesize, const u32 qe_size,
+		   const u32 nr_of_sg);
+
+/* destructor for a ipz_queue_t
+ *  -# free queue
+ *  see ipz_queue_ctor()
+ *  returns true if ok, false if queue was NULL-ptr of free failed
+ */
+int ipz_queue_dtor(struct ipz_queue *queue);
+
+/* constructor for a ipz_qpt_t,
+ * placement new for struct ipz_queue, new for all dependent datastructors
+ *
+ *  all QP Tables are the same,
+ *  flow:
+ *  -# allocate+pin queue
+ *  -# initialise ptcb
+ *  -# allocate+pin PTs
+ *  -# link PTs to a ring, according to HCA Arch, set bit62 id needed
+ *  -# the ring must have room for exactly nr_of_PTEs
+ *  see ipz_qpt_ctor()
+ */
+void ipz_qpt_ctor(struct ipz_qpt *qpt,
+		  const u32 nr_of_QEs,
+		  const u32 pagesize,
+		  const u32 qe_size,
+		  const u8 lowbyte, const u8 toggle,
+		  u32 * act_nr_of_QEs, u32 * act_nr_of_pages);
+
+/*  return current Queue Entry, increment Queue Entry iterator by one
+ *   step in struct ipz_queue, will wrap in ringbuffer
+ *   returns address (kv) of Queue Entry BEFORE increment
+ *   warning don't use in parallel with ipz_qpageit_get_inc()
+ *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ *
+ *   fix EQ page problems
+ */
+void *ipz_qeit_eq_get_inc(struct ipz_queue *queue);
+
+/*  return current Event Queue Entry, increment Queue Entry iterator
+ *   by one step in struct ipz_queue if valid, will wrap in ringbuffer
+ *   returns address (kv) of Queue Entry BEFORE increment
+ *   returns 0 and does not increment, if wrong valid state
+ *   warning don't use in parallel with ipz_queue_QPageit_get_inc()
+ *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ */
+static inline void *ipz_eqit_eq_get_inc_valid(struct ipz_queue *queue)
+{
+	void *ret = ipz_qeit_get(queue);
+	u32 qe = *(u8 *) ret;
+	EDEB(7, "ipz_QEit_EQ_get_inc_valid qe=%x", qe);
+	if ((qe >> 7) == (queue->toggle_state & 1))
+		ipz_qeit_eq_get_inc(queue); /* this is a good one */
+	else
+		ret = NULL;
+	return ret;
+}
+
+/*
+ *   returns address (GX) of first queue entry
+ */
+static inline u64 ipz_qpt_get_firstpage(struct ipz_qpt *qpt)
+{
+	return be64_to_cpu(qpt->qpts[0]);
+}
+
+/*
+ *   returns address (kv) of first page of queue page table
+ */
+static inline void *ipz_qpt_get_qpt(struct ipz_qpt *qpt)
+{
+	return qpt->qpts;
+}
+
+#endif				/* __IPZ_PT_FN_H__ */
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ipz_pt_fn.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ipz_pt_fn.c	2006-05-15 15:43:31.000000000 +0200
@@ -0,0 +1,177 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  internal queue handling
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
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
+ */
+
+#define DEB_PREFIX "iptz"
+
+#include "ehca_tools.h"
+#include "ipz_pt_fn.h"
+
+extern int ehca_hwlevel;
+
+void *ipz_qpageit_get_inc(struct ipz_queue *queue)
+{
+	void *ret = ipz_qeit_get(queue);
+	queue->current_q_offset += queue->pagesize;
+	if (queue->current_q_offset > queue->queue_length) {
+		queue->current_q_offset -= queue->pagesize;
+		ret = NULL;
+	}
+	if (((u64)ret) % EHCA_PAGESIZE) {
+		EDEB(4, "ERROR!! not at PAGE-Boundary");
+		return NULL;
+	}
+	EDEB(7, "queue=%p ret=%p", queue, ret);
+	return ret;
+}
+
+void *ipz_qeit_eq_get_inc(struct ipz_queue *queue)
+{
+	void *ret = ipz_qeit_get(queue);
+	u64 last_entry_in_q = queue->queue_length - queue->qe_size;
+	queue->current_q_offset += queue->qe_size;
+	if (queue->current_q_offset > last_entry_in_q) {
+		queue->current_q_offset = 0;
+		queue->toggle_state = (~queue->toggle_state) & 1;
+	}
+
+	EDEB(7, "queue=%p ret=%p new current_q_offset=%lx qe_size=%x",
+	     queue, ret, queue->current_q_offset, queue->qe_size);
+
+	return ret;
+}
+
+int ipz_queue_ctor(struct ipz_queue *queue,
+		   const u32 nr_of_pages,
+		   const u32 pagesize, const u32 qe_size, const u32 nr_of_sg)
+{
+	int pages_per_kpage = PAGE_SIZE >> EHCA_PAGESHIFT;
+	int f;
+
+	EDEB_EN(7, "nr_of_pages=%x pagesize=%x qe_size=%x",
+		nr_of_pages, pagesize, qe_size);
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
+	/* allocate pages for queue:
+	   while loop allocates whole kernel pages
+	   if cond allocates so much mem needed for the rest of queue pages,
+	   which is nr_of_pages % pages_per_kpage
+	 */
+	f = 0;
+	while (f + pages_per_kpage <= nr_of_pages) {
+		u8 *kpage = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		int k;
+		if (!kpage)
+			goto ipz_queue_ctor_exit0; /*NOMEM*/
+		for (k = 0; k < pages_per_kpage; k++) {
+			(queue->queue_pages)[f] = (struct ipz_page *)kpage;
+			kpage += EHCA_PAGESIZE;
+			f++;
+		}
+	}
+	if (f < nr_of_pages) {
+		u8 *kpage = kzalloc((nr_of_pages - f) * EHCA_PAGESIZE,
+				      GFP_KERNEL);
+		if (!kpage)
+			goto ipz_queue_ctor_exit0; /*NOMEM*/
+		while (f < nr_of_pages) {
+			(queue->queue_pages)[f] = (struct ipz_page *)kpage;
+			kpage += EHCA_PAGESIZE;
+			f++;
+		}
+	}
+
+	queue->current_q_offset = 0;
+	queue->qe_size = qe_size;
+	queue->act_nr_of_sg = nr_of_sg;
+	queue->pagesize = pagesize;
+	queue->toggle_state = 1;
+	EDEB_EX(7, "queue_length=%x queue_pages=%p qe_size=%x"
+		" act_nr_of_sg=%x", queue->queue_length, queue->queue_pages,
+		queue->qe_size, queue->act_nr_of_sg);
+	return 1;
+
+ ipz_queue_ctor_exit0:
+	EDEB_ERR(4, "Couldn't get alloc pages queue=%p f=%x nr_of_pages=%x",
+		 queue, f, nr_of_pages);
+	for (f = 0; f < nr_of_pages; f += pages_per_kpage) {
+		if (!(queue->queue_pages)[f])
+			break;
+		kfree((queue->queue_pages)[f]);
+	}
+	return 0;
+}
+
+int ipz_queue_dtor(struct ipz_queue *queue)
+{
+	int pages_per_kpage = PAGE_SIZE >> EHCA_PAGESHIFT;
+	int g;
+	int nr_pages;
+
+	EDEB_EN(7, "ipz_queue pointer=%p", queue);
+	if (!queue || !queue->queue_pages) {
+		EDEB_ERR(4, "queue or queue_pages is NULL");
+		return 0;
+	}
+	EDEB(7, "destructing a queue with the following "
+	     "properties:\n nr_of_pages=%x pagesize=%x qe_size=%x",
+	     queue->act_nr_of_sg, queue->pagesize, queue->qe_size);
+	nr_pages = queue->queue_length / queue->pagesize;
+	for (g = 0; g < nr_pages; g += pages_per_kpage)
+		kfree((queue->queue_pages)[g]);
+	vfree(queue->queue_pages);
+
+	EDEB_EX(7, "queue freed!");
+	return 1;
+}


