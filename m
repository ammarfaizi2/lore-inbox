Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbQLTPXR>; Wed, 20 Dec 2000 10:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLTPXH>; Wed, 20 Dec 2000 10:23:07 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:765 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129632AbQLTPW5>; Wed, 20 Dec 2000 10:22:57 -0500
Message-ID: <3A40C8CB.D063E337@uow.edu.au>
Date: Thu, 21 Dec 2000 01:57:15 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>,
		<E147MkJ-00036t-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 16, 2000 at 07:11:47PM +0000 <20001220142858.A7381@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > o     wake_one semantics for accept()                 (Andrew Morton)
> 
> I dislike the implementation. I stick with my faster and nicer implementation
> that was just included in aa kernels for some time (2.2.18aa2 included it for
> example). Andrew, I guess you didn't noticed I just implemented the wakeone for
> accept. (I just ported it on top of 2.2.19pre2 after backing out the wakeone in
> pre2)

Yes, I noticed your implementation a few weeks back.

'fraid I never liked the use of the TASK_EXCLUSIVE bit in
task_struct.state.  It's an enumerated state, not an aggregation
of flags.  Most of the kernel treats it as an enumerated state
and so will happily clear the TASK_EXCLUSIVE bit without masking it
off.  Fragile.

If a task is on two waitqueues at the same time it becomes a bug:
if the outer waitqueue is non-exclusive and the inner is exclusive,
the task suddenly becomes exclusive on the outer one and converts
it from wake-all to wake-some!

Is it faster?  Not sure.  You've saved a cacheline read in __wake_up
(which was in fact a preload, if you look at what comes later) at the
cost of having to mask out the bit in current->state every time
we schedule().

Anyway, it's academic.  davem would prefer that we do it properly
and move the `exclusive' flag into the waitqueue head to avoid the 
task-on-two-waitqueues problem, as was done in 2.4.  I think he's
right.  Do you?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
