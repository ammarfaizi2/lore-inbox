Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290375AbSAPHKU>; Wed, 16 Jan 2002 02:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290379AbSAPHJ7>; Wed, 16 Jan 2002 02:09:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21776 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290375AbSAPHJ5>;
	Wed, 16 Jan 2002 02:09:57 -0500
Date: Wed, 16 Jan 2002 08:09:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: block completion races
Message-ID: <20020116080948.G3805@suse.de>
In-Reply-To: <3C44DC7B.D960D15D@zip.com.au> <Pine.LNX.4.10.10201152001400.26467-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201152001400.26467-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2002, Andre Hedrick wrote:
> 
> We have a more interesting problem!
> This does not show up in 2.5.1 which is patch base for 2.5.3-pre1.
> It does show up in 2.5.2-pre10 but I have not walked the patch through
> 2.5.2preX series.
> 
> We have a very bad queue race that is PIO specific but really the whole
> darn driver before the patch was applied.  ACB only tighten the driver's
> alignment to the NCITS standards.  One should note the direct access via
> the ioctl does not lock the driver.  Only coming down from BLOCK will this
> event occur.
> 
> Repeatable test "hdparm -d0 -t /dev/hdx"
> 
> If you apply the acb-io patch to 2.5.1 this does not happen.
> 
> In the introduction of BIO, there were no "q->queue_lock" applied to
> protecting the queue.
> 
>         /*
>          * Is meant to protect the queue in the future instead of
>          * io_request_lock
>          */
>         spinlock_t              queue_lock;
> 
> Well we pulled "io_request_lock" but did we forgot to insert or add
> q->queue_lock spinlocks?
> 
> It is going to be a LONG LONG NIGHT :-(

ide_lock == q->queue_lock

ide-probe.c:ide_init_queue():	blk_init_queue(q, do_ide_request, &ide_lock);

-- 
Jens Axboe

