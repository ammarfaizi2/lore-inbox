Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTERAxc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 20:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTERAxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 20:53:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52657
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261874AbTERAxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 20:53:30 -0400
Date: Sun, 18 May 2003 03:06:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Schwartz <davids@webmaster.com>
Cc: dak@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030518010621.GC1429@dualathlon.random>
References: <20030517235048.GB1429@dualathlon.random> <MDEHLPKNGKAHNMBLJOLKIELBDAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIELBDAAA.davids@webmaster.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 05:16:33PM -0700, David Schwartz wrote:
> 
> > I see what you mean, but I still don't think it is a problem. If
> > bandwidth matters you will have to use large writes and reads anyways,
> > if bandwidth doesn't matter the number of ctx switches doesn't matter
> > either and latency usually is way more important with small messages.
> 
> > Andrea
> 
> 	This is the danger of pre-emption based upon dynamic priorities. You can
> get cases where two processes each are permitted to make a very small amount
> of progress in alternation. This can happen just as well with large writes
> as small ones, the amount of data is irrelevent, it's the amount of CPU time
> that's important, or to put it another way, it's how far a process can get
> without suffering a context switch.
> 
> 	I suggest that a process be permitted to use up at least some portion of
> its timeslice exempt from any pre-emption based solely on dynamic
> priorities.

that's the issue yes. but then when a multithreaded app sends a signal
to another process  it can take up to this "x" timeslice portion before
the signal will run (I mean in UP). Same goes for mouse clicks etc..
1msec for mouse clicks should not be noticeable though. And over all I
don't see a real big issue in the current code.

To try it probably the simpler way to add a need_resched_timeout
along to need_resched, and to honour the need_resched only when the
timeout triggers, immediate need_resched will set the timeout = jiffies
so it'll trigger immediatly, the timer interrupt will check it. The
reschedule_idle on a non idle cpu will be the only one to set the
timeout. Effectively I'm curious to see what will happen. Not all archs
would need to check against it (the entry.S code is the main reader of
need_resched), it'll be an hint only and idle() for sure must not check
it at all. this would guarantee minimal timeslice reserved up to 1/HZ by
setting the timeout to jiffies + 2 (jiffies + 1 would return a mean of
1/HZ/2 but the worst case would be ~0, in practice even + 1 would be
enough) Does anybody think this could have a value? If yes I can make a
quick hack to see what happens.

Andrea
