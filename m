Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268014AbUIFNtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268014AbUIFNtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUIFNtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:49:12 -0400
Received: from linux.di.uminho.pt ([193.136.19.96]:23509 "HELO
	homer.lsd.di.uminho.pt") by vger.kernel.org with SMTP
	id S268014AbUIFNsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:48:40 -0400
From: =?iso-8859-1?q?Jos=E9_Orlando_Pereira?= <jop@lsd.di.uminho.pt>
Organization: Universidade do Minho
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Synaptics detection not working reliably?
Date: Mon, 6 Sep 2004 14:49:47 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409061449.47377.jop@lsd.di.uminho.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is something weird with Synaptics detection in 2.6.8.1 in a Fujitsu S7010
laptop with a touchpad/stick combo. The problem is as follows:

 - The first time the driver is loaded, either compiled in or as a module and
regardless of options provided, the mouse is detected as a bare PS/2:

I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio4/input0
H: Handlers=mouse0 event1
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

 - If I unload psmouse without actually using the mouse, and reload it again,
it is detected again as a bare PS/2.

 - If I load psmouse and actually use the mouse, which initially behaves erratically
but eventually settlles down, and only then reload the module, it is now correctly detected:

I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio4/input0
H: Handlers=mouse0 event1
B: EV=b
B: KEY=6420 0 70003 0 0 0 0 0 0 0 0
B: ABS=11000003

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=synaptics-pt/serio0/input0
H: Handlers=mouse1 event2
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

The relevant section of /var/log/messages is:

Sep  6 14:29:59 localhost kernel: input: PS/2 Generic Mouse on isa0060/serio4
Sep  6 14:29:59 localhost udev[3329]: configured rule in '/etc/udev/rules.d//50
Sep  6 14:29:59 localhost udev[3329]: creating device node '/udev/input/mouse0'
Sep  6 14:29:59 localhost udev[3330]: configured rule in '/etc/udev/rules.d//50
Sep  6 14:29:59 localhost udev[3330]: creating device node '/udev/input/event1'
Sep  6 14:30:44 localhost kernel: psmouse.c: Mouse at isa0060/serio4/input0 los
Sep  6 14:30:56 localhost udev[3594]: removing device node '/udev/input/mouse0'
Sep  6 14:30:56 localhost udev[3607]: removing device node '/udev/input/event1'
Sep  6 14:31:00 localhost kernel: Synaptics Touchpad, model: 1
Sep  6 14:31:00 localhost kernel:  Firmware: 5.9
Sep  6 14:31:00 localhost kernel:  Sensor: 15
Sep  6 14:31:00 localhost kernel:  new absolute packet format
Sep  6 14:31:00 localhost kernel:  Touchpad has extended capability bits
Sep  6 14:31:00 localhost kernel:  -> 2 multi-buttons, i.e. besides standard bu
Sep  6 14:31:00 localhost kernel:  -> multifinger detection
Sep  6 14:31:00 localhost kernel:  -> palm detection
Sep  6 14:31:00 localhost kernel:  -> pass-through port
Sep  6 14:31:01 localhost kernel: input: SynPS/2 Synaptics TouchPad on isa0060/
Sep  6 14:31:01 localhost kernel: serio: Synaptics pass-through port at isa0060
Sep  6 14:31:01 localhost kernel: input: PS/2 Generic Mouse on synaptics-pt/ser
Sep  6 14:31:02 localhost udev[3671]: configured rule in '/etc/udev/rules.d//50
Sep  6 14:31:02 localhost udev[3671]: creating device node '/udev/input/mouse0'
Sep  6 14:31:02 localhost udev[3672]: configured rule in '/etc/udev/rules.d//50
Sep  6 14:31:02 localhost udev[3672]: creating device node '/udev/input/event1'
Sep  6 14:31:02 localhost udev[3673]: configured rule in '/etc/udev/rules.d//50
Sep  6 14:31:02 localhost udev[3673]: creating device node '/udev/input/mouse1'
Sep  6 14:31:02 localhost udev[3674]: configured rule in '/etc/udev/rules.d//50
Sep  6 14:31:02 localhost udev[3674]: creating device node '/udev/input/event2'

This happens on an installation of Fedora Core 2+current updates. Kernel configuration
is copied from the original Fedora Core kernel. X.org 6.7 is used and configured with the
plain "mouse" driver.

Is this a known problem? Is there a known solution or an workaround?

-- 
Jose Orlando Pereira
* mailto:jop@di.uminho.pt * http://gsd.di.uminho.pt/~jop *
