Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbTDBRHH>; Wed, 2 Apr 2003 12:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbTDBRHH>; Wed, 2 Apr 2003 12:07:07 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:35893 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261776AbTDBRHE>; Wed, 2 Apr 2003 12:07:04 -0500
Date: Wed, 02 Apr 2003 11:18:23 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-mm2] Optimizaction for object-based rmap
Message-ID: <9770000.1049303903@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========856700887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========856700887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


It occurred to me that a simple way to improve objrmap performance would be
to sort the vma chains off address_space by offset.  Here's a patch that
does it.  Tests show no measureable cost, and it could significantly reduce
the impact of the worst case scenario (100 mappings * 100 processes) we've
all worried about.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========856700887==========
Content-Type: text/plain; charset=us-ascii; name="objsort-2.5.66-mm2-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="objsort-2.5.66-mm2-1.diff";
 size=2893

--- 2.5.66-mm2-test/./mm/mmap.c	2003-04-01 11:23:35.000000000 -0600
+++ 2.5.66-mm2-fix/./mm/mmap.c	2003-04-01 11:25:31.000000000 -0600
@@ -311,14 +311,26 @@ static inline void __vma_link_file(struc
 	if (file) {
 		struct inode * inode = file->f_dentry->d_inode;
 		struct address_space *mapping = inode->i_mapping;
+		struct list_head *vmlist, *vmhead;
 
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&inode->i_writecount);
 
 		if (vma->vm_flags & VM_SHARED)
-			list_add_tail(&vma->shared, &mapping->i_mmap_shared);
+			vmhead = &mapping->i_mmap_shared;
 		else
-			list_add_tail(&vma->shared, &mapping->i_mmap);
+			vmhead = &mapping->i_mmap;
+
+		list_for_each(vmlist, &mapping->i_mmap_shared) {
+			struct vm_area_struct *vmtemp;
+			vmtemp = list_entry(vmlist, struct vm_area_struct, shared);
+			if (vmtemp->vm_pgoff >= vma->vm_pgoff)
+				break;
+		}
+		if (vmlist == vmhead)
+			list_add_tail(&vma->shared, vmlist);
+		else
+			list_add(&vma->shared, vmlist);
 	}
 }
 
--- 2.5.66-mm2-test/./mm/rmap.c	2003-04-01 14:09:26.000000000 -0600
+++ 2.5.66-mm2-fix/./mm/rmap.c	2003-04-01 11:30:21.000000000 -0600
@@ -207,12 +207,16 @@ page_referenced_obj(struct page *page)
 	if (down_trylock(&mapping->i_shared_sem))
 		return 1;
 	
-	list_for_each_entry(vma, &mapping->i_mmap, shared)
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
+			break;
 		referenced += page_referenced_obj_one(vma, page);
-
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
+	}
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
+			break;
 		referenced += page_referenced_obj_one(vma, page);
-
+	}
 	up(&mapping->i_shared_sem);
 
 	return referenced;
@@ -572,12 +576,16 @@ try_to_unmap_obj(struct page *page)
 		return ret;
 	
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
+			break;
 		ret = try_to_unmap_obj_one(vma, page);
 		if (ret == SWAP_FAIL || !page->pte.mapcount)
 			goto out;
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
+			break;
 		ret = try_to_unmap_obj_one(vma, page);
 		if (ret == SWAP_FAIL || !page->pte.mapcount)
 			goto out;
@@ -868,6 +876,8 @@ again:
 		index = NRPTE - index;
 
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
+			break;
 		pte = find_pte(vma, page, NULL);
 		if (pte) {
 			ptecount++;
@@ -886,6 +896,8 @@ again:
 		}
 	}
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
+			break;
 		pte = find_pte(vma, page, NULL);
 		if (pte) {
 			ptecount++;

--==========856700887==========--

