Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268959AbTBWTXi>; Sun, 23 Feb 2003 14:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbTBWTXi>; Sun, 23 Feb 2003 14:23:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34821 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268959AbTBWTWU>; Sun, 23 Feb 2003 14:22:20 -0500
Date: Sun, 23 Feb 2003 19:32:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, ink@jurassic.park.msu.ru,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030223193229.F20405@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Greg KH <greg@kroah.com>, ink@jurassic.park.msu.ru,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030223173441.D20405@flint.arm.linux.org.uk> <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Feb 23, 2003 at 10:57:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 10:57:10AM -0800, Linus Torvalds wrote:
> On Sun, 23 Feb 2003, Russell King wrote:
> > Linus - this patch is for discussion, NOT for applying unless you have
> > zero problems with it since it actively breaks existing hotplug PCI.
> 
> Well, I definitely want it, and you should add Alan to the cc list since 
> he apparently even _has_ one of these devices.

Alan kindly sent one of these beasts to me, which renewed my interest
in this area.  I'll forward stuff so far.

> > Furthermore, I propose that pci_remove_device() shall disappear -
> > and this devices makes it so (thereby breaking existing hotplug
> > drivers.)
> 
> Can't you just fix up the current users to use "pci_remove_bus_device()". 
> The breakage seems a bit spiteful ;)

I'd like to hear Gregs comments first - Greg knows the hotplugging code
better than me.  It appears to have its own way of decending some of the
PCI buses, but it seems unclear why it needs to supervise removal of
devices which are downstream from the hotplug slot.

As far as inserting this device, there needs to be a fair number of other
to the PCI layer to make stuff work sanely.  Currently, in order, we:

1. discovering all devices
2. once all devices have been initialised, registering each
   device with sysfs and thereby letting the drivers know.
3. apply any fixups needed
4. initialise any resources that need initialising

The drivers quite rightfully moan, and it isn't a pretty sight.

IMO, what we should be doing, in order, is:

1. discovering all devices
2. apply any fixups needed
3. initialise any resources that need initialising
4. once all devices have been initialised, registering each
   device with sysfs and thereby letting the drivers know.

We need to wait until everything is setup for step 4 because we may
(and do in the case of this split-bridge) need to program PCI-PCI
bridges before the devices become accessible.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

