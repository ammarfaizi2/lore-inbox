Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWHYS3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWHYS3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHYSZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:21 -0400
Received: from mx.pathscale.com ([64.160.42.68]:38786 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422653AbWHYSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:18 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 23] IB/ipath - More changes to support InfiniPath on
	PowerPC 970 systems
X-Mercurial-Node: 44809b730ac95b39b672a837c9fa29eb69a3f4f2
Message-Id: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:26 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ordering of writethrough store buffers needs to be forced, and we need
to use ifdef to get writethrough behavior to InfiniPath buffers, because
there is no generic way to specify that at this time (similar to code
in char/drm/drm_vm.c and block/z2ram.c).

Signed-off-by: John Gregor <john.gregor@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile
--- a/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:44 2006 -0700
@@ -20,6 +20,7 @@ ipath_core-y := \
 	ipath_user_pages.o
 
 ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
+ipath_core-$(CONFIG_PPC64) += ipath_wc_ppc64.o
 
 ib_ipath-y := \
 	ipath_cq.o \
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:44 2006 -0700
@@ -440,7 +440,13 @@ static int __devinit ipath_init_one(stru
 	}
 	dd->ipath_pcirev = rev;
 
+#if defined(__powerpc__)
+	/* There isn't a generic way to specify writethrough mappings */
+	dd->ipath_kregbase = __ioremap(addr, len,
+		(_PAGE_NO_CACHE|_PAGE_WRITETHRU));
+#else
 	dd->ipath_kregbase = ioremap_nocache(addr, len);
+#endif
 
 	if (!dd->ipath_kregbase) {
 		ipath_dbg("Unable to map io addr %llx to kvirt, failing\n",
diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:44 2006 -0700
@@ -985,6 +985,13 @@ static int mmap_piobufs(struct vm_area_s
 	 * write combining behavior we want on the PIO buffers!
 	 */
 
+#if defined(__powerpc__)
+	/* There isn't a generic way to specify writethrough mappings */
+	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
+	pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
+	pgprot_val(vma->vm_page_prot) &= ~_PAGE_GUARDED;
+#endif
+
 	if (vma->vm_flags & VM_READ) {
 		dev_info(&dd->pcidev->dev,
 			 "Can't map piobufs as readable (flags=%lx)\n",
diff --git a/drivers/infiniband/hw/ipath/ipath_wc_ppc64.c b/drivers/infiniband/hw/ipath/ipath_wc_ppc64.c
new file mode 100644
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_wc_ppc64.c	Fri Aug 25 11:19:44 2006 -0700
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
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
+
+/*
+ * This file is conditionally built on PowerPC only.  Otherwise weak symbol
+ * versions of the functions exported from here are used.
+ */
+
+#include "ipath_kernel.h"
+
+/**
+ * ipath_unordered_wc - indicate whether write combining is ordered
+ *
+ * PowerPC systems (at least those in the 970 processor family)
+ * write partially filled store buffers in address order, but will write
+ * completely filled store buffers in "random" order, and therefore must
+ * have serialization for correctness with current InfiniPath chips.
+ *
+ */
+int ipath_unordered_wc(void)
+{
+	return 1;
+}
