Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTBJIyG>; Mon, 10 Feb 2003 03:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTBJIyF>; Mon, 10 Feb 2003 03:54:05 -0500
Received: from [195.223.140.107] ([195.223.140.107]:56961 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264749AbTBJIyE>;
	Mon, 10 Feb 2003 03:54:04 -0500
Date: Mon, 10 Feb 2003 10:02:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jakob Oestergaard <jakob@unthought.net>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210090248.GP31401@dualathlon.random>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <3E476287.8070407@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E476287.8070407@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 07:27:51PM +1100, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >On Mon, Feb 10, 2003 at 06:41:14PM +1100, Nick Piggin wrote:
> >
> >>Andrea Arcangeli wrote:
> >>
> >>
> >>>On Mon, Feb 10, 2003 at 03:58:26PM +1100, Nick Piggin wrote:
> >>>
> >>>>Remember that readahead gets scaled down quickly if it isn't
> >>>>getting hits. It is also likely to be sequential and in the
> >>>>track buffer, so it is a small cost.
> >>>>
> >>>>Huge readahead is a problem however anticipatory scheduling
> >>>>will hopefully allow good throughput for multiple read streams
> >>>>without requiring much readahead.
> >>>>
> What I mean by this is: if we have >1 sequential readers (eg. ftp
> server), lets say 30MB/s disk, 4ms avg seek+settle+blah time,
> submitting reads in say 128KB chunks alternating between streams
> will cut throughput in half... At 1MB readahead we're at 89%
> throughput. At 2MB, 94%
> 
> With anticipatory scheduling, we can give each stream say 100ms
> so thats 96% with, say... 8K readahead if you like. (Yes, I am
> aware that CPU/PCI/IDE efficiency also mandates a larger request
> size).

the way things works, if you give 8k readahead, you'll end submitting 8k
requests no matter how long you wait and it will kill throughput to 10%
of what was possible to achieve, very especially with scsi, max
coalescing of ide is 64k and btw that is its main weakness IMHO.

It doesn't make any sense to me your claim that you can decrease the
readahead by adding anticipatory scheduling, if you do you'll run
so slow at 8k per request in all common workloads.

> 
> Anyway that is the theory. It remains to be seen if we can make
> it work.
> 
> >>>>
> >>>>
> >>>the main purpose of readahead is to generate 512k scsi commands when you
> >>>read a file with a 4k user buffer, anticipatory scheduling isn't very
> >>>related to readahead.
> >>>
> >>>
> >>You seem to be forgetting things like seek time.
> >>
> >
> >I didn't say it's the only purpose. Of course there's no hope for
> >merging in the metadata dependent reads of the fs where anticipatory
> >scheduling does its best, and infact they don't even attempt to do any
> >readhaead.  BTW, one thing that should definitely do readhaead and it's
> >not doing that (at least in 2.4) is the readdir path, again to generate
> >big commands, no matter the seeks.  It was lost with the directory in
> >pagecache.
> >
> >Andrea
> >
> >
> > 
> >
> 


Andrea
