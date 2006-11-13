Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755180AbWKMQdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbWKMQdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbWKMQdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:33:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20621 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755180AbWKMQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:33:43 -0500
Date: Mon, 13 Nov 2006 17:32:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113163216.GA3480@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131710.13285.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > > (IPIs tend to be thousands of cycles). [...]
> >
> > Programming the IPI itself is cheap.
> 
> yep, that is why physical mode doesn't hurt much.

and that is why your argument of thousands of cycles per IPI 'cost', in 
comparison to which any other cost is miniscule, was misleading IMO.

> > > for_each_cpu_mask is essentially just BSF with some glue.
> > 
> > yes - it's a minimum of 2 BSF scans, and that isnt exactly the cheapest 
> > of instructions. It should be tens of cycles or more, combined with the 
> > nonzero cost of passing a cpumask (which is 32 bytes) into the function 
> > by value ...
> 
> Sorry, but everytime IPIs and all the other overhead etc. are involved 
> even 10 BSFs would be completely in the noise.  The relative cost is 
> so much smaller. I think you're barking up the wrong tree here 
> regarding that loop.

i'm puzzled, you just confirmed above what i said before, that 
programming the IPI is cheap... If something is cheap then other costs 
added to (such as cpu-mask scanning, and passing around the cpumask) 
definitely do matter.

> There are surely inefficiencies in the code, but I don't think they're 
> related to cpu loops.

it's the death by thousands of small cuts ...

> [BTW the code for the cpu loop is much worse than it could be [1], but 
> that's a different story. But even with the worse code it doesn't 
> matter much]

so by your argument nothing matters, as long as it's just a small cost?? 
My guesstimation is that the cost is a few dozen cycles per IPI.

> > and your argument again, is to hide a hotplug bug
> 
> I don't think it's a bug -- it's inherent.

please explain.

> > indeed, you are right. Btw., this is another change to io_apic.c that i 
> > would never have ACKed ;-) This whole thing is hidden via something that 
> > looks like a macro value:
> 
> Yes agreed the magic macros are ugly. It has historical reasons from 
> i386 (and I'm partly to blame). Essentially it comes out of the mess 
> that i386 subarchs are and when moving genapic to x86-64 that 
> particular ugliness wasn't cleaned up.

yes. It comes out of tacking a feature ontop of a messy codebase (which 
got messy partly because other, similar features like subarch ioapic 
code was not done in conjunction with the necessary cleanup) - this 
mirrors the mess that is in the time code currently. Mess like that is 
just like the overhead of small featurities - it only shows up in a 
noticeable way if piled together.

> > physical delivery is bad on the IO-APIC anyway - today LowestPrio 
> > delivery mode works again and the hardware can help us.
> 
> Help us with what exactly?

logical flat APIC mode defaults to dest_LowestPrio - this delivery mode 
allows the hardware (the chipset) to optimize IRQ routing. This is only 
available in logical delivery mode, because the 'target CPU range' there 
is an APIC ID mask, inherently.

the hardware might know details like 'is a target core in lowpower mode' 
and redirect IRQs accordingly. We could do the same from the kernel only 
via expensive irq-redirection of IO-APIC entries.

> > you are risking the introduction of the kind of regressions that i'm 
> > seeing on my box: that physical delivery mystically doesnt work 
> > occasionally. AFAIK Windows defaults to logical APIC delivery too on 
> > small systems. (it in fact uses the TPR IIRC which can only work 
> > with logical delivery)
> 
> Yes that's a real risk.

it's an unknown risk against the supposedly-known risk of the 
hotplug-CPU breakage. We should pick known risks, obviously.

> > So your suggestion would put us up to use an uncommon (and more 
> > expensive ...) mode of IPI delivery - instead of limiting that rare 
> > delivery mode to large SMP systems only ...
> > 
> > and again, please remind me of what you are trying to argue: that we 
> > should keep the slower and less common delivery mode just to not 
> > have to fix the hotplug bug?
> 
> Ok assuming temporarily it's a bug, how would you want to fix it?

for that i'd have to know the bug, and this is the third time i'm asking 
about specifics :-) (The URL that was given in the thread was about a 
chipset bug regarding incompatibility with clustered-APIC mode - my 
patch in fact - because it switches small systems to use logical flat 
mode always - solves that kind of regression too.)

	Ingo
