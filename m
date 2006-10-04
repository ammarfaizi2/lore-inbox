Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030688AbWJDN7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbWJDN7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030833AbWJDN73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:59:29 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:21117 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030688AbWJDN72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:59:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=lEFPPzMfV7zVlmVeD37KmOajLE2+BW2ppPNh8A91TJX9zZir5RsBYOPUddP+rSQ8cJNJEYvgMWcdcI/066UMjZD9xe655X1OFo5UZfDJOXOhOPs9S+HY8UsYfVi51k8OOrakIduzHdQBQJbIlibDP6wC+b38GBl1XO3yq+RqY7U=  ;
Message-ID: <4523BE45.5050205@yahoo.com.au>
Date: Wed, 04 Oct 2006 23:59:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Noll <maan@systemlinux.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       riel@redhat.com
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
References: <20061004104018.GB22487@skl-net.de>
In-Reply-To: <20061004104018.GB22487@skl-net.de>
Content-Type: multipart/mixed;
 boundary="------------020701020109050808030805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701020109050808030805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andre Noll wrote:
> Hi
> 
> MATLAB triggers the following bug on both of our new 16-way opteron
> machines (64G Ram): The same kernel is running with no problems on a
> bunch of smaller (8-way, 4-way, max 32G Ram) cluster nodes.
> 
> Any hints?
> Andre
> 
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at ...aid0/home/maan/scm/stable/linux-2.6.18.y/mm/rmap.c:522

Ah, this old thing. I hope it is repeatable?

What we really want is the bit before this, the "Eeek! page_mapcount went
negative" part.

It is also nice if we can work out where the page actually came from. The
following attached patch should help out a bit with that, if you could
run with it?

Thanks a lot for reporting, this is very useful.

Nick

-- 
SUSE Labs, Novell Inc.

--------------020701020109050808030805
Content-Type: text/plain;
 name="mm-rmap-debug-more.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-rmap-debug-more.patch"

Index: linux-2.6/include/linux/rmap.h
===================================================================
--- linux-2.6.orig/include/linux/rmap.h	2006-10-04 23:51:55.000000000 +1000
+++ linux-2.6/include/linux/rmap.h	2006-10-04 23:52:28.000000000 +1000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
Index: linux-2.6/mm/filemap_xip.c
===================================================================
--- linux-2.6.orig/mm/filemap_xip.c	2006-10-04 23:56:59.000000000 +1000
+++ linux-2.6/mm/filemap_xip.c	2006-10-04 23:57:08.000000000 +1000
@@ -189,7 +189,7 @@ __xip_unmap (struct address_space * mapp
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap_unlock(pte, ptl);
Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c	2006-10-04 23:57:00.000000000 +1000
+++ linux-2.6/mm/fremap.c	2006-10-04 23:57:13.000000000 +1000
@@ -33,7 +33,7 @@ static int zap_pte(struct mm_struct *mm,
 		if (page) {
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			page_cache_release(page);
 		}
 	} else {
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-10-04 23:57:00.000000000 +1000
+++ linux-2.6/mm/memory.c	2006-10-04 23:57:26.000000000 +1000
@@ -677,7 +677,7 @@ static unsigned long zap_pte_range(struc
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1540,7 +1540,7 @@ gotten:
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		if (old_page) {
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma);
 			if (!PageAnon(old_page)) {
 				dec_mm_counter(mm, file_rss);
 				inc_mm_counter(mm, anon_rss);
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c	2006-10-04 23:49:15.000000000 +1000
+++ linux-2.6/mm/rmap.c	2006-10-04 23:58:00.000000000 +1000
@@ -508,7 +508,7 @@ void page_add_file_rmap(struct page *pag
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page, struct vm_area_struct *vma)
 {
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 #ifdef CONFIG_DEBUG_VM
@@ -517,6 +517,7 @@ void page_remove_rmap(struct page *page)
 			printk (KERN_EMERG "  page->flags = %lx\n", page->flags);
 			printk (KERN_EMERG "  page->count = %x\n", page_count(page));
 			printk (KERN_EMERG "  page->mapping = %p\n", page->mapping);
+			print_symbol (KERN_EMERG "  vma->vm_ops = %s\n", vma->vm_ops);
 		}
 #endif
 		BUG_ON(page_mapcount(page) < 0);
@@ -621,7 +622,7 @@ static int try_to_unmap_one(struct page 
 		dec_mm_counter(mm, file_rss);
 
 
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma);
 	page_cache_release(page);
 
 out_unmap:
@@ -711,7 +712,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;

--------------020701020109050808030805--
Send instant messages to your online friends http://au.messenger.yahoo.com 
