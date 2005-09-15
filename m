Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbVIOHGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbVIOHGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVIOHEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:04:10 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:15228 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030430AbVIOHEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:01 -0400
Message-Id: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 00/28] RFC/RFT: Input - sysfs integration
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Argh, resending with subjects and proper CCs]

Hi,

The following set of patches deals with converting input subsystem
to the driver model and intergrate it with sysfs. This allows us
to remove custom-made input hotplug handler and finally have an
option of netlink-only hotplug notifier.

Some changes to the driver core were required. I decided that I did
not want to add an additional class to /sys/class directory; instead
class code was changed to allow nesting several classes. This way
we can have:

/sys/class/input/
|-- devices
|   |-- input0
|   |-- input1
|   `-- input2
`-- interfaces
    |-- event0
    ...
    |-- mouse1
    `-- ts0

and not clutter the top-level directory. Top-level classes define
individual subsystems, lower-level classes define individual parts.
In this particular case 'devices' directory contains class devices
corresponding to input_dev structures whereas 'interfaces' has
class devices produced by input interfaces (handlers), such as
evdev, mousedev, tsdev and joydev.

I believe that other subsystems, such as firewire, SCSI, USB and
I2C could also be moved to a hierarchy of classes to make /sys
tree more organized.

Although all this compatible with pre-udev hotplug scripts I was
advised that having sub-classes will require some changes to udev.

Class interface code was slightly changed to pass interface to
add/remove methods. This way subsystem can have a generic handler
and still call individual interfaces's methods if needed. There are
couple if I2O patches that deal with class interface code, these are
not directly related to this series, but required for compiling.
The maintainer acked them and will push with the rest of I2O
updates.

When registering class devices hotplug event is now sent before
adding interfaces, otherwise children's hotplug events would reach
userspace (udev) first.

The full sysfs input hierarchy on by laptop is the following:
[dtor@core ~]$ tree /sys/class/input/
/sys/class/input/
|-- devices
|   |-- input0
|   |   |-- capabilities
|   |   |   |-- abs
|   |   |   |-- ev
|   |   |   |-- ff
|   |   |   |-- key
|   |   |   |-- led
|   |   |   |-- msc
|   |   |   |-- rel
|   |   |   |-- snd
|   |   |   `-- sw
|   |   |-- device -> ../../../../devices/platform/i8042/serio1
|   |   |-- event0 -> ../../../../class/input/interfaces/event0
|   |   |-- id
|   |   |   |-- bustype
|   |   |   |-- product
|   |   |   |-- vendor
|   |   |   `-- version
|   |   |-- name
|   |   |-- phys
|   |   `-- uniq
|   |-- input1
|   |   |-- capabilities
|   |   |   |-- abs
|   |   |   |-- ev
|   |   |   |-- ff
|   |   |   |-- key
|   |   |   |-- led
|   |   |   |-- msc
|   |   |   |-- rel
|   |   |   |-- snd
|   |   |   `-- sw
|   |   |-- device -> ../../../../devices/platform/i8042/serio0
|   |   |-- event1 -> ../../../../class/input/interfaces/event1
|   |   |-- id
|   |   |   |-- bustype
|   |   |   |-- product
|   |   |   |-- vendor
|   |   |   `-- version
|   |   |-- mouse0 -> ../../../../class/input/interfaces/mouse0
|   |   |-- name
|   |   |-- phys
|   |   |-- ts0 -> ../../../../class/input/interfaces/ts0
|   |   `-- uniq
|   `-- input2
|       |-- capabilities
|       |   |-- abs
|       |   |-- ev
|       |   |-- ff
|       |   |-- key
|       |   |-- led
|       |   |-- msc
|       |   |-- rel
|       |   |-- snd
|       |   `-- sw
|       |-- device -> ../../../../devices/platform/i8042/serio0/serio2
|       |-- event2 -> ../../../../class/input/interfaces/event2
|       |-- id
|       |   |-- bustype
|       |   |-- product
|       |   |-- vendor
|       |   `-- version
|       |-- mouse1 -> ../../../../class/input/interfaces/mouse1
|       |-- name
|       |-- phys
|       |-- ts1 -> ../../../../class/input/interfaces/ts1
|       `-- uniq
`-- interfaces
    |-- event0
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input0
    |-- event1
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input1
    |-- event2
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input2
    |-- mice
    |   `-- dev
    |-- mouse0
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input1
    |-- mouse1
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input2
    |-- ts0
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input1
    `-- ts1
        |-- dev
        `-- device -> ../../../../class/input/devices/input2

Review/comments/testing will be appreciated.

Thank you.

--
Dmitry

