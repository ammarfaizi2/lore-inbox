Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTFWQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbTFWQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:28:07 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:22285 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264806AbTFWQ2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:28:02 -0400
Date: Mon, 23 Jun 2003 18:47:43 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030623164743.GB1184@hh.idb.hist.no>
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com> <3EF6B5D4.10501@aitel.hist.no> <1056363509.587.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056363509.587.13.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 12:18:29PM +0200, Felipe Alfaro Solana wrote:
> On Mon, 2003-06-23 at 10:09, Helge Hafting wrote:
> > Felipe Alfaro Solana wrote:
> > > As someone said before in the list, a process should be marked
> > > "interactive" based on the fact that it's receiving user input, 
> > 
> > This is almost impossible to get right, except for a few very special
> > cases like a single user working at the console.  Unix is supposed to
> > do much better than that - the user logging in via a serial port,
> > (or more commonly these days, via the network) should get exactly
> > the same responsiveness as that console user.
> > 
> > Further, we may (sometimes) know that some devices is connected
> > to a human.  But how about that script reading one disk file
> > and writing to another?  Is it some cron job, did it start
> > from some GUI menu with a user eagerly waiting for it to finish?
> > Or did the user switch to the workd processor because he
> > knows the script will take "forever"?
> 
> Maybe I have different a different idea of what "interactive" should be.
> For me, an interactive process should have nearly-realtime response
> times to user events. For example, if I click on a link in my web
> browser's window, I want almost an immediate response:I want the process
> to acknowledge the event, although it could be impossible to perform it
> due to network latency, etc.
> 
Quick response is only possible if the job requested is small.
A big job won't happen quicly even if you get 100% cpu.
(Some sort of feedback ought to be possible though.)

> Currently, 2.5 kernels don't have a good "interactive" kernel, if we
> stick to the previous definition of "interactive". I can easily starve
> processes (XMMS) and moving windows around the screen do feel jerky and
> laggy at best when the machine is loaded. For a normal desktop usage, I
> prefer all my intensive tasks to start releasing more CPU cycles so
> moving a window around the desktop feels completely smooth (sorry to
> say, as Windows does). The same applies to repainting, or even launching
> a new process.
> 
I don't say the current 2.5 kernel is perfect - but I do
believe the current scheme (sleep-based priority) is good.
2.5 may need some tweaking to get good, such as:
 * how much boost for how much sleep
 * how long do you keep the boost

> > > for example, key strokes, mouse movements or any events received from any
> > > input device, not based on its CPU usage. I think applications like XMMS
> > > or mplayer shouldn't be considered interactive (at least, not until they
> > > start interacting with user), 
> 
> > The're interactive if the user is staring at / listening to the output.
> 
> Or the user is feeding events to it, for example, by dragging a window,
> clicking the mouse or pressing keys. If a process has received user
> input in the past, ir's pretty probable that the process is an
> interactive one.
> 
Except for when the user starts a cpu hog, which really is
almost all cpu hogs. :-/

> I don't consider compiling the kernel an interactive process as it's
> done almost automatically without any user intervention. XMMS is not a
> complete interactive application as it spends most of the time decoding
> and playing sound.
> 
A kernel compile isn't interactive - sure.  It may get some boosts
anyway for io waiting.  This quite correctly puts it above a
pure cpu hog like a mandelbrot calculation.

> > Use a multithreaded word processor and you'll get exactly this behaviour,
> > with the current system.  See above.
> 
> I agree. The word processor example was a bad one. Most word processors
> are multithreaded.
> 
> > > For terminal based, interactive applications (like pine, vi, and
> > > company), which are connected to tty devices, a user input event could
> > > make the scheduler boost the process priority for a brief time (and
> > > then, reduce the priority in a nearly quadratic fashion until reaching
> > > it's original, or a lower, priority) to give it a better response time
> > > and increase the interactive feeling.
> > > 
> > This works already, because the app slept waiting for that keystroke.
> 
> So then, why I can easily starve the X11 server (which should be marked
> interactive), Evolution or OpenOffice simply by running "while true; do
> a=2; done". Why don't they get an increased priority boost to stop the
> from behaving so jerky?
> 
A badly implemented or ill-tuned scheduler.  The loop isn't interactive.
Openoffice is a bad example though - it has _so_ much overhead
during startup that it seems to (correctly) become noninteractive.
 
> > > by increasing the target process priority (it normally runs as root)?
> > > Should the window manager increase the priority of the process which
> > > owns the current foreground, active window? Solaris seems to work this
> > 
> > It can't without that X protocol change, for the "foreground process",
> > the "window manager" and the "X server" may all be running on three
> > different machines.
> 
> That's what is said at course SA-400 Solaris 8 Tuning from the Solaris
> Official Curriculum. In fact, it works when working locally on a Solaris
> 8 or 9 machine.

Sure, you can do this locally, but that is not enough.  Being fair is
important, particularly in multi-user situations.  And multi-user becomes
_more_ common now that corporations realize they can save costs by
having 2-4 users share a single pc.  (Duplicate screens & keyboard, but
not the rest.)  Then there's remote login for administration,
spreading a large job over many pc's and so on.

Helge Hafting 

