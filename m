Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWGZOqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWGZOqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWGZOqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:46:15 -0400
Received: from thunk.org ([69.25.196.29]:65244 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750946AbWGZOqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:46:14 -0400
Date: Wed, 26 Jul 2006 10:45:36 -0400
From: Theodore Tso <tytso@mit.edu>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: A better interface, perhaps: a timed signal flag
Message-ID: <20060726144536.GA28597@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Neil Horman <nhorman@tuxdriver.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, jg@freedesktop.org
References: <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org> <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com> <20060726002043.GA5192@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726002043.GA5192@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:20:43PM -0400, Neil Horman wrote:
> > Yes, there are plenty of systems which don't have an RTC, or have an RTC 
> > which can't generate interrupts.
> > 
> Ok, for those implementations which don't have an RTC that the rtc driver can
> drive, the mmap functionality will not work, but at that point what interface
> are you left with at all for obtaining periodic time?

Well, the HPET, for one.  My main problem with this interface is that
it is tied to the /dev/rtc, and the system may have any number of
timer hardware that may be more appropriate, and it shouldn't be up to
the user application to select which one.

But this does bring up an interesting coding paradigm which is used by
more than just the X server.  As it turns out, there is a real-time
garbage collector[1] for Java that needs exactly the same thing, although
the resolution window is a few orders of magnitude faster than what X
needs.  Fundamentally, this coding paradigm is:

	while (work to do) {
		do_a_bit_of_work();
		if (we_have_exceeded_a_timeout_period())
			break;  
	}
	/* Clean up and let some other client/thread run */

So there are a couple of things to note about this high-level
abstracted paradigm.  The application doesn't need to know _exactly_
how much time has passed, just whether or not the the appointed time
slice has expired (which might be 10ms or it might be 100us in the
case of the rt garbage collector).  So calculating exactly how much
time has ellapsed is not necessary, and if there is a single-shot
event timer hardware available to the system, it might be sufficient.
So even if a VDSO implementation of gettimeofday() would be faster
than calling gettimeofday(), it still may be doing work that strictly
speaking doesn't need to happen; if the application doesn't need to
know exactly how many microseconds have gone by, but just whether or
not 150us has ellapsed, why calculate the necessary time?  (Especially
if it requires using some ACPI interface...)

Secondly, it's different from a kernel-mediated secheduler timeslice
because the application needs to give up control only at certain
specifically defined stopping points (i.e., after copying a tiny
amount of live data in an incremental garbage collector design, or
after servicing a single X request, for example), and it may need to
do some cleanups.  So it's often not possible to just say, well, put
it in its own thread, and let the scheduler handle it. 

So maybe what we need is an interface where a particular memory
location gets incremented when a timeout has happened.  It's probably
enough to say that each thread (task_struct) can have one of these
(another problem with using /dev/rtc and tieing it directly to
interrupts is that what happens if two processes want to use this
facility?), and what hardware timer source gets used is hidden from
the user application.  In fact, depending on the resolution which is
specified (i.e., 100's of microseconds versus 10's of milliseconds),
different hardware might get used; we should leave that up to the
kernel.

The other thing which would be nice is if the application could
specify whether it is interested in CPU time or wall clock time for
this timeout.

If we had such an interface, then the application would look like
this:

	volatile int	flag = 0;

	register_timout(&time_val, &flag);
	while (work to do) {
		do_a_bit_of_work();
		if (flag)
			break;
	}

Finally, a note about tickless designs.  Very often such applications
don't need a constantly ticking design.  For example, the X server
only needs to have the memory location incremented while it is
processing events; if the laptop is idle, there's no reason to have
the RTC generating interrupts and incrementing memory locations.
Similarly, the Metronome garbage collector would only need to poll to
see if the timeout has expired while the garbage collector is running,
which is _not_ all of the time.  

Yes, you could use ioctl's to start and stop the RTC interrupt
handler, but that's just ugly, and points out that maybe the interface
should not be one of programming the RTC interrupt frequency directly,
but rather one of "increment this flag after X units of
(CPU/wallclock) time, and I don't care how it is implemented at the
hardware level."

Regards,

						- Ted

[1] http://www.research.ibm.com/people/d/dfb/papers/Bacon03Metronome.pdf
"The Metronome: A Simpler Approach to Garbage Collection in Real-time
Systems", by David Bacon, Perry Cheng, and V.T. Rajan, Workshop on
Java Technologies for Real-Time and Embedded Systems (Catania, Sicily,
November 2003.  (See also http://www.research.ibm.com/metronome)

