Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbULNVcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbULNVcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbULNVcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:32:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62352 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261501AbULNVcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:32:15 -0500
Date: Tue, 14 Dec 2004 13:31:55 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041214213155.GA2057@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041213125046.GG3033@suse.de> <20041213130926.GH3033@suse.de> <20041213175721.GA2721@suse.de> <20041214133725.GG3157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214133725.GG3157@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 02:37:25PM +0100, Jens Axboe wrote:
> Hi,
> 
> Version -12 has been uploaded. Changes:
> 
> - Small optimization to choose next request logic
> 
> - An idle queue that exited would waste time for the next process
> 
> - Request allocation changes. Should get a smooth stream for writes now,
>   not as bursty as before. Also simplified the may_queue/check_waiters
>   logic, rely more on the regular block rq allocation congestion and
>   don't waste sys time doing multiple wakeups.
> 
> - Fix compilation on x86_64
> 
> No io priority specific fixes, the above are all to improve the cfq time
> slicing.
> 
> For 2.6.10-rc3-mm1:
> 
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-12-2.6.10-rc3-mm1.gz
> 
> For 2.6-BK:
> 
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-12.gz

OK...  I confess, I am confused...

I see the comment stating that only one thread updates, hence no need
for locking.  But I can't find the readers!  There is a section of
code under rcu_read_lock(), but this same function updates the list
as well.  If there really is only one updater, then the rcu_read_lock()
is not needed, because rcu_read_lock() is only required to protect against
concurrent deletion.

Either way, in cfq_exit_io_context(), the list_for_each_safe_rcu() should
be able to be simply list_for_each_safe(), since this is apparently the
sole updater thread, so no concurrent updates are possible.

If only one task is referencing the list at all, no need for RCU or for
any other synchronization mechanism.  If multiple threads are referencing
the list, I cannot find any pure readers.  If multiple threads are updating
the list, I don't see how they are excluding each other.

Any enlightenment available?  I most definitely need a clue here...

						Thanx, Paul

> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
