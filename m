Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCHXjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUCHXjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:39:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10252
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261411AbUCHXjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:39:33 -0500
Date: Tue, 9 Mar 2004 00:40:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040308234014.GG12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308152126.54f4f681.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 03:21:26PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > Other issues are how it will play with remap_file_pages(), and how it
> > > impacts Ingo's work to permit remap_file_pages() to set page permissions on
> > > a per-page basis.  This change provides large performance improvements to
> > 
> > in the current form it should be using pte_chains still for nonlinear
> > vmas, see the function that pretends to convert the page to be like
> > anonymous memory (which simply means to use pte_chains for the reverse
> > mappings).  I admit I didn't focus much on that part though, I trust
> > Dave on that ;), since I want to drop it.
> > 
> > What I want to do with the nonlinear vmas is to scan all the ptes in
> > every nonlinear vma, so I don't have to allocate the pte_chain and the
> > swapping procedure will simply be more cpu hungry under nonlinear vmas.
> > I'm not interested to provide optimal performance in swapping nonlinear
> > vmas, I prefer the fast path to be as fast as possible and without
> > memory overhead.
> 
> OK.  There was talk some months ago about making the non-linear vma's
> effectively mlocked and unswappable.  That would reduce their usefulness
> significantly.  It looks like that's off the table now, which is good.

I sure remeber well since I was the one suggesting it ;). I now figured
out throwing some cpu at the problem would make them swappable without
hurting any fast path, so I was opting for it. It won't be an efficient
swapping but at least it swaps ;). If it will be way too inefficient
we've to options 1) is to take the 2.4 way of destroying all the vma
(still better than to destroy the whole address space), 2) to make the
mlocked as I originally suggested which will annoy the JIT emulation
usage mentioned.

> btw, mincore() has always been broken with nonlinear vma's.  If you could
> fix that up some time using that pagetable walker it would be nice.  It's
> not very important though.

Ok! I'm still late at this though, I wish I would be working on the
nonlinear stuff by now ;), I'm still stuck at the anon_vma_chain...

If I understand well, vmtruncate will also need the pagetable walker to
nuke all mappings of the last pages of the files before we free them
from the pagecache. So it should be a library call that mincore can use
too then, I don't see problems.


btw (for completeness), about the cpu consumption concerns about objrmap
w.r.t. security (that was Ingo's only argument against objrmap),
whatever malicious waste of cpu that could happen during paging, can be
already triggered in any kernel out there by using truncate on the same
mappings instead of swapping them out. Truncate 1 page at time and you
can have the kernel walk all the vmas in the huge list for every page in
the mapping. It must be mandated by a syscall but I don't see much
difference. I don't think it's very different from a for(;;) loop in
userspace, except this will have an higher scheduler latency, but if we
implement it right the scheduler latency won't be higher than the one
triggered by truncate today. So I can't see any security related issue.
Swapping a page with objrmap or truncating it with the same objrmap (as
every kernel out there does) carries exactly the same objrmap cpu cost.
And this is only a matter of local security and wasting cpu if you can
write your own app is quite easy anyways.
