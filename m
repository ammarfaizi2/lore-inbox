Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132845AbRDDPLr>; Wed, 4 Apr 2001 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbRDDPLj>; Wed, 4 Apr 2001 11:11:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24692 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132836AbRDDPLZ>; Wed, 4 Apr 2001 11:11:25 -0400
Date: Wed, 4 Apr 2001 17:08:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: a quest for a better scheduler
Message-ID: <20010404170846.V20911@athlon.random>
In-Reply-To: <OF401BD38B.CF3B1E9F-ON85256A24.0048543A@pok.ibm.com> <Pine.LNX.4.30.0104041527190.5382-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0104041527190.5382-100000@elte.hu>; from mingo@elte.hu on Wed, Apr 04, 2001 at 03:34:22PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 03:34:22PM +0200, Ingo Molnar wrote:
> 
> On Wed, 4 Apr 2001, Hubertus Franke wrote:
> 
> > Another point to raise is that the current scheduler does a exhaustive
> > search for the "best" task to run. It touches every process in the
> > runqueue. this is ok if the runqueue length is limited to a very small
> > multiple of the #cpus. [...]
> 
> indeed. The current scheduler handles UP and SMP systems, up to 32
> (perhaps 64) CPUs efficiently. Agressively NUMA systems need a different
> approach anyway in many other subsystems too, Kanoj is doing some
> scheduler work in that area.

I didn't seen anything from Kanoj but I did something myself for the wildfire:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa1/10_numa-sched-1

this is mostly an userspace issue, not really intended as a kernel optimization
(however it's also partly a kernel optimization). Basically it splits the load
of the numa machine into per-node load, there can be unbalanced load across the
nodes but fairness is guaranteed inside each node. It's not extremely well
tested but benchmarks were ok and it is at least certainly stable.

However Ingo consider that in a 32-way if you don't have at least 32 tasks
running all the time _always_ you're really stupid paying such big money for
nothing ;). So the fact the scheduler is optimized for 1/2 tasks running all
the time is not nearly enough for those machines (and of course also the
scheduling rate automatically increases linearly with the increase of the
number of cpus). Now it's perfectly fine that we don't ask the embedded and
desktop guys to pay for that, but a kernel configuration option to select an
algorithm that scales would be a good idea IMHO. The above patch just adds a
CONFIG_NUMA_SCHED. The scalable algorithm can fit into it and nobody will be
hurted by that (CONFIG_NUMA_SCHED cannot even be selected by x86 compiles).

Andrea
