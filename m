Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbTBJL3y>; Mon, 10 Feb 2003 06:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTBJL3y>; Mon, 10 Feb 2003 06:29:54 -0500
Received: from [195.223.140.107] ([195.223.140.107]:8578 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266749AbTBJL3x>;
	Mon, 10 Feb 2003 06:29:53 -0500
Date: Mon, 10 Feb 2003 12:39:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210113923.GY31401@dualathlon.random>
References: <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E478C09.6060508@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 10:24:57PM +1100, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Mon, Feb 10, 2003 at 09:40:34PM +1100, Nick Piggin wrote:
> >
> >>I don't know too much about SCSI stuff, but if driver / wire / device
> >>overheads were that much higher at 128K compared to 512K I would
> >>think something is broken or maybe optimised badly.
> >>
> >
> >I guess it's also a matter of the way the harddisk can serve the I/O if
> >it sees it all at the same time, not only the cpu/bus protocol after all
> >minor overhead.  Most certainly it's not a software mistake in linux
> >that the big commands runs that much faster. Again go check the numbers
> >in bigbox.html between my tree, 2.4 and 2.5 in bonnie read sequential,
> >to see the difference between 128k commands and 512k commands with
> >reads, these are facts.  (and no writes and no seeks here)
> >
> Yes it is very clear from the numbers that your tree is more than
> 150% the speed for reads. As I said I don't know too much about

correct, that's the huge improvement I get in the read sequential case
(i.e. bonnie), which is a crucial common workload.

> SCSI, but it is very interesting that writes don't get a noticable
> improvement although they would be using the bigger request sizes
> too, right? Something is causing this but the cpu, bus, wire

It's the readahead in my tree that allows the reads to use the max scsi
command size. It has nothing to do with the max scsi command size
itself.

writes don't need readahead to use the max command size, they always
used it since the first place, so they can't go even faster, they never
had a problem.

It's by fixing readahead that reads gets boosted. this has nothing to do
with writes or the max_sectors itself.

You can wait 10 minutes and still such command can't grow.  This is why
claiming anticipatory scheduling can decrease the need for readahead
doesn't make much sense to me, there are important things you just can't
achieve by only waiting.

> overhead of using small requests does not seem to be it.
> 
> Nick
> 


Andrea
