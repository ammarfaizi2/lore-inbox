Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUFRB72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUFRB72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUFRB72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:59:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48768
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264924AbUFRB65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:58:57 -0400
Date: Fri, 18 Jun 2004 03:59:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: anon-vma mprotect merging-extend fix
Message-ID: <20040618015903.GA2797@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yesterday I got a crash bugreport where this BUG_ON bombed with wine.

static inline void anon_vma_page_link(struct page * page, struct
vm_area_struct
* vma,
                                      unsigned long address)
{
        unsigned long index = ((address - vma->vm_start) >> PAGE_SHIFT)
+
vma->vm_pgoff;

        BUG_ON(!vma->anon_vma);
        if (page->mapcount == 1) {
                page->index = index;
                BUG_ON(page->mapping);
                page->mapping = (struct address_space *) vma->anon_vma;
        } else {
                BUG_ON(vma->anon_vma != (anon_vma_t *) page->mapping ||
                 index != page->index);
                ^^^^^^^^^^^^^^^^^^^^^^^
        }
}

The problem is that I was not propagating the anon_vma correctly in the
extend case of mprotect-merging.

This fixes the problem:

--- sles/include/linux/objrmap.h.~1~	2004-06-17 19:25:24.000000000 +0200
+++ sles/include/linux/objrmap.h	2004-06-18 03:16:29.000000000 +0200
@@ -48,6 +48,8 @@ static inline void anon_vma_unlock(struc
 extern int FASTCALL(anon_vma_prepare(struct vm_area_struct * vma));
 extern void FASTCALL(anon_vma_merge(struct vm_area_struct * vma,
 				    struct vm_area_struct * vma_dying));
+extern void FASTCALL(anon_vma_merge_extend(struct vm_area_struct * prev,
+					   struct vm_area_struct * next));
 extern void FASTCALL(anon_vma_unlink(struct vm_area_struct * vma));
 extern void FASTCALL(anon_vma_link(struct vm_area_struct * vma));
 extern void FASTCALL(__anon_vma_link(struct vm_area_struct * vma));
--- sles/mm/objrmap.c.~1~	2004-06-17 19:25:24.000000000 +0200
+++ sles/mm/objrmap.c	2004-06-18 03:32:43.000000000 +0200
@@ -302,8 +316,10 @@ void fastcall page_add_rmap(struct page 
 	 * allowed to read PG_anon outside the page_map_lock.
 	 */
 	last_anon = PageAnon(page);
-	if (anon && !last_anon)
+	if (anon && !last_anon) {
+		BUG_ON(page->mapping);
 		SetPageAnon(page);
+	}
 	BUG_ON(!anon && last_anon);
 
 	if (!page->mapcount++)
@@ -798,6 +814,51 @@ void fastcall anon_vma_merge(struct vm_a
 	}
 }
 
+/*
+ * This is called when _prev_ is being extended. This is needed
+ * by mprotect for example. This means prev->vm_end == next->vm_start
+ * and they both get moved to an address > next->vm_start and
+ * < next->vm_end. NOTE: it's critical that "prev" is extended.
+ * This will kernel-crash if it's "next" being extended down, this
+ * only works for prev->vm_end and next->vm_start going _up_,
+ * down not.
+ */
+void fastcall anon_vma_merge_extend(struct vm_area_struct * prev,
+				    struct vm_area_struct * next)
+{
+	anon_vma_t * anon_vma = next->anon_vma;
+
+	/*
+	 * If next->anon_vma is null we've nothing to do since
+	 * next is being shrunk.
+	 */
+	if (!anon_vma)
+		return;
+
+	/*
+	 * If both prev->anon_vma != 0 and next->anon_vma != 0
+	 * it means they're equal and we've nothing to do again.
+	 */
+	if (prev->anon_vma) {
+		BUG_ON(prev->anon_vma != anon_vma);
+		return;
+	}
+
+	/*
+	 * If we get here it means we've to propagate the anon_vma
+	 * from "next" to "prev" because "prev" will now have to
+	 * include pages in the previous "next" range that can
+	 * point to "anon_vma". The setting of prev->anon_vma
+	 * is serialized by the mmap_sem rwsem taken in write mode.
+	 */
+	prev->anon_vma = anon_vma;
+
+	/* Now link the "prev" vma into the "anon_vma_head" list. */
+	spin_lock(&anon_vma->anon_vma_lock);
+	list_add(&prev->anon_vma_node, &next->anon_vma_node);
+	spin_unlock(&anon_vma->anon_vma_lock);
+}
+
 void fastcall __anon_vma_link(struct vm_area_struct * vma)
 {
 	anon_vma_t * anon_vma = vma->anon_vma;
--- sles/mm/mprotect.c.~1~	2004-06-17 19:25:25.000000000 +0200
+++ sles/mm/mprotect.c	2004-06-18 03:39:38.608807352 +0200
@@ -135,7 +135,7 @@ mprotect_attempt_merge(struct vm_area_st
 
 	prev_pgoff = vma->vm_pgoff - ((prev->vm_end - prev->vm_start) >> PAGE_SHIFT);
 	file = vma->vm_file;
-	if (!is_mergeable_vma(prev, file, newflags, prev_pgoff, NULL))
+	if (!vma->vm_private_data && !is_mergeable_vma(prev, file, newflags, prev_pgoff, NULL))
 		return 0;
 	if (!is_mergeable_anon_vma(prev, vma))
 		return 0;
@@ -215,6 +215,14 @@ mprotect_attempt_merge(struct vm_area_st
 	anon_vma_unlock(vma);
 	if (file)
 		up(i_shared_sem);
+
+	/*
+	 * No need of any lock for this (except the internal anon_vma_lock),
+	 * the whole vma->anon_vma handling is serialized enterely by the
+	 * mmap_sem rwsem taken in write mode.
+	 */
+	anon_vma_merge_extend(prev, vma);
+
 	return 1;
 }
 
@@ -241,7 +249,7 @@ mprotect_attempt_merge_final(struct vm_a
 
 	next_pgoff = prev->vm_pgoff + ((prev->vm_end - prev->vm_start) >> PAGE_SHIFT);
 	file = prev->vm_file;
-	if (!is_mergeable_vma(next, file, newflags, next_pgoff, NULL))
+	if (!prev->vm_private_data && !is_mergeable_vma(next, file, newflags, next_pgoff, NULL))
 		return;
 	if (!is_mergeable_anon_vma(prev, next))
 		return;


This adds another robustness BUG_ON to be sure we switch the PG_anon
bitflag only in unmapped pages, and secondly it makes sure not to merge
anything if vm_private_data is set on the "other" vma (the one not
checked internally in is_mergeable_vma). I considered adding another
parameter to is_mergeable_vma, but I think the above is fine too, such
construct can be copied as easily without forgetting about the "other"
vma private_data.

This is against latest 2.6-aa or sles kernel (SL9.1 is unaffected
because we didn't enable the mprotect merging there, so in short nothing
is affected because this is not a released kernel yet and I fixed this
just in time ;).

I didn't have much time to look at the status of mainline in the last
week, I assume Hugh will take care of merging this fix in a way that
will apply cleanly to mainline.

I plan to finish the fix-update for 2.4 before the weekend and to
synchronize with 2.6 early next week (sorry for being a bit out of sync
and thanks for all the help).
