Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbULOPda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbULOPda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbULOPda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:33:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38370 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262360AbULOPdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:33:07 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix nommu MAP_SHARED handling
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Wed, 15 Dec 2004 15:32:52 +0000
Message-ID: <2149.1103124772@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch does the following things:

 (1) It uniquifies permitted overlapping VMAs (eg: MAP_SHARED on chardevs) in
     nommu_vma_tree. Identical entries break the assumptions on which rbtrees
     work. Since we don't need to share VMAs in this case, we uniquify such
     VMAs by using the pointer to the VMA. They're only kept in the tree for
     /proc/maps visibility.

 (2) Extracts VMA unlinking into its own function so that the source is
     adjacent to the VMA linking function.

 (3) No longer releases memory belonging to a shared chardev or file (the
     underlying driver is expected to provide mappable memory).

 (4) Frees the file attached to a VMA whether or not that VMA is shared or is
     a memory-mapped I/O mapping.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog1>diffstat nommu-rb-2610rc3.diff 
 nommu.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 50 insertions(+), 16 deletions(-)

diff -uNrp linux-2.6.10-rc3-mm1-base/mm/nommu.c linux-2.6.10-rc3-mm1-nommu-rb/mm/nommu.c
--- linux-2.6.10-rc3-mm1-base/mm/nommu.c	2004-12-13 17:34:22.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-rb/mm/nommu.c	2004-12-15 14:32:07.000000000 +0000
@@ -315,25 +315,51 @@ static inline struct vm_area_struct *fin
 static void add_nommu_vma(struct vm_area_struct *vma)
 {
 	struct vm_area_struct *pvma;
+	struct address_space *mapping;
 	struct rb_node **p = &nommu_vma_tree.rb_node;
 	struct rb_node *parent = NULL;
 
+	/* add the VMA to the master list */
 	while (*p) {
 		parent = *p;
 		pvma = rb_entry(parent, struct vm_area_struct, vm_rb);
 
-		if (vma->vm_start < pvma->vm_start)
+		if (vma->vm_start < pvma->vm_start) {
 			p = &(*p)->rb_left;
-		else if (vma->vm_start > pvma->vm_start)
+		}
+		else if (vma->vm_start > pvma->vm_start) {
 			p = &(*p)->rb_right;
-		else
-			BUG(); /* shouldn't happen by this point */
+		}
+		else {
+			/* mappings are at the same address - this can only
+			 * happen for shared-mem chardevs and shared file
+			 * mappings backed by ramfs/tmpfs */
+			BUG_ON(!(pvma->vm_flags & VM_SHARED));
+
+			if (vma < pvma)
+				p = &(*p)->rb_left;
+			else if (vma > pvma)
+				p = &(*p)->rb_right;
+			else
+				BUG();
+		}
 	}
 
 	rb_link_node(&vma->vm_rb, parent, p);
 	rb_insert_color(&vma->vm_rb, &nommu_vma_tree);
 }
 
+static void delete_nommu_vma(struct vm_area_struct *vma)
+{
+	struct address_space *mapping;
+
+	/* remove from the master list */
+	rb_erase(&vma->vm_rb, &nommu_vma_tree);
+}
+
+/*
+ * handle mapping creation for uClinux
+ */
 unsigned long do_mmap_pgoff(struct file *file,
 			    unsigned long addr,
 			    unsigned long len,
@@ -633,27 +659,33 @@ unsigned long do_mmap_pgoff(struct file 
 	return -ENOMEM;
 }
 
+/*
+ * handle mapping disposal for uClinux
+ */
 static void put_vma(struct vm_area_struct *vma)
 {
 	if (vma) {
 		down_write(&nommu_vma_sem);
 
 		if (atomic_dec_and_test(&vma->vm_usage)) {
-			rb_erase(&vma->vm_rb, &nommu_vma_tree);
+			delete_nommu_vma(vma);
 
 			if (vma->vm_ops && vma->vm_ops->close)
 				vma->vm_ops->close(vma);
 
-			if (!(vma->vm_flags & VM_IO) && vma->vm_start) {
+			/* IO memory and memory shared directly out of the pagecache from
+			 * ramfs/tmpfs mustn't be released here */
+			if (!(vma->vm_flags & (VM_IO | VM_SHARED)) && vma->vm_start) {
 				realalloc -= kobjsize((void *) vma->vm_start);
 				askedalloc -= vma->vm_end - vma->vm_start;
-				if (vma->vm_file)
-					fput(vma->vm_file);
 				kfree((void *) vma->vm_start);
 			}
 
 			realalloc -= kobjsize(vma);
 			askedalloc -= sizeof(*vma);
+
+			if (vma->vm_file)
+				fput(vma->vm_file);
 			kfree(vma);
 		}
 
@@ -664,6 +696,7 @@ static void put_vma(struct vm_area_struc
 int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
 {
 	struct vm_list_struct *vml, **parent;
+	unsigned long end = addr + len;
 
 #ifdef MAGIC_ROM_PTR
 	/* For efficiency's sake, if the pointer is obviously in ROM,
@@ -677,15 +710,16 @@ int do_munmap(struct mm_struct *mm, unsi
 #endif
 
 	for (parent = &mm->context.vmlist; *parent; parent = &(*parent)->next)
-		if ((*parent)->vma->vm_start == addr)
-			break;
-	vml = *parent;
+		if ((*parent)->vma->vm_start == addr &&
+		    (*parent)->vma->vm_end == end)
+			goto found;
 
-	if (!vml) {
-		printk("munmap of non-mmaped memory by process %d (%s): %p\n",
-		       current->pid, current->comm, (void *) addr);
-		return -EINVAL;
-	}
+	printk("munmap of non-mmaped memory by process %d (%s): %p\n",
+	       current->pid, current->comm, (void *) addr);
+	return -EINVAL;
+
+ found:
+	vml = *parent;
 
 	put_vma(vml->vma);
 
