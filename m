Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWFUT4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWFUT4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWFUT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:56:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38666 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030233AbWFUT4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:56:16 -0400
Date: Wed, 21 Jun 2006 15:56:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: andi@lisas.de
cc: Bodo Eggert <7eggert@gmx.de>, Andrew Morton <akpm@osdl.org>,
       <linux-usb-devel@lists.sourceforge.net>, <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, <hal@lists.freedesktop.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <20060621191640.GA8596@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.44L0.0606211550040.8478-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andreas Mohr wrote:

> > It's not a USB issue; it's a matter of lack of coordination between the sg 
> > and sr drivers.  Each is unaware of the actions of the other, even when 
> > they are speaking to the same device.
> 
> Right, I could have expressed it much better before, sorry.
> 
> Found the relevant code:
> sd.c sd_open()
> 
>         if (!sdkp->openers++ && sdev->removable) {
>                 if (scsi_block_when_processing_errors(sdev))
>                         scsi_set_medium_removal(sdev, SCSI_REMOVAL_PREVENT);
>         }

Um, this isn't the relevant code.  You're interested in sr.c, not sd.c.  
Furthermore, the actual ALLOW MEDIUM REMOVAL command is caused by code in 
drivers/cdrom/cdrom.c:cdrom_release().  This needs to be coordinated (the 
cdi->use_count variable) with the sg driver.

> And the obvious question would be whether the sdkp->openers++ thingy
> could somehow be extended to enclose all hardware device users so that
> e.g. sr.c wouldn't send ALLOW_MEDIUM_REMOVAL on a device already locked
> by e.g. the sd.c driver.
> Difficult question, though, since the group of drivers possible to use
> with a certain device is not a static set:
> it could be via
> - sr.c
> - sd.c
> - IDE (in the case of ATA devices mapped via ide-scsi)
> - ???
> 
> Is it possible to have such a per-*hardware*-device instance in the kernel
> to keep track of various things such as number of device openers?
> I'll do some investigation myself, too...

Look at include/scsi/scsi_device.h.  There's plenty of opportunity for 
adding an additional counter.

Alan Stern

