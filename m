Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbSJMWZd>; Sun, 13 Oct 2002 18:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJMWZd>; Sun, 13 Oct 2002 18:25:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61702 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261665AbSJMWZc>; Sun, 13 Oct 2002 18:25:32 -0400
Date: Sun, 13 Oct 2002 23:31:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Message-ID: <20021013233119.O23142@flint.arm.linux.org.uk>
References: <200210132214.PAA00953@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210132214.PAA00953@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Oct 13, 2002 at 03:14:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 03:14:27PM -0700, Adam J. Richter wrote:
> >There is a very good reason for calling the driver->remove() function
> >on a reboot so that we place the devices in a consistent state.  And
> >stop any on going DMA etc.
> 
> 	A warm reboot is supposed to do this by the platform dependent
> machine_restart(), and whatever processes machine_restart sets off
> (e.g., by making a RESET signal active).  If a device driver needs
> some special processing prior to that, that is what the reboot
> notifier chain is for.

I'd imagine the reboot notifier chain is going away - especially as
stuff would need to be shut down in the right order, which is one of
the reasons we have the device model.  It already knows the right
order.

> 	If you have a platform where, for example, somehow PCI devices
> are able to continue jabbering away after the computer has been reset,
> then that could probably be done more consistently for most drivers by
> having machine_restart on that platform walk the PCI bus and shut down
> everything (drivers that need to do something really special would
> still use the reboot notifier).

x86, I believe, is one example of such a platform that can leave PCI
devices jabbering over a warm reboot.

> 	device_shutdown and device_suspend are for power management.
> It is important to turn the device off as soon as possible if a power
> management routine has told you that the device is not going to be
> used any more.

I'd think the sane solution would be a device_reboot() call, and kill
off the reboot notifier.  That's just my opinion though, given that I
have some devices that definitely need this type of treatment.

I'd rather have one registration system for this type of device
management, not multiple random lists to register stuff with all over
the place.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

