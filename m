Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTBJL7r>; Mon, 10 Feb 2003 06:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBJL7r>; Mon, 10 Feb 2003 06:59:47 -0500
Received: from [195.223.140.107] ([195.223.140.107]:17794 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267717AbTBJL7p>;
	Mon, 10 Feb 2003 06:59:45 -0500
Date: Mon, 10 Feb 2003 13:09:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: piggin@cyberone.com.au, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210120916.GD31401@dualathlon.random>
References: <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210034808.7441d611.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:48:08AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > It's the readahead in my tree that allows the reads to use the max scsi
> > command size. It has nothing to do with the max scsi command size
> > itself.
> 
> Oh bah.
> 
> -               *max_ra++ = vm_max_readahead;
> +               *max_ra = ((128*4) >> (PAGE_SHIFT - 10)) - 1;
> 
> 
> Well of course that will get bigger bonnie numbers, for exactly the reasons
> I've explained.  It will seek between files after every 512k rather than
> after every 128k.

NOTE: first there is no seek at all in the benchmark we're talking
about, no idea why you think there are seeks. This is not tiobench, this
is bonnie sequential read.

Second I increased it to 4 times 128k very recently, it was used to be
exactly 128k and 512k for scsi. Infact the difference happens in SCSI
not IDE, where going past 128k is helpful, on ide as said the limit of
the command is limited by the hardware anyways.

the only thing you can argue is that the qla is capable of max 256k per
command, and I'm doing readahead of 512k at once, but I don't think it
can matter, like it doesn't matter now that I increased it even more,
all it matters is not to stop at 128k, and to submit the 256k commands.

> 
> > You can wait 10 minutes and still such command can't grow.  This is why
> > claiming anticipatory scheduling can decrease the need for readahead
> > doesn't make much sense to me, there are important things you just can't
> > achieve by only waiting.
> > 
> 
> The anticipatory scheduler can easily permit 512k of reading before seeking
> away to another file.  In fact it can allow much more, without requiring that
> readhead be cranked up.

This has nothing to do with "the other file". There is a single task in
the system, it is in replacement of /sbin/init, it never forks and it
never opens more than 1 single file called /myfile. Nothing else nothing
more.

anticipatory scheduling can't help in any way that benchmark, period. If
you destroy readahead you won't be able to build the scsi command of the
optimal size and this will hurt. Waiting can't help this.

Andrea
