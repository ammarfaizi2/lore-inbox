Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280403AbRJaSlC>; Wed, 31 Oct 2001 13:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280405AbRJaSk6>; Wed, 31 Oct 2001 13:40:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12560 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280403AbRJaSkk>; Wed, 31 Oct 2001 13:40:40 -0500
Message-ID: <3BE044A8.E91A4F01@zip.com.au>
Date: Wed, 31 Oct 2001 10:36:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BDFBFF5.9F54B938@zip.com.au>,
> Andrew Morton  <akpm@zip.com.au> wrote:
> >
> >Appended here is a program which creates 100,000 small files.
> >Using ext2 on -pre5.  We see how long it takes to run
> >
> >       (make-many-files ; sync)
> >
> >For several values of queue_nr_requests:
> >
> >queue_nr_requests:     128     8192    32768
> >execution time:                4:43    3:25    3:20
> >
> >Almost all of the execution time is in the `sync'.
> 
> Hmm..  I don't consider "sync" to be a benchmark, and one of the things
> that made me limit the queue size was in fact that Linux in the
> timeframe before roughly 2.4.7 or so was _completely_ unresponsive when
> you did a big "untar" followed by a "sync".

Sure.  I chose `sync' because it's measurable.  That sync took
four minutes, so the machine will be locked up seeking for four
minutes whether the writeback was initiated by /bin/sync or by
kupdate/bdflush.

> I'd rather have a machine where I don't even much notice the sync than
> one where a made-up-load and a "sync" that servers no purpose shows
> lower throughput.
> 
> Do you actually have any real load that cares?

All I do is compile kernels :)

Actually, ext3 journal replay can sometimes take thirty seconds
or longer - it reads maybe ten megs from the journal and then
it has to splatter it all over the platter and wait on it.

> ...
> We have actually talked about some higher-level ordering of the dirty list
> for at least five years, but nobody has ever done it. And I bet you $5
> that you'll get (a) better throughput than by making the queues longer and
> (b) you'll have fine latency while you write and (c) that you want to
> order the write-queue anyway for filesystems that care about ordering.

I'll buy that.  It's not just the dirty list, either.  I've seen 
various incarnations of page_launder() and its successor which
were pretty suboptimal from a write clustering pov.

But it's actually quite seductive to take a huge amount of data and
just chuck it at the request layer and let Jens sort it out. This
usually works well and keeps the complexity in one place.

One does wonder whether everything is working as it should, though.
Creating those 100,000 4k files is going to require writeout of
how many blocks?  120,000?  And four minutes is enough time for
34,000 seven-millisecond seeks.  And ext2 is pretty good at laying
things out contiguously.  These numbers don't gel.

Ah-ha.  Look at the sync_inodes stuff:

	for (zillions of files) {
		filemap_fdatasync(file)
		filemap_fdatawait(file)
	}

If we turn this into

	for (zillions of files)
		filemap_fdatasync(file)
	for (zillions of files)
		filemap_fdatawait(file)

I suspect that interesting effects will be observed, yes?  Especially
if we have a nice long request queue, and the results of the
preceding sync_buffers() are still available for being merged with.

kupdate runs this code path as well. Why is there any need for
kupdate to wait on the writes?

Anyway.  I'll take a look....


-
