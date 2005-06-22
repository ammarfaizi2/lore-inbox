Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFVNxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFVNxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 09:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVFVNxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 09:53:15 -0400
Received: from gw.alcove.fr ([81.80.245.157]:57528 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261291AbVFVNwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 09:52:51 -0400
Subject: usb sysfs intf files no longer created when probe fails
From: Stelian Pop <stelian@popies.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Jun 2005 15:50:56 +0200
Message-Id: <1119448257.4587.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the latest git tree, the USB core no longer creates sysfs entries
for interfaces which haven't been probed by a driver. It used to work
until yesterday. I am talking about these:

defiant:/sys/devices/pci0001:10/0001:10:1a.0/usb1/1-2 125 > ls -al
total 0
drwxr-xr-x  5 root root    0 2005-06-22 15:32 .
drwxr-xr-x  6 root root    0 2005-06-22 15:31 ..
drwxr-xr-x  3 root root    0 2005-06-22 14:14 1-2:1.0
drwxr-xr-x  3 root root    0 2005-06-22 14:14 1-2:1.2
-r--r--r--  1 root root 4096 2005-06-22 15:32 bcdDevice
-rw-r--r--  1 root root 4096 2005-06-22 15:32 bConfigurationValue
[...]

Notice the '1-2:1.1' is missing. Upon booting I get:

Jun 22 13:34:04 localhost kernel: HID device not claimed by input or
hiddev
Jun 22 13:34:04 localhost kernel: usbhid: probe of 1-2:1.1 failed with
error -5
Jun 22 13:34:04 localhost kernel: usb 1-2: device_add(1-2:1.1) --> -5

The two first lines are normal (the device claims to be a HID one but it
is a proprietary one). The third line is new, it is not present when
booting an older kernel.

In case it matters, this is on an Apple Powerbook Alu (post Feb 2005
modem), and /proc/bus/usb/devices says:
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05ac ProdID=020f Rev= 0.28
S:  Manufacturer=Apple Computer
S:  Product=Apple Internal Keyboard/Trackpad
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr= 40mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=   1 Ivl=10ms

I use the 'atp' input driver from http://popies.net/atp/ to drive this
touchpad. When removing the driver I also get an oops, possibly related
to the previous failure to create the sysfs file:
usbcore: deregistering driver atp
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C009F5F8 LR: C00A1728 SP: C3AD9DE0 REGS: c3ad9d30 TRAP: 0300    Not
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000C, DSISR: 40000000
TASK = ccc94150[7148] 'rmmod' THREAD: c3ad8000
Last syscall: 129
GPR00: 00000000 C3AD9DE0 CCC94150 C6ED3D48 C02C889C DE6273C7 00000000
00000000
GPR08: 00000001 C6ED3CD4 DFFF9410 00000000 64A79ADA 1001A18C 100C0000
100A0000
GPR16: 00000000 100FEF88 24222482 100C0000 100F2CE8 100F2BE8 10001430
00000000
GPR24: 10000000 00000000 00000000 C02C889C DE76819C DE984678 00000000
E1074280
NIP [c009f5f8] sysfs_hash_and_remove+0x3c/0x170
LR [c00a1728] sysfs_remove_link+0x14/0x24
Call trace:
[c00a1728] sysfs_remove_link+0x14/0x24
[c0132ebc] __device_release_driver+0x48/0x90
[c0133030] driver_detach+0xb0/0xdc
[c01327c8] bus_remove_driver+0x50/0x6c
[c01332a8] driver_unregister+0x18/0x38
[c01a1760] usb_deregister+0x3c/0x58
[e1072cac] atp_exit+0x18/0x40c [atp]
[c00360ac] sys_delete_module+0x19c/0x214
[c0004660] ret_from_syscall+0x0/0x44

Does anybody have an idea or should I try to debug this further ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian@popies.net>

