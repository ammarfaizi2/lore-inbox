Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWAJTWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWAJTWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWAJTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:22:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29312 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751325AbWAJTWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:22:35 -0500
Subject: Hugetlb: Shared memory race
From: Adam Litke <agl@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Organization: IBM
Date: Tue, 10 Jan 2006 13:22:31 -0600
Message-Id: <1136920951.23288.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have discovered a race caused by the interaction of demand faulting
with the hugetlb overcommit accounting patch.  Attached is a workaround
for the problem.  Can anyone suggest a better approach to solving the
race I'll describe below?  If not, would the attached workaround be
acceptable?

The race occurs when multiple threads shmat a hugetlb area and begin
faulting in it's pages.  During a hugetlb fault, hugetlb_no_page checks
for the page in the page cache.  If not found, it allocates (and zeroes)
a new page and tries to add it to the page cache.  If this fails, the
huge page is freed and we retry the page cache lookup (assuming someone
else beat us to the add_to_page_cache call).

The above works fine, but due to the large window (while zeroing the
huge page) it is possible that many threads could be "borrowing" pages
only to return them later.  This causes free_hugetlb_pages to be lower
than the logical number of free pages and some threads trying to shmat
can falsely fail the accounting check.

The workaround disables the accounting check that happens at shmat time.
It was already done at shmget time (which is the normal semantics
anyway).

Signed-off-by: Adam Litke <agl@us.ibm.com>

 inode.c |   10 ++++++++++
 1 files changed, 10 insertions(+)
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c
+++ current/fs/hugetlbfs/inode.c
@@ -74,6 +74,14 @@ huge_pages_needed(struct address_space *
 	pgoff_t next = vma->vm_pgoff;
 	pgoff_t endpg = next + ((end - start) >> PAGE_SHIFT);
 
+	/* 
+	 * Accounting for shared memory segments is done at shmget time
+	 * so we can skip the check now to avoid a race where hugetlb_no_page
+	 * is zeroing hugetlb pages not yet in the page cache.
+	 */
+	if (vma->vm_file->f_dentry->d_inode->i_blocks != 0)
+		return 0;
+
 	pagevec_init(&pvec, 0);
 	while (next < endpg) {
 		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE))
@@ -832,6 +840,8 @@ struct file *hugetlb_zero_setup(size_t s
 
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
+	/* Mark this file is used for shared memory */
+	inode->i_blocks = 1;
 	inode->i_nlink = 0;
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

