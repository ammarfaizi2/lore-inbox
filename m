Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWFWOvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWFWOvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFWOvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:51:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36619 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750809AbWFWOvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:51:48 -0400
Date: Fri, 23 Jun 2006 10:51:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-pm@osdl.org>, <pavel@suse.cz>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
In-Reply-To: <20060623042452.GA23232@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Greg KH wrote:

> > Under what scenario could it possibly be legitimate to suspend a
> > usb device -- or interface, or anything else -- with its children
> > remaining active?  The ability to guarantee that could _never_ happen
> > was one of the fundamental motivations for the driver model ...
> 
> I'm not disagreeing with that.  It's just that you are looping all
> struct devices that are attached to a struct usb_device and assuming
> that they are all of type struct usb_interface.  And that's not true
> anymore, and should never have been assumed (which is probably my fault
> way long ago when converting USB to the driver model.)

In fact the code doesn't make that assumption.  It only assumes that the 
dev->power.power_state.event field is set correctly (0 for not suspended, 
non-zero for suspended) and that you don't want to suspend a device if its 
children aren't all suspended.

> We probably need to keep our own list of interfaces if we want to
> properly walk them now...

We do have such a list: udev->actconfig->interface[].

> And we also need to be able to handle devices in the device tree that do
> not have a suspend/resume function, or ones that are not attached to any
> bus, without failing the suspend, as obviously they do not care or need
> to worry about the whole issue.

Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
it because it doesn't need them, or is it because nobody has written them 
yet?  In the latter case, failing the suspend or unbinding the driver are 
the only safe courses.

And when you're dealing with a device that isn't on a bus or doesn't have 
a driver, then clearly you _can't_ suspend it.  You can abort the system 
sleep, or you can go ahead knowing that the device may not be in a 
low-power mode.

Alan Stern

