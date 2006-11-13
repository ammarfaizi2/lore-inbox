Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755292AbWKMRPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbWKMRPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbWKMRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:15:55 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:16030 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1755292AbWKMRPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:15:54 -0500
Date: Mon, 13 Nov 2006 12:15:53 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: arvidjaar@mail.ru, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI
 wakeup via sysfs
In-Reply-To: <200611130839.11459.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0611131202290.2390-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, David Brownell wrote:

> > Well, I would argue that part of the problem has to do with the use of 
> > device_may_wakeup.  It is tied to a sysfs API 
> 
> It's a *driver model* API, which is also accessible from sysfs ... to support
> per-device policies, for example the (a) workaround.  The mechanism exists
> even on kernels that don't include sysfs ... although on such systems, there
> is no way for users to do things like say "ignore the fact that this mouse
> claims to issue wakeup events, its descriptors lie".

Yes, it is separate from sysfs -- but it is _tied_ to the sysfs API.

> > and therefore administrative  
> > in nature, but now you say it's also being used to record hardware quirks.
> 
> No; I'm saying the driver model is used to record that the hardware mechanism
> isn't available.   The fact that it's because of an implementation artifact
> (bad silicon, or board layout, etc) versus a design artifact (silicon designed
> without that feature) is immaterial ... in either case, the system can't use
> the mechanism.

But the information is being recorded in the wrong spot.  The correct test
should use device_can_wakeup, not device_may_wakeup.  The can_wakeup flag
is the one which records whether or not the hardware mechanism is actually
available.


> > > > If you think autostop should also check for device_may_wakeup(), I'll make 
> > > > it do so.  Remember though that autostop is intended to work even when 
> > > > CONFIG_PM is off.
> > > 
> > > The original autosuspend logic would never kick in without PM; after all,
> > > it's purely a power saving mechanism!  And testing device_may_wakeup() will
> > > be restoring that behavior, since without PM that's always false.
> > 
> > It would restore that behavior, and it would be silly way of doing so.  
> > There are better ways to prevent autostop without PM, such as making
> > ohci_rh_suspend() and ohci_rh_resume() depend on CONFIG_PM!
> 
> ISTR they do that too.  :)

They used to, but I changed it when I added autostop.  Looks like I need 
to change it back.

> > However it was always my intention that autostop should operate without
> > PM.  It's not only about saving power, it also is about reducing load on
> > system resources -- primarily DMA, although this may be a lot less severe
> > with OHCI than with UHCI.  Does OHCI do any DMA at all when no devices are
> > plugged in and the schedule is empty?
> 
> That's not an issue at all with OHCI; it only DMAs when the relevant
> schedule is enabled.  Which it isn't, unless it has work to do.
> 
>  
> > My quick impression from the spec is that it does not, in which case 
> > there is no point in keeping autostop when CONFIG_PM is off.
> 
> Exactly.  That's why I said it's purely a power saving mechanism.

Okay.  I'll write a patch to eliminate autostop and those routines when
CONFIG_PM is off.

But that doesn't answer the question above: Should autostop check 
device_can_wakeup rather than device_may_wakeup?

Also: Does the quirk/bug detection logic clear can_wakeup, as it should?  
Or does it only affect may_wakeup?

Alan Stern

