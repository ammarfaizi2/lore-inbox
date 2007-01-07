Return-Path: <linux-kernel-owner+w=401wt.eu-S932527AbXAGMzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbXAGMzM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 07:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbXAGMzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 07:55:12 -0500
Received: from mail.screens.ru ([213.234.233.54]:36050 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932527AbXAGMzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 07:55:10 -0500
Date: Sun, 7 Jan 2007 15:56:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107125603.GA74@tv-sign.ru>
References: <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107104328.GC13579@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Srivatsa Vaddagiri wrote:
>
> On Sat, Jan 06, 2007 at 08:34:16PM +0300, Oleg Nesterov wrote:
> > I suspect this can't help either.
> > 
> > The problem is that flush_workqueue() may be called while cpu hotplug event
> > in progress and CPU_DEAD waits for kthread_stop(), so we have the same dead
> > lock if work->func() does flush_workqueue(). This means that Andrew's change
> > to use preempt_disable() is good and anyway needed.
> 
> Well ..a lock_cpu_hotplug() in run_workqueue() and support for recursive
> calls to lock_cpu_hotplug() by the same thread will avoid the problem
> you mention.

Srivatsa, I'm completely new to cpu-hotplug, so please correct me if I'm
wrong (in fact I _hope_ I am wrong) but as I see it, the hotplug/workqueue
interaction is broken by design, it can't be fixed by changing just locking.

Once again. CPU dies, CPU_DEAD calls kthread_stop() and sleeps until
cwq->thread exits. To do so, this thread must at least complete the
currently running work->func().

work->func() calls flush_workque(WQ), it does lock_cpu_hotplug() or
_whatever_. Now the question, does it block?

if YES:
	This is what the stable tree does - deadlock.

if NOT:
	This is what we have with Andrew's s/mutex_lock/preempt_disable/
	patch - race or deadlock, we have a choice.

	Suppose that WQ has pending works on that dead CPU. Note that
	at this point this CPU does not present on cpu_online_map.
	This means that (without other changes) we have lost.

		- flush_workque(WQ) can't return until CPU_DEAD transfers
		  these works to some another CPU on the cpu_online_map.

		- CPU_DEAD can't do take_over_work() untill flush_workque()
		  returns.

Andrew, Ingo, this also means that freezer can't solve this particular
problem either (if i am right).

Thoughts?

Oleg.


