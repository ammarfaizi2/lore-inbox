Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbUL2Hdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUL2Hdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUL2Hdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:33:40 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:10927 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261374AbUL2HdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/16] New set of input patches
Date: Wed, 29 Dec 2004 02:17:36 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290217.36282.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

Please take a look at the following input patches. Patches 1-9 are already
in my tree (and were there for quite some time so they should have gotten
at least some testing as Andrew automatically pulls from me) and I'd like
see them pushed to Linus together with your last batch. At least patches
6, 8 and 9 fix bugs introduced by latest changes. Patch 7 should help owners
of Toshibas with Synaptics touchpads.

01-i8042-panicblink-cleanup.patch
	Move panicblink parameter definition together with the rest of i8042
	module parameters, add description and entry in kernel-parameters.txt

02-serio-start-stop.patch
	Add serio start() and stop() methods to serio structure that are
	called when serio port is about to be fully registered and when
	serio port is about to be unregistered. These methods are useful
	for drivers that share interrupt among several serio ports. In this
	case interrupt can not be enabled/disabled in open/close methods
	and it is very hard to determine if interrupt shoudl be ignored or
	passed on.

03-i8042-use-start-stop.patch
	Make use of new serio start/stop methods to safely activate and
	deactivate ports. Also unify as much as possible port handling
	between KBD, AUX and MUX ports. Rename i8042_values into i8042_port.

04-serio-suppress-dup-events.patch
	Do not submit serio event into event queue if there is already one
	of the same type for the same port in front of it. Also look for
	duplicat events once event is processed. This should help with
	disconnected ports generating alot of data and consuming memory for
	events when kseriod gets behind and prevents constant rescans.
	This also allows to remove special check for 0xaa in reconnect path
	of interrupt handler known to cause problems with Toshibas keyboards.

05-evdev-buffer-size.patch
	Return -EINVAL from evdev_read when passed buffer is too small.
	Based on patch by James Lamanna.

06-ps2pp-mouse-name.patch
	Set mouse name to "Mouse" instead of leaving it NULL when using
	PS2++ protocol and don't have any other information (Wheel, Touchpad)
	about the mouse.

07-synaptics-toshiba-rate.patch
	Toshiba Satellite KBCs have trouble handling data stream coming from
	Synaptics at full rate (80 pps, 480 byte/sec) which causes keyboards
	to pause or even get stuck. Use DMI to detect Satellites and limit
	rate to 40 pps which cures keyboard.

08-atkbd-keycode-size.patch
	Fix keycode table size initialization that got broken by my changes
	that exported 'set' and other settings via sysfs.
	setkeycodes should work again now.

09-i8042-sysfs-permissions.patch
	Fix braindamage in sysfs permissions for 'debug' option.

10-twidjoy-build.patch
	Make Kconfig and Makefile agree on the option name so twidjoy
	can be built.

11-input-msecs-to-jiffies.patch
	Use msecs_to_jiffies instead of homegrown ms_to_jiffies
	so everything works when HZ != 1000

12-atkbd-msecs-to-jiffies.patch
	Use msecs_to_jiffies instead of manually calculating
	delay for Toshiba bouncing keys workaround so it works
        when HZ != 1000.

13-serio-drvdata.patch
	Remove serio->private in favor of using driver-specific data
	in device structure, add serio_get_drvdata/serio_put_drvdata
	to access it so serio bus code looks more like other buses.

14-serio-id-match.patch
	Replace serio's type field with serio_id structure and
	add ids table to serio drivers. This will allow splitting
	initial matching and probing routines for better sysfs
	integration.

15-serio-bus-cleanup.patch
	Make serio implementation more in line with standard
	driver model implementations by removing explicit device
	and driver list manipulations and introducing bus_match
	function. serio_register_port is always asynchronous to
	allow freely registering child ports. When deregistering
	serio core still takes care of destroying children ports
	first.

16-serio-connect-errcode.patch
	Make serios' connect methods return error code instead of
        void so exact cause of failur can be comminicated upstream. 

Let me know which ones will you take and I will push them to my tree as
well.

Thanks!

-- 
Dmitry
