Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269810AbVBFCft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269810AbVBFCft (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 21:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269848AbVBFCft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 21:35:49 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:41384 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269810AbVBFCf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 21:35:27 -0500
Date: Sat, 5 Feb 2005 18:33:44 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206023344.GA15853@atomide.com>
References: <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205230017.GA1070@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050205 15:08]:
> Hi!
> 
> > > > > It could also be that the reprogamming of PIT timer does not work on
> > > > > your machine. I chopped off the udelays there... Can you try
> > > > > something like this:
> > > > 
> > > > I added the udelays, but behaviour did not change.
> > > 
> > > Yeah, and if the first patch was working better, that means the PIT
> > > interrupts work. I'll do another version of the patch where PIT
> > > interrupts work again without local APIC needed, let's see what
> > > happens with that.
> > 
> > I think something broke TSC timer after the first patch, but I could
> > not figure out yet what. So the bad combo might be local APIC + TSC.
> > At least I'm seeing similar problems with local APIC + TSC timer.
> > 
> > Attached is a slightly improved patch, but the patch does not fix
> > the TSC problem. It just fixes compile without local APIC, and
> > booting SMP kernel on uniprocessor machine.
> > 
> > Currently the suggested combo is local APIC + ACPI PM timer...
> 
> Ok, works slightly better: time no longer runs 2x too fast. When TSC
> is used, I get same behaviour  as before ("sleepy machine"). With
> "notsc", machine seems to work okay, but I still get 1000 timer
> interrupts a second.

Sounds like dyn-tick did not get enabled then, maybe you don't have
CONFIG_X86_PM_TIMER, or don't have ACPI PM timer on your board?

After modifying I8042_POLL_PERIOD and leaving out CONFIG_NETFILTER
I'm getting roughly 6HZ timer rate when idle :)

$ dmesg | grep -i "time\|tick\|apic"
ACPI: PM-Timer IO Port: 0x1008
Kernel command line: root=/dev/nfs ip=dhcp ro console=ttyS0,115200
lapic init=/bin/minit
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Using pmtmr for high-res timesource
dyn-tick: Registering dynamic tick timer
per-CPU timeslice cutoff: 365.35 usecs.
task migration cache decay timeout: 1 msecs.
Machine check exception polling timer started.
Real Time Clock Driver v1.12
dyn-tick: Maximum ticks to skip limited to 2678
dyn-tick: Timer using dynamic tick

$ cat /proc/interrupts | grep timer && sleep 10 && cat /proc/interrupts | grep timer
  0:      10689          XT-PIC  timer
  0:      10745          XT-PIC  timer

> > And if that works, changing the I8042_POLL_PERIOD from HZ/20 in
> > drivers/input/serio/i8042.h to something like HZ increases the
> > sleep interval quite a bit. I think I had lots of polling also in
> > CONFIG_NETFILTER, but I haven't verified that.
> 
> Okay, I set POLL_PERIOD to 5*HZ, and disabled USB. Perhaps it will
> sleep better now?

Sounds like your system is not running with the dyn-tick... I'll try
to fix that TSC bug.

Tony
