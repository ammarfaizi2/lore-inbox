Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUBNAVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUBNAVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:21:37 -0500
Received: from mail.shareable.org ([81.29.64.88]:62594 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264454AbUBNAVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:21:32 -0500
Date: Sat, 14 Feb 2004 00:21:29 +0000
From: Jamie Lokier <jamie@shareable.org>
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: spinlocks dont work
Message-ID: <20040214002129.GD31199@mail.shareable.org>
References: <89760D3F308BD41183B000508BAFAC4104B16F6F@DDCNYNTD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F6F@DDCNYNTD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RANDAZZO@ddc-web.com wrote:
> On my uniprocessor system, I have two LKM's
>
> driver1 takes hold of the spinlock....but does not release it...
> driver2 attempts to take hold, and is allowed!!!!

How does driver2 run when driver1 holds the spinlock?  It is not
possible: driver1 is running, and you only have one CPU.

It is an error if you call schedule() while holding a spinlock.  It is
also an error if you call the non-irqsave or non-bh spinlock functions
from a context where an irq or bh could interrupt and take the same lock.

These rules ensure that driver1 and driver2 are prevented from
accessing the hardware at the same time.

> how come spin locks don't work?????

They do, if you use them correctly.

> how can I restrict access (to hardware) to only one driver at a time???

By following the correct rules.
See http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/

> should I use semaphores,  etc...

Are you scheduling while you hold the spinlock?  Then you should use
semaphores instead.  But you cannot use semaphores if you are locking
from any kind of interrupt (this includes timer callbacks and wakeup
functions).

Are you using the spinlock from an interrupt?  This is not normally a
problem because each hardware device normally has just one interrupt source.

Are you using the spinlock from a softirq or whatever they are called
these days, as well as an interrupt?  Then you should be using the
spin_lock_irqsave functions in those cases.

And so on.  You must use the correct type of lock functions.

In a uniprocessor kernel, spinlocks compile to almost no code.
(Someone said they compile to nops; this is not quite accurate).  Even
on a uniprocessor, they disable preemptive scheduling while the lock
is held.  This is completely correct.

-- Jamie
