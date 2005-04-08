Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVDHLe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVDHLe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVDHLea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:34:30 -0400
Received: from mx1.suse.de ([195.135.220.2]:37805 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262734AbVDHLeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:34:15 -0400
Message-ID: <42566C22.4040509@suse.de>
Date: Fri, 08 Apr 2005 13:33:54 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com>
In-Reply-To: <42564584.4080606@tuxrocks.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> Tony Lindgren wrote:
> | * Tony Lindgren <tony@atomide.com> [050407 23:28]:
> |
> |>I think I have an idea on what's going on; Your system does not wake to
> |>APIC interrupt, and the system timer updates time only on other
> interrupts.
> |>I'm experiencing the same on a loaner ThinkPad T30.
> |>
> |>I'll try to do another patch today. Meanwhile it now should work
> |>without lapic in cmdline.
> |
> |
> | Following is an updated patch. Anybody having trouble, please try
> | disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.
> |
> | I'm hoping this might work on Pavel's machine too?
> |
> | Tony
> 
> This updated patch seems to work just fine on my machine with lapic on
> the cmdline and CONFIG_DYN_TICK_USE_APIC disabled.
> 
> Also, you were correct that removing lapic from the cmdline allowed the
> previous version to run at full speed.
> 
> Now, how can I tell if the patch is doing its thing?  What should I be
> seeing? :)
> 
> Functionally, it looks like it's working.  There were a number of
> compiler warnings you might wish to fix before calling it good.  Such as
> "initialization from incompatible pointer type" several times in
> dyn-tick-timer.c and a "too many arguments for format" in
> dyn_tick_late_init.
> 

Here are some figures about idle/C-states:

Passing bm_history=0xF to processor module makes it going into C3 and deeper.
Passing lower values, deeper states are reached more often, but system could freeze:

bm_activity=0x4
bus master activity:     fefffffd
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00007183]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[00000515]
    C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[00000330]

bm_activity=0x1
bus master activity:     ffff7ffd
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00005495]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[00000537]
    C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[00000472]


Figures NO_IDLE_HZ disabled, HZ=1000 (max sleep 1ms)
(Don't trust the figures too much, there probably are little bugs...):

Active C0/C1 state:
Total(ms):    145
Usage:        20205
Failures:     0
Maximum(us):  1967
Average(us):  7
Sleep  C2 state:
Total(ms):    19306
Usage:        20074
Failures:     0
Maximum(us):  1275            (-> strange max should be 1000us)
Average(us):  961
Sleep  C3 state:
Total(ms):    34
Usage:        131
Failures:     0
Maximum(us):  984
Average(us):  259
Measures based on ACPI PM timer reads

Total switches between C-states:  20205
Switches between C-states per second:  1063 per second
Total measure time (s):  19
Total measure time (based on starting measures) (s):  20


Figures NO_IDLE_HZ enabled, processor.bm_history=0xF HZ=1000:
(Don't trust the figures too much, there probably are little bugs...):

Active C0/C1 state:
Total(ms):    81
Usage:        4659
Failures:     0
Maximum(us):  1608
Average(us):  17
Sleep  C2 state:
Total(ms):    71108
Usage:        4241
Failures:     0
Maximum(us):  49921
Average(us):  16766
Sleep  C3 state:
Total(ms):    219
Usage:        167
Failures:     0
Maximum(us):  28296
Average(us):  1311
Sleep  C4 state:
Total(ms):    374
Usage:        251
Failures:     0
Maximum(us):  18870
Average(us):  1490
Measures based on ACPI PM timer reads

Total switches between C-states:  4659
Switches between C-states per second:  65 per second
Total measure time (s):  71
Total measure time (based on starting measures) (s):  75


I buffer C-state times in an array and write them to /dev/cstX.
>From there I calc the stats from userspace.

Tony: If you like I can send you the patch and dump prog for
http://www.muru.com/linux/dyntick/ ?

I try to find a better algorithm (directly adjust slept time to
C-state latency or something) for NO_IDLE_HZ (hints are very welcome)
and try to come up with new figures soon.


         Thomas
