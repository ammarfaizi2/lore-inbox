Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267803AbTBJMBg>; Mon, 10 Feb 2003 07:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBJMBf>; Mon, 10 Feb 2003 07:01:35 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:28167 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267803AbTBJMBc>;
	Mon, 10 Feb 2003 07:01:32 -0500
Message-ID: <3E4796D5.7070009@cyberone.com.au>
Date: Mon, 10 Feb 2003 23:11:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <3E4790F7.2010208@cyberone.com.au> <20030210120006.GC31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 10:45:59PM +1100, Nick Piggin wrote:
>
>>perspective it does nullify the need for readahead (though
>>it is obivously still needed for other reasons).
>>
>
>I'm guessing that physically it may be needed from a head prospective
>too, I doubt it only has to do with the in-core overhead.  Seeing it all
>before reaching the seek point might allow the disk to do smarter things
>and to keep the head at the right place for longer, dunno.  Anyways,
>whatever is the reason it doesn't make much difference from our point of
>view ;), but I don't expect this hardware behaviour changing in future
>high end storage.
>
I don't understand it at all. I mean there is no other IO going
on so there would be no reason for the disk head to move anyway.
Rotational latency should be basically non-existant due to track
buffers, and being FC RAID hardware you wouldn't expect them to
skimp on anything.

>
>
>NOTE: just to be sure, I'm not at all against anticpiatory scheduling,
>it's clearly a very good feature to have (still I would like an option
>to disable it especially in heavy async environments like databases,
>where lots of writes are sync too) but it should be probably be enabled
>by default, especially for the metadata reads that have to be
>synchronous by design.
>
Yes it definately has to be selectable (in fact, in my current
version, setting antic_expire = 0 disables it), and Andrew has
been working on tuning the non anticipatory version into shape.

>
>
>Infact I wonder that it may be interesting to also make it optionally
>controlled from a fs hint (of course we don't pretend all fs to provide
>the hint), so that you stall I/O writes only when you know for sure
>you're going to submit another read in a few usec, just the time to
>parse the last metadata you read. Still a timeout would be needed for
>scheduling against RT etc..., but it could be a much more relaxed
>timeout with this option enabled, so it would need less accurate
>timings, and it would be less dependent on hardware, and it would
>be less prone to generate false positive stalls. The downside is having
>to add the hints.
>
It would be easy to anticipate or not based on hints. We could
anticipate sync writes if we wanted, lower expire time for sync
writes, increase it for async reads. It is really not very
complex (although the code needs tidying up).


