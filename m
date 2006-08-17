Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWHQMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWHQMEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHQMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:04:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:12433 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751018AbWHQMEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:04:43 -0400
Date: Thu, 17 Aug 2006 04:58:53 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Multiprobe sanitizer
Message-ID: <20060817115853.GB6843@kroah.com>
References: <1155746538.24077.371.camel@localhost.localdomain> <20060816222633.GA6829@kroah.com> <1155774994.15195.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155774994.15195.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 01:36:33AM +0100, Alan Cox wrote:
> Ar Mer, 2006-08-16 am 15:26 -0700, ysgrifennodd Greg KH:
> > What would this help out with?  Would the PCI layer (for example) handle
> > this "notify the core that it can continue" type logic?  Or would the
> > individual drivers need to be able to control it?
> > 
> > I'm guessing that you are thinking of this in relation to the disk
> > drivers, have you found cases where something like this is necessary due
> > to hardware constraints?
> 
> Actually it occurs everywhere because what happens is
> 
> 	PCI enumerates in bus order
> 	Threads *usually* run in bus order
> 
> so every n'th boot your devices re-order themselves out of bus order,
> and eth1 becomes eth0 for the day.

As per the help information for this option, this will happen.  Happens
all the time on my machines already, that's why I use a tool that always
names the devices in the proper way (like almost all distros do these
days.)

It's a trade off, if you want a parallel device probe, you have to stop
relying on the kernel name for devices and use something that is not
going to change.  Like PCI device ids, (well, ok, they change all the time
on pci hotplug boxes and bios upgrades) or MAC addresses, or serial
numbers, or file system labels.

> If you have a "ok now continue scanning" API then we can do
> 
> 	Grab resources
> 	Register driver
> 	Go parallel
> 	[Slow stuff]

It seems that for some types of devices, the "Grab resources" portion
takes the longest (SCSI...).  And the "register driver" stuff already
happens later in the process, in an async manner today.  So that's not
going to work :(

> I was thinking if we set multithread = 2 (and define some constants)
> then the core code would do
> 
> 	if (multithread == WAIT)
> 		down(&drv->wait);
> 
> 
> and we'd have
> 
> 	pci_driver_continue_enumerating(struct pci_driver *drv) {
> 		up(&drv->wait);
> 	}

Yeah, I played with limiting the number of outstanding threads in a
manner like this, but couldn't come up with a real reason to limit it.

If you can think of a place in the PCI core that we could block on in
this manner, please let me know.

thanks,

greg k-h
