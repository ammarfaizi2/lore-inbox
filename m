Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTINDvx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 23:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTINDvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 23:51:53 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:40844 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262288AbTINDvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 23:51:51 -0400
Message-ID: <1b7101c37a73$8288b190$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 vs. APM or keyboard driver
Date: Sun, 14 Sep 2003 12:51:25 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test5 continues to have APM problems which earlier 2.6.0-test versions
had, which can be solved by booting 2.4.19.

A laptop has the following keys among others:
  Fn+F2 = adjust screen brightness (100%->25%->50%->75%->100%)
  Fn+F7 = suspend to disk (but see below)
  Fn+F8 = adjust CPU speed (200MHz->50MHz->100MHz->200MHz)
  Fn+F9 = display battery status on screen for 5 seconds
  Fn+F10 = suspend to RAM (but see below)

If no APM driver is active, the BIOS performs all of those operations
itself.  Suspend to disk uses a dedicated disk partition and turns off the
power.  Suspend to RAM mostly turns off the power, the only way to turn it
back on is to push the power switch, but it does use the battery to refresh
RAM and could drain the battery in a few days if not plugged in.

If an APM driver is active then the BIOS only performs these actions by
itself:
  Fn+F2 = adjust screen brightness (100%->25%->50%->75%->100%)
  Fn+F8 = adjust CPU speed (200MHz->50MHz->100MHz->200MHz)
  Fn+F9 = display battery status on screen for 5 seconds
These actions vary as follows:
  Fn+F7 = user suspend, followed by BIOS action (see below)
  Fn+F10 = user standby (but see below)

Fn+F7 gives the OS a chance to take some action, after which the BIOS still
saves state to a dedicated disk partition and turns off the power.

Fn+F10 is interpreted by Windows 95, 98, 2000, and XP as suspend to RAM,
even though 98 and 2000 and XP use the word standby for it, and their APM
drivers command the BIOS to do a suspend operation.  Only Linux is
different, 2.4.19 commands the BIOS to do a standby operation, which can be
reawakened by actions such as pressing the keyboard's Shift key, but which
could drain the battery in hours if not plugged in (except when I modified
2.4.19 so it commands the BIOS to do a suspend to RAM).

Also if 2.4.19 is running then I can type the command "apm -s" to do a
suspend to RAM (or can type the command "apm -S" to do the power-hungry
version of standby).

If 2.6.0-test[1-5] is running then behavior is as follows:
  Fn+F2 = no-op
  Fn+F7 = no-op
  Fn+F8 = no-op
  Fn+F9 = no-op
  Fn+F10 = no-op
Fortunately I can still type the command "apm -s" to do a suspend to RAM (or
can type the command "apm -S" to do the power-hungry version of standby).

Running with ACPI=OFF APM=DEBUG, I could confirm the messages that the APM
driver gets from the BIOS.
2.4.19:
  Pull the power cord = power status change
  Plug in the power cord = power status change
  Fn+F2 = none, the BIOS acts by itself
  Fn+F7 = user suspend (after which the BIOS acts)
  Turn it back on = normal resume (oddly, no power status changes)
  Fn+F8 = none, the BIOS acts by itself
  Fn+F9 = none, the BIOS acts by itself
  Fn+F10 = user standby (though I turned it into a suspend)
  Turn it back on = normal resume (followed by two power status changes)
2.6.0-test5:
  Pull the power cord = power status change
  Plug in the power cord = power status change
  Fn+F2 = none, and the BIOS takes no action
  Fn+F7 = none, and the BIOS takes no action
  Fn+F8 = none, and the BIOS takes no action
  Fn+F9 = none, and the BIOS takes no action
  Fn+F10 = none, and the BIOS takes no action
As mentioned above, commands "apm -s" and "apm -S" still work, though I
neglected to look at the debug messages.  There is no way to force a suspend
to disk though, and no way to adjust the screen brightness etc.

The above complaints all concern either APM or the keyboard driver.  I am
not sure if the 2.6.0 keyboard driver could be the reason why the BIOS no
longer even gets signals from the keyboard.  I have never seen any other
situation where a keyboard's "Fn" key plus functional meaning of another key
could get broken, so I'm not sure if a broken keyboard driver could really
be this powerful.  Otherwise the APM driver itself got b0rked between 2.4.19
and 2.6.0-test[1-5].

(ACPI is not an issue here.  It is already known that if I omit ACPI=OFF
then the ACPI drivers will see just enough BIOS hooks so that they will act
as no-ops instead of unloading themselves, they will persuade the APM driver
to unload itself, and then I will have no power management whatsoever.  In
2.6.0 I have configured the kernel build to omit ACPI entirely.)

