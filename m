Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUL0O22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUL0O22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 09:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUL0O22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 09:28:28 -0500
Received: from styx.suse.cz ([82.119.242.94]:11701 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261697AbUL0O15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 09:27:57 -0500
Date: Mon, 27 Dec 2004 15:28:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osld.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [bk patches] Long delayed input update
Message-ID: <20041227142821.GA5309@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First, let me apologize for sitting on these patches for so long, I hope
I'll be quicker next time.

Linus, please pull the input patches from

	bk://kernel.bkbits.net/vojtech/input

The patches are also available split out at

	bk://kernel.bkbits.net/vojtech/input

The most important changes are an added ALPS touchpad driver, factored
out PS/2 routines from atkbd and psmouse, and a reworked HID->input
mapping for USB devices.

The diffstat:

 Documentation/input/joystick-parport.txt     |   13 
 Documentation/kernel-parameters.txt          |    6 
 MAINTAINERS                                  |   17 
 drivers/Makefile                             |    4 
 drivers/char/keyboard.c                      |   33 +
 drivers/input/gameport/emu10k1-gp.c          |    3 
 drivers/input/joydev.c                       |    6 
 drivers/input/joystick/Kconfig               |    2 
 drivers/input/joystick/gamecon.c             |  192 ++++-----
 drivers/input/joystick/iforce/iforce-main.c  |    4 
 drivers/input/joystick/iforce/iforce-serio.c |   18 
 drivers/input/joystick/iforce/iforce.h       |    2 
 drivers/input/joystick/magellan.c            |   24 -
 drivers/input/joystick/spaceball.c           |   24 -
 drivers/input/joystick/spaceorb.c            |   24 -
 drivers/input/joystick/stinger.c             |   24 -
 drivers/input/joystick/tmdc.c                |    2 
 drivers/input/joystick/twidjoy.c             |   20 
 drivers/input/joystick/warrior.c             |   24 -
 drivers/input/keyboard/atkbd.c               |  283 +++++++++----
 drivers/input/keyboard/lkkbd.c               |   24 -
 drivers/input/keyboard/newtonkbd.c           |   24 -
 drivers/input/keyboard/sunkbd.c              |   24 -
 drivers/input/keyboard/xtkbd.c               |   24 -
 drivers/input/misc/Kconfig                   |    2 
 drivers/input/misc/uinput.c                  |    3 
 drivers/input/mouse/Kconfig                  |    2 
 drivers/input/mouse/logips2pp.c              |    2 
 drivers/input/mouse/psmouse-base.c           |  310 +++++++++-----
 drivers/input/mouse/psmouse.h                |   40 +
 drivers/input/mouse/sermouse.c               |   24 -
 drivers/input/mouse/synaptics.c              |   54 +-
 drivers/input/mouse/vsxxxaa.c                |   24 -
 drivers/input/mousedev.c                     |  237 ++++++++---
 drivers/input/serio/Kconfig                  |   16 
 drivers/input/serio/Makefile                 |    1 
 drivers/input/serio/ambakmi.c                |   40 +
 drivers/input/serio/ct82c710.c               |  106 ++--
 drivers/input/serio/gscps2.c                 |   62 +-
 drivers/input/serio/i8042-io.h               |   31 +
 drivers/input/serio/i8042.c                  |  353 +++++++++-------
 drivers/input/serio/i8042.h                  |    7 
 drivers/input/serio/maceps2.c                |   86 ++--
 drivers/input/serio/parkbd.c                 |   47 +-
 drivers/input/serio/pcips2.c                 |   52 +-
 drivers/input/serio/q40kbd.c                 |  117 ++++-
 drivers/input/serio/rpckbd.c                 |   50 +-
 drivers/input/serio/sa1111ps2.c              |   39 +
 drivers/input/serio/serio.c                  |  576 +++++++++++++++++++++------
 drivers/input/serio/serio_raw.c              |  390 ++++++++++++++++++
 drivers/input/serio/serport.c                |   49 +-
 drivers/input/touchscreen/gunze.c            |   24 -
 drivers/input/touchscreen/h3600_ts_input.c   |   24 -
 drivers/input/tsdev.c                        |  301 ++++++++------
 drivers/serial/sunsu.c                       |   89 ++--
 drivers/serial/sunzilog.c                    |   80 ++-
 drivers/usb/input/hid-core.c                 |  104 ++--
 drivers/usb/input/hiddev.c                   |   17 
 fs/compat_ioctl.c                            |    2 
 include/asm-ppc/8253pit.h                    |   10 
 include/asm-ppc64/8253pit.h                  |   10 
 include/linux/compat_ioctl.h                 |   17 
 include/linux/input.h                        |    2 
 include/linux/serio.h                        |   66 ++-
 64 files changed, 3003 insertions(+), 1284 deletions(-)

The list of changesets:

ChangeSet@1.1957.1.26, 2004-10-27 01:11:44-05:00, dtor_core@ameritech.net
  Input: parkbd - switch to using module_param. Parameter names are
         parkbd.port and parkbd.mode
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.25, 2004-10-21 23:57:49-05:00, dtor_core@ameritech.net
  Input: gscps2 - remove unused statically allocated gscps2_serio_port
         variable as the port is allocated dynamically.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.24, 2004-10-21 23:56:41-05:00, dtor_core@ameritech.net
  Input: get rid of pm_dev in input core as it is deprecated and
         nothing uses it anyway.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.23, 2004-10-21 23:55:41-05:00, dtor_core@ameritech.net
  Input: i8042 - get rid of reboot notifier as suspend method
         should do the job.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.22, 2004-10-21 23:53:52-05:00, dtor_core@ameritech.net
  Input: i8042 - get rid of old style power management handler since
         APM calls both pm_send and device_suspend.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.21, 2004-10-21 23:52:36-05:00, dtor_core@ameritech.net
  Input: i8042 - allow turning debugging on and off "on-fly"
         so people do not have to recompile their kernels to
         provide debug info.
  
         Adds new parameter i8042.debug also accessible through
         sysfs. 
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.20, 2004-10-21 23:51:43-05:00, dtor_core@ameritech.net
  Input: when creating input devices for hardware attached to
         a serio port properly set input_device->dev pointer
         so when corresponding class device is created it will
         show proper links to parent device and driver in sysfs
         hierarchy.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.19, 2004-10-21 23:50:25-05:00, dtor_core@ameritech.net
  Input: evdev, joydev, mousedev, tsdev - remove class device and devfs
         entry when hardware driver disconnects instead of waiting for
         the last user to drop off. This way hardware drivers can be
         unloaded at any time.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.18, 2004-10-21 23:49:17-05:00, dtor_core@ameritech.net
  Input: couple of whitespace fixes.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.15, 2004-10-20 10:13:15+02:00, vojtech@suse.cz
  input: Increase ACK timeouts in libps2 in case the RESET_BAT command is used.
         This should fix most Synaptics "reset failed" cases. Thanks to Keith
         Packard for the report.
         Also add some more keyboard IDs, so that unusual keyboards are accepted
         by libps2 and atkbd.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1957.1.14, 2004-10-19 12:58:36+02:00, vojtech@suse.cz
  Input: i8042 ACPI enumeration - add PNP IDs found in AMD64 laptops.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1957.1.12, 2004-10-16 13:15:38+02:00, vojtech@suse.cz
  input: Fix ssize_t prototype mismatch in psmouse and atkbd.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1957.1.9, 2004-09-30 01:31:12-05:00, dtor_core@ameritech.net
  Input: psmouse - explicitely specify packet size instead of relying
         on protocol numbering scheme. Make protocol detection routines
         return -1 on failure to keep them consistent with ther rest
         of the code. Set mouse parameters right in detection routines
         instead of doing it in psmouse_extensions.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.8, 2004-09-30 01:30:25-05:00, dtor_core@ameritech.net
  Input: psmouse - make logips2pp fully decode its protocol packets
         and not rely on generic handler to finish job.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.7, 2004-09-30 01:28:49-05:00, dtor_core@ameritech.net
  Input: psmouse - drop PS2TPP protocol (it is handled exactly like
         PS2PP) to free spot for THINKPS protocol and keep old protocol
         numbers for binary compatibility with Synaptics/ALPS touchpad
         driver for X.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.6, 2004-09-30 01:28:03-05:00, dtor_core@ameritech.net
  Input: psmouse - export rate, resolution, resetafter and smartscroll
         (Logitech only) as individual mouse attributes (sysfs) and allow
         them to be set/changed independently for each mouse:
  
           echo -n "100" > /sys/bus/serio/devices/serio0/rate
           echo -n "200" > /sys/bus/serio/devices/serio0/resolution
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.5, 2004-09-30 01:27:24-05:00, dtor_core@ameritech.net
  Input: psmouse - reset mouse before doing intellimouse/explorer
         probes in case it got confused by earlier probes; switch
         to streaming mode before setting scale and resolution,
         otherwise some KVMs get confused.
  
  Patch-by: Marko Macek <Marko.Macek@gmx.net>
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.4, 2004-09-30 01:26:43-05:00, dtor_core@ameritech.net
  Input: synaptics - not only switch to 4-byte client protocol
         but also revert to 3-byte mode if client selected lower
         protocol.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru> 

ChangeSet@1.1957.1.3, 2004-09-30 01:25:47-05:00, dtor_core@ameritech.net
  Input: psmouse - add set_rate and set_resolution handlers to make
         adding new protocols easier and remove special knowledge
         from psmouse-base.c
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1957.1.2, 2004-09-30 01:24:59-05:00, dtor_core@ameritech.net
  Input: add a new signature for ALPS DualPoint found in
         Dell Inspiron 8500
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1958, 2004-09-24 12:26:54+02:00, jbglaw@lug-owl.de
  input: More comment fixes in lkkbd.c
  
  Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1957, 2004-09-24 11:40:14+02:00, bjorn.helgaas@hp.com
  Input: Add ACPI-based i8042 keyboard and aux controller enumeration; can be
  disabled by passing i8042.noacpi as a boot parameter.
  
  Original code by Bjorn Helgaas <bjorn.helgaas@hp.com>, reworked by
  Dmitry Torokhov <dtor@mail.ru>, FixedIO support from Hans-Frieder Vogt
  <hfvogt@gmx.net>
  
  Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1956, 2004-09-24 11:36:34+02:00, jbglaw@lug-owl.de
  Input: correct the the wrong use of "DB9" to the correct name, "DE9". 
         Also, some comments/debugging output is fixed up.
  
  Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1955, 2004-09-24 10:30:25+02:00, lenz@cs.wisc.edu
  input: Add LED definitions for PDAs.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Signed-off-by: John Lenz <lenz@cs.wisc.edu>

ChangeSet@1.1952, 2004-09-23 13:01:47+02:00, mochel@digitalimplant.org
  input: Remove calls to pm_access() and pm_dev_idle() from input.c, as
         they're empty functions anyway.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Patch-by: Patrick Mochel <mochel@digitalimplant.org>

ChangeSet@1.1951, 2004-09-23 12:59:31+02:00, vojtech@suse.cz
  input: Tidy up & fix the hid-input.c driver. Dual-wheel A4 mice don't report the phantom
           button anymore, D-Pads are mapped to Hat-switches, debug can print HID->Input
           mappings, more mappings added, devices with reports larger than MaxPacketSize
           work again.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1949.1.1, 2004-09-22 22:35:49-05:00, dtor_core@ameritech.net
  Input: clean up ALPS DualPoint logic
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1949, 2004-09-22 10:46:32+02:00, vojtech@suse.cz
  input: More IOWarrior blacklist entries in hid.c, rearranging the
         blacklist back to alphabetic order.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1948, 2004-09-22 01:50:38-05:00, dtor_core@ameritech.net
  Input: atkbd - export extra, scroll, set, softrepeat and softraw as individual
         keyboard attributes (sysfs) and allow them to be set/changed independently
         for each keyboard:
  
         echo -n "2" > /sys/bus/serio/devices/serio1/set
         echo -n "1" > /sys/bus/serio/devices/serio1/softrepeat
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru> 

ChangeSet@1.1947, 2004-09-22 01:49:31-05:00, dtor_core@ameritech.net
  Input: add serio_[un]pin_driver() functions so attribute handlers
         can safely access driver bound to a serio port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1946, 2004-09-22 01:48:40-05:00, dtor_core@ameritech.net
  Input: pull common code from psmouse and atkbd into libps2 module
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1945, 2004-09-21 16:12:18+02:00, vojtech@suse.cz
  input: Add AT-compatible rawmode generation for ARM.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Patch-by: Woody Suwalski <woodys@xandros.com>

ChangeSet@1.1944, 2004-09-21 15:48:50+02:00, petero2@telia.com
  input: Add ALPS touchpad driver, driver by Neil Brown, Peter Osterlund
         and Dmitry Torokhov, some fixes by Vojtech Pavlik.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Patch-by: Peter Osterlund <petero2@telia.com>

ChangeSet@1.1943, 2004-09-21 15:27:54+02:00, pmaydell@chiark.greenend.org.uk
  input: Add support for Kensington ThinkingMouse PS/2 protocol.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Patch-by: Peter Maydell <pmaydell@chiark.greenend.org.uk>

ChangeSet@1.1942, 2004-09-21 10:04:06+02:00, vojtech@suse.cz
  input: Some HID devices have problems returning the HID class descriptor.
         Try a few times before giving up.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1940, 2004-09-21 09:24:21+02:00, pnelson@suse.cz
  input: Fix oops in gamecon
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Patch-by: Peter Nelson <pnelson@andrew.cmu.edu>

ChangeSet@1.1939, 2004-09-19 13:46:50+02:00, olh@suse.de
  input: Joydump depends on gameport
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Patch-by: Olaf Hering <olh@suse.de>


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
