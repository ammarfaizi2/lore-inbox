Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262567AbSJGS57>; Mon, 7 Oct 2002 14:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbSJGS57>; Mon, 7 Oct 2002 14:57:59 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:46256 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262567AbSJGS5y>; Mon, 7 Oct 2002 14:57:54 -0400
Message-Id: <200210071903.g97J3VSs276692@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 7 Oct 2002 10:03:16 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <200210070856.07356.pollard@admin.navo.hpc.mil>
In-Reply-To: <200210070856.07356.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 09:56 am, Jesse Pollard wrote:

> In other words... don't swap.

"Don't swap this bit", anyway.

> If an application has to be swapped out, all
> bets are off on response time.

Alright, breaking the problem down into specific, bite-sized chunks, seeing 
what's easily measurable, and then picking the lowest hanging fruit:

The frequency of mouse pointer stalls, and the worst case response time, is 
probably something an automated benchmark could measure.  (Z-order's a 
tricker problem because the window manager's involved, but mouse stalls are 
EASY to cause.)

On my laptop (with 256 megs ram and 256 megs swap).  Open up 30 or 40 
konqueror windows of a "this page looks interesting, I'll read it offline" 
variety until memory's full and you're about 2/3 of the way into swap.  
(KTimeMon makes this easy to see.)  then do something swap-happy in the 
background (including downloading a huge file, which causes disk cache to 
grow and evict stuff, or of course running a big compile).

No matter how much ram the system has, with six desktops full of open windows 
I can usually drive it DEEP into swap, without even picking an easy target 
like star/openoffice.  (Yeah, KDE sucketh.  And X should be able to figure 
out that windows not currently being displayed at all (completely behind 
other windows, on another desktop, etc) can be swapped out.  But it's just 
not designed that way...)

> > Even the new threading work can potentially help X spin off a dedicated
> > high-priority "update the mouse position, and manipulate window borders
> > and z order, and never swap this thread out" thread.  (I remember the way
> > OS/2 used to cheat and give extra time slices to anything that got a
> > Presentation Manager window event, so you could literally speed up your
> > program on a loaded system by "scrubbing" the mouse across it repeatedly.
> > The resulting perception was a snappy desktop, whatever the reality was.)
>
> Not really - the application may want the mouse pointer changed, update
> data based on where the mouse is located (see what happens to a rule bar on
> image/word processors). There is also the possibility that multiple
> processes are watching the mouse.

You may notice that in mozilla when your rat moves over a link, the mouse 
pointer turns into a hand anywhere up to several seconds later on a 
pathologically loaded system.  This usually doesn't stop the pointer from 
moving if you just want to wander past the link and continue on.  "Tooltips" 
take two or three seconds to pop up, and this is a GOOD thing...

if the mouse movement stalls, you can't navigate with a nipple mouse or 
touchpad (which is all you get on a laptop), 'cause you'll overshoot. Having 
the button under the mouse highlight is secondary to being able to get the 
mouse over the button.

When the system isn't loaded anymore (went away while a compile finished or a 
file downloaded), you get one or two small (1/4 second) stalls as stuff swaps 
back in and then life is good.  It's when you swap stuff in and then it swaps 
back out after 3 seconds of inactivity that it gets to be a real pain 
(something the deadline I/O scheduler is supposed to help)...

Maybe the correct thing here is a user space fix, with X throwing certain 
event handlers into an mlocked shared library, just so your mouse pointer 
always updates smoothly.  But I do know a lot of work has gone into making 
more intelligent swapping decisions (fundamentally, that's all VM work really 
is), and it's certainly a heck of a lot better than the 2.4.6 days where you 
had to go get a beverage when it went swap-happy and it could be 30 seconds 
between pointer updates.

> Even M$ Windows will lockup when it swaps out the application. The mouse
> might move... but then the entire system hangs (at least under ME).

The amazing number of things windows manages to screw up should not be used 
to prevent discussiona about the small number of things they successfully 
copied from the macintosh.  :)

Rob
