Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWJESJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWJESJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWJESJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:09:57 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54000 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751768AbWJESJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:09:56 -0400
Date: Thu, 5 Oct 2006 14:09:16 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
In-Reply-To: <20061005170132.GA11149@Krystal>
Message-ID: <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com>
References: <1160025104.6504.30.camel@localhost.localdomain>
 <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
 <20061005170132.GA11149@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Oct 2006, Mathieu Desnoyers wrote:

>
> Usage of LTTng that I am aware of are not limited to analysis : some users,
> Autodesk for instance, use its user space tracing capabilities extensively to
> find deadlocks and deadline misses in their video applications. That I have
> found is that having both some general overview of the system in the same trace
> where the debugging information sits is a very powerful aid to developers.
>

Well, I never said it wasn't good for debugging :-)  But then again, when
someone does an analysis, that can be argued that they are also debugging.
Why analyze when the system works 100% efficiently :-P


> > When things slow down for me a little, I'll see where you are at, and take
> > a look.  Something we can also discuss at the next OLS.
> >
>
> Sure, I'll be glad to discuss about it.

OK, I'll bring a notebook.

>
> > To logdev, speed of the trace is important, but not that important.
> > Accuracy of the trace is the most important.  Originally, I had a single
> > buffer, and would use spinlocks to protect it.  All CPUs would share this
> > buffer. The reason for this, is I wanted simple code to prove that the
> > sequence events really did happen in a certain order.  I just recently
> > changed the ring buffer to use a lockless buffer per cpu, but I still
> > question it's accuracy. But I guess it does make things faster now.
> >
>
> That's why I directly use the timestamp counter (when synchronized) of the CPUs.
> I do not rely on the kernel time base when it is not needed. As I use the
> timestamps to merge the events from the multiple buffers, they must be as
> accurate as possible.

My problem with using a timestamp, is that I ran logdev on too many archs.
So I need to have a timestamp that I can get to that is always reliable.
How does LTTng get the time for different archs?  Does it have separate
code for each arch?

> > I know I said I'm staying out of the debate, but I need to ask this
> > anyway.  Couldn't LTTng be fully implemented with dynamic traces? And if
> > so, then what would be the case, to get that into the kernel, and then
> > maintain a separate patch to convert those dynamic traces into static
> > onces where performance is critical.  This way, you can get the
> > infrastructure into the kernel, and get more eyes on it. Also make the
> > patch smaller.
> >
>
> It its current state, LTTng is already splitted into such pieces. The parts
> that are the most highly reusable are :
>
> - Code markup mechanism (markers)

Is this the static marks everyone is fighting over?

> - Serialization mechanism (facilities) within probes (ltt-probes kernel
>   modules) dynamically connected to markers.

Sorry, I don't really understand what the above is.  Is it a loadable
module that connects to the static markers?  You might need to dumb this
one down for me.


> - Tracing control mechanism (ltt-tracer, ltt-control)

Is this in kernel or tools?

> - Buffer management mechanism (ltt-relay)

So this uses the current relay system?


>
> To answer your question, I will distinguish elements of this "dynamic"
> term that is so widely used :

Ah, terminology. I've never been good at that.  I've programmed in an
Object oriented fashion years before I knew what object oriented was :P

So when I talk about dynamic, I'm really talking about a way to cause a
trigger for tracing inside the kernel, without actually modifying that
kernel source to do so.  So currently today in the vanilla kernel, we can
statically place  a marker  (some macro, like I have in logdev: ldprint)
or something that modifies the binary code or uses some hardware mechanism
to trigger it (such as kprobes, which as of yesterday, logdev does that
too).

The greatest resistance that I currently see with LTTng is the adding of
static trace points.  So if LTTng isn't fully crippled by working with
dynamic addition of trace point (unmodifying the code), then try to get
that in first. See below.

>
> * Dynamic probe connexion
>
> LTTng 0.6.0 now supports dynamic probe connexion on the markers. A probe is a
> dynamically loadable kernel module. It supports load/unload of these modules.

