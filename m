Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVGYFyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVGYFyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGYFxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:53:23 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:21624 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261630AbVGYFxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:18 -0400
Message-Id: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 00/24] Input patches for 2.6.13
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have a bunch of changes for input subsystem I would like to get in.
Half of the stuff is patches I picked from your quilt tree (ALPS
dualpoint resume fix, ALPS tapping mode, couple HID changes, etc)
plus some of my changes (usb_to_input_id, small acecad cleanup,
add modalias for serio bus, couple of  input cleanups).

The full changelog is at the end of the mail.

Could you please "bless" these for Linus to pull:

git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

Thanks!

--
Dmitry


Changelog:
==========

author Sergey Vlasov <vsu@altlinux.ru> Sun, 24 Jul 2005 10:53:32 -0500

Input: synaptics - fix setting packet size on passthrough port.

Synaptics driver used child->type to select either 3-byte or 4-byte
packet size for the pass-through port; this gives wrong results for
the newer protocols. Change the check to use child->pktsize instead.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> Sun, 24 Jul 2005 10:50:03 -0500

Input: check keycodesize when adjusting keymaps

When changing key mappings we need to make sure that the new
keycode value can be stored in dev->keycodesize bytes.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 15 Jul 2005 11:51:56 -0500

Input: i8042 - don't use negation to mark AUX data

Currently i8042_command() negates data coming from the AUX port
of keyboard controller; this is not a very reliable indicator.
Change i8042_command() to fail if response to I8042_CMD_AUX_LOOP
is not coming from AUX channel and get rid of negation.

Based on patch by Vojtech Pavlik.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> Fri, 15 Jul 2005 11:50:08 -0500

Input: psmouse - wheel mice (imps, exps) always have 3rd button

There are wheel mice that respond to Logitech probes and report
that they have only 2 buttons (such as e-Aser mouse) and this
stops the wheel from being used as a middle button. Change the
driver to always report BTN_MIDDLE capability if a wheel is
present.

Also, never reset BTN_RIGHT capability in logips2pp code - there
are no Logitech mice that have only one button and if some other
mice happen to respond to Logitech's query we could do the wrong
thing.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Adam Kropelin <akropel1@rochester.rr.com> Mon, 11 Jul 2005 11:09:32 -0500

Input: HID - only report events coming from interrupts to hiddev

Currently hid-core follows the same code path for input reports
regardless of whether they are a result of interrupt transfers or
control transfers. That leads to interrupt events erroneously being
reported to hiddev for regular control transfers.

Prior to 2.6.12 the problem was mitigated by the fact that
reporting to hiddev is supressed if the field value has not changed,
which is often the case. Said filtering was removed in 2.6.12-rc1 which
means any input reports fetched via control transfers result in hiddev
interrupt events. This behavior can quickly lead to a feedback loop
where a userspace app, in response to interrupt events, issues control
transfers which in turn create more interrupt events.

This patch prevents input reports that arrive via control transfers from
being reported to hiddev as interrupt events.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Michael Prokop <mika@grml.org> Mon, 11 Jul 2005 11:09:10 -0500

Input: elo - fix help in Kconfig (wrong module name)

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Tobias Klauser <tklauser@nuerscht.ch> Mon, 11 Jul 2005 11:08:56 -0500

Input: joydev - remove custom conversion from jiffies to msecs

Replace the MSECS() macro with the jiffies_to_msecs() function provided
in jiffies.h

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Luca T <luca@lt-software.com> Mon, 11 Jul 2005 11:08:40 -0500

Input: HID - add a quirk for Aashima Trust (06d6:0025) gamepad

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Peter Osterlund <petero2@telia.com> Mon, 11 Jul 2005 11:08:04 -0500

Input: ALPS - unconditionally enable tapping mode

The condition in alps_init() was also inverted and the driver
was enabling tapping mode only if it was already enabled.

Signed-off-by: Peter Osterlund <petero2@telia.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author David Moore <dcm@MIT.EDU> Mon, 11 Jul 2005 11:07:48 -0500

Input: ALPS - fix resume (for DualPoints)

The driver would not reset pass-through mode when performing
resume of a DualPoint touchpad causing it to stop working
until next reboot.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Simon Horman <horms@valinux.co.jp> Mon, 11 Jul 2005 11:07:20 -0500

Input: synaptics - limit rate to 40pps on Toshiba Dynabooks

Toshiba Dynabooks require the same workaround as Satellites -
Synaptics report rate should be lowered to 40pps (from 80),
otherwise KBC starts losing keypresses.

Signed-off-by: Simon Horman <horms@valinux.co.jp>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Vojtech Pavlik <vojtech@suse.cz> Mon, 11 Jul 2005 11:06:28 -0500

Input: i8042 - add Fujitsu T3010 to NOMUX blacklist.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Mon, 11 Jul 2005 11:06:06 -0500

Input: i8042 - add Alienware Sentia to NOMUX blacklist.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Neil Brown <neilb@cse.unsw.edu.au> Mon, 11 Jul 2005 11:05:47 -0500

Input: serio_raw - fix Kconfig help

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Mon, 11 Jul 2005 11:02:16 -0500

Input: serio_raw - link serio_raw misc device to corresponding
       serio port in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Andrew Morton <akpm@osdl.org> Sat, 02 Jul 2005 09:54:30 -0500

Input: cannot refer to __exit from within __init.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:50:38 -0500

Input: make name, phys and uniq be 'const char *' because once
       set noone should attempt to change them.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:50:29 -0500

Input: rearrange procfs code to reduce number of #ifdefs

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:50:10 -0500

Sonypi: make sure that input_work is not running when unloading
        the module; submit/retrieve key release data into/from
        input_fifo in one shot.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:49:08 -0500

Input: introduce usb_to_input_id() to uniformly produce
       struct input_id for USB input devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:48:51 -0500

Input: acecad - drop unneeded cast and couple unneeded spaces.
       Noticed by Joe Perches.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Stephane VOLTZ <svoltz@numericable.fr>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:48:34 -0500

Input: serio - add modalias attribute and environment variable to
       simplify hotplug scripts.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:48:14 -0500

Input: uinput - use completions instead of events and manual
       wakeups in force feedback code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

--------------------------
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 30 Jun 2005 10:47:50 -0500

Input: clean up uinput driver (formatting, extra braces)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>



