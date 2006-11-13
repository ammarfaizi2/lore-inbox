Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755190AbWKMQK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbWKMQK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbWKMQK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:10:26 -0500
Received: from ns2.suse.de ([195.135.220.15]:18639 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755190AbWKMQKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:10:24 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Date: Mon, 13 Nov 2006 17:10:13 +0100
User-Agent: KMail/1.9.5
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu>
In-Reply-To: <20061113150415.GA20321@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131710.13285.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Programming the IPI itself is cheap.

yep, that is why physical mode doesn't hurt much.
 
> > for_each_cpu_mask is essentially just BSF with some glue.
> 
> yes - it's a minimum of 2 BSF scans, and that isnt exactly the cheapest 
> of instructions. It should be tens of cycles or more, combined with the 
> nonzero cost of passing a cpumask (which is 32 bytes) into the function 
> by value ...

Sorry, but everytime IPIs and all the other overhead etc. are involved even 10 BSFs 
would be completely  in the noise.  The relative cost is so much smaller.
I think you're barking up the wrong tree here regarding that loop.

There are surely inefficiencies in the code, but I don't think they're
related to cpu loops.

[BTW the code for the cpu loop is much worse than it could be [1], but 
that's a different story. But even with the worse code it doesn't matter much]

[1] I had an optimization patch for find_next_bit for that case once but gcc
didn't like it and fixing it completely (= getting rid of the bogus 
additional test) would require auditing all architectures. I didn't push
it very hard because I didn't have much evidence it is really performance
critical -- compared to cache misses and locks it is all small fries.

> 
> and your argument again, is to hide a hotplug bug 

I don't think it's a bug -- it's inherent.

> indeed, you are right. Btw., this is another change to io_apic.c that i 
> would never have ACKed ;-) This whole thing is hidden via something that 
> looks like a macro value:

Yes agreed the magic macros are ugly. It has historical reasons from i386 (and I'm 
partly to blame). Essentially it comes out of the mess that i386 subarchs 
are and when moving genapic to x86-64 that particular ugliness wasn't cleaned up.

> physical delivery is bad on the IO-APIC anyway - today LowestPrio 
> delivery mode works again and the hardware can help us. 

Help us with what exactly?

> you are risking the introduction of the kind of regressions that i'm 
> seeing on my box: that physical delivery mystically doesnt work 
> occasionally. AFAIK Windows defaults to logical APIC delivery too on 
> small systems. (it in fact uses the TPR IIRC which can only work with 
> logical delivery)

Yes that's a real risk.

Probably need a solution for your chipset. But currently as proposed by you it 
would be robbing Peter to pay Paul.

> So your suggestion would put us up to use an uncommon (and more 
> expensive ...) mode of IPI delivery - instead of limiting that rare 
> delivery mode to large SMP systems only ...
> 
> and again, please remind me of what you are trying to argue: that we 
> should keep the slower and less common delivery mode just to not have to 
> fix the hotplug bug?

Ok assuming temporarily it's a bug, how would you want to fix it?

-Andi