But are the markers still static?  I'm confused her. Not sure what it
means to have a kernel module do a dynamic probe connexion on a marker.
In logdev, I use to have the tracepoints have crazy macros so that I can
load and unload the logdev main module.  But I still needed to have hooks
into the kernel.  I finally got rid of that support and by doing so I
cleaned up logdev quite a bit.


>
> * Dynamic registration of new events/event record types
>
> LTTng supports such dynamic registration since the 0.5.x series.

I feel really stupid!  What do you define as an event, and how would
one add a new one dynamically.

>
> * Probe placement
>
> What makes debugging information based probe placement unsuitable as the only
> option for LTTng :

First thing which is a key point:  "only option"  OK, while reading that
nasty thread, I saw that LTTng can still function when certain features
are not present.  Basically, convert all posible static tracepoints into
dynamic ones and make a code base for that.  Have a patch to convert
critical trace points that are not suitable for performance into static
traces, and also add static traces that were not able to be done by
dynamic ones.  This way you have a functioning LTTng in the kernel (if the
resistance falls by doing this), and still maintaing a patch for a "value
added" to your customers. Perhaps call it "Turbo LTTng" ;-)


> - inability to extract all the local variables

Some comments about the above. This is interesting and not always needed.
As with kgdb, we can't look at all local valiables since gcc may optimize
them out.  But I've never needed to know a local variable unless I was
debugging that code.  Which usually means that I add my static tracing
with logdev until I find the bug, and then remove the tracing.

So local variable tracing is not a good candidate for a static tracing to
be put in the kernel anyway.

I'm not saying on a dynamic only LTTng, to strip out the static tracing
abilities.  I'm saying that it just wont be using them when brought into
the kernel.  But the patch can still use them, and those that are
debugging the kernel can pull in your patch.


> - performance impact

Yes, good point!  But when people see the problem, they will find a way
to fix in.  In the mean time, those that need the performance, can still
use your "Turbo LTTng".

Also, if the dynamic trace points never fit the needs of LTTng, if LTTng
were in the kernel there would be more pressure on the kernel developers
to add the static trace points in the critical sections.  That is assuming
that the dynamic trace points can't be fixed.

> - inability to follow the kernel code changes as well as a marker inserted
>   in the code itself.

This one I will argue against.  Basically, if you have a static trace
point, it too can be moved around and "broken" by the maintainer of that
code.  There's times that I've submitted patches ignoring the effect it
would have on some accounting code.  Simply because I don't know what that
accounting code does, and didn't care.  The same will happen with the
tracing code.  If the maintainer, doesn't fully understand what is being
traced, and changes the code, they might just break the tracing tool.  Now
someone, like you, will need to submit a patch to fix that static marker.
And here is where we get into the burden part. Because now the maintainer
of the said code needs to make sure that your patch didn't break anything
else.

A dynamic trace point won't ever bother the maintainer.  But it may still
break. When it does, you just fix your dynamic part and go on. No one will
be bothered except the ones that use your stuff.

Also, and this is the cool part (IMHO), this will drive more inovation in
what the kernel can do with the compiler.  Like having a debug setting in
the compiler where the dynamic trace point adder can read the code better
and see what to do with it.  As you mentioned about my logdev reading an
offset.  Have gdb tricks to automatically find things for you.  All your
tools will need is a vmlinux build for the running kernel.

I need to understand how gdb gets its info better, and use that to really
extract things dynamically.

Basically, Mathieu, I want to help you get this into the kernel.  I could
be wrong, since I'm only a spectator, and not really involved on either
side. But I have been reading LKML long enough to have an idea of what it
takes.

If you can modulize LTTng further down. Add non intrusive parts to the
kernel.  If you can make a LTTng functional (but "crippled" due to the
limitations you are saying) and have it doing what the ney-sayers want,
you will have a better time getting it accepted.  Once accepted, it will
be a lot easier to add controversial things than it is to add it before
any of it is accepted.

Just a thought.

Cheers,

-- Steve

