Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755087AbWKMPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbWKMPFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbWKMPFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:05:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55258 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754879AbWKMPFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:05:12 -0500
Date: Mon, 13 Nov 2006 16:04:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113150415.GA20321@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611131008.37810.ak@suse.de> <20061113140520.GA8111@elte.hu> <200611131529.46464.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131529.46464.ak@suse.de>
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

> On the two CPU case it is basically always the same anyways because 
> the loop is very cheap compared to the IPIs (IPIs tend to be thousands 
> of cycles). [...]

the basic thing that you are missing is that some of the most important 
IPI deliveries are /asynchronous/! For those it does not matter at all 
that the IPI delivery itself might be thousands of cycles ... 
Programming the IPI itself is cheap.

> for_each_cpu_mask is essentially just BSF with some glue.

yes - it's a minimum of 2 BSF scans, and that isnt exactly the cheapest 
of instructions. It should be tens of cycles or more, combined with the 
nonzero cost of passing a cpumask (which is 32 bytes) into the function 
by value ...

and your argument again, is to hide a hotplug bug via extra cost (and by 
causing additional regressions) and not fix the hotplug bug? Your 
position makes no sense to me.

> For the > 2 CPU case it is not that obvious -- in theory the hardware 
> could optimize it to be more efficient, but it doesn't seem to. Or at 
> least not in a good enough way to show significant differences.

how did you measure it?

> > you are still not getting it i think. The IO-APIC is still in 
> > logical delivery mode on small systems,
> 
> The IO-APIC delivery mode that is configured comes from genapic, and 
> should be physical for physflat unless I'm totally confused about the 
> code.

indeed, you are right. Btw., this is another change to io_apic.c that i 
would never have ACKed ;-) This whole thing is hidden via something that 
looks like a macro value:

                entry.delivery_mode = INT_DELIVERY_MODE;

but is defined behind the curtain as:

		#define INT_DELIVERY_MODE (genapic->int_delivery_mode)

same goes for TARGET_CPUS:

		#define TARGET_CPUS   (genapic->target_cpus())

ugh!

physical delivery is bad on the IO-APIC anyway - today LowestPrio 
delivery mode works again and the hardware can help us. In physical mode 
there's no LowestPrio delivery mode...

> > the right solution is to use pure physical mode (both local APIC and 
> > IO-APIC) only on large systems, and to use pure logical mode on 
> > small systems - maybe with the combination of clustered mode as 
> > well.
> 
> I disagree.  I think we should just use physical mode everywhere, 
> except on the old i386 systems.

you are risking the introduction of the kind of regressions that i'm 
seeing on my box: that physical delivery mystically doesnt work 
occasionally. AFAIK Windows defaults to logical APIC delivery too on 
small systems. (it in fact uses the TPR IIRC which can only work with 
logical delivery)

So your suggestion would put us up to use an uncommon (and more 
expensive ...) mode of IPI delivery - instead of limiting that rare 
delivery mode to large SMP systems only ...

and again, please remind me of what you are trying to argue: that we 
should keep the slower and less common delivery mode just to not have to 
fix the hotplug bug?

	Ingo
