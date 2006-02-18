Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbWBRBAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWBRBAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWBRA6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:30 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:47881 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751835AbWBRA6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:58:01 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 20/22] ehca userspace verbs
Date: Fri, 17 Feb 2006 16:57:57 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005757.13620.13628.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:57.0703 (UTC) FILETIME=[5B9C9D70:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>


---

 drivers/infiniband/hw/ehca/ehca_uverbs.c |  376 ++++++++++++++++++++++++++++++
 1 files changed, 376 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_uverbs.c b/drivers/infiniband/hw/ehca/ehca_uverbs.c
new file mode 100644
index 0000000..f813e9c
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_uverbs.c
@@ -0,0 +1,376 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  userspace support verbs
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
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
+ *  $Id: ehca_uverbs.c,v 1.29 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#undef DEB_PREFIX
+#define DEB_PREFIX "uver"
+
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+#include "ehca_classes.h"
+#include "ehca_iverbs.h"
+#include "ehca_eq.h"
+#include "ehca_mrmw.h"
+
+#include "hcp_sense.h"		/* TODO: later via hipz_* header file */
+#include "hcp_if.h"		/* TODO: later via hipz_* header file */
+
+struct ib_ucontext *ehca_alloc_ucontext(struct ib_device *device,
+					struct ib_udata *udata)
+{
+	struct ehca_ucontext *my_context = NULL;
+	EHCA_CHECK_ADR_P(device);
+	EDEB_EN(7, "device=%p name=%s", device, device->name);
+	my_context = kmalloc(sizeof *my_context, GFP_KERNEL);
+	if (NULL == my_context) {
+		EDEB_ERR(4, "Out of memory device=%p", device);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(my_context, 0, sizeof(*my_context));
+	EDEB_EX(7, "device=%p ucontext=%p", device, my_context);
+	return &my_context->ib_ucontext;
+}
+
+int ehca_dealloc_ucontext(struct ib_ucontext *context)
+{
+	struct ehca_ucontext *my_context = NULL;
+	EHCA_CHECK_ADR(context);
+	EDEB_EN(7, "ucontext=%p", context);
+	my_context = container_of(context, struct ehca_ucontext, ib_ucontext);
+	kfree(my_context);
+	EDEB_EN(7, "ucontext=%p", context);
+	return 0;
+}
+
+struct page *ehca_nopage(struct vm_area_struct *vma,
+			 unsigned long address, int *type)
+{
+	struct page *mypage = 0;
+	u64 fileoffset = vma->vm_pgoff << PAGE_SHIFT;
+	u32 idr_handle = fileoffset >> 32;
+	u32 q_type = (fileoffset >> 28) & 0xF;	  /* CQ, QP,...        */
+	u32 rsrc_type = (fileoffset >> 24) & 0xF; /* sq,rq,cmnd_window */
+
+	EDEB_EN(7,
+		"vm_start=%lx vm_end=%lx vm_page_prot=%lx vm_fileoff=%lx",
+		vma->vm_start, vma->vm_end, vma->vm_page_prot, fileoffset);
+
+
+	if (q_type == 1) { /* CQ */
+		struct ehca_cq *cq;
+
+		down_read(&ehca_cq_idr_sem);
+		cq = idr_find(&ehca_cq_idr, idr_handle);
+		up_read(&ehca_cq_idr_sem);
+
+		/* make sure this mmap really belongs to the authorized user */
+		if (cq == 0) {
+			EDEB_ERR(4, "cq is NULL ret=NOPAGE_SIGBUS");
+			return NOPAGE_SIGBUS;
+		}
+		if (rsrc_type == 2) {
+			void *vaddr;
+			EDEB(6, "cq=%p cq queuearea", cq);
+			vaddr = address - vma->vm_start
+			    + cq->ehca_cq_core.ipz_queue.queue;
+			EDEB(6, "queue=%p vaddr=%p",
+			     cq->ehca_cq_core.ipz_queue.queue, vaddr);
+			mypage = vmalloc_to_page(vaddr);
+		}
+	} else if (q_type == 2) { /* QP */
+		struct ehca_qp *qp;
+
+		down_read(&ehca_qp_idr_sem);
+		qp = idr_find(&ehca_qp_idr, idr_handle);
+		up_read(&ehca_qp_idr_sem);
+
+		/* make sure this mmap really belongs to the authorized user */
+		if (qp == NULL) {
+			EDEB_ERR(4, "qp is NULL ret=NOPAGE_SIGBUS");
+			return NOPAGE_SIGBUS;
+		}
+		if (rsrc_type == 2) {	/* rqueue */
+			void *vaddr;
+			EDEB(6, "qp=%p qp rqueuearea", qp);
+			vaddr = address - vma->vm_start
+			    + qp->ehca_qp_core.ipz_rqueue.queue;
+			EDEB(6, "rqueue=%p vaddr=%p",
+			     qp->ehca_qp_core.ipz_rqueue.queue, vaddr);
+			mypage = vmalloc_to_page(vaddr);
+		} else if (rsrc_type == 3) {	/* squeue */
+			void *vaddr;
+			EDEB(6, "qp=%p qp squeuearea", qp);
+			vaddr = address - vma->vm_start
+			    + qp->ehca_qp_core.ipz_squeue.queue;
+			EDEB(6, "squeue=%p vaddr=%p",
+			     qp->ehca_qp_core.ipz_squeue.queue, vaddr);
+			mypage = vmalloc_to_page(vaddr);
+		}
+	}
+	if (mypage == 0) {
+		EDEB_ERR(4, "Invalid page adr==NULL ret=NOPAGE_SIGBUS");
+		return NOPAGE_SIGBUS;
+	}
+	get_page(mypage);
+	EDEB_EX(7, "page adr=%p", mypage);
+	return mypage;
+}
+
+static struct vm_operations_struct ehcau_vm_ops = {
+	.nopage = ehca_nopage,
+};
+
+/* TODO: better error output messages !!!
+   NO RETURN WITHOUT ERROR
+ */
+int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
+{
+	u64 fileoffset = vma->vm_pgoff << PAGE_SHIFT;
+
+
+	u32 idr_handle = fileoffset >> 32;
+	u32 q_type = (fileoffset >> 28) & 0xF;	  /* CQ, QP,...        */
+	u32 rsrc_type = (fileoffset >> 24) & 0xF; /* sq,rq,cmnd_window */
+	u32 ret = -EFAULT;	/* assume the worst             */
+	u64 vsize = 0;		/* must be calculated/set below */
+	u64 physical = 0;	/* must be calculated/set below */
+
+	EDEB_EN(7, "vm_start=%lx vm_end=%lx vm_page_prot=%lx vm_fileoff=%lx",
+		vma->vm_start, vma->vm_end, vma->vm_page_prot, fileoffset);
+
+	if (q_type == 1) { /* CQ */
+		struct ehca_cq *cq;
+
+		down_read(&ehca_cq_idr_sem);
+		cq = idr_find(&ehca_cq_idr, idr_handle);
+		up_read(&ehca_cq_idr_sem);
+
+		/* make sure this mmap really belongs to the authorized user */
+		if (cq == 0)
+			return -EINVAL;
+		if (cq->ib_cq.uobject == 0)
+			return -EINVAL;
+		if (cq->ib_cq.uobject->context != context)
+			return -EINVAL;
+		if (rsrc_type == 1) {	/* galpa fw handle */
+			EDEB(6, "cq=%p cq triggerarea", cq);
+			vma->vm_flags |= VM_RESERVED;
+			vsize = vma->vm_end - vma->vm_start;
+			if (vsize != 4096) {
+				EDEB_ERR(4, "invalid vsize=%lx",
+					 vma->vm_end - vma->vm_start);
+				ret = -EINVAL;
+				goto mmap_exit0;
+			}
+
+			physical = cq->ehca_cq_core.galpas.user.fw_handle;
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+			vma->vm_flags |= VM_IO | VM_RESERVED;
+
+			EDEB(6, "vsize=%lx physical=%lx", vsize,
+			     physical);
+			ret =
+			    remap_pfn_range(vma, vma->vm_start,
+					    physical >> PAGE_SHIFT, vsize,
+					    vma->vm_page_prot);
+			if (ret != 0) {
+				EDEB_ERR(4,
+					 "Error: remap_pfn_range() returned %x!",
+					 ret);
+				ret = -ENOMEM;
+			}
+			goto mmap_exit0;
+		} else if (rsrc_type == 2) {	/* cq queue_addr */
+			EDEB(6, "cq=%p cq q_addr", cq);
+			/* vma->vm_page_prot =
+			 * pgprot_noncached(vma->vm_page_prot); */
+			vma->vm_flags |= VM_RESERVED;
+			vma->vm_ops = &ehcau_vm_ops;
+			ret = 0;
+			goto mmap_exit0;
+		} else {
+			EDEB_ERR(6, "bad resource type %x", rsrc_type);
+			ret = -EINVAL;
+			goto mmap_exit0;
+		}
+	} else if (q_type == 2) { /* QP */
+		struct ehca_qp *qp;
+
+		down_read(&ehca_qp_idr_sem);
+		qp = idr_find(&ehca_qp_idr, idr_handle);
+		up_read(&ehca_qp_idr_sem);
+
+		/* make sure this mmap really belongs to the authorized user */
+		if (qp == NULL || qp->ib_qp.uobject == NULL ||
+		    qp->ib_qp.uobject->context != context) {
+			EDEB(6, "qp=%p, uobject=%p, context=%p",
+			     qp, qp->ib_qp.uobject, qp->ib_qp.uobject->context);
+			ret = -EINVAL;
+			goto mmap_exit0;
+		}
+		if (rsrc_type == 1) {	/* galpa fw handle */
+			EDEB(6, "qp=%p qp triggerarea", qp);
+			vma->vm_flags |= VM_RESERVED;
+			vsize = vma->vm_end - vma->vm_start;
+			if (vsize != 4096) {
+				EDEB_ERR(4, "invalid vsize=%lx",
+					 vma->vm_end - vma->vm_start);
+				ret = -EINVAL;
+				goto mmap_exit0;
+			}
+
+			physical = qp->ehca_qp_core.galpas.user.fw_handle;
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+			vma->vm_flags |= VM_IO | VM_RESERVED;
+
+			EDEB(6, "vsize=%lx physical=%lx", vsize,
+			     physical);
+			ret =
+			    remap_pfn_range(vma, vma->vm_start,
+					    physical >> PAGE_SHIFT, vsize,
+					    vma->vm_page_prot);
+			if (ret != 0) {
+				EDEB_ERR(4,
+					 "Error: remap_pfn_range() returned %x!",
+					 ret);
+				ret = -ENOMEM;
+			}
+			goto mmap_exit0;
+		} else if (rsrc_type == 2) {	/* qp rqueue_addr */
+			EDEB(6, "qp=%p qp rqueue_addr", qp);
+			vma->vm_flags |= VM_RESERVED;
+			vma->vm_ops = &ehcau_vm_ops;
+			ret = 0;
+			goto mmap_exit0;
+		} else if (rsrc_type == 3) {	/* qp squeue_addr */
+			EDEB(6, "qp=%p qp squeue_addr", qp);
+			vma->vm_flags |= VM_RESERVED;
+			vma->vm_ops = &ehcau_vm_ops;
+			ret = 0;
+			goto mmap_exit0;
+		} else {
+			EDEB_ERR(4, "bad resource type %x",
+				 rsrc_type);
+			ret = -EINVAL;
+			goto mmap_exit0;
+		}
+	} else {
+		EDEB_ERR(4, "bad queue type %x", q_type);
+		ret = -EINVAL;
+		goto mmap_exit0;
+	}
+
+      mmap_exit0:
+	EDEB_EX(7, "ret=%x", ret);
+	return ret;
+}
+
+int ehca_mmap_nopage(u64 foffset,u64 length,void ** mapped,struct vm_area_struct ** vma)
+{
+	down_write(&current->mm->mmap_sem);
+	*mapped=(void*)
+		do_mmap(NULL,0,
+			length,
+			PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS,
+			foffset);
+	up_write(&current->mm->mmap_sem);
+	if (*mapped) {
+		*vma = find_vma(current->mm,(u64)*mapped);
+		if (*vma) {
+			(*vma)->vm_flags |= VM_RESERVED;
+			(*vma)->vm_ops = &ehcau_vm_ops;
+		} else {
+			EDEB_ERR(4,"couldn't find queue vma queue=%p",
+				 *mapped);
+		}
+	} else {
+		EDEB_ERR(4,"couldn't create mmap length=%lx",length);
+	}
+	EDEB(7,"mapped=%p",*mapped);
+	return 0;
+}
+
+int ehca_mmap_register(u64 physical,void ** mapped,struct vm_area_struct ** vma)
+{
+	int ret;
+	unsigned long vsize;
+	ehca_mmap_nopage(0,4096,mapped,vma);
+	(*vma)->vm_flags |= VM_RESERVED;
+	vsize = (*vma)->vm_end - (*vma)->vm_start;
+	if (vsize != 4096) {
+		EDEB_ERR(4, "invalid vsize=%lx",
+			 (*vma)->vm_end - (*vma)->vm_start);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	(*vma)->vm_page_prot = pgprot_noncached((*vma)->vm_page_prot);
+	(*vma)->vm_flags |= VM_IO | VM_RESERVED;
+
+	EDEB(6, "vsize=%lx physical=%lx", vsize,
+	     physical);
+	ret =
+		remap_pfn_range((*vma), (*vma)->vm_start,
+				physical >> PAGE_SHIFT, vsize,
+				(*vma)->vm_page_prot);
+	if (ret != 0) {
+		EDEB_ERR(4,
+			 "Error: remap_pfn_range() returned %x!",
+			 ret);
+		ret = -ENOMEM;
+	}
+	return ret;
+
+}
+
+int ehca_munmap(unsigned long addr, size_t len) {
+	int ret=0;
+	struct mm_struct *mm = current->mm;
+	if (mm!=0) {
+		down_write(&mm->mmap_sem);
+		ret = do_munmap(mm, addr, len);
+		up_write(&mm->mmap_sem);
+	}
+	return ret;
+}
+
+/* eof ehca_uverbs.c */
