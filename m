Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264708AbSJ3Pf1>; Wed, 30 Oct 2002 10:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbSJ3Pf1>; Wed, 30 Oct 2002 10:35:27 -0500
Received: from mail106.mail.bellsouth.net ([205.152.58.46]:53629 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264708AbSJ3PfZ>; Wed, 30 Oct 2002 10:35:25 -0500
Date: Wed, 30 Oct 2002 10:41:43 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
cc: johannes@erdfelt.com, <linux-usb-devel@lists.sourceforge.net>,
       <greg@kroah.com>
Subject: [2.5.44] USB Devices register twice
Message-ID: <Pine.LNX.4.43.0210301033480.317-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.5.44 (and in 44-bk2), if I unplug a USB device, then plug it in
again, it registers itself twice. This does not happen in 2.5.43.


drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB/EB/MB PIIX4 USB
drivers/usb/core/hcd-pci.c: irq 11, io base 0000cce0
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 2
Manufacturer: Logitech
input: USB HID v1.00 Mouse [Logitech] on usb-00:07.2-1
drivers/usb/core/usb.c: USB disconnect on device 2
<unplug mouse here, then plug it back in>
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 3
Manufacturer: Logitech
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 4
Manufacturer: Logitech


This causes the following oops on reboot:


Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01b9765
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01b9765>]    Not tainted
EFLAGS: 00010246
EIP is at device_shutdown+0x75/0x8c
eax: 00000001   ebx: 00000000   ecx: 00000000   edx: ffffffff
esi: c0346ad0   edi: fee1dead   ebp: bffffd8c   esp: c90c3ea0
ds: 0068   es: 0068   ss: 0068
Process reboot (pid: 302, threadinfo=c90c2000 task=c9c0c6c0)
Stack: c90c2000 01234567 c011b10d c03a12e8 00000001 00000000 c90c2000 08049960
       c90a6400 400deb60 c0121a9d c90c2000 c90a6400 c9f40000 c13c9000 000013c9
       c13c9740 00031768 00000005 c0128523 c119f930 c13c9000 00000246 c13c976c
Call Trace:
 [<c011b10d>] sys_reboot+0xdd/0x2a0
 [<c0121a9d>] do_no_page+0x219/0x288
 [<c0128523>] kmem_cache_free+0x19b/0x244
 [<c0128523>] kmem_cache_free+0x19b/0x244
 [<c0147ec9>] dput+0x19/0x184
 [<c0136a96>] __fput+0xba/0xdc
 [<c01369db>] fput+0x13/0x14
 [<c01351e5>] filp_close+0x99/0xa4
 [<c0135248>] sys_close+0x58/0x80
 [<c0106eb3>] syscall_call+0x7/0xb

Code: 8b 1b 81 fb c0 6a 34 c0 75 c1 89 f1 ff 05 d0 6a 34 c0 7e 35



Here is the verbose USB Debugging messages:

drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
drivers/usb/core/hub.c: hub 0 port 1 connection change
drivers/usb/core/hub.c: hub 0 port 1, portstatus 301, change 1, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 2
drivers/usb/core/usb.c: new device strings: Mfr=1, Product=0, SerialNumber=0
Manufacturer: Logitech
drivers/usb/core/usb.c: usb_new_device - registering 1-1:0
drivers/usb/core/usb.c: usb_device_probe
drivers/usb/core/usb.c: usb_device_probe - got id
input: USB HID v1.00 Mouse [Logitech] on usb-00:07.2-1
drivers/usb/core/hub.c: port 2, portstatus 100, change 0, 12 Mb/s
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/hub.c: port 1, portstatus 100, change 3, 12 Mb/s
drivers/usb/core/hub.c: hub 0 port 1 connection change
drivers/usb/core/hub.c: hub 0 port 1, portstatus 100, change 3, 12 Mb/s
drivers/usb/core/usb.c: USB disconnect on device 2
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/usb.c: unregistering interfaces on device 2
drivers/usb/core/hcd.c: (no bus?): hcd_unlink_urb fail -22
drivers/usb/core/hcd.c: (no bus?): hcd_unlink_urb fail -22
drivers/usb/core/usb.c: unregistering the device 2
drivers/usb/core/hub.c: port 2, portstatus 100, change 0, 12 Mb/s
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/hub.c: port 1, portstatus 100, change 2, 12 Mb/s
drivers/usb/core/hub.c: hub 0 port 1 enable change, status 100
drivers/usb/core/hub.c: port 2, portstatus 100, change 0, 12 Mb/s
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
drivers/usb/core/hub.c: hub 0 port 1 connection change
drivers/usb/core/hub.c: hub 0 port 1, portstatus 301, change 1, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 3
drivers/usb/core/usb.c: new device strings: Mfr=1, Product=0, SerialNumber=0
Manufacturer: Logitech
drivers/usb/host/uhci-hcd.c: cce0: suspend_hc
drivers/usb/host/uhci-hcd.c: cce0: wakeup_hc
drivers/usb/core/hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 4
drivers/usb/core/usb.c: new device strings: Mfr=1, Product=0, SerialNumber=0
Manufacturer: Logitech
drivers/usb/core/hub.c: port 2, portstatus 100, change 0, 12 Mb/s


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461



