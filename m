Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315166AbSEHUuX>; Wed, 8 May 2002 16:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSEHUuW>; Wed, 8 May 2002 16:50:22 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24213 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315166AbSEHUuV>;
	Wed, 8 May 2002 16:50:21 -0400
Date: Wed, 8 May 2002 22:48:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Reading page from given block device
Message-ID: <20020508204809.GA2300@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For swsusp, I kind of need to read 4K from given block device.

Here's my attempt:

static int bdev_read_page(kdev_t dev, long pos, void *buf)
{
        struct buffer_head *bh;
        struct block_device *bdev;

        if (pos%PAGE_SIZE) panic("Sorry, dave, I can't let you do
that!\n");
        bdev = bdget(kdev_t_to_nr(dev));
        if (!bdev) {
                printk("No block device for %s\n", __bdevname(dev));
                BUG();
        }
        printk("C");
        bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
        printk("D");
        bdput(bdev);
        if (!bh || (!bh->b_data)) {
                return -1;
        }
        memcpy(buf, bh->b_data, PAGE_SIZE);
        bforget(bh);                    /* FIXME: maybe bforget should
be here */
        return 0;
}

It works *once*, second time it deadlocks in __bread(). I tried both
bforget() and brelse(). Kernel is 2.5.13. What am I doing wrong/what's
wrong?

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
