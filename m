Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbTCJAwN>; Sun, 9 Mar 2003 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbTCJAwN>; Sun, 9 Mar 2003 19:52:13 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:42761 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262686AbTCJAwM>; Sun, 9 Mar 2003 19:52:12 -0500
Date: Sun, 9 Mar 2003 20:02:32 -0500
From: Ben Collins <bcollins@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Device removal callback
Message-ID: <20030310010232.GB16134@phunnypharm.org>
References: <20030309181413.GA492@phunnypharm.org> <20030310001102.GE6082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310001102.GE6082@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 04:11:02PM -0800, Greg KH wrote:
> On Sun, Mar 09, 2003 at 01:14:13PM -0500, Ben Collins wrote:
> > 
> > So I added a new callback to the device stucture called remove. This
> > callback is done when device_del is about to remove a device from the
> > tree. I've used this internally to make sure I can walk the list of
> > children myself, and also do some other cleanups.
> 
> But don't you really want to remove the children before you remove the
> parent?  If you do this patch, then the remove() function will have to
> clean up the children first, right?  Can we handle the core recursion
> with the current locks properly?

Actually, with this patch, the dev->remove(dev) is called before the
driver model does any cleanup. So you can cleanup children at that
point, and the parent device is still sane.

The reason for this is I would like to be able to unregister a node's
device from several places without worrying about other things that need
to be done. One call.

> Yes, for USB we still have a list of a device's children, as we need
> them for various things, and the current driver model only has a parent
> pointer, not a child pointer (which is good, as for USB we can have
> multiple children).  So in the function where we know a USB device is
> disconnected, we walk our list of children and disconnect them in a
> depth-first order.  With this patch I don't see how it helps me push
> code into the driver core.

I haven't looked into USB in depth, but consider this. Without the
patch, to cleanup a device:

void ieee1394_remove_node(struct node_entry *ne)
{
	...

	list_for_each(..., &ne->device.children) {
		device_unregister(list_to_dev(lh));
	}

	device_unregister(&ne->device);
}


Then to remove a device, this function must always be called, so that
the unit-directories get removed. What happens if the PCI bus gets
yanked out from underneath us? How does the OHCI card's callbacks get me
back down to this point? Without a lot of extra infrastructure, the
nodes and unit directories get left hanging.

Instead I now do this, with the patch.

void ieee1394_remove_node(struct device *dev)
{
	list_for_each(..., &ne->device.children) {
		device_unregister(list_to_dev(lh));
	}
}

...
	/* Where the dev is created */
	...
	ne->device.remove = ieee1394_remove_node;
	device_register(&ne->device);

Now, no matter where it's called from, doing...

	device_unregister(&ne->device);

...will make sure my remove callback is executed, so the children
devices get unregistered aswell. I extend this to the host device
and I have a recursive remocal scheme that is safe no matter where my
devices get unregistered. Whole lot simpler that adding in a lot of
failsafe's and checks.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
