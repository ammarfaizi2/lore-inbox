Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbULPE6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbULPE6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbULPE6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:58:43 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:49361 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261821AbULPE6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:58:37 -0500
Date: Wed, 15 Dec 2004 23:57:41 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rml@ximian.com, mochel@digitalimplant.org,
       len.brown@intel.com, shaohua.li@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Device Resource Management
Message-ID: <20041216045740.GE2661@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, rml@ximian.com,
	mochel@digitalimplant.org, len.brown@intel.com, shaohua.li@intel.com,
	Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <20041211054509.GA2661@neo.rr.com> <20041216041405.GA23223@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216041405.GA23223@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 08:14:05PM -0800, Greg KH wrote:
> On Sat, Dec 11, 2004 at 12:45:09AM -0500, Adam Belay wrote:
> > 
> > Hi All,
> > 
> > This patch is a draft for the core infustructure of driver model based
> > resource management.  Buses capable of dynamically allocating resources (such
> > as PCI or pcmcia), and recent developments with linux ACPI support have
> > incited the need for the kernel to keep track of system resources, and assist
> > in the allocation process.  Eventually I'd like to move on to more complex
> > problems like resource rebalancing.  This patch simply lays out some
> > foundation.
> > 
> > We currently have some infustructure, but it is more or less incomplete.  For
> > example, it doesn't show how resources and the devices that consume them are
> > related.  Also it isn't flexable enough to track all types of bus resources.
> > ACPI, PnP, and PCI have to allocate interrupts somewhat blindly because
> > request_irq happens too late in the game, and really is used to register
> > interrupt handlers, not track interrupt usage.
> 
> But the interrupts are assigned early in the process, right?  We still
> need to do that.

Yes, interrupts are usually assigned much earlier than they are serviced by
device drivers. 

> 
> > My implementation is not based on the existing "struct resource" stuff because
> > quite frankly, even making small changes would break a large number of
> > drivers.  Instead it uses "struct iores"  My hope is that we can gradually
> > phase the old implementation out.
> 
> Ah, what's wrong with a little breakage :)

I can work with that approach too :)  I was just concerned with some of the
not so testable legacy drivers.

> 
> > With that in mind, I'd like to work out a solid new API, and would appreciate
> > any comments or suggestions, both on the code in this patch and the overall
> > design of the API.
> > 
> > A few issues need to be discussed.  The most important is probably how sysfs
> > will display resource usage?  "struct kobject" is actually larger then "struct
> > iores" so I don't feel very comfortable embedding it.  But, if a kobject based
> > sysfs resource tree would be needed, then I'd be happy to implement it.  If
> > not what would be a good alternative?  Does the user have to read resources
> > from each device like one would with this current patch?
> 
> Why would it matter if we export this info to userspace?  Do any
> userspace programs care about this information?

It depends if we want userspace to handle any resource management policy.
If it doesn't, then more complex PnP algorithms will have to be implemented
in kernel.  Userspace control is more important for old technology where
resource assignment can be less flexable.  Examples would include ISAPnP and
PCMCIA.  The majority of systems could probably get by without userspace
control if we are able to map out tricky things like the 10-bit decode VGA I/O
in kernel.

Pat suggested a resource tree in sysfs with each item in the tree linking back
to the device that consumes it.  Kobject size, and strange locking/lifetime
challenges would be the major disadvantages.  Also a method for making the
actual assignments would have to be worked out.

Another reason userspace would care about this information is that it could be
really useful for debugging hardware problems.

> 
> > This patch was only tested for compilation so it may have a few bugs/typos.
> > Once again I'd really appreciate any comments or suggestions.
> 
> It looks good.  What's the main goals of this redesign (for those of us
> who are old and forgot what you said at the last kernel summit...)

Basically there are three goals:

1.) To solve the resource allocation problems we currently see with ACPI and
other bus/firmware technologies and fullfill their requirements.

2.) To integrate the tracking of bus resources into the driver model--  This
will allow us to more accurately track device dependencies.  Just like there
are power parents/domains in power management, there are resource producers in
resource management.  Also it should allow us to remove a bunch of duplicate 
code between bus drivers.

3.) To support resource rebalancing-- This will likely become necessary as PCI
express gains wider usage because it will allow for more complex PCI bridge
hierarchies.  A device could be paused, and it's resources could be adjusted
to accommodate a newly hotplugged device etc.

I appreciate the comments.

Thanks,
Adam
