Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262748AbTCJIck>; Mon, 10 Mar 2003 03:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262749AbTCJIck>; Mon, 10 Mar 2003 03:32:40 -0500
Received: from AMarseille-201-1-1-111.abo.wanadoo.fr ([193.252.38.111]:12327
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262748AbTCJIci>; Mon, 10 Mar 2003 03:32:38 -0500
Subject: Re: [patch] oprofile for ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Segher Boessenkool <segher@koffie.nl>, oprofile-list@lists.sourceforge.net,
       linuxppc-dev@lists.linuxppc.org, o.oppitz@web.de, afleming@motorola.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1047277876.2012.360.camel@cube>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
	 <1047032003.12206.5.camel@zion.wanadoo.fr> <1047061862.1900.67.camel@cube>
	 <1047136206.12202.85.camel@zion.wanadoo.fr>  <3E6C0B93.5040205@koffie.nl>
	 <1047277876.2012.360.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047285780.19211.15.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 09:43:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 07:31, Albert Cahalan wrote:
> On Sun, 2003-03-09 at 22:50, Segher Boessenkool wrote:
> > Benjamin Herrenschmidt wrote:
> 
> >> Beware though that some G4s have a nasty bug that
> >> prevents using the performance counter interrupt
> >> (and the thermal interrupt as well).
> >
> > MPC7400 version 1.2 and lower have this problem.
> 
> MPC7410 you mean, right? Are those early revisions
> even popular?
> 
> I'm wondering if the MPC7400 is also affected.
> The MPC7400 has some significant differences.
> The pipeline length changed.

7400 and 7410 are quite similar. I had the problem on
my old G4 which is a 7400 (I don't have it any more so
I can't tell you about the CPU rev).

> >> The problem is that if any of those fall at the same
> >> time as the DEC interrupt, the CPU messes up it's
> >> internal state and you lose SRR0/SRR1, which means
> >> you can't recover from the exception.
> >
> > But the worst that happens is that you lose that
> > process, isn't it?  Not all that big a problem,
> > esp. since the window in which this can happen is
> > very small.
> 
> I think you'd get an infinite loop of either
> the decrementer or performance monitor. That's
> mostly fixable by checking for the condition and
> killing the affected process, but that process
> could be one of the ones built into the kernel.

You can lose the kernel state as well

> So the use of oprofile comes down to a choice:
> 
> a. Ignore the problem.
>    rare crashes

Not that rare as soon as you increase the interrupt frequency

> b. The decrementer goes much faster for profiling.
>    high overhead, awkwardness in non-time measurement

The overhead of a single DEC interrupt isn't _that_ high

> c. The performance monitor is used for clock ticks.
>    hard choices about sharing or frequency
> 
> Besides the obvious use of core cycles to generate
> a clock tick out of the performance monitor, there
> is the tbsel field in MMCR0. That has some strange
> frequency choices. On a system with a 100 MHz bus,
> it looks like one gets:
> 
> 12.5 MHz, 49 kHz, 3 kHz, 191 Hz
> 
> So 3 kHz it is. That's 1526 Hz on a 50 MHz bus,
> or 6104 Hz on a 200 MHz bus. This is enough to
> get a 1000 Hz jiffies with reasonable jitter on
> most machines, and a very good 100 Hz for user apps.
> 
> 
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
