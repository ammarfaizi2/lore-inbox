Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280930AbRKGT0R>; Wed, 7 Nov 2001 14:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280917AbRKGT0C>; Wed, 7 Nov 2001 14:26:02 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9232 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S280930AbRKGTZt>;
	Wed, 7 Nov 2001 14:25:49 -0500
Date: Wed, 7 Nov 2001 20:25:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonas Diemer <diemer@gmx.de>,
        Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
Message-ID: <20011107202546.A1939@suse.cz>
In-Reply-To: <20011107125012.6b1fbdc3.diemer@gmx.de> <E161RcS-0003x8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E161RcS-0003x8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 07, 2001 at 12:15:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 12:15:47PM +0000, Alan Cox wrote:
> > but it seems that the patch was incomplete: The bug is still triggered on my
> > computer using 2.4.14, but the bugfix seems to work whith -ac kernels.
> 
> The first piece is in.
> 
> > you can see what's missing to actually work around the via timer bug. I hope
> > this will go into 2.4.15.
> 
> I don't plan to submit it until the locking fixes for the timer access are
> done and we know the real cause

I'm trying to figure it out (locking, bug workarounds), but its tough:

We have two hw bugs:

1) The VIA 686a bug (happening at least on vt82c686a, possibly also 686b),
where the timer chip sometimes corrupts its programming, not conting
from 11920 down to 0, but from a higher value, presumably 65536. There
is no good workaround known - all we can do is detect it when it happens
and restore the programming. Some ticks are lost irreversibly, though.

2) The Intel Neptune (happening at least on Mercury and Neptune P6
chipsets, but very likely also on newer chipsets, including SiS). The
bug is in the 0x00 (latch) command to the timer chip, which instead of
reading the 16-bit counter into a temporary buffer just selects it to be
read. The subsequent two 8-bit reads read the counter non-atomically,
which can cause a value larger by 256 to be read instead of the correct
one. 

The bug #2 can trigger the test for #1, because the timer is read just
after the timer interrupt happens and thus the value is usually around
11920, which, plus 256 is larger than 11920.

Also, bug #2 isn't correctly worked around in the kernel. There is some
logic to work it around when it'd give too inconsistent results, but
still isn't giving correct results on affected chips.

Furthermore, the i8253 is accessed from more than one place:

timer.c: do_slow_gettimeofday() ... has both workarounds
	 timer_interrupt()      ... only has VIA workaround
apic.c:                         ... only has Neptune workaround
ftape-calibr.c:			... has a crazy workaround for some
				    other hardware bug, bad
				    implementation
gameport.c, analog.c:		... no workarounds present, not
				    too critical
hd.c, ide.c			... no workarounds, bad implementation,
				    #ifdef-ed out.

Only timer.c and apic.c do proper locking.

The locking itself isn't a problem to solve. And it's also not enough to
fix the problems that are seen on SiS and other newer chipsets - most of
the users don't use gameport/analog/ftape, and thus have the locking
correct.

The problem is how to work around the bugs 1) and 2) reliably and
without too much performance impact. I haven't found a feasible way to
do that yet.

Best would be to forget about the i8253 reading altogether and use some
other means of doing gettimeofday and timex et cetera, if there is any
present (RTC, TSC, whatever) ...

-- 
Vojtech Pavlik
SuSE Labs
