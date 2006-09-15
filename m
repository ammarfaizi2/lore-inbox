Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWIOV7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWIOV7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWIOV7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:59:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55452 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932306AbWIOV7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:59:50 -0400
Date: Fri, 15 Sep 2006 23:51:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915215112.GB12789@elte.hu>
References: <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609152314250.6761@scrub.home>
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

> > because:
> > 
> >  - static tracepoints, once added, are very hard to remove - up until
> >    eternity. (On the other hand, markers for dynamic tracers are easily 
> >    removed, either via making the dynamic tracer smarter, or by 
> >    detaching the marker via the patch(1) method. In any case, if a 
> >    marker goes away then hell does not break loose in dynamic tracing 
> >    land - but it does in static tracing land.
> 
> This is simply not true, at the source level you can remove a static 
> tracepoint as easily as a dynamic tracepoint, the effect of the 
> missing trace information is the same either way.

this is not true. I gave you one example already a few mails ago (which 
you did not reply to, neither did you reply the previous time when i 
first mentioned this - perhaps you missed it in the high volume of 
emails):

" i outlined one such specific "removal of static tracepoint" example 
  already: static trace points at the head/prologue of functions (half 
  of the existing tracepoints are such). The sock_sendmsg() example i 
  quoted before is such a case. Those trace points can be replaced with 
  a simple GCC function attribute, which would cause a 5-byte (or 
  whatever necessary) NOP to be inserted at the function prologue. The 
  attribute would be alot less invasive than an explicit tracepoint (and 
  thus easier to maintain) "

> >  - the markers needed for dynamic tracing are different from the LTT
> >    static tracepoints.
> 
> What makes the requirements so different? I would actually think it 
> depends on the user independent of the tracing is done.

yes, and i mentioned before that they can be merged (i even outlined a 
few APIs for it), but still that is not being offered by LTT today.

> >  - a marker for dynamic tracing has lower performance impact than a 
> >    static tracepoint, on systems that are not being traced. (but which 
> >    have the tracing infrastructure enabled otherwise)
> 
> Anyone using static tracing intents to use, which makes this point 
> moot.

that's not at all true, on multiple grounds:

Firstly, many people use distro kernels. A Linux distribution typically 
wants to offer as few kernel rpms as possible (one per arch to be 
precise), but it also wants to offer as many features as possible. So if 
there was a static tracer in there, a distro would enable it - but 99.9% 
of the users would never use it - still they would see the overhead. 
Hence the user would have it enabled, but does not intend to use it - 
which contradicts your statement.

Secondly, even people who intend to _eventually_ make use of tracing, 
dont use it most of the time. So why should they have more overhead when 
they are not tracing? Again: the point is not moot because even though 
the user intends to use tracing, but does not always want to trace.

> >  - having static tracepoints dillutes the incentive for architectures to
> >    implement proper kprobes support.
> 
> Considering the level of work needed to support efficient dynamic 
> tracing it only withholds archs from tracing support for no good 
> reason.

5 major architectures (both RISC and CISC) already support kprobes, so 
fortunately this point is largely moot - but you are right to a certain 
degree, it's not totally solved. But the examples are there. It's still 
not trivial to implement a feature like this, but kernel programming 
never is. I far more prefer the harder but more intelligent solution 
than the easier but less intelligent solution - even if that means a 
temporary unavailability of a feature for some rarer arch.

> > > > > there are separate project teams is because managers in key 
> > > > > positions made the decision that they'd rather break from existing 
> > > > > projects which had had little success mainlining and instead use 
> > > > > their corporate bodyweight to pressure/seduce kernel developers 
> > > > > working for them into pushing their new great which-aboslutely- 
> > > > > has-nothing-to-do-with-this-ltt-crap-(no,no, we actually agree 
> > > > > with you kernel developers that this is crap, this is why we're 
> > > > > developing this new amazing thing). That's the truth plain and 
> > > > > simple.
> > > >
> > > > Stop whining!
> > > 
> > > So we're back to personal attacks now. :-(
> > 
> > hm, so you dont consider the above paragraph a whine. How would you 
> > characterize it then? A measured, balanced, on-topic technical 
> > comment? I'm truly curious.
> 
> It's sarcastic, [...]

oh, really? Karim's characterization was:

 " I'm factually explaining the real-life result of resistance to static
   instrumentation. "

so whose interpretation of Karim's comments should i accept, yours or 
Karim's? I'm really torn on that issue. (_that_ was sarcastic)

	Ingo
