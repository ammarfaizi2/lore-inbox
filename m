Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934255AbWKTPtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934255AbWKTPtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934256AbWKTPtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:49:15 -0500
Received: from mailgate.sandia.gov ([132.175.109.1]:15058 "EHLO
	mailgate.sandia.gov") by vger.kernel.org with ESMTP id S934255AbWKTPtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:49:14 -0500
Subject: Re: splice/vmsplice performance test results
From: Jim Schutt <jaschut@sandia.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061120082426.GG4077@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov>
	 <20061116202529.GH7164@kernel.dk>
	 <1163784110.8170.8.camel@sale659.sandia.gov>
	 <20061120075941.GF4077@kernel.dk>  <20061120082426.GG4077@kernel.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Nov 2006 08:49:03 -0700
Message-Id: <1164037743.19613.5.camel@sale659.sandia.gov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 09:24 +0100, Jens Axboe wrote:
> On Mon, Nov 20 2006, Jens Axboe wrote:
> > On Fri, Nov 17 2006, Jim Schutt wrote:
> > > On Thu, 2006-11-16 at 21:25 +0100, Jens Axboe wrote:
> > > > On Thu, Nov 16 2006, Jim Schutt wrote:
> > > > > Hi,
> > > > > 
> > > 
> > > > > My test program can do one of the following:
> > > > > 
> > > > > send data:
> > > > >  A) read() from file into buffer, write() buffer into socket
> > > > >  B) mmap() section of file, write() that into socket, munmap()
> > > > >  C) splice() from file to pipe, splice() from pipe to socket
> > > > > 
> > > > > receive data:
> > > > >  1) read() from socket into buffer, write() buffer into file
> > > > >  2) ftruncate() to extend file, mmap() new extent, read() 
> > > > >       from socket into new extent, munmap()
> > > > >  3) read() from socket into buffer, vmsplice() buffer to 
> > > > >      pipe, splice() pipe to file (using the double-buffer trick)
> > > > > 
> > > > > Here's the results, using:
> > > > >  - 64 KiB buffer, mmap extent, or splice
> > > > >  - 1 MiB TCP window
> > > > >  - 16 GiB data sent across network
> > > > > 
> > > > > A) from /dev/zero -> 1) to /dev/null : 857 MB/s (6.86 Gb/s)
> > > > > 
> > > > > A) from file      -> 1) to /dev/null : 472 MB/s (3.77 Gb/s)
> > > > > B) from file      -> 1) to /dev/null : 366 MB/s (2.93 Gb/s)
> > > > > C) from file      -> 1) to /dev/null : 854 MB/s (6.83 Gb/s)
> > > > > 
> > > > > A) from /dev/zero -> 1) to file      : 375 MB/s (3.00 Gb/s)
> > > > > A) from /dev/zero -> 2) to file      : 150 MB/s (1.20 Gb/s)
> > > > > A) from /dev/zero -> 3) to file      : 286 MB/s (2.29 Gb/s)
> > > > > 
> > > > > I had (naively) hoped the read/vmsplice/splice combination would 
> > > > > run at the same speed I can write a file, i.e. at about 450 MB/s
> > > > > on my setup.  Do any of my numbers seem bogus, so I should look 
> > > > > harder at my test program?
> > > > 
> > > > Could be read-ahead playing in here, I'd have to take a closer look at
> > > > the generated io patterns to say more about that. Any chance you can
> > > > capture iostat or blktrace info for such a run to compare that goes to
> > > > the disk?
> > > 
> > > I've attached a file with iostat and vmstat results for the case
> > > where I read from a socket and write a file, vs. the case where I
> > > read from a socket and use vmsplice/splice to write the file.
> > > (Sorry it's not inline - my mailer locks up when I try to
> > > include the file.)
> > > 
> > > Would you still like blktrace info for these two cases?
> > 
> > No, I think the iostat data is fine, I don't think the blktrace info
> > would give me any more insight on this problem. I'll set up a test to
> > reproduce it here, looks like the write out path could be optimized some
> > more.

Great, let me know if you need testing from me.

> 
> While I get that setup, can you repeat your testing without using
> SPLICE_F_MORE (you don't really use that flag correctly, but it does not
> matter for your case afaict) and SPLICE_F_MOVE?

Done.  Removing these flags from any call to splice or vmsplice made 
no difference to throughput for me, either when sending or receiving 
a file.

>  The latter will cost
> some CPU, but vmsplice/splice for network receive to a file is not
> really optimal in the first place. When we get splice() from socket fd
> support that'll improve, right now you are doing the best you can.
> 
Thanks for reviewing my test program.
