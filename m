Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWGDFpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWGDFpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWGDFpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:45:53 -0400
Received: from mga05.intel.com ([192.55.52.89]:43103 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751122AbWGDFpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:45:52 -0400
X-IronPort-AV: i="4.06,202,1149490800"; 
   d="scan'208"; a="92899106:sNHT14149121"
Subject: [PATCH] mmap zero-length hugetlb file with PROT_NONE to protect a
	hugetlb virtual area
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain
Message-Id: <1151991861.28493.160.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 04 Jul 2006 13:44:21 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Sometimes, applications need below call to be successful although
"/mnt/hugepages/file1" doesn't exist.

fd = open("/mnt/hugepages/file1", O_CREAT|O_RDWR, 0755);
*addr = mmap(NULL, 0x1024*1024*256, PROT_NONE, 0, fd, 0);

As for regular pages (or files), above call does work, but as for huge pages,
above call would fail because hugetlbfs_file_mmap would fail if 
(!(vma->vm_flags & VM_WRITE) && len > inode->i_size). 
 
This capability on huge page is useful on ia64 when the process wants to 
protect one area on region 4, so other threads couldn't read/write this
area. A famous JVM (Java Virtual Machine) implementation on IA64 needs the
capability.

The patch against 2.6.17-mm6 provides the capability.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.17_mm6/fs/hugetlbfs/inode.c linux-2.6.17_mm6_hugetlb/fs/hugetlbfs/inode.c
--- linux-2.6.17_mm6/fs/hugetlbfs/inode.c	2006-07-04 10:18:38.000000000 +0800
+++ linux-2.6.17_mm6_hugetlb/fs/hugetlbfs/inode.c	2006-07-04 10:20:10.000000000 +0800
@@ -83,8 +83,6 @@ static int hugetlbfs_file_mmap(struct fi
 
 	ret = -ENOMEM;
 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
-		goto out;
 
 	if (vma->vm_flags & VM_MAYSHARE &&
 	    hugetlb_reserve_pages(inode, vma->vm_pgoff >> (HPAGE_SHIFT-PAGE_SHIFT),
@@ -93,7 +91,7 @@ static int hugetlbfs_file_mmap(struct fi
 
 	ret = 0;
 	hugetlb_prefault_arch_hook(vma->vm_mm);
-	if (inode->i_size < len)
+	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
 		inode->i_size = len;
 out:
 	mutex_unlock(&inode->i_mutex);
