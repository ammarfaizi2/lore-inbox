Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUIOWaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUIOWaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUIOW2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:28:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:61643 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267664AbUIOW0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:26:50 -0400
Date: Wed, 15 Sep 2004 15:23:36 -0700
From: Greg KH <greg@kroah.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Marco d'Itri" <md@Linux.IT>, "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915222336.GD26591@kroah.com>
References: <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <20040915161541.GD21971@kroah.com> <20040915192134.GA4197@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915192134.GA4197@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:21:34PM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 15, 2004 at 09:15:41AM -0700, Greg KH wrote:
> > But the low level driver (like a USB driver for example), has no way of
> > knowing when the "device discovery" process is over.  Actually the USB
> > core never knows this either, as devices come and go all the time.
> 
> eventually the discovery will end with a call into userspace, it'd be
> enough to wait4 and wakeup a waitqueue when the wait4 returns. 

But to wait for what?  That's the point.  The individual driver doesn't
know what it should be waiting for, if anything at all.  That's why we
have the "probe" and "release" model for device drivers now.

> > So the kernel can not know what or when to wait for something it doesn't
> > know is going to ever happen in the future.
> 
> the kernel certainly knows when it's about time to fork an userspace
> process to create the device, doesn't it? then just wait4 while the
> process is running.

Yes and no.  You see there's a lot of hotplug events that get kicked off
when a device (such as a USB device) is discovered.  We have the "here's
a device", "here's an interface on that device", "here's a scsi-host
controller that got bound to the interface", "here's a scsi device on
that host controller that got added", "here's a sg interface bound to
that scsi device", "here's a sd interface bound to that device", "here's
a block device attached to that sd interface", "here's a partition
belonging to that block device".

And all of those get kicked off by different kernel threads at different
times, all for one possible modprobe.  And odds are that modprobe has
long returned by the time that last "block device" and "partition"
hotplug events get emitted by the kernel.  

And different modprobe events all caused that end result (modprobing of
the bus, host controller, usb driver, scsi core, scsi disk, and scsi
generic modules.)  Which modprobe will you want to wait for?


> > Remember, this isn't your old "static device tree" unix-like kernel that
> > people grew up with, anymore. :)
> 
> if you intentionally don't want to provide serialization and force into
> /var/run locking, that's fine with me, but I don't buy your claim that
> it's not feasible.

I think it's not feasible.  But feel free to dig through the
usb/scsi/driver core/block code to prove me wrong :)

In the meantime, the rest of us over here will be using the /etc/dev.d
interface...

thanks,

greg k-h
