Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRJBMMr>; Tue, 2 Oct 2001 08:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272856AbRJBMMi>; Tue, 2 Oct 2001 08:12:38 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:5301 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S272838AbRJBMMX>;
	Tue, 2 Oct 2001 08:12:23 -0400
Date: Tue, 2 Oct 2001 08:10:00 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, Ingo Molnar <mingo@elte.hu>,
        <netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011002011351.A20025@redhat.com>
Message-ID: <Pine.GSO.4.30.0110020724530.29541-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Oct 2001, Benjamin LaHaise wrote:

> On Mon, Oct 01, 2001 at 09:54:49PM -0400, jamal wrote:
>
> > And how does /proc/irq/NR/max_rate solve this?
> > I have a feeling you are trying to say that varying /proc/irq/NR/max_rate
> > gives opportunity for user processes to execute;
> > note, although that is bad logic, you could also modify the high and low
> > watermarks for when we have congestion in the backlog queue
> > (This is already doable via /proc)
>
> The high and low watermarks are only sufficient if the task the machine is
> performing is limited to bh mode operations.  What I mean is that user space
> can be starved by the cyclic nature of the network queues: they will
> eventually be emptied, at which time more interrupts will be permitted.
>

Which hardware flow control has been doing since 2.1 days;

> > It is unfair to add any latency to a device that didnt cause or
> > contributre to the havoc.
>
> I disagree.  When a machine is overloaded, everything gets slower.  But a
> side effect of delaying interrupts is that more work gets done for each
> irq handler that is run and efficiency goes up.  The hard part is balancing
> the two in an attempt to achieve a steady rate of progress.
>

Let me see if i understand this:
-scheme 1: shut down only actions (within a device) that are contributing
to the overload and only they get affected because they are misbehaving;
when things get better(and we know when they get better), we turn it on
again
- scheme two: shut down the IRQ which might infact include other devices
for a jiffy or two (which doesnt mean the condition got better)

Are you saying that you disagree scheme 1 is better?

> > I think you missed my point. i am saying there is more than one source of
> > interupt for that same IRQ number that you are indiscrimately shutting
> > down in a network device.
>
> You're missing the effect that irq throttling has: it results in a system
> that is effectively running in "polled" mode.  Information does get
> processed, and thruput remains high, it is just that some additional
> latency is found in operations.  Which is acceptable by definition as
> the system is under extreme load.

sure. Just like the giant bottom half lock is acceptable when you can do
fine grained locking ;->
Dont preach polling to me; i am already a convert and you attended the
presentation i gave. Weve had patches for months which have been running
on live system. We were just waiting for 2.5 ...

>
> > So, assuming that tx complete interupts do actually shut you down
> > (although i doubt that very much given the classical Donald Becker tx
> > descriptor prunning) pick another interupt source; lets say MII link
> > status; why do you want to kill that when it is not causing any noise but
> > is a source of good asynchronous information (that could be used for
> > example in HA systems)?
>
> That information will eventually be picked up.  I doubt the extra latency
> will be of significant note.  If it is, you've got realtime concerns,
> which is not our goal to address at this time.
>

You are still missing the point (by humping on the literal meaning of the
example i provide), the point is: fine grained vs shutting down the whole
IRQ.

>
> > and what is this "known safe limit"? ;->
>
> It's system dependant.  It's load dependant.  For a short list of the number
> of factors that you have to include to compute this:
>
> 	- number of cycles userspace needs to run
> 	- number of cache misses that userspace is forced to
> 	  incur due to irq handlers running
> 	- amount of time to dedicate to the irq handler
> 	- variance due to error path handling
> 	- increased system cpu usage due to higher memory load
> 	- front side bus speed of cpu
> 	- speed of cpu
> 	- length of cpu pipelines
> 	- time spent waiting on io cycles
> 	.....
>
> It is non-trivial to determine a limit.  And trying to tune a system
> automatically is just as hard: which factor do you choose for the system
> to attempt to tune itself with?  How does that choice affect users who
> want to tune for other loads?  What if latency is more important than
> dropping data?
>
> There are a lot of choices as to how we handle these situations.  They
> all involve tradeoffs of one kind or another.  Personally, I have a
> preference towards irq rate limiting as I have measured the tradeoff
> between latency and thruput, and by putting that control in the hands of
> the admin, the choice that is best for the real load of the system is
> not made at compile time.
>
> If you look at what other operating systems do to schedule interrupts
> as tasks and then looks at the actual cost, is it really something we
> want to do?  Linux has made a point of keeping things as simple as
> possible, and it has brought us great wins because we do not have the
> overhead that other, more complicated systems have chosen.  It might
> be a loss in a specific case to rate limit interrupts, but if that is
> so, just change the rate.  What can you say about the dynamic self
> tuning techniques that didn't take into account that particular type
> of load?  Recompiling is not always an option.
>

I am not sure where you are getting the  opinion that there is recompiling
involved or how what we have is complex (the patch is much smaller than
what Ingo posted);
And no, you dont need to maintain any state of all those things in your
list; in 2.4, which is a good start, you have the system load being probed
via a second order effect i.e the growth rate of the backlog queue is a
good indicator that the system is not pulling packets off fast enough.
This is a very good measure of _all_ those items on your list. I am not
saying it is God's answer, merely pointing that it is a good indicator
which doesnt need to maintain state of 1000 items or cause additional
computations on the datapath.
We get a fairly early warning that we are about to be overloaded. We can then
shut off the offending device's _receive_ interupt source when it doesnt
heed the congestion notification advice weve been giving it. It heeds the
advice by mitigating.
In the 2.5 patch (i should say it is a clean patch to 2.4 actually and is
backward compatible) we worked around the fact that the 2.4 solution
requires a specific NIC feature (mitigation) among a lot of other things.
Infact we have already proven that mitigation is only good when you have
one or two NICs on the system.

> > What we are providing is actually a scheme to exactly measure that "known
> > safe limit" you are refering to without depending on someone having to
> > tell you "here's a good number for that 8 way xeon"
> > If there is system capacity available  why the fsck is it not being used?
>
> That's a choice for the admin to make.  Sometimes having reserves that aren't
> used is a safety net that people are willing to pay for.  ext2 has by
> default a reserve that isn't normally used.  Do people complain?  No.  It
> buys several useful features (resistance against fragmentation, space for
> daemon temporary files on disk full, ...) that pay dividends of the cost.
>

I am not sure whether you are trolling or not. We are talking about a
system conserving a work principle and you compare it a reservation
system.

> Is irq throttling the be all and end all?  No.  Can other techniques work
> better?  Yes.  Always?  No.  And nothing prevents us from using this and
> other techniques together.  Please don't dismiss it solely because you
> see cases that it doesn't handle.
>

I am not dismising the whole patch. I most definetly dismiss those
two ideas i pointed out.

cheers,
jamal

