Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264813AbUEKQNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbUEKQNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUEKQNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:13:43 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:61156 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S264813AbUEKQNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:13:41 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] fix init_idle() locking problem
Date: Tue, 11 May 2004 10:13:38 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200405101032.18508.bjorn.helgaas@hp.com> <20040511093913.GA17185@elte.hu>
In-Reply-To: <20040511093913.GA17185@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111013.39122.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 May 2004 3:39 am, Ingo Molnar wrote:
> * Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > init_idle() removes "idle" from its runqueue, but there's a window
> > between looking up the runqueue and locking it, where another CPU can
> > move "idle" to a different runqueue, i.e., via load_balance().
> 
> the sched-domains patches that are now in BK solve this problem in a
> cleaner way: the rule is that no cross-CPU balancing is allowed until
> all CPUs have booted up.

Thanks for fixing this the right way.  I'll try it out in the next couple
days.  Nice coincidence that all the sched-domains stuff went in the
same day :-)

> [ btw., your patch does not seem to be correct anyway - if an online CPU
> 'steals' the new idle task then it will also most likely run it - and
> that is disastrous for any CLONE_IDLETASK task. (e.g. on x86 the EIP has
> random content, most likely crashing that CPU.) ]

I'm sure my patch wasn't complete, but it did address something
that still looks strange to me.  The current code is:

	void __init init_idle(task_t *idle, int cpu)
	{
	        runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
	        unsigned long flags;

	        local_irq_save(flags);
	        double_rq_lock(idle_rq, rq);

	        idle_rq->curr = idle_rq->idle = idle;

The fact that we look up the runqueue, lock it, and use it without
rechecking that we got the correct one certainly is suspicious at
the micro point of view.

But, if you say this window is not a problem anymore because of the
larger design, I'll take your word for it.

Bjorn
