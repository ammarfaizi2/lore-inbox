Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422949AbWHZRnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422949AbWHZRnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422977AbWHZRnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:43:13 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:35510 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422949AbWHZRmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=J9TTL9QppyssTvPuroJyBBaraHdqEEF9Hr4xV55wXmZO4X1G5mpiNkZM7+npfyt8yvn3WT6dFUH3h9+9BGkIocmYr6F0R0stulxb6wNqYF3s/2MYokmtUFguwxKkWMUnPbT762ZJKkbenehj6IXjyVK6I5xd9ZGVWI2ZpbpC6zA=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 11/13] RFP prot support: fix get_user_pages() on VM_MANYPROTS vmas
Date: Sat, 26 Aug 2006 19:42:46 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174246.14790.94903.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

*Non unit-tested patch* - I've not written a test case to verify functionality of
ptrace on VM_MANYPROTS area.

get_user_pages may well call __handle_mm_fault() wanting to override protections,
so in this case __handle_mm_fault() should still avoid checking VM access rights.

Also, get_user_pages() may give write faults on present readonly PTEs in
VM_MANYPROTS areas (think of PTRACE_POKETEXT), so we must still do do_wp_page
even on VM_MANYPROTS areas.

So, possibly use VM_MAYWRITE and/or VM_MAYREAD in the access_mask and check
VM_MANYPROTS in maybe_mkwrite_file (new variant of maybe_mkwrite).

API Note: there are many flags parameter which can be constructed but which
don't make any sense, but the code very freely interprets them too.
For instance VM_MAYREAD|VM_WRITE is interpreted as VM_MAYWRITE|VM_WRITE.

XXX: Todo: add checking to reject all meaningless flag combination.

====
pte_to_pgprot is to be used only with encoded PTEs.

This is needed since now pte_to_pgprot does heavy changes to the pte, it looks
for _PAGE_FILE_PROTNONE and translates it to _PAGE_PROTNONE.
---

 include/linux/mm.h |   17 ++++++++++++++++-
 mm/memory.c        |   43 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 67fe661..b04973f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -747,7 +747,22 @@ extern int install_file_pte(struct mm_st
 
 #ifdef CONFIG_MMU
 
-/* We reuse VM_READ, VM_WRITE and VM_EXEC for the @access_mask. */
+/* We reuse VM_READ, VM_WRITE and (optionally) VM_EXEC for the @access_mask, to
+ * report the kind of access we request for permission checking, in case the VMA
+ * is VM_MANYPROTS.
+ *
+ * get_user_pages( force == 1 ) is a special case. It's allowed to override
+ * protection checks, even on VM_MANYPROTS vma.
+ *
+ * To express that, it must replace VM_READ / VM_WRITE with the corresponding
+ * MAY flags.
+ * This allows to force copying COW pages to break sharing even on read-only
+ * page table entries.
+ * PITFALL: you're not allowed to override only part of the checks, and in
+ * general specifying strange combinations of flags may lead to unspecified
+ * results.
+ */
+
 extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma,
 			unsigned long address, int access_mask);
 
