Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbTFSVAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbTFSVAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:00:48 -0400
Received: from ida.rowland.org ([192.131.102.52]:1284 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265938AbTFSVAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:00:44 -0400
Date: Thu, 19 Jun 2003 17:14:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, <viro@parcelfarce.linux.theplanet.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       Mike Anderson <andmike@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44.0306190946440.955-100000@cherise>
Message-ID: <Pine.LNX.4.44L0.0306191433140.1445-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003, Patrick Mochel wrote:

> SCSI copied USB in this respect. I've always been skeptical about the
> representation, though Greg had good reason to initially do this. I wonder 
> if that object could be moved over /sys/class/usb-host/ these days.. 

I wonder about the apparent proliferation of entries under /sys/class/.  
If people continue to add things like /sys/class/usb-storage/ right at the
top level, won't it become rather unwieldy?  What would be a good place to
put something like that?

----

> Well, what does the object represent? A per-device driver-specific object? 
> Is it really a separate object, or does it have a SCSI host object 
> embedded in it? Usually, from what I've seen, if there is a per-device 
> driver-specific object, it contains an embedded (class) object. This 
> object is what the driver registers with the infrastructure for that 
> device type.
> 
> That embedded structure should contain an embedded struct class_device, 
> which is registered with the class (when the driver registers it's 
> object). That gives it presence under /sys/class/whatever/
> 
> It also gives the driver an object that it owns, via embedding, which it 
> is free to export attributes for.

On Thu, 19 Jun 2003, Mike Anderson wrote:

> Actually host1 is created by the aic7xxx driver through registration
> with the SCSI subsystem. The aic7xxx allocates the structure, registers
> it, unregisters it, and drops the ref on it when it is done with it.

[Two different replies to related questions of mine.]

This makes sense.  But it doesn't match my experience working with the 
SCSI core.  (That experience is connected with usb-storage, not aic7xxx.)

When a host driver registers a newly-detected host adapter with the core,
it doesn't provide a structure representing that adapter.  It provides a
Scsi Host Template, but that's not the same thing.  Instead, the core
creates a struct Scsi_Host on the driver's behalf.  Embedded in it is a
struct device, which is registered under /sys/devices/, and a struct
class_device, which is registered under /sys/class/scsi_host/.  The driver
doesn't own these structures; the SCSI core does.

Furthermore, there is no release() for the embedded struct class_device,
so there's no way for the driver to know when it goes away.  (That lack is
liable to cause a problem at some point.  I noticed that until very
recently there was no release() method for struct class_device at all.)  
There _is_ a release notification for the overall struct Scsi_Host in
scsi_remove_host(), but it occurs at the wrong time.  It is called right
after the embedded struct device has been deregistered, not when its
reference count drops to 0.

So what Mike says the SCSI core does, and what Pat says it ought to do, 
isn't what actually happens.  Is this simply an indication that the work 
of completing the SCSI code to the driver model isn't yet complete?  It 
seems as though a very large change would be needed to make things work as 
Pat described.

In the meantime, where should I register my class device for the 
usb-storage driver?  Should it go in 
/sys/class/scsi_host/host1/usb-storage/, under the existing class device?  
That might be simplest.  Or should there be a new class just for it?

Alan Stern


