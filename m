Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTFPQz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 12:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFPQz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 12:55:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56192 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263980AbTFPQzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 12:55:25 -0400
Date: Mon, 16 Jun 2003 10:08:26 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030616170825.GB24986@kroah.com>
References: <Pine.LNX.4.44L0.0306151221190.32270-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306151221190.32270-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 12:42:26PM -0400, Alan Stern wrote:
> If you're already aware of this, please forgive the intrusion.
> 
> There's a general problem in the driver model's implementation of 
> attribute files, in connection with loadable kernel modules.  The 
> sysfs_ops structure stores function pointers with no means for identifying 
> the module that contains the corresponding code.  As a result, it's 
> possible to call through one of these pointers even after the module has 
> been unloaded, causing an oops.

That's why CONFIG_MODULE_UNLOAD is a new option, if you don't want to
take the risk, don't enable it :)

> It's not hard to provoke this sort of situation.  A user process can
> open a sysfs device file, for instance, and delay trying to read it until 
> the module containing the device driver has been removed.  When the read 
> does occur, it runs into trouble.

Then don't let your module unload until _all_ instances of your
structures are gone.  You can tell if this is true or not, it's just up
to the implementor :)

Look at the new pcmcia code for just such an example.

If this is in regards to the scsi usage of sysfs, I've been talking to
Mike Anderson a lot about this recently.  People are having to realize a
few new things with regards to kernel programming that previously they
have not had to worry about:
  - in the past, the only thing that could ever go away while a kernel
    was running was a module.  So people worried about module reference
    counts, and hence the /proc useage of module counts.
  - With the advent of hotplug devices, we now have to worry about
    individual devices going away, not so much modules.  This is causing
    layers like the scsi one to be changed a lot to accommodate this
    (any pci scsi device can be removed at any time thanks to pci
    hotplug systems, and the scsi layer can't really handle this very
    well at all until very recently.)

So, the driver model helps out with handling the fact that devices can
go away at any time a lot easier than anything we've had before.  It's
now up to the individual kernel modules to control their own module
reference counts to handle if they want to be able to be unloaded before
all of their references are gone now or not.

Look at the usb hid drivers, they _never_ set their reference count :)

Hope this helps,

greg k-h
