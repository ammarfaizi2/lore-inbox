Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVATPuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVATPuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVATPsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:48:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58120 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262161AbVATPo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:44:26 -0500
Date: Thu, 20 Jan 2005 15:44:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial8250_init and platform_device
Message-ID: <20050120154420.D13242@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050120114328.A3110@flint.arm.linux.org.uk> <4D4277A8-6AF7-11D9-A0BF-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4D4277A8-6AF7-11D9-A0BF-000393DBC2E8@freescale.com>; from kumar.gala@freescale.com on Thu, Jan 20, 2005 at 09:23:56AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 09:23:56AM -0600, Kumar Gala wrote:
> No problem, let me try to clarify.  I'm trying to figure out in the ARM 
> case if there are 2 platform_devices that are registered and if this is 
> the desired behavior (and if so why?).

Yes.  The first (by serial8250_init) is the ISA compatibility platform
device, which registers the "old" static list of serial devices found
in include/asm-*/serial.h.

The second registers a platform device which contains the 8250 serial
devices for the particular platform.

> In serial8250_init() we call platform_device_register_simple(), this 
> will be one registration of a serial8250 device.  In my example of 
> vr1000, arch/arm/mach-s3c2410/cpu.c:s3c_arch_init() calls 
> platform_device_register, the 2nd time a serial8250 device is 
> registered.

Correct.

> > We then register the device driver, which allows us to pick up on the
> >  platform devices.  This causes the placeholder registrations to be
> >  reassigned to the platform devices on a first come first served basis
> >  via the standard registration call serial8250_register_port().
> 
> I'm not following you here, its not clear if you mean we have 2 
> platform devices registered in the system, but only one actually has 
> serial ports that are registered.

We have two platform devices registered - one representing the
compatibility devices, and one (or more) representing the platform's
own devices.

To illustrate this, let's assume your architecture always has ports at
a fixed set of addresses, and then has a set of platform specific ports.
You may wish to have one platform device for the platform common serial
devices which always gets registered.  Your platform specific
initialisation code could then register another platform device which
contains details of the platform specific serial devices.

> If you are using SERIAL_PORT_DFNS, 
> it will be the platform_device created in serial8250_init(), if you are 
> not it will be the platform_device created elsewhere?

Initially, all serial devices are attached to the platform device
created in serial8250_init(), whether or not they are listed in
SERIAL_PORT_DFNS or not.  Serial devices not listed in SERIAL_PORT_DFNS
remain in an unconfigured state.

When the 8250 platform device driver is registered, serial devices
are "stolen" from this "private" platform device, and are owned by
the platform device which registered them.

Lets take some examples:

1. SERIAL_PORT_DFNS contains port at 0x3f8, irq4, and we have space for
   4 serial ports.  No other platform devices are registered.

# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:unknown port:00000000 irq:0
2: uart:unknown port:00000000 irq:0
3: uart:unknown port:00000000 irq:0
# tree /sys/class/tty/ttyS*
/sys/class/tty/ttyS0
|-- dev
`-- device -> ../../../devices/platform/serial8250
/sys/class/tty/ttyS1
|-- dev
`-- device -> ../../../devices/platform/serial8250
/sys/class/tty/ttyS2
|-- dev
`-- device -> ../../../devices/platform/serial8250
/sys/class/tty/ttyS3
|-- dev
`-- device -> ../../../devices/platform/serial8250

2. SERIAL_PORT_DFNS contains port at 0x3f8, irq4, and we have space for
   4 serial ports.  A platform device also describing 0x3f8, irq 4 is
   registered.

# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:unknown port:00000000 irq:0
2: uart:unknown port:00000000 irq:0
3: uart:unknown port:00000000 irq:0
# tree /sys/class/tty/ttyS*
/sys/class/tty/ttyS0
|-- dev
|-- device -> ../../../devices/platform/serial82500
`-- driver -> ../../../bus/platform/drivers/serial8250
/sys/class/tty/ttyS1
|-- dev
`-- device -> ../../../devices/platform/serial8250
/sys/class/tty/ttyS2
|-- dev
`-- device -> ../../../devices/platform/serial8250
/sys/class/tty/ttyS3
|-- dev
`-- device -> ../../../devices/platform/serial8250

3. SERIAL_PORT_DFNS is empty, otherwise the same as case (2).  Results
   are identical to case (2).

HTH.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
