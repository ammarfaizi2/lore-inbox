Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUAWSDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUAWSDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:03:35 -0500
Received: from ida.rowland.org ([192.131.102.52]:18948 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266624AbUAWSDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:03:33 -0500
Date: Fri, 23 Jan 2004 13:03:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <Pine.LNX.4.58.0401230939170.2151@home.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Linus Torvalds wrote:

> On Fri, 23 Jan 2004, Alan Stern wrote:
> >
> > Since I haven't seen any progress towards implementing the 
> > class_device_unregister_wait() and platform_device_unregister_wait() 
> > functions, here is my attempt.
> 
> So why would this not deadlock?

Kind of a general question, so I'll give a general answer.  This wouldn't
deadlock for the same reason as anything else: People use it properly!

> The reason we don't wait on things like this is that it's basically
> impossible not to deadlock.

That's an exaggeration.  There are places where it's _necessary_ to
wait.  For example, consider this extract from a recent patch written by
Greg KH:

+	/* FIXME change this when the driver core gets the
+	 * class_device_unregister_wait() call */
+	init_completion(&bus->released);
 	class_device_unregister(&bus->class_dev);
+	wait_for_completion(&bus->released);

For the full patch, see 
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107109069106188&w=2

The general context is that a module is trying to unload, but it can't
until the release() callback for its device has finished.

> There are damn good reasons why the kernel uses reference counting 
> everywhere. Any other approach is broken.

And sometimes a part of the kernel has to wait until the reference count
drops to 0.  Instead of making everyone who needs to wait for a
class_device or a platform_device roll their own completions, this
provides a central facility.

By the way, adding class_device_unregister_wait() has an excellent
precedent.  The driver model core _already_ includes
device_unregister_wait(), merged by Pat Mochel.  Are you saying that
function shouldn't exist either?

Alan Stern

