Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUCPUpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUCPUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:45:38 -0500
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:45008 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261651AbUCPUpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:45:30 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Kurt Garloff <garloff@suse.de>
Subject: Re: dynamic sched timeslices
Date: Wed, 17 Mar 2004 07:45:02 +1100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315224201.GX4452@tpkurt.garloff.de> <200403170013.38140.kernel@kolivas.org> <20040316142957.GX4452@tpkurt.garloff.de>
In-Reply-To: <20040316142957.GX4452@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403170745.02538.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004 01:29 am, Kurt Garloff wrote:
> Hi Con,
>
> On Wed, Mar 17, 2004 at 12:13:37AM +1100, Con Kolivas wrote:
> > 2.4 O(1) effects do not directly apply with 2.6
> >
> > Dropping Hz will save you performance for sure on 2.6.
> >
> > Changing the timeslices in 2.6 will be disappointing, though. Although
> > the apparent timeslice of nice 0 tasks is 102ms, interactive tasks round
> > robin at 10ms. If you drop the timeslice to 10ms you will not improve the
> > interactive feel but you will speed up expiration instead which will
> > almost certainly worsen interactive feel.
>
> If you have a system with an easy workload (say one clear CPU hog and
> one interactive job), things are easy. The fact that you preempt the
> not-yet expired CPU hog is enough.
> That's easy, and that worked with 2.4 O(1) (if tweaked a bit to estimate
> interactiveness better, see other patch) and it works with 2.6.
>
> Things start to get difficult if you have something like a calculation
> program with a non-multithreaded GUI. It will look like a CPU hog and
> still you'd like to see it responsive. Now add a second CPU hog.
>
> The kernel can not fix this problem, but it can limit the damage by
> not having too long timeslices.
>
> There are other scenarios where the preemption will not solve all
> problems.
> Think two interactive processes, one playing audio, another one being
> your shell. The audio player may take the CPU for extended periods of
> times occasionally to decode the next N ogg frames. You still want the
> shell to react promptly, but it can't ... Thus you wish the timeslice
> not being too long.
>
> Thus you'll set them not too long for desktop kind of machines to
> not have to rely completely on the interactiveness estimator.

I'm not arguing with your logic I'm saying you will ruin the estimator in the 
process because it isn't just about timeslices and preemption. Ultimately 
you're still only give me theoretical cases which are exactly what were my 
test cases during development. Find a test case that you can prove it does 
something rather than a theoretical one. Oh and a test case should be one 
where it is the cpu scheduler that is responsible, not one where you're 
fixing problems due to poor hardware config with alsa, oss, IDE, dma settings 
etc.

> > If you drop timeslices below 10ms you will get
> > significant cache trashing and drop in performance (which your 2.4
> > results confirm).
>
> No doubt. Don't overdo it. It's a tradeoff. If you impact throughput too
> much, you'll not enjoy the short latency ;-)
>
> > Increasing timeslices does benefit pure number crunching workloads. The
> > benchmarking I've done using cache intensive workloads (which are the
> > most likely to benefit) show you are chasing diminishing returns, though.
> > You can mathematically model them based on the fact that keeping a task
> > bound to a cpu instead of shifting it to another cpu on SMP saves about
> > 2ms processing time on P4. Suffice to say the benefit is only worth it if
> > you do nothing but cpu intensive things, and becomes virtually
> > insignificant beyond 200ms. On other architecture with longer cache
> > decays you will benefit more; arch/i386/mach-voyager seems the longest at
> > 20ms.
>
> That's why I think we should offer the tunables.

If your workload is so dedicated to just number crunching it isn't hard to add 
a zero to maximum timeslice in kernel/sced.c. Then again this is just 
semantics about how to tune it so I don't really care, but I'm sure the 
maintainer wants proof that changing it shows some real world improvement.

Con
