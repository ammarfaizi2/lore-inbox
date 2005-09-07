Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVIGMA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVIGMA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVIGMA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:00:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:14742 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751191AbVIGMA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:00:56 -0400
Date: Wed, 7 Sep 2005 13:00:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection
 support (for UML), try 3
In-Reply-To: <200509042110.01968.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
 <Pine.LNX.4.61.0509022201020.11937@goblin.wat.veritas.com>
 <200509042110.01968.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Sep 2005 12:00:45.0832 (UTC) FILETIME=[C7848880:01C5B3A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Sep 2005, Blaisorblade wrote:
> On Friday 02 September 2005 23:02, Hugh Dickins wrote:
> > On Fri, 26 Aug 2005, Blaisorblade wrote:
> > > * The first 2 patches modify the PTE encoding macros and start preparing
> > > the VM for the new situation (i.e. VMA which have variable protections,
> > > which are called VM_NONUNIFORM. I dropped the early VM_MANYPROTS name).
> 
> > What a pity: please revert.  VM_NONUNIFORM sounds impressive, but might
> > mean all kinds of things, maybe to do with NUMA.  VM_MANYPROTS is good,
> > it says what it means.
> Ok. Btw, before I forget: I assume I should redo the patches rather than fix 
> what you say on top of mine, (at least when not changing behaviour), right?

If it's something pervasive, like such naming, then yes you should redo
the patches.  Minor local corrections can be appended as an additional
patch, so long as they don't make the original patch ridiculous.

I don't understand your "(at least when not changing behaviour)":
if you mean that significant changes of behaviour should be done as extra
patches at the end, no: surely they should be patches of the main sequence.

All of this supposes that my opinion is to be followed.
I've given my opinions, Andi gave his, I don't remember others.
It doesn't mean any one of us is right.  Did you agree with mine?

> > "Inherit" is about parents and children, this is not; and furthermore,
> > some UNIXes had a MAP_INHERIT (see asm-alpha/mman.h) which was about
> > passing an mmap across exec.  Your MAP_NOINHERIT has nothing to do
> > with that.  MAP_MANYPROTS would help us to follow the trail more
> > easily (though it's true that you can't actually pass many prots
> > in to a single remap_file_pages call).
> MAP_CHGPROT? MAP_CHANGEPROT? MAP_REPROT?
> VM_MANYPROTS is internal name, so there's no reason to have the same name 
> either.

It doesn't have to be the same name, true, but I find it a lot easier
to follow the trail of functionality when similar naming is used.
Perhaps the "PROT" part is enough: MAP_SETPROT or MAP_CHGPROT or
MAP_CHANGEPROT if you don't like MAP_MANYPROTS.

> It's just what you remarked above. But we'd have separate macros and code 
> paths (not hugely separate): use the old macro version if VM_MANYPROTS clear, 
> use the new one if VM_MANYPROTS set.

I think those macros are grotesque enough already.
But I don't have a constructive suggestion.

> > No, I think I disagree with your choice here.  A reasonable person,
> > doing a successful, prohibitive (e.g. remove write access) mprotect
> > on a range, would expect those prohibitions then to be enforced across
> > the range.  Whereas you're letting existing entries (whether present
> > or paged out) retain the permissions they were given earlier with
> > remap_file_pages.
> A reasonable person using VM_MANYPROTS must study the new API anyway - and if 
> he went even to the trouble of writing twice the code to support even older 
> kernels (UML does), and he wants to prohibit access to a range, he'd rather 
> go with remap_file_pages (PROT_NONE), which does exactly what you expect, or 
> it would waste the advantage of avoiding VMA splitting.

