Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752002AbWFWWAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbWFWWAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWFWWAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:00:24 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:40159 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752002AbWFWWAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:00:23 -0400
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
	 <1151019590.15744.144.camel@lappy>
	 <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 00:00:17 +0200
Message-Id: <1151100017.30819.50.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 20:06 +0100, Hugh Dickins wrote:

> > -     if (unlikely((vma->vm_flags & (VM_SHARED|VM_WRITE)) ==
> > -                             (VM_SHARED|VM_WRITE))) {
> > +     /*
> > +      * Only catch write-faults on shared writable pages, read-only
> > +      * shared pages can get COWed by get_user_pages(.write=1, .force=1).
> > +      */
> > +     if (unlikely(((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
> > +                                     (VM_WRITE|VM_SHARED)))) {
> 
> I was about to say I'm satisfied with that test now, and it's all the
> better for not mentioning VM_PFNMAP there - though odd that you've
> exchanged WRITE and SHARED, and added extra unnecessary parentheses ;)

Oops, on the extra parentheses. I exchanged the order because that is
more consistent with all the other sites.

> But grrr, sigh, damn, argh - I now realize it's right to the first
> order (normal case) and to the second order (ptrace poke), but not
> to the third order (ptrace poke anon page here to be COWed -
> perhaps can't occur without intervening mprotects).
> 
> That's not an issue for you at all (there are other places which
> are inconsistent on whether such pages are private or shared e.g.
> copy_one_pte does not wrprotect them), but could be a problem for
> David's page_mkwrite - there's a danger of passing it an anonymous
> page, which (depending on what the ->page_mkwrite actually does)
> could go seriously wrong.
> 
> I guess it ought to be restructured
>         if (PageAnon(old_page)) {
>                 ...
>         } else if (shared writable vma) {
>                 ...
>         }
> and a patch to do that should precede your dirty page patches
> (and the only change your dirty page patches need add here on top
> of that would be the dirty_page = old_page, get_page(dirty_page)).

Hmm, I'll investigate this and maybe write a follow-up patch if you or
someone else doesn't beaten me to it.

> (You've probably noticed that use of mprotect on problem vmas
> is liable to remove the cache bits.  There have been occasional
> complaints about that, and perhaps a patch to fix it.  But that's
> long-standing behaviour, so not something you need worry about:
> we've only had to worry about a new change in behaviour in mmap.)

Yeah, had noticed, but had assumed that since it was a user action
they'd know better than to call it on dubious mappings.

However if you say there is demand; I've been through all the arch's to
verify the use of that most ugly drm construct, and whipping up an arch
function like pgprot_modify() that would fold a pgprot_t and
protection_map[] argument together seems quite doable.

> > Page from remap_pfn_range() are explicitly excluded because their
> > COW semantics are already horrid enough (see vm_normal_page() in
> > do_wp_page()) and because they don't have a backing store anyway.
> > 
> > copy_one_pte() cleans child PTEs, not wrong in the current context,
> > but why?
> 
> Dates back to Linux 2.2 if not earlier.  I think the idea is that the
> parent has its pte dirty, and that's enough to mark the page as dirty;
> the child is unlikely to dirty the page further itself, and a second
> instance of dirty pte for that page may entail some overhead.  What
> overhead would vary from release to release, I've not thought through
> what the current saving would be in 2.6.17, probably very little.
> But you can imagine there might have been some release which would
> write out the page each time it found pte dirty, in which case good
> reason to clear it there.  But I'm guessing, it's from before my time.

I'll keep that in mind for a future cleanup.

> > +	if ((pgprot_val(vma->vm_page_prot) == pgprot_val(vm_page_prot) &&
> > +	     ((vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
> > +			  (VM_WRITE|VM_SHARED)) &&
> > +	     vma->vm_file && vma->vm_file->f_mapping &&
> > +	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
> > +	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
> > +		vma->vm_page_prot =
> > +			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
> > +
> 
> I'm dazzled by the beauty of it!

It's a real beauty isn't it :-)

> Given the change you've made to
> mapping_cap_account_dirty, you don't have to check vma->vm_file->f_mapping
> there; but other than that, seems right to me.  May offend other tastes.

I meant to remove the mapping_cap_account_dirty() changes, so as not to
burden all call sites with the extra conditional. This one extra check
in here does not make the difference between beauty and beast.

> > Index: 2.6-mm/mm/rmap.c
> > ===================================================================
> > --- 2.6-mm.orig/mm/rmap.c	2006-06-22 17:59:07.000000000 +0200
> > +++ 2.6-mm/mm/rmap.c	2006-06-23 01:14:39.000000000 +0200
> > +static int page_mkclean_file(struct address_space *mapping, struct page *page)
> > +{
> > +	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
> > +	struct vm_area_struct *vma;
> > +	struct prio_tree_iter iter;
> > +	int ret = 0;
> > +
> > +	BUG_ON(PageAnon(page));
> > +
> > +	spin_lock(&mapping->i_mmap_lock);
> > +	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
> > +		int protect = mapping_cap_account_dirty(mapping) &&
> > +	((vma->vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
> > +	 		  (VM_WRITE|VM_SHARED));
> 
> I think you can forget about testing VM_PFNMAP|VM_INSERTPAGE here,
> or else	BUG_ON or WARN_ON(vma->vm_flags & (VM_PFNMAP|VM_INSERTPAGE)):
> those just shouldn't arrive here.

Done

> But I'm still puzzled, why did you move page_mkclean out from under
> the mapping_cap_account_dirty tests in page-writeback.c: no explanation
> in your change history.  Doesn't that just add some unnecessary work,
> and this "protect" business?

You're right, added back under the wing of mapping_cap_account_dirty().

> If you're thinking ahead to other changes you want to make, you'd
> do better to add these changes then, and for now just work on the
> VM_SHARED vmas.

But I'll leave page_mkclean() as callable without, that way its more
true to its name.

Peter

