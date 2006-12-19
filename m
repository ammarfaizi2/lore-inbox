Return-Path: <linux-kernel-owner+w=401wt.eu-S1752631AbWLSGUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbWLSGUk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLSGUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:20:40 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:21895 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752631AbWLSGUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:20:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=DQbMtOL6blZZ+goc5SLwh+pc9Gc3hFcDvOsnbJxTJLTi4TP7mnaxmV8tr3B4N/U6D5ozUty++8cfCcHCLhciOTblL9F+3SYmHVd9qNNe3uWeExEmwkWyIMKrG8t5eMJmnp7G4FFSZx+FotB3gr62tFmOZuBnNrYjhcUxypoUyjw=  ;
X-YMail-OSG: ReoWJn8VM1nkVd2Mo6e0TA9z0ZGWsqJ2r36XT7fijQrkBdYTnTR0mWCiqdsLC4yq3_dmgHpZJNw3vqygqgVrzqWwQ.aWTliiOvgNYz9rCaN_5Adc2zNntflWtASQSelgXL1cQ559WaMxz28-
Message-ID: <458776A5.3060007@yahoo.com.au>
Date: Tue, 19 Dec 2006 16:20:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Chris Rankin <cj.rankin@ntlworld.com>
Subject: Re: -mm merge plans for 2.6.20
References: <20061204204024.2401148d.akpm@osdl.org> <20061205160250.GB9076@kernelslacker.org> <20061212174909.GD2140@redhat.com>
In-Reply-To: <20061212174909.GD2140@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060305040105060307050600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305040105060307050600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Jones wrote:

> Eeek! page_mapcount(page) went negative! (-2)

Hmm, probably happened once before, too.

>   page->flags = 404

What's that? PG_referenced|PG_reserved? So I'd say it is likely
that some driver has got its refcounting wrong.

Unfortunately, this debugging output is almost useless when it
comes to trying to track down the problem any further.

And I see we've got another report for 2.6.19.1 from Chris, which
is equally vague.

IMO the pattern is much too consistent to be able to attribute
them all to hardware problems. And considering it takes so long
for these things to appear, can we get something like the attached
patch upstream at least until we manage to stamp them out? Any
other debugging info we can add?

-- 
SUSE Labs, Novell Inc.

--------------060305040105060307050600
Content-Type: text/plain;
 name="mm-rmap-debug-more.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-rmap-debug-more.patch"

Index: linux-2.6/include/linux/rmap.h
===================================================================
--- linux-2.6.orig/include/linux/rmap.h	2006-12-04 19:56:17.000000000 +1100
+++ linux-2.6/include/linux/rmap.h	2006-12-19 16:14:30.000000000 +1100
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
--- linux-2.6.orig/mm/filemap_xip.c	2006-12-04 19:07:10.000000000 +1100
+++ linux-2.6/mm/filemap_xip.c	2006-12-19 16:14:30.000000000 +1100
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
--- linux-2.6.orig/mm/fremap.c	2006-12-04 19:56:20.000000000 +1100
+++ linux-2.6/mm/fremap.c	2006-12-19 16:14:30.000000000 +1100
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
--- linux-2.6.orig/mm/memory.c	2006-12-04 19:56:21.000000000 +1100
+++ linux-2.6/mm/memory.c	2006-12-19 16:14:30.000000000 +1100
@@ -681,7 +681,7 @@ static unsigned long zap_pte_range(struc
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1576,7 +1576,7 @@ gotten:
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
--- linux-2.6.orig/mm/rmap.c	2006-12-04 19:56:21.000000000 +1100
+++ linux-2.6/mm/rmap.c	2006-12-19 16:20:13.000000000 +1100
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 
 #include <asm/tlbflush.h>
 
@@ -567,7 +568,7 @@ void page_add_file_rmap(struct page *pag
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page, struct vm_area_struct *vma)
 {
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		if (unlikely(page_mapcount(page) < 0)) {
@@ -575,6 +576,9 @@ void page_remove_rmap(struct page *page)
 			printk (KERN_EMERG "  page->flags = %lx\n", page->flags);
 			printk (KERN_EMERG "  page->count = %x\n", page_count(page));
 			printk (KERN_EMERG "  page->mapping = %p\n", page->mapping);
+			print_symbol (KERN_EMERG "  vma->vm_ops = %s\n", (unsigned long)vma->vm_ops);
+			if (vma->vm_ops)
+				print_symbol (KERN_EMERG "  vma->vm_ops->nopage = %s\n", (unsigned long)vma->vm_ops->nopage);
 			BUG();
 		}
 
@@ -679,7 +683,7 @@ static int try_to_unmap_one(struct page 
 		dec_mm_counter(mm, file_rss);
 
 
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma);
 	page_cache_release(page);
 
 out_unmap:
@@ -769,7 +773,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;

--------------060305040105060307050600--
Send instant messages to your online friends http://au.messenger.yahoo.com 
