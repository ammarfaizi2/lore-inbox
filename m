Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVIJWb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVIJWb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVIJWb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:31:57 -0400
Received: from styx.suse.cz ([82.119.242.94]:3748 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932337AbVIJWb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:31:56 -0400
Date: Sun, 11 Sep 2005 00:32:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/26] Input update
Message-ID: <20050910223217.GA23380@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here comes another input update, mostly fixes/workarounds to get oddball
hardware work nicely and cleanups.

Dmitry put all the patches into a GIT repository, ready for you to pull:

	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

The diffstat and list of changes follows:

----

 b/Documentation/kernel-parameters.txt            |    1 
 b/drivers/char/keyboard.c                        |    2 
 b/drivers/input/evdev.c                          |    2 
 b/drivers/input/joystick/iforce/iforce-packets.c |   32 --
 b/drivers/input/joystick/iforce/iforce-usb.c     |    1 
 b/drivers/input/keyboard/atkbd.c                 |   10 
 b/drivers/input/keyboard/sunkbd.c                |    2 
 b/drivers/input/mouse/Makefile                   |    2 
 b/drivers/input/mouse/alps.c                     |    2 
 b/drivers/input/mouse/logips2pp.c                |   12 
 b/drivers/input/mouse/psmouse-base.c             |   15 +
 b/drivers/input/mouse/psmouse.h                  |    1 
 b/drivers/input/mouse/trackpoint.c               |  297 +++++++++++++++++++++++
 b/drivers/input/mouse/trackpoint.h               |  147 +++++++++++
 b/drivers/input/serio/i8042-io.h                 |    6 
 b/drivers/input/serio/i8042-ip22io.h             |    2 
 b/drivers/input/serio/i8042-jazzio.h             |    2 
 b/drivers/input/serio/i8042-sparcio.h            |   12 
 b/drivers/input/serio/i8042-x86ia64io.h          |   22 -
 b/drivers/input/serio/i8042.c                    |  174 +++++++------
 b/drivers/usb/input/hid-core.c                   |   62 +++-
 b/drivers/usb/input/hid-debug.h                  |   17 +
 b/drivers/usb/input/hid-input.c                  |    1 
 b/drivers/usb/input/hid.h                        |    1 
 b/drivers/usb/input/hiddev.c                     |    1 
 b/include/linux/input.h                          |    8 
 drivers/char/keyboard.c                          |  109 ++++----
 drivers/input/mouse/logips2pp.c                  |    1 
 drivers/input/mouse/psmouse-base.c               |  117 +++++----
 drivers/input/mouse/psmouse.h                    |   49 ++-
 drivers/input/mouse/trackpoint.c                 |  183 +++++++-------
 drivers/input/serio/i8042-x86ia64io.h            |   50 ++-
 drivers/input/serio/i8042.c                      |   33 +-
 drivers/usb/input/hid-core.c                     |   11 
 drivers/usb/input/hid-debug.h                    |   17 -
 drivers/usb/input/hid-input.c                    |   71 ++++-
 drivers/usb/input/hid.h                          |   12 
 37 files changed, 1081 insertions(+), 406 deletions(-)

----

author Dmitry Torokhov <dtor_core@ameritech.net> 1126371882 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1126371882 -0500

Input: i8042 - use kzalloc instead of kcalloc

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1126371818 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1126371818 -0500

Input: clean up whitespace and formatting in drivers/char/keyboard.c

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Stefan Nickl <Stefan.Nickl@kontron.com> 1125903466 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125903466 -0500

Input: HIDDEV - make HIDIOCSREPORT wait IO completion

When trying to make the hiddev driver issue several Set_Report control
transfers to a custom device with 2.6.13-rc6, only the first transfer in a
row is carried out, while others immediately following it are silently
dropped.

This happens where hid_submit_report() (in hid-core.c) tests for
HID_CTRL_RUNNING, which seems to be still set because the first transfer is
not finished yet.

As a workaround, inserting a delay between the two calls to
ioctl(HIDIOCSREPORT) in userspace "solves" the problem.  The
straightforward fix is to add a call to hid_wait_io() to the implementation
of HIDIOCSREPORT (in hiddev.c), just like for HIDIOCGREPORT.  Works fine
for me.

Apparently, this issue has some history:
http://marc.theaimsgroup.com/?l=linux-usb-users&m=111100670105558&w=2

Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Brian Schau <brian@schau.com> 1125903461 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125903461 -0500

Input: HID - add Wireless Security Lock to HID blacklist

The device is a Wireless Security Lock (WSL).  The device identifies itself
as a Cypress Ultra Mouse.  It is, however, not a mouse at all and as such,
shouldn't be handled as one.

