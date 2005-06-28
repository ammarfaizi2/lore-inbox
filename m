Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVF1XXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVF1XXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVF1XXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:23:09 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:11926 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S262232AbVF1XD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:57 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 11/16] IB uverbs: add mthca mmap support
In-Reply-To: <2005628163.o84QGfsM7oMSy0oU@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.gtJFW6uLUrGQteys@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mmap() method to mthca, so that userspace can get
access to doorbell registers.  This allows userspace to get direct
access to the HCA for data path operations.

Each userspace context gets its own copy of the doorbell registers and
is only allowed to use resources that the kernel has given it access
to.  In other words, this is safe.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:16.611313860 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:18.380930082 -0700
@@ -340,6 +340,23 @@ static int mthca_dealloc_ucontext(struct
 	return 0;
 }
 
+static int mthca_mmap_uar(struct ib_ucontext *context,
+			  struct vm_area_struct *vma)
+{
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_flags    |= VM_DONTCOPY;
+
+	if (remap_pfn_range(vma, vma->vm_start,
+			    to_mucontext(context)->uar.pfn,
+			    PAGE_SIZE, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
 static struct ib_pd *mthca_alloc_pd(struct ib_device *ibdev,
 				    struct ib_ucontext *context,
 				    struct ib_udata *udata)
@@ -766,6 +783,7 @@ int mthca_register_device(struct mthca_d
 	dev->ib_dev.query_gid            = mthca_query_gid;
 	dev->ib_dev.alloc_ucontext       = mthca_alloc_ucontext;
 	dev->ib_dev.dealloc_ucontext     = mthca_dealloc_ucontext;
+	dev->ib_dev.mmap                 = mthca_mmap_uar;
 	dev->ib_dev.alloc_pd             = mthca_alloc_pd;
 	dev->ib_dev.dealloc_pd           = mthca_dealloc_pd;
 	dev->ib_dev.create_ah            = mthca_ah_create;
