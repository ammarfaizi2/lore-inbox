Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUAWTpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUAWTpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:45:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266681AbUAWTpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:45:47 -0500
Date: Fri, 23 Jan 2004 19:45:46 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040123194546.GK21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org> <Pine.LNX.4.58.0401230939170.2151@home.osdl.org> <20040123181106.GD23169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123181106.GD23169@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 10:11:06AM -0800, Greg KH wrote:
> On Fri, Jan 23, 2004 at 09:42:09AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Fri, 23 Jan 2004, Alan Stern wrote:
> > >
> > > Since I haven't seen any progress towards implementing the 
> > > class_device_unregister_wait() and platform_device_unregister_wait() 
> > > functions, here is my attempt.
> > 
> > So why would this not deadlock?
> 
> It will deadlock if the user does something braindead like:
> 	rmmod foo < /sys/class/foo_class/foo1/file
> 
> Now I know the network code can handle something like that, but they
> have their own thread to handle issues like this...  It's not sane to
> make every driver subsystem do that...

Network code does *NOT* wait for references to kobject to disappear.
->release() for those buggers is not in a module and freeing can
happen way after the rmmod.  No threads involved.

What it does wait for is different - in effect, net_device has a special-cased
rwsem in it, heavily optimised for down_read().  dev_hold() is an equivalent
of down_read().  dev_put() - up_read().  And unregister_netdev() does an
equivalent of down_write() after removing from all search structures.

That's what it is waiting for - it wants all readers (semaphore is unfair)
to go away.  It's not a refcounting issue at all - it's an exclusion around
the net_device shutdown, freeing resources, etc.

There was an optimistic attempt to turn that animal into sysfs refcount.
It didn't work - we had to add real refcounting there and make sysfs code
do essentially an equivalent of down_try_read() before accessing the guts
of net_device().  And we have ->release() for those buggers in core kernel.
