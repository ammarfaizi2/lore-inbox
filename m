Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVEXTkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVEXTkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 15:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVEXTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 15:40:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44966 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261962AbVEXTkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 15:40:18 -0400
Date: Tue, 24 May 2005 14:39:30 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ioc4: Driver rework
In-Reply-To: <429289C6.9080707@pobox.com>
Message-ID: <20050524135944.D80608@chenjesu.americas.sgi.com>
References: <20050523192157.V75588@chenjesu.americas.sgi.com>
 <429289C6.9080707@pobox.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Jeff Garzik wrote:

> Brent Casavant wrote:
> > - The IOC4 chip implements multiple functions (serial, IDE, others not
> >   yet implemented in the mainline kernel) but is not a multifunction
> >   PCI device.  In order to properly handle device addition and removal
> >   as well as module insertion and deletion, an intermediary IOC4-specific
> >   driver layer is needed to handle these operations cleanly.
> 
> I disagree that a layer is needed.
> 
> Just write a PCI driver that does the following in probe:
> 
> 	register IDE
> 	register serial
> 	...
> 
> and undoes all that in remove.

Robin Holt just stopped by my office and clued me in to something I
may not have made clear, and which may be why you disagree with me.

The IOC4 hardware is very strange PCI-wise.  While it implements
what are a disparate set of features (IDE, serial ports, kbd/mouse,
etc), in PCI-speak IOC4 is not a multifunction device. That is, in
all ways it appears to the PCI infrastructure as a single device
(e.g.  a single shared interrupt for all these features, no subdevice
IDs for each independent feature, etc).

This complicates the driver model fairly significantly.  The PCI
infrastructure cannot natively deal with this situation because
multiple kernel modules cannot register themselves for the same
PCI subdevice because pci_device_probe_dynamic() will find only
the first match.  Consequently we cannot write free-standing drivers
for the seperate IOC4 features; actions that would normally be
invoked by a probe function must be handled by some sort of IOC4
core code which knows about the various IOC4 features, and how to
probe these features whenever the core code has its probe function
invoked.

(Yes, I suppose I could alter the PCI code to deal with this situation,
but considering the complications that may cause for less-weird devices,
it hardly seems like a good path to pursue.)

The main thrust of my code changes is to allow these logically
independent features of the IOC4 to be implemented as independent
(from eachother, not the core driver) kernel modules.  Rather than
the IOC4 core module having hard-coded knowledge of each feature of
the chip, it instead relies on the per-feature kernel modules to
register their comings and goings.

This provides a very useful level of flexibility, requiring neither
RAM nor disk space (which can be quite contended for install media
or initrd images) for unused features.  It certainly speeds up
driver debugging iterations.  And (personal opinion here), the
resulting code structure is cleaner than the existing code.

In some ways, you could conceptualize the IOC4 chip as a bus.  In
fact, I once toyed with the idea of implementing it as a new bus
type.  If you view it in those terms, the IOC4 core driver is
essentially a "PCI to IOC4 bridge" driver, and the IOC4 feature
drivers would be independent IOC4 devices.  However, IOC4 isn't
a bridge, and implementing it as a bus would be overkill. Thus
a simple core driver that allows feature registration and
deregistration seems a fitting solution.

Thoughts?

Thanks,
Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
