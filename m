Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWG3Ohn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWG3Ohn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWG3Ohn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:37:43 -0400
Received: from thunk.org ([69.25.196.29]:52659 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750853AbWG3Ohn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:37:43 -0400
Date: Sun, 30 Jul 2006 10:33:42 -0400
From: Theodore Tso <tytso@mit.edu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Nicholas Miell <nmiell@comcast.net>, Edgar Toernig <froese@gmx.de>,
       Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character driver)
Message-ID: <20060730143341.GD23279@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Nicholas Miell <nmiell@comcast.net>, Edgar Toernig <froese@gmx.de>,
	Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, a.zummo@towertech.it,
	jg@freedesktop.org, Keith Packard <keithp@keithp.com>,
	Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
References: <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org> <20060729234948.0768dbf4.froese@gmx.de> <20060729225138.GA22390@gnuppy.monkey.org> <1154216151.2467.5.camel@entropy> <20060730010020.GA23288@gnuppy.monkey.org> <1154222579.2467.12.camel@entropy> <20060730013936.GA23571@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730013936.GA23571@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 06:39:36PM -0700, Bill Huey wrote:
> On Sat, Jul 29, 2006 at 06:22:59PM -0700, Nicholas Miell wrote:
> > On Sat, 2006-07-29 at 18:00 -0700, Bill Huey wrote:
> > > Think edge triggered verse level triggered. Event interfaces in the Linux
> > > kernel are sort of just that, edge triggered events. What RT folks generally
> > > want is control over scheduling policies over a particular time period in
> > > relation to a scheduling policy. A general kernel event interface isn't
> >                 ^ Did you mean to say timer here?
> 
> No, I really ment scheduling.

Bill, 

Do you mean frequency-based scheduling?  This was mentioned, IIRC, in
Gallmeister's book (Programming for the Real World, a must-read for
those interested in Posix real-time interfaces) as a likely extension
to the SCHED_RR/SCHED_FIFO scheduling policies and future additions to
the struct sched_policy used by sched_setparam() at some future point.


The basic idea here is that if you have some task which is cyclic in
nature, what might be useful would be to tell the scheduler that a
particular thread should be woken up every at a specific cyclic time;
and that thread promises it will only run for a certain amount of
time, and before that time expires, it will finish running.  If it
doesn't, this is considered an overrun situation, and a number of
different things can happen at that point, including a signal which
might or might not kill the process, merely recording the event that
there was an overrun.  It would be possible to have and soft and hard
overrun limits where you record the number and amount of time exceeded
of soft overruns, and upon a thread using up its promised time
quantuum plus the hard overrun limit, it gets a signal.

Since the scheduler knows when the cyclic tasks need to run, and how
much time they promise to take, in theory it might be able to do a
better job scheduling the threads, particularly if it knows that
certain threads can tolerate being scheduled earlier or later within
some time boundaries (which means even more fields in the struct
sched_policy).  At least, that's the theory.  The exact semantics of
what would actually be useful to application is I believe a little
unclear, and of course there is the question of whether there is
sufficient reason to try to do this as part of a system-wide
scheduler.  Alternatively, it might be sufficient to do this sort of
thing at the application level across cooperating threads, in which
case it wouldn't be necessary to try to add this kind of complicated
scheduling gorp into the kernel.

In any case, I don't think this is particularly interesting to the X
folks, although there may very well be real-time applications that
would find this sort of thing useful.

Regards,

						- Ted
