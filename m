Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbULOPiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbULOPiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbULOPiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:38:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262363AbULOPil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:38:41 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2149.1103124772@redhat.com> 
References: <2149.1103124772@redhat.com> 
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix nommu MAP_SHARED handling 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Wed, 15 Dec 2004 15:38:36 +0000
Message-ID: <2272.1103125116@redhat.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch includes prio-tree support and adds cross-referencing of
VMAs with address spaces back in, as is done under normal MMU Linux.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat nommu-prio-2610rc3.diff 
 Makefile |    4 ++--
 nommu.c  |   22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff -uNrp linux-2.6.10-rc3-mm1-nommu-rb/mm/Makefile linux-2.6.10-rc3-mm1-nommu-prio/mm/Makefile
--- linux-2.6.10-rc3-mm1-nommu-rb/mm/Makefile	2004-12-13 17:34:22.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-prio/mm/Makefile	2004-12-15 13:38:04.000000000 +0000
@@ -5,12 +5,12 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o prio_tree.o
+			   vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
-			   $(mmu-y)
+			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
diff -uNrp linux-2.6.10-rc3-mm1-nommu-rb/mm/nommu.c linux-2.6.10-rc3-mm1-nommu-prio/mm/nommu.c
--- linux-2.6.10-rc3-mm1-nommu-rb/mm/nommu.c	2004-12-15 14:32:07.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-prio/mm/nommu.c	2004-12-15 13:38:04.000000000 +0000
@@ -48,10 +48,6 @@ DECLARE_RWSEM(nommu_vma_sem);
 struct vm_operations_struct generic_file_vm_ops = {
 };
 
-void __init prio_tree_init(void)
-{
-}
-
 /*
  * Handle all mappings that got truncated by a "truncate()"
  * system call.
@@ -319,6 +315,15 @@ static void add_nommu_vma(struct vm_area
 	struct rb_node **p = &nommu_vma_tree.rb_node;
 	struct rb_node *parent = NULL;
 
+	/* add the VMA to the mapping */
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+
+		flush_dcache_mmap_lock(mapping);
+		vma_prio_tree_insert(vma, &mapping->i_mmap);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
 	/* add the VMA to the master list */
 	while (*p) {
 		parent = *p;
@@ -353,6 +358,15 @@ static void delete_nommu_vma(struct vm_a
 {
 	struct address_space *mapping;
 
+	/* remove the VMA from the mapping */
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+
+		flush_dcache_mmap_lock(mapping);
+		vma_prio_tree_remove(vma, &mapping->i_mmap);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
 	/* remove from the master list */
 	rb_erase(&vma->vm_rb, &nommu_vma_tree);
 }
