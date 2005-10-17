Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVJQJuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVJQJuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVJQJuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:50:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3951 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932238AbVJQJux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:50:53 -0400
Date: Mon, 17 Oct 2005 11:51:33 +0200
From: Jens Axboe <axboe@suse.de>
To: li nux <lnxluv@yahoo.com>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Erik Mouw <erik@harddisk-recovery.com>, colin <colin@realtek.com.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20051017095133.GU2811@suse.de>
References: <20051017091710.GT2811@suse.de> <20051017094140.14685.qmail@web33301.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017094140.14685.qmail@web33301.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17 2005, li nux wrote:
> 
> 
> --- Jens Axboe <axboe@suse.de> wrote:
> 
> > On Mon, Oct 17 2005, Grzegorz Kulewski wrote:
> > > On Mon, 17 Oct 2005, Jens Axboe wrote:
> > > >>how to correct this problem ?
> > > >
> > > >See your buffer address, it's not aligned. You
> > need to align that as
> > > >well. This is needed because the hardware will
> > dma directly to the user
> > > >buffer, and to be on the safe side we require the
> > same alignment as the
> > > >block layer will normally generate for file
> > system io.
> > > >
> > > >So in short, just align your read buffer to the
> > same as your block size
> > > >and you will be fine. Example:
> > > >
> > > >#define BS      (4096)
> > > >#define MASK    (BS - 1)
> > > >#define ALIGN(buf)      (((unsigned long) (buf) +
> > MASK) & ~(MASK))
> > > >
> > > >char *ptr = malloc(BS + MASK);
> > > >char *buf = (char *) ALIGN(ptr);
> > > >
> > > >read(fd, buf, BS);
> > > 
> > > Shouldn't one use posix_memalign(3) for that?
> > 
> > Dunno if one 'should', one 'can' if one wants to. I
> > prefer to do it
> > manually so I don't have to jump through #define
> > hoops to get at it
> > (which, btw, still doesn't expose it on this
> > machine).
> > 
> > -- 
> > Jens Axboe
> 
> Thanx a lot Jens :-)
> Its working now.
> I did not have to make these adjustments on 2.6
> Is looks to be having more relaxation.

2.6 does have the option of checking the hardware dma requirement
seperately, but for this path you should run into the same restrictions.
Perhaps you just got lucky when testing 2.6?

> Can somebody please throw some light on how to find
> your system's hard/soft block size ?

It's a per-device (or even per-partition, in case of mounted partitions)
setting, you can use the BLKBSZGET and BLKSSZGET ioctls to query for
soft/hard sector sizes.

-- 
Jens Axboe

