Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWINVji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWINVji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWINVjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:39:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45740 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751151AbWINVjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:39:35 -0400
Date: Thu, 14 Sep 2006 23:31:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914213113.GA16989@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509C1D0.6080208@mbligh.org>
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


* Martin Bligh <mbligh@mbligh.org> wrote:

> > primarily because i fail to see any property of static tracers that 
> > are not met by dynamic tracers. So to me dynamic tracers like 
> > SystemTap are a superset of static tracers.
> 
> 1. They're harder to maintain out of tree.

as i mentioned before, SystemTap should be in tree. Relayfs was added 
for the sake of SystemTap for example, i have no problem with moving 
SystemTap into the tree either.

> 2. they're written in some jibberish awk crap

You can write embedded-C SystemTap scripts too. There's an "EMBEDDED C" 
section in "man stap".

> 3. They're slower. If you're doing thousands of tracepoints a second,
> 	into a circular 8GB log buffer, that *does* matter. You want
> 	to peturb what you're measuring as little as possible.

i very much agree that they should become as fast as possible. So to 
rephrase the question: can we make dynamic tracepoints as fast (or 
nearly as fast) as static tracepoints? If yes, should we care about 
static tracers at all?

> >So my position is that what we should concentrate on is to make the life 
> >of dynamic tracers easier (be that a handful of generic, parametric 
> >hooks that gather debuginfo information and add NOPs for easy patching), 
> >while realizing that static tracers have no advantage over dynamic 
> >tracers.
> 
> I'm confused. You're saying that the dynamic tracers need help by 
> adding some static data to the kernel, and yet at the same time 
> rejecting static additions to the kernel on the grounds they have no 
> value???

no. I'm saying that dynamic tracers are fundamentally more advanced, and 
that _iff_ we are to add static info to the kernel we should add it _for 
the sole sake of speeding up dynamic tracers_. If static tracers can 
live off the same hooks then fine, but we should architect primarily for 
the needs of the dynamic tracers.

> Perhaps we're just meaning different things by static tracing. To me, 
> what is important is that there is a well-defined place in the source 
> code where the data needed to be logged, and the exact place to log it 
> at, is defined. If all that macro does to the compilation is add a 
> couple of nops, and make an entry in a symbol data, or other debug 
> data, for something to hook into later that's *fine*. The point is to 
> maintain the location and intelligence about *what* to trace.

ok. For me 'static tracepoints' are like the sort of stuff that LTT 
adds: funky function names littering the tree.

i see the point behind 'data extraction point' hooks mentioned by you as 
a compromise, which incidentally will also speed up dynamic tracepoints 
to the level of static tracepoints. But they should be very much 
constructed as data extraction points for the purposes of dynamic 
tracers. (which the LTT hooks currently are not)

> If we want it to be superfast, we could compile with a different 
> config option to insert some tracing statically in there or something, 
> but I agree it should not be the default.

for a dynamic tracer all that is needed is a 5-byte NOP (even on 
64-bit), and the availability of all the data. Maybe even a function 
call that can be patched out after bootup, with NOPs. But the current 
LTT stuff has lots of inlined crap that just bloats the kernel.

> >i.e. why add infrastructure for the sake of something that is clearly 
> >inferior? I have no problem with adding infrastructure for SystemTap, 
> >but i am asking the question: is it worth adding a static tracer?
> 
> Yes ;-) Realise that your usage model is not exactly the same as 
> everyone else's, and I don't give a damn if I have to recompile. I 
> realise other people do, but ....

So you dont care about recompiling: that's fine - but others care, so as 
long as all your needs are met (which we are working on meeting :-) then 
we'll go for the solution that is better - instead of having some dual 
debugging infrastructure.

> > (Just like i would accept the reintroduction of the Big Kernel Lock
> >  too, if someone proved it that it's the right thing to do.)
> 
> Surely it's still there at the moment? ;-)

no - at least for me it's the Big Kernel Semaphore ;-)

	Ingo
