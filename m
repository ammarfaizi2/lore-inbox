Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSAXPem>; Thu, 24 Jan 2002 10:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288422AbSAXPei>; Thu, 24 Jan 2002 10:34:38 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:773 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288377AbSAXPeU>;
	Thu, 24 Jan 2002 10:34:20 -0500
Date: Thu, 24 Jan 2002 08:19:50 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020124081950.A5668@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <1011650506.850.483.camel@phantasy> <20020121165659.A20501@hq.fsmlabs.com> <E16SqOY-0001mL-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16SqOY-0001mL-00@starship.berlin>; from phillips@bonn-fries.net on Tue, Jan 22, 2002 at 03:10:42AM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 03:10:42AM +0100, Daniel Phillips wrote:
> On January 22, 2002 12:56 am, yodaiken@fsmlabs.com wrote:
> > I have not seen that argued - certainly I have not argued it myself.
> > My argument is:
> > 	It makes the kernel _much_ more complex
> 
> The patch itself is simple, so this must be an extended interpretation of the 
> word 'complex'.

I'm at a loss here. You seem to be arguing that
there there is a relationship between the complexity of a patch
that changes the entire synchronization assumption of the
kernel and the complexity of the result. But that seems
unbelievable. Is there some component of your argument I've missed?

> 
> > 	It has known costs e.g. by making the lockless 
> > 		per-processor caching  more difficult if not impossible
> 
> Not at all, the lazy man's way of dealing with this is to disable preemption 
> around that code, an efficient operation.

Well, aside from how easy it will be to isolate all that information,
doesn't that defeat the purpose of the patch?  There is a big
difference in design between
	try to get fromverylightweight cache
		fallback to slow but fair and safe pool
and
	try to bound worst case times

In the first case we amortize worst case times by making average case
very low. This is a common design methodology in Linux kernel: semaphores
are the classic example.
So I'm sure that you can add any number of hacks to the kernel, but my
argument stands: per-processor caching is a common case optimization that
de-optimizes worst case. If the purpose of preemption is to reduce
latency, per-processor caching is at counter-purposes.


It's also worth pointing out that every use of cpu-specific information
is dangerous if preemption is extended to smp.
	x = smp_processor_id();
	//get preempted
	do_something(memslab[x]); // used to be safe since only current can
				// do this.

	
> > 	It seems to lead to a requirement for inheritance
> 
> I don't know about that.  From the (long) thread above, it looks like you 
> haven't successfully proved the assertion that -preempt introduces any new 
> inheritance requirement.

Oliver cited the trivial case. He was ignored.

> > 	It has no demonstrated benefits.
> 
> Demonstrated to who?  I have certainly demonstrated the benefits to myself, 
> and others have attested to doing the same.

I've heard similar arguments in favor of aromatherapy and Scientology.

What's amazing about all the arguments in favor of preemption is that we
don't see any published numbers of the obvious application: a periodic
SCHED_FIFO process. We've done these experiments and the results are
_dismal_. 
Even ignoring this, the repeated publication of numbers showing that
Andrew's patches get better results and the repeated statement by 
Andrew that the hard part of latency reduction
is _not_ solved by preemption alone
is continually met with repetitions of the same unsubstantiated chorus:
	But it is easier to maintain  



> As far as arguments go, your main points don't seem to be rooted in firm 
> ground at all.  On the other hand, the proponents of this patch have 
> compelling arguments: it makes Linux feel smoother, it makes certain tests 
> run faster, it doesn't slow anything down measurably, it's stable and so on.  
> I even explained why it does what it does.  I don't understand why you're so 
> vehemently opposed to this, especially as it's a config option.

What you proposed is a
claimed explanation of why a task that experienced regular unfixable
latencies of multiple milliseconds waiting for I/O would have additional
latencies possibly reduced by some unknown amount. You failed to make a
case that this is either something that actually happens or that it would
ever make any difference.

BTW: I've made no arguments that the patch should not be made an option.
I've argued that it is based on a very bad design premise. As for
whether it should be added to 2.5,  sold by other vendors, advertised on TV,
used when operating heavy machinery, or taken by pregnant women,
that's not up to me.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

