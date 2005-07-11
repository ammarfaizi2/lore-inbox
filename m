Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVGKHG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVGKHG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 03:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVGKHG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 03:06:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58560 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261165AbVGKHG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 03:06:58 -0400
Date: Mon, 11 Jul 2005 09:05:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
Message-ID: <20050711070516.GA2238@elte.hu>
References: <42CF05BE.3070908@opersys.com> <20050709071911.GB31100@elte.hu> <42CFEFC9.7070007@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CFEFC9.7070007@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> With ping floods, as with other things, there is room for improvement, 
> but keep in mind that these are standard tests [...]

the problem is that ping -f isnt what it used to be. If you are using a 
recent distribution with an updated ping utility, these days the 
equivalent of 'ping -f' is something like:

	ping -q -l 500 -A -s 10 <target>

and even this variant (and the old variant) needs to be carefully 
validated for actual workload generated. Note that this is true for 
workloads against vanilla kernels too. (Also note that i did not claim 
that the flood ping workload you used is invalid - you have not 
published packet rates or interrupt rates that could help us judge how 
constant the workload was. I only said that according to my measurements 
it's quite unstable, and that you should double-check it.  Just running 
it and ACK-ing that the packet rates are stable and identical amongst 
all of these kernels would be enough to put this concern to rest.)

to see why i think there might be something wrong with the measurement, 
just look at the raw numbers:

 LMbench running times:
 +--------------------+-------+-------+-------+-------+-------+
 | Kernel             | plain | IRQ   | ping  | IRQ & | IRQ & |
 |                    |       | test  | flood | ping  |  hd   |
 +====================+=======+=======+=======+=======+=======+
 | Vanilla-2.6.12     | 152 s | 150 s | 188 s | 185 s | 239 s |
 +====================+=======+=======+=======+=======+=======+
 | with RT-V0.7.51-02 | 152 s | 153 s | 203 s | 201 s | 239 s |
 +====================+=======+=======+=======+=======+=======+

note that both the 'IRQ' and 'IRQ & hd' test involves interrupts, and 
PREEMPT_RT shows overhead within statistical error, but only the 'flood 
ping' workload created a ~8% slowdown.

my own testing (whatever it's worth) shows that during flood-pings, the 
maximum overhead PREEMPT_RT caused was 4%. I.e. PREEMPT_RT used 4% more 
system-time than the vanilla UP kernel when the CPU was 99% dedicated to 
handling ping replies. But in your tests not the full CPU was dedicated 
to flood ping replies (of course). Your above numbers suggest that under 
the vanilla kernel 23% of CPU time was used up by flood pinging.  
(188/152 == +23.6%)

Under PREEMPT_RT, my tentative guesstimation would be that it should go 
from 23.6% to 24.8% - i.e. a 1.2% less CPU time for lmbench - which 
turns into roughly +1 seconds of lmbench wall-clock time slowdown. Not 
15 seconds, like your test suggests. So there's a more than an order of 
magnitude difference in the numbers, which i felt appropriate sharing :)

_And_ your own hd and stable-rate irq workloads suggest that PREEMPT_RT 
and vanilla are very close to each other. Let me repeat the table, with 
only the numbers included where there was no flood pinging going on:

 LMbench running times:
 +--------------------+-------+-------+-------+-------+-------+
 | Kernel             | plain | IRQ   |       |       | IRQ & |
 |                    |       | test  |       |       |  hd   |
 +====================+=======+=======+=======+=======+=======+
 | Vanilla-2.6.12     | 152 s | 150 s |       |       | 239 s |
 +====================+=======+=======+=======+=======+=======+
 | with RT-V0.7.51-02 | 152 s | 153 s |       |       | 239 s |
 +====================+=======+=======+=======+=======+=======+
 | with Ipipe-0.7     | 149 s | 150 s |       |       | 236 s |
 +====================+=======+=======+=======+=======+=======+

these numbers suggest that outside of ping-flooding all IRQ overhead 
results are within statistical error.

So why do your "ping flood" results show such difference? It really is 
just another type of interrupt workload and has nothing special in it.

> but keep in mind that these are standard tests used as-is by others 
> [...]

are you suggesting this is not really a benchmark but a way to test how 
well a particular system withholds against extreme external load?

> For one thing, the heavy fluctuation in ping packets may actually 
> induce a state in the monitored kernel which is more akin to the one 
> we want to measure than if we had a steady flow of packets.

so you can see ping packet flow fluctuations in your tests? Then you 
cannot use those results as any sort of benchmark metric.

under PREEMPT_RT, if you wish to tone down the effects of an interrupt 
source then all you have to do is something like:

 P=$(pidof "IRQ "$(grep eth1 /proc/interrupts | cut -d: -f1 | xargs echo))

 chrt -o -p 0 $P   # net irq thread
 renice -n 19 $P
 chrt -o -p 0 5    # softirq-tx
 renice -n 19 5
 chrt -o -p 0 6    # softirq-rx
 renice -n 19 6

and from this point on you should see zero lmbench overhead from flood 
pinging. Can vanilla or I-PIPE do that?

	Ingo
