Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <972389-12281>; Mon, 4 May 1998 05:07:44 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:39034 "EHLO rrzs2.rz.uni-regensburg.de" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <972348-12281>; Mon, 4 May 1998 05:04:04 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: R.E.Wolff@bitwizard.nl (Rogier Wolff)
Date: Mon, 4 May 1998 11:43:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Problem with kernel-pll in 2.0.3x (at least)
Cc: linux-kernel@vger.rutgers.edu
In-reply-to: <199805040909.LAA01448@cave.BitWizard.nl>
References: <1DCAEE817EF5@rkdvmks1.ngate.uni-regensburg.de> from "Ulrich Windl" at May 4, 98 09:27:53 am
Message-ID: <1DCD313014D0@rkdvmks1.ngate.uni-regensburg.de>
Sender: owner-linux-kernel@vger.rutgers.edu

On  4 May 98 at 11:09, Rogier Wolff wrote:

> Ulrich Windl wrote:
> > 
> > # Using 1024 Hz as interrupt frequency the following is true:
> > # Using 976us as tick you'll have 999424us per second, and 576us error
> > # Using 977us as tick you'll have 1000448us per second, and 448us error
> > # Using 976us and 977us every second tick, you'll have 999936us per second,
> > # and 64us error
> > # Using 976us and 977us every second tick, plus 978 every 16th tick, you'll
> > # have no error (while your time is still quite steady)! 8-)
> 
> 
> Hi,
> 
> Your method depends on HZ being 1024. It is ad-hoc. We might want this
> because it happens so often, but I personally perfer a general solution.

Yes, setting up the tick is architecture-specific in 2.0 now. The 
modulo operations done can all be expressed by ANDing, and I thought 
the Alpha is fast enough for integers.

> 
> Below is a code snippet that uses fixed-point arithmetic to calculate
> tick much more accurately (10 bits behind the binary point). For 1
> million microseconds in a second and 1024 ticks per second, that
> yields exactly 0 error. 
> 
> But if you happen to have 555 (*) ticks per second, it will be much
> more accurate than the older algorithm (in fact one 40th of a
> microsecond per second of systematic error is quite acceptable don't
> you think?  The old system yielded 110 microseconds of error per
> second.  ;-).
> 
> (*) The 555 is completely arbitrary. I just banged on my keyboard to
> get an example number that doesn't divide evenly.
> 
> As the final code is slightly more complicated than the standard
> 
> 	time += tick;
> 
> you could make this code conditional on:
> 
> #if HZ * (1000000/HZ) != 1000000
> /* #warning "HZ doesn't divide." */
> #define USE_FP_TICK
> #else
> #define USE_SIMPLE_TICK
> /* #warning "HZ DOES divide." */
> #endif
> 
> 
> /* Code snippet: */
> 
> #include <stdio.h>
> 
> #define HZ 1024
> 
> #define FP_SHIFT 10
> #define FRAC_BITS 0x3ff
> 
> 
> int main (int argc, char **argv)
> {
>   long tick;
>   int residual, tick_of_the_day;
>   int i;
>   int time;
> 
>   residual = time = 0;
> 
> /*vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv*/
>   tick = ((1000000 << FP_SHIFT) + HZ/2) / HZ;
> /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
> 
>   for (i=0;i < HZ;i++) {
> 
> /*vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv*/
>     residual += tick;
>     tick_of_the_day = residual >> FP_SHIFT;
>     residual &= FRAC_BITS;
>     time += tick_of_the_day;
> /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
> 
>     printf ("%d %d %d\n", time, tick_of_the_day, residual);
>   }
>   exit (0);
> }
> 
> 
> I'm willing to prepare a patch if Linus says he'll include it in the
> kernel.

The point of you code is: You are doing basically the same as the NTP 
kernel code already does, i.e. remember fractional ticks and add them 
if the fraction is large enough.

The correct solution would probably be to add a frequency offset that 
corrects the systematic error of the software to the offset that the 
user sees. (talking about MOD_FREQUENCY). Unfortunately the NTP code 
originally was designed with 32 bits in mind, and the overflow 
considerations limit the maximum correction. With a systematic offset 
of more than 400PPM there isn't much tolarence left for bad hardware 
(=quartz). Therefore I'd doe it outside of the NTP code, even if it 
wastes some cycles.

As long as the interrupt handling is architecture-specific, I don't 
see the advantage of the very universal code.

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
