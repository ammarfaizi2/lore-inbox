Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLTP4E>; Wed, 20 Dec 2000 10:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130030AbQLTPzx>; Wed, 20 Dec 2000 10:55:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35856 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129849AbQLTPzt>; Wed, 20 Dec 2000 10:55:49 -0500
Date: Wed, 20 Dec 2000 16:24:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001220162456.G7381@athlon.random>
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>, <E147MkJ-00036t-00@the-village.bc.nu>; <20001220142858.A7381@athlon.random> <3A40C8CB.D063E337@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A40C8CB.D063E337@uow.edu.au>; from andrewm@uow.edu.au on Thu, Dec 21, 2000 at 01:57:15AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 01:57:15AM +1100, Andrew Morton wrote:
> If a task is on two waitqueues at the same time it becomes a bug:
> if the outer waitqueue is non-exclusive and the inner is exclusive,

Your 2.2.x won't allow that either. You set the `current->task_exclusive = 1'
and so you will get an exclusive wakeups in both waitqueues. You simply cannot
tell register in two waitqueue and expect a non-exlusive wakeup in one and an
exclusive wakeup in the other one.

The only design difference (non implementation difference) between my patch and
your patch is that you have to clear task_exlusive explicitly. You
moved the EXCLUSIVE bitflag out of current->state field. That gives no
advantages and it looks ugiler to me. The robusteness point doesn't hold
IMHO: as soon as current->state is been changed by somebody else
you don't care anymore if it was exclusive wakeup or not.

About the fact I mask out the exlusive bit in schedule that's zero cost
compared to a cacheline miss, but it also depends if you have more wakeups or
schedules (with accept(2) usage there are going to be more schedule than
wakeups, but on other usages that could not be the case) but ok, the
performance point was nearly irrelevant ;).

> Anyway, it's academic.  davem would prefer that we do it properly
> and move the `exclusive' flag into the waitqueue head to avoid the 
> task-on-two-waitqueues problem, as was done in 2.4.  I think he's

The fact you could mix non-exclusive and exlusive wakeups in the same waitqueue
was a feature not a misfeature. Then of course you cannot register in two
waitqueues one with wake-one and one with wake-all but who does that anyways?
Definitely not an issue for 2.2.x.

I think the real reason for spearating the two things as davem proposed is
because otherwise we cannot register for a LIFO wake-one in O(1) as we needed
for accept.

Other thing about your patch, adding TASK_EXCLUSIVE to
wake_up/wake_up_interruptible is useless. You kind of mixed the two things at
the source level. In your patch TASK_EXCLUSIVE should not be defined.  Last
thing the wmb() in accept wasn't necessary. At that point you don't care at all
what the wakeup can see.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
