Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWFAO6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWFAO6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWFAO6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:58:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:1028 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751027AbWFAO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:58:46 -0400
Date: Thu, 1 Jun 2006 10:58:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: David Liontooth <liontooth@cogweb.net>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-Reply-To: <20060601030140.172239b0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, Andrew Morton wrote:

> On Thu, 01 Jun 2006 02:18:20 -0700
> David Liontooth <liontooth@cogweb.net> wrote:
> 
> > Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
> > hubs. Alan Stern explains,
> > 
> > "The idea is that the kernel now keeps track of USB power budgets.  When a 
> > bus-powered device requires more current than its upstream hub is capable 
> > of providing, the kernel will not configure it.
> > 
> > Computers' USB ports are capable of providing a full 500 mA, so devices
> > plugged directly into the computer will work okay.  However unpowered hubs
> > can provide only 100 mA to each port.  Some devices require (or claim they
> > require) more current than that.  As a result, they don't get configured
> > when plugged into an unpowered hub."
> > 
> > http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg43480.html
> > 
> > This is generating a lot of grief and appears to be unnecessarily
> > strict. Common USB sticks with a MaxPower value just above 100mA, for
> > instance, typically work fine on unpowered hubs supplying 100mA.
> > 
> > Is a more user-friendly solution possible? Could the shortfall
> > information be passed to udev, which would allow rules to be written per
> > device?

I'm not sure whether we create a udev event when a new USB device is
connected.  If we don't, we certainly could.  Although this event wouldn't
contain information about the power budget shortfall, it would contain
vendor and product IDs.  These would be sufficiently specific for a custom
udev script to install the desired configuration.

> Yes, it sounds like we're being non-real-worldly here.  This change
> apparently broke things.  Did it actually fix anything as well?

Yes.  At least, I think so.  The change directly addresses a complaint 
filed here:

http://marc.theaimsgroup.com/?l=linux-usb-users&m=112438431718562&w=2

I haven't checked back with the original poster to make sure that his
problem has been solved, but presumably it has been.

As an alternative, we could allow an "over-budget window" of say 10%.  
Configurations that exceed the power budget by less than that amount would
still be accepted.  I don't know whether this would be enough of a help,
however.  I've heard of devices that claim to require 200 mA, for
instance.  It just doesn't seem right to enable them when the upstream hub
can only provide 100 mA.

Alan Stern

