Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUJCSXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUJCSXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUJCSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:23:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50447 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268042AbUJCSX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:23:29 -0400
Date: Sun, 3 Oct 2004 19:23:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] vmtrunc: truncate_count not atomic
In-Reply-To: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410031921440.2750-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is mapping->truncate_count atomic?  It's incremented inside
i_mmap_lock (and i_sem), and the reads don't need it to be atomic.

And why smp_rmb() before call to ->nopage?  The compiler cannot reorder
the initial assignment of sequence after the call to ->nopage, and no
cpu (yet!) can read from the future, which is all that matters there.

And delete totally bogus reset of truncate_count from blkmtd add_device.
truncate_count is all about detecting i_size changes: i_size does not
change there; and if it did, the count should be incremented not reset.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 drivers/mtd/devices/blkmtd.c |    1 -
 fs/inode.c                   |    1 -
 include/linux/fs.h           |    2 +-
 mm/memory.c                  |   12 +++++-------
 4 files changed, 6 insertions(+), 10 deletions(-)

--- 2.6.9-rc3-mm1/drivers/mtd/devices/blkmtd.c	2004-08-14 06:38:20.000000000 +0100
+++ trunc1/drivers/mtd/devices/blkmtd.c	2004-10-03 01:07:01.388014544 +0100
@@ -661,7 +661,6 @@ static struct blkmtd_dev *add_device(cha
 
 	memset(dev, 0, sizeof(struct blkmtd_dev));
 	dev->blkdev = bdev;
-	atomic_set(&(dev->blkdev->bd_inode->i_mapping->truncate_count), 0);
 	if(!readonly) {
 		init_MUTEX(&dev->wrbuf_mutex);
 	}
--- trunc0/fs/inode.c	2004-10-02 18:22:24.857608136 +0100
+++ trunc1/fs/inode.c	2004-10-03 01:07:01.390014240 +0100
@@ -200,7 +200,6 @@ void inode_init_once(struct inode *inode
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.tree_lock);
 	spin_lock_init(&inode->i_data.i_mmap_lock);
-	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
--- trunc0/include/linux/fs.h	2004-10-02 18:22:28.019127512 +0100
+++ trunc1/include/linux/fs.h	2004-10-03 01:07:01.393013784 +0100
@@ -342,7 +342,7 @@ struct address_space {
 	struct prio_tree_root	i_mmap;		/* tree of private and shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
 	spinlock_t		i_mmap_lock;	/* protect tree, count, list */
-	atomic_t		truncate_count;	/* Cover race condition with truncate */
+	unsigned int		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		nrpages;	/* number of total pages */
 	pgoff_t			writeback_index;/* writeback starts here */
 	struct address_space_operations *a_ops;	/* methods */
--- trunc0/mm/memory.c	2004-10-02 18:22:29.354924440 +0100
+++ trunc1/mm/memory.c	2004-10-03 01:07:01.396013328 +0100
@@ -1259,7 +1259,7 @@ void unmap_mapping_range(struct address_
 
 	spin_lock(&mapping->i_mmap_lock);
 	/* Protect against page fault */
-	atomic_inc(&mapping->truncate_count);
+	mapping->truncate_count++;
 
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		unmap_mapping_range_list(&mapping->i_mmap, &details);
@@ -1557,7 +1557,7 @@ do_no_page(struct mm_struct *mm, struct 
 	struct page * new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
-	int sequence = 0;
+	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
 
@@ -1569,9 +1569,8 @@ do_no_page(struct mm_struct *mm, struct 
 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
-		sequence = atomic_read(&mapping->truncate_count);
+		sequence = mapping->truncate_count;
 	}
-	smp_rmb();  /* Prevent CPU from reordering lock-free ->nopage() */
 retry:
 	cond_resched();
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
@@ -1615,9 +1614,8 @@ retry:
 	 * invalidated this page.  If unmap_mapping_range got called,
 	 * retry getting the page.
 	 */
-	if (mapping &&
-	      (unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
-		sequence = atomic_read(&mapping->truncate_count);
+	if (mapping && unlikely(sequence != mapping->truncate_count)) {
+		sequence = mapping->truncate_count;
 		spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
 		goto retry;

