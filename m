Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWF0PYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWF0PYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWF0PYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:24:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45835 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161090AbWF0PYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:24:52 -0400
Date: Tue, 27 Jun 2006 11:24:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Greg KH <greg@kroah.com>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-pm@osdl.org>, <pavel@suse.cz>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
In-Reply-To: <200606261904.06102.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0606271121390.20671-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, David Brownell wrote:

> On Monday 26 June 2006 4:57 pm, Greg KH wrote:
> > On Fri, Jun 23, 2006 at 10:51:47AM -0400, Alan Stern wrote:
> > > On Thu, 22 Jun 2006, Greg KH wrote:
> > > 
> > > > > Under what scenario could it possibly be legitimate to suspend a
> > > > > usb device -- or interface, or anything else -- with its children
> > > > > remaining active?  The ability to guarantee that could _never_ happen
> > > > > was one of the fundamental motivations for the driver model ...
> > > > 
> > > > I'm not disagreeing with that.  It's just that you are looping all
> > > > struct devices that are attached to a struct usb_device and assuming
> > > > that they are all of type struct usb_interface. ...
> > > 
> > > In fact the code doesn't make that assumption.  It only assumes that the 
> > > dev->power.power_state.event field is set correctly ...
> > 
> > Yes, but it's looking at devices it should _not_ care about.  The USB
> > core should only care about devices it controls, not other devices in
> > the device chain.  Those are for the driver core to handle.
> 
> The basic problem is that the driver core does ** NOT ** maintain such
> integrity constraints.  So it's unsafe to remove those checks for cases
> (like USB) where devices get suspended outside transition to "system sleep"
> states like "standby", "suspend-to-ram", and "suspend-to-disk". [1]
> 
> Go back to my original question:  is there a legitimate scenario where
> that test should fail?  Nobody has come up with even one ...
> 
> 
> Even so-called "virtual" devices (talking to abstracted hardware) need to
> quiesce.  And as Adam has pointed out separately, often most of the work to
> quiesce drivers should be at such a "virtual" level.  Most of the time when
> a driver for a "physical" device (touches real registers) does complicated
> work to quiesce, it's because the next level in the driver stack didn't
> create a "virtual" device to package that logic.  As with "eth0".

An easy way around the problem is to create simple suspend/resume methods 
for the endpoint devices.  They don't have to do anything other than set 
dev->power.power_state.event.  Not until these "endpoint devices" start 
implementing some real functionality.

Alan Stern

