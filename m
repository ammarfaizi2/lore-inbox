Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVIFWAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVIFWAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVIFWAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:00:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:59555 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751000AbVIFWAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:00:06 -0400
Subject: Re: [PATCH 3/3 htlb-acct] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1126043611.3123.55.camel@localhost.localdomain>
References: <1126043611.3123.55.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 06 Sep 2005 17:00:01 -0500
Message-Id: <1126044001.3123.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Post (Thu, 18 Aug 2005)

Basic overcommit checking for hugetlb_file_map() based on an implementation
used with demand faulting in SLES9.

Since demand faulting can't guarantee the availability of pages at mmap time,
this patch implements a basic sanity check to ensure that the number of huge
pages required to satisfy the mmap are currently available.  Despite the
obvious race, I think it is a good start on doing proper accounting.  I'd like
to work towards an accounting system that mimics the semantics of normal pages
(especially for the MAP_PRIVATE/COW case).  That work is underway and builds on
what this patch starts.

Huge page shared memory segments are simpler and still maintain their commit on
shmget semantics.

Diffed against 2.6.13-git6

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 inode.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+)
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c
+++ current/fs/hugetlbfs/inode.c
@@ -45,9 +45,51 @@ static struct backing_dev_info hugetlbfs
 
 int sysctl_hugetlb_shm_group;
 
+static void huge_pagevec_release(struct pagevec *pvec);
+
+unsigned long
+huge_pages_needed(struct address_space *mapping, struct vm_area_struct *vma)
+{
+	int i;
+	struct pagevec pvec;
+	unsigned long start = vma->vm_start;
+	unsigned long end = vma->vm_end;
+	unsigned long hugepages = (end - start) >> HPAGE_SHIFT;
+	pgoff_t next = vma->vm_pgoff;
+	pgoff_t endpg = next + ((end - start) >> PAGE_SHIFT);
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+
+	/*
+	 * Shared memory segments are accounted for at shget time,
+	 * not at shmat (when the mapping is actually created) so 
+	 * check here if the memory has already been accounted for.
+	 */
+	if (inode->i_blocks != 0)
+		return 0;
+
+	pagevec_init(&pvec, 0);
+	while (next < endpg) {
+		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE))
+			break;
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+			if (page->index > next)
+				next = page->index;
+			if (page->index >= endpg)
+				break;
+			next++;
+			hugepages--;
+		}
+		huge_pagevec_release(&pvec);
+	}
+	return hugepages << HPAGE_SHIFT;
+}
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long bytes;
 	loff_t len, vma_len;
 	int ret;
 
@@ -66,6 +108,10 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;
 
+	bytes = huge_pages_needed(mapping, vma);
+	if (!is_hugepage_mem_enough(bytes))
+		return -ENOMEM;
+
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	down(&inode->i_sem);
@@ -794,6 +840,7 @@ struct file *hugetlb_zero_setup(size_t s
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
+	inode->i_blocks = 1;
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;


