Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTBJLa0>; Mon, 10 Feb 2003 06:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTBJLa0>; Mon, 10 Feb 2003 06:30:26 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:15111 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S266978AbTBJLaW>;
	Mon, 10 Feb 2003 06:30:22 -0500
Message-ID: <3E478F8B.1050103@cyberone.com.au>
Date: Mon, 10 Feb 2003 22:39:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@digeo.com>, Hans Reiser <reiser@namesys.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210024810.43a57910.akpm@digeo.com> <20030210112104.GW31401@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 02:48:10AM -0800, Andrew Morton wrote:
>
>>Hans Reiser <reiser@namesys.com> wrote:
>>
>>>readahead seems to be less effective for non-sequential objects.  Or at 
>>>least, you don't get the order of magnitude benefit from doing only one 
>>>seek, you only get the better elevator scheduling from having more 
>>>things in the elevator, which isn't such a big gain.
>>>
>>>For the spectators of the thread, one of the things most of us learn 
>>>from experience about readahead is that there has to be something else 
>>>trying to interject seeks into your workload for readahead to make a big 
>>>difference, otherwise a modern disk drive (meaning, not 30 or so years 
>>>old) is going to optimize it for you anyway using its track cache.
>>>
>>>
>>The biggest place where readahead helps is when there are several files being
>>read at the same time.  Without readahead the disk will seek from one file
>>to the next after having performed a 4k I/O.  With readahead, after performing
>>a (say) 128k I/O.  It really can make a 32x difference.
>>
>
>definitely, but again the most important by far is to submit big
>commands, if you get the 512k commands interleaved by different task
>it isn't a panic situation.
>
Well the most important by far is to minimise seeks - you may
be able to achieve that by submitting big commands, but you can
also do it by accounting by time (not number of requests) and
anticipating reads. I'm not saying your way doesn't work.

>
>
>>Readahead is brute force.  The anticipatory scheduler solves this in a
>>smarter way.
>>
>
>If you decrease readahead with anticipatory scheduler you will submit
>the small commands, if you decrease the readahead you can stall 10
>minutes any write in the queue, and still you won't grow the command in
>the head of the queue.
>
Not sure exactly what you mean here, however no big starvation
occurs with the scheduler you will find in 2.5.59-mm10 +
experimental.

A streaming reader and streaming writer total 14MB/s in agregate
throughput, with 2.23 bytes read per write with default settings.

This goes to 11.4MB/s and a ratio of 1.6 with 0 readahead.

When I turn off anticipatory scheduling however, I get a good
17MB/s throughput with a ratio of 0.00 reads per write (actually
some small positive epsilon less than  one over one hundred).

[snipped]

>>
>>So with eight files, it's a 300% drop from not using readahead.
>>
>
>yes, and anticipatory scheduler isn't going to fix it. furthmore with
>
I am guessing it will do a pretty good job.

>
>IDE the max merging is 64k so you can see little of the whole picture.
>
The disk can't but the io scheduler obviously can. We can give
the disk a lot of help.

>
>
>Andrea
>
>
>  
>

