Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVARUSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVARUSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVARUSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:18:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:41380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261409AbVARUR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:17:57 -0500
Date: Tue, 18 Jan 2005 12:17:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com, carl.staelin@hp.com
cc: "Luck, Tony" <tony.luck@intel.com>, lmbench-users@bitmover.com,
       linux-ia64@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pipe performance regression on ia64
In-Reply-To: <16877.21998.984277.551515@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0501181200460.8178@ppc970.osdl.org>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org> <16877.21998.984277.551515@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Jan 2005, David Mosberger wrote:
>
> >>>>> On Tue, 18 Jan 2005 10:11:26 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:
> 
>   Linus> I don't know how to make the benchmark look repeatable and
>   Linus> good, though.  The CPU affinity thing may be the right thing.
> 
> Perhaps it should be split up into three cases:
> 
> 	- producer/consumer pinned to the same CPU
> 	- producer/consumer pinned to different CPUs
> 	- producer/consumer lefter under control of the scheduler
> 
> The first two would let us observe any changes in the actual pipe
> code, whereas the 3rd case would tell us which case the scheduler is
> leaning towards (or if it starts doing something real crazy, like
> reschedule the tasks on different CPUs each time, we'd see a bandwith
> lower than case 2 and that should ring alarm bells).

Yes, that would be good.

However, I don't know who (if anybody) maintains lmbench any more. It 
might be Carl Staelin (added to cc), and there used to be a mailing list 
which may or may not be active any more..

[ Background for Carl (and/or lmbench-users): 

  The "pipe bandwidth" test ends up giving wildly fluctuating (and even
  when stable, pretty nonsensical, since they depend very strongly on the
  size of the buffer being used to do the writes vs the buffer size in the
  kernel) numbers purely depending on where the reader/writer got
  scheduled.

  So a recent kernel buffer management change made lmbench numbers vary 
  radically, ranging from huge improvements to big decreases. It would be 
  useful to see the numbers as a function of CPU selection on SMP (the 
  same is probably true also for the scheduling latency benchmark, which 
  is also extremely unstable on SMP).

  It's not just that it has big variance - you can't just average out many 
  runs. It has very "modal" operation, making averages meaningless. 

  A trivial thing that would work for most cases is just a simple (change 
  the "1" to whatever CPU-mask you want for some case)

	long affinity = 1;	/* bitmask: CPU0 only */
	sched_setaffinity(0, sizeof(long), &affinity);

  but I don't know what other OS's do, so it's obviously not portable ]

Hmm?

			Linus
