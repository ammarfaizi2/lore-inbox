Return-Path: <linux-kernel-owner+w=401wt.eu-S932758AbWLNOTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWLNOTc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLNOTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:19:32 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:46395 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932749AbWLNOT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:19:27 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v4 12/13] Core Debug functions
Date: Thu, 14 Dec 2006 07:58:38 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061214135837.21159.29330.stgit@dell3.ogc.int>
In-Reply-To: <20061214135233.21159.78613.stgit@dell3.ogc.int>
References: <20061214135233.21159.78613.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Debug code to dump various data structs, some of which are in 
adapter memory.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/hw/cxgb3/core/cxio_dbg.c |  205 +++++++++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/core/cxio_dbg.c b/drivers/infiniband/hw/cxgb3/core/cxio_dbg.c
new file mode 100644
index 0000000..22f4f75
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/core/cxio_dbg.c
@@ -0,0 +1,205 @@
+/*
+ * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
+ * Copyright (c) 2006 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifdef DEBUG
+#include <linux/types.h>
+#include "common.h"
+#include "cxgb3_ioctl.h"
+#include "cxio_hal.h"
+#include "cxio_wr.h"
+
+void cxio_dump_tpt(struct cxio_rdev *rdev, u32 stag) 
+{
+	struct ch_mem_range *m;
+	u64 *data;
+	int rc;
+	int size = 32;
+
+	m = kmalloc(sizeof(*m) + size, GFP_ATOMIC);
+	if (!m) {
+		PDBG("%s couldn't allocate memory.\n", __FUNCTION__);
+		return;
+	}
+	m->mem_id = MEM_PMRX;
+	m->addr = (stag>>8) * 32 + rdev->rnic_info.tpt_base;
+	m->len = size;
+	PDBG("%s TPT addr 0x%x len %d\n", __FUNCTION__, m->addr, m->len);
+	rc = rdev->t3cdev_p->ctl(rdev->t3cdev_p, RDMA_GET_MEM, m);
+	if (rc) {
+		PDBG("%s toectl returned error %d\n", __FUNCTION__, rc);
+		kfree(m);
+		return;
+	}
+
+	data = (u64 *)m->buf;
+	while (size > 0) {
+		PDBG("TPT %08x: %016llx\n", m->addr, (u64)*data);
+		size -= 8;
+		data++;
+		m->addr += 8;
+	}
+	kfree(m);
+}
+
+void cxio_dump_pbl(struct cxio_rdev *rdev, u32 pbl_addr, uint len, u8 shift)
+{
+	struct ch_mem_range *m;
+	u64 *data;
+	int rc;
+	int size, npages;
+
+	shift += 12;
+	npages = (len + (1ULL << shift) - 1) >> shift;
+	size = npages * sizeof(u64);
+
+	m = kmalloc(sizeof(*m) + size, GFP_ATOMIC);
+	if (!m) {
+		PDBG("%s couldn't allocate memory.\n", __FUNCTION__);
+		return;
+	}
+	m->mem_id = MEM_PMRX;
+	m->addr = pbl_addr;
+	m->len = size;
+	PDBG("%s PBL addr 0x%x len %d depth %d\n", 
+		__FUNCTION__, m->addr, m->len, npages);
+	rc = rdev->t3cdev_p->ctl(rdev->t3cdev_p, RDMA_GET_MEM, m);
+	if (rc) {
+		PDBG("%s toectl returned error %d\n", __FUNCTION__, rc);
+		kfree(m);
+		return;
+	}
+
+	data = (u64 *)m->buf;
+	while (size > 0) {
+		PDBG("PBL %08x: %016llx\n", m->addr, (u64)*data);
+		size -= 8;
+		data++;
+		m->addr += 8;
+	}
+	kfree(m);
+}
+
+void cxio_dump_wqe(union t3_wr *wqe)
+{
+	__be64 *data = (__be64 *)wqe;
+	uint size = (uint)(be64_to_cpu(*data) & 0xff);
+
+	if (size == 0) 
+		size = 8;
+	while (size > 0) {
+		PDBG("WQE %p: %016llx\n", data, be64_to_cpu(*data));
+		size--;
+		data++;
+	}
+}
+
+void cxio_dump_wce(struct t3_cqe *wce)
+{
+	__be64 *data = (__be64 *)wce;
+	int size = sizeof(*wce);
+
+	while (size > 0) {
+		PDBG("WCE %p: %016llx\n", data, be64_to_cpu(*data));
+		size -= 8;
+		data++;
+	}
+}
+
+void cxio_dump_rqt(struct cxio_rdev *rdev, u32 hwtid, int nents)
+{
+	struct ch_mem_range *m;
+	int size = nents * 64;
+	u64 *data;
+	int rc;
+
+	m = kmalloc(sizeof(*m) + size, GFP_ATOMIC);
+	if (!m) {
+		PDBG("%s couldn't allocate memory.\n", __FUNCTION__);
+		return;
+	}
+	m->mem_id = MEM_PMRX;
+	m->addr = ((hwtid)<<10) + rdev->rnic_info.rqt_base;
+	m->len = size;
+	PDBG("%s RQT addr 0x%x len %d\n", __FUNCTION__, m->addr, m->len);
+	rc = rdev->t3cdev_p->ctl(rdev->t3cdev_p, RDMA_GET_MEM, m);
+	if (rc) {
+		PDBG("%s toectl returned error %d\n", __FUNCTION__, rc);
+		kfree(m);
+		return;
+	}
+
+	data = (u64 *)m->buf;
+	while (size > 0) {
+		PDBG("RQT %08x: %016llx\n", m->addr, (u64)*data);
+		size -= 8;
+		data++;
+		m->addr += 8;
+	}
+	kfree(m);
+}
+
+void cxio_dump_tcb(struct cxio_rdev *rdev, u32 hwtid)
+{
+	struct ch_mem_range *m;
+	int size = TCB_SIZE;
+	u32 *data;
+	int rc;
+
+	m = kmalloc(sizeof(*m) + size, GFP_ATOMIC);
+	if (!m) {
+		PDBG("%s couldn't allocate memory.\n", __FUNCTION__);
+		return;
+	}
+	m->mem_id = MEM_CM;
+	m->addr = hwtid * size; 
+	m->len = size;
+	PDBG("%s TCB %d len %d\n", __FUNCTION__, m->addr, m->len);
+	rc = rdev->t3cdev_p->ctl(rdev->t3cdev_p, RDMA_GET_MEM, m);
+	if (rc) {
+		PDBG("%s toectl returned error %d\n", __FUNCTION__, rc);
+		kfree(m);
+		return;
+	}
+
+	data = (u32 *)m->buf;
+	while (size > 0) {
+		printk("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", 
+			m->addr, 
+			*(data+2), *(data+3), *(data),*(data+1),
+			*(data+6), *(data+7), *(data+4), *(data+5));
+		size -= 32;
+		data += 8;
+		m->addr += 32;
+	}
+	kfree(m);
+}
+#endif
