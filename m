Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbSJMX7A>; Sun, 13 Oct 2002 19:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbSJMX7A>; Sun, 13 Oct 2002 19:59:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33655 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261771AbSJMX67>; Sun, 13 Oct 2002 19:58:59 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210132310.QAA01044@adam.yggdrasil.com>
	<20021014001552.Q23142@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 18:03:28 -0600
In-Reply-To: <20021014001552.Q23142@flint.arm.linux.org.uk>
Message-ID: <m1smz9lwdr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sun, Oct 13, 2002 at 04:10:01PM -0700, Adam J. Richter wrote:
> > 	I have no objection to replacing or supplementing the reboot
> > notifier chain with a method in struct device_driver, but let's not
> > overload these methods with ambiguous semantics.  I do not want to
> > call thirty functions that primarily return memory to various memory
> > allocators, mark a bunch of inodes as invalid, and otherwise arrange
> > things so that the kernel can smoothly continue to run user level
> > programs when, in fact, we just want to pull the reset line on the
> > computer.
> 
> And what about setups where you can't pull the reset line from software.
> I have several machines here like that.  And one of them needs software
> to talk to the cards to put them back into a sane state before rebooting.
> 
> "rebooting" in this particular case is "turn MMU off, jump to location 0"
And for x86 it is turn MMU off, jump to location 0xffff0.
 
> And I never said anything about needing to allocate memory to do this.
> I agree with you that suspending devices on reboot _is_ silly.  However,
> that's not what I was proposing.
> 

Documentation/driver-mode/devices.txt says:

>         int     (*remove)       (struct device * dev);
> 
> remove is called to dissociate a driver with a device. This may be
> called if a device is physically removed from the system, if the
> driver module is being unloaded, or during a reboot sequence. 
> 
> It is up to the driver to determine if the device is present or
> not. It should free any resources allocated specifically for the
> device; i.e. anything in the device's driver_data field. 
> 
> If the device is still present, it should quiesce the device and place
> it into a supported low-power state.

So there is a little bit that deals with a low power state.  

At any rate until someone changes the kernel API again ->remove()
is the proper method to be calling in this case.  

Eric
