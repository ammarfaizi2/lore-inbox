Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSEHVWp>; Wed, 8 May 2002 17:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315205AbSEHVWo>; Wed, 8 May 2002 17:22:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315198AbSEHVWm>;
	Wed, 8 May 2002 17:22:42 -0400
Message-ID: <3CD996E5.BFB5CF9E@zip.com.au>
Date: Wed, 08 May 2002 14:21:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
In-Reply-To: <20020508204809.GA2300@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> For swsusp, I kind of need to read 4K from given block device.
> 
> Here's my attempt:
> 
> static int bdev_read_page(kdev_t dev, long pos, void *buf)
> {
>         struct buffer_head *bh;
>         struct block_device *bdev;
> 
>         if (pos%PAGE_SIZE) panic("Sorry, dave, I can't let you do
> that!\n");

It's possible I guess that someone has a pinned buffer against
the same page which has a different block size.  See the "lock up"
comment over __getblk().

>         bdev = bdget(kdev_t_to_nr(dev));
>         if (!bdev) {
>                 printk("No block device for %s\n", __bdevname(dev));
>                 BUG();
>         }
>         printk("C");
>         bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
>         printk("D");
>         bdput(bdev);
>         if (!bh || (!bh->b_data)) {
>                 return -1;
>         }
>         memcpy(buf, bh->b_data, PAGE_SIZE);

You'll need to kmap bh->b_page before copying the data.

> 
> It works *once*, second time it deadlocks in __bread(). I tried both
> bforget() and brelse(). Kernel is 2.5.13. What am I doing wrong/what's
> wrong?

brelse is safer.

Please try 2.5.14.  2.5.13 had a few leaky problems which
could perhaps result in a pinned buffer which will cause
try_to_free_buffers() to fail, which triggers the __getblk()
nastiness.

Generally, if you're reading from a swap partition then
it may be better to use brw_page().  bread() is backed
by bdev->bd_inode->i_mapping, and there may be coherency
problems if the target blocks are currently in swapper_space. 
Although probably your bdget() here will create a new inode
with no pagecache, so it'll work OK.

It really depends on what you're trying to do.  It may
be best to just cook up a local buffer_head and submit
the darn thing.

-
