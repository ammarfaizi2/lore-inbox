Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUCMRd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUCMRd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:33:27 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25351
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263135AbUCMRdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:33:06 -0500
Date: Sat, 13 Mar 2004 18:33:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
Message-ID: <20040313173348.GI30940@dualathlon.random>
References: <Pine.LNX.4.44.0403130942200.15971-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0403130759150.1045@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403130759150.1045@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 08:18:48AM -0800, Linus Torvalds wrote:
> 
> 
> Ok, guys,
>  how about this anon-page suggestion?
> 
> I'm a bit nervous about the complexity issues in Andrea's current setup, 
> so I've been thinking about Rik's per-mm thing. And I think that there is 
> one very simple approach, which should work fine, and should have minimal 
> impact on the existing setup exactly because it is so simple.
> 
> Basic setup:
>  - each anonymous page is associated with exactly _one_ virtual address, 
>    in a "anon memory group". 
> 
>    We put the virtual address (shifted down by PAGE_SHIFT) into 
>    "page->index". We put the "anon memory group" pointer into 
>    "page->mapping". We have a PAGE_ANONYMOUS flag to tell the
>    rest of the world about this.
> 
>  - the anon memory group has a list of all mm's that it is associated 
>    with.
> 
>  - an "execve()" creates a new "anon memory group" and drops the old one.
> 
>  - a mm copy operation just increments the reference count and adds the 
>    new mm to the mm list for that anon memory group.

This is the anonmm from Hugh.

> 
> So now to do reverse mapping, we can take a page, and do
> 
> 	if (PageAnonymous(page)) {
> 		struct anongroup *mmlist = (struct anongroup *)page->mapping;
> 		unsigned long address = page->index << PAGE_SHIFT;
> 		struct mm_struct *mm;
> 
> 		for_each_entry(mm, mmlist->anon_mms, anon_mm) {
> 			.. look up page in page tables in "mm, address" ..
> 			.. most of the time we may not even need to look ..
> 			.. up the "vma" at all, just walk the page tables ..
> 		}
> 	} else {
> 		/* Shared page */
> 		.. look up page using the inode vma list ..
> 	}
> 
> The above all works 99% of the time.

this is again exactly the anonmm from Hugh.

BTW, (for completeness) I was thinking last night that the anonmm could
handle mremap correctly too in theory without changes like the below
one, if it would walk the whole list of vmas reachable from the mm->mmap
for every mm in the anonmm (your anongroup, Hugh called it struct anonmm
instead of struct anongroup). Problem is that checking all the vmas in
if expensive and a single find_vma is a lot faster, but find_vma has no
way to take vm_pgoff into the equation and in turn it breaks with
mremap.

> The only problem is mremap() after a fork(), and hell, we know that's a
> special case anyway, and let's just add a few lines to copy_one_pte(),
> which basically does:
> 
> 	if (PageAnonymous(page) && page->count > 1) {
> 		newpage = alloc_page();
> 		copy_page(page, newpage);
> 		page = newpage;
> 	}
> 	/* Move the page to the new address */
> 	page->index = address >> PAGE_SHIFT;
> 
> and now we have zero special cases.

you're basically here saying that you agree with Hugh that anonmm is the
way to go, and you're providing one of the possible ways to handle
mremap correctly with anonmm (without using pte_chains). I also above
provided another alternate way to handle mremap correctly with anonmm
(that is to inefficiently walk all the mm->mmap and to try unmapping
from all vmas with vma->vm_file == NULL).

what I called anon_vma_global in a older email is the more efficient
version of checking all the vmas in the mm->mmap, a prio_tree could
index all the anon vmas in each mm, so taking vm_pgoff into
consideration, unlike find_vma(page->index). That still takes memory for
each vma though, and it also still forces to check all unrelated mm
address spaces too (see later in the email for details on this).

But returning to your proposed solution to the mremap problem with
the anonmm design, that will certainly work: rather than trying to
handle that case correctly we just makes it impossible for that
condition to happen. I don't like very much to unshare pages, but it may
save more memory than what it actually waste. Problem is that it depends
on the workload.

