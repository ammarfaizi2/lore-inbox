Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWFIONv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWFIONv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWFIONv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:13:51 -0400
Received: from mx2.rowland.org ([192.131.102.7]:31248 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S965192AbWFIONu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:13:50 -0400
Date: Fri, 9 Jun 2006 10:13:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/3] SCSI core and sd: early detection of medium not
 present
In-Reply-To: <1149814666.3276.16.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.44L0.0606091007370.16847-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, James Bottomley wrote:

> On Tue, 2006-06-06 at 11:31 -0400, Alan Stern wrote:
> > This patch (as695) changes the scsi_test_unit_ready() routine in the
> > SCSI 
> > core to set a new flag when no medium is present.  The sd driver is 
> > changed to use this new flag for reporting -ENOMEDIUM in from the 
> > sd_media_changed method.
> 
> This would appear to be duplicating the struct scsi_disk media_present
> flag.

Correct, although the semantics of the two flags aren't exactly the same.

>  Moving the media_present flag from scsi_disk to scsi_device may
> make a bit of sense long term ... however, there's also dupication with
> the sr driver and the cdrom layer now (that stores media change at the
> cdrom level), so is there an argument why it's better in scsi_device
> than scsi_disk?

I did it that way in the patch because it was the only simple choice.  The 
scsi_test_unit_ready() routine is part of the SCSI core and can be called 
for devices that aren't disks.  Hence any flag it sets cannot be part of 
the scsi_disk structure.

In principle the information could be conveyed in the return value from 
scsi_test_unit_ready() rather than in a static flag.  But the routine has 
several callers and I didn't want to change all of them to recognize a 
-ENOMEDIUM return code.  Now in the long run, perhaps that would be a good 
thing to do.  Or perhaps moving the flag to scsi_device would be better, I 
don't know...

Ultimately this boils down to how you want to represent "No medium 
present" in the SCSI core.  What do you think is the bets way?

Alan Stern

