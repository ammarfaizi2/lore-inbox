Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBTSJp>; Tue, 20 Feb 2001 13:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbRBTSJg>; Tue, 20 Feb 2001 13:09:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19760 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129143AbRBTSJS>; Tue, 20 Feb 2001 13:09:18 -0500
Date: Tue, 20 Feb 2001 19:10:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __lock_page calls run_task_queue(&tq_disk) unecessarily?
Message-ID: <20010220191023.F8120@athlon.random>
In-Reply-To: <20010220170000.J26544@athlon.random> <Pine.LNX.4.10.10102200909350.30652-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102200909350.30652-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 20, 2001 at 09:11:04AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 09:11:04AM -0800, Linus Torvalds wrote:
> Even if it is wake-one, others may have claimed it before. There can be
> new users coming in and doing a "trylock()" etc.
> 
> NEVER *EVER* think that "exclusive wait-queue" implies some sort of
> critical region protection. An exlcusive wait-queue is _not_ a lock. It's
> only an optimization heuristic.

The reason of not executing the trylock in the slow path of the lock_page is to
avoid writing to the shared ram on all the CPUs at the same time for no good
reason.

We can write just now to the same cacheline from all the CPUs at the same time
if all the cpus runs lock_page at the same time on the same page, but there's
not an high probability for such thing to happen and we would be slower to try
to read first.

The reason of the `continue' is only one: if the wakeup would be wake-all we
would end executing NR_sleppers TryLockPage() and we would get an high probability
that only one of those trylocks will succeed. So we could assume that all the
other trylocks was going to be wasted and so we used `continue' to try not to
bang the cacheline too much for probably no good reason.

But since it's a wake-one, only one task will try to acquire the cacheline after
the wakeup as it just did once with the TryLockPage in lock_page(). It will
just try again like restarting from lock_page().

I don't see how the probability of TryLockPage to succeed after the wakeup
could decrease compared to the first TryLockPage. Since the probability doesn't
decrease I don't see any point for the `continue'. Why should the probability
of succeeding in TryLockPage drecrease after a wakeup compared to the
TryLockPage in lock_page()? If you have an explanation I will certainly agree
to left the `continue' there.

Andrea
