Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283541AbRK3Hhx>; Fri, 30 Nov 2001 02:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283539AbRK3Hho>; Fri, 30 Nov 2001 02:37:44 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53428 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283538AbRK3Hhb>;
	Fri, 30 Nov 2001 02:37:31 -0500
Date: Fri, 30 Nov 2001 02:37:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.1.4: fix rd.c build
In-Reply-To: <20011130082855.E16796@suse.de>
Message-ID: <Pine.GSO.4.21.0111300229570.13367-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Nov 2001, Jens Axboe wrote:

> On Fri, Nov 30 2001, Alexander Viro wrote:
> > 
> > 
> > On Fri, 30 Nov 2001, Jens Axboe wrote:
> > 
> > > Actually, this is not even enough if rd receives a multi page bio.
> > > Something like this should work, untested.
> > > 
> > > @@ -237,9 +238,9 @@
> > >  	err = -EIO;
> > 
> > Make it err = 0...
> 
> Explain

Think what happens if you have all these pages in page cache.  Already.
Returning -EIO is hardly a good idea in that case.  Look through the
loop - we assign err in the body only if we have to allocate a new
page.

Notice that any bh brings the page in.  I.e. for smaller-than-page ones
you are going to have a lot of fun...

>From -pre2:

@@ -227,19 +227,18 @@
        commit_write: ramdisk_commit_write,
 };
 
-static int rd_blkdev_pagecache_IO(int rw, struct buffer_head * sbh, int minor)
+static int rd_blkdev_pagecache_IO(int rw, struct bio *sbh, int minor)
 {
        struct address_space * mapping;
        unsigned long index;
        int offset, size, err;
 
        err = -EIO;
-       err = 0;
        mapping = rd_bdev[minor]->bd_inode->i_mapping;

Sure, one of these assignments had to go away.  You'd picked the wrong one,
though...

