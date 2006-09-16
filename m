Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWIPAb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWIPAb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWIPAb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:31:59 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15274 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932255AbWIPAb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:31:58 -0400
Date: Sat, 16 Sep 2006 02:31:19 +0200 (CEST)
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
In-Reply-To: <20060915231419.GA24731@elte.hu>
Message-ID: <Pine.LNX.4.64.0609160139130.6761@scrub.home>
References: <1158332447.5724.423.camel@localhost.localdomain>
 <20060915111644.c857b2cf.akpm@osdl.org> <1158348954.5724.481.camel@localhost.localdomain>
 <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu>
 <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu>
 <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 16 Sep 2006, Ingo Molnar wrote:

> > As I said before you're mixing up function tracing with event tracing, 
> > not all events are tied to functions, functions can be moved and 
> > renamed, the actual event more often stays the same.
> 
> you are showing a clear misunderstanding of how tracing is typically 
> done.

Not really, you're missing the point I'm trying to make, we want to trace 
_events_ not functions. Function specific tracing would still require 
kernel specific mapping to map function names to events.

> Both for LTT and for blktrace (and for the tracers i've done 
> myself), roughly half (50%) of the tracepoints are right at the top of 
> the function and trace the function arguments. Let me quote an example 
> straight from LTT:
> 
>  int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  {
>          struct kiocb iocb;
>          struct sock_iocb siocb;
>          int ret;
> 
>          trace_socket_sendmsg(sock, sock->sk->sk_family,
>                  sock->sk->sk_type,
>                  sock->sk->sk_protocol,
>                  size);
> 
> this tracepoint, under a dynamic tracing concept, can be replaced with:
> 
>  int __trace sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  {
>          struct kiocb iocb;
>          struct sock_iocb siocb;
>          int ret;
> 
> note the "__trace" attribute to the function. (see my previous mails 
> where i talked about __trace for more details) SystemTap can hook to 
> that point and can access the very same parameters that the markup does, 
> in a lot less invasive way.
> 
> So a 5-line markup can be replaced with a single function attribute.

A nice example where you make life more difficult for static tracers for 
no reason, whereas a "trace_socket_sendmsg(sock, size);" is just as 
usable. It would also add virtually no maintainance overhead as you like 
to claim - how often does this function change?

> > Function attributes also doesn't provide information local to the 
> > function.
> 
> of course, but where does the above tracepoint i quoted use information 
> local to the function? A fair number of markups use global functions 
> because, surprise, alot of interesting activity happens along global 
> functions. So a healthy reduction in markups can be achieved.

But not completely, which is the whole point.

> > It's possible I missed something, but pretty much anything you 
> > outlined wouldn't make the live of static tracepoints any easier.
> 
> sorry, but if you re-read the above line of argument, your sentence 
> appears non-sequitor. I said "the markers needed for dynamic tracing are 
> different from the LTT static tracepoints". You asked why they are so 
> different, and i replied that i already outlined what the right API 
> would be in my opinion to do markups, but that API is different from 
> what LTT is offering now. To which you are now replying: "pretty much 
> anything you outlined wouldn't make the life of static tracepoints any 
> easier." Huh?

Yeah, huh?
I have no idea, what you're trying to tell me. As you demonstrated above 
your "right API" is barely usable for static tracers.

> > So if dynamic tracing is available use it, as distributions already 
> > do. OTOH the barrier to use static tracing is drastically different 
> > whether the user has to deal with external patches or whether it's a 
> > simple kernel option. Again, static tracing doesn't exclude the 
> > possibility of dynamic tracing, that's something you constantly omit 
> > and thus make it sound like both options were mutually exlusive.
> 
> how does this reply to my point that: "a marker for dynamic tracing has 
> lower performance impact than a static tracepoint, on systems that are 
> not being traced", which point you claimed moot?

Because it's pretty much an implementation issue. The point is about 
adding markers at all, it's about the choice being able to use static 
tracers in the first place. Both have undeniable their advantages/ 
disadvantages, where you prefer to emphasize only the strong points of 
dynamic tracing and constantly declare its problems as nonissues.

> > > Secondly, even people who intend to _eventually_ make use of 
> > > tracing, dont use it most of the time. So why should they have more 
> > > overhead when they are not tracing? Again: the point is not moot 
> > > because even though the user intends to use tracing, but does not 
> > > always want to trace.
> > 
> > I've used kernels which included static tracing and the perfomance 
> > overhead is negligible for occasional use.
> 
> how does this suddenly make my point, that "a marker for dynamic tracing 
> has lower performance impact than a static tracepoint, on systems that 
> are not being traced", "moot"?

Why exactly is the point relevant in first place? How exactly is the added 
(minor!) overhead such a fundamental problem?

> > Why don't you leave the choice to the users? Why do you constantly 
> > make it an exclusive choice? [...]
> 
> as i outlined it tons of times before: once we add markups for static 
> tracers, we cannot remove them. That is a constant kernel maintainance 
> drag that i feel uncomfortable about.

As many, many people have already said, any tracepoints have an 
maintainance overhead, which is barely different between dynamic and 
static tracing and only increases the further away the tracepoints are 
from the source.

bye, Roman
