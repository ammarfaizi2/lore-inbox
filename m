Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWCHDRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWCHDRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWCHDRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:17:03 -0500
Received: from fmr23.intel.com ([143.183.121.15]:18882 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932220AbWCHDRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:17:01 -0500
Subject: RE: [PATCH] hugetlb_no_page might break hugetlb quota
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <1141635963.29825.28.camel@ymzhang-perf.sh.intel.com>
References: <200603060815.k268FXg07605@unix-os.sc.intel.com>
	 <1141635963.29825.28.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1141787660.29825.83.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 08 Mar 2006 11:14:20 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 17:06, Zhang, Yanmin wrote:
> On Mon, 2006-03-06 at 16:15, Chen, Kenneth W wrote:
> > Zhang, Yanmin wrote on Sunday, March 05, 2006 10:22 PM
> > > In function hugetlb_no_page, backout path always calls hugetlb_put_quota.
> > > It's incorrect when find_lock_page gets the page or the new page is added
> > > into page cache.
> > 
> > While I acknowledge the bug, this patch is not complete.  It makes file
> > system quota consistent with respect to page cache state. But such quota
> > (more severely, the page cache state) is still buggy, for example under
> > ftruncate case: if one ftrucate hugetlb file and then tries to fault a
> > page outside ftruncate area, a new hugetlb page is allocated and then
> > added into page cache along with file system quota; and at the end
> > returning VM_FAULT_SIGBUS.  In this case, kernel traps an unreachable
> > page until possibly next mmap that extends it.  That need to be fixed.
> I have another patch to fix it. The second patch is to delete checking
> (!(vma->vm_flags & VM_WRITE) && len > inode->i_size) in function
> hugetlbfs_file_mmap, and add a checking in hugetlb_no_page,
> to implement a capability for application to mmap
> an zero-length huge page area. It's useful for process to protect one area.
> As a side effect, the second patch also fixes the problem you said.
> 
Here is the second patch.

From: Zhang Yanmin <yanmin.zhang@intel.com>

Sometimes, applications need below call to be successful although
"/mnt/hugepages/file1" doesn't exist.

	fd = open("/mnt/hugepages/file1", O_CREAT|O_RDWR, 0755);
 	*addr = mmap(NULL, 0x1024*1024*256, PROT_NONE, MAP_SHARED, fd, 0);

As for regular pages (or files), above call does work, but as for huge pages,
above call would fail because hugetlbfs_file_mmap would fail if 
(!(vma->vm_flags & VM_WRITE) && len > inode->i_size). 

This capability on huge page is useful on ia64 when the process wants to 
protect one area on region 4, so other threads couldn't read/write this
area.

My patch against 2.6.16-rc5-mm3 implements it.

In addition, my patch fixes a bug caught by Ken. Consider below scenario:
Process A mmaps a hugetlb file with 5 huge pages, then process B truncates
the file with length of 2 huge pages. Later on, process A still could fault
on huge page 3-5, and these huge pages would be added into page cache.
Then, no processes could access these huge pages. My patch fixes it by
moving checking (idx >= size) to the begining of function hugetlb_no_page.

Thanks for Ken's good suggestions.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.16-rc5-mm3/fs/hugetlbfs/inode.c linux-2.6.16-rc5-mm3_huge_check/fs/hugetlbfs/inode.c
--- linux-2.6.16-rc5-mm3/fs/hugetlbfs/inode.c	2006-03-08 17:59:10.000000000 +0800
+++ linux-2.6.16-rc5-mm3_huge_check/fs/hugetlbfs/inode.c	2006-03-08 18:17:15.000000000 +0800
@@ -84,8 +84,6 @@ static int hugetlbfs_file_mmap(struct fi
 
 	ret = -ENOMEM;
 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
-		goto out;
 
 	if (vma->vm_flags & VM_MAYSHARE)
 		if (hugetlb_extend_reservation(info, len >> HPAGE_SHIFT) != 0)
diff -Nraup linux-2.6.16-rc5-mm3/mm/hugetlb.c linux-2.6.16-rc5-mm3_huge_check/mm/hugetlb.c
--- linux-2.6.16-rc5-mm3/mm/hugetlb.c	2006-03-08 17:59:11.000000000 +0800
+++ linux-2.6.16-rc5-mm3_huge_check/mm/hugetlb.c	2006-03-08 18:01:21.000000000 +0800
@@ -555,6 +555,10 @@ int hugetlb_no_page(struct mm_struct *mm
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
 		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 
+	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
+	if (idx >= size)
+		return ret;
+
 	/*
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
@@ -588,9 +592,6 @@ retry:
 	}
 
 	spin_lock(&mm->page_table_lock);
-	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
-	if (idx >= size)
-		goto backout;
 
 	ret = VM_FAULT_MINOR;
 	if (!pte_none(*ptep))


