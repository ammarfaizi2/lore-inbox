Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSEIEml>; Thu, 9 May 2002 00:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315612AbSEIEmk>; Thu, 9 May 2002 00:42:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16573 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315611AbSEIEmk>;
	Thu, 9 May 2002 00:42:40 -0400
Date: Thu, 9 May 2002 00:42:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
In-Reply-To: <20020508225603.GA11842@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0205090039060.12789-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 May 2002, Pavel Machek wrote:

> Well, I'm doing it during boot, and this is swap partition; it should
> not have been accessed previously.
> 
> > >         bdev = bdget(kdev_t_to_nr(dev));
> > >         if (!bdev) {
> > >                 printk("No block device for %s\n", __bdevname(dev));
> > >                 BUG();
> > >         }
> > >         printk("C");

blkdev_open(bdev, FMODE_READ, O_RDONLY, BDEV_RAW)

> > >         bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
> > >         printk("D");
> > >         bdput(bdev);

nope - blkdev_put(bdev), and do it _after_ you are done with buffers.
Oh, and you need to do brelse().

> > >         if (!bh || (!bh->b_data)) {
> > >                 return -1;

However, I would really suggest to open the bugger once, do all IO and
then close it.  See how raw.c and friends deal with these problems.

