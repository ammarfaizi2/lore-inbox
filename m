Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVJQQgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVJQQgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVJQQgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:36:49 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:63706 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750761AbVJQQgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:36:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=paJlKQ9RFWPShVHNYP27rpppJGS15o5hNzg7KF0LND+OcJINnueQ108MkrA4uxu0D62p+o62O8QNWzb+TzYvNOjjSgBEgRMUI7nmnkD1aSgk0H3HK9vzIQTDvnLquZvDmhCyPn6FOuPwCHYXdQ7lKhl1qIqJbq1WCRA8mnEkowU=
Subject: Re: A problem about DIRECT IO on ext3
From: Badari Pulavarty <pbadari@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: li nux <lnxluv@yahoo.com>, Grzegorz Kulewski <kangur@polcom.net>,
       Erik Mouw <erik@harddisk-recovery.com>, colin <colin@realtek.com.tw>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051017095133.GU2811@suse.de>
References: <20051017091710.GT2811@suse.de>
	 <20051017094140.14685.qmail@web33301.mail.mud.yahoo.com>
	 <20051017095133.GU2811@suse.de>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 09:36:10 -0700
Message-Id: <1129566970.23632.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 11:51 +0200, Jens Axboe wrote:
> On Mon, Oct 17 2005, li nux wrote:
> > 
> > 
> > --- Jens Axboe <axboe@suse.de> wrote:
> > 
> > > On Mon, Oct 17 2005, Grzegorz Kulewski wrote:
> > > > On Mon, 17 Oct 2005, Jens Axboe wrote:
> > > > >>how to correct this problem ?
> > > > >
> > > > >See your buffer address, it's not aligned. You
> > > need to align that as
> > > > >well. This is needed because the hardware will
> > > dma directly to the user
> > > > >buffer, and to be on the safe side we require the
> > > same alignment as the
> > > > >block layer will normally generate for file
> > > system io.
> > > > >
> > > > >So in short, just align your read buffer to the
> > > same as your block size
> > > > >and you will be fine. Example:
> > > > >
> > > > >#define BS      (4096)
> > > > >#define MASK    (BS - 1)
> > > > >#define ALIGN(buf)      (((unsigned long) (buf) +
> > > MASK) & ~(MASK))
> > > > >
> > > > >char *ptr = malloc(BS + MASK);
> > > > >char *buf = (char *) ALIGN(ptr);
> > > > >
> > > > >read(fd, buf, BS);
> > > > 
> > > > Shouldn't one use posix_memalign(3) for that?
> > > 
> > > Dunno if one 'should', one 'can' if one wants to. I
> > > prefer to do it
> > > manually so I don't have to jump through #define
> > > hoops to get at it
> > > (which, btw, still doesn't expose it on this
> > > machine).
> > > 
> > > -- 
> > > Jens Axboe
> > 
> > Thanx a lot Jens :-)
> > Its working now.
> > I did not have to make these adjustments on 2.6
> > Is looks to be having more relaxation.
> 
> 2.6 does have the option of checking the hardware dma requirement
> seperately, but for this path you should run into the same restrictions.
> Perhaps you just got lucky when testing 2.6?

2.6 also has the same restriction. But, if the "filesystem 
blocksize alignment" (soft block size) fails, we try to see 
if its aligned with hard sector size (512). If so, we can do the IO.
 
2.4 fails if the offset or buffer is NOT filesystem blocksize
aligned. Period.

So, its possible that your buffer is atleast 512byte aligned,
there by succeeding on 2.6

BTW, posix_memalign() or valloc() should be safe.
 
> 
> > Can somebody please throw some light on how to find
> > your system's hard/soft block size ?
> 
> It's a per-device (or even per-partition, in case of mounted partitions)
> setting, you can use the BLKBSZGET and BLKSSZGET ioctls to query for
> soft/hard sector sizes.
> 

Thanks,
Badari

