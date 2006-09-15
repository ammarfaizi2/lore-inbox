Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWIOWxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWIOWxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWIOWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:53:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42409 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932346AbWIOWxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:53:52 -0400
Date: Sat, 16 Sep 2006 00:53:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060915215112.GB12789@elte.hu>
Message-ID: <Pine.LNX.4.64.0609160018110.6761@scrub.home>
References: <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
 <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org>
 <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com>
 <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home>
 <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home>
 <20060915215112.GB12789@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

> > This is simply not true, at the source level you can remove a static 
> > tracepoint as easily as a dynamic tracepoint, the effect of the 
> > missing trace information is the same either way.
> 
> this is not true. I gave you one example already a few mails ago (which 
> you did not reply to, neither did you reply the previous time when i 
> first mentioned this - perhaps you missed it in the high volume of 
> emails):
> 
> " i outlined one such specific "removal of static tracepoint" example 
>   already: static trace points at the head/prologue of functions (half 
>   of the existing tracepoints are such). The sock_sendmsg() example i 
>   quoted before is such a case. Those trace points can be replaced with 
>   a simple GCC function attribute, which would cause a 5-byte (or 
>   whatever necessary) NOP to be inserted at the function prologue. The 
>   attribute would be alot less invasive than an explicit tracepoint (and 
>   thus easier to maintain) "

As I said before you're mixing up function tracing with event tracing, not 
all events are tied to functions, functions can be moved and renamed, the 
actual event more often stays the same.
Function attributes also doesn't provide information local to the 
function.

> > >  - the markers needed for dynamic tracing are different from the LTT
> > >    static tracepoints.
> > 
> > What makes the requirements so different? I would actually think it 
> > depends on the user independent of the tracing is done.
> 
> yes, and i mentioned before that they can be merged (i even outlined a 
> few APIs for it), but still that is not being offered by LTT today.

It's possible I missed something, but pretty much anything you outlined 
wouldn't make the live of static tracepoints any easier.

> > >  - a marker for dynamic tracing has lower performance impact than a 
> > >    static tracepoint, on systems that are not being traced. (but which 
> > >    have the tracing infrastructure enabled otherwise)
> > 
> > Anyone using static tracing intents to use, which makes this point 
> > moot.
> 
> that's not at all true, on multiple grounds:
> 
> Firstly, many people use distro kernels. A Linux distribution typically 
> wants to offer as few kernel rpms as possible (one per arch to be 
> precise), but it also wants to offer as many features as possible. So if 
> there was a static tracer in there, a distro would enable it - but 99.9% 
> of the users would never use it - still they would see the overhead. 
> Hence the user would have it enabled, but does not intend to use it - 
> which contradicts your statement.

So if dynamic tracing is available use it, as distributions already do.
OTOH the barrier to use static tracing is drastically different whether 
the user has to deal with external patches or whether it's a simple kernel 
option.
Again, static tracing doesn't exclude the possibility of dynamic tracing, 
that's something you constantly omit and thus make it sound like both 
options were mutually exlusive.

> Secondly, even people who intend to _eventually_ make use of tracing, 
> dont use it most of the time. So why should they have more overhead when 
> they are not tracing? Again: the point is not moot because even though 
> the user intends to use tracing, but does not always want to trace.

I've used kernels which included static tracing and the perfomance 
overhead is negligible for occasional use.

> > >  - having static tracepoints dillutes the incentive for architectures to
> > >    implement proper kprobes support.
> > 
> > Considering the level of work needed to support efficient dynamic 
> > tracing it only withholds archs from tracing support for no good 
> > reason.
> 
> 5 major architectures (both RISC and CISC) already support kprobes, so 
> fortunately this point is largely moot - but you are right to a certain 
> degree, it's not totally solved. But the examples are there. It's still 
> not trivial to implement a feature like this, but kernel programming 
> never is. I far more prefer the harder but more intelligent solution 
> than the easier but less intelligent solution - even if that means a 
> temporary unavailability of a feature for some rarer arch.

Why don't you leave the choice to the users? Why do you constantly make it 
an exclusive choice? There is a lot of common ground, but you seem to be 
hellbent to make the life of static tracers and thus their users as hard 
possible. Only for pursuit of some perfect solution while the more 
practical solution is easily available without any ill effects?

bye, Roman
