Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUK0Df0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUK0Df0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUKZTVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:21:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262309AbUKZTT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:19:59 -0500
Date: Fri, 26 Nov 2004 17:26:16 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041126010841.GA3563@elte.hu>
Message-Id: <Pine.OSF.4.05.10411261649150.23754-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Nov 2004, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > I am running on -31-7 kernel now - it takes quite some time to run with
> > the runall.sh script with 100000 samples per point so I don't have full
> > data yet. [...]
> 
> btw., do you really need 100,000 samples to get statistically stable
> results? I've been running with 1000 samples and it was already more
> than usable - i'd say 3000-5000 samples ought to be more than enough. 
> 
> > But the bounds look like
> > depth observed bound  theoretical
> >    1        1 ms          1 ms
> >    2        3 ms          2 ms      :-(
> 
> are you sure the theoretical limit is 2 msec? I think it's 3 msec, for
> the following reason:
> 
> there are two types of nonprivileged-task lock sequences allowed in the
> 2-deep case:
> 
> 	spin_lock(&lock2);
> 	spin_lock(&lock1);
> 	... loop for 1 msec ...
> 	spin_unlock(&lock1);
> 	spin_unlock(&lock2);
> 
> or:
> 	spin_lock(&lock1);
> 	... loop for 1 msec ...
> 	spin_unlock(&lock1);
> 
> now, with the above locking, the worst case scenario is the following
> one, in chronological order [task A and B are unprivileged, RT is the
> highprio task]:
> 
> 	task-A			task-B			task-RT
> 
> 	spin_lock(&lock2);
> 	[ gets lock2 ]
> 				spin_lock(&lock1);
> 				[ gets lock1 ]
> 							spin_lock(&lock2);
> 							[ boosts task-A ]
> 							[ waits ]
> 	[ gets RT prio ]				.
> 	spin_lock(&lock1);				.
> 	[ boosts task-B ]				.
> 	[ waits ]					.
> 	.			[ gets RT prio ]	.
> 	.			[ 1 msec loop ]		.
> 	.			spin_unlock(&lock1);	.
> 	[ gets lock 1 ]					.
> 				spin_lock(&lock1);	.

point of disagreement          ----^   

> 				[ waits ]		.
> 	[ 1 msec loop ]		.			.
> 	spin_unlock(&lock1);	.			.
> 				[ gets lock1 ]		.
> 	spin_unlock(&lock2);				.
> 							[ gets lock2 ]
> 							spin_lock(&lock1);
> 							[ boosts task-B ]
> 							[ waits ]
> 				[ 1 msec loop ]		.
> 				spin_unlock(&lock1);	.
> 							[ gets lock1 ]
> 
> 
> the additional 1 msec comes in because the RT task might be blocking on
> a task that _itself_ has to wait 1 msec to get its second lock. So we
> have 3 msec of maximum waiting altogether.
> 
> the additional +1 msec comes from the fact that 1-deep lock/unlock of
> lock1 is an allowed operation too - 2 msec would be the limit if the
> only sequence is the 2-deep one.
> 
> so i think the numbers, at least in the 2-deep case, are quite close to
> the theoretical boundary.
> 
> agreed?
>

No :-)
Why should task B get lock1 the 2. time before the rt-task? That
would be an error! 
As soon as task B releases lock1 it has to go back to no-rt and thus go to
sleep. It should be asleep until rt-task is done and thus shouldn't get a
chance to call spin_lock(&lock1) again while it can "do damage". 

I just briefly checked the code in -31-7 and it should work like I
described: You explicitly put in a schedule() after resetting the 
priority after releasing the lock in __up_mutex(). The priority should be
the one you get from mutex_getprio() since B's pi_waiters is emptied in
change_owner() called from set_new_owner() called from pick_new_owner()
called before pi_setprio().

I can't see how it can produce a flow like the one you describe above!

 
> 	Ingo
> 

Esben


