Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRACDPb>; Tue, 2 Jan 2001 22:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131169AbRACDPU>; Tue, 2 Jan 2001 22:15:20 -0500
Received: from mailb.telia.com ([194.22.194.6]:38672 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S130463AbRACDPI>;
	Tue, 2 Jan 2001 22:15:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problem?
Date: Wed, 3 Jan 2001 03:39:35 +0100
X-Mailer: KMail [version 1.2]
Cc: Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <Pine.Linu.4.10.10101020857530.1024-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10101020857530.1024-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <01010303393503.01851@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have played around with this code previously.
This is my current understanding.
[yield problem?]

On Tuesday 02 January 2001 09:27, Mike Galbraith wrote:
> Hi,
>
> I am seeing (what I believe is;) severe process CPU starvation in
> 2.4.0-prerelease.  At first, I attributed it to semaphore troubles
> as when I enable semaphore deadlock detection in IKD and set it to
> 5 seconds, it triggers 100% of the time on nscd when I do sequential
> I/O (iozone eg).  In the meantime, I've done a slew of tracing, and
> I think the holder of the semaphore I'm timing out on just flat isn't
> being scheduled so it can release it.  In the usual case of nscd, I
> _think_ it's another nscd holding the semaphore.  In no trace can I
> go back far enough to catch the taker of the semaphore or any user
> task other than iozone running between __down() time and timeout 5
> seconds later.  (trace buffer covers ~8 seconds of kernel time)
>
> I think the snippet below captures the gist of the problem.
>
> c012f32e  nr_free_pages +<e/4c> (0.16) pid(256)
> c012f37a  nr_inactive_clean_pages +<e/44> (0.22) pid(256)

wakeup_bdflush (from beginning of __alloc_pages; page_alloc.c:324 ) 
> c01377f2  wakeup_bdflush +<12/a0> (0.14) pid(256)
> c011620a  wake_up_process +<e/58> (0.29) pid(256)

> c012eea4  __alloc_pages_limit +<10/b8> (0.28) pid(256)
> c012eea4  __alloc_pages_limit +<10/b8> (0.30) pid(256)
Two __alloc_pages_limit

wakeup_kswapd(0) (from page_alloc.c:392 )
> c012e3fa  wakeup_kswapd +<12/d4> (0.25) pid(256)
> c0115613  __wake_up +<13/130> (0.41) pid(256)

schedule() (from page_alloc.c:396 )
> c011527b  schedule +<13/398> (0.66) pid(256->6)
> c01077db  __switch_to +<13/d0> (0.70) pid(6)

bdflush is running!!!
> c01893c6  generic_unplug_device +<e/38> (0.25) pid(6)

bdflush is ready. (but how likely is it that it will run
for long enough to get hit by a tick i.e. current->counter--
unless it is it will continue to be preferred to kswapd, and
since only one process is yielded... )
> c011527b  schedule +<13/398> (0.50) pid(6->256)
> c01077db  __switch_to +<13/d0> (0.29) pid(256)

back to client, not the additionally runable kswapd...
Why not - nothing remaining of timeslice.
Not that the yield only yields one process. Not all
in runqueue - IMHO. [is this intended?]

3:rd __alloc_pages_limit this time direct_reclaim
tests are fulfilled
> c012eea4  __alloc_pages_limit +<10/b8> (0.22) pid(256)
> c012d267  reclaim_page +<13/408> (0.54) pid(256)

Possible (in -prerelease) untested possibilities.

* Be tougher when yielding.


 	wakeup_kswapd(0);
	if (gfp_mask & __GFP_WAIT) {
		__set_current_state(TASK_RUNNING);
		current->policy |= SCHED_YIELD;
+               current->counter--; /* be faster to let kswapd run */
or
+               current->counter = 0; /* too fast? [not tested] */
		schedule();
	}

Might be to tough on the client not doing any actual work... think dbench...

* Be tougher on bflushd, decrement its counter now and then... 
  [naive, not tested]

* Move wakeup of bflushd to kswapd. Somewhere after 'do_try_to_free_pages(..)'
  has been run. Before going to sleep... 
  [a variant tested with mixed results - this is likely a better one]


		/* 
		 * We go to sleep if either the free page shortage
		 * or the inactive page shortage is gone. We do this
		 * because:
		 * 1) we need no more free pages   or
		 * 2) the inactive pages need to be flushed to disk,
		 *    it wouldn't help to eat CPU time now ...
		 *
		 * We go to sleep for one second, but if it's needed
		 * we'll be woken up earlier...
		 */
		if (!free_shortage() || !inactive_shortage()) {
			/*
			 * If we are about to get low on free pages and cleaning
			 * the inactive_dirty pages would fix the situation,
			 * wake up bdflush.
			 */
			if (free_shortage() && nr_inactive_dirty_pages > free_shortage()
				&& nr_inactive_dirty_pages >= freepages.high)
					wakeup_bdflush(0);

			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
		}

--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
