Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTDTCxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 22:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTDTCxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 22:53:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40676 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263510AbTDTCx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 22:53:29 -0400
Date: Sat, 19 Apr 2003 20:05:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 603] New: 2.5.67: USB kills kernel on hotplug stop, wrong timer handling?
Message-ID: <1390000.1050807920@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=603

           Summary: 2.5.67: USB kills kernel on hotplug stop, wrong timer
                    handling?
    Kernel Version: 2.5.67 proper
            Status: NEW
          Severity: high
             Owner: greg@kroah.com
         Submitter: andi@lisas.de


Distribution: Debian unstable
Hardware Environment: Dell Inspiron 8000, 2 USB ports
Software Environment:
Hotplug version: 0.0.20030117-7, gcc version 3.2.3 20030407 (Debian prerelease)
Problem Description:
After hours of trying to nail down my very annoying system shutdown crash, I
finally found that it's USB that's causing it.

Messages on /etc/init.d/hotplug start:
Apr 19 20:27:41 localhost kernel: drivers/usb/core/usb.c: registered new driver 
usbfs
Apr 19 20:27:41 localhost kernel: drivers/usb/core/usb.c: registered new driver 
hub
Apr 19 20:27:41 localhost kernel: Please use the 'usbfs' filetype instead, the '
usbdevfs' name is deprecated.
Apr 19 20:27:41 localhost kernel: drivers/usb/host/uhci-hcd.c: USB Universal Hos
t Controller Interface driver v2.0
Apr 19 20:27:41 localhost kernel: uhci-hcd 00:1f.2: Intel Corp. 82801BA/BAM USB 
(Hub
Apr 19 20:27:41 localhost kernel: uhci-hcd 00:1f.2: irq 10, io base 0000dce0
Apr 19 20:27:41 localhost kernel: Please use the 'usbfs' filetype instead, the '
usbdevfs' name is deprecated.
Apr 19 20:27:41 localhost kernel: uhci-hcd 00:1f.2: new USB bus registered, assi
gned bus number 1
Apr 19 20:27:41 localhost kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
Apr 19 20:27:41 localhost kernel: usb usb1: Product: Intel Corp. 82801BA/BAM USB
 (Hub
Apr 19 20:27:41 localhost kernel: usb usb1: Manufacturer: Linux 2.5.67 uhci-hcd
Apr 19 20:27:41 localhost kernel: usb usb1: SerialNumber: 00:1f.2
Apr 19 20:27:41 localhost kernel: hub 1-0:0: USB hub found
Apr 19 20:27:41 localhost kernel: hub 1-0:0: 2 ports detected

messages on /etc/init.d/hotplug stop (gathered using: while true; do sync; done):

Apr 19 20:28:23 localhost kernel: uhci-hcd 00:1f.2: remove, state 3
Apr 19 20:28:23 localhost kernel: usb usb1: USB disconnect, address 1
Apr 19 20:28:23 localhost kernel: uhci-hcd 00:1f.2: USB bus 1 deregistered
Apr 19 20:28:23 localhost kernel: uhci-hcd 00:1f.2: dangling refs (1) to bus 1!
Apr 19 20:28:23 localhost kernel: drivers/usb/core/usb.c: deregistering driver u
sbfs
Apr 19 20:28:23 localhost kernel: drivers/usb/core/usb.c: deregistering driver h
ub
[OOPS]

OOPS trace very similar to http://groups.google.de/groups?th=620852fd541f704e&rnum=6

Could it be that "dangling refs (1) to bus 1!" causes some distortion in proper
USB shutdown, causing USB to kfree() a timer without killing it before doing so?
Or maybe it's because of the usbfs vs. usbdevfs message?

The USB modules loaded at this time are:
uhci_hcd               32584  0 
ohci_hcd               31104  0 
usbcore               115892  4 uhci_hcd,ohci_hcd

Manually loading these modules instead of starting /etc/init.d/hotplug does
NOT cause a crash on shutdown.
And I NEVER plugged any USB device into the connectors.

root@note:/home/andi# cat /proc/bus/usb/devices 

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.67 uhci-hcd
S:  Product=Intel Corp. 82801BA/BAM USB (Hub
S:  SerialNumber=00:1f.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

lspci:
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 02)


