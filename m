Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRHYSC4>; Sat, 25 Aug 2001 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRHYSCq>; Sat, 25 Aug 2001 14:02:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:53265 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270050AbRHYSCg>; Sat, 25 Aug 2001 14:02:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Galbraith <mikeg@wen-online.de>,
        Roger Larsson <roger.larsson@norran.net>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
Date: Sat, 25 Aug 2001 20:09:24 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0108250946560.540-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0108250946560.540-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825180244Z16204-32383+1340@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 10:48 am, Mike Galbraith wrote:
> I think the easiest way to handle high order allocations is to do _low_
> volume background reclamation if high order allocations might fail.  ie
> put a little effort into keeping such allocations available, but don't
> do massive effort.  Cache tends to lose it's value over time, so dumping
> small quantities over time shouldn't hurt.

Ah, time.  Please see below for an alternative way of looking at time.

> This would also have the
> benefit of scanning the inactive lists even when there's little activity
> so that list information (page accessed _yesterday_?) won't get stale.

It would probably improve the average performance somewhat.  I'm looking at a 
more direct approach: if we have a shortage at order(m) then, then for each 
(free) member of order(m-1) look in mem_map for its buddy, and if it doesn't 
look too active, try to free it, thus moving the allocation unit up one 
order.  Could you examine this idea please and check for obvious holes?

> I think it's ~fine to reclaim for up to say order 2, but beyond that, it
> doesn't have any up side that I can see.. only down.

Yep.

> btw, I wonder why we don't do memory_pressure [+-]= 1 << order.

We should, at least the "memory_pressure += 1 << order" flavor.  Patch?

IMO the concept of memory pressure is bogus.  Instead we should calculate the 
number of pages to scan directly from the number of pages consumed by 
alloc_pages and the probability that deactivated pages will be rescued.  The 
latter statistic we can measure.  We can control it, too, by controlling the 
length of the inactive queue.  The shorter the inactive queue, the lower the 
probability a deactivated page will be rescued.

The idea of clocking recalculate_vm_stats by real time is also bogus.  MM 
activity does not have a linear relationship to real time under most loads 
(exceptions: those loads clocked by a realtime constraint, such as network 
bandwidth on a saturated network).  We should be clocking the mm using a time 
quantum of "one page alloced".  A scan of the literature shows considerable 
support for this view, and it's also intuitive, don't you think?

What this means in practice is, sure we can have kswapd wake once a second or 
once per 100 ms, but the amount of scanning it does needs to be based on the 
number of pages actually alloced in that interval.  (Intuitively, this 
corresponds to the number of free pages needed to replace those alloced.)  
>From the mm's perspective, kswapd's constant realtime interval is a variable 
delta-t in terms of mm time, meaning that we need to scale all proportional 
mm activity by the measured delta.  Hmm, clear as mud?  This is a standard 
idea from control theory.

BTW, what the heck is this supposed to do (page_alloc.c):

144         if (memory_pressure > NR_CPUS)
145                 memory_pressure--;

--
Daniel
