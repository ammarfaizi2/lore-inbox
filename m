Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVBJVcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVBJVcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBJVcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:32:32 -0500
Received: from peabody.ximian.com ([130.57.169.10]:52421 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261462AbVBJVc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:32:27 -0500
Subject: Re: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>
Cc: rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050210181255.GC8683@kroah.com>
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <20050210084113.GZ32727@kroah.com>
	 <1108055918.3423.23.camel@localhost.localdomain>
	 <20050210181255.GC8683@kroah.com>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 16:26:53 -0500
Message-Id: <1108070814.3423.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 10:12 -0800, Greg KH wrote:
> On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> > On Thu, 2005-02-10 at 00:41 -0800, Greg KH wrote:
> > > On Fri, Jan 28, 2005 at 05:30:04PM -0500, Adam Belay wrote:
> > > > Hi,
> > > > 
> > > > This patch adds initial support for driver matching priorities to the
> > > > driver model.  It is needed for my work on converting the pci bridge
> > > > driver to use "struct device_driver".  It may also be helpful for driver
> > > > with more complex (or long id lists as I've seen in many cases) matching
> > > > criteria. 
> > > > 
> > > > "match" has been added to "struct device_driver".  There are now two
> > > > steps in the matching process.  The first step is a bus specific filter
> > > > that determines possible driver candidates.  The second step is a driver
> > > > specific match function that verifies if the driver will work with the
> > > > hardware, and returns a priority code (how well it is able to handle the
> > > > device).  The bus layer could override the driver's match function if
> > > > necessary (similar to how it passes *probe through it's layer and then
> > > > on to the actual driver).
> > > > 
> > > > The current priorities are as follows:
> > > > 
> > > > enum {
> > > > 	MATCH_PRIORITY_FAILURE = 0,
> > > > 	MATCH_PRIORITY_GENERIC,
> > > > 	MATCH_PRIORITY_NORMAL,
> > > > 	MATCH_PRIORITY_VENDOR,
> > > > };
> > > > 
> > > > let me know if any of this would need to be changed.  For example, the
> > > > "struct bus_type" match function could return a priority code.
> > > > 
> > > > Of course this patch is not going to be effective alone.  We also need
> > > > to change the init order.  If a driver is registered early but isn't the
> > > > best available, it will be bound to the device prematurely.  This would
> > > > be a problem for carbus (yenta) bridges.
> > > > 
> > > > I think we may have to load all in kernel drivers first, and then begin
> > > > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > > > patch for that too.
> > > 
> > > I think the issue that Al raises about drivers grabbing devices, and
> > > then trying to unbind them might be a real problem.
> > 
> > I agree.  Do you think registering every in-kernel driver before probing
> > hardware would solve this problem?
> 
> This doesn't work for any vendor kernel as they build all drivers as
> modules :(

True, but if we allowed userspace to control specifically which drivers
are bound to which devices, then we will be able to ensure the best
driver is bound.  The only problem is that modules then shouldn't
automatically bind to devices.

For non-modules, as many core drivers currently are (ex. pci bus) we can
often do the right thing using the above suggestion.

I think we can't avoid this inherent flaw in modules if we don't have a
user-space mechanism to control driver binding.  Our current approach
doesn't work because it's indirect.  Adding a device ID doesn't
specifically ensure the device in question will be bound to the correct
driver.

Thanks,
Adam


