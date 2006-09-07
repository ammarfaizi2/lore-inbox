Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWIGWch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWIGWch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWIGWch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:32:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:54959 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422688AbWIGWcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:32:36 -0400
Date: Fri, 8 Sep 2006 00:32:34 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Suresh B <suresh.b.siddha@intel.com>
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <20060907223234.GC28080@wotan.suse.de>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com> <20060907105801.GC3077@wotan.suse.de> <Pine.LNX.4.64.0609071016250.16674@schroedinger.engr.sgi.com> <20060907214753.GA28080@wotan.suse.de> <Pine.LNX.4.64.0609071511370.18416@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609071511370.18416@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 03:20:32PM -0700, Christoph Lameter wrote:
> On Thu, 7 Sep 2006, Nick Piggin wrote:
> 
> > How about if you have N/2 CPUs with lots of stuff on runqueues?
> > Then the other N/2 will each be scanning N/2+1 runqueues... that's
> > a lot of bus traffic going on which you probably don't want.
> 
> Then the load will likely be sitting on a runqueue and run 
> much slower since it has to share cpus although many cpus are available 
> to take new jobs. The scanning is very fast and it is certainly better 
> than continuing to overload a single processor.

But it is N^2... I thought SGI of all would hesitate to put such an
algorithm into the scheduler ;)

> > A sched-domain is per-CPU as well. Why doesn't it work?
> 
> Lets say you store the latest set of pinned cpus encountered (I am not 
> sure what cpu number would accomplish). The next time you have to 
> reschedule the situation may be completely different and you would have
> to revalidate the per cpu pinned cpu set. 

Maybe you misunderstood, I'll explain below.

> > Yes, it isn't going to be perfect, but it would at least work (which
> > it doesn't now) without introducing that latency.
> 
> Could you tell us how this could work?

You keep track of a fallback CPU. Then, if balancing fails because all
processes are pinned, you just try pulling from the fallback CPU. If
that fails, set the fallback to the next CPU.

OTOH that still results in suboptimal scheduler, and now that I remember
your workload, you had a small number of CPUs screwing up balancing for
a big system. Hmm... so this may be not great for you.

> 
> > > This looks to me as a design flaw that would require either a major rework 
> > > of the scheduler or (my favorite) a delegation of difficult (and 
> > > computational complex and expensive) scheduler decisions to user space.
> > 
> > I'd be really happy to move this to userspace :)
> 
> Can we merge this patch and then I will try to move this as fast as 
> possible to userspace?

I'd like to get an ack from Ingo, but otherwise OK I guess.

> 
> Ok then we need to do the following to address the current issue and to
> open up the possibilities for future enhancements:
> 
> 1. Add a new field to /proc/<pid>/cpu that can be written to and that
>    forces the process to be moved to the corresponding cpu.
> 
> 2. Extend statistics in /proc/<pid>/ to allow the export of more scheduler
>    information and a special flag that is set if a process cannot be 
>    rescheduling. initially the user space scheduler may just poll this 
>   field.
> 
> 3. Optional: Some sort of notification mechanism that a user space 
>    scheduler helper could subscribe to. If a pinned tasks situation
>    is encountered then the notification passes the number of the
>    idle cpu.

Hmm, how about

1. Export SD information in /sys/
2. Export runqueue load information there too
3. One attribute in /sys/.../CPUn/ will be written to a CPU number m and
   a count t, which will try to pull t tasks from CPUm to CPUn
4. Another attribute would be the result of the last balance attempt
   (eg. 'all pinned').

?

