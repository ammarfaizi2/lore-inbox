Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTFPNvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 09:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTFPNv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 09:51:29 -0400
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262185AbTFPNvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 09:51:23 -0400
Date: Mon, 16 Jun 2003 10:05:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <1055698845.1351.44.camel@ixodes.goop.org>
Message-ID: <Pine.LNX.4.44L0.0306160958300.737-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 2003, Jeremy Fitzhardinge wrote:

> On Sun, 2003-06-15 at 09:42, Alan Stern wrote:
> > If you're already aware of this, please forgive the intrusion.
> > 
> > There's a general problem in the driver model's implementation of 
> > attribute files, in connection with loadable kernel modules.  The 
> > sysfs_ops structure stores function pointers with no means for identifying 
> > the module that contains the corresponding code.  As a result, it's 
> > possible to call through one of these pointers even after the module has 
> > been unloaded, causing an oops.
> > 
> > It's not hard to provoke this sort of situation.  A user process can
> > open a sysfs device file, for instance, and delay trying to read it until 
> > the module containing the device driver has been removed.  When the read 
> > does occur, it runs into trouble.
> 
> I've seen this oops when a program has its cwd in a /sys directory
> corresponding to a removed (or replaced) module.  I think active
> references to a part of the /sys namespace corresponding to a module
> should just pin the module.  But I haven't looked into it really.

The question of which references should pin a module is a design decision 
that I prefer to leave to others.  But I would think that a reference the 
module can quickly and easily revoke probably shouldn't pin it, whereas 
one the module isn't even aware of probably should.

That's the difference between the example you gave and the problem I
cited.  In your example, the fact that your program parked its cwd in a
sysfs directory would force the reference count of the corresponding
kobject to be nonzero.  That the module was willing to deallocate the
kobject and exit even though the reference count was still positive is a
simple programming error.  But in the situation I described, the design of
the driver model makes it impossible for a driver to know whether any user
processes still have references to a device attribute file after
device_remove_file() has been called.

Alan Stern

