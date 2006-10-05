Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWJEV3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWJEV3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWJEV3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:29:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45545 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932221AbWJEV3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:29:38 -0400
Date: Thu, 5 Oct 2006 17:28:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
In-Reply-To: <20061005205055.GB1865@Krystal>
Message-ID: <Pine.LNX.4.58.0610051659590.1011@gandalf.stny.rr.com>
References: <1160025104.6504.30.camel@localhost.localdomain>
 <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
 <20061005170132.GA11149@Krystal> <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com>
 <20061005205055.GB1865@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Oct 2006, Mathieu Desnoyers wrote:

> >
> > Is this the static marks everyone is fighting over?
> >
>
> I consider that the previous discussion let to a general concensus where it has
> been recognised that marking the code is generally acceptable and needed. As a
> personal initiative following this discussion, I proposed a marker mechanism,
> iterated for 2 weeks, and it is now at the 0.20 release. It went through about 3
> complete rewrites during the process, but it seems that most objections has been
> answered.

Currently at 5932 unread messages, and I'm still reading that thread :-)

A little birdy pointed me to http://lwn.net/Articles/200059/ which talks
about this.  Good to see it.  I should have read the rest of the thread
before posting, but this was originally about my logdev, and I got
excited.

>
> This week, I ported LTTng to the marker mechanism by creating "probes", which
> are the dynamically loadable modules that connects to the markers.

Cool.

>
> > > - Serialization mechanism (facilities) within probes (ltt-probes kernel
> > >   modules) dynamically connected to markers.
> >
> > Sorry, I don't really understand what the above is.  Is it a loadable
> > module that connects to the static markers?  You might need to dumb this
> > one down for me.
> >
>
> Ok,
>
> A marker, in my implementation, is a statement placed in the code, i.e. :
>
> MARK(kernel_sched_schedule, "%d %d %ld", prev->pid, next->pid, prev->state);
>
> A probe is a dynamically loadable module which implements a callback, i.e. :
>
>
> #define KERNEL_SCHED_SCHEDULE_FORMAT "%d %d %ld"
> void probe_kernel_sched_schedule(const char *format, ...)
> {
>         va_list ap;
>         /* Declare args */
>         int prev_pid, next_pid;
>         long state;
>
>         /* Assign args */
>         va_start(ap, format);
>         prev_pid = va_arg(ap, typeof(prev_pid));
>         next_pid = va_arg(ap, typeof(next_pid));
>         state = va_arg(ap, typeof(state));
>
>         /* Call tracer */
>         trace_process_schedchange(prev_pid, next_pid, state);
>
>         va_end(ap);
> }
>
> Which, in my case, takes the variable arguments of the marker call and gives
> them to my inline tracing function.
>
> trace_process_schedchange is the "serialization" mechanism which takes its input
> (arguments) and writes them in a event record in the buffers, dealing with
> reentrancy.
>
>

OK, this makes a lot more sense. I still have a ton of questions, but they
are probably answered in the 5932 messages I have yet to read/skim.

> >
> > > - Tracing control mechanism (ltt-tracer, ltt-control)
> >
> > Is this in kernel or tools?
> >
>
> I am absolutely not talking about the user space tools here, only kernel code.
> This would be another discussion :)

I didn't think you were, but I had to be sure.

>
> In fact, ltt-control is the netlink interface that helps user space controlling
> the tracer. It's not mandatory : the tracer can be controlled from within the
> kernel too (useful for embedded systems).
>
> > > - Buffer management mechanism (ltt-relay)
> >
> > So this uses the current relay system?
> >
>
> Yes, but I do my own synchronization. I implement my own reserve/commit and I
> also export my own ioctl and poll to communicate with the user space buffer
> reading daemon.

Sounds like what logdev does too.

>
> > The greatest resistance that I currently see with LTTng is the adding of
> > static trace points.  So if LTTng isn't fully crippled by working with
> > dynamic addition of trace point (unmodifying the code), then try to get
> > that in first. See below.
> >
>
> My first goal is to have the infrastructure in, without the instrumentation. And
> yes, I want to connect this infrastructure with a nice dynamic instrumentation
> tool like logdev or systemtap, as it will give fast usability of the
> infrastructure to a user base.

systemtap would obviously be prefered over my logdev (but I can still
dream ;)


> > > * Dynamic registration of new events/event record types
> > >
> > > LTTng supports such dynamic registration since the 0.5.x series.
> >
> > I feel really stupid!  What do you define as an event, and how would
> > one add a new one dynamically.
> >
>
> Please don't :) Defining a new event would be to say :
>
> I want to create an event named "schedchange", which belongs to the "kernel"
> subsystem. In its definition, I say that it will take two integers and a long,
> respectively names "prev_pid", "next_pid" and "state".
>
> We can think of various events for various subsystems, and even for modules. It
> becomes interesting to have dynamically loadable event definitions which gets
> loaded with kernel modules. The "description" of the events is saved in the
> trace, in a special low traffic channel (small buffers with a separate file).
>

But these events still need the marker in the source code right?


> > >
> > > * Probe placement
> > >
> > > What makes debugging information based probe placement unsuitable as the only
> > > option for LTTng :
> >
> > First thing which is a key point:  "only option"  OK, while reading that
> > nasty thread, I saw that LTTng can still function when certain features
> > are not present.  Basically, convert all posible static tracepoints into
> > dynamic ones and make a code base for that.  Have a patch to convert
> > critical trace points that are not suitable for performance into static
> > traces, and also add static traces that were not able to be done by
> > dynamic ones.  This way you have a functioning LTTng in the kernel (if the
> > resistance falls by doing this), and still maintaing a patch for a "value
> > added" to your customers. Perhaps call it "Turbo LTTng" ;-)
> >
>
> I won't try to convert all the existing "marker" based trace points into
> dynamic ones, as I see no real use of it in the long run. However, I would
> really like to see a kprobe based instrumentation being a little more nicely
> integrated with LTTng (and it is not hard to do!).

That should definitely be a step. If I'm understanding this (which I may
not be), you can have a dynamic event added with also using dynamic
trace points like kprobes.

>
> > Basically, Mathieu, I want to help you get this into the kernel.  I could
> > be wrong, since I'm only a spectator, and not really involved on either
> > side. But I have been reading LKML long enough to have an idea of what it
> > takes.
> >
> > If you can modulize LTTng further down. Add non intrusive parts to the
> > kernel.  If you can make a LTTng functional (but "crippled" due to the
> > limitations you are saying) and have it doing what the ney-sayers want,
> > you will have a better time getting it accepted.  Once accepted, it will
> > be a lot easier to add controversial things than it is to add it before
> > any of it is accepted.
> >
>
> Yes, that's why I am splitting my projects in parts "markers, tracer, control,
> facilities, ..." and plan to keep the most intrusives as an external patchset
> for the moment. Anyway, the marker-probe mechanism lets me put all the
> serialization code inside probes external to the kernel, which can be connected
> either with the "marker" mechanism or with kprobes, it doesn't matter.
>
> Thanks for your hints,

No prob, I should read the rest of the thread, and try to catch up more,
before posting more comments.

Later,

-- Steve

