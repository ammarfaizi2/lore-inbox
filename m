Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWAPUm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWAPUm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAPUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:42:29 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:147 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751173AbWAPUm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:42:28 -0500
Date: Mon, 16 Jan 2006 21:40:58 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060116204057.GC3639@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111184027.GB4735@inferi.kami.home> <20060112220825.GA3490@inferi.kami.home> <1137108362.2890.141.camel@cog.beaverton.ibm.com> <20060114120816.GA3554@inferi.kami.home> <1137442582.27699.12.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137442582.27699.12.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-mm4-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 12:16:21PM -0800, john stultz wrote:
> On Sat, 2006-01-14 at 13:08 +0100, Mattia Dongili wrote:
> > On Thu, Jan 12, 2006 at 03:26:01PM -0800, john stultz wrote:
[...]
> > > Few things to try (independently):
> > > 1. Does booting w/ idle=poll change the behavior?
> > 
> > yes, no more stalls
> 
> Ok, this points to the TSC is changing frequency (likely due to C3
> halting). 

humm... no C3 state here :) did you mean this C3?
# cat /proc/acpi/processor/CPU0/power
active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00007790]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[010] usage[02310093]

> > > 2. Does booting w/ clocksource=jiffies change the behavior?
> > 
> > yes, same as above
> 
> Ok, good, interrupts are getting there at the right frequency.
> 
> > > 3. After booting up, run: 
> > >    echo tsc > /sys/devices/system/clocksource/clocksource0/current_clocksource
> > >    And check that the system keeps accurate time.
> > 
> > didn't try as there seems to be no problem in timekeeping
> 
> Well, it would have re-inforced the TSC being the issue, but I'm fairly
> confident that that is the case.

Now that filesystem problems have gone I have longer uptimes. OhOhOh,
very funnny, echoing tsc into the mentioned sysfs entry makes the clock
almost completely stop:
# date
Mon Jan 16 21:29:26 CET 2006
now count with me 1..2..3..4..5
# date
Mon Jan 16 21:29:27 CET 2006

I'd say the time is far from being accurate.

> My theory: The stalls are due to the TSC frequency not being consistent
> for the small window at boot between when it is installed and when the
> ACPI PM clocksource is installed.

seems you're right, issuing a 'sleep 1' takes ages before it returns and
it's exactely where the boot process got stuck.

> I'll try to narrow that window down a bit and see if that doesn't
> resolve the issue.

I'll be happy to test new patches if necessary (I'm running -mm4)

-- 
mattia
:wq!
