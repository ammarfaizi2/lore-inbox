Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbQKJG71>; Fri, 10 Nov 2000 01:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbQKJG7R>; Fri, 10 Nov 2000 01:59:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60545 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129834AbQKJG7G>;
	Fri, 10 Nov 2000 01:59:06 -0500
Date: Thu, 9 Nov 2000 22:44:18 -0800
Message-Id: <200011100644.WAA24097@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: bsuparna@in.ibm.com
CC: aviro@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <CA256992.004406D2.00@d73mta05.au.ibm.com> (bsuparna@in.ibm.com)
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting
	 hierarchies ?
In-Reply-To: <CA256992.004406D2.00@d73mta05.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bsuparna@in.ibm.com
   Date: 	Thu, 9 Nov 2000 17:46:53 +0530

     I was looking into the vmm code and trying to work out exactly
   how to fix this

Let me save you some time, below is the fix I sent to
Linus this evening:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/linux/mm.h linux/include/linux/mm.h
--- vanilla/linux/include/linux/mm.h	Thu Nov  9 21:43:46 2000
+++ linux/include/linux/mm.h	Thu Nov  9 20:16:04 2000
@@ -417,8 +417,11 @@
 extern void swapin_readahead(swp_entry_t);
 
 /* mmap.c */
+extern void lock_vma_mappings(struct vm_area_struct *);
+extern void unlock_vma_mappings(struct vm_area_struct *);
 extern void merge_segments(struct mm_struct *, unsigned long, unsigned long);
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
+extern void __insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void build_mmap_avl(struct mm_struct *);
 extern void exit_mmap(struct mm_struct *);
 extern unsigned long get_unmapped_area(unsigned long, unsigned long);
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/filemap.c linux/mm/filemap.c
--- vanilla/linux/mm/filemap.c	Thu Nov  9 21:43:46 2000
+++ linux/mm/filemap.c	Thu Nov  9 20:08:24 2000
@@ -1813,11 +1813,13 @@
 	get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = end;
-	insert_vm_struct(current->mm, n);
+	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
@@ -1837,10 +1839,12 @@
 	get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_end = start;
-	insert_vm_struct(current->mm, n);
+	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
@@ -1870,15 +1874,17 @@
 		vma->vm_ops->open(left);
 		vma->vm_ops->open(right);
 	}
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = start;
 	vma->vm_end = end;
 	setup_read_behavior(vma, behavior);
 	vma->vm_raend = 0;
-	insert_vm_struct(current->mm, left);
-	insert_vm_struct(current->mm, right);
+	__insert_vm_struct(current->mm, left);
+	__insert_vm_struct(current->mm, right);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/mlock.c linux/mm/mlock.c
--- vanilla/linux/mm/mlock.c	Fri Oct 13 12:10:30 2000
+++ linux/mm/mlock.c	Thu Nov  9 17:47:00 2000
@@ -36,11 +36,13 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = end;
-	insert_vm_struct(current->mm, n);
+	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
@@ -61,10 +63,12 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_end = start;
-	insert_vm_struct(current->mm, n);
+	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
@@ -96,15 +100,17 @@
 		vma->vm_ops->open(left);
 		vma->vm_ops->open(right);
 	}
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_flags = newflags;
 	vma->vm_raend = 0;
-	insert_vm_struct(current->mm, left);
-	insert_vm_struct(current->mm, right);
+	__insert_vm_struct(current->mm, left);
+	__insert_vm_struct(current->mm, right);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/mmap.c linux/mm/mmap.c
--- vanilla/linux/mm/mmap.c	Fri Oct 13 12:10:30 2000
+++ linux/mm/mmap.c	Thu Nov  9 17:53:02 2000
@@ -67,7 +67,7 @@
 }
 
 /* Remove one vm structure from the inode's i_mapping address space. */
