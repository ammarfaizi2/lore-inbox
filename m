Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbUDGHX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUDGHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:23:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44947
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264130AbUDGHXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:23:51 -0400
Date: Wed, 7 Apr 2004 09:23:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407072349.GC26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random> <20040407060330.GB26888@dualathlon.random> <20040407064629.GA31338@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407064629.GA31338@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 08:46:29AM +0200, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > > I'm using DOUBLE. However I won't post the quips, I draw the graph
> > > showing the performance for every working set, that gives a better
> > > picture of what is going on w.r.t. memory bandwidth/caches/tlb.
> > 
> > Here we go:
> > 
> > 	http://www.kernel.org/pub/linux/kernel/people/andrea/misc/31-44-100-1000/31-44-100-1000.html
> > 
> > the global quips you posted indeed had no way to account for the part
> > of the curve where 4:4 badly hurts. details in the above url.
> 
> Firstly, most of the first (full) chart supports my measurements. 

yes, above and below a certain treshold there's definitely no difference.

> There's the portion of the chart at around 500k working set that is at
> issue, which area you've magnified so helpfully [ ;-) ].

the problem showup between 300k and 700k, and I magnified everything,
not just that single part.

> That area of the curve is quite suspect at first sight. With a TLB flush

the cache size of the l2 is 512k, that's the point where slowing down walking
pagetables out of l2 hurt most. It made perfect sense to me. Likely on a 1M
cache machine you'll get the same huge slowdown at 1M working set and so on
with bigger cache sizes in more expensive x86 big iron cpus.

> every 1 msec [*], for a 'double digit' slowdown to happen it means the
> effect of the TLB flush has to be on the order of 100-200 usecs. This is
> near impossible, the dTLB+iTLB on your CPU is only 64+64. This means
> that a simple mmap() or a context-switch done by a number-cruncher
> (which does a TLB flush too) would have a 100-200 usecs secondary cost -
> this has never been seen or reported before!

note that it's not only the tlb flush having the cost, the cost is the
later code going slow due the tlb misses. So if you rdstc around the mmap
syscall it'll return quick just like the irq returns quick to userspace.
the cost of the tlb misses causing pte walkings of ptes out of l2 cache isn't
easily measurable in other ways than I did.

> but it is well-known that most complex numeric benchmarks are extremely
> sensitive to the layout of pages - e.g. my dTLB-sensitive benchmark is
> so sensitive that i easily get runs that are 2 times faster on 4:4 than
> on 3:1, and the 'results' are extremely stable and repeatable on the
> same kernel!
> 
> to eliminate layout effects, could you do another curve? Plain -aa4 (no

with page layout effects you mean different page coloring I assume, but it's
well proven that page coloring has no significant effect on those multi
associative x86 caches (we run some benchmark in the past to confirm that, ok
it was not on the same hardware but the associativity is similar, the big boost
of page coloring comes with bcache one way associative ;). Plus it's be a
tremendous conincidence if the caches were layed out exactly to support my
theories ;). Note that the position in the dimms doesn't matter much since the
whole point is when the stuff is at the limit of the l2 cache. I'm quite
certain you're wrong suspecting this -17% slowdown at 500k working set to be
just a measurement error due page coloring, I know the effects of page coloring
in practice, and they're visible even on consecutive runs w/o requiring a
kernel recompile or reboot and I verified consecutive runs the same results
(and I run various gnuplots/ssh etc..  between the runs). Of course there was a
tiny divergence between the runs (primarly due page coloring), but it wasn't
remotely comparable to the -17% gap and the order of the curves was always the
same (i.e. starting at HZ=100 and HZ=200, then at 200k the two curves crosses
and 4:4 goes all the way down, and HZ=1000 even lower). Just give it a spin
yourself too.

> 4:4 patch) but a __flush_tlb() added before and after do_IRQ(), in
> arch/i386/kernel/irq.c? This should simulate much of the TLB flushing
> effect of 4:4 on -aa4, without any of the other layout changes in the
> kernel. [it's not a full simulation of all effects of 4:4, but it should
> simulate the TLB flush effect quite well.]

sure I can try it (though not right now, but I'll try before the
weekend).

> once the kernel image layout has been stabilized via the __flush_tlb()
> thing, the way to stabilize user-space layout is to static link the
> benchmark and boot it via init=/bin/DOUBLE. This ensures that the
> placement of the physical pages is constant. Doing the test 'fresh after
> bootup' is not good enough.

You can try it too, you actually already showed the quips, maybe you
never looked at the per-working-set results.

btw, this is my hint.h setting to stop before paging and to get some more
granularity:

#define ADVANCE    1.1     /* 1.2589 */ /* Multiplier. We use roughly 1 decibel step size. */
                           /* Closer to 1.0 takes longer to run, but might    */
                           /* produce slightly higher net QUIPS.              */
#define NCHUNK     4       /* Number of chunks for scatter decomposition      */
                           /* Larger numbers increase time to first result    */
                           /* (latency) but sample domain more evenly.        */
#define NSAMP      200     /* Maximum number of QUIPS measurements            */
                           /* Increase if needed, e.g. if ADVANCE is smaller  */
#define NTRIAL     5       /* Normal number of times to run a trial           */
                           /* Increase if computer is prone to interruption   */
#define PATIENCE   7      /* Number of times to rerun a bogus trial          */
#define RUNTM      1.0    /* Target time, seconds. Reduce for high-res timer.*/
                           /* Should be much larger than timer resolution.    */
#define STOPRT     0.65     /* Ratio of current to peak QUIPS to stop at       */
                           /* Smaller numbers will beat on virtual memory.    */
#define STOPTM     100     /* Longest time acceptable, seconds.  Most systems */
                           /* run out of decent-speed memory well before this */
#define MXPROC     32      /* Maximum number of processors to use in shared   */                           /* memory configu
ration. Adjust as necessary.      */


I used DOUBLE compiled with -ffast-math -fomit-frame-pointer -march=pentium4,
but I don't think INT or any compiler thing can make a difference.

> [*] a nitpick: you keep saying '2000 tlb flushes per second'. This is
>     misleading, there's one flush of the userspace TLBs every 1 msec
>     (i.e. 1000 per second), and one flush of the kernel TLBs - but
>     the kernel TLBs are small at this point, especially with 4MB pages.

I'm saying 2000 tlb flushes only because I'd be wrong saying there are only
1000, but I obviously agree the cost of half of them is not significant (the
footprint of the irq handler is tiny).
