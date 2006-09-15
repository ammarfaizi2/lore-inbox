Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWIOW1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWIOW1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWIOW1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:27:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21394 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932330AbWIOW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:27:35 -0400
Date: Sat, 16 Sep 2006 00:19:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915221926.GD12789@elte.hu>
References: <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <20060915213213.GA12789@elte.hu> <20060915215852.GC18958@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915215852.GC18958@Krystal>
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


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> > > > sorry, but i disagree. There _is_ a solution that is superior in 
> > > > every aspect: kprobes + SystemTap. (or any other equivalent 
> > > > dynamic tracer)
> > > > 
> > > 
> > > I am sorry to have to repeat myself, but this is not true for 
> > > heavy loads.
> > 
> > djprobes?
> > 
> 
> I am fully aware of djprobes limitations towards fully preemptible 
> kernel [...]

i dont see any fundamental limitation with a preemptible kernel. 
(preemptability was never a showstopper for any kernel feature in the 
past, and i dont expect it to be a showstopper for anything in the 
future either.)

> [...] (and around branches instructions ? I don't remember if they 
> solved this one). Oh, yes, and if a trap happen to come at the wrong 
> spot, then the thread gets scheduled out... well, it cannot be applied 
> everywhere, eh ?

i expect the number of places where dynamic tracers have problems to 
gradually shrink. It has shrunk significantly already. Hence i'm 
supportive of static markers (as i stated it numerous times), as long as 
it's there to ease dynamic probing - _and as long as these static 
markers shrink in number as the capabilities of dynamic tracers 
improve_. With static tracers i just dont see that possibility: a static 
tracer needs all its static tracepoints forever or otherwise it just 
wont work.

> >  $ grep "\<trace_.*(" * | wc -l
> >  359
> > 
> 
> This count includes the inline trace functions definitions.

yes, as i stated:

> > some of those are not true tracepoints, but there's at least this many 
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > of them:
> > 
> >  $ grep "\<trace_.*(" *instrumentation* | wc -l
> >  235
> > 
> 
> 1 - This counts per architecture trace points. It quickly adds up 
> considering that we support ARM, MIPS, i386, powerpc, ppc and x86_64.

yes. That's my point: overhead of static tracepoints "quickly adds up". 
The cost goes up linearly, as you grow into more subsystems and into 
more architectures.

btw., an observation: that's 6 LTT architectures in 7 years, while 
kprobes are now on 5 architectures in 2 years.

> 2 - It also counts some experimental trace points that I do not want 
> to submit.
> 3 - Most of these are instrumentation of the traps handlers, which is 
> conceptually only one event.

i counted the number of tracepoints, not the number of unique types of 
events, because:

> > when judging kernel maintainance overhead, the sum of all patches 
> > matters. And i considered all the other patches too (the ones that 
> > add actual tracepoints) that will come after the currently offered 
> > ones, not just the ones you submitted to lkml.
> 
> I plan to rework the instrumentation patches before submitting them to 
> LKML, don't worry. I just hasn't been my focus until now. Too bad that 
> you take those as arguments.

the static tracer patches make little sense without instrumentation, so 
sure i considered them. I also clearly declared that you didnt submit 
them yet:

>>> Let me quote from the latest LTT patch (patch-2.6.17-lttng-0.5.108, 
>>> which is the same version submitted to lkml - although no specific 
                                                  ^^^^^^^^^^^^^^^^^^^^
>>> tracepoints were submitted):
    ^^^^^^^^^^^^^^^^^^^^^^^^^^

	Ingo
