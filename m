Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWJEUvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWJEUvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWJEUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:51:17 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:62443 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932179AbWJEUvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:51:14 -0400
Date: Thu, 5 Oct 2006 16:50:55 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
Message-ID: <20061005205055.GB1865@Krystal>
References: <1160025104.6504.30.camel@localhost.localdomain> <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com> <20061005170132.GA11149@Krystal> <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:25:33 up 43 days, 17:34,  8 users,  load average: 0.04, 0.17, 0.28
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> My problem with using a timestamp, is that I ran logdev on too many archs.
> So I need to have a timestamp that I can get to that is always reliable.
> How does LTTng get the time for different archs?  Does it have separate
> code for each arch?
> 
See my answer to Daniel Walker on this one.

> > It its current state, LTTng is already splitted into such pieces. The parts
> > that are the most highly reusable are :
> >
> > - Code markup mechanism (markers)
> 
> Is this the static marks everyone is fighting over?
> 

I consider that the previous discussion let to a general concensus where it has
been recognised that marking the code is generally acceptable and needed. As a
personal initiative following this discussion, I proposed a marker mechanism,
iterated for 2 weeks, and it is now at the 0.20 release. It went through about 3
complete rewrites during the process, but it seems that most objections has been
answered.

This week, I ported LTTng to the marker mechanism by creating "probes", which
are the dynamically loadable modules that connects to the markers.

> > - Serialization mechanism (facilities) within probes (ltt-probes kernel
> >   modules) dynamically connected to markers.
> 
> Sorry, I don't really understand what the above is.  Is it a loadable
> module that connects to the static markers?  You might need to dumb this
> one down for me.
>

Ok,

A marker, in my implementation, is a statement placed in the code, i.e. :

MARK(kernel_sched_schedule, "%d %d %ld", prev->pid, next->pid, prev->state);

A probe is a dynamically loadable module which implements a callback, i.e. :


#define KERNEL_SCHED_SCHEDULE_FORMAT "%d %d %ld"
void probe_kernel_sched_schedule(const char *format, ...)
{
        va_list ap;
        /* Declare args */
        int prev_pid, next_pid;
        long state;

        /* Assign args */
        va_start(ap, format);
        prev_pid = va_arg(ap, typeof(prev_pid));
        next_pid = va_arg(ap, typeof(next_pid));
        state = va_arg(ap, typeof(state));

        /* Call tracer */
        trace_process_schedchange(prev_pid, next_pid, state);

        va_end(ap);
}

Which, in my case, takes the variable arguments of the marker call and gives
them to my inline tracing function.

trace_process_schedchange is the "serialization" mechanism which takes its input
(arguments) and writes them in a event record in the buffers, dealing with
reentrancy.


> 
> > - Tracing control mechanism (ltt-tracer, ltt-control)
> 
> Is this in kernel or tools?
> 

I am absolutely not talking about the user space tools here, only kernel code.
This would be another discussion :)

In fact, ltt-control is the netlink interface that helps user space controlling
the tracer. It's not mandatory : the tracer can be controlled from within the
kernel too (useful for embedded systems).

> > - Buffer management mechanism (ltt-relay)
> 
> So this uses the current relay system?
> 

Yes, but I do my own synchronization. I implement my own reserve/commit and I
also export my own ioctl and poll to communicate with the user space buffer
reading daemon.

> The greatest resistance that I currently see with LTTng is the adding of
> static trace points.  So if LTTng isn't fully crippled by working with
> dynamic addition of trace point (unmodifying the code), then try to get
> that in first. See below.
> 

My first goal is to have the infrastructure in, without the instrumentation. And
yes, I want to connect this infrastructure with a nice dynamic instrumentation
tool like logdev or systemtap, as it will give fast usability of the
infrastructure to a user base.

> >
> > * Dynamic probe connexion
> >
> > LTTng 0.6.0 now supports dynamic probe connexion on the markers. A probe is a
> > dynamically loadable kernel module. It supports load/unload of these modules.
> 
> But are the markers still static?  I'm confused her. Not sure what it
> means to have a kernel module do a dynamic probe connexion on a marker.
> In logdev, I use to have the tracepoints have crazy macros so that I can
> load and unload the logdev main module.  But I still needed to have hooks
> into the kernel.  I finally got rid of that support and by doing so I
> cleaned up logdev quite a bit.
> 

Yes, a marker is a low performance impact hook in the kernel (I jump over the
call when the marker is disabled).

> 
> >
> > * Dynamic registration of new events/event record types
> >
> > LTTng supports such dynamic registration since the 0.5.x series.
> 
> I feel really stupid!  What do you define as an event, and how would
> one add a new one dynamically.
> 

Please don't :) Defining a new event would be to say :

I want to create an event named "schedchange", which belongs to the "kernel"
subsystem. In its definition, I say that it will take two integers and a long,
respectively names "prev_pid", "next_pid" and "state".

We can think of various events for various subsystems, and even for modules. It
becomes interesting to have dynamically loadable event definitions which gets
loaded with kernel modules. The "description" of the events is saved in the
trace, in a special low traffic channel (small buffers with a separate file).

> >
> > * Probe placement
> >
> > What makes debugging information based probe placement unsuitable as the only
> > option for LTTng :
> 
> First thing which is a key point:  "only option"  OK, while reading that
> nasty thread, I saw that LTTng can still function when certain features
> are not present.  Basically, convert all posible static tracepoints into
> dynamic ones and make a code base for that.  Have a patch to convert
> critical trace points that are not suitable for performance into static
> traces, and also add static traces that were not able to be done by
> dynamic ones.  This way you have a functioning LTTng in the kernel (if the
> resistance falls by doing this), and still maintaing a patch for a "value
> added" to your customers. Perhaps call it "Turbo LTTng" ;-)
> 

I won't try to convert all the existing "marker" based trace points into
dynamic ones, as I see no real use of it in the long run. However, I would
really like to see a kprobe based instrumentation being a little more nicely
integrated with LTTng (and it is not hard to do!).

> Basically, Mathieu, I want to help you get this into the kernel.  I could
> be wrong, since I'm only a spectator, and not really involved on either
> side. But I have been reading LKML long enough to have an idea of what it
> takes.
> 
> If you can modulize LTTng further down. Add non intrusive parts to the
> kernel.  If you can make a LTTng functional (but "crippled" due to the
> limitations you are saying) and have it doing what the ney-sayers want,
> you will have a better time getting it accepted.  Once accepted, it will
> be a lot easier to add controversial things than it is to add it before
> any of it is accepted.
> 

Yes, that's why I am splitting my projects in parts "markers, tracer, control,
facilities, ..." and plan to keep the most intrusives as an external patchset
for the moment. Anyway, the marker-probe mechanism lets me put all the
serialization code inside probes external to the kernel, which can be connected
either with the "marker" mechanism or with kprobes, it doesn't matter.

Thanks for your hints,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
