Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293416AbSBYQOl>; Mon, 25 Feb 2002 11:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293418AbSBYQOc>; Mon, 25 Feb 2002 11:14:32 -0500
Received: from users.ccur.com ([208.248.32.211]:30558 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293416AbSBYQOQ>;
	Mon, 25 Feb 2002 11:14:16 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200202251613.QAA10726@rudolph.ccur.com>
Subject: Re: Bug report: smp affinity patch
To: hahn@physics.mcmaster.ca (Mark Hahn)
Date: Mon, 25 Feb 2002 11:13:52 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <Pine.LNX.4.33.0202221834430.19736-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Feb 22, 2002 06:35:51 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On occasion, the smp affinity patch can leave one or more runnable
>> processes in such a state that the scheduler never selects them for
> 
> out of curiosity, do you have data on some case where this kind of
> affinity fiddling produces a  noticable improvement in performance? 
> people always say it does, but it's not clear whether that's just
> because famous old systems in the past did it...


Hi Mark,
 Sorry about the delay.  Your letter must have come in just as I was
stepping out the door last Friday night.

Such fiddling never `increases performance', it always results in a
massively suboptimal use of system resources.  Therefore one shields
only when the loss in performance is a non-issue, compared to the
gain in timely responsiveness to external events experienced by
applications running on the shielded cpus.  `Timely responsiveness'
is typically measured by how erratic an application is in responding
to an external event repeated over and over; this variation in
response time I call jitter.

One can measure jitter with a dual trace oscilloscope, a square wave
generator, and a PC with an external input/output interrupt card with
a matching driver which lets an application sleep, waiting on
interrupts from that driver.  The test application is a few lines of
C code that loops forever, sending out an external interrupt every
time it wakes up due to the arrival of an input external interrupt.

With channel 1 of the oscilloscope also attached to the square wave
generator and channel 2 attached to the external interrupt output pin
of the PC, one can graphically see on the scope 1) the average delay
time it takes the PC (hardware, driver, OS, and application in toto)
to respond to an interrupt, and 2) the variations (jitter) from that
average time, how often such variations occur, and their magnitude.

Now I haven't run the above test myself for Linux, but one of the
guys here has, and he says that under Linux we see an average delay
between the input and output pulses of 11 microseconds, and that most
of the delays fall within a few microseconds of that.  However, there
are occasional delays much longer than this, with the longest being
an occasional 10 MILLIseconds..which would be a a truely horrendous
jitter, if true.

The above is with shielding off; we have not done experiments with
our shielding code turned on in Linux since that is not working yet.

I imagine the 10 millisecond delay is due to the standard linux
scheduler, which is priority-less and often favors running a
currently running program over switching to a newly-runnable program.
The new O(1) scheduler might fix that, although I haven't looked at
it yet to see if my hope has any basis in fact.

Once the scheduler issues are fixed then shielding becomes useful
keeping ordinary, noncritical processes off of a cpu.  Process
priority alone does not protect much against the jitter these
processes introduce, as they can at any time enter the kernel via a
system call. There, they can grab spinlocks and lock out interrupts
for short periods of time .. those short periods of time often being
in the 100's of microseconds, for a well-threaded system (which Linux
is not, yet).   These lockouts prevent the scheduler from running and
thus are a source of jitter that is 10x of the normal response time of
the PC to an external interrupt.

In combination with process shielding, one also should use IRQ
shielding (/proc/irq/n/affinity interface), in order to steer
interrupts from noncritical devices over to the unshielded cpus.
Interrupt processing is also a source of jitter in the 100's of
microsecond range, and given todays networking cards, whose drivers
like to loop at interrupt level processing boo-ko numbers of packets,
can often hold out interrupts for much longer than 100's of
microseconds..

Joe
