Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbUKXHO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUKXHO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbUKXHO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:14:57 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:55653 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262264AbUKXHOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Wed, 24 Nov 2004 02:05:10 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/11] New input patches
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240205.10502.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have some more input patches that I'd like you to comment on.

01-atkbd-keycode-size.patch
         Fix keycode table size initialization that got broken by my changes
         that exported 'set' and other settings via sysfs.
         setkeycodes should work again now.      

02-psmouse-polling.patch
         Trying to work around KVMs that suppress 0xAA 0x00 when switching
         mouse off and on by periodically sending ENABLE command to the
         mouse. The idea is that if KVM disconnects mouse the command will
         time out or we get NAK. Next time we see data coming from the mouse
         we will force reconnect. The advantages is that we can reconnect
         even if mouse uses PS2++ kind of protocol.
         Seems to work fine for several people.

03-serio-drvdata.patch
         Remove serio->private in favor of using driver-specific data
         in device structure, add serio_get_drvdata/serio_put_drvdata
         to access it so serio bus code looks more like other buses.

04-twidjoy-build.patch
         Make Kconfig and Makefile agree on the option name so twidjoy
         can be built.

05-serio-id-match.patch
         replace serio's type field with serio_id structure and
         add ids table to serio drivers. This will allow splitting
         initial matching and probing routines for better sysfs
         integration.

06-serio-bus-cleanup.patch
         make serio implementation more in line with standard
         driver model implementations by removing explicit device
         and driver list manipulations and introducing bus_match
         function. serio_register_port is always asynchronous to
         allow freely registering child ports. When deregistering
         serio core still takes care of destroying children ports
         first.

07-input-msecs-to-jiffies.patch
         Use msecs_to_jiffies instead of homegrown ms_to_jiffies
         so everything works when HZ != 1000

08-atkbd-msecs-to-jiffies.patch
         Use msecs_to_jiffies instead of manually calculating
         delay for Toshiba bouncing keys workaround.
         
09-gameport-rename1.patch
         rename gameport->driver to gameport->port_data in preparation
         to sysfs integration.

10-gameport-rename2.patch
	 more renames in serio in preparations to sysfs integration
         - gameport_dev -> gameport_driver
         - gameport_[un]register_device -> gameport_[un]register_driver

11-gameport-openclose-mandatory.patch
         Make connect and disconnect methods mandatory for gameport
         drivers since that's where gameport_{open|close} are called
         from to actually bind driver to a port.

There are also patches from the previous batch that you have not pulled yet.
Please take a look. Thanks!

> 01-i8042-panicblink-cleanup.patch
>         Move panicbkink parameter definition together with the rest of i8042
>         module parameters, add description and entry in kernel-parameters.txt
> 
> 02-serio-start-stop.patch
>         Add serio start() and stop() methods to serio structure that are
>         called when serio port is about to be fully registered and when
>         serio port is about to be unregistered. These methods are useful
>         for drivers that share interrupt among several serio ports. In this
>         case interrupt can not be enabled/disabled in open/close methods
>         and it is very hard to determine if interrupt shoudl be ignored or
>         passed on.
> 
> 03-i8042-use-start-stop.patch
>         Make use of new serio start/stop methods to safely activate and
>         deactivate ports. Also unify as much as possible port handling
>         between KBD, AUX and MUX ports. Rename i8042_values into i8042_port.
> 
> 04-serio-suppress-dup-events.patch
>         Do not submit serio event into event queue if there is already one
>         of the same type for the same port in front of it. Also look for
>         duplicate events once event is processed. This should help with
>         disconnected ports generating alot of data and consuming memory for
>         events when kseriod gets behind and prevents constant rescans.
>         This also allows to remove special check for 0xaa in reconnect path
>         of interrupt handler known to cause problems with Toshibas keyboards.
> 
> 05-evdev-buffer-size.patch
>         Return -EINVAL from evdev_read when passed buffer is too small.
>         Based on patch by James Lamanna.
> 
> 06-ps2pp-mouse-name.patch
>         Set mouse name to "Mouse" instead of leaving it NULL when using
>         PS2++ protocol and don't have any other information (Wheel, Touchpad)
>         about the mouse.
> 
> 07-synaptics-toshiba-rate.patch
>         Toshiba Satellite KBCs have trouble handling data stream coming from
>         Synaptics at full rate (80 pps, 480 byte/sec) which causes keyboards
>         to pause or even get stuck. Use DMI to detect Satellites and limit
>         rate to 40 pps which cures keyboard.
>

-- 
Dmitry
