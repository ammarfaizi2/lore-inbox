Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTESQjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTESQjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:39:10 -0400
Received: from almesberger.net ([63.105.73.239]:25353 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262000AbTESQjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:39:09 -0400
Date: Mon, 19 May 2003 13:51:44 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-cleanup-2.5.69-A0
Message-ID: <20030519135144.A1432@almesberger.net>
References: <20030519121331.C1475@almesberger.net> <Pine.LNX.4.44.0305191807260.13379-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305191807260.13379-100000@localhost.localdomain>; from mingo@elte.hu on Mon, May 19, 2003 at 06:09:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> hm, it should in fact have been dead code from 2.5.68 on and upwards.  
> Before that it was called quite often.

Ah, that makes sense: I hit it in 2.5.66 and haven't tried more
recent kernels yet.

> but doing stuff out of the idle thread is not nice i think, there's a fair
> amount of code that does not work out of the idle task.

Yes, that's what I'm a bit worried about. Not calling anything
that may sleep sounds fair enough to me. At least networking
(that is, ARP and TCP) seems to be okay (I'm calling netif_rx,
plus a few simple helper functions, such as flow control, and
dev_alloc_skb), but it would of course be nice to avoid future
pitfalls.

A bit of background: umlsim (http://umlsim.sourceforge.net/)
turns UML into an event-driven simulator. It sits in the idle
thread to handle timeouts (simulation time doesn't move while
there is any pending work). All this is controlled by a master
process that works as a script-driven debugger. What those
scripts do is up to the user, but there's a (currently very
small) set of "library" functions that handle some of the more
common tasks, such as moving packets from one UML to the next.

> Any reason you
> dont start some really-low-prio thread instead? (i could suggest
> SCHED_BATCH but the scheduler doesnt have it :-)

Yes, I could do that, as long as this thread gets only run if there
is really nothing else left to do, but then only this thread runs.
Which is, of course, exactly what the idle thread does.

I could make it yield if anything else is runnable (I already check
for this, but just to panic). I suppose if I just set p->static_prio
to MAX_PRIO-1, this thread that would give me only very few
activations while other processes are runnable ?

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