diff --git a/mm/memory.c b/mm/memory.c
index 992d877..db71673 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1058,16 +1058,17 @@ int get_user_pages(struct task_struct *t
 			cond_resched();
 			while (!(page = follow_page(vma, start, foll_flags))) {
 				int ret;
-				ret = __handle_mm_fault(mm, vma, start,
-						foll_flags & FOLL_WRITE);
+				ret = __handle_mm_fault(mm, vma, start, vm_flags);
 				/*
 				 * The VM_FAULT_WRITE bit tells us that do_wp_page has
 				 * broken COW when necessary, even if maybe_mkwrite
 				 * decided not to set pte_write. We can thus safely do
 				 * subsequent page lookups as if they were reads.
 				 */
-				if (ret & VM_FAULT_WRITE)
+				if (ret & VM_FAULT_WRITE) {
 					foll_flags &= ~FOLL_WRITE;
+					vm_flags &= ~(VM_WRITE|VM_MAYWRITE);
+				}
 				
 				switch (ret & ~VM_FAULT_WRITE) {
 				case VM_FAULT_MINOR:
@@ -1402,7 +1403,20 @@ #endif
  * servicing faults for write access.  In the normal case, do always want
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
  * that do not have writing enabled, when used by access_process_vm.
+ *
+ * Also, we must never change protections on VM_MANYPROTS pages; that's only
+ * allowed in do_no_page(), so test only VMA protections there. For other cases
+ * we *know* that VM_MANYPROTS is clear, such as anonymous/swap pages, and in
+ * that case using plain maybe_mkwrite() is an optimization.
+ * Instead, when we may be mapping a file, we must use maybe_mkwrite_file.
  */
+static inline pte_t maybe_mkwrite_file(pte_t pte, struct vm_area_struct *vma)
+{
+	if (likely((vma->vm_flags & (VM_WRITE | VM_MANYPROTS)) == VM_WRITE))
+		pte = pte_mkwrite(pte);
+	return pte;
+}
+
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
@@ -1454,6 +1468,9 @@ static inline void cow_user_page(struct 
  * We enter with non-exclusive mmap_sem (to exclude vma changes,
  * but allow concurrent faults), with pte both mapped and locked.
  * We return with mmap_sem still held, but pte unmapped and unlocked.
+ *
+ * Note that a page here can be a shared readonly page where
+ * get_user_pages() (for instance for ptrace()) wants to write to it!
  */
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
@@ -1509,7 +1526,8 @@ static int do_wp_page(struct mm_struct *
 	if (reuse) {
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = pte_mkyoung(orig_pte);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		/* Since it can be shared, it can be VM_MANYPROTS! */
+		entry = maybe_mkwrite_file(pte_mkdirty(entry), vma);
 		ptep_set_access_flags(vma, address, page_table, entry, 1);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
@@ -1552,7 +1570,7 @@ gotten:
 			inc_mm_counter(mm, anon_rss);
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		entry = maybe_mkwrite_file(pte_mkdirty(entry), vma);
 		lazy_mmu_prot_update(entry);
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
@@ -1982,7 +2000,7 @@ static int do_swap_page(struct mm_struct
 	inc_mm_counter(mm, anon_rss);
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
-		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
+		pte = maybe_mkwrite_file(pte_mkdirty(pte), vma);
 		write_access = 0;
 	}
 
@@ -2305,7 +2323,7 @@ static inline int handle_pte_fault(struc
 	pte_t entry;
 	pte_t old_entry;
 	spinlock_t *ptl;
-	int write_access = access_mask & VM_WRITE;
+	int write_access = access_mask & (VM_WRITE|VM_MAYWRITE);
 
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
@@ -2313,7 +2331,7 @@ static inline int handle_pte_fault(struc
 		 * we need to check VM_MANYPROTS, because in that case the arch
 		 * fault handler skips the VMA protection check. */
 		if (!pte_file(entry) && unlikely(insufficient_vma_perms(vma, access_mask)))
-			goto out_segv;
+			goto segv;
 
 		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -2340,8 +2358,9 @@ static inline int handle_pte_fault(struc
 	 * condition with another thread having already fixed the fault. So go
 	 * the slow way. */
 	if (unlikely(vma->vm_flags & VM_MANYPROTS) &&
- 		unlikely(insufficient_perms(entry, access_mask)))
-			goto out_segv;
+ 		unlikely(insufficient_perms(entry, access_mask)) &&
+		likely(!(access_mask & (VM_MAYWRITE|VM_MAYREAD))))
+			goto segv_unlock;
 
 	if (write_access) {
 		if (!pte_write(entry))
@@ -2367,8 +2386,10 @@ static inline int handle_pte_fault(struc
 unlock:
 	pte_unmap_unlock(pte, ptl);
 	return VM_FAULT_MINOR;
-out_segv:
+
+segv_unlock:
 	pte_unmap_unlock(pte, ptl);
+segv:
 	return VM_FAULT_SIGSEGV;
 }
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
