Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbTGOIOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbTGOIOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:14:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1736 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266880AbTGOIOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:14:06 -0400
Date: Tue, 15 Jul 2003 10:28:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715082850.GH833@suse.de>
References: <20030714202434.GS16313@dualathlon.random> <1058214881.13313.291.camel@tiny.suse.com> <20030714224528.GU16313@dualathlon.random> <1058229360.13317.364.camel@tiny.suse.com> <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de> <20030715070314.GD30537@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715070314.GD30537@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15 2003, Andrea Arcangeli wrote:
> On Tue, Jul 15, 2003 at 08:08:57AM +0200, Jens Axboe wrote:
> > I don't see the 31% slowdown. We complete less tar loads, but only
> > because there's less time to complete them in. Well almost, as you list
> 
> I see, so I agree the writer wrote at almost the same speed.

Good

> > I see tar making progress, how could it be stopped?
> 
> I didn't know the load was stopped after 249 seconds, I could imagine it,
> sorry. I was probably obfuscated by the two severe problems the code had
> that could lead to what I was expecting with more readers running
> simultanously.
> 
> So those numbers sounds perfectly reproducible with a fixed patch too.

Yes

> At the light of this latest info you convinced me you were right, I
> probably understimated the value of the separated queues when I dropped
> it to simplify the code.

Ok, so we are on the same wave length know :)

> I guess waiting the batch_sectors before getting a request for a read
> was allowing another writer to get it first because the other writer was
> already queued in the FIFO waitqueue when the writer got in. that might
> explain the difference, the reserved requests avoid the reader to wait
> for batch_sectors twice (that translates in 1/4 of the queue less to
> wait at every I/O plus the obvious minor saving in less schedules and
> waitqueue registration).

That is one out come, yes.

> It'll be great to give another boost to the elevator-lowlatency thanks
> to this feature.

Definitely, because prepare to be a bit disappointed. Here are scores
that include 2.4.21 as well:

no_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.21                 3        133     197.0   0.0     0.0     1.00
2.4.22-pre5            2        134     196.3   0.0     0.0     1.00
2.4.22-pre5-axboe      3        133     196.2   0.0     0.0     1.00
ctar_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.21                 3        190     140.5   15.0    15.8    1.43
2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46

2.4.22-pre5-axboe is way better than 2.4.21, look at the loads
completed.

xtar_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.21                 3        287     93.0    14.0    15.3    2.16
2.4.22-pre5            3        309     86.4    15.0    14.9    2.31
2.4.22-pre5-axboe      3        249     107.2   11.3    14.1    1.87

2.4.21 beats 2.4.22-pre5, not too surprising and expected, and not
terribly interesting either.

io_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.21                 3        543     49.7    100.4   19.0    4.08
2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06

2.4.22-pre5-axboe completes the most loads here per time unit.

io_other:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.21                 3        581     46.5    111.3   19.1    4.37
2.4.22-pre5            3        576     47.2    107.7   19.8    4.30
2.4.22-pre5-axboe      3        452     59.7    85.3    19.5    3.40

2.4.22-pre5 is again the slowest of the lot when it comes to
workloads/time, 2.4.22-pre5 is again the fastest and completes the work
load in the shortest time.

read_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.21                 3        151     180.1   8.3     9.3     1.14
2.4.22-pre5            3        150     181.3   8.1     9.3     1.12
2.4.22-pre5-axboe      3        152     178.9   8.2     9.9     1.14

Pretty equal.

I'm running a fixed variant 2.4.22-pre5 now, will post results when they
are done (in a few hours).

-- 
Jens Axboe

