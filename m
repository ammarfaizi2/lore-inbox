Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUGJMrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUGJMrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266238AbUGJMrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:47:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3207 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266237AbUGJMrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:47:17 -0400
Date: Sat, 10 Jul 2004 14:48:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710124814.GA27345@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709195105.GA4807@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > unlike the lowlatency patches, this patch doesn't add a lot of new
> > scheduling points to the source code, it rather reuses a rich but
> > currently inactive set of scheduling points that already exist in the
> > 2.6 tree: the might_sleep() debugging checks. Any code point that does
> > might_sleep() is in fact ready to sleep at that point. So the patch
> > activates these debugging checks to be scheduling points. This reduces
> > complexity and impact quite significantly.
> 
> I don't think this is a good idea.  Just because a function might
> sleep it doesn't mean it should sleep.  I'd rather add the
> might_sleep() to cond_resched() and replace the former with the latter
> in the cases where it makes sense.

think of voluntary preemption as a variant of CONFIG_PREEMPT with
different tradeoffs: it doesnt preempt as much code but it's cheaper (in
terms of code footprint and overhead) and less risky (in terms of code
affected).

What you say is equivalent to: 'because a process has higher priority it
doesnt mean it should be scheduled to', which is the wrong approach
because it is ultimately the decision of the user which tasks get
scheduled (by giving processes various priorities) and the decision of
the scheduler (for freely schedulable tasks). The preemption decision
does not depend and should not depend on the kernel function utilized!

if you dont care about latencies and want to maximize throughput (for
e.g. servers) then you dont want to enable CONFIG_PREEMPT_VOLUNTARY. 
That way you get artificial batching of parallel workloads.

FYI, i am also preparing a preemption patch where there's a (per-task)
tunable for 'expected maximum latency' and the kernel would measure
latencies and not do a forced preemption unless this latency is being
exceeded.

Voluntary preemption and CONFIG_PREEMPT means this tunable has a value
of 0 - we reschedule as soon as possible. Server workloads mean a much
higher tolerated latency value in the range of 50 msecs or so. Both are
fair expectations and settings.

	Ingo
