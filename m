Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVLSU2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVLSU2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVLSU2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:28:05 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:59187 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964946AbVLSU2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:28:04 -0500
Date: Mon, 19 Dec 2005 15:27:48 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
In-reply-to: <20051219195630.GO3734@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Ben Collins <bcollins@ubuntu.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Message-id: <1135024069.4541.6.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051219153236.GA10905@swissdisk.com>
 <20051219193508.GL3734@suse.de>
 <1135021497.2029.3.camel@localhost.localdomain> <20051219195630.GO3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 20:56 +0100, Jens Axboe wrote:
> On Mon, Dec 19 2005, Ben Collins wrote:
> > On Mon, 2005-12-19 at 20:35 +0100, Jens Axboe wrote:
> > > On Mon, Dec 19 2005, Ben Collins wrote:
> > > > Reference: https://bugzilla.ubuntu.com/5049
> > > > 
> > > > The eject command was failing for a large group of users for removable
> > > > devices. The "eject -r" command, which uses the CDROMEJECT ioctl would not
> > > > work, however "eject -s", which uses SG_IO did work, but required root access.
> > > > 
> > > > Since SG_IO was using the same mechanism as CDROMEJECT, there should be no
> > > > difference. The main reason for getting the CDROMEJECT ioctl working was
> > > > because it didn't need root privileges like the SG_IO commands did.
> > > > 
> > > > One bug was noticed, and that is CDROMEJECT was setting the blk request to a
> > > > WRITE operation, when in fact it wasn't. The block layer did not like getting
> > > > WRITE requests when data_len==0 and data==NULL.
> > > 
> > > False, it can't be a write request if there's no data attached. Write is
> > > simply used there because read requests are usually more precious.
> > 
> > Did you mean "can be a write request"? If not, then you just repeated
> > what I said.
> 
> No, you are misreading me. Definition:
> 
> - Read request: direction bit not set, non-zero data length
> - Write request: direction bit set, non-zero data length
> 
> How can you read or write anything, when there's nothing to read or
> write?

Exactly, but the block layer (and I'd have to trace back through the
code to find the exact failure point) has a check somewhere in there
that checks the direction, and if it's a WRITE, checks data_len, and
fails if it is 0.

Note, my patch does not fix the case for the bug if I leave it as WRITE.
It only works when it is READ.

> > > > This patch fixes the WRITE vs READ issue, and also sends the extra two
> > > > commands. Anyone with an iPod connected via USB (not sure about firewire)
> > > > should be able to reproduce this issue, and verify the patch.
> > > 
> > > The bug was in the SCSI layer, and James already has the fix integrated
> > > for that. It really should make 2.6.15, James are you sending it upwards
> > > for that?
> > 
> > Can you point me to this fix? Also, does the "fix" fix the case for IDE
> > CDROM's too?
> 
> What is the problem case for for ide-cd?

Yes, I know these patches. I was in the Cc when they were all being
discussed. It's has nothing to do with my patch. It's the commands that
are required. It's not about the bug in the SCSI layer.

> The SCSI fix is here:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a8c730e85e80734412f4f73ab28496a0e8b04a7b
> 
> and followed up by a fix for James to cater to all paths:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c9526497cf03ee775c3a6f8ba62335735f98de7a
> 
> > > >  		case CDROMEJECT:
> > > > -			rq = blk_get_request(q, WRITE, __GFP_WAIT);
> > > > -			rq->flags |= REQ_BLOCK_PC;
> > > > -			rq->data = NULL;
> > > > -			rq->data_len = 0;
> > > > -			rq->timeout = BLK_DEFAULT_TIMEOUT;
> > > > -			memset(rq->cmd, 0, sizeof(rq->cmd));
> > > > -			rq->cmd[0] = GPCMD_START_STOP_UNIT;
> > > > -			rq->cmd[4] = 0x02 + (close != 0);
> > > > -			rq->cmd_len = 6;
> > > > -			err = blk_execute_rq(q, bd_disk, rq, 0);
> > > > -			blk_put_request(rq);
> > > > +			err = 0;
> > > > +
> > > > +			err |= blk_send_allow_medium_removal(q, bd_disk);
> > > > +			err |= blk_send_start_stop(q, bd_disk, 0x01);
> > > > +			err |= blk_send_start_stop(q, bd_disk, 0x02);
> > > 
> > > Do this in the eject tool, if it's required for some devices.
> > 
> > It already is in eject tool, but as described, that requires root
> > access. Not something I want to force a user to do in order to eject
> > their CDROM/iPod/USBStick in gnome. What exactly is wrong with the
> > commands? If they are harmless for devices that don't need it, and fix a
> > huge number of problems (did you see the Cc list on the bug report?) for
> > users with affected devices, then what's the harm?
> 
> So the medium removal command does require write permission on the
> deviec, but it doesn't require root. If they need to rw to the device
> fs, surely they need write permissions on the device in the first place?

bcollins@colorless:~$ id -a
uid=1000(bcollins) gid=1000(bcollins)
groups=4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),104(lpadmin),105(scanner),106(admin),1000(bcollins)
bcollins@colorless:~$ ls -l /dev/hdc
brw-rw---- 1 root plugdev 22, 0 Dec 19  2005 /dev/hdc
bcollins@colorless:~$ eject -s /dev/hdc
eject: unable to eject, last error: Operation not permitted
bcollins@colorless:~$ eject -r /dev/hdc
bcollins@colorless:~$

Write permissions is not enough.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

