Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSHPRPA>; Fri, 16 Aug 2002 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSHPRPA>; Fri, 16 Aug 2002 13:15:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318626AbSHPRO6>; Fri, 16 Aug 2002 13:14:58 -0400
Date: Fri, 16 Aug 2002 10:22:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <20020816173013.A858@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208161013420.2243-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Jamie Lokier wrote:
> 
> Quite.  There is no lock; the the futex is used in its purest form, as
> a wait queue.
> 
>       TID  = thread is alive
>       zero = thread is gone

I don't disagree with using a futex, and the interface can be exactly the
same (ie "synchronize with thread exit" really becomes "futex wait for tid
address" as you point out). I think it's a wonderful interface, and for
people who don't use futexes, they'd never even _notice_ that they could 
do so.

However, the thing that makes me slightly nervous is that it would make
the exit case a bit slower. Right now we just do a conditional write zero
to a virtual address (ie two instructions or so):

        if (tsk->user_tid)
                put_user(0UL, tsk->user_tid);

but if we were to use a futex, the code would need to be something 
slightly more complex and slower (I'm adding the "only do this if 
somebody else has the VM" test to avoid it for some cases):

	if (tsk->user_tid && atomic_read(&tsk->mm->users) > 1) {
		if (!put_user(0, tsk->user_tid))
			sys_futex(FUTEX_WAKE, tsk->user_tid);
	}

where that sys_futex will do a page table walk etc. 

So yes, it's a lot more generic (and very pleasant to use when we want 
to), but it does imply a fair amount of overhead.

So I'd like to know what the likelyhood of it being used as a futex is. If 
90% of all users would like a futex, that's _wonderful_. No question that 
we should do it. But if it's dynamically fairly rare to have this 
"synchronize with thread exit", then we may be losing more than we win.

		Linus

