Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWBRA5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWBRA5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWBRA5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:38 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:29624 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751817AbWBRA53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:29 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 09/22] ehca classes
Date: Fri, 17 Feb 2006 16:57:25 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005725.13620.32014.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:25.0797 (UTC) FILETIME=[48982550:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

The fact that ehca_cq_delete and ehca_qp_delete return an int seems
a little silly, given that the functions can never fail.

The code in ehca_classes.c seems like a misuse of the kmem_cache API;
rather than wrapping kmem_cache_alloc() and doing extra initialization,
why not just use the kmem_cache's constructor to do this?
---

 drivers/infiniband/hw/ehca/ehca_classes.c         |  191 +++++++++++
 drivers/infiniband/hw/ehca/ehca_classes.h         |  369 +++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_classes_core.h    |   73 ++++
 drivers/infiniband/hw/ehca/ehca_classes_pSeries.h |  256 +++++++++++++++
 4 files changed, 889 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.c b/drivers/infiniband/hw/ehca/ehca_classes.c
new file mode 100644
index 0000000..9819788
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_classes.c
@@ -0,0 +1,191 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  struct initialisations and allocation
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
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
+ *  $Id: ehca_classes.c,v 1.21 2006/02/06 16:20:38 schickhj Exp $
+ */
+
+#define DEB_PREFIX "clas"
+#include "ehca_kernel.h"
+
+#include "ehca_classes.h"
+
+struct ehca_pd *ehca_pd_new(void)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_pd *me;
+
+	me = kmem_cache_alloc(ehca_module.cache_pd, SLAB_KERNEL);
+	if (me == NULL)
+		return NULL;
+
+	memset(me, 0, sizeof(struct ehca_pd));
+
+	return me;
+}
+
+void ehca_pd_delete(struct ehca_pd *me)
+{
+	extern struct ehca_module ehca_module;
+
+	kmem_cache_free(ehca_module.cache_pd, me);
+}
+
+struct ehca_cq *ehca_cq_new(void)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_cq *me;
+
+	me = kmem_cache_alloc(ehca_module.cache_cq, SLAB_KERNEL);
+	if (me == NULL)
+		return NULL;
+
+	memset(me, 0, sizeof(struct ehca_cq));
+	spin_lock_init(&me->spinlock);
+	spin_lock_init(&me->cb_lock);
+
+	return me;
+}
+
+int ehca_cq_delete(struct ehca_cq *me)
+{
+	extern struct ehca_module ehca_module;
+
+	kmem_cache_free(ehca_module.cache_cq, me);
+
+	return H_Success;
+}
+
+struct ehca_qp *ehca_qp_new(void)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_qp *me;
+
+	me = kmem_cache_alloc(ehca_module.cache_qp, SLAB_KERNEL);
+	if (me == NULL)
+		return NULL;
+
+	memset(me, 0, sizeof(struct ehca_qp));
+	spin_lock_init(&me->spinlock_s);
+	spin_lock_init(&me->spinlock_r);
+
+	return me;
+}
+
+int ehca_qp_delete(struct ehca_qp *me)
+{
+	extern struct ehca_module ehca_module;
+
+	kmem_cache_free(ehca_module.cache_qp, me);
+
+	return H_Success;
+}
+
+struct ehca_av *ehca_av_new(void)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_av *me;
+
+	me  = kmem_cache_alloc(ehca_module.cache_av, SLAB_KERNEL);
+	if (me == NULL)
+		return NULL;
+
+	memset(me, 0, sizeof(struct ehca_av));
+
+	return me;
+}
+
+int ehca_av_delete(struct ehca_av *me)
+{
+	extern struct ehca_module ehca_module;
+
+	kmem_cache_free(ehca_module.cache_av, me);
+
+	return H_Success;
+}
+
+struct ehca_mr *ehca_mr_new(void)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_mr *me;
+
+	me = kmem_cache_alloc(ehca_module.cache_mr, SLAB_KERNEL);
+	if (me) {
+		memset(me, 0, sizeof(struct ehca_mr));
+		spin_lock_init(&me->mrlock);
+		EDEB_EX(7, "ehca_mr=%p sizeof(ehca_mr_t)=%x", me,
+			(u32) sizeof(struct ehca_mr));
+	} else {
+		EDEB_ERR(3, "alloc failed");
+	}
+
+	return me;
+}
+
+void ehca_mr_delete(struct ehca_mr *me)
+{
+	extern struct ehca_module ehca_module;
+
+	kmem_cache_free(ehca_module.cache_mr, me);
+}
+
+struct ehca_mw *ehca_mw_new(void)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_mw *me;
+
+	me = kmem_cache_alloc(ehca_module.cache_mw, SLAB_KERNEL);
+	if (me) {
+		memset(me, 0, sizeof(struct ehca_mw));
+		spin_lock_init(&me->mwlock);
+		EDEB_EX(7, "ehca_mw=%p sizeof(ehca_mw_t)=%x", me,
+			(u32) sizeof(struct ehca_mw));
+	} else {
+		EDEB_ERR(3, "alloc failed");
+	}
+
+	return me;
+}
+
+void ehca_mw_delete(struct ehca_mw *me)
+{
+	extern struct ehca_module ehca_module;
+
+	kmem_cache_free(ehca_module.cache_mw, me);
+}
+
diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
new file mode 100644
index 0000000..1d72aaf
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -0,0 +1,369 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  struct definitions for hcad internal structures
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
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
+ *  $Id: ehca_classes.h,v 1.80 2006/02/06 16:20:38 schickhj Exp $
+ */
+
+#ifndef __EHCA_CLASSES_H__
+#define __EHCA_CLASSES_H__
+
+#include "ehca_kernel.h"
+#include "ipz_pt_fn.h"
+
+#include <linux/list.h>
+
+struct ehca_module;
+struct ehca_qp;
+struct ehca_cq;
+struct ehca_eq;
+struct ehca_mr;
+struct ehca_mw;
+struct ehca_pd;
+struct ehca_av;
+
+#ifndef CONFIG_PPC64
+#ifndef Z_SERIES
+#error "no series defined"
+#endif
+#endif
+
+#ifdef CONFIG_PPC64
+#include "ehca_classes_pSeries.h"
+#endif
+
+#ifdef Z_SERIES
+#include "ehca_classes_zSeries.h"
+#endif
+
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_user_verbs.h>
+
+#include "ehca_irq.h"
+
+#include "ehca_classes_core.h"
+
+/** @brief HCAD class
+ *
+ * contains HCAD specific data
+ *
+ */
+struct ehca_module {
+	struct list_head shca_list;
+	spinlock_t shca_lock;
+
+	kmem_cache_t *cache_pd;
+	kmem_cache_t *cache_cq;
+	kmem_cache_t *cache_qp;
+	kmem_cache_t *cache_av;
+	kmem_cache_t *cache_mr;
+	kmem_cache_t *cache_mw;
+
+	struct ehca_pfmodule pf; /* plattform specific part of HCA */
+};
+
+/** @brief EQ class
+ */
+struct ehca_eq {
+	u32 length;		    /* length of EQ */
+	struct ipz_queue ipz_queue; /* EQ in kv     */
+	struct ipz_eq_handle ipz_eq_handle;
+	struct ehca_irq_info irq_info;
+	struct work_struct work;
+	struct h_galpas galpas;
+	int    is_initialized;
+
+	struct ehca_pfeq pf; /* plattform specific part of EQ */
+
+	spinlock_t spinlock;
+};
+
+/** static port
+ */
+struct ehca_sport {
+	struct ib_cq *ibcq_aqp1; /* CQ for AQP1 */
+	struct ib_qp *ibqp_aqp1; /* QP for AQP1 */
+	enum ib_port_state port_state;
+};
+
+/** @brief HCA class "static HCA"
+ *
+ * contains HCA specific data per HCA (or vHCA?)
+ * per instance reported by firmware
+ *
+ */
+struct ehca_shca {
+	struct ib_device ib_device;
+	struct ibmebus_dev *ibmebus_dev;
+	u8 num_ports;
+	int hw_level;
+	struct list_head shca_list;
+	struct ipz_adapter_handle ipz_hca_handle; /* firmware HCA handle     */
+	struct ehca_bridge_handle bridge;
+	struct ehca_sport sport[2];
+	struct ehca_eq eq;	/* event queue                        */
+	struct ehca_eq neq;	/* notification event queue           */
+	struct ehca_mr *maxmr;	/* internal max MR (for kernel users) */
+	struct ehca_pd *pd;	/* internal pd (for kernel users)     */
+	struct ehca_pfshca pf;	/* plattform specific part of HCA     */
+	struct h_galpas galpas;
+};
+
+/** @brief protection domain
+ */
+struct ehca_pd {
+	struct ib_pd ib_pd;	/* gen2 qp, must always be first in ehca_pd */
+	struct ipz_pd fw_pd;
+	struct ehca_pfpd pf;
+};
+
+/** @brief QP class
+ */
+struct ehca_qp {
+	struct ib_qp ib_qp;	/* gen2 qp, must always be first in ehca_qp */
+	struct ehca_qp_core ehca_qp_core;	/* common fields for
+						   user/kernel space */
+	u32 token;
+	spinlock_t spinlock_s;
+	spinlock_t spinlock_r;
+	u32 sq_max_inline_data_size; /* max # of inline data can be send */
+	struct ipz_qp_handle ipz_qp_handle; /* QP handle for h-calls            */
+	struct ehca_pfqp pf;	     /* plattform specific part of QP    */
+	struct ib_qp_init_attr init_attr;
+	/* adr mapping for s/r queues and fw handle bw kernel&user space */
+	u64 uspace_squeue;
+	u64 uspace_rqueue;
+	u64 uspace_fwh;
+	struct ehca_cq* send_cq;
+	unsigned int sqerr_purgeflag;
+	struct list_head list_entries;
+};
+
+#define QP_HASHTAB_LEN 7
+/** @brief CQ class
+ */
+struct ehca_cq {
+	struct ib_cq ib_cq;	/* gen2 cq, must always be first
+				   in ehca_cq */
+	struct ehca_cq_core ehca_cq_core; /* common fields for
+					     user/kernel space */
+	spinlock_t spinlock;
+	u32 cq_number;
+	u32 token;
+	u32 nr_of_entries;
+	/* fw specific data common for p+z */
+	struct ipz_cq_handle ipz_cq_handle;	/* CQ handle for h-calls */
+	/* pf specific code */
+	struct ehca_pfcq pf;            /* platform specific part of CQ */
+	spinlock_t cb_lock;             /* completion event handler */
+	/* adr mapping for queue and fw handle bw kernel&user space */
+	u64 uspace_queue;
+	u64 uspace_fwh;
+	struct list_head qp_hashtab[QP_HASHTAB_LEN];
+};
+
+
+/** @brief MR flags
+ */
+enum ehca_mr_flag {
+	EHCA_MR_FLAG_FMR = 0x80000000,	 /* FMR, created with ehca_alloc_fmr */
+	EHCA_MR_FLAG_MAXMR = 0x40000000, /* max-MR                           */
+	EHCA_MR_FLAG_USER = 0x20000000	 /* user space TODO...necessary????. */
+};
+
+/** @brief MR class
+ */
+struct ehca_mr {
+	union {
+		struct ib_mr ib_mr;	/* must always be first in ehca_mr */
+		struct ib_fmr ib_fmr;	/* must always be first in ehca_mr */
+	} ib;
+
+	spinlock_t mrlock;
+
+	/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
+	 * !!! ehca_mr_deletenew() memsets from flags to end of structure
+	 * !!! DON'T move flags or insert another field before.
+	 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
+
+	enum ehca_mr_flag flags;
+	u32 num_pages;		/* number of MR pages */
+	int acl;		/* ACL (stored here for usage in reregister) */
+	u64 *start;		/* virtual start address (stored here for */
+	/* usage in reregister) */
+	u64 size;		/* size (stored here for usage in reregister) */
+	u32 fmr_page_size;	/* page size for FMR */
+	u32 fmr_max_pages;	/* max pages for FMR */
+	u32 fmr_max_maps;	/* max outstanding maps for FMR */
+	u32 fmr_map_cnt;	/* map counter for FMR */
+	/* fw specific data */
+	struct ipz_mrmw_handle ipz_mr_handle;	/* MR handle for h-calls */
+	struct h_galpas galpas;
+	/* data for userspace bridge */
+	u32 nr_of_pages;
+	void *pagearray;
+
+	struct ehca_pfmr pf;	/* platform specific part of MR */
+};
+
+/** @brief MW class
+ */
+struct ehca_mw {
+	struct ib_mw ib_mw;	/* gen2 mw, must always be first in ehca_mw */
+	spinlock_t mwlock;
+
+	u8 never_bound;		/* indication MW was never bound */
+	struct ipz_mrmw_handle ipz_mw_handle;	/* MW handle for h-calls */
+	struct h_galpas galpas;
+
+	struct ehca_pfmw pf;	/* platform specific part of MW */
+};
+
+/** @brief MR page info type
+ */
+enum ehca_mr_pgi_type {
+	EHCA_MR_PGI_PHYS   = 1,  /* type of ehca_reg_phys_mr,
+				  * ehca_rereg_phys_mr,
+				  * ehca_reg_internal_maxmr */
+	EHCA_MR_PGI_USER   = 2,  /* type of ehca_reg_user_mr */
+	EHCA_MR_PGI_FMR    = 3   /* type of ehca_map_phys_fmr */
+};
+
+/** @brief MR page info
+ */
+struct ehca_mr_pginfo {
+	enum ehca_mr_pgi_type type;
+	u64 num_pages;
+	u64 page_count;
+
+	/* type EHCA_MR_PGI_PHYS section */
+	int num_phys_buf;
+	struct ib_phys_buf *phys_buf_array;
+	u64 next_buf;
+	u64 next_page;
+
+	/* type EHCA_MR_PGI_USER section */
+	struct ib_umem *region;
+	struct ib_umem_chunk *next_chunk;
+	u64 next_nmap;
+
+	/* type EHCA_MR_PGI_FMR section */
+	u64 *page_list;
+	u64 next_listelem;
+};
+
+
+/** @brief addres vector suitable for a ud enqueue request
+ */
+struct ehca_av {
+	struct ib_ah ib_ah;	/* gen2 ah, must always be first in ehca_ah */
+	struct ehca_ud_av av;
+};
+
+/** @brief user context
+ */
+struct ehca_ucontext {
+	struct ib_ucontext ib_ucontext;
+};
+
+struct ehca_module *ehca_module_new(void);
+
+int ehca_module_delete(struct ehca_module *me);
+
+int ehca_eq_ctor(struct ehca_eq *eq);
+
+int ehca_eq_dtor(struct ehca_eq *eq);
+
+struct ehca_shca *ehca_shca_new(void);
+
+int ehca_shca_delete(struct ehca_shca *me);
+
+struct ehca_sport *ehca_sport_new(struct ehca_shca *anchor);	/*anchor?? */
+
+struct ehca_cq *ehca_cq_new(void);
+
+int ehca_cq_delete(struct ehca_cq *me);
+
+struct ehca_av *ehca_av_new(void);
+
+int ehca_av_delete(struct ehca_av *me);
+
+struct ehca_pd *ehca_pd_new(void);
+
+void ehca_pd_delete(struct ehca_pd *me);
+
+struct ehca_qp *ehca_qp_new(void);
+
+int ehca_qp_delete(struct ehca_qp *me);
+
+struct ehca_mr *ehca_mr_new(void);
+
+void ehca_mr_delete(struct ehca_mr *me);
+
+struct ehca_mw *ehca_mw_new(void);
+
+void ehca_mw_delete(struct ehca_mw *me);
+
+extern struct rw_semaphore ehca_qp_idr_sem;
+extern struct rw_semaphore ehca_cq_idr_sem;
+extern struct idr ehca_qp_idr;
+extern struct idr ehca_cq_idr;
+
+/*
+ * resp structs for comm bw user and kernel space
+ */
+struct ehca_create_cq_resp {
+	u32 cq_number;
+	u32 token;
+	struct ehca_cq_core ehca_cq_core;
+};
+
+struct ehca_create_qp_resp {
+	u32 qp_num;
+	u32 token;
+	struct ehca_qp_core ehca_qp_core;
+};
+
+/*
+ * helper funcs to link send cq and qp
+ */
+int ehca_cq_assign_qp(struct ehca_cq *cq, struct ehca_qp *qp);
+int ehca_cq_unassign_qp(struct ehca_cq *cq, unsigned int qp_num);
+struct ehca_qp* ehca_cq_get_qp(struct ehca_cq *cq, int qp_num);
+
+#endif				/* __EHCA_CLASSES_H__ */
diff --git a/drivers/infiniband/hw/ehca/ehca_classes_core.h b/drivers/infiniband/hw/ehca/ehca_classes_core.h
new file mode 100644
index 0000000..5e864b3
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_classes_core.h
@@ -0,0 +1,73 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  core struct definitions for hcad internal structures and
+ *  to be used/compiled commonly in user and kernel space
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
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
+ *  $Id: ehca_classes_core.h,v 1.12 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __EHCA_CLASSES_CORE_H__
+#define __EHCA_CLASSES_CORE_H__
+
+#include "ipz_pt_fn_core.h"
+#include "ehca_galpa.h"
+
+/** @brief qp core contains common fields for user/kernel space
+ */
+struct ehca_qp_core {
+	/* kernel space: enum ib_qp_type, user space: enum ibv_qp_type */
+	int qp_type;
+	int dummy1; /* 8 byte alignment */
+	struct ipz_queue ipz_squeue;
+	struct ipz_queue ipz_rqueue;
+	struct h_galpas galpas;
+	unsigned int qkey;
+	int dummy2; /* 8 byte alignment */
+	/* qp_num assigned by ehca: sqp0/1 may have got different numbers */
+	unsigned int real_qp_num;
+};
+
+/** @brief cq core contains common fields for user/kernel space
+ */
+struct ehca_cq_core {
+	struct ipz_queue ipz_queue;
+	struct h_galpas galpas;
+};
+
+#endif /* __EHCA_CLASSES_CORE_H__ */
diff --git a/drivers/infiniband/hw/ehca/ehca_classes_pSeries.h b/drivers/infiniband/hw/ehca/ehca_classes_pSeries.h
new file mode 100644
index 0000000..8f86137
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_classes_pSeries.h
@@ -0,0 +1,256 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  pSeries interface definitions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
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
+ *  $Id: ehca_classes_pSeries.h,v 1.24 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __EHCA_CLASSES_PSERIES_H__
+#define __EHCA_CLASSES_PSERIES_H__
+
+#include "ehca_galpa.h"
+#include "ipz_pt_fn.h"
+
+
+struct ehca_pfmodule {
+};
+
+struct ehca_pfshca {
+};
+
+struct ehca_pfqp {
+	struct ipz_qpt sqpt;
+	struct ipz_qpt rqpt;
+	struct ehca_bridge_handle bridge;
+};
+
+struct ehca_pfcq {
+	struct ipz_qpt qpt;
+	struct ehca_bridge_handle bridge;
+	u32 cqnr;
+};
+
+struct ehca_pfeq {
+	struct ipz_qpt qpt;
+	struct ehca_bridge_handle bridge;
+	struct h_galpa galpa;
+	u32 eqnr;
+};
+
+struct ehca_pfpd {
+};
+
+struct ehca_pfmr {
+	struct ehca_bridge_handle bridge;
+};
+struct ehca_pfmw {
+};
+
+struct ipz_adapter_handle {
+	u64 handle;
+};
+
+struct ipz_cq_handle {
+	u64 handle;
+};
+
+struct ipz_eq_handle {
+	u64 handle;
+};
+
+struct ipz_qp_handle {
+	u64 handle;
+};
+struct ipz_mrmw_handle {
+	u64 handle;
+};
+
+struct ipz_pd {
+	u32 value;
+};
+
+struct hcp_modify_qp_control_block {
+	u32 qkey;                      /* 00 */
+	u32 rdd;                       /* reliable datagram domain */
+	u32 send_psn;                  /* 02 */
+	u32 receive_psn;               /* 03 */
+	u32 prim_phys_port;            /* 04 */
+	u32 alt_phys_port;             /* 05 */
+	u32 prim_p_key_idx;            /* 06 */
+	u32 alt_p_key_idx;             /* 07 */
+	u32 rdma_atomic_ctrl;          /* 08 */
+	u32 qp_state;                  /* 09 */
+	u32 reserved_10;               /* 10 */
+	u32 rdma_nr_atomic_resp_res;   /* 11 */
+	u32 path_migration_state;      /* 12 */
+	u32 rdma_atomic_outst_dest_qp; /* 13 */
+	u32 dest_qp_nr;                /* 14 */
+	u32 min_rnr_nak_timer_field;   /* 15 */
+	u32 service_level;             /* 16 */
+	u32 send_grh_flag;             /* 17 */
+	u32 retry_count;               /* 18 */
+	u32 timeout;                   /* 19 */
+	u32 path_mtu;                  /* 20 */
+	u32 max_static_rate;           /* 21 */
+	u32 dlid;                      /* 22 */
+	u32 rnr_retry_count;           /* 23 */
+	u32 source_path_bits;          /* 24 */
+	u32 traffic_class;             /* 25 */
+	u32 hop_limit;                 /* 26 */
+	u32 source_gid_idx;            /* 27 */
+	u32 flow_label;                /* 28 */
+	u32 reserved_29;               /* 29 */
+	union {                        /* 30 */
+		u64 dw[2];
+		u8 byte[16];
+	} dest_gid;
+	u32 service_level_al;          /* 34 */
+	u32 send_grh_flag_al;          /* 35 */
+	u32 retry_count_al;            /* 36 */
+	u32 timeout_al;                /* 37 */
+	u32 max_static_rate_al;        /* 38 */
+	u32 dlid_al;                   /* 39 */
+	u32 rnr_retry_count_al;        /* 40 */
+	u32 source_path_bits_al;       /* 41 */
+	u32 traffic_class_al;          /* 42 */
+	u32 hop_limit_al;              /* 43 */
+	u32 source_gid_idx_al;         /* 44 */
+	u32 flow_label_al;             /* 45 */
+	u32 reserved_46;               /* 46 */
+	u32 reserved_47;               /* 47 */
+	union {                        /* 48 */
+		u64 dw[2];
+		u8 byte[16];
+	} dest_gid_al;
+	u32 max_nr_outst_send_wr;      /* 52 */
+	u32 max_nr_outst_recv_wr;      /* 53 */
+	u32 disable_ete_credit_check;  /* 54 */
+	u32 qp_number;                 /* 55 */
+	u64 send_queue_handle;         /* 56 */
+	u64 recv_queue_handle;         /* 58 */
+	u32 actual_nr_sges_in_sq_wqe;  /* 60 */
+	u32 actual_nr_sges_in_rq_wqe;  /* 61 */
+	u32 qp_enable;                 /* 62 */
+	u32 curr_srq_limit;            /* 63 */
+	u64 qp_aff_asyn_ev_log_reg;    /* 64 */
+	u64 shared_rq_hndl;            /* 66 */
+	u64 trigg_doorbell_qp_hndl;    /* 68 */
+	u32 reserved_70_127[58];       /* 70 */
+};
+
+#define MQPCB_MASK_QKEY                         EHCA_BMASK_IBM(0,0)
+#define MQPCB_MASK_SEND_PSN                     EHCA_BMASK_IBM(2,2)
+#define MQPCB_MASK_RECEIVE_PSN                  EHCA_BMASK_IBM(3,3)
+#define MQPCB_MASK_PRIM_PHYS_PORT               EHCA_BMASK_IBM(4,4)
+#define MQPCB_PRIM_PHYS_PORT                    EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_ALT_PHYS_PORT                EHCA_BMASK_IBM(5,5)
+#define MQPCB_MASK_PRIM_P_KEY_IDX               EHCA_BMASK_IBM(6,6)
+#define MQPCB_PRIM_P_KEY_IDX                    EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_ALT_P_KEY_IDX                EHCA_BMASK_IBM(7,7)
+#define MQPCB_MASK_RDMA_ATOMIC_CTRL             EHCA_BMASK_IBM(8,8)
+#define MQPCB_MASK_QP_STATE                     EHCA_BMASK_IBM(9,9)
+#define MQPCB_QP_STATE                          EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_RDMA_NR_ATOMIC_RESP_RES      EHCA_BMASK_IBM(11,11)
+#define MQPCB_MASK_PATH_MIGRATION_STATE         EHCA_BMASK_IBM(12,12)
+#define MQPCB_MASK_RDMA_ATOMIC_OUTST_DEST_QP    EHCA_BMASK_IBM(13,13)
+#define MQPCB_MASK_DEST_QP_NR                   EHCA_BMASK_IBM(14,14)
+#define MQPCB_MASK_MIN_RNR_NAK_TIMER_FIELD      EHCA_BMASK_IBM(15,15)
+#define MQPCB_MASK_SERVICE_LEVEL                EHCA_BMASK_IBM(16,16)
+#define MQPCB_MASK_SEND_GRH_FLAG                EHCA_BMASK_IBM(17,17)
+#define MQPCB_MASK_RETRY_COUNT                  EHCA_BMASK_IBM(18,18)
+#define MQPCB_MASK_TIMEOUT                      EHCA_BMASK_IBM(19,19)
+#define MQPCB_MASK_PATH_MTU                     EHCA_BMASK_IBM(20,20)
+#define MQPCB_PATH_MTU                          EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_MAX_STATIC_RATE              EHCA_BMASK_IBM(21,21)
+#define MQPCB_MAX_STATIC_RATE                   EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_DLID                         EHCA_BMASK_IBM(22,22)
+#define MQPCB_DLID                              EHCA_BMASK_IBM(16,31)
+#define MQPCB_MASK_RNR_RETRY_COUNT              EHCA_BMASK_IBM(23,23)
+#define MQPCB_RNR_RETRY_COUNT                   EHCA_BMASK_IBM(29,31)
+#define MQPCB_MASK_SOURCE_PATH_BITS             EHCA_BMASK_IBM(24,24)
+#define MQPCB_SOURCE_PATH_BITS                  EHCA_BMASK_IBM(25,31)
+#define MQPCB_MASK_TRAFFIC_CLASS                EHCA_BMASK_IBM(25,25)
+#define MQPCB_TRAFFIC_CLASS                     EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_HOP_LIMIT                    EHCA_BMASK_IBM(26,26)
+#define MQPCB_HOP_LIMIT                         EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_SOURCE_GID_IDX               EHCA_BMASK_IBM(27,27)
+#define MQPCB_SOURCE_GID_IDX                    EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_FLOW_LABEL                   EHCA_BMASK_IBM(28,28)
+#define MQPCB_FLOW_LABEL                        EHCA_BMASK_IBM(12,31)
+#define MQPCB_MASK_DEST_GID                     EHCA_BMASK_IBM(30,30)
+#define MQPCB_MASK_SERVICE_LEVEL_AL             EHCA_BMASK_IBM(31,31)
+#define MQPCB_SERVICE_LEVEL_AL                  EHCA_BMASK_IBM(28,31)
+#define MQPCB_MASK_SEND_GRH_FLAG_AL             EHCA_BMASK_IBM(32,32)
+#define MQPCB_SEND_GRH_FLAG_AL                  EHCA_BMASK_IBM(31,31)
+#define MQPCB_MASK_RETRY_COUNT_AL               EHCA_BMASK_IBM(33,33)
+#define MQPCB_RETRY_COUNT_AL                    EHCA_BMASK_IBM(29,31)
+#define MQPCB_MASK_TIMEOUT_AL                   EHCA_BMASK_IBM(34,34)
+#define MQPCB_TIMEOUT_AL                        EHCA_BMASK_IBM(27,31)
+#define MQPCB_MASK_MAX_STATIC_RATE_AL           EHCA_BMASK_IBM(35,35)
+#define MQPCB_MAX_STATIC_RATE_AL                EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_DLID_AL                      EHCA_BMASK_IBM(36,36)
+#define MQPCB_DLID_AL                           EHCA_BMASK_IBM(16,31)
+#define MQPCB_MASK_RNR_RETRY_COUNT_AL           EHCA_BMASK_IBM(37,37)
+#define MQPCB_RNR_RETRY_COUNT_AL                EHCA_BMASK_IBM(29,31)
+#define MQPCB_MASK_SOURCE_PATH_BITS_AL          EHCA_BMASK_IBM(38,38)
+#define MQPCB_SOURCE_PATH_BITS_AL               EHCA_BMASK_IBM(25,31)
+#define MQPCB_MASK_TRAFFIC_CLASS_AL             EHCA_BMASK_IBM(39,39)
+#define MQPCB_TRAFFIC_CLASS_AL                  EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_HOP_LIMIT_AL                 EHCA_BMASK_IBM(40,40)
+#define MQPCB_HOP_LIMIT_AL                      EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_SOURCE_GID_IDX_AL            EHCA_BMASK_IBM(41,41)
+#define MQPCB_SOURCE_GID_IDX_AL                 EHCA_BMASK_IBM(24,31)
+#define MQPCB_MASK_FLOW_LABEL_AL                EHCA_BMASK_IBM(42,42)
+#define MQPCB_FLOW_LABEL_AL                     EHCA_BMASK_IBM(12,31)
+#define MQPCB_MASK_DEST_GID_AL                  EHCA_BMASK_IBM(44,44)
+#define MQPCB_MASK_MAX_NR_OUTST_SEND_WR         EHCA_BMASK_IBM(45,45)
+#define MQPCB_MAX_NR_OUTST_SEND_WR              EHCA_BMASK_IBM(16,31)
+#define MQPCB_MASK_MAX_NR_OUTST_RECV_WR         EHCA_BMASK_IBM(46,46)
+#define MQPCB_MAX_NR_OUTST_RECV_WR              EHCA_BMASK_IBM(16,31)
+#define MQPCB_MASK_DISABLE_ETE_CREDIT_CHECK     EHCA_BMASK_IBM(47,47)
+#define MQPCB_DISABLE_ETE_CREDIT_CHECK          EHCA_BMASK_IBM(31,31)
+#define MQPCB_QP_NUMBER                         EHCA_BMASK_IBM(8,31)
+#define MQPCB_MASK_QP_ENABLE                    EHCA_BMASK_IBM(48,48)
+#define MQPCB_QP_ENABLE                         EHCA_BMASK_IBM(31,31)
+#define MQPCB_MASK_CURR_SQR_LIMIT               EHCA_BMASK_IBM(49,49)
+#define MQPCB_CURR_SQR_LIMIT                    EHCA_BMASK_IBM(15,31)
+#define MQPCB_MASK_QP_AFF_ASYN_EV_LOG_REG       EHCA_BMASK_IBM(50,50)
+#define MQPCB_MASK_SHARED_RQ_HNDL               EHCA_BMASK_IBM(51,51)
+
+#endif /* __EHCA_CLASSES_PSERIES_H__ */
