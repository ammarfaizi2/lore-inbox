Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVHYLRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVHYLRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 07:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVHYLRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 07:17:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30632 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964941AbVHYLRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 07:17:20 -0400
Date: Thu, 25 Aug 2005 13:17:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
Message-ID: <20050825111717.GA4018@suse.de>
References: <1124899329.3855.12.camel@mindpipe> <20050824174702.GL28272@suse.de> <20050825060958.GB26398@elte.hu> <20050825062207.GO28272@suse.de> <20050825075205.GB30650@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825075205.GB30650@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25 2005, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > There can quite easily be lots of pending IO for the io_context (and, 
> > in CFQ's case, below cfq_io_contexts), task exiting is completely 
> > decoupled from any pending io.
> 
> yes, but that only affects the io_context reference count. Actual new 
> use of tsk->io_context should only be possible on the IO-submission 
> side, which should all have stopped by the time we execute do_exit().  
> (and it's synchronous anyway, so the fact that we are executing in the 
> kernel prevents the same thread from submitting new IO, in this case.)
> 
> i.e. the removal of tsk->io_context can be done without locking out 
> interrupts. No interrupt or io_context is supposed to access 
> current->io_context at that point.

Well that's not quite correct, changes were made that allow lookup of
the cic from another task. What happens is that process A will be
dirtying lots of data and process B will be quitely reading other data.
Process B can then get unlucky and have to do page reclaim on behalf of
process A, simply because it tries to allocate a page under memory
pressure.

This is probably fairly rare, because async writeout goes to a dedicated
queue typically bound to one (or more) of the pdflush threads which
never exit. None the less, it needs fixing.

This used to be safe (it used rcu and the cfq_cic_lock to protect read
and write side respectively), I _think_ this was dropped at some point
because I dropped the cross-lookup. I have to ponder how best to fix
this...

-- 
Jens Axboe

