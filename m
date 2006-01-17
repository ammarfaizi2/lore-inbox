Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWAQTrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWAQTrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWAQTrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:47:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:44335 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932152AbWAQTrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:47:03 -0500
Date: Tue, 17 Jan 2006 19:01:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0601171805430.8030@goblin.wat.veritas.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Jan 2006 19:47:02.0101 (UTC) FILETIME=[C9336850:01C61B9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Christoph Lameter wrote:
> On Mon, 16 Jan 2006, Hugh Dickins wrote:
> 
> > Hmm, that battery of unusual tests at the start of migrate_page_add
> > is odd: the tests don't quite match the comment, and it isn't clear
> > what reasoning lies behind the comment anyway.
> 
> Here is patch to clarify the test. I'd be glad if someone could make
> the tests more accurate. This ultimately comes down to a concept of
> ownership of page by a process / mm_struct that we have to approximate.

Endless scope for argument here!  But I'm relieved to see there's
an MPOL_MF_MOVE_ALL subject to a capability check, so this is just
dealing with what a ordinary uncapable process might be allowed to
do to itself.

> Explain the complicated check in migrate_page_add by putting the logic
> into a separate function migration_check. This way any enhancements can
> be easily added.

Yes, that's helpful to separate it out.  I'd prefer a more specific name
than migration_check, but that name may depend on what it ends up doing.

> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.15/mm/mempolicy.c
> ===================================================================
> --- linux-2.6.15.orig/mm/mempolicy.c	2006-01-14 10:56:28.000000000 -0800
> +++ linux-2.6.15/mm/mempolicy.c	2006-01-17 09:24:20.000000000 -0800
> @@ -551,6 +551,37 @@ out:
>  	return rc;
>  }
>  
> +static inline int migration_check(struct mm_struct *mm, struct page *page)
> +{
> +	/*
> +	 * If the page has no mapping then we do not track reverse mappings.
> +	 * Thus the page is not mapped by other mms, so its safe to move.
> +	 */
> +	if (page->mapping)
> +		return 1;

Please cut out this test.  You probably meant to say "!page->mapping",
but those are weird cases best left alone (though rarely would they
have PageLRU set, so they'll probably be skipped later anyway).  Almost
every page you'll meet in an mm has page->mapping set, doesn't it?
Either a file page in the page cache, or an anonymous page pointing to
its anon_vma.  You've already skipped the ZERO_PAGEs and anything else
with PageReserved set, and any VM_RESERVED area (covering some driver
areas).  Just cut out this test completely, it's wrong as is,
and doesn't add anything useful when inverted.

> +
> +	/*
> +	 * We cannot determine "ownership" of anonymous pages.
> +	 * However, this is the primary set of pages a user would like
> +	 * to move. So move the page regardless of sharing.
> +	 */
> +	if (PageAnon(page))
> +		return 1;

I think that's reasonable.  The page may be "shared" with some other
processes in our fork-group (anon_vma), but we probably needn't get
worked up about that.  Though you could choose to make it stricter by

	if (PageAnon(page))
		return page_mapcount(page) == 1;

> +
> +	/*
> +	 * If the mapping is writable then its reasonable to assume that
> +	 * it is okay to move the page.
> +	 */
> +	if (mapping_writably_mapped(page->mapping))
> +		return 1;

I can't see why the fact that some other process has mapped some part
of this file for writing should have any bearing on whether we can
migrate this page.  I can see an argument (I'm unsure whether I agree
with it) that if we can have write access to this file page, then we
should be allowed to migrate it.  A test for that (given a vma arg)
would be

	if (vma->vm_flags & VM_SHARED)
		return 1;
> +
> +	/*
> +	 * Its a read only file backed mapping. Only migrate the page
> +	 * if we are the only process mapping that file.
> +	 */
> +	return single_mm_mapping(mm, page->mapping);

So what if someone else is mapping some other part of the file?
I just don't think it merits the complexity of single_mm_mapping's
prio_tree check.   I say delete single_mm_mapping and here just

	return page_mapcount(page) == 1;

Of course, page_mapcount may go up an instant later; but equally,
another vma may get added to the prio_tree an instant later.

It may be that, after much argument to and fro, the whole function will
just reduce to checking "page_mapcount(page) == 1": if so, then I think
you can go back to inlining it literally.

Hugh

> +}
> +
>  /*
>   * Add a page to be migrated to the pagelist
>   */
> @@ -558,11 +589,17 @@ static void migrate_page_add(struct vm_a
>  	struct page *page, struct list_head *pagelist, unsigned long flags)
>  {
>  	/*
> -	 * Avoid migrating a page that is shared by others and not writable.
> +	 * MPOL_MF_MOVE_ALL migrates all pages. However, migrating all
> +	 * pages may also move commonly shared pages (like for example glibc
> +	 * pages referenced by all processes). If these are included in
> +	 * migration then these pages may be uselessly moved back and
> +	 * forth. Migration may also affect the performance of other
> +	 * processes.
> +	 *
> +	 * If MPOL_MF_MOVE_ALL is not set then we try to avoid migrating
> +	 * these shared pages.
>  	 */
> -	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
> -	    mapping_writably_mapped(page->mapping) ||
> -	    single_mm_mapping(vma->vm_mm, page->mapping))
> +	if ((flags & MPOL_MF_MOVE_ALL) || migration_check(vma->vm_mm, page))
>  		if (isolate_lru_page(page) == 1)
>  			list_add(&page->lru, pagelist);
>  }
