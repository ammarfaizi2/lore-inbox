Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUA3Qpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUA3Qpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:45:53 -0500
Received: from imap.gmx.net ([213.165.64.20]:57542 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261889AbUA3Qpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:45:49 -0500
X-Authenticated: #4512188
Message-ID: <401A8A35.1020105@gmx.de>
Date: Fri, 30 Jan 2004 17:45:41 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
References: <20040126215036.GA6906@kroah.com>
In-Reply-To: <20040126215036.GA6906@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

perhaps you remember me being a gentoo user wanting to switch to udev. 
Well I did so, but am having some problems:

1.) Minor one: Nodes for Nvidia (I am using binary display modules 
1.0.5328) ar not created. I have to do it by hand each start-up (written 
into loacal.start.):
mknod /dev/nvidia0 c 195 0
mknod /dev/nvidiactl c 195 255

2.) More probelmatic: I am having some serious troubles with my Epson 
Perfection USB scanner:
a) I am to dumb to write a rule for it to map it to /dev/usb/scanner0

Excerp of lsusb -v:

Bus 001 Device 004: ID 04b8:010f Seiko Epson Corp. Perfection 1250
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass          255 Vendor Specific Class
   bDeviceSubClass         0
   bDeviceProtocol       255
   bMaxPacketSize0         8
   idVendor           0x04b8 Seiko Epson Corp.
   idProduct          0x010f Perfection 1250
   bcdDevice            1.00
   iManufacturer           1 EPSON
   iProduct                2 EPSON Scanner 010F
   iSerial                 0
   bNumConfigurations      1

I don't exactly know which SYSFS_ field to use as the don't match the 
lsusb descriptor. I tried various ones, but the scanner always gets 
mapped to /dev/scanner0. I managed to get my HP printer to be mapped to 
usb/lp0 by using its serial. This is my (latest non working )line for 
the scanner:

BUS="usb", SYSFS_model="Perfection 1250", NAME="usb/scanner0"

Now the serious issue: When rebooting or disconnecting the scanner I get 
a kernel oops:

hub 1-0:1.0: new USB device on port 2, assigned address 4
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x010f) now 
attached to usb/scanner0
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.16:USB Scanner Driver
usb 1-2: USB disconnect, address 4
Unable to handle kernel NULL pointer dereference at virtual address 0000001e
  printing eip:
f9b370cc
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f9b370cc>]    Tainted: PF
EFLAGS: 00010282
EIP is at disconnect_scanner+0x2c/0x6d [scanner]
eax: f685f0c0   ebx: f685f0d4   ecx: f9b370a0   edx: 00000007
esi: 00000000   edi: f73194e8   ebp: f9b3abfc   esp: f78c3e50
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 983, threadinfo=f78c2000 task=f78da720)
Stack: f685f0c0 f9b3ac78 f685f0c0 f9b3ace0 f9a4611b f685f0c0 f685f0c0 
f685f100
        f685f0d4 f9b3ad00 c026c214 f685f0d4 f685f100 f73194fc f73194c0 
f9b36a4f
        f685f0d4 f685f0c0 f73194fc f9b3ac0c 00000000 00000000 c021cbf8 
f73194fc
Call Trace:
  [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
  [<c026c214>] device_release_driver+0x64/0x70
  [<f9b36a4f>] destroy_scanner+0x4f/0xb0 [scanner]
  [<c021cbf8>] kobject_cleanup+0x98/0xa0
  [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
  [<c026c214>] device_release_driver+0x64/0x70
  [<c026c345>] bus_remove_device+0x55/0xa0
  [<c026b27d>] device_del+0x5d/0xa0
  [<f9a4c6af>] usb_disable_device+0x6f/0xb0 [usbcore]
  [<f9a46b76>] usb_disconnect+0x96/0xf0 [usbcore]
  [<f9a492df>] hub_port_connect_change+0x30f/0x320 [usbcore]
  [<f9a48c13>] hub_port_status+0x43/0xb0 [usbcore]
  [<f9a495ba>] hub_events+0x2ca/0x340 [usbcore]
  [<f9a4965d>] hub_thread+0x2d/0xf0 [usbcore]
  [<c010925e>] ret_from_fork+0x6/0x14
  [<c011c9e0>] default_wake_function+0x0/0x20
  [<f9a49630>] hub_thread+0x0/0xf0 [usbcore]
  [<c0107289>] kernel_thread_helper+0x5/0xc

Code: 80 7e 1e 00 75 2e 85 f6 74 17 8d 46 3c 8b 5c 24 08 8b 74 24


And that's it. I cannot do a clean shut-down anymore, as the scanner 
module won't get unloaded. Is this an udev issue or is the module 
faulty? I am using latest Linus kernel 2.6.2-rc2.

Other than that I am quite impressed by udev. I disabled the use of an 
archive saving all the nodes. This was getting on my nerves with a 
former udev release as populating /dev took several seconds. Now I 
cannot see any delay. Very well!

bye,

Prakash
