Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266904AbRGMAg5>; Thu, 12 Jul 2001 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266906AbRGMAgr>; Thu, 12 Jul 2001 20:36:47 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:45333
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S266904AbRGMAgl>; Thu, 12 Jul 2001 20:36:41 -0400
Date: Thu, 12 Jul 2001 17:36:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010712173641.C11719@work.bitmover.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com> <XFMail.20010712172255.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.20010712172255.davidel@xmailserver.org>; from davidel@xmailserver.org on Thu, Jul 12, 2001 at 05:22:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be careful tuning for LMbench (says the author :-)

Especially this benchmark.  It's certainly possible to get dramatically better
SMP numbers by pinning all the lat_ctx processes to a single CPU, because 
the benchmark is single threaded.  In other words, if we have 5 processes,
call them A, B, C, D, and E, then the benchmark is passing a token from
A to B to C to D to E and around again.  

If the amount of data/instructions needed by all 5 processes fits in the 
cache and you pin all the processes to the same CPU you'll get much 
better performance than simply letting them float.

But making the system do that naively is a bad idea.

This is a really hard area to get right but you can take a page from all
the failed process migration efforts.  In general, moving stuff is a bad
idea, it's much better to leave it where it is.  Everything scales better
if there is a process queue per CPU and the default is that you leave the
processes on the queue on which they last run.  However, if the load average
for a queue starts going up and there is another queue with a substantially
lower load average, then and ONLY then, should you move the process.

I think if you experiment with that you'll see that lat_ctx does well and
so do a lot of other things.

An optimization on that requires hardware support.  If you knew the number
of cache misses associated with each time slice, you could factor that in
and start moving processes that have a "too high" cache miss rate, with the
idea being that we want to keep all processes on the same CPU if we can
but if that is causing an excessive cache miss rate, it's time to move.

Another optimization is to always schedule an exec-ed process (as opposed
to a forked process) on a different CPU than its parent.  In general, when
you exec you have a clear boundary and it's good to spread those out.

All of this is based on my somewhat dated performance efforts that lead to
LMbench.  I don't know of any fundamental changed that invalidate these 
opinions but I could be wrong.

This is an area in which I've done a pile of work and I'd be interested
in keeping a finger in any efforts to fix up the scheduler.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
