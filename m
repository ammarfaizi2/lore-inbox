Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317346AbSFGUif>; Fri, 7 Jun 2002 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSFGUie>; Fri, 7 Jun 2002 16:38:34 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:46352 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S317346AbSFGUid>; Fri, 7 Jun 2002 16:38:33 -0400
Message-ID: <3D0117FA.8D1A2289@opersys.com>
Date: Fri, 07 Jun 2002 16:30:50 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: ashieh@OCF.Berkeley.EDU
CC: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday clock jump bug
In-Reply-To: <200206072021.g57KLJU04835@war.OCF.Berkeley.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Alan,

While developing the Linux Trace Toolkit, I've seen this bug occur on
at least the i386 and the PPC. I had written down a description of
how time-keeping is done in the kernel in order to get to the bottom of
the problem. I'm not sure if this is still acurate, but it's a starting
point nevetheless:
http://www.embeddedlinuxworks.com/articles/kernel_time.html

Cheers,

Karim

ashieh@OCF.Berkeley.EDU wrote:
> 
> Hi,
> 
> time() occasionally returns a bogus value (>1 hour jump forward, and a few microseconds later jumps back to the right time) on my box (Thunderbird 750, Asus K7V (KX133) kernel 2.4.17). This behavior sets in after the box is up for some period of time. I don't think this is related to the 686a configuration reset bug.
> 
> I suspect that somehow the either do_gettimeoffset() or xtime.tv_usec in do_gettimeofday is returning a ridiculously large value. I would like to get to the bottom of this problem, but am not familiar with this part of the timing infrastructure. Has anyone seen this bug before? Would using a different locking mode (SMP  vs none SMP, or wahtever) possibly help this problem? Is there a document online describing how this works in Linux?
> 
> In the meantime, I want to hack up a patch to fix this on my box. I'm thinking I could give up a few seconds of clock precision in exchange for monotonic clock behavior, and so I want to comment out the adjustments to usec. What are the possible ramifications of this hack?
> 
> Alan
> 
> Original do_gettimeofday:
> 
> void do_gettimeofday(struct timeval *tv)
> {
>         unsigned long flags;
>         unsigned long usec, sec;
> 
>         read_lock_irqsave(&xtime_lock, flags);
>         usec = do_gettimeoffset();
>         {
>                 unsigned long lost = jiffies - wall_jiffies;
>                 if (lost)
>                         usec += lost * (1000000 / HZ);
>         }
>         sec = xtime.tv_sec;
>         usec += xtime.tv_usec;
>         read_unlock_irqrestore(&xtime_lock, flags);
> 
>         while (usec >= 1000000) {
>                 usec -= 1000000;
>                 sec++;
>         }
> 
>         tv->tv_sec = sec;
>         tv->tv_usec = usec;
> }
> 
> My proposed hack (for my system):
> 
> void do_gettimeofday(struct timeval *tv)
> {
>         unsigned long flags;
>         unsigned long usec, sec;
> 
>         read_lock_irqsave(&xtime_lock, flags);
>         usec = do_gettimeoffset();
>         /* {
>                 unsigned long lost = jiffies - wall_jiffies;
>                 if (lost)
>                         usec += lost * (1000000 / HZ);
>         } */
>         sec = xtime.tv_sec;
>         usec = xtime.tv_usec;
>         read_unlock_irqrestore(&xtime_lock, flags);
> 
>         while (usec >= 1000000) {
>                 usec -= 1000000;
>                 sec++;
>         }
> 
>         tv->tv_sec = sec;
>         tv->tv_usec = usec;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
