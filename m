Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUGVQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUGVQWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUGVQWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:22:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22434 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266705AbUGVQWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:22:32 -0400
Date: Thu, 22 Jul 2004 18:23:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722162357.GB23972@elte.hu>
References: <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FF9CD1.7050705@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >this is insufficient too. An RT task might be _waiting to run_ and
> >spending our time in a non-RT context (including the idle task) doing
> >softirq processing might delay it indefinitely.
> >
> >what we could do is to add a rq->nr_running_rt and do the deferred
> >softirq processing unconditionally if (rq->nr_running_rt). I'd still add
> >a sysctl to make it unconditional for user processes too - if someone
> >really cares about latency and doesnt want to make all his tasks RT. 
> >I'll code this up for the next version of the patch.
> >
> 
> Or just if (rt_task || need_resched). Another thing that may be
> worthwhile thinking about is allowing softirqs to be run directly from
> interrupt if the idle thread is running, maybe with an early exit if
> something becomes runnable. Although this all may be going down the
> path of too much complexity.

this doesnt work either: once we've committed ourselves to do an
'immediate' softirq processing pass we are risking latencies. We cannot
preempt the idle task while it's processing softirqs the same way we can
do the lock-break if they are always deferred.

Also, it's not really a performance issue if the system is idle then can
switch to ksoftirqd cheaply (lazy-TLB) and once we switch away from
ksoftirqd it costs as much as switching away from the idle task.

	Ingo
