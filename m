Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbTFSJF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbTFSJF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:05:28 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:24040 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S265742AbTFSJFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:05:18 -0400
Subject: Re: 2.4.21: Bluetooth oopses with Acer USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Marius Gedminas <mgedmin@centras.lt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030619072216.GB14665@gintaras>
References: <20030619072216.GB14665@gintaras>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jun 2003 11:18:18 +0200
Message-Id: <1056014305.32273.90.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marius,

> When I insert an Acer USB Bluetooth dongle, 2.4.21 (vanilla + CPUfreq
> patch found on Con Kolivas patch page, 1100_CFS_0306161356_2.4.21-ck1.patch)
> immediately oopses:
> 
> Jun 19 02:38:56 perlas kernel: hub.c: new USB device 00:1d.1-1, assigned address 2
> Jun 19 02:38:56 perlas hcid[834]: HCI dev 0 registered
> Jun 19 02:38:56 perlas kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> Jun 19 02:38:56 perlas kernel:  printing eip:
> Jun 19 02:38:56 perlas kernel: d0a2f431
> Jun 19 02:38:56 perlas kernel: *pde = 00000000
> Jun 19 02:38:56 perlas kernel: Oops: 0000
> Jun 19 02:38:56 perlas kernel: CPU:    0
> Jun 19 02:38:56 perlas kernel: EIP:    0010:[<d0a2f431>]    Not tainted
> Jun 19 02:38:56 perlas kernel: EFLAGS: 00010096
> Jun 19 02:38:56 perlas kernel: eax: 00000000   ebx: ce04cc00   ecx: cdcf5ab4   edx: ce04cc00
> Jun 19 02:38:56 perlas kernel: esi: ce04cc00   edi: 00000000   ebp: 00000206   esp: c92a1f28
> Jun 19 02:38:56 perlas kernel: ds: 0018   es: 0018   ss: 0018
> Jun 19 02:38:56 perlas kernel: Process hcid (pid: 989, stackpage=c92a1000)
> Jun 19 02:38:56 perlas kernel: Stack: d0a2f38f cdcf5ab4 00000020 206c6165 68746977 00000008 ce04cc00 ce04cc00
> Jun 19 02:38:56 perlas kernel:        00000000 00000206 d0a2f63a ce04cc00 c9434240 ce04cc00 ce04ccbc 00000000
> Jun 19 02:38:56 perlas kernel:        d0a263a9 ce04cc00 00000001 00000002 00000000 c9434240 400448c9 ffffffe7
> Jun 19 02:38:56 perlas kernel: Call Trace:    [<d0a2f38f>] [<d0a2f63a>] [<d0a263a9>] [sock_ioctl+38/48] [sys_ioctl+185/448]
> Jun 19 02:38:56 perlas kernel:   [system_call+51/56]
> Jun 19 02:38:56 perlas kernel:
> Jun 19 02:38:56 perlas kernel: Code: 0f b7 78 04 c7 44 24 04 20 00 00 00 8d 04 bf 8d 2c 00 89 2c
> Jun 19 02:38:56 perlas /sbin/hotplug: no runnable /etc/hotplug/bluetooth.agent is installed
> Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: Setup hci_usb for USB product b7a/7d0/134
> Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: Setup hci_usb for USB product b7a/7d0/134
> Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: missing kernel or user mode driver hci_usb
> Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: missing kernel or user mode driver hci_usb

what kind of Acer dongle is this? Please show us your data from
/proc/bus/usb/devices for this device.

The following small patch should help.

Regards

Marcel


diff -urN linux-2.4.21/drivers/bluetooth/hci_usb.c linux-2.4.21-mh/drivers/bluetooth/hci_usb.c
--- linux-2.4.21/drivers/bluetooth/hci_usb.c    Fri Jun 13 16:51:32 2003
+++ linux-2.4.21-mh/drivers/bluetooth/hci_usb.c Thu Jun 19 11:11:15 2003
@@ -301,7 +301,8 @@
                        hci_usb_bulk_rx_submit(husb);
 
 #ifdef CONFIG_BLUEZ_USB_SCO
-               hci_usb_isoc_rx_submit(husb);
+               if (husb->isoc_iface)
+                       hci_usb_isoc_rx_submit(husb);
 #endif
        } else {
                clear_bit(HCI_RUNNING, &hdev->flags);


