Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbRE0TKg>; Sun, 27 May 2001 15:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbRE0TK0>; Sun, 27 May 2001 15:10:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40074 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261515AbRE0TKP>;
	Sun, 27 May 2001 15:10:15 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15121.20713.676075.980272@pizda.ninka.net>
Date: Sun, 27 May 2001 12:09:29 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
In-Reply-To: <20010527195619.K676@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>
	<20010527190700.H676@athlon.random>
	<15121.13986.987230.445825@pizda.ninka.net>
	<20010527195619.K676@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > 	if (softirq_active(cpu) & softirq_mask(cpu)) {
 > 	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 > 
 > I mean everything is fine until the same softirq is marked active again
 > under do_softirq, in such case neither the do_softirq in do_IRQ will
 > run it (because we are in the critical section and we hold the per-cpu
 > locks), nor we will run it again ourself from the underlying do_softirq
 > to avoid live locking into do_softirq.

"live lock".  What do you hope to avoid by pushing softirq processing
into a scheduled task?  I think doing that is a stupid idea.

You are saying that if we are getting a lot of soft irqs we should
defer it so that we can leave the trap handler, to avoid "live lock".

I think this is a bogus scheme for several reasons.  First of all,
deferring the processing will only increase the likelyhood that the
locality of the data will be lost, making the system work harder.

Secondly, if we are getting softirqs at such a rate, we have other
problems.  We are likely getting surged with hardware interrupts, and
until we have Jamals stuff in to move ethernet hardware interrupt
handling into softirqs your deferrals will be fruitless when they do
actually trigger.  We will be livelocked in hardware interrupt
processing instead of being livelocked in softirq processing, what an
incredible improvement. :-)

Therefore I recommend that the softirqs are implemented on x86 how at
least I intended the damn things to be implemented, on every return
from trap, no matter what kind, call do_softirq if softirqs are
pending.

Again, I am totally against ksoftirqd, I think it's a completely dumb
idea.  Softirqs were meant to be as light weight as possible, don't
crap on them like this with this heavyweight live lock "solution".
It isn't even solving live locks, it's rather trading one kind for
another with zero improvement.

Later,
David S. Miller
davem@redhat.com
