Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315476AbSEHW4C>; Wed, 8 May 2002 18:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315477AbSEHW4B>; Wed, 8 May 2002 18:56:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1028 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315476AbSEHW4A>; Wed, 8 May 2002 18:56:00 -0400
Date: Thu, 9 May 2002 00:56:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
Message-ID: <20020508225603.GA11842@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020508204809.GA2300@elf.ucw.cz> <3CD996E5.BFB5CF9E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > For swsusp, I kind of need to read 4K from given block device.
> > 
> > Here's my attempt:
> > 
> > static int bdev_read_page(kdev_t dev, long pos, void *buf)
> > {
> >         struct buffer_head *bh;
> >         struct block_device *bdev;
> > 
> >         if (pos%PAGE_SIZE) panic("Sorry, dave, I can't let you do
> > that!\n");
> 
> It's possible I guess that someone has a pinned buffer against
> the same page which has a different block size.  See the "lock up"
> comment over __getblk().

Well, I'm doing it during boot, and this is swap partition; it should
not have been accessed previously.

> >         bdev = bdget(kdev_t_to_nr(dev));
> >         if (!bdev) {
> >                 printk("No block device for %s\n", __bdevname(dev));
> >                 BUG();
> >         }
> >         printk("C");
> >         bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
> >         printk("D");
> >         bdput(bdev);
> >         if (!bh || (!bh->b_data)) {
> >                 return -1;
> >         }
> >         memcpy(buf, bh->b_data, PAGE_SIZE);
> 
> You'll need to kmap bh->b_page before copying the data.

This machine does not have himem.

> > It works *once*, second time it deadlocks in __bread(). I tried both
> > bforget() and brelse(). Kernel is 2.5.13. What am I doing wrong/what's
> > wrong?
> 
> brelse is safer.
> 
> Please try 2.5.14.  2.5.13 had a few leaky problems which
> could perhaps result in a pinned buffer which will cause
> try_to_free_buffers() to fail, which triggers the __getblk()
> nastiness.
> 
> Generally, if you're reading from a swap partition then
> it may be better to use brw_page().  bread() is backed

It is swap partition, but system does not yet know its swap at that
point. This is next boot, that partition was not yet accessed.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
