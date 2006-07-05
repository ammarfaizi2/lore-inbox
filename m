Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWGEIY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWGEIY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGEIY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:24:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:25217 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932397AbWGEIY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:24:26 -0400
Date: Wed, 5 Jul 2006 10:19:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Message-ID: <20060705081934.GA1898@elte.hu>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <20060705063550.GA28004@elte.hu> <44AB726B.8070602@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB726B.8070602@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> >>+static inline void inc_mutex_count(void)
> >>+{
> >>+	current->mutexes_held++;
> >>+}
> >>+
> >>+static inline void dec_mutex_count(void)
> >>+{
> >>+	current->mutexes_held--;
> >>+}
> >>+
> >
> >NACK! This whole patch is way too intrusive for such a relatively small 
> >gain.
> >
> >also, if something doesnt hold a mutex, it might still be unsafe to 
> >background it! For example if it holds a semaphore. Or an rwsem. Or any 
> >other kernel resource that has exclusion semantics.
> >
> >so unless this patch gets _much_ less complex and much less intrusive, 
> >we'll have to stay with SCHED_BATCH and nice +19.
> 
> This means being less strict but (as you imply) that may be not much 
> better than nice +19.  I'll have a look at it.

it's way too much pain for little gain.

> Of course, a comprehensive (as opposed to RT only) priority 
> inheritance mechanism would make the "safe/unsafe to background" 
> problem go away and make this patch very simple.  Any plans in that 
> direction?

that seems quite unlikely to happen. I think you are missing the biggest 
issue: for RT, if the priority inheritance mechanism does not extend to 
a given scheduling pattern it causes longer latencies, but no harm is 
done otherwise. But for SCHED_BGND we'd have to make sure _every_ place 
is priority-inversions safe - otherwise we risk a potential local DoS if 
a task with a critical resource is backgrounded! That's plain impossible 
to achieve.

	Ingo
