Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTAYRix>; Sat, 25 Jan 2003 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbTAYRiw>; Sat, 25 Jan 2003 12:38:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55114 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261624AbTAYRiv>; Sat, 25 Jan 2003 12:38:51 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: Jason Papadopoulos <jasonp@boo.net>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: your mail
References: <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com>
	<40475.210.212.228.78.1043384883.webmail@mail.nitc.ac.in>
	<Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com>
	<3.0.6.32.20030124212935.007fcc10@boo.net>
	<20030125022648.GA13989@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2003 10:47:19 -0700
In-Reply-To: <20030125022648.GA13989@work.bitmover.com>
Message-ID: <m17kctceag.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> > For the record, I finally got to try my own page coloring patch on a 1GHz
> > Athlon Thunderbird system with 256kB L2 cache. With the present patch, my
> > own number crunching benchmarks and a kernel compile don't show any benefit 
> > at all, and lmbench is completely unchanged except for the mmap latency, 
> > which is slightly worse. Hardly a compelling case for PCs!
> 
> If it works correctly then the variability in lat_ctx should go away.
> Try this
> 
> 	for p in 2 4 8 12 16 24 32 64
> 	do	for size in 0 2 4 8 16
> 		do	for i in 1 2 3 4 5 6 7 8 9 0
> 			do	lat_ctx -s$size $p
> 			done
> 		done
> 	done
> 
> on both the with and without kernel.  The page coloring should make the 
> numbers rock steady, without it, they will bounce a lot.

On the same kind of vein I have seen some tremendous variability in the
stream benchmark.  Under linux I have gotten it to very as much
as a 100MB/sec by running updatedb, between runs.  In one case
it ran faster with updatedb running in the background.

But at the same time streams tends to be very steady if you have a quiet
machine and run it several times in a row repeatedly because it gets
allocated essentially the same memory every run.

So I do no the variables of cache contention do have effect on some
real programs.  I have not yet tracked it down to see if cache coloring
could be a benefit.  I suspect the buddy allocator actually comes
quite close most of the time, and tricks like allocating multiple pages
at once could improve that even more with very little effort, while reducing
page fault miss times.

I am wondering if there is any point in biasing page addresses in between
processes so that processes are less likely to have a cache conflict.
i.e.  process 1 address 0 %16K == 0, process 2 address 0 %16K == 4K 

Eric
