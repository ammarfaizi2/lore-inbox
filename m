Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbUJ0WmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUJ0WmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUJ0Wim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:38:42 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:2316 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262955AbUJ0WgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:36:11 -0400
Date: Wed, 27 Oct 2004 15:35:47 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041027223547.GA613@nietzsche.lynx.com>
References: <20041023194721.GB1268@us.ibm.com> <417F12F1.5010804@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F12F1.5010804@opersys.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 11:16:01PM -0400, Karim Yaghmour wrote:
> I've been trying not to get too involved in this, though I've been
> personally very interested in the topic of obtaining deterministic
> response times from Linux for quite some time. Ingo's work is
> certainly gathering a lot of interest, and he's certainly got the
> brains and the can-do mindset that warrant a wait-and-see attitude.

No, this needs to be discussed. And the development process is moving
faster than I've ever anticipated.

> I must admit though that I'm somewhat skeptical/worried. The issue
> for me isn't whether Linux can actually become deterministic. This
> kernel has reached heights which many of its detractors never
> believed it could, it has come a long way. So whether it _could_
> better/surpass existing RT-Unixes (such as LynxOS or QNX for example)
> in terms of real-time performance is for me in the realm of the
> possible.

It's possible. Our company (the makers of LynxOS, Lynuxworks) is
betting on it or else I would have no context to work here.

> That the Linux development community has to answer the question of
> "how do we provide deterministic behavior for users who need it?"

The biggest groups of folks I can identify is the multimedia folks.
Their applications are the most system loaded out of all of the
applications on this planet, deterministic latency, heavy CPU usage,
heavy disk load and manical temporal control via frame schedulers, etc...

This stuff has direct application to DVRs (digital video recorders)
and other things that only SGI and BeOS machines could do in their
day.

> was, as for the kernel developers of most popular Unixes, just a
> matter of time. And in this regard, this is a piece of history that
> is yet to be written: What is the _correct_ way to provide
> deterministic response times in a Unix environment?

It's going to be driven by the application. Never lose sight of the
fact that kernel is suppose to support applications, not the other
way around. Kernel programmers forget that fact and app programmers
pay the price with inferior performing kernels as a result of that
attitude.

[comments about Ingo's effort]

> Yet, I believe that this is a case where the concepts do actually
> matter a lot, and that no amount of published code will erase the
> fundamental question: What is the _correct_ way to provide
> deterministic response times in a Unix environment? I keep
> highlighting the word "correct" because it's around this word's
> definition that the answer probably lies.

A new scheduler would probably be needed to drive the system and I'm
betting on pervasively threaded QoS through all of the IO systems with
those QoS threads controlled by that scheduler. This is minimally
required for VoIP applications and the like. QoS is going to be king
in the next few years.
 
> My take on this has been that the "correct" way to provide
> deterministic response times in a Unix environment should minimize
> in as much as possible:
...
> a) the modifications to the targeted kernel's existing API,
> behavior, source code, and functionality in general;

IMO, little or no change should happen other than supporting basic
Posix RT facilities and possibly userspace drivers.

> b) the burden for future mainstream kernel development efforts;
> c) the potential for accidental/casual use of the hard-rt
> capabilities, as this would in itself result in loss of
> deterministic behavior;

Like with any new system, it's going to take training and time
for folks to figure this out. These patches are some of the most
important in the history of the Linux kernel and it's going to
ultimately have a strong effect on the general kernel community
as well. Hopefully, it won't clash with it, but it's almost
unavoidable. It's probably better to minimize the clash as much
as possible to minimize the adjustment.

The only other project that I know of in open source that's doing
roughly what we're doing is FreeBSD SMPng. Many of the preemption/locking
issue have direct analogs to that project and I use concepts from
the BSD/OS SMPng code in it as a guide for future development. So
one can use that as a guide for how this project might unfold and
I've been doing that. The "WITNESS" facility, etc.. :)

> Also, it should be:

> a) architectured in a way that enables straight-forward
> extension of the real-time capabilities/services without requiring
> further modifications to the targeted kernel's existing API,
> behavior, sources, and functionality in general;

uber-preemption makes the entire kernel hard RT. The question here
for me is scheduling policy for non-RT tasks outside of the
deterministic application domain.

> b) truly deterministic, not simply time-bound by some upper
> limit found during a sample test run;

That's going to come in the future, you can bet on it. It's just that
stability and correctness are major issues at this times since the
kernel just went through some major surgery. It's expected.

> c) _very_ simple to use without, as I said above, having the
> potential of being accidentally or casually used (such a solution
> should strive, in as much as possible, to provide the same API as
> the targeted Unix kernel);

That, to me, is a system-wide scheduling policy. It doesn't exist
as of yet and I'm sure that it's going to be defined in the near
future.

> d) easily portable to new architectures, while remaining
> consistent, both in terms of API and in terms of behavior, from
> one architecture to the next;

Not a problem. The vast majority of changes are apart of the core
kernel code, not architecturally bound to the x86. The PowerPC folks,
Benjamin and company, can trivially do a port in less than 2 weeks,
if not a single day.

[comments about the "Adeos/RT-nucleus/RTAI-fusion" approach]

This is a good approach, but the limitations to this are things that
require access to the full Linux XFS facilities from SGI. This requires
low level IO subsystems, etc... to be preemptable so that deadlines
can be met and other things.

> One argument that has been leveled against this approach by those
> who champion the vanilla-Linux-should-become-hard-rt cause (many
> of whom are now in the uber-preemption camp) is that it requires
> writing separate real-time drivers. Yet, this argument contains

Not a problem. Clean up is being handled now and drivers that are
abusing things by spinning under disabled preemption are the next
in line to be cleaned up.

> a fatal flaw: drivers do not become deterministic by virtue of
> running on an RTOS. IOW, even if Linux were to be made a Unix RTOS,
> every single driver in the Linux sources would still have to be
> rewritten with determinism in mind in order to be used in a
> system that requires hard-rt. This is therefore a non-issue.

Current latency tracing and bleeding edge reports should point
these places out. These problem places are getting hammered out
often within an hour. This isn't a problem since most drivers are
written well as far as I can see.

> Which brings me back to what you said above: "The problem is that
> the entire OS kernel must be modified to ensure that all code paths
> are deterministic." There are two possible paths here.
> 
> Either:
> a) Most current kernel developers intend to eventually convert the
> entire existing code-base into one that contains deterministic
> code paths only, and therefore impose such constraints on all future
> contributors, in which case the path to follow is the one set by
> the uber-preemption folks;

The impact so far has been minimal. It's going to cramp on a few
style points, minimal impact, but the systems will be clearer in the
end.

> or:
> b) Most current kernel developers intend to keep Linux a general
> purpose Unix OS which mainly serves a user-base that does not need
> deterministic hard-rt behavior from Linux, and therefore changes
> for providing deterministic hard-rt behavior are acceptable only
> if they are demonstrably minimal, non-instrusive, yet flexible
> enough for those that demand hard-rt, in which case the path to
> follow is the one set by the nanokernel/hyperviser folks;
> 
> So which is it?

This is a non-issue. the uber-preemption folks will continue to do
what they've/we've been doing and it just opens up more opportunities
for dual-domain RT folks. One doesn't exclude from the other.

I'm aiming for single kernel RT since media applications are more
API demanding than classic RT applications.

> [ You'll have to excuse the pace of my participation to this thread,
> I'm giving 9-to-5 training all week. I'll respond as time permits. ]

I hope this was useful. :)

bill

