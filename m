Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTA2AQV>; Tue, 28 Jan 2003 19:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTA2AQV>; Tue, 28 Jan 2003 19:16:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14328 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262500AbTA2AQT>;
	Tue, 28 Jan 2003 19:16:19 -0500
Message-ID: <3E371F52.370D1F77@mvista.com>
Date: Tue, 28 Jan 2003 16:24:50 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2/4) 2.5.59 fast reader/writer lock for gettimeofday
References: <1043797351.10150.302.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One wonders if it wouldn't be better to put the div in
gettimeofday() outside of the lock region, see below...  It
makes the while condition even more unlikely.

-g

~snip~

> diff -urN -X dontdiff linux-2.5.59/arch/i386/kernel/time.c linux-2.5-frlock/arch/i386/kernel/time.c
> --- linux-2.5.59/arch/i386/kernel/time.c        2003-01-17 09:42:14.000000000 -0800
> +++ linux-2.5-frlock/arch/i386/kernel/time.c    2003-01-24 15:06:37.000000000 -0800
> @@ -70,7 +70,7 @@
> 
>  unsigned long cpu_khz; /* Detected as we calibrate the TSC */
> 
> -extern rwlock_t xtime_lock;
> +extern frlock_t xtime_lock;
>  extern unsigned long wall_jiffies;
> 
>  spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
> @@ -87,19 +87,21 @@
>   */
>  void do_gettimeofday(struct timeval *tv)
>  {
> -       unsigned long flags;
> +       unsigned long seq;
++++>     unsigned long xtimensec;
>         unsigned long usec, sec;
> 
> -       read_lock_irqsave(&xtime_lock, flags);
> -       usec = timer->get_offset();
> -       {
> -               unsigned long lost = jiffies - wall_jiffies;
> -               if (lost)
> -                       usec += lost * (1000000 / HZ);
> -       }
> -       sec = xtime.tv_sec;
> -       usec += (xtime.tv_nsec / 1000);
> -       read_unlock_irqrestore(&xtime_lock, flags);
> +       do {
> +               seq = fr_read_begin(&xtime_lock);
> +
> +               usec = timer->get_offset();
> +               {
> +                       unsigned long lost = jiffies - wall_jiffies;
> +                       if (lost)
> +                               usec += lost * (1000000 / HZ);
> +               }
> +               sec = xtime.tv_sec;
----> +               usec += (xtime.tv_nsec / 1000);
++++> +               xtimensec = xtime.tv_nsec;
> +       } while (unlikely(seq != fr_read_end(&xtime_lock)));
> 
++++>     usec += xtimensec / 1000;
>         while (usec >= 1000000) {
>                 usec -= 1000000;
> @@ -112,7 +114,7 @@
> 
>  void do_settimeofday(struct timeval *tv)
>  {
> -       write_lock_irq(&xtime_lock);
> +       fr_write_lock_irq(&xtime_lock);
>         /*
>          * This is revolting. We need to set "xtime" correctly. However, the
>          * value in this location is the value at the most recent update of
> @@ -133,7 +135,7 @@
>         time_status |= STA_UNSYNC;
>         time_maxerror = NTP_PHASE_LIMIT;
>         time_esterror = NTP_PHASE_LIMIT;
> -       write_unlock_irq(&xtime_lock);
> +       fr_write_unlock_irq(&xtime_lock);
>  }
> 
>  /*
> @@ -279,12 +281,12 @@
>          * the irq version of write_lock because as just said we have irq
>          * locally disabled. -arca
>          */
> -       write_lock(&xtime_lock);
> +       fr_write_lock(&xtime_lock);
> 
>         timer->mark_offset();
> 
>         do_timer_interrupt(irq, NULL, regs);
> 
> -       write_unlock(&xtime_lock);
> +       fr_write_unlock(&xtime_lock);
> 
>  }

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
