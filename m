Return-Path: <linux-kernel-owner+w=401wt.eu-S1750791AbXAQGRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXAQGRP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXAQGRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:17:15 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47137 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbXAQGRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:17:14 -0500
Date: Wed, 17 Jan 2007 11:47:05 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070117061705.GB2803@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070109163815.GA208@tv-sign.ru> <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com> <20070115125401.GA134@tv-sign.ru> <20070115161810.GB16435@in.ibm.com> <20070115165516.GA254@tv-sign.ru> <20070116052606.GA995@in.ibm.com> <20070116132725.GA81@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116132725.GA81@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 04:27:25PM +0300, Oleg Nesterov wrote:
> > I meant issuing kthread_stop() in DOWN_PREPARE so that worker
> > thread exits itself (much before CPU is actually brought down).
> 
> Deadlock if work_struct re-queues itself.

Are you referring to the problem you described here?

	http://lkml.org/lkml/2007/1/8/173

If so, then it can easily be prevented by having run_workqueue() check for 
kthread_should_stop() in its while loop?

> > Even if there are problems with it, how abt something like below:
> >
> > workqueue_cpu_callback()
> > {
> >
> > 	CPU_DEAD:
> > 		/* threads are still frozen at this point */
> > 		take_over_work();
> 
> No, we can't move a currently executing work. This will break flush_workxxx().

What do you mean by "currently" executing work? worker thread executing
some work on the cpu? That is not possible, because all threads are
frozen at this point. There cant be any ongoing flush_workxxx() as well
because of this, which should avoid breaking flush_workxxx() ..

> > 		if (kthread_marked_stop(current))
> > 			break;
> 
> Racy. Because of kthread_stop() above we should clear cwq->thread somehow.
> But we can't do this: this workqueue may be already destroyed.

We will surely take workqueue_mutex in CPU_CLEAN_THREADS (when it
traverses the workqueues list), which should avoid this race?

> Please note that the code I posted does something like kthread_mark_stop(), but
> it operates on cwq, not on task_struct, this makes a big difference.

Ok sure ..putting the flag in cwq makes sense. Others also can follow
similar trick for stopping threads (like ksoftirqd).

> And it doesn't need take_over_work() at all. And it doesn't need additional 
> complications. Instead, it lessens both the source and compiled code.

I guess either way, changes are required.

1st method, what you are suggesting:
	
	- Needs separate bitmap(s), cpu_populated_map and possible another
	  for create_workqueue()?
	- flush_workqueue() traverses thr a separate bitmap
	  cpu_populated_map (separate from the online map) while
	  create_workqueue() traverses the other bitmap

2nd method:

	- Avoids the need for maintenance of separate bitmaps (uses
  	  existing cpu_online_map). All functions can safely use
	  the online_map w/o any races. Personally this is why I like
	  this approach.
	- Needs changes in worker_thread to exit right after it comes
	  out of refrigerator.

I havent made any changes as per 2nd method to see the resulting code
size, so I cant comment on code sizes.

Another point is that once we create code as in 1st method, which
maintains separate bitmaps, that will easily get replicated (over time) 
to other subsystems. Is that a good thing?

-- 
Regards,
vatsa
