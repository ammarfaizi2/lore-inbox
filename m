Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSHWJgZ>; Fri, 23 Aug 2002 05:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSHWJgZ>; Fri, 23 Aug 2002 05:36:25 -0400
Received: from [217.167.51.129] ([217.167.51.129]:22270 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S317034AbSHWJgY>;
	Fri, 23 Aug 2002 05:36:24 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Date: Fri, 23 Aug 2002 13:41:57 +0200
Message-Id: <20020823114157.29703@192.168.4.1>
In-Reply-To: <3D658F2C.1080400@mandrakesoft.com>
References: <3D658F2C.1080400@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, this only applies if you are slack and letting the kernel init 
>your ATA from scratch, instead of doing proper ATA initialization in 
>firmware ;-)

That will happen. Recent Apple's OF will reset all ATA devices before
booting the kernel, thus triggering the problem with some of them,
and ide-pmac will hard-reset (via the reset line) devices on boot
as well to avoid problems caused by bogus firmwares or machines booted
from MacOS who let the devices in whatever bogus/unknown state (possibly
SLEEP state).

I saw that happening on some embedded platforms as well.

I realy think the kernel should be able to do it all, and waiting
around the busy bit is neither complicated nor hamrful, so...
>
>Seriously, if you are a handed an ATA device that is actually in 
>operation when the kernel boots, you are already out of spec.  I would 
>prefer to barf if the BSY or DRDY bits are set, because taking over the 
>ATA bus while a device is in the middle of a command shouldn't be 
>happening at Linux kernel boot, ever.

It will happen when the device just got reset or powered up. It's really
a couple of lines to do that properly (see my other mail about the full
procedure I copied from Apple firmware that seem to work fine on all
HW I've tested so far).

Also, another issue we didn't deal with properly yet is PM. With non-APM
power management (like pmac, but probably also ACPI and some embedded
devices), the devices will be basically powered off during suspend, and
no firmware is here to put them back into life on wakeup. So you have to
redo the bringup, which, in some cases (like hotswap IDE bays on some
PowerBooks) probably involves re-running the probe procedure at least,
then re-setting up the device (SET_FEATURE dance)

Ben.


