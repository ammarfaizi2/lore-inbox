Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSGJFm1>; Wed, 10 Jul 2002 01:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317474AbSGJFm0>; Wed, 10 Jul 2002 01:42:26 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:3859 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S317473AbSGJFmX>; Wed, 10 Jul 2002 01:42:23 -0400
Message-ID: <3D2BCA1A.2E08B3F1@opersys.com>
Date: Wed, 10 Jul 2002 01:46:02 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>,
       bob <bob@watson.ibm.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
References: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com> <3D29DCBC.5ADB7BE8@opersys.com> <20020710022208.GA56823@compsoc.man.ac.uk> <3D2BB505.889304A8@opersys.com> <20020710043844.GA69117@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Levon wrote:
> > And the list goes on.
> 
> Sure, there are all sorts of things where some tracing can come in
> useful. The question is whether it's really something the mainline
> kernel should be doing, and if the gung-ho approach is nice or not.

I'm not sure how to read "gung-ho approach" but I would point out that
LTT wasn't built overnight. It's been out there for 3 years now.

As for whether the mainline kernel should have it or not, then I
think the standard has always been set using the actual purpose:
Is this useful to users or is this only useful to kernel developers?
Whenever it was the later, then the answer has almost always been NO.
In the case of tracing I think that not only is it "useful" to users,
but I would say "essential". Would you ask a user to recompile his
kernel with a ptrace patch because he needs to use gdb? I don't
think so, and I don't think application developers or system
administrators should have to recompile their kernel either in
order to understand the system' dynamics.

If facts are of interest, then I would point out that LTT is already
part of a number of distributions out there. Most other distros that
don't have it included find it very useful but don't want to get
involved in maintaining it until it's part of the kernel.

> > The fact that so many kernel subsystems already have their own tracing
> > built-in (see other posting)
> 
> Your list was almost entirely composed of per-driver debug routines.

I don't see any contradiction here. This is part of what I'm pointing out.
Mainly that understanding the dynamic behavior of the system is essential
to software development, especially when complex interactions, such as
in the Linux kernel, take place.

> This is not the same thing as logging trap entry/exits, syscalls etc
> etc, on any level, and I'm a bit perplexed that you're making such an
> assocation.

In regards to trap entry/exits, there was a talk a couple of years ago
by Nat Friedman, I think, which discussed GNU rope. Basically, it
identified the location of page fault misses at the start of programs
and used this information to reorder the binary in order to accelerate
its load time. That's just one example where traps are of interest.

Not to mention that traps can result in scheduling changes and that
knowing why a process has been scheduled out is all part of understanding
the system's dynamics.

As for syscalls, oprofile, for one, really needs this sort of info. So
I don't see your point.

There are 2 things LTT provides in the kernel:
1- A unified tracing and high-throughput data-collection system
2- A select list of trace points in the kernel

Item #1 can easily replace the existing ad-hoc implementation while
serving oprofile, DProbes and others. Item #2 is of prime interest
to application developers and system administrators.

> > expect user-space developers to efficiently use the kernel if they
> > have
> > absolutely no idea about the dynamic interaction their processes have
> > with the kernel and how this interaction is influenced by and
> > influences
> > the interaction with other processes?
> 
> This is clearly an exaggeration. And seeing as something like LTT
> doesn't (and cannot) tell the "whole story" either, I could throw the
> same argument directly back at you. The point is, there comes a point of
> no return where usefulness gets outweighed by ugliness. For the very few
> cases that such detailed information is really useful, the user can
> usually install the needed special-case tools.

I'd really be interested in seing what you mean by "ugliness". If there's
a list of grievances you have with LTT then I'm all ears.

Anything inserted by LTT is clean and clear. It doesn't change anything
to the kernel's normal behavior and once a trace point is inserted it
requires almost zero maintenance. Take for example the scheduling change
trace point (kernel/sched.c:schedule()):
	TRACE_SCHEDCHANGE(prev, next);

I don't see why this should be ugly. It's an inline that results in
zero lines of code if you configure tracing as off.

The cases I presented earlier clearly show the usefullness of this
information. The developer who needs to solve his synchronization
problem or the system administrator who wants to understand why his
box is so slow doesn't really want to patch/recompile/reboot to fix
his problem.

You would like to paint these as "very few cases". Unfortunately
these cases are much more common than you say they are.

> In contrast a profiling mechanism that improves on the poor lot that
> currently exists (gprof, readprofile) has a truly general utility, and
> can hopefully be done without too much ugliness.

Somehow it is not justifiable to add a feature the like of which didn't
exist before but it is justifiable to add a feature which only "improves"
on existing tools?

As I said before, LTT and the information it provides has a truly
general utility: Oprofile can use it, DProbes uses it, a slew of existing
ad-hoc tracing systems in the kernel can be replaced by it, application
developers can isolate synchronization problems with it, system
administrators can identify performance bottlenecks with it, etc.

An argument over which is more useful between LTT and oprofile is bound
to be useless. If nothing else, I see LTT as having a more general use
than oprofile. But let's not get into that. What I'm really interested in
here is the possibilty of having one unified tracing and data collection
system which serves many purposes instead of having each subsystem or
profiler have its own tracing and data collection mechanism.

> The primary reason I want to see something like this is to kill the ugly
> code I have to maintain.

I can't say that my goals are any different.

> > > The entry.S examine-the-registers approach is simple enough, but
> > > it's
> > > not much more tasteful than sys_call_table hackery IMHO
> >
> > I guess we won't agree on this. From my point of view it is much
> > better
> > to have the code directly within entry.S for all to see instead of
> > having some external software play around with the syscall table in a
> > way kernel users can't trace back to the kernel's own code.
> 
> Eh ? I didn't say sys_call_table hackery was better. I said the entry.S
> thing wasn't much better ...

I know you weren't saying that. I said that in _my point of view_ the entry.S
"thing" is much better.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
