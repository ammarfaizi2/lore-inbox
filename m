Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933137AbWFZX7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbWFZX7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933150AbWFZX7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:59:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:53451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S933137AbWFZX7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:59:43 -0400
Date: Mon, 26 Jun 2006 16:57:32 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060626235732.GE32008@kroah.com>
References: <20060623042452.GA23232@kroah.com> <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 10:51:47AM -0400, Alan Stern wrote:
> On Thu, 22 Jun 2006, Greg KH wrote:
> 
> > > Under what scenario could it possibly be legitimate to suspend a
> > > usb device -- or interface, or anything else -- with its children
> > > remaining active?  The ability to guarantee that could _never_ happen
> > > was one of the fundamental motivations for the driver model ...
> > 
> > I'm not disagreeing with that.  It's just that you are looping all
> > struct devices that are attached to a struct usb_device and assuming
> > that they are all of type struct usb_interface.  And that's not true
> > anymore, and should never have been assumed (which is probably my fault
> > way long ago when converting USB to the driver model.)
> 
> In fact the code doesn't make that assumption.  It only assumes that the 
> dev->power.power_state.event field is set correctly (0 for not suspended, 
> non-zero for suspended) and that you don't want to suspend a device if its 
> children aren't all suspended.

Yes, but it's looking at devices it should _not_ care about.  The USB
core should only care about devices it controls, not other devices in
the device chain.  Those are for the driver core to handle.

> > We probably need to keep our own list of interfaces if we want to
> > properly walk them now...
> 
> We do have such a list: udev->actconfig->interface[].

Ah, ok, I thought it was somewhere...  David, why don't we walk that
list instead?

> > And we also need to be able to handle devices in the device tree that do
> > not have a suspend/resume function, or ones that are not attached to any
> > bus, without failing the suspend, as obviously they do not care or need
> > to worry about the whole issue.
> 
> Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> it because it doesn't need them, or is it because nobody has written them 
> yet?  In the latter case, failing the suspend or unbinding the driver are 
> the only safe courses.

No, if it's not there, just expect that it knows what it is doing, and
don't fail the thing.  Unless you want to add those methods to _every_
driver in the kernel, and that's going to be a lot of work...

> And when you're dealing with a device that isn't on a bus or doesn't have 
> a driver, then clearly you _can't_ suspend it.  You can abort the system 
> sleep, or you can go ahead knowing that the device may not be in a 
> low-power mode.

It's a virtual device, it can go to sleep just fine with nothing needed
to have done at all, as it's just in kernel memory, no physical thing to
turn to "low power" mode at all.

thanks,

greg k-h
