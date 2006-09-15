Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWIOXth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWIOXth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWIOXth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:49:37 -0400
Received: from alnrmhc12.comcast.net ([206.18.177.52]:11512 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932221AbWIOXtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:49:36 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Nicholas Miell <nmiell@comcast.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <20060915231419.GA24731@elte.hu>
References: <1158332447.5724.423.camel@localhost.localdomain>
	 <20060915111644.c857b2cf.akpm@osdl.org>
	 <1158348954.5724.481.camel@localhost.localdomain>
	 <450B0585.5070700@opersys.com>
	 <1158351780.5724.507.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609152236010.6761@scrub.home>
	 <20060915204812.GA6909@elte.hu>
	 <Pine.LNX.4.64.0609152314250.6761@scrub.home>
	 <20060915215112.GB12789@elte.hu>
	 <Pine.LNX.4.64.0609160018110.6761@scrub.home>
	 <20060915231419.GA24731@elte.hu>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 16:49:21 -0700
Message-Id: <1158364161.2352.9.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 01:14 +0200, Ingo Molnar wrote:
> * Roman Zippel <zippel@linux-m68k.org> wrote:
> 
> > > > This is simply not true, at the source level you can remove a static 
> > > > tracepoint as easily as a dynamic tracepoint, the effect of the 
> > > > missing trace information is the same either way.
> > > 
> > > this is not true. I gave you one example already a few mails ago (which 
> > > you did not reply to, neither did you reply the previous time when i 
> > > first mentioned this - perhaps you missed it in the high volume of 
> > > emails):
> > > 
> > > " i outlined one such specific "removal of static tracepoint" example 
> > >   already: static trace points at the head/prologue of functions (half 
> > >   of the existing tracepoints are such). The sock_sendmsg() example i 
> > >   quoted before is such a case. Those trace points can be replaced with 
> > >   a simple GCC function attribute, which would cause a 5-byte (or 
> > >   whatever necessary) NOP to be inserted at the function prologue. The 
> > >   attribute would be alot less invasive than an explicit tracepoint (and 
> > >   thus easier to maintain) "
> > 
> > As I said before you're mixing up function tracing with event tracing, 
> > not all events are tied to functions, functions can be moved and 
> > renamed, the actual event more often stays the same.
> 
> you are showing a clear misunderstanding of how tracing is typically 
> done. Both for LTT and for blktrace (and for the tracers i've done 
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
> 
> roughly half of the existing tracepoints in blktrace/LTT can be replaced 
> that way. A 50% reduction in the number of markups is significant - but 
> such a reduction in markups not possible under the static tracing 
> concept. And that method was just off the top of my head - Andrew 
> provided other ideas to reduce the number of markups.
> 

You're going to want to be able to trace every function in the kernel,
which means they'd all need a __trace -- and in that case, a
-fpad-functions-for-tracing gcc option would make more sense then
per-function attributes.

The option could also insert NOPs before RETs, not just before the
prologue so that function returns are equally easy to trace. (It might
also inhibit tail calls, assuming being able to trace all function
returns is more important than that optimization.)


And SystemTap can already hook into sock_sendmsg() (or any other
function) and examine it's arguments -- all of this GCC extension talk
is just performance enhancement.

-- 
Nicholas Miell <nmiell@comcast.net>

