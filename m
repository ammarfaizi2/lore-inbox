Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTBJLMc>; Mon, 10 Feb 2003 06:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTBJLMc>; Mon, 10 Feb 2003 06:12:32 -0500
Received: from [195.223.140.107] ([195.223.140.107]:3458 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267675AbTBJLMa>;
	Mon, 10 Feb 2003 06:12:30 -0500
Date: Mon, 10 Feb 2003 12:21:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Hans Reiser <reiser@namesys.com>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210112104.GW31401@dualathlon.random>
References: <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210024810.43a57910.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210024810.43a57910.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 02:48:10AM -0800, Andrew Morton wrote:
> Hans Reiser <reiser@namesys.com> wrote:
> >
> > readahead seems to be less effective for non-sequential objects.  Or at 
> > least, you don't get the order of magnitude benefit from doing only one 
> > seek, you only get the better elevator scheduling from having more 
> > things in the elevator, which isn't such a big gain.
> > 
> > For the spectators of the thread, one of the things most of us learn 
> > from experience about readahead is that there has to be something else 
> > trying to interject seeks into your workload for readahead to make a big 
> > difference, otherwise a modern disk drive (meaning, not 30 or so years 
> > old) is going to optimize it for you anyway using its track cache.
> > 
> 
> The biggest place where readahead helps is when there are several files being
> read at the same time.  Without readahead the disk will seek from one file
> to the next after having performed a 4k I/O.  With readahead, after performing
> a (say) 128k I/O.  It really can make a 32x difference.

definitely, but again the most important by far is to submit big
commands, if you get the 512k commands interleaved by different task
it isn't a panic situation.

> Readahead is brute force.  The anticipatory scheduler solves this in a
> smarter way.

If you decrease readahead with anticipatory scheduler you will submit
the small commands, if you decrease the readahead you can stall 10
minutes any write in the queue, and still you won't grow the command in
the head of the queue.

> vmm:/mnt/hda6> for i in $(seq 1 8)
> for> do
> for> dd if=/dev/zero of=file$i bs=1M count=10 
> for> sync
> for> fadvise file$i 0 999999999 dontneed

what is this fadvise doing?

> for> done
> 
> vmm:/home/akpm> 0 blockdev --setra 240 /dev/hda1

> for i in $(seq 1 8)
> do
> time cat file$i >/dev/null&          
> done
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 4.422 total
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 5.801 total
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.012 total
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.261 total
> cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 6.401 total
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.494 total
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.754 total
> cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.757 total
> 
> vmm:/mnt/hda6> for i in $(seq 1 8)
> do
> fadvise file$i 0 999999999 dontneed
> done
> vmm:/home/akpm> 0 blockdev --setra 4 /dev/hda1
> vmm:/mnt/hda6> for i in $(seq 1 8)
> do
> time cat file$i >/dev/null&          
> done
> cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 13.373 total
> cat file$i > /dev/null  0.00s user 0.04s system 0% cpu 14.849 total
> cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 15.816 total
> cat file$i > /dev/null  0.00s user 0.04s system 0% cpu 16.808 total
> cat file$i > /dev/null  0.00s user 0.05s system 0% cpu 17.824 total
> cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 19.004 total
> cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 19.274 total
> cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 19.301 total
> 
> So with eight files, it's a 300% drop from not using readahead.

yes, and anticipatory scheduler isn't going to fix it. furthmore with
IDE the max merging is 64k so you can see little of the whole picture.

Andrea
