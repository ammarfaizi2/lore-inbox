Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWDDMC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWDDMC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 08:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWDDMCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 08:02:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58305 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932376AbWDDMCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 08:02:25 -0400
Date: Tue, 4 Apr 2006 14:00:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10
Message-ID: <20060404120003.GA15847@elte.hu>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk> <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk> <20060326233530.GA22496@elte.hu> <Pine.LNX.4.58.0603281142410.17504@apollon> <20060328204944.GA1217@elte.hu> <Pine.LNX.4.61.0604041344000.15050@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604041344000.15050@openx3.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Simon Derr <Simon.Derr@bull.net> wrote:

> On Tue, 28 Mar 2006, Ingo Molnar wrote:
> 
> > 
> > * Simon Derr <simon.derr@bull.net> wrote:
> > 
> > > On Mon, 27 Mar 2006, Ingo Molnar wrote:
> > > 
> > > > i've released -rt10
> > > 
> > > Is anyone working on a port of this patch to the IA64 architecture ?
> > 
> > not that i know of. If someone wants to do that, take a look at the 
> > x86_64 changes (or ppc/mips/i386 changes) to get an idea. These are the 
> > rough steps needed:
> > [snip]
> 
> 
> Work in progress... (based on -rt11)
> So far I have a kernel that almost boots, but not quite.
> 
> First issue: 'BUG: udev:45 task might have lost a preemption check!'
> 
> When looking at the code in preempt_enable_no_resched(), why is the 
> value of preempt_count() checked to be non-zero _after_ calling 
> dec_preempt_count() ?
> 
> I saw several posts on this list claiming that this message is 
> harmless, but I'd like to figure what's going on.

the warning means that doing a preempt_enable_no_resched() while being 
in a preemptible section is most likely a bug, and that you could lose a 
need_resched() check. (and introduce a scheduling latency) What's the 
backtrace? This could be the sign of a not fully/correctly converted 
arch/*/kernel/process.c (but i'm only guessing here).

> My boot process is stuck later when insmod loads the driver for the 
> MPT Fusion SCSI adapter. It's waiting for a second interrupt to 
> arrive, and that never happens.
> 
> I see that the -rt patch touches many drivers by changing calls to 
> local_irq_save (and friends), changing the type of the semaphores, but 
> the MPT driver makes no use of these.
> 
> Any ideas ?

you should first check the PREEMPT_NONE kernel with PREEMPT_SOFTIRQS and 
PREEMPT_HARDIRQS enabled. I.e. first check whether IRQ threading works.  
Then enable all the other PREEMPT options one by one: PREEMPT_DESKTOP, 
PREEMPT_RCU, PREEMPT_BKL. Only when all these work switch to PREEMPT_RT.

	Ingo
