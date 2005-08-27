Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbVH0NnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbVH0NnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbVH0NnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 09:43:14 -0400
Received: from iris.datenpark.ch ([212.55.203.206]:54963 "HELO
	mail.qwasartech.com") by vger.kernel.org with SMTP id S1751613AbVH0NnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 09:43:14 -0400
Message-ID: <43106DEF.3040206@qwasartech.com>
Date: Sat, 27 Aug 2005 15:43:11 +0200
From: Dominik Wezel <dio@qwasartech.com>
Organization: Qwasartech
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB EHCI Problem with Low Speed Devices on kernel 2.6.11+
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

Looks like something the list has seen before, but I actually ran out of 
  ideas even after seeing about everything google, yahoo and the kernel 
majordomo had to offer as advice ...

Hardware
========
- IBM Thinkpad T40
- Targus PAUH212 USB 2.0 HUB 7 Ports connected to Laptop
- USB Keyboard/Mouse (any do, i.e. any cause same problem) connected to hub

Kernel
======
- 2.6.8, 2.6.11.10 and 2.6.12.4, all show same problem

Distro
======
- debian sarge
- using hotplug and udev

Problem
=======
When turning on the laptop and during POST and GrUB loading, all ports 
on the hub are enabled.  During the USB initialization phase, when the 
hub is detected, shortly all ports become disabled, then turn on again 
(uhci_hcd detects the lo-speed ports).  Upon initialization of ehci_hcd 
however, the ports are disconnected again (for good):

---8<----
Aug 27 14:29:50 solaris kernel: ehci_hcd 0000:00:1d.7: USB 2.0 
initialized, EHCI 1.00, driver 10 Dec 2004
Aug 27 14:29:50 solaris kernel: hub 4-0:1.0: USB hub found
Aug 27 14:29:50 solaris kernel: hub 4-0:1.0: 6 ports detected
Aug 27 14:29:50 solaris kernel: usb 2-1: USB disconnect, address 2
Aug 27 14:29:50 solaris kernel: usb 2-1.5: USB disconnect, address 3
Aug 27 14:29:50 solaris kernel: usb 2-1.6: USB disconnect, address 4
---8<----

Addresses 2, 3 and 4 are a keyboard, mouse and palm sync cable respectively.

and afterwards the log becomes cluttered with:

---8<----
Aug 27 14:30:31 solaris kernel: usb 4-3: new high speed USB device using 
ehci_hcd and address 79
Aug 27 14:30:31 solaris kernel: usb 4-3: device not accepting address 
79, error -71
Aug 27 14:30:32 solaris kernel: usb 4-3: new high speed USB device using 
ehci_hcd and address 81
Aug 27 14:30:32 solaris kernel: usb 4-3: device not accepting address 
81, error -71
Aug 27 14:30:33 solaris kernel: usb 4-3: new high speed USB device using 
ehci_hcd and address 86
Aug 27 14:30:34 solaris kernel: usb 4-3: device not accepting address 
86, error -71
Aug 27 14:30:34 solaris kernel: usb 4-3: new high speed USB device using 
ehci_hcd and address 89
Aug 27 14:30:35 solaris kernel: usb 4-3: device not accepting address 
89, error -71
Aug 27 14:30:35 solaris kernel: usb 4-3: new high speed USB device using 
ehci_hcd and address 90
Aug 27 14:30:35 solaris kernel: usb 4-3: device not accepting address 
90, error -71
---8<----

first address to be assigned was 30 in all logs, but the number raises 
mostly in increments of 2 till about 120, then restarts with 12.

Interestlingly, the keyboard and mouse have been detected immediately 
before the intialization of ehcihcd:

---8<---
Aug 27 14:29:50 solaris kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Aug 27 14:29:50 solaris kernel: PCI: Setting latency timer of device 
0000:00:1d.2 to 64
Aug 27 14:29:50 solaris kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 
0x1840
Aug 27 14:29:50 solaris kernel: uhci_hcd 0000:00:1d.2: new USB bus 
registered, assigned bus number 3
Aug 27 14:29:50 solaris kernel: hub 3-0:1.0: USB hub found
Aug 27 14:29:50 solaris kernel: hub 3-0:1.0: 2 ports detected
/* These are the 2 ports on the laptop */
Aug 27 14:29:50 solaris kernel: usb 2-1: new full speed USB device using 
uhci_hcd and address 2
Aug 27 14:29:50 solaris kernel: hub 2-1:1.0: USB hub found
Aug 27 14:29:50 solaris kernel: hub 2-1:1.0: 7 ports detected
/* These are the 7 ports of the external hub */
Aug 27 14:29:50 solaris kernel: usb 2-1.5: new low speed USB device 
using uhci_hcd and address 3
Aug 27 14:29:50 solaris kernel: usb 2-1.6: new low speed USB device 
using uhci_hcd and address 4
Aug 27 14:29:50 solaris kernel: usbcore: registered new driver hiddev
Aug 27 14:29:50 solaris kernel: input: USB HID v1.10 Mouse [Logitech 
Trackball] on usb-0000:00:1d.1-1.5
Aug 27 14:29:50 solaris kernel: input: USB HID v1.10 Keyboard [CHICONY 
USB Keyboard] on usb-0000:00:1d.1-1.6
Aug 27 14:29:50 solaris kernel: input,hiddev96: USB HID v1.10 Device 
[CHICONY USB Keyboard] on usb-0000:00:1d.1-1.6
Aug 27 14:29:50 solaris kernel: usbcore: registered new driver usbhid
Aug 27 14:29:50 solaris kernel: drivers/usb/input/hid-core.c: v2.0:USB 
HID core driver
---8<---

which means the ehci_hcd has afterwards superseded uhci_hcd.

Even more interestingly: in about 5% of the boot cases, ehci_hcd manages 
to detect the ports correctly (or at least doesn't interfere with uhci). 
  I can then use both low-speed and hi-speed devices for a variable 
amount of time (spanning 20 minutes up to 8 hours), after which the 
ports suddenly go down.  Rebooting however falls (in 19 of 20 cases) 
outside of the 5%, and I'm lost again (fortunately the internal keyboard 
and mouse always work, so at least I /can/ reboot).

Measures taken
==============
I've found an article suggesting to
         echo Y > /sys/module/usbcore/parameters/old_scheme_first
which I've done.  Interestingly, when turning the parameter to 'Y' and 
then pluggin the hub out and in, all ports come on. Unfortunately this 
doesn't work once the setting is done in the boot process 
(/etc/init.d/local).
---
I've also found articles suggesting to throw away the hub and get 
another one, which of course I can't take plain seriously, because now I 
know the problem of this hub, and I'm not going to change it for a hub 
whose problem I even don't know yet... =;)
---
Of course, I've also tried a kernel with ehci_hcd disabled.  This works 
fine for the keyboard and mouse now, as long as I don't use any 
high-speed devices, such as the palm sync, which doesn't work any more 
in this setup (neither when plugged in the hub nor when plugged in the 
laptop [root hub]).

Measures not taken
==================
I didn't test the hub on Microsoft Windows, because I assume that 
wouldn't add to the solution space, since the problem is clearly located 
in the uhci_hcd vs. ehci_hcd domain of the linux kernel, as the hub is 
fully functional (within the lo speed scope) when used with only uhci.

Thanks for any ideas or suggestions!

--

Dominik Wezel
Systems Engineer

