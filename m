Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265908AbRGEQQX>; Thu, 5 Jul 2001 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbRGEQQO>; Thu, 5 Jul 2001 12:16:14 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:57381 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265908AbRGEQP7>; Thu, 5 Jul 2001 12:15:59 -0400
Date: Thu, 5 Jul 2001 18:15:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Thibaut Laurent <thibaut@celestix.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705181544.Y17051@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random> <3B447B6D.C83E5FB9@redhat.com> <20010705164046.S17051@athlon.random> <20010705233200.7ead91d5.thibaut@celestix.com> <20010705114633.A1787@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010705114633.A1787@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, Jul 05, 2001 at 11:46:33AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 11:46:33AM -0400, Arjan van de Ven wrote:
> On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> > And the winner is... Andrea. Kudos to you, I've just applied these patches,
> > recompiled and it seems to work fine.
> > Too bad, this was the perfect excuse for getting rid of those good old Cyrix
> > boxen ;)
> 
> As Andrea's patches don't actually fix anything Cyrix related it's obvious
> that they just avoid the real bug instead of fixing it.
> It's a very useful datapoint though.

I repeat an hardware issue cannot cause that BUG(), I assume you are
worried about the software device driver. The softirq stuff in mainline
is pretty broken, to make an example think if atomic_read(&t->count) is
> 0 and another cpu enables the tasklet before the tasklet_unlock but
after the test_bit(TASKLET_STATE_SCHED), the following
test_bit(TASKLET_STATE_SCHED) will trigger but tasklet_hi_schedule won't
do anything because TASKLET_STATE_SCHED is just set and you will break
badly if you don't use my patches. The new code breaks the invariant
that when irq are locally enabled and the TASKLET_STATE_SCHED is set the
tasklet is guaranteed to be just queued and that can have side effects,
possibly the BUG() you are seeing, I didn't checked the new code too
closely because I simply don't agree with the "infinite loop into atomic
context" design, ksoftirqd solves the latency bugs just fine without
losing robusteness that way.

But of course if the driver has all the power to be able to be the buggy
piece of code, in that case I will be more than willing to add some
BUG() to my variant of the softirq handling to trigger it too. But at
the moment it is not obvious to me this is not a bug in the softirq
code.

Andrea
