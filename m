Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSJQX54>; Thu, 17 Oct 2002 19:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262797AbSJQX54>; Thu, 17 Oct 2002 19:57:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5556 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262528AbSJQX5y>; Thu, 17 Oct 2002 19:57:54 -0400
Date: Fri, 18 Oct 2002 01:04:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 9/9 Ingo's shmem_populate
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180102050.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instate Ingo's shmem_populate on top of the previous patches, now using
shmem_getpage(,,,SGP_QUICK) for the nonblocking case (its find_lock_page
may block, but rarely for long).  Note install_page will need redefining
if PAGE_CACHE_SIZE departs from PAGE_SIZE; note pgoff to populate must
be in terms of PAGE_SIZE; note page_cache_release if install_page fails.

filemap_populate similarly needs page_cache_release when install_page
fails, but filemap.c not included in this patch since we started out
from 2.5.43 rather than 2.5.43-mm2: whereas patches 1-8 could go
directly to 2.5.43, this 9/9 belongs with Ingo's population work.

--- tmpfs8/mm/shmem.c	Thu Oct 17 22:01:59 2002
+++ tmpfs9/mm/shmem.c	Thu Oct 17 22:02:09 2002
@@ -53,6 +53,7 @@
 
 /* Flag allocation requirements to shmem_getpage and shmem_swp_alloc */
 enum sgp_type {
+	SGP_QUICK,	/* don't try more than file page cache lookup */
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate page */
@@ -757,6 +758,8 @@
 	if (filepage && PageUptodate(filepage))
 		goto done;
 	error = 0;
+	if (sgp == SGP_QUICK)
+		goto failed;
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
@@ -949,6 +952,42 @@
 	return page;
 }
 
+static int shmem_populate(struct vm_area_struct *vma,
+	unsigned long addr, unsigned long len,
+	unsigned long prot, unsigned long pgoff, int nonblock)
+{
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	struct mm_struct *mm = vma->vm_mm;
+	enum sgp_type sgp = nonblock? SGP_QUICK: SGP_CACHE;
+	unsigned long size;
+
+	size = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (pgoff >= size || pgoff + (len >> PAGE_SHIFT) > size)
+		return -EINVAL;
+	
+	while ((long) len > 0) {
+		struct page *page = NULL;
+		int err;
+		/*
+		 * Will need changing if PAGE_CACHE_SIZE != PAGE_SIZE
+		 */
+		err = shmem_getpage(inode, pgoff, &page, sgp);
+		if (err)
+			return err;
+		if (page) {
+			err = install_page(mm, vma, addr, page, prot);
+			if (err) {
+				page_cache_release(page);
+				return err;
+			}
+		}
+		len -= PAGE_SIZE;
+		addr += PAGE_SIZE;
+		pgoff++;
+	}
+	return 0;
+}
+
 void shmem_lock(struct file *file, int lock)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -1829,6 +1868,7 @@
 
 static struct vm_operations_struct shmem_vm_ops = {
 	.nopage		= shmem_nopage,
+	.populate	= shmem_populate,
 };
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,

