Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131529AbRCSTuN>; Mon, 19 Mar 2001 14:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCSTtx>; Mon, 19 Mar 2001 14:49:53 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:22782 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131529AbRCSTtq>; Mon, 19 Mar 2001 14:49:46 -0500
Message-ID: <3AB662B0.A3FB2135@inet.com>
Date: Mon, 19 Mar 2001 13:49:04 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
In-Reply-To: <200103191906.TAA01646@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Eli Carter writes:
> > Russell, I know that at least the EBSA285's timer1_gettimeoffset() needs
> > some attention to fix a time going backward problem.
> 
> I know about this, which is what started me looking at what x86 does,
> and I am firmly of the conclusion that x86 is buggy as it stands.

Ah, OK.
 
> I believe that we can, instead of having a per-machine fix on ARM, have
> a generic fix.  At the moment, I haven't worked out exactly what this
> generic fix would be.
> 
> > The problem is only going to occur if gettimeoffset has not been called
> > in the past 10ms.  Once 10ms has passed, either jiffies has changed, or
> > count will have passed count_p.
> 
> My concern with the x86 fix is what if 9.9999999999ms has passed since the
> last timer tick, and we got the timer tick after we disabled interrupts and
> entered do_gettimeofday.  This can lead to the tests in there miscorrecting
> IMHO.  You won't see it with an infinite loop reading the time of day...

Hmm...  I'm not seeing it quite yet...
do_gettimeofday doesn't 
-- disable interrupts for do_gettimeofday
-- interrupt raised for "TIMER1" (or isa timer or whatever), the timer's
counter wraps back to the value of LATCH and begins decrementing.
-- we make a copy of xtime
-- gettimeoffset is called.  Assuming it has been called less than 10ms
ago, (jiffies_t == jiffies_p && count > count_p) is true, so we adjust
the 10ms for that, and return the number of usecs since the last jiffie
change.
-- add the offset, bringing us up to the correct time
-- lost_ticks adjusts for the number of jiffies that have been counted
but not added to xtime (and thus has no impact on the gettimeoffset
logic)
    (so, shouldn't this be "tv->tv_usec += lost_ticks *
USECS_PER_JIFFY;"?
     or can lost_ticks never be greater than 1?)
-- restore interrupts
-- jiffies & lost_ticks get incremented

What are you seeing that I'm missing?

> I'll re-read your mail in more depth later tonight.  Appologies if this
> reply appears to be a little early.

No problem.  I'd like to see this code fixed correctly, so I'm happy to
help.

C-ya,

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
