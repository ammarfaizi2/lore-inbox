Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVKGJrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVKGJrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 04:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKGJrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 04:47:14 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5316 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964804AbVKGJrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 04:47:13 -0500
Date: Mon, 7 Nov 2005 01:46:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051107014659.14c2631b.pj@sgi.com>
In-Reply-To: <436EEF43.2050403@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051106124944.0b2ccca1.pj@sgi.com>
	<436EC2AF.4020202@yahoo.com.au>
	<200511070442.58876.ak@suse.de>
	<20051106203717.58c3eed0.pj@sgi.com>
	<436EEF43.2050403@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Yeah, take a look at rmap.c as well, and some of the comments in
> changelogs if you need a better feel for it.

Ok - thanks.


> So your cpusets may be reused, but only as new cpusets. This should
> be no problem at all for you.

Correct - should be no problem.


> > And is the pair of operators:
> >   task_lock(current), task_unlock(current)
> > really that much worse than the pair of operators
> >   ...
> >   preempt_disable, preempt_enable

That part still surprises me a little.  Is there enough difference in
the performance between:

  1) task_lock, which is a spinlock on current->alloc_lock and
  2) rcu_read_lock, which is .preempt_count++; barrier()

to justify a separate slab cache for cpusets and a little more code?

For all I know (not much) the task_lock might actually be cheaper ;).


> You may also have to be careful about memory ordering when setting
> a pointer which may be concurrently dereferenced by another CPU so
> that stale data doesn't get picked up.
> 
> The set side needs an rcu_assign_pointer, and the dereference side
> needs rcu_dereference. Unless you either don't care about races,

I don't think I care ...  I'm just sampling task->cpuset->mems_generation,
looking for it to change.  Sooner or later, after it changes, I will get
an accurate read of it, realized it changed, and immediately down a
cpuset semaphore and reread all values of interest.

The semaphore down means doing an atomic_dec_return(), which imposes
a memory barrier, right?


> My RCU suggestion was mainly an idea to get around your immediate
> problem with a lockless fastpath, rather than advocating it over
> any of the alternatives.

Understood.  Thanks for your comments on the alternatives - they
seem reasonable.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
