Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131649AbRCSWzS>; Mon, 19 Mar 2001 17:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbRCSWzI>; Mon, 19 Mar 2001 17:55:08 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:24204 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131653AbRCSWy5>; Mon, 19 Mar 2001 17:54:57 -0500
Message-ID: <3AB68E13.E6F6109E@inet.com>
Date: Mon, 19 Mar 2001 16:54:11 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
In-Reply-To: <200103192134.VAA01785@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Eli Carter writes:
> > What are you seeing that I'm missing?
> 
> Ok, after sitting down and thinking again about this problem, its not
> the 9.9999ms case, but the 10.000000001 case:

And you described (in much better detail) the same problem I was talking
about in the first email I sent today.

gettimeoffset does not handle cases >10ms.

> Like I say, this requires good timing to create, so may not be too much of
> a problem, but it does seem to be a problem that could occur.

You should be able to create this "maliciously" within the kernel (or
with bad driver code...) with something like:
Disable interrupts for 10ms, then call gettimeofday, reenable
interrupts, then call gettimeofday.
(I think.)

> I'm wondering if something like the following will plug this hole:

Yes, but it digs another to get the dirt to fill the first one. :/  for
instance:

> 
>         read_lock_xtime_and_ints();
>         jiffies_1 = jiffies;
>         counter_1 = counter;
>         read_unlock_xtime_and_ints();

Time passes due to an interrupt handler.... but not a full jiffy, so
jiffies hasn't changed.
Also, what if this function is called with interrupts disabled?  (Is
that legal?)  If so, we've broken the locking expected by the caller.

>         read_lock_xtime_and_ints();

And just for giggles, the counter rolls over here.  (And with interrupts
disabled, jiffies isn't updated yet...)

>         jiffies_2 = jiffies;
>         counter_2 = counter;
>         read_unlock_xtime_and_ints();
>
>         if (jiffies_1 != jiffies_2) {
>                 /*
>                  * we rolled over while reading counter_1.  Therefore
>                  * we can't trust it.  Use *_2 instead.  Note that we
>                  * would have received an interrupt between read_unlock
>                  * and read_lock.
>                  */
>                 jiffies_1 = jiffies_2;
>                 counter_1 = counter_1;
>         } else {
>                 /*
>                  * we didn't roll over while reading counter_1
>                  * we can safely use counter_1 as is.  Neither
>                  * did we receive a timer interrupt between the
>                  * read_unlock and read_lock.
>                  */
>         }
> 
>         /* apply standard counter correction factor */

Which might be just less than 10ms inaccurate due to that interrupt
handler that ran after we read the times.  So we are no more accurate
than before. :/

Unless you use counter_2, but then you have the original problem again.

> The only thing I haven't looked at is whether xtime would be updated.

That is updated in the timer bottom half; jiffies and lost_ticks are
updated in the timer interrupt.  lost_ticks is then used by the bottom
half to update xtime.  (That's why the gettimeofday portion references
lost_ticks.)

Comments?

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
