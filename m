Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318693AbSHLDyd>; Sun, 11 Aug 2002 23:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318692AbSHLDyd>; Sun, 11 Aug 2002 23:54:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28423 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318693AbSHLDya>;
	Sun, 11 Aug 2002 23:54:30 -0400
Message-ID: <3D5734B1.2DEC6CF2@zip.com.au>
Date: Sun, 11 Aug 2002 21:08:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D572B4C.90F4AF3C@zip.com.au> <Pine.LNX.4.44.0208112023200.1518-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 11 Aug 2002, Andrew Morton wrote:
> >
> > At least that's the theory, and the testing I did yesterday
> > was succesful.
> 
> Did you try Simons test-case which seemed to be just a "cat" on a floppy
> 
>   "To demonstrate the problem reliably, I've used "strace -r cat" on a
>    floppy, which is a sufficiently slow medium. :)  This is on a 2.4.19
>    kernel, but 2.5 behaves similarly.")
> 
> although that may be different from the NFS issue, it is kind of
> interesting: the perfect behaviour would be a steady stream of data, not
> too many hickups.

I did, but I cut you from the Cc...

> I happen to have a little test app for this stuff:
> http://www.zip.com.au/~akpm/linux/stream.tar.gz
> 
> You can use it to slowly read or write a file.
> 
>         ./stream -i /dev/fd0h1440 23 1000
> 
> will read 1000k from floppy at 23k per second.  It's a bit
> useless at those rates on 2.4 because of the coarse timer
> resolution.  But in 1000Hz 2.5 it works a treat.
> 
> ./stream -i /dev/fd0h1440 20 1000  0.00s user 0.01s system 0% cpu 51.896 total
> ./stream -i /dev/fd0h1440 21 1000  0.00s user 0.02s system 0% cpu 49.825 total
> ./stream -i /dev/fd0h1440 22 1000  0.00s user 0.02s system 0% cpu 47.843 total
> ./stream -i /dev/fd0h1440 23 1000  0.00s user 0.01s system 0% cpu 45.853 total
> ./stream -i /dev/fd0h1440 24 1000  0.01s user 0.02s system 0% cpu 44.077 total
> ./stream -i /dev/fd0h1440 25 1000  0.00s user 0.02s system 0% cpu 42.307 total
> ./stream -i /dev/fd0h1440 26 1000  0.00s user 0.01s system 0% cpu 41.305 total
> ./stream -i /dev/fd0h1440 27 1000  0.00s user 0.02s system 0% cpu 40.493 total
> ./stream -i /dev/fd0h1440 28 1000  0.01s user 0.02s system 0% cpu 39.122 total
> ./stream -i /dev/fd0h1440 29 1000  0.00s user 0.01s system 0% cpu 39.118 total
> 
> What we see here is perfect readahead behaviour.  The kernel is keeping the
> read streaming ahead of the application's read cursor all the way out to the
> point where the device is saturated. (The numbers are all off by three
> seconds because of the initial spinup delay).
> 
> If you strace it, the reads are smooth on 2.4 and 2.5.
> 
> So it may be an NFS peculiarity.  That's a bit hard for me to test over
> 100bT.

The strace of that app is smooth, all the way out to the peak disk
bandwidth.

So something is different either in the test or in Simon's setup.  It
needs further investigation.
