Return-Path: <linux-kernel-owner+w=401wt.eu-S964979AbXADQav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbXADQav (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbXADQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:30:51 -0500
Received: from mail.screens.ru ([213.234.233.54]:44236 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964979AbXADQau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:30:50 -0500
Date: Thu, 4 Jan 2007 19:31:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070104163139.GA312@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104155649.GB27603@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104155649.GB27603@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Srivatsa Vaddagiri wrote:
>
> On Thu, Jan 04, 2007 at 05:29:36PM +0300, Oleg Nesterov wrote:
> > Thanks, I need to think about this.
> > 
> > However I am not sure I fully understand the problem.
> > 
> > First, this deadlock was not introduced by recent changes (including "single
> > threaded flush_workqueue() takes workqueue_mutex too"), yes?
> 
> AFAIK this deadlock originated from Andrew's patch here:
> 
> 	http://lkml.org/lkml/2006/12/7/231

I don't think so. The core problem is not that we are doing unlock/sleep/lock
with this patch. The thing is: work->func() can't take wq_mutex (and thus use
flush_work/workqueue) because it is possible that CPU_DEAD holds this mutex
and waits for us to complete(kthread_stop_info). I believe this bug is old.

> (Yes, your patches didnt introduce this. I was just reiterating here my
> earlier point that workqueue code is broken of late wrt cpu hotplug).
> 
> > Also, it seems to me we have a much more simple scenario for deadlock.
> > 
> > events/0 runs run_workqueue(), work->func() sleeps or takes a preemtion. CPU 0
> > dies, keventd thread migrates to another CPU. CPU_DEAD calls kthread_stop() under
> > workqueue_mutex and waits for until kevents thread exits. Now, if this work (or
> > another work pending on cwq->worklist) takes workqueue_mutex (for example, does
> > flush_workqueue) we have a deadlock.
> > 
> > No?
> 
> Yes, the above scenario also will cause a deadlock. 

Ok, thanks for acknowledgement.

> I supposed one could avoid the deadlock by having a 'workqueue_mutex_held' 
> flag and avoid taking the mutex set under some conditions,

I am thinking about the same right now. Probably we can do something like this:


	int xxx_lock(void)
	{
		for (;;) {
			if (mutex_trylock(wq_mutex))
				return 1;

			// the owner of wq_mutex sleeps, we can proceed
			if (kthread_should_stop())
				return 0;
		}
	}
	void xxx_unlock(int yesno)
	{
		if (yesno)
			mutex_unlock(wq_mutext);
	}

and then do

	locked = xxx_lock();
	...
	xxx_unlock(locked);

in flush_xxx() instead of plain lock/unlock.

Yes, ugly. I'll try to do something else on weekend.

>                                                             but IMHO a
> more neater solution is to provide a cpu-hotplug lock which works under
> all these corner cases. One such proposal was made here:
> 
> 	http://lkml.org/lkml/2006/10/26/65

I'll take a look later, thanks.

Oleg.

