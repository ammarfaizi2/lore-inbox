Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTDIEo4 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTDIEo4 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:44:56 -0400
Received: from [12.47.58.221] ([12.47.58.221]:20751 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262731AbTDIEoy (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:44:54 -0400
Date: Tue, 8 Apr 2003 21:56:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Roland Dreier <roland@topspin.com>
Cc: spstarr@sh0n.net, rml@tech9.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T
 info
Message-Id: <20030408215651.503685ee.akpm@digeo.com>
In-Reply-To: <52znn0mg3o.fsf@topspin.com>
References: <20030406133827.34bfbf93.akpm@digeo.com>
	<003001c2fe3d$6eab1080$030aa8c0@unknown>
	<20030408211216.71022d84.akpm@digeo.com>
	<52znn0mg3o.fsf@topspin.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 04:56:28.0704 (UTC) FILETIME=[618B9200:01C2FE54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
> Still, I like the idea of this patch, since it resolves the livelock.
> But I don't think the implementation is quite right.  insert_sequence
> doesn't get incremented until delayed_work_timer_fn().  That means
> that a driver (tty_io.c, for example) could call
> schedule_delayed_work(), then call flush_scheduled_work() before
> delayed_work_timer_fn() has run for that work.

The driver needs to run cancel_delayed_work() before calling
flush_scheduled_work().  The tty patch is already doing that, and I think
that plugs the holes.

Here's a full changelog.



The workqueue code currently has a notion of a per-cpu queue being "busy". 
flush_scheduled_work()'s responsibility is to wait for a queue to be not busy.

Problem is, flush_scheduled_work() can easily hang up.

- The workqueue is deemed "busy" when there are pending (timer-based)
  works.  But if someone repeatedly schedules new work in the delayed
  callback, the queue will never fall idle, and flush_scheduled_work() will
  not complete.

- If someone reschedules work (not delayed work) in the work function, that
  too will cause the queue to never go idle, and flush_scheduled_work() will
  not terminate.

So what this patch does is:

- Create a new "cancel_delayed_work()" which will try to kill off any
  timer-based works.

- Change flush_scheduled_work() so that it is immune to people re-adding
  work in the work callout handler.

  We can do this by recognising that the caller does *not* want to wait
  until the workqueue is "empty".  The caller merely wants to wait until all
  works which were pending at the time flush_scheduled_work() was called have
  completed.

  The patch uses a couple of sequence numbers for that.

So now, if someone wants to reliably remove delayed work they should do:


	/*
	 * Make sure that my work-callback will no longer schedule new work
	 */
	my_driver_is_shutting_down = 1;

	/*
	 * Kill off any pending delayed work
	 */
	cancel_delayed_work(&my_work);

	/*
	 * OK, there will be no new works scheduled.  But there may be one
	 * currently queued or in progress.  So wait for that to complete.
	 */
	flush_scheduled_work();

And change the flush_workqueue() sleep to be uninterruptible.  We worry that
delivery of a signal may cause the wait to return too early.

