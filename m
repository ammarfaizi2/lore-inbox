Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWAXSHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWAXSHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWAXSHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:07:46 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:28077 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1161018AbWAXSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:07:45 -0500
Date: Tue, 24 Jan 2006 12:07:22 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <321DE6430A7C77745B5B8275@[10.1.1.4]>
In-Reply-To: <Pine.LNX.4.61.0601241604550.4262@goblin.wat.veritas.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
 <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]>
 <Pine.LNX.4.61.0601241604550.4262@goblin.wat.veritas.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, January 24, 2006 17:50:17 +0000 Hugh Dickins
<hugh@veritas.com> wrote:

> On Mon, 23 Jan 2006, Dave McCracken wrote:
> 
>> The pmd level is important for ppc because it works in segments, which
>> are 256M in size and consist of a full pmd page.  The current
>> implementation of the way ppc loads its tlb doesn't allow sharing at
>> smaller than segment size.
> 
> Does that make pmd page sharing strictly necessary?  The way you describe
> it, it sounds like it's merely that you "might as well" share pmd page,
> because otherwise would always just waste memory on PPC.  But if it's
> significantly less complex not to go to that level, it may be worth that
> waste of memory (which would be a small fraction of what's now wasted at
> the pte level, wouldn't it?).  Sorry for belabouring this point, which
> may just be a figment of my ignorance, but you've not convinced me yet.

No, ppc can not share at smaller than segment size at all.  We need pmd
level sharing to get to the 256MB segment size.  Once we can share this
level, there's a whole other feature of ppc that comes into play.  TLB
entries are keyed by segment id, not process, so all processes sharing a
segment can reuse TLB entries for regions they share.  This is only
possible if they share the page table at segment level.

> And maybe I'm exaggerating the additional complexity: you have, after
> all, been resolute in treating the levels in the same way.  It's more
> a matter of offputting patch size than complexity: imagine splitting
> the patch into two, one to implement it at the pte level first, then
> a second to take it up to pmd level, that would be better.
> 
>> I needed a function that returns a struct page for pgd and pud, defined
>> in each architecture.  I decided the simplest way was to redefine
>> pgd_page and pud_page to match pmd_page and pte_page.  Both functions
>> are pretty much used one place per architecture, so the change is
>> trivial.  I could come up with new functions instead if you think it's
>> an issue.  I do have a bit of a fetish about symmetry across levels :)
> 
> Sounds to me like you made the right decision.

I had a thought... would it be preferable for me to make this change as a
separate patch across all archictures in the name of consistency?  Or
should I continue to roll it into the shared pagetable patch as we enable
each architecture?

>> >>  static inline int copy_pmd_range(struct mm_struct *dst_mm, struct
>> >>  mm_struct *src_mm, pud_t *dst_pud, pud_t *src_pud, struct
>> >>  		vm_area_struct *vma,
>> >> -		unsigned long addr, unsigned long end)
>> >> +		unsigned long addr, unsigned long end, int shareable)
>> >>  {
>> > 
>> > I'd have preferred not to add the shareable argument at each level,
>> > and work it out here; or is that significantly less efficient?
>> 
>> My gut feeling is that the vma-level tests for shareability are
>> significant enough that we only want to do them once, then pass the
>> result down the call  stack.  I could change it if you disagree about
>> the relative cost.
> 
> I now think cut out completely your mods from copy_page_range and its
> subfunctions.  Given Nick's "Don't copy ptes..." optimization there,
> what shareable areas will reach the lower levels?  Only the VM_PFNMAP
> and VM_INSERTPAGE ones: which do exist, and may be large enough to
> qualify; but they're not the areas you're interested in targetting,
> so I'd say keep it simple and forget about shareability here.  The
> simpler you keep your patch, the likelier it is to convince people.

I'll look into this in more detail.  It would be nice if I don't have to
deal with it.  I don't want to lose sharing pagetables on fork for normally
shared regions.  If they don't get into copy_page_range, then we'll be fine.

> And that leads on to another issue which occurred to me today, in
> reading through your overnight replies.  Notice the check on anon_vma
> in that optimization?  None of your "shareable" tests check anon_vma:
> the vm_flags shared/write check may be enough in some contexts, but
> not in all.  VM_WRITE can come and go, and even a VM_SHARED vma may
> have anon pages in it (through Linus' strange ptrace case): you must
> keep away from sharing pagetables once you've got anonymous pages in
> your vma (well, you could share those pagetables not yet anonymized,
> but that's just silly complexity).  And in particular, the prio_tree
> loop next_shareable_vma needs to skip any vma with its anon_vma set:
> at present you're (unlikely but) liable to offer entirely unsuitable
> pagetables for sharing there.

I'll have to think through this again.  I'll need to evaluate just what
states a vma can be in, and make sure I catch it at all its transitions out
of what should be shareable.  It sounds like there may be states I didn't
catch the first time.

> (In the course of writing this, I've discovered that 2.6.16-rc
> supports COWed hugepages: anonymous pages without any anon_vma.
> I'd better get up to speed on those: maybe we'll want to allocate
> an anon_vma just for the appropriate tests, maybe we'll want to
> set another VM_flag, don't know yet... for the moment you ignore
> them, and assume anon_vma is the thing to test for, as in 2.6.15.)

Yeah, I've been trying to keep up with the hugepage changes, but they're
coming pretty fast.  I'll look at them again too.

> One other thing I forgot to comment on your patch: too many largish
> inline functions - our latest fashion is only to say "inline" on the
> one-or-two liners.

Ok.  I haven't really kept up with the style du jour for inlining :)

Dave

