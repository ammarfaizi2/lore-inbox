Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319622AbSH3RHn>; Fri, 30 Aug 2002 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319623AbSH3RHn>; Fri, 30 Aug 2002 13:07:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44548 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319622AbSH3RHm>; Fri, 30 Aug 2002 13:07:42 -0400
Date: Fri, 30 Aug 2002 10:19:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208301902570.527-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208301012480.2163-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Ingo Molnar wrote:
> 
> it touches the waitqueue spinlock - and the __down() path [ie. the process
> that gets woken up, which has the semaphore on the stack] takes the
> spinlock after waking up. Ie. there's guaranteed synchronization, the
> semaphore will not be 'unused' before the __down() path takes the spinlock
> - ie. after the __up() path releases the spinlock. What am i missing?

So why couldn't this happen? This is what used to happen before, I don't 
see that consolidating the spinlock had any impact at all.

	CPU #0						CPU #1

	down()						up()

		lock decl (negative)
		__down()				lock incl
			spinlock()			__up()
			atomic_add_negative()
				success - break
			spinunlock();
		}					wake_up()
	return - semaphore is now invalid		spin_lock()

							BOOM!


The fact is, that as long as down() and up() avoid taking the spinlock 
_before_ they touch "count", they aren't synchronized. 

And we definitely do _not_ want to take the spinlock before we touch 
count, since that would make the fast path a lot slower.

What?

		Linus

