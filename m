Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVASRsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVASRsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVASRsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:48:19 -0500
Received: from mail.joq.us ([67.65.12.105]:45284 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261816AbVASRpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:45:08 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us>
	<871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu>
	<87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu>
	<87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu>
	<87pt02pt0r.fsf@sulphur.joq.us> <20050119082433.GE29037@elte.hu>
	<20050119143927.GA11950@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 11:45:52 -0600
In-Reply-To: <20050119143927.GA11950@elte.hu> (Ingo Molnar's message of
 "Wed, 19 Jan 2005 15:39:27 +0100")
Message-ID: <87651tmhwv.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> i'm not suggesting that this is the way to go, it's just to test how
>> nice--20 tasks would perform (on the hacked kernel). We still dont
>> have this data, because in the other tests you tried, some
>> non-highprio threads got nice--20 priority as well, which can (and
>> apparently do) interfere with the highprio threads.

I could hack the threads that the test actually uses just to get some
numbers.  But, that will break some existing JACK clients.

> ('highprio threads' are the ones that normally get SCHED_FIFO priority
> with -R, 'lowprio threads' are the other client-side threads, if any.)

I usually call them `realtime threads' and `non-realtime threads'.
Means the same thing.  I think of them that way, because any code
running in a realtime thread is severely constrained.  It must be
written *very* carefully, almost like a hardware interrupt handler.

> to make it easier to test, i've written an API hack: with the kernel
> patch below setscheduler() will set the task to nice --20 if you use
> SCHED_FIFO and sched_priority of 1. I.e. all you need to do is to run
> Jack with -R and use an RT priority of 1 - all the highprio threads
> should then become nice --20. If you use RT prio 2 (or higher) it should
> be SCHED_FIFO again. Just apply the patch to 2.6.11-rc1 (2.6.10 might
> work too) and it will work automatically. (the hack also includes the
> earlier 'no starvation for nice--20 tasks' hack.)

Good idea, thanks.

These tests mean a lot more running "real" audio programs.  :-)

> @@ -3211,6 +3211,12 @@ static inline task_t *find_process_by_pi
>  static void __setscheduler(struct task_struct *p, int policy, int prio)
>  {
>  	BUG_ON(p->array);
> +	if (prio == 1 && policy != SCHED_NORMAL) {
> +		p->policy = SCHED_NORMAL;
> +		p->static_prio = NICE_TO_PRIO(-20);
> +		p->prio = p->static_prio;
> +		return;
> +	}
>  	p->policy = policy;
>  	p->rt_priority = prio;
>  	if (policy != SCHED_NORMAL)
>

JACK actually uses three different priorities, the defaults are 9, 10
and 20.  How about if I change this test?

	if (prio <= 20 && policy != SCHED_NORMAL) {

Or, should that be?

	if (prio > 0 && prio <= 20 && policy != SCHED_NORMAL) {
-- 
  joq
