Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVAMPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVAMPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVAMPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:38:10 -0500
Received: from styx.suse.cz ([82.119.242.94]:38865 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261665AbVAMPfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:35:06 -0500
Date: Thu, 13 Jan 2005 16:36:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050113153644.GA18939@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412290217.36282.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 02:17:36AM -0500, Dmitry Torokhov wrote:
> Hi Vojtech,
> 
> Please take a look at the following input patches. Patches 1-9 are already
> in my tree (and were there for quite some time so they should have gotten
> at least some testing as Andrew automatically pulls from me) and I'd like
> see them pushed to Linus together with your last batch. At least patches
> 6, 8 and 9 fix bugs introduced by latest changes. Patch 7 should help owners
> of Toshibas with Synaptics touchpads.
> 
> 01-i8042-panicblink-cleanup.patch
> 	Move panicblink parameter definition together with the rest of i8042
> 	module parameters, add description and entry in kernel-parameters.txt

I think I prefer the DELAY definition to be outside the function. Other
than that the patch is OK.

> 02-serio-start-stop.patch
> 	Add serio start() and stop() methods to serio structure that are
> 	called when serio port is about to be fully registered and when
> 	serio port is about to be unregistered. These methods are useful
> 	for drivers that share interrupt among several serio ports. In this
> 	case interrupt can not be enabled/disabled in open/close methods
> 	and it is very hard to determine if interrupt shoudl be ignored or
> 	passed on.

> 03-i8042-use-start-stop.patch
> 	Make use of new serio start/stop methods to safely activate and
> 	deactivate ports. Also unify as much as possible port handling
> 	between KBD, AUX and MUX ports. Rename i8042_values into i8042_port.

Would we need this at all if we made the port registration completely
asynchronous, only binding devices to ports _after_ the port is
completely registered?

I'm rather reluctant to add even more callbacks.

> 04-serio-suppress-dup-events.patch
> 	Do not submit serio event into event queue if there is already one
> 	of the same type for the same port in front of it. Also look for
> 	duplicat events once event is processed. This should help with
> 	disconnected ports generating alot of data and consuming memory for
> 	events when kseriod gets behind and prevents constant rescans.
> 	This also allows to remove special check for 0xaa in reconnect path
> 	of interrupt handler known to cause problems with Toshibas keyboards.

Ok. Since we'll be usually scanning an empty list, this shouldn't add
any overhead.

Btw, why do we need _both_ to scan for duplicate events on event
completion and check at event insert time? One should be enough - if we
always check, then we cannot have duplicate events and if we always are
able to deal with them, we don't have to care ...

> 05-evdev-buffer-size.patch
> 	Return -EINVAL from evdev_read when passed buffer is too small.
> 	Based on patch by James Lamanna.

OK.

> 06-ps2pp-mouse-name.patch
> 	Set mouse name to "Mouse" instead of leaving it NULL when using
> 	PS2++ protocol and don't have any other information (Wheel, Touchpad)
> 	about the mouse.

Already merged.

> 07-synaptics-toshiba-rate.patch
> 	Toshiba Satellite KBCs have trouble handling data stream coming from
> 	Synaptics at full rate (80 pps, 480 byte/sec) which causes keyboards
> 	to pause or even get stuck. Use DMI to detect Satellites and limit
> 	rate to 40 pps which cures keyboard.

OK.

> 08-atkbd-keycode-size.patch
> 	Fix keycode table size initialization that got broken by my changes
> 	that exported 'set' and other settings via sysfs.
> 	setkeycodes should work again now.

Already merged.

> 09-i8042-sysfs-permissions.patch
> 	Fix braindamage in sysfs permissions for 'debug' option.

OK.

> 10-twidjoy-build.patch
> 	Make Kconfig and Makefile agree on the option name so twidjoy
> 	can be built.

OK.

> 11-input-msecs-to-jiffies.patch
> 	Use msecs_to_jiffies instead of homegrown ms_to_jiffies
> 	so everything works when HZ != 1000

OK.

> 12-atkbd-msecs-to-jiffies.patch
> 	Use msecs_to_jiffies instead of manually calculating
> 	delay for Toshiba bouncing keys workaround so it works
>         when HZ != 1000.

OK.

> 13-serio-drvdata.patch
> 	Remove serio->private in favor of using driver-specific data
> 	in device structure, add serio_get_drvdata/serio_put_drvdata
> 	to access it so serio bus code looks more like other buses.

OK.

> 14-serio-id-match.patch
> 	Replace serio's type field with serio_id structure and
> 	add ids table to serio drivers. This will allow splitting
> 	initial matching and probing routines for better sysfs
> 	integration.

OK. Maybe we should add a new SPIOCSTYPE ioctl to pass the structure
directly.

> 15-serio-bus-cleanup.patch
> 	Make serio implementation more in line with standard
> 	driver model implementations by removing explicit device
> 	and driver list manipulations and introducing bus_match
> 	function. serio_register_port is always asynchronous to
> 	allow freely registering child ports. When deregistering
> 	serio core still takes care of destroying children ports
> 	first.

OK. I suppose the synchronous unregister variant is needed for module
unload? I suppose refcounting would be enough there ... 

> 16-serio-connect-errcode.patch
> 	Make serios' connect methods return error code instead of
>         void so exact cause of failur can be comminicated upstream. 

OK.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
