Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSLBVlD>; Mon, 2 Dec 2002 16:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSLBVlD>; Mon, 2 Dec 2002 16:41:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11524 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264756AbSLBVlB>; Mon, 2 Dec 2002 16:41:01 -0500
Date: Mon, 2 Dec 2002 16:46:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
In-Reply-To: <Pine.LNX.4.44L.0212021035130.15981-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1021202162812.1418A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Rik van Riel wrote:

> On Mon, 2 Dec 2002, Jens Axboe wrote:
> > On Mon, Dec 02 2002, Andrew Morton wrote:
> 
> > > So rather than just keeping on calling it a "hack" could you please
> > > describe what is actually wrong with the idea?
> >
> > I've never said that the idea is wrong, it's the solution that is an
> > ugly hack.
> 
> OK, do you have a better idea on how to implement this thing ?
> 
> I could be your code monkey if you don't have the time to
> implement something yourself.

Clearly the patch addresses the problem. However, I have some doubt that
it can be optimal however tuned. The more we put blocking io ahead of
non-blocking io, the greater the chance that the system will get so low on
memory that some of the non-blocking write may act like blocking write, or
the system may smoothly become dead slow.

Ignoring all the reasons why a major change shouldn't be put into a frozen
development, if there were a per-device and per-pid queue, then each time
the elevator were loaded some minimum and maximum number of requests per
pid could be queued. This would repeat until all requests were processed
or some max number of requests was handled. 

I think the effect of this would be that under light load many requests
from a single process would be taken, getting the benefit of sequential io
and good throughput. If the performance gain justified the overhead the
per-pid queue could be sorted to keep contiguous requests grouped. If
there were a lot of processes contending for the device, it would assure
some degree of fair scheduling without having to scan down or insert in
one large queue.

Just a thought, clearly this is too large a change to put in at the
moment, and may have some drawback I missed, or less benefit. It has the
advantage of not having to scan down all waiting requests for a device,
which would clearly be too much overhead. The actual decisions aren't all
that complex at any given point, hopefully CPU usage would reflext this.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

