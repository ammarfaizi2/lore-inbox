Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbUDFUZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbUDFUZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:25:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58520
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263992AbUDFUZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:25:50 -0400
Date: Tue, 6 Apr 2004 22:25:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406202548.GI2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406192549.GA14869@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:25:49PM +0200, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > I will use the HINT to measure the slowdown on HZ=1000. It's an
> > optimal benchmark simulating userspace load at various cache sizes and
> > it's somewhat realistic.
> 
> here are the INT results from the HINT benchmark (best of 3 runs):
> 
>  1000Hz, 3:1, PAE:    25513978.295333 net QUIPs
>  1000Hz, 4:4, PAE:    25515998.582834 net QUIPs
> 
> i.e. the two kernels are equal in performance. (the noise of the
> benchmark was around ~0.5% so this 0.01% win of 4:4 is a draw.) This is
> not unexpected, the benchmark is too noisy to notice the 0.22% maximum
> possible 4:4 hit.

that's really a good result, and this is a benchmark that is realistic
for a number crunching load, I'm running it too on my hardware right now
(actually I started it a few hours ago but it didn't finish a pass yet).
I'm using DOUBLE. However I won't post the quips, I draw the graph
showing the performance for every working set, that gives a better
picture of what is going on w.r.t. memory bandwidth/caches/tlb.

BTW, which is the latest 4:4 patch to use on top of 2.4? I'm porting the
one in Andrew's rc3-mm4 in order to run the benchmark on top of the same
kernel codebase. is that the latest one?

> i've just re-measured a couple of workloads that are very kernel and
> syscall intensive, to get a feel for the worst-case:
> 
>  apache tested via 'ab':      5% slowdown
>  dbench:                     10% slowdown
>  tbench:                     16% slowdown
> 
> these would be the ones where i'd expect to see the biggest slowdown,
> these are dominated by kernel overhead and do alot of small syscalls. 
> (all these tests fully saturated the CPU.)

we perfectly know that the biggest slowdown is in mysql-like and
databases running gettimeofday, they're quite common workloads. Numbers
were posted to the list too. vgettimeofday mitigates it.

> you should also consider that while 4:4 does introduce extra TLB
> flushes, it also removes the TLB flush at context-switch. So for
> context-switch intensive workloads the 4:4 overhead will be smaller. (in

yes, that's also why threaded apps are hurted most. And due the
serialized copy-user probably you shouldn't enable the threading support
in apache2 for 4:4. Did you get the 5% slowdown with threading enabled?
I'd expect more if you enable the threading, partly because 3:1 should
run a bit faster with threading, and mostly because 4:4 serializes the
copy-user. (OTOH not sure if apache does that much copy-user, in the
past they used mmapped I/O, and mmapped I/O should scale well with
threading on 4:4 too)

> But judging by your present attitude i'm sure you'll be able to find
> worse performing testcases and will use them as the typical slowdown
> number to quote from that point on ;) Good luck in your search.

they were already posted on the list.

> 'always good' feature - i never claimed it was. It is an enabler feature
> for very large RAM systems, and it gives 3.98 GB of VM to userspace. It

Agreed, I define very large as >32G (32G works fine w/o it).

The number crunching simulations using 4G address space at the expense
of peforming syscalls and interrupts slower is a small amount of
userbase (and even before they care about 4:4 they should care about
mapbase), these are the same users that asked me the 3.5:0.5 in the
past. The point is that these users gets a mmap(-ENOMEM) failure if they
need more address space, so it's easy to detect those users (and most
important they're always very skilled users capable of recompiling and
customizing a kernel) and to provide them specialized kernels, their
application will just complain with allocation failures.  All the rest
of the userbase will just run slower and they'll not know they could run
faster without 4:4.

I provided 3.5:0.5 kernel option + your mapbase tweak for ages in all
2.4-aa for the people who needs 3.5 of address space in userspace. 4:4
adds up another 512M so it's better for them indeed.

> But for pure userspace code (which started this discussion), where
> userspace overhead dominates by far, the cost is negligible even with
> 1000Hz.

I thought hz 1000 would hurt more than %0.02 given 900 irqs per second
themselfs wastes 1% of the cpu, but I may very well be wrong about that
(it's just your previous post wasn't convincing due the apparently
too artificial testcase), anyways the hint is a lot more convincing now.
I will still try to reproduce your HINT numbers here on slightly
different high end hardware, so you can get a further confirmation and
datapoint.

thanks.
