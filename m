Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUDASuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbUDASuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:50:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19846
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263036AbUDAStz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:49:55 -0500
Date: Thu, 1 Apr 2004 20:49:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401184954.GW18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <20040401103425.03ba8aff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401103425.03ba8aff.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:34:25AM -0800, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > On Thu, Apr 01, 2004 at 08:48:25AM -0800, William Lee Irwin III wrote:
> > >> Something like this would have the minor advantage of zero core impact.
> > >> Testbooted only. vs. 2.6.5-rc3-mm4
> > 
> > On Thu, Apr 01, 2004 at 06:59:52PM +0200, Andrea Arcangeli wrote:
> > > I certainly like this too (despite it's more complicated but it might
> > > avoid us to have to add further sysctl in the future), Andrew what do
> > > you prefer to merge? I don't mind either ways.
> 
> What is the Oracle requirement in detail?

being able to shmget(SHM_HUGETLB) as normal user. However I cannot
disable the CAP_IPC_LOCK from hugetlbfs/inode.c since that would break
local security w.r.t. mlock.

If I've to disable that single check in hugetlbfs/inode.c then I prefer
to disable all CAP_IPC_LOCK so they can as well use mlock.

> If it's for access to hugetlbfs then there are the uid= and gid= mount
> options.

sure we know, that's not the problem, disabling mlock checks is easy
with hugetlbfs marking the mountpoint 777.

> If it's for access to SHM_HUGETLB then there was some discussion about
> extending the uid= thing to shm, but nothing happened.  This could be
> resurrected.

never heard of those discussions sorry, though I'm not completely sure
that one single uid would work, a 777 ownership would certain work
instead, but how to give 777 ownership to not an fs. I mean, the sysctl
is an order of magnitude simpler and it covers the mlock and
shmclt(SHM_LOCK/UNLOCK) usages as well that cannot be covered by rlimit
either.

> 
> If it's just generally for the ability to mlock lots of memory then
> RLIMIT_MEMLOCK would be preferable.  I don't see why we'd need the sysctl
> when `ulimit -m' is available?  (Where is that patch btw?)

the real reason is shmget(SHM_HUGETLB) but if I disable that
specific CAP_IPC_LOCK I can disable them all, and then nobody will have
to use rlimit anymore for this.

Also consider the same user can shmget multiple segments and that can
exceed the 4G limit of rlimit, since that's not address space but
physical memory (either ram or swap).

> I guess we could live with sysctl which simply nukes CAP_IPC_LOCK, but it
> has to be the when-all-else-failed option, yes?

Probably the main advantage is that it doesn't giveup all righs to the
user with fsuid == 0, it only gives it mlock. Though I can imagine some
user may not like to giveup mlock to fsuid == 0 either, so even that may
need to be a config option, but OTOH overcommit and other vm bits (again
stuff that can't be used to do real bad stuff) are already available to
fsuid == 0. So I think the sysctl-cap-mlock is reasonable feature at
least until there's a more finegriend way to give the
shmget(SHM_HUGETLB)/shmctl(SHM_LOCK/UNLOCK) rights.
