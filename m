Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUCIAf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUCIAfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:35:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2061
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261412AbUCIAfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:35:11 -0500
Date: Tue, 9 Mar 2004 01:35:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309003550.GL12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040308161046.04270108.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308161046.04270108.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 04:10:46PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > btw, mincore() has always been broken with nonlinear vma's.  If you could
> > > fix that up some time using that pagetable walker it would be nice.  It's
> > > not very important though.
> > 
> > Ok! I'm still late at this though, I wish I would be working on the
> > nonlinear stuff by now ;), I'm still stuck at the anon_vma_chain...
> 
> As I say, broken mincore() on nonlinear mappings isn't a showstopper ;)
> 
> > If I understand well, vmtruncate will also need the pagetable walker to
> > nuke all mappings of the last pages of the files before we free them
> > from the pagecache. So it should be a library call that mincore can use
> > too then, I don't see problems.
> 
> If we want to bother with the traditional truncate-causes-SIGBUS semantics
> on nonlinear mappings, yes.  I guess it would be best to do that if
> possible.

yes, this was my object.


btw, this reminds me another trouble, that is what to do in the case
where in 2.4 we convert file-mapped-pages into anonymous pages while
they're still mapped (I don't remeber exactly what could do that but it
could happen, do you remember the details? I think this is the case that
Hugh calls the Morton pages, he also had troubles in his anobjrmap
attempt but I think it was more a fixme comment). In 2.4 the swap_out
had to deal with that somehow, but with my anobjrmap the vm will now
lose track of those pages, so they will become unswappable. Not sure if
they were unswappable in 2.4 too and/or if 2.6-rmap could leave them
visible to the vm or not.

Also these pages should be swapped to the swap device, if something,
they lost reference of the inode.

Input on the Morton pages is appreciated ;)

> > btw (for completeness), about the cpu consumption concerns about objrmap
> > w.r.t. security (that was Ingo's only argument against objrmap),
> > whatever malicious waste of cpu that could happen during paging, can be
> > already triggered in any kernel out there by using truncate on the same
> > mappings instead of swapping them out.
> 
> Yes, malicious apps can DoS the machine in many ways.  I'm more concerned
> about non-malicious ones getting hurt by the new search activity.  Say, a
> single-threaded app which uses a huge number of vma's to map discontiguous
> parts of a file.  The 2.4-style virtual scan would handle that OK, and the
> 2.6-style pte_chain walk would handle it OK too.  People do weird things.

That's the db normal scenario and it's running fine on 16G boxes today
in 2.4 with objrmap. Note that we're talking about swapping here, and
compared to swap_out that cpu load in the vma chains is little compared
to throwing away hundred gigs of address space before swapping the first
4k (infact objrmap was the 1st showstopper fix to make huge-shm-swap work
properly). So I'm not very concerned. Also for some db those pages
should be mlocked, so to be optimal we should remove them from the lru
while they're mlocked as Martin suggested. and normal pure db (not
applications) don't swap, so they will only run faster.

Longer term on 64bit those weird setups will be all but common as far as
I can tell.

Overall it sounds the best trade-off.

> (objrmap could perhaps terminate the vma walk after it sees the page->count
> fall to a value which means there are no more pte's mapping the page - that
> would halve the search cost on average).

It really should! Agreed. Feel free to go ahead and fix it. I checked
the page_count before starting the loop in my 2.4 implementation, but I
forgot to do that during the core of the loop. I was only breaking the
loop at the first pte_young I would find (my objrmap isn't capable of
clearing the pte_young bit, I leave that task to the pagetable walk, you
know my 2.4 objrmap is an hybrid between objrmap and the swap_out loop,
2.6 handles all this differently). 
