Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbSLSJme>; Thu, 19 Dec 2002 04:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267589AbSLSJme>; Thu, 19 Dec 2002 04:42:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:62426 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267582AbSLSJmc>;
	Thu, 19 Dec 2002 04:42:32 -0500
Message-ID: <3E019654.FC8B3FEC@digeo.com>
Date: Thu, 19 Dec 2002 01:50:12 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
References: <3E015ECE.9E3BD19@digeo.com> <3E01943B.4170B911@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 09:50:27.0172 (UTC) FILETIME=[0F09F240:01C2A744]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Andrew Morton wrote:
> >
> > ...
> > slab-poisoning.patch
> >   more informative slab poisoning
> 
> This patch has exposed a quite long-standing use-after-free bug in
> mremap().  It make the machine go BUG when starting the X server if
> memory debugging is turned on.
> 
> The bug might be present in 2.4 as well..

here's a 2.4 patch:




move_vma() calls do_munmap() and then uses the memory at *new_vma.

But when starting X11 it just happens that the memory which do_munmap
unmapped had the same start address and the range at *new_vma.  So
new_vma is freed by do_munmap().

This was never noticed before because (vm_flags & VM_LOCKED) evaluates
false when vm_flags is 0x5a5a5a5a.  But I just changed that to
0x6b6b6b6b and we call make_pages_present() with start == end ==
0x6b6b6b6b and it goes BUG.

The fix is for move_vma() to not inspect the values of any vma's after
it has called do_munmap().

The patch does that, for `vma' and `new_vma'.

It also removes three redundant tests of !vma->vm_file.  can_vma_merge()
already tested that.


 mm/mremap.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

--- 24/mm/mremap.c~move_vma-use-after-free	Thu Dec 19 01:29:52 2002
+++ 24-akpm/mm/mremap.c	Thu Dec 19 01:31:43 2002
@@ -134,14 +134,16 @@ static inline unsigned long move_vma(str
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
@@ -151,7 +153,8 @@ static inline unsigned long move_vma(str
 				kmem_cache_free(vm_area_cachep, next);
 			}
 		} else if (next->vm_start == new_addr + new_len &&
-			   can_vma_merge(next, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+					can_vma_merge(next, vma->vm_flags) &&
+					!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			next->vm_start = new_addr;
 			spin_unlock(&mm->page_table_lock);
@@ -160,7 +163,8 @@ static inline unsigned long move_vma(str
 	} else {
 		prev = find_vma(mm, new_addr-1);
 		if (prev && prev->vm_end == new_addr &&
-		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+				can_vma_merge(prev, vma->vm_flags) &&
+				!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			prev->vm_end = new_addr + new_len;
 			spin_unlock(&mm->page_table_lock);
@@ -177,11 +181,15 @@ static inline unsigned long move_vma(str
 	}
 
 	if (!move_page_tables(current->mm, new_addr, addr, old_len)) {
+		unsigned long must_fault_in;
+		unsigned long fault_in_start;
+		unsigned long fault_in_end;
+
 		if (allocated_vma) {
 			*new_vma = *vma;
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
-			new_vma->vm_pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
+			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
 			new_vma->vm_raend = 0;
 			if (new_vma->vm_file)
 				get_file(new_vma->vm_file);
@@ -189,12 +197,19 @@ static inline unsigned long move_vma(str
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
+
+		must_fault_in = new_vma->vm_flags & VM_LOCKED;
+		fault_in_start = new_vma->vm_start;
+		fault_in_end = new_vma->vm_end;
+
 		do_munmap(current->mm, addr, old_len);
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
