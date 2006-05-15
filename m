Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWEORlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWEORlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWEORlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:41:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:36856 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751624AbWEORk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:40:58 -0400
Message-ID: <4468BD41.4010803@de.ibm.com>
Date: Mon, 15 May 2006 19:41:21 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 02/16] ehca: structure definitions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  drivers/infiniband/hw/ehca/ehca_classes.h         |  350 ++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ehca_classes_pSeries.h |  251 +++++++++++++++
  2 files changed, 601 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_classes.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_classes.h	2006-05-12 12:48:21.000000000 +0200
@@ -0,0 +1,350 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Struct definition for eHCA internal structures
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
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
+#ifndef __EHCA_CLASSES_H__
+#define __EHCA_CLASSES_H__
+
+#include "ehca_classes.h"
+#include "ipz_pt_fn.h"
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
+#ifdef CONFIG_PPC64
+#include "ehca_classes_pSeries.h"
+#endif
+
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_user_verbs.h>
+
+#include "ehca_irq.h"
+
+struct ehca_module {
+	struct list_head shca_list;
+	spinlock_t shca_lock;
+	struct timer_list timer;
+	kmem_cache_t *cache_pd;
+	kmem_cache_t *cache_cq;
+	kmem_cache_t *cache_qp;
+	kmem_cache_t *cache_av;
+	kmem_cache_t *cache_mr;
+	kmem_cache_t *cache_mw;
+	struct ehca_pfmodule pf;
+};
+
+struct ehca_eq {
+	u32 length;
+	struct ipz_queue ipz_queue;
+	struct ipz_eq_handle ipz_eq_handle;
+	struct work_struct work;
+	struct h_galpas galpas;
+	int is_initialized;
+	struct ehca_pfeq pf;
+	spinlock_t spinlock;
+	struct tasklet_struct interrupt_task;
+	u32 ist;
+};
+
+struct ehca_sport {
+	struct ib_cq *ibcq_aqp1;
+	struct ib_qp *ibqp_aqp1;
+	enum ib_rate  rate;
+	enum ib_port_state port_state;
+};
+
+struct ehca_shca {
+	struct ib_device ib_device;
+	struct ibmebus_dev *ibmebus_dev;
+	u8 num_ports;
+	int hw_level;
+	struct list_head shca_list;
+	struct ipz_adapter_handle ipz_hca_handle;
+	struct ehca_sport sport[2];
+	struct ehca_eq eq;
+	struct ehca_eq neq;
+	struct ehca_mr *maxmr;
+	struct ehca_pd *pd;
+	struct ehca_pfshca pf;
+	struct h_galpas galpas;
+};
+
+struct ehca_pd {
+	struct ib_pd ib_pd;
+	struct ipz_pd fw_pd;
+	struct ehca_pfpd pf;
+	u32 ownpid;
+};
+
+struct ehca_qp {
+	struct ib_qp ib_qp;
+	u32 qp_type;
+	struct ipz_queue ipz_squeue;
+	struct ipz_queue ipz_rqueue;
+	struct h_galpas galpas;
+	u32 qkey;
+	u32 real_qp_num;
+	u32 token;
+	spinlock_t spinlock_s;
+	spinlock_t spinlock_r;
+	u32 sq_max_inline_data_size;
+	struct ipz_qp_handle ipz_qp_handle;
+	struct ehca_pfqp pf;
+	struct ib_qp_init_attr init_attr;
+	u64 uspace_squeue;
+	u64 uspace_rqueue;
+	u64 uspace_fwh;
+	struct ehca_cq *send_cq;
+	struct ehca_cq *recv_cq;
+	unsigned int sqerr_purgeflag;
+	struct hlist_node list_entries;
+};
+
+/* must be power of 2 */
+#define QP_HASHTAB_LEN 8
+
+struct ehca_cq {
+	struct ib_cq ib_cq;
+	struct ipz_queue ipz_queue;
+	struct h_galpas galpas;
+	spinlock_t spinlock;
+	u32 cq_number;
+	u32 token;
+	u32 nr_of_entries;
+	struct ipz_cq_handle ipz_cq_handle;
+	struct ehca_pfcq pf;
+	spinlock_t cb_lock;
+	u64 uspace_queue;
+	u64 uspace_fwh;
+	struct hlist_head qp_hashtab[QP_HASHTAB_LEN];
+	struct list_head entry;
+	u32 nr_callbacks;
+	spinlock_t task_lock;
+	u32 ownpid;
+};
+
+enum ehca_mr_flag {
+	EHCA_MR_FLAG_FMR = 0x80000000,	 /* FMR, created with ehca_alloc_fmr */
+	EHCA_MR_FLAG_MAXMR = 0x40000000, /* max-MR                           */
+};
+
+struct ehca_mr {
+	union {
+		struct ib_mr ib_mr;	/* must always be first in ehca_mr */
+		struct ib_fmr ib_fmr;	/* must always be first in ehca_mr */
+	} ib;
+	spinlock_t mrlock;
+
+	enum ehca_mr_flag flags;
+	u32 num_pages;		/* number of MR pages */
+	u32 num_4k;		/* number of 4k "page" portions to form MR */
+	int acl;		/* ACL (stored here for usage in reregister) */
+	u64 *start;		/* virtual start address (stored here for */
+	                        /* usage in reregister) */
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
+enum ehca_mr_pgi_type {
+	EHCA_MR_PGI_PHYS   = 1,  /* type of ehca_reg_phys_mr,
+				  * ehca_rereg_phys_mr,
+				  * ehca_reg_internal_maxmr */
+	EHCA_MR_PGI_USER   = 2,  /* type of ehca_reg_user_mr */
+	EHCA_MR_PGI_FMR    = 3   /* type of ehca_map_phys_fmr */
+};
+
+struct ehca_mr_pginfo {
+	enum ehca_mr_pgi_type type;
+	u64 num_pages;
+	u64 page_cnt;
+	u64 num_4k;       /* number of 4k "page" portions */
+	u64 page_4k_cnt;  /* counter for 4k "page" portions */
+	u64 next_4k;      /* next 4k "page" portion in buffer/chunk/listelem */
+
+	/* type EHCA_MR_PGI_PHYS section */
+	int num_phys_buf;
+	struct ib_phys_buf *phys_buf_array;
+	u64 next_buf;
+
+	/* type EHCA_MR_PGI_USER section */
+	struct ib_umem *region;
+	struct ib_umem_chunk *next_chunk;
+	u64 next_nmap;
+
+	/* type EHCA_MR_PGI_FMR section */
+	u64 *page_list;
+	u64 next_listelem;
+	/* next_4k also used within EHCA_MR_PGI_FMR */
+};
+
+/* output parameters for MR/FMR hipz calls */
+struct ehca_mr_hipzout_parms {
+	struct ipz_mrmw_handle handle;
+	u32 lkey;
+	u32 rkey;
+	u64 len;
+	u64 vaddr;
+	u32 acl;
+};
+
+/* output parameters for MW hipz calls */
+struct ehca_mw_hipzout_parms {
+	struct ipz_mrmw_handle handle;
+	u32 rkey;
+};
+
+struct ehca_av {
+	struct ib_ah ib_ah;
+	struct ehca_ud_av av;
+};
+
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
+struct ehca_sport *ehca_sport_new(struct ehca_shca *anchor);
+
+extern spinlock_t ehca_qp_idr_lock;
+extern spinlock_t ehca_cq_idr_lock;
+extern struct idr ehca_qp_idr;
+extern struct idr ehca_cq_idr;
+
+struct ipzu_queue_resp {
+	u64 queue;        /* points to first queue entry */
+	u32 qe_size;      /* queue entry size */
+	u32 act_nr_of_sg;
+	u32 queue_length; /* queue length allocated in bytes */
+	u32 pagesize;
+	u32 toggle_state;
+	u32 dummy; /* padding for 8 byte alignment */
+};
+
+struct ehca_create_cq_resp {
+	u32 cq_number;
+	u32 token;
+	struct ipzu_queue_resp ipz_queue;
+	struct h_galpas galpas;
+};
+
+struct ehca_create_qp_resp {
+	u32 qp_num;
+	u32 token;
+	u32 qp_type;
+	u32 qkey;
+	/* qp_num assigned by ehca: sqp0/1 may have got different numbers */
+	u32 real_qp_num;
+	u32 dummy; /* padding for 8 byte alignment */
+	struct ipzu_queue_resp ipz_squeue;
+	struct ipzu_queue_resp ipz_rqueue;
+	struct h_galpas galpas;
+};
+
+struct ehca_alloc_cq_parms {
+	u32 nr_cqe;
+	u32 act_nr_of_entries;
+	u32 act_pages;
+	struct ipz_eq_handle eq_handle;
+};
+
+struct ehca_alloc_qp_parms {
+	int servicetype;
+	int sigtype;
+	int daqp_ctrl;
+	int max_send_sge;
+	int max_recv_sge;
+	int ud_av_l_key_ctl;
+
+	u16 act_nr_send_wqes;
+	u16 act_nr_recv_wqes;
+	u8  act_nr_recv_sges;
+	u8  act_nr_send_sges;
+
+	u32 nr_rq_pages;
+	u32 nr_sq_pages;
+
+	struct ipz_eq_handle ipz_eq_handle;
+	struct ipz_pd pd;
+};
+
+int ehca_cq_assign_qp(struct ehca_cq *cq, struct ehca_qp *qp);
+int ehca_cq_unassign_qp(struct ehca_cq *cq, unsigned int qp_num);
+struct ehca_qp* ehca_cq_get_qp(struct ehca_cq *cq, int qp_num);
+
+#endif
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_classes_pSeries.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_classes_pSeries.h	2006-04-28 14:20:07.000000000 +0200
@@ -0,0 +1,251 @@
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
+ */
+
+#ifndef __EHCA_CLASSES_PSERIES_H__
+#define __EHCA_CLASSES_PSERIES_H__
+
+#include "hcp_phyp.h"
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
+};
+
+struct ehca_pfcq {
+	struct ipz_qpt qpt;
+	u32 cqnr;
+};
+
+struct ehca_pfeq {
+	struct ipz_qpt qpt;
+	struct h_galpa galpa;
+	u32 eqnr;
+};
+
+struct ehca_pfpd {
+};
+
+struct ehca_pfmr {
+};
+
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


