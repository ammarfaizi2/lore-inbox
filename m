Return-Path: <linux-kernel-owner+w=401wt.eu-S932514AbXAQPso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXAQPso (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXAQPso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:48:44 -0500
Received: from mail.screens.ru ([213.234.233.54]:54607 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514AbXAQPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:48:43 -0500
Date: Wed, 17 Jan 2007 18:47:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070117154716.GA104@tv-sign.ru>
References: <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com> <20070115125401.GA134@tv-sign.ru> <20070115161810.GB16435@in.ibm.com> <20070115165516.GA254@tv-sign.ru> <20070116052606.GA995@in.ibm.com> <20070116132725.GA81@tv-sign.ru> <20070117061705.GB2803@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117061705.GB2803@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17, Srivatsa Vaddagiri wrote:
>
> On Tue, Jan 16, 2007 at 04:27:25PM +0300, Oleg Nesterov wrote:
> > > I meant issuing kthread_stop() in DOWN_PREPARE so that worker
> > > thread exits itself (much before CPU is actually brought down).
> > 
> > Deadlock if work_struct re-queues itself.
> 
> Are you referring to the problem you described here?
> 
> 	http://lkml.org/lkml/2007/1/8/173
> 
> If so, then it can easily be prevented by having run_workqueue() check for 
> kthread_should_stop() in its while loop?

flush_workqueue() also calls run_workqueue().

> > > workqueue_cpu_callback()
> > > {
> > >
> > > 	CPU_DEAD:
> > > 		/* threads are still frozen at this point */
> > > 		take_over_work();
> > 
> > No, we can't move a currently executing work. This will break flush_workxxx().
> 
> What do you mean by "currently" executing work? worker thread executing
> some work on the cpu? That is not possible, because all threads are
> frozen at this point. There cant be any ongoing flush_workxxx() as well
> because of this, which should avoid breaking flush_workxxx() ..

work->func() sleeps/freezed. We can't move the rest of pending jobs before
it completes. This will break flush_workxxx. And no, this is not because
we use barriers now.

> 1st method, what you are suggesting:
> 	
> 	- Needs separate bitmap(s), cpu_populated_map and possible another
> 	  for create_workqueue()?
> 	- flush_workqueue() traverses thr a separate bitmap
> 	  cpu_populated_map (separate from the online map) while
> 	  create_workqueue() traverses the other bitmap

Yes, we need the additional bitmap. This is optimization, we can just use
cpu_possible_map. create_workqueue() can use cpu_online_map + "int new_cpu".

Yes, this is a complication. But still this is much simpler (IMHO) than
we have now. And imho better.

> 2nd method:
> 
> 	- Avoids the need for maintenance of separate bitmaps (uses
>   	  existing cpu_online_map). All functions can safely use
> 	  the online_map w/o any races. Personally this is why I like
> 	  this approach.
> 	- Needs changes in worker_thread to exit right after it comes
> 	  out of refrigerator.
>
> I havent made any changes as per 2nd method to see the resulting code
> size, so I cant comment on code sizes.

Yes, yes, yes, let's see the code first! :) Then we can compare.
Right now:
	- cpu-hotplug doesn't use freezer yet
	- all ideas about using it to improve workqueue.c were wrong

> Another point is that once we create code as in 1st method, which
> maintains separate bitmaps, that will easily get replicated (over time) 
> to other subsystems. Is that a good thing?

Honestly, I can't understand your point. Why it will get replicated?
Because another subsystem will need cpu_populated_map too? We can remove
"static" and move cpu_populated_map to kernel/cpu.c then.

Btw, I agree it is good to have a sleeping lock to protect cpu_online_map.
But it should be separate from workqueue_mutex, and it is not needed for
create/destroy/flush funcs.

Oleg.

