Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVAHMp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVAHMp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 07:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVAHMp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 07:45:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64269 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261876AbVAHMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 07:45:48 -0500
Date: Sat, 8 Jan 2005 12:45:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Andries Brouwer <aebr@win.tue.nl>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Al Viro <viro@ftp.uk.linux.org>,
       Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20050108124538.B11515@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk> <41D4253D.8070006@drzeus.cx> <20050107123947.B23665@flint.arm.linux.org.uk> <20050107140035.GA5920@pclin040.win.tue.nl> <20050108110957.D7065@flint.arm.linux.org.uk> <20050108120517.GA27414@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050108120517.GA27414@infradead.org>; from hch@infradead.org on Sat, Jan 08, 2005 at 12:05:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:05:17PM +0000, Christoph Hellwig wrote:
> On Sat, Jan 08, 2005 at 11:09:57AM +0000, Russell King wrote:
> > Your point 2 isn't user space though.
> > 
> > Also, it's buggy.  Consider a SCSI PCMCIA card with SCSI disks attached.
> > When you eject that card, your SCSI disks disappear, yet they aren't
> > marked as removable.  If user space is relying on /sys/block/*/removable
> > to tell it if things may go away, then user space is buggy.
> 
> It means removable media.  The actual device can disappear for just about
> any driver these days, considering pci hotplug or PCMCIA or usb or..
> 
> > Maybe it's for devices which may be present (eg, floppy driver), but
> > which have removable media (eg, floppy disk), rather than removable
> > devices?
> 
> Yes.  Else there would be very little driver that don't set the flag.

Ok.  So the requirement is:

(a) removable media with permanent block devices should set this flag.
(b) removable block devices with permanent media should not set this flag.

MMC is definitely case (b) - the block device is created and destroyed
when the card is inserted and removed, since the block device corresponds
to the controller on the card rather than the MMC host adapter.  The
media is permanently attached to the on-board controller.

Therefore, it would be incorrect for the MMC block device driver to set
the "removable" flag.

I guess we now find out how many user applications incorrectly interpret
this flag as meaning "this device may be user removable".

Maybe this needs documenting in Documentation/block so that everyone
knows what this flag is supposed to represent ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
