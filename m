Return-Path: <linux-kernel-owner+w=401wt.eu-S1751418AbXAKTMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXAKTMF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXAKTME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:12:04 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:43719 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbXAKTMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:12:01 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
Date: Thu, 11 Jan 2007 20:08:15 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland and Christoph H.!
This is a patch for ehca_uverbs.c. It implements ehca-specific mmap
in the following way (as recommended by Christoph H.):
- Call remap_pfn_range() for hardware register block
- Use vm_insert_page() to register memory allocated for completion queues
and queue pairs
- The actual mmap() call/trigger is now controlled by user space, 
ie. libehca, for which I will send a separate patch for later review
This patch also removes superfluous resp. obsolete functions.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_uverbs.c |  253 ++++++++++++++++++----------------------------------------
 1 files changed, 80 insertions(+), 173 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_uverbs.c b/drivers/infiniband/hw/ehca/ehca_uverbs.c
index e08764e..250eac6 100644
--- a/drivers/infiniband/hw/ehca/ehca_uverbs.c
+++ b/drivers/infiniband/hw/ehca/ehca_uverbs.c
@@ -68,105 +68,59 @@ int ehca_dealloc_ucontext(struct ib_ucon
 	return 0;
 }
 
-struct page *ehca_nopage(struct vm_area_struct *vma,
-			 unsigned long address, int *type)
+static void mm_open(struct vm_area_struct *vma)
 {
-	struct page *mypage = NULL;
-	u64 fileoffset = vma->vm_pgoff << PAGE_SHIFT;
-	u32 idr_handle = fileoffset >> 32;
-	u32 q_type = (fileoffset >> 28) & 0xF;	  /* CQ, QP,...        */
-	u32 rsrc_type = (fileoffset >> 24) & 0xF; /* sq,rq,cmnd_window */
-	u32 cur_pid = current->tgid;
-	unsigned long flags;
-	struct ehca_cq *cq;
-	struct ehca_qp *qp;
-	struct ehca_pd *pd;
-	u64 offset;
-	void *vaddr;
-
-	switch (q_type) {
-	case 1: /* CQ */
-		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-		cq = idr_find(&ehca_cq_idr, idr_handle);
-		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
-
-		/* make sure this mmap really belongs to the authorized user */
-		if (!cq) {
-			ehca_gen_err("cq is NULL ret=NOPAGE_SIGBUS");
-			return NOPAGE_SIGBUS;
-		}
-
-		if (cq->ownpid != cur_pid) {
-			ehca_err(cq->ib_cq.device,
-				 "Invalid caller pid=%x ownpid=%x",
-				 cur_pid, cq->ownpid);
-			return NOPAGE_SIGBUS;
-		}
-
-		if (rsrc_type == 2) {
-			ehca_dbg(cq->ib_cq.device, "cq=%p cq queuearea", cq);
-			offset = address - vma->vm_start;
-			vaddr = ipz_qeit_calc(&cq->ipz_queue, offset);
-			ehca_dbg(cq->ib_cq.device, "offset=%lx vaddr=%p",
-				 offset, vaddr);
-			mypage = virt_to_page(vaddr);
-		}
-		break;
-
-	case 2: /* QP */
-		spin_lock_irqsave(&ehca_qp_idr_lock, flags);
-		qp = idr_find(&ehca_qp_idr, idr_handle);
-		spin_unlock_irqrestore(&ehca_qp_idr_lock, flags);
-
-		/* make sure this mmap really belongs to the authorized user */
-		if (!qp) {
-			ehca_gen_err("qp is NULL ret=NOPAGE_SIGBUS");
-			return NOPAGE_SIGBUS;
-		}
-
-		pd = container_of(qp->ib_qp.pd, struct ehca_pd, ib_pd);
-		if (pd->ownpid != cur_pid) {
-			ehca_err(qp->ib_qp.device,
-				 "Invalid caller pid=%x ownpid=%x",
-				 cur_pid, pd->ownpid);
-			return NOPAGE_SIGBUS;
-		}
-
-		if (rsrc_type == 2) {	/* rqueue */
-			ehca_dbg(qp->ib_qp.device, "qp=%p qp rqueuearea", qp);
-			offset = address - vma->vm_start;
-			vaddr = ipz_qeit_calc(&qp->ipz_rqueue, offset);
-			ehca_dbg(qp->ib_qp.device, "offset=%lx vaddr=%p",
-				 offset, vaddr);
-			mypage = virt_to_page(vaddr);
-		} else if (rsrc_type == 3) {	/* squeue */
-			ehca_dbg(qp->ib_qp.device, "qp=%p qp squeuearea", qp);
-			offset = address - vma->vm_start;
-			vaddr = ipz_qeit_calc(&qp->ipz_squeue, offset);
-			ehca_dbg(qp->ib_qp.device, "offset=%lx vaddr=%p",
-				 offset, vaddr);
-			mypage = virt_to_page(vaddr);
-		}
-		break;
-
-	default:
-		ehca_gen_err("bad queue type %x", q_type);
-		return NOPAGE_SIGBUS;
+	u32 *count = (u32*)vma->vm_private_data;
+	if (!count) {
+		ehca_gen_err("Invalid vma struct vm_start=%lx vm_end=%lx",
+			     vma->vm_start, vma->vm_end);
+		return;
 	}
+	(*count)++;
+	if (!(*count))
+		ehca_gen_err("Use count overflow vm_start=%lx vm_end=%lx",
+			     vma->vm_start, vma->vm_end);
+	ehca_gen_dbg("vm_start=%lx vm_end=%lx count=%x",
+		     vma->vm_start, vma->vm_end, *count);
+}
 
-	if (!mypage) {
-		ehca_gen_err("Invalid page adr==NULL ret=NOPAGE_SIGBUS");
-		return NOPAGE_SIGBUS;
+static void mm_close(struct vm_area_struct *vma)
+{
+	u32 *count = (u32*)vma->vm_private_data;
+	if (!count) {
+		ehca_gen_err("Invalid vma struct vm_start=%lx vm_end=%lx",
+			     vma->vm_start, vma->vm_end);
+		return;
 	}
-	get_page(mypage);
-
-	return mypage;
+	(*count)--;
+	ehca_gen_dbg("vm_start=%lx vm_end=%lx count=%x",
+		     vma->vm_start, vma->vm_end, *count);
 }
 
-static struct vm_operations_struct ehcau_vm_ops = {
-	.nopage = ehca_nopage,
+static struct vm_operations_struct vm_ops = {
+	.open =	mm_open,
+	.close = mm_close,
 };
 
+static int ehca_mmap_qpages(struct vm_area_struct *vma, struct ipz_queue *queue)
+{
+	u64 start, ofs;
+	struct page *page;
+	int  rc = 0;
+	start = vma->vm_start;
+	for (ofs = 0; ofs < queue->queue_length; ofs += PAGE_SIZE) {
+		u64 virt_addr = (u64)ipz_qeit_calc(queue, ofs);
+		page = virt_to_page(virt_addr);
+		rc = vm_insert_page(vma, start, page);
+		if (unlikely(rc)) {
+			ehca_gen_err("vm_insert_page() failed rc=%x", rc);
+			return rc;
+		}
+		start +=  PAGE_SIZE;
+	}
+	return 0;
+}
+
 int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 {
 	u64 fileoffset = vma->vm_pgoff << PAGE_SHIFT;
@@ -204,7 +158,6 @@ int ehca_mmap(struct ib_ucontext *contex
 		switch (rsrc_type) {
 		case 1: /* galpa fw handle */
 			ehca_dbg(cq->ib_cq.device, "cq=%p cq triggerarea", cq);
-			vma->vm_flags |= VM_RESERVED;
 			vsize = vma->vm_end - vma->vm_start;
 			if (vsize != EHCA_PAGESIZE) {
 				ehca_err(cq->ib_cq.device, "invalid vsize=%lx",
@@ -214,25 +167,34 @@ int ehca_mmap(struct ib_ucontext *contex
 
 			physical = cq->galpas.user.fw_handle;
 			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-			vma->vm_flags |= VM_IO | VM_RESERVED;
 
 			ehca_dbg(cq->ib_cq.device,
 				 "vsize=%lx physical=%lx", vsize, physical);
+			/* VM_IO | VM_RESERVED are set by remap_pfn_range() */
 			ret = remap_pfn_range(vma, vma->vm_start,
 					      physical >> PAGE_SHIFT, vsize,
 					      vma->vm_page_prot);
-			if (ret) {
+			if (unlikely(ret)) {
 				ehca_err(cq->ib_cq.device,
 					 "remap_pfn_range() failed ret=%x",
 					 ret);
 				return -ENOMEM;
 			}
+			vma->vm_private_data = &cq->mm_count_galpa;
+			cq->mm_count_galpa++;
 			break;
 
 		case 2: /* cq queue_addr */
 			ehca_dbg(cq->ib_cq.device, "cq=%p cq q_addr", cq);
 			vma->vm_flags |= VM_RESERVED;
-			vma->vm_ops = &ehcau_vm_ops;
+			ret = ehca_mmap_qpages(vma, &cq->ipz_queue);
+			if (unlikely(ret)) {
+				ehca_gen_err("ehca_mmap_qpages() failed rc=%x "
+					     "cq_num=%x", ret, cq->cq_number);
+				return ret;
+			}
+			vma->vm_private_data = &cq->mm_count_queue;
+			cq->mm_count_queue++;
 			break;
 
 		default:
@@ -265,7 +227,6 @@ int ehca_mmap(struct ib_ucontext *contex
 		switch (rsrc_type) {
 		case 1: /* galpa fw handle */
 			ehca_dbg(qp->ib_qp.device, "qp=%p qp triggerarea", qp);
-			vma->vm_flags |= VM_RESERVED;
 			vsize = vma->vm_end - vma->vm_start;
 			if (vsize != EHCA_PAGESIZE) {
 				ehca_err(qp->ib_qp.device, "invalid vsize=%lx",
@@ -275,31 +236,49 @@ int ehca_mmap(struct ib_ucontext *contex
 
 			physical = qp->galpas.user.fw_handle;
 			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-			vma->vm_flags |= VM_IO | VM_RESERVED;
 
 			ehca_dbg(qp->ib_qp.device, "vsize=%lx physical=%lx",
 				 vsize, physical);
+			/* VM_IO | VM_RESERVED are set by remap_pfn_range() */
 			ret = remap_pfn_range(vma, vma->vm_start,
 					      physical >> PAGE_SHIFT, vsize,
 					      vma->vm_page_prot);
-			if (ret) {
+			if (unlikely(ret)) {
 				ehca_err(qp->ib_qp.device,
 					 "remap_pfn_range() failed ret=%x",
 					 ret);
 				return -ENOMEM;
 			}
+			vma->vm_private_data = &qp->mm_count_galpa;
+			qp->mm_count_galpa++;
 			break;
 
 		case 2: /* qp rqueue_addr */
 			ehca_dbg(qp->ib_qp.device, "qp=%p qp rqueue_addr", qp);
 			vma->vm_flags |= VM_RESERVED;
-			vma->vm_ops = &ehcau_vm_ops;
+			ret = ehca_mmap_qpages(vma, &qp->ipz_rqueue);
+			if (unlikely(ret)) {
+				ehca_gen_err("ehca_mmap_qpages(rq) failed "
+					     "rc=%x qp_num=%x",
+					     ret, qp->ib_qp.qp_num);
+				return ret;
+			}
+			vma->vm_private_data = &qp->mm_count_rqueue;
+			qp->mm_count_rqueue++;
 			break;
 
 		case 3: /* qp squeue_addr */
 			ehca_dbg(qp->ib_qp.device, "qp=%p qp squeue_addr", qp);
 			vma->vm_flags |= VM_RESERVED;
-			vma->vm_ops = &ehcau_vm_ops;
+			ret = ehca_mmap_qpages(vma, &qp->ipz_squeue);
+			if (unlikely(ret)) {
+				ehca_gen_err("ehca_mmap_qpages(sq) failed "
+					     "rc=%x qp_num=%x",
+					     ret, qp->ib_qp.qp_num);
+				return ret;
+			}
+			vma->vm_private_data = &qp->mm_count_squeue;
+			qp->mm_count_squeue++;
 			break;
 
 		default:
@@ -314,79 +293,7 @@ int ehca_mmap(struct ib_ucontext *contex
 		return -EINVAL;
 	}
 
-	return 0;
-}
-
-int ehca_mmap_nopage(u64 foffset, u64 length, void **mapped,
-		     struct vm_area_struct **vma)
-{
-	down_write(&current->mm->mmap_sem);
-	*mapped = (void*)do_mmap(NULL,0, length, PROT_WRITE,
-				 MAP_SHARED | MAP_ANONYMOUS,
-				 foffset);
-	up_write(&current->mm->mmap_sem);
-	if (!(*mapped)) {
-		ehca_gen_err("couldn't mmap foffset=%lx length=%lx",
-			     foffset, length);
-		return -EINVAL;
-	}
-
-	*vma = find_vma(current->mm, (u64)*mapped);
-	if (!(*vma)) {
-		down_write(&current->mm->mmap_sem);
-		do_munmap(current->mm, 0, length);
-		up_write(&current->mm->mmap_sem);
-		ehca_gen_err("couldn't find vma queue=%p", *mapped);
-		return -EINVAL;
-	}
-	(*vma)->vm_flags |= VM_RESERVED;
-	(*vma)->vm_ops = &ehcau_vm_ops;
+	vma->vm_ops = &vm_ops;
 
 	return 0;
 }
-
-int ehca_mmap_register(u64 physical, void **mapped,
-		       struct vm_area_struct **vma)
-{
-	int ret;
-	unsigned long vsize;
-	/* ehca hw supports only 4k page */
-	ret = ehca_mmap_nopage(0, EHCA_PAGESIZE, mapped, vma);
-	if (ret) {
-		ehca_gen_err("could'nt mmap physical=%lx", physical);
-		return ret;
-	}
-
-	(*vma)->vm_flags |= VM_RESERVED;
-	vsize = (*vma)->vm_end - (*vma)->vm_start;
-	if (vsize != EHCA_PAGESIZE) {
-		ehca_gen_err("invalid vsize=%lx",
-			     (*vma)->vm_end - (*vma)->vm_start);
-		return -EINVAL;
-	}
-
-	(*vma)->vm_page_prot = pgprot_noncached((*vma)->vm_page_prot);
-	(*vma)->vm_flags |= VM_IO | VM_RESERVED;
-
-	ret = remap_pfn_range((*vma), (*vma)->vm_start,
-			      physical >> PAGE_SHIFT, vsize,
-			      (*vma)->vm_page_prot);
-	if (ret) {
-		ehca_gen_err("remap_pfn_range() failed ret=%x", ret);
-		return -ENOMEM;
-	}
-
-	return 0;
-
-}
-
-int ehca_munmap(unsigned long addr, size_t len) {
-	int ret = 0;
-	struct mm_struct *mm = current->mm;
-	if (mm) {
-		down_write(&mm->mmap_sem);
-		ret = do_munmap(mm, addr, len);
-		up_write(&mm->mmap_sem);
-	}
-	return ret;
-}
