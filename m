Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTHZPef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbTHZPef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:34:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:15248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262657AbTHZPeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:34:25 -0400
Date: Tue, 26 Aug 2003 08:31:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Russell King <rmk@arm.linux.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
In-Reply-To: <20030823184819.B1158@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0308260817190.942-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When a device "A" is registered with the driver model, we call
> device_add().  This adds the device to the bus, which calls any
> registered driver methods.  Once the device has been added to the
> bus, we add the device to the tail of the device power list.
> 
> In the case where a device driver for device "A" registers further
> devices, which are siblings of device "A", two things can happen:
> 
>  - If a driver is already registered for the device, we call its
>    probe method before we have added device "A" to the power lists.
>    Therefore, the siblings will be added to the tail of the device
>    power list _before_ the device "A" has been added.
> 
>  - If the driver registers after the device, the device "A" will be
>    added to the power list _before_ the siblings.
> 
> So in one case, we have PARENT SIBLING SIBLING SIBLING and in the
> other case we have SIBLING SIBLING SIBLING PARENT.

I haven't been ignoring you. I've been trying to figure exactly what 
you're talking about. Do you have a concrete example? Is it some PCMCIA 
driver, or some platform driver? 

I fail to see the problem, in theory, besides the driver itself. In the
case where the driver registers first, ->probe() will not be called until
it matches a device, which implies the device will have been added before
->probe() is called.

Also, I think I initially misunderstood your vocabulary. Each SIBLING is a
sibling of one another, but are CHILDREN of the PARENT. Right?

> Now, we do have this pm_users thing which seems to imply that it
> describes the relationship between two devices.  However, its non-
> functional.  It operates on a per-device variable called "pm_users"
> which is only ever _written_ !

Hey, I hadn't finished that part, because I considered fixing the system 
power management interface more important that day. 

It works like this: 

- A driver is able to set ->power.pm_parent for a device by calling 
  device_pm_set_parent() after its registered. By default, pm_parent is 
  set to the phsyical parent of the device. 

- A device with other devices that are dependent on it for power has a 
  positive pm_users count. 

- A device may only be suspended when pm_users == 0. 

- When a device is suspended, the pm_users count of its pm_parent is 
  decremented, and incremented when the device is resumed. 

- device_suspend() makes multiple passes over the device list, in case
  power dependencies cause some devices to be deferred. It fails with an 
  error (and resumes all suspended devices) if a pass was made in which 
  no devicse were suspended, but there are still devices with a positive
  pm_users count. 

Sound good? 


	Pat

