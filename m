Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUKJCzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUKJCzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUKJCzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:55:45 -0500
Received: from ozlabs.org ([203.10.76.45]:39654 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262003AbUKJCzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:55:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16785.33677.704803.889900@cargo.ozlabs.ibm.com>
Date: Wed, 10 Nov 2004 13:57:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041110013700.GF9496@kroah.com>
References: <1099346276148@kroah.com>
	<10993462773570@kroah.com>
	<20041102223229.A10969@flint.arm.linux.org.uk>
	<20041107152805.B4009@flint.arm.linux.org.uk>
	<20041110013700.GF9496@kroah.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> On Sun, Nov 07, 2004 at 03:28:05PM +0000, Russell King wrote:
> > On Tue, Nov 02, 2004 at 10:32:29PM +0000, Russell King wrote:
> > > 
> > > Does this mean that a device driver can have its suspend or resume
> > > methods called in the middle of a probe or remove on a different CPU ?
> > > (note: x86 APM does not freeze all processes last time I checked...)
> > > 
> > > If yes, has anyone audited the drivers to ensure that they're correct
> > > in respect of this?
> > 
> > I'll repost the above question since it's of fundamental importance.

I didn't change anything that would affect that.

Unless I am misunderstanding the question, it has always been the case
that a bus's suspend or resume method could be called concurrently
with a driver probe call.  device_add() calls device_pm_add() followed
by bus_add_device().  device_pm_add() puts the device on the
dpm_active list, and once it is there, device_suspend will see it, and
will call the bus's suspend function.  bus_add_device() calls
device_attach() which either calls device_bind_driver() or
driver_probe_device(), and driver_probe_device() calls the driver's
probe function.

So we can get a driver's probe method called concurrently with its
bus's suspend or resume method.  Whether the driver's suspend/resume
method gets called depends on the bus-specific code.  In the case of
PCI, it looks like pci_device_suspend won't call the driver's suspend
function unless pci_dev->driver is set.  That gets set in
pci_device_probe_{dynamic,static} after the drv->probe() call, so that
probably mostly excludes concurrency with the suspend/resume calls
(except that there is no memory barrier in there).  I don't know
whether driver_probe_device() can ever get called for PCI devices.  If
it can I then don't know how/where pci_dev->driver would get set (as
opposed to dev->driver).

I would stress that none of this analysis is any different before or
after my patch though.  The question (of concurrency between
probe/remove and suspend/resume) is an interesting one, but it's not
something that's affected one way or the other by my patch.

Greg, do you have an analysis (or set of rules) for concurrency
between the various driver functions?

Paul.
