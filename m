Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWAWRje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWAWRje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWAWRjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:39:33 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:54707 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S964822AbWAWRjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:39:33 -0500
Date: Mon, 23 Jan 2006 11:39:07 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <6F40FCDC9FFDE7B6ACD294F5@[10.1.1.4]>
In-Reply-To: <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, January 20, 2006 21:24:08 +0000 Hugh Dickins
<hugh@veritas.com> wrote:

> The locking looks much better now, and I like the way i_mmap_lock seems
> to fall naturally into place where the pte lock doesn't work.  But still
> some raciness noted in comments on patch below.
> 
> The main thing I dislike is the
>  16 files changed, 937 insertions(+), 69 deletions(-)
> (with just i386 and x86_64 included): it's adding more complexity than
> I can welcome, and too many unavoidable "if (shared) ... else ..."s.
> With significant further change needed, not just adding architectures.

I've received preliminary patches from people trying other architectures.
It looks like for architectures with a standard hardware page table it's
only a couple of lines for each architecture.

> Worthwhile additional complexity?  I'm not the one to judge that.
> Brian has posted dramatic improvments (25%, 49%) for the non-huge OLTP,
> and yes, it's sickening the amount of memory we're wasting on pagetables
> in that particular kind of workload.  Less dramatic (3%, 4%) in the
> hugetlb case: and as yet (since last summer even) no profiles to tell
> where that improvement actually comes from.

I'll look into getting some profiles.

> Could it be simpler?  I'd love you to chuck out the pud and pmd sharing
> and just stick to sharing the lowest level of pagetable (though your
> handling of the different levels is decently symmetrical).  But you
> told me last time around that sharing at pmd level is somehow essential
> to having it work on ppc64.

You're probably right about the pud sharing.  I did it for completeness,
but it's probably useless.  There's not enough win to be worth the extra
cost of including it.

The pmd level is important for ppc because it works in segments, which are
256M in size and consist of a full pmd page.  The current implementation of
the way ppc loads its tlb doesn't allow sharing at smaller than segment
size.  I currently also enable pmd sharing for x86_64, but I'm not sure how
much of a win it is.  I use it to share pmd pages for hugetlb, as well.

> An annoying piece of work you have yet to do: getting file_rss working.
> You may want to leave that undone, until/unless there's some signal
> that mainline really wants shared pagetables: it's off your track,
> and probably not worth the effort while prototyping.
> 
> I guess what you'll have to do is keep file_rss and anon_rss per
> pagetable page (in its struct page) when split ptlock - which would
> have the benefit that they can revert back from being atomics in that
> case.  Tiresome (prohibitive?) downside being that gatherers of rss
> would have to walk the pagetable pages to sum up rss.
> 
> Unless we can persuade ourselves that file_rss just isn't worth
> supporting any more: tempting for us, but not for those who look at
> rss stats.  Even though properly accounted file_rss becomes somewhat
> misleading in the shared pagetable world - a process which never
> faulted being suddenly graced with thousands of pages.

Yep, I punted on it for now.  I've had a couple of thoughts in that
direction, but nothing complete enough to code.

> A more serious omission that you need to fix soon: the TLB flushing
> in mm/rmap.c.  In a shared pagetable, you have no record of which
> cpus the pte is exposed on (unlike mm->cpu_vm_mask), and so you'll
> probably have to flush TLB on all online cpus each time (per pte,
> or perhaps can be rearranged to do so only once for the page).  I
> don't think you can keep a cpu_vm_mask with the pagetable - we
> wouldn't want scheduling a task to have to walk its pagetables.
> 
> Well, I say "no record", but I suppose if you change the code somehow
> to leave the pte in place when the page is first found, and accumulate
> the mm->cpu_vm_masks of all the vmas in which the page is found, and
> only clear it at the end.  Not sure if that can fly, or worthwhile.

Sigh.  You're right.  In your earlier comments I thought you were
questioning the locking, which didn't seem like an issue to me.  But yeah,
the flushing is a problem.  I do like your thoughts about collecting it up
and doing it as a batch.  I'll chase that some.

>> --- 2.6.15/./arch/x86_64/Kconfig	2006-01-02 21:21:10.000000000 -0600
>> +++ 2.6.15-shpt/./arch/x86_64/Kconfig	2006-01-03 10:30:01.000000000 -0600
>> +config PTSHARE
>> +	bool "Share page tables"
>> +	default y
>> +	help
>> +	  Turn on sharing of page tables between processes for large shared
>> +	  memory regions.
>>
>> (...) more config options.
> 
> I presume this cornucopia of config options is for ease of testing the
> performance effect of different aspects of the patch, and will go away
> in due course.

Most of them are to select different subsets of pt sharing based on
architecture, and aren't intended to be user selectable.

