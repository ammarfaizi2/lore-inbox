Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUJ0D1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUJ0D1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJ0D1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:27:30 -0400
Received: from opersys.com ([64.40.108.71]:18700 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261621AbUJ0DYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:24:44 -0400
Message-ID: <417F12F1.5010804@opersys.com>
Date: Tue, 26 Oct 2004 23:16:01 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC][PATCH] Restricted hard realtime
References: <20041023194721.GB1268@us.ibm.com>
In-Reply-To: <20041023194721.GB1268@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> Attaining hard-realtime response in an existing general-purpose operating
> system has been seen as a "big-bang" conversion.  The problem is that
> the entire OS kernel must be modified to ensure that all code paths
> are deterministic.  It would be much better if there was an evolutionary
> path to hard realtime.

I've been trying not to get too involved in this, though I've been
personally very interested in the topic of obtaining deterministic
response times from Linux for quite some time. Ingo's work is
certainly gathering a lot of interest, and he's certainly got the
brains and the can-do mindset that warrant a wait-and-see attitude.

I must admit though that I'm somewhat skeptical/worried. The issue
for me isn't whether Linux can actually become deterministic. This
kernel has reached heights which many of its detractors never
believed it could, it has come a long way. So whether it _could_
better/surpass existing RT-Unixes (such as LynxOS or QNX for example)
in terms of real-time performance is for me in the realm of the
possible.

That the Linux development community has to answer the question of
"how do we provide deterministic behavior for users who need it?"
was, as for the kernel developers of most popular Unixes, just a
matter of time. And in this regard, this is a piece of history that
is yet to be written: What is the _correct_ way to provide
deterministic response times in a Unix environment?

Like in most other circumstances, the Linux development community's
approach to this has been: show me the code! In that regard (and
this is in no way criticism of anyone's work),  Ingo's work has
gathered a lot of interest not because it is breaking new ground
in terms of the concepts, but largely because of its very rapid
development pace. Let's face it, no self-respecting effort that has
ever labeled itself as wanting to provide "hard real-time Linux"
has been active on the LKML on the same level as Ingo (though many
have concentrated a lot of effort and talent on other lists.)

Yet, I believe that this is a case where the concepts do actually
matter a lot, and that no amount of published code will erase the
fundamental question: What is the _correct_ way to provide
deterministic response times in a Unix environment? I keep
highlighting the word "correct" because it's around this word's
definition that the answer probably lies.

Here are a number of solutions that some have found to be "correct"
for their needs over time, in chronological order of appearance:
a- Master/slave kernel (ex.: RTLinux)
b- Dual-CPU (there are actually many examples of this, some that
    date back quite a few years)
c- Interrupt levels (ex.: D.Schleef, B.Kuhn, etc.)
d- Nanokernel/Hypervisor (ex.:Adeos)
e- Preemption
f- Uber-preemption and IRQ threading (a.k.a. preemption on acid)
    (ex.: Ingo, TimeSys, MontaVista, Bill)

My take on this has been that the "correct" way to provide
deterministic response times in a Unix environment should minimize
in as much as possible:
a) the modifications to the targeted kernel's existing API,
behavior, source code, and functionality in general;
b) the burden for future mainstream kernel development efforts;
c) the potential for accidental/casual use of the hard-rt
capabilities, as this would in itself result in loss of
deterministic behavior;

Also, it should be:
a) architectured in a way that enables straight-forward
extension of the real-time capabilities/services without requiring
further modifications to the targeted kernel's existing API,
behavior, sources, and functionality in general;
b) truly deterministic, not simply time-bound by some upper
limit found during a sample test run;
c) _very_ simple to use without, as I said above, having the
potential of being accidentally or casually used (such a solution
should strive, in as much as possible, to provide the same API as
the targeted Unix kernel);
d) easily portable to new architectures, while remaining
consistent, both in terms of API and in terms of behavior, from
one architecture to the next;

 From all the solutions that have been put forth over the years, I
have found that the nanokernel/hypervisor solution fits this
description of correctness best. The Adeos/RT-nucleus/RTAI-fusion
stack is one implementation I have been promoting, as it has
already reached important milestones. All that is needed for it
to work is the necessary hooks for Adeos to hook itself into
Linux by way of an interrupt pipeline; the latter being very simple,
portable and non-intrusive, yet could not accidentally/casually
be used without breaking. This interrupt pipeline is all that
is required for the rest of the stack to provide the services I
have alluded to in other postings by means of loadable modules,
including the ability to transparently service existing Linux
system calls via RTAI-fusion for providing applications with hard-
rt deterministic behavior.

One argument that has been leveled against this approach by those
who champion the vanilla-Linux-should-become-hard-rt cause (many
of whom are now in the uber-preemption camp) is that it requires
writing separate real-time drivers. Yet, this argument contains
a fatal flaw: drivers do not become deterministic by virtue of
running on an RTOS. IOW, even if Linux were to be made a Unix RTOS,
every single driver in the Linux sources would still have to be
rewritten with determinism in mind in order to be used in a
system that requires hard-rt. This is therefore a non-issue.

Which brings me back to what you said above: "The problem is that
the entire OS kernel must be modified to ensure that all code paths
are deterministic." There are two possible paths here.

Either:
a) Most current kernel developers intend to eventually convert the
entire existing code-base into one that contains deterministic
code paths only, and therefore impose such constraints on all future
contributors, in which case the path to follow is the one set by
the uber-preemption folks;

or:
b) Most current kernel developers intend to keep Linux a general
purpose Unix OS which mainly serves a user-base that does not need
deterministic hard-rt behavior from Linux, and therefore changes
for providing deterministic hard-rt behavior are acceptable only
if they are demonstrably minimal, non-instrusive, yet flexible
enough for those that demand hard-rt, in which case the path to
follow is the one set by the nanokernel/hyperviser folks;

So which is it?

[ You'll have to excuse the pace of my participation to this thread,
I'm giving 9-to-5 training all week. I'll respond as time permits. ]

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

