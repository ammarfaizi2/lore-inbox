Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTFPSwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFPSwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:52:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:54788 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263258AbTFPSwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:52:17 -0400
Date: Mon, 16 Jun 2003 15:06:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44.0306161133010.908-100000@cherise>
Message-ID: <Pine.LNX.4.44L0.0306161450510.1350-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm forced to agree with most of what you say.

On Mon, 16 Jun 2003, Patrick Mochel wrote:

> That's not the problem, only one possible solution. The problem is that 
> the driver does not own the object it's exporting the attribute for. 
> 
> The object who owns the attributes gets its refcount incremented when the 
> file is opened. If the module owns that object, it can take measures on 
> unload to wait for that reference count to reach 0. 

Yes.  This may delay the rmmod system call (make it wait until some other 
user process has closed the attribute file), but who cares about that?

> If a piece of code exports an attribute for an object that it does not 
> own, it must explicitly modify the reference count for that object. There 
> is no other way to be safe. 

Even that's not enough to be safe.  Modifying the reference count doesn't 
help because this isn't a problem of the object being deleted, it's a 
problem of a struct device_attributes being deleted -- and they don't have 
reference counts since they aren't objects.

> Note that by pinning the driver in memory when you create a sysfs file 
> that it owns will prevent the module from ever being unloaded. That is 
> possible, but not desirable. Note that that change would make your point 
> moot. :) 

Again I agree.  That was never my intention.  The change I originally
suggested would simply make device_remove_file() atomic with respect
to readers and writers of the attribute file:  It wouldn't return until
all current readers or writers had left the show()/store() routine, and
after it returned nobody would call show()/store().  I still don't see any 
reason not to implement something like this.

> Also, device_create_file() does not have a driver argument, because 
> drivers are not the only entities that may create files for a device. The 
> owning bus and the core itself may also use that call. Drivers are 
> probably the least qualified (most unsafe) entities to do so.

Most unsafe, perhaps.  But least qualified?  Who can possibly be more 
qualified to display the state or affect the functioning of a device than 
its driver?!

However, you may very well approve of my previous suggestion (crossed in 
the email) for a driver-specific subdirectory of the device directory.  I 
think it's more awkward, but it fits in your framework better.

Alan Stern

