Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273002AbTHKSnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273030AbTHKSmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:42:00 -0400
Received: from [66.212.224.118] ([66.212.224.118]:5649 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S273002AbTHKSlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:41:00 -0400
Date: Mon, 11 Aug 2003 14:29:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2.6] hugetlbfs - 'recovering' too many blocks on failure
Message-ID: <Pine.LNX.4.53.0308111422060.26153@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code appears to be able to add too many blocks back to 
sbinfo->free_blocks in the failure path. We first do;

len = vma->vm_end - vma->vm_start;
sbinfo->free_blocks -= len;

but then later do;
len = (vma->vm_end - vma->vma_start) + (vma->vm_pgoff << HPAGE_SHIFT)

error:
sbinfo->free_blocks += len;

Index: linux-2.6.0-test3-mm1/fs/hugetlbfs/inode.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/fs/hugetlbfs/inode.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 inode.c
--- linux-2.6.0-test3-mm1/fs/hugetlbfs/inode.c	11 Aug 2003 03:01:07 -0000	1.2
+++ linux-2.6.0-test3-mm1/fs/hugetlbfs/inode.c	11 Aug 2003 17:44:31 -0000
@@ -48,7 +48,7 @@ static int hugetlbfs_file_mmap(struct fi
 	struct inode *inode = file->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(inode->i_sb);
-	loff_t len;
+	loff_t len, vma_len;
 	int ret;
 
 	if (vma->vm_start & ~HPAGE_MASK)
@@ -60,11 +60,11 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;
 
-	len = (loff_t)(vma->vm_end - vma->vm_start);
+	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 	if (sbinfo->free_blocks >= 0) { /* Check if there is any size limit. */
 		spin_lock(&sbinfo->stat_lock);
-		if ((len >> HPAGE_SHIFT) <= sbinfo->free_blocks) {
-			sbinfo->free_blocks -= (len >> HPAGE_SHIFT);
+		if ((vma_len >> HPAGE_SHIFT) <= sbinfo->free_blocks) {
+			sbinfo->free_blocks -= (vma_len >> HPAGE_SHIFT);
 			spin_unlock(&sbinfo->stat_lock);
 		} else {
 			spin_unlock(&sbinfo->stat_lock);
@@ -78,8 +78,7 @@ static int hugetlbfs_file_mmap(struct fi
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 	ret = hugetlb_prefault(mapping, vma);
-	len = (loff_t)(vma->vm_end - vma->vm_start) +
-			((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	if (ret == 0 && inode->i_size < len)
 		inode->i_size = len;
 	up(&inode->i_sem);
@@ -89,7 +88,7 @@ static int hugetlbfs_file_mmap(struct fi
 	 */
 	if ((ret != 0) && (sbinfo->free_blocks >= 0)) {
 		spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_blocks += (len >> HPAGE_SHIFT);
+		sbinfo->free_blocks += (vma_len >> HPAGE_SHIFT);
 		spin_unlock(&sbinfo->stat_lock);
 	}
 
