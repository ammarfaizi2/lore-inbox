Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293688AbSCPDPa>; Fri, 15 Mar 2002 22:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSCPDPL>; Fri, 15 Mar 2002 22:15:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47854 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S293688AbSCPDPD>;
	Fri, 15 Mar 2002 22:15:03 -0500
Message-ID: <3C92B126.852DC838@mvista.com>
Date: Fri, 15 Mar 2002 18:42:46 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [QUESTION] Micro-Second timers in kernel ?
In-Reply-To: <20020315164845.A15889@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 
>         Hi,
> 
>         I'm wondering what is the lowest resolution of timers that can
> be get in Linux across all platforms. The goal : I need to do
> microsecond resolution delay in the hard_xmit function of the IrDA-USB
> driver, and don't want to just grab the CPU.
> 
>         The function sys_nanosleep() seems to indicate that under 2ms,
> we should not even bother using a timer. Well, on a modern CPU, 2ms is
> a very long time (on the other hand, it seems OK for PDAs).
>         The definition of "tick" in timer.c indicate that the timer_bh
> is called at a maximum of HZ time per second (which is consistent with
> the definition of jiffies). On i386, this would be one tick every
> 10ms.
>         Well... I'm stuck. 10ms is a very long time at 4Mb/s. So, I
> guess I'll continue to busy wait before sending each packet. Ugh !
> 
The overhead to do a timer is on the order of at least 100 us on an
800MHZ machine.  Given this, a timer/ interrupt based delay for less
than 100 us is probably a bad idea.

Still, times in this range and up are available in the high-res-timers
patch, BUT, while the patch makes a stab at providing POSIX timers for
all "arch"s the high-res part depends on the hardware and thus is
different for each platform.  Even for the x86 there are two versions
(three if you want to work with a machine that does not have a TSC).  

The upshot of this is that high-res timers will be available on some
platforms soon but it will take some time to find them on all platforms.

That said, there are a few kernel issues that need to be ironed out. 
Here are a couple:

1.) What interface(s) would you like to see in the kernel.
2.) Is there a standard compliant way to extend high-res to the user
APIs that currently, implicitly reference CLOCK_REALTIME.  The issue
here is:

CLOCK_REALTIME is rather firmly locked on to 1/HZ resolution.
The select() API (to give just one example) does not specify a CLOCK and
so implicitly uses CLOCK_REALTIME.


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
