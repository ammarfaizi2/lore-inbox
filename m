Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132710AbRDNCqL>; Fri, 13 Apr 2001 22:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRDNCpv>; Fri, 13 Apr 2001 22:45:51 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:59535 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S132710AbRDNCpq>; Fri, 13 Apr 2001 22:45:46 -0400
Date: Fri, 13 Apr 2001 19:45:28 -0700
From: "Adam J. Richter" <adam@freya.yggdrasil.com>
Message-Id: <200104140245.TAA05482@freya.yggdrasil.com>
To: chief@bandits.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Fremlin" <chief@bandits.org> writes:
>"Adam J. Richter" <adam@yggdrasil.com> writes:
>> "John Fremlin" <chief@bandits.org> writes:
>> > "Adam J. Richter" <adam@yggdrasil.com> writes:

>The parent is not allowed to run until the child execs, if I
>understand correctly. Read up on CLONE_VFORK.

	I thought that I had checked this a few months ago and
discovered that Linux let the vfork parent run, but I wrote a
test program just now, and you're apparently right about that,
at least with respect to 2.4.3, although that's all the more
reason to give the short term CPU priority to the process that
can use it (the child), thereby slightly increasing the average
runtime available in a timeslice, which in term slightly decreases
the percentage of time spent in context switch overhead.  This will
usually be a really tiny amount, but my point is that since there
is probably a tiny advantage to giving the remaining time slices
to the child even here, there is no need to complicate my patch.

>> Of course, in the vfork case, this change is probably only a very
>> small win.  The real advantage is with regular fork() followed by an
>> exec, which happens quite a lot.  For example, I do not see vfork
>> anywhere in the bash sources.

>If it is a real advantage you can get a bigger advantage by changing
>the app to use vfork, i.e. you can solve the problem (if it exists)
>better without hacking the kernel.

	It is impractical to change every application, including
ones that you don't have access to, and many of them have reaons for
using fork instead of vfork, and you don't even have access to them.
For example, the setup that the child does between the fork and the
exec is complex enough so that it might mess up the parent's memory or,
more commonly, its error handling code for exec failure is.

	Even if you could show that vfork was the right choice in all
cases (and it isn't), that would still be no reason for making do_fork
unnecessary slow and complex.  My change simplifies do_fork(), makes
it runs a few cycles faster, and, I believe, makes it behave like more
fork on most other systems.  If you want to argue against this change,
please justify the real benefits of the performance cost, the
complexity and nonstandard behavior you are advocating.  (Admittedly
the last two are really small, but I believe they are positive).

	Note that I've dropped Linus's email address for this thread,
as it does not appear to be arguing a real technical advantage to the
old do_fork() behavior.  So, while it may be interesting and informative
and on topic for lkml, it is not seem to be an argument to Linus that
he should reject or modify my patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
