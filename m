Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbTBJNJt>; Mon, 10 Feb 2003 08:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbTBJNJt>; Mon, 10 Feb 2003 08:09:49 -0500
Received: from [195.223.140.107] ([195.223.140.107]:49538 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267843AbTBJNJs>;
	Mon, 10 Feb 2003 08:09:48 -0500
Date: Mon, 10 Feb 2003 14:18:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210131858.GP31401@dualathlon.random>
References: <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <20030210120916.GD31401@dualathlon.random> <3E47A1E5.6020902@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E47A1E5.6020902@namesys.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:58:13PM +0300, Hans Reiser wrote:
> Is the following a fair summary?
> 
> There is a certain minimum size required for the IOs to be cost 
> effective.  This can be determined by single reader benchmarking.  Only 
> readahead and not anticipatory scheduling addresses that.
> 
> Anticipatory scheduling does not address the application that spends one 
> minute processing every read that it makes.  Readahead does.
> 
> Anticipatory scheduling does address the application that reads multiple 
> files that are near each other (because they are in the same directory), 
> and current readahead implementations (excepting reiser4 in progress 
> vaporware) do not.
> 
> Anticipatory scheduling can do a better job of avoiding unnecessary 
> reads for workloads with small time gaps between reads than readahead 
> (it is potentially more accurate for some workloads).
> 
> Is this a fair summary?

I would also add what I feel the most important thing, that is
anticipatory scheduling can help decreasing a lot the latencies of
filesystem reads in presence of lots of misc I/O, by knowing which are
the read commands that are intermediate-dependent-sync, that means
knowing a new dependent read will be submitted very quickly as soon as
the current read-I/O is completed. In such a case it makes lots sense to
wait for the next read to be submitted instead of start processing
immediatly the rest of the I/O queue.  This way when you read a file and
you've to walk the indirect blocks before being able to read the data,
you won't be greatly peanalized against the writes or reads that won't
need to pass through metadata I/O before being served.

This doesn't obviate the need of SFQ for the patological multimedia
cases where I/O latency is the first prio, or for workloads where
sync-write latency is the first prio.

BTW, I'm also thinking that the SFQ could be selected not system wide,
but per-process basis, with a prctl or something, so you could have all
the I/O going into the single default async-io queue, except for mplayer
that will use the SFQ queues. This may not even need to be privilegied
since SFQ is fair and if an user can write a lot it can just hurt
latency, with SFQ could hurt more but still not deadlock. This SFQ prctl
for the I/O scheduler, would be very similar to the RT policy for the
main process scheduler. Infact it maybe the best to just have SFQ always
enabled, and selectable only via the SFQ prctl, and to enable the
functionaltiy only per-process basis rather than global. We can still
add a sysctl to enable it globally despite nobody set the per-process
flag.

Andrea