>> --- 2.6.15/./include/asm-x86_64/pgtable.h	2006-01-02 21:21:10.000000000
>> -0600 +++ 2.6.15-shpt/./include/asm-x86_64/pgtable.h	2006-01-03
>> 10:30:01.000000000 -0600 @@ -324,7 +321,8 @@ static inline int
>> pmd_large(pmd_t pte) {
>>  /*
>>   * Level 4 access.
>>   */
>> -#define pgd_page(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd)
>> & PTE_MASK)) +#define pgd_page_kernel(pgd) ((unsigned long)
>> __va((unsigned long)pgd_val(pgd) & PTE_MASK)) +#define pgd_page(pgd)
>> 	(pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT))
> 
> Hmm, so pgd_page changes its meaning: is that wise?  Looks like it isn't
> used much outside of include/ so perhaps you're okay, and I can see the
> attraction of using "_page" for something that supplies a struct page *.
> I can also see the attraction of appending "_kernel" to the other,
> following pte_offset_kernel, but "_kernel" isn't really appropriate.
> Musing aloud, no particular suggestion.

I needed a function that returns a struct page for pgd and pud, defined in
each architecture.  I decided the simplest way was to redefine pgd_page and
pud_page to match pmd_page and pte_page.  Both functions are pretty much
used one place per architecture, so the change is trivial.  I could come up
with new functions instead if you think it's an issue.  I do have a bit of
a fetish about symmetry across levels :)

>> --- 2.6.15/./include/linux/ptshare.h	1969-12-31 18:00:00.000000000 -0600
>> +++ 2.6.15-shpt/./include/linux/ptshare.h	2006-01-03 10:30:01.000000000
>> -0600 +
>> +#ifdef CONFIG_PTSHARE
>> +static inline int pt_is_shared(struct page *page)
>> +{
>> +	return (page_mapcount(page) > 1);
> 
> This looks like its uses will be racy: see further remarks below.

Hmm, good point.  Originally most of the uses were under locks that went
away with the recent changes.  I'll need to revisit all that.

>> +extern void pt_unshare_range(struct vm_area_struct *vma, unsigned long
>> address, +			     unsigned long end);
>> +#else /* CONFIG_PTSHARE */
>> +#define	pt_is_shared(page)	(0)
>> +#define	pt_increment_share(page)
>> +#define	pt_decrement_share(page)
>> +#define pt_shareable_vma(vma)	(0)
>> +#define	pt_unshare_range(vma, address, end)
>> +#endif /* CONFIG_PTSHARE */
> 
> Please keep to "#define<space>MACRO<tab(s)definition" throughout:
> easiest thing would be to edit the patch itself.

Sorry.  Done.  I thought the standard was "#define<TAB>" like all the other
C code I've ever seen.  I didn't realize Linux does it different.

>> +static inline void pt_increment_pte(pmd_t pmdval)
>> +{
>> +	struct page *page;
>> +
>> +	page = pmd_page(pmdval);
>> +	pt_increment_share(page);
>> +	return;
>> +}
> 
> Please leave out all these unnecessary "return;"s.

Done.

>> +static inline int pt_shareable_pte(struct vm_area_struct *vma, unsigned
>> long address) +{
>> +	unsigned long base = address & PMD_MASK;
>> +	unsigned long end = base + (PMD_SIZE-1);
>> +
>> +	if ((vma->vm_start <= base) &&
>> +	    (vma->vm_end >= end))
>> +		return 1;
>> +
>> +	return 0;
>> +}
> 
> I think you have an off-by-one on the end test there (and in similar fns):
> maybe you should be saying "(vma->vm_end - 1 >= end)".

Hmm... you may be right.  I'll stare at it some more.

>> --- 2.6.15/./mm/fremap.c	2006-01-02 21:21:10.000000000 -0600
>> +++ 2.6.15-shpt/./mm/fremap.c	2006-01-03 10:30:01.000000000 -0600
>> @@ -193,6 +194,9 @@ asmlinkage long sys_remap_file_pages(uns
>>  				has_write_lock = 1;
>>  				goto retry;
>>  			}
>> +			if (pt_shareable_vma(vma))
>> +				pt_unshare_range(vma, vma->vm_start, vma->vm_end);
>> +
> 
> I do like the way you simply unshare whenever (or almost whenever) in
> doubt, and the way unsharing doesn't have to copy the pagetable, because
> it's known to be full of straight file mappings which can just be faulted
> back.
> 
> But it's not robust to be using the "pt_shareable_vma" test for whether
> you need to unshare.  Notably the PMD_SIZE part of the pt_shareable_vma
> test is good for deciding whether it's worth trying to share, but not so
> good for deciding whether in fact we are shared.  By all means have an
> inline test for whether it's worth going off to the exceptional unshare
> function, but use a safer test.
> 
> Even if you do fix up those places which reduce the size of the area
> but don't at present unshare.  For example, madvise.c and mlock.c don't
> appear in this patch, but madvise and mlock can split_vma bringing it
> below PMD_SIZE.  It's not necessarily the case that we should then
> unshare, but probably need to at least in the mlock case (since
> try_to_unmap might unmap pte from non-VM_LOCKED vma before reaching
> VM_LOCKED vma sharing the same pagetable).  You might decide it's
> best to unshare in split_vma.

I'll have to think that through a bit more.  I see your point.

>> --- 2.6.15/./mm/memory.c	2006-01-02 21:21:10.000000000 -0600
>> +++ 2.6.15-shpt/./mm/memory.c	2006-01-03 10:30:01.000000000 -0600
>> @@ -110,14 +113,25 @@ void pmd_clear_bad(pmd_t *pmd)
>>   * Note: this doesn't free the actual pages themselves. That
>>   * has been handled earlier when unmapping all the memory regions.
>>   */
>> -static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
>> +static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>> +			   unsigned long addr)
>>  {
>>  	struct page *page = pmd_page(*pmd);
>> -	pmd_clear(pmd);
>> -	pte_lock_deinit(page);
>> -	pte_free_tlb(tlb, page);
>> -	dec_page_state(nr_page_table_pages);
>> -	tlb->mm->nr_ptes--;
>> +	pmd_t pmdval= *pmd;
>> +	int share;
>> +
>> +	share = pt_is_shared_pte(pmdval);
>> +	if (share)
>> +		pmd_clear_flush(tlb->mm, addr, pmd);
>> +	else
>> +		pmd_clear(pmd);
>> +
>> +	pt_decrement_pte(pmdval);
>> +	if (!share) {
>> +		pte_lock_deinit(page);
>> +		pte_free_tlb(tlb, page);
>> +		dec_page_state(nr_page_table_pages);
>> +	}
>>  }
> 
> Here's an example of where using pt_is_shared_pte is racy.
> The last two tasks sharing might find page_mapcount > 1 at the same
> time, so neither do the freeing.  In this case, haven't looked to
> see if it's the same everywhere, you want pt_decrement_pte to
> return the atomic_dec_and_test - I think.  Or else be holding
> i_mmap_lock here and in more places, but that's probably worse.

