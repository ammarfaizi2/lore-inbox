Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVC3Wvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVC3Wvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVC3Wvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:51:46 -0500
Received: from peabody.ximian.com ([130.57.169.10]:63161 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262528AbVC3Wus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:50:48 -0500
Subject: Re: [RFC] Driver States
From: Adam Belay <abelay@novell.com>
To: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
In-Reply-To: <Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
References: <1111963367.3503.152.camel@localhost.localdomain>
	 <Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 17:45:16 -0500
Message-Id: <1112222717.3503.213.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 21:57 -0800, Patrick Mochel wrote:
> On Sun, 27 Mar 2005, Adam Belay wrote:
> 
> > Dynamic power management may require devices and drivers to transition
> > between various physical and logical states.  I would like to start a
> > discussion on how these might be defined at the bus, driver, and class
> > levels.
> 
> <snip>
> 
> > Bus Level
> > =========
> > At the bus level, there are two state attributes, power and
> > enable/disable.  Enable/disable may mean different things on different
> > buses, but they generally refer to resource decoding.  A device can only
> > be enabled during a non-off power state.
> 
> <...>
> 
> > Driver Level
> > ============
> > At the driver level there are two areas of interest, physical and
> > logical state.  There is an additional concern of transitioning between
> > these states multiple times.  Because a driver acts as a bridge between
> > physical and logical components, I think separating these steps seems
> > natural.
> 
> <...>
> 
> > *attach - allocates data structures, creates sysfs entries, prepares driver
> >        to handle the hardware.
> >
> > *start -  Sets up device resources and configures the hardware.  Loads
> > firmware, etc.
> > (physical)
> >
> > *open -   engages the hardware, and makes it usable by the class device.
> > (logical and physical)
> >
> > *close -  disengages the hardware, and stops class level access
> > (logical and physical)
> >
> > *stop -   physically disables the hardware
> > (physical)
> >
> > *detach - tears down the driver and releases it from the "struct device"
> >
> 
> You have a few things here that can easily conflict, and that will be
> developed at different paces. I like the direction that it's going, but
> how do you intend to do it gradually. I.e. what to do first?

I think the first step would be for us to all agree on a design, whether
it be this one or another, so we can began planning for long term
changes.

My arguments for these changes are as follows:

     1. If a device has been powered off, powered on, and restored in
        state, it is identical to a device that the driver is
        configuring for the first time.  So calling "*start" as part of
        device resume seems like a logical course of action.
     2. Being able to start and stop a device is useful outside the
        realm of power management.  It's required for resource
        re-balancing.  Also, the user may want to disable a device, but
        the device must still be able to save state and react correctly
        during a suspend.  Allowing the user to start and stop drivers
        gives more flexibility to userspace utilities.  There may be
        sysfs configuration files that can only be changed when the
        device isn't active.  Resource configuration cannot be changed
        when the device is in use.
     3. *open and *close also might be a possibility.  When a device is
        put into a lower power state, we want to stop driver timers and
        prepare the hardware to be inactive, which is exactly the role
        of "*close".  See the existing code in most net drivers.  I
        would like to note, however, that this portion of the API is
        optional, and needs to be looked into further.  I'm considering
        dropping it in favor of having suspend and resume handle this.
     4. Having responsibilities at each driver level encourages a
        layered and object based design, reducing code duplication and
        complexity.

* "*start" and "*stop" might even be useful for device error detection.
(Ex. we currently have no notion of starting up a device over again
after a hardware failure)

I think the next step would be to look at each class subsystem, and
verify that our proposed API could work well with it.  If it's going to
change the design of many device drivers, we want to make sure we get it
right.

>From there, the bus level changes could be made, as they would affect
the least upstream code.  Things like PCI PM could also be improved
during this stage.  Greg, I know that adding *enable, and *disable to
"struct bus_type" would be nice for PCI, ACPI, etc, as it would control
whether resources are decoded and other device initialization
requirements.  What about external devices such as USB?  Would such as
interface be useful for other buses?

Next, we could make changes to "struct device_driver".  As to not break
things, (*start or *attach) and (*stop or *detach) could be temporarily
mapped to *probe and *remove until everything is fixed up.  This hack
could be made at the bus level, so the fixes could be applied one bus at
a time.

The final step would be to introduce "*open and *close", if we decide to
use them, and also class device *start and *stop.  Pat, do you have any
comments on adding *start and *stop to class devices?  It seems like an
interesting possibility to me.

Thanks,
Adam


