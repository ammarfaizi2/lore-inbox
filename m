Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSHLDO0>; Sun, 11 Aug 2002 23:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSHLDO0>; Sun, 11 Aug 2002 23:14:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4615 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318641AbSHLDOZ>;
	Sun, 11 Aug 2002 23:14:25 -0400
Message-ID: <3D572B4C.90F4AF3C@zip.com.au>
Date: Sun, 11 Aug 2002 20:28:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <20020811031705.GA13878@netnation.com> <Pine.LNX.4.44.0208111121510.9930-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> Basically, it _used_ to be that each page got woken up one at a time as
> they became ready after IO. With the new scheme, they all get woken up
> together in "mpage_end_io_read()" (or write, but since people usually
> don't wait for writes..).
> 
> At least that is how I read the code. Andrew?

Yes.  The basic unit of IO in there is a 64k BIO.  So once readahead
is cruising, pages come unlocked in 16-page batches.  In 2.4 they'll
come unlocked one at a time against a device such as a floppy drive.

But with default settings the readahead code lays one to two of these
BIOs out ahead of the read point, so the application never stumbles across
a locked page unless it's outpacing the device.

At least that's the theory, and the testing I did yesterday
was succesful.

So I'd appreciate it if Simon could invetigate a little further
with the test app I posted.  Something is up, and it may not
be just an NFS thing.  But note that nfs_readpage will go
synchronous if rsize is less than PAGE_CACHE_SIZE, so it has
to be set up right.
