Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUJKWOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUJKWOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUJKWMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:12:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:13279 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269293AbUJKWLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:11:41 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041009191556.06e09c67.pj@sgi.com>
References: <20041007072842.2bafc320.pj@sgi.com>
	 <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
	 <20041009191556.06e09c67.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097532415.4038.50.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 11 Oct 2004 15:06:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 19:15, Paul Jackson wrote:
> Rick replying to Paul:
> > And what I'm hearing is that if you're a job running in a set of shared
> > resources (i.e., non-exclusive) then by definition you are *not* a job
> > who cares about which processor you run on.  I can't think of a situation
> > where I'd care about the physical locality, and the proximity of memory
> > and other nodes, but NOT care that other tasks might steal my cycles.
> 
> There are at least these situations:
>  1) proximity to special hardware (graphics, networking, storage, ...)
>  2) non-dedicated tightly coupled multi-threaded apps (OpenMP, MPI)
>  3) batch managers switching resources between jobs
> 
> On (2), if say you want to run eight copies of an application, on a
> system that only has eight CPUs, where each copy of the app is an
> eight-way tightly coupled app, they will go much faster if each app is
> placed across all 8 CPUs, one thread per CPU, than if they are placed
> willy-nilly.  Or a bit more realistically, if you have a random input
> queue of such tightly coupled apps, each with a predetermined number of
> threads between one and eight, you will get more work done by pinning
> the threads of any given app on different CPUs.  The users submitting
> the jobs may well not care which CPUs are used for their job, but an
> intermediate batch manager probably will care, as it may be solving the
> knapsack problem of how to fit a stream of varying sized jobs onto a
> given size of hardware.
> 
> On (3), a batch manager might say have two small cpusets, and also one
> larger cpuset that is the two small ones combined.  It might run one job
> in each of the two small cpusets for a while, then suspend these two
> jobs, in order to run a third job in the larger cpuset.  The two small
> cpusets don't go away while the third job runs -- you don't want to lose
> or have to tear down and rebuild the detailed inter-cpuset placement of
> the two small jobs while they are suspended.

I think these situations, particularly the first two, are the times you
*want* to use the cpus_allowed mechanism.  Pinning a specific thread to
a specific processor (cases (1) & (2)) is *exactly* why the cpus_allowed
mechanism was put into the kernel.

And (3) can pretty easily be achieved by using a combination of
sched_domains and cpus_allowed.  In your example of one 4 CPU cpuset and
two 2 CPU sub cpusets (cpu-subsets? :), one could easily create a 4 CPU
domain for the larger job and two 2 CPU domains for the smaller jobs. 
Those 2 2 CPU subdomains can be created & destroyed at will, or they
could be simply tagged as "exclusive" when you don't want tasks moving
back and forth between them, and tagged as "non-exclusive" when you want
tasks to be freely balanced across all 4 CPUs in the larger parent
domain.

One of the cool thing about using sched_domains as your partitioning
element is that in reality, tasks run on *CPUs*, not *domains*.  So if
you have threads 'a1' & 'a2' running on CPUs 0 & 1 (small job 'a') and
threads 'b1' & 'b2' running on CPUs 2 & 3 (small job 'b'), you can
suspend threads a1, a2, b1 & b2 and remove the domains they were running
in to allow job A (big job with threads A1, A2, A3, & A4) to run on the
larger 4 CPU domain.  When you then suspend A1-A4 again to allow the
smaller jobs to proceed, you can pretty trivially create the 2 CPU
domains underneath the 4 CPU domain and resume the jobs.  Those jobs (a
& b) have been suspended on the CPUs they were originally running on,
and thus will resume on the same CPUs without any extra effort.  They
will simply run on those CPUs, and at load balance time, the domains
attached to those CPUs will be consulted to determine where the tasks
can be relocated to if there is a heavy load.  The domains will tell the
scheduler that the tasks cannot be relocated outside the 2 CPUs in each
respective domain.  Viola!  (sorta ;)

-Matt

