Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUCLMlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUCLMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:41:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262087AbUCLMlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:41:02 -0500
Date: Fri, 12 Mar 2004 07:40:51 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312122127.GQ30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403120736420.3576-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 11, 2004 at 10:28:42PM -0500, Rik van Riel wrote:

> > Actually, with the code Rajesh is working on there's
> > no search problem with Hugh's idea.
> 
> you missed the fact mremap doesn't work, that's the fundamental reason
> for the vma tracking, so you can use vm_pgoff.
> 
> if you take Hugh's anonmm, mremap will be attaching a persistent dynamic
> overhead to the vma it touches. Currently it does in form of pte_chains,
> that can be converted to other means of overhead, but I simply don't
> like it.
> 
> I like all vmas to be symmetric to each other, without special hacks to
> handle mremap right.
> 
> We have the vm_pgoff to handle mremap and I simply use that.

Would it be possible to get rid of that if we attached
a struct address_space to each mm_struct after exec(),
sharing the address_space between parent and child
processes after a fork() ?

Note that the page cache can handle up to 2^42 bytes
in one address_space on a 32 bit system, so there's
more than enough space to be shared between parent and
child processes.

Then the vmas can track vm_pgoff inside the address
space attached to the mm.

> > Considering the fact that we'll need Rajesh's code
> > anyway, to deal with Ingo's test program and the real
> 
> Rajesh's code has nothing to do with the mremap breakage, Rajesh's code
> can only boost the search of the interesting vmas in an anonmm, it
> doesn't solve mremap.

If you mmap a file, then mremap part of that mmap, where's
the special case ?

> "Overall the main reason for forbidding keeping track of vmas and not of
> mm, is to be able to handle mremap as efficiently as with 2.4, I mean
> your anobjrmap-5 simply reistantiate the pte_chains, so the vm then has
> to deal with both pte_chains and anonmm too."

Yes, that's a problem indeed.  I'm not sure it's fundamental
or just an implementation artifact, though...

> the vma merging isn't a problem, we need to rework the code anyways to
> allow the file merging in both mprotect and mremap

Agreed.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