The remaining downside of all the global anonmm designs vs my finegrined
anon_vma design, is that if you execute a malloc in a child (that will
be direct memory with page->count == 1), you'll still have to try all
the mm in the anongroup (that can be on the order of the thousands),
while the anon_vma design would immediatly only reach the right vma in
the right mm and it would not try the wrong vmas in the other mm (i.e.
no find_vma). That isn't fixable with the anonmm design.

I think the only important thing is to avoid the _per-page_ overhead of the
pte_chains, a _per-vma_ 12 byte cost for the anon_vma doesn't sound like
an issue to me if it can save significant cpu in a setup with thousand
of tasks and each one executing a malloc. A single vma can cover
plenty of memory.

Note that even the i_mmap{,shared} methods (even with a prio_tree!) may
actually check vmas and (in turn mm_structs too) where the page has been
sobstituted with an anonymous copy during a cow fault, if the vma has
been mapped with MAP_PRIVATE. While we cannot avoid to check unrelated
mm_structs with MAP_PRIVATE usages (since the only thing where we have
that information is the pte itself, so by the time we find the answer
it's too late to avoid asking the question), but I can avoid that for
the anonymous memory with my anon_vma design. And my anon_vma gets
mremap right too without the need of prio trees like the anon_vma_global
design I proposed requires, and while still allowing sharing of pages
through mremap.

the downsides of anon_vma vs anonmm+linus-unshare-during-mremap is
that anon_vma requires a per anonymous vma 12 byte object, and secondly it
requires 12 bytes per-vma for the anon_vma_node list_head and the
anon_vma pointer. So it's a worst case 24byte overhead per anonymous
vma (on average it will be slightly less since the anon_vmas can be
shared). Secondly anon_vma forbids merging of vmas with different
anon_vma or with different vm_pgoff, though for all appends there will
be no problem at all, appends with mmap are guaranteed to work. A
munmap+mmap gap creation and gap fill is also guaranteed to work (since
split_vma will make both the prev and next vma share the same anon_vma).

the advantage of anon_vma is that it will track all vma in the most
possible finegrined way, avoiding the unmapping code to walk "mm" that
for sure don't have anything to do with the page that we want to unmap,
plus it handles mremap (allowing sharing and avoiding copies). It avoids
the find_vma cost too.

I'm not sure if the pros-cons worth the additional 24 bytes per
anonymous vma. the complexity doesn't worry me though. Also when the
cost will be truly 24 bytes we'll have the biggest advantage, if the
advantage will be low it means the cost will be less than 24 bytes since
the vma is shared.

> What do you think? To me, this seems to be a really simple approach..

I certainly agree it's simpler. I'm quite undecided if to giveup on the
anon_vma and to use anonmm plus your unshared during mremap at the
moment, while it's simpler it's also a definitely inferior solution
since it uses the mremap hack to work safely and it will check all mm
in the group with find_pte not matter if it worth checking them, but at
the same time if one is never swapping and never using mremap it will
save some memory from the anon_vma overhead (and it will also be
non-exploitable without the need of a prio_tree).

With anon_vma and w/o a prio_tree on top of it, one could try executing
a flood of vma_splits, and without a prio_tree on top of an anon_vma,
that could cause memory waste during swapping, but all real applications
would definitely swap better with anon_vma than with anonmm.

I mean, I would expect the pte_chain advocates to agree anon_vma is a lot
better than anonmm, they were going to throw 8 bytes per-pte to save cpu
during swapping, now I throw only 24 bytes per-vma at the problem (with
each vma being still extendable with merging) and I still provide
optimal swapping with minimal complexty, so they should like the
finegrined way more than unsharing with mremap and not scaling during
swapping checking all unrelated mms too. anon_vma basically sits in
between anonmm and pte_chains. it was more than enough for me, to save all
the memory wasted in the pte_chains on the 64bit archs with huge
anonymous vma blocks, but I didn't want to giveup the swap scalability
either with many processes (with i_mmap{,shared} we've already enough
troubles with the scalability during swapping that I didn't want to
think about those issues with the anonymous memory too with some
thousand tasks like it will run in practice). If I go stright ahead with
anon_vma I'm basically guaranteed that I can forget about the anonymous
vma swapping and that all real life apps will scale _as_well_ as with the
pte_chains, and I'm guaranteed not to run into issues with mremap
(though I don't expect troubles there).
