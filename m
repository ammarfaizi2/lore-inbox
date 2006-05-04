Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWEDQoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWEDQoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWEDQoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:44:19 -0400
Received: from animx.eu.org ([216.98.75.249]:43467 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1030216AbWEDQoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:44:19 -0400
Date: Thu, 4 May 2006 12:50:55 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
Message-ID: <20060504165055.GA22880@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <200605041232.k44CWnFn004411@wildsau.enemy.org> <1146750532.20677.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146750532.20677.38.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-05-04 at 14:32 +0200, Herbert Rosmanith wrote:
> > I've been experimenting with damaged CDs this day. I observed that
> > a dirty or (partly) unreadable CD will (1) block the process which is
> > trying to read from the CD - it will be in state "D" - uninterruptible
> > sleep and (2) sometimes(?) probably freeze your system such that even
> > a manual reboot wont work (e.g., because it's not possible to log in, or
> > keystrokes are no longer accepted) and a power-cycle is required.
> 
> This is a known problem with the old IDE layer. There are several
> problems involved
> 
> 1. The old IDE layer reset confuses some drives fatally
> 2. The DMA recovery tricks it does break the state machine of some
> controllers and hang them for good
> 3. The error recovery and timer code races and can hang
> 4. The speed change paths used on DMA fail change down race everything
> 
> > please tell me a way to savely
> > (1) reset the IDE interface, e.g via IDE-TASKFILE (or, for testing,
> >     a sequence of outb() to the chip)
> > (2) reset the CD-drive - sending a WIN_DEVICE_RESET (linux/hdreg.h line 196)
> >     doesnt seem to be enough.
> 
> Please try the libata PATA patches instead of the old IDE layer.

I have noticed a problem which I believe is in sr_mod.  Doesn't matter if
the physical connection is ide, scsi, usb, etc.

If I access a drive that is not ready (ie, no disc, or in the process of
loading in a disc), the drive will no longer function properly.

I'm not sure if I can explain it fully, and I'm not sure if it's already
been reported.

I place a CD on the tray and do a mount.  Mount will fail (lets just assume
that under 2.4.x this worked).  I eject the cd and reinsert and wait for it
to become ready.  Mount will still fail.  Last I recall getblks ioctl
returns 2 or 4 in this case.  The only way to fix is to rmmod sr_mod and
reinsert sr_mod.

another example would be that I insert a disc, say with 159000 sectors and
I'm able to read from it just fine.  I make the above mistake but I insert a
disc with 200,000 sectors.  The disc will be reported with 159000 instead of
the correct 200,000 sectors and some files will not be readable.  Again,
rmmod and modprobe sr_mod fixes the problem.

I've been able to reproduce this on every linux system running 2.6 that I've
used with a CDRom.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
