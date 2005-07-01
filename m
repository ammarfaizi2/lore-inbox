Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVGAVfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVGAVfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVGAVdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:33:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:11140 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261593AbVGAVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:31:29 -0400
Date: Fri, 1 Jul 2005 14:31:09 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] PCI: clean up the dynamic pci id logic
Message-ID: <20050701213109.GA1834@kroah.com>
References: <20050630091812.GA25285@kroah.com> <20050701195232.GB3742@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701195232.GB3742@neo.rr.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 03:52:32PM -0400, Adam Belay wrote:
> I was wondering why we need dynamic id support in the driver core.  Is there
> an issue where the bind/unbind mechanism requires this feature?  I was hoping
> bind/unbind would replace it.

No, bind/unbind (well bind, unbind doesn't care) only will work if the
driver's probe function can accept the device.  Without dynamic ids,
it's not possible to have a driver bind to a device that it does not
know about.

I want to put the sysfs file, and a common callback in the driver core,
to make it easier for busses to support dynamic ids.  That's why I am
suggesting we add it there.  But I'll play with implementing it and see
if it's really worth it or not.

Either way, this patch fixes up the pci code to make the dynamic ids for
it, much more readable and smaller.

> I understand that there are PCI drivers that use .driver_data and read from
> their ID table (e.g. pci_serial), but we don't really want the user modifying
> these IDs because they're often attached to some device specific tables.

True, if you look at the current pci dynamic id stuff, we don't set the
driver_data field at all.  Some USB drivers use this field too.

> It was my understanding that the *probe function should be responsible for
> accepting any device, and then gracefully fail if it knows it will be unable
> to support it.  For some drivers this could include failing if it's missing
> from the ID table.

For this to happen, we would have to rewrite all drivers :(  Right now
they assume that the MODULE_TABLE must have matched, in order for the
probe() call to be called.  

Remember, probe() of most busses pass in a valid id structure too...

> If the driver developer requires the driver to match to an unknown
> pool of devices, then the *probe function could be made more advanced.

If the bus/driver core supports dynamic ids, then the individual drivers
don't have to be changed at all :)

thanks,

greg k-h
