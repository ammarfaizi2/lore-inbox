Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUCLNK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUCLNK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:10:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39693
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261419AbUCLNKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:10:24 -0500
Date: Fri, 12 Mar 2004 14:11:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312131103.GS30940@dualathlon.random>
References: <20040312122127.GQ30940@dualathlon.random> <Pine.LNX.4.44.0403120736420.3576-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403120736420.3576-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 07:40:51AM -0500, Rik van Riel wrote:
> On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> > On Thu, Mar 11, 2004 at 10:28:42PM -0500, Rik van Riel wrote:
> 
> > > Actually, with the code Rajesh is working on there's
> > > no search problem with Hugh's idea.
> > 
> > you missed the fact mremap doesn't work, that's the fundamental reason
> > for the vma tracking, so you can use vm_pgoff.
> > 
> > if you take Hugh's anonmm, mremap will be attaching a persistent dynamic
> > overhead to the vma it touches. Currently it does in form of pte_chains,
> > that can be converted to other means of overhead, but I simply don't
> > like it.
> > 
> > I like all vmas to be symmetric to each other, without special hacks to
> > handle mremap right.
> > 
> > We have the vm_pgoff to handle mremap and I simply use that.
> 
> Would it be possible to get rid of that if we attached
> a struct address_space to each mm_struct after exec(),
> sharing the address_space between parent and child
> processes after a fork() ?

> Note that the page cache can handle up to 2^42 bytes
> in one address_space on a 32 bit system, so there's
> more than enough space to be shared between parent and
> child processes.
> 
> Then the vmas can track vm_pgoff inside the address
> space attached to the mm.

I can't understand sorry.

I don't see what you mean with sharing the same address space between
parent and child, whatever _global_ mm wide address space is screwed by
mremap, if you don't use the pg_off to ofset the page->index, the
vm_start/vm_end means nothing.

I think the anonmm design is flawed and it has no way to handle
mremap reasonably well, though feel free to keep doing research on that,
I would be happy to use a simpler and more efficient design, I just
tried to reuse the anonmm but it was overlay complex in design and
inefficient too to deal with mremap, so I had not much doubts I had to
change that, and the anon_vma idea solved all the issues with anonmm, so
I started coding that.

If you don't track by vmas (like I'm doing), and you allow merging of
two different vmas, one touched by mremap and the other not, you'll end
up mixing the vm_pgoff and the whole anonmm falls apart, and the tree
search falls apart too after you lost the vm_pgoff of the vma that got
merged.

Hugh solved this by simply saying that anonmm isn't capable of dealing
with mremap and he used the pte_chains like if it was the rmap vm, after
the first mremap. That's bad, but whatever more efficient solution than
the pte_chains (for example a metadata tracking a range, not wasting
bytes for every single page in the range like rmap does) will still
be a mess in terms of vma merging, tracking and rbtree/prio_tree search
too, and it won't at all be more obviously efficient, since you'll still
have to use the tree, and in all common cases my design will beat the
tree performance (even ignoring the mremap overhead with anonmm). the
way I defer the anonvma allocation and I instantiate direct pages 
is as well is extremely efficient compared to the anonmm.

The only thing I disallow is the merging of two vmas with different
anon_vma or different vm_pgoff, but that's a feature, if you don't do
that in the anonmm design, you'll have to allocate dynamic structures on
top of the vma tracking partial ranges within each vma which can be a
lot slower and it's so messy to deal with that I don't even remotely
considered writing anything like that, when I can use the pgoff with
the anon_vma_t.

> > > Considering the fact that we'll need Rajesh's code
> > > anyway, to deal with Ingo's test program and the real
> > 
> > Rajesh's code has nothing to do with the mremap breakage, Rajesh's code
> > can only boost the search of the interesting vmas in an anonmm, it
> > doesn't solve mremap.
> 
> If you mmap a file, then mremap part of that mmap, where's
> the special case ?

you miss that we disallow the merging of vmas with vm_pgoff if they
belong to a file (vma->vm_file != NULL). Infact what my code is doing is
to threat the anon vma similarly to the file-vmas, and that's why the
merging probability is reduced a little bit. The single fact anonmm
allows merging of all anonvmas like if they were not-vma-tracked tells
you anonmm is flawed w.r.t.  mremap. Something has to be changed anyways
in the vma handling code too (like the vma merging code) even with
anonmm, if your object is to always pass through the vma to reach the
pagetables. Hugh solved this by not passing through the vma after the
first mremap, that works too of course but I think my design is more
efficient, my whole effort is to avoid allocating per-page overhead and
to have a single metadata object (the vma) serving a range of pages,
that's a lot more efficient than the pte_chains and it saves a load of
ram in 64bit and 32bit.

to tell it in another way, the problem you have with anonmm, is that
after an mremap the page->index becomes invalid, and no, you can't fixup
the page->index by looping all over the pages pointed by the vma because
those page->index will be meaningful to other vmas in other address
spaces, where their address is still the original one (the one before
fork()).

> > "Overall the main reason for forbidding keeping track of vmas and not of
> > mm, is to be able to handle mremap as efficiently as with 2.4, I mean
> > your anobjrmap-5 simply reistantiate the pte_chains, so the vm then has
> > to deal with both pte_chains and anonmm too."
> 
> Yes, that's a problem indeed.  I'm not sure it's fundamental
> or just an implementation artifact, though...

I think it's fundamental but again, if you can find a solution to that
it's more than welcome, I just don't see how you can ever handle mremap
if you threat all the vmas the same, before and after mremap, if you
threat all the vmas the same you lose vm_pgoff and in turn you break in
mremap and you can forget using the vmas for reaching the pagetables
since you will do nothing with just the vm_start/vm_end and page->index
then.

You can still threat all of them the same by allocating dynamic stuff on
top of the vma but that will complicate everything, including the tree
search and the vma merging too. So the few lines I had to add to the vma
merging to teach the vma layer about the anon_vma, should be a whole lot
simpler and a whole lot more efficient than the ones you've to add to
allocate those dynamic objects sitting on top of the vmas and telling you
the right pg_off per-range (not to tell the handling of the oom
conditions while allocating those dynamic objects in super-spinlocked
paths, even the GFP_ATOMIC abuses from the pte_chains were nasty,
GFP_ATOMIC should reserved to irqs and bhs since they've no way to
unlock and sleep!...).
