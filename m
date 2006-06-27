Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933280AbWF0CEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933280AbWF0CEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbWF0CEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:04:10 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:27030 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S933280AbWF0CEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:04:09 -0400
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Mon, 26 Jun 2006 19:04:05 -0700
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
References: <20060623042452.GA23232@kroah.com> <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org> <20060626235732.GE32008@kroah.com>
In-Reply-To: <20060626235732.GE32008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261904.06102.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 4:57 pm, Greg KH wrote:
> On Fri, Jun 23, 2006 at 10:51:47AM -0400, Alan Stern wrote:
> > On Thu, 22 Jun 2006, Greg KH wrote:
> > 
> > > > Under what scenario could it possibly be legitimate to suspend a
> > > > usb device -- or interface, or anything else -- with its children
> > > > remaining active?  The ability to guarantee that could _never_ happen
> > > > was one of the fundamental motivations for the driver model ...
> > > 
> > > I'm not disagreeing with that.  It's just that you are looping all
> > > struct devices that are attached to a struct usb_device and assuming
> > > that they are all of type struct usb_interface. ...
> > 
> > In fact the code doesn't make that assumption.  It only assumes that the 
> > dev->power.power_state.event field is set correctly ...
> 
> Yes, but it's looking at devices it should _not_ care about.  The USB
> core should only care about devices it controls, not other devices in
> the device chain.  Those are for the driver core to handle.

The basic problem is that the driver core does ** NOT ** maintain such
integrity constraints.  So it's unsafe to remove those checks for cases
(like USB) where devices get suspended outside transition to "system sleep"
states like "standby", "suspend-to-ram", and "suspend-to-disk". [1]

Go back to my original question:  is there a legitimate scenario where
that test should fail?  Nobody has come up with even one ...


Even so-called "virtual" devices (talking to abstracted hardware) need to
quiesce.  And as Adam has pointed out separately, often most of the work to
quiesce drivers should be at such a "virtual" level.  Most of the time when
a driver for a "physical" device (touches real registers) does complicated
work to quiesce, it's because the next level in the driver stack didn't
create a "virtual" device to package that logic.  As with "eth0".


> > > We probably need to keep our own list of interfaces if we want to
> > > properly walk them now...
> > 
> > We do have such a list: udev->actconfig->interface[].
> 
> Ah, ok, I thought it was somewhere...  David, why don't we walk that
> list instead?

Because the type of the child doesn't matter.  If it hasn't suspended,
the parent must not suspend.  The original point of the driver model was
to be able to enforce that integrity constraint.

Plus, this way we use the driver model data structures ... in much the
way the driver model itself would, if it were maintaining such integrity
constraints.  If the driver model is ever going to fix those issues,
we'll at least know it has sufficient data at hand.

- Dave

[1] One simple example:  echo 3 > /sys/devices/.../power/state for a
    device with children that aren't suspended.  The PM core will not
    detect that error.


