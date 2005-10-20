Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVJTUyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVJTUyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVJTUyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:54:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51866 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932535AbVJTUyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:54:49 -0400
Date: Thu, 20 Oct 2005 22:54:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020205459.GA23326@elte.hu>
References: <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu> <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain> <20051020085955.GB2903@elte.hu> <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain> <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain> <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain> <1129826750.27168.163.camel@cog.beaverton.ibm.com> <20051020193214.GA21613@elte.hu> <1129838714.27168.181.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129838714.27168.181.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> > no, this is really a bad optimization that causes unrobustness. 
> > Correctness and robustness comes first. It is so easy to cause a 
> > 500-1000msec delay in the kernel, due to a bad driver or anything. The 
> > timekeeping code should not break like that.
> 
> Eh, its an easy enough change, so I'll put it back to u64. We can 
> revisit it again later if needed.

yeah. i didnt notice u64 hurting that much, and we can optimize it later 
on. As long as the 64-bit CPUs are ok, we shouldnt care all that much 
about micro-performance - especially not at the expense of robustness.

> However making sure periodic_hook isn't starved for too long is 
> important for good timekeeping, since ntp and cpufreq adjustments are 
> made at that point. Steven's suggestion of moving it to use ktimers 
> sounds like a good plan, but let me know if you can see any other 
> holes.

yes. Besides driver bugs and 'badly behaving' code, there's another use 
case: in the PREEMPT_RT kernel it's the user that picks the priorities 
for kernel functionalities in a very finegrained way: if his 
data-collection device interrupt and driver code is more important than 
anything else on the system (including timekeeping), then that's the way 
it will be. So the seemingly contradictory (and amusing) situation 
arises that the -rt kernel, which is all about low latencies, also 
increases the the need for subsystems to more robustly _bear with_ 
higher latencies - for the case where they happen to be the lowprio guy 
...

but i agree - excessive latencies cannot be tolerated - but up to a few 
seconds can easily happen in various situations.

	Ingo
