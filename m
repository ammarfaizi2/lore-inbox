Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTFLUCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTFLUCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:02:34 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:32799 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264976AbTFLUC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:02:28 -0400
Date: Thu, 12 Jun 2003 15:16:01 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <133430000.1055448961@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1848066916=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1848066916==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Paul McKenney and I sat down today and hashed out just what the races are
for both  vmtruncate and the distributed filesystems.  We took Andrea's
idea of using seqlocks and came up with a simple solution that definitely
fixes the race in vmtruncate, as well as most likely the invalidate race in
distributed filesystems.  Paul is going to discuss it with the DFS folks to
verify that it's a complete fix for them, but neither of us can see a hole.

Anyway, here's the patch.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1848066916==========
Content-Type: text/plain; charset=iso-8859-1; name="trunc-2.5.70-mm8-1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="trunc-2.5.70-mm8-1.diff"; size=4075

--- 2.5.70-mm8/./drivers/mtd/devices/blkmtd.c	2003-05-26 20:00:21.000000000 =
-0500
+++ 2.5.70-mm8-trunc/./drivers/mtd/devices/blkmtd.c	2003-06-12 =
13:45:48.000000000 -0500
@@ -1189,6 +1189,7 @@ static int __init init_blkmtd(void)
   INIT_LIST_HEAD(&mtd_rawdevice->as.locked_pages);
   mtd_rawdevice->as.host =3D NULL;
   init_MUTEX(&(mtd_rawdevice->as.i_shared_sem));
+  seqlock_init(&(mtd_rawdevice->as.truncate_lock));
=20
   mtd_rawdevice->as.a_ops =3D &blkmtd_aops;
   INIT_LIST_HEAD(&mtd_rawdevice->as.i_mmap);
--- 2.5.70-mm8/./include/linux/fs.h	2003-06-12 13:37:28.000000000 -0500
+++ 2.5.70-mm8-trunc/./include/linux/fs.h	2003-06-12 13:42:51.000000000 =
-0500
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/seqlock.h>
 #include <asm/atomic.h>
=20
 struct iovec;
@@ -323,6 +324,7 @@ struct address_space {
 	struct list_head	i_mmap;		/* list of private mappings */
 	struct list_head	i_mmap_shared;	/* list of shared mappings */
 	struct semaphore	i_shared_sem;	/* protect both above lists */
+	seqlock_t		truncate_lock;	/* Cover race condition with truncate */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
 	int			gfp_mask;	/* how to allocate the pages */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
--- 2.5.70-mm8/./fs/inode.c	2003-06-12 13:37:22.000000000 -0500
+++ 2.5.70-mm8-trunc/./fs/inode.c	2003-06-12 13:43:29.000000000 -0500
@@ -185,6 +185,7 @@ void inode_init_once(struct inode *inode
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	spin_lock_init(&inode->i_data.page_lock);
 	init_MUTEX(&inode->i_data.i_shared_sem);
+	seqlock_init(&inode->i_data.truncate_lock);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
--- 2.5.70-mm8/./mm/swap_state.c	2003-05-26 20:00:39.000000000 -0500
+++ 2.5.70-mm8-trunc/./mm/swap_state.c	2003-06-12 13:40:54.000000000 -0500
@@ -44,6 +44,7 @@ struct address_space swapper_space =3D {
 	.i_mmap		=3D LIST_HEAD_INIT(swapper_space.i_mmap),
 	.i_mmap_shared	=3D LIST_HEAD_INIT(swapper_space.i_mmap_shared),
 	.i_shared_sem	=3D __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
+	.truncate_lock  =3D SEQLOCK_UNLOCKED,
 	.private_lock	=3D SPIN_LOCK_UNLOCKED,
 	.private_list	=3D LIST_HEAD_INIT(swapper_space.private_list),
 };
--- 2.5.70-mm8/./mm/memory.c	2003-06-12 13:37:31.000000000 -0500
+++ 2.5.70-mm8-trunc/./mm/memory.c	2003-06-12 13:40:54.000000000 -0500
@@ -1138,6 +1138,9 @@ invalidate_mmap_range(struct address_spa
 			hlen =3D ULONG_MAX - hba + 1;
 	}
 	down(&mapping->i_shared_sem);
+	/* Protect against page fault */
+	write_seqlock(&mapping->truncate_lock);
+	write_sequnlock(&mapping->truncate_lock);
 	if (unlikely(!list_empty(&mapping->i_mmap)))
 		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
 	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
@@ -1390,8 +1393,11 @@ do_no_page(struct mm_struct *mm, struct=20
 	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
 {
 	struct page * new_page;
+	struct inode *inode;
+	struct address_space *mapping;
 	pte_t entry;
 	struct pte_chain *pte_chain;
+	unsigned sequence;
 	int ret;
=20
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -1400,6 +1406,10 @@ do_no_page(struct mm_struct *mm, struct=20
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
=20
+	inode =3D vma->vm_file->f_dentry->d_inode;
+	mapping =3D inode->i_mapping;
+retry:
+	sequence =3D read_seqbegin(&mapping->truncate_lock);
 	new_page =3D vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
=20
 	/* no page was available -- either SIGBUS or OOM */
@@ -1428,6 +1438,17 @@ do_no_page(struct mm_struct *mm, struct=20
 	}
=20
 	spin_lock(&mm->page_table_lock);
+	/*
+	 * If someone invalidated the page, serialize against the inode,
+	 * then go try again.
+	 */
+	if (unlikely(read_seqretry(&mapping->truncate_lock, sequence))) {
+		spin_unlock(&mm->page_table_lock);
+		down(&inode->i_sem);
+		up(&inode->i_sem);
+		goto retry;
+	}
+
 	page_table =3D pte_offset_map(pmd, address);
=20
 	/*

--==========1848066916==========--

