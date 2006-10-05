Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWJEPuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWJEPuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWJEPuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:50:06 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42222 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751582AbWJEPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:50:03 -0400
Date: Thu, 5 Oct 2006 11:49:16 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
In-Reply-To: <20061005143133.GA400@Krystal>
Message-ID: <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
References: <1160025104.6504.30.camel@localhost.localdomain>
 <20061005143133.GA400@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Mathieu Desnoyers wrote:

> Hi Steven,
>
> The dynamic abilities of your logdev are very interesting! If I may emit some
> ideas :

Thanks, I appreciate all constructive ideas!

>
> It would be great to have this logging information recorded into a standardized
> buffer format so it could be analyzed with data gathered by other
> instrumentation. Instead of using Tom's relay mechanism directly, you might
> want to have a look at LTTng (http://ltt.polymtl.ca) : it would be a simple
> matter of describing your own facility (group of event), the data types they
> record, run genevent (serialization code generator) and call those
> serialization functions when you want to record to the buffers from logdev.

Hmm, interesting. But at the mean time, what you describe seems a little
out of scope with logdev. This doesn't mean that it can't be applied, now
or later.  But currently, I do use logdev for 90% debugging and 10%
analyzing.  Perhaps for the analyzing part, this would be useful.  I have
to admit, I didn't get far trying to convert LTTng to 2.6.18. Didn't have
the time. Ah, I see you have a patch there now for 2.6.18.  Adding this
would be good to do.  But unfortunately, my time is currently very limited
(who's isn't. But mine currently is more limited than it usually is).

When things slow down for me a little, I'll see where you are at, and take
a look.  Something we can also discuss at the next OLS.


>
> One thing logdev seems to have that LTTng does't currently is the integration
> with a mechanism that dumps the output upon a crash (LKCD integration). It's no
> rocket science, but I just did not have time to do it.

heehee, in pine the "no" was cut off by my 80 cols, and it looked like
"It's rocket science".  Well if it _was_ rocket science, I wouldn't be
able to do it ;-)

But from that really bright thread (lit up mainly by the flames), there
was strong talk about LTTng not tracing for debugging.  It _can_ be a
debugging tool, but that's not its main purpose. It is an analyzing tool.
Logdev _was_ written to be a debugging tool, and that is why I never
pushed to hard to get it into the kernel. Because, mainly, it was used for
kernel hackers only.

This is why the output of the crashes is very important for Logdev, and
not so important for LTTng.  Logdev's biggest asset was the ability to
find deadlocks.  The output always showed the order of events between
processors, and time and time again, I've submitted race condition
fix patches to the kernel, to the -rt patch and even to tglx's hrtimer
work.

To logdev, speed of the trace is important, but not that important.
Accuracy of the trace is the most important.  Originally, I had a single
buffer, and would use spinlocks to protect it.  All CPUs would share this
buffer. The reason for this, is I wanted simple code to prove that the
sequence events really did happen in a certain order.  I just recently
changed the ring buffer to use a lockless buffer per cpu, but I still
question it's accuracy. But I guess it does make things faster now.

>
> I think it would be great to integrate those infrastructures together so we can
> easily merge information coming from various sources (markers, logdev, systemTAP
> scripts, LKET).

The one argument I have against this, is that some of these have different
objectives.  Merging too much can dilute the objective of the app.  But I
do think that a cooperation between the tools would be nice.


>
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > 1. break point and a watch address
> >
> > This simply allows you to set a break point at some address (or pass in
> > a function name if it exists in kallsyms).
> >
> > logprobe -f hrtimer_start  -v jiffies_64
> >
> Does it automatically get the data type, or is there any way to specify it ?

Not yet, but all of the kprobes code for logdev was written in about 26
hours.  And really because I lost access to the Internet, did I do so
much.  I got to get back to other things, so the progress will once again
slow down to almost a halt.

I would really like to integrate the logdev tools with gdb so that I can
load the vmlinux kernel and get all sorts of good stuff.

But that's not going to happen in 26 hours :-)

I also need to learn how to do that.

