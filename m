Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTBYG2a>; Tue, 25 Feb 2003 01:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTBYG2a>; Tue, 25 Feb 2003 01:28:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:641 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267708AbTBYG21>;
	Tue, 25 Feb 2003 01:28:27 -0500
Date: Mon, 24 Feb 2003 22:38:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-Id: <20030224223858.52c61880.akpm@digeo.com>
In-Reply-To: <20030225053547.GA1571@rushmore>
References: <20030225053547.GA1571@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 06:38:35.0872 (UTC) FILETIME=[85DBF600:01C2DC98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> Executive question: Why does 2.5.62-mm2 have higher sequential
> write latency than 2.5.61-mm1?

Well bear in mind that we sometimes need to perform reads to be able to
perform writes.  So the way tiobench measures it, you could be seeing
read-vs-write latencies here.

And there are various odd interactions in, at least, ext3.  You did not
specify which filesystem was used.

>  ...
>                     Thr  MB/sec   CPU%     avg lat      max latency
> 2.5.62-mm2-as         8   14.76   52.04%     6.14        4.5
> 2.5.62-mm2-dline      8    9.91   13.90%     9.41         .8
> 2.5.62-mm2            8    9.83   15.62%     7.38      408.9

Fishiness.  2.5.62-mm2 _is_ 2.5.62-mm2-as.  Why the 100x difference?

That 408 seconds looks suspect.


I don't know what tiobench is doing in there, really.  I find it more useful
to test simple things, which I can understand.  If you want to test write
latency, do this:

	while true
	do
		write-and-fsync -m 200 -O -f foo
	done

Maybe run a few of these.  This command will cause a continuous streaming
file overwrite.


then do:

	time write-and-fsync -m1 -f foo

this will simply write a megabyte file, fsync it and exit.

You need to be careful with this - get it wrong and most of the runtime is
actually paging the executables back in.  That is why the above background
load is just reusing the same pagecache over and over.

The latency which I see for the one megabyte write and fsync varies a lot. 
>From one second to ten.  That's with the deadline scheduler.

There is a place in VFS where one writing task could accidentally hammer a
different one.  I cannot trigger that, but I'll fix it up in next -mm.


