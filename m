Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752093AbWCGKub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbWCGKub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWCGKub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:50:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:48547 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752093AbWCGKub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:50:31 -0500
X-Authenticated: #14349625
Subject: p4_clockmod weirdness
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 11:50:56 +0100
Message-Id: <1141728656.7951.44.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I recently found that recalc_task_prio() is being called with now <
p->timestamp on my system.  The debug code below leads to the output
below that.  This only happens if the kernel for my single P4 system is
compiled SMP, which seems strange, because traces showed that tasks were
not migrating back and forth between the real CPU and it's retarded
little brother (ergo unlikely to be synchronization between multiple
counters which may or may not even exist in a single p4;).  It seemed to
me that if power saving frequency switching (which I know zero about) is
causing this, the same thing should happen whether compiled as UP or
SMP.

if (unlikely(now < p->timestamp)) {
	unsigned long long clock = sched_clock();
	unsigned long long warp;

	warp = clock - now;
	__sleep_time = 0ULL;
	if (jiffies > INITIAL_JIFFIES + 60000) // only to improve survivability
		printk(KERN_ERR "%s:%d now:%Lu stamp:%Lu clock:%Lu warp:%Lu\n",
		p->comm, p->pid, now, p->timestamp, clock, warp);
}

konsole:7630 now:168775258387 stamp:168775259360 clock:168775262028 warp:3641
konsole:7630 now:169439733481 stamp:169439734665 clock:169439737077 warp:3596
konsole:7630 now:169598589224 stamp:169598590376 clock:169598592795 warp:3571
konsole:7630 now:169756488313 stamp:169756489545 clock:169756491846 warp:3533
konsole:7630 now:170187200934 stamp:170187201938 clock:170187204705 warp:3771
X:6907 now:171350486801 stamp:171350487465 clock:171350490314 warp:3513
konsole:7630 now:171361246237 stamp:171361247379 clock:171361249920 warp:3683
konsole:7630 now:171558121226 stamp:171558122502 clock:171558124855 warp:3629
konsole:7630 now:171950822632 stamp:171950823914 clock:171950826323 warp:3691

Tinkering with this problem, I noticed a correlation.  p4_clockmod
gripes loudly and bales for half of my CPU, namely the real half.  It's
happy with the sibling, and enables scaling in SMP mode only for the
sibling. In UP, it of course just bales.  SMP mode, half-assed frequency
scaling and problem.  UP mode, no frequency scaling, and no problem.
However, the problem is there in SMP mode whether I load p4_clockmod or
not, or have it compiled in or not.

cpufreq-core: trying to register driver p4-clockmod
cpufreq-core: adding CPU 0
p4-clockmod: has errata -- disabling frequencies lower than 2ghz
speedstep-lib: x86: f, model: 2
speedstep-lib: ebx value is 9, x86_mask is 9
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xf12000f 0x0
speedstep-lib: P4 - FSB 200000 kHz; Multiplier 15; Speed 3000000 kHz
freq-table: setting show_table for cpu 0 to f8d18720
freq-table: table entry 0 is invalid, skipping
freq-table: table entry 1 is invalid, skipping
freq-table: table entry 2 is invalid, skipping
freq-table: table entry 3 is invalid, skipping
freq-table: table entry 4 is invalid, skipping
freq-table: table entry 5 is invalid, skipping
freq-table: table entry 6 is invalid, skipping
freq-table: table entry 7 is invalid, skipping
freq-table: table entry 8 is invalid, skipping
cpufreq-core: initialization failed
cpufreq-core: adding CPU 1
p4-clockmod: has errata -- disabling frequencies lower than 2ghz
speedstep-lib: x86: f, model: 2
speedstep-lib: ebx value is 9, x86_mask is 9
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xf12000f 0x0
speedstep-lib: P4 - FSB 200000 kHz; Multiplier 15; Speed 3000000 kHz
freq-table: setting show_table for cpu 1 to f8d18720
freq-table: table entry 0 is invalid, skipping
freq-table: table entry 1: 375000 kHz, 1 index
freq-table: table entry 2: 750000 kHz, 2 index
freq-table: table entry 3: 1125000 kHz, 3 index
freq-table: table entry 4: 1500000 kHz, 4 index
freq-table: table entry 5: 1875000 kHz, 5 index
freq-table: table entry 6: 2250000 kHz, 6 index
freq-table: table entry 7: 2625000 kHz, 7 index
freq-table: table entry 8: 3000000 kHz, 8 index
cpufreq-core: setting new policy for CPU 1: 375000 - 3000000 kHz
freq-table: request for verification of policy (375000 - 3000000 kHz) for cpu 1
freq-table: verification lead to (375000 - 3000000 kHz) for cpu 1
freq-table: request for verification of policy (375000 - 3000000 kHz) for cpu 1
freq-table: verification lead to (375000 - 3000000 kHz) for cpu 1
cpufreq-core: new min and max freqs are 375000 - 3000000 kHz
cpufreq-core: governor switch
cpufreq-core: __cpufreq_governor for CPU 1, event 1
performance: setting to 3000000 kHz because of event 1
cpufreq-core: target for CPU 1: 3000000 kHz, relation 1
freq-table: request for target 3000000 kHz (relation: 1) for cpu 1
freq-table: target is 8 (3000000 kHz, 8)
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 1, event 3
performance: setting to 3000000 kHz because of event 3
cpufreq-core: target for CPU 1: 3000000 kHz, relation 1
freq-table: request for target 3000000 kHz (relation: 1) for cpu 1
freq-table: target is 8 (3000000 kHz, 8)
cpufreq-core: initialization complete
cpufreq-core: driver p4-clockmod up and running
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
whoami:7818 now:173037394175 stamp:173037394416 clock:173037397434 warp:3259
konsole:7630 now:173056342791 stamp:173056343848 clock:173056346553 warp:3762
konsole:7630 now:176252452790 stamp:176252453850 clock:176252456318 warp:3528
konsole:7630 now:176566223402 stamp:176566224535 clock:176566227049 warp:3647
konsole:7630 now:176605227603 stamp:176605228789 clock:176605231297 warp:3694
konsole:7630 now:177233688054 stamp:177233689160 clock:177233691714 warp:3660
konsole:7630 now:177353592995 stamp:177353594229 clock:177353596643 warp:3648
konsole:7630 now:179585880188 stamp:179585881413 clock:179585883863 warp:3675
konsole:7630 now:179938657279 stamp:179938658134 clock:179938660897 warp:3618
konsole:7630 now:180177457448 stamp:180177458753 clock:180177461266 warp:3818

	-Mike

