Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWHQUNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWHQUNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWHQULv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:11:51 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:20743 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1030254AbWHQULE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:11:04 -0400
X-IronPort-AV: i="4.08,139,1154934000"; 
   d="scan'208"; a="336821743:sNHT64337988"
Cc: schihei@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: [PATCH 10/13] IB/ehca: hipz
In-Reply-To: <20068171311.sHGelL4wOwoc17UG@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 17 Aug 2006 13:11:02 -0700
Message-Id: <20068171311.jebQ3TFd5jvynHCW@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 17 Aug 2006 20:11:02.0347 (UTC) FILETIME=[433A81B0:01C6C239]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rolandd@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/infiniband/hw/ehca/hipz_fns.h      |   68 +++++
 drivers/infiniband/hw/ehca/hipz_fns_core.h |  122 +++++++++
 drivers/infiniband/hw/ehca/hipz_hw.h       |  390 ++++++++++++++++++++++++++++
 3 files changed, 580 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hipz_fns.h b/drivers/infiniband/hw/ehca/hipz_fns.h
new file mode 100644
index 0000000..9dac93d
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hipz_fns.h
@@ -0,0 +1,68 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  HW abstraction register functions
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+#ifndef __HIPZ_FNS_H__
+#define __HIPZ_FNS_H__
+
+#include "ehca_classes.h"
+#include "hipz_hw.h"
+
+#include "hipz_fns_core.h"
+
+#define hipz_galpa_store_eq(gal, offset, value) \
+	hipz_galpa_store(gal, EQTEMM_OFFSET(offset), value)
+
+#define hipz_galpa_load_eq(gal, offset) \
+	hipz_galpa_load(gal, EQTEMM_OFFSET(offset))
+
+#define hipz_galpa_store_qped(gal, offset, value) \
+	hipz_galpa_store(gal, QPEDMM_OFFSET(offset), value)
+
+#define hipz_galpa_load_qped(gal, offset) \
+	hipz_galpa_load(gal, QPEDMM_OFFSET(offset))
+
+#define hipz_galpa_store_mrmw(gal, offset, value) \
+	hipz_galpa_store(gal, MRMWMM_OFFSET(offset), value)
+
+#define hipz_galpa_load_mrmw(gal, offset) \
+	hipz_galpa_load(gal, MRMWMM_OFFSET(offset))
+
+#endif
diff --git a/drivers/infiniband/hw/ehca/hipz_fns_core.h b/drivers/infiniband/hw/ehca/hipz_fns_core.h
new file mode 100644
index 0000000..ff8d7ed
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hipz_fns_core.h
@@ -0,0 +1,122 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  HW abstraction register functions
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Heiko J Schick <schickhj@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+#ifndef __HIPZ_FNS_CORE_H__
+#define __HIPZ_FNS_CORE_H__
+
+#include "hcp_phyp.h"
+#include "hipz_hw.h"
+
+#define hipz_galpa_store_cq(gal, offset, value) \
+	hipz_galpa_store(gal, CQTEMM_OFFSET(offset), value)
+
+#define hipz_galpa_load_cq(gal, offset) \
+	hipz_galpa_load(gal, CQTEMM_OFFSET(offset))
+
+#define hipz_galpa_store_qp(gal,offset, value) \
+	hipz_galpa_store(gal, QPTEMM_OFFSET(offset), value)
+#define hipz_galpa_load_qp(gal, offset) \
+	hipz_galpa_load(gal,QPTEMM_OFFSET(offset))
+
+static inline void hipz_update_sqa(struct ehca_qp *qp, u16 nr_wqes)
+{
+	struct h_galpa gal;
+
+	EDEB_EN(7, "qp=%p", qp);
+	gal = qp->galpas.kernel;
+	/*  ringing doorbell :-) */
+	hipz_galpa_store_qp(gal, qpx_sqa, EHCA_BMASK_SET(QPX_SQADDER, nr_wqes));
+	EDEB_EX(7, "qp=%p QPx_SQA = %i", qp, nr_wqes);
+}
+
+static inline void hipz_update_rqa(struct ehca_qp *qp, u16 nr_wqes)
+{
+	struct h_galpa gal;
+
+	EDEB_EN(7, "qp=%p", qp);
+	gal = qp->galpas.kernel;
+	/*  ringing doorbell :-) */
+	hipz_galpa_store_qp(gal, qpx_rqa, EHCA_BMASK_SET(QPX_RQADDER, nr_wqes));
+	EDEB_EX(7, "qp=%p QPx_RQA = %i", qp, nr_wqes);
+}
+
+static inline void hipz_update_feca(struct ehca_cq *cq, u32 nr_cqes)
+{
+	struct h_galpa gal;
+
+	EDEB_EN(7, "cq=%p", cq);
+	gal = cq->galpas.kernel;
+	hipz_galpa_store_cq(gal, cqx_feca,
+			    EHCA_BMASK_SET(CQX_FECADDER, nr_cqes));
+	EDEB_EX(7, "cq=%p CQx_FECA = %i", cq, nr_cqes);
+}
+
+static inline void hipz_set_cqx_n0(struct ehca_cq *cq, u32 value)
+{
+	struct h_galpa gal;
+	u64 CQx_N0_reg = 0;
+
+	EDEB_EN(7, "cq=%p event on solicited completion -- write CQx_N0", cq);
+	gal = cq->galpas.kernel;
+	hipz_galpa_store_cq(gal, cqx_n0,
+			    EHCA_BMASK_SET(CQX_N0_GENERATE_SOLICITED_COMP_EVENT,
+					   value));
+	CQx_N0_reg = hipz_galpa_load_cq(gal, cqx_n0);
+	EDEB_EX(7, "cq=%p loaded CQx_N0=%lx", cq, (unsigned long)CQx_N0_reg);
+}
+
+static inline void hipz_set_cqx_n1(struct ehca_cq *cq, u32 value)
+{
+	struct h_galpa gal;
+	u64 CQx_N1_reg = 0;
+
+	EDEB_EN(7, "cq=%p event on completion -- write CQx_N1",
+		cq);
+	gal = cq->galpas.kernel;
+	hipz_galpa_store_cq(gal, cqx_n1,
+			    EHCA_BMASK_SET(CQX_N1_GENERATE_COMP_EVENT, value));
+	CQx_N1_reg = hipz_galpa_load_cq(gal, cqx_n1);
+	EDEB_EX(7, "cq=%p loaded CQx_N1=%lx", cq, (unsigned long)CQx_N1_reg);
+}
+
+#endif /* __HIPZ_FNC_CORE_H__ */
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
new file mode 100644
index 0000000..f5f4871
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -0,0 +1,390 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  eHCA register definitions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
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
+#ifndef __HIPZ_HW_H__
+#define __HIPZ_HW_H__
+
+#include "ehca_tools.h"
+
+/* QP Table Entry Memory Map */
+struct hipz_qptemm {
+	u64 qpx_hcr;
+	u64 qpx_c;
+	u64 qpx_herr;
+	u64 qpx_aer;
+/* 0x20*/
+	u64 qpx_sqa;
+	u64 qpx_sqc;
+	u64 qpx_rqa;
+	u64 qpx_rqc;
+/* 0x40*/
+	u64 qpx_st;
+	u64 qpx_pmstate;
+	u64 qpx_pmfa;
+	u64 qpx_pkey;
+/* 0x60*/
+	u64 qpx_pkeya;
+	u64 qpx_pkeyb;
+	u64 qpx_pkeyc;
+	u64 qpx_pkeyd;
+/* 0x80*/
+	u64 qpx_qkey;
+	u64 qpx_dqp;
+	u64 qpx_dlidp;
+	u64 qpx_portp;
+/* 0xa0*/
+	u64 qpx_slidp;
+	u64 qpx_slidpp;
+	u64 qpx_dlida;
+	u64 qpx_porta;
+/* 0xc0*/
+	u64 qpx_slida;
+	u64 qpx_slidpa;
+	u64 qpx_slvl;
+	u64 qpx_ipd;
+/* 0xe0*/
+	u64 qpx_mtu;
+	u64 qpx_lato;
+	u64 qpx_rlimit;
+	u64 qpx_rnrlimit;
+/* 0x100*/
+	u64 qpx_t;
+	u64 qpx_sqhp;
+	u64 qpx_sqptp;
+	u64 qpx_nspsn;
+/* 0x120*/
+	u64 qpx_nspsnhwm;
+	u64 reserved1;
+	u64 qpx_sdsi;
+	u64 qpx_sdsbc;
+/* 0x140*/
+	u64 qpx_sqwsize;
+	u64 qpx_sqwts;
+	u64 qpx_lsn;
+	u64 qpx_nssn;
+/* 0x160 */
+	u64 qpx_mor;
+	u64 qpx_cor;
+	u64 qpx_sqsize;
+	u64 qpx_erc;
+/* 0x180*/
+	u64 qpx_rnrrc;
+	u64 qpx_ernrwt;
+	u64 qpx_rnrresp;
+	u64 qpx_lmsna;
+/* 0x1a0 */
+	u64 qpx_sqhpc;
+	u64 qpx_sqcptp;
+	u64 qpx_sigt;
+	u64 qpx_wqecnt;
+/* 0x1c0*/
+	u64 qpx_rqhp;
+	u64 qpx_rqptp;
+	u64 qpx_rqsize;
+	u64 qpx_nrr;
+/* 0x1e0*/
+	u64 qpx_rdmac;
+	u64 qpx_nrpsn;
+	u64 qpx_lapsn;
+	u64 qpx_lcr;
+/* 0x200*/
+	u64 qpx_rwc;
+	u64 qpx_rwva;
+	u64 qpx_rdsi;
+	u64 qpx_rdsbc;
+/* 0x220*/
+	u64 qpx_rqwsize;
+	u64 qpx_crmsn;
+	u64 qpx_rdd;
+	u64 qpx_larpsn;
+/* 0x240*/
+	u64 qpx_pd;
+	u64 qpx_scqn;
+	u64 qpx_rcqn;
+	u64 qpx_aeqn;
+/* 0x260*/
+	u64 qpx_aaelog;
+	u64 qpx_ram;
+	u64 qpx_rdmaqe0;
+	u64 qpx_rdmaqe1;
+/* 0x280*/
+	u64 qpx_rdmaqe2;
+	u64 qpx_rdmaqe3;
+	u64 qpx_nrpsnhwm;
+/* 0x298*/
+	u64 reserved[(0x400 - 0x298) / 8];
+/* 0x400 extended data */
+	u64 reserved_ext[(0x500 - 0x400) / 8];
+/* 0x500 */
+	u64 reserved2[(0x1000 - 0x500) / 8];
+/* 0x1000      */
+};
+
+#define QPX_SQADDER EHCA_BMASK_IBM(48,63)
+#define QPX_RQADDER EHCA_BMASK_IBM(48,63)
+
+#define QPTEMM_OFFSET(x) offsetof(struct hipz_qptemm,x)
+
+/* MRMWPT Entry Memory Map */
+struct hipz_mrmwmm {
+	/* 0x00 */
+	u64 mrx_hcr;
+
+	u64 mrx_c;
+	u64 mrx_herr;
+	u64 mrx_aer;
+	/* 0x20 */
+	u64 mrx_pp;
+	u64 reserved1;
+	u64 reserved2;
+	u64 reserved3;
+	/* 0x40 */
+	u64 reserved4[(0x200 - 0x40) / 8];
+	/* 0x200 */
+	u64 mrx_ctl[64];
+
+};
+
+#define MRX_HCR_LPARID_VALID EHCA_BMASK_IBM(0,0)
+
+#define MRMWMM_OFFSET(x) offsetof(struct hipz_mrmwmm,x)
+
+struct hipz_qpedmm {
+	/* 0x00 */
+	u64 reserved0[(0x400) / 8];
+	/* 0x400 */
+	u64 qpedx_phh;
+	u64 qpedx_ppsgp;
+	/* 0x410 */
+	u64 qpedx_ppsgu;
+	u64 qpedx_ppdgp;
+	/* 0x420 */
+	u64 qpedx_ppdgu;
+	u64 qpedx_aph;
+	/* 0x430 */
+	u64 qpedx_apsgp;
+	u64 qpedx_apsgu;
+	/* 0x440 */
+	u64 qpedx_apdgp;
+	u64 qpedx_apdgu;
+	/* 0x450 */
+	u64 qpedx_apav;
+	u64 qpedx_apsav;
+	/* 0x460  */
+	u64 qpedx_hcr;
+	u64 reserved1[4];
+	/* 0x488 */
+	u64 qpedx_rrl0;
+	/* 0x490 */
+	u64 qpedx_rrrkey0;
+	u64 qpedx_rrva0;
+	/* 0x4a0 */
+	u64 reserved2;
+	u64 qpedx_rrl1;
+	/* 0x4b0 */
+	u64 qpedx_rrrkey1;
+	u64 qpedx_rrva1;
+	/* 0x4c0 */
+	u64 reserved3;
+	u64 qpedx_rrl2;
+	/* 0x4d0 */
+	u64 qpedx_rrrkey2;
+	u64 qpedx_rrva2;
+	/* 0x4e0 */
+	u64 reserved4;
+	u64 qpedx_rrl3;
+	/* 0x4f0 */
+	u64 qpedx_rrrkey3;
+	u64 qpedx_rrva3;
+};
+
+#define QPEDMM_OFFSET(x) offsetof(struct hipz_qpedmm,x)
+
+/* CQ Table Entry Memory Map */
+struct hipz_cqtemm {
+	u64 cqx_hcr;
+	u64 cqx_c;
+	u64 cqx_herr;
+	u64 cqx_aer;
+/* 0x20  */
+	u64 cqx_ptp;
+	u64 cqx_tp;
+	u64 cqx_fec;
+	u64 cqx_feca;
+/* 0x40  */
+	u64 cqx_ep;
+	u64 cqx_eq;
+/* 0x50  */
+	u64 reserved1;
+	u64 cqx_n0;
+/* 0x60  */
+	u64 cqx_n1;
+	u64 reserved2[(0x1000 - 0x60) / 8];
+/* 0x1000 */
+};
+
+#define CQX_FEC_CQE_CNT           EHCA_BMASK_IBM(32,63)
+#define CQX_FECADDER              EHCA_BMASK_IBM(32,63)
+#define CQX_N0_GENERATE_SOLICITED_COMP_EVENT EHCA_BMASK_IBM(0,0)
+#define CQX_N1_GENERATE_COMP_EVENT EHCA_BMASK_IBM(0,0)
+
+#define CQTEMM_OFFSET(x) offsetof(struct hipz_cqtemm,x)
+
+/* EQ Table Entry Memory Map */
+struct hipz_eqtemm {
+	u64 eqx_hcr;
+	u64 eqx_c;
+
+	u64 eqx_herr;
+	u64 eqx_aer;
+/* 0x20 */
+	u64 eqx_ptp;
+	u64 eqx_tp;
+	u64 eqx_ssba;
+	u64 eqx_psba;
+
+/* 0x40 */
+	u64 eqx_cec;
+	u64 eqx_meql;
+	u64 eqx_xisbi;
+	u64 eqx_xisc;
+/* 0x60 */
+	u64 eqx_it;
+
+};
+
+#define EQTEMM_OFFSET(x) offsetof(struct hipz_eqtemm,x)
+
+/* access control defines for MR/MW */
+#define HIPZ_ACCESSCTRL_L_WRITE  0x00800000
+#define HIPZ_ACCESSCTRL_R_WRITE  0x00400000
+#define HIPZ_ACCESSCTRL_R_READ   0x00200000
+#define HIPZ_ACCESSCTRL_R_ATOMIC 0x00100000
+#define HIPZ_ACCESSCTRL_MW_BIND  0x00080000
+
+/* query hca response block */
+struct hipz_query_hca {
+	u32 cur_reliable_dg;
+	u32 cur_qp;
+	u32 cur_cq;
+	u32 cur_eq;
+	u32 cur_mr;
+	u32 cur_mw;
+	u32 cur_ee_context;
+	u32 cur_mcast_grp;
+	u32 cur_qp_attached_mcast_grp;
+	u32 reserved1;
+	u32 cur_ipv6_qp;
+	u32 cur_eth_qp;
+	u32 cur_hp_mr;
+	u32 reserved2[3];
+	u32 max_rd_domain;
+	u32 max_qp;
+	u32 max_cq;
+	u32 max_eq;
+	u32 max_mr;
+	u32 max_hp_mr;
+	u32 max_mw;
+	u32 max_mrwpte;
+	u32 max_special_mrwpte;
+	u32 max_rd_ee_context;
+	u32 max_mcast_grp;
+	u32 max_total_mcast_qp_attach;
+	u32 max_mcast_qp_attach;
+	u32 max_raw_ipv6_qp;
+	u32 max_raw_ethy_qp;
+	u32 internal_clock_frequency;
+	u32 max_pd;
+	u32 max_ah;
+	u32 max_cqe;
+	u32 max_wqes_wq;
+	u32 max_partitions;
+	u32 max_rr_ee_context;
+	u32 max_rr_qp;
+	u32 max_rr_hca;
+	u32 max_act_wqs_ee_context;
+	u32 max_act_wqs_qp;
+	u32 max_sge;
+	u32 max_sge_rd;
+	u32 memory_page_size_supported;
+	u64 max_mr_size;
+	u32 local_ca_ack_delay;
+	u32 num_ports;
+	u32 vendor_id;
+	u32 vendor_part_id;
+	u32 hw_ver;
+	u64 node_guid;
+	u64 hca_cap_indicators;
+	u32 data_counter_register_size;
+	u32 max_shared_rq;
+	u32 max_isns_eq;
+	u32 max_neq;
+} __attribute__ ((packed));
+
+/* query port response block */
+struct hipz_query_port {
+	u32 state;
+	u32 bad_pkey_cntr;
+	u32 lmc;
+	u32 lid;
+	u32 subnet_timeout;
+	u32 qkey_viol_cntr;
+	u32 sm_sl;
+	u32 sm_lid;
+	u32 capability_mask;
+	u32 init_type_reply;
+	u32 pkey_tbl_len;
+	u32 gid_tbl_len;
+	u64 gid_prefix;
+	u32 port_nr;
+	u16 pkey_entries[16];
+	u8  reserved1[32];
+	u32 trent_size;
+	u32 trbuf_size;
+	u64 max_msg_sz;
+	u32 max_mtu;
+	u32 vl_cap;
+	u8  reserved2[1900];
+	u64 guid_entries[255];
+} __attribute__ ((packed));
+
+#endif
-- 
1.4.1

