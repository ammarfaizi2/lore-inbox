Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVJQRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVJQRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVJQRw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:52:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13333 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751078AbVJQRwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:52:55 -0400
Date: Mon, 17 Oct 2005 19:53:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: li nux <lnxluv@yahoo.com>, Grzegorz Kulewski <kangur@polcom.net>,
       Erik Mouw <erik@harddisk-recovery.com>, colin <colin@realtek.com.tw>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20051017175326.GX2811@suse.de>
References: <20051017091710.GT2811@suse.de> <20051017094140.14685.qmail@web33301.mail.mud.yahoo.com> <20051017095133.GU2811@suse.de> <1129566970.23632.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129566970.23632.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17 2005, Badari Pulavarty wrote:
> On Mon, 2005-10-17 at 11:51 +0200, Jens Axboe wrote:
> > On Mon, Oct 17 2005, li nux wrote:
> > > 
> > > 
> > > --- Jens Axboe <axboe@suse.de> wrote:
> > > 
> > > > On Mon, Oct 17 2005, Grzegorz Kulewski wrote:
> > > > > On Mon, 17 Oct 2005, Jens Axboe wrote:
> > > > > >>how to correct this problem ?
> > > > > >
> > > > > >See your buffer address, it's not aligned. You
> > > > need to align that as
> > > > > >well. This is needed because the hardware will
> > > > dma directly to the user
> > > > > >buffer, and to be on the safe side we require the
> > > > same alignment as the
> > > > > >block layer will normally generate for file
> > > > system io.
> > > > > >
> > > > > >So in short, just align your read buffer to the
> > > > same as your block size
> > > > > >and you will be fine. Example:
> > > > > >
> > > > > >#define BS      (4096)
> > > > > >#define MASK    (BS - 1)
> > > > > >#define ALIGN(buf)      (((unsigned long) (buf) +
> > > > MASK) & ~(MASK))
> > > > > >
> > > > > >char *ptr = malloc(BS + MASK);
> > > > > >char *buf = (char *) ALIGN(ptr);
> > > > > >
> > > > > >read(fd, buf, BS);
> > > > > 
> > > > > Shouldn't one use posix_memalign(3) for that?
> > > > 
> > > > Dunno if one 'should', one 'can' if one wants to. I
> > > > prefer to do it
> > > > manually so I don't have to jump through #define
> > > > hoops to get at it
> > > > (which, btw, still doesn't expose it on this
> > > > machine).
> > > > 
> > > > -- 
> > > > Jens Axboe
> > > 
> > > Thanx a lot Jens :-)
> > > Its working now.
> > > I did not have to make these adjustments on 2.6
> > > Is looks to be having more relaxation.
> > 
> > 2.6 does have the option of checking the hardware dma requirement
> > seperately, but for this path you should run into the same restrictions.
> > Perhaps you just got lucky when testing 2.6?
> 
> 2.6 also has the same restriction. But, if the "filesystem 
> blocksize alignment" (soft block size) fails, we try to see 
> if its aligned with hard sector size (512). If so, we can do the IO.
>  
> 2.4 fails if the offset or buffer is NOT filesystem blocksize
> aligned. Period.

I'm aware of that, however this particular case was about the buffer
alignment (which was 32-bytes in the strace). And that should not work
for 2.6 either.

The block-size alignment is really a separate property of correctness.

> BTW, posix_memalign() or valloc() should be safe.

Certainly.

-- 
Jens Axboe

