Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbWLSHkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWLSHkL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWLSHkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:40:11 -0500
Received: from amsfep17-int.chello.nl ([62.179.120.12]:22834 "EHLO
	amsfep17-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbWLSHkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:40:10 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 08:38:46 +0100
Message-Id: <1166513926.10372.121.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 11:18 -0800, Linus Torvalds wrote:

> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index d8a842a..3f9061e 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -448,7 +448,7 @@ static int page_mkclean_one(struct page 
> >  		goto unlock;
> >  
> >  	entry = ptep_get_and_clear(mm, address, pte);
> > -	entry = pte_mkclean(entry);
> > +	/*entry = pte_mkclean(entry);*/
> >  	entry = pte_wrprotect(entry);
> >  	ptep_establish(vma, address, pte, entry);
> >  	lazy_mmu_prot_update(entry);
> 
> The above patch is bad. It's always going to hide the bug, but it hides it 
> by just not doing anything at all. 

Not quite, it does wrprotect still, so further updates will trigger the
do_wp_page() path and call set_page_dirty().

So we could make 'something' that would keep the tracking working and
not create corruption, say something like this:

However I'll try and figure out how we get so terribly confused on the
PG_dirty state that we have to clean it and fall back to pte_dirty. That
is the real issue we have.

---
 include/linux/rmap.h |    6 ++++++
 mm/page-writeback.c  |    3 ++-
 mm/rmap.c            |   23 ++++++++++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

Index: linux-2.6-git/mm/rmap.c
===================================================================
--- linux-2.6-git.orig/mm/rmap.c	2006-12-18 11:06:29.000000000 +0100
+++ linux-2.6-git/mm/rmap.c	2006-12-19 08:33:57.000000000 +0100
@@ -428,7 +428,8 @@ int page_referenced(struct page *page, i
 	return referenced;
 }
 
-static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
+static int page_mkcw_one(struct page *page,
+			 struct vm_area_struct *vma, int make_clean)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -448,7 +449,8 @@ static int page_mkclean_one(struct page 
 		goto unlock;
 
 	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
+	if (make_clean)
+		entry = pte_mkclean(entry);
 	entry = pte_wrprotect(entry);
 	ptep_establish(vma, address, pte, entry);
 	lazy_mmu_prot_update(entry);
@@ -460,7 +462,8 @@ out:
 	return ret;
 }
 
-static int page_mkclean_file(struct address_space *mapping, struct page *page)
+static int page_mkcw_file(struct address_space *mapping,
+			  struct page *page, int make_clean)
 {
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
@@ -478,7 +481,7 @@ static int page_mkclean_file(struct addr
 	return ret;
 }
 
-int page_mkclean(struct page *page)
+static int page_mkcw(struct page *page, int make_clean)
 {
 	int ret = 0;
 
@@ -487,12 +490,22 @@ int page_mkclean(struct page *page)
 	if (page_mapped(page)) {
 		struct address_space *mapping = page_mapping(page);
 		if (mapping)
-			ret = page_mkclean_file(mapping, page);
+			ret = page_mkcw_file(mapping, page, make_clean);
 	}
 
 	return ret;
 }
 
+int page_mkclean(struct page *page)
+{
+	return page_mkcw(page, 1);
+}
+
+int page_wrprotect(struct page *page)
+{
+	return page_mkcw(page, 0);
+}
+
 /**
  * page_set_anon_rmap - setup new anonymous rmap
  * @page:	the page to add the mapping to
Index: linux-2.6-git/include/linux/rmap.h
===================================================================
--- linux-2.6-git.orig/include/linux/rmap.h	2006-12-19 08:31:59.000000000 +0100
+++ linux-2.6-git/include/linux/rmap.h	2006-12-19 08:32:28.000000000 +0100
@@ -110,6 +110,7 @@ unsigned long page_address_in_vma(struct
  * returns the number of cleaned PTEs.
  */
 int page_mkclean(struct page *);
+int page_wrprotect(struct page *);
 
 #else	/* !CONFIG_MMU */
 
@@ -125,6 +126,11 @@ static inline int page_mkclean(struct pa
 	return 0;
 }
 
+static inline int page_wrprotect(struct page *page)
+{
+	return 0;
+}
+
 
 #endif	/* CONFIG_MMU */
 
Index: linux-2.6-git/mm/page-writeback.c
===================================================================
--- linux-2.6-git.orig/mm/page-writeback.c	2006-12-19 08:24:48.000000000 +0100
+++ linux-2.6-git/mm/page-writeback.c	2006-12-19 08:31:43.000000000 +0100
@@ -872,7 +872,8 @@ int test_clear_page_dirty(struct page *p
 		 * page is locked, which pins the address_space
 		 */
 		if (mapping_cap_account_dirty(mapping)) {
-			page_mkclean(page);
+			if (page_wrprotect(page))
+				set_page_dirty();
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
 		return 1;




