Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266087AbTLIURr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbTLIURq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:17:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266112AbTLIUPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:55 -0500
Date: Tue, 9 Dec 2003 11:38:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031209193801.GF19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209151103.GA4837@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> The more fine-grained work is not complete and I'm not sure it ever
> will be. Some _preliminary_ results (i.e. take with a grain of salt):
> The regression for kbuild in 2.5.48 was caused by a patch titled "better
> inode reclaim balancing". In 2.5.49, "strengthen the `incremental
> min' logic in the page". In 2.6.0-test3 (aka 2.6.78), it's a subtle
> interaction between "fix kswapd throttling" and "decaying average of
> zone pressure" -- IIRC reverting the former gains nothing unless you
> also revert the latter. I'd have to dig through my notes.

Okay, it sounds like you're well on our way to cleaning things up.
Not too hard to chime in as needed.


On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
>> It was defined in two different ways: cpu utilization (inverse of iowait)
>> and multiprogramming level (how many tasks it could avoid suspending).

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> Yeah, that's the classic. It _is_ throughput. Unless you have task
> priorities (i.e. eye candy or SETI@home competing for cycles), CPU
> utilization is an excellent approximation for throughput. And the
> benefit of maintaining a high level of multiprogramming is that you
> have a better chance to have a runnable process at any time, meaning
> better CPU utilization meaning higher throughput.
> The classic strategies based on these criteria work for transaction and
> batch systems. They are all but useless, though, for a workstation and
> even most modern servers, due to assumptions that are incorrect today
> (remember all the degrees of freedom a scheduler had 30 years ago)
> and additional factors that only became crucial in the past few decades
> (latency again).

This assessment is inaccurate. The performance metrics are not entirely
useless, and it's rather trivial to recover data useful for modern
scenarios based on them. The driving notion from the iron age (I guess
the stone age was when the only way to support virtual memory was
swapping) was that getting stuck on io was the thing preventing the cpu
from getting used. Nowadays, we burn the cpu nicely enough with GNOME
etc. but have to worry about what happens to some task or other. So:

(a) Multiprogramming level is obviously trying to minimize the amount of
	swapping out going on. i.e. this is trying to limit the worst case
	handling to the worst case. Minimal adjustments are required. e.g.
	consider number of process address spaces swapped out directly
	as something to be minimized instead of total minus that.
(b) CPU utilization is essentially trying to minimize how much the system
	gets stuck on io. This one needs more adjustment for modern systems,
	which tend to utilize the cpu regardless of io being in flight.
	Number of blocked tasks is a close approximation, directly using
	iowait, and so on are various other possible substitutes.


On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
>> Demoting the largest task is one that does worse than random.

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> We only know that to be true for irrelevant optimization criteria.

The above explains how and why they are relevant.

It's also not difficult to understand why it goes wrong: the operation
is too expensive.


On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
>> Like the PFF bits for WS?

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> Yup. PFF doesn't cover all disk I/O, though. Suspending a process that
> is I/O bound even with a low PFF improves thrashing performance as well,
> because disk I/O is the bottleneck.

That's a significantly different use for it; AIUI it was an heuristic
to estimate the WSS without periodic catastrophes like WSinterval,
though ISTR bits about "extremely high" rates contracting the estimated
size.


On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
>> Top 0.001%? For expanded range, both endpoints matter. My notion of
>> scalability is running like greased lightning (compared to other OS's)
>> on everything from some ancient toaster with a 0.1MHz cpu and 256KB RAM
>> to a 16384x/16PB superdupercomputer.

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> Well, that's nice. I agree. IIRC, though, each major release had more
> demanding minimum requirements (in terms of RAM). The range covered
> has been growing only because upward scalability grew faster. I can't
> help but notice that some of your statements sound a lot like wishful
> thinking.

This is not wishful thinking; it's an example that tries to illustrate
the goal. It's rather clear to me that neither end of the spectrum
mentioned above is even functional in current source (well, 4096x might
boot with deep enough stacks, though I'd expect it to perform too poorly
to be considered functional).


On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
>> No matter how many pieces of hardware you buy, the original one still
>> isn't driven correctly by the software. Hardware *NEVER* fixes software.

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> Look, I became the maintainer of via-rhine because nobody else wanted to
> fix the driver for a very common, but barely documented piece of
> cheap hardware. People were just told to buy another cheap card. That's
> the reality of Linux.

That's an _unfortunate_ reality. And you changed it in a similar way to
how we want to support the lower end, though I'm going a bit lower end
than you are.


On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> Don't forget what we are talking about, though. Once you are seriously
> tight on memory, you can only mitigate the damage in software, the only
> solution is to add more RAM. Thrashing is not a bug like a broken driver.

Covering for low quality hardware is generally a kernel's job. c.f. the
"how many address lines did this device snip off" games that have even
infected the VM. Of course, it's not as clear cut as an oops, no.


On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> I am currently writing a paper on the subject, and the gist of it will
> likely be that we should try to prevent thrashing from happening as
> long as possible (with good page replacement, I/O scheduling, etc.),
> but when it's inevitable we're pretty much done for. Load control may
> or may not be worth adding, but it only helps in some special cases
> and does not seem clearly beneficial in general-purpose systems.

Figures.


On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
>> The common case is pretty much zero or slim overcommitment these days.
>> The case I have in mind is pretty much 10x RAM committed. (Sum of WSS's,
>> not non-overcommit-related.)

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> So you want to help people who for some reason _have_ to run several
> _batch_ jobs _concurrently_ (otherwise load control is ineffective)
> on a low-end machine to result in a 10x overcommit system? Why don't
> we buy those two or three guys a DIMM each?
> I'm afraid you have a solution in search of a problem. Nobody runs a
> 10x overcommit system. And if they did, they would find it doesn't work
> well with 2.4, either, so no one will complain about a regression. What
> does happen, though, is that people go close to the limit of what
> their low-end hardware supports, which will work perfectly with 2.4
> and collapse with 2.6.
> The real problem, the one many people will hit, the one the very
> complaint that started this thread was about, is light and medium
> overcommit. And load control is not the answer to that.

No, I've got some guy in Russia complaining about 2.6 sucking on his
box who has a 10x overcommit ratio (approximate sum of WSS's).

(Also, whatever this thread was, the In-Reply-To: chain was broken
somewhere and the first thing I saw was the post I replied to.)

Hmm.

I was trying to avoid duplicating effort and/or preempt someone's code
they were working on because I'd heard either you and/or Nick Piggin
were working on the stuff. You're doing something useful and relevant...

Well, I guess I might as well help with your paper. If the demotion
criteria you're using are anything like what you posted, they risk
invalidating the results, since they're apparently based on something
worse than random.


-- wli
