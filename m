Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbTFNVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265717AbTFNVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:01:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4333 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265710AbTFNVBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:01:10 -0400
Date: Sat, 14 Jun 2003 23:14:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Riley Williams <Riley@Williams.Name>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030614231455.A26303@ucw.cz>
References: <20030614224253.G25997@ucw.cz> <BKEGKPICNAKILKJKMHCACEFDEFAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <BKEGKPICNAKILKJKMHCACEFDEFAA.Riley@Williams.Name>; from Riley@Williams.Name on Sat, Jun 14, 2003 at 10:05:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 10:05:24PM +0100, Riley Williams wrote:
> Hi.
> 
>  > ChangeSet@1.1215.104.25, 2003-06-09 14:41:31+02:00, vojtech@suse.cz
>  >   input: Change input/misc/pcspkr.c to use CLOCK_TICK_RATE instead of
>  >   a fixed value of 1193182. And change CLOCK_TICK_RATE and several
>  >   usages of a fixed value 1193180 to a slightly more correct value
>  >   of 1193182. (True freq is 1.193181818181...).
> 
> Is there any reason why you used CLOCK_TICK_RATE in some places and
> 1193182 in others ??? I can understand your using the number in the
> definition of CLOCK_TICK_RATE but not in the other cases.

I only changed the numbers from 1193180 to 1193182 in the patch.
The presence of the number instead of CLOCK_TICK_RATE in many drivers
is most likely a bug by itself, but that'll need to be addressed in a
different patch.

The only one place where I fixed it for now is the pcspkr.c driver,
since that is the one that actually started the whole thing.

> If I'm reading it correctly, the result is a collection of bugs on the
> AMD ELAN system as that uses a different frequency (at least, according
> to the last but one hunk in your patch)...

Care to send me a patch to fix this all completely and for once?

Anyone disagrees with changing all the instances of 1193180/1193182 to
CLOCK_TICK_RATE?

> Best wishes from Riley.
> ---
>  * Nothing as pretty as a smile, nothing as ugly as a frown.
> 
> 
> 
>  >  drivers/char/vt_ioctl.c           |    4 ++--
>  >  drivers/input/gameport/gameport.c |    2 +-
>  >  drivers/input/joystick/analog.c   |    2 +-
>  >  drivers/input/misc/pcspkr.c       |    2 +-
>  >  include/asm-i386/timex.h          |    2 +-
>  >  include/asm-x86_64/timex.h        |    2 +-
>  >  6 files changed, 7 insertions(+), 7 deletions(-)
>  >
>  > ===================================================================
>  >
>  > diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
>  > --- a/drivers/char/vt_ioctl.c	Sat Jun 14 22:23:32 2003
>  > +++ b/drivers/char/vt_ioctl.c	Sat Jun 14 22:23:32 2003
>  > @@ -395,7 +395,7 @@
>  >  		if (!perm)
>  >  			return -EPERM;
>  >  		if (arg)
>  > -			arg = 1193180 / arg;
>  > +			arg = 1193182 / arg;
>  >  		kd_mksound(arg, 0);
>  >  		return 0;
>  >
>  > @@ -412,7 +412,7 @@
>  >  		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
>  >  		count = ticks ? (arg & 0xffff) : 0;
>  >  		if (count)
>  > -			count = 1193180 / count;
>  > +			count = 1193182 / count;
>  >  		kd_mksound(count, ticks);
>  >  		return 0;
>  >  	}
>  > diff -Nru a/drivers/input/gameport/gameport.c
>  > b/drivers/input/gameport/gameport.c
>  > --- a/drivers/input/gameport/gameport.c	Sat Jun 14 22:23:32 2003
>  > +++ b/drivers/input/gameport/gameport.c	Sat Jun 14 22:23:32 2003
>  > @@ -37,7 +37,7 @@
>  >
>  >  #ifdef __i386__
>  >
>  > -#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193180/HZ:0))
>  > +#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
>  >  #define GET_TIME(x)     do { x = get_time_pit(); } while (0)
>  >
>  >  static unsigned int get_time_pit(void)
>  > diff -Nru a/drivers/input/joystick/analog.c
>  > b/drivers/input/joystick/analog.c
>  > --- a/drivers/input/joystick/analog.c	Sat Jun 14 22:23:32 2003
>  > +++ b/drivers/input/joystick/analog.c	Sat Jun 14 22:23:32 2003
>  > @@ -138,7 +138,7 @@
>  >
>  >  #ifdef __i386__
>  >  #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x =
> get_time_pit(); } while (0)
>  > -#define DELTA(x,y)
> (cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
>  > +#define DELTA(x,y)
> (cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193182L/HZ:0)))
>  >  #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
>  >  static unsigned int get_time_pit(void)
>  >  {
>  > diff -Nru a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
>  > --- a/drivers/input/misc/pcspkr.c	Sat Jun 14 22:23:32 2003
>  > +++ b/drivers/input/misc/pcspkr.c	Sat Jun 14 22:23:32 2003
>  > @@ -43,7 +43,7 @@
>  >  	}
>  >
>  >  	if (value > 20 && value < 32767)
>  > -		count = 1193182 / value;
>  > +		count = CLOCK_TICK_RATE / value;
>  >
>  >  	spin_lock_irqsave(&i8253_beep_lock, flags);
>  >
>  > diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
>  > --- a/include/asm-i386/timex.h	Sat Jun 14 22:23:32 2003
>  > +++ b/include/asm-i386/timex.h	Sat Jun 14 22:23:32 2003
>  > @@ -15,7 +15,7 @@
>  >  #ifdef CONFIG_MELAN
>  >  #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency!
> */
>  >  #else
>  > -#  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
>  > +#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
>  >  #endif
>  >  #endif
>  >
>  > diff -Nru a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
>  > --- a/include/asm-x86_64/timex.h	Sat Jun 14 22:23:32 2003
>  > +++ b/include/asm-x86_64/timex.h	Sat Jun 14 22:23:32 2003
>  > @@ -10,7 +10,7 @@
>  >  #include <asm/msr.h>
>  >  #include <asm/vsyscall.h>
>  >
>  > -#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
>  > +#define CLOCK_TICK_RATE	1193182 /* Underlying HZ */
>  >  #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and
> CLOCK_TICK_RATE */
>  >  #define FINETUNE ((((((int)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) *
> \
>  >  	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
> 
> ---
> Outgoing mail is certified Virus Free.
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.489 / Virus Database: 288 - Release Date: 10-Jun-2003
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
