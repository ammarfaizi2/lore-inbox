Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318359AbSHEKik>; Mon, 5 Aug 2002 06:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSHEKik>; Mon, 5 Aug 2002 06:38:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13289 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318359AbSHEKik>;
	Mon, 5 Aug 2002 06:38:40 -0400
Date: Mon, 5 Aug 2002 12:40:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Richard Zidlicky <rz@linux-m68k.org>, Jeff Dike <jdike@karaya.com>,
       Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user
 mode linux]
In-Reply-To: <m3u1mb5df3.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0208051223430.8173-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Aug 2002, Andi Kleen wrote:

> > actually the opposite is true, on a 2.2 GHz P4:
> > 
> >   $ ./lat_sig catch
> >   Signal handler overhead: 3.091 microseconds
> > 
> >   $ ./lat_ctx -s 0 2
> >   2 0.90
> > 
> > ie. *process to process* context switches are 3.4 times faster than signal
> > delivery. Ie. we can switch to a helper thread and back, and still be
> > faster than a *single* signal.
> 
> This is because the signal save/restore does a lot of unnecessary stuff.
> One optimization I implemented at one time was adding a SA_NOFP signal
> bit that told the kernel that the signal handler did not intend to
> modify floating point state (few signal handlers need FP) It would not
> save the FPU state then and reached quite some speedup in signal
> latency.

well, we have an optimization in this area already - if the thread
receiving the signal has not used any FPU registers during its current
scheduled atom yet then we do not save the FPU state into the signal
frame.

lat_sig uses the FPU so this cost is added. If the FPU saving cost is
removed then signal delivery latency is still 2.0 usecs - slightly more
than twice as expensive as a context-switch - so it's not a win. And
threads can do queued events that amortizes context switch overhead, while
queued signals generate per-event signal delivery, so signal delivery
costs are not amortized.

(Not that i advocate SIGIO or helper threads for highperformance IO -
Ben's aio interface is the fastest and most correct approach.)

	Ingo

