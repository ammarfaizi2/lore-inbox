Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317848AbSFMVuU>; Thu, 13 Jun 2002 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317846AbSFMVuT>; Thu, 13 Jun 2002 17:50:19 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6678 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317844AbSFMVuR>; Thu, 13 Jun 2002 17:50:17 -0400
Date: Thu, 13 Jun 2002 17:50:19 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3)
Message-ID: <20020613175019.A4515@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <dledford@redhat.com> <200206132126.g5DLQiQ24889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 05:26:44PM -0400, James Bottomley wrote:
> On Mon, Jun 10, 2002 at 10:46:44PM -0400, James Bottomley wrote:
> > 2) The SCSI queue will stall if it gets an untagged request in the stream, so 
> > once tagged queueing is enabled, all commands (including SPECIALS) must be 
> > tagged.  I altered the check in blk_queue_start_tag to permit this.
> 
> dledford@redhat.com said:
> > Hmmm...this seems broken to me.  Switching from tagged to untagged
> > momentarily and then back is perfectly valid.  Can the bio layer
> > handle this and not the scsi layer, or are both layers unable to
> > handle  this sort of tag manipulation?  
> 
> The layers can cope with the switch easily enough.  The problem is that to 
> send an untagged command to a SCSI device you have to wait for the outstanding 
> tags to clear which is what causes the stall.

Well, intentional behaviour is hardly what I would call a stall.  I 
thought you were implying that it would stall the queue indefinitely.  I'm 
fully aware that it forces the queue to wait until all outstanding 
commands have completed before sending the untagged command, that's part 
of the desired behaviour in that case.

>  The scsi mid-layer queue push 
> back system pushes all commands back to the BIO layer marked as REQ_SPECIAL 
> (because the upper layer drivers generate the commands and it has no idea what 
> they are supposed to be doing) if the driver cannot handle them.  This means 
> for those drivers (like the new adaptec) which load up the device until it 
> returns a queue full (thus causing push back into the bio layer) we'd get 
> stutter in the command pipeline.  The cleanest solution is to allow (but not 
> require) tagging of every request type.

This I'm not following.  If you get a QUEUE_FULL from the adaptec driver, 
then the commands you are pushing back should still be tagged and no stall 
should be required beyond just waiting for any outstanding command on the 
drive to complete or for a timeout to pass.  It should not require any 
untagged type stall where you have to drain the entire pipeline...

> I thought about doing this.  The problem is that the blk layer doesn't have 
> very good instrumentation for detecting the condition.  The SCSI layer is the 
> one that has per command timers and all the other necessaries so it can detect 
> when a command should have returned and take corrective action.

I would think that, eventually, the bio layer will support I/O fencing via 
tagged commands (aka, ext3 needs an I/O fence and the bio layer does as 
needed to enforce that, which on scsi may mean an ordered queue tag is 
generated instead of a regular tag and on IDE it may mean something else).  
It will have to be able to tell that some of these conditions have been 
satisfied in those cases, so I see no reason why it shouldn't be made 
aware of them now.  Just my $.02

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
