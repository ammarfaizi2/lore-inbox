Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWINRWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWINRWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWINRWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:22:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3810 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750813AbWINRWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:22:17 -0400
Date: Thu, 14 Sep 2006 19:13:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914171320.GB1105@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609141623570.6761@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Thu, 14 Sep 2006, Ingo Molnar wrote:
> 
> > > On Thu, 14 Sep 2006, Ingo Molnar wrote:
> > > 
> > > > i have one very fundamental question: why should we do this 
> > > > source-intrusive method of adding tracepoints instead of the dynamic, 
> > > > unintrusive (and thus zero-overhead) KProbes+SystemTap method?
> > > 
> > > Could you define "zero-overhead"?
> > 
> > zero overhead when not used: not a single instruction added to the 
> > kernel codepath that is to be traced, anywhere. (which will be the case 
> > on 99% of the systems)
> 
> Using alternatives this could be near zero as well and it will likely 
> have less overhead when it's actually used.

if there are lots of tracepoints (and the union of _all_ useful 
tracepoints that i ever encountered in my life goes into the thousands) 
then the overhead is not zero at all.

also, the other disadvantages i listed very much count too. Static 
tracepoints are fundamentally limited because:

  - they can only be added at the source code level

  - modifying them requires a reboot which is not practical in a
    production environment

  - there can only be a limited set of them, while many problems need
    finegrained tracepoints tailored to the problem at hand

  - conditional tracepoints are typically either nonexistent or very
    limited.

for me these are all _independent_ grounds for rejection, as a generic 
kernel infrastructure.

> > the key point is that we want _zero_ "static tracepoints". Firstly, 
> > static tracepoints are fundamentally limited:
> 
> BTW I don't mind KProbes as an option, but I have huge problem with 
> making it the only option.

i'm not arguing for SystemTap to be the only option (KProbes is just the 
infrastructure SystemTap is using - there are other uses for KProbes 
too), but i'm arguing against the inclusion of static tracepoints as an 
infrastructure, precisely because a much better option (SystemTap) is 
already available and is usable on the stock kernel. You are of course 
free to invent other, equally advantageous (or better) options.

> > But besides the usability problems, the most important problem is 
> > that static tracepoints add a _constant maintainance overhead_ to 
> > the kernel. I'm talking from first hand experience: i wrote 
> > 'iotrace' (a static tracer) in 1996 and have maintained it for many 
> > years, and even today i'm maintaining a handful of tracepoints in 
> > the -rt kernel. I _dont_ want static tracepoints in the mainline 
> > kernel.
> 
> Even dynamic tracepoints have a maintainance overhead and I doubt 
> there is much difference. The big problem is having to maintain them 
> outside the mainline kernel, that's why it's so important to get them 
> into the mainline kernel.

i dispute that: for example kernel/sched.c has zero maintainance 
overhead under SystemTap, while it's nonzero with static tracepoints. Of 
course SystemTap _itself_ has maintainance overhead, but it does not 
slow down any other subsystem's speed of progress.

> You didn't address my main issue at all - kprobes is only available 
> for a few archs...

the kprobes infrastructure, despite being fairly young, is widely 
available: powerpc, i386, x86_64, ia64 and sparc64. The other 
architectures are free to implement them too, there's nothing 
hardware-specific about kprobes and the "porting overhead" is in essence 
a one-time cost - while for static tracepoints the maintainance overhead 
goes on forever and scales linearly with the number of tracepoints 
added.

	Ingo
