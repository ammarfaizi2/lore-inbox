Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131486AbRC1Fxg>; Wed, 28 Mar 2001 00:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131528AbRC1Fx1>; Wed, 28 Mar 2001 00:53:27 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:58876 "EHLO zooty.lancs.ac.uk") by vger.kernel.org with ESMTP id <S131486AbRC1FxR>; Wed, 28 Mar 2001 00:53:17 -0500
Message-Id: <l03130300b6e7282c3def@[192.168.239.101]>
In-Reply-To: <01032718343500.32154@friz.themagicbus.com>
References: <Pine.LNX.4.33.0103271815370.26154-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0103271815370.26154-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 28 Mar 2001 06:52:14 +0100
To: james <jdickens@ameritech.net>, Rik van Riel <riel@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Ideas for the oom problem
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to be gentle here and try to point out where your suggestions are
flawed...

>a. don't kill any task with a uid < 100

Suppose your system daemon springs a leak?  It will have to be killed
eventually, however system daemons can sensibly be given a little "grace".
Also, the UIDs used by a system daemon vary from system to system.

>b. if uid between 100 to 500 or CAP-SYS equivalent enabled
>	set it too a lower priority, so if it is at fault it will happen
>slower
>            giving more time before the system collapses

Not slowly enough.  When your system is thrashing, the CPU is the resource
under least pressure, so "nice" values and priorities have virtually zero
effect.  In any case, under OOM conditions the system has *already*
collapsed and we *have* to kill something for the system to keep running.

>c.  if a task is nice'd then immediately put the task too sleep, and schedule
>all code / data too be swapped out, or thrown away as appropiate. do not
>reschedule the task too continue until memory is available

In OOM conditions there is no swap space left to do what you suggest.  This
is a sensible solution for when thrashing is the only problem...

>d. kill any normal user interactive tasks that is started during a memory
>crisis.

Define "memory crisis".  However, this is a relatively sensible solution.

>allocate a pool of memory at system start up that is too be released to the
>memory pool when the system is in a memory crisis. This will reduce system
>swapping, and allow the system too stablize slightly

One of my patches already tries to do this, in a way.  It doesn't yet
provide a hard barrier, but it does prevent applications from hogging the
entire memory on the system (at least, without expending some effort into
it).

>report any task asking for large pool of memory while the system is in
>oom crisis. if uid > 500 and was started from an interactive shell it should
>be killed.

See above.  malloc() fails, which tells the application there is no more
memory in the system.  A well-written application will respond to this and
use more memory-conservative techniques.  A poorly-written application will
segfault.  End Of Problem.  Now to make memory accounting work properly so
these tests are reliable...

>when the crisis is ended, re-adquire the memory pool for later usage.

It is never given up, except when it is needed by the kernel itself (eg. to
swap in pages or (in the absence of true memory accounting) to provide COW
space.

>Prong 3 providing  information about oom crisis too user land
>
>create /proc/vm/oom_crisis this would be readonly file owned by root it would
>report if the system is in crisis and the uid of any process that is asking
>for large amounts of ram while the system
>is in crisis.

This kind of information is already available using /proc - applications
just have to look int he right places.

>create a SIGDANGER handler that is sent out too all tasks that have
>registered a handler when the kernel enters oom_kill, give these tasks a high
>priority access too system resources.

This is a fairly good idea, why does it look so familiar?  :)  SIGDANGER
would be sent to all processes when memory availablility goes below a
threshold, ie. when there is still enough memory left to handle the
situation.  The default handler would be a no-op, preserving compatibility.
However, the notion of "high priority access to resources" is not currently
feasible (or necessary).

>this would enable user land programs too deal with the situation with out
>continuous polling free ram/swap. They could email/page sysadmin and user
>about the crisis and add additional swap resources and kill any know  non
>essential tasks. and probe system for possible broken tasks, such as
>netscape-common tasks not connected too netscape client, at least i have been
>known too find these when netscape crashes.

Interesting applications for this signal.  However, this is entirely a
userspace issue as to what to do with the signal - the kernel's job is to
provide it (if we decide to, that is).

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


