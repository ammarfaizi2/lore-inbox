Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUCRPdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUCRPdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:33:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50648 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262687AbUCRPdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:33:03 -0500
Date: Thu, 18 Mar 2004 10:32:58 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <20040318022201.GE2113@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403181026250.16728-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0403181026252.16728@chimarrao.boston.redhat.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andrea Arcangeli wrote:

> This implements anon_vma for the anonymous memory unmapping and objrmap
> for the file mappings, effectively removing rmap completely and
> replacing it with more efficient algorithms (in terms of memory
> utilization and cpu cost for the fast paths).

Cool.  I'm glad we've figured out how to fix all the problems
with object based rmap.  I'd be happy to get rid of the pte
based reverse mapping stuff...

> Next thing to fix are the nonlinear mappings (probably I will use the
> sysctl for the short term, sysctl may be needed anyways for allowing
> mlock to all users), and then the rbtree for the i_mmap{shared} (the
> prio_tree isn't stable yet, over time we can replace it with the
> prio_tree of course).

Yeah, we'll definately need the prio_tree stuff before the
object based rmap can go into the mainline kernel...

As for nonlinear mappings, if the VMA is locked, no need to
check anything ... the swappable VMAs could be a bit of a
problem though, though I guess we could just unmap a large
number of ptes ;) 

> I'm running this kernel while writing this and it's under 500M swap load
> without problems. Ingo complains some workload with zillon of vmas
> in the same file will not work well, but 1) those workloads are supposed
> to use remap_file_pages in 32bit archs, and 2) they wants mlock anyways,
> and this vm design is optimal on the 64bit without requiring nor
> remap_file_pages nor mlock there.

Take a look at User Mode Linux ...

I don't think wants to use mlock, and I suspect it doesn't
use remap_file_pages (yet?).  Once it does use remap_file_pages,
we'll still need to find a more or less efficient way to swap
out those pages ...

> Alternate solutions to anon_vma have been proposed and they may be
> considered in alternative to this. Ideally we should split the anon_vma
> patch in two parts, one that could be re-used by the anonmm design,
> though I was no time to split it so far. I'm not claiming anon_vma is
> definitely superior to anonmm but it's the solution I prefer. It is clearly
> more efficient in some very high end workload I've in mind, but in the
> small boxes it takes a bit more of memory so for the simpler workloads
> anonmm is prefereable, plus anonmm allows full vma merging (though it
> requires cow during mremap).

They both have their advantages and disadvantages.  We'll
have to find out in practice which one works better...

I hope to get some time soon to implement the mm-based
reverse mapping, so we can test both alternatives.

At that point we'll want to split the file-backed stuff off
into a separate patch, on which we could layer either your
vma-based or Linus's mm-based reverse mapping scheme.

I'm kind of curious which one will end up better under
which workloads ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

