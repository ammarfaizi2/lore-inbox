Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbSJGNwn>; Mon, 7 Oct 2002 09:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263051AbSJGNwn>; Mon, 7 Oct 2002 09:52:43 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:34979 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S263049AbSJGNwl> convert rfc822-to-8bit; Mon, 7 Oct 2002 09:52:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 7 Oct 2002 08:56:07 -0500
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
In-Reply-To: <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210070856.07356.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 October 2002 03:30 pm, Rob Landley wrote:
> On Friday 04 October 2002 07:13 pm, Linus Torvalds wrote:
[snip]
> Now to fake this in Linux, you theoretically just need to run your X server
> and  your window manager at a priority of -10 (and somebody needs to club
> the distributions on the head until they start DOING this).  But in the
> past, that wouldn't guarantee your mouse cursor didn't do a half-second
> pause at a window boundary when the swap file went nuts.  There was NOTHING
> you could do under the first dozen 2.4 kernels to make sure your mouse
> pointer wouldn't stall at a window boundary, or go into la-la land for five
> minutes for that matter.  (It improved noticeably after that, but by then
> most people's opinions of 2.4's desktop suitability were already formed. 
> And it's STILL not fully fixed in 2.4: the instant an app blocks on a
> swapped out page and then I/O starvation happens with reads blocked by
> writes...  BANG.  User twiddles thumb while their mouse pointer ignores
> them.  Solution?  Never do anything disk intensive in the background unless
> you want interactive feel to go into the toilet.)

In other words... don't swap. If an application has to be swapped out, all
bets are off on response time. There are X events that REQUIRE the
application to be in memory if they are going to be handled. (example:
focus follows mouse, auto raise window on focus, app must redraw exposed
area... or worse: app grabs mouse to put it in the workspace on entry to a
status display. Guess what can happen to the mouse.)

> The new deadline I/O scheduler directly addresses this, and the ability to
> get "nice" to affect I/O priority is going to be a big win as well.  Andrea
> and Rik's VM work help here: rmap adds a lot of future tuning potential,
> such as the ability to make SWAP care about niceness (swap out pages from
> the nice+20 process before the nice-20 process).  The O(1) scheduler helps
> here by making niceness levels more meaningful in general.  All of these
> help X11 at nice level -10 to not stall.  The faster clock tick helps here
> too, the low  latency work at the start of 2.5 helps here, and preempt
> helps here. There has been a LOT of work on general latency improvement and
> interactive feel.

It will still stall everytime the mouse crosses the window border IF the
application has specified "enter/leave" event notification. This requires the
application to be swapped in to recieve the event. The only fix is locking
the application/X libraries into memory.

> Even the new threading work can potentially help X spin off a dedicated
> high-priority "update the mouse position, and manipulate window borders and
> z order, and never swap this thread out" thread.  (I remember the way OS/2
> used to cheat and give extra time slices to anything that got a
> Presentation Manager window event, so you could literally speed up your
> program on a loaded system by "scrubbing" the mouse across it repeatedly. 
> The resulting perception was a snappy desktop, whatever the reality was.)

Not really - the application may want the mouse pointer changed, update data
based on where the mouse is located (see what happens to a rule bar on
image/word processors). There is also the possibility that multiple processes
are watching the mouse.

The only "fix" that would help this out is to lock the X shared libraries and
X server into memory, and to use a multi-threaded X server, OR have
enough memory available to not swap.

The major difference between M$ window handling and X is that X gives the
users app control over what happens to the mouse. M$ has already defined
what the actions are, it is NOT up to the application. X does not implement
application policy. That is up to the application.

Even M$ Windows will lockup when it swaps out the application. The mouse
might move... but then the entire system hangs (at least under ME).

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
