Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSJZIjK>; Sat, 26 Oct 2002 04:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSJZIjJ>; Sat, 26 Oct 2002 04:39:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48627 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261973AbSJZIjH>;
	Sat, 26 Oct 2002 04:39:07 -0400
Message-ID: <3DBA560F.5824F738@mvista.com>
Date: Sat, 26 Oct 2002 01:45:03 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@trommello.org
CC: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
References: <3DB88F6D.F408FF06@ccur.com> <200210251458.21284.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Thursday 24 October 2002 19:25, Jim Houston wrote:
> > Hi Rob,
> >
> > The Posix timers entry in your list is confused.  I don't know how
> > my patch got the name Google.
> 
> Sorry, misread "George's version" as "Google's version" at 5 am one morning.
> Lot of late nights recently... :)
> 
> > I think Dan Kegel misunderstood George's answer to my previous
> > announcement.  George might be picking up some of my changes, but there
> > will still be two patches for Linus to choose from.  You included the URL to
> > George's answer which quoted my patch, rather than the URL I sent you.
> 
> Had it in, then took it out.  I'm trying to collate down the list wherever I
> can.
> 
> > Here is the URL for an archived copy of my latest patch:
> >      Jim Houston's  [PATCH] alternate Posix timer patch3
> >      http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000027416&w=2
> 
> It's back now.
> 
> > I would be happy to see either version go into 2.5.
> 
> So what exactly is the difference between them?

First, to answer your question about the order of things in
my patches.  The 4 patches should be applied in this order:

First, the posix patch.  It introduces the POSIX clocks &
timers to the system.  It is not high res and stands alone. 
The rest of the patches are all about doing the high res
timers:

The 3 parts to the high res timers are:
 core           The core kernel (i.e. platform independent)
changes
 i386           The high-res changes for the i386 (x86)
platform
 posixhr        The changes to the POSIX clocks & timers
patch to
use high-res timers

This last is almost entirely contained to the one file
(.../kernel/posix_timers.c).  The "almost" is because it
adds a member to the posix timers structure which is defined
in sched.h.

Now, as to the differences between my patches and Jim's. 
Jim's patch is an alternate for the first or "posix" patch
only.  Since I picked up a variation on his id allocator,
thus removing the configuration option for the maximum
number of timers, the principle difference is that Jim keeps
the posix timers in a separate list, where as, my patch puts
them in the same list (i.e. the add_timer list) as all other
timers.  I assume (not having looked in detail at his latest
patch) that he uses the systems add_timers to drive the
timers in this list, and thus has a two stage expiry
algorithm (a. the add_timer pop which then, b. causes a
check of this new list).

Jim has also attempted to address the clock_nanosleep()
interaction with signals problem.  In short, the standard
says that signals that do not actually cause a handler in
the user code to run are NOT supposed to interrupt a sleep. 
The straight forward way to do this is to interrupt the
sleep on the signal, call do_signal() to deliver the signal
and check the return to see if it invoked a user handler (it
returns 1 in this case, else 0) and either continue the
sleep or return.  The problem is that do_signal() requires
&regs as a parameter and this is passed in different ways,
in the various platforms, to system calls.  ALL other system
calls that call do_signal() reside in platform dependent
code, most likely for this reason.

My solution for this problem is to provide a couple of
macros in linux/signal.h and linux/asm-i386/signal.h to
define the entry sequence for clock_nanosleep (and nanosleep
as it is now just a call to clock_nanosleep).  The macros in
linux/signal.h are general purpose and do NOT actually solve
the problem, but they do allow other platforms to work,
although, without the standard required signal handling. 
These are only defined if the asm/signal.h does not supply
an alternative.  This allows each platform to customize the
entry to clock_nanosleep() to pass in regs in what ever way
works for that platform.  I fully admit that this is a VERY
messy bit of code, BUT at the same time, it works.  I am
fully prepared to change to a cleaner solution should one
arise.

Jim has NOT provided high res timers as yet, and thus does
not have any code to replace the 3 high res patches.  I
don't know if he is attempting to do this code.  I suspect
he is not, but he did indicate that he wants to expand his
posix timers to be high res.  If he does this, I suspect
that it would be his version of the "hrposix" patch.
> 
> > The URLs for George's patches are incomplete.  I believe this is the
> > most recent (it's from Oct 18).  The Sourceforge.net reference has the
> > user space library and test programs, but I did not see 2.5 kernel
> > patches.
> >
> >   [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
> >      http://marc.theaimsgroup.com/?l=linux-kernel&m=103489669622397&w=2
> 
> He's up to version 4 now.

As I said in another post, don't trust these archives, they
truncate long posts to less than what the lklm allows.  In
particular, they have truncated my patches.  The full set of
4 patches are available here:

 http://sourceforge.net/projects/high-res-timers/

or, to save a few clicks:

http://sourceforge.net/project/showfiles.php?group_id=20460&release_id=118345

Please do read the notes, they tell about the order of
application, which is fixed, i.e.:
hrtimers-posix  The posix clock/ timers interface, low res.
hrtimers-core   The core system high res patch.
hrtimers-i386   The high res code for the i386 platform.
hrtimers-hrposix The patch to move the low res posix patch
                 to high res.


-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
