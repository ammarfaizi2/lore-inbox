Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVC3TRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVC3TRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVC3TN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:13:29 -0500
Received: from hermes.domdv.de ([193.102.202.1]:49412 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262411AbVC3TLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:11:03 -0500
Message-ID: <424AF9C3.4000905@domdv.de>
Date: Wed, 30 Mar 2005 21:10:59 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050308)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
CC: vojtech@suse.cz, dtor_core@ameritech.net, acpi-devel@lists.sourceforge.net
Subject: 2.6.11 acpi battery state readout as source of keyboard/touchpad
 troubles
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In traceing the source of my sporadic synaptics touchpad troubles

psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.

and keyboard troubles (sporadically lost key up/down events) on an Acer
Aspire 1520 (x86_64, latest bios v1.09) I did enable the
report_lost_ticks option which did spit out stuff like the following at
regular intervals:

time.c: Lost 17 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 18 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)

This looked suspiciously like it happended when the the kde laptop
applet polled the battery status. So I did terminate the applet.

The result was no more lost ticks, no lost keyboard events and no more
lost touchpad sync.

To verify ACPI battery data as the source of trouble i did a simple

cat /proc/acpi/battery/BAT0/state

which instantly resulted in:

time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)

So it seems ACPI battery readout does cause some long running interrupt
disable and that it causes nasty side effects for the 8042 input.

Note that doing

cat /proc/acpi/battery/BAT0/info

doesn't cause any trouble (battery alarm is unsupported).

I can ignore the lost ticks but the keyboard/touchpad problems caused by
the state readout are definitely nasty.

Any ideas?
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
