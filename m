Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265933AbRGOHoQ>; Sun, 15 Jul 2001 03:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265941AbRGOHoG>; Sun, 15 Jul 2001 03:44:06 -0400
Received: from [209.234.73.40] ([209.234.73.40]:14344 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S265933AbRGOHn4>;
	Sun, 15 Jul 2001 03:43:56 -0400
Date: Sun, 15 Jul 2001 02:42:55 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
        lse-tech@lists.sourceforge.net
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010715024255.F3965@altus.drgw.net>
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com>; from mkravetz@sequent.com on Thu, Jul 12, 2001 at 04:40:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 04:40:17PM -0700, Mike Kravetz wrote:
> This discussion was started on 'lse-tech@lists.sourceforge.net'.
> I'm widening the distribution in the hope of getting more input.
> 
> It started when Andi Kleen noticed that a single 'CPU Hog' task
> was being bounced back and forth between the 2 CPUs on his 2-way
> system.  I had seen similar behavior when running the context
> switching test of LMbench.  When running lat_ctx with only two
> threads on an 8 CPU system, one would ?expect? the two threads
> to be confined to two of the 8 CPUs in the system.  However, what
> I have observed is that the threads are effectively 'round
> robined' among all the CPUs and they all end up bearing
> an equivalent amount of the CPU load.  To more easily observe
> this, increase the number of 'TRIPS' in the benchmark to a really
> large number.

Did this 'CPU Hog' task do any I/O that might have caused an interrupt?

I'm wondering if the interrupt distribution has anything to do with this.. 
are you using any CPU affinity for interrupts? If not, this might explain 
why the processes wind up doing a 'round robin'.

I'm trying to reproduce this with gzip on a dual Mac G4, and I'm wondering
if this will be scewed any because all interrupts are directed at cpu0, so
anything that generates input or output on the network or serial is going
to tend to wind up on cpu0.

I'd also like to figure out what the IPI latency actually is.. Does anyone
have any suggestions how to measure this? I would hope it's lower on the
dual 7410 machine I have since I have 4-stage pipelines as opposed to 20
odd stages that Pentium III class machines do..

> After a little investigation, I believe this 'situation' is caused
> by the latency of the reschedule IPI used by the scheduler.  Recall
> that in lat_ctx all threads are in a tight loop consisting of:
> 
> pipe_read()
> pipe_write()
> 
> Both threads 'start' on the same CPU and are sitting in pipe_read
> waiting for data.  A token is written to the pipe and one thread
> is awakened.  The awakened thread, then immediately writes the token
> back to the pipe which ultimately results in a call to reschedule_idle()
> that will 'initiate' the scheduling of the other thread.  In
> reschedule_idle() we can not take the 'fast path' because WE are
> currently executing on the other thread's preferred CPU.  Therefore,
> reschedule_idle() chooses the oldest idle CPU and sends the IPI.
> However, before the IPI is received (and schedule() run) on the
> remote CPU, the currently running thread calls pipe_read which
> blocks and calls schedule().  Since the other task has yet to be
> scheduled on the other CPU, it is scheduled to run on the current
> CPU.  Both tasks continue to execute on the one CPU until such time
> that an IPI induced schedule() on the other CPU hits a window where
> it finds one of the tasks to schedule.  We continue in this way,
> migrating the tasks to the oldest idle CPU and eventually cycling our
> way through all the CPUs.
> 
> Does this explanation sound reasonable?
> 
> If so, it would then follow that booting with 'idle=poll' would
> help alleviate this situation.  However, that is not the case.  With
> idle=poll the CPU load is not as evenly distributed among the CPUs,
> but is still distributed among all of them.
> 
> Does the behavior of the 'benchmark' mean anything?  Should one
> expect tasks to stay their preferred CPUs if possible?
> 
> Thoughts/comments
> -- 
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
