Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSLCGOo>; Tue, 3 Dec 2002 01:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSLCGOo>; Tue, 3 Dec 2002 01:14:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36870 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265355AbSLCGOn>;
	Tue, 3 Dec 2002 01:14:43 -0500
Date: Tue, 3 Dec 2002 07:21:49 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Willy Tarreau <willy@w.ods.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
Message-ID: <20021203062149.GA10479@alpha.home.local>
References: <20021202204509.GA21070@alpha.home.local> <Pine.LNX.4.44L.0212022107421.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0212022107421.15981-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 09:10:03PM -0200, Rik van Riel wrote:
> On Mon, 2 Dec 2002, Willy Tarreau wrote:
> 
> >   - not one, but two elevators, one for read requests, one for write requests.
> >   - we would process one of the request queues (either reads or writes), and
> >     after a user-settable amount of requests processed, we would switch to the
> 
> OK, lets for the sake of the argument imagine such an
> elevator, with Read and Write queues for the following
> block numbers:
> 
> R:  1 3 4 5 6 20 21 22 100 110 111
> 
> W:  2 15 16 17 18 50 52 53
> 
> Now imagine what switching randomly between these queues
> would do for disk seeks. Especially considering that some
> of the writes can be "sandwiched" in-between the reads...

Well, I don't speak about "random switching". My goal is exactly to reduce seek
time *and* to bound latency. Look at your example, considering that we put no
limit on the number of consecutive requests, just processing them in order would
give :

R(1), W(2), R(3,4,5,6), W(15,16,17,18), R(20,21,22), W(50,52,53), R(100,110,111)

This is about what is currently done with a single elevator. Now, if we try to
detect long runs of consecutive accesses based on seek length, we could
optimize it this way :

W(2), R(1-22), W(15-53), R(100-111)   => we only do one backwards seek

And now, if you want to lower latency for a particular usage, with a 3:1
read/write ratio, this would give :

R(1,3,4), W(2), R(5,6,20), W(15), R(21,22,100), W(16), R(110,111), W(17-53)

Of course, this won't be globally optimal, but could perhaps help *some*
processes to wait less time for their data, which is the goal of inserting read
requests near the head of the queue, isn't it ?

BTW, just for my understanding, what would your example look like with the
current elevator (choose the ordering you like) ?

Cheers,
Willy

