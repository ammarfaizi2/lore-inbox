Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275406AbTHNRcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273389AbTHNRcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:32:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37166 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S275422AbTHNRaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:30:01 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
References: <m1he4kzpiy.fsf@frodo.biederman.org>
	<20030814085442.A21232@infradead.org>
	<20030814090605.A25516@flint.arm.linux.org.uk>
	<m17k5gz1aq.fsf@frodo.biederman.org>
	<20030814170721.B332@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2003 11:26:04 -0600
In-Reply-To: <20030814170721.B332@flint.arm.linux.org.uk>
Message-ID: <m1wudgxiab.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Thu, Aug 14, 2003 at 09:50:05AM -0600, Eric W. Biederman wrote:
> > Russell King <rmk@arm.linux.org.uk> writes:
> > > That's likely to remove the keyboard driver, and some people like
> > > to configure their box so that ctrl-alt-del halts the system, and
> > > a further ctrl-alt-del reboots the system once halted.
> > 
> > Hmm.  That is a very weird case.  Semantically the keyboard driver
> > and everything else should be removed in any case.
> 
> I don't view it as "really weird" - it's something I've always done
> with 2.2 and 2.4, and in fact the first thing I do when I get a machine
> is to modify the inittab to halt the machine on ctrl-alt-del.
>
> It's far safer than hitting ctrl-alt-del and trying to power the machine
> off at the exact moment it reboots.
> 
> However, sometimes you want it to reboot, and in this case its far
> simpler to wait for the machine to halt, and then use ctrl-alt-del
> again.  It's something that's been supported by both the kernel and
> init for eons.

This sounds reasonable.  Something that needs to happen is we need
to distinguish clearly, between the semantics of a halt and reboot.

For a soft reboot to be safe we need to shutdown all of the drivers.

However what does it mean to call halt?  
There are two possibilities. 
-  A frozen in amber state where the kernel just sits in a busy loop,
   and possibly the system is powered off, nothing new can be stared
   but a few remaining things continue on.
-  Everything happens like a reboot except we don't transition to
   any other code.

So to be clear the cases we have to get semantics straight for are.

	case LINUX_REBOOT_CMD_RESTART:
        /* This is a reboot and things are fairly clear */

	case LINUX_REBOOT_CMD_RESTART2:
        /* This is the reboot case and it is fairly clear what needs to
         * happen there.  Of the two this case is biased towards
         * returning to the firmware if there need to be any differences.
         */

	case LINUX_REBOOT_CMD_HALT:
        /* this is the generic halt case and the most confusing.


	case LINUX_REBOOT_CMD_POWER_OFF:
        /* This is the power off case and similarly confusing. */

I think my vote goes for a frozen in amber state where the drivers
do nothing except for the little bit of code in machine_halt or
machine_power_off, which are practically noops, on x86.  And as long
as input is event interrupt driven you can do something with it.

I like it because doing absolutely nothing is very much KISS and easy
to get right.

> > After device_shutdown is called it is improper for any driver
> > to be handling interrupts because the are supposed to be in a quiescent
> > state.  And if they are not it is likely to break a soft reboot.
> 
> I guess then this is another bug we need to add to the list of bugs
> introduced during 2.5 into 2.6 then...

If the kernel should just go into some form of busy loop when halt
is called, I agree that calling device_shutdown on halt is a bug.  
If a halt is just a reboot where we don't do anything afterwards then
2.6 is correct, and the init example is unsupportable.

Possibly what is required is another case of sys_reboot so we can have
both semantics but that feels like over kill.

> If it is changing, then someone needs to get that information into
> davej's document.

I will have to look, I am not up to speed on that one.

> > Russell do you have any objects to always calling shutdown before
> > remove?   I don't think this looses knowledge and in most cases it should
> > work, but if there are bus devices were we need to do things significantly
> > differently I am open to other solutions.
> 
> The way I'm treating ->shutdown at present is that it is the final call
> to the device driver.  Once this call has been made, the bus driver
> puts the bus into the correct state for reboot, and the device driver
> must not attempt to access it.

I agree with that interpretation of ->shutdown.  And that is why
I contend it is wrong to access the keyboard controller after
device_shutdown is called.   Because device_shutdown calls ->shutdown
on every device.  In that case all ->remove could legitimately do in
remove is to free the device data structures.

I think calling ->shutdown, ->remove when a device goes away or when
we remove the module is compatible with the current semantics of
->shutdown.  Although we might need to update a driver or two of the
set that has already implemented a ->shutdown method.  But I don't
think that case is terribly likely to cause problems in practice.

Eric
