Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbSJIAGV>; Tue, 8 Oct 2002 20:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbSJIAGV>; Tue, 8 Oct 2002 20:06:21 -0400
Received: from pc132.utati.net ([216.143.22.132]:10402 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S263195AbSJIAGS>; Tue, 8 Oct 2002 20:06:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Tue, 8 Oct 2002 15:11:46 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210071903.g97J3VSs276692@pimout2-ext.prodigy.net> <200210081714.32959.pollard@admin.navo.hpc.mil>
In-Reply-To: <200210081714.32959.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021009001148.3665D544@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 06:14 pm, Jesse Pollard wrote:

> > On my laptop (with 256 megs ram and 256 megs swap).  Open up 30 or 40
> > konqueror windows of a "this page looks interesting, I'll read it
> > offline" variety until memory's full and you're about 2/3 of the way into
> > swap. (KTimeMon makes this easy to see.)  then do something swap-happy in
> > the background (including downloading a huge file, which causes disk
> > cache to grow and evict stuff, or of course running a big compile).
>
> Out of curiosity, does it also happen if you have no swap?

I'd trigger the OOM killer a lot easier?  (Done it more than once without 
meaning to...)

It used to go into REAL swap meltdown once the swap file was full, because 
it'd start paging out executables and libraries back into their files.  I've 
actually tried to avoid testing that recently, for obvious reasons. :)

As soon as I read, take notes from, index, and close about 40 open web pages, 
I can reboot the sucker without swap.  (I could try to swapoff a heavily 
loaded running system, but I tried that once and the results were NOT 
pretty...)

> It is my understanding that this change will prevent much (not all) of the
> swap activity, giving a quicker response to the mouse events. It should
> increase the amount of actual swap activity, but each activiation will be
> of shorter duration, giving a "better" apparent interactive response.

I haven't been brave enough to run 2.5 on my laptop yet.  (Soon.  I've 
downloaded it, compiled it, but haven't made it through the "what do I need 
to upgrade" list yet.  This sucker's still running 2.4.19 inserted in a 
modified red hat 7.2.)  My test machine at home's an old pentium pro 180 with 
96 megs of ram, so I haven't exactly got the world's highest interactive 
expectations there.

> > You may notice that in mozilla when your rat moves over a link, the mouse
> > pointer turns into a hand anywhere up to several seconds later on a
> > pathologically loaded system.  This usually doesn't stop the pointer from
> > moving if you just want to wander past the link and continue on.
> > "Tooltips" take two or three seconds to pop up, and this is a GOOD
> > thing...
>
> I was thinking more about switching pointer on window entry. I don't think
> a link is implemented as a window. (I thought is was a proximity check in
> an already loaded event). Or places that do pointer grabs (fortunately for
> me most of the dialog boxes I see in X don't do this).

All sorts of things can cause a stall at the edge of the window.  I've seen 
it happen at the edge of the little animated mozilla logo.

To drive a 2.4 system to its knees, all you have to do is "cat /dev/zero > 
bigfile" on a partition with a few gigabytes free, and then scrub the mouse a 
bit.

Tried it on a friend's workstation a minute ago.  The result was NOT pretty.  
2.4.19 is a lot better about this than whatever shipped with his SuSE box, 
but if you want to make desktop interactive feel suck, try running this in 
the following on a system that's a ways into swap.  (It needs 4 gigs of disk 
space, which should be more ram than most people have...)

while true
do
  dd if=/dev/zero of=tempfile bs=65536 count=65536
  rm tempfile
done

It's certainly improving.  On 2.4.19, the mouse cursor only really seems to 
get truly jerky when you exhaust the swap so badly it pages to the executable 
files.  (Then again, every few minutes it goes consistently jerky for several 
seconds.)

But by the same token, I have a server running 2.4.19 that when receiving a 
big file transfer through the 100baseT and blasting it to disk, goes 
completely into la-la land and won't allow new ssh connections until the 
transfer ends.  (I've given it a 4 gigabyte transfer and waited minutes.  The 
prompt shows up about one second after the transfer ends, and I had more than 
one machine queued waiting like that...)

I'm hoping 2.5 categorically fixes this, but haven't put it on a production 
machine yet.  Maybe I'll be able to slap together an appropriate spare box in 
a few days.  (P.S.  Did make meuconfig crashing when you tried to enter the 
ALSA menu ever get fixed?  Set me back half an hour, that did...)

> Also the "tooltips" thing is implemented as a mouse window entry event
> which in turn sets a timer event. A mouse window exit event generates
> a timer cancel.
>
> One of the most amazing thing to me is the total number
> of events that occur on something a simple as a scroll bar. Entering a
> window can generate 8-10 events depending which toolkit is used.
> First the pointer character is changed, then events cascade since the
> border of a scrollbar may actually have 2 or 3 windows, each with
> a different requirement, but requesting a window entry/exit event.

Not exactly an easy problem to solve from kernel space, no.  But when 
unrelated processes can seriously interact with each other, you can't help 
but think the kernel is involved somehow... :)

> This is where a slightly different method of handling background processes
> (and I/O requests). A background process should have a lower processing
> priority.

1) This doesn't affect I/O.

2) Swapping, running executables, stating files...  all I/O the high priority 
process may need to do.

Hmmm...  You know,it might be a good idea to rip the swap file out of that 
SERVER (which has 256 megs of ram also, that should be plenty) and see if 
that makes the incoming transfer hang go away...

> The I/O activity generated by that background process should also
> have a lower priority. The deadline I/O scheduler should/would/could then
> keep the forground processes (X server, apps with exposed windows) running
> by processing their I/O first.

This is what I'm hoping.  This is not the 2.4 reality, I'll tell you that. :)

> This also assumes that the X server MIGHT be able to change the priority of
> processes attached to hidden windows (iconified/covered).

Ingo was thinking about letting normal processes nice themselves up a couple 
of levels.  Enough that abuse wouldn't matter too much, but so that processes 
intended to be interactive could identify themselves as such.

Part of the problem is that "nice" is really trying to say two things.  "I 
want more CPU time" and "I want lower latency".  In theory, interactive 
processes could get SHORTER time slices (subject to some minimum), they just 
need to be dispatched more rapidly when they unblock.  Possibly the scheduler 
needs some kind of hint in addition to just a number.

> It doesn't
> address those processes that may be running detached (cron or started by
> terminal emulators) which would act like foreground processes. Though the
> terminal emulators could be detected, and have all subprocesses of the
> controlling pty reduced in priority.... Also have to recognize when they
> should again be elevated too... (or even if they should be. These things
> can take a LOT of resources). It would also have to be under the control of
> the user, since the user may need the background compile done ASAP (even if
> the user DOES run a solitare game covering the terminal window...)

Again, two separate scheduler problems.  A process that wants big long 
timeslices but doesn't care about gaps between them, and a process that wants 
short time slices in 30 miliseconds or less or it's free. :)

An artifact of the current O(1) scheduler is that if you nice a process way 
the heck DOWN it may finish slightly faster, because its timeslices are 
longer when it gets them, so the cache stays hot.

Strange but true, or at least "worked for me"...

Rob
