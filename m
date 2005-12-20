Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVLTShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVLTShW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVLTShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:37:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47163 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750915AbVLTShW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:37:22 -0500
Date: Tue, 20 Dec 2005 19:38:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
Message-ID: <20051220183857.GQ3734@suse.de>
References: <20051219195014.GA13578@swissdisk.com> <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org> <20051220174948.GP3734@suse.de> <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Dec 2005, Jens Axboe wrote:
> > 
> > WRITEs cannot have length 0, and READs cannot as well. Since it's just
> > one bit for direction, those are the rules.
> 
> Jens, your logic doesn't make sense.

It does

> There clearly _are_ commands with a 0 data-length.

Of course, that's not what I'm saying. What I am saying is interpreted
from the driver or further down in the io stack.

> And commands _have_ to be either READ or WRITE. We don't have a choice. 
> ll_rw_block: blk_get_request() even has a BIG_ON() that enforces that.

Yes, it has to choose one of the two pools.

> So claiming that reads and writes cannot have zere data-length is INSANE.

There are two sides to this - looking at the request allocations pools,
yes if you want a request you have to tell from which pool you want it
from. But a request that originates from that particular pool (in this
case the write pool), does _not_ have to imply any transfer of data from
a device!

> So reads and writes HAVE to accept a zero data length. End of story. If 

That's not up for debate, of course that is the case. Otherwise we could
not issue any request unless it needed to transfer data from a device.
Just because an empty request happens to have the data direction bit
set, does not mean it wants to transfer data to the device. By
definition, that is an impossibility since there's nothing to transfer.

> there is some path in the SCSI layer that refuses it, that part must be 
> fixed, or you have to add a new "NONE" (and perhaps "BOTH") direction.

There _was_ a bug in the SCSI layer, because it had logic like this:

        if (rq_data_dir(req) == WRITE)
                DMA_TO_DEVICE
        else if (req->data_len)
                DMA_FROM_DEVICE
        else
                DMA_NONE

which was buggy, because for it to transfer data to the device, both the
direction bit _and_ a data length must be set.

-- 
Jens Axboe

