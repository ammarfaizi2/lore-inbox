Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUJXP7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUJXP7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUJXP5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:57:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55071 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261531AbUJXPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:46:09 -0400
Date: Sun, 24 Oct 2004 16:45:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: William Irwin <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] statm: __vm_stat_accounting
Message-ID: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The procfs shared_vm accounting in do_mmap_pgoff didn't balance with
munmap in the case of shared anonymous: because file comes in NULL,
whereas vm_file gets set at the end by shmem_zero_setup.

Update file; and update vm_flags (a driver is likely to add VM_IO or
VM_RESERVED, modifying reserved_vm); and update pgoff (doesn't affect
procfs accounting, but could affect vma_merge - though at present all
drivers which modify vm_pgoff set a VM_SPECIAL which prevents merging).
And do that __vm_stat_account before advancing to make_pages_present.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 mm/mmap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- 2.6.10-rc1/mm/mmap.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/mmap.c	2004-10-23 20:43:24.000000000 +0100
@@ -988,9 +988,12 @@ munmap_back:
 	 *         f_op->mmap method. -DaveM
 	 */
 	addr = vma->vm_start;
+	pgoff = vma->vm_pgoff;
+	vm_flags = vma->vm_flags;
 
 	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
 			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
+		file = vma->vm_file;
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -1005,6 +1008,7 @@ munmap_back:
 	}
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
+	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
@@ -1015,7 +1019,6 @@ out:	
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
-	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	return addr;
 
 unmap_and_free_vma:

