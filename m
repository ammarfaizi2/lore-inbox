Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWD0Ktz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWD0Ktz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWD0Kty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:49:54 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:22802 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965094AbWD0Ktc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:49:32 -0400
Message-ID: <4450A1D4.3030200@de.ibm.com>
Date: Thu, 27 Apr 2006 12:49:56 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 16/16] ehca: PHYP abstraction layer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  hcp_phyp.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  hcp_phyp.h |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 194 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_phyp.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_phyp.h	2006-03-09 15:05:14.000000000 +0100
@@ -0,0 +1,97 @@
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
+ *
+ *  $Id: hcp_phyp.h,v 1.5 2006/03/09 14:05:14 schickhj Exp $
+ */
+
+#ifndef __HCP_PHYP_H__
+#define __HCP_PHYP_H__
+
+
+/* eHCA page (mapped into memory)
+    resource to access eHCA register pages in CPU address space
+*/
+struct h_galpa {
+	u64 fw_handle;
+	/* for pSeries this is a 64bit memory address where
+	   I/O memory is mapped into CPU address space (kv) */
+};
+
+/*
+   resource to access eHCA address space registers, all types
+*/
+struct h_galpas {
+	u32 pid;		/*PID of userspace galpa checking */
+	struct h_galpa user;	/* user space accessible resource,
+				   set to 0 if unused */
+	struct h_galpa kernel;	/* kernel space accessible resource,
+				   set to 0 if unused */
+};
+
+inline static u64 hipz_galpa_load(struct h_galpa galpa, u32 offset)
+{
+	u64 addr = galpa.fw_handle + offset;
+	u64 out;
+	EDEB_EN(7, "addr=%lx offset=%x ", addr, offset);
+	out = *(u64 *) addr;
+	EDEB_EX(7, "addr=%lx value=%lx", addr, out);
+	return out;
+};
+
+inline static void hipz_galpa_store(struct h_galpa galpa, u32 offset, u64 value)
+{
+	u64 addr = galpa.fw_handle + offset;
+	EDEB(7, "addr=%lx offset=%x value=%lx", addr,
+	     offset, value);
+	*(u64 *) addr = value;
+};
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
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_phyp.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_phyp.c	2006-03-17 13:31:35.000000000 +0100
@@ -0,0 +1,97 @@
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
+ *
+ *  $Id: hcp_phyp.c,v 1.7 2006/03/17 12:31:35 nguyen Exp $
+ */
+
+#define DEB_PREFIX "PHYP"
+
+#include "ehca_kernel.h"
+#include "ehca_classes.h"
+#include "hipz_hw.h"
+
+int hcall_map_page(u64 physaddr, u64 * mapaddr)
+{
+	*mapaddr = (u64)(ioremap(physaddr, 4096));
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
+	int rc = 0;
+
+	rc = hcall_map_page(paddr_kernel, &galpas->kernel.fw_handle);
+	if (rc != 0)
+		return (rc);
+
+	galpas->user.fw_handle = paddr_user;
+
+	EDEB(7, "paddr_kernel=%lx paddr_user=%lx galpas->kernel=%lx"
+	     " galpas->user=%lx",
+	     paddr_kernel, paddr_user, galpas->kernel.fw_handle,
+	     galpas->user.fw_handle);
+
+	return (rc);
+}
+
+int hcp_galpas_dtor(struct h_galpas *galpas)
+{
+	int rc = 0;
+
+	if (galpas->kernel.fw_handle != 0)
+		rc = hcall_unmap_page(galpas->kernel.fw_handle);
+
+	if (rc != 0)
+		return (rc);
+
+	galpas->user.fw_handle = galpas->kernel.fw_handle = 0;
+
+	return rc;
+}



