Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUG1JBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUG1JBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUG1JBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:01:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6839 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266490AbUG1JBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:01:13 -0400
Date: Wed, 28 Jul 2004 08:45:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Scott Wood <scott@timesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040728064547.GA16176@elte.hu>
References: <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040722185308.GC4774@yoda.timesys> <20040722194513.GA32377@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722194513.GA32377@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.524, required 5.9,
	autolearn=not spam, BAYES_01 -1.52
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> There are also other problem with moving to a largely sleeping mutex
> style kernel, dead lock detection becomes sorely needed. Current
> spinlock detection methods are probably going to be useless in a
> system like this. [...]

i have another worry with the 'everything is a mutex' concept. Currently
we still do have a number of 'central' locks such as dcache_lock, or the
SLAB locks. So even if all (but the scheduling) spinlocks are converted
to sleeping mutexes what do you gain? A high-prio RT task will get to
execute userspace instructions almost immediately, but any kernel
functionality use of this RT thread might still be blocked by a priority
inversion problem. So the same type of latency problems that we are
detecting and solving currently will occur on a mutex-based system as
well - if the RT application wants to use kernel functionality.

so why dont we keep the spinlocks [on UP, nonpreemptible sections] and
just let the kernel finish its work and get to a fully lock-quiescent
state ASAP where we can reschedule? It's not like that a high-prio RT
task can avoid this situation with any guarantee, as long as these
central locks remain. (in fact it would have to do this processing with
higher overhead, because the lowprio thread that got preemption needs to
be boosted, scheduled, unscheduled and the high-prio task needs to
schedule again.)

i'd agree with turning most of the finegrained per-task (non-irq-safe)
spinlocks into mutexes (or spin-mutexes). But the central locks that an
RT task would likely hit need to remain spinlocks i believe.

plus there are central mutexes too that are in 'hiding' currently but
could cause latencies just as much.

	Ingo
