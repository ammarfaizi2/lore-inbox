Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267366AbUHJAne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267366AbUHJAne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUHJAne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:43:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:36052 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267366AbUHJAn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:43:28 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>
In-Reply-To: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092098425.14102.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 10:40:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The highlights are that it adds:
> 
> - To struct class:
> 
> 	int     (*dev_start)(struct class_device * dev);
> 	int     (*dev_stop)(struct class_device * dev);
> 
> - ->dev_stop() and ->dev_start() to struct class
>   This provides the framework to shutdown a device from a functional
>   level, rather than at a hardware level, as well as the entry points
>   to stop/start ALL devices in the system.
> 
>   This is implemented by iterating through the list of struct classes,
>   then through each of their struct class_device's. The class_device is
>   the only argument to those functions.

Hrm... I don't agree, that iteration should be done in bus ordering too.

For example, if you stop operation of a USB host controller, you have to
do that after you have stopped operation of child devices. Same goes
with the ATA disk vs. controller. The ordering requirements for stopping
operations are the same as for PM
> 
> - To struct bus_type:
> 	int             (*pm_save)(struct device *, struct pm_state *);
> 	int             (*pm_restore)(struct device *);
> 
>   These methods provide the interface for saving and restoring low-
>   level device state only. The intent is to remove the callbacks from
>   struct device_driver, and unconditionally call through the bus. (That's
>   what all buses with drivers that implement those functions do today.)
> 
>   The methods are called for each device in the global device list, in
>   a reverse order (so children are saved before parents).

What about passing the previous state to restore ? could be useful...

> - To struct bus_type:
> 
> 	int             (*pm_power)(struct device *, struct pm_state *);
> 
>   This method is used to do all power transitions, including both
>   shutdown/reset and device power management states.

Who calls it ? It's the driver calling it's bus or what ? It make no
sense to power manage a device before suspending activity... I agree it
may be worth splitting dev_start/stop from PM transitions proper, that
would help dealing with various policies, however, there are still some
dependencies between those, and they all need to be tied to the bus
topology. 

> The 2nd argument to ->pm_save() and ->pm_power() is determined by mapping
> an enumerated system power state to a static array of 'struct pm_state'
> pointers, that is in dev->power.pm_system. The pointers in that array
> point to entries in dev->power.pm_supports, which is an array of all the
> device power states that device supports. Please see include/linux/pm.h in
> the patch below. These arrays should be initialized by the bus, though
> they can be fixed up by the individual drivers, should they have a
> different set of states they support, or given user policy.
> 
> The actual value of the 'struct pm_state' instances is driver-specific,
> though again, the bus drivers should provide the set of power states valid
> for that bus. For example:

I have to ponder that a bit more, but it looks like it's going to the
right direction. 

> struct pm_state {
>         char    * name;
>         u32     state;
> };
> 
> #define decl_state(n, s) \
>         struct pm_state pm_state_##n = {        \
>                 .name   = __stringify(n),       \
>                 .state  = s,                    \
>         }
> 
> drivers/pci/ should do:
> 
> decl_state(d0, PCI_PM_CAP_PME_D0);
> EXPORT_SYMBOL(pm_state_d0);
> 
> decl_state(d1, PCI_PM_CAP_PME_D1);
> EXPORT_SYMBOL(pm_state_d1);
> 
> decl_state(d2, PCI_PM_CAP_PME_D2);
> EXPORT_SYMBOL(pm_state_d2);
> 
> decl_state(d3, PCI_PM_CAP_PME_D3);
> EXPORT_SYMBOL(pm_state_d3);
> 
> 
> This provides a meaningful tag to each state that is completely local to
> the bus, but can be handled easily by the core.
> 
> To handle runtime power management, a set of sysfs files will be created,
> inclding 'current' and 'supports'. The latter will display all the
> possible states the device supports, as specified its ->power.pm_supports
> array, in an attractive string format. 'current' will display the current
> power state, as an ASCII string. Writing to this file will look up the
> state requested in ->pm_supports, and if found, translate that into the
> device-specific power state and suspend the device.
> 
> The patches to implement that, as well as initial PCI support and system
> power support, will hopefuly eek out in the next week..

What about partial tree ? We need to suspend childs first and we need to
tied PM transition with dev_start/stop (or have some way to indicate the
device we want it to auto-resume when it gets a request, or something).
We need to work out policy a bit more here I suppose...


