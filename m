Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbTCGTCK>; Fri, 7 Mar 2003 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCGTCK>; Fri, 7 Mar 2003 14:02:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27144 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261675AbTCGTCI>; Fri, 7 Mar 2003 14:02:08 -0500
Date: Fri, 7 Mar 2003 11:10:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <Pine.LNX.4.44.0303071949160.16478-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303071104210.2521-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, 
 I already merged and pushed out the core changes in -B2, but now that I'm 
looking more closely at it I'm almost certain that it's buggy.

In particular, you do this:

	..
	dequeue_task(current, array);
	current->prio = effective_prio(current);
	enqueue_task(current, array);
	..

without actually holding the rq lock on the array!

Yes, we hold _a_ rq_lock - we hold the rq lock for the array that "p" is 
on, but that's necessarily the same as this_rq().

So you can end up with the priority bitmap and the runqueue being 
corrupted by another wakeup on another CPU that wakes up something that is 
on the runqueue for the current CPU. At which point the machine will be 
basically dead (runqueue corruption is not likely to be a survivable 
event).

Or am I missing something?

		Linus