We disagree quite strongly on what's reasonable for mprotect to do,
if it's to do anything interesting at all: we could indeed define it
to do special new things for this case (sorry, I've cut your suggestions),
but I'd much prefer not.

However, it looks like we can agree that for now it needn't do anything
on these areas but give an error.

> > Or, if that would really bloat the implementation (I don't see why,
> > but perhaps the encoding of absent entries, maybe manyprots, maybe
> > nonlinear, might do so), just fail with -EACCES when sys_mprotect
> > meets a manyprots vma, until someone asks for better.
> That is reasonable; -EINVAL makes more sense for me in this case (why 
> permission denied?)

But can we agree on which error?  I avoided -EINVAL, partly because it's
a very overloaded error code (perhaps the most overloaded of all?), so
often unhelpful to the user; and partly because for mprotect it appears
to relate to invalid PROT flags rather than anything else.  Whereas if
mprotect is applied to a HUGETLB area which it can't do anything with,
-EACCES is currently returned.  So I followed that precedent.

> > > Subject: [patch 06/18] remap_file_pages protection support: support
> > > private vma for MAP_POPULATE
> 
> > > Fix MAP_POPULATE | MAP_PRIVATE. We don't need the VMA to be shared if we
> > > don't rearrange pages around. And it's trivial to do.
> 
> > This seems reasonable to me.  I was afraid you were going to extend
> > VM_NONLINEAR to private maps, but no, you're just letting private maps
> > be populated linearly, that's fine.
> Would that be a real problem, when limited to readonly mappings?
> There's some interest in that, for library loading - a binary with 100 dso's 
> has 300 vmas...

You seem to see vmas as nothing but obstacles.  Perhaps there is a reason
we divide the mm into vmas?  But perhaps there is a better way of doing it.

Regarding nonlinear readonly.  I never asked Ingo why he excluded it -
suspect he didn't intend to, but missed the peculiar treatment of VM_SHARED
versus VM_MAYSHARE - my apologies, Ingo, if I'm underestimating you!  But
I was glad he had because it demands write access to the file being mapped
nonlinear.  Therefore the ordinary user cannot map libc.so nonlinear, and
condemn all users to the sledgehammer fashion of try_to_unmap_cluster.

Though thinking through that again now, the user of the nonlinear vma
is penalized, and the whole system is penalized by the difficulty in
reclaiming efficiently, but I don't see the other users of the library
particularly penalized (they might be unfairly advantaged by having its
pages stay unnaturally long in memory).  Either I was wrong before, or
I'm missing another aspect of it now: I don't know which.

> > And resist adding a preliminary VM_MANYPROTS check to each fault
> > handler.  Let's say instead that the mmap/mprotect permissions are the
> > maximum that the area can take (and therefore modify the check done on
> > prots in sys_remap_file_pages, to make sure they do not exceed "default").
> 
> > Would that work out?
> No, absolutely not, I'm sorry. Since I may have sparse mappings (I'll use this 
> to emulate TLBs), we have a huge PROT_NONE mapping and then remap individual 
> pages, after their allocation, at fault time, with more permissive settings.

I think I get the picture now: you start with a dark sky, then insert the
stars one by one.  Yes, I accept what I proposed would be of no use to you.

Okay, so as well as the VM_FAULT_SIGSEGV case, you do need to add that
preliminary check to each arch.

So far as I can see (I may have missed it), you really don't need to
change from the write boolean (perhaps -1 for exec in one arch??) to the
write_access mask: it's not a bad change, but the less you have to modify
each of the architectures, the better for now.

> That check may be moved later, to beginning of bad_area, if you say "default 
> prots are the minimum one, I can only remap with more permissive settings". 
> That would avoid affecting the fast path - even if the branch is clearly an 
> "unlikely" one, so shouldn't give mispredictions at least.

Would it?  Anyway, although it fits with UML's particular usage (starting
from PROT_NONE), your minimum permissions idea seems neither natural nor
useful to me (and I don't think you're convinced by it either, just trying
to offer a constructive alternative).

No, just stick with the "unlikely" test in the obvious place where you
already put it, and leave it for later optimization to rearrange that if
necessary: perhaps Christoph L will want modify the ia64 path, to move
that test down into the bad_area handling, to jump back if manyprots;
but no need for spaghetti in the initial implementation.

> > And I think there's a serious flaw in handle_pte_fault, where it says
> 
> > > +	/* VM_NONUNIFORM vma's have PTE's always installed with the correct
> > > +	 * protection. So, generate a SIGSEGV if a fault is caught there. */
> > > +	if (unlikely(vma->vm_flags & VM_NONUNIFORM))
> > > +		goto out_segv;
> 
> > Consider two threads faulting on the same pte on different cpus.
> > One of them fixes it up, you're giving the other SIGSEGV?
> > I think this runs quite deep and will need a rework.
> Not so deep.
> Weeeell, I was ready to ripping this out (even if for other reasons), I assume 
> that comparing write_access/access_mask and the protections in the PTE is 
> perfectly ok and fixes this.

Probably, yes.  Let's see what you come up with next and think it over.

> > Sorry, I do not know when I can next face going over this,
> > it's a hard task for me: perhaps someone else can take over.
> For me is ok - just tell Andrew who should be appointed at this. There's not 
> an "official" list of VM maintainers anywhere, even if I'm under the 
> impression you're currently the top one.

Mercifully for you, me and Linux, no.  Andrew was mm maintainer when he
started the -mm tree, and remains so.  But obviously he has a very heavy
load, and may look to others for opinions.  He didn't ask me on this,
but remap_file_pages does fall into one of my areas of concern, so I
felt obliged to give my opinions.  I guess that I shall have to look
at a later version, but I badly need to focus on the page_table_lock
again before spending time elsewhere: I get very sick of holding up
other people's requirements, but yours is not the first in line.

Hugh
