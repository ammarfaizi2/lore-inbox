Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUGVJt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUGVJt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUGVJt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:49:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42918 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266670AbUGVJtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:49:55 -0400
Date: Thu, 22 Jul 2004 11:51:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722095111.GA13125@elte.hu>
References: <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721184308.GA27034@elte.hu> <20040722023235.GB3298@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722023235.GB3298@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.428, required 5.9,
	autolearn=not spam, BAYES_20 -1.43
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> > what high/low semantics do you mean, other than the ordering of softirq
> > sources? (which is currently implemented via the __do_softirq() loop
> > first looking at the highest prio softirq.) So splitting up ksoftirqd
> > into two pieces seems like a separate issue.
> 
> I meant the current split between immediate-context softirqs (which
> are repesented in the patch by the high-priority ksoftirqd) and the
> low-priority thread which is used to avoid starvation while allowing
> softirqs to continue running if the system's otherwise more or less
> idle.

ok, i understand what you are trying to do. I dont think it makes much
sense to preserve the throttling property of the current
immediate/ksoftirqd processing. It was really an ad-hoc way to keep
softirqs from monopolizing the CPU. The simplest solution for softirq
deferral is to push it all into ksoftirqd and then let users change the
priority/policy of ksoftirqd.

it might make sense to create separate threads for each softirq level
that exists currently:

        HI_SOFTIRQ=0,
        TIMER_SOFTIRQ,
        NET_TX_SOFTIRQ,
        NET_RX_SOFTIRQ,
        SCSI_SOFTIRQ,
        TASKLET_SOFTIRQ

but this doesnt solve the problem either, because the current softirq
splitup is too opaque - there's no priority-based distinction between
softirq processing. Doing full softirq scheduling by attaching the
softirq work to the process context that generates it (or an anymous
context for things that are not connected to any particular existing
context) is way too much work and not completely possible anyway. Much
of the irq work <-> context information is lost at higher levels. We
merge IO requests and do other optimizations. To track who generated
what would be quite some work.

so since we cannot do it perfectly i'd go for the simplest approach for
now: defer to a single ksoftirqd per CPU. Then if someone comes up with
a good patch to attach all hardirq/softirq processing to a particular
context we can implement precise scheduling of hardirq/softirq work,
based on the priority/policy of the context that generated/receives the
interrupt event.

	Ingo
