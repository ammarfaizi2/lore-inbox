Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVJHH6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVJHH6b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 03:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJHH6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 03:58:31 -0400
Received: from fmr24.intel.com ([143.183.121.16]:41904 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750738AbVJHH6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 03:58:31 -0400
Message-Id: <200510080758.j987w0g06343@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Seth, Rohit" <rohit.seth@intel.com>, <hugh@veritas.com>, <agl@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Cc: <linux-mm@kvack.org>, <akpm@osdl.org>
Subject: RE: FW: [PATCH 0/3] Demand faulting for huge pages
Date: Sat, 8 Oct 2005 00:57:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXLhTD/dngZ3/qjS+KfldOFWp0/9AAVbeCA
In-Reply-To: <1128720518.32679.15.camel@akash.sc.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote on Friday, October 07, 2005 2:29 PM
> On Fri, 2005-10-07 at 10:47 -0700, Adam Litke wrote:
> > If I were to spend time coding up a patch to remove truncation
> > support for hugetlbfs, would it be something other people would
> > want to see merged as well?
> 
> In its current form, there is very little use of huegtlb truncate
> functionality.  Currently it only allows reducing the size of hugetlb
> backing file.   
> 
> IMO it will be useful to keep and enhance this capability so that
> apps can dynamically reduce or increase the size of backing files
> (for example based on availability of memory at any time).

Yup, here is a patch to enhance that capability.  It is more of bring
ftruncate on hugetlbfs file a step closer to the same semantics for
file on other file systems.


---
Add expanding ftruncate to hugetlbfs.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.14-rc3/fs/hugetlbfs/inode.c.orig	2005-10-07 18:07:38.131373873 -0700
+++ linux-2.6.14-rc3/fs/hugetlbfs/inode.c	2005-10-08 00:31:15.951404405 -0700
@@ -327,20 +327,20 @@ hugetlb_vmtruncate_list(struct prio_tree
 	}
 }
 
-/*
- * Expanding truncates are not allowed.
- */
 static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 {
 	unsigned long pgoff;
 	struct address_space *mapping = inode->i_mapping;
-
-	if (offset > inode->i_size)
-		return -EINVAL;
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+	int ret = 0;
 
 	BUG_ON(offset & ~HPAGE_MASK);
 	pgoff = offset >> HPAGE_SHIFT;
 
+	if (offset > inode->i_size)
+		goto do_expand;
+
 	inode->i_size = offset;
 	spin_lock(&mapping->i_mmap_lock);
 	if (!prio_tree_empty(&mapping->i_mmap))
@@ -348,6 +348,18 @@ static int hugetlb_vmtruncate(struct ino
 	spin_unlock(&mapping->i_mmap_lock);
 	truncate_hugepages(mapping, offset);
 	return 0;
+
+do_expand:
+	spin_lock(&mapping->i_mmap_lock);
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, ULONG_MAX) {
+		ret = hugetlb_prefault(mapping, vma);
+		if (ret == 0)
+			inode->i_size = offset;
+		else
+			break;
+	}
+	spin_unlock(&mapping->i_mmap_lock);
+	return ret;
 }
 
 static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
--- linux-2.6.14-rc3/mm/hugetlb.c.orig	2005-10-07 23:16:42.789349826 -0700
+++ linux-2.6.14-rc3/mm/hugetlb.c	2005-10-07 23:25:04.175085872 -0700
@@ -340,7 +340,7 @@ void zap_hugepage_range(struct vm_area_s
 
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr;
 	int ret = 0;
 
@@ -360,6 +360,8 @@ int hugetlb_prefault(struct address_spac
 			ret = -ENOMEM;
 			goto out;
 		}
+		if (pte_present(*pte))
+			continue;
 
 		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));

