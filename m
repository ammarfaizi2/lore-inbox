Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSLOSma>; Sun, 15 Dec 2002 13:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSLOSma>; Sun, 15 Dec 2002 13:42:30 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:516
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S262360AbSLOSm2>; Sun, 15 Dec 2002 13:42:28 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PROBLEM][2.5][AMD76X_PM]: Possible porting problem - Can't register AMD Northbridge?
Date: Sun, 15 Dec 2002 13:50:54 -0500
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212151350.54025.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is some debugging added as well as having the kernel partly -DDEBUG 
enabled:

===============================================
amd76x_pm: amd76x_pm hardware power management 0.1.0
amd76x_pm: Looking for Northbridge...
bus pci: add driver amd76x_pm-nb
kobject amd76x_pm-nb: registering. parent: <NULL>, subsys: drivers
Inside driver_attach()
!bus->match not true continue on..
!dev->driver keep going...
inside bus_match()
inside pci_bus_match()
pci_bus_match(): About to search ids list...
pci_match_bus(): ids->vendor = 1022
pci_match_bus(): ids->subvendor = ffffffff
pci_match_bus(): ids->class_mask = 0
pci_match_bus(): ids->device = 700c
pci_match_bus(): ids->class = 0
pci_match_bus(): DECISION: ids->vendor 1022 == pci_dev->vendor 1022?
pci_match_bus(): DECISION ids->device 700c == pci_dev->device 700d?
pci_match_bus(): DECISION ids->subvendor ffffffff == pci_dev->subsystem_vendor 
0?
pci_match_bus(): DECISION ids->subdevice ffffffff == pci_dev->subsystem_device 
0?
bus_match(): match(): We didn't find a match. Failed
bus_match(): Returns -19 [-ENODEV]
Dec 14 23:20:37 unknown kernel: Driver_attach(): Returns 0

(This repeats a few times in the list then terminates with driver_attach 
returning 0).

However when detecting the Southbridge:

amd76x_pm: Looking for Southbridge...
bus pci: add driver amd76x_pm-sb
kobject amd76x_pm-sb: registering. parent: <NULL>, subsys: drivers
Inside driver_attach()
!bus->patch not true continue on..
!dev->driver keep going...
inside bus_match()
inside pci_bus_match()

[First one doesnt match]
[Second one doesn't match]
[Third one doesn't match]
[Forth one doesn't match]
[Firth one doesn't match]

On the 6th list check:

pci_match_bus(): ids->vendor = 1022
pci_match_bus(): ids->subvendor = ffffffff
pci_match_bus(): ids->class_mask = 0
pci_match_bus(): ids->device = 7443
pci_match_bus(): ids->class = 0
pci_match_bus(): DECISION: ids->vendor 1022 == pci_dev->vendor 1022?
pci_match_bus(): DECISION ids->device 7443 == pci_dev->device 7443?
pci_match_bus(): DECISION ids->subvendor ffffffff == pci_dev->subsystem_vendor 
1043?
pci_match_bus(): DECISION ids->subdevice ffffffff == pci_dev->subsystem_device 
8044?
bus_match(): We matched!
amd76x_pm: Initializing southbridge Advanced Micro Devic AMD-768 [Opus] ACPI
bus_match(): Success! Attach it!
bound device '00:07.3' to driver 'amd76x_pm-sb'
sysfs_create_link: depth = 4, size = 33
sysfs_create_link: path ='../../../../devices/pci0/00:07.3'
bus_match(): Returns 0
driver_attach():bus_match() returns 1
[ It keeps searching the list after this for other new things]

We OOPs when we try to use pdev_nb->device in a switch because pdev = NULL! 
because the Northbridge was not found.

Unable to handle kernel NULL pointer dereference at virtual address 00000026
printing eip:
   e08a5568
   *pde = 00000000
   Oops: 0000
   CPU:    0
   EIP:    0060:[<e08a5568>]    Not tainted
   EFLAGS: 00010282
   EIP is at 0xe08a5568
   eax: 00000000   ebx: 00000000   ecx: c034d6d4   edx: 00000282
   esi: e08a3000   edi: 00000000   ebp: de365fa0   esp: de365f94
   ds: 0068   es: 0068   ss: 0068
Process insmod (pid: 127, threadinfo=de364000 task=de363940)
Stack: e08a5b00 00007443 c034fb98 de365fbc c012e6d1 40017000 00001dd3 0804a028
        de364000 00000003 bffffd48 c01093db 40017000 00001dd3 0804a028      
00000003
        00000000 bffffd48 00000080 0000002b 0000002b 00000080 400fb36d 
00000023

Call Trace:
  [sys_init_module+433/464] sys_init_module+0x1b1/0x1d0
  [syscall_call+7/11] syscall_call+0x7/0xb

Code: 0f b7 40 26 c7 04 24 60 5b 8a e0 89 44 24 04 e8 74 85 87 df

This of course, hangs insmod :(

Any pointers, Do we need to register the Northbridge and Southbridge and if 
so, why can't we find it?

00:00.0 Class 0600: 1022:700c (rev 11) <---------- Northbridge 
00:01.0 Class 0604: 1022:700d
00:07.0 Class 0601: 1022:7440 (rev 04)
00:07.1 Class 0101: 1022:7441 (rev 04)
00:07.3 Class 0680: 1022:7443 (rev 03) <----------- Southbridge

I have them on this MPX A7M266-D machine but its not finding it.

Shawn.
