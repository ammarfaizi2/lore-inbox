Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbTCSQju>; Wed, 19 Mar 2003 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263068AbTCSQju>; Wed, 19 Mar 2003 11:39:50 -0500
Received: from mail.ccur.com ([208.248.32.212]:55556 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S263060AbTCSQjs>;
	Wed, 19 Mar 2003 11:39:48 -0500
Message-ID: <3E789FF4.DFDE1248@ccur.com>
Date: Wed, 19 Mar 2003 11:51:00 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@digeo.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, joe.korty@ccur.com
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
References: <20030318215228.417e0a58.akpm@digeo.com>
	 <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
	 <20030318215228.417e0a58.akpm@digeo.com> <5.2.0.9.2.20030319091819.00ca4bf0@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I like Ingo's round down the sleep time fix.  It solves most
of the problems.

I have been chasing a small case it doesn't fix.  If you have
a circle of processes passing a token (like the irman test which
is part of contest), the processes can still get to inflated 
priorities if they are preempted by other processes.

Consider one of the processes in the circle.  It spends most of
its time blocked waiting for its turn to pass the token.  With Ingo's
change it doesn't get a sleep time credit because the sleep time 
almost always rounds down to zero.  But if any of the process in
the loop is delayed (maybe it used its time slice), then all of the
other processes in the chain will get a sleep_avg credit for that
delay time.

Here is the idea I have been playing with (in activate_task):

        sync_wake_cycle = 0
	if (!in_interrupt()) {
                /*
                 * Detect cycles of synchronous wakeups.  This catches
                 * the old circle of processes passing a token benchmarks.
                 * If none of the processes ever sleep they should not
                 * get an interactive bonus.
                 */
                if (current->sync_wake_leader == p->sync_wake_leader)
                        sync_wake_cycle = 1;
                else if (current->sync_wake_leader)
                        p->sync_wake_leader = current->sync_wake_leader;
                else
                        p->sync_wake_leader = current;
        } else {
                p->sync_wake_leader = 0;
        } 

If sync_wake_cycle is set, don't credit the sleep_avg.  If there is an 
interactive task in the loop, it will break the loop when it is woken by
a real interrupt.

I hope to get another version of my run_avg based (and overly optimistically
named) self-tuning scheduler out soon.

Jim Houston - Concurrent Computer Corp.