>
> >
> > 2. break point and watch from current
> >
> > This allows a user to see something on the current task_struct. You need
> > to know the offset exactly. In the below example, I know that 20 (dec)
> > is the offset in the task_struct to lock_depth.
> >
> > example:
> >
> > logprobe -f schedule -c 20 "lock_depth"
> >
> > produces:
> >
> >   [ 8757.854029] cpu:1 sawfish:3862 func: schedule (0xc02f8320) lock_depth index:20 = 0xffffffff
> >
>
> Could we think of a quick hack that would involve using gcc on stdin and return
> an "offsetof", all in user-space ?

Have an idea, I'd love to see it!

>
> >
> > 3. break point and watch fixed type
> >
> > This is a catch all for me. I currently only implement preempt_count.
> >
> >
> >  logprobe -t pc -f _spin_lock
> >
> > produces:
> >
> >    [ 9442.215693] cpu:0 logread:6398 func: _spin_lock (0xc02fab9d)  preempt_count:0x0
> >
> Ouch, I can imagine the performance impact of this breakpoint though :) This is
> a case where marking the code helps a lot.

True, but it also matters what you write.  My old static tracing still
noticeably slowed down the system.  But this thread is _not_ about
static vs dynamic, that's been beaten to death already and I don't want
to be involved in that debate until the emotions calm down (like that has
ever happened on LKML).

But the above really didn't slow the system down too noticeably.

>
>
> Regards,
>
> Mathieu

Well Mathieu, thanks a lot for taking the time to look at the code.  I'd
like to know more about LTTng too, and understand it better.  Hopefully,
when things slow down a little I will.

I know I said I'm staying out of the debate, but I need to ask this
anyway.  Couldn't LTTng be fully implemented with dynamic traces? And if
so, then what would be the case, to get that into the kernel, and then
maintain a separate patch to convert those dynamic traces into static
onces where performance is critical.  This way, you can get the
infrastructure into the kernel, and get more eyes on it. Also make the
patch smaller.

As you stated, there can be more users than LTTng to what gets into the
kernel.  Now, grant you, I don't know LTTng too well, so all this that I'm
saying could just be coming out of my butt. But from what I did read,
LTTng is a _good_ tool, and should be supported.  It just seems that the
method isn't accepted.

I've learned a lot from Ingo and Thomas.  One thing I watch them do with
the -rt patch was to get small pieces into the kernel, a little at a time.
But these pieces got into the kernel not because it came from Ingo, but
because they actually benefited other parts of the kernel.

Like relay getting into the kernel, that was a part of LTT that helped
other parts of the kernel.  So if there is an underlining infrastructure
that can be used by multiple systems, then that should be something to
strive for.

So if you convert LTTng to use dynamic traces only (for now), and that
gets accepted into the kernel, you will then have a larger user base of
LTTng.  Yes, the performance may be a problem, but you have a separate
patch (as you do now) to change to static tracing for those that need the
performance.  But in the mean time, you have those that can use it without
recompiling their kernel.

Now heres the kicker!

When the demand comes to make LTTng (that's in the kernel) perform better,
then the kernel developers will feel the pressure to either introduce
static tracing in critical points, or fix up the dynamic tracing to
perform better.

As Ingo showed in the thread.  He added code to speed up kprobes. This was
done just because it was noticed that kprobes was slow. It will never be
done if no one notices.  But as soon as there is a demand for speed on
that system, there will be lots of good ideas coming out to make it
better.

So I personally am not for or against static tracing, because simply I
don't mind patching my own kernel, and I'm not maintaining it.  Logdev was
used to add static tracing quickly.  Logdev started in the 2.1 kernel, and
is now at 2.6.18.  I've seldom had problems porting it.  The most
difficult port (which took 2 hours) was to the -rt patch.  And that was
just because my tracing had to be aware of spinlocks turning into mutexes,
and interrupts not really being disabled.

But the moral here is that logdev was as much contained out of the kernel,
and I could just slam in trace points when needed.  After a bug was found,
I removed all them right away. (thank God for subversion and quilt).

Just some thoughts. Although I'm sure I'm going to regret bringing this
back up. :-/

Tschuess,

-- Steve
