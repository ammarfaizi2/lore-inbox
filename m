Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbTCJGYU>; Mon, 10 Mar 2003 01:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbTCJGYT>; Mon, 10 Mar 2003 01:24:19 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:47836 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261628AbTCJGYS>; Mon, 10 Mar 2003 01:24:18 -0500
Subject: Re: [patch] oprofile for ppc
From: Albert Cahalan <albert@users.sf.net>
To: Segher Boessenkool <segher@koffie.nl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, afleming@motorola.com, linux-kernel@vger.kernel.org
In-Reply-To: <3E6C0B93.5040205@koffie.nl>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>	
	<1047032003.12206.5.camel@zion.wanadoo.fr>  <1047061862.1900.67.camel@cube>
	<1047136206.12202.85.camel@zion.wanadoo.fr>  <3E6C0B93.5040205@koffie.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Mar 2003 01:31:14 -0500
Message-Id: <1047277876.2012.360.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 22:50, Segher Boessenkool wrote:
> Benjamin Herrenschmidt wrote:

>> Beware though that some G4s have a nasty bug that
>> prevents using the performance counter interrupt
>> (and the thermal interrupt as well).
>
> MPC7400 version 1.2 and lower have this problem.

MPC7410 you mean, right? Are those early revisions
even popular?

I'm wondering if the MPC7400 is also affected.
The MPC7400 has some significant differences.
The pipeline length changed.

>> The problem is that if any of those fall at the same
>> time as the DEC interrupt, the CPU messes up it's
>> internal state and you lose SRR0/SRR1, which means
>> you can't recover from the exception.
> 
> But the worst that happens is that you lose that
> process, isn't it?  Not all that big a problem,
> esp. since the window in which this can happen is
> very small.

I think you'd get an infinite loop of either
the decrementer or performance monitor. That's
mostly fixable by checking for the condition and
killing the affected process, but that process
could be one of the ones built into the kernel.

So the use of oprofile comes down to a choice:

a. Ignore the problem.
   rare crashes

b. The decrementer goes much faster for profiling.
   high overhead, awkwardness in non-time measurement

c. The performance monitor is used for clock ticks.
   hard choices about sharing or frequency

Besides the obvious use of core cycles to generate
a clock tick out of the performance monitor, there
is the tbsel field in MMCR0. That has some strange
frequency choices. On a system with a 100 MHz bus,
it looks like one gets:

12.5 MHz, 49 kHz, 3 kHz, 191 Hz

So 3 kHz it is. That's 1526 Hz on a 50 MHz bus,
or 6104 Hz on a 200 MHz bus. This is enough to
get a 1000 Hz jiffies with reasonable jitter on
most machines, and a very good 100 Hz for user apps.


