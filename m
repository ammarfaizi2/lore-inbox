Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267898AbTAHOx1>; Wed, 8 Jan 2003 09:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbTAHOx1>; Wed, 8 Jan 2003 09:53:27 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:18886 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267898AbTAHOxZ> convert rfc822-to-8bit; Wed, 8 Jan 2003 09:53:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Larry McVoy <lm@bitmover.com>, venom@sns.it
Subject: Re: Honest does not pay here ...
Date: Wed, 8 Jan 2003 08:59:07 -0600
User-Agent: KMail/1.4.1
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
References: <20030107232820.GB24664@merlin.emma.line.org> <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it> <20030108003050.GF17310@work.bitmover.com>
In-Reply-To: <20030108003050.GF17310@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301080859.07911.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 January 2003 06:30 pm, Larry McVoy wrote:
> > In very semplicistic words:
> > In 2.5/2.6 kernels, non GPL modules have a big
> > penalty, because they cannot create their own queue, but have to use a
> > default one.
>
> I may be showing my ignorance here (won't be the first time) but this makes
> me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> drivers which ran in kernel mode but in the context of a process and had
> to talk to the real kernel via pipes or whatever.  It's a fair amount of
> plumbing but could have the advantage of being a more stable interface
> for the drivers.
>
> If you think about it, drivers are more or less
> open/close/read/write/ioctl. They need kernel privileges to do their thing
> but don't need (and shouldn't have) access to all the guts of the kernel.
>
> Can any well traveled driver people see this working or is it nuts?

The big problem is overhead.

The last successful user mode driver I used was in the old RSX-11
systems - all drivers were user mode.

The other place user mode drivers are used is in microkernel structures.

The problem is context switching time. If the hardware isn't designed to
support 10-20 simultaneous contexts, you must save/restore register sets
on each interrupt for the device.

If you split the driver into a kernel interface driver (the 
open/close/read/write/ioctl style) then you have a VERY limited time
for doing certain types of processing - consider the time delays that
would get imposed on audio synthesis - each segment must be encoded
by the driver before being sent to the kernel interface driver. The 
application then has to switch:
	appuser mode ->kernel->user mode driver->kernel mode
		interface->user mode driver->kernel->appuser mode
Before the application being able to resynchronize with the video.. which
would go through the same type of interface.

What Linux is using is more like a real time system. The tasklets/task queues
are more like a full featured RT system with priority queues. This allows a
fair amount of processing to be done by the driver without requiring heavy
handed context switching loads. What it appears to lack for a RT system is
a guaranteed interrupt latency.

In a microkernel envionment (where it can work) there need to be enough 
resources available to minimize the context switching - The Cray T3 used
basic Alpha processors (a LOT of them). The UNICOS kernel on top of the
microkernel distributed the load by puting only one or two drivers per
processor.

These drivers appear (I didn't get to see the source) to perform full context
switches for each interrupt/read/write/open/close/ioctl. The key here is that
the processor really doesn't have to do anything else. Cache memory remains
hot, and nothing is delayed.

User applications run on totally different CPUs (out of 1048 processors, 40
of them might be OS processors, out of the 40 there might be 20 that are 
filesystem/device drivers, the others handle user batch scheduling 
scheduling, resource allocation and  system calls. 8 to 10 additional ones
are used for "command" processors (not handling batch jobs) used for
complers, interactive access, and non-parallel utilties. The rest are
 "application processors" and are dedicated to batch and/or parallel programs.

I have never really seen a generic processor that could run user mode
drivers very well - even the PDP-11s could not do that well for certain
devices, and they only had 8 registers to save/restore.

I would think that user mode drivers would need (ideally):

1. multiple user register sets in hardware - at least (5 to 10).
2. near zero context switching - calling for the MMU to support (5 to 10) 
	simultaneous contexts.
3. use one control register to switch between user register sets and MMU
	contexts.
4. multiple cache memory modules ... 10 desirable, one per register set.
5. multiple processing levels (almost every processor has 2, Intel has 4)

The 5-10 register sets/MMU sets is based on:

1. disk driver
1. filesystem driver
1. video driver
1. keyboard driver
1. system call/user process

If more drivers are loaded/active then you would want more or you get into
scheduling collisions with context save/restore overhead. It would also
be desirable to have one for the system call/scheduler to eliminate that
overhead too, but IMHO that one can be shared with the user process.

Context switching time should be very nearly equivalent to a subroutine call
then - select the context, select the entry point, switch. Any parameter
passing could be almost the same as a subroutine parameter + a cache miss.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
