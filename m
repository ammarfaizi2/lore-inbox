Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbTCKSyp>; Tue, 11 Mar 2003 13:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTCKSyp>; Tue, 11 Mar 2003 13:54:45 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:46509 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261521AbTCKSyo>; Tue, 11 Mar 2003 13:54:44 -0500
Message-ID: <3E6E3386.FFFECD86@attbi.com>
Date: Tue, 11 Mar 2003 14:05:42 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.64bk4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] self tuning scheduler
References: <5.2.0.9.2.20030311095954.01f9a008@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> Greetings,
> 
> I took your patch out for a test-drive, and it appears to have starvation
> problems with irman's process load (dang thing seems to be HELL on schedulers).
> 
> Irman starts a load (defaults to 9 tasks passing data in a pipe ring), and
> forks a child which pingpongs one character back and forth to the parent
> for 1000000 iterations, measuring response time for each iteration and
> computing statistics.  With an iteration % 1000 printf() in the evaluation
> routine, I see it start off nice and fast, then begins to get starved for
> up to 30 seconds.  It jerks around for a bit, then slows down to a ~stable
> 1 sec/iteration after approximately 300000 iterations.  The whole test
> takes ~2minutes with 2.5.64-virgin.  (I'm not patient enough to wait for
> the rest of the .5million iterations left on this burn before reporting:)
> 
> It also shows a serious throughput loss with make -j30 bzImage on this box
> (I think you expect that though from what I read).  With stock, it takes
> ~8m30s... this scheduler adds a full minute.
> 
> The window wave test with a make -j5 bzImage running (fits easily in ram)
> is pretty ragged.
> 
> Ending on a more positive note, vmstat output from the parallel build looks
> quite nice.
> 
>         -Mike

Hi Mike,

Thanks for taking the time to test my changes.

I found an irman rpm which is 2001 vintage and a broken link at:
	http://people.redhat.com/bmatthews/irman/
So I'm not sure if I'm duplicating your test. If you could send me a
tar ball with the source for the irman you are running, it would help.

When I run the version of irman I have, it runs to completion, maybe a
bit slower than it should.  I have some ideas why my scheduler does
badly on this test.

When I start a new process, I pick an initial priority for the new
process based on the average priority at which the system has been
running.  From this I back calculate a run_avg value. If this guess
is bad, the new process may have an unfair advantage with respect to
its parent.  I have been thinking of ways to fix this.  One idea is
to use a shorter half-life value for processes which are recently started.

This test is an example where basing the child priority on the parent
makes sense.  Perhaps I should use the parent priority if it is 
lower than the rq->prio_avg value.

I guess it was wishful thinking when I titled this self tuning.
If your interested you could adjust the run_avg_halflife and/or
prio_avg_halflife to a smaller values.  

It may also be a sampling problem where the period of the ping-pong
exchange is a fraction of the HZ tick, and one process is charged more
than its share of the cpu.

On the make -j30 kernel make, I intentionally reduce the timeslice
as the process priority increases.  This should reduce jitter for
interactive processes. As more processes try to share the cpu they
all get higher priority and the smaller time slice.  If there are
only 1-2 compute bound processes they would get 0.5 second time
slices.  

I'm also curious about the hardware you are testing on.

Jim Houston - Concurrent Computer Corp.
