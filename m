Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030973AbWKUNzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030973AbWKUNzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 08:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030974AbWKUNzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 08:55:08 -0500
Received: from brick.kernel.dk ([62.242.22.158]:15986 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030973AbWKUNzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 08:55:07 -0500
Date: Tue, 21 Nov 2006 14:54:54 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jim Schutt <jaschut@sandia.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice/vmsplice performance test results
Message-ID: <20061121135454.GV8055@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov> <20061116202529.GH7164@kernel.dk> <1163784110.8170.8.camel@sale659.sandia.gov> <20061120075941.GF4077@kernel.dk> <20061120082426.GG4077@kernel.dk> <1164037743.19613.5.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164037743.19613.5.camel@sale659.sandia.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2006, Jim Schutt wrote:
> On Mon, 2006-11-20 at 09:24 +0100, Jens Axboe wrote:
> > On Mon, Nov 20 2006, Jens Axboe wrote:
> > > On Fri, Nov 17 2006, Jim Schutt wrote:
> > > > On Thu, 2006-11-16 at 21:25 +0100, Jens Axboe wrote:
> > > > > On Thu, Nov 16 2006, Jim Schutt wrote:
> > > > > > Hi,
> > > > > > 
> > > > 
> > > > > > My test program can do one of the following:
> > > > > > 
> > > > > > send data:
> > > > > >  A) read() from file into buffer, write() buffer into socket
> > > > > >  B) mmap() section of file, write() that into socket, munmap()
> > > > > >  C) splice() from file to pipe, splice() from pipe to socket
> > > > > > 
> > > > > > receive data:
> > > > > >  1) read() from socket into buffer, write() buffer into file
> > > > > >  2) ftruncate() to extend file, mmap() new extent, read() 
> > > > > >       from socket into new extent, munmap()
> > > > > >  3) read() from socket into buffer, vmsplice() buffer to 
> > > > > >      pipe, splice() pipe to file (using the double-buffer trick)
> > > > > > 
> > > > > > Here's the results, using:
> > > > > >  - 64 KiB buffer, mmap extent, or splice
> > > > > >  - 1 MiB TCP window
> > > > > >  - 16 GiB data sent across network
> > > > > > 
> > > > > > A) from /dev/zero -> 1) to /dev/null : 857 MB/s (6.86 Gb/s)
> > > > > > 
> > > > > > A) from file      -> 1) to /dev/null : 472 MB/s (3.77 Gb/s)
> > > > > > B) from file      -> 1) to /dev/null : 366 MB/s (2.93 Gb/s)
> > > > > > C) from file      -> 1) to /dev/null : 854 MB/s (6.83 Gb/s)
> > > > > > 
> > > > > > A) from /dev/zero -> 1) to file      : 375 MB/s (3.00 Gb/s)
> > > > > > A) from /dev/zero -> 2) to file      : 150 MB/s (1.20 Gb/s)
> > > > > > A) from /dev/zero -> 3) to file      : 286 MB/s (2.29 Gb/s)
> > > > > > 
> > > > > > I had (naively) hoped the read/vmsplice/splice combination would 
> > > > > > run at the same speed I can write a file, i.e. at about 450 MB/s
> > > > > > on my setup.  Do any of my numbers seem bogus, so I should look 
> > > > > > harder at my test program?
> > > > > 
> > > > > Could be read-ahead playing in here, I'd have to take a closer look at
> > > > > the generated io patterns to say more about that. Any chance you can
> > > > > capture iostat or blktrace info for such a run to compare that goes to
> > > > > the disk?
> > > > 
> > > > I've attached a file with iostat and vmstat results for the case
> > > > where I read from a socket and write a file, vs. the case where I
> > > > read from a socket and use vmsplice/splice to write the file.
> > > > (Sorry it's not inline - my mailer locks up when I try to
> > > > include the file.)
> > > > 
> > > > Would you still like blktrace info for these two cases?
> > > 
> > > No, I think the iostat data is fine, I don't think the blktrace info
> > > would give me any more insight on this problem. I'll set up a test to
> > > reproduce it here, looks like the write out path could be optimized some
> > > more.
> 
> Great, let me know if you need testing from me.

I found some suboptimal behaviour in your test app - you don't check for
short reads and splice would really like things to be aligned for the
best performance. I did some testing with the original app here, and I
get 114.769MB/s for read-from-socket -> write-to-file and 109.878MB/s
for read-from-socket -> vmsplice-splice-to-file. If I fix up the read to
always get the full buffer size before doing the vmsplice+splice, the
performance is up to the same as the read/write.

Since it's doing buffered writes, the results do vary a lot though (as
you also indicated). A raw /dev/zero -> /dev/null is 3 times faster with
vmsplice/splice.

-- 
Jens Axboe

