Return-Path: <linux-kernel-owner+w=401wt.eu-S932602AbXAGQXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbXAGQXG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbXAGQXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:23:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37076 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602AbXAGQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:23:03 -0500
Date: Sun, 7 Jan 2007 21:51:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107162140.GA6800@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com> <20070107125603.GA74@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107125603.GA74@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 03:56:03PM +0300, Oleg Nesterov wrote:
> Srivatsa, I'm completely new to cpu-hotplug, so please correct me if I'm
> wrong (in fact I _hope_ I am wrong) but as I see it, the hotplug/workqueue
> interaction is broken by design, it can't be fixed by changing just locking.
> 
> Once again. CPU dies, CPU_DEAD calls kthread_stop() and sleeps until
> cwq->thread exits. To do so, this thread must at least complete the
> currently running work->func().

If run_workqueue() takes a lock_cpu_hotplug() successfully, then we shouldnt 
even reach till this point, as it will block writers (cpu_down/up) until it
completes.


	run_workqueue()
	---------------
	
try_again:
	rc = lock_cpu_hotplug_interruptible();
	
	if (rc && kthread_should_stop())
		return;
	
	if (rc != 0)
		goto try_again;
	
	/* cpu_down/up shouldnt happen now untill we call unlock_cpu_hotplug */
	while (!list_empty(..))
		work->func();
	
	unlock_cpu_hotplug();


If work->func() calls something (say flush_workqueue()) which requires a
lock_cpu_hotplug() again, there are two ways to support it:

Method 1: Add a field, hotplug_lock_held, in task_struct

	If current->hotplug_lock_held > 1, then lock_cpu_hotplug()
	merely increments it and returns success. Its counterpart, 
	unlock_cpu_hotplug() will decrement the count.

	Easiest to implement. However additional field is required in
	each task_struct, which may not be attractive for some.

Method 2 : Bias readers over writers:

	This method will support recursive calls to lock_cpu_hotplug()
	by the same thread, w/o requiring a field in task_struct. To 
	accomplish this, readers are biased over writers i.e 


		reader1_lock(); <- success

					writer1_lock(); <- blocks on reader1


		reader2_lock(); <- success

A fair lock would have blocked reader2_lock() until 
writer1_lock()/writer1_unlock() is complete, but since we are required to 
support recursion w/o maintaining a task_struct field, we let reader2_lock() 
succeed, even though it could be from a different thread.
	
> Andrew, Ingo, this also means that freezer can't solve this particular
> problem either (if i am right).

freezer wont give stable access to cpu_online_map either, as could typically be
required in functions like flush_workqueue.

-- 
Regards,
vatsa
