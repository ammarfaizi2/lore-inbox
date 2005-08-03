Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVHCKYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVHCKYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHCKYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:24:23 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:23733 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262194AbVHCKYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:24:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=Clp8cD3qI9HSrhWgcN8qp1StK7ie3XRjGuZoHV8XEnGHlw/ujeBhS6QeG1BY+h9xI35cQhNG3WRPUoegv2nqrYPFOFvv9daeMwlEn8Oq9jr2whzXyCeRdwMLMV+LJgqyMwWwejWO3EodjMuFEad1ddGCthLrjSGLVFdhjvwCAwI=  ;
Message-ID: <42F09B41.3050409@yahoo.com.au>
Date: Wed, 03 Aug 2005 20:24:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com> <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org> <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com> <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------000105010906000803080204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105010906000803080204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hugh Dickins wrote:
> On Tue, 2 Aug 2005, Linus Torvalds wrote:
> 
>>Go for it, I think whatever we do won't be wonderfully pretty.
> 
> 
> Here we are: get_user_pages quite untested, let alone the racy case,
> but I think it should work.  Please all hack it around as you see fit,
> I'll check mail when I get home, but won't be very responsive...
> 

Seems OK to me. I don't know why you think handle_mm_fault can't
be inline, but if it can be, then I have a modification attached
that removes the condition - any good?

Oh, it gets rid of the -1 for VM_FAULT_OOM. Doesn't seem like there
is a good reason for it, but might that break out of tree drivers?

-- 
SUSE Labs, Novell Inc.


--------------000105010906000803080204
Content-Type: text/plain;
 name="mm-gup-hugh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-gup-hugh.patch"

Checking pte_dirty instead of pte_write in __follow_page is problematic
for s390, and for copy_one_pte which leaves dirty when clearing write.

So revert __follow_page to check pte_write as before, and let do_wp_page
pass back a special code VM_FAULT_WRITE to say it has done its full job
(whereas VM_FAULT_MINOR when it backs out on race): once get_user_pages
receives this value, it no longer requires pte_write in __follow_page.

But most callers of handle_mm_fault, in the various architectures, have
switch statements which do not expect this new case.  To avoid changing
them all in a hurry, only pass back VM_FAULT_WRITE when write_access arg
says VM_FAULT_WRITE_EXPECTED - chosen as -1 since some arches pass
write_access as a boolean, some as a bitflag, but none as -1.

Yes, we do have a call to do_wp_page from do_swap_page, but no need to
change that: in rare case it's needed, another do_wp_page will follow.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -625,10 +625,16 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
-#define VM_FAULT_OOM	(-1)
-#define VM_FAULT_SIGBUS	0
-#define VM_FAULT_MINOR	1
-#define VM_FAULT_MAJOR	2
+#define VM_FAULT_OOM	0x00
+#define VM_FAULT_SIGBUS	0x01
+#define VM_FAULT_MINOR	0x02
+#define VM_FAULT_MAJOR	0x03
+
+/* 
+ * Special case for get_user_pages.
+ * Must be in a distinct bit from the above VM_FAULT_ flags.
+ */
+#define VM_FAULT_WRITE	0x10
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 
@@ -704,7 +710,13 @@ extern pte_t *FASTCALL(pte_alloc_kernel(
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
-extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
+extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
+
+static inline int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access)
+{
+	return __handle_mm_fault(mm, vma, address, write_access) & (~VM_FAULT_WRITE);
+}
+
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -811,15 +811,18 @@ static struct page *__follow_page(struct
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_dirty(pte))
+		if (write && !pte_write(pte))
 			goto out;
 		if (read && !pte_read(pte))
 			goto out;
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (accessed)
+			if (accessed) {
+				if (write && !pte_dirty(pte) &&!PageDirty(page))
+					set_page_dirty(page);
 				mark_page_accessed(page);
+			}
 			return page;
 		}
 	}
@@ -941,10 +944,11 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
+			int write_access = write;
 			struct page *page;
 
 			cond_resched_lock(&mm->page_table_lock);
-			while (!(page = follow_page(mm, start, write))) {
+			while (!(page = follow_page(mm, start, write_access))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -957,7 +961,16 @@ int get_user_pages(struct task_struct *t
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
-				switch (handle_mm_fault(mm,vma,start,write)) {
+				switch (__handle_mm_fault(mm, vma, start,
+							write_access)) {
+				case VM_FAULT_WRITE:
+					/*
+					 * do_wp_page has broken COW when
+					 * necessary, even if maybe_mkwrite
+					 * decided not to set pte_write
+					 */
+					write_access = 0;
+					/* FALLTHRU */
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
@@ -1220,6 +1233,7 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
 	pte_t entry;
+	int ret;
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
@@ -1247,7 +1261,7 @@ static int do_wp_page(struct mm_struct *
 			lazy_mmu_prot_update(entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
-			return VM_FAULT_MINOR;
+			return VM_FAULT_MINOR|VM_FAULT_WRITE;
 		}
 	}
 	pte_unmap(page_table);
@@ -1274,6 +1288,7 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
+	ret = VM_FAULT_MINOR;
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
@@ -1290,12 +1305,13 @@ static int do_wp_page(struct mm_struct *
 
 		/* Free the old page.. */
 		new_page = old_page;
+		ret |= VM_FAULT_WRITE;
 	}
 	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_MINOR;
+	return ret;
 
 no_new_page:
 	page_cache_release(old_page);
@@ -1987,7 +2003,6 @@ static inline int handle_pte_fault(struc
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
-
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
@@ -2002,7 +2017,7 @@ static inline int handle_pte_fault(struc
 /*
  * By the time we get here, we already hold the mm semaphore
  */
-int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
 		unsigned long address, int write_access)
 {
 	pgd_t *pgd;

--------------000105010906000803080204--
Send instant messages to your online friends http://au.messenger.yahoo.com 
