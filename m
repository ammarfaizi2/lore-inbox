Return-Path: <linux-kernel-owner+w=401wt.eu-S932173AbXAQWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXAQWQA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXAQWP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:15:59 -0500
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:59742 "EHLO
	mtagate6.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbXAQWP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:15:58 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: hch@infradead.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap() for better readability
Date: Wed, 17 Jan 2007 23:12:13 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701172312.14840.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
here is a patch for ehca_uverbs.c with the following changes:
- Rename mm_open/close() to ehca_mm_open/close() respectively
- Refactor ehca_mmap() into sub-functions ehca_mmap_cq/qp(),
which then call the new common sub-functions ehca_mmap_fw()
and ehca_mmap_queue() to register firmware memory block and
queue pages respectively
Roland, please note that I applied the previous patches to
your git tree for-2.6.21 before creating this patch. I also
realized a compile issue with the patch from Michael T. in
ehca_reqs.c regarding "return qp pointer in ib_wc". For this
I'll send another patch.
Thanks!
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_uverbs.c |  266 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 146 insertions(+), 120 deletions(-)


diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_uverbs.c infiniband_work/drivers/infiniband/hw/ehca/ehca_uverbs.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_uverbs.c	2007-01-17 21:39:01.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_uverbs.c	2007-01-17 21:17:00.000000000 +0100
@@ -68,7 +68,7 @@ int ehca_dealloc_ucontext(struct ib_ucon
 	return 0;
 }
 
