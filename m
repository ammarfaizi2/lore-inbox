Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSKCWlt>; Sun, 3 Nov 2002 17:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSKCWlt>; Sun, 3 Nov 2002 17:41:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32008 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262547AbSKCWlt>; Sun, 3 Nov 2002 17:41:49 -0500
Date: Sun, 3 Nov 2002 14:48:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
In-Reply-To: <20021103220904.GE28704@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002, Pavel Machek wrote:
> 
> How do I quiesce a queue? Is it ll_rw_blk stuff?

Just send a request down the request list, and make sure that

 - the command is marked as being non-mergeable or re-orderable by 
   software (as all special commands are)

 - the command is not re-orderable / mergeable by hardware (and since the
   command in question would be something like "flush" or "spindown",
   hardware really would be quite broken if it re-ordered it ;)

and then just wait for its completion.

The code is not that complicated, it looks roughly something like

	struct request *rq;

	rq = blk_get_request(q, WRITE, __GFP_WAIT);
	rq->flags = REQ_BLOCK_PC;
	rq->data = NULL;
	rq->data_len = 0;
	rq->timeout = 5*HZ; /* Or whatever */
	memset(rq->cmd, 0, sizeof(rq->cmd));
	rq->cmd[0] = SYNCHRONIZE_CACHE;
	.. fill in whatever bytes the SYNCHRONIZE_CACHE cmd needs ..
	rq->cmd_len = 10;
	err = blk_do_rq(q, bdev, rq);
	blk_put_request(rq);

and you're done. The above should work pretty much on all block drivers
out there, btw: the ones that don't understand SCSI commands should just
ignore requests that aren't the regular REQ_CMD commands.

See drivers/block/scsi_ioctl.c for other examples of sending down commands 
to block devices.

		Linus

