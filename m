Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWIVWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWIVWPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWIVWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:15:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:55175 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965227AbWIVWPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:15:54 -0400
Date: Sat, 23 Sep 2006 00:15:41 +0200 (MEST)
Message-Id: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Cc: linux-kernel@vger.kernel.org, simoneau@ele.uri.edu,
       sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 13:51:21 -0700 (PDT), David Miller wrote:
>> I don't think it's harmless. My Ultra5 has an add-on PCI USB controller
>> card (Belkin). A 2.6.18-rc kernel compiled with gcc-4.1.1 will throw a few
>> unaligned accesses when I initialise USB by inserting a USB memory stick.
>> Removing the memory stick then results in PCI errors and other breakage.
>> 
>> The same kernel compiled with gcc-3.4.6 has no problems at all, so I've
>> been assuming it's a gcc-4 issue and not a kernel issue.
>
>Compiled with gcc-4.0.x I get the same ehci_hub_control unaligned
>accesses, and putting the correct {get,put}_unaligned() in that
>function makes them go away.
>
>It's a pure mystery if gcc-3.4.x somehow avoids those, as by the
>way the code is written those unaligned accesses are to be expected.

I rechecked with 2.6.18 final, and the behaviour is as I described:
gcc-4.1.1 causes the alignment exceptions, while gcc-3.4.6 does not.
I didn't get any PCI errors now, but I'm sure I did get them in the
2.6.17 or early 2.6.18-rc kernels.

Here's a dmesg diff to show what happens, between the gcc-4.1.1
and gcc-3.4.6 compiled kernels. The first part is from kernel
bootup + user-space modprobe of the USB EHCI etc modules:

--- dmesg-2.6.18.usb-remove	2006-09-22 22:43:36.000000000 +0200
+++ dmesg-2.6.18-gcc346.usb-remove	2006-09-22 23:30:36.000000000 +0200
@@ -1,20 +1,20 @@
 PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
 PROMLIB: Root node compatible: 
-Linux version 2.6.18 (mikpe@sparge) (gcc version 4.1.1) #1 Fri Sep 22 22:32:42 CEST 2006
+Linux version 2.6.18-gcc346 (mikpe@sparge) (gcc version 3.4.6) #1 Fri Sep 22 23:09:51 CEST 2006
 ARCH: SUN4U
 Ethernet address: 08:00:20:fd:ec:1f
 PROM: Built device tree with 46570 bytes of memory.
-On node 0 totalpages: 32312
-  DMA zone: 32312 pages, LIFO batch:7
+On node 0 totalpages: 32309
+  DMA zone: 32309 pages, LIFO batch:7
 CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
-Built 1 zonelists.  Total pages: 32312
+Built 1 zonelists.  Total pages: 32309
 Kernel command line: ro root=/dev/hda5
 PID hash table entries: 1024 (order: 10, 8192 bytes)
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
-Memory: 255928k available (1736k kernel code, 624k data, 112k init) [fffff80000000000,0000000017f46000]
-Calibrating delay using timer specific routine.. 800.26 BogoMIPS (lpj=4001318)
+Memory: 255872k available (1752k kernel code, 624k data, 112k init) [fffff80000000000,0000000017f46000]
+Calibrating delay using timer specific routine.. 800.30 BogoMIPS (lpj=4001524)
 Mount-cache hash table entries: 512
 NET: Registered protocol family 16
 PCI: Probing for controllers.
@@ -88,9 +88,6 @@
 usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 3 ports detected
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
 ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
 ohci_hcd 0000:02:01.0: OHCI Host Controller
 ohci_hcd 0000:02:01.0: new USB bus registered, assigned bus number 2

The following messages are from when I insert the USB memory stick:

@@ -112,11 +109,6 @@
 EXT3 FS on hda2, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 Adding 1048808k swap on /dev/hda4.  Priority:-1 extents:1 across:1048808k
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
 usb 1-2: new high speed USB device using ehci_hcd and address 2
 usb 1-2: configuration #1 chosen from 1 choice
 SCSI subsystem initialized

The following messages are from when I remove the USB memory stick:

@@ -139,9 +131,4 @@
 sda: assuming drive cache: write through
  sda: sda1
 sd 0:0:0:0: Attached scsi removable disk sda
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
 usb 1-2: USB disconnect, address 2
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]
-Kernel unaligned access at TPC[1006a9e4] ehci_hub_control+0x54c/0x68c [ehci_hcd]

/Mikael
