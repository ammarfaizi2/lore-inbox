Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265739AbTFNUxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbTFNUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:53:10 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:2761 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S265739AbTFNUvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:51:33 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Date: Sat, 14 Jun 2003 22:05:24 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEFDEFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030614224253.G25997@ucw.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

 > ChangeSet@1.1215.104.25, 2003-06-09 14:41:31+02:00, vojtech@suse.cz
 >   input: Change input/misc/pcspkr.c to use CLOCK_TICK_RATE instead of
 >   a fixed value of 1193182. And change CLOCK_TICK_RATE and several
 >   usages of a fixed value 1193180 to a slightly more correct value
 >   of 1193182. (True freq is 1.193181818181...).

Is there any reason why you used CLOCK_TICK_RATE in some places and
1193182 in others ??? I can understand your using the number in the
definition of CLOCK_TICK_RATE but not in the other cases.

If I'm reading it correctly, the result is a collection of bugs on the
AMD ELAN system as that uses a different frequency (at least, according
to the last but one hunk in your patch)...

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.



 >  drivers/char/vt_ioctl.c           |    4 ++--
 >  drivers/input/gameport/gameport.c |    2 +-
 >  drivers/input/joystick/analog.c   |    2 +-
 >  drivers/input/misc/pcspkr.c       |    2 +-
 >  include/asm-i386/timex.h          |    2 +-
 >  include/asm-x86_64/timex.h        |    2 +-
 >  6 files changed, 7 insertions(+), 7 deletions(-)
 >
 > ===================================================================
 >
 > diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
 > --- a/drivers/char/vt_ioctl.c	Sat Jun 14 22:23:32 2003
 > +++ b/drivers/char/vt_ioctl.c	Sat Jun 14 22:23:32 2003
 > @@ -395,7 +395,7 @@
 >  		if (!perm)
 >  			return -EPERM;
 >  		if (arg)
 > -			arg = 1193180 / arg;
 > +			arg = 1193182 / arg;
 >  		kd_mksound(arg, 0);
 >  		return 0;
 >
 > @@ -412,7 +412,7 @@
 >  		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
 >  		count = ticks ? (arg & 0xffff) : 0;
 >  		if (count)
 > -			count = 1193180 / count;
 > +			count = 1193182 / count;
 >  		kd_mksound(count, ticks);
 >  		return 0;
 >  	}
 > diff -Nru a/drivers/input/gameport/gameport.c
 > b/drivers/input/gameport/gameport.c
 > --- a/drivers/input/gameport/gameport.c	Sat Jun 14 22:23:32 2003
 > +++ b/drivers/input/gameport/gameport.c	Sat Jun 14 22:23:32 2003
 > @@ -37,7 +37,7 @@
 >
 >  #ifdef __i386__
 >
 > -#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193180/HZ:0))
 > +#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
 >  #define GET_TIME(x)     do { x = get_time_pit(); } while (0)
 >
 >  static unsigned int get_time_pit(void)
 > diff -Nru a/drivers/input/joystick/analog.c
 > b/drivers/input/joystick/analog.c
 > --- a/drivers/input/joystick/analog.c	Sat Jun 14 22:23:32 2003
 > +++ b/drivers/input/joystick/analog.c	Sat Jun 14 22:23:32 2003
 > @@ -138,7 +138,7 @@
 >
 >  #ifdef __i386__
 >  #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x =
get_time_pit(); } while (0)
 > -#define DELTA(x,y)
(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
 > +#define DELTA(x,y)
(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193182L/HZ:0)))
 >  #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 >  static unsigned int get_time_pit(void)
 >  {
 > diff -Nru a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
 > --- a/drivers/input/misc/pcspkr.c	Sat Jun 14 22:23:32 2003
 > +++ b/drivers/input/misc/pcspkr.c	Sat Jun 14 22:23:32 2003
 > @@ -43,7 +43,7 @@
 >  	}
 >
 >  	if (value > 20 && value < 32767)
 > -		count = 1193182 / value;
 > +		count = CLOCK_TICK_RATE / value;
 >
 >  	spin_lock_irqsave(&i8253_beep_lock, flags);
 >
 > diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
 > --- a/include/asm-i386/timex.h	Sat Jun 14 22:23:32 2003
 > +++ b/include/asm-i386/timex.h	Sat Jun 14 22:23:32 2003
 > @@ -15,7 +15,7 @@
 >  #ifdef CONFIG_MELAN
 >  #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency!
*/
 >  #else
 > -#  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
 > +#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 >  #endif
 >  #endif
 >
 > diff -Nru a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
 > --- a/include/asm-x86_64/timex.h	Sat Jun 14 22:23:32 2003
 > +++ b/include/asm-x86_64/timex.h	Sat Jun 14 22:23:32 2003
 > @@ -10,7 +10,7 @@
 >  #include <asm/msr.h>
 >  #include <asm/vsyscall.h>
 >
 > -#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
 > +#define CLOCK_TICK_RATE	1193182 /* Underlying HZ */
 >  #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and
CLOCK_TICK_RATE */
 >  #define FINETUNE ((((((int)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) *
\
 >  	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.489 / Virus Database: 288 - Release Date: 10-Jun-2003

