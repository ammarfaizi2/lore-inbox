Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbSALFD6>; Sat, 12 Jan 2002 00:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284761AbSALFDi>; Sat, 12 Jan 2002 00:03:38 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:13325 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S284831AbSALFD2>;
	Sat, 12 Jan 2002 00:03:28 -0500
Date: Fri, 11 Jan 2002 22:00:51 -0700
From: yodaiken@fsmlabs.com
To: Rob Landley <landley@trommello.org>
Cc: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020111220051.A2333@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Jan 11, 2002 at 03:22:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:22:08PM -0500, Rob Landley wrote:
> I preempt leads to disaster than Linux can't do SMP.  Are you saying that's 
> the case?
> 
> The preempt patch is really "SMP on UP".  If pre-empt shows up a problem, 

People keep repeating this, it must feel reassuring.

	/* in kernel mode: does it need a lock? */
	m = next_free_page_from_per_cpu_cache();

To start, preemptive means that the optimizations for SMP that reduce
locking by per cpu localization do not work. 
So, as I understand it:
	the preempt patch is really "crappy SMP on UP" 
may be correct. But what you wrote is not.
Did I miss something? That's not a rhetorical question - I recall
being wrong before so go ahead and explain what's wrong with my logic.
        

> then it's a problem SMP users will see too.  If we can't take advantage of 
> the existing SMP locking infrastructure to improve latency and interactive 
> feel on UP machines, than SMP for linux DOES NOT WORK.
> 
> > All the numbers I've seen show Morton's low latency just works better. Are
> > there other numbers I should look at.
> 
> This approach is basically a collection of heuristics.  The kernel has been 

One patch makes the numbers look good (sort of)

One patch does not but "improves feel" and breaks a exceptionally useful 
rule: per cpu data in kernel that is not touched by interrupt code does not
need to be locked.

The basic assumption of the preempt trick is that locking for SMP is 
based on the same principles as locking for preemption and that's completely
false.  

I believe that the preempt path leads inexorably to
mutex-with-stupid-priority-trick and that would be very unfortunate indeed.
It's unavoidable because sooner or later someone will find that preempt +
SCHED_FIFO leads to 
		niced app 1 in K mode gets Sem A
		SCHED_FIFO app prempts and blocks on  Sem A
		whoops! app 2 in K more preempts niced app 1

	Hey my DVD player has stalled, lets add sem_with_revolting_priority_trick!
	Why the hell is UP Windows XP3 blowing away my Linux box on DVD playing while
	Linux now runs with the grace and speed of IRIX? 
	And has anyone fixed all those mysterious hangs caused by the interesting 
	interaction of hundreds of preempted semaphores?


		



> profiled and everywhere a latency spike was found, a band-aid was put on it 
> (an explicit scheduling point).  This doesn't say there aren't other latency 
> spikes, just that with the collection of hardware and software being 
> benchmarked, the latency spikes that were found have each had a band-aid 
> individually applied to them.
> 
> This isn't a BAD thing.  If the benchmarks used to find latency spikes are at 
> all like real-world use, then it helps real-world applications.  But of 
> COURSE the benchmarks are going to look good, since tuning the kernel to 
> those benchmarks is the way the patch was developed!
> 
> The majority of the original low latency scheduling point work is handled 
> automatically by the SMP on UP kernel.  You don't NEED to insert scheduling 
> points anywhere you aren't inside a spinlock.  So the SMP on UP patch makes 
> most of the explicit scheduling point patch go away, accomplishing the same 
> thing in a less intrusive manner.  (Yes, it makes all kernels act like SMP 
> kernels for debugging purposes.  But you can turn it off for debugging if you 
> want to, that's just another toggle in the magic sysreq menu.  And this isn't 
> entirely a bad thing: applying the enormous UP userbase to the remaining SMP 
> bugs is bound to squeeze out one or two more obscure ones, but those bugs DO 
> exist already on SMP.)

This is the logic of _every_ variant of "lets put X windows in the kernel
and let the kernel hackers fix it" .  Konquerer crashed when I used it 
yesterday. Let's put it in the kernel too and apply that enormous UP
userbase to the remaining bugs.

> 
> However, what's left of the explicit scheduling work is still very useful.  
> When you ARE inside a spinlock, you can't just schedule, you have to save 
> state, drop the lock(s), schedule, re-acquire the locks, and reload your 
> state in case somebody else diddled with the structures you were using.  This 
> is a lot harder than just scheduling, but breaking up long-held locks like 
> this helps SMP scalability, AND helps latency in the SMP-on-UP case.
> 
> So the best approach is a combination of the two patches.  SMP-on-UP for 
> everything outside of spinlocks, and then manually yielding locks that cause 
> problems.  Both Robert Love and Andrew Morton have come out in favor of each 
> other's patches on lkml just in the past few days.  The patches work together 
> quite well, and each wants to see the other's patch applied.


> 
> Rob

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

