Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbTFLWnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFLWno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:43:44 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:13186 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265034AbTFLWnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:43:17 -0400
Date: Thu, 12 Jun 2003 17:56:50 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <184910000.1055458610@baldur.austin.ibm.com>
In-Reply-To: <20030612144418.49f75066.akpm@digeo.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
 <20030612134946.450e0f77.akpm@digeo.com>
 <20030612140014.32b7244d.akpm@digeo.com>
 <150040000.1055452098@baldur.austin.ibm.com>
 <20030612144418.49f75066.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========2142667794=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========2142667794==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On Thursday, June 12, 2003 14:44:18 -0700 Andrew Morton <akpm@digeo.com>
wrote:

> Well it is not "worse".  Futzing with i_sem in do_no_page() is pretty
> gross. You could add vm_ops->prevalidate() or something if it worries you.

Actually I've been studying the logic.  I don't think we need to serialize
with i_sem at all.  i_size has already been changed, so just doing a retry
immediately will be safe.  Distributed filesystems should also be safe as
long as they mark the page invalid before they call invalidate_mmap_range().

I like your idea of doing an atomic_t instead of a seqlock.  The original
idea from Andrea implied there was a range of time it was unstable, but
with this scheme a single increment is sufficient.

I also think if we can solve both the vmtruncate and the distributed file
system races without adding any vm_ops, we should.

Here's a new patch.  Does this look better?

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========2142667794==========
Content-Type: text/plain; charset=iso-8859-1; name="trunc-2.5.70-mm8-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="trunc-2.5.70-mm8-2.diff"; size=3877

--- 2.5.70-mm8/./drivers/mtd/devices/blkmtd.c	2003-05-26 20:00:21.000000000 =
-0500
+++ 2.5.70-mm8-trunc/./drivers/mtd/devices/blkmtd.c	2003-06-12 =
16:57:52.000000000 -0500
@@ -1189,6 +1189,7 @@ static int __init init_blkmtd(void)
   INIT_LIST_HEAD(&mtd_rawdevice->as.locked_pages);
   mtd_rawdevice->as.host =3D NULL;
   init_MUTEX(&(mtd_rawdevice->as.i_shared_sem));
+  atomic_set(&(mtd_rawdevice->as.truncate_count), 0);
=20
   mtd_rawdevice->as.a_ops =3D &blkmtd_aops;
   INIT_LIST_HEAD(&mtd_rawdevice->as.i_mmap);
--- 2.5.70-mm8/./include/linux/fs.h	2003-06-12 13:37:28.000000000 -0500
+++ 2.5.70-mm8-trunc/./include/linux/fs.h	2003-06-12 17:00:04.000000000 =
-0500
@@ -323,6 +323,7 @@ struct address_space {
 	struct list_head	i_mmap;		/* list of private mappings */
 	struct list_head	i_mmap_shared;	/* list of shared mappings */
 	struct semaphore	i_shared_sem;	/* protect both above lists */
+	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
 	int			gfp_mask;	/* how to allocate the pages */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
--- 2.5.70-mm8/./fs/inode.c	2003-06-12 13:37:22.000000000 -0500
+++ 2.5.70-mm8-trunc/./fs/inode.c	2003-06-12 16:59:30.000000000 -0500
@@ -185,6 +185,7 @@ void inode_init_once(struct inode *inode
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	spin_lock_init(&inode->i_data.page_lock);
 	init_MUTEX(&inode->i_data.i_shared_sem);
+	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
--- 2.5.70-mm8/./mm/swap_state.c	2003-05-26 20:00:39.000000000 -0500
+++ 2.5.70-mm8-trunc/./mm/swap_state.c	2003-06-12 16:59:53.000000000 -0500
@@ -44,6 +44,7 @@ struct address_space swapper_space =3D {
 	.i_mmap		=3D LIST_HEAD_INIT(swapper_space.i_mmap),
 	.i_mmap_shared	=3D LIST_HEAD_INIT(swapper_space.i_mmap_shared),
 	.i_shared_sem	=3D __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
+	.truncate_count  =3D ATOMIC_INIT(0),
 	.private_lock	=3D SPIN_LOCK_UNLOCKED,
 	.private_list	=3D LIST_HEAD_INIT(swapper_space.private_list),
 };
--- 2.5.70-mm8/./mm/memory.c	2003-06-12 13:37:31.000000000 -0500
+++ 2.5.70-mm8-trunc/./mm/memory.c	2003-06-12 17:51:55.000000000 -0500
@@ -1138,6 +1138,8 @@ invalidate_mmap_range(struct address_spa
 			hlen =3D ULONG_MAX - hba + 1;
 	}
 	down(&mapping->i_shared_sem);
+	/* Protect against page fault */
+	atomic_inc(&mapping->truncate_count);
 	if (unlikely(!list_empty(&mapping->i_mmap)))
 		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
 	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
@@ -1390,8 +1392,10 @@ do_no_page(struct mm_struct *mm, struct=20
 	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
 {
 	struct page * new_page;
+	struct address_space *mapping;
 	pte_t entry;
 	struct pte_chain *pte_chain;
+	unsigned sequence;
 	int ret;
=20
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -1400,6 +1404,9 @@ do_no_page(struct mm_struct *mm, struct=20
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
=20
+	mapping =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+retry:
+	sequence =3D atomic_read(&mapping->truncate_count);
 	new_page =3D vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
=20
 	/* no page was available -- either SIGBUS or OOM */
@@ -1428,6 +1435,16 @@ do_no_page(struct mm_struct *mm, struct=20
 	}
=20
 	spin_lock(&mm->page_table_lock);
+	/*
+	 * For a file-backed vma, someone could have truncated or otherwise
+	 * invalidated this page.  If invalidate_mmap_range got called,
+	 * retry getting the page.
+	 */
+	if (unlikely(sequence !=3D atomic_read(&mapping->truncate_count))) {
+		spin_unlock(&mm->page_table_lock);
+		page_cache_release(new_page);
+		goto retry;
+	}
 	page_table =3D pte_offset_map(pmd, address);
=20
 	/*

--==========2142667794==========--

