Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280498AbRJaUju>; Wed, 31 Oct 2001 15:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280494AbRJaUjl>; Wed, 31 Oct 2001 15:39:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23681 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280493AbRJaUjc>; Wed, 31 Oct 2001 15:39:32 -0500
Date: Wed, 31 Oct 2001 15:39:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gerhard Mack <gmack@innerfire.net>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.10.10110311206020.6571-100000@innerfire.net>
Message-ID: <Pine.LNX.3.95.1011031152022.21553A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Gerhard Mack wrote:

> On Wed, 31 Oct 2001, Richard B. Johnson wrote:
> 
> > On Wed, 31 Oct 2001, Gerhard Mack wrote:
> > 
> > > Why exactly do we use the jiffie count for calculating uptime?  Why not
> > > just record the startup time and compare when needed?
> > > 
> > > 
> > > 	Gerhard
> > > 
> > Because you get it for free. The counter is necessary for time-outs
> > so you need it. If it starts at zero, you get uptime in HZ.
> 
> Yes that I understand and it works right up until the jiffie count wraps.
> But now we have people adding cost to everything else just so we can all
> have good uptime values.  Since AFIK the drivers handle the wrap cleanly
> the only thing that it bothers is the uptime stats.
> 
> Now we have people making jiffies more expensive just to deal with uptime.
> At least as far as I can see it should just be easier/better to make
> uptime use something else.
> 
> Or am I completly off base?
> 
> 
> 	Gerhard

I think that if you just saved time_t (the time() seconds variable,
after the system time has been set, it would be a good win.

Unfortunately, the time gets set either from user-mode via a sys-call,
or initially from CMOS. If the boot time was set during this initial CMOS
setting, it could be very wrong. If it gets set every time the system-call
is executed, it becomes "time since last time the time was set".

A fix exists, though. The existing, possibly wrong, boot time could
be grabbed during the set-time sys-call, the difference between the
existing (wrong) time and the boot time could be calculated, the
new (correct) time could be set, then the boot-time would be changed
to the new correct time, minus the calculated difference. This
would result in a correct boot-time.

	dif_time = time - boot_time;
        time = new_time;
        boot_time = time - dif_time;

Uptime could then be present time minus boot time. No mucking with
timer ticks are required.

BUT, and the big BUT. Demonstration variable 'time' above, isn't
a unique variable. It's derived from jiffies / HZ. So, we are back
to the same problem of 32-bits.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


