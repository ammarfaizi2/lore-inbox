Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317835AbSFMV0v>; Thu, 13 Jun 2002 17:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317839AbSFMV0u>; Thu, 13 Jun 2002 17:26:50 -0400
Received: from host194.steeleye.com ([216.33.1.194]:58642 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317837AbSFMV0r>; Thu, 13 Jun 2002 17:26:47 -0400
Message-Id: <200206132126.g5DLQiQ24889@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3) 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Thu, 13 Jun 2002 17:01:41 EDT." <20020613170141.B4609@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 17:26:44 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 10:46:44PM -0400, James Bottomley wrote:
> 2) The SCSI queue will stall if it gets an untagged request in the stream, so 
> once tagged queueing is enabled, all commands (including SPECIALS) must be 
> tagged.  I altered the check in blk_queue_start_tag to permit this.

dledford@redhat.com said:
> Hmmm...this seems broken to me.  Switching from tagged to untagged
> momentarily and then back is perfectly valid.  Can the bio layer
> handle this and not the scsi layer, or are both layers unable to
> handle  this sort of tag manipulation?  

The layers can cope with the switch easily enough.  The problem is that to 
send an untagged command to a SCSI device you have to wait for the outstanding 
tags to clear which is what causes the stall.  The scsi mid-layer queue push 
back system pushes all commands back to the BIO layer marked as REQ_SPECIAL 
(because the upper layer drivers generate the commands and it has no idea what 
they are supposed to be doing) if the driver cannot handle them.  This means 
for those drivers (like the new adaptec) which load up the device until it 
returns a queue full (thus causing push back into the bio layer) we'd get 
stutter in the command pipeline.  The cleanest solution is to allow (but not 
require) tagging of every request type.

On Mon, Jun 10, 2002 at 10:46:44PM -0400, James Bottomley wrote:
> There are several shortcomings of the prototype, most notably it doesn't have 
> tag starvation detection and processing.  However, I think I can re-introduce 
> this as part of the error handler functions.

dledford@redhat.com said:
> If you are using the bio layer tag processing, then it should be
> doing this part I would think.  If it isn't, then it sounds like
> either  it's design is missing some key elements required to be fully
> functional  or the integration between the scsi layer and the bio
> layer needs some  additional work. 

I thought about doing this.  The problem is that the blk layer doesn't have 
very good instrumentation for detecting the condition.  The SCSI layer is the 
one that has per command timers and all the other necessaries so it can detect 
when a command should have returned and take corrective action.

James


