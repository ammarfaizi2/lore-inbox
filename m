Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUCLMUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUCLMUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:20:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4619
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262068AbUCLMUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:20:45 -0500
Date: Fri, 12 Mar 2004 13:21:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312122127.GQ30940@dualathlon.random>
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 10:28:42PM -0500, Rik van Riel wrote:
> On Thu, 11 Mar 2004, Andrea Arcangeli wrote:
> 
> > it's more complicated because it's more finegrined and it can handle
> > mremap too. I mean, the additional cost of tracking the vmas payoffs
> > because then we've a tiny list of vma to search for every page,
> > otherwise with the mm-wide model we'd need to search all of the vmas in
> > a mm.
> 
> Actually, with the code Rajesh is working on there's
> no search problem with Hugh's idea.

you missed the fact mremap doesn't work, that's the fundamental reason
for the vma tracking, so you can use vm_pgoff.

if you take Hugh's anonmm, mremap will be attaching a persistent dynamic
overhead to the vma it touches. Currently it does in form of pte_chains,
that can be converted to other means of overhead, but I simply don't
like it.

I like all vmas to be symmetric to each other, without special hacks to
handle mremap right.

We have the vm_pgoff to handle mremap and I simply use that.

> Considering the fact that we'll need Rajesh's code
> anyway, to deal with Ingo's test program and the real

Rajesh's code has nothing to do with the mremap breakage, Rajesh's code
can only boost the search of the interesting vmas in an anonmm, it
doesn't solve mremap.

> world programs that do similar things, I don't see how
> your objection to Hugh's code is still valid.

This was my objection, maybe you didn't read all my emails, i quote
again:

"Overall the main reason for forbidding keeping track of vmas and not of
mm, is to be able to handle mremap as efficiently as with 2.4, I mean
your anobjrmap-5 simply reistantiate the pte_chains, so the vm then has
to deal with both pte_chains and anonmm too."

As said one can convert the pte_chains to other means of overhead, but
still it's an hack and you'll need transient objects to track those if
you don't track finegrined by vma as I'm doing.

It's not that I didn't read anonmm patches from Hugh, I spent lots of
time on those, they just were flawed and they couldn't handle mremap,
he very well knows, see anobjrmap-5 for istance.

the vma merging isn't a problem, we need to rework the code anyways to
allow the file merging in both mprotect and mremap (currently only mmap
is capable of merging files, and in turn it's also the only one capable
of merging anon_vmas). Any merging code that is currently capable of
merging files is easy to teach about anon_vmas too, it's basically the
same problem at merging.
