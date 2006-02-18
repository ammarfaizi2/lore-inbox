Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWBRA6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWBRA6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWBRA5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:52 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:57779 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751818AbWBRA5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:38 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 06/22] Queue handling
Date: Fri, 17 Feb 2006 16:57:19 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005719.13620.95136.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:19.0265 (UTC) FILETIME=[44B37110:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

Code like

	#ifndef __PPC64__
		void * dummy1;              /* make sure we use the same thing on 
32 bit 
*/
	#endif

looks _very_ suspicious.  Much better to make sure that the
structures are laid out the same no matter what the word size
of the architecture is rather than relying on fragile hacks
like this.
---

 drivers/infiniband/hw/ehca/ipz_pt_fn.c      |  137 ++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ipz_pt_fn.h      |  165 +++++++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ipz_pt_fn_core.h |  152 +++++++++++++++++++++++++
 3 files changed, 454 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
new file mode 100644
index 0000000..d6c490c
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -0,0 +1,137 @@
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
+ *
+ *  $Id: ipz_pt_fn.c,v 1.16 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#define DEB_PREFIX "iptz"
+
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+#include "ipz_pt_fn.h"
+
+extern int ehca_hwlevel;
+
+void *ipz_QPageit_get_inc(struct ipz_queue *queue)
+{
+	void *retvalue = NULL;
+	u8 *EOF_last_page = queue->queue + queue->queue_length;
+
+	retvalue = queue->current_q_addr;
+	queue->current_q_addr += queue->pagesize;
+	if (queue->current_q_addr > EOF_last_page) {
+		queue->current_q_addr -= queue->pagesize;
+		retvalue = NULL;
+	}
+
+	if ((((u64)retvalue) % EHCA_PAGESIZE) != 0) {
+		EDEB(4,  "ERROR!! not at PAGE-Boundary");
+		return (NULL);
+	}
+	EDEB(7, "queue=%p retvalue=%p", queue, retvalue);
+	return (retvalue);
+}
+
+void *ipz_QEit_EQ_get_inc(struct ipz_queue *queue)
+{
+	void *retvalue = NULL;
+	u8 *last_entry_in_q = queue->queue + queue->queue_length
+	    - queue->qe_size;
+
+	retvalue = queue->current_q_addr;
+	queue->current_q_addr += queue->qe_size;
+	if (queue->current_q_addr > last_entry_in_q) {
+		queue->current_q_addr = queue->queue;
+		queue->toggle_state = (~queue->toggle_state) & 1;
+	}
+
+	EDEB(7, "queue=%p retvalue=%p new current_q_addr=%p qe_size=%x",
+	     queue, retvalue, queue->current_q_addr, queue->qe_size);
+
+	return (retvalue);
+}
+
+int ipz_queue_ctor(struct ipz_queue *queue,
+		   const u32 nr_of_pages,
+		   const u32 pagesize, const u32 qe_size, const u32 nr_of_sg)
+{
+	EDEB_EN(7,  "nr_of_pages=%x pagesize=%x qe_size=%x",
+		nr_of_pages, pagesize, qe_size);
+	queue->queue_length = nr_of_pages * pagesize;
+	queue->queue = vmalloc(queue->queue_length);
+	if (queue->queue == 0) {
+		EDEB(4,  "ERROR!! didn't get the memory");
+		return (FALSE);
+	}
+	if ((((u64)queue->queue) & (EHCA_PAGESIZE - 1)) != 0) {
+		EDEB(4,  "ERROR!! QUEUE doesn't start at "
+		     "page boundary");
+		vfree(queue->queue);
+		return (FALSE);
+	}
+
+	memset(queue->queue, 0, queue->queue_length);
+	queue->current_q_addr = queue->queue;
+	queue->qe_size = qe_size;
+	queue->act_nr_of_sg = nr_of_sg;
+	queue->pagesize = pagesize;
+	queue->toggle_state = 1;
+	EDEB_EX(7,  "queue_length=%x queue=%p qe_size=%x"
+		" act_nr_of_sg=%x", queue->queue_length, queue->queue,
+		queue->qe_size, queue->act_nr_of_sg);
+	return TRUE;
+}
+
+int ipz_queue_dtor(struct ipz_queue *queue)
+{
+	EDEB_EN(7,  "ipz_queue pointer=%p", queue);
+	if (queue == NULL) {
+		return (FALSE);
+	}
+	if (queue->queue == NULL) {
+		return (FALSE);
+	}
+	EDEB(7,  "destructing a queue with the following "
+	     "properties:\n nr_of_pages=%x pagesize=%x qe_size=%x",
+	     queue->act_nr_of_sg, queue->pagesize, queue->qe_size);
+	vfree(queue->queue);
+
+	EDEB_EX(7,  "queue freed!");
+	return TRUE;
+}
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.h b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
new file mode 100644
index 0000000..2e197db
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
@@ -0,0 +1,165 @@
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
+ *
+ *  $Id: ipz_pt_fn.h,v 1.11 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __IPZ_PT_FN_H__
+#define __IPZ_PT_FN_H__
+
+#include "ipz_pt_fn_core.h"
+#include "ehca_qes.h"
+
+#define EHCA_PAGESIZE   4096UL
+#define EHCA_PT_ENTRIES 512UL
+
+/** @brief generic page table
+ */
+struct ipz_pt {
+	u64 entries[EHCA_PT_ENTRIES];
+};
+
+/** @brief generic page
+ */
+struct ipz_page {
+	u8 entries[EHCA_PAGESIZE];
+};
+
+/** @brief page table for a queue, only to be used in pf
+ */
+struct ipz_qpt {
+	/* queue page tables (kv), use u64 because we know the element length */
+	u64 *qpts;
+	u32 allocated_qpts_entries;
+	u32 nr_of_PTEs; /*  number of page table entries PTE iterators */
+	u64 *current_pte_addr;
+};
+
+/** @brief constructor for a ipz_queue_t, placement new for ipz_queue_t,
+    new for all dependent datastructors
+
+    all QP Tables are the same
+    flow:
+    -# allocate+pin queue
+    @see ipz_qpt_ctor()
+    @returns true if ok, false if out of memory
+ */
+int ipz_queue_ctor(struct ipz_queue *queue, const u32 nr_of_pages,
+		   const u32 pagesize,
+		   const u32 qe_size, /* queue entry size*/
+		   const u32 nr_of_sg);
+
+/** @brief destructor for a ipz_queue_t
+    -# free queue
+    @see ipz_queue_ctor()
+    @returns true if ok, false if queue was NULL-ptr of free failed
+*/
+int ipz_queue_dtor(struct ipz_queue *queue);
+
+/** @brief constructor for a ipz_qpt_t,
+ * placement new for struct ipz_queue, new for all dependent datastructors
+ *
+ *  all QP Tables are the same,
+ *  flow:
+ *  -# allocate+pin queue
+ *  -# initialise ptcb
+ *  -# allocate+pin PTs
+ *  -# link PTs to a ring, according to HCA Arch, set bit62 id needed
+ *  -# the ring must have room for exactly nr_of_PTEs
+ *  @see ipz_qpt_ctor()
+ */
+void ipz_qpt_ctor(struct ipz_qpt *qpt,
+		  struct ehca_bridge_handle bridge,
+		  const u32 nr_of_QEs,
+		  const u32 pagesize,
+		  const u32 qe_size,
+		  const u8 lowbyte, const u8 toggle,
+		  u32 * act_nr_of_QEs,
+		  u32 * act_nr_of_pages);
+
+/**  @brief return current Queue Entry, increment Queue Entry iterator by one
+     step in struct ipz_queue, will wrap in ringbuffer
+     @returns address (kv) of Queue Entry BEFORE increment
+     @warning don't use in parallel with ipz_QPageit_get_inc()
+     @warning unpredictable results may occur if steps>act_nr_of_queue_entries
+
+     fix EQ page problems
+ */
+void *ipz_QEit_EQ_get_inc(struct ipz_queue *queue);
+
+/**  @brief return current Event Queue Entry, increment Queue Entry iterator
+     by one step in struct ipz_queue if valid, will wrap in ringbuffer
+     @returns address (kv) of Queue Entry BEFORE increment
+     @returns 0 and does not increment, if wrong valid state
+     @warning don't use in parallel with ipz_queue_QPageit_get_inc()
+     @warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ */
+inline static void *ipz_QEit_EQ_get_inc_valid(struct ipz_queue *queue)
+{
+	void *retvalue = ipz_QEit_get(queue);
+	u32 qe = *(u8 *) retvalue;
+	EDEB(7, "ipz_QEit_EQ_get_inc_valid qe=%x", qe);
+	if ((qe >> 7) == (queue->toggle_state & 1)) {
+		/* this is a good one */
+		ipz_QEit_EQ_get_inc(queue);
+	} else {
+		retvalue = NULL;
+	}
+	return (retvalue);
+}
+
+/**
+     @returns address (GX) of first queue entry
+ */
+inline static u64 ipz_qpt_get_firstpage(struct ipz_qpt *qpt)
+{
+	return (be64_to_cpu(qpt->qpts[0]));
+}
+
+/**
+     @returns address (kv) of first page of queue page table
+ */
+inline static void *ipz_qpt_get_qpt(struct ipz_qpt *qpt)
+{
+	return (qpt->qpts);
+}
+
+#endif /* __IPZ_PT_FN_H__ */
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn_core.h b/drivers/infiniband/hw/ehca/ipz_pt_fn_core.h
new file mode 100644
index 0000000..1b9a114
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn_core.h
@@ -0,0 +1,152 @@
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
+ *
+ *  $Id: ipz_pt_fn_core.h,v 1.12 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __IPZ_PT_FN_CORE_H__
+#define __IPZ_PT_FN_CORE_H__
+
+#ifdef __KERNEL__
+#include "ehca_tools.h"
+#else /* some replacements for kernel stuff */
+#include "ehca_utools.h"
+#endif
+
+#include "ehca_qes.h"
+
+/** @brief generic queue in linux kernel virtual memory (kv)
+ */
+struct ipz_queue {
+#ifndef __PPC64__
+	void * dummy1;              /* make sure we use the same thing on 32 bit */
+#endif
+	u8 *current_q_addr;         /* current queue entry */
+#ifndef __PPC64__
+	void * dummy2;
+#endif
+	u8 *queue;                  /* points to first queue entry */
+	u32 qe_size;                /* queue entry size */
+	u32 act_nr_of_sg;
+	u32 queue_length;           /* queue length allocated in bytes */
+	u32 pagesize;
+	u32 toggle_state;           /* toggle flag - per page */
+	u32 dummy3;                 /* 64 bit alignment*/
+};
+
+/**  @brief return current Queue Entry
+     @returns address (kv) of Queue Entry
+ */
+static inline void *ipz_QEit_get(struct ipz_queue *queue)
+{
+	return (queue->current_q_addr);
+}
+
+/**  @brief return current Queue Page , increment Queue Page iterator from
+     page to page in struct ipz_queue, last increment will return 0! and
+     NOT wrap
+     @returns address (kv) of Queue Page
+     @warning don't use in parallel with ipz_QE_get_inc()
+ */
+void *ipz_QPageit_get_inc(struct ipz_queue *queue);
+
+/**  @brief return current Queue Entry, increment Queue Entry iterator by one
+     step in struct ipz_queue, will wrap in ringbuffer
+     @returns address (kv) of Queue Entry BEFORE increment
+     @warning don't use in parallel with ipz_QPageit_get_inc()
+     @warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ */
+static inline void *ipz_QEit_get_inc(struct ipz_queue *queue)
+{
+	void *retvalue = 0;
+	u8 *last_entry_in_q = queue->queue + queue->queue_length
+	    - queue->qe_size;
+
+	retvalue = queue->current_q_addr;
+	queue->current_q_addr += queue->qe_size;
+	if (queue->current_q_addr > last_entry_in_q) {
+		queue->current_q_addr = queue->queue;
+		/* toggle the valid flag */
+		queue->toggle_state = (~queue->toggle_state) & 1;
+	}
+
+	EDEB(7, "queue=%p retvalue=%p new current_q_addr=%p qe_size=%x",
+	     queue, retvalue, queue->current_q_addr, queue->qe_size);
+
+	return (retvalue);
+}
+
+/**  @brief return current Queue Entry, increment Queue Entry iterator by one
+     step in struct ipz_queue, will wrap in ringbuffer
+     @returns address (kv) of Queue Entry BEFORE increment
+     @returns 0 and does not increment, if wrong valid state
+     @warning don't use in parallel with ipz_QPageit_get_inc()
+     @warning unpredictable results may occur if steps>act_nr_of_queue_entries
+ */
+inline static void *ipz_QEit_get_inc_valid(struct ipz_queue *queue)
+{
+	void *retvalue = ipz_QEit_get(queue);
+#ifdef USERSPACE_DRIVER
+
+	u32 qe =
+	    ((struct ehca_cqe *)(ehca_ktou((struct ehca_cqe *)retvalue)))->
+	    cqe_flags;
+#else
+	u32 qe = ((struct ehca_cqe *)retvalue)->cqe_flags;
+#endif
+	if ((qe >> 7) == (queue->toggle_state & 1)) {
+		/* this is a good one */
+		ipz_QEit_get_inc(queue);
+	} else
+		retvalue = 0;
+	return (retvalue);
+}
+
+/**  @brief returns and resets Queue Entry iterator
+     @returns address (kv) of first Queue Entry
+ */
+static inline void *ipz_QEit_reset(struct ipz_queue *queue)
+{
+	queue->current_q_addr = queue->queue;
+	return (queue->queue);
+}
+
+#endif /* __IPZ_PT_FN_CORE_H__ */