-static void mm_open(struct vm_area_struct *vma)
+static void ehca_mm_open(struct vm_area_struct *vma)
 {
 	u32 *count = (u32*)vma->vm_private_data;
 	if (!count) {
@@ -84,7 +84,7 @@ static void mm_open(struct vm_area_struc
 		     vma->vm_start, vma->vm_end, *count);
 }
 
-static void mm_close(struct vm_area_struct *vma)
+static void ehca_mm_close(struct vm_area_struct *vma)
 {
 	u32 *count = (u32*)vma->vm_private_data;
 	if (!count) {
@@ -98,26 +98,150 @@ static void mm_close(struct vm_area_stru
 }
 
 static struct vm_operations_struct vm_ops = {
-	.open =	mm_open,
-	.close = mm_close,
+	.open =	ehca_mm_open,
+	.close = ehca_mm_close,
 };
 
-static int ehca_mmap_qpages(struct vm_area_struct *vma, struct ipz_queue *queue)
+static int ehca_mmap_fw(struct vm_area_struct *vma, struct h_galpas *galpas,
+			u32 *mm_count)
 {
+	int ret;
+	u64 vsize, physical;
+
+	vsize = vma->vm_end - vma->vm_start;
+	if (vsize != EHCA_PAGESIZE) {
+		ehca_gen_err("invalid vsize=%lx", vma->vm_end - vma->vm_start);
+		return -EINVAL;
+	}
+
+	physical = galpas->user.fw_handle;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	ehca_gen_dbg("vsize=%lx physical=%lx", vsize, physical);
+	/* VM_IO | VM_RESERVED are set by remap_pfn_range() */
+	ret = remap_pfn_range(vma, vma->vm_start, physical >> PAGE_SHIFT,
+			      vsize, vma->vm_page_prot);
+	if (unlikely(ret)) {
+		ehca_gen_err("remap_pfn_range() failed ret=%x", ret);
+		return -ENOMEM;
+	}
+
+	vma->vm_private_data = mm_count;
+	(*mm_count)++;
+	vma->vm_ops = &vm_ops;
+
+	return 0;
+}
+
+static int ehca_mmap_queue(struct vm_area_struct *vma, struct ipz_queue *queue,
+			   u32 *mm_count)
+{
+	int ret;
 	u64 start, ofs;
 	struct page *page;
-	int  rc = 0;
+
+	vma->vm_flags |= VM_RESERVED;
 	start = vma->vm_start;
 	for (ofs = 0; ofs < queue->queue_length; ofs += PAGE_SIZE) {
 		u64 virt_addr = (u64)ipz_qeit_calc(queue, ofs);
 		page = virt_to_page(virt_addr);
-		rc = vm_insert_page(vma, start, page);
-		if (unlikely(rc)) {
-			ehca_gen_err("vm_insert_page() failed rc=%x", rc);
-			return rc;
+		ret = vm_insert_page(vma, start, page);
+		if (unlikely(ret)) {
+			ehca_gen_err("vm_insert_page() failed rc=%x", ret);
+			return ret;
 		}
 		start +=  PAGE_SIZE;
 	}
+	vma->vm_private_data = mm_count;
+	(*mm_count)++;
+	vma->vm_ops = &vm_ops;
+
+	return 0;
+}
+
+static int ehca_mmap_cq(struct vm_area_struct *vma, struct ehca_cq *cq,
+			u32 rsrc_type)
+{
+	int ret;
+
+	switch (rsrc_type) {
+	case 1: /* galpa fw handle */
+		ehca_dbg(cq->ib_cq.device, "cq_num=%x fw", cq->cq_number);
+		ret = ehca_mmap_fw(vma, &cq->galpas, &cq->mm_count_galpa);
+		if (unlikely(ret)) {
+			ehca_err(cq->ib_cq.device,
+				 "ehca_mmap_fw() failed rc=%x cq_num=%x",
+				 ret, cq->cq_number);
+			return ret;
+		}
+		break;
+
+	case 2: /* cq queue_addr */
+		ehca_dbg(cq->ib_cq.device, "cq_num=%x queue", cq->cq_number);
+		ret = ehca_mmap_queue(vma, &cq->ipz_queue, &cq->mm_count_queue);
+		if (unlikely(ret)) {
+			ehca_err(cq->ib_cq.device,
+				 "ehca_mmap_queue() failed rc=%x cq_num=%x",
+				 ret, cq->cq_number);
+			return ret;
+		}
+		break;
+
+	default:
+		ehca_err(cq->ib_cq.device, "bad resource type=%x cq_num=%x",
+			 rsrc_type, cq->cq_number);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ehca_mmap_qp(struct vm_area_struct *vma, struct ehca_qp *qp,
+			u32 rsrc_type)
+{
+	int ret;
+
+	switch (rsrc_type) {
+	case 1: /* galpa fw handle */
+		ehca_dbg(qp->ib_qp.device, "qp_num=%x fw", qp->ib_qp.qp_num);
+		ret = ehca_mmap_fw(vma, &qp->galpas, &qp->mm_count_galpa);
+		if (unlikely(ret)) {
+			ehca_err(qp->ib_qp.device,
+				 "remap_pfn_range() failed ret=%x qp_num=%x",
+				 ret, qp->ib_qp.qp_num);
+			return -ENOMEM;
+		}
+		break;
+
+	case 2: /* qp rqueue_addr */
+		ehca_dbg(qp->ib_qp.device, "qp_num=%x rqueue",
+			 qp->ib_qp.qp_num);
+		ret = ehca_mmap_queue(vma, &qp->ipz_rqueue, &qp->mm_count_rqueue);
+		if (unlikely(ret)) {
+			ehca_err(qp->ib_qp.device,
+				 "ehca_mmap_queue(rq) failed rc=%x qp_num=%x",
+				 ret, qp->ib_qp.qp_num);
+			return ret;
+		}
+		break;
+
+	case 3: /* qp squeue_addr */
+		ehca_dbg(qp->ib_qp.device, "qp_num=%x squeue",
+			 qp->ib_qp.qp_num);
+		ret = ehca_mmap_queue(vma, &qp->ipz_squeue, &qp->mm_count_squeue);
+		if (unlikely(ret)) {
+			ehca_err(qp->ib_qp.device,
+				 "ehca_mmap_queue(sq) failed rc=%x qp_num=%x",
+				 ret, qp->ib_qp.qp_num);
+			return ret;
+		}
+		break;
+
+	default:
+		ehca_err(qp->ib_qp.device, "bad resource type=%x qp=num=%x",
+			 rsrc_type, qp->ib_qp.qp_num);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -129,7 +253,6 @@ int ehca_mmap(struct ib_ucontext *contex
 	u32 rsrc_type = (fileoffset >> 24) & 0xF; /* sq,rq,cmnd_window */
 	u32 cur_pid = current->tgid;
 	u32 ret;
-	u64 vsize, physical;
 	unsigned long flags;
 	struct ehca_cq *cq;
 	struct ehca_qp *qp;
@@ -155,52 +278,12 @@ int ehca_mmap(struct ib_ucontext *contex
 		if (!cq->ib_cq.uobject || cq->ib_cq.uobject->context != context)
 			return -EINVAL;
 
-		switch (rsrc_type) {
-		case 1: /* galpa fw handle */
-			ehca_dbg(cq->ib_cq.device, "cq=%p cq triggerarea", cq);
-			vsize = vma->vm_end - vma->vm_start;
-			if (vsize != EHCA_PAGESIZE) {
-				ehca_err(cq->ib_cq.device, "invalid vsize=%lx",
-					 vma->vm_end - vma->vm_start);
-				return -EINVAL;
-			}
-
-			physical = cq->galpas.user.fw_handle;
-			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-			ehca_dbg(cq->ib_cq.device,
-				 "vsize=%lx physical=%lx", vsize, physical);
-			/* VM_IO | VM_RESERVED are set by remap_pfn_range() */
-			ret = remap_pfn_range(vma, vma->vm_start,
-					      physical >> PAGE_SHIFT, vsize,
-					      vma->vm_page_prot);
-			if (unlikely(ret)) {
-				ehca_err(cq->ib_cq.device,
-					 "remap_pfn_range() failed ret=%x",
-					 ret);
-				return -ENOMEM;
-			}
-			vma->vm_private_data = &cq->mm_count_galpa;
-			cq->mm_count_galpa++;
-			break;
-
-		case 2: /* cq queue_addr */
-			ehca_dbg(cq->ib_cq.device, "cq=%p cq q_addr", cq);
-			vma->vm_flags |= VM_RESERVED;
-			ret = ehca_mmap_qpages(vma, &cq->ipz_queue);
-			if (unlikely(ret)) {
-				ehca_gen_err("ehca_mmap_qpages() failed rc=%x "
-					     "cq_num=%x", ret, cq->cq_number);
-				return ret;
-			}
-			vma->vm_private_data = &cq->mm_count_queue;
-			cq->mm_count_queue++;
-			break;
-
-		default:
-			ehca_err(cq->ib_cq.device, "bad resource type %x",
-				 rsrc_type);
-			return -EINVAL;
+		ret = ehca_mmap_cq(vma, cq, rsrc_type);
+		if (unlikely(ret)) {
+			ehca_err(cq->ib_cq.device,
+				 "ehca_mmap_cq() failed rc=%x cq_num=%x",
+				 ret, cq->cq_number);
+			return ret;
 		}
 		break;
 
@@ -224,67 +307,12 @@ int ehca_mmap(struct ib_ucontext *contex
 		if (!qp->ib_qp.uobject || qp->ib_qp.uobject->context != context)
 			return -EINVAL;
 
-		switch (rsrc_type) {
-		case 1: /* galpa fw handle */
-			ehca_dbg(qp->ib_qp.device, "qp=%p qp triggerarea", qp);
-			vsize = vma->vm_end - vma->vm_start;
-			if (vsize != EHCA_PAGESIZE) {
-				ehca_err(qp->ib_qp.device, "invalid vsize=%lx",
-					 vma->vm_end - vma->vm_start);
-				return -EINVAL;
-			}
-
-			physical = qp->galpas.user.fw_handle;
-			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-			ehca_dbg(qp->ib_qp.device, "vsize=%lx physical=%lx",
-				 vsize, physical);
-			/* VM_IO | VM_RESERVED are set by remap_pfn_range() */
-			ret = remap_pfn_range(vma, vma->vm_start,
-					      physical >> PAGE_SHIFT, vsize,
-					      vma->vm_page_prot);
-			if (unlikely(ret)) {
-				ehca_err(qp->ib_qp.device,
-					 "remap_pfn_range() failed ret=%x",
-					 ret);
-				return -ENOMEM;
-			}
-			vma->vm_private_data = &qp->mm_count_galpa;
-			qp->mm_count_galpa++;
-			break;
-
-		case 2: /* qp rqueue_addr */
-			ehca_dbg(qp->ib_qp.device, "qp=%p qp rqueue_addr", qp);
-			vma->vm_flags |= VM_RESERVED;
-			ret = ehca_mmap_qpages(vma, &qp->ipz_rqueue);
-			if (unlikely(ret)) {
-				ehca_gen_err("ehca_mmap_qpages(rq) failed "
-					     "rc=%x qp_num=%x",
-					     ret, qp->ib_qp.qp_num);
-				return ret;
-			}
-			vma->vm_private_data = &qp->mm_count_rqueue;
-			qp->mm_count_rqueue++;
-			break;
-
-		case 3: /* qp squeue_addr */
-			ehca_dbg(qp->ib_qp.device, "qp=%p qp squeue_addr", qp);
-			vma->vm_flags |= VM_RESERVED;
-			ret = ehca_mmap_qpages(vma, &qp->ipz_squeue);
-			if (unlikely(ret)) {
-				ehca_gen_err("ehca_mmap_qpages(sq) failed "
-					     "rc=%x qp_num=%x",
-					     ret, qp->ib_qp.qp_num);
-				return ret;
-			}
-			vma->vm_private_data = &qp->mm_count_squeue;
-			qp->mm_count_squeue++;
-			break;
-
-		default:
-			ehca_err(qp->ib_qp.device, "bad resource type %x",
-				 rsrc_type);
-			return -EINVAL;
+		ret = ehca_mmap_qp(vma, qp, rsrc_type);
+		if (unlikely(ret)) {
+			ehca_err(qp->ib_qp.device,
+				 "ehca_mmap_qp() failed rc=%x qp_num=%x",
+				 ret, qp->ib_qp.qp_num);
+			return ret;
 		}
 		break;
 
@@ -293,7 +321,5 @@ int ehca_mmap(struct ib_ucontext *contex
 		return -EINVAL;
 	}
 
-	vma->vm_ops = &vm_ops;
-
 	return 0;
 }
