Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWBRBBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWBRBBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWBRA62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:28 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:59775 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751822AbWBRA54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:56 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 18/22] ehca address vectors, multicast groups, protection domains
Date: Fri, 17 Feb 2006 16:57:52 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005752.13620.3255.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:53.0008 (UTC) FILETIME=[58D03700:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>


---

 drivers/infiniband/hw/ehca/ehca_av.c    |  258 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_mcast.c |  194 +++++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_pd.c    |  100 ++++++++++++
 3 files changed, 552 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
new file mode 100644
index 0000000..f5382c2
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -0,0 +1,258 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  adress vector functions
+ *
+ *  Authors: Reinhard Ernst <rernst@de.ibm.com>
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
+ *  $Id: ehca_av.c,v 1.28 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#define DEB_PREFIX "ehav"
+
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+#include "ehca_iverbs.h"
+#include "hcp_if.h"
+
+struct ib_ah *ehca_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr)
+{
+	extern int ehca_static_rate;
+	int retcode = 0;
+	struct ehca_av *av = NULL;
+
+	EHCA_CHECK_PD_P(pd);
+	EHCA_CHECK_ADR_P(ah_attr);
+
+	EDEB_EN(7,"pd=%p ah_attr=%p", pd, ah_attr);
+
+	av = ehca_av_new();
+	if (!av) {
+		EDEB_ERR(4,"Out of memory pd=%p ah_attr=%p", pd, ah_attr);
+		retcode = -ENOMEM;
+		goto create_ah_exit0;
+	}
+
+	av->av.sl = ah_attr->sl;
+	av->av.dlid = ntohs(ah_attr->dlid);
+	av->av.slid_path_bits = ah_attr->src_path_bits;
+
+	if (ehca_static_rate < 0) {
+	        av->av.ipd = ah_attr->static_rate;
+	} else {
+	        av->av.ipd = ehca_static_rate;
+	}
+
+	av->av.lnh = ah_attr->ah_flags;
+	av->av.grh.word_0 |= EHCA_BMASK_SET(GRH_IPVERSION_MASK, 6);
+	av->av.grh.word_0 |= EHCA_BMASK_SET(GRH_TCLASS_MASK,
+					    ah_attr->grh.traffic_class);
+	av->av.grh.word_0 |= EHCA_BMASK_SET(GRH_FLOWLABEL_MASK,
+					    ah_attr->grh.flow_label);
+	av->av.grh.word_0 |= EHCA_BMASK_SET(GRH_HOPLIMIT_MASK,
+					    ah_attr->grh.hop_limit);
+	av->av.grh.word_0 |= EHCA_BMASK_SET(GRH_NEXTHEADER_MASK, 0x1B);
+	/* IB transport */
+	av->av.grh.word_0 = be64_to_cpu(av->av.grh.word_0);
+	/* set sgid in grh.word_1 */
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		int rc = 0;
+		struct ib_port_attr port_attr;
+		union ib_gid gid;
+		memset(&port_attr, 0, sizeof(port_attr));
+		rc = ehca_query_port(pd->device, ah_attr->port_num,
+				     &port_attr);
+		if (rc != 0) { /* invalid port number */
+			retcode = -EINVAL;
+			EDEB_ERR(4, "Invalid port number "
+				 "ehca_query_port() returned %x "
+				 "pd=%p ah_attr=%p", rc, pd, ah_attr);
+			goto create_ah_exit1;
+		}
+		memset(&gid, 0, sizeof(gid));
+		rc = ehca_query_gid(pd->device,
+				    ah_attr->port_num,
+				    ah_attr->grh.sgid_index, &gid);
+		if (rc != 0) {
+			retcode = -EINVAL;
+			EDEB_ERR(4, "Failed to retrieve sgid "
+				 "ehca_query_gid() returned %x "
+				 "pd=%p ah_attr=%p", rc, pd, ah_attr);
+			goto create_ah_exit1;
+		}
+		memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
+	}
+	/* for the time beeing we use a hard coded PMTU of 2048 Bytes */
+	av->av.pmtu = 4; /* TODO */
+
+	/* dgid comes in grh.word_3 */
+	memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
+	       sizeof(ah_attr->grh.dgid));
+
+	EHCA_REGISTER_AV(device, pd);
+
+	EDEB_EX(7,"pd=%p ah_attr=%p av=%p", pd, ah_attr, av);
+	return (&av->ib_ah);
+
+ create_ah_exit1:
+	ehca_av_delete(av);
+
+ create_ah_exit0:
+	EDEB_EX(7,"retcode=%x pd=%p ah_attr=%p", retcode, pd, ah_attr);
+	return ERR_PTR(retcode);
+}
+
+int ehca_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
+{
+	struct ehca_av *av = NULL;
+	struct ehca_ud_av new_ehca_av;
+	int ret = 0;
+
+	EHCA_CHECK_AV(ah);
+	EHCA_CHECK_ADR(ah_attr);
+
+	EDEB_EN(7,"ah=%p ah_attr=%p", ah, ah_attr);
+
+	memset(&new_ehca_av, 0, sizeof(new_ehca_av));
+	new_ehca_av.sl = ah_attr->sl;
+	new_ehca_av.dlid = ntohs(ah_attr->dlid);
+	new_ehca_av.slid_path_bits = ah_attr->src_path_bits;
+	new_ehca_av.ipd = ah_attr->static_rate;
+	new_ehca_av.lnh = EHCA_BMASK_SET(GRH_FLAG_MASK,
+					 ((ah_attr->ah_flags & IB_AH_GRH) > 0));
+	new_ehca_av.grh.word_0 = EHCA_BMASK_SET(GRH_TCLASS_MASK,
+						ah_attr->grh.traffic_class);
+	new_ehca_av.grh.word_0 |= EHCA_BMASK_SET(GRH_FLOWLABEL_MASK,
+						 ah_attr->grh.flow_label);
+	new_ehca_av.grh.word_0 |= EHCA_BMASK_SET(GRH_HOPLIMIT_MASK,
+						 ah_attr->grh.hop_limit);
+	new_ehca_av.grh.word_0 |= EHCA_BMASK_SET(GRH_NEXTHEADER_MASK, 0x1b);
+	new_ehca_av.grh.word_0 = be64_to_cpu(new_ehca_av.grh.word_0);
+
+	/* set sgid in grh.word_1 */
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		int rc = 0;
+		struct ib_port_attr port_attr;
+		union ib_gid gid;
+		memset(&port_attr, 0, sizeof(port_attr));
+		rc = ehca_query_port(ah->device, ah_attr->port_num,
+				     &port_attr);
+		if (rc != 0) { /* invalid port number */
+			ret = -EINVAL;
+			EDEB_ERR(4, "Invalid port number "
+				 "ehca_query_port() returned %x "
+				 "ah=%p ah_attr=%p port_num=%x",
+				 rc, ah, ah_attr, ah_attr->port_num);
+			goto modify_ah_exit1;
+		}
+		memset(&gid, 0, sizeof(gid));
+		rc = ehca_query_gid(ah->device,
+				    ah_attr->port_num,
+				    ah_attr->grh.sgid_index, &gid);
+		if (rc != 0) {
+			ret = -EINVAL;
+			EDEB_ERR(4,
+				 "Failed to retrieve sgid "
+				 "ehca_query_gid() returned %x "
+				 "ah=%p ah_attr=%p port_num=%x "
+				 "sgid_index=%x",
+				 rc, ah, ah_attr, ah_attr->port_num,
+				 ah_attr->grh.sgid_index);
+			goto modify_ah_exit1;
+		}
+		memcpy(&new_ehca_av.grh.word_1, &gid, sizeof(gid));
+	}
+
+	new_ehca_av.pmtu = 4; /* TODO: see comment in create_ah() */
+
+	memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
+	       sizeof(ah_attr->grh.dgid));
+
+	av = container_of(ah, struct ehca_av, ib_ah);
+	av->av = new_ehca_av;
+
+ modify_ah_exit1:
+	EDEB_EX(7,"ret=%x ah=%p ah_attr=%p", ret, ah, ah_attr);
+
+	return ret;
+}
+
+int ehca_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
+{
+	int ret = 0;
+	struct ehca_av *av = NULL;
+
+	EHCA_CHECK_AV(ah);
+	EHCA_CHECK_ADR(ah_attr);
+
+	EDEB_EN(7,"ah=%p ah_attr=%p", ah, ah_attr);
+
+	av = container_of(ah, struct ehca_av, ib_ah);
+	memcpy(&ah_attr->grh.dgid, &av->av.grh.word_3,
+	       sizeof(ah_attr->grh.dgid));
+	ah_attr->sl = av->av.sl;
+
+	ah_attr->dlid = av->av.dlid;
+
+	ah_attr->src_path_bits = av->av.slid_path_bits;
+	ah_attr->static_rate = av->av.ipd;
+	ah_attr->ah_flags = EHCA_BMASK_GET(GRH_FLAG_MASK, av->av.lnh);
+	ah_attr->grh.traffic_class = EHCA_BMASK_GET(GRH_TCLASS_MASK,
+						    av->av.grh.word_0);
+	ah_attr->grh.hop_limit = EHCA_BMASK_GET(GRH_HOPLIMIT_MASK,
+						av->av.grh.word_0);
+	ah_attr->grh.flow_label = EHCA_BMASK_GET(GRH_FLOWLABEL_MASK,
+						 av->av.grh.word_0);
+
+	EDEB_EX(7,"ah=%p ah_attr=%p ret=%x", ah, ah_attr, ret);
+	return ret;
+}
+
+int ehca_destroy_ah(struct ib_ah *ah)
+{
+	int ret = 0;
+
+	EHCA_CHECK_AV(ah);
+	EHCA_DEREGISTER_AV(ah);
+
+	EDEB_EN(7,"ah=%p", ah);
+
+	ehca_av_delete(container_of(ah, struct ehca_av, ib_ah));
+
+	EDEB_EX(7,"ret=%x ah=%p", ret, ah);
+	return ret;
+}
diff --git a/drivers/infiniband/hw/ehca/ehca_mcast.c b/drivers/infiniband/hw/ehca/ehca_mcast.c
new file mode 100644
index 0000000..b49bcf6
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_mcast.c
@@ -0,0 +1,194 @@
+
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  mcast  functions
+ *
+ *  Authors: Waleri Fomin <fomin@de.ibm.com>
+ *           Reinhard Ernst <rernst@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
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
+ *  $Id: ehca_mcast.c,v 1.20 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#define DEB_PREFIX "mcas"
+
+#include "ehca_kernel.h"
+#include "ehca_classes.h"
+#include "ehca_tools.h"
+#include "hcp_if.h"
+#include "ehca_qes.h"
+#include <linux/module.h>
+#include <linux/err.h>
+#include "ehca_iverbs.h"
+
+#define MAX_MC_LID 0xFFFE
+#define MIN_MC_LID 0xC000	/* Multicast limits */
+#define EHCA_VALID_MULTICAST_GID(gid)  ((gid)[0] == 0xFF)
+#define EHCA_VALID_MULTICAST_LID(lid)  (((lid) >= MIN_MC_LID) && ((lid) <= MIN_MC_LID))
+
+int ehca_attach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	union ib_gid my_gid;
+	u64 hipz_rc = H_Success;
+	int retcode = 0;
+
+	EHCA_CHECK_ADR(ibqp);
+	EHCA_CHECK_ADR(gid);
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+
+	EHCA_CHECK_QP(my_qp);
+	if (ibqp->qp_type != IB_QPT_UD) {
+		EDEB_ERR(4, "invalid qp_type %x gid, retcode=%x",
+			 ibqp->qp_type, EINVAL);
+		return (-EINVAL);
+	}
+
+	shca = container_of(ibqp->pd->device, struct ehca_shca, ib_device);
+	EHCA_CHECK_ADR(shca);
+
+	if (!(EHCA_VALID_MULTICAST_GID(gid->raw))) {
+		EDEB_ERR(4, "gid is not valid mulitcast gid retcode=%x",
+			 EINVAL);
+		return (-EINVAL);
+	} else if ((lid < MIN_MC_LID) || (lid > MAX_MC_LID)) {
+		EDEB_ERR(4, "lid=%x is not valid mulitcast lid retcode=%x",
+			 lid, EINVAL);
+		return (-EINVAL);
+	}
+
+	memcpy(&my_gid.raw, gid->raw, sizeof(union ib_gid));
+
+	hipz_rc = hipz_h_attach_mcqp(shca->ipz_hca_handle,
+				     my_qp->ipz_qp_handle,
+				     my_qp->ehca_qp_core.galpas.kernel,
+				     lid, my_gid);
+	if (H_Success != hipz_rc) {
+		EDEB_ERR(4,
+			 "ehca_qp=%p qp_num=%x hipz_h_attach_mcqp() failed "
+			 "hipz_rc=%lx", my_qp, ibqp->qp_num, hipz_rc);
+	}
+	retcode = ehca2ib_return_code(hipz_rc);
+
+	EDEB_EX(7, "mcast attach retcode=%x\n"
+		   "ehca_qp=%p qp_num=%x  lid=%x\n"
+		   "my_gid=  %x %x %x %x\n"
+		   "         %x %x %x %x\n"
+		   "         %x %x %x %x\n"
+		   "         %x %x %x %x\n",
+		   retcode, my_qp, ibqp->qp_num, lid,
+		   my_gid.raw[0], my_gid.raw[1],
+		   my_gid.raw[2], my_gid.raw[3],
+		   my_gid.raw[4], my_gid.raw[5],
+		   my_gid.raw[6], my_gid.raw[7],
+		   my_gid.raw[8], my_gid.raw[9],
+		   my_gid.raw[10], my_gid.raw[11],
+		   my_gid.raw[12], my_gid.raw[13],
+		   my_gid.raw[14], my_gid.raw[15]);
+
+	return retcode;
+}
+
+int ehca_detach_mcast(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct ehca_qp *my_qp = NULL;
+	struct ehca_shca *shca = NULL;
+	union ib_gid my_gid;
+	u64 hipz_rc = H_Success;
+	int retcode = 0;
+
+	EHCA_CHECK_ADR(ibqp);
+	EHCA_CHECK_ADR(gid);
+
+	my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
+
+	EHCA_CHECK_QP(my_qp);
+	if (ibqp->qp_type != IB_QPT_UD) {
+		EDEB_ERR(4, "invalid qp_type %x gid, retcode=%x",
+			 ibqp->qp_type, EINVAL);
+		return (-EINVAL);
+	}
+
+	shca = container_of(ibqp->pd->device, struct ehca_shca, ib_device);
+	EHCA_CHECK_ADR(shca);
+
+	if (!(EHCA_VALID_MULTICAST_GID(gid->raw))) {
+		EDEB_ERR(4, "gid is not valid mulitcast gid retcode=%x",
+			 EINVAL);
+		return (-EINVAL);
+	} else if ((lid < MIN_MC_LID) || (lid > MAX_MC_LID)) {
+		EDEB_ERR(4, "lid=%x is not valid mulitcast lid retcode=%x",
+			 lid, EINVAL);
+		return (-EINVAL);
+	}
+
+	EDEB_EN(7, "dgid=%p qp_numl=%x lid=%x",
+		gid, ibqp->qp_num, lid);
+
+	memcpy(&my_gid.raw, gid->raw, sizeof(union ib_gid));
+
+	hipz_rc = hipz_h_detach_mcqp(shca->ipz_hca_handle,
+				     my_qp->ipz_qp_handle,
+				     my_qp->ehca_qp_core.galpas.kernel,
+				     lid, my_gid);
+	if (H_Success != hipz_rc) {
+		EDEB_ERR(4,
+			 "ehca_qp=%p qp_num=%x hipz_h_detach_mcqp() failed "
+			 "hipz_rc=%lx", my_qp, ibqp->qp_num, hipz_rc);
+	}
+	retcode = ehca2ib_return_code(hipz_rc);
+
+	EDEB_EX(7, "mcast detach retcode=%x\n"
+		"ehca_qp=%p qp_num=%x  lid=%x\n"
+		"my_gid=  %x %x %x %x\n"
+		"         %x %x %x %x\n"
+		"         %x %x %x %x\n"
+		"         %x %x %x %x\n",
+		retcode, my_qp, ibqp->qp_num, lid,
+		my_gid.raw[0], my_gid.raw[1],
+		my_gid.raw[2], my_gid.raw[3],
+		my_gid.raw[4], my_gid.raw[5],
+		my_gid.raw[6], my_gid.raw[7],
+		my_gid.raw[8], my_gid.raw[9],
+		my_gid.raw[10], my_gid.raw[11],
+		my_gid.raw[12], my_gid.raw[13],
+		my_gid.raw[14], my_gid.raw[15]);
+
+	return retcode;
+}
diff --git a/drivers/infiniband/hw/ehca/ehca_pd.c b/drivers/infiniband/hw/ehca/ehca_pd.c
new file mode 100644
index 0000000..e110320
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_pd.c
@@ -0,0 +1,100 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  PD functions
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
+ *  $Id: ehca_pd.c,v 1.25 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#define DEB_PREFIX "vpd "
+
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+#include "ehca_iverbs.h"
+
+struct ib_pd *ehca_alloc_pd(struct ib_device *device,
+			    struct ib_ucontext *context, struct ib_udata *udata)
+{
+	struct ib_pd *mypd = NULL;
+	struct ehca_pd *pd = NULL;
+
+	EDEB_EN(7, "device=%p context=%p udata=%p", device, context, udata);
+
+	EHCA_CHECK_DEVICE_P(device);
+
+	pd = ehca_pd_new();
+	if (!pd) {
+		EDEB_ERR(4, "ERROR device=%p context=%p pd=%p "
+			 "out of memory", device, context, mypd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* kernel pd when (device,-1,0)
+	 * user pd only if context != -1  */
+	if (context == NULL) {
+		/* kernel pds after init reuses always
+		 * the one created in ehca_shca_reopen()
+		 */
+		struct ehca_shca *shca = container_of(device, struct ehca_shca,
+						      ib_device);
+		pd->fw_pd.value = shca->pd->fw_pd.value;
+	} else {
+		pd->fw_pd.value = (u64)pd;
+	}
+
+	mypd = &pd->ib_pd;
+
+	EHCA_REGISTER_PD(device, pd);
+
+	EDEB_EX(7, "device=%p context=%p pd=%p", device, context, mypd);
+
+	return (mypd);
+}
+
+int ehca_dealloc_pd(struct ib_pd *pd)
+{
+	int ret = 0;
+	EDEB_EN(7, "pd=%p", pd);
+
+	EHCA_CHECK_PD(pd);
+	EHCA_DEREGISTER_PD(pd);
+	ehca_pd_delete(container_of(pd, struct ehca_pd, ib_pd));
+
+	EDEB_EX(7, "pd=%p", pd);
+	return ret;
+}
