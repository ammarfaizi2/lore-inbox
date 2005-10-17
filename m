Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVJQJDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJQJDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJQJDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:03:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37705 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932197AbVJQJDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:03:15 -0400
Date: Mon, 17 Oct 2005 11:03:11 +0200
From: Jens Axboe <axboe@suse.de>
To: li nux <lnxluv@yahoo.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, colin <colin@realtek.com.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20051017090310.GR2811@suse.de>
References: <20050831080744.GM4018@suse.de> <20051017085226.47541.qmail@web33315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017085226.47541.qmail@web33315.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17 2005, li nux wrote:
> 
> 
> --- Jens Axboe <axboe@suse.de> wrote:
> 
> > On Mon, Aug 29 2005, Erik Mouw wrote:
> > > There are four prerequisites for direct IO:
> > > - the file needs to be opened with O_DIRECT
> > > - the buffer needs to be page aligned (hint: use
> > getpagesize() instead
> > >   of assuming that a page is 4k
> > > - reads and writes need to happen *in* multiples
> > of the soft block size
> > > - reads and writes need to happen *at* multiples
> > of the soft block size
> > 
> > Actually, the buffer only needs to be hard block
> > size aligned, same goes
> > for the chunk size used for reads/writes.
> > 
> > -- 
> > Jens Axboe
> > 
> On 2.4 the open call succeeds with O_DIRECT
> but read returns -EINVAL for any block size (512, 1024
> ..16384)
> 
> open("/tmp/midstress_idx10",
> O_RDWR|O_CREAT|O_DIRECT|O_LARGEFILE, 01001101270) = 4
> read(3, 0xbfffdc40, 16384) = -1 EINVAL (Invalid
> argument)
> 
> how to correct this problem ?

See your buffer address, it's not aligned. You need to align that as
well. This is needed because the hardware will dma directly to the user
buffer, and to be on the safe side we require the same alignment as the
block layer will normally generate for file system io.

So in short, just align your read buffer to the same as your block size
and you will be fine. Example:

#define BS      (4096)
#define MASK    (BS - 1)
#define ALIGN(buf)      (((unsigned long) (buf) + MASK) & ~(MASK))

char *ptr = malloc(BS + MASK);
char *buf = (char *) ALIGN(ptr);

read(fd, buf, BS);

-- 
Jens Axboe

