Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUCLP4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbUCLP4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:56:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19466
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262225AbUCLP4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:56:10 -0500
Date: Fri, 12 Mar 2004 16:56:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312155652.GW30940@dualathlon.random>
References: <20040312122127.GQ30940@dualathlon.random> <Pine.LNX.4.44.0403121309000.4898-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121309000.4898-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 01:43:23PM +0000, Hugh Dickins wrote:
> Thanks a lot for pointing us to your (last night's) patches, Andrea.
> 
> On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> > On Thu, Mar 11, 2004 at 10:28:42PM -0500, Rik van Riel wrote:
> > 
> > It's not that I didn't read anonmm patches from Hugh, I spent lots of
> > time on those, they just were flawed and they couldn't handle mremap,
> > he very well knows, see anobjrmap-5 for istance.
> 
> Flawed in what way?  They handled mremap fine, but yes, used pte_chains
> for that extraordinary case, just as pte_chains were used for nonlinear.

"using pte_chains for the extraordinary case" (which is a common case
for some apps) means it doesn't handle it, and you've to use rmap to
handle that case.

> With pte_chains gone (hurrah! though nonlinear handling yet to come),
> as you know, I've already suggested a better way to handle that case
> (use tmpfs-style backing object).

Do you realize the complexity of creating a tmpfs-inode and to attach
all vmas to it stacked on top of anonmm? And after you fix mremap you
get the same disavantages for merging of vmas (remeber my
disavantage of not merging after an mremap you won't merge too), plus it
wastes a lot more ram since you need a fake inode for every anonymous
vma and it's ugly to create those objects inside mremap. My transient
object is 8 bytes per group of vmas. And you need even the prio_tree
search on top of the anonmm.

Don't forget you can't re-use the vma->shared for doing the tmpfs-style
thing, that's already in a true inode. so what you're suggesting would
becomes an huge mess to implement IMHO. the anon_vma sounds a lot
cleaner and more efficient design to me than stacking inode-like objects
on top of a vma already queued in a i_mmap.

> > the vma merging isn't a problem, we need to rework the code anyways
> > to
> > allow the file merging in both mprotect and mremap (currently only mmap
> > is capable of merging files, and in turn it's also the only one capable
> > of merging anon_vmas). Any merging code that is currently capable of
> > merging files is easy to teach about anon_vmas too, it's basically the
> > same problem at merging.
> 
> You're paying too much attention to the (almost optional, though it can
> have a devastating effect on vma usage, yes) issue of vma merging, but
> what about the (mandatory) vma splitting?  I see no sign of the tiresome
> code I said you'd need for anonvma rather than anonmm, walking the pages
> updating as.vma whenever vma changes e.g. when mprotecting or munmapping
> some pages in the middle of a vma.  Surely move_vma_start is not enough?

you're right about vma_split, the way I implemented it is wrong,
basically the as.vma/PageDirect idea is falling apart with vma_split.
I should simply allocate the anon_vma without passing through the direct
mode, that will fix it though it'll be a bit less efficient for the
first page fault in an anonymous vma (only the first one, for all the
other page faults it'll be as fast as the direct mode).

this is probably why the code was not stable yet btw ;) so I greatly
appreciate your comments about it, it's just the optimization I did that
was invalid.

I could retain the optimization with a list of pages attached to the vma
but it doesn't worth it, allocating the anon_vma is way too cheap
compared to that. the pagedirect was a microoptization only, any
additional complexity to retain the microoptimization is worthless.

> That's what led me to choose anonmm, which seems a lot simpler: the real
> argument for anonvma is that it saves a find_vma per pte in try_to_unmap
> (page_referenced doesn't need it): a good saving, but is it worth the
> complication of the faster paths?

the only real argument is mremap, your tmpfs-like thing is overkill
compared to anon_vma, and secondly I don't need the prio_tree to scale.
