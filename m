Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUKZXPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUKZXPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbUKZTsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:48:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:57026 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262381AbUKZT0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:36 -0500
Date: Fri, 26 Nov 2004 02:08:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041126010841.GA3563@elte.hu>
References: <20041125165829.GA24121@elte.hu> <Pine.OSF.4.05.10411252305040.25041-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411252305040.25041-100000@da410.ifa.au.dk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I am running on -31-7 kernel now - it takes quite some time to run with
> the runall.sh script with 100000 samples per point so I don't have full
> data yet. [...]

btw., do you really need 100,000 samples to get statistically stable
results? I've been running with 1000 samples and it was already more
than usable - i'd say 3000-5000 samples ought to be more than enough. 

> But the bounds look like
> depth observed bound  theoretical
>    1        1 ms          1 ms
>    2        3 ms          2 ms      :-(

are you sure the theoretical limit is 2 msec? I think it's 3 msec, for
the following reason:

there are two types of nonprivileged-task lock sequences allowed in the
2-deep case:

	spin_lock(&lock2);
	spin_lock(&lock1);
	... loop for 1 msec ...
	spin_unlock(&lock1);
	spin_unlock(&lock2);

or:
	spin_lock(&lock1);
	... loop for 1 msec ...
	spin_unlock(&lock1);

now, with the above locking, the worst case scenario is the following
one, in chronological order [task A and B are unprivileged, RT is the
highprio task]:

	task-A			task-B			task-RT

	spin_lock(&lock2);
	[ gets lock2 ]
				spin_lock(&lock1);
				[ gets lock1 ]
							spin_lock(&lock2);
							[ boosts task-A ]
							[ waits ]
	[ gets RT prio ]				.
	spin_lock(&lock1);				.
	[ boosts task-B ]				.
	[ waits ]					.
	.			[ gets RT prio ]	.
	.			[ 1 msec loop ]		.
	.			spin_unlock(&lock1);	.
	[ gets lock 1 ]					.
				spin_lock(&lock1);	.
				[ waits ]		.
	[ 1 msec loop ]		.			.
	spin_unlock(&lock1);	.			.
				[ gets lock1 ]		.
	spin_unlock(&lock2);				.
							[ gets lock2 ]
							spin_lock(&lock1);
							[ boosts task-B ]
							[ waits ]
				[ 1 msec loop ]		.
				spin_unlock(&lock1);	.
							[ gets lock1 ]


the additional 1 msec comes in because the RT task might be blocking on
a task that _itself_ has to wait 1 msec to get its second lock. So we
have 3 msec of maximum waiting altogether.

the additional +1 msec comes from the fact that 1-deep lock/unlock of
lock1 is an allowed operation too - 2 msec would be the limit if the
only sequence is the 2-deep one.

so i think the numbers, at least in the 2-deep case, are quite close to
the theoretical boundary.

agreed?

	Ingo