Yep.  Needs more thought about proper locking/sequencing.  I have a couple
ideas.

>>  	if (pmd_present(*pmd)) {	/* Another has populated it */
>>  		pte_lock_deinit(new);
>>  		pte_free(new);
>>  	} else {
>> -		mm->nr_ptes++;
> 
> So /proc/<pid>/status VmPTE will always be "0 kB"?
> I think you ought to try a bit harder there (not sure if it should
> include shared pagetables or not), guess best left along with rss.

Yep.  I didn't see a simple way of keeping that correct.

>>  static inline int copy_pmd_range(struct mm_struct *dst_mm, struct
>>  mm_struct *src_mm, pud_t *dst_pud, pud_t *src_pud, struct
>>  		vm_area_struct *vma,
>> -		unsigned long addr, unsigned long end)
>> +		unsigned long addr, unsigned long end, int shareable)
>>  {
>>  	pmd_t *src_pmd, *dst_pmd;
>>  	unsigned long next;
>> @@ -531,16 +579,20 @@ static inline int copy_pmd_range(struct 
>>  		next = pmd_addr_end(addr, end);
>>  		if (pmd_none_or_clear_bad(src_pmd))
>>  			continue;
>> -		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
>> -						vma, addr, next))
>> -			return -ENOMEM;
>> +		if (shareable && pt_shareable_pte(vma, addr)) {
>> +			pt_copy_pte(dst_mm, dst_pmd, src_pmd);
> 
> I'd have preferred not to add the shareable argument at each level,
> and work it out here; or is that significantly less efficient?

My gut feeling is that the vma-level tests for shareability are significant
enough that we only want to do them once, then pass the result down the
call  stack.  I could change it if you disagree about the relative cost.

>> @@ -610,6 +676,7 @@ static unsigned long zap_pte_range(struc
>>  	do {
>>  		pte_t ptent = *pte;
>>  		if (pte_none(ptent)) {
>> +
>>  			(*zap_work)--;
>>  			continue;
>>  		}
> 
> An utterly inexcusable blank line!

Yep.  Fixed.  Must have been an interim editing error.

>> --- 2.6.15/./mm/ptshare.c	1969-12-31 18:00:00.000000000 -0600
>> +++ 2.6.15-shpt/./mm/ptshare.c	2006-01-03 10:30:01.000000000 -0600
>> +			spude = *spud;
> 
> I seem to have a strange aversion to the name "spude",
> but you can safely ignore my affliction.

Must be one of those Brit things :)

Dave

