Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSCDC2N>; Sun, 3 Mar 2002 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291020AbSCDC1y>; Sun, 3 Mar 2002 21:27:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15396 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290983AbSCDC1m>; Sun, 3 Mar 2002 21:27:42 -0500
Date: Mon, 4 Mar 2002 03:25:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304032535.F20606@dualathlon.random>
In-Reply-To: <20020301013056.GD2711@matchmail.com> <E16hdgg-0000Py-00@starship.berlin> <20020304014950.E20606@dualathlon.random> <E16hhYV-0000Qz-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hhYV-0000Qz-00@starship.berlin>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 02:46:22AM +0100, Daniel Phillips wrote:
> On March 4, 2002 01:49 am, Andrea Arcangeli wrote:
> > On Sun, Mar 03, 2002 at 10:38:34PM +0100, Daniel Phillips wrote:
> > > On March 2, 2002 03:06 am, Andrea Arcangeli wrote:
> > > > On Thu, Feb 28, 2002 at 10:26:48PM -0500, Bill Davidsen wrote:
> > > > > rather than patches. But there are a lot more small machines (which I feel
> > > > > are better served by rmap) than large. I would like to leave the jury out
> > > > 
> > > > I think there's quite some confusion going on from the rmap users, let's
> > > > clarify the facts.
> > > > 
> > > > The rmap design in the VM is all about decreasing the complexity of
> > > > swap_out on the huge boxes (so it's all about saving CPU), by slowing
> > > > down a big lots of fast common paths like page faults and by paying with
> > > > some memory too. See the lmbench numbers posted by Randy after applying
> > > > rmap to see what I mean.
> > > 
> > > Do you know any reason why rmap must slow down the page fault fast, or are
> > > you just thinking about Rik's current implementation?  Yes, rmap has to add
> > > a pte_chain entry there, but it can be a direct pointer in the unshared case
> > > and the spinlock looks like it can be avoided in the common case as well.
> > 
> > unshared isn't the very common case (shm, and file mappings like
> > executables are all going to be shared, not unshared).
> 
> As soon as you have shared pages you start to benefit from rmap's ability
> to unmap in one step, so the cost of creating the link is recovered by not

we'd benefit also with unshared pages.

BTW, for the map shared mappings we just collect the rmap information,
we need it for vmtruncate, but it's not layed out for efficient
browsing, it's only meant to make vmtruncate work.

> having to scan two page tables to unmap it.  In theory.  Do you see a hole
> in that?

Just the fact you never need the reverse lookup during lots of
important production usages (first that cames to mind is when you have
enough ram to do your job, all number crunching/fileserving, and most
servers are setup that way).  This is the whole point. Note that this
has nothing to do with the "cache" part, this is only about the
pageout/swapout stage, only a few servers really needs heavy swapout.

The background swapout to avoid unused services to stay in ram forever,
doesn't matter with rmap or w/o rmap design.

And on the other case (heavy swapout/pageouts like in some hard DBMS
usage, simualtions and laptops or legacy desktops) we would mostly save
CPU and reduce complexity, but I really don't see system load during
heavy pageouts/swapouts yet, so I don't see an obvious need of save cpu
there either.

Probably the main difference visible in numbers would be infact to
follow a perfect lru, but really giving mapped pages an higher chance is
beneficial.  Another bit in the current design of round robin cycling
over the whole VM clearing the accessed bitflag and activating physical
pages if needed, can also be see also as a feature in some ways. It is
much better at providing a kind of "clock based" aging to the accessed
bit information, while the lru pass rmap aware, wouldn't really be fair
with all the virtual pages the same way as we do now.

> > So unless you first share all the pagetables as well (like Ben once said
> > years ago), it's not going to be a direct pointer in the very common
> > case. And there's no guarantee you can share the pagetable (even
> > assuming the kernels supports that at the maximum possible degree across
> > execve and at random mmaps too) if you map those pages at different
> > virtual addresses.
> 
> The virtual alignment just needs to be the same modulo 4 MB.  There are
> other requirements as well, but being able to share seems to be the common
> case.

Yep on x86 w/o PAE. With PAE enabled (or x86-64 kernel) it needs to be
the same layout of phys pages on a naturally aligned 2M chunk. I trust
that will match often in theory, but still tracking it down over execve
and on random mmaps looks not that easy, I think for tracking that down
we'd really need the rmap information for everything (not just map
shared like right now). And also doing all the checks and walking the
reverse maps won't be zero cost, but I can see the benefit of the full
pte sharing (starting from cpu cache utilization across tlb flushes).

Infact it maybe rmap will be more useful for things like enabling the full
pagetable sharing you're suggesting above, rather than for replacing the
swap_out round robing cycle over the VM. so it might be used only for MM
internals rather than for VM internals.

Andrea
