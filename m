Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWEORmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWEORmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWEORmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:42:17 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:2622 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751639AbWEORlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:41:50 -0400
Message-ID: <4468BD76.6010505@de.ibm.com>
Date: Mon, 15 May 2006 19:42:14 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 08/16] ehca: protection domain and address vector
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  drivers/infiniband/hw/ehca/ehca_av.c |  306 +++++++++++++++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ehca_pd.c |  118 +++++++++++++
  2 files changed, 424 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_av.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_av.c	2006-05-12 12:45:25.000000000 +0200
@@ -0,0 +1,306 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  adress vector functions
+ *
+ *  Authors: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Khadija Souissi <souissik@de.ibm.com>
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
+
+#define DEB_PREFIX "ehav"
+
+#include <asm/current.h>
+
+#include "ehca_tools.h"
+#include "ehca_iverbs.h"
+#include "hcp_if.h"
+
+struct ib_ah *ehca_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr)
+{
+	extern struct ehca_module ehca_module;
+	extern int ehca_static_rate;
+	int ret = 0;
+	struct ehca_av *av = NULL;
+	struct ehca_shca *shca = NULL;
+
+	EHCA_CHECK_PD_P(pd);
+	EHCA_CHECK_ADR_P(ah_attr);
+
+	shca = container_of(pd->device, struct ehca_shca, ib_device);
+
+	EDEB_EN(7, "pd=%p ah_attr=%p", pd, ah_attr);
+
+	av = kmem_cache_alloc(ehca_module.cache_av, SLAB_KERNEL);
+	if (!av) {
+		EDEB_ERR(4, "Out of memory pd=%p ah_attr=%p", pd, ah_attr);
+		ret = -ENOMEM;
+		goto create_ah_exit0;
+	}
+
+	av->av.sl = ah_attr->sl;
+	av->av.dlid = ntohs(ah_attr->dlid);
+	av->av.slid_path_bits = ah_attr->src_path_bits;
+
+	if (ehca_static_rate < 0) {
+		int ah_mult = ib_rate_to_mult(ah_attr->static_rate);
+		int ehca_mult =
+			ib_rate_to_mult(shca->sport[ah_attr->port_num].rate );
+
+		if (ah_mult >= ehca_mult)
+			av->av.ipd = 0;
+		else
+			av->av.ipd = (ah_mult > 0) ?
+				((ehca_mult - 1) / ah_mult) : 0;
+	} else
+	        av->av.ipd = ehca_static_rate;
+
+	EDEB(7, "IPD av->av.ipd set =%x  ah_attr->static_rate=%x "
+	     "shca_ib_rate=%x ",av->av.ipd, ah_attr->static_rate,
+	     shca->sport[ah_attr->port_num].rate);
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
+		if (rc) { /* invalid port number */
+			ret = -EINVAL;
+			EDEB_ERR(4, "Invalid port number "
+				 "ehca_query_port() returned %x "
+				 "pd=%p ah_attr=%p", rc, pd, ah_attr);
+			goto create_ah_exit1;
+		}
+		memset(&gid, 0, sizeof(gid));
+		rc = ehca_query_gid(pd->device,
+				    ah_attr->port_num,
+				    ah_attr->grh.sgid_index, &gid);
+		if (rc) {
+			ret = -EINVAL;
+			EDEB_ERR(4, "Failed to retrieve sgid "
+				 "ehca_query_gid() returned %x "
+				 "pd=%p ah_attr=%p", rc, pd, ah_attr);
+			goto create_ah_exit1;
+		}
+		memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
+	}
+	/* for the time being we use a hard coded PMTU of 2048 Bytes */
+	av->av.pmtu = 4;
+
+	/* dgid comes in grh.word_3 */
+	memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
+	       sizeof(ah_attr->grh.dgid));
+
+	EHCA_REGISTER_AV(device, pd);
+
+	EDEB_EX(7, "pd=%p ah_attr=%p av=%p", pd, ah_attr, av);
+	return &av->ib_ah;
+
+create_ah_exit1:
+	kmem_cache_free(ehca_module.cache_av, av);
+
+create_ah_exit0:
+	EDEB_EX(7, "ret=%x pd=%p ah_attr=%p", ret, pd, ah_attr);
+
+	return ERR_PTR(ret);
+}
+
+int ehca_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
+{
+	struct ehca_av *av = NULL;
+	struct ehca_ud_av new_ehca_av;
+	struct ehca_pd *my_pd = NULL;
+	u32 cur_pid = current->tgid;
+	int ret = 0;
+
+	EHCA_CHECK_AV(ah);
+	EHCA_CHECK_ADR(ah_attr);
+
+	EDEB_EN(7, "ah=%p ah_attr=%p", ah, ah_attr);
+
+	my_pd = container_of(ah->pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		return -EINVAL;
+	}
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
+		if (rc) { /* invalid port number */
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
+		if (rc) {
+			ret = -EINVAL;
+			EDEB_ERR(4, "Failed to retrieve sgid "
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
+	new_ehca_av.pmtu = 4; /* see also comment in create_ah() */
+
+	memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
+	       sizeof(ah_attr->grh.dgid));
+
+	av = container_of(ah, struct ehca_av, ib_ah);
+	av->av = new_ehca_av;
+
+modify_ah_exit1:
+	EDEB_EX(7, "ret=%x ah=%p ah_attr=%p", ret, ah, ah_attr);
+
+	return ret;
+}
+
+int ehca_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
+{
+	int ret = 0;
+	struct ehca_av *av = NULL;
+	struct ehca_pd *my_pd = NULL;
+	u32 cur_pid = current->tgid;
+
+	EHCA_CHECK_AV(ah);
+	EHCA_CHECK_ADR(ah_attr);
+
+	EDEB_EN(7, "ah=%p ah_attr=%p", ah, ah_attr);
+
+	my_pd = container_of(ah->pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		return -EINVAL;
+	}
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
+	EDEB_EX(7, "ah=%p ah_attr=%p ret=%x", ah, ah_attr, ret);
+	return ret;
+}
+
+int ehca_destroy_ah(struct ib_ah *ah)
+{
+	extern struct ehca_module ehca_module;
+	struct ehca_pd *my_pd = NULL;
+	u32 cur_pid = current->tgid;
+	int ret = 0;
+
+	EHCA_CHECK_AV(ah);
+	EHCA_DEREGISTER_AV(ah);
+
+	EDEB_EN(7, "ah=%p", ah);
+
+	my_pd = container_of(ah->pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		return -EINVAL;
+	}
+
+	kmem_cache_free(ehca_module.cache_av,
+			container_of(ah, struct ehca_av, ib_ah));
+
+	EDEB_EX(7, "ret=%x ah=%p", ret, ah);
+	return ret;
+}
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_pd.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_pd.c	2006-05-15 13:35:24.000000000 +0200
@@ -0,0 +1,118 @@
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
+ */
+
+
+#define DEB_PREFIX "vpd "
+
+#include <asm/current.h>
+
+#include "ehca_tools.h"
+#include "ehca_iverbs.h"
+
+struct ib_pd *ehca_alloc_pd(struct ib_device *device,
+			    struct ib_ucontext *context, struct ib_udata *udata)
+{
+	extern struct ehca_module ehca_module;
+	struct ib_pd *mypd = NULL;
+	struct ehca_pd *pd = NULL;
+
+	EDEB_EN(7, "device=%p context=%p udata=%p", device, context, udata);
+
+	EHCA_CHECK_DEVICE_P(device);
+
+	pd = kmem_cache_alloc(ehca_module.cache_pd, SLAB_KERNEL);
+	if (!pd) {
+		EDEB_ERR(4, "ERROR device=%p context=%p pd=%p"
+			 " out of memory", device, context, mypd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	memset(pd, 0, sizeof(struct ehca_pd));
+	pd->ownpid = current->tgid;
+
+	/* Kernel PD: when device = -1, 0
+	 * User   PD: when context != -1
+	 */
+	if (!context) {
+		/* Kernel PDs after init reuses always
+		 * the one created in ehca_shca_reopen()
+		 */
+		struct ehca_shca *shca = container_of(device, struct ehca_shca,
+						      ib_device);
+		pd->fw_pd.value = shca->pd->fw_pd.value;
+	} else
+		pd->fw_pd.value = (u64)pd;
+
+	mypd = &pd->ib_pd;
+
+	EHCA_REGISTER_PD(device, pd);
+
+	EDEB_EX(7, "device=%p context=%p pd=%p", device, context, mypd);
+
+	return mypd;
+}
+
+int ehca_dealloc_pd(struct ib_pd *pd)
+{
+	extern struct ehca_module ehca_module;
+	int ret = 0;
+	u32 cur_pid = current->tgid;
+	struct ehca_pd *my_pd = NULL;
+
+	EDEB_EN(7, "pd=%p", pd);
+
+	EHCA_CHECK_PD(pd);
+	my_pd = container_of(pd, struct ehca_pd, ib_pd);
+	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
+	    my_pd->ownpid != cur_pid) {
+		EDEB_ERR(4, "Invalid caller pid=%x ownpid=%x",
+			 cur_pid, my_pd->ownpid);
+		return -EINVAL;
+	}
+
+	EHCA_DEREGISTER_PD(pd);
+
+	kmem_cache_free(ehca_module.cache_pd,
+			container_of(pd, struct ehca_pd, ib_pd));
+
+	EDEB_EX(7, "pd=%p", pd);
+
+	return ret;
+}