-static inline void remove_shared_vm_struct(struct vm_area_struct *vma)
+static inline void __remove_shared_vm_struct(struct vm_area_struct *vma)
 {
 	struct file * file = vma->vm_file;
 
@@ -75,14 +75,41 @@
 		struct inode *inode = file->f_dentry->d_inode;
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_inc(&inode->i_writecount);
-		spin_lock(&inode->i_mapping->i_shared_lock);
 		if(vma->vm_next_share)
 			vma->vm_next_share->vm_pprev_share = vma->vm_pprev_share;
 		*vma->vm_pprev_share = vma->vm_next_share;
-		spin_unlock(&inode->i_mapping->i_shared_lock);
 	}
 }
 
+static inline void remove_shared_vm_struct(struct vm_area_struct *vma)
+{
+	lock_vma_mappings(vma);
+	__remove_shared_vm_struct(vma);
+	unlock_vma_mappings(vma);
+}
+
+void lock_vma_mappings(struct vm_area_struct *vma)
+{
+	struct address_space *mapping;
+
+	mapping = NULL;
+	if (vma->vm_file)
+		mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	if (mapping)
+		spin_lock(&mapping->i_shared_lock);
+}
+
+void unlock_vma_mappings(struct vm_area_struct *vma)
+{
+	struct address_space *mapping;
+
+	mapping = NULL;
+	if (vma->vm_file)
+		mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	if (mapping)
+		spin_unlock(&mapping->i_shared_lock);
+}
+
 /*
  *  sys_brk() for the most part doesn't need the global kernel
  *  lock, except when an application is doing something nasty
@@ -316,13 +343,22 @@
 	 * after the call.  Save the values we need now ...
 	 */
 	flags = vma->vm_flags;
-	addr = vma->vm_start; /* can addr have changed?? */
+
+	/* Can addr have changed??
+	 *
+	 * Answer: Yes, several device drivers can do it in their
+	 *         f_op->mmap method. -DaveM
+	 */
+	addr = vma->vm_start;
+
+	lock_vma_mappings(vma);
 	spin_lock(&mm->page_table_lock);
-	insert_vm_struct(mm, vma);
+	__insert_vm_struct(mm, vma);
 	if (correct_wcount)
 		atomic_inc(&file->f_dentry->d_inode->i_writecount);
 	merge_segments(mm, vma->vm_start, vma->vm_end);
 	spin_unlock(&mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED) {
@@ -534,10 +570,12 @@
 	/* Work out to one of the ends. */
 	if (end == area->vm_end) {
 		area->vm_end = addr;
+		lock_vma_mappings(area);
 		spin_lock(&mm->page_table_lock);
 	} else if (addr == area->vm_start) {
 		area->vm_pgoff += (end - area->vm_start) >> PAGE_SHIFT;
 		area->vm_start = end;
+		lock_vma_mappings(area);
 		spin_lock(&mm->page_table_lock);
 	} else {
 	/* Unmapping a hole: area->vm_start < addr <= end < area->vm_end */
@@ -560,12 +598,18 @@
 		if (mpnt->vm_ops && mpnt->vm_ops->open)
 			mpnt->vm_ops->open(mpnt);
 		area->vm_end = addr;	/* Truncate area */
+
+		/* Because mpnt->vm_file == area->vm_file this locks
+		 * things correctly.
+		 */
+		lock_vma_mappings(area);
 		spin_lock(&mm->page_table_lock);
-		insert_vm_struct(mm, mpnt);
+		__insert_vm_struct(mm, mpnt);
 	}
 
-	insert_vm_struct(mm, area);
+	__insert_vm_struct(mm, area);
 	spin_unlock(&mm->page_table_lock);
+	unlock_vma_mappings(area);
 	return extra;
 }
 
@@ -811,10 +855,12 @@
 	flags = vma->vm_flags;
 	addr = vma->vm_start;
 
+	lock_vma_mappings(vma);
 	spin_lock(&mm->page_table_lock);
