Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVASQmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVASQmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVASQmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:42:54 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:17571 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261771AbVASQmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:42:46 -0500
Date: Wed, 19 Jan 2005 08:40:35 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, carl.staelin@hp.com, "Luck, Tony" <tony.luck@intel.com>,
       lmbench-users@bitmover.com, linux-ia64@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lmbench-users] Re: pipe performance regression on ia64
Message-ID: <20050119164035.GB20656@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, davidm@hpl.hp.com,
	carl.staelin@hp.com, "Luck, Tony" <tony.luck@intel.com>,
	lmbench-users@bitmover.com, linux-ia64@vger.kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com> <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org> <16877.21998.984277.551515@napali.hpl.hp.com> <Pine.LNX.4.58.0501181200460.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501181200460.8178@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 12:17:11PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Jan 2005, David Mosberger wrote:
> >
> > >>>>> On Tue, 18 Jan 2005 10:11:26 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:
> > 
> >   Linus> I don't know how to make the benchmark look repeatable and
> >   Linus> good, though.  The CPU affinity thing may be the right thing.
> > 
> > Perhaps it should be split up into three cases:
> > 
> > 	- producer/consumer pinned to the same CPU
> > 	- producer/consumer pinned to different CPUs
> > 	- producer/consumer lefter under control of the scheduler
> > 
> > The first two would let us observe any changes in the actual pipe
> > code, whereas the 3rd case would tell us which case the scheduler is
> > leaning towards (or if it starts doing something real crazy, like
> > reschedule the tasks on different CPUs each time, we'd see a bandwith
> > lower than case 2 and that should ring alarm bells).
> 
> Yes, that would be good.

You're revisiting a pile of work I did back at SGI, I'm pretty sure all
of this has been thought through before but it's worth going over again.
I have some pretty strong opinions about this that schedulers tend not
to like.

It's certainly true that you can increase the performance of this sort
of problem by pinning the processes to a CPU and/or different CPUs.
For specific applications that is a fine thing to do, I did that for
the bulk data server that was moving NFS traffic over a TCP socket
over HIPPI (if you look at images from space that came from the 
military it is pretty likely that they passed through that code).
Pinning the processes to a particular _cache_ (not CPU, CPU has
nothing to do with it) gave me around 20% better throughput.

The problem is that schedulers tend be too smart, they try and figure
out where to put the process each time the schedule.  In general that
is the wrong answer for two reasons:

    a) It's more work on each context switch
    b) It only works for processes that use up a substantial fraction of
    their time slice (because the calculation is typically based in part
    on the idea if you ran on this cache for a long time then you want 
    to stay here).

The problem with the "thinking scheduler" is that it doesn't work for I/O
loads.  That sort of approach will believe that it is fine to move a process
which hasn't run for a long time.  That's false, you are invalidating its
cache and that hurts.  That's the 20% gain I got.

You are far better off, in my opinion, havig a scheduler that thinks at
process creation time and then only when the load gets unbalanced.  Other
than that, it always puts the process back on the CPU where it last ran.
If the scheduler guesses wrong and puts two processes on the same CPU
and they fight one will get moved.  But it shouldn't right away, leave
it there and let things settle a bit.

If someone coded up this policy and tried it I think that it would go a
long way towards making the LMbench timings more stable.  I could be
wrong but it would be interesting to compare this approach with a manual
placement approach.  Manual placement will always do better but it should
be in the 5% range, not in the 20% range.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
