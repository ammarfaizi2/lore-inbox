Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263332AbSKCWu0>; Sun, 3 Nov 2002 17:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKCWuZ>; Sun, 3 Nov 2002 17:50:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20741 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263332AbSKCWuY>; Sun, 3 Nov 2002 17:50:24 -0500
Date: Sun, 3 Nov 2002 23:56:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021103225656.GR28704@atrey.karlin.mff.cuni.cz>
References: <20021103220904.GE28704@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How do I quiesce a queue? Is it ll_rw_blk stuff?
> 
> Just send a request down the request list, and make sure that
> 
>  - the command is marked as being non-mergeable or re-orderable by 
>    software (as all special commands are)
> 
>  - the command is not re-orderable / mergeable by hardware (and since the
>    command in question would be something like "flush" or "spindown",
>    hardware really would be quite broken if it re-ordered it ;)
> 
> and then just wait for its completion.

Okay, so it can be done.

Is that really the right way to prepare disks for suspend? 

I sleep all devices by telling driverfs to sleep them. Should I tell
all block devices, then tell driverfs? Seems hacky to me. Or should
idedisk_suspend generate request for itself, then pass it through
queues?

> The code is not that complicated, it looks roughly something like
> 
> 	struct request *rq;
> 
> 	rq = blk_get_request(q, WRITE, __GFP_WAIT);
> 	rq->flags = REQ_BLOCK_PC;
> 	rq->data = NULL;
> 	rq->data_len = 0;
> 	rq->timeout = 5*HZ; /* Or whatever */
> 	memset(rq->cmd, 0, sizeof(rq->cmd));
> 	rq->cmd[0] = SYNCHRONIZE_CACHE;
> 	.. fill in whatever bytes the SYNCHRONIZE_CACHE cmd needs ..
> 	rq->cmd_len = 10;
> 	err = blk_do_rq(q, bdev, rq);
> 	blk_put_request(rq);

Thanx.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
