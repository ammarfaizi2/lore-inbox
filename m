Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131533AbRCSS1a>; Mon, 19 Mar 2001 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbRCSS1K>; Mon, 19 Mar 2001 13:27:10 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:2040 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131533AbRCSS1G>; Mon, 19 Mar 2001 13:27:06 -0500
Message-ID: <3AB64F4F.7518D3D5@inet.com>
Date: Mon, 19 Mar 2001 12:26:23 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
In-Reply-To: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk> <20010319073356.A16622@flint.arm.linux.org.uk> <20010319123941.A18699@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Russell King wrote:
> > > I've noticed that one of my machines here suffers from the "time going
> > > backwards problem" and so started thinking about the x86 solution.
> > >
> > > I've come to the conclusion that it has a hole which could cause it
> > > to return the wrong time in one specific case:
> > >
> > > - in do_gettimeofday(), we disable irqs (read_lock_irqsave)
> > > - the ISA timer wraps, but we've got interrupts disabled, so no update
> > >   of xtime or jiffies occurs
> > > - in do_slow_gettimeoffset(), we read the timer, which has wrapped
> > > - since jiffies_p != jiffies, we do not apply any correction
> > > - our idea of time is now one jiffy slow.
> >
> > I never heard any response to this.  Could some knowledgeable person please
> > take a look at it?
> 
> do_slow_gettimeoffset() is supposed to correct for wrapping.
> But where it says:
> 
>         #define BUGGY_NEPTUN_TIMER
> 
>                 if( jiffies_t == jiffies_p ) {
>                     if( count > count_p ) {
>                               /* the nutcase */
> 
> Shouldn't that say "count < count_p"?

I've been looking at related code a bit lately... (please correct me if
I'm wrong on something...)

The TIMER1 on an EBSA285 counts down, in which case, count > count_p is
correct.  I don't know which direction the isa_ timer counts.

Russell, I know that at least the EBSA285's timer1_gettimeoffset() needs
some attention to fix a time going backward problem. 
(include/asm-arm/arch-ebsa285/time.h)
I have been using the following recently.  I'm no longer seeing the
gettimeofday() going backwards with this change.  (NOTE! I can't vouch
for the 100% correctness of this code.. I'll talk a bit more about that
after the code, but I think it's closer than it was.)

        int count;

        static int count_p = LATCH;    /* for the first call after boot
*/
        static unsigned long jiffies_p = 0;

        /*
         * cache volatile jiffies temporarily; we have IRQs turned off.
         */
        unsigned long jiffies_t;

        count = *CSR_TIMER1_VALUE;      /* read the count */

        jiffies_t = jiffies;

        /* Detect timer underflows.  If we haven't had a timer tick
since
           the last time we were called, and time is apparently going
           backwards, the counter must have wrapped during this routine.
*/
        if ((jiffies_t == jiffies_p) && (count > count_p))
                count -= LATCH;
        else
                jiffies_p = jiffies_t;

        count_p = count;

        count = (LATCH - count) * tick;
    /* Round up to nearest tick */
        count = (count + LATCH/2) / LATCH;

        return count;

This should prevent us from seeing time jump back for slightly less than
a jiffie. I'm a little unsure of the "rounding" code...  We are supposed
to be returning the number of microseconds since the start of this
jiffie. (right?)  From my (possibly flawed) understanding of this code,
perhaps the following would make more sense?

/*
 * tick = # of usecs per jiffie 
 *        (set in kernel/sched.c, modified by xntpd thru kernel/time.c)
 * LATCH = # timer decrements per jiffie <linux/timex.h>
 * count = # timer decrements remaining in this jiffie
 *
 * LATCH - count = # of timer decrements that have occurred so far in 
 *                 the current (cached) jiffie.
 *
 * (LATCH - count)(timer decs)  tick (usec)            (jiffie)
 *                            x ----------- x ----------------- = (usec)
 *                                (jiffie)    LATCH (timer decs)
 */
        usecs = (LATCH - count) * tick / LATCH;
        return usecs;

Now... all the above makes the time-going-backward problem happen less,
but the original post may still have a point... 

---- timer interrupt
---- jiffies++
---- gettimeoffset
       (sets jiffies_p and count_p)
---- timer interrupt
---- jiffies++
#--- DISABLE INTERRUPTS
#--- timer interrupt
#--- gettimeoffset
#      jiffies_t != jiffies_p, so we don't detect an 
#          underflow (wrapped counter) condition, so the time
#          reported is ~10ms less than it should be.
#      (sets jiffies_p and count_p)
#--- REENABLE INTERRUPTS
---- jiffies++ 
---- timer interrupt
---- jiffies++ 

The problem is only going to occur if gettimeoffset has not been called
in the past 10ms.  Once 10ms has passed, either jiffies has changed, or
count will have passed count_p.

My first thought on a fix for this is to have do_timer (kernel/sched.c)
update the *_p variables... but that's kinda ugly.  Perhaps it should
call gettimeoffset to make sure that it keeps up with the jiffies? 
Ummm....  Of course, if interrupt are disabled for multiple jiffies, I'm
not sure quite how we detect that either...

Thoughts, comments, questions, etc. welcome.

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