Signed-off-by: Brian Schau <brian@schau.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Stelian Pop <stelian@popies.net> 1125903453 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125903453 -0500

Input: HID - add mapping for Powerbook USB keyboard

Map custom HID events (such as the ones generated by some Logitech and
Apple Powerbooks USB keyboards) to the FN keycode.

Signed-off-by: Stelian Pop <stelian@popies.net>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125897212 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897212 -0500

Input: HID - add the Trust Predator TH 400 gamepad to the badpad list

Reported-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125897195 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897195 -0500

Input: HID - add a quirk for the Apple Powermouse

Add a quirk for the Apple Powermouse, remapping GenericDesktop.Z to
Rel.HWheel, to allow horizontal scrolling in Linux.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125897183 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897183 -0500

Input: HID - fix URB success status handling

Add a missing break; statement to the URB status handling
in hid-core.c, avoiding flushing the request queue on success.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125897167 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897167 -0500

Input: sunkbd - extend mapping to handle Type-6 Sun keyboards

Map an unmarked key at 'Esc' position to KEY_MACRO

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125897159 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897159 -0500

Input: iforce - use wait_event_interruptible_timeout

The timeout while() loops in iforce-packets.c lack a
set_current_state(TASK_INTERRUPTIBLE); call. The right solution is
to replace them with wait_event_interruptible_timeout().

Reported-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Micah F. Galizia <mfgalizi@uwo.ca> 1125897135 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897135 -0500

Input: HID - add support for Logitech UltraX Media Remote control

The hid now supports the Logitech UltraX Media Remote control.
For now, ID 45 on the consumer usage page has been incorrectly
mapped to KEY_RADIO since no other devices uses it.

Signed-off-by: Micah F. Galizia <mfgalizi@csd.uwo.ca>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Michael Haboustak <mike-@cinci.rr.com> 1125897121 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897121 -0500

Input: HID - handle multi-transascion reports

Fixes handling of multi-transaction reports for HID devices. New
function hid_size_buffers() that calculates the longest report
for each endpoint and stores the result in the hid_device object.
These lengths are used to allocate buffers that are large enough
to store any report on the endpoint. For compatibility, the minimum
size for an endpoint buffer set to HID_BUFFER_SIZE rather than the
known optimal case (the longest report length).

It fixes bug #3063 in bugzilla.

Signed-off-by: Michael Haboustak <mike-@cinci.rr.com>

I simplified the patch a bit to use just a single buffer size.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125897101 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125897101 -0500

Input: atkbd - handle keyboards generating scancode 0x7f

Extend bat_xl handling to do err_xl handling, so that
keyboards using 0x7f scancode for regular keys can work.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125896888 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125896888 -0500

Input: HID - add more consumer usages

Extend mapping of the consumer usage page in hid-input.c to handle
more cases appearing on new USB keyboards.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125896879 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125896879 -0500

Input: add HID simulation mappings

Add simulation usage page mappings to hid-input.c to support
a new crop of joysticks using them to designate Rudder and
Throttle controls.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125896857 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125896857 -0500

Inpur: recognize and ignore Logitech vendor usages in HID

These get in our way with MX mice.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1125816130 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816130 -0500

Input: i8042 - add Lifebook E4010 to MUX blacklist

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1125816120 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816120 -0500

Input: i8042 - add i8042.nokbd module option to allow supressing
       creation of keyboard port.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1125816111 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816111 -0500

Input: i8042 - fix IRQ printing when either KBD or AUX port
       is absent from ACPI/PNP tables.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1125816098 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816098 -0500

Input: make i8042_platform_init return 'real' error code

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1125816087 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816087 -0500

Input: i8042 - clean up initialization code; abort if we
       can't create all ports.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Ian Campbell <ijc@hellion.org.uk> 1125816074 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816074 -0500

Input: fix checking whether new keycode fits size-wise

When dev->keycodesize == sizeof(int) the old code produces
incorrect result.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125816055 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816055 -0500

Input: psmouse - add new Logitech wheel mouse model

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> 1125816043 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816043 -0500

Input: ALPS - fix wheel decoding

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> 1125816020 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1125816020 -0500

Input: rework psmouse attributes to reduce module size

Rearrange attribute code to use generic show and set handlers
instead of replicating them for every attribute; switch to
using attribute_group instead of creating all attributes
manually. All this saves about 4K.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Stephen Evanchik <evanchsa@gmail.com> 1123482378 -0500
committer Dmitry Torokhov <dtor_core@ameritech.net> 1123482378 -0500

Input: psmouse - add support for IBM TrackPoint devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
