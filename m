Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271413AbRHTQzq>; Mon, 20 Aug 2001 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271411AbRHTQza>; Mon, 20 Aug 2001 12:55:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36851 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S271389AbRHTQzY>; Mon, 20 Aug 2001 12:55:24 -0400
Message-ID: <3B8140F2.43509CCE@mvista.com>
Date: Mon, 20 Aug 2001 09:55:14 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange macros set HZ value for timer channel zero
In-Reply-To: <Pine.LNX.3.95.1010820100504.1658A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 17 Aug 2001, george anzinger wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > To whomever maintains the timer code, greetings.
> > >
> > > When using Linux on the AMD SC520 chip, the system time will
> > > not be correct because the PIT clock is 1.1882 MHz instead of
> > > the usual 1.19318 MHz. Therefore, I put a conditional value
> > > in ../linux/include/asm/timex.h .
> > >
> > > #ifndef _ASMi386_TIMEX_H
> > > #define _ASMi386_TIMEX_H
> > >
> > > #include <linux/config.h>
> > > #include <asm/msr.h>
> > > #ifdef SC520
> > > #define CLOCK_TICK_RATE 1188200 /* Underlying HZ */
> > > #else
> > > #define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
> > > #endif
> > >
> [SNIPPED...]
> 
> Okay. I still don't know what's wrong. The following code
> shows that your MACRO does produce the right stuff:
> Script started on Mon Aug 20 10:02:58 2001
> 
> # cat xxx.c
> #include <stdio.h>
> #include <sys/time.h>
> #define __KERNEL__
> #include <linux/timex.h>
> 
> int main()
> {
>     printf("Divisor = %d\n", LATCH);
>     printf("%02x %02x\n", LATCH & 0xff, LATCH >> 8);
> }
> 
> # gcc -o xxx xxx.c
> In file included from /usr/local/include/linux/timex.h:54,
>                  from xxx.c:4:
> /usr/local/include/asm/param.h:21: warning: `CLOCKS_PER_SEC' redefined
> /usr/local/include/timebits.h:44: warning: this is the location of the previous definition
> # xxx
> Divisor = 11932
> 9c 2e
> # gcc -DSC520 -o xxx xxx.c
> In file included from /usr/local/include/linux/timex.h:54,
>                  from xxx.c:4:
> /usr/local/include/asm/param.h:21: warning: `CLOCKS_PER_SEC' redefined
> /usr/local/include/timebits.h:44: warning: this is the location of the previous definition
> # xxx
> Divisor = 11882
> 6a 2e
> # exit
> exit
> 
> Script done on Mon Aug 20 10:03:50 2001
> 
> Ignoring the "multiple-defined" warnings, one can see that the
> divisor and the stuff that will be put into the registers is
> correct. Sorry to bother you.
> 
> It looks like this problem has to be fixed with a hammer. For some
> reason, the chip doesn't like the new values.
> 
> I'm off by about 7 seconds per minute:
> 
> Connected to platinum, wait...
>         platinum time was Mon Aug 20 10:10:10 2001
>            chaos time was Mon Aug 20 10:10:03 2001
>     Difference = 7 second(s)
>         platinum time was Mon Aug 20 10:10:11 2001
>            chaos time was Mon Aug 20 10:10:04 2001
>     Difference = 7 second(s)
>         platinum time was Mon Aug 20 10:10:11 2001
>            chaos time was Mon Aug 20 10:10:04 2001
>     Difference = 7 second(s)
>         platinum time was Mon Aug 20 10:10:12 2001
>            chaos time was Mon Aug 20 10:10:05 2001
>     Difference = 7 second(s)
>         platinum time was Mon Aug 20 10:10:12 2001
>            chaos time was Mon Aug 20 10:10:05 2001
>     Difference = 7 second(s)
>         platinum time was Mon Aug 20 10:10:13 2001
>            chaos time was Mon Aug 20 10:10:06 2001
>     Difference = 7 second(s)
>         platinum time was Mon Aug 20 10:10:13 2001
>            chaos time was Mon Aug 20 10:10:06 2001
>     Difference = 7 second(s)
> 
> Aborted by ^C
> 
> It gains time, meaning that the divisor is too small. Unfortunately,
> I can't read what was written to the actual chip. I can only detect
> its affect. 60 / 67 = 0.89 * 100 = 89. 1188200/89 = 13350 = 0x3426
> as a divisor. It doesn't make sense because both LSB and MSB are
> wrong. If one was wrong I could guess that the previous hadn't set
> up properly and needs more delay.
> 
> Anyway. I will continue to search.
> 
If you want to try, you can get close to what the chip is actually using
(with in 6-7 counts).  The counter if read back every interrupt by the
timer interrupt code and is used to compute:
		delay_at_last_interrupt = (count + LATCH/2) / LATCH;

This is done in ../arch/i386/kernel/time.c in the function
timer_interrupt().  To capture the value you could define a variable and
store count in it.  Possibly read this with /proc or more simply, use a
debugger to look at the value.  Or, even, set up a function to take the
max of several readings and printk the result.  The counter is reset to
the programmed value each interrupt (by hardware) and is counting down,
so it will be a few counts less than what was programmed.

George

P.S.  I wonder if the problem is related to other uses of LATCH...

G.
