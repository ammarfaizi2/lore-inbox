Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUBCKZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUBCKZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:25:23 -0500
Received: from mail2.speakeasy.net ([216.254.0.202]:25779 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S265750AbUBCKZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:25:19 -0500
Date: Tue, 3 Feb 2004 02:25:15 -0800
Message-Id: <200402031025.i13APFvl023035@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: Linus Torvalds's message of  Monday, 2 February 2004 16:30:18 -0800 <Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is working for me.  What do you think?

I'm not sure I followed Ingo's comment.  The ptes are still marked dirty
here, just not also writable.  I can't see off hand how it matters one way
or the other, since the page will have been marked dirty by get_user_pages
already.  I don't see a problem making the pte_dirty use also conditional
if that is better somehow.


Thanks,
Roland


Index: linux-2.6/mm/memory.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/memory.c,v
retrieving revision 1.141
diff -b -p -u -r1.141 memory.c
--- linux-2.6/mm/memory.c 20 Jan 2004 05:12:38 -0000 1.141
+++ linux-2.6/mm/memory.c 3 Feb 2004 05:18:30 -0000
@@ -746,7 +746,8 @@ int get_user_pages(struct task_struct *t
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
-			while (!(map = follow_page(mm, start, write))) {
+			int lookup_write = write;
+			while (!(map = follow_page(mm, start, lookup_write))) {
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:
@@ -762,6 +763,14 @@ int get_user_pages(struct task_struct *t
 				default:
 					BUG();
 				}
+				/*
+				 * Now that we have performed a write fault
+				 * and surely no longer have a shared page we
+				 * shouldn't write, we shouldn't ignore an
+				 * unwritable page in the page table if
+				 * we are forcing write access.
+				 */
+				lookup_write = write && !force;
 				spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {
@@ -951,6 +960,19 @@ int remap_page_range(struct vm_area_stru
 EXPORT_SYMBOL(remap_page_range);
 
 /*
+ * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
+ * servicing faults for write access.  In the normal case, do always want
+ * pte_mkwrite.  But get_user_pages can cause write faults for mappings
+ * that do not have writing enabled, when used by access_process_vm.
+ */
+static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_flags & VM_WRITE))
+		pte = pte_mkwrite(pte);
+	return pte;
+}
+
+/*
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
  */
 static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
@@ -959,7 +981,8 @@ static inline void break_cow(struct vm_a
 	pte_t entry;
 
 	flush_cache_page(vma, address);
-	entry = pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)));
+	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
+			      vma);
 	ptep_establish(vma, address, page_table, entry);
 	update_mmu_cache(vma, address, entry);
 }
@@ -1011,7 +1034,8 @@ static int do_wp_page(struct mm_struct *
 		unlock_page(old_page);
 		if (reuse) {
 			flush_cache_page(vma, address);
-			entry = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte)));
+			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
+					      vma);
 			ptep_establish(vma, address, page_table, entry);
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
@@ -1279,7 +1303,7 @@ static int do_swap_page(struct mm_struct
 	mm->rss++;
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page))
-		pte = pte_mkdirty(pte_mkwrite(pte));
+		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 	unlock_page(page);
 
 	flush_icache_page(vma, page);
@@ -1346,7 +1370,9 @@ do_anonymous_page(struct mm_struct *mm, 
 			goto out;
 		}
 		mm->rss++;
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
+							 vma->vm_page_prot)),
+				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
 	}
@@ -1462,7 +1488,7 @@ retry:
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte(page_table, entry);
 		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		pte_unmap(page_table);
