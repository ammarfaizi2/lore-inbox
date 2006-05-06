Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWEFPZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWEFPZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 11:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEFPZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 11:25:20 -0400
Received: from gold.veritas.com ([143.127.12.110]:5176 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750860AbWEFPZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 11:25:19 -0400
X-IronPort-AV: i="4.05,95,1146466800"; 
   d="scan'208"; a="59272592:sNHT35286108"
Date: Sat, 6 May 2006 16:25:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Dave McCracken <dmccr@us.ibm.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
In-Reply-To: <57DF992082E5BD7D36C9D441@[10.1.1.4]>
Message-ID: <Pine.LNX.4.64.0605061620560.5462@blonde.wat.veritas.com>
References: <1146671004.24422.20.camel@wildcat.int.mccr.org>
 <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com>
 <57DF992082E5BD7D36C9D441@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 May 2006 15:25:18.0812 (UTC) FILETIME=[485669C0:01C67121]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, Dave McCracken wrote:
> 
> The changes should be relatively minor.  Just a tweak to the unshare
> locking and some extra code to handle hugepage copy_page_range, mostly.

I didn't pay any attention to 1/2, the pxd_page/pxd_page_kernel patch.
It was well worth separating that one out, really helps to reduce the
scale and worry of the main patch.

Notice recent mails suggesting it's the answer to a pud_page anomaly:
I hadn't realized the type of pud_page varies from arch to arch, that's
horrid: if you're sorting it out, then please make that clear in the
comment and push it forward.

Though I notice only a couple of instances of pxd_page_kernel outside of
include/asm-* in 2.6.17-rc: I now think you'd do much better not to
propagate that obscure _kernel suffix further, but go for pxd_page_vaddr
(or suchlike) throughout instead: more change, but much clearer.

I do agree with Christoph that you'd do well to separate out the hugetlb
part of the main patch.  Not just for the locking, more because that's
become such a specialist and fast-moving area recently.  I didn't pay
attention to that part of 2/2 either, but got the impression that your
patch has not kept up with the changes there.

Let me say (while perhaps others are still reading) that I'm seriously
wondering whether you should actually restrict your shared pagetable work
to the hugetlb case.  I realize that would be a disappointing limitation
to you, and would remove the 25%/50% improvement cases, leaving only the
3%/4% last-ounce-of-performance cases.

But it's worrying me a lot that these complications to core mm code will
_almost_ never apply to the majority of users, will get little testing
outside of specialist setups.  I'd feel safer to remove that "almost",
and consign shared pagetables to the hugetlb ghetto, if that would
indeed remove their handling from the common code paths.  (Whereas,
if we didn't have hugetlb, I would be arguing strongly for shared pts.)

Patch 2/2 does look cleaner than before, and dropping PTSHARE_PUD has
helped to make it all simpler.

But you've not yet added the rss accounting: that's going to make it
quite a lot nastier.  An argument for sticking just to the hugetlb case:
although hugetlb accounts rss at present, I think we could justify not
doing so (though hugetlb rss is more relevant now it's not prefaulted).
However, I'll continue commenting on your non-hugetlb modifications.

A lot of page migration work has come into the tree (in mm/mempolicy.c
and mm/migrate.c) since 2.6.15: an optimistic guess would be that all
you need do there is skip shared pagetables unless MPOL_MF_MOVE_ALL
(as page_mapcount > 1 pages would be skipped).  You don't have to
worry about the pagetable becoming shared after you've tested: it's
already accepted that what's initially tested may change later (and
your rmap.c changes should cover the wider TLB flushing needed).

Naming: pt_check_unshare_pxd, I think better call them pt_unshare_pxd;
ah, you've already got pt_unshare_pxd, which is similar but different.
That's confusing - forced upon you by pagetable folding peculiarities?
I'd rather have just one copy of that central locking code.

You've generally been helpful with your underscores: one exception is
pt_vmashared: pt_sharing_vma?  Ah, it's supposed to be gone from the
latest version, but one trace remains - please delete that.  ptshare.h
contains more declarations/definitions never used, pt_increment_pte,
pt_decrement_pte, pt_increment_pmd, pt_decrement_pmd at least: please
check and delete what you're not actually using.

Compiler warns "value computed is not used" on the "*shared++;" lines
in page_check_address: should be "(*shared)++;".  So at present the
shared path in rmap.c has not really been tested.

page_referenced_one needs to skip decrementing *mapcount when shared:
the vma prio_tree search will bring it back again and again to the
same shared pagetable, though that pte is only counted once in mapcount:
so it's currently liable to break out too early, missing other entries.

try_to_unmap_one will now be flushing TLB on all cpus for each shared
pagetable entry it unmaps, where often (seeing inactive mm) it wouldn't
have needed to flush TLB at all; but that might work out on balance,
it won't be finding so many entries to unmap.

The prio_tree_iter_inits in pt_share_pte and pt_share_pmd should limit
their scope to the range of the pagetable involved, not the whole vma.
next_shareable_vma likewise?  I thought so at first, but perhaps its
check for a similar vma often avoids immediate unsharing.
Optimizations only, you've probably had them in mind for later.

I mentioned the off-by-one in pt_shareable_pte and pt_shareable_pmd
before: ought to say "vma->vm_end - 1 >= end"; but must admit that's
nitpicking, since vm_end is PAGE_SIZE aligned anyway, so no real
issue can arise - fix it to help stop others worrying later?

Whereas pt_share_pte and pt_share_pmd have the complementary issue:
"end = base + PXD_SIZE" may wrap to 0, so you need to -1 somewhere
(but you won't need base and end if pt_trans_start/end go away).
pt_share_pte and pt_share_pmd: preferable to swap around their pxd
and address arguments, so they resemble what they're replacing.

pt_shareable now has the same off-by-one too: or would have, but
"end = base + (mask-1)" is quite wrong, isn't it?  base + ~mask?
Move those calculations lower down, after the common tests?  or
do compiler and processor nowadays optimize such orderings well?
And there's a leftover "vmas in transition" comment on vm_flags.

pt_shareable is still not rejecting if vma->anon_vma is set: it's
quite possible for a vm_file vma to be private and writable, gather
some COW pages, and then be mprotected to readonly, so passing the
vm_flags test - but its pagetables must not be shared.

VM_PTSHARE came and went, good, you never had the mmap_sem needed
to set it.  VM_TRANSITION came and went, you've replaced it by the
mm->pt_trans_start, pt_trans_end.  At first I thought that a big
improvement, now I'm not so sure.  If they stay, those added fields
should be under #ifdef so as not to enlarge the basic mm_struct.

I'd prefer something other than "lock" in pt_unshare_lock_range
and pt_unlock_range, but I think I'm going to suggest you go back
to using pt_unshare_range alone: let's look at the three callsites.

sys_remap_file_pages: doesn't really need the locked range, you could
just call pt_unshare_range a little lower down, once i_mmap_lock taken.

mprotect_fixup: that does need some protection, yes, because the pte
protections are out-of-synch with the vm_flags for a while (in a way
that's okay for the owning mm, but not for "parasites" wanting to share).
Please move the pt_unshare_lock_range (or whatever) down above vma_merge,
so you can remove the pt_unlock_range from the -ENOMEM case above it.

mremap move_vma: not good enough, you're unsharing and locking the old
range, but you also need to lock the new range before copy_vma, to hold
it unshared too; which could be done, though not with the interfaces
you've provided.  (The VM_TRANSITION version was insufficient too, and
cleared the flag at a point where "vma" might already have been freed.)

Are those the only places which need this range locking?  I was worried
at first that there might be more, then I came around to thinking you'd
identified the right places, now suddenly I see pt_check_unshare_pxd in
zap_pxd_range as vulnerable: the vma remains in the prio_tree, so it
might immediately get shared again; what the zapping does is not wholly
wrong, but its TLB flushing would be inadequate if the table has become
shared in the meantime.  Or am I mistaken?

Unless you have firm performance evidence to the contrary, on a workload
that you're seriously trying to address, I suggest you drop the range
locking transitional stuff, and down_read_trylock(&svma->vm_mm->mmap_sem)
in (or near calls to) next_shareable_vma instead.  That will fail more
often than your transitional checks, but give much stronger assurance
that nothing funny is going on in the vma found.

But do you then need to add down_write(&mm->mmap_sem) in exit_mmap, if
pagetable sharing is enabled? currently I believe so.  But then, I think,
you can remove the pt_check_unshare_pxd from free_pyd_range: odd how it
was doing those once in the unmap_vmas path, then again in the
free_pgtables path - what was your thinking there?  Yes, the pagetable
may have gotten reshared in between, but the TLB flushing would already
be inadequate if so.

I admire the simplicity of the way you just unshare when you have to,
letting faults fill back in lazily; but does that have a problem in the
case of a VM_LOCKED vma, losing the guarantees mlock should be giving?

I read through a lot of old mails while reviewing, going back to Daniel's
first implementation in 2002.  The most interesting remark I found (and
have lost again) was one from wli, questioning the locking required when
changing *pmd.  Hmm, let's look at your pt_check_unshare_pte (similar
remarks apply to pt_check_unshare_pmd, pt_unshare_pte, pt_unshare_pmd),
there's a lot to question in that locking.

Well, the locking that you do have, it's unclear why you're using the
spinlock in the pagetable struct page there: doesn't it amount to?
	page = pmd_page(*pmd);
	if (atomic_add_unless(&page->_mapcount, -1, -1))
		return 0;
	pmd_clear_flush(mm, address, pmd);
	return 1;
Ah, probably atomic_add_unless wasn't available when you wrote it.

But then what of the "Oops, already mapped" pt_decrement_share in
pt_share_pte?  That's under different locking (rightly, the level
above, since the question there is whether a racing thread has set
*pmd): what happens if that decrement brings the share count down to,
umm, something awkward - hard to be specific, partly because of how
_mapcount starts from -1, partly because you've gone for a share count
rather than a reference count - I understand that you were avoiding the
overhead of maintaining another reference count on the common path, but
it leaves me deeply suspicious, I fear it's hiding bugs.

I'd agree it'll be rare (usually the racing thread will have found the
same pagetable to share as we have, and so raised its share count), but
I do believe that pt_decrement_share can go wrong: the process that had
that pagetable may be exiting, find it shared in its pt_check_unshare_pte
so skip zapping, then we're left with that pagetable to free - but we do
nothing other than decrement the count one too far.  I think that will
get fixed by pt_share_pte holding i_mmap_lock and its down_read_trylock
of svma->vm_mm->mmap_sem across the lower block: then it only needs to
pt_increment_share when all's well at the end, the decrement case gone.
pte_lock nests within i_mmap_lock, should be fine for pmd_lock also.

Now, back to the question of the pmd_clear_flush: currently, we may add
a valid entry *pmd at any time, but we only clear it in free_pgtables,
after all occupying vmas have been removed from anon_vma and prio_tree.
You're relaxing that; most paths are protected by holding mmap_sem, but
file truncation and rmap lookup are not.  The easiest protection against
races here is to hold i_mmap_lock, since both unmap_mapping_range and
page_check_address do (but slightly messy since the unmap_mapping_range
path must then avoid retaking it in the pt_check_unshares).  If you're
taking i_mmap_lock in pt_check_unshare_pte etc, you could then skip the
atomic_add_unless I was suggesting above, revert to your existing
structure but using i_mmap_lock instead of pmd_page ptl.

Except, you must not drop the lock until after your pmd_clear_flush
(which only needs flush_tlb_mm, doesn't it, rather than flush_tlb_all?).
Because once you drop the lock, the process you were sharing with could
unmap and free all the pages, and not knowing it had been sharing, only
flush for its own mm - other threads of your process might be able to
access those pages after they were freed by the other.

I don't suppose extending the use of i_mmap_lock as I suggest will be
popular, it's liable to reduce your scalability: I'm more pointing to
an obvious way to fix some problems than necessarily the end solution.

Please don't interpret these detailed comments as meaning that I think
your patch is almost ready: I'm afraid that the longer I spend looking
at it, the more I find to worry about - not a good sign.  (And let me
repeat, I've not looked at the hugetlb end of it at all.)

And though it's easy to find performance advocates in favour of your
patch, it's hard to find kernel hackers who care for maintainability
wanting it in.  And I worry that it will tie our hands, repeatedly
posing a difficulty for other future developments (rather as
sys_remap_file_pages did, or I feared Christoph's pte xchging would).

How was Ray Bryant's shared,anonymous,fork,munmap,private bug of
25 Jan resolved?  We didn't hear the end of that.

Hugh
