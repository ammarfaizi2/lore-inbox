Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVLSTy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVLSTy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVLSTy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:54:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32838 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964923AbVLSTy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:54:56 -0500
Date: Mon, 19 Dec 2005 20:56:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Ben Collins <bcollins@ubuntu.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
Message-ID: <20051219195630.GO3734@suse.de>
References: <20051219153236.GA10905@swissdisk.com> <20051219193508.GL3734@suse.de> <1135021497.2029.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135021497.2029.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19 2005, Ben Collins wrote:
> On Mon, 2005-12-19 at 20:35 +0100, Jens Axboe wrote:
> > On Mon, Dec 19 2005, Ben Collins wrote:
> > > Reference: https://bugzilla.ubuntu.com/5049
> > > 
> > > The eject command was failing for a large group of users for removable
> > > devices. The "eject -r" command, which uses the CDROMEJECT ioctl would not
> > > work, however "eject -s", which uses SG_IO did work, but required root access.
> > > 
> > > Since SG_IO was using the same mechanism as CDROMEJECT, there should be no
> > > difference. The main reason for getting the CDROMEJECT ioctl working was
> > > because it didn't need root privileges like the SG_IO commands did.
> > > 
> > > One bug was noticed, and that is CDROMEJECT was setting the blk request to a
> > > WRITE operation, when in fact it wasn't. The block layer did not like getting
> > > WRITE requests when data_len==0 and data==NULL.
> > 
> > False, it can't be a write request if there's no data attached. Write is
> > simply used there because read requests are usually more precious.
> 
> Did you mean "can be a write request"? If not, then you just repeated
> what I said.

No, you are misreading me. Definition:

- Read request: direction bit not set, non-zero data length
- Write request: direction bit set, non-zero data length

How can you read or write anything, when there's nothing to read or
write?

> > > This patch fixes the WRITE vs READ issue, and also sends the extra two
> > > commands. Anyone with an iPod connected via USB (not sure about firewire)
> > > should be able to reproduce this issue, and verify the patch.
> > 
> > The bug was in the SCSI layer, and James already has the fix integrated
> > for that. It really should make 2.6.15, James are you sending it upwards
> > for that?
> 
> Can you point me to this fix? Also, does the "fix" fix the case for IDE
> CDROM's too?

What is the problem case for for ide-cd?

The SCSI fix is here:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a8c730e85e80734412f4f73ab28496a0e8b04a7b

and followed up by a fix for James to cater to all paths:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c9526497cf03ee775c3a6f8ba62335735f98de7a

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

So the medium removal command does require write permission on the
deviec, but it doesn't require root. If they need to rw to the device
fs, surely they need write permissions on the device in the first place?

-- 
Jens Axboe

