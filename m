Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbULOGjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbULOGjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 01:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbULOGjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 01:39:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28051 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261906AbULOGjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 01:39:41 -0500
Date: Wed, 15 Dec 2004 07:36:28 +0100
From: Jens Axboe <axboe@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041215063628.GL3157@suse.de>
References: <20041213125046.GG3033@suse.de> <20041213130926.GH3033@suse.de> <20041213175721.GA2721@suse.de> <20041214133725.GG3157@suse.de> <20041214213155.GA2057@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214213155.GA2057@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14 2004, Paul E. McKenney wrote:
> On Tue, Dec 14, 2004 at 02:37:25PM +0100, Jens Axboe wrote:
> > Hi,
> > 
> > Version -12 has been uploaded. Changes:
> > 
> > - Small optimization to choose next request logic
> > 
> > - An idle queue that exited would waste time for the next process
> > 
> > - Request allocation changes. Should get a smooth stream for writes now,
> >   not as bursty as before. Also simplified the may_queue/check_waiters
> >   logic, rely more on the regular block rq allocation congestion and
> >   don't waste sys time doing multiple wakeups.
> > 
> > - Fix compilation on x86_64
> > 
> > No io priority specific fixes, the above are all to improve the cfq time
> > slicing.
> > 
> > For 2.6.10-rc3-mm1:
> > 
> > http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-12-2.6.10-rc3-mm1.gz
> > 
> > For 2.6-BK:
> > 
> > http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-12.gz
> 
> OK...  I confess, I am confused...
> 
> I see the comment stating that only one thread updates, hence no need
> for locking.  But I can't find the readers!  There is a section of
> code under rcu_read_lock(), but this same function updates the list
> as well.  If there really is only one updater, then the rcu_read_lock()
> is not needed, because rcu_read_lock() is only required to protect against
> concurrent deletion.
> 
> Either way, in cfq_exit_io_context(), the list_for_each_safe_rcu() should
> be able to be simply list_for_each_safe(), since this is apparently the
> sole updater thread, so no concurrent updates are possible.
> 
> If only one task is referencing the list at all, no need for RCU or for
> any other synchronization mechanism.  If multiple threads are referencing
> the list, I cannot find any pure readers.  If multiple threads are updating
> the list, I don't see how they are excluding each other.
> 
> Any enlightenment available?  I most definitely need a clue here...

No, you are about right :-)

The RCU stuff can go again, because I moved everything to happen under
the same task. The section under rcu_read_lock() is the reader, it just
later on moved the hot entry to the front as well which does indeed mean
it's buggy if there were concurrent updaters. So that's why it's in a
state of being a little messy right now.

A note on the list itself - a task has a cfq_io_context per queue it's
doing io against and it needs to be looked up when we this process
queues io. The task sets this up itself on first io and tears this down
on exit. So only the task itself ever updates or searches this list.

-- 
Jens Axboe

