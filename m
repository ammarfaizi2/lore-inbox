Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbTBJMNs>; Mon, 10 Feb 2003 07:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267804AbTBJMNs>; Mon, 10 Feb 2003 07:13:48 -0500
Received: from [195.223.140.107] ([195.223.140.107]:23426 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267795AbTBJMNq>;
	Mon, 10 Feb 2003 07:13:46 -0500
Date: Mon, 10 Feb 2003 13:22:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210122248.GG31401@dualathlon.random>
References: <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <3E4790F7.2010208@cyberone.com.au> <20030210120006.GC31401@dualathlon.random> <3E4796D5.7070009@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4796D5.7070009@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:11:01PM +1100, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Mon, Feb 10, 2003 at 10:45:59PM +1100, Nick Piggin wrote:
> >
> >>perspective it does nullify the need for readahead (though
> >>it is obivously still needed for other reasons).
> >>
> >
> >I'm guessing that physically it may be needed from a head prospective
> >too, I doubt it only has to do with the in-core overhead.  Seeing it all
> >before reaching the seek point might allow the disk to do smarter things
> >and to keep the head at the right place for longer, dunno.  Anyways,
> >whatever is the reason it doesn't make much difference from our point of
> >view ;), but I don't expect this hardware behaviour changing in future
> >high end storage.
> >
> I don't understand it at all. I mean there is no other IO going

Unfortunately I can't help you understand it, but this is what I found
with my pratical experience, I found it the first time in my alpha years
ago when I increased the sym to 512k in early 2.4 then since it could
break stuff we added the max_sectors again in 2.4. But of course if you
don't fix readahead there's no way reads can take advantage of these
lowlevel fixes. I thought I fixed readahead too but I felt it got backed
out and when I noticed I resurrected it in my tree (see the name of the
patch ;)

> >NOTE: just to be sure, I'm not at all against anticpiatory scheduling,
> >it's clearly a very good feature to have (still I would like an option
> >to disable it especially in heavy async environments like databases,
> >where lots of writes are sync too) but it should be probably be enabled
> >by default, especially for the metadata reads that have to be
> >synchronous by design.
> >
> Yes it definately has to be selectable (in fact, in my current
> version, setting antic_expire = 0 disables it), and Andrew has
> been working on tuning the non anticipatory version into shape.

Great.

> >Infact I wonder that it may be interesting to also make it optionally
> >controlled from a fs hint (of course we don't pretend all fs to provide
> >the hint), so that you stall I/O writes only when you know for sure
> >you're going to submit another read in a few usec, just the time to
> >parse the last metadata you read. Still a timeout would be needed for
> >scheduling against RT etc..., but it could be a much more relaxed
> >timeout with this option enabled, so it would need less accurate
> >timings, and it would be less dependent on hardware, and it would
> >be less prone to generate false positive stalls. The downside is having
> >to add the hints.
> >
> It would be easy to anticipate or not based on hints. We could

yep.

> anticipate sync writes if we wanted, lower expire time for sync
> writes, increase it for async reads. It is really not very
> complex (although the code needs tidying up).

this is not the way I thought at it. I'm interested to give an hint
only to know for sure which are the intermediate sync dependent reads
(the obvious example is when doing the get_block and walking the
3 level of inode indirect metadata blocks with big files, or while
walking the balanced tree in reiserfs), and I'm not interested at all
about writes. And I would just set an higher timeout when a read that I
know for sure (thanks to the hint) is "intermdiate" is completed. We can
use high timeouts there because we know they won't trigger 90% of the
time, a new dependent read will be always submitted first.

Andrea
