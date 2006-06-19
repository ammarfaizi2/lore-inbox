Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWFSMb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWFSMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWFSMb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:31:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41871 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932420AbWFSMb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:31:26 -0400
Date: Mon, 19 Jun 2006 14:26:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: tglx@timesys.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic  HZ
Message-ID: <20060619122606.GA19451@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606191521.05508.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Nice work Thomas and Ingo.
> 
> The approach to previous dynticks that I was working on had some nasty 
> issues with scalability that were not addressable without a complete 
> rewrite which is why I abandoned the previous implementation. Your 
> approach for using the hires timer events is ultimately a better 
> solution and the code base is cleaner so I'm very pleased to see it.

thanks!

> A couple of comments.
> 
> One of the problems we enountered with dynticks was that using the 
> higher resolution timers such as TSC and HPET to adjust for timer 
> ticks over longer periods when skipping ticks made the overall clock 
> drift when run for many days and only the PM Timer was not prone to 
> this happening. ie the timers were very accurate for short periods but 
> over days it would drift. It could well have been a design flaw in the 
> dynticks I was maintaining rather than the timers themselves but have 
> you checked that this isn't a problem?

not yet. If it's a real problem we could introduce a 'make clock events 
more reliable' framework by doing something like always programming 
clock event sources into periodic mode and reading their current time 
offset [if possible] when the event is processesed (thus compensating 
for most of the drift caused by irq processing latency). But if it's not 
needed it would be nice to avoid that complexity. I'm also wondering why 
the PM timer was the most accurate in that regard - it's almost as slow 
to program as the PIT, so i'd have expected it to to show the biggest 
drift.

(another technique to reduce drift: we could increase the APIC-priority 
of the lapic timer, making it less suspect to drift when there are lots 
of other IRQs going on.)

can you think of any other similar 'weird cases' that you saw happen 
with dynticks? For example there's the 'APIC stops timer irqs when 
entering C3 mode' bug - any similar weirdness we should be careful 
about? [right now the patch doesnt handle the C3 mode bug, but it should 
be relatively straightforward to blacklist lapic events in that case]

i'm looking at dynticks-060227.patch right now, and there seem to be a 
fair amount of dyntick specific changes to ACPI's processor_idle.c code. 
Do you remember what those changes were about and should we pick them up 
in one way or another?

> The other thing I note is that there is a reasonable amount of 
> indirection in fairly hot paths. It looks like there is scope for more 
> local variable storage of these indirect calls. [...]

which function(s) were you looking at when coming to this conclusion? 
clockevents_init_next_event() perhaps? [we could certainly put 
'sources->nextevent' into a local variable there]

> [...] Also if set_next_event is separated from struct clock_event, the 
> whole struct looks like a suitable candidate for __read_mostly.

You mean ->event_handler()? We can make all clockevent instantiations 
__read_mostly right now - all of the fields of clock_event are static, 
even ->event_handler() will change at most once per bootup [when we 
switch from low-res into high-res mode].

	Ingo
