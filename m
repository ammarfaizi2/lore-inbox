Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWIJOJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWIJOJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWIJOJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:09:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10181 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932190AbWIJOJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:09:58 -0400
Date: Sun, 10 Sep 2006 16:02:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060910140214.GA1578@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <200609101555.52211.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609101555.52211.ak@suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > ugh, "having a working current" is "so much infrastructure" ??
> 
> Together with stacktrace the infrastructure needed is quite 
> considerable.

Having the ability to produce a backtrace _anywhere within the kernel_ 
is a pretty fundamental thing too. So IMO the problems with stacktrace 
were the stack dumping code's weaknesses, independent of lockdep, and 
they would have triggered in one way or another as well. Not that i 
think that doing a dwarf unwinder is simple - and you certainly did a 
great job with it. Now with stacktrace we do have a pretty powerful 
infrastructure to do transparent execution tracing: for example the 
page-tracing code could be changed to use stacktrace.

> > the i686 PDA patches introduce tons of early_current() uses. While i
> > like the new PDA code, its bootstrap (like x86_64's PDA bootstrap) is
> > too fragile in my opinion, and it will regularly hit instrumenting
> > patches.
> 
> Or the instrumentation patches just always need to check some global 
> variable. Maybe system_state could be extended or something.

maybe, but i find that unrobust too. Example: i debugged many 
early-bootup hangs via the use of an early_printk() based function 
execution tracer (a feature of the latency tracing patchset) - the lack 
of working 'current' would hit that code too.

Yes, it can all be worked around, but the fundamental weakness IMO is 
that we dont have a working 'current' in all situations.

> > should be moved into 32-bit early boot userspace code (like
> > compressed/misc.c) and it will thus not depend on any kernel
> > infrastructure.
> 
> Ok I guess it would make sense to add a i386_start_kernel to i386 and 
> initialize the boot PDA there. I would also move early_cpu_init into 
> there because that also avoids quite some mess later.

yes. And move all of this _outside_ the normal kernel build process, so 
that whatever ad-hoc or less ad-hoc instrumentation is added (be that 
PROFILE_UNLIKELY, function tracing, 'get_current' based hacks, irqtrace, 
lockdep or whatever) it wont be included in that code. That gets rid of
most of the dependency and bootstrap problems. It's hard enough already
to debug early boot code.

	Ingo
