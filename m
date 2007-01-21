Return-Path: <linux-kernel-owner+w=401wt.eu-S1751197AbXAUGAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXAUGAV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 01:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXAUGAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 01:00:21 -0500
Received: from thunk.org ([69.25.196.29]:54309 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbXAUGAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 01:00:19 -0500
Date: Sun, 21 Jan 2007 00:54:56 -0500
From: Theodore Tso <tytso@mit.edu>
To: Willy Tarreau <w@1wt.eu>
Cc: Joe Barr <joe@pjprimer.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070121055456.GC27422@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
	Joe Barr <joe@pjprimer.com>,
	Linux Kernel mailing List <linux-kernel@vger.kernel.org>
References: <1169242654.20402.154.camel@warthawg-desktop> <20070120173644.GY24090@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070120173644.GY24090@1wt.eu>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 06:36:44PM +0100, Willy Tarreau wrote:
> On Fri, Jan 19, 2007 at 03:37:34PM -0600, Joe Barr wrote:
> > 
> > I'm forwarding this post by the author of a great little program for
> > digital amateur radio on Linux, because I'm curious whether or not the
> > problem he is seeing can be resolved outside the kernel.
> 
> At least, I see one wrong claim and one unexplored track in his report.
> The wrong claim : the serial port can only be controled by the kernel.
> It is totally wrong for true serial ports. If he does not want to use
> ioctl(), then he can directly program the I/O port.

There's more wrong with his claim than just that.  Another wrong claim
is that it's caused by the Linux kernel not treating ioctl requests
with high priority.  Of course that's nonsense.  It might be the case
if we were using brain-damaged messaging-passing approach like what
Andrew Tenenbaum is proposing with Minix 3.1, but in Linux, the serial
port DTR/CTS lines are toggled as soon as the userspace executes the
ioctl. 

The real issue is when does the userspace program get a chance to run.
He's using the select() system call, which only guarantees accuracy up
to the granularity of the system clock.  Given that he's reporting a
jitter of between 0 and 4ms, I'm guessing that he's running with a
system clock tick of 250HZ (since 1/250 == 4ms ).

So if he wants accuracy greater than that, there are a couple of
things he can do.  One is to recompile his kernel with HZ=1000.  That
will give him accuracy up to 1ms or so.  If he needs better than 1ms
granularity, there are two options.  One is use sched_setscheduler()
to enable posix soft-realtime, and then calibrate a busy loop.  This
will of course burn power and completely busy out one CPU, so if he
needs to run CW continuously this probably isn't a great solution.  On
an SMP system it might work, although it is obviously a huge kludge.

The other choice would be to install Ingo's -rt patches (see
http://rt.wiki.kernel.org for more information), and then use the
 Posix high-resolution timer API's (i.e., timer_create, et. al).  Make
sure you enable CONFIG_HIGH_RES_TIMERS after you apply the patch.  It
would also be a good idea to set a real-time scheduling priority for
the application, to make sure that when the timer goes off, the
process doesn't get preempted by some background cron job.

> Now he must be careful about avoiding busy loops in the rest of the
> program, or he will have to use the reset button.

An easy way of dealing with this is to have an sshd running
an alternative port running at a nice high priority (say, prio 95 or
so).  That way, if you screw up, you can always login remotely and
kill the offending program.

There is also a RT Watchdog program which can be found on
rt.wiki.kernel.org which can be used to recover from runaway real-time
processes without needing to hit the reset button.

Finally, please feel free to direct your amateur radio friend to the
linux-rt-users@vger.kernel.org.  There are plenty of folks there who
would be very happy to help him out.

73 de Ted, N1ZSU
