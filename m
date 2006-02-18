Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWBRBAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWBRBAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWBRA6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:38 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:34083 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751837AbWBRA6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:58:03 -0500
X-IronPort-AV: i="4.02,125,1139212800"; 
   d="scan'208"; a="256299658:sNHT52980612"
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 19/22] ehca memory regions
Date: Fri, 17 Feb 2006 16:57:54 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005754.13620.41418.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:55.0227 (UTC) FILETIME=[5A22CEB0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

Nearly all the inline functions in ehca_mrmw.h look too big to
be inlined.  Why can't they just be static functions in ehca_mrmw.c?
---

 drivers/infiniband/hw/ehca/ehca_mrmw.c | 1711 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_mrmw.h |  739 ++++++++++++++
 2 files changed, 2450 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
new file mode 100644
index 0000000..d756082
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -0,0 +1,1711 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  MR/MW functions
+ *
+ *  Authors: Dietmar Decker <ddecker@de.ibm.com>
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
+ *  $Id: ehca_mrmw.c,v 1.86 2006/02/07 07:51:13 decker Exp $
+ */
+
+#undef DEB_PREFIX
+#define DEB_PREFIX "mrmw"
+
+#include "ehca_kernel.h"
+#include "ehca_iverbs.h"
+#include "hcp_if.h"
+#include "ehca_mrmw.h"
+
+extern int ehca_use_hp_mr;
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+struct ib_mr *ehca_get_dma_mr(struct ib_pd *pd, int mr_access_flags)
+{
+	struct ib_mr *ib_mr;
+	int retcode = 0;
+	struct ehca_mr *e_maxmr = 0;
+	struct ehca_pd *e_pd;
+	struct ehca_shca *shca;
+
+	EDEB_EN(7, "pd=%p mr_access_flags=%x", pd, mr_access_flags);
+
+	EHCA_CHECK_PD_P(pd);
+	e_pd = container_of(pd, struct ehca_pd, ib_pd);
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+
+	if (shca->maxmr) {
+		e_maxmr = ehca_mr_new();
+		if (!e_maxmr) {
+			EDEB_ERR(4, "out of memory");
+			ib_mr = ERR_PTR(-ENOMEM);
+			goto get_dma_mr_exit0;
+		}
+
+		retcode = ehca_reg_maxmr(shca, e_maxmr,
+					 (u64 *)KERNELBASE,
+					 mr_access_flags, e_pd,
+					 &e_maxmr->ib.ib_mr.lkey,
+					 &e_maxmr->ib.ib_mr.rkey);
+		if (retcode != 0) {
+			ib_mr = ERR_PTR(retcode);
+			goto get_dma_mr_exit0;
+		}
+		ib_mr = &e_maxmr->ib.ib_mr;
+	} else {
+		EDEB_ERR(4, "no internal max-MR exist!");
+		ib_mr = ERR_PTR(-EINVAL);
+		goto get_dma_mr_exit0;
+	}
+
+      get_dma_mr_exit0:
+	if (IS_ERR(ib_mr) == 0)
+		EDEB_EX(7, "ib_mr=%p lkey=%x rkey=%x",
+			ib_mr, ib_mr->lkey, ib_mr->rkey);
+	else
+		EDEB_EX(4, "rc=%lx pd=%p mr_access_flags=%x ",
+			PTR_ERR(ib_mr), pd, mr_access_flags);
+	return (ib_mr);
+} /* end ehca_get_dma_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+struct ib_mr *ehca_reg_phys_mr(struct ib_pd *pd,
+			       struct ib_phys_buf *phys_buf_array,
+			       int num_phys_buf,
+			       int mr_access_flags,
+			       u64 *iova_start)
+{
+	struct ib_mr *ib_mr = 0;
+	int retcode = 0;
+	struct ehca_mr *e_mr = 0;
+	struct ehca_shca *shca = 0;
+	struct ehca_pd *e_pd = 0;
+	u64 size = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+	u32 num_pages_mr = 0;
+
+	EDEB_EN(7, "pd=%p phys_buf_array=%p num_phys_buf=%x "
+		"mr_access_flags=%x iova_start=%p", pd, phys_buf_array,
+		num_phys_buf, mr_access_flags, iova_start);
+
+	EHCA_CHECK_PD_P(pd);
+	if ((num_phys_buf <= 0) || ehca_adr_bad(phys_buf_array)) {
+		EDEB_ERR(4, "bad input values: num_phys_buf=%x "
+			 "phys_buf_array=%p", num_phys_buf, phys_buf_array);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_phys_mr_exit0;
+	}
+	if (((mr_access_flags & IB_ACCESS_REMOTE_WRITE) &&
+	     !(mr_access_flags & IB_ACCESS_LOCAL_WRITE)) ||
+	    ((mr_access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	     !(mr_access_flags & IB_ACCESS_LOCAL_WRITE))) {
+		/* Remote Write Access requires Local Write Access */
+		/* Remote Atomic Access requires Local Write Access */
+		EDEB_ERR(4, "bad input values: mr_access_flags=%x",
+			 mr_access_flags);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_phys_mr_exit0;
+	}
+
+	/* check physical buffer list and calculate size */
+	retcode = ehca_mr_chk_buf_and_calc_size(phys_buf_array, num_phys_buf,
+						iova_start, &size);
+	if (retcode != 0) {
+		ib_mr = ERR_PTR(retcode);
+		goto reg_phys_mr_exit0;
+	}
+	if ((size == 0) ||
+	    ((0xFFFFFFFFFFFFFFFF - size) < (u64)iova_start)) {
+		EDEB_ERR(4, "bad input values: size=%lx iova_start=%p",
+			 size, iova_start);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_phys_mr_exit0;
+	}
+
+	e_pd = container_of(pd, struct ehca_pd, ib_pd);
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+
+	e_mr = ehca_mr_new();
+	if (!e_mr) {
+		EDEB_ERR(4, "out of memory");
+		ib_mr = ERR_PTR(-ENOMEM);
+		goto reg_phys_mr_exit0;
+	}
+
+	/* determine number of MR pages */
+	/* pagesize currently hardcoded to 4k ... TODO.. */
+	num_pages_mr =
+	    ((((u64)iova_start % PAGE_SIZE) + size +
+	      PAGE_SIZE - 1) / PAGE_SIZE);
+
+	/* register MR on HCA */
+	if (ehca_mr_is_maxmr(size, iova_start)) {
+		e_mr->flags |= EHCA_MR_FLAG_MAXMR;
+		retcode = ehca_reg_maxmr(shca, e_mr, iova_start,
+					 mr_access_flags, e_pd,
+					 &e_mr->ib.ib_mr.lkey,
+					 &e_mr->ib.ib_mr.rkey);
+		if (retcode != 0) {
+			ib_mr = ERR_PTR(retcode);
+			goto reg_phys_mr_exit1;
+		}
+	} else {
+		pginfo.type           = EHCA_MR_PGI_PHYS;
+		pginfo.num_pages      = num_pages_mr;
+		pginfo.num_phys_buf   = num_phys_buf;
+		pginfo.phys_buf_array = phys_buf_array;
+
+		retcode = ehca_reg_mr(shca, e_mr, iova_start, size,
+				      mr_access_flags, e_pd, &pginfo,
+				      &e_mr->ib.ib_mr.lkey,
+				      &e_mr->ib.ib_mr.rkey);
+		if (retcode != 0) {
+			ib_mr = ERR_PTR(retcode);
+			goto reg_phys_mr_exit1;
+		}
+	}
+
+	/* successful registration of all pages */
+	ib_mr = &e_mr->ib.ib_mr;
+	goto reg_phys_mr_exit0;
+
+      reg_phys_mr_exit1:
+	ehca_mr_delete(e_mr);
+      reg_phys_mr_exit0:
+	if (IS_ERR(ib_mr) == 0)
+		EDEB_EX(7, "ib_mr=%p lkey=%x rkey=%x",
+			ib_mr, ib_mr->lkey, ib_mr->rkey);
+	else
+		EDEB_EX(4, "rc=%lx pd=%p phys_buf_array=%p "
+			"num_phys_buf=%x mr_access_flags=%x iova_start=%p",
+			PTR_ERR(ib_mr), pd, phys_buf_array,
+			num_phys_buf, mr_access_flags, iova_start);
+	return (ib_mr);
+} /* end ehca_reg_phys_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+struct ib_mr *ehca_reg_user_mr(struct ib_pd *pd,
+			       struct ib_umem *region,
+			       int mr_access_flags,
+			       struct ib_udata *udata)
+{
+	struct ib_mr *ib_mr = 0;
+	struct ehca_mr *e_mr = 0;
+	struct ehca_shca *shca = 0;
+	struct ehca_pd *e_pd = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+	int retcode = 0;
+	u32 num_pages_mr = 0;
+
+	EDEB_EN(7, "pd=%p region=%p mr_access_flags=%x udata=%p",
+		pd, region, mr_access_flags, udata);
+
+	EHCA_CHECK_PD_P(pd);
+	if (ehca_adr_bad(region)) {
+		EDEB_ERR(4, "bad input values: region=%p", region);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_user_mr_exit0;
+	}
+	if (((mr_access_flags & IB_ACCESS_REMOTE_WRITE) &&
+	     !(mr_access_flags & IB_ACCESS_LOCAL_WRITE)) ||
+	    ((mr_access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	     !(mr_access_flags & IB_ACCESS_LOCAL_WRITE))) {
+		/* Remote Write Access requires Local Write Access */
+		/* Remote Atomic Access requires Local Write Access */
+		EDEB_ERR(4, "bad input values: mr_access_flags=%x",
+			 mr_access_flags);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_user_mr_exit0;
+	}
+	EDEB(7, "user_base=%lx virt_base=%lx length=%lx offset=%x page_size=%x "
+	     "chunk_list.next=%p",
+	     region->user_base, region->virt_base, region->length,
+	     region->offset, region->page_size, region->chunk_list.next);
+	if (region->page_size != PAGE_SIZE) {
+		/* @TODO large page support */
+		EDEB_ERR(4, "large pages not supported, region->page_size=%x",
+			 region->page_size);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_user_mr_exit0;
+	}
+
+	if ((region->length == 0) ||
+	    ((0xFFFFFFFFFFFFFFFF - region->length) < region->virt_base)) {
+		EDEB_ERR(4, "bad input values: length=%lx virt_base=%lx",
+			 region->length, region->virt_base);
+		ib_mr = ERR_PTR(-EINVAL);
+		goto reg_user_mr_exit0;
+	}
+
+	e_pd = container_of(pd, struct ehca_pd, ib_pd);
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+
+	e_mr = ehca_mr_new();
+	if (!e_mr) {
+		EDEB_ERR(4, "out of memory");
+		ib_mr = ERR_PTR(-ENOMEM);
+		goto reg_user_mr_exit0;
+	}
+
+	/* determine number of MR pages */
+	/* pagesize currently hardcoded to 4k ...TODO... */
+	num_pages_mr =
+	    (((region->virt_base % PAGE_SIZE) + region->length +
+	      PAGE_SIZE - 1) / PAGE_SIZE);
+
+	/* register MR on HCA */
+	pginfo.type       = EHCA_MR_PGI_USER;
+	pginfo.num_pages  = num_pages_mr;
+	pginfo.region     = region;
+	pginfo.next_chunk = list_prepare_entry(pginfo.next_chunk,
+					       (&region->chunk_list),
+					       list);
+
+	retcode = ehca_reg_mr(shca, e_mr, (u64 *)region->virt_base,
+			      region->length, mr_access_flags, e_pd, &pginfo,
+			      &e_mr->ib.ib_mr.lkey, &e_mr->ib.ib_mr.rkey);
+	if (retcode != 0) {
+		ib_mr = ERR_PTR(retcode);
+		goto reg_user_mr_exit1;
+	}
+
+	/* successful registration of all pages */
+	ib_mr = &e_mr->ib.ib_mr;
+	goto reg_user_mr_exit0;
+
+      reg_user_mr_exit1:
+	ehca_mr_delete(e_mr);
+      reg_user_mr_exit0:
+	if (IS_ERR(ib_mr) == 0)
+		EDEB_EX(7, "ib_mr=%p lkey=%x rkey=%x",
+			ib_mr, ib_mr->lkey, ib_mr->rkey);
+	else
+		EDEB_EX(4, "rc=%lx pd=%p region=%p mr_access_flags=%x "
+			"udata=%p",
+			PTR_ERR(ib_mr), pd, region, mr_access_flags, udata);
+	return (ib_mr);
+} /* end ehca_reg_user_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_rereg_phys_mr(struct ib_mr *mr,
+		       int mr_rereg_mask,
+		       struct ib_pd *pd,
+		       struct ib_phys_buf *phys_buf_array,
+		       int num_phys_buf,
+		       int mr_access_flags,
+		       u64 *iova_start)
+{
+	int retcode = 0;
+	struct ehca_shca *shca = 0;
+	struct ehca_mr *e_mr = 0;
+	u64 new_size = 0;
+	u64 *new_start = 0;
+	u32 new_acl = 0;
+	struct ehca_pd *new_pd = 0;
+	u32 tmp_lkey = 0;
+	u32 tmp_rkey = 0;
+	unsigned long sl_flags;
+	u64 num_pages_mr = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+
+	EDEB_EN(7, "mr=%p mr_rereg_mask=%x pd=%p phys_buf_array=%p "
+		"num_phys_buf=%x mr_access_flags=%x iova_start=%p",
+		mr, mr_rereg_mask, pd, phys_buf_array, num_phys_buf,
+		mr_access_flags, iova_start);
+
+	if (!(mr_rereg_mask & IB_MR_REREG_TRANS)) {
+		/*@TODO not supported, because PHYP rereg hCall needs pages*/
+		/*@TODO: We will follow this with Tom ....*/
+		EDEB_ERR(4, "rereg without IB_MR_REREG_TRANS not supported yet,"
+			 " mr_rereg_mask=%x", mr_rereg_mask);
+		retcode = -EINVAL;
+		goto rereg_phys_mr_exit0;
+	}
+
+	EHCA_CHECK_MR(mr);
+	e_mr = container_of(mr, struct ehca_mr, ib.ib_mr);
+	if (mr_rereg_mask & IB_MR_REREG_PD) {
+		EHCA_CHECK_PD(pd);
+	}
+
+	if ((mr_rereg_mask &
+	     ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS)) ||
+	    (mr_rereg_mask == 0)) {
+		retcode = -EINVAL;
+		goto rereg_phys_mr_exit0;
+	}
+
+	shca = container_of(mr->device, struct ehca_shca, ib_device);
+
+	/* check other parameters */
+	if (e_mr == shca->maxmr) {
+		/* should be impossible, however reject to be sure */
+		EDEB_ERR(3, "rereg internal max-MR impossible, mr=%p "
+			 "shca->maxmr=%p mr->lkey=%x",
+			 mr, shca->maxmr, mr->lkey);
+		retcode = -EINVAL;
+		goto rereg_phys_mr_exit0;
+	}
+	if (mr_rereg_mask & IB_MR_REREG_TRANS) { /* transl., i.e. addr/size */
+		if (e_mr->flags & EHCA_MR_FLAG_FMR) {
+			EDEB_ERR(4, "not supported for FMR, mr=%p flags=%x",
+				 mr, e_mr->flags);
+			retcode = -EINVAL;
+			goto rereg_phys_mr_exit0;
+		}
+		if (ehca_adr_bad(phys_buf_array) || num_phys_buf <= 0) {
+			EDEB_ERR(4, "bad input values: mr_rereg_mask=%x "
+				 "phys_buf_array=%p num_phys_buf=%x",
+				 mr_rereg_mask, phys_buf_array, num_phys_buf);
+			retcode = -EINVAL;
+			goto rereg_phys_mr_exit0;
+		}
+	}
+	if ((mr_rereg_mask & IB_MR_REREG_ACCESS) &&	/* change ACL */
+	    (((mr_access_flags & IB_ACCESS_REMOTE_WRITE) &&
+	      !(mr_access_flags & IB_ACCESS_LOCAL_WRITE)) ||
+	     ((mr_access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	      !(mr_access_flags & IB_ACCESS_LOCAL_WRITE)))) {
+		/* Remote Write Access requires Local Write Access */
+		/* Remote Atomic Access requires Local Write Access */
+		EDEB_ERR(4, "bad input values: mr_rereg_mask=%x "
+			 "mr_access_flags=%x", mr_rereg_mask, mr_access_flags);
+		retcode = -EINVAL;
+		goto rereg_phys_mr_exit0;
+	}
+
+	/* set requested values dependent on rereg request */
+	spin_lock_irqsave(&e_mr->mrlock, sl_flags); /* get lock @TODO for MR*/
+	new_start = e_mr->start;  /* new == old address */
+	new_size  = e_mr->size;	  /* new == old length */
+	new_acl   = e_mr->acl;	  /* new == old access control */
+	new_pd    = container_of(mr->pd,struct ehca_pd,ib_pd); /*new == old PD*/
+
+	if (mr_rereg_mask & IB_MR_REREG_TRANS) {
+		new_start = iova_start;	/* change address */
+		/* check physical buffer list and calculate size */
+		retcode = ehca_mr_chk_buf_and_calc_size(phys_buf_array,
+							num_phys_buf,
+							iova_start, &new_size);
+		if (retcode != 0)
+			goto rereg_phys_mr_exit1;
+		if ((new_size == 0) ||
+		    ((0xFFFFFFFFFFFFFFFF - new_size) < (u64)iova_start)) {
+			EDEB_ERR(4, "bad input values: new_size=%lx "
+				 "iova_start=%p", new_size, iova_start);
+			retcode = -EINVAL;
+			goto rereg_phys_mr_exit1;
+		}
+		num_pages_mr = ((((u64)new_start % PAGE_SIZE) +
+				 new_size + PAGE_SIZE - 1) / PAGE_SIZE);
+		pginfo.type           = EHCA_MR_PGI_PHYS;
+		pginfo.num_pages      = num_pages_mr;
+		pginfo.num_phys_buf   = num_phys_buf;
+		pginfo.phys_buf_array = phys_buf_array;
+	}
+	if (mr_rereg_mask & IB_MR_REREG_ACCESS)
+		new_acl = mr_access_flags;
+	if (mr_rereg_mask & IB_MR_REREG_PD)
+		new_pd = container_of(pd, struct ehca_pd, ib_pd);
+
+	EDEB(7, "mr=%p new_start=%p new_size=%lx new_acl=%x new_pd=%p "
+	     "num_pages_mr=%lx",
+	     e_mr, new_start, new_size, new_acl, new_pd, num_pages_mr);
+
+	retcode = ehca_rereg_mr(shca, e_mr, new_start, new_size, new_acl,
+				new_pd, &pginfo, &tmp_lkey, &tmp_rkey);
+	if (retcode != 0)
+		goto rereg_phys_mr_exit1;
+
+	/* successful reregistration */
+	if (mr_rereg_mask & IB_MR_REREG_PD)
+		mr->pd = pd;
+	mr->lkey = tmp_lkey;
+	mr->rkey = tmp_rkey;
+
+      rereg_phys_mr_exit1:
+	spin_unlock_irqrestore(&e_mr->mrlock, sl_flags); /* free spin lock */
+      rereg_phys_mr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "mr=%p mr_rereg_mask=%x pd=%p phys_buf_array=%p "
+			"num_phys_buf=%x mr_access_flags=%x iova_start=%p",
+			mr, mr_rereg_mask, pd, phys_buf_array, num_phys_buf,
+			mr_access_flags, iova_start);
+	else
+		EDEB_EX(4, "retcode=%x mr=%p mr_rereg_mask=%x pd=%p "
+			"phys_buf_array=%p num_phys_buf=%x mr_access_flags=%x "
+			"iova_start=%p",
+			retcode, mr, mr_rereg_mask, pd, phys_buf_array,
+			num_phys_buf, mr_access_flags, iova_start);
+
+	return (retcode);
+} /* end ehca_rereg_phys_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_query_mr(struct ib_mr *mr, struct ib_mr_attr *mr_attr)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_shca *shca = 0;
+	struct ehca_mr *e_mr = 0;
+	struct ipz_pd fwpd;		/* Firmware PD */
+	u32 access_ctrl = 0;
+	u64 tmp_remote_size = 0;
+	u64 tmp_remote_len = 0;
+
+	unsigned long sl_flags;
+
+	EDEB_EN(7, "mr=%p mr_attr=%p", mr, mr_attr);
+
+	EHCA_CHECK_MR(mr);
+	e_mr = container_of(mr, struct ehca_mr, ib.ib_mr);
+	if (ehca_adr_bad(mr_attr)) {
+		EDEB_ERR(4, "bad input values: mr_attr=%p", mr_attr);
+		retcode = -EINVAL;
+		goto query_mr_exit0;
+	}
+	if ((e_mr->flags & EHCA_MR_FLAG_FMR)) {
+		EDEB_ERR(4, "not supported for FMR, mr=%p e_mr=%p "
+			 "e_mr->flags=%x", mr, e_mr, e_mr->flags);
+		retcode = -EINVAL;
+		goto query_mr_exit0;
+	}
+
+	shca = container_of(mr->device, struct ehca_shca, ib_device);
+	memset(mr_attr, 0, sizeof(struct ib_mr_attr));
+	spin_lock_irqsave(&e_mr->mrlock, sl_flags); /* get spin lock @TODO?? */
+
+	rc = hipz_h_query_mr(shca->ipz_hca_handle, &e_mr->pf,
+			     &e_mr->ipz_mr_handle, &mr_attr->size,
+			     &mr_attr->device_virt_addr, &tmp_remote_size,
+			     &tmp_remote_len, &access_ctrl, &fwpd,
+			     &mr_attr->lkey, &mr_attr->rkey);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_mr_query failed, rc=%lx mr=%p "
+			 "hca_hndl=%lx mr_hndl=%lx lkey=%x",
+			 rc, mr, shca->ipz_hca_handle.handle,
+			 e_mr->ipz_mr_handle.handle, mr->lkey);
+		retcode = ehca_mrmw_map_rc_query_mr(rc);
+		goto query_mr_exit1;
+	}
+	ehca_mrmw_reverse_map_acl(&access_ctrl, &mr_attr->mr_access_flags);
+	mr_attr->pd = mr->pd;
+
+      query_mr_exit1:
+	spin_unlock_irqrestore(&e_mr->mrlock, sl_flags); /* free spin lock */
+      query_mr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "pd=%p device_virt_addr=%lx size=%lx "
+			"mr_access_flags=%x lkey=%x rkey=%x",
+			mr_attr->pd, mr_attr->device_virt_addr,
+			mr_attr->size, mr_attr->mr_access_flags,
+			mr_attr->lkey, mr_attr->rkey);
+	else
+		EDEB_EX(4, "retcode=%x mr=%p mr_attr=%p", retcode, mr, mr_attr);
+	return (retcode);
+} /* end ehca_query_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_dereg_mr(struct ib_mr *mr)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_shca *shca = 0;
+	struct ehca_mr *e_mr = 0;
+
+	EDEB_EN(7, "mr=%p", mr);
+
+	EHCA_CHECK_MR(mr);
+	e_mr = container_of(mr, struct ehca_mr, ib.ib_mr);
+	shca = container_of(mr->device, struct ehca_shca, ib_device);
+
+	if ((e_mr->flags & EHCA_MR_FLAG_FMR)) {
+		EDEB_ERR(4, "not supported for FMR, mr=%p e_mr=%p "
+			 "e_mr->flags=%x", mr, e_mr, e_mr->flags);
+		retcode = -EINVAL;
+		goto dereg_mr_exit0;
+	} else if (e_mr == shca->maxmr) {
+		/* should be impossible, however reject to be sure */
+		EDEB_ERR(3, "dereg internal max-MR impossible, mr=%p "
+			 "shca->maxmr=%p mr->lkey=%x",
+			 mr, shca->maxmr, mr->lkey);
+		retcode = -EINVAL;
+		goto dereg_mr_exit0;
+	}
+
+	/*@TODO: BUSY: MR still has bound window(s) */
+	rc = hipz_h_free_resource_mr(shca->ipz_hca_handle, &e_mr->pf,
+				     &e_mr->ipz_mr_handle);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_free_mr failed, rc=%lx shca=%p e_mr=%p"
+			 " hca_hndl=%lx mr_hndl=%lx mr->lkey=%x",
+			 rc, shca, e_mr, shca->ipz_hca_handle.handle,
+			 e_mr->ipz_mr_handle.handle, mr->lkey);
+		retcode = ehca_mrmw_map_rc_free_mr(rc);
+		goto dereg_mr_exit0;
+	}
+
+	/* successful deregistration */
+	ehca_mr_delete(e_mr);
+
+      dereg_mr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "");
+	else
+		EDEB_EX(4, "retcode=%x mr=%p", retcode, mr);
+	return (retcode);
+} /* end ehca_dereg_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+struct ib_mw *ehca_alloc_mw(struct ib_pd *pd)
+{
+	struct ib_mw *ib_mw = 0;
+	u64 rc = H_Success;
+	struct ehca_shca *shca = 0;
+	struct ehca_mw *e_mw = 0;
+	struct ehca_pd *e_pd = 0;
+
+	EDEB_EN(7, "pd=%p", pd);
+
+	EHCA_CHECK_PD_P(pd);
+	e_pd = container_of(pd, struct ehca_pd, ib_pd);
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+
+	e_mw = ehca_mw_new();
+	if (!e_mw) {
+		ib_mw = ERR_PTR(-ENOMEM);
+		goto alloc_mw_exit0;
+	}
+
+	rc = hipz_h_alloc_resource_mw(shca->ipz_hca_handle, &e_mw->pf,
+				      &shca->pf, e_pd->fw_pd,
+				      &e_mw->ipz_mw_handle, &e_mw->ib_mw.rkey);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_mw_allocate failed, rc=%lx shca=%p "
+			 "hca_hndl=%lx mw=%p", rc, shca,
+			 shca->ipz_hca_handle.handle, e_mw);
+		ib_mw = ERR_PTR(ehca_mrmw_map_rc_alloc(rc));
+		goto alloc_mw_exit1;
+	}
+	/* save R_Key in local copy */
+	/*@TODO?????    mw->rkey = *rkey_p; */
+
+	/* successful MW allocation */
+	ib_mw = &e_mw->ib_mw;
+	goto alloc_mw_exit0;
+
+      alloc_mw_exit1:
+	ehca_mw_delete(e_mw);
+      alloc_mw_exit0:
+	if (IS_ERR(ib_mw) == 0)
+		EDEB_EX(7, "ib_mw=%p rkey=%x", ib_mw, ib_mw->rkey);
+	else
+		EDEB_EX(4, "rc=%lx pd=%p", PTR_ERR(ib_mw), pd);
+	return (ib_mw);
+} /* end ehca_alloc_mw() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_bind_mw(struct ib_qp *qp,
+		 struct ib_mw *mw,
+		 struct ib_mw_bind *mw_bind)
+{
+	int retcode = 0;
+
+	/*@TODO: not supported up to now */
+	EDEB_ERR(4, "bind MW currently not supported by HCAD");
+	retcode = -EPERM;
+	goto bind_mw_exit0;
+
+      bind_mw_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "qp=%p mw=%p mw_bind=%p", qp, mw, mw_bind);
+	else
+		EDEB_EX(4, "rc=%x qp=%p mw=%p mw_bind=%p",
+			retcode, qp, mw, mw_bind);
+	return (retcode);
+} /* end ehca_bind_mw() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_dealloc_mw(struct ib_mw *mw)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_shca *shca = 0;
+	struct ehca_mw *e_mw = 0;
+
+	EDEB_EN(7, "mw=%p", mw);
+
+	EHCA_CHECK_MW(mw);
+	e_mw = container_of(mw, struct ehca_mw, ib_mw);
+	shca = container_of(mw->device, struct ehca_shca, ib_device);
+
+	rc = hipz_h_free_resource_mw(shca->ipz_hca_handle, &e_mw->pf,
+				     &e_mw->ipz_mw_handle);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_free_mw failed, rc=%lx shca=%p mw=%p "
+			 "rkey=%x hca_hndl=%lx mw_hndl=%lx",
+			 rc, shca, mw, mw->rkey, shca->ipz_hca_handle.handle,
+			 e_mw->ipz_mw_handle.handle);
+		retcode = ehca_mrmw_map_rc_free_mw(rc);
+		goto dealloc_mw_exit0;
+	}
+	/* successful deallocation */
+	ehca_mw_delete(e_mw);
+
+      dealloc_mw_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "");
+	else
+		EDEB_EX(4, "retcode=%x mw=%p", retcode, mw);
+	return (retcode);
+} /* end ehca_dealloc_mw() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+struct ib_fmr *ehca_alloc_fmr(struct ib_pd *pd,
+			      int mr_access_flags,
+			      struct ib_fmr_attr *fmr_attr)
+{
+	struct ib_fmr *ib_fmr = 0;
+	struct ehca_shca *shca = 0;
+	struct ehca_mr *e_fmr = 0;
+	int retcode = 0;
+	struct ehca_pd *e_pd = 0;
+	u32 tmp_lkey = 0;
+	u32 tmp_rkey = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+
+	EDEB_EN(7, "pd=%p mr_access_flags=%x fmr_attr=%p",
+		pd, mr_access_flags, fmr_attr);
+
+	EHCA_CHECK_PD_P(pd);
+	if (ehca_adr_bad(fmr_attr)) {
+		EDEB_ERR(4, "bad input values: fmr_attr=%p", fmr_attr);
+		ib_fmr = ERR_PTR(-EINVAL);
+		goto alloc_fmr_exit0;
+	}
+
+	EDEB(7, "max_pages=%x max_maps=%x page_shift=%x",
+	     fmr_attr->max_pages, fmr_attr->max_maps, fmr_attr->page_shift);
+
+	/* check other parameters */
+	if (((mr_access_flags & IB_ACCESS_REMOTE_WRITE) &&
+	     !(mr_access_flags & IB_ACCESS_LOCAL_WRITE)) ||
+	    ((mr_access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	     !(mr_access_flags & IB_ACCESS_LOCAL_WRITE))) {
+		/* Remote Write Access requires Local Write Access */
+		/* Remote Atomic Access requires Local Write Access */
+		EDEB_ERR(4, "bad input values: mr_access_flags=%x",
+			 mr_access_flags);
+		ib_fmr = ERR_PTR(-EINVAL);
+		goto alloc_fmr_exit0;
+	}
+	if (mr_access_flags & IB_ACCESS_MW_BIND) {
+		EDEB_ERR(4, "bad input values: mr_access_flags=%x",
+			 mr_access_flags);
+		ib_fmr = ERR_PTR(-EINVAL);
+		goto alloc_fmr_exit0;
+	}
+	if ((fmr_attr->max_pages == 0) || (fmr_attr->max_maps == 0)) {
+		EDEB_ERR(4, "bad input values: fmr_attr->max_pages=%x "
+			 "fmr_attr->max_maps=%x fmr_attr->page_shift=%x",
+			 fmr_attr->max_pages, fmr_attr->max_maps,
+			 fmr_attr->page_shift);
+		ib_fmr = ERR_PTR(-EINVAL);
+		goto alloc_fmr_exit0;
+	}
+	if ((1 << fmr_attr->page_shift) != PAGE_SIZE) {
+		/* pagesize currently hardcoded to 4k ... */
+		EDEB_ERR(4, "unsupported fmr_attr->page_shift=%x",
+			 fmr_attr->page_shift);
+		ib_fmr = ERR_PTR(-EINVAL);
+		goto alloc_fmr_exit0;
+	}
+
+	e_pd = container_of(pd, struct ehca_pd, ib_pd);
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+
+	e_fmr = ehca_mr_new();
+	if (e_fmr == 0) {
+		ib_fmr = ERR_PTR(-ENOMEM);
+		goto alloc_fmr_exit0;
+	}
+	e_fmr->flags |= EHCA_MR_FLAG_FMR;
+
+	/* register MR on HCA */
+	retcode = ehca_reg_mr(shca, e_fmr, 0,
+			      fmr_attr->max_pages * PAGE_SIZE,
+			      mr_access_flags, e_pd, &pginfo,
+			      &tmp_lkey, &tmp_rkey);
+	if (retcode != 0) {
+		ib_fmr = ERR_PTR(retcode);
+		goto alloc_fmr_exit1;
+	}
+
+	/* successful registration of all pages */
+	e_fmr->fmr_page_size = 1 << fmr_attr->page_shift;
+	e_fmr->fmr_max_pages = fmr_attr->max_pages; /* pagesize hardcoded 4k */
+	e_fmr->fmr_max_maps = fmr_attr->max_maps;
+	e_fmr->fmr_map_cnt = 0;
+	ib_fmr = &e_fmr->ib.ib_fmr;
+	goto alloc_fmr_exit0;
+
+      alloc_fmr_exit1:
+	ehca_mr_delete(e_fmr);
+      alloc_fmr_exit0:
+	if (IS_ERR(ib_fmr) == 0)
+		EDEB_EX(7, "ib_fmr=%p tmp_lkey=%x tmp_rkey=%x",
+			ib_fmr, tmp_lkey, tmp_rkey);
+	else
+		EDEB_EX(4, "rc=%lx pd=%p mr_access_flags=%x "
+			"fmr_attr=%p", PTR_ERR(ib_fmr), pd,
+			mr_access_flags, fmr_attr);
+	return (ib_fmr);
+} /* end ehca_alloc_fmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_map_phys_fmr(struct ib_fmr *fmr,
+		      u64 *page_list,
+		      int list_len,
+		      u64 iova)
+{
+	int retcode = 0;
+	struct ehca_shca *shca = 0;
+	struct ehca_mr *e_fmr = 0;
+	struct ehca_pd *e_pd = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+	u32 tmp_lkey = 0;
+	u32 tmp_rkey = 0;
+	/*@TODO unsigned long sl_flags; */
+
+	EDEB_EN(7, "fmr=%p page_list=%p list_len=%x iova=%lx",
+		fmr, page_list, list_len, iova);
+
+	EHCA_CHECK_FMR(fmr);
+	e_fmr = container_of(fmr, struct ehca_mr, ib.ib_fmr);
+	shca = container_of(fmr->device, struct ehca_shca, ib_device);
+	e_pd = container_of(fmr->pd, struct ehca_pd, ib_pd);
+
+	if (!(e_fmr->flags & EHCA_MR_FLAG_FMR)) {
+		EDEB_ERR(4, "not a FMR, e_fmr=%p e_fmr->flags=%x",
+			 e_fmr, e_fmr->flags);
+		retcode = -EINVAL;
+		goto map_phys_fmr_exit0;
+	}
+	retcode = ehca_fmr_check_page_list(e_fmr, page_list, list_len);
+	if (retcode != 0)
+		goto map_phys_fmr_exit0;
+	if (iova % PAGE_SIZE) {
+		/* only whole-numbered pages */
+		EDEB_ERR(4, "bad iova, iova=%lx", iova);
+		retcode = -EINVAL;
+		goto map_phys_fmr_exit0;
+	}
+	if (e_fmr->fmr_map_cnt >= e_fmr->fmr_max_maps) {
+		/* HCAD does not limit the maps, however trace this anyway */
+		EDEB(6, "map limit exceeded, fmr=%p e_fmr->fmr_map_cnt=%x "
+		     "e_fmr->fmr_max_maps=%x",
+		     fmr, e_fmr->fmr_map_cnt, e_fmr->fmr_max_maps);
+	}
+
+	pginfo.type      = EHCA_MR_PGI_FMR;
+	pginfo.num_pages = list_len;
+	pginfo.page_list = page_list;
+
+	/* @TODO spin_lock_irqsave(&e_fmr->mrlock, sl_flags); */
+
+	retcode = ehca_rereg_mr(shca, e_fmr, (u64 *)iova,
+				list_len * PAGE_SIZE,
+				e_fmr->acl, e_pd, &pginfo,
+				&tmp_lkey, &tmp_rkey);
+	if (retcode != 0) {
+		/* @TODO spin_unlock_irqrestore(&fmr->mrlock, sl_flags); */
+		goto map_phys_fmr_exit0;
+	}
+	/* successful reregistration */
+	e_fmr->fmr_map_cnt++;
+	/* @TODO spin_unlock_irqrestore(&fmr->mrlock, sl_flags); */
+
+	e_fmr->ib.ib_fmr.lkey = tmp_lkey;
+	e_fmr->ib.ib_fmr.rkey = tmp_rkey;
+
+      map_phys_fmr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "lkey=%x rkey=%x",
+			e_fmr->ib.ib_fmr.lkey, e_fmr->ib.ib_fmr.rkey);
+	else
+		EDEB_EX(4, "retcode=%x fmr=%p page_list=%p list_len=%x  "
+			"iova=%lx",
+			retcode, fmr, page_list, list_len, iova);
+	return (retcode);
+} /* end ehca_map_phys_fmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_unmap_fmr(struct list_head *fmr_list)
+{
+	int retcode = 0;
+	struct ib_fmr *ib_fmr;
+	struct ehca_shca *shca = 0;
+	struct ehca_shca *prev_shca = 0;
+	struct ehca_mr *e_fmr = 0;
+	u32 num_fmr = 0;
+	u32 unmap_fmr_cnt = 0;
+	/* @TODO unsigned long sl_flags; */
+
+	EDEB_EN(7, "fmr_list=%p", fmr_list);
+
+	/* check all FMR belong to same SHCA, and check internal flag */
+	list_for_each_entry(ib_fmr, fmr_list, list) {
+		prev_shca = shca;
+		shca = container_of(ib_fmr->device, struct ehca_shca,
+				    ib_device);
+		EHCA_CHECK_FMR(ib_fmr);
+		e_fmr = container_of(ib_fmr, struct ehca_mr, ib.ib_fmr);
+		if ((shca != prev_shca) && (prev_shca != 0)) {
+			EDEB_ERR(4, "SHCA mismatch, shca=%p prev_shca=%p "
+				 "e_fmr=%p", shca, prev_shca, e_fmr);
+			retcode = -EINVAL;
+			goto unmap_fmr_exit0;
+		}
+		if (!(e_fmr->flags & EHCA_MR_FLAG_FMR)) {
+			EDEB_ERR(4, "not a FMR, e_fmr=%p e_fmr->flags=%x",
+				 e_fmr, e_fmr->flags);
+			retcode = -EINVAL;
+			goto unmap_fmr_exit0;
+		}
+		num_fmr++;
+	}
+
+	/* loop over all FMRs to unmap */
+	list_for_each_entry(ib_fmr, fmr_list, list) {
+		unmap_fmr_cnt++;
+		e_fmr = container_of(ib_fmr, struct ehca_mr, ib.ib_fmr);
+		shca = container_of(ib_fmr->device, struct ehca_shca,
+				    ib_device);
+		/*@TODO??? spin_lock_irqsave(&fmr->mrlock, sl_flags); */
+		retcode = ehca_unmap_one_fmr(shca, e_fmr);
+		/*@TODO???? spin_unlock_irqrestore(&fmr->mrlock, sl_flags); */
+		if (retcode != 0) {
+			/* unmap failed, stop unmapping of rest of FMRs */
+			EDEB_ERR(4, "unmap of one FMR failed, stop rest, "
+				 "e_fmr=%p num_fmr=%x unmap_fmr_cnt=%x lkey=%x",
+				 e_fmr, num_fmr, unmap_fmr_cnt,
+				 e_fmr->ib.ib_fmr.lkey);
+			goto unmap_fmr_exit0;
+		}
+	}
+
+      unmap_fmr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "num_fmr=%x", num_fmr);
+	else
+		EDEB_EX(4, "retcode=%x fmr_list=%p num_fmr=%x unmap_fmr_cnt=%x",
+			retcode, fmr_list, num_fmr, unmap_fmr_cnt);
+	return (retcode);
+} /* end ehca_unmap_fmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_dealloc_fmr(struct ib_fmr *fmr)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_shca *shca = 0;
+	struct ehca_mr *e_fmr = 0;
+
+	EDEB_EN(7, "fmr=%p", fmr);
+
+	EHCA_CHECK_FMR(fmr);
+	e_fmr = container_of(fmr, struct ehca_mr, ib.ib_fmr);
+	shca = container_of(fmr->device, struct ehca_shca, ib_device);
+
+	if (!(e_fmr->flags & EHCA_MR_FLAG_FMR)) {
+		EDEB_ERR(4, "not a FMR, e_fmr=%p e_fmr->flags=%x",
+			 e_fmr, e_fmr->flags);
+		retcode = -EINVAL;
+		goto free_fmr_exit0;
+	}
+
+	rc = hipz_h_free_resource_mr(shca->ipz_hca_handle, &e_fmr->pf,
+				     &e_fmr->ipz_mr_handle);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_free_mr failed, rc=%lx e_fmr=%p "
+			 "hca_hndl=%lx fmr_hndl=%lx fmr->lkey=%x",
+			 rc, e_fmr, shca->ipz_hca_handle.handle,
+			 e_fmr->ipz_mr_handle.handle, fmr->lkey);
+		ehca_mrmw_map_rc_free_mr(rc);
+		goto free_fmr_exit0;
+	}
+	/* successful deregistration */
+	ehca_mr_delete(e_fmr);
+
+      free_fmr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "");
+	else
+		EDEB_EX(4, "retcode=%x fmr=%p", retcode, fmr);
+	return (retcode);
+} /* end ehca_dealloc_fmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_reg_mr(struct ehca_shca *shca,
+		struct ehca_mr *e_mr,
+		u64 *iova_start,
+		u64 size,
+		int acl,
+		struct ehca_pd *e_pd,
+		struct ehca_mr_pginfo *pginfo,
+		u32 *lkey,
+		u32 *rkey)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_mr->pf;
+	u32 hipz_acl = 0;
+
+	EDEB_EN(7, "shca=%p e_mr=%p iova_start=%p size=%lx acl=%x e_pd=%p "
+		"pginfo=%p num_pages=%lx", shca, e_mr, iova_start, size, acl,
+		e_pd, pginfo, pginfo->num_pages);
+
+	ehca_mrmw_map_acl(acl, &hipz_acl);
+	ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
+	if (ehca_use_hp_mr == 1)
+	        hipz_acl |= 0x00000001;
+
+	rc = hipz_h_alloc_resource_mr(shca->ipz_hca_handle, pfmr, &shca->pf,
+				      (u64)iova_start, size, hipz_acl,
+				      e_pd->fw_pd, &e_mr->ipz_mr_handle,
+				      lkey, rkey);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_alloc_mr failed, rc=%lx hca_hndl=%lx "
+			 "mr_hndl=%lx", rc, shca->ipz_hca_handle.handle,
+			 e_mr->ipz_mr_handle.handle);
+		retcode = ehca_mrmw_map_rc_alloc(rc);
+		goto ehca_reg_mr_exit0;
+	}
+
+	retcode = ehca_reg_mr_rpages(shca, e_mr, pginfo);
+	if (retcode != 0)
+		goto ehca_reg_mr_exit1;
+
+	/* successful registration */
+	e_mr->num_pages = pginfo->num_pages;
+	e_mr->start = iova_start;
+	e_mr->size = size;
+	e_mr->acl = acl;
+	goto ehca_reg_mr_exit0;
+
+      ehca_reg_mr_exit1:
+	rc = hipz_h_free_resource_mr(shca->ipz_hca_handle, pfmr,
+				     &e_mr->ipz_mr_handle);
+	if (rc != H_Success) {
+		EDEB(1, "rc=%lx shca=%p e_mr=%p iova_start=%p "
+		     "size=%lx acl=%x e_pd=%p lkey=%x pginfo=%p num_pages=%lx",
+		     rc, shca, e_mr, iova_start, size, acl,
+		     e_pd, *lkey, pginfo, pginfo->num_pages);
+		ehca_catastrophic("internal error in ehca_reg_mr, "
+				  "not recoverable");
+	}
+      ehca_reg_mr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "retcode=%x lkey=%x rkey=%x", retcode, *lkey, *rkey);
+	else
+		EDEB_EX(4, "retcode=%x shca=%p e_mr=%p iova_start=%p "
+			"size=%lx acl=%x e_pd=%p pginfo=%p num_pages=%lx",
+			retcode, shca, e_mr, iova_start,
+			size, acl, e_pd, pginfo, pginfo->num_pages);
+	return (retcode);
+} /* end ehca_reg_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_reg_mr_rpages(struct ehca_shca *shca,
+		       struct ehca_mr *e_mr,
+		       struct ehca_mr_pginfo *pginfo)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_mr->pf;
+	u32 rnum = 0;
+	u64 rpage = 0;
+	u32 i;
+	u64 *kpage = 0;
+
+	EDEB_EN(7, "shca=%p e_mr=%p pginfo=%p num_pages=%lx",
+		shca, e_mr, pginfo, pginfo->num_pages);
+
+	kpage = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (kpage == 0) {
+		EDEB_ERR(4, "kpage alloc failed");
+		retcode = -ENOMEM;
+		goto ehca_reg_mr_rpages_exit0;
+	}
+	memset(kpage, 0, PAGE_SIZE);
+
+	/* max 512 pages per shot */
+	for (i = 0; i < ((pginfo->num_pages + 512 - 1) / 512); i++) {
+
+		if (i == ((pginfo->num_pages + 512 - 1) / 512) - 1) {
+			rnum = pginfo->num_pages % 512; /* last shot */
+			if (rnum == 0)
+				rnum = 512;      /* last shot is full */
+		} else
+			rnum = 512;
+
+		if (rnum > 1) {
+			retcode = ehca_set_pagebuf(e_mr, pginfo, rnum, kpage);
+			if (retcode) {
+				EDEB_ERR(4, "ehca_set_pagebuf bad rc, "
+					 "retcode=%x rnum=%x kpage=%p",
+					 retcode, rnum, kpage);
+				retcode = -EFAULT;
+				goto ehca_reg_mr_rpages_exit1;
+			}
+			rpage = ehca_kv_to_g(kpage);
+			if (rpage == 0) {
+				EDEB_ERR(4, "kpage=%p i=%x", kpage, i);
+				retcode = -EFAULT;
+				goto ehca_reg_mr_rpages_exit1;
+			}
+		} else {  /* rnum==1 */
+			retcode = ehca_set_pagebuf_1(e_mr, pginfo, &rpage);
+			if (retcode) {
+				EDEB_ERR(4, "ehca_set_pagebuf_1 bad rc, "
+					 "retcode=%x i=%x", retcode, i);
+				retcode = -EFAULT;
+				goto ehca_reg_mr_rpages_exit1;
+			}
+		}
+
+		EDEB(9, "i=%x rnum=%x rpage=%lx", i, rnum, rpage);
+
+		rc = hipz_h_register_rpage_mr(shca->ipz_hca_handle,
+					      &e_mr->ipz_mr_handle, pfmr,
+					      &shca->pf,
+					      0, /* pagesize hardcoded to 4k */
+					      0, rpage, rnum);
+
+		if (i == ((pginfo->num_pages + 512 - 1) / 512) - 1) {
+			/* check for 'registration complete'==H_Success */
+			/* and for 'page registered'==H_PAGE_REGISTERED */
+			if (rc != H_Success) {
+				EDEB_ERR(4, "last hipz_reg_rpage_mr failed, "
+					 "rc=%lx e_mr=%p i=%x hca_hndl=%lx "
+					 "mr_hndl=%lx lkey=%x", rc, e_mr, i,
+					 shca->ipz_hca_handle.handle,
+					 e_mr->ipz_mr_handle.handle,
+					 e_mr->ib.ib_mr.lkey);
+				retcode = ehca_mrmw_map_rc_rrpg_last(rc);
+				break;
+			} else
+				retcode = 0;
+		} else if (rc != H_PAGE_REGISTERED) {
+			EDEB_ERR(4, "hipz_reg_rpage_mr failed, rc=%lx e_mr=%p "
+				 "i=%x lkey=%x hca_hndl=%lx mr_hndl=%lx",
+				 rc, e_mr, i, e_mr->ib.ib_mr.lkey,
+				 shca->ipz_hca_handle.handle,
+				 e_mr->ipz_mr_handle.handle);
+			retcode = ehca_mrmw_map_rc_rrpg_notlast(rc);
+			break;
+		} else
+			retcode = 0;
+	} /* end for(i) */
+
+
+       ehca_reg_mr_rpages_exit1:
+	kfree(kpage);
+       ehca_reg_mr_rpages_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "retcode=%x", retcode);
+	else
+		EDEB_EX(4, "retcode=%x shca=%p e_mr=%p pginfo=%p "
+			"num_pages=%lx",
+			retcode, shca, e_mr, pginfo, pginfo->num_pages);
+	return (retcode);
+} /* end ehca_reg_mr_rpages() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+inline int ehca_rereg_mr_rereg1(struct ehca_shca *shca,
+				struct ehca_mr *e_mr,
+				u64 *iova_start,
+				u64 size,
+				u32 acl,
+				struct ehca_pd *e_pd,
+				struct ehca_mr_pginfo *pginfo,
+				u32 *lkey,
+				u32 *rkey)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_mr->pf;
+	u64 iova_start_out = 0;
+	u32 hipz_acl = 0;
+	u64 *kpage = 0;
+	u64 rpage = 0;
+	struct ehca_mr_pginfo pginfo_save;
+
+	EDEB_EN(7, "shca=%p e_mr=%p iova_start=%p size=%lx acl=%x "
+		"e_pd=%p pginfo=%p num_pages=%lx", shca, e_mr,
+		iova_start, size, acl, e_pd, pginfo, pginfo->num_pages);
+
+	ehca_mrmw_map_acl(acl, &hipz_acl);
+	ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
+
+	kpage = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (kpage == 0) {
+		EDEB_ERR(4, "kpage alloc failed");
+		retcode = -ENOMEM;
+		goto ehca_rereg_mr_rereg1_exit0;
+	}
+	memset(kpage, 0, PAGE_SIZE);
+
+	pginfo_save = *pginfo;
+	retcode = ehca_set_pagebuf(e_mr, pginfo, pginfo->num_pages, kpage);
+	if (retcode != 0) {
+		EDEB_ERR(4, "set pagebuf failed, e_mr=%p pginfo=%p type=%x "
+			 "num_pages=%lx kpage=%p",
+			 e_mr, pginfo, pginfo->type, pginfo->num_pages, kpage);
+		goto ehca_rereg_mr_rereg1_exit1;
+	}
+	rpage = ehca_kv_to_g(kpage);
+	if (rpage == 0) {
+		EDEB_ERR(4, "kpage=%p", kpage);
+		retcode = -EFAULT;
+		goto ehca_rereg_mr_rereg1_exit1;
+	}
+	rc = hipz_h_reregister_pmr(shca->ipz_hca_handle, pfmr, &shca->pf,
+				   &e_mr->ipz_mr_handle, (u64)iova_start,
+				   size, hipz_acl, e_pd->fw_pd, rpage,
+				   &iova_start_out, lkey, rkey);
+	if (rc != H_Success) {
+		/* reregistration unsuccessful,                 */
+		/* try it again with the 3 hCalls,              */
+		/* e.g. this is required in case H_MR_CONDITION */
+		/* (MW bound or MR is shared)                   */
+		EDEB(6, "hipz_h_reregister_pmr failed (Rereg1), rc=%lx "
+		     "e_mr=%p", rc, e_mr);
+		*pginfo = pginfo_save;
+		retcode = -EAGAIN;
+	} else if ((u64 *)iova_start_out != iova_start) {
+		EDEB_ERR(4, "PHYP changed iova_start in rereg_pmr, "
+			 "iova_start=%p iova_start_out=%lx e_mr=%p "
+			 "mr_handle=%lx lkey=%x", iova_start, iova_start_out,
+			 e_mr, e_mr->ipz_mr_handle.handle, e_mr->ib.ib_mr.lkey);
+		retcode = -EFAULT;
+	} else {
+		/* successful reregistration */
+		/* note: start and start_out are identical for eServer HCAs */
+		e_mr->num_pages = pginfo->num_pages;
+		e_mr->start     = iova_start;
+		e_mr->size      = size;
+		e_mr->acl       = acl;
+	}
+
+       ehca_rereg_mr_rereg1_exit1:
+	kfree(kpage);
+       ehca_rereg_mr_rereg1_exit0:
+	if ((retcode == 0) || (retcode == -EAGAIN))
+		EDEB_EX(7, "retcode=%x rc=%lx lkey=%x rkey=%x pginfo=%p "
+			"num_pages=%lx",
+			retcode, rc, *lkey, *rkey, pginfo, pginfo->num_pages);
+	else
+		EDEB_EX(4, "retcode=%x rc=%lx lkey=%x rkey=%x pginfo=%p "
+			"num_pages=%lx",
+			retcode, rc, *lkey, *rkey, pginfo, pginfo->num_pages);
+	return (retcode);
+} /* end ehca_rereg_mr_rereg1() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_rereg_mr(struct ehca_shca *shca,
+		  struct ehca_mr *e_mr,
+		  u64 *iova_start,
+		  u64 size,
+		  int acl,
+		  struct ehca_pd *e_pd,
+		  struct ehca_mr_pginfo *pginfo,
+		  u32 *lkey,
+		  u32 *rkey)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_mr->pf;
+	int Rereg1Hcall = TRUE;	 /* TRUE: use hipz_h_reregister_pmr directly */
+	int Rereg3Hcall = FALSE; /* TRUE: use 3 hipz calls for reregistration */
+	struct ehca_bridge_handle save_bridge;
+
+	EDEB_EN(7, "shca=%p e_mr=%p iova_start=%p size=%lx acl=%x "
+		"e_pd=%p pginfo=%p num_pages=%lx", shca, e_mr,
+		iova_start, size, acl, e_pd, pginfo, pginfo->num_pages);
+
+	/* first determine reregistration hCall(s) */
+	if ((pginfo->num_pages > 512) || (e_mr->num_pages > 512) ||
+	    (pginfo->num_pages > e_mr->num_pages)) {
+		EDEB(7, "Rereg3 case, pginfo->num_pages=%lx "
+		     "e_mr->num_pages=%x", pginfo->num_pages, e_mr->num_pages);
+		Rereg1Hcall = FALSE;
+		Rereg3Hcall = TRUE;
+	}
+
+	if (e_mr->flags & EHCA_MR_FLAG_MAXMR) {	/* check for max-MR */
+		Rereg1Hcall = FALSE;
+		Rereg3Hcall = TRUE;
+		e_mr->flags &= ~EHCA_MR_FLAG_MAXMR;
+		EDEB(4, "Rereg MR for max-MR! e_mr=%p", e_mr);
+	}
+
+	if (Rereg1Hcall) {
+		retcode = ehca_rereg_mr_rereg1(shca, e_mr, iova_start, size,
+					       acl, e_pd, pginfo, lkey, rkey);
+		if (retcode != 0) {
+			if (retcode == -EAGAIN)
+				Rereg3Hcall = TRUE;
+			else
+				goto ehca_rereg_mr_exit0;
+		}
+	}
+
+	if (Rereg3Hcall) {
+		struct ehca_mr save_mr;
+
+		/* first deregister old MR */
+		rc = hipz_h_free_resource_mr(shca->ipz_hca_handle, pfmr,
+					     &e_mr->ipz_mr_handle);
+		if (rc != H_Success) {
+			EDEB_ERR(4, "hipz_free_mr failed, rc=%lx e_mr=%p "
+				 "hca_hndl=%lx mr_hndl=%lx mr->lkey=%x",
+				 rc, e_mr, shca->ipz_hca_handle.handle,
+				 e_mr->ipz_mr_handle.handle,
+				 e_mr->ib.ib_mr.lkey);
+			retcode = ehca_mrmw_map_rc_free_mr(rc);
+			goto ehca_rereg_mr_exit0;
+		}
+		/* clean ehca_mr_t, without changing struct ib_mr and lock */
+		save_bridge = pfmr->bridge;
+		save_mr = *e_mr;
+		ehca_mr_deletenew(e_mr);
+
+		/* set some MR values */
+		e_mr->flags = save_mr.flags;
+		pfmr->bridge = save_bridge;
+		e_mr->fmr_page_size = save_mr.fmr_page_size;
+		e_mr->fmr_max_pages = save_mr.fmr_max_pages;
+		e_mr->fmr_max_maps = save_mr.fmr_max_maps;
+		e_mr->fmr_map_cnt = save_mr.fmr_map_cnt;
+
+		retcode = ehca_reg_mr(shca, e_mr, iova_start, size, acl,
+				      e_pd, pginfo, lkey, rkey);
+		if (retcode != 0) {
+			u32 offset = (u64)(&e_mr->flags) - (u64)e_mr;
+			memcpy(&e_mr->flags, &(save_mr.flags),
+			       sizeof(struct ehca_mr) - offset);
+			goto ehca_rereg_mr_exit0;
+		}
+	}
+
+      ehca_rereg_mr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "retcode=%x shca=%p e_mr=%p iova_start=%p size=%lx "
+			"acl=%x e_pd=%p pginfo=%p num_pages=%lx lkey=%x "
+			"rkey=%x Rereg1Hcall=%x Rereg3Hcall=%x",
+			retcode, shca, e_mr, iova_start, size, acl, e_pd,
+			pginfo, pginfo->num_pages, *lkey, *rkey, Rereg1Hcall,
+			Rereg3Hcall);
+	else
+		EDEB_EX(4, "retcode=%x shca=%p e_mr=%p iova_start=%p size=%lx "
+			"acl=%x e_pd=%p pginfo=%p num_pages=%lx lkey=%x "
+			"rkey=%x Rereg1Hcall=%x Rereg3Hcall=%x",
+			retcode, shca, e_mr, iova_start, size, acl, e_pd,
+			pginfo, pginfo->num_pages, *lkey, *rkey, Rereg1Hcall,
+			Rereg3Hcall);
+
+	return (retcode);
+} /* end ehca_rereg_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_unmap_one_fmr(struct ehca_shca *shca,
+		       struct ehca_mr *e_fmr)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_fmr->pf;
+	int Rereg1Hcall = TRUE;	 /* TRUE: use hipz_mr_reregister directly */
+	int Rereg3Hcall = FALSE; /* TRUE: use 3 hipz calls for unmapping */
+	struct ehca_bridge_handle save_bridge;
+	struct ehca_pd *e_pd = 0;
+	struct ehca_mr save_fmr;
+	u32 tmp_lkey = 0;
+	u32 tmp_rkey = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+
+	EDEB_EN(7, "shca=%p e_fmr=%p", shca, e_fmr);
+
+	/* first check if reregistration hCall can be used for unmap */
+	if (e_fmr->fmr_max_pages > 512) {
+		Rereg1Hcall = FALSE;
+		Rereg3Hcall = TRUE;
+	}
+
+	e_pd = container_of(e_fmr->ib.ib_fmr.pd, struct ehca_pd, ib_pd);
+
+	if (Rereg1Hcall) {
+		/* note: after using rereg hcall with len=0,            */
+		/* rereg hcall must be used again for registering pages */
+		u64 start_out = 0;
+		rc = hipz_h_reregister_pmr(shca->ipz_hca_handle, pfmr,
+					   &shca->pf, &e_fmr->ipz_mr_handle, 0,
+					   0, 0, e_pd->fw_pd, 0, &start_out,
+					   &tmp_lkey, &tmp_rkey);
+		if (rc != H_Success) {
+			/* should not happen, because length checked above, */
+			/* FMRs are not shared and no MW bound to FMRs      */
+			EDEB_ERR(4, "hipz_reregister_pmr failed (Rereg1), "
+				 "rc=%lx e_fmr=%p hca_hndl=%lx mr_hndl=%lx "
+				 "lkey=%x", rc, e_fmr,
+				 shca->ipz_hca_handle.handle,
+				 e_fmr->ipz_mr_handle.handle,
+				 e_fmr->ib.ib_fmr.lkey);
+			Rereg3Hcall = TRUE;
+		} else {
+			/* successful reregistration */
+			e_fmr->start = 0;
+			e_fmr->size = 0;
+		}
+	}
+
+	if (Rereg3Hcall) {
+		struct ehca_mr save_mr;
+
+		/* first free old FMR */
+		rc = hipz_h_free_resource_mr(shca->ipz_hca_handle, pfmr,
+					     &e_fmr->ipz_mr_handle);
+		if (rc != H_Success) {
+			EDEB_ERR(4, "hipz_free_mr failed, rc=%lx e_fmr=%p "
+				 "hca_hndl=%lx mr_hndl=%lx lkey=%x", rc, e_fmr,
+				 shca->ipz_hca_handle.handle,
+				 e_fmr->ipz_mr_handle.handle,
+				 e_fmr->ib.ib_fmr.lkey);
+			retcode = ehca_mrmw_map_rc_free_mr(rc);
+			goto ehca_unmap_one_fmr_exit0;
+		}
+		/* clean ehca_mr_t, without changing lock */
+		save_bridge = pfmr->bridge;
+		save_fmr = *e_fmr;
+		ehca_mr_deletenew(e_fmr);
+
+		/* set some MR values */
+		e_fmr->flags = save_fmr.flags;
+		pfmr->bridge = save_bridge;
+		e_fmr->fmr_page_size = save_fmr.fmr_page_size;
+		e_fmr->fmr_max_pages = save_fmr.fmr_max_pages;
+		e_fmr->fmr_max_maps = save_fmr.fmr_max_maps;
+		e_fmr->fmr_map_cnt = save_fmr.fmr_map_cnt;
+		e_fmr->acl = save_fmr.acl;
+
+		pginfo.type      = EHCA_MR_PGI_FMR;
+		pginfo.num_pages = 0;
+		retcode = ehca_reg_mr(shca, e_fmr, 0,
+				      (e_fmr->fmr_max_pages *
+				       e_fmr->fmr_page_size),
+				      e_fmr->acl, e_pd, &pginfo, &tmp_lkey,
+				      &tmp_rkey);
+		if (retcode != 0) {
+			u32 offset = (u64)(&e_fmr->flags) - (u64)e_fmr;
+			memcpy(&e_fmr->flags, &(save_mr.flags),
+			       sizeof(struct ehca_mr) - offset);
+			goto ehca_unmap_one_fmr_exit0;
+		}
+	}
+
+      ehca_unmap_one_fmr_exit0:
+	EDEB_EX(7, "retcode=%x tmp_lkey=%x tmp_rkey=%x fmr_max_pages=%x "
+		"Rereg1Hcall=%x Rereg3Hcall=%x", retcode, tmp_lkey, tmp_rkey,
+		e_fmr->fmr_max_pages, Rereg1Hcall, Rereg3Hcall);
+	return (retcode);
+} /* end ehca_unmap_one_fmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_reg_smr(struct ehca_shca *shca,
+		 struct ehca_mr *e_origmr,
+		 struct ehca_mr *e_newmr,
+		 u64 *iova_start,
+		 int acl,
+		 struct ehca_pd *e_pd,
+		 u32 *lkey,
+		 u32 *rkey)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_newmr->pf;
+	u32 hipz_acl = 0;
+
+	EDEB_EN(7,"shca=%p e_origmr=%p e_newmr=%p iova_start=%p acl=%x e_pd=%p",
+		shca, e_origmr, e_newmr, iova_start, acl, e_pd);
+
+	ehca_mrmw_map_acl(acl, &hipz_acl);
+	ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
+
+	rc = hipz_h_register_smr(shca->ipz_hca_handle, pfmr, &e_origmr->pf,
+				 &shca->pf, &e_origmr->ipz_mr_handle,
+				 (u64)iova_start, hipz_acl, e_pd->fw_pd,
+				 &e_newmr->ipz_mr_handle, lkey, rkey);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_reg_smr failed, rc=%lx shca=%p e_origmr=%p "
+			 "e_newmr=%p iova_start=%p acl=%x e_pd=%p hca_hndl=%lx "
+			 "mr_hndl=%lx lkey=%x", rc, shca, e_origmr, e_newmr,
+			 iova_start, acl, e_pd, shca->ipz_hca_handle.handle,
+			 e_origmr->ipz_mr_handle.handle,
+			 e_origmr->ib.ib_mr.lkey);
+		retcode = ehca_mrmw_map_rc_reg_smr(rc);
+		goto ehca_reg_smr_exit0;
+	}
+	/* successful registration */
+	e_newmr->num_pages = e_origmr->num_pages;
+	e_newmr->start = iova_start;
+	e_newmr->size = e_origmr->size;
+	e_newmr->acl = acl;
+	goto ehca_reg_smr_exit0;
+
+      ehca_reg_smr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "retcode=%x lkey=%x rkey=%x",
+			retcode, *lkey, *rkey);
+	else
+		EDEB_EX(4, "retcode=%x shca=%p e_origmr=%p e_newmr=%p "
+			"iova_start=%p acl=%x e_pd=%p", retcode,
+			shca, e_origmr, e_newmr, iova_start, acl, e_pd);
+	return (retcode);
+} /* end ehca_reg_smr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_reg_internal_maxmr(
+	struct ehca_shca *shca,
+	struct ehca_pd *e_pd,
+	struct ehca_mr **e_maxmr)
+{
+	int retcode = 0;
+	struct ehca_mr *e_mr = 0;
+	u64 *iova_start = 0;
+	u64 size_maxmr = 0;
+	struct ehca_mr_pginfo pginfo={0,0,0,0,0,0,0,0,0,0,0,0};
+	struct ib_phys_buf ib_pbuf;
+	u32 num_pages_mr = 0;
+
+	EDEB_EN(7, "shca=%p e_pd=%p e_maxmr=%p", shca, e_pd, e_maxmr);
+
+	if (ehca_adr_bad(shca) || ehca_adr_bad(e_pd) || ehca_adr_bad(e_maxmr)) {
+		EDEB_ERR(4, "bad input values: shca=%p e_pd=%p e_maxmr=%p",
+			 shca, e_pd, e_maxmr);
+		retcode = -EINVAL;
+		goto ehca_reg_internal_maxmr_exit0;
+	}
+
+	e_mr = ehca_mr_new();
+	if (!e_mr) {
+		EDEB_ERR(4, "out of memory");
+		retcode = -ENOMEM;
+		goto ehca_reg_internal_maxmr_exit0;
+	}
+	e_mr->flags |= EHCA_MR_FLAG_MAXMR;
+
+	/* register internal max-MR on HCA */
+	size_maxmr = (u64)high_memory - PAGE_OFFSET;
+	EDEB(9, "high_memory=%p PAGE_OFFSET=%lx", high_memory, PAGE_OFFSET);
+	iova_start = (u64 *)KERNELBASE;
+	ib_pbuf.addr = 0;
+	ib_pbuf.size = size_maxmr;
+	num_pages_mr =
+		((((u64)iova_start % PAGE_SIZE) + size_maxmr +
+		  PAGE_SIZE - 1) / PAGE_SIZE);
+
+	pginfo.type           = EHCA_MR_PGI_PHYS;
+	pginfo.num_pages      = num_pages_mr;
+	pginfo.num_phys_buf   = 1;
+	pginfo.phys_buf_array = &ib_pbuf;
+
+	retcode = ehca_reg_mr(shca, e_mr, iova_start, size_maxmr, 0, e_pd,
+			      &pginfo, &e_mr->ib.ib_mr.lkey,
+			      &e_mr->ib.ib_mr.rkey);
+	if (retcode != 0) {
+		EDEB_ERR(4, "reg of internal max MR failed, e_mr=%p "
+			 "iova_start=%p size_maxmr=%lx num_pages_mr=%x",
+			 e_mr, iova_start, size_maxmr, num_pages_mr);
+		goto ehca_reg_internal_maxmr_exit1;
+	}
+
+	/* successful registration of all pages */
+	e_mr->ib.ib_mr.device = e_pd->ib_pd.device;
+	e_mr->ib.ib_mr.pd = &e_pd->ib_pd;
+	e_mr->ib.ib_mr.uobject = NULL;
+	atomic_inc(&(e_pd->ib_pd.usecnt));
+	atomic_set(&(e_mr->ib.ib_mr.usecnt), 0);
+	*e_maxmr = e_mr;
+	goto ehca_reg_internal_maxmr_exit0;
+
+      ehca_reg_internal_maxmr_exit1:
+	ehca_mr_delete(e_mr);
+      ehca_reg_internal_maxmr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "*e_maxmr=%p lkey=%x rkey=%x",
+			*e_maxmr, (*e_maxmr)->ib.ib_mr.lkey,
+			(*e_maxmr)->ib.ib_mr.rkey);
+	else
+		EDEB_EX(4, "retcode=%x shca=%p e_pd=%p e_maxmr=%p",
+			retcode, shca, e_pd, e_maxmr);
+	return (retcode);
+} /* end ehca_reg_internal_maxmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_reg_maxmr(struct ehca_shca *shca,
+		   struct ehca_mr *e_newmr,
+		   u64 *iova_start,
+		   int acl,
+		   struct ehca_pd *e_pd,
+		   u32 *lkey,
+		   u32 *rkey)
+{
+	int retcode = 0;
+	u64 rc = H_Success;
+	struct ehca_pfmr *pfmr = &e_newmr->pf;
+	struct ehca_mr *e_origmr = shca->maxmr;
+	u32 hipz_acl = 0;
+
+	EDEB_EN(7,"shca=%p e_origmr=%p e_newmr=%p iova_start=%p acl=%x e_pd=%p",
+		shca, e_origmr, e_newmr, iova_start, acl, e_pd);
+
+	ehca_mrmw_map_acl(acl, &hipz_acl);
+	ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
+
+	rc = hipz_h_register_smr(shca->ipz_hca_handle, pfmr, &e_origmr->pf,
+				 &shca->pf, &e_origmr->ipz_mr_handle,
+				 (u64)iova_start, hipz_acl, e_pd->fw_pd,
+				 &e_newmr->ipz_mr_handle, lkey, rkey);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "hipz_reg_smr failed, rc=%lx e_origmr=%p "
+			 "hca_hndl=%lx mr_hndl=%lx lkey=%x",
+			 rc, e_origmr, shca->ipz_hca_handle.handle,
+			 e_origmr->ipz_mr_handle.handle,
+			 e_origmr->ib.ib_mr.lkey);
+		retcode = ehca_mrmw_map_rc_reg_smr(rc);
+		goto ehca_reg_maxmr_exit0;
+	}
+	/* successful registration */
+	e_newmr->num_pages = e_origmr->num_pages;
+	e_newmr->start = iova_start;
+	e_newmr->size = e_origmr->size;
+	e_newmr->acl = acl;
+
+      ehca_reg_maxmr_exit0:
+	EDEB_EX(7, "retcode=%x lkey=%x rkey=%x", retcode, *lkey, *rkey);
+	return (retcode);
+} /* end ehca_reg_maxmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+int ehca_dereg_internal_maxmr(struct ehca_shca *shca)
+{
+	int retcode = 0;
+	struct ehca_mr *e_maxmr = 0;
+	struct ib_pd *ib_pd = 0;
+
+	EDEB_EN(7, "shca=%p shca->maxmr=%p", shca, shca->maxmr);
+
+	if (shca->maxmr == 0) {
+		EDEB_ERR(4, "bad call, shca=%p", shca);
+		retcode = -EINVAL;
+		goto ehca_dereg_internal_maxmr_exit0;
+	}
+
+	e_maxmr = shca->maxmr;
+	ib_pd = e_maxmr->ib.ib_mr.pd;
+	shca->maxmr = 0; /* remove internal max-MR indication from SHCA */
+
+	retcode = ehca_dereg_mr(&e_maxmr->ib.ib_mr);
+	if (retcode != 0) {
+		EDEB_ERR(3, "dereg internal max-MR failed, "
+			 "retcode=%x e_maxmr=%p shca=%p lkey=%x",
+			 retcode, e_maxmr, shca, e_maxmr->ib.ib_mr.lkey);
+		shca->maxmr = e_maxmr;
+		goto ehca_dereg_internal_maxmr_exit0;
+	}
+
+	atomic_dec(&ib_pd->usecnt);
+
+      ehca_dereg_internal_maxmr_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "");
+	else
+		EDEB_EX(4, "retcode=%x shca=%p shca->maxmr=%p",
+			retcode, shca, shca->maxmr);
+	return (retcode);
+} /* end ehca_dereg_internal_maxmr() */
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.h b/drivers/infiniband/hw/ehca/ehca_mrmw.h
new file mode 100644
index 0000000..4df4b5b
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.h
@@ -0,0 +1,739 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  MR/MW declarations and inline functions
+ *
+ *  Authors: Dietmar Decker <ddecker@de.ibm.com>
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
+ *  $Id: ehca_mrmw.h,v 1.59 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef _EHCA_MRMW_H_
+#define _EHCA_MRMW_H_
+
+#undef DEB_PREFIX
+#define DEB_PREFIX "mrmw"
+
+#include "hipz_structs.h"
+
+
+int ehca_reg_mr(struct ehca_shca *shca,
+		struct ehca_mr *e_mr,
+		u64 *iova_start,
+		u64 size,
+		int acl,
+		struct ehca_pd *e_pd,
+		struct ehca_mr_pginfo *pginfo,
+		u32 *lkey,  /**<OUT*/
+		u32 *rkey); /**<OUT*/
+
+int ehca_reg_mr_rpages(struct ehca_shca *shca,
+		       struct ehca_mr *e_mr,
+		       struct ehca_mr_pginfo *pginfo);
+
+int ehca_rereg_mr(struct ehca_shca *shca,
+		  struct ehca_mr *e_mr,
+		  u64 *iova_start,
+		  u64 size,
+		  int mr_access_flags,
+		  struct ehca_pd *e_pd,
+		  struct ehca_mr_pginfo *pginfo,
+		  u32 *lkey,  /**<OUT*/
+		  u32 *rkey); /**<OUT*/
+
+int ehca_unmap_one_fmr(struct ehca_shca *shca,
+		       struct ehca_mr *e_fmr);
+
+int ehca_reg_smr(struct ehca_shca *shca,
+		 struct ehca_mr *e_origmr,
+		 struct ehca_mr *e_newmr,
+		 u64 *iova_start,
+		 int acl,
+		 struct ehca_pd *e_pd,
+		 u32 *lkey,  /**<OUT*/
+		 u32 *rkey); /**<OUT*/
+
+/** @brief register internal max-MR to internal SHCA
+ */
+int ehca_reg_internal_maxmr(struct ehca_shca *shca,  /**<IN*/
+			    struct ehca_pd *e_pd,    /**<IN*/
+			    struct ehca_mr **maxmr); /**<OUT*/
+
+int ehca_reg_maxmr(struct ehca_shca *shca,
+		   struct ehca_mr *e_newmr,
+		   u64 *iova_start,
+		   int acl,
+		   struct ehca_pd *e_pd,
+		   u32 *lkey,
+		   u32 *rkey);
+
+int ehca_dereg_internal_maxmr(struct ehca_shca *shca);
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief check physical buffer array of MR verbs for validness and
+ calculates MR size
+*/
+static inline int ehca_mr_chk_buf_and_calc_size(
+	struct ib_phys_buf *phys_buf_array, /**<IN*/
+	int num_phys_buf,                   /**<IN*/
+	u64 *iova_start,                    /**<IN*/
+	u64 *size)                          /**<OUT*/
+{
+	struct ib_phys_buf *pbuf = phys_buf_array;
+	u64 size_count = 0;
+	u32 i;
+
+	if (num_phys_buf == 0) {
+		EDEB_ERR(4, "bad phys buf array len, num_phys_buf=0");
+		return (-EINVAL);
+	}
+	/* check first buffer */
+	if (((u64)iova_start & ~PAGE_MASK) != (pbuf->addr & ~PAGE_MASK)) {
+		EDEB_ERR(4, "iova_start/addr mismatch, iova_start=%p "
+			 "pbuf->addr=%lx pbuf->size=%lx",
+			 iova_start, pbuf->addr, pbuf->size);
+		return (-EINVAL);
+	}
+	if (((pbuf->addr + pbuf->size) % PAGE_SIZE) &&
+	    (num_phys_buf > 1)) {
+		EDEB_ERR(4, "addr/size mismatch in 1st buf, pbuf->addr=%lx "
+			 "pbuf->size=%lx", pbuf->addr, pbuf->size);
+		return (-EINVAL);
+	}
+
+	for (i = 0; i < num_phys_buf; i++) {
+		if ((i > 0) && (pbuf->addr % PAGE_SIZE)) {
+			EDEB_ERR(4, "bad address, i=%x pbuf->addr=%lx "
+				 "pbuf->size=%lx", i, pbuf->addr, pbuf->size);
+			return (-EINVAL);
+		}
+		if (((i > 0) &&	/* not 1st */
+		     (i < (num_phys_buf - 1)) &&	/* not last */
+		     (pbuf->size % PAGE_SIZE)) || (pbuf->size == 0)) {
+			EDEB_ERR(4, "bad size, i=%x pbuf->size=%lx",
+				 i, pbuf->size);
+			return (-EINVAL);
+		}
+		size_count += pbuf->size;
+		pbuf++;
+	}
+
+	*size = size_count;
+	return (0);
+} /* end ehca_mr_chk_buf_and_calc_size() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief check page list of map FMR verb for validness
+*/
+static inline int ehca_fmr_check_page_list(
+	struct ehca_mr *e_fmr, /**<IN*/
+	u64 *page_list,        /**<IN*/
+	int list_len)          /**<IN*/
+{
+	u32 i;
+	u64 *page = 0;
+
+	if (ehca_adr_bad(page_list)) {
+		EDEB_ERR(4, "bad page_list, page_list=%p fmr=%p",
+			 page_list, e_fmr);
+		return (-EINVAL);
+	}
+
+	if ((list_len == 0) || (list_len > e_fmr->fmr_max_pages)) {
+		EDEB_ERR(4, "bad list_len, list_len=%x e_fmr->fmr_max_pages=%x "
+			 "fmr=%p", list_len, e_fmr->fmr_max_pages, e_fmr);
+		return (-EINVAL);
+	}
+
+	/* each page must be aligned */
+	page = page_list;
+	for (i = 0; i < list_len; i++) {
+		if (*page % PAGE_SIZE) {
+			EDEB_ERR(4, "bad page, i=%x *page=%lx page=%p "
+				 "fmr=%p", i, *page, page, e_fmr);
+			return (-EINVAL);
+		}
+		page++;
+	}
+
+	return (0);
+} /* end ehca_fmr_check_page_list() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief setup page buffer from page info
+ */
+static inline int ehca_set_pagebuf(struct ehca_mr *e_mr,
+				   struct ehca_mr_pginfo *pginfo,
+				   u32 number,
+				   u64 *kpage) /**<OUT*/
+{
+	int retcode = 0;
+	struct ib_umem_chunk *prev_chunk = NULL;
+	struct ib_umem_chunk *chunk      = NULL;
+	struct ib_phys_buf *pbuf         = NULL;
+	u64 *fmrlist = NULL;
+	u64 numpg  = 0;
+	u64 pgaddr = 0;
+	u32 i = 0;
+	u32 j = 0;
+
+
+	EDEB_EN(7, "pginfo=%p type=%x num_pages=%lx next_buf=%lx next_page=%lx "
+		"number=%x kpage=%p page_count=%lx next_listelem=%lx "
+		"region=%p next_chunk=%p next_nmap=%lx",
+		pginfo, pginfo->type, pginfo->num_pages, pginfo->next_buf,
+		pginfo->next_page, number, kpage, pginfo->page_count,
+		pginfo->next_listelem, pginfo->region, pginfo->next_chunk,
+		pginfo->next_nmap);
+
+	if (pginfo->type == EHCA_MR_PGI_PHYS) {
+		/* loop over desired phys_buf_array entries */
+		while (i < number) {
+			pbuf  = pginfo->phys_buf_array + pginfo->next_buf;
+			numpg = ((pbuf->size + PAGE_SIZE - 1) / PAGE_SIZE);
+			while (pginfo->next_page < numpg) {
+				/* sanity check */
+				if (pginfo->page_count >= pginfo->num_pages) {
+					EDEB_ERR(4, "page_count >= num_pages, "
+						 "page_count=%lx num_pages=%lx "
+						 "i=%x", pginfo->page_count,
+						 pginfo->num_pages, i);
+					retcode = -EFAULT;
+					goto ehca_set_pagebuf_exit0;
+				}
+				*kpage = phys_to_abs((pbuf->addr & PAGE_MASK)
+						     + (pginfo->next_page *
+							PAGE_SIZE));
+				if ((*kpage == 0) && (pbuf->addr != 0)) {
+					EDEB_ERR(4, "pbuf->addr=%lx"
+						 " pbuf->size=%lx"
+						 " next_page=%lx",
+						 pbuf->addr, pbuf->size,
+						 pginfo->next_page);
+					retcode = -EFAULT;
+					goto ehca_set_pagebuf_exit0;
+				}
+				(pginfo->next_page)++;
+				(pginfo->page_count)++;
+				kpage++;
+				i++;
+				if (i >= number) break;
+			}
+			if (pginfo->next_page >= numpg) {
+				(pginfo->next_buf)++;
+				pginfo->next_page = 0;
+			}
+		}
+	} else if (pginfo->type == EHCA_MR_PGI_USER) {
+		/* loop over desired chunk entries */
+		/* (@TODO: add support for large pages) */
+		chunk      = pginfo->next_chunk;
+		prev_chunk = pginfo->next_chunk;
+		list_for_each_entry_continue(chunk,
+					     (&(pginfo->region->chunk_list)),
+					     list) {
+			EDEB(9, "chunk->page_list[0]=%lx",
+			     (u64)sg_dma_address(&chunk->page_list[0]));
+			for (i = pginfo->next_nmap; i < chunk->nmap; i++) {
+				pgaddr = ( page_to_pfn(chunk->page_list[i].page)
+					   << PAGE_SHIFT );
+				*kpage = phys_to_abs(pgaddr);
+				EDEB(9,"pgaddr=%lx *kpage=%lx", pgaddr, *kpage);
+				if (*kpage == 0) {
+					EDEB_ERR(4, "chunk->page_list[i]=%lx"
+						 " i=%x mr=%p",
+						 (u64)sg_dma_address(
+							 &chunk->page_list[i]),
+						 i, e_mr);
+					retcode = -EFAULT;
+					goto ehca_set_pagebuf_exit0;
+				}
+				(pginfo->page_count)++;
+				(pginfo->next_nmap)++;
+				kpage++;
+				j++;
+				if (j >= number) break;
+			}
+			if ( (pginfo->next_nmap >= chunk->nmap) &&
+			     (j >= number) ) {
+				pginfo->next_nmap = 0;
+				prev_chunk = chunk;
+				break;
+			} else if (pginfo->next_nmap >= chunk->nmap) {
+				pginfo->next_nmap = 0;
+				prev_chunk = chunk;
+			} else if (j >= number)
+				break;
+			else
+				prev_chunk = chunk;
+		}
+		pginfo->next_chunk =
+			list_prepare_entry(prev_chunk,
+					   (&(pginfo->region->chunk_list)),
+					   list);
+	} else if (pginfo->type == EHCA_MR_PGI_FMR) {
+		/* loop over desired page_list entries */
+		fmrlist = pginfo->page_list + pginfo->next_listelem;
+		for (i = 0; i < number; i++) {
+			*kpage = phys_to_abs(*fmrlist);
+			if (*kpage == 0) {
+				EDEB_ERR(4, "*fmrlist=%lx fmrlist=%p"
+					 " next_listelem=%lx", *fmrlist,
+					 fmrlist, pginfo->next_listelem);
+				retcode = -EFAULT;
+				goto ehca_set_pagebuf_exit0;
+			}
+			(pginfo->next_listelem)++;
+			(pginfo->page_count)++;
+			fmrlist++;
+			kpage++;
+		}
+	} else {
+		EDEB_ERR(4, "bad pginfo->type=%x", pginfo->type);
+		retcode = -EFAULT;
+		goto ehca_set_pagebuf_exit0;
+	}
+
+      ehca_set_pagebuf_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "retcode=%x e_mr=%p pginfo=%p type=%x num_pages=%lx "
+			"next_buf=%lx next_page=%lx number=%x kpage=%p "
+			"page_count=%lx i=%x next_listelem=%lx region=%p "
+			"next_chunk=%p next_nmap=%lx",
+			retcode, e_mr, pginfo, pginfo->type, pginfo->num_pages,
+			pginfo->next_buf, pginfo->next_page, number, kpage,
+			pginfo->page_count, i, pginfo->next_listelem,
+			pginfo->region, pginfo->next_chunk, pginfo->next_nmap);
+	else
+		EDEB_EX(4, "retcode=%x e_mr=%p pginfo=%p type=%x num_pages=%lx "
+			"next_buf=%lx next_page=%lx number=%x kpage=%p "
+			"page_count=%lx i=%x next_listelem=%lx region=%p "
+			"next_chunk=%p next_nmap=%lx",
+			retcode, e_mr, pginfo, pginfo->type, pginfo->num_pages,
+			pginfo->next_buf, pginfo->next_page, number, kpage,
+			pginfo->page_count, i, pginfo->next_listelem,
+			pginfo->region, pginfo->next_chunk, pginfo->next_nmap);
+	return (retcode);
+} /* end ehca_set_pagebuf() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief setup 1 page from page info page buffer
+ */
+static inline int ehca_set_pagebuf_1(struct ehca_mr *e_mr,
+				     struct ehca_mr_pginfo *pginfo,
+				     u64 *rpage) /**<OUT*/
+{
+	int retcode = 0;
+	struct ib_phys_buf *tmp_pbuf = 0;
+	u64 *tmp_fmrlist = 0;
+	struct ib_umem_chunk *chunk = 0;
+	struct ib_umem_chunk *prev_chunk = 0;
+	u64 pgaddr = 0;
+
+	EDEB_EN(7, "pginfo=%p type=%x num_pages=%lx next_buf=%lx next_page=%lx "
+		"rpage=%p page_count=%lx next_listelem=%lx region=%p "
+		"next_chunk=%p next_nmap=%lx",
+		pginfo, pginfo->type, pginfo->num_pages, pginfo->next_buf,
+		pginfo->next_page, rpage, pginfo->page_count,
+		pginfo->next_listelem, pginfo->region, pginfo->next_chunk,
+		pginfo->next_nmap);
+
+	if (pginfo->type == EHCA_MR_PGI_PHYS) {
+		/* sanity check */
+		if (pginfo->page_count >= pginfo->num_pages) {
+			EDEB_ERR(4, "page_count >= num_pages, "
+				 "page_count=%lx num_pages=%lx",
+				 pginfo->page_count, pginfo->num_pages);
+			retcode = -EFAULT;
+			goto ehca_set_pagebuf_1_exit0;
+		}
+		tmp_pbuf = pginfo->phys_buf_array + pginfo->next_buf;
+		*rpage = phys_to_abs(((tmp_pbuf->addr & PAGE_MASK) +
+				      (pginfo->next_page * PAGE_SIZE)));
+		if ((*rpage == 0) && (tmp_pbuf->addr != 0)) {
+			EDEB_ERR(4, "tmp_pbuf->addr=%lx"
+				 " tmp_pbuf->size=%lx next_page=%lx",
+				 tmp_pbuf->addr, tmp_pbuf->size,
+				 pginfo->next_page);
+			retcode = -EFAULT;
+			goto ehca_set_pagebuf_1_exit0;
+		}
+		(pginfo->next_page)++;
+		(pginfo->page_count)++;
+		if (pginfo->next_page >= tmp_pbuf->size / PAGE_SIZE) {
+			(pginfo->next_buf)++;
+			pginfo->next_page = 0;
+		}
+	} else if (pginfo->type == EHCA_MR_PGI_USER) {
+		chunk      = pginfo->next_chunk;
+		prev_chunk = pginfo->next_chunk;
+		list_for_each_entry_continue(chunk,
+					     (&(pginfo->region->chunk_list)),
+					     list) {
+			pgaddr = ( page_to_pfn(chunk->page_list[
+						       pginfo->next_nmap].page)
+				   << PAGE_SHIFT );
+			*rpage = phys_to_abs(pgaddr);
+			EDEB(9,"pgaddr=%lx *rpage=%lx", pgaddr, *rpage);
+			if (*rpage == 0) {
+				EDEB_ERR(4, "chunk->page_list[]=%lx next_nmap=%lx "
+					 "mr=%p", (u64)sg_dma_address(
+						 &chunk->page_list[
+							 pginfo->next_nmap]),
+					 pginfo->next_nmap, e_mr);
+				retcode = -EFAULT;
+				goto ehca_set_pagebuf_1_exit0;
+			}
+			(pginfo->page_count)++;
+			(pginfo->next_nmap)++;
+			if (pginfo->next_nmap >= chunk->nmap) {
+				pginfo->next_nmap = 0;
+				prev_chunk = chunk;
+			}
+			break;
+		}
+		pginfo->next_chunk =
+			list_prepare_entry(prev_chunk,
+					   (&(pginfo->region->chunk_list)),
+					   list);
+	} else if (pginfo->type == EHCA_MR_PGI_FMR) {
+		tmp_fmrlist = pginfo->page_list + pginfo->next_listelem;
+		*rpage = phys_to_abs(*tmp_fmrlist);
+		if (*rpage == 0) {
+			EDEB_ERR(4, "*tmp_fmrlist=%lx tmp_fmrlist=%p"
+				 " next_listelem=%lx", *tmp_fmrlist,
+				 tmp_fmrlist, pginfo->next_listelem);
+			retcode = -EFAULT;
+			goto ehca_set_pagebuf_1_exit0;
+		}
+		(pginfo->next_listelem)++;
+		(pginfo->page_count)++;
+	} else {
+		EDEB_ERR(4, "bad pginfo->type=%x", pginfo->type);
+		retcode = -EFAULT;
+		goto ehca_set_pagebuf_1_exit0;
+	}
+
+      ehca_set_pagebuf_1_exit0:
+	if (retcode == 0)
+		EDEB_EX(7, "retcode=%x e_mr=%p pginfo=%p type=%x num_pages=%lx "
+			"next_buf=%lx next_page=%lx rpage=%p page_count=%lx "
+			"next_listelem=%lx region=%p next_chunk=%p "
+			"next_nmap=%lx",
+			retcode, e_mr, pginfo, pginfo->type, pginfo->num_pages,
+			pginfo->next_buf, pginfo->next_page, rpage,
+			pginfo->page_count, pginfo->next_listelem,
+			pginfo->region, pginfo->next_chunk, pginfo->next_nmap);
+	else
+		EDEB_EX(4, "retcode=%x e_mr=%p pginfo=%p type=%x num_pages=%lx "
+			"next_buf=%lx next_page=%lx rpage=%p page_count=%lx "
+			"next_listelem=%lx region=%p next_chunk=%p "
+			"next_nmap=%lx",
+			retcode, e_mr, pginfo, pginfo->type, pginfo->num_pages,
+			pginfo->next_buf, pginfo->next_page, rpage,
+			pginfo->page_count, pginfo->next_listelem,
+			pginfo->region, pginfo->next_chunk, pginfo->next_nmap);
+	return (retcode);
+} /* end ehca_set_pagebuf_1() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief check MR if it is a max-MR, i.e. uses whole memory
+    in case it's a max-MR TRUE is returned, else FALSE
+*/
+static inline int ehca_mr_is_maxmr(u64 size,
+				   u64 *iova_start)
+{
+	/* a MR is treated as max-MR only if it fits following: */
+	if ((size == ((u64)high_memory - PAGE_OFFSET)) &&
+	    (iova_start == (void*)KERNELBASE)) {
+		EDEB(6, "this is a max-MR");
+		return (TRUE);
+	} else
+		return (FALSE);
+} /* end ehca_mr_is_maxmr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+/** @brief map access control for MR/MW.
+    This routine is used for MR and MW.
+*/
+static inline void ehca_mrmw_map_acl(int ib_acl,    /**<IN*/
+				     u32 *hipz_acl) /**<OUT*/
+{
+	*hipz_acl = 0;
+	if (ib_acl & IB_ACCESS_REMOTE_READ)
+		*hipz_acl |= HIPZ_ACCESSCTRL_R_READ;
+	if (ib_acl & IB_ACCESS_REMOTE_WRITE)
+		*hipz_acl |= HIPZ_ACCESSCTRL_R_WRITE;
+	if (ib_acl & IB_ACCESS_REMOTE_ATOMIC)
+		*hipz_acl |= HIPZ_ACCESSCTRL_R_ATOMIC;
+	if (ib_acl & IB_ACCESS_LOCAL_WRITE)
+		*hipz_acl |= HIPZ_ACCESSCTRL_L_WRITE;
+	if (ib_acl & IB_ACCESS_MW_BIND)
+		*hipz_acl |= HIPZ_ACCESSCTRL_MW_BIND;
+} /* end ehca_mrmw_map_acl() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief sets page size in hipz access control for MR/MW.
+ */
+static inline void ehca_mrmw_set_pgsize_hipz_acl(
+	u32 *hipz_acl) /**<INOUT HIPZ access control */
+{
+	/* @TODO page size of 4k currently hardcoded ... */
+	return;
+} /* end ehca_mrmw_set_pgsize_hipz_acl() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief reverse map access control for MR/MW.
+    This routine is used for MR and MW.
+*/
+static inline void ehca_mrmw_reverse_map_acl(
+	const u32 *hipz_acl, /**<IN*/
+	int *ib_acl)	     /**<OUT*/
+{
+	*ib_acl = 0;
+	if (*hipz_acl & HIPZ_ACCESSCTRL_R_READ)
+		*ib_acl |= IB_ACCESS_REMOTE_READ;
+	if (*hipz_acl & HIPZ_ACCESSCTRL_R_WRITE)
+		*ib_acl |= IB_ACCESS_REMOTE_WRITE;
+	if (*hipz_acl & HIPZ_ACCESSCTRL_R_ATOMIC)
+		*ib_acl |= IB_ACCESS_REMOTE_ATOMIC;
+	if (*hipz_acl & HIPZ_ACCESSCTRL_L_WRITE)
+		*ib_acl |= IB_ACCESS_LOCAL_WRITE;
+	if (*hipz_acl & HIPZ_ACCESSCTRL_MW_BIND)
+		*ib_acl |= IB_ACCESS_MW_BIND;
+} /* end ehca_mrmw_reverse_map_acl() */
+
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for MR/MW allocations
+    Used for hipz_mr_reg_alloc and hipz_mw_alloc.
+*/
+static inline int ehca_mrmw_map_rc_alloc(const u64 rc)
+{
+	switch (rc) {
+	case H_Success:	             /* successful completion */
+		return (0);
+	case H_ADAPTER_PARM:         /* invalid adapter handle */
+	case H_RT_PARM:              /* invalid resource type */
+	case H_NOT_ENOUGH_RESOURCES: /* insufficient resources */
+	case H_MLENGTH_PARM:         /* invalid memory length */
+	case H_MEM_ACCESS_PARM:      /* invalid access controls */
+	case H_Constrained:          /* resource constraint */
+		return (-EINVAL);
+	case H_Busy:                 /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_alloc() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for MR register rpage
+    Used for hipz_h_register_rpage_mr at registering last page
+*/
+static inline int ehca_mrmw_map_rc_rrpg_last(const u64 rc)
+{
+	switch (rc) {
+	case H_Success:         /* registration complete */
+		return (0);
+	case H_PAGE_REGISTERED:	/* page registered */
+	case H_ADAPTER_PARM:    /* invalid adapter handle */
+	case H_RH_PARM:         /* invalid resource handle */
+/*	case H_QT_PARM:            invalid queue type */
+	case H_Parameter:       /* invalid logical address, */
+		                /* or count zero or greater 512 */
+	case H_TABLE_FULL:      /* page table full */
+	case H_Hardware:        /* HCA not operational */
+		return (-EINVAL);
+	case H_Busy:            /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_rrpg_last() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for MR register rpage
+    Used for hipz_h_register_rpage_mr at registering one page, but not last page
+*/
+static inline int ehca_mrmw_map_rc_rrpg_notlast(const u64 rc)
+{
+	switch (rc) {
+	case H_PAGE_REGISTERED:	/* page registered */
+		return (0);
+	case H_Success:         /* registration complete */
+	case H_ADAPTER_PARM:    /* invalid adapter handle */
+	case H_RH_PARM:         /* invalid resource handle */
+/*	case H_QT_PARM:            invalid queue type */
+	case H_Parameter:       /* invalid logical address, */
+		                /* or count zero or greater 512 */
+	case H_TABLE_FULL:      /* page table full */
+	case H_Hardware:        /* HCA not operational */
+		return (-EINVAL);
+	case H_Busy:            /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_rrpg_notlast() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for MR query
+    Used for hipz_mr_query.
+*/
+static inline int ehca_mrmw_map_rc_query_mr(const u64 rc)
+{
+	switch (rc) {
+	case H_Success:	             /* successful completion */
+		return (0);
+	case H_ADAPTER_PARM:         /* invalid adapter handle */
+	case H_RH_PARM:              /* invalid resource handle */
+		return (-EINVAL);
+	case H_Busy:                 /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_query_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for freeing MR resource
+    Used for hipz_h_free_resource_mr
+*/
+static inline int ehca_mrmw_map_rc_free_mr(const u64 rc)
+{
+	switch (rc) {
+	case H_Success:	     /* resource freed */
+		return (0);
+	case H_ADAPTER_PARM: /* invalid adapter handle */
+	case H_RH_PARM:      /* invalid resource handle */
+	case H_R_STATE:      /* invalid resource state */
+	case H_Hardware:     /* HCA not operational */
+		return (-EINVAL);
+	case H_Resource:     /* Resource in use */
+	case H_Busy:         /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_free_mr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for freeing MW resource
+    Used for hipz_h_free_resource_mw
+*/
+static inline int ehca_mrmw_map_rc_free_mw(const u64 rc)
+{
+	switch (rc) {
+	case H_Success:	     /* resource freed */
+		return (0);
+	case H_ADAPTER_PARM: /* invalid adapter handle */
+	case H_RH_PARM:      /* invalid resource handle */
+	case H_R_STATE:      /* invalid resource state */
+	case H_Hardware:     /* HCA not operational */
+		return (-EINVAL);
+	case H_Resource:     /* Resource in use */
+	case H_Busy:         /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_free_mw() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief map HIPZ rc to IB retcodes for SMR registrations
+    Used for hipz_h_register_smr.
+*/
+static inline int ehca_mrmw_map_rc_reg_smr(const u64 rc)
+{
+	switch (rc) {
+	case H_Success:	             /* successful completion */
+		return (0);
+	case H_ADAPTER_PARM:         /* invalid adapter handle */
+	case H_RH_PARM:              /* invalid resource handle */
+	case H_MEM_PARM:             /* invalid MR virtual address */
+	case H_MEM_ACCESS_PARM:      /* invalid access controls */
+	case H_NOT_ENOUGH_RESOURCES: /* insufficient resources */
+		return (-EINVAL);
+	case H_Busy:                 /* long busy */
+		return (-EBUSY);
+	default:
+		return (-EINVAL);
+	}
+} /* end ehca_mrmw_map_rc_reg_smr() */
+
+/*----------------------------------------------------------------------*/
+/*----------------------------------------------------------------------*/
+
+/** @brief MR destructor and constructor
+    used in Reregister MR verb, memsets ehca_mr_t to 0,
+    except struct ib_mr and spinlock
+ */
+static inline void ehca_mr_deletenew(struct ehca_mr *mr)
+{
+	u32 offset = (u64)(&mr->flags) - (u64)mr;
+	memset(&mr->flags, 0, sizeof(*mr) - offset);
+} /* end ehca_mr_deletenew() */
+
+#endif /*_EHCA_MRMW_H_*/
