Return-Path: <linux-kernel-owner+w=401wt.eu-S964783AbXAGRI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbXAGRI4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbXAGRI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:08:56 -0500
Received: from mail.screens.ru ([213.234.233.54]:50406 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618AbXAGRIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:08:55 -0500
Date: Sun, 7 Jan 2007 20:09:32 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107170932.GA238@tv-sign.ru>
References: <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com> <20070107125603.GA74@tv-sign.ru> <20070107162140.GA6800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107162140.GA6800@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Srivatsa Vaddagiri wrote:
>
> On Sun, Jan 07, 2007 at 03:56:03PM +0300, Oleg Nesterov wrote:
> > Srivatsa, I'm completely new to cpu-hotplug, so please correct me if I'm
> > wrong (in fact I _hope_ I am wrong) but as I see it, the hotplug/workqueue
> > interaction is broken by design, it can't be fixed by changing just locking.
> > 
> > Once again. CPU dies, CPU_DEAD calls kthread_stop() and sleeps until
> > cwq->thread exits. To do so, this thread must at least complete the
> > currently running work->func().
> 
> If run_workqueue() takes a lock_cpu_hotplug() successfully, then we shouldnt 
> even reach till this point, as it will block writers (cpu_down/up) until it
> completes.
> 
> 
> 	run_workqueue()
> 	---------------
> 	
> try_again:
> 	rc = lock_cpu_hotplug_interruptible();
> 	
> 	if (rc && kthread_should_stop())
> 		return;
> 	
> 	if (rc != 0)
> 		goto try_again;
> 	
> 	/* cpu_down/up shouldnt happen now untill we call unlock_cpu_hotplug */
> 	while (!list_empty(..))
> 		work->func();

This mean that every work->func() which may sleep delays cpu_down/up unpredictable,
not good. What about work->func which sleeps then re-queues itself? I guess we can
solve this, but this is what I said "other changes".

Also, lock_cpu_hotplug() should be per-cpu, otherwise we have livelock.

Not that I am against lock_cpu_hotplug (I can't judge), but its usage in run_workqueue
looks like complication to me. I may be wrong. But the main problem we don't have it :)

Oleg.

