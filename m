Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266882AbUGVSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUGVSgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUGVSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:36:55 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:47007 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266882AbUGVSgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:36:47 -0400
Date: Thu, 22 Jul 2004 14:36:18 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722183618.GB4774@yoda.timesys>
References: <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721184308.GA27034@elte.hu> <20040722023235.GB3298@yoda.timesys> <20040722095111.GA13125@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722095111.GA13125@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 11:51:11AM +0200, Ingo Molnar wrote:
> * Scott Wood <scott@timesys.com> wrote:
> > I meant the current split between immediate-context softirqs (which
> > are repesented in the patch by the high-priority ksoftirqd) and the
> > low-priority thread which is used to avoid starvation while allowing
> > softirqs to continue running if the system's otherwise more or less
> > idle.
> 
> ok, i understand what you are trying to do. I dont think it makes much
> sense to preserve the throttling property of the current
> immediate/ksoftirqd processing. It was really an ad-hoc way to keep
> softirqs from monopolizing the CPU. The simplest solution for softirq
> deferral is to push it all into ksoftirqd and then let users change the
> priority/policy of ksoftirqd.

Ideally, yes.  However, there isn't currently a scheduling policy that
allows the softirq thread to run as a moderately high priority
realtime thread for a short period of time, and drop it to a low
priority non-realtime thread if it runs for longer than it "should".

Running it as one high priority non-realtime task would work if all
you want to run are non-realtime tasks and very high priority RT
tasks (which are intended to have higher priority than softirqs). 
This is assuming that a high-priority non-RT task will always preempt
a lower priority task except when it has depleted its timeslice; I'm
not familiar enough with the current scheduler to know whether that
is the case.

> it might make sense to create separate threads for each softirq level
> that exists currently:
> 
>         HI_SOFTIRQ=0,
>         TIMER_SOFTIRQ,
>         NET_TX_SOFTIRQ,
>         NET_RX_SOFTIRQ,
>         SCSI_SOFTIRQ,
>         TASKLET_SOFTIRQ
> 
> but this doesnt solve the problem either, because the current softirq
> splitup is too opaque - there's no priority-based distinction between
> softirq processing.

Splitting it that way would be nice from the perspective of giving
the user the ability to place more importance on certain types of
softirqs, but it's not what I was trying to do with the high/low
threads.

> so since we cannot do it perfectly i'd go for the simplest approach for
> now: defer to a single ksoftirqd per CPU.

The dual-thread model is about as simple as the immediate/thread
split that is currently there, IMHO, and while not perfect, it is an
improvement over having to pick only one policy/priority given the
current choices of policy.

-Scott
