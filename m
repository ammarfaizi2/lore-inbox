Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUIOP5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUIOP5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUIOP5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:57:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45482 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262279AbUIOPyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:54:43 -0400
Date: Wed, 15 Sep 2004 17:55:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040915155555.GA11019@elte.hu>
References: <20040915151815.GA30138@elte.hu> <Pine.LNX.4.58.0409150826150.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409150826150.2333@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> > the attached patch is a new approach to get rid of Linux's Big Kernel
> > Lock as we know it today.
> 
> I really think this is wrong.
> 
> Maybe not from a conceptual standpoint, but that implementation with
> the scheduler doing "reaquire_kernel_lock()" and doing a down() there
> is just wrong, wrong, wrong.
> 
> If we're going to do a down() and block immediately after being
> scheduled, I don't think we should have been picked in the first
> place.

agreed, and that codepath is only for correctness - the semaphore code
will make sure most of the time that this doesnt happen. It's the same
as the need_resched check - it doesnt happen in 99.9% of the cases but
when it happens it must happen.

> Yeah, yeah, you have all that magic to not recurse by setting
> lock-depth negative before doing the down(), but it still feels
> fundamentally wrong to me. There's also the question whether this
> actually _helps_ anything, since it may well just replace the spinning
> with lots of new scheduler activity. 

Rare activity that still runs under the BKL (e.g. mounting, or ioctls)
can introduce many milliseconds of scheduling delays that hurt
latencies. None of this is really performance-sensitive as it's almost
always used for some big old piece of code. Anything that is frequently
taken/dropped we've replaced with proper spinlocks already. So what's
left is the code for which 1) everyone hurts most from it not being a
real semaphore 2) no _user_ or maintainer of that code cares about the
BKL because it's not performance-critical.

> And you make schedule() a lot more expensive for kernel lock holders
> by copying the CPU map. [...]

we dont really care about BKL _users_, other than correctness. We've got
cpusets for the bitmap overhead reduction.

> [...] You may have tested it on a machine where the CPU map is just a
> single word, but what about the big machines?

and it's not that bad - if it's .. 512 CPUs then _BKL users_ copy 64
bytes. I dont think the 512-CPU guys will complain about this patch. If
there are any frequent BKL users on such big boxes then they need
serious and quick fixing anyway, because they are bouncing a global
spinlock madly across 512 CPUs, 32 cross-connects and 4 backplanes! The
64-byte copy within the CPU-local task structure really dwarves in
comparison...

> Spinlocks really _are_ cheaper. Wouldn't it be nice to just continue
> removing kernel lock users and keeping a very _simple_ kernel lock for
> legacy issues? 

yes, but progress in this area seems to have slowed down, and people are
hurting from the latencies introduced by the BKL meanwhile. Who cares if
some rare big chunk of code runs under a semaphore, as long as it's
preemptable?

a global spinlock isnt all that much cheaper than a semaphore, even if
it's not taken or lightly taken. If it's heavily taken then a semaphore
wins. There is clearly an interim area where a spinlock will win - but
only if the spinlock is well-localized to some resource or CPU - this is
absolutely not true for the BKL which is as global as it gets.

> In other words, I'd _really_ like to see some serious numbers for
> this.

fully agreed about that too!

	Ingo
