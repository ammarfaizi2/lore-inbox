Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbULES6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbULES6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbULES6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:58:20 -0500
Received: from mailfe08.swip.net ([212.247.154.225]:62459 "EHLO
	mailfe08.swip.net") by vger.kernel.org with ESMTP id S261350AbULES6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:58:04 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: [PATCH] Make msync update atime and possibly ctime/mtime
From: Alexander Nyberg <alexn@dsv.su.se>
To: andrea@novell.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 05 Dec 2004 19:57:49 +0100
Message-Id: <1102273070.725.170.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an issue that doing the sequence of
open; mmap; change file; possibly msync; munmap; close; 

I know this is still a problem if the user doesn't do msync,
but I have not yet figured out a good way to do it without msync.
This should help us a bit on the way.

http://www.opengroup.org/onlinepubs/007908799/xsh/msync.html says that:
"If msync() causes any write to a file, the file's st_ctime and 
st_mtime fields are marked for update."

I think it makes a good time to update the atime of the file
aswell as it won't get done anywhere else.



Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== mm/msync.c 1.19 vs edited =====
--- 1.19/mm/msync.c	2004-10-19 07:26:38 +02:00
+++ edited/mm/msync.c	2004-12-04 22:48:54 +01:00
@@ -27,15 +27,16 @@ static int filemap_sync_pte(pte_t *ptep,
 	pte_t pte = *ptep;
 	unsigned long pfn = pte_pfn(pte);
 	struct page *page;
+	int dirty = 0;
 
 	if (pte_present(pte) && pfn_valid(pfn)) {
 		page = pfn_to_page(pfn);
 		if (!PageReserved(page) &&
-		    (ptep_clear_flush_dirty(vma, address, ptep) ||
+		    ((dirty = ptep_clear_flush_dirty(vma, address, ptep)) ||
 		     page_test_and_clear_dirty(page)))
 			set_page_dirty(page);
 	}
-	return 0;
+	return dirty;
 }
 
 static int filemap_sync_pte_range(pmd_t * pmd,
@@ -43,7 +44,7 @@ static int filemap_sync_pte_range(pmd_t 
 	struct vm_area_struct *vma, unsigned int flags)
 {
 	pte_t *pte;
-	int error;
+	int dirty = 0;
 
 	if (pmd_none(*pmd))
 		return 0;
@@ -55,16 +56,16 @@ static int filemap_sync_pte_range(pmd_t 
 	pte = pte_offset_map(pmd, address);
 	if ((address & PMD_MASK) != (end & PMD_MASK))
 		end = (address & PMD_MASK) + PMD_SIZE;
-	error = 0;
+
 	do {
-		error |= filemap_sync_pte(pte, vma, address, flags);
+		dirty |= filemap_sync_pte(pte, vma, address, flags);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
 
 	pte_unmap(pte - 1);
 
-	return error;
+	return dirty;
 }
 
 static inline int filemap_sync_pmd_range(pgd_t * pgd,
@@ -72,7 +73,7 @@ static inline int filemap_sync_pmd_range
 	struct vm_area_struct *vma, unsigned int flags)
 {
 	pmd_t * pmd;
-	int error;
+	int dirty = 0;
 
 	if (pgd_none(*pgd))
 		return 0;
@@ -84,13 +85,13 @@ static inline int filemap_sync_pmd_range
 	pmd = pmd_offset(pgd, address);
 	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
 		end = (address & PGDIR_MASK) + PGDIR_SIZE;
-	error = 0;
+
 	do {
-		error |= filemap_sync_pte_range(pmd, address, end, vma, flags);
+		dirty |= filemap_sync_pte_range(pmd, address, end, vma, flags);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
-	return error;
+	return dirty;
 }
 
 static int filemap_sync(struct vm_area_struct * vma, unsigned long address,
@@ -98,7 +99,7 @@ static int filemap_sync(struct vm_area_s
 {
 	pgd_t * dir;
 	unsigned long end = address + size;
-	int error = 0;
+	int dirty = 0;
 
 	/* Aquire the lock early; it may be possible to avoid dropping
 	 * and reaquiring it repeatedly.
@@ -117,7 +118,7 @@ static int filemap_sync(struct vm_area_s
 	if (address >= end)
 		BUG();
 	do {
-		error |= filemap_sync_pmd_range(dir, address, end, vma, flags);
+		dirty |= filemap_sync_pmd_range(dir, address, end, vma, flags);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -129,7 +130,7 @@ static int filemap_sync(struct vm_area_s
  out:
 	spin_unlock(&vma->vm_mm->page_table_lock);
 
-	return error;
+	return dirty;
 }
 
 /*
@@ -146,17 +147,17 @@ static int filemap_sync(struct vm_area_s
 static int msync_interval(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, int flags)
 {
-	int ret = 0;
+	int dirty, ret = 0;
 	struct file * file = vma->vm_file;
 
 	if ((flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED))
 		return -EBUSY;
 
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		ret = filemap_sync(vma, start, end-start, flags);
+		struct address_space *mapping = file->f_mapping;
+		dirty = filemap_sync(vma, start, end-start, flags);
 
-		if (!ret && (flags & MS_SYNC)) {
-			struct address_space *mapping = file->f_mapping;
+		if (flags & MS_SYNC) {
 			int err;
 
 			down(&mapping->host->i_sem);
@@ -171,6 +172,11 @@ static int msync_interval(struct vm_area
 				ret = err;
 			up(&mapping->host->i_sem);
 		}
+		
+		/* only update ctime & mtime if file actually changed */
+		if (dirty)
+			inode_update_time(mapping->host, 1);
+		update_atime(mapping->host);
 	}
 	return ret;
 }


