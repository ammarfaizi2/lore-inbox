Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWEMON0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWEMON0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWEMON0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:13:26 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:48232 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932420AbWEMONZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:13:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=NKKdcHW1A58qPTzHLrq0oEOz7hiqoxFg40tMcioNpNXYlf50aoQ6vps12rRMa6k+6TLSXcfMisscrifJOZqcUDo3xn1FNx1Plqfdq6xULgA+LjqOXYVfa2UbXFjaBqeQ8a5gg2d2FvBOlAVJHRLLZsNIi0684phGTY0xe+P9uVs=  ;
Message-ID: <4465E981.60302@yahoo.com.au>
Date: Sun, 14 May 2006 00:13:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Blaisorblade <blaisorblade@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com> <445D75EB.5030909@yahoo.com.au>
In-Reply-To: <445D75EB.5030909@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070102070805060202000200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070102070805060202000200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> I think possibly each thread should have a private vma cache, with
> room for at least its stack vma(s), (and several others, eg. code,
> data). Perhaps the per-mm cache could be dispensed with completely,
> although it might be useful eg. for the heap. And it might be helped
> with increased entries as well.
> 
> I've got patches lying around to implement this stuff -- I'd be
> interested to have more detail about this problem, or distilled test
> cases.

OK, I got interested again, but can't get Val's ebizzy to give me
a find_vma constrained workload yet (though the numbers back up
my assertion that the vma cache is crap for threaded apps).

Without the patch, after bootup, the vma cache gets 208 364 hits out
of 438 535 lookups (47.5%)

./ebizzy -t16: 384.29user 754.61system 5:31.87elapsed 343%CPU

And ebizzy gets 7 373 078 hits out of 82 255 863 lookups (8.9%)


With mm + 4 slot LRU per-thread cache (this patch):
After boot, 303 767 / 439 918 = 69.0%

./ebizzy -t16: 388.73user 750.29system 5:30.24elapsed 344%CPU

ebizzy hits: 53 024 083 / 82 055 195 = 64.6%


So on a non-threaded workload, hit rate is increased by about 50%;
on a threaded workload it is increased by over 700%. In rbtree-walk
-constrained workloads, the total find_vma speedup should be linear
to the hit ratio improvement.

I don't think my ebizzy numbers can justify the patch though...

Nick

-- 
SUSE Labs, Novell Inc.

--------------070102070805060202000200
Content-Type: text/plain;
 name="vma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vma.patch"

Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2006-05-13 23:31:13.000000000 +1000
+++ linux-2.6/mm/mmap.c	2006-05-13 23:48:53.000000000 +1000
@@ -30,6 +30,99 @@
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
 
+static void vma_cache_touch(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	struct task_struct *curr = current;
+	if (mm == curr->mm) {
+		int i;
+		if (curr->vma_cache_sequence != mm->vma_sequence) {
+			curr->vma_cache_sequence = mm->vma_sequence;
+			curr->vma_cache[0] = vma;
+			for (i = 1; i < 4; i++)
+				curr->vma_cache[i] = NULL;
+		} else {
+			int update_mm;
+
+			if (curr->vma_cache[0] == vma)
+				return;
+
+			for (i = 1; i < 4; i++) {
+				if (curr->vma_cache[i] == vma)
+					break;
+			}
+			update_mm = 0;
+			if (i == 4) {
+				update_mm = 1;
+				i = 3;
+			}
+			while (i != 0) {
+				curr->vma_cache[i] = curr->vma_cache[i-1];
+				i--;
+			}
+			curr->vma_cache[0] = vma;
+
+			if (!update_mm)
+				return;
+		}
+	}
+
+	if (mm->vma_cache != vma) /* prevent cacheline bouncing */
+		mm->vma_cache = vma;
+}
+
+static void vma_cache_replace(struct mm_struct *mm, struct vm_area_struct *vma,
+						struct vm_area_struct *repl)
+{
+	mm->vma_sequence++;
+	if (unlikely(mm->vma_sequence == 0)) {
+		struct task_struct *curr = current, *t;
+		t = curr;
+		rcu_read_lock();
+		do {
+			t->vma_cache_sequence = -1;
+			t = next_thread(t);
+		} while (t != curr);
+		rcu_read_unlock();
+	}
+
+	if (mm->vma_cache == vma)
+		mm->vma_cache = repl;
+}
+
+static inline void vma_cache_invalidate(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	vma_cache_replace(mm, vma, NULL);
+}
+
+static struct vm_area_struct *vma_cache_find(struct mm_struct *mm,
+						unsigned long addr)
+{
+	struct task_struct *curr;
+	struct vm_area_struct *vma;
+
+	inc_page_state(vma_cache_query);
+
+	curr = current;
+	if (mm == curr->mm && mm->vma_sequence == curr->vma_cache_sequence) {
+		int i;
+		for (i = 0; i < 4; i++) {
+			vma = curr->vma_cache[i];
+			if (vma && vma->vm_end > addr && vma->vm_start <= addr){
+				inc_page_state(vma_cache_hit);
+				return vma;
+			}
+		}
+	}
+
+	vma = mm->vma_cache;
+	if (vma && vma->vm_end > addr && vma->vm_start <= addr) {
+		inc_page_state(vma_cache_hit);
+		return vma;
+	}
+
+	return NULL;
+}
+
 static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
