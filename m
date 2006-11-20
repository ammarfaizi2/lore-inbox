Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934001AbWKTIYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934001AbWKTIYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934002AbWKTIYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:24:44 -0500
Received: from brick.kernel.dk ([62.242.22.158]:64564 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S934001AbWKTIYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:24:43 -0500
Date: Mon, 20 Nov 2006 09:24:26 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jim Schutt <jaschut@sandia.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice/vmsplice performance test results
Message-ID: <20061120082426.GG4077@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov> <20061116202529.GH7164@kernel.dk> <1163784110.8170.8.camel@sale659.sandia.gov> <20061120075941.GF4077@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120075941.GF4077@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2006, Jens Axboe wrote:
> On Fri, Nov 17 2006, Jim Schutt wrote:
> > On Thu, 2006-11-16 at 21:25 +0100, Jens Axboe wrote:
> > > On Thu, Nov 16 2006, Jim Schutt wrote:
> > > > Hi,
> > > > 
> > 
> > > > My test program can do one of the following:
> > > > 
> > > > send data:
> > > >  A) read() from file into buffer, write() buffer into socket
> > > >  B) mmap() section of file, write() that into socket, munmap()
> > > >  C) splice() from file to pipe, splice() from pipe to socket
> > > > 
> > > > receive data:
> > > >  1) read() from socket into buffer, write() buffer into file
> > > >  2) ftruncate() to extend file, mmap() new extent, read() 
> > > >       from socket into new extent, munmap()
> > > >  3) read() from socket into buffer, vmsplice() buffer to 
> > > >      pipe, splice() pipe to file (using the double-buffer trick)
> > > > 
> > > > Here's the results, using:
> > > >  - 64 KiB buffer, mmap extent, or splice
> > > >  - 1 MiB TCP window
> > > >  - 16 GiB data sent across network
> > > > 
> > > > A) from /dev/zero -> 1) to /dev/null : 857 MB/s (6.86 Gb/s)
> > > > 
> > > > A) from file      -> 1) to /dev/null : 472 MB/s (3.77 Gb/s)
> > > > B) from file      -> 1) to /dev/null : 366 MB/s (2.93 Gb/s)
> > > > C) from file      -> 1) to /dev/null : 854 MB/s (6.83 Gb/s)
> > > > 
> > > > A) from /dev/zero -> 1) to file      : 375 MB/s (3.00 Gb/s)
> > > > A) from /dev/zero -> 2) to file      : 150 MB/s (1.20 Gb/s)
> > > > A) from /dev/zero -> 3) to file      : 286 MB/s (2.29 Gb/s)
> > > > 
> > > > I had (naively) hoped the read/vmsplice/splice combination would 
> > > > run at the same speed I can write a file, i.e. at about 450 MB/s
> > > > on my setup.  Do any of my numbers seem bogus, so I should look 
> > > > harder at my test program?
> > > 
> > > Could be read-ahead playing in here, I'd have to take a closer look at
> > > the generated io patterns to say more about that. Any chance you can
> > > capture iostat or blktrace info for such a run to compare that goes to
> > > the disk?
> > 
> > I've attached a file with iostat and vmstat results for the case
> > where I read from a socket and write a file, vs. the case where I
> > read from a socket and use vmsplice/splice to write the file.
> > (Sorry it's not inline - my mailer locks up when I try to
> > include the file.)
> > 
> > Would you still like blktrace info for these two cases?
> 
> No, I think the iostat data is fine, I don't think the blktrace info
> would give me any more insight on this problem. I'll set up a test to
> reproduce it here, looks like the write out path could be optimized some
> more.

While I get that setup, can you repeat your testing without using
SPLICE_F_MORE (you don't really use that flag correctly, but it does not
matter for your case afaict) and SPLICE_F_MOVE? The latter will cost
some CPU, but vmsplice/splice for network receive to a file is not
really optimal in the first place. When we get splice() from socket fd
support that'll improve, right now you are doing the best you can.

-- 
Jens Axboe

