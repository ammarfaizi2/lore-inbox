Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWJ1TPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWJ1TPe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWJ1TPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:15:33 -0400
Received: from 1wt.eu ([62.212.114.60]:13316 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932085AbWJ1TPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:15:16 -0400
Date: Sat, 28 Oct 2006 21:15:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028191515.GA1603@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe> <1162006081.27225.257.camel@mindpipe> <20061028052837.GC1709@1wt.eu> <200610281137.22451.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610281137.22451.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 11:37:22AM -0700, Andi Kleen wrote:
> On Friday 27 October 2006 22:28, Willy Tarreau wrote:
> > On Fri, Oct 27, 2006 at 11:28:00PM -0400, Lee Revell wrote:
> > > On Fri, 2006-10-27 at 18:04 -0700, Andi Kleen wrote:
> > > > I don't think it makes too much sense to hack on pure RDTSC when
> > > > gtod is fast enough -- RDTSC will be always icky and hard to use.
> > >
> > > I agree FWIW, our application would be happy to just use gtod if it
> > > wasn't so slow on these machines.
> >
> > Agreed, I had to turn about 20 dual-core servers to single core because
> > the only way to get a monotonic gtod made it so slow that it was not
> > worth using a dual-core. 
> 
> Curious - what workload was that? 

Two different but related workloads :
  - load balancer doing between 10 and 100k gtod per second on a sun
    x2100 under RHEL 3. HPET was not available and the only way I found
    to get monotonic clock was to use the APIC timer IIRC (it was more
    than 6 months ago, so sorry if I don't remember about all the details).

  - network sniffer that I tried to tune to get the highest possible packet
    rates on gigabit ethernet.

> While gtod is time critical and often appears high on profile lists it is 
> normally not as time critical as you're claiming it is; especially not
> time critical enough to warrant such radical action.

Yes it was, because the small gain of using a dual core with such
a workload was clearly lost by that change. IIRC, I reached 25000
sessions/s on dual core with TSC if I didn't care about the clock,
20000 without TSC, and 18000 on single core+TSC. But with the sniffer,
it was even worse : I had 500 kpps in dual-core+TSC, 70kpps without
TSC and 300 kpps with single-core+TSC. Since I had to buy the same
machines for both uses, this last argument was enough for me to stick
to a single core.

> > I initially considered buying one dual-core 
> > AMD for my own use, but after seeing this, I'm definitely sure I won't
> > ever buy one as long as this problem is not fixed, as it causes too
> > many problems.
> 
> It's somewhat slower, but I'm not sure what "too many problems" you're
> refering to.

Anticipated or delayed timeouts on the proxy, time measurement errors
(when the logs show that a session finishes before it begins, there's
a real problem, particularly because we use those logs for troubleshooting).
And for the sniffer, getting wrong times by about 2s was a real problem too.
I would have preferred to get something monotonic with little accuracy than
out of order packets !

This is definitely a design problem on those chips, probably because
marketting targets gamers only. And that's very sad, because they are
excellent processors !

> -Andi

Regards,
Willy

