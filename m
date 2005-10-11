Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVJKTQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVJKTQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJKTQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:16:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:11915 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932340AbVJKTQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:16:51 -0400
Subject: [PATCH 3/3] hugetlb: Simple overcommit check
From: Adam Litke <agl@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       david@gibson.dropbear.id.au, ak@suse.de, hugh@veritas.com,
       agl@us.ibm.com
In-Reply-To: <20051011113206.77e0fc84.akpm@osdl.org>
References: <1129055057.22182.8.camel@localhost.localdomain>
	 <20051011113206.77e0fc84.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Tue, 11 Oct 2005 14:16:45 -0500
Message-Id: <1129058206.22958.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 11:32 -0700, Andrew Morton wrote:
> Adam Litke <agl@us.ibm.com> wrote:
> >
> > Andrew: Did Andi
> >  Kleen's explanation of huge_pages_needed() satisfy?
> 
> Spose so.  I trust that it's adequately commented in this version..

Just to be sure, added a comment block at the top of
huge_pages_needed().

Initial Post (Thu, 18 Aug 2005)

Basic overcommit checking for hugetlb_file_map() based on an implementation
used with demand faulting in SLES9.

Since we're not prefaulting the pages at mmap time, some extra accounting is
needed.  This patch implements a basic sanity check to ensure that the number
of huge pages required to satisfy the mmap are currently available.  Of course
this method doesn't guarantee that the pages will be available at fault time,
but I think it is a good start on doing proper accounting and solves 90% of the
overcommit problems I see in practice.

Huge page shared memory segments are simpler and still maintain their commit on
shmget semantics.

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 inode.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 63 insertions(+), 10 deletions(-)
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c
+++ current/fs/hugetlbfs/inode.c
@@ -45,9 +45,67 @@ static struct backing_dev_info hugetlbfs
 
 int sysctl_hugetlb_shm_group;
 
+static void huge_pagevec_release(struct pagevec *pvec)
+{
+	int i;
+
+	for (i = 0; i < pagevec_count(pvec); ++i)
+		put_page(pvec->pages[i]);
+
+	pagevec_reinit(pvec);
+}
+
+/*
+ * huge_pages_needed tries to determine the number of new huge pages that
+ * will be required to fully populate this VMA.  This will be equal to
+ * the size of the VMA in huge pages minus the number of huge pages 
+ * (covered by this VMA) that are found in the page cache.
+ *
+ * Result is in bytes to be compatible with is_hugepage_mem_enough()
+ */
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
 
@@ -66,6 +124,10 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;
 
+	bytes = huge_pages_needed(mapping, vma);
+	if (!is_hugepage_mem_enough(bytes))
+		return -ENOMEM;
+
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	down(&inode->i_sem);
@@ -167,16 +229,6 @@ static int hugetlbfs_commit_write(struct
 	return -EINVAL;
 }
 
-static void huge_pagevec_release(struct pagevec *pvec)
-{
-	int i;
-
-	for (i = 0; i < pagevec_count(pvec); ++i)
-		put_page(pvec->pages[i]);
-
-	pagevec_reinit(pvec);
-}
-
 static void truncate_huge_page(struct page *page)
 {
 	clear_page_dirty(page);
@@ -792,6 +844,7 @@ struct file *hugetlb_zero_setup(size_t s
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
+	inode->i_blocks = 1;
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;


-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

