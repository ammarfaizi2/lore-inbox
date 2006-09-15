Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWIOXXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWIOXXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWIOXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:23:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:2448 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932359AbWIOXXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:23:07 -0400
Date: Sat, 16 Sep 2006 01:14:19 +0200
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
Message-ID: <20060915231419.GA24731@elte.hu>
References: <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609160018110.6761@scrub.home>
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

> > > This is simply not true, at the source level you can remove a static 
> > > tracepoint as easily as a dynamic tracepoint, the effect of the 
> > > missing trace information is the same either way.
> > 
> > this is not true. I gave you one example already a few mails ago (which 
> > you did not reply to, neither did you reply the previous time when i 
> > first mentioned this - perhaps you missed it in the high volume of 
> > emails):
> > 
> > " i outlined one such specific "removal of static tracepoint" example 
> >   already: static trace points at the head/prologue of functions (half 
> >   of the existing tracepoints are such). The sock_sendmsg() example i 
> >   quoted before is such a case. Those trace points can be replaced with 
> >   a simple GCC function attribute, which would cause a 5-byte (or 
> >   whatever necessary) NOP to be inserted at the function prologue. The 
> >   attribute would be alot less invasive than an explicit tracepoint (and 
> >   thus easier to maintain) "
> 
> As I said before you're mixing up function tracing with event tracing, 
> not all events are tied to functions, functions can be moved and 
> renamed, the actual event more often stays the same.

you are showing a clear misunderstanding of how tracing is typically 
done. Both for LTT and for blktrace (and for the tracers i've done 
myself), roughly half (50%) of the tracepoints are right at the top of 
the function and trace the function arguments. Let me quote an example 
straight from LTT:

 int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
         struct kiocb iocb;
         struct sock_iocb siocb;
         int ret;

         trace_socket_sendmsg(sock, sock->sk->sk_family,
                 sock->sk->sk_type,
                 sock->sk->sk_protocol,
                 size);

this tracepoint, under a dynamic tracing concept, can be replaced with:

 int __trace sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
         struct kiocb iocb;
         struct sock_iocb siocb;
         int ret;

note the "__trace" attribute to the function. (see my previous mails 
where i talked about __trace for more details) SystemTap can hook to 
that point and can access the very same parameters that the markup does, 
in a lot less invasive way.

So a 5-line markup can be replaced with a single function attribute.

roughly half of the existing tracepoints in blktrace/LTT can be replaced 
that way. A 50% reduction in the number of markups is significant - but 
such a reduction in markups not possible under the static tracing 
concept. And that method was just off the top of my head - Andrew 
provided other ideas to reduce the number of markups.

> Function attributes also doesn't provide information local to the 
> function.

of course, but where does the above tracepoint i quoted use information 
local to the function? A fair number of markups use global functions 
because, surprise, alot of interesting activity happens along global 
functions. So a healthy reduction in markups can be achieved.

> > > >  - the markers needed for dynamic tracing are different from the 
> > > >    LTT static tracepoints.
> > >
> > > What makes the requirements so different? I would actually think 
> > > it depends on the user independent of the tracing is done.
> > 
> > yes, and i mentioned before that they can be merged (i even outlined 
> > a few APIs for it), but still that is not being offered by LTT 
> > today.
> 
> It's possible I missed something, but pretty much anything you 
> outlined wouldn't make the live of static tracepoints any easier.

sorry, but if you re-read the above line of argument, your sentence 
appears non-sequitor. I said "the markers needed for dynamic tracing are 
different from the LTT static tracepoints". You asked why they are so 
different, and i replied that i already outlined what the right API 
would be in my opinion to do markups, but that API is different from 
what LTT is offering now. To which you are now replying: "pretty much 
anything you outlined wouldn't make the life of static tracepoints any 
easier." Huh?

> > > >  - a marker for dynamic tracing has lower performance impact than a 
> > > >    static tracepoint, on systems that are not being traced. (but which 
> > > >    have the tracing infrastructure enabled otherwise)
> > > 
> > > Anyone using static tracing intents to use, which makes this point 
> > > moot.
> > 
> > that's not at all true, on multiple grounds:
> > 
> > Firstly, many people use distro kernels. A Linux distribution typically 
> > wants to offer as few kernel rpms as possible (one per arch to be 
> > precise), but it also wants to offer as many features as possible. So if 
> > there was a static tracer in there, a distro would enable it - but 99.9% 
> > of the users would never use it - still they would see the overhead. 
> > Hence the user would have it enabled, but does not intend to use it - 
> > which contradicts your statement.
> 
> So if dynamic tracing is available use it, as distributions already 
> do. OTOH the barrier to use static tracing is drastically different 
> whether the user has to deal with external patches or whether it's a 
> simple kernel option. Again, static tracing doesn't exclude the 
> possibility of dynamic tracing, that's something you constantly omit 
> and thus make it sound like both options were mutually exlusive.

how does this reply to my point that: "a marker for dynamic tracing has 
lower performance impact than a static tracepoint, on systems that are 
not being traced", which point you claimed moot?

> > Secondly, even people who intend to _eventually_ make use of 
> > tracing, dont use it most of the time. So why should they have more 
> > overhead when they are not tracing? Again: the point is not moot 
> > because even though the user intends to use tracing, but does not 
> > always want to trace.
> 
> I've used kernels which included static tracing and the perfomance 
> overhead is negligible for occasional use.

how does this suddenly make my point, that "a marker for dynamic tracing 
has lower performance impact than a static tracepoint, on systems that 
are not being traced", "moot"?

> > > >  - having static tracepoints dillutes the incentive for 
> > > >  architectures to
> > > >    implement proper kprobes support.
> > > 
> > > Considering the level of work needed to support efficient dynamic 
> > > tracing it only withholds archs from tracing support for no good 
> > > reason.
> > 
> > 5 major architectures (both RISC and CISC) already support kprobes, 
> > so fortunately this point is largely moot - but you are right to a 
> > certain degree, it's not totally solved. But the examples are there. 
> > It's still not trivial to implement a feature like this, but kernel 
> > programming never is. I far more prefer the harder but more 
> > intelligent solution than the easier but less intelligent solution - 
> > even if that means a temporary unavailability of a feature for some 
> > rarer arch.
> 
> Why don't you leave the choice to the users? Why do you constantly 
> make it an exclusive choice? [...]

as i outlined it tons of times before: once we add markups for static 
tracers, we cannot remove them. That is a constant kernel maintainance 
drag that i feel uncomfortable about. While with dynamic tracers i see a 
clear path out of any such drag. We can, in a very finegrained way, tune 
the overhead of markups vs. out-of-source scripts. Static tracers dont 
give us this flexibility - and hence limit our future choices.

the user of course does not care about kernel internal design and 
maintainance issues. Think about the many reasons why STREAMS was 
rejected - users wanted that too. And note that users dont want "static 
tracers" or any design detail of LTT in particular: what they want is 
the _functionality_ of LTT.

nor do i reject all of LTT: as i said before i like the tools, and i 
think its collection of trace events should be turned into systemtap 
markups and scripts. Furthermore, it's ringbuffer implementation looks 
better. So as far as the user is concerned, LTT could (and should) live 
on with full capabilities, but with this crutial difference in how it 
interfaces to the kernel source code.

	Ingo
