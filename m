Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUGUT52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUGUT52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266614AbUGUT52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 15:57:28 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:44789 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266611AbUGUT5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 15:57:17 -0400
Date: Wed, 21 Jul 2004 15:56:50 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721195650.GA2186@yoda.timesys>
References: <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721184650.GA27375@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 08:46:50PM +0200, Ingo Molnar wrote:
> * Scott Wood <scott@timesys.com> wrote:
> 
> > You're still running do_softirq() with preemption disabled, which is
> > almost as bad as doing it under a lock.
> 
> well softirqs are designed like that. 

And those who wish to continue using them like that can.  However, in
my patch they never run with preemption disabled, which can result in
substantial latency improvement (as long as nothing else is causing
similar delays).  I see nothing in the design that *requires* them to
continue running with preemption disabled.

Likewise, interrupts are "designed" to be unpreemptible, but it is
possible to run them in their own threads so as to further reduce
sources of latency (at a throughput cost, of course).  This allows
long-held spinlocks that an interrupt handler needs to acquire to be
replaced with mutexes that don't inhibit preemption.

Of course, a better fix is to keep the interrupt handlers and
critical sections short, but threading them can be very effective for
producing low latencies in the short term (we were able to achieve
worst measured case latencies of well under 100us on ordinary PC
hardware under 2.4.x using this approach).

> I've added extra preemption code to the latest patch to avoid
> repeat processing.

Do you also add preemption checks in all of the various loops that
can be run from within a single softirq instance?

-Scott
