Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317884AbSFMWKC>; Thu, 13 Jun 2002 18:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSFMWJ6>; Thu, 13 Jun 2002 18:09:58 -0400
Received: from host194.steeleye.com ([216.33.1.194]:26131 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317881AbSFMWJw>; Thu, 13 Jun 2002 18:09:52 -0400
Message-Id: <200206132209.g5DM9kF25073@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3) 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Thu, 13 Jun 2002 17:50:19 EDT." <20020613175019.A4515@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 18:09:46 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dledford@redhat.com said:
> This I'm not following.  If you get a QUEUE_FULL from the adaptec
> driver,  then the commands you are pushing back should still be tagged
> and no stall  should be required beyond just waiting for any
> outstanding command on the  drive to complete or for a timeout to
> pass.  It should not require any  untagged type stall where you have
> to drain the entire pipeline... 

Ah, but that was the problem in the blk generic tagging.  only requests of 
type REQ_CMD get tagged, so say the SD driver gets a block read request as a 
REQ_CMD, translates it into a SCSI READ, sends it through the mid-layer to the 
low layer driver which requests a block layer tag but eventually responds 
QUEUE_FULL.  Now the command gets pushed back to the blk queue head as a 
REQ_SPECIAL (and as part of the push back, we have to finish the tag since 
command moves from the tag queue to the blk queue), which to the scsi mid 
layer means request with already formulated SCSI command so don't go back 
through the upper layer driver again.  The problem is that when this command 
comes back again into the scsi mid layer for execution it would now do so as 
an untagged command because the blk_queue_start_tag() code will only tag 
REQ_CMD requests, and hence we get a queue stall every time the low level 
driver responds QUEUE_FULL.

This was the behaviour (in the blk layer) I was objecting to---on the second 
go around, we request a tag using blk_queue_start_tag() but get denied because 
the request isn't of the correct type---and why I think the 
blk_generic_start_tag() needs to allow REQ_SPECIAL requests to be tagged.

> I would think that, eventually, the bio layer will support I/O fencing
> via  tagged commands (aka, ext3 needs an I/O fence and the bio layer
> does as  needed to enforce that, which on scsi may mean an ordered
> queue tag is  generated instead of a regular tag and on IDE it may
> mean something else).   It will have to be able to tell that some of
> these conditions have been  satisfied in those cases, so I see no
> reason why it shouldn't be made  aware of them now.  Just my $.02 

I've actually already put this code into the mid layer patch (the 
scsi_populate_tag_msg() function in scsi.h) to generate an ordered tag for the 
case where the request is marked REQ_BARRIER.

James


