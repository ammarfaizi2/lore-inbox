Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWF0X3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWF0X3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWF0X3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:29:13 -0400
Received: from ns1.suse.de ([195.135.220.2]:57506 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422721AbWF0X3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:29:12 -0400
Date: Tue, 27 Jun 2006 16:26:00 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060627232600.GE15225@kroah.com>
References: <20060623042452.GA23232@kroah.com> <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org> <20060626235732.GE32008@kroah.com> <200606261904.06102.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261904.06102.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 07:04:05PM -0700, David Brownell wrote:
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

Again, virtual devices that are no associated with any driver.  Exactly
the situation we have today with the usb endpoints and the usb_device
structures. 

And again, the USB core should not be messing with any devices that it
does not control, that just happen to be hanging off of the USB devices.

> Even so-called "virtual" devices (talking to abstracted hardware) need to
> quiesce.

No they don't.  If they did, they would be bound to a driver and provide
a suspend method.  Look at the current code for 2 examples of struct
devices that meet this critera.

> > Ah, ok, I thought it was somewhere...  David, why don't we walk that
> > list instead?
> 
> Because the type of the child doesn't matter.  If it hasn't suspended,
> the parent must not suspend.  The original point of the driver model was
> to be able to enforce that integrity constraint.

Well, who knows what the original point of the driver model was in this
regard, as that developer is not helping with development anymore :(

> Plus, this way we use the driver model data structures ... in much the
> way the driver model itself would, if it were maintaining such integrity
> constraints.  If the driver model is ever going to fix those issues,
> we'll at least know it has sufficient data at hand.

If we want to add these kinds of constraints to the driver model, great,
let's add them to the core and have that discussion.  But we should NOT
be adding it to a random driver subsystem to try to enforce requirements
the rest of the driver tree does not obey.  That's just insane.

thanks,

greg k-h
