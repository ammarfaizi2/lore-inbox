Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUILQG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUILQG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUILQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:06:56 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60608 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268294AbUILQGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:06:21 -0400
Date: Sun, 12 Sep 2004 12:10:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Yielding processor resources during lock contention
In-Reply-To: <20040912074904.GA7777@elte.hu>
Message-ID: <Pine.LNX.4.53.0409121157110.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040912074904.GA7777@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Sun, 12 Sep 2004, Ingo Molnar wrote:

> it is not clear from the Intel documentation how well MONITOR+MWAIT
> works on SMP. It seems to be targeted towards hyperthreaded CPUs - where
> i suspect it's much easier to monitor the stream of stores done to an
> address.

Indeed, Linus also pointed out how lax the documentation on usage and 
effects of these opcodes.

> one good thing to do would be to test the behavior and count cycles - it
> is possible to set up the 'wrong' caching case that can potentially lead
> to indefinite delays in mwait. If it turns out to work the expected way
> then it would be nice to use. (The deep-sleep worries are not a too big
> issue for latency-sensitive users as deep sleep can already occur via
> the idle loop so it has to be turned off / tuned anyway.)
> 
> but unless the SMP case is guaranteed to work in a time-deterministic
> way i dont think this patch can be added :-( It's not just the question
> of high latencies, it's the question of fundamental correctness: with
> large enough caches there is no guarantee that a CPU will _ever_ flush a
> dirty cacheline to RAM.

The suggested usage of monitor/mwait avoids that scenario, the recommended 
usage being;

while (*addr != condition) {
	monitor(addr)
	if (*addr != condition)
		mwait();
}

This method is used because you can receive spurious wakeups from mwait. 
Like 'hlt' an interrupt, NMI, SMI etc will cause the processor to continue 
executing the next instruction after mwait. The extended sleep state 
however could occur if interrupts are disabled which isn't the case with 
the current users. So there is a sense of time deterministic behaviour 
with an operating system which uses a periodic timer tick for example. But 
regardless of that, i also think this requires further clarification with 
respect to side effects and benchmarking with current hardware.

Thanks,
	Zwane
