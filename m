Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbSLSJdW>; Thu, 19 Dec 2002 04:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbSLSJdW>; Thu, 19 Dec 2002 04:33:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:42970 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267581AbSLSJdU>;
	Thu, 19 Dec 2002 04:33:20 -0500
Message-ID: <3E01943B.4170B911@digeo.com>
Date: Thu, 19 Dec 2002 01:41:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
References: <3E015ECE.9E3BD19@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 09:41:15.0679 (UTC) FILETIME=[C652CAF0:01C2A742]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> slab-poisoning.patch
>   more informative slab poisoning

This patch has exposed a quite long-standing use-after-free bug in
mremap().  It make the machine go BUG when starting the X server if
memory debugging is turned on.

The bug might be present in 2.4 as well..


--- 25/mm/mremap.c~move_vma-use-after-free	Thu Dec 19 00:51:49 2002
+++ 25-akpm/mm/mremap.c	Thu Dec 19 01:08:45 2002
@@ -183,14 +183,16 @@ static unsigned long move_vma(struct vm_
 	next = find_vma_prev(mm, new_addr, &prev);
 	if (next) {
 		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+				can_vma_merge(prev, vma->vm_flags) &&
+				!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			prev->vm_end = new_addr + new_len;
 			spin_unlock(&mm->page_table_lock);
 			new_vma = prev;
 			if (next != prev->vm_next)
 				BUG();
-			if (prev->vm_end == next->vm_start && can_vma_merge(next, prev->vm_flags)) {
+			if (prev->vm_end == next->vm_start &&
+					can_vma_merge(next, prev->vm_flags)) {
 				spin_lock(&mm->page_table_lock);
 				prev->vm_end = next->vm_end;
 				__vma_unlink(mm, next, prev);
@@ -201,7 +203,8 @@ static unsigned long move_vma(struct vm_
 				kmem_cache_free(vm_area_cachep, next);
 			}
 		} else if (next->vm_start == new_addr + new_len &&
-			   can_vma_merge(next, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+					can_vma_merge(next, vma->vm_flags) &&
+					!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			next->vm_start = new_addr;
 			spin_unlock(&mm->page_table_lock);
@@ -210,7 +213,8 @@ static unsigned long move_vma(struct vm_
 	} else {
 		prev = find_vma(mm, new_addr-1);
 		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+				can_vma_merge(prev, vma->vm_flags) &&
+				!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			prev->vm_end = new_addr + new_len;
 			spin_unlock(&mm->page_table_lock);
@@ -227,12 +231,16 @@ static unsigned long move_vma(struct vm_
 	}
 
 	if (!move_page_tables(vma, new_addr, addr, old_len)) {
+		unsigned long must_fault_in;
+		unsigned long fault_in_start;
+		unsigned long fault_in_end;
+
 		if (allocated_vma) {
 			*new_vma = *vma;
 			INIT_LIST_HEAD(&new_vma->shared);
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
-			new_vma->vm_pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
+			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
 			if (new_vma->vm_file)
 				get_file(new_vma->vm_file);
 			if (new_vma->vm_ops && new_vma->vm_ops->open)
@@ -251,19 +259,25 @@ static unsigned long move_vma(struct vm_
 		} else
 			vma = NULL;		/* nothing more to do */
 
-		do_munmap(current->mm, addr, old_len);
-
 		/* Restore VM_ACCOUNT if one or two pieces of vma left */
 		if (vma) {
 			vma->vm_flags |= VM_ACCOUNT;
 			if (split)
 				vma->vm_next->vm_flags |= VM_ACCOUNT;
 		}
+
+		must_fault_in = new_vma->vm_flags & VM_LOCKED;
+		fault_in_start = new_vma->vm_start;
+		fault_in_end = new_vma->vm_end;
+
+		do_munmap(current->mm, addr, old_len);
+
+		/* new_vma could have been invalidated by do_munmap */
+
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
-		if (new_vma->vm_flags & VM_LOCKED) {
+		if (must_fault_in) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
-			make_pages_present(new_vma->vm_start,
-					   new_vma->vm_end);
+			make_pages_present(fault_in_start, fault_in_end);
 		}
 		return new_addr;
 	}

_
