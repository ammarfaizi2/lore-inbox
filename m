Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280873AbRKLRfs>; Mon, 12 Nov 2001 12:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280872AbRKLRfi>; Mon, 12 Nov 2001 12:35:38 -0500
Received: from 57.ppp1-3.hob.worldonline.dk ([212.54.85.57]:44673 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280867AbRKLRf0>; Mon, 12 Nov 2001 12:35:26 -0500
Date: Mon, 12 Nov 2001 18:34:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        "H . J . Lu" <hjl@lucon.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011112183442.H786@suse.de>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11 2001, Andrew Morton wrote:
> Guys,
> 
> drivers/ieee1394/sbp2.c deadlocks immediately on SMP, because
> io_request_lock is not held over its call to scsi_old_done().
> 
> I don't know why scsi_old_done() actually requires io_request_lock;
> perhaps Jens could comment on whether I've taken the lock in the
> appropriate place?

Yes it looks fine, unfortunately the mid layer locking design is crappy
like that. Imposing locking downwards is just not good style :/

I've actually had quite good luck changing this for future kernels -- it
was required to remove io_request_lock anyways.

> The games which scsi_old_done() plays with spinlocks and interrupt
> enabling are really foul.  If someone calls it with interrupts disabled
> (sbp2 does this) then scsi_old_done() will enable interrupts for you.
> If, for example, you call scsi_old_done() under spin_lock_irqsave(), 
> the reenabling of interrupts will expose you to deadlocks.  Perhaps
> scsi_old_done() should just use spin_unlock()/spin_lock()?

Yep it's not nice either. I wouldn't change that without further
auditing though.

-- 
Jens Axboe

