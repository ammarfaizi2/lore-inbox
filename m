Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUGVC2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUGVC2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUGVC2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:28:44 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:25792 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266790AbUGVC2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:28:40 -0400
Date: Wed, 21 Jul 2004 22:28:10 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722022810.GA3298@yoda.timesys>
References: <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721214534.GA31892@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 11:45:34PM +0200, Ingo Molnar wrote:
> do you have a 2.6 patch for hardirq redirection too? 

Yes, and I'll try to get it cleaned up and posted soon.  It depends
on threaded softirqs, though (so I'll have to do something with the
local_bh_disable; probably put it back to the way it was, at least
for now).

> I always thought this to be the best approach to achive hard-RT
> class latency guarantees under Linux (but never coded it up). The
> problem with RTLinux is that it introduces a separate OS (with
> separate APIs). 

If you really want hard-RT-type guarantees, though, you'd need to go
with a scheme whereby interrupts/preemption are disabled only where
the code has specifically been "approved" as not capable of causing
excessive latency (which IRQ threads are a step towards, and which is
what we did in 2.4), as opposed to the current scheme of benchmarking
latencies and fixing those places which actually show up as being
problematic.  There's always the possibility that a different usage
case will show up later, causing the latency in some piece of code to
go way up.

> if both hardirqs and softirqs are redirectable to process contexts then
> the only unpredictable latency would be the very short IRQ entry stub of
> a new hardirq costing ~5 usecs - which latency is limited in effect
> unless the CPU is hopelessly bombarded with interrupts.

Those aren't the only sources; you also have preempt_disable() and
such (as well as hardware weirdness, though there's not much we can
do about that).

> to solve the spinlock problem of hardirqs i'd propose a dual type
> spinlock that is a spinlock if hardirqs are immediate (synchronous) and
> it would be a mutex if hardirqs are redirected (asynchronous). Then some
> simple driver could be converted to this RT-aware spinlock and we'd see
> how well it works. Have you done experiments in this direction? 

This sort of substitution is what we did in 2.4, though we made this
type the default and gave the real spinlocks a new name to be used in
those few places where it was really needed.  Of course, this
resulted in a lot of places using a mutex where a spinlock would have
been fine.

-Scott
