Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUCHXCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCHXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:02:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58889
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261378AbUCHXCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:02:07 -0500
Date: Tue, 9 Mar 2004 00:02:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040308230247.GC12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308132305.3c35e90a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 01:23:05PM -0800, Andrew Morton wrote:
> There is an architectural concern: we're now treating anonymous pages
> differently from file-backed ones.  But we already do that in some places

I'm working on that.

> Other issues are how it will play with remap_file_pages(), and how it
> impacts Ingo's work to permit remap_file_pages() to set page permissions on
> a per-page basis.  This change provides large performance improvements to

in the current form it should be using pte_chains still for nonlinear
vmas, see the function that pretends to convert the page to be like
anonymous memory (which simply means to use pte_chains for the reverse
mappings).  I admit I didn't focus much on that part though, I trust
Dave on that ;), since I want to drop it.

What I want to do with the nonlinear vmas is to scan all the ptes in
every nonlinear vma, so I don't have to allocate the pte_chain and the
swapping procedure will simply be more cpu hungry under nonlinear vmas.
I'm not interested to provide optimal performance in swapping nonlinear
vmas, I prefer the fast path to be as fast as possible and without
memory overhead. nonlinear vmas are supposed to speedup the workload. If
one needs to swap efficiently, the vmas will do it (by carrying some
memory overhead, like pte_chains would carry too).

> UML, making it more viable for various virtual-hosting applications.  I
> don't immediately see any reason why objrmap should kill that off, but if
> it does we're in the position of trading off UML virtual server performance
> against monster highmem viability.  That's less clear.

I still don't see objrmap as a highmem related things, by side effect of
being more efficient avoids the needs of 4:4 too, but that's just a side
effect.

the potential additional cpu consumtion with many vmas from the same
file at different offsets is something I'm slightly concerned about too
but my priority is to optimize the fast path, and the slowdown is not
something I worry about too much since it should be still a lot better
than the pagetable walk of 2.4 where one had to throw away the whole
address space before one could free a shared page (and still it was far
from being cpu bound). I'm also using objrmap in 2.4 to actually swap
lots of shm, some of which having tons of vmas for the same file, and
while the objrmap function remains at the top of the profiling, at least
the swap_out loop is gone and avoid to trow away the whole address
space. I mean it's still a lot more efficient than having to scan all
the ptes in the system to find the right page, or like 2.4 stock is
doing to throw away all the address space to swap 4k.

and you know well that 2.6 swaps slower (or anyways not faster) than
2.4, see the posts on linux-mm or the complains from the lowmem users,
there are various bits involved into the swapping and paging that are
more important than saving cpu during swapping, which is normally an I/O
bound thing.
