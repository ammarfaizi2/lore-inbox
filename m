Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVBJRYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVBJRYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBJRYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:24:50 -0500
Received: from peabody.ximian.com ([130.57.169.10]:65475 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262166AbVBJRYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:24:21 -0500
Subject: Re: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>
Cc: rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050210084113.GZ32727@kroah.com>
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <20050210084113.GZ32727@kroah.com>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 12:18:37 -0500
Message-Id: <1108055918.3423.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 00:41 -0800, Greg KH wrote:
> On Fri, Jan 28, 2005 at 05:30:04PM -0500, Adam Belay wrote:
> > Hi,
> > 
> > This patch adds initial support for driver matching priorities to the
> > driver model.  It is needed for my work on converting the pci bridge
> > driver to use "struct device_driver".  It may also be helpful for driver
> > with more complex (or long id lists as I've seen in many cases) matching
> > criteria. 
> > 
> > "match" has been added to "struct device_driver".  There are now two
> > steps in the matching process.  The first step is a bus specific filter
> > that determines possible driver candidates.  The second step is a driver
> > specific match function that verifies if the driver will work with the
> > hardware, and returns a priority code (how well it is able to handle the
> > device).  The bus layer could override the driver's match function if
> > necessary (similar to how it passes *probe through it's layer and then
> > on to the actual driver).
> > 
> > The current priorities are as follows:
> > 
> > enum {
> > 	MATCH_PRIORITY_FAILURE = 0,
> > 	MATCH_PRIORITY_GENERIC,
> > 	MATCH_PRIORITY_NORMAL,
> > 	MATCH_PRIORITY_VENDOR,
> > };
> > 
> > let me know if any of this would need to be changed.  For example, the
> > "struct bus_type" match function could return a priority code.
> > 
> > Of course this patch is not going to be effective alone.  We also need
> > to change the init order.  If a driver is registered early but isn't the
> > best available, it will be bound to the device prematurely.  This would
> > be a problem for carbus (yenta) bridges.
> > 
> > I think we may have to load all in kernel drivers first, and then begin
> > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > patch for that too.
> 
> I think the issue that Al raises about drivers grabbing devices, and
> then trying to unbind them might be a real problem.

I agree.  Do you think registering every in-kernel driver before probing
hardware would solve this problem?

> 
> Also, why can't this just be done in the bus specific code, in the match
> function?  I don't see how putting this into the driver core helps out
> any.

The match priority is a chararistic of the driver and how it's
implemented rather than the bus's matching mechanism.  The type of match
doesn't necessarily reflect the driver's ability to control the hardware
(ex. a driver could match on a specific PCI id but only provide generic
support for the device).

Also, I think this is a feature that would be useful for all of the
buses.  Therefore, it would seem implementing it in the driver core
might result in the least code duplication.

The second "*match" function in "struct device_driver" gives the driver
a chance to evaluate it's ability of controlling the device and solves a
few problems with the current implementation.  (ex. it's not possible to
detect ISA Modems with only a list of PnP IDs, and some PCI devices
support a pool of IDs that is too large to put in an ID table).

Thanks,
Adam


