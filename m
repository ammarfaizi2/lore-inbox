Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbTHMGfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTHMGfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:35:30 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5600 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S271418AbTHMGfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:35:17 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Mike Galbraith <efault@gmx.de>,
       Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Subject: Re: What is interactivity? Re: [PATCH]O14int [SCHED_SOFTRR  please]
Date: Tue, 12 Aug 2003 21:43:44 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030811212837.01975fa0@pop.gmx.net> <5.2.1.1.2.20030812062357.01a102f8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030812062357.01a102f8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308122143.44393.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 01:40, Mike Galbraith wrote:

> Well, interactivity can certainly be viewed like one of those tricky
> philosophy questions (bears farting in the woods, trees falling over etc;),
> but I consider any task which is connected to a human via any of our senses
> to be interactive.  Perhaps it's not a 100% accurate use of the term, but
> for lack of a better term...

"Interactivity"  is being used as a proxy for at least two different 
conditions: smooth spooling and snappy response to (possibly repeated) 
asynchronous wakeups.

The smooth spooler problem is where you're trying to input or output stuff at 
a constant rate, somewhere below your theoretical maximum capacity.  Sound 
output is like this.  Whether you're listening or not, the tree in the forest 
still falls.  A skip is a skip, the output could be being recorded to tape or 
who knows what.  Correctness here is emprical; if it skips something went 
wrong.

Sound is just one example, and a relatively easy one since the CPU 
requirements are so low on modern machines.  Personal Video Recorders ala 
Tivo are a more demanding application (often coming perilously close to your 
memory or disk bandwidth capacity), and skips or dropouts are saved for 
posterity there.  A human doesn't even have to be in the room, that task is 
still "interactive".

Repeated asynchronous wakeups come from typing on the keyboard and wiggling 
the mouse.  If your mouse is dragging a window, the asynchronous wakeups 
could provoke a lot of CPU activity.

The difference between these two is that they are different types of waits.  
Smooth spooling involves waiting for a known period of time, and being woken 
up by a timer.  Asynchronous wakeups come out of the blue, the application 
has know way of knowing the mouse is about to move or the keyboard is about 
to press until it happens.

(Some things combine these behaviors.  First person shooters (30 frames per 
second, plus responding to the joystick NOW), but that kind of thing could 
also collapse into the smooth spooler case if the frame rate's high enough 
and polling for input is cheap...)

True CPU hogs do block, but they only block when they're requesting more work.  
Any read or write to a block device is a "request more work" type of block, 
for example.  If the block device gets faster, the app runs faster.

With a CPU hog, there is no system so powerful that this thing won't try to 
speed to completion as fast as it can.  With an "interactive" task, the speed 
of the system is not the limiting factor (or at least shouldn't be).

Now there's a lot of fuzzy bits where you can't tell what kind of block you're 
doing.  Blocking on the network, blocking on pipes, etc.  Could be anything.  
But I think it's pretty safe to say that a timer is always an interactive 
wait, and a block device never is.  (And considering that the  I/O scheduler 
and the CPU scheduler may have to work together in the future to make things 
like the anticipatory schedulerwork properly, it shouldn't be TOO much of a 
stretch to distinguish between waiting on a block device and waiting on 
something else...)

> >I think that the work done this far is great. It is great that the
> > scheduler almost can handle xmms under all kinds of loads - but enough is
> > enough.
>
> I don't care if xmms skips or my mouse pointer stalls while I'm testing at
> the heavy end of the load scale,

I do.  I believe you're in the minority here.

> you flat can't have low latency and max
> throughput at the same time.

If you're talking about keeping your cache hot, I agree.  But a lot of times, 
minimizing latency DOES help throughput.  (Anticipatory scheduler, case in 
point. :)

What you're saying is that you want your CPU hog loads to complete as quickly 
as possible at the expense of smooth mouse movement.  This is what "nice" is 
for, isn't it?  (If you've got a dedicated, throughput-optimized server 
running X in the first place, you have more fundamental problems.)

And your uber-optimized configuration is still going to lose out to an 
unoptimized configuration running on hardware that's three months newer... :)

The linux-kernel gurus focused their optimizations almost exclusively on 
throughput for almost the first full decade of kernel development.  
Interactive latency started explicitly showing up as a concern in 2.4, and 
has only really become a priority in 2.5.  There are a few tradeoffs, but 
some of them are a bit overdue if you ask me.

If you can document a throughput degredation and give a repeatable benchmark, 
I'm sure Con and Ingo will be thrilled to address it.  A lot of contest is 
about throughput, you know.  They're trying very hard to avoid regressions...

>  If xmms skips and the mouse becomes sticks at
> less than "heavy" though, something is wrong (defining heavy is one of
> those tricky judgement calls).

You know, I used to beat OS/2 to DEATH, and the mouse never went funky on me.  
(Of course the mouse was updated directly from an interrupt routine in kernel 
memory that never swapped out.  But still... :)

> It's the mozilla loading a webpage type of reports that I worry about.

It could be worse.  It could be OpenOffice. :)

>          -Mike

Rob


