Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319068AbSH2CG5>; Wed, 28 Aug 2002 22:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319070AbSH2CG5>; Wed, 28 Aug 2002 22:06:57 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:18353 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S319068AbSH2CGz>;
	Wed, 28 Aug 2002 22:06:55 -0400
Date: Thu, 29 Aug 2002 12:11:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Frank.Otto@tc.pci.uni-heidelberg.de
Cc: linux-kernel@vger.kernel.org, mdheffner@yahoo.com
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
Message-Id: <20020829121103.48b5920d.sfr@canb.auug.org.au>
In-Reply-To: <200208281504.g7SF4Xl04292@goedel.pci.uni-heidelberg.de>
References: <20020826170037.69164.qmail@web40210.mail.yahoo.com>
	<1030381725.1750.10.camel@irongate.swansea.linux.org.uk>
	<200208281504.g7SF4Xl04292@goedel.pci.uni-heidelberg.de>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Wed, 28 Aug 2002 17:04:33 +0200 Frank.Otto@tc.pci.uni-heidelberg.de wrote:
>
> Alan Cox wrote:
> > On Mon, 2002-08-26 at 18:00, mike heffner wrote:
> > > Well, isn't that a nice feature.  Is there a
> > > workaround for this hardware?
> >  
> >  A thinkpad ;)
> 
> Unfortunately, that's not true -- I just got an IBM Thinkpad R32
> which exhibits the same behaviour as Mike's Dell Inspiron 8100,
> it's only a tad worse. When I have the battstat_applet running (which
> checks the battery every second), kernel time runs about 3% slow
> compared to the RTC (which seems to be half-way accurate on my machine).

Don't do that then.  Why would you need to check the battery status
every second?  Check every 30 seconds.  Does your battery even update its
status more often than that?

> The cause seems to be definitely APM. If I shut off battstat_applet
> and apmd, kernel time and RTC are in sync. With only apmd, I lose about
> 15 seconds per hour. With battstat_applet, I lose 2 minutes per hour.
> With
>   while true; do cat /proc/apm >/dev/null; done
> the system runs at about 1/4 of the right speed. Using a kernel with ACPI
> eliminates the problem (of course, you lose almost all power management
> functionality too).

Interesting ... Howlong does "cat /proc/apm" take?
On my Thinkpad T22 I get:

# time cat /proc/apm
1.16 1.2 0x03 0x01 0x00 0x01 99% -1 ?

real	0m0.009s
user	0m0.000s
sys	0m0.010s

while ...

# time ./tppow
Battery 0 present power units mW[h] design capacity 38880 last full charge capacity 29260
status 0x0 rate 0 cap 29172 voltage 12485

real	0m0.311s
user	0m0.100s
sys	0m0.000s

tppow is a C implementation of the disassembled APCI method for reading the
battery status. It does not disable interrupts but does talk to the
embedded controller in the Thinkpad.

> BTW, I have set CONFIG_APM_ALLOW_INT, and on startup the kernel even says
> "IBM machine detected. Enabling interrupts during APM calls." Doesn't
> seem to help, though.

This just means that we enter the BIOS with interrupts enabled, it doesn't
stop the BIOS from disabling interrupts ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
