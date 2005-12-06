Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbVLFAed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbVLFAed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbVLFAed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:34:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21710
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751526AbVLFAec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:32 -0500
Message-Id: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:26 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 00/21] hrtimer - High-resolution timer subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a major rework of the former ktimer subsystem. It replaces the 
ktimer patch series and drops the ktimeout series completely.

A broken out series is available from
http://www.tglx.de/projects/ktimers/patches-2.6.15-rc5-hrtimer.tar.bz2

1. Naming

After the extensive discussions on LKML, Andrew Morton suggested 
"hrtimer" and we picked it up. While the hrtimer subsystem does not 
offer high-resolution clock sources just yet, the subsystem can be 
easily extended with high-resolution clock capabilities. The rework of 
the ktimer-hrt patches is the next step.

2. More simplifications

We worked through the subsystem and its users and further reduced the 
implementation to the basic required infrastructure and generally 
streamlined it. (We did this with easy extensibility for the high 
resolution clock support still in mind, so we kept some small extras 
around.)

The new .text overhead (on x86) we believe speaks for itself:

    text    data     bss     dec     hex filename
 2468380  547212  155164 3170756  3061c4 vmlinux-2.6.15-rc2
 2469996  548016  155164 3173176  306b38 vmlinux-ktimer-rc5-mm1
 2468164  547508  155100 3170772  3061d4 vmlinux-hrtimer

While it was +1616 bytes before, it's -216 bytes now. This also gives a 
new justification for hrtimers: it reduces .text overhead ;-) [ There's 
still some .data overhead, but it's acceptable at 0.1%.]

On 64-bit platforms such as x64 there are even more .text savings:

    text    data     bss     dec     hex filename
 3853431  914316  403880 5171627  4ee9ab vmlinux-x64-2.6.15-rc5
 3852407  914548  403752 5170707  4ee613 vmlinux-x64-hrtimer

(due to the compactness of 64-bit ktime_t ops)

Other 32-bit platforms (arm, ppc) have a much smaller .text 
hrtimers footprint now too.

3. Fixes

The last splitup of ktimers resulted in a bug in the overrun accounting.  
This bug is now fixed and the code verified for correctness.

4. Rounding

We looked at the runtime behaviour of vanilla, ktimers and ptimers to 
figure out the consequences for applications in a more detailed way.

The rounding of time values and intervals leads to rather unpredictible 
results which deviates of the current mainline implementation 
significantly and introduces unpredictible behaviour vs. the timeline.

After reading the Posix specification again, we came to the conclusion 
that it is possible to do no rounding at all for the ktime_t values, and 
to still ensure that the timer is not delivered early.

".. and that timers must wait for the next clock tick after the 
theoretical expiration time, to ensure that a timer never returns too 
soon. Note also that the granularity of the clock may be significantly 
coarser than the resolution of the data format used to set and get time 
and interval values. Also note that some implementations may choose to 
adjust time and/or interval values to exactly match the ticks of the 
underlying clock."

Which allows the already discussed part of the spec to be interpreted 
differently:

"Time values that are between two consecutive non-negative integer 
multiples of the resolution of the specified timer shall be rounded up 
to the larger multiple of the resolution. Quantization error shall not 
cause the timer to expire earlier than the rounded time value."

The rounding of the time value i.e. the expiry time itself must be
rounded to the next clock tick, to ensure that a timer never expires
early.

	Thomas, Ingo

--

