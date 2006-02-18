Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWBRA66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWBRA66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWBRA6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:50 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:61498 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751819AbWBRA5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:47 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 11/22] ehca event queues
Date: Fri, 17 Feb 2006 16:57:37 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005730.13620.53494.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:37.0125 (UTC) FILETIME=[4F58A950:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

in ehca_poll_eqs(), is there any reason not to use list_for_each_entry()?

Since ehca_poll_eqs() defers all the work to an workqueue, is
there any reason for it to run in a kernel thread?  Why not just
make it a recurring timer?
---

 drivers/infiniband/hw/ehca/ehca_eq.c |  242 ++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_eq.h |   78 +++++++++++
 2 files changed, 320 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_eq.c b/drivers/infiniband/hw/ehca/ehca_eq.c
new file mode 100644
index 0000000..e508edb
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_eq.c
@@ -0,0 +1,242 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Event queue handling
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
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
+ *  $Id: ehca_eq.c,v 1.40 2006/02/06 16:20:38 schickhj Exp $
+ */
+
+#define DEB_PREFIX "e_eq"
+
+#include "ehca_eq.h"
+#include "ehca_kernel.h"
+#include "ehca_classes.h"
+#include "hcp_if.h"
+#include "ehca_iverbs.h"
+#include "ipz_pt_fn.h"
+#include "ehca_qes.h"
+#include "ehca_irq.h"
+
+/* TODO: should be defined in ehca_classes_pSeries.h */
+#define HIPZ_EQ_REGISTER_ORIG 0
+
+int ehca_create_eq(struct ehca_shca *shca,
+		   struct ehca_eq *eq,
+		   const enum ehca_eq_type type, const u32 length)
+{
+	extern struct workqueue_struct *ehca_wq;
+	u64 ret = H_Success;
+	u32 nr_pages = 0;
+	u32 i;
+	void *vpage = NULL;
+
+	EDEB_EN(7, "shca=%p eq=%p length=%x", shca, eq, length);
+	EHCA_CHECK_ADR(shca);
+	EHCA_CHECK_ADR(eq);
+
+	spin_lock_init(&eq->spinlock);
+	eq->is_initialized = 0;
+
+	if (type!=EHCA_EQ && type!=EHCA_NEQ) {
+		EDEB_ERR(4, "Invalid EQ type %x. eq=%p", type, eq);
+		return -EINVAL;
+	}
+	if (length==0) {
+		EDEB_ERR(4, "EQ length must not be zero. eq=%p", eq);
+		return -EINVAL;
+	}
+
+     	ret = hipz_h_alloc_resource_eq(shca->ipz_hca_handle,
+				       &eq->pf,
+				       type,
+				       length,
+				       &eq->ipz_eq_handle,
+				       &eq->length,
+				       &nr_pages, &eq->irq_info.ist);
+
+	if (ret != H_Success) {
+		EDEB_ERR(4, "Can't allocate EQ / NEQ. eq=%p", eq);
+		return -EINVAL;
+	}
+
+	ret = ipz_queue_ctor(&eq->ipz_queue, nr_pages,
+			     EHCA_PAGESIZE, sizeof(struct ehca_eqe), 0);
+	if (!ret) {
+		EDEB_ERR(4, "Can't allocate EQ pages. eq=%p", eq);
+		goto create_eq_exit1;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		u64 rpage;
+
+		if (!(vpage = ipz_QPageit_get_inc(&eq->ipz_queue))) {
+			ret = H_Resource;
+			goto create_eq_exit2;
+		}
+
+		rpage = ehca_kv_to_g(vpage);
+		ret = hipz_h_register_rpage_eq(shca->ipz_hca_handle,
+					       eq->ipz_eq_handle,
+					       &eq->pf,
+					       0,
+					       HIPZ_EQ_REGISTER_ORIG, rpage, 1);
+
+		if (i == (nr_pages - 1)) {
+			/* last page */
+			vpage = ipz_QPageit_get_inc(&eq->ipz_queue);
+			if ((ret != H_Success) || (vpage != 0)) {
+				goto create_eq_exit2;
+			}
+		} else {
+			if ((ret != H_PAGE_REGISTERED) || (vpage == 0)) {
+				goto create_eq_exit2;
+			}
+		}
+	}
+
+	ipz_QEit_reset(&eq->ipz_queue);
+
+#ifndef EHCA_USERDRIVER
+	{
+	        pid_t pid = 0;
+		(eq->irq_info).pid = pid;
+		(eq->irq_info).eq = eq;
+		(eq->irq_info).wq = ehca_wq;
+		(eq->irq_info).work = &(eq->work);
+	}
+#endif
+
+	/* register interrupt handlers and initialize work queues */
+	if (type == EHCA_EQ) {
+		INIT_WORK(&(eq->work),
+			  ehca_interrupt_eq, (void *)&(eq->irq_info));
+		eq->is_initialized = 1;
+		hipz_request_interrupt(&(eq->irq_info), ehca_interrupt);
+	} else if (type == EHCA_NEQ) {
+		INIT_WORK(&(eq->work),
+			  ehca_interrupt_neq, (void *)&(eq->irq_info));
+		hipz_request_interrupt(&(eq->irq_info), ehca_interrupt);
+	}
+
+	EDEB_EX(7, "ret=%lx", ret);
+
+	return 0;
+
+      create_eq_exit2:
+	ipz_queue_dtor(&eq->ipz_queue);
+
+      create_eq_exit1:
+	hipz_h_destroy_eq(shca->ipz_hca_handle, eq);
+
+	EDEB_EX(7, "ret=%lx", ret);
+
+	return -EINVAL;
+}
+
+void *ehca_poll_eq(struct ehca_shca *shca, struct ehca_eq *eq)
+{
+	unsigned long flags = 0;
+	void *eqe = NULL;
+
+	EDEB_EN(7, "shca=%p  eq=%p", shca, eq);
+	EHCA_CHECK_ADR_P(shca);
+	EHCA_CHECK_EQ_P(eq);
+
+	spin_lock_irqsave(&eq->spinlock, flags);
+	eqe = ipz_QEit_EQ_get_inc_valid(&eq->ipz_queue);
+	spin_unlock_irqrestore(&eq->spinlock, flags);
+
+	EDEB_EX(7, "eq=%p eqe=%p", eq, eqe);
+
+	return eqe;
+}
+
+int ehca_poll_eqs(void *data)
+{
+	extern struct workqueue_struct *ehca_wq;
+	struct ehca_shca *shca;
+	struct ehca_module* module = data;
+	struct list_head *entry;
+
+	do {
+		spin_lock(&module->shca_lock);
+		list_for_each(entry, &module->shca_list) {
+			shca = list_entry(entry, struct ehca_shca, shca_list);
+
+			if (shca->eq.is_initialized && !kthread_should_stop())
+				queue_work(ehca_wq, &shca->eq.work);
+		}
+		spin_unlock(&module->shca_lock);
+
+		msleep_interruptible(1000);
+	}
+	while(!kthread_should_stop());
+
+	return 0;
+}
+
+int ehca_destroy_eq(struct ehca_shca *shca, struct ehca_eq *eq)
+{
+	unsigned long flags = 0;
+	u64 retcode = H_Success;
+
+	EDEB_EN(7, "shca=%p  eq=%p", shca, eq);
+	EHCA_CHECK_ADR(shca);
+	EHCA_CHECK_EQ(eq);
+
+	spin_lock_irqsave(&eq->spinlock, flags);
+	hipz_free_interrupt(&(eq->irq_info));
+
+	retcode = hipz_h_destroy_eq(shca->ipz_hca_handle, eq);
+
+	spin_unlock_irqrestore(&eq->spinlock, flags);
+
+	if (retcode != H_Success) {
+		EDEB_ERR(4, "Can't free EQ resources.");
+		return -EINVAL;
+	}
+	ipz_queue_dtor(&eq->ipz_queue);
+
+	EDEB_EX(7, "retcode=%lx", retcode);
+
+	return 0;
+}
+
diff --git a/drivers/infiniband/hw/ehca/ehca_eq.h b/drivers/infiniband/hw/ehca/ehca_eq.h
new file mode 100644
index 0000000..d09f21b
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_eq.h
@@ -0,0 +1,78 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Completion queue, event queue handling helper functions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
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
+ *  $Id: ehca_eq.h,v 1.10 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef EHCA_EQ_H
+#define EHCA_EQ_H
+
+#include "ehca_classes.h"
+#include "ehca_common.h"
+
+enum ehca_eq_type {
+	EHCA_EQ = 0, /* event queue              */
+	EHCA_NEQ     /* notification event queue */
+};
+
+/** @brief hcad internal create EQ
+ */
+int ehca_create_eq(struct ehca_shca *shca,
+		   struct ehca_eq *eq, /* struct contains eq to create */
+		   enum ehca_eq_type type,
+		   const u32 length);
+
+/** @brief destroy the eq
+ */
+int ehca_destroy_eq(struct ehca_shca *shca, struct ehca_eq *eq);
+
+/** @brief hcad internal poll EQ
+  - check if new EQE available,
+  - if yes, increment EQE pointer
+  - otherwise return 0
+  @returns pointer to EQE if new valid EQEavailable
+ */
+void *ehca_poll_eq(struct ehca_shca *shca, struct ehca_eq *eq);
+
+#endif /* EHCA_EQ_H */
+
