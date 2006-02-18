Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWBRA7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWBRA7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWBRA6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:40 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:61498 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751818AbWBRA5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:53 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 17/22] Special QP functions
Date: Fri, 17 Feb 2006 16:57:50 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005750.13620.62709.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:50.0359 (UTC) FILETIME=[573C0270:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

The wait for the port to become active when creating QP 1 seems
bizarre.  Why can't we just create QP 1 before the port is active?

What is the issue with creating QP 0?  Without QP 0, it's impossible
to run a subnet manager on top of ehca.
---

 drivers/infiniband/hw/ehca/ehca_sqp.c |  135 +++++++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_sqp.c b/drivers/infiniband/hw/ehca/ehca_sqp.c
new file mode 100644
index 0000000..bbad4cb
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_sqp.c
@@ -0,0 +1,135 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  SQP functions
+ *
+ *  Authors: Khadija Souissi <souissi@de.ibm.com>
+ *           Heiko J Schick <schickhj@de.ibm.com>
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
+ *  $Id: ehca_sqp.c,v 1.35 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#define DEB_PREFIX "e_qp"
+
+#include "ehca_kernel.h"
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "hcp_if.h"
+#include "ehca_qes.h"
+#include "ehca_iverbs.h"
+
+#include <linux/module.h>
+#include <linux/err.h>
+
+extern int ehca_create_aqp1(struct ehca_shca *shca, struct ehca_sport *sport);
+extern int ehca_destroy_aqp1(struct ehca_sport *sport);
+
+extern int ehca_port_act_time;
+
+/**
+ * ehca_define_aqp0 - TODO
+ *
+ * @ehca_qp:     : TODO adapter_handle, ipz_qp_handle, galpas.kernel
+ * @qp_init_attr : TODO for port number
+ */
+u64 ehca_define_sqp(struct ehca_shca *shca,
+			       struct ehca_qp *ehca_qp,
+			       struct ib_qp_init_attr *qp_init_attr)
+{
+
+	u32 pma_qp_nr = 0;
+	u32 bma_qp_nr = 0;
+	u64 ret = H_Success;
+	u8 port = qp_init_attr->port_num;
+	int counter = 0;
+
+	EDEB_EN(7, "port=%x qp_type=%x",
+		port, qp_init_attr->qp_type);
+
+	shca->sport[port - 1].port_state = IB_PORT_DOWN;
+
+	switch (qp_init_attr->qp_type) {
+	case IB_QPT_SMI:
+		/* TODO: function not supported yet */
+		/*
+		   ret = hipz_h_define_aqp0(shca->ipz_hca_handle,
+		   ehca_qp->ipz_qp_handle,
+		   ehca_qp->galpas.kernel,
+		   (u32)qp_init_attr->port_num);
+		 */
+		break;
+	case IB_QPT_GSI:
+		ret = hipz_h_define_aqp1(shca->ipz_hca_handle,
+					 ehca_qp->ipz_qp_handle,
+					 ehca_qp->ehca_qp_core.galpas.kernel,
+					 (u32) qp_init_attr->port_num,
+					 &pma_qp_nr, &bma_qp_nr);
+
+		if (ret != H_Success) {
+			EDEB_ERR(4, "Can't define AQP1 for port %x. rc=%lx",
+				    port, ret);
+			goto ehca_define_aqp1;
+		}
+		break;
+	default:
+		ret = H_Parameter;
+		goto ehca_define_aqp1;
+	}
+
+#ifndef EHCA_USERDRIVER
+	while ((shca->sport[port - 1].port_state != IB_PORT_ACTIVE) &&
+	       (counter < ehca_port_act_time)) {
+		EDEB(6, "... wait until port %x is active",
+			port);
+		msleep_interruptible(1000);
+		counter++;
+	}
+
+	if (counter == ehca_port_act_time) {
+		EDEB_ERR(4, "Port %x is not active.", port);
+		ret = H_Hardware;
+	}
+#else
+	if (shca->sport[port - 1].port_state != IB_PORT_ACTIVE) {
+		sleep(20);
+	}
+#endif
+
+      ehca_define_aqp1:
+	EDEB_EX(7, "ret=%lx", ret);
+
+	return ret;
+}
