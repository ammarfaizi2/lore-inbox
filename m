Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTFPSWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFPSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:22:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264088AbTFPSWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:22:37 -0400
Date: Mon, 16 Jun 2003 11:38:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alan Stern <stern@rowland.harvard.edu>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44L0.0306161413510.1350-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0306161133010.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree.  The problem here is that the sysfs/driver-model core is putting
> an object into a structure (i.e., a pointer to the device_attribute
> structure is being stored in the dentry for a user-owned file) without
> taking the corresponding responsibility for the lifetime of the driver
> code that the attribute refers to.  The struct driver's reference count is 
> _not_ incremented; in fact device_create_file() doesn't even _have_ a 
> struct driver argument to say who the caller is.

That's not the problem, only one possible solution. The problem is that 
the driver does not own the object it's exporting the attribute for. 

The object who owns the attributes gets its refcount incremented when the 
file is opened. If the module owns that object, it can take measures on 
unload to wait for that reference count to reach 0. 

If a piece of code exports an attribute for an object that it does not 
own, it must explicitly modify the reference count for that object. There 
is no other way to be safe. 

Note that by pinning the driver in memory when you create a sysfs file 
that it owns will prevent the module from ever being unloaded. That is 
possible, but not desirable. Note that that change would make your point 
moot. :) 

Also, device_create_file() does not have a driver argument, because 
drivers are not the only entities that may create files for a device. The 
owning bus and the core itself may also use that call. Drivers are 
probably the least qualified (most unsafe) entities to do so.


	-pat

