Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbTCHTXg>; Sat, 8 Mar 2003 14:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbTCHTXg>; Sat, 8 Mar 2003 14:23:36 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:52388 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261631AbTCHTXe>; Sat, 8 Mar 2003 14:23:34 -0500
Subject: Re: [patch] oprofile for ppc
From: Albert Cahalan <albert@users.sf.net>
To: benh@kernel.crashing.org
Cc: paulus@samba.org, albert@users.sourceforge.net,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       segher@koffie.nl, o.oppitz@web.de, afleming@motorola.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1047136206.12202.85.camel@zion.wanadoo.fr>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
	<1047032003.12206.5.camel@zion.wanadoo.fr>  <1047061862.1900.67.camel@cube>
	 <1047136206.12202.85.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Mar 2003 14:30:29 -0500
Message-Id: <1047151830.2012.149.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 10:10, Benjamin Herrenschmidt wrote:
> On Fri, 2003-03-07 at 19:31, Albert Cahalan wrote:

>> This is just the first part of the code. Please merge it
>> into any tree you have, unless it's obviously broken.
>> It is useful for long-running processes that don't do
>> much that is tied to the clock tick. (number crunching,
>> maybe X, web browsers without animations, /tmp cleaner...)
>>
>> The i386 port is already using 1000 Hz in the kernel,
>> and has 100 Hz as a non-default option. I'd really like
>> to have this on my Mac; lots of things would improve.
>>
>> I intend to allow sampling based on the performance counter
>> interrupt/trap/exception and the external interrupt signal.
>
> Ok. I'll ask paulus about merging this.
>
> Beware though that some G4s have a nasty bug that prevents
> using the performance counter interrupt (and the thermal interrupt
> as well). The problem is that if any of those fall at the same
> time as the DEC interrupt, the CPU messes up it's internal
> state and you lose SRR0/SRR1, which means you can't recover
> from the exception.

Ouch. Motorola's description looks really suspicious.
The other interrupts "not affected by this errata"
might not suffer the 2-cycle MSR(EE) reset delay,
but they sure would interact with the broken ones.

MPC7400PNS.pdf doesn't list the bug; is a MPC7400 OK?
If not, perhaps you can send me some better info.

The decrementer isn't needed on systems with the
performance monitor. Simply require that one of the
PMCx registers count something like clock ticks, and
require that performance monitor interrupts be enabled.
Problem solved, eh?

> Note also that it should be relatively easy to have the
> DEC timer run faster than HZ. The code in timer.c can
> deal with spurrious DEC interrupts, so you may improve
> your results by just making it fire at 1Khz or higher.

How about this:

Bound the alarm clock (decrementer or an alternative)
setting such that it always fires between 10000 bus
cycles (safe number?) and 1/4000 second into the future.
Update jiffies purely based on the timebase register.
HZ is 1000. This ought to help with high-res timers.

If that special page at the top of user-space got
implemented (did it?), supply timebase frequency and
offset info there for non-SMP systems. (and for SMP
too if somebody cares to count the 60x/MPX bus cycles
involved in synchronizing timebase registers)


