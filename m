Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312160AbSCTUpR>; Wed, 20 Mar 2002 15:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312157AbSCTUpI>; Wed, 20 Mar 2002 15:45:08 -0500
Received: from daimi.au.dk ([130.225.16.1]:7270 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S293226AbSCTUpD>;
	Wed, 20 Mar 2002 15:45:03 -0500
Message-ID: <3C98F4C8.703E4574@daimi.au.dk>
Date: Wed, 20 Mar 2002 21:44:56 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Micro-Second timers in kernel ?
In-Reply-To: <20020315164845.A15889@bougret.hpl.hp.com> <3C92B126.852DC838@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Jean Tourrilhes wrote:
> >
> >         Well... I'm stuck. 10ms is a very long time at 4Mb/s. So, I
> > guess I'll continue to busy wait before sending each packet. Ugh !
> >
> The overhead to do a timer is on the order of at least 100 us on an
> 800MHZ machine.  Given this, a timer/ interrupt based delay for less
> than 100 us is probably a bad idea.

I have been considering all this timer thing for some time. I would
actually like to see the interrupt at regular intervals completely
removed from the kernel.

Instead I would rather be using a programable one shot timer. The
PIT used in the i386 based machines actually can do that, although
it is not the best designed hardware I could imagine. I don't know
what posibilities there are in other hardware.

The idea behind all this is that the timers are used for two
different purposes. One purpose is that we want particular pieces
of code executed at given times, the one shot timer can be used for
that. The other purpose is to meassure time intervals, this can be
done better in hardware without the need for interrupts, the TSC is
more or less a proof of that.

What we need to do is that whenever we want a function called at a
specified time, we insert a struct containing the time and whatever
additional information we need into a priority queue. We then take
the difference between the current time and the time from the head
of the queue and reprogram the oneshot timer if necesarry.

Whenever the timer interrupt gets invoked it should keep executing
the first element from the priority queue, until the element in the
head has a time stamp in the future. Then it should either busywait
or reprogram the timer depending on the needed delay compared to
the overhead. All this should probably not be done by the timer
interrupt itself, so perhaps we would use a kernel thread, a tasklet
or something else. I haven't yet figured out exactly what would be
the best.

The problem with this idea is primarily that a lot of code might
need to be rewritten. We would also need another unit for the
jiffies variable, nanoseconds would probably be a good choice. But
this would probably need it to be a 64bit integer even on 32bit
architectures. And actually jiffies should no longer be a variable
but actually a function call. (This is in some way similar to what
happened to current at some time.)

I have been considering a few implementation details on the i386
architecture, obviously a combination of the PIT and the TSC will
be needed. The TSC cannot produce interrupts, and the PIT cannot
reliably be used to meassure time when used as one shot timer.

The PIT has a well specified frequency, the TSC doesn't. I don't
know about the accuracy of the two. We would need to know the
frequency of the TSC, but I guess the kernel already meassures
that at bootup. I would suggest that the frequency meassured in HZ
would be put in some proc pseudofile. Then there is an easy way
for applications to read it, and root can change it if needed. The
posibility of changing of this pseudofile would have two main
purposes. First of all it can be used on hardware were the boot
time measurement of the frequency is for some reason wrong. Second
a feature could be added to ntpd to change the frequency used by
the kernel in order to slowly adjust the time towards the right
value.

The accuracy with which we know the TSC speed will affect the
accuracy of the time. However the accuracy of the PIT should not
be that important. If interrupts come too early we will either
busywait a very short time, or we will just schedule another
interrupt. If interrupts come too late, some process will sleep
slightly longer than it was supposed to, but that is no worse
than what the kernel promises. And probably no worse than the
current implementation.

With all this in place the scheduler does no more need to use
fixed size timeslices, it could implement growing time slices and
decreasing priorities for processes that needs lots of CPU time.
And OTOH use small time slices for interactive processes.

There are still a few questions for which I do not yet know the
answers:
- How much overhead will the timer interrupts have with this new
  design?
- How much overhead will the needed 64bit calculations in the
  kernel have?
- Will this be possible on all architectures on which Linux runs.
  And are there any architectures where this will be easy to
  implement?
- Is the TSC frequency reliable enough to be used for this?

I'm absolutely sure that this will require a lot of work to
implement, but with the right architecture I believe it would be
a very good idea. Is it worth a try?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
