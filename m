Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUFOXlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUFOXlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUFOXlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:41:32 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:63362 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S266016AbUFOXla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:41:30 -0400
Subject: Re: calling kthread_create() from interrupt thread
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robin Holt <holt@sgi.com>
Cc: Dean Nelson <dcn@sgi.com>, Arjan van de Ven <arjanv@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040615190114.GA6151@lnx-holt.americas.sgi.com>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
	 <1087321777.2710.43.camel@laptop.fenrus.com>
	 <20040615180525.GA17145@sgi.com> <Pine.LNX.4.53.0406151412350.2353@chaos>
	 <20040615190114.GA6151@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Message-Id: <1087342744.12229.73.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 09:40:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 05:01, Robin Holt wrote:
> We receive an interrupt.  The interrupt handler determines that some work
> needs to be done.  Part of that work to be done may result in the process
> needing to go to sleep waiting for a resource to become available.
> 
> Currently, the interrupt handler wakes a thread sleeping on a
> wait_event_interruptible().  This wakeup is taking approx 35uSec.  Dean
> is looking for a lower latency means of doing the wakeup.

The best approach is, as suggested in this thread, to have a fastpath
which is called from interrupt handler, which fails if it needs to
sleep; in that case you back off to your own workqueue.  It'd look
something like:

	static DEFINE_PER_CPU(struct work_struct slow_work);
	static workqueue_struct *wq;

	irqreturn_t do_interrupt(...)
	{
		if (!fast_irq_handle())
			queue_work(wq, &__get_cpu_var(slow_work));
	}

	static void do_slow_work(void *unused)
	{
		...
	}

	static int __init init(void)
	{
		int cpu;
		wq = create_workqueue("drivername", 0);
		for_each_cpu(cpu)
			PREPARE_WORK(&per_cpu(slow_work, cpu),
				     do_slow_work, NULL);
	}

You need to come up with a mechanism to pass details from the interrupt
handler to the do_slow_work() fn, probably a separate queue or array
which do_slow_work() will need to disable irqs to access.  queue_work
will not requeue the work_struct if it's already pending, your
do_slow_work() needs to handle all the requests which are waiting.

Hope that helps,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

