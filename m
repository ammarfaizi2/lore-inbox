Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292380AbSBPPRc>; Sat, 16 Feb 2002 10:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292382AbSBPPRY>; Sat, 16 Feb 2002 10:17:24 -0500
Received: from [208.166.87.138] ([208.166.87.138]:20661 "EHLO server.rwii.com")
	by vger.kernel.org with ESMTP id <S292380AbSBPPRO>;
	Sat, 16 Feb 2002 10:17:14 -0500
Message-ID: <3C6E77DE.70FE49DF@rwii.com>
Date: Sat, 16 Feb 2002 10:16:46 -0500
From: Tyson D Sawyer <tyson@rwii.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Missed jiffies
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system looses about 8 seconds every 20 minutes.  This is reported
by ntp and verified by comparing 'date' to 'hwclock --show' and a wall
clock.

My system is a x86 Dell laptop with HZ=1024.

I am quite certain that the issue is the System Management Interrupt
(SMI).

While doing latency tests I have observed 18ms delays every 2 seconds.
 Like, as they say, clock work.  Given that in 18ms with HZ==1024
roughly 18 timer interrupts should occur then 17 of them (I believe)
would be lost.  Looking in the kernel sources I could find nothing
that adjusts for this.

Since I have defined HZ to be 1024, I miss lots of timer interrupts. 
However, since the the processor spends 18ms at a time in SMM (System
Mangement Mode), then even the stock 10ms timer tick will sometimes
miss a tick.  Thus the problem applies to non-hacked kernels also.

I don't know that there is a solution for all systems, however, at
least on pentium systems it seems possible to use the TSC to catch
this.  However, even if I worked up a patch to do so, do_timer()
always increments jiffies by just 1 count and it isn't clear that its
safe to call it repeatedly to catch up with lost ticks.  It also isn't
clear that it would be safe to modify jiffies directly in one of the
arch/i386/kernel/time.c functions.

In general, I'd like to try a solution that looks something like:

tsc_per_jiffie = cpu_khz * 1000 / HZ;

tsc_remainder += last_tsc_low-tsc_low;
jiffies_increment=0;
do {
	tsc_remainder -= tsc_per_jiffie;
	jiffies_increment++;
} while (tsc_remainder > tsc_per_jiffie);

do_timer(regs, jiffies_increment);

The above was created on the fly and completely untested.  It needs
bits like making sure that the arithmetic works properly on overflow
of tsc_low.  It also requires a patch to do_timer() and proper
structuring for portability.

One problem I see is that tsc_per_jiffie must be perfect or time will
drift.  I think it might work to not carry over the remainder from
cycle to cycle under some conditions (no missed ticks) but I'd have
to think about that the effects of timing jitter on this.

Have attempts to address this problem been made before?

What are the problems with incrementing jiffies by more than 1?

What problems have I missed?

What strategies might be employed to prevent degraded system
performance since this code is in a criticle path?

Have I competely missed something, the kernel already takes care of
this and I have the problem all wrong?

This problem also comes up with IDE access with dma off and I've
seen reports of it when using frame buffers.

Thanks!
Ty


-- 
Tyson D Sawyer                             iRobot Corporation
Senior Systems Engineer                    Military Systems Division
tsawyer@irobot.com                         Robots for the Real World
603-532-6900 ext 206                       http://www.irobot.com
