Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbRGORCL>; Sun, 15 Jul 2001 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbRGORCB>; Sun, 15 Jul 2001 13:02:01 -0400
Received: from altus.drgw.net ([209.234.73.40]:41992 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S266710AbRGORBp>;
	Sun, 15 Jul 2001 13:01:45 -0400
Date: Sun, 15 Jul 2001 12:00:38 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Andi Kleen <ak@suse.de>
Cc: Mike Kravetz <mkravetz@sequent.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Message-ID: <20010715120037.I3965@altus.drgw.net>
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com> <20010715024255.F3965@altus.drgw.net> <20010715110543.A9981@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010715110543.A9981@gruyere.muc.suse.de>; from ak@suse.de on Sun, Jul 15, 2001 at 11:05:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 11:05:43AM +0200, Andi Kleen wrote:
> On Sun, Jul 15, 2001 at 02:42:55AM -0500, Troy Benjegerdes wrote:
> > On Thu, Jul 12, 2001 at 04:40:17PM -0700, Mike Kravetz wrote:
> > > This discussion was started on 'lse-tech@lists.sourceforge.net'.
> > > I'm widening the distribution in the hope of getting more input.
> > > 
> > > It started when Andi Kleen noticed that a single 'CPU Hog' task
> > > was being bounced back and forth between the 2 CPUs on his 2-way
> > > system.  I had seen similar behavior when running the context
> > > switching test of LMbench.  When running lat_ctx with only two
> > > threads on an 8 CPU system, one would ?expect? the two threads
> > > to be confined to two of the 8 CPUs in the system.  However, what
> > > I have observed is that the threads are effectively 'round
> > > robined' among all the CPUs and they all end up bearing
> > > an equivalent amount of the CPU load.  To more easily observe
> > > this, increase the number of 'TRIPS' in the benchmark to a really
> > > large number.
> > 
> > Did this 'CPU Hog' task do any I/O that might have caused an interrupt?
> 
> Yes; it did some IO, but most of its time was doing CPU work
> (it was CPU bound)

I shouldn't have sent that first email out so quickly. About 5 minutes 
after I sent it, I saw gzip switching CPU's with top a lot.

The next very interesting thing I found was that if I run something like 
'while true; do true; done' to load the other CPU while gzip is running, 
gzip runs faster. The time change isn't very large, and appears to be just 
barely detectable above the noise, but it definetly appears that gzip is 
bouncing back and forth between cpus if both are idle.

I'm tempted to try the somewhat brute-force approach of increasing
PROC_CHANGE_PENALTY, which is currently set to 20 (on ppc) to something
like 100. Would this be an adequate 'short-term' solution util there is 
some sort of multi-queue scheduler that everyone Linus likes? What are the 
drawbacks of increasing PROC_CHANGE_PENALTY?

> I'm not sure about the Mac, but on x86 linux boxes the SMP bootup synchronizes
> the time stamp counters of the CPUs. If they are synchronized on your box
> also you could store TSC value in the IPI sender and compute the average
> latency in the receiver. 

The PPC has a 'timebase register' which is effectively the same thing as 
the TSC, except it counts processor bus ticks/4, not cpu cycles.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
