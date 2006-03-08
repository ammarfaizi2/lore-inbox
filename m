Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWCHUJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWCHUJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCHUJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:09:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55708 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932189AbWCHUJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:09:08 -0500
Date: Wed, 8 Mar 2006 15:09:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <200603081033.21584.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0603081421250.5360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, David Brownell wrote:

> > In this case it wouldn't make any difference, since all the altsettings
> > for a particular interface are supposed to have the same bInterfaceClass,
> > bInterfaceSubClass, and bInterfaceProtocol.  Although I don't think the
> > USB spec actually says this anywhere..
> 
> I'd have stopped at "wouldn't make any difference"; the kernel must make
> some initial choice, but userspace is free to revise it.  Agreed it would
> be odd if altsettings had different class/subclass/protocol, but I don't
> see any good reason to make that illegal.

Agreed.  And like I said before, this is only a heuristic.

> > The bMaxPower value could be different for different altsettings. 
> 
> Erm, no; that's a per-configuration thing, not a per-altsetting thing.
> It's checking the config descriptor, not the interface descriptor,
> for that particular concern.

Whoops, yes.  I misread the code.  All the more reason not to worry about 
any but the first altsetting.

> > > > b) How do we know that there's actually anything _there_?  The length of
> > > >    that variable-sized array doesn't seem to have been stored anywhere
> > > >    obvious by usb_parse_configuration() and choose_configuration() doesn't
> > > >    check.  What happens if the length was zero?
> > > 
> > > I don't think it is allowed to be, as all USB devices have to have at
> > > least 1 interface.
> 
> I think that's not true, and it would be worth verifying that it's not
> a no-interfaces device even if the USB spec required it.  It's trivial
> to create device firmware that advertises no-interfaces, and those should
> never be able to make Linux hiccup (much less oops).

Ha!  "should never be able" indeed.  It turns out the code doesn't like it 
if a configuration has no interfaces.  How embarassing...

Andrew, if you tell us what's in your /proc/bus/usb/devices we'll see
whether that was the real problem.  In any case, a patch follows.

Alan Stern

