Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUBAKGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUBAKGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:06:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:13698 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265246AbUBAKG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:06:29 -0500
Date: Sun, 1 Feb 2004 11:06:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 2.6 input drivers FAQ
Message-ID: <20040201100644.GA2201@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Common problems and solutions with 2.6 input drivers:

Problems:
~~~~~~~~~

How do I get a list of the input devices in my system?
How can I check that the input drivers have found my devices correctly?

Solution:
~~~~~~~~~

'cat /proc/bus/input/devices' and 'dmesg' are your friends here. The first
lists all devices known to the input core with their properties, and the
latter shows the messages from boot. There you can spot any errors that
happened in the probing process.

Problems:
~~~~~~~~~

I'm getting double clicks when I click only once.
My scroll wheel scrolls by two lines/screens instead of one.
My mouse moves too fast.

Solution:
~~~~~~~~~

Check your XFree86 config file. 

You probably have two "mouse" entries there, one pointing to /dev/psaux and
the other to /dev/input/mice, so that you can get both your PS/2 and USB
mouse working on 2.4.

2.6 uses the input subsystem for both PS2 and USB, and thus both devices
will report events from both mice, resulting in doubled events.

Remove either the /dev/psaux or /dev/input/mice entry, depending what suits
you better for 2.4 compatibility should you ever need go back to 2.4.


Problems:
~~~~~~~~~

My mouse wheel is not working in X.
My Logitech (MousManPS/2) mouse stopped working in X.
My extra buttons don't work in X.


Solution:
~~~~~~~~~

Check your XFree86 config file.

Make sure the mouse protocol is set to "ExplorerPS/2", as that is what the
2.6 kernel exports to applications regardless of the real mouse type.

Make sure you have an "ZAxisMapping 4 5" entry.

Make sure you have an entry for remapping the extra buttons above 5.


Problem:
~~~~~~~~

Kernel reports:
	atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
	atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

Solution:
~~~~~~~~~

Well, the kernel means what it says. XFree86 boldly goes and accesses the
keyboard controller registers when it starts up. This is a bad thing to do,
as it can conflict with the kernel using these registers at the same time.
The kernel spots this and complains, and in most cases is not affected by
the problem.

So, unless you are an XFree86 developer and can fix X, ignore this message.

Problem:
~~~~~~~~

I get the message above, but I'm not running X.

Solution:
~~~~~~~~~

Other applications (for example kbdrate) may also access the keyboard
controller. This will trigger the same message.

Fix your application / utility or ignore the message.

Problem:
~~~~~~~~

My multimedia keys don't work at all and instead emit a message like this:

	atkbd.c: Unknown key pressed (translated set 2, code 0x83 on isa0060/serio0).
	atkbd.c: Use 'setkeycodes e003 <keycode>' to make it known.
	atkbd.c: Unknown key released (translated set 2, code 0x83 on isa0060/serio0).
	atkbd.c: Use 'setkeycodes e003 <keycode>' to make it known.

Solution:
~~~~~~~~~

Do what the kernel says. Use the setkeycodes utility with the suggested
scncode value. For the keycode value, look into /usr/include/linux/input.h,
where is a list of all defined Linux keycodes.

Then you can verify that the keyboard works correctly by using the evtest
program:

	evtest /dev/input/event#

Where # is the number of the input device that is your keyboard.

Problem:
~~~~~~~~

setkeycodes refuses to work with keycodes above 127.

Solution:
~~~~~~~~~

Get a recent version of kbd-utils, and recompile on a 2.6 kernel.

Problem:
~~~~~~~~

Ok, evtest shows everything correctly, but I get incorrect keysyms assigned
to these keys in XFree86.


Solution:
~~~~~~~~~

While the 2.6 kernel tries to use the "standard" scancodes as much as
possible, it is not posible for all keys.

A good solution is to modify the XKB keyboard definition to match the
scancodes one can obtain from 'showkeys -s', after the above problem is
solved and the keys work in evtest.

An better solution would be to write a kernel-2.6 keyboard definition, as
the scancodes are the same for every type of keyboard, independend of the
hardware. This is called hardware abstraction.

A perfect solution would be to get X to use the event protocol. If you're an
XFree86 developer, you might consider this.


Problem:
~~~~~~~~

My PC Speaker is not beeping anymore in 2.6.

Solution:
~~~~~~~~~

Enable it in the kernel config. Go to Drivers->Input->Misc->PC Speaker.


Problem:
~~~~~~~~

My Synaptics touchpad lost the ability of tap-to-click, scroll, etc.


Solution:
~~~~~~~~~

The easy solution is to pass psmouse.proto=imps on the kernel command line,
or proto=imps on the psmouse module command line. This will restore 2.4
behavior.

A better solution is to download the new XFree86 Synaptics driver that
cooperates with the input drivers nicely, from:

	http://w1.894.telia.com/~u89404340/touchpad/index.html

This will allow you to configure the behavior of the touchpad in detail and
give you all the features it can do, including palm detection and similar.

In case you want to get this running at the console, too, an updated GPM
package can be found here:

	http://www.geocities.com/dt_or/gpm/gpm.html


Problem:
~~~~~~~~

When I switch my KVM, my PS/2 mouse goes all crazy.

Solution:
~~~~~~~~~

Use psmouse.proto=bare on the kernel command line, or proto=bare on the
psmouse module command line.

Problem:
~~~~~~~~

I'm getting these:

	psmouse.c: PS/2 mouse at serio0 lost synchronization, throwing 2 bytes away.

Solution:
~~~~~~~~~

Check your mouse cable. If this only happens when you move your mouse in a
certain way, fix the mouse cable or replace the mouse.

Check your kernel and harddisk settings. This message can also happen when
the mouse interrupt is delayed more than one half of a second. Make sure DMA
is enabled for your harddrive and CD-ROM. Kill your ACPI/APM battery
monitoring applet. Try disabling ACPI, frequency scaling. Make sure your
time is ticking correctly, often with frequency scaling it gets unreliable.
Even if you're using the ACPI PM Timer as a clock source - actually this
often leads to the above problem. 

Problem:
~~~~~~~~

My keyboard autorepeat is not as snappy as it used to be in the 2.5 series.

Solution:
~~~~~~~~~

Use atkbd.softrepeat=1 on the kernel command line, or "softrepeat=1" on
atkbd module command line. This will enable kernel internal repeat
generation, which is much more flexible and allows higher repeat rates and
shorter repeat delays than the keyboard itself does.


Problem:
~~~~~~~~

kbdrate doesn't work when I use atkbd.softrepeat.

Solution:
~~~~~~~~~

Get an up-to-date version of kbd-utils. Recompile on 2.6.


Problem:
~~~~~~~~

I've read through the whole file, and it did not help me at all!

Solution:
~~~~~~~~~

Either you didn't have any problem in the first place, or it's something
that is not very often and thus not listed. Try contacting the driver
author/maintainer, the kernel mailing list, or enter the problem into the
Linux kernel bugzilla.
