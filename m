Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTEZSyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTEZSyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:54:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4815 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262138AbTEZSyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:54:03 -0400
Date: Mon, 26 May 2003 21:07:07 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526190707.GM845@suse.de>
References: <1053972773.2298.177.camel@mulgrave> <20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053974830.1768.190.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, James Bottomley wrote:
> On Mon, 2003-05-26 at 14:18, Jens Axboe wrote:
> > > 1. Unified SG segment allocation.  The SCSI layer currently has a
> > > mempool implementation to cope with this, is there a reason it can't
> > > become block generic?
> > 
> > Of course that is doable, when I killed scsi_dma.c it was just a direct
> > replacement. Given that IDE had no such dynamic sg list allocation
> > requirements, it stayed in SCSI. Overdesign is never good :)
> 
> I agree with the sentiment.  I just don't think variable size SG tables
> will remain the exclusive province of SCSI forever.

Agree, until that becomes a problem I don't see a reason to rip it out
of SCSI.

> > > b. the host adapter is out of resources for *all* its devices.  Block
> > > all device queues until we free some resources (again, usually a
> > > returning command).
> > 
> > This is harder, because it involves more than one specific queue.
> 
> Yes, this is our nastycase, especially for locking and ref
> counting...you didn't say I only had to hand off the easy problems,
> though...

:)

I really think this should be handled in the SCSI layer. You are dealing
with devices hanging off a hardware unit of some sort.

It's also possible to go too far with this whole abstraction deal. The
resulting code ends up being contorted, instead of having to separate
'straight forward' cases in SCSI and XYZ (for instance).

> Hotpluggin has to have some awareness of this locality too.  Even for
> IDE, hot unplug a card and you can lose two devices per cable.

Hmmm yes. Now we are moving into general device management, though.

> > > 5. There needs to be some amalgam of the SCSI code for dynamic tag
> > > command queue depth handling.
> > 
> > Again, block layer queueing was designed for what I needed (ide tcq) and
> > no overdesign was attempted. If you describe what you need, I'd be very
> > happy to oblige and add those bits. Some decent depth change handling, I
> > presume?
> 
> Pretty much yes, now.  We lost all of our memory allocation nightmare
> problems when we moved away from fixed command queues per device to lazy
> command allocation using slabs.

Alright, so what do you need? Start out with X tags, shrink to Y (based
on repeated queue full conditions)? Anything else?

-- 
Jens Axboe

