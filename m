Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWHQUO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWHQUO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWHQULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:11:30 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:62313 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030259AbWHQULF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:11:05 -0400
Cc: schihei@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: [PATCH 12/13] IB/ehca: phyp
In-Reply-To: <20068171311.NYGfAW00YTmK6YKh@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 17 Aug 2006 13:11:02 -0700
Message-Id: <20068171311.P1OwgyzMAlKlrkeW@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 17 Aug 2006 20:11:02.0597 (UTC) FILETIME=[4360A750:01C6C239]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rolandd@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/infiniband/hw/ehca/hcp_phyp.c |   92 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/ehca/hcp_phyp.h |   96 +++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.c b/drivers/infiniband/hw/ehca/hcp_phyp.c
new file mode 100644
index 0000000..d522d50
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.c
@@ -0,0 +1,92 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *   load store abstraction for ehca register access with tracing
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
+ */
+
+#define DEB_PREFIX "PHYP"
+
+#include "ehca_classes.h"
+#include "hipz_hw.h"
+
+int hcall_map_page(u64 physaddr, u64 *mapaddr)
+{
+	*mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
+
+	EDEB(7, "ioremap physaddr=%lx mapaddr=%lx", physaddr, *mapaddr);
+	return 0;
+}
+
+int hcall_unmap_page(u64 mapaddr)
+{
+	EDEB(7, "mapaddr=%lx", mapaddr);
+	iounmap((volatile void __iomem*)mapaddr);
+	return 0;
+}
+
+int hcp_galpas_ctor(struct h_galpas *galpas,
+		    u64 paddr_kernel, u64 paddr_user)
+{
+	int ret = hcall_map_page(paddr_kernel, &galpas->kernel.fw_handle);
+	if (ret)
+		return ret;
+
+	galpas->user.fw_handle = paddr_user;
+
+	EDEB(7, "paddr_kernel=%lx paddr_user=%lx galpas->kernel=%lx"
+	     " galpas->user=%lx",
+	     paddr_kernel, paddr_user, galpas->kernel.fw_handle,
+	     galpas->user.fw_handle);
+
+	return ret;
+}
+
+int hcp_galpas_dtor(struct h_galpas *galpas)
+{
+	int ret = 0;
+
+	if (galpas->kernel.fw_handle)
+		ret = hcall_unmap_page(galpas->kernel.fw_handle);
+
+	if (ret)
+		return ret;
+
+	galpas->user.fw_handle = galpas->kernel.fw_handle = 0;
+
+	return ret;
+}
diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.h b/drivers/infiniband/hw/ehca/hcp_phyp.h
new file mode 100644
index 0000000..ecb1117
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.h
@@ -0,0 +1,96 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Firmware calls
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
+ *           Gerd Bayer <gerd.bayer@de.ibm.com>
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
+#ifndef __HCP_PHYP_H__
+#define __HCP_PHYP_H__
+
+
+/*
+ * eHCA page (mapped into memory)
+ * resource to access eHCA register pages in CPU address space
+*/
+struct h_galpa {
+	u64 fw_handle;
+	/* for pSeries this is a 64bit memory address where
+	   I/O memory is mapped into CPU address space (kv) */
+};
+
+/*
+ * resource to access eHCA address space registers, all types
+ */
+struct h_galpas {
+	u32 pid;		/*PID of userspace galpa checking */
+	struct h_galpa user;	/* user space accessible resource,
+				   set to 0 if unused */
+	struct h_galpa kernel;	/* kernel space accessible resource,
+				   set to 0 if unused */
+};
+
+static inline u64 hipz_galpa_load(struct h_galpa galpa, u32 offset)
+{
+	u64 addr = galpa.fw_handle + offset;
+	u64 out;
+	EDEB_EN(7, "addr=%lx offset=%x ", addr, offset);
+	out = *(u64 *) addr;
+	EDEB_EX(7, "addr=%lx value=%lx", addr, out);
+	return out;
+}
+
+static inline void hipz_galpa_store(struct h_galpa galpa, u32 offset, u64 value)
+{
+	u64 addr = galpa.fw_handle + offset;
+	EDEB(7, "addr=%lx offset=%x value=%lx", addr,
+	     offset, value);
+	*(u64 *) addr = value;
+}
+
+int hcp_galpas_ctor(struct h_galpas *galpas,
+		    u64 paddr_kernel, u64 paddr_user);
+
+int hcp_galpas_dtor(struct h_galpas *galpas);
+
+int hcall_map_page(u64 physaddr, u64 * mapaddr);
+
+int hcall_unmap_page(u64 mapaddr);
+
+#endif
-- 
1.4.1

