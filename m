Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSKYTWQ>; Mon, 25 Nov 2002 14:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSKYTWQ>; Mon, 25 Nov 2002 14:22:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:57780 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265413AbSKYTWP>;
	Mon, 25 Nov 2002 14:22:15 -0500
Message-ID: <3DE27A14.598EB80D@digeo.com>
Date: Mon, 25 Nov 2002 11:29:24 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Piet/Pete Delaney <piet@www.piet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver potentially sleeping with spin lock held in 
 linux-2.5.48 (mm1 patch)
References: <20021125123219.GA3103@www.piet.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2002 19:29:24.0714 (UTC) FILETIME=[F65034A0:01C294B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet/Pete Delaney wrote:
> 
> I'm getting a scsi problem in the  aic7xxx driver sleeping while the preempt_count() != 0.
> Looks like we are holding a spinlock where the slab allocator could go to sleep.
> 
> ...
> #5  0xc029104d in aic7xxx_alloc_aic_dev (p=0xc3f7d56c, SDptr=0xc3ed3c00) at drivers/scsi/aic7xxx_old.c:6636

This does an GFP_KERNEL allocation

> #6  0xc029717d in aic7xxx_queue (cmd=0xc3efca00, fn=0xc0280f04 <scsi_done>) at drivers/scsi/aic7xxx_old.c:10341
> #7  0xc0280a26 in scsi_dispatch_cmd (SCpnt=0xc3efca00) at drivers/scsi/scsi.c:852                                <--- spin lock grabed at Line 851 just prior to call to queuecommand()

OK.

> #8  0xc0285ed2 in scsi_request_fn (q=0xc3ed3c28) at drivers/scsi/scsi_lib.c:1061
> #9  0xc0253715 in blk_insert_request (q=0xc3ed3c28, rq=0xc3efc88c, at_head=0, data=0xc3efc800) at drivers/block/ll_rw_blk.c:1456

And this took the queue lock.

It's aic7xxx_old.c.   Presumably it is headed for the scrap
heap.  The allocation is a once-off startup thing.  Probably
not worth worrying about.