@@ -460,8 +553,6 @@
 {
 	prev->vm_next = vma->vm_next;
 	rb_erase(&vma->vm_rb, &mm->mm_rb);
-	if (mm->mmap_cache == vma)
-		mm->mmap_cache = prev;
 }
 
 /*
@@ -586,6 +677,7 @@
 		 * us to remove next before dropping the locks.
 		 */
 		__vma_unlink(mm, next, vma);
+		vma_cache_replace(mm, next, vma);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 		if (next->anon_vma)
@@ -1384,8 +1476,8 @@
 	if (mm) {
 		/* Check the cache first. */
 		/* (Cache hit rate is typically around 35%.) */
-		vma = mm->mmap_cache;
-		if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
+		vma = vma_cache_find(mm, addr);
+		if (!vma) {
 			struct rb_node * rb_node;
 
 			rb_node = mm->mm_rb.rb_node;
@@ -1405,9 +1497,9 @@
 				} else
 					rb_node = rb_node->rb_right;
 			}
-			if (vma)
-				mm->mmap_cache = vma;
 		}
+		if (vma)
+			vma_cache_touch(mm, vma);
 	}
 	return vma;
 }
@@ -1424,6 +1516,14 @@
 	if (!mm)
 		goto out;
 
+	vma = vma_cache_find(mm, addr);
+	if (vma) {
+		rb_node = rb_prev(&vma->vm_rb);
+		if (rb_node)
+			prev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
+		goto out;
+	}
+
 	/* Guard against addr being lower than the first VMA */
 	vma = mm->mmap;
 
@@ -1445,6 +1545,9 @@
 	}
 
 out:
+	if (vma)
+		vma_cache_touch(mm, vma);
+
 	*pprev = prev;
 	return prev ? prev->vm_next : vma;
 }
@@ -1686,6 +1789,7 @@
 
 	insertion_point = (prev ? &prev->vm_next : &mm->mmap);
 	do {
+		vma_cache_invalidate(mm, vma);
 		rb_erase(&vma->vm_rb, &mm->mm_rb);
 		mm->map_count--;
 		tail_vma = vma;
@@ -1698,7 +1802,6 @@
 	else
 		addr = vma ?  vma->vm_start : mm->mmap_base;
 	mm->unmap_area(mm, addr);
-	mm->mmap_cache = NULL;		/* Kill the cache. */
 }
 
 /*
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h	2006-05-13 23:31:05.000000000 +1000
+++ linux-2.6/include/linux/page-flags.h	2006-05-13 23:31:44.000000000 +1000
@@ -164,6 +164,9 @@
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
 	unsigned long nr_bounce;	/* pages for bounce buffers */
+
+	unsigned long vma_cache_hit;
+	unsigned long vma_cache_query;
 };
 
 extern void get_page_state(struct page_state *ret);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-05-13 23:31:05.000000000 +1000
+++ linux-2.6/mm/page_alloc.c	2006-05-13 23:31:44.000000000 +1000
@@ -2389,6 +2389,9 @@
 
 	"pgrotated",
 	"nr_bounce",
+
+	"vma_cache_hit",
+	"vma_cache_query",
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2006-05-13 23:31:03.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2006-05-13 23:33:01.000000000 +1000
@@ -293,9 +293,11 @@
 } while (0)
 
 struct mm_struct {
-	struct vm_area_struct * mmap;		/* list of VMAs */
+	struct vm_area_struct *mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
-	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	struct vm_area_struct *vma_cache;
+	unsigned long vma_sequence;
+
 	unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
 				unsigned long pgoff, unsigned long flags);
@@ -734,6 +736,8 @@
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	struct vm_area_struct *vma_cache[4];
+	unsigned long vma_cache_sequence;
 
 /* task state */
 	struct linux_binfmt *binfmt;
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c	2006-05-13 23:31:03.000000000 +1000
+++ linux-2.6/kernel/fork.c	2006-05-13 23:32:59.000000000 +1000
@@ -197,7 +197,7 @@
 
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
-	mm->mmap_cache = NULL;
+	mm->vma_sequence = oldmm->vma_sequence+1;
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->cached_hole_size = ~0UL;
 	mm->map_count = 0;
@@ -238,6 +238,10 @@
 		tmp->vm_next = NULL;
 		anon_vma_link(tmp);
 		file = tmp->vm_file;
+
+		if (oldmm->vma_cache == mpnt)
+			mm->vma_cache = tmp;
+
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);

--------------070102070805060202000200--
Send instant messages to your online friends http://au.messenger.yahoo.com 
