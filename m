Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319196AbSH2MVn>; Thu, 29 Aug 2002 08:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319197AbSH2MVn>; Thu, 29 Aug 2002 08:21:43 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:10483 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S319196AbSH2MVm>; Thu, 29 Aug 2002 08:21:42 -0400
Date: Thu, 29 Aug 2002 14:25:52 +0200
From: Frank Otto <Frank.Otto@tc.pci.uni-heidelberg.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, mdheffner@yahoo.com
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
Message-ID: <20020829142552.A8042@goedel.pci.uni-heidelberg.de>
References: <20020826170037.69164.qmail@web40210.mail.yahoo.com> <1030381725.1750.10.camel@irongate.swansea.linux.org.uk> <200208281504.g7SF4Xl04292@goedel.pci.uni-heidelberg.de> <20020829121103.48b5920d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020829121103.48b5920d.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On Thu, Aug 29, 2002 at 12:11:03PM +1000, Stephen Rothwell wrote:
> Hi Frank,
> 
> On Wed, 28 Aug 2002 17:04:33 +0200 Frank.Otto@tc.pci.uni-heidelberg.de wrote:
> > it's only a tad worse. When I have the battstat_applet running (which
> > checks the battery every second), kernel time runs about 3% slow
> > compared to the RTC (which seems to be half-way accurate on my machine).
> 
> Don't do that then.  Why would you need to check the battery status
> every second?  Check every 30 seconds.  Does your battery even update its
> status more often than that?

I know it's stupid to check the battery every second, but frankly,
I haven't found a way to configure this in battstat_applet (of course,
it's possible by fixing the sources). Luckily, there's also battery_applet
for the gnome-panel, which has the same functionality, and additionally
lets you configure the update time. However, it doesn't look so spiffy :)

> > The cause seems to be definitely APM. If I shut off battstat_applet
> > and apmd, kernel time and RTC are in sync. With only apmd, I lose about
> > 15 seconds per hour. With battstat_applet, I lose 2 minutes per hour.
> > With
> >   while true; do cat /proc/apm >/dev/null; done
> > the system runs at about 1/4 of the right speed. Using a kernel with ACPI
> > eliminates the problem (of course, you lose almost all power management
> > functionality too).
> 
> Interesting ... Howlong does "cat /proc/apm" take?
> On my Thinkpad T22 I get:
> 
> # time cat /proc/apm
> 1.16 1.2 0x03 0x01 0x00 0x01 99% -1 ?
> 
> real	0m0.009s
> user	0m0.000s
> sys	0m0.010s

Stupid me hasn't thought of trying this, and I don't have my Thinkpad
right here now. Also -- what method does the `time' command use to measure
the time? It doesn't check the RTC, does it? And if the kernel clock stands
still during the /proc/apm access, `time' couldn't notice that real time
has passed, could it? Anyway, I'll try the `time' method this evening.

> while ...
> 
> # time ./tppow
> Battery 0 present power units mW[h] design capacity 38880 last full charge capacity 29260
> status 0x0 rate 0 cap 29172 voltage 12485
> 
> real	0m0.311s
> user	0m0.100s
> sys	0m0.000s
> 
> tppow is a C implementation of the disassembled APCI method for reading the
> battery status. It does not disable interrupts but does talk to the
> embedded controller in the Thinkpad.

When I built a kernel 2.4.19 with ACPI, I also applied the latest patches from
acpi.sourceforge.net . This gave me /proc/acpi/battery/BAT0/state, reading
from which didn't slow down the kernel clock at all. (Sadly, ACPI doesn't
seem to report any events on my machine, so I'll stick with APM.)

> > BTW, I have set CONFIG_APM_ALLOW_INT, and on startup the kernel even says
> > "IBM machine detected. Enabling interrupts during APM calls." Doesn't
> > seem to help, though.
> 
> This just means that we enter the BIOS with interrupts enabled, it doesn't
> stop the BIOS from disabling interrupts ...

Does this mean that the BIOS is buggy, or does this behaviour still
comply to the APM specifications? Just wondering.

Regards,
Frank
