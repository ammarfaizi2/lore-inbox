Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUECUF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUECUF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUECUF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:05:27 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:13799 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S263718AbUECUFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:05:17 -0400
Date: Mon, 3 May 2004 13:04:09 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>
Subject: Re: RCU scaling on large systems
Message-ID: <20040503200408.GC1246@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com> <200405030939.11707.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405030939.11707.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 09:39:11AM -0700, Jesse Barnes wrote:
> On Sunday, May 2, 2004 11:28 am, Paul E. McKenney wrote:
> > From your numbers below, I would guess that if you have at least
> > 8 CPUs per NUMA node, a two-level tree would suffice.  If you have
> > only 4 CPUs per NUMA node, you might well need a per-node level,
> > a per-4-nodes level, and a global level to get the global lock
> > contention reduced sufficiently.
> 
> Actually, only 2, but it sounds like your approach would work.

OK, make that a per-node level, a per-8-nodes level, and a global
level.  ;-)  The per-node level might or might not be helpful,
depending on your memory latencies.

> > Cute!  However, it is not clear to me that this approach is
> > compatible with real-time use of RCU, since it results in CPUs
> > processing their callbacks less frequently, and thus getting
> > more of them to process at a time.
> 
> I think it was just a proof-of-concept--the current RCU design obviously 
> wasn't designed with this machine in mind :).

Agreed!  ;-)

> > But it is not clear to me that anyone is looking for realtime
> > response from a 512-CPU machine (yow!!!), so perhaps this
> > is not a problem...
> 
> There are folks that would like realtime (or close to realtime) response on 
> such systems, so it would be best not to do anything that would explicitly 
> prevent it.

The potential problem with less-frequent processing of callbacks is
that it would result in larger "bursts" of callbacks to be processed,
degrading realtime scheduling latency.  There are some patches that
help avoid this problem, but they probably need more testing and
tuning.

> > This patch certainly seems simple enough, and I would guess that
> > "jiffies" is referenced often enough that it is warm in the cache
> > despite being frequently updated.
> >
> > Other thoughts?
> 
> On a big system like this though, won't reading jiffies frequently be another 
> source of contention?

My thought was that each CPU was already reading jiffies several times
each tick anyway, so that it would already be cached when RCU wanted
to look at it.  But I must defer to your experience with this particular
machine.

						Thanx, Paul
