Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVLSUCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVLSUCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVLSUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:02:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964905AbVLSUCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:02:30 -0500
Date: Mon, 19 Dec 2005 12:02:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Collins <ben.collins@ubuntu.com>
cc: Jens Axboe <axboe@suse.de>, Ben Collins <bcollins@ubuntu.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
In-Reply-To: <1135021497.2029.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512191156430.4827@g5.osdl.org>
References: <20051219153236.GA10905@swissdisk.com> <20051219193508.GL3734@suse.de>
 <1135021497.2029.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Dec 2005, Ben Collins wrote:
> 
> > >  		case CDROMEJECT:
> > > -			rq = blk_get_request(q, WRITE, __GFP_WAIT);
> > > -			rq->flags |= REQ_BLOCK_PC;
> > > -			rq->data = NULL;
> > > -			rq->data_len = 0;
> > > -			rq->timeout = BLK_DEFAULT_TIMEOUT;
> > > -			memset(rq->cmd, 0, sizeof(rq->cmd));
> > > -			rq->cmd[0] = GPCMD_START_STOP_UNIT;
> > > -			rq->cmd[4] = 0x02 + (close != 0);
> > > -			rq->cmd_len = 6;
> > > -			err = blk_execute_rq(q, bd_disk, rq, 0);
> > > -			blk_put_request(rq);
> > > +			err = 0;
> > > +
> > > +			err |= blk_send_allow_medium_removal(q, bd_disk);
> > > +			err |= blk_send_start_stop(q, bd_disk, 0x01);
> > > +			err |= blk_send_start_stop(q, bd_disk, 0x02);
> > 
> > Do this in the eject tool, if it's required for some devices.
> 
> It already is in eject tool, but as described, that requires root
> access. Not something I want to force a user to do in order to eject
> their CDROM/iPod/USBStick in gnome. What exactly is wrong with the
> commands? If they are harmless for devices that don't need it, and fix a
> huge number of problems (did you see the Cc list on the bug report?) for
> users with affected devices, then what's the harm?

I do agree that the suggested patch seems to be a real cleanup, regardless 
of whether the original code bug has now been fixed or not.

Are there devices that really want the old sequence? 

Also, do we really need to send fist a start_stop 1 and then a 2?

Wouldn't the _logical_ thing be to replace the old code with just a 
cleaned-up-version of what the old code did, ie just do

	err = blk_send_start_stop(q, bd_disk, 0x02);

for the eject case? That way we could do the patch as a pure cleanup, and 
then a separate patch might change the singe "start_stop 2" with the more 
complex sequence.

(IOW, I'd prefer to separate out the cleanup from the "make the eject 
sequence more complete" part).

		Linus
