Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbTHZRwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbTHZRwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:52:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35332 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262833AbTHZRvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:51:52 -0400
Date: Tue, 26 Aug 2003 18:51:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
Message-ID: <20030826185147.H28810@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg KH <greg@kroah.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030823184819.B1158@flint.arm.linux.org.uk> <Pine.LNX.4.33.0308260817190.942-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0308260817190.942-100000@localhost.localdomain>; from mochel@osdl.org on Tue, Aug 26, 2003 at 08:31:55AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 08:31:55AM -0700, Patrick Mochel wrote:
> > So in one case, we have PARENT SIBLING SIBLING SIBLING and in the
> > other case we have SIBLING SIBLING SIBLING PARENT.
> 
> I haven't been ignoring you. I've been trying to figure exactly what 
> you're talking about. Do you have a concrete example? Is it some PCMCIA 
> driver, or some platform driver? 

It's a multi-function chip (again):

            sa1111 bus
    SA1111------+-------Interrupt controller
                +-------USB host
                +-------PS/2 ports

The SA1111 probe function registers devices whose parent is the SA1111
device.

In this case, we end up placing these devices on the list in the wrong
order.

At the point where the SA1111 probe function is called, the SA1111 device
is not on the dpm lists, because of the ordering in device_add().

When we add the USB host, PS/2 ports etc, their parent device has not
been added to the dpm lists.  Only after the SA1111 probe function
completes will the SA1111 device appear on the dpm lists, and in this
case it will appear _after_ the USB and PS/2 ports.

The effect of this is that when we do a device suspend, we suspend
the SA1111, then the PS/2 ports, then the USB host.  Unfortunately
this can't work because suspending the SA1111 prevents access to
these sub-devices.

> I fail to see the problem, in theory, besides the driver itself. In the
> case where the driver registers first, ->probe() will not be called until
> it matches a device, which implies the device will have been added before
> ->probe() is called.

This doesn't happen - take a careful look at device_add(), specifically
the order of bus_add_device() and device_pm_add().  We probe the device
_before_ we add it to the PM lists.

> > Now, we do have this pm_users thing which seems to imply that it
> > describes the relationship between two devices.  However, its non-
> > functional.  It operates on a per-device variable called "pm_users"
> > which is only ever _written_ !
> 
> Hey, I hadn't finished that part, because I considered fixing the system 
> power management interface more important that day. 
> 
> It works like this: 
> 
> - A driver is able to set ->power.pm_parent for a device by calling 
>   device_pm_set_parent() after its registered. By default, pm_parent is 
>   set to the phsyical parent of the device. 
> 
> - A device with other devices that are dependent on it for power has a 
>   positive pm_users count. 
> 
> - A device may only be suspended when pm_users == 0. 
> 
> - When a device is suspended, the pm_users count of its pm_parent is 
>   decremented, and incremented when the device is resumed. 
> 
> - device_suspend() makes multiple passes over the device list, in case
>   power dependencies cause some devices to be deferred. It fails with an 
>   error (and resumes all suspended devices) if a pass was made in which 
>   no devicse were suspended, but there are still devices with a positive
>   pm_users count. 
> 
> Sound good? 

It sounds more complicated than our old system, but I'm willing to give
it a go.  However, some drivers only want to be notified of resume events,
so this would involve more code to explicitly handle the suspend case in
such drivers.

Dunno, I'll wait until there's a patch available and see how well it fits.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

