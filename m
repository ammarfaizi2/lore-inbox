Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbUAWSP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUAWSP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:15:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:57553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266601AbUAWSPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:15:40 -0500
Date: Fri, 23 Jan 2004 10:15:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.58.0401231008220.2151@home.osdl.org>
References: <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jan 2004, Alan Stern wrote:
> > 
> > So why would this not deadlock?
> 
> Kind of a general question, so I'll give a general answer.  This wouldn't
> deadlock for the same reason as anything else: People use it properly!

No.

> > The reason we don't wait on things like this is that it's basically
> > impossible not to deadlock.
> 
> That's an exaggeration.

Not by much.

>		  There are places where it's _necessary_ to
> wait.  For example, consider this extract from a recent patch written by
> Greg KH:
> 
> +	/* FIXME change this when the driver core gets the
> +	 * class_device_unregister_wait() call */
> +	init_completion(&bus->released);
>  	class_device_unregister(&bus->class_dev);
> +	wait_for_completion(&bus->released);
> 
> For the full patch, see 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107109069106188&w=2
> 
> The general context is that a module is trying to unload, but it can't
> until the release() callback for its device has finished.

And in just about any circumstance, with the _possible_ exception of 
module unload, things like this can be fooled into deadlocking by a 
non-root user.

To the point where root can no longer fix things up.

We've had these bugs before. It's a mistake to make interfaces that 
positively _encourage_ bugs like this.

The canonical example of a bug like this is when a regular user can 
trigger an event that causes the wait, and then makes sure that it holds a 
reference count on the event - by opening a file descriptor. 

> And sometimes a part of the kernel has to wait until the reference count
> drops to 0.

Not likely. The rest of the kernel never does it.

What is it with USB that makes people think so? Remember all the USB bugs 
early on that were due to _exactly_ that thinking. 

It's wrong. YOU SHOULD NEVER WAIT FOR THE REFERNCE COUNT TO DROP TO ZERO!

You just ignore it. With proper memory management it doesn't matter.

For module unload, it's likely better to return an error than to wait. 
Tell the super-user that you're busy.

> By the way, adding class_device_unregister_wait() has an excellent
> precedent.  The driver model core _already_ includes
> device_unregister_wait(), merged by Pat Mochel.  Are you saying that
> function shouldn't exist either?

Quite probably.

		Linus
