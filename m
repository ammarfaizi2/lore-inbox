Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSJHWME>; Tue, 8 Oct 2002 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJHWLk>; Tue, 8 Oct 2002 18:11:40 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:62640 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261325AbSJHWLL> convert rfc822-to-8bit; Tue, 8 Oct 2002 18:11:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Rob Landley <landley@trommello.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Tue, 8 Oct 2002 17:14:32 -0500
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210070856.07356.pollard@admin.navo.hpc.mil> <200210071903.g97J3VSs276692@pimout2-ext.prodigy.net>
In-Reply-To: <200210071903.g97J3VSs276692@pimout2-ext.prodigy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210081714.32959.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 09:03 am, Rob Landley wrote:
> On Monday 07 October 2002 09:56 am, Jesse Pollard wrote:
> > In other words... don't swap.
>
> "Don't swap this bit", anyway.
>
> > If an application has to be swapped out, all
> > bets are off on response time.
>
> Alright, breaking the problem down into specific, bite-sized chunks, seeing
> what's easily measurable, and then picking the lowest hanging fruit:
>
> The frequency of mouse pointer stalls, and the worst case response time, is
> probably something an automated benchmark could measure.  (Z-order's a
> tricker problem because the window manager's involved, but mouse stalls are
> EASY to cause.)
>
> On my laptop (with 256 megs ram and 256 megs swap).  Open up 30 or 40
> konqueror windows of a "this page looks interesting, I'll read it offline"
> variety until memory's full and you're about 2/3 of the way into swap.
> (KTimeMon makes this easy to see.)  then do something swap-happy in the
> background (including downloading a huge file, which causes disk cache to
> grow and evict stuff, or of course running a big compile).

Out of curiosity, does it also happen if you have no swap?
It is my understanding that this change will prevent much (not all) of the
swap activity, giving a quicker response to the mouse events. It should
increase the amount of actual swap activity, but each activiation will be of
shorter duration, giving a "better" apparent interactive response.

> No matter how much ram the system has, with six desktops full of open
> windows I can usually drive it DEEP into swap, without even picking an easy
> target like star/openoffice.  (Yeah, KDE sucketh.  And X should be able to
> figure out that windows not currently being displayed at all (completely
> behind other windows, on another desktop, etc) can be swapped out.  But
> it's just not designed that way...)

partly depends on whether the X window buffers are page aligned... If they
were then that should be the result. I bet they arn't page aligned.

> > > Even the new threading work can potentially help X spin off a dedicated
> > > high-priority "update the mouse position, and manipulate window borders
> > > and z order, and never swap this thread out" thread.  (I remember the
> > > way OS/2 used to cheat and give extra time slices to anything that got
> > > a Presentation Manager window event, so you could literally speed up
> > > your program on a loaded system by "scrubbing" the mouse across it
> > > repeatedly. The resulting perception was a snappy desktop, whatever the
> > > reality was.)
> >
> > Not really - the application may want the mouse pointer changed, update
> > data based on where the mouse is located (see what happens to a rule bar
> > on image/word processors). There is also the possibility that multiple
> > processes are watching the mouse.
>
> You may notice that in mozilla when your rat moves over a link, the mouse
> pointer turns into a hand anywhere up to several seconds later on a
> pathologically loaded system.  This usually doesn't stop the pointer from
> moving if you just want to wander past the link and continue on. 
> "Tooltips" take two or three seconds to pop up, and this is a GOOD thing...

I was thinking more about switching pointer on window entry. I don't think
a link is implemented as a window. (I thought is was a proximity check in an
already loaded event). Or places that do pointer grabs (fortunately for me
most of the dialog boxes I see in X don't do this).

Also the "tooltips" thing is implemented as a mouse window entry event
which in turn sets a timer event. A mouse window exit event generates
a timer cancel.

One of the most amazing thing to me is the total number
of events that occur on something a simple as a scroll bar. Entering a
window can generate 8-10 events depending which toolkit is used.
First the pointer character is changed, then events cascade since the
border of a scrollbar may actually have 2 or 3 windows, each with
a different requirement, but requesting a window entry/exit event.

> if the mouse movement stalls, you can't navigate with a nipple mouse or
> touchpad (which is all you get on a laptop), 'cause you'll overshoot.
> Having the button under the mouse highlight is secondary to being able to
> get the mouse over the button.
>
> When the system isn't loaded anymore (went away while a compile finished or
> a file downloaded), you get one or two small (1/4 second) stalls as stuff
> swaps back in and then life is good.  It's when you swap stuff in and then
> it swaps back out after 3 seconds of inactivity that it gets to be a real
> pain (something the deadline I/O scheduler is supposed to help)...

This is where a slightly different method of handling background processes
(and I/O requests). A background process should have a lower processing
priority. The I/O activity generated by that background process should also
have a lower priority. The deadline I/O scheduler should/would/could then
keep the forground processes (X server, apps with exposed windows) running
by processing their I/O first.

This also assumes that the X server MIGHT be able to change the priority of
processes attached to hidden windows (iconified/covered). It doesn't address
those processes that may be running detached (cron or started by terminal
emulators) which would act like foreground processes. Though the terminal
emulators could be detected, and have all subprocesses of the controlling
pty reduced in priority.... Also have to recognize when they should again
be elevated too... (or even if they should be. These things can take a LOT
of resources). It would also have to be under the control of the user, since
the user may need the background compile done ASAP (even if the user
DOES run a solitare game covering the terminal window...)

> Maybe the correct thing here is a user space fix, with X throwing certain
> event handlers into an mlocked shared library, just so your mouse pointer
> always updates smoothly.  But I do know a lot of work has gone into making
> more intelligent swapping decisions (fundamentally, that's all VM work
> really is), and it's certainly a heck of a lot better than the 2.4.6 days
> where you had to go get a beverage when it went swap-happy and it could be
> 30 seconds between pointer updates.

Unfortunately, X cannot control the event handlers. That is the rest of the
application, and you end up locking the entire application in memory.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
