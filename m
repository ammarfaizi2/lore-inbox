Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbTAQUFh>; Fri, 17 Jan 2003 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTAQUFg>; Fri, 17 Jan 2003 15:05:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61191 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267655AbTAQUFf>; Fri, 17 Jan 2003 15:05:35 -0500
Date: Fri, 17 Jan 2003 20:14:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initcall / device model meltdown?
Message-ID: <20030117201432.G13888@flint.arm.linux.org.uk>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030117192356.F13888@flint.arm.linux.org.uk> <Pine.LNX.4.44.0301171342410.15056-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301171342410.15056-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Fri, Jan 17, 2003 at 01:56:07PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 01:56:07PM -0600, Kai Germaschewski wrote:
> o Make the init order not matter. That is, make sure that the registration
>   routines ("pci_register_driver()") can be run safely even before
>   the corresponding __initcall() has executed. E.g. have 
>   pci_register_driver() only add the driver to a (statically initialized)
>   list of drivers. Then, when pci_init() gets executed, walk the list of
>   registered drivers, call ->probe() etc.

For each driver, you have up to two objects that have to be pre-initialised
and registered with the device model:

- the bus_type structure
- the device_class structure

The bus type is registered by the bus subsystem (eg, PCI), and the
device_class is registered by the driver subsystem (eg, input).

Until both of those have been initialised, you can't register the
driver (without oopsing.)  It isn't sufficient to wait for the bus
subsystem to be initialised, you need to wait for both the bus
and driver subsystems.

I suppose a solution would be for the device model could accept the
registration of a driver or device, but if the referenced objects
are not initialised, set a count of "objects requiring initialisation".

As each object is initialised, look for unregistered drivers and
decrement their initialisation count.  When it hits zero, finis the
driver registration.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

