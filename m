Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbVGAXo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbVGAXo4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVGAXom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:44:42 -0400
Received: from cpe-24-93-204-161.neo.res.rr.com ([24.93.204.161]:22411 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261638AbVGAXny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:43:54 -0400
Date: Fri, 1 Jul 2005 19:37:36 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] PCI: clean up the dynamic pci id logic
Message-ID: <20050701233736.GA8691@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Matt_Domsch@dell.com, linux-pci@atrey.karlin.mff.cuni.cz
References: <20050630091812.GA25285@kroah.com> <20050701195232.GB3742@neo.rr.com> <20050701213109.GA1834@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701213109.GA1834@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 02:31:09PM -0700, Greg KH wrote:
> On Fri, Jul 01, 2005 at 03:52:32PM -0400, Adam Belay wrote:
> > I was wondering why we need dynamic id support in the driver core.  Is there
> > an issue where the bind/unbind mechanism requires this feature?  I was hoping
> > bind/unbind would replace it.
> 
> No, bind/unbind (well bind, unbind doesn't care) only will work if the
> driver's probe function can accept the device.  Without dynamic ids,
> it's not possible to have a driver bind to a device that it does not
> know about.

This could be easily changed.  We would just have to make some tweaks to the
bus drivers.  See below...

> 
> I want to put the sysfs file, and a common callback in the driver core,
> to make it easier for busses to support dynamic ids.  That's why I am
> suggesting we add it there.  But I'll play with implementing it and see
> if it's really worth it or not.
> 
> Either way, this patch fixes up the pci code to make the dynamic ids for
> it, much more readable and smaller.

Yeah, agreed.

> 
> > I understand that there are PCI drivers that use .driver_data and read from
> > their ID table (e.g. pci_serial), but we don't really want the user modifying
> > these IDs because they're often attached to some device specific tables.
> 
> True, if you look at the current pci dynamic id stuff, we don't set the
> driver_data field at all.  Some USB drivers use this field too.

Personally, I'd like to remove .driver_data in favor of internal driver
heuristics (possibly with some <insert bus here> helper functions).  The
only driver I've ever seen that wouldn't have completely trivial breakage
is "serial-pci".

The right way to fix this driver would be to have it bind to the PCI serial
class code.  It would then have an internal ID table with flags and
instructions for each device.  If the device isn't in the table, and
controlling it is not obvious, ->probe would fail.

> 
> > It was my understanding that the *probe function should be responsible for
> > accepting any device, and then gracefully fail if it knows it will be unable
> > to support it.  For some drivers this could include failing if it's missing
> > from the ID table.
> 
> For this to happen, we would have to rewrite all drivers :(  Right now
> they assume that the MODULE_TABLE must have matched, in order for the
> probe() call to be called.  
> 
> Remember, probe() of most busses pass in a valid id structure too...

Yes, but the vast majority (though not all) of driver-level probe functions
completely ignore it.  We could fix drivers that need it to handle a null ID
structure.  Most of these drivers are not going to be able to handle an
unknown target device anyway, so they could just fail if there isn't an ID.

> 
> > If the driver developer requires the driver to match to an unknown
> > pool of devices, then the *probe function could be made more advanced.
> 
> If the bus/driver core supports dynamic ids, then the individual drivers
> don't have to be changed at all :)

I understand.  I'm just trying to avoid some extra complexity, code, and
memory usage.  I'd like to have a more direct approach :)

Thanks,
Adam

P.S.: One final thought, the bus driver could create a new ID ( based on
available identification data) on the fly when a driver is bound to the
device.


Also, don't we need a way to turn off automatic driver binding?  The end
user might want to select a specific driver for a device.  Removing the
automatically bound driver every time is a bit ugly (and probably sometimes
impossible depending on the bus/hardware).
