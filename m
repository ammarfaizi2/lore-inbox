Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUCQXSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUCQXQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:16:45 -0500
Received: from aea152.neoplus.adsl.tpnet.pl ([83.31.137.152]:1796 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262142AbUCQXPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:15:23 -0500
Date: Thu, 18 Mar 2004 00:22:03 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4: Oops on rmmod uhci-hcd when device is still accessed
Message-ID: <20040317232203.GA3510@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just gave 2.6.4 a try (after 102 days of uptime on 2.6.0-test11
- "almost stable" if I knew what not to do ;) - but now I experienced
some strange deadlocks in programs accessing some resource, probably
memory, so I had to reboot).

When shutting down 2.6.0-test11 I noticed oops message on stopping
hotplug service - and this bug is still present in Linux 2.6.4.

Oops occurs on "rmmod uhci-hcd" when device connected to USB is still
accessed by modem_run program (it's Alcatel Speedtouch ADSL modem).

dmesg then contains:

uhci_hcd 0000:00:07.2: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-2: USB disconnect, address 2
usbfs: USBDEVFS_CONTROL failed cmd modem_run dev 2 rqt 192 rq 18 len 1 ret -19
usbfs: usb_submit_urb returned -19
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
printing eip:
d884c3c8
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d884c3c8>]    Not tainted
EFLAGS: 00010246
EIP is at releaseintf+0x68/0x80 [usbcore]
eax: 00000000   ebx: d6101824   ecx: d6101824   edx: 00000000
esi: d6101800   edi: 00000000   ebp: d6213ac0   esp: d1653f30
ds: 007b   es: 007b   ss: 0068
Process modem_run (pid: 4022, threadinfo=d1652000 task=d17e4c00)
Stack: d6213ac0 00000000 d7fe4600 d1625540 d884c796 d194bc00 00000000 c014bf8f
d1c37a40 d194bc00 00000000 d1fb1200 00000001 c014a6df ffffffff 00000001
00000006 d1fb1200 c011ba89 d1fb1200 d2804ba0 d17e4c00 0000ff00 c011c5fd
Call Trace:
[<d884c796>] usbdev_release+0xa6/0xb0 [usbcore]
[<c014bf8f>] __fput+0xff/0x110
[<c014a6df>] filp_close+0x4f/0x80
[<c011ba89>] put_files_struct+0x59/0xb0
[<c011c5fd>] do_exit+0x18d/0x3f0
[<c011c902>] do_group_exit+0x32/0xa0
[<c0108c5b>] syscall_call+0x7/0xb

Code: 8b 54 90 0c b8 a0 8a 85 d8 e8 2a 7f ff ff eb c6 90 8d b4 26
<6>uhci_hcd 0000:00:07.2: USB bus 1 deregistered
uhci_hcd 0000:00:07.3: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:07.3: USB bus 2 deregistered


It's in drivers/usb/core/devio.c:388:

|        down(&dev->serialize);
|        if (test_and_clear_bit(intf, &ps->ifclaimed)) {
|                iface = dev->actconfig->interface[intf];
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
|                usb_driver_release_interface(&usbdevfs_driver, iface);
|                err = 0;
|        }
|        up(&dev->serialize);

and looks like dev->actconfig is NULL


My USB-related configuration options:
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_SPEEDTOUCH=m
(the rest is not set)

Whole .config is available at
http://cyber.cs.net.pl/~qboosh/misc/kernel-2.6.4.config


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
