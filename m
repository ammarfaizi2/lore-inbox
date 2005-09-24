Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVIXXpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVIXXpb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVIXXpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 19:45:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57543 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750782AbVIXXpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 19:45:30 -0400
Date: Sun, 25 Sep 2005 01:45:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, Christopher Friesen <cfriesen@nortel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, george@mvista.com,
       johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127570212.15115.77.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509250052390.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home>  <1127342485.24044.600.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
  <Pine.LNX.4.61.0509230151080.3743@scrub.home>  <1127458197.24044.726.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509240443440.3728@scrub.home>  <20050924051643.GB29052@elte.hu>
  <Pine.LNX.4.61.0509241212170.3728@scrub.home> <1127570212.15115.77.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Sep 2005, Thomas Gleixner wrote:

> #define timespec_gt(a,b)                       	\
>         (((a).tv_sec > (b).tv_sec) ? 1 :        \
>         (((a).tv_sec < (b).tv_sec) ? 0 :        \
>         ((a).tv_nsec > (b).tv_nsec)))
> 
> #define timespec_addptr(a,b)                            \
>         (a)->tv_sec = ((a)->tv_sec + (b)->tv_sec);      \
>         (a)->tv_nsec = ((a)->tv_nsec + (b)->tv_nsec);   \
>         if ((a)->tv_nsec >= NSEC_PER_SEC){               \
>                 (a)->tv_nsec -= NSEC_PER_SEC;           \
>                 (a)->tv_sec++;                          \
>         }
> 
> #define timespec_addppp(c,a,b)                          \
>         (c)->tv_sec = ((a)->tv_sec + (b)->tv_sec);      \
>         (c)->tv_nsec = ((a)->tv_nsec + (b)->tv_nsec);   \
>         if ((c)->tv_nsec >= NSEC_PER_SEC){               \
>                 (c)->tv_nsec -= NSEC_PER_SEC;           \
>                 (c)->tv_sec++;                          \
>         }

Alternative for ktimespec:

#define timespec_gt(a,b) ((a).tv64 > (b).tv64)

#if BITS_PER_LONG == 64
#define timespec_addptr(a,b)                            \
        (a).tv64 += (b).tv64;                           \
        if ((a).tv.nsec >= NSEC_PER_SEC) {              \
                (a).tv64 += (u32)-NSEC_PER_SEC;         \
        }
        
#define timespec_addppp(c,a,b)                          \
        (c).tv64 = (a).tv64 + (b).tv64;                 \
        if ((c).tv.nsec >= NSEC_PER_SEC) {              \
                (c).tv64 += (u32)-NSEC_PER_SEC;         \
        }
#else
#define timespec_addptr(a,b)                            \
        (a).tv.sec = ((a).tv.sec + (b).tv.sec);         \
        (a).tv.nsec = ((a).tv.nsec + (b).tv.nsec);      \
        if ((a).tv.nsec >= NSEC_PER_SEC) {              \
                (a).tv.nsec -= NSEC_PER_SEC;            \
                (a).tv.sec++;                           \
        }

#define timespec_addppp(c,a,b)                          \
        (c).tv.sec = ((a).tv.sec + (b).tv.sec);         \
        (c).tv.nsec = ((a).tv.nsec + (b).tv.nsec);      \
        if ((c).tv.nsec >= NSEC_PER_SEC) {              \
                (c).tv.nsec -= NSEC_PER_SEC;            \
                (c).tv.sec++;                           \
        }
#endif  

Adding the necessary conversion to the makes the difference even smaller.

> The only point, where (k)timespec has an advantage is that the userspace
> value must not be converted to nsec_t, but deducing therefor this is the
> better overall solution is a fallacy.

That's your opinion...

> nsec_t				ktimespec
> 
> syscall:
> 32x32 mul
> 64bit add			2 x 32bit move
> 
> arm timer:
> 64 bit add			2 x 32 bit add
> 				  32 bit compare
> 				  32 bit sub
> 				  32 bit add
> 
> The 3 operation compensate for the 32x32 
> multiplication.

The multiply is not necessarly cheap, if the arch has no 32x32->64 
instruction, gcc will generate a call to __muldi3().
Overall for the common case both variations don't differ much in speed 
and size (for a single code path). For a few timers it likely doesn't 
matter and for a lot of timers the tree insert likely dominates.

> The backward conversion from nsec_t to timespec is almost a non issue.
> The vast majority of callers dont provide the second argument to
> nanosleep(), setitimer(), set_timer() which makes the conversion
> necessary and I think we optimize for the common use case.

You know very well, that the conversion back to timespec is the killer in 
your calculation. You graciously decide that the "vast majority" doesn't 
want to read the timer, how did you get to that conclusion?

> Besides that the representation of time in nsec_t values is much
> clearer. 

Well, that depends on the bigger picture, mainly how the timesource 
manages the time. We want to optimize them for a fast get(ns)timeofday, so 
we have already timespec based interfaces. Tick based sources will keep a 
cached xtime timespec, so they either have to convert that to ns or 
maintain another cached value just for your ktimers.
As long as you can't get rid of timespec completely (which is impossible), 
there is a value in keeping it as much as possible as timespec.

bye, Roman
