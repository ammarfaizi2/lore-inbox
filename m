Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319625AbSH2X3x>; Thu, 29 Aug 2002 19:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319626AbSH2X3w>; Thu, 29 Aug 2002 19:29:52 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:2044 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319625AbSH2X3u>; Thu, 29 Aug 2002 19:29:50 -0400
Date: Thu, 29 Aug 2002 19:34:13 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-mm@kvack.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: weirdness with ->mm vs ->active_mm handling
Message-ID: <20020829193413.H17288@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In trying to track down a bug, I found routines like generic_file_read 
getting called with current->mm == NULL.  This seems to be a valid state 
for lazy tlb tasks, but the code throughout the kernel doesn't seem to 
assume that.  For starters, I suspect that the fault handling path in 
arch/i386/mm/fault.c should probably be using ->active_mm, or else the 
corrent page tables will not get updated on a vmalloc fault in some cases.  
I'm surprised nobody has encountered this before, hence I'd like comments 
on the below (untested) approach of starting to convert ->mm users into 
using ->active_mm.  As a benefit, we should be able to safely eliminate 
the if (mm) check in find_vma once all the stragglers are caught.

		-ben

:r ~/patches/v2.5/v2.5.32-active_mm.diff
diff -urN v2.5.32/arch/i386/mm/fault.c active_mm-v2.5.32/arch/i386/mm/fault.c
--- v2.5.32/arch/i386/mm/fault.c	Tue Aug 27 16:00:08 2002
+++ active_mm-v2.5.32/arch/i386/mm/fault.c	Thu Aug 29 19:27:17 2002
@@ -35,13 +35,14 @@
  */
 int __verify_write(const void * addr, unsigned long size)
 {
+	struct mm_struct *mm = current->active_mm;
 	struct vm_area_struct * vma;
 	unsigned long start = (unsigned long) addr;
 
 	if (!size)
 		return 1;
 
-	vma = find_vma(current->mm, start);
+	vma = find_vma(mm, start);
 	if (!vma)
 		goto bad_area;
 	if (vma->vm_start > start)
@@ -57,7 +58,7 @@
 
 	for (;;) {
 	survive:
-		switch (handle_mm_fault(current->mm, vma, start, 1)) {
+		switch (handle_mm_fault(mm, vma, start, 1)) {
 			case VM_FAULT_SIGBUS:
 				goto bad_area;
 			case VM_FAULT_OOM:
@@ -177,7 +178,7 @@
 	if (address >= TASK_SIZE && !(error_code & 5))
 		goto vmalloc_fault;
 
-	mm = tsk->mm;
+	mm = tsk->active_mm;
 	info.si_code = SEGV_MAPERR;
 
 	/*
diff -urN v2.5.32/mm/mmap.c active_mm-v2.5.32/mm/mmap.c
--- v2.5.32/mm/mmap.c	Tue Aug 20 19:22:36 2002
+++ active_mm-v2.5.32/mm/mmap.c	Thu Aug 29 19:28:02 2002
@@ -693,32 +693,30 @@
 {
 	struct vm_area_struct *vma = NULL;
 
-	if (mm) {
-		/* Check the cache first. */
-		/* (Cache hit rate is typically around 35%.) */
-		vma = mm->mmap_cache;
-		if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
-			rb_node_t * rb_node;
+	/* Check the cache first. */
+	/* (Cache hit rate is typically around 35%.) */
+	vma = mm->mmap_cache;
+	if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
+		rb_node_t * rb_node;
 
-			rb_node = mm->mm_rb.rb_node;
-			vma = NULL;
+		rb_node = mm->mm_rb.rb_node;
+		vma = NULL;
 
-			while (rb_node) {
-				struct vm_area_struct * vma_tmp;
+		while (rb_node) {
+			struct vm_area_struct * vma_tmp;
 
-				vma_tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
+			vma_tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
 
-				if (vma_tmp->vm_end > addr) {
-					vma = vma_tmp;
-					if (vma_tmp->vm_start <= addr)
-						break;
-					rb_node = rb_node->rb_left;
-				} else
-					rb_node = rb_node->rb_right;
-			}
-			if (vma)
-				mm->mmap_cache = vma;
+			if (vma_tmp->vm_end > addr) {
+				vma = vma_tmp;
+				if (vma_tmp->vm_start <= addr)
+					break;
+				rb_node = rb_node->rb_left;
+			} else
+				rb_node = rb_node->rb_right;
 		}
+		if (vma)
+			mm->mmap_cache = vma;
 	}
 	return vma;
 }
