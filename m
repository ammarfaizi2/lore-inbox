Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269999AbRHEUI6>; Sun, 5 Aug 2001 16:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHEUIs>; Sun, 5 Aug 2001 16:08:48 -0400
Received: from [63.209.4.196] ([63.209.4.196]:53514 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270002AbRHEUI3>; Sun, 5 Aug 2001 16:08:29 -0400
Date: Sun, 5 Aug 2001 13:04:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Black <mblack@csihq.com>
cc: Ben LaHaise <bcrl@redhat.com>, Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <01df01c11dc2$b2ee30e0$b6562341@cfl.rr.com>
Message-ID: <Pine.LNX.4.33.0108051249570.7988-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Aug 2001, Mike Black wrote:
>
> I bumped up the queue_nr_requests to 512, then 1024 -- 1024 finally made a
> performance difference for me and the machine was still usable.

This is truly strange.

The reason it is _so_ strange is that with a single thread doing read IO,
the IO should actually be limited by the read-ahead size, which is _much_
smaller than 1024 entries. Right now the max read-ahead for a regular
filesystem is 127 pages - which, even assuming the absolute worst case
(1kB filesystem, totally non-contiguous etc) is no more than 500
reqesusts.

And quite frankly, if your disk can push 50MB/s through a 1kB
non-contiguous filesystem, then my name is Bugs Bunny.

You're more likely to have a nice contiguous file, probably on a 4kB
filesystem, and it should be able to do read-ahead of 127 pages in just a
few requests.

The fact that it makes a difference for you at the 1024 mark (which means
512 entries for the read queue) is rather strange.

> As an ext3 mount (here's where I've been seeing BIG delays before) there
> were:
> 1 thread - no delays
> 2 threads - 2 delays for 2 seconds each  << previously even 2 threads caused
> minute+ delays.
> 4 threads - 5 delays - 1 for 3 seconds, 4 for 2 seconds
> 8 threads - 21 delays  - 9 for 2 sec, 4 for 3 sec,  4 for 4 sec, 2 for 5
> sec, 1 for 6 sec, and 1 for 10 sec

Now, this is the good news. It tells me that the old ll_rw_blk() code
really was totally buggered, and that getting rid of it was 100% the right
thing to do.

But I'd _really_ like to understand why you see differences in read
performance, though. That really makes no sense, considering that you
should never even get close to the request limits anyway.

What driver do you use (maybe it has merging problems - some drivers want
to merge only blocks that are also physically adjacent in memory), and can
you please verify that you have a 4kB filesystem, not a old 1kB
filesystem..

Oh, and can you play around with the "MAX_READAHEAD" define, too? It is,
in fact, not unlikely that performance will _improve_ by making the
read-ahead lower, if the read-ahead is so large as to cause request
stalling.

(It would be good to have a nice interface for true "if you don't have
enough requests, stop read-ahead" interface, I'll take a look at
possibly reviving the READA code).

		Linus

