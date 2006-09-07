Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWIGKha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWIGKha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWIGKha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:37:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35513 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751012AbWIGKh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:37:29 -0400
Date: Thu, 7 Sep 2006 12:26:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
Message-ID: <20060907102621.GC4125@elte.hu>
References: <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> <17274.1157553962@warthog.cambridge.redhat.com> <8934.1157622928@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8934.1157622928@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> The genirq subdir all wraps up into this:
> 
> 	  10908    3272      12   14192    3770 kernel/irq/built-in.o
> 	   1548      64       4    1616     650 arch/frv/kernel/irq.o
> 	---------------------------------------------------------------------
> 	  12456    3336      16   15808    3dc0 total

hm, could you take a look at why that difference happens? Do you make 
use of __do_IRQ()? Do you make use of all the various flow handlers that 
are offered in handle.c? Could you #ifdef out all the functions that are 
unused? The kernel build process doesnt remove them and i havent (yet) 
put them into a library.

Could you please send us the patch that genirq-ifies FRV?

> So, again, why _should_ I use the generic IRQ stuff? [...]

To have shared code between architectures? To make generic API updates 
easier for all of us? To have less cruft in interrupt.h? To not having 
to add last-minute patches to v2.6.18 because some arch defines its own 
IRQ prototypes and a difficult generic feature like irqtrace breaks? To 
get new IRQ subsystem features for free like preemptible irqs, irqpoll 
or SHIRQ debugging?

the same "why should we share code" argument could be made for the VFS 
too. Sharing code has a (small) price most of the time, but it's also 
very much worth it. I think the size increases you are seeing are 
artificial and most of it is not caused by the indirections. If they 
were caused by the indirections i'd probably agree with you.

if your argument were true every arch should run its whole Linux kernel 
in arch/frv, with zero sharing with anyone else. There's always a lot of 
'unnecessary' stuff all around the kernel that is just a hindrance for 
FRV. In reality what makes us stronger is to work together. I dont for a 
minute say that we should overdo code sharing - if it's not possible 
then it must not be forced, but just the pure fact of "more 
indirections" or "what does this bring me _now_" isnt a good enough 
reason i believe - it simply makes _future_ changes easier.

	Ingo
