Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWAXRtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWAXRtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWAXRtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:49:41 -0500
Received: from silver.veritas.com ([143.127.12.111]:44710 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932465AbWAXRtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:49:40 -0500
Date: Tue, 24 Jan 2006 17:50:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
In-Reply-To: <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]>
Message-ID: <Pine.LNX.4.61.0601241604550.4262@goblin.wat.veritas.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
 <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Jan 2006 17:49:39.0444 (UTC) FILETIME=[8C577B40:01C6210E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Dave McCracken wrote:
> --On Friday, January 20, 2006 21:24:08 +0000 Hugh Dickins
> <hugh@veritas.com> wrote:
> 
> I'll look into getting some profiles.

Thanks, that will help everyone to judge the performance/complexity better.

> The pmd level is important for ppc because it works in segments, which are
> 256M in size and consist of a full pmd page.  The current implementation of
> the way ppc loads its tlb doesn't allow sharing at smaller than segment
> size.

Does that make pmd page sharing strictly necessary?  The way you describe
it, it sounds like it's merely that you "might as well" share pmd page,
because otherwise would always just waste memory on PPC.  But if it's
significantly less complex not to go to that level, it may be worth that
waste of memory (which would be a small fraction of what's now wasted at
the pte level, wouldn't it?).  Sorry for belabouring this point, which
may just be a figment of my ignorance, but you've not convinced me yet.

And maybe I'm exaggerating the additional complexity: you have, after
all, been resolute in treating the levels in the same way.  It's more
a matter of offputting patch size than complexity: imagine splitting
the patch into two, one to implement it at the pte level first, then
a second to take it up to pmd level, that would be better.

> I needed a function that returns a struct page for pgd and pud, defined in
> each architecture.  I decided the simplest way was to redefine pgd_page and
> pud_page to match pmd_page and pte_page.  Both functions are pretty much
> used one place per architecture, so the change is trivial.  I could come up
> with new functions instead if you think it's an issue.  I do have a bit of
> a fetish about symmetry across levels :)

Sounds to me like you made the right decision.

> >> +#define	pt_decrement_share(page)
> >> +#define pt_shareable_vma(vma)	(0)
> >> +#define	pt_unshare_range(vma, address, end)
> >> +#endif /* CONFIG_PTSHARE */
> > 
> > Please keep to "#define<space>MACRO<tab(s)definition" throughout:
> > easiest thing would be to edit the patch itself.
> 
> Sorry.  Done.  I thought the standard was "#define<TAB>" like all the other
> C code I've ever seen.  I didn't realize Linux does it different.

No, I can't claim "#define<space>" is a Linux standard: I happen to
prefer it myself, and it seems to predominate in the header files I've
most often added to; but I was only trying to remove the distracting
inconsistency from your patch, whichever way round.

> >>  static inline int copy_pmd_range(struct mm_struct *dst_mm, struct
> >>  mm_struct *src_mm, pud_t *dst_pud, pud_t *src_pud, struct
> >>  		vm_area_struct *vma,
> >> -		unsigned long addr, unsigned long end)
> >> +		unsigned long addr, unsigned long end, int shareable)
> >>  {
> > 
> > I'd have preferred not to add the shareable argument at each level,
> > and work it out here; or is that significantly less efficient?
> 
> My gut feeling is that the vma-level tests for shareability are significant
> enough that we only want to do them once, then pass the result down the
> call  stack.  I could change it if you disagree about the relative cost.

I now think cut out completely your mods from copy_page_range and its
subfunctions.  Given Nick's "Don't copy ptes..." optimization there,
what shareable areas will reach the lower levels?  Only the VM_PFNMAP
and VM_INSERTPAGE ones: which do exist, and may be large enough to
qualify; but they're not the areas you're interested in targetting,
so I'd say keep it simple and forget about shareability here.  The
simpler you keep your patch, the likelier it is to convince people.

And that leads on to another issue which occurred to me today, in
reading through your overnight replies.  Notice the check on anon_vma
in that optimization?  None of your "shareable" tests check anon_vma:
the vm_flags shared/write check may be enough in some contexts, but
not in all.  VM_WRITE can come and go, and even a VM_SHARED vma may
have anon pages in it (through Linus' strange ptrace case): you must
keep away from sharing pagetables once you've got anonymous pages in
your vma (well, you could share those pagetables not yet anonymized,
but that's just silly complexity).  And in particular, the prio_tree
loop next_shareable_vma needs to skip any vma with its anon_vma set:
at present you're (unlikely but) liable to offer entirely unsuitable
pagetables for sharing there.

(In the course of writing this, I've discovered that 2.6.16-rc
supports COWed hugepages: anonymous pages without any anon_vma.
I'd better get up to speed on those: maybe we'll want to allocate
an anon_vma just for the appropriate tests, maybe we'll want to
set another VM_flag, don't know yet... for the moment you ignore
them, and assume anon_vma is the thing to test for, as in 2.6.15.)

One other thing I forgot to comment on your patch: too many largish
inline functions - our latest fashion is only to say "inline" on the
one-or-two liners.

Hugh
