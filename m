Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRIOHR3>; Sat, 15 Sep 2001 03:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272124AbRIOHRS>; Sat, 15 Sep 2001 03:17:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62456 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S272121AbRIOHRK>; Sat, 15 Sep 2001 03:17:10 -0400
Message-ID: <3BA2FFFC.49FBDDC8@mvista.com>
Date: Sat, 15 Sep 2001 00:15:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Schneider <SPATZ1@t-online.de>
CC: "Antonios G. Danalis" <danalis@udel.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: increasing HZ in Linux kernel
In-Reply-To: <3BA134F3.FA661E9E@udel.edu> <3BA23D51.B456C9EE@mvista.com> <3BA24424.A3C74D69@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Schneider wrote:
> 
> george anzinger schrieb:
> >
> > "Antonios G. Danalis" wrote:
> > >
> > > Hello,
> > >
> > > I want to increase the frequency of the clock interrupt up
> > > to ~10000 to run some experiments.
> > >
> > > Is there an easy way to increase clock interrupt freq, or
> > > do I have to mess with the whole kernel ?
> > >
> > The approach we are taking in the high-res-timers project
> > (http://sourceforge.net/projects/high-res-timers) is to leave HZ alone
> > and schedule timer interrupts as needed between the 1/HZ ticks.  I have
> > an kernel with most of the infrastructure ready to put on the
> > sourceforge site (today I hope), that you may want to look at.  Be
> > aware, however, it is not really a simple change.  You may also want to
> > look at the UTIME patch from the University of Kansas, which, to some
> > extent, is where I started.  We both leave HZ alone and schedule timer
> > ticks as needed to get high resolution.
> >
> > As you have noted, changing HZ impacts other sub systems.  There is also
> > an issue of jiffie rollover which affects the longest time you can set
> > timers for.  Currently with HZ =100 and 32-bit integers, this is about
> > 248.55 days.
> 
> Sure ?
> I think it is 497 days, jiffies is "unsigned long" on IA32.

That is when it rolls over.  What I am talking about is when the compare
of two unsigned numbers gives the wrong answer.  That happens when the
difference is greater than 1/2 of the max count.  This is independent of
the actual values so it really doesn't matter what the counts are, just
the differences to be compared.  The kernel code is very careful to do
the compare in such a way as to avoid the issues around the actual size,
but the max difference of 1/2 the value is another matter and can not be
avoided with out extra bits.

This is important as the add_timer code checks to see if the time has
passed yet.  If so it queues the timer for the next tick.  This will
happen when the timer is to expire more than 1/2 the max unsigned int
from now.

George
> 
> (On PPC "HZ" is 1024, but i think there "jiffies" is 64-bit.)
> 
> I encountered this problem as my "/proc/uptime"-counter got over the
> ridge and the machine now has an uptime of 550 days, but /proc/uptime
> speaks of 550-497=53 days.
> 
> I also postet a patch against this effect, but this does only cosmetic
> and no major changes to other things like "jiffies".
> 
> If you move HZ to 1000, this moves to 24.855 days, and the
> > 10,000 you want moves it to 2.4855 days which will give problems with at
> > least the cron sub system and probably a lot of others.
> 
> The rollover at my machine (2.2.10) did not do any harm, but that does
> not mean that there will be no negative side-effect.
> 
> Solong..
> Frank.
> 
> --
> Frank Schneider, <SPATZ1@T-ONLINE.DE>.
> Microsoft isn't the answer.
> Microsoft is the question, and the answer is NO.
> ... -.-