-	insert_vm_struct(mm, vma);
+	__insert_vm_struct(mm, vma);
 	merge_segments(mm, vma->vm_start, vma->vm_end);
 	spin_unlock(&mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED) {
@@ -877,9 +923,10 @@
 }
 
 /* Insert vm structure into process list sorted by address
- * and into the inode's i_mmap ring.
+ * and into the inode's i_mmap ring.  If vm_file is non-NULL
+ * then the i_shared_lock must be held here.
  */
-void insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vmp)
+void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vmp)
 {
 	struct vm_area_struct **pprev;
 	struct file * file;
@@ -916,15 +963,20 @@
 			head = &mapping->i_mmap_shared;
       
 		/* insert vmp into inode's share list */
-		spin_lock(&mapping->i_shared_lock);
 		if((vmp->vm_next_share = *head) != NULL)
 			(*head)->vm_pprev_share = &vmp->vm_next_share;
 		*head = vmp;
 		vmp->vm_pprev_share = head;
-		spin_unlock(&mapping->i_shared_lock);
 	}
 }
 
+void insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vmp)
+{
+	lock_vma_mappings(vmp);
+	__insert_vm_struct(mm, vmp);
+	unlock_vma_mappings(vmp);
+}
+
 /* Merge the list of memory segments if possible.
  * Redundant vm_area_structs are freed.
  * This assumes that the list is ordered by address.
@@ -986,11 +1038,13 @@
 			mpnt->vm_pgoff += (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 			mpnt->vm_start = mpnt->vm_end;
 			spin_unlock(&mm->page_table_lock);
+			unlock_vma_mappings(mpnt);
 			mpnt->vm_ops->close(mpnt);
+			lock_vma_mappings(mpnt);
 			spin_lock(&mm->page_table_lock);
 		}
 		mm->map_count--;
-		remove_shared_vm_struct(mpnt);
+		__remove_shared_vm_struct(mpnt);
 		if (mpnt->vm_file)
 			fput(mpnt->vm_file);
 		kmem_cache_free(vm_area_cachep, mpnt);
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/mprotect.c linux/mm/mprotect.c
--- vanilla/linux/mm/mprotect.c	Wed Oct 18 14:25:46 2000
+++ linux/mm/mprotect.c	Thu Nov  9 17:53:43 2000
@@ -118,11 +118,13 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = end;
-	insert_vm_struct(current->mm, n);
+	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
@@ -145,10 +147,12 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_end = start;
-	insert_vm_struct(current->mm, n);
+	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
@@ -179,6 +183,7 @@
 		vma->vm_ops->open(left);
 		vma->vm_ops->open(right);
 	}
+	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = start;
@@ -186,9 +191,10 @@
 	vma->vm_flags = newflags;
 	vma->vm_raend = 0;
 	vma->vm_page_prot = prot;
-	insert_vm_struct(current->mm, left);
-	insert_vm_struct(current->mm, right);
+	__insert_vm_struct(current->mm, left);
+	__insert_vm_struct(current->mm, right);
 	spin_unlock(&vma->vm_mm->page_table_lock);
+	unlock_vma_mappings(vma);
 	return 0;
 }
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/mremap.c linux/mm/mremap.c
--- vanilla/linux/mm/mremap.c	Wed Oct 18 14:25:46 2000
+++ linux/mm/mremap.c	Thu Nov  9 17:53:57 2000
@@ -141,10 +141,12 @@
 				get_file(new_vma->vm_file);
 			if (new_vma->vm_ops && new_vma->vm_ops->open)
 				new_vma->vm_ops->open(new_vma);
+			lock_vma_mappings(vma);
 			spin_lock(&current->mm->page_table_lock);
-			insert_vm_struct(current->mm, new_vma);
+			__insert_vm_struct(current->mm, new_vma);
 			merge_segments(current->mm, new_vma->vm_start, new_vma->vm_end);
 			spin_unlock(&current->mm->page_table_lock);
+			unlock_vma_mappings(vma);
 			do_munmap(current->mm, addr, old_len);
 			current->mm->total_vm += new_len >> PAGE_SHIFT;
 			if (new_vma->vm_flags & VM_LOCKED) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
