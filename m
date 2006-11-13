Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754665AbWKMOGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWKMOGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbWKMOGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:06:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37776 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754665AbWKMOGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:06:51 -0500
Date: Mon, 13 Nov 2006 15:05:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113140520.GA8111@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611130332.07569.ak@suse.de> <20061113081616.GA25604@elte.hu> <200611131008.37810.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131008.37810.ak@suse.de>
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

> > Had i ever noticed this hack in the first place i would have NAK-ed 
> > it. There is a fundamental design friction of a high-level feature 
> > like HOTPLUG_CPU /requiring/ a fundamental change to the lowlevel 
> > IRQ delivery mode!
> 
> Well to be honest masked mode isn't that useful anyways. It's only 
> theoretical advantage would be a bit more performance for multicast 
> IPIs, but Ashok did benchmarks and it didn't make any significant 
> difference. [...]

this argument is false for at least two reasons. Firstly, i can show you 
a 1000 small changes that wont be measurable individually but that as a 
summary effect can degrade the kernel substantially.

Secondly, in the physical case, /all/ IPI sending goes through this 
code:

        for_each_cpu_mask(query_cpu, mask) {

yes, even the single-IPI calls which give the overwhelming majority of 
the use of IPIs. Even on systems that have only 2 CPUs to begin with. 
This should be measurable.

> [...] With that I prefer to use always the same mode for small and 
> large systems. Ok should probably drop the ifdef and just always use 
> physical mode.

you are still not getting it i think. The IO-APIC is still in logical 
delivery mode on small systems, and we very much make use of this fact 
by using LowestPrio messages (that current CPUs started to support 
again). The switching to physical mode is dangerous because it creates 
'mixed' APIC messages (physical and logical targeted messages as well) - 
which 'mixed mode' is notorious for erratas both in the CPU and in the 
chipset. (I strongly suspect that my eth timeouts are due to that.) 

Combine this with the fact that /normally/ we default to logical mode, 
the basis of your position is quite puzzling to me.

the right solution is to use pure physical mode (both local APIC and 
IO-APIC) only on large systems, and to use pure logical mode on small 
systems - maybe with the combination of clustered mode as well.

and that's precisely what my patch achieves ...

> > Such a requirement is broken and just serves to hide a flaw in the 
> > hotplug design - which flaw would trigger on i386 /anyway/, because 
> > i386 still uses logical delivery mode for APIC IPIs.
> 
> i386 cpu hotplug is somewhat broken anyways, but it should be fixed 
> there too eventually. But some very old chipsets don't seem to support 
> physical properly so it wasn't changed there.

as i said it before, what you are suggesting is not a 'fix', it's a 
workaround for a design flaw in the hotplug code which flaw is hitting 
us in other places and architectures anyway, and which workaround makes 
us use an inferior IRQ delivery method on small systems ...

	Ingo
