Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTEZSeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTEZSeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:34:02 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:39684 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262031AbTEZSeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:34:00 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030526181852.GL845@suse.de>
References: <1053972773.2298.177.camel@mulgrave> 
	<20030526181852.GL845@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 May 2003 14:47:08 -0400
Message-Id: <1053974830.1768.190.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 14:18, Jens Axboe wrote:
> > 1. Unified SG segment allocation.  The SCSI layer currently has a
> > mempool implementation to cope with this, is there a reason it can't
> > become block generic?
> 
> Of course that is doable, when I killed scsi_dma.c it was just a direct
> replacement. Given that IDE had no such dynamic sg list allocation
> requirements, it stayed in SCSI. Overdesign is never good :)

I agree with the sentiment.  I just don't think variable size SG tables
will remain the exclusive province of SCSI forever.

> > b. the host adapter is out of resources for *all* its devices.  Block
> > all device queues until we free some resources (again, usually a
> > returning command).
> 
> This is harder, because it involves more than one specific queue.

Yes, this is our nastycase, especially for locking and ref
counting...you didn't say I only had to hand off the easy problems,
though...

Hotpluggin has to have some awareness of this locality too.  Even for
IDE, hot unplug a card and you can lose two devices per cable.

> > 5. There needs to be some amalgam of the SCSI code for dynamic tag
> > command queue depth handling.
> 
> Again, block layer queueing was designed for what I needed (ide tcq) and
> no overdesign was attempted. If you describe what you need, I'd be very
> happy to oblige and add those bits. Some decent depth change handling, I
> presume?

Pretty much yes, now.  We lost all of our memory allocation nightmare
problems when we moved away from fixed command queues per device to lazy
command allocation using slabs.

James


