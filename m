Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288121AbSAHPyw>; Tue, 8 Jan 2002 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288124AbSAHPyn>; Tue, 8 Jan 2002 10:54:43 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:22536 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288121AbSAHPya>;
	Tue, 8 Jan 2002 10:54:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 16:54:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16Nxjg-00009W-00@starship.berlin> <20020108162930.E1894@inspiron.school.suse.de>
In-Reply-To: <20020108162930.E1894@inspiron.school.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Nyaf-0000A5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 04:29 pm, Andrea Arcangeli wrote:
> > The preemptible approach is much less of a maintainance headache, since 
> > people don't have to be constantly doing audits to see if something changed, 
> > and going in to fiddle with scheduling points.
> 
> this yes, it requires less maintainance, but still you should keep in
> mind the details about the spinlocks, things like the checks the VM does
> in shrink_cache are needed also with preemptive kernel.

Yes of course, the spinlock regions still have to be analyzed and both
patches have to be maintained for that.  Long duration spinlocks are bad
by any measure, and have to be dealt with anyway.

> > Finally, with preemption, rescheduling can be forced with essentially zero 
> > latency in response to an arbitrary interrupt such as IO completion, whereas 
> > the non-preemptive kernel will have to 'coast to a stop'.  In other words, 
> > the non-preemptive kernel will have little lags between successive IOs, 
> > whereas the preemptive kernel can submit the next IO immediately.  So there 
> > are bound to be loads where the preemptive kernel turns in better latency 
> > *and throughput* than the scheduling point hack.
> 
> The I/O pipeline is big enough that a few msec before or later in a
> submit_bh shouldn't make a difference, the batch logic in the
> ll_rw_block layer also try to reduce the reschedule, and last but not
> the least if the task is I/O bound preemptive kernel or not won't make
> any difference in the submit_bh latency because no task is eating cpu
> and latency will be the one of pure schedule call.

That's not correct.  For one thing, you don't know that no task is eating
CPU, or that nobody is hogging the kernel.  Look at the above, and consider
the part about the little lags between IOs.

> > Mind you, I'm not devaluing Andrew's work, it's good and valuable.  However 
> > it's good to be aware of why that approach can't equal the latency-busting 
> > performance of the preemptive approach.
> 
> I also don't want to devaluate the preemptive kernel approch (the mean
> latency it can reach is lower than the one of the lowlat kernel, however
> I personally care only about worst case latency and this is why I don't
> feel the need of -preempt),

This is exactly the case that -preempt handles well.  On the other hand,
trying to show that scheduling hacks satisfy any given latency bound is
equivalent to solving the halting problem.

I thought you had done some real time work?

> but I just wanted to make clear that the
> idea that is floating around that preemptive kernel is all goodness is
> very far from reality, you get very low mean latency but at a price.

A price lots of people are willing to pay.

By the way, have you measured the cost of -preempt in practice?

--
Daniel
