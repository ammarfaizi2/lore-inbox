Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWCNBCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWCNBCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWCNBCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:02:14 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:41223 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S932530AbWCNBCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:02:11 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: OOM kiler/load problems with RAID/LVM and AoE
Date: Mon, 13 Mar 2006 16:02:03 -0900
User-Agent: KMail/1.7.2
Cc: sah@coraid.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131602.03886.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right off: This e-mail is going to be long.  I'm first going to explain how I 
first discovered this bug, then explain how I set up a "smaller scale" test 
case.  And I apologize for the wandering nature of this message as I am 
trying to debug things and find the actual root cause of my problem.  I've 
read through the entire LKML FAQ, so I hope all that follows is proper form.

Initial setup:
I am using two Coraid Etherdrive units each with 15 400GB drives.  Each unit 
is configured internally as a RAID5 device, which presents a 5.1TB drive to 
the OS.  I wanted to mirror these units via RAID1, but discovered the 2TB 
RAID component limit.

So, to get around this, here is what I did:
Put each unit into it's own LVM volume group (vg-shelf0 and vg-shelf1).  Next, 
I split each VG up into 5 1TB logical volumes (p1 through p5).  Then, I 
mirrored each 1TB LV against its corresponding LV in the other VG (e.g. 
vg-shelf0/p1 and vg-shelf1/p1).  I then took those 5 RAID1 devices and 
assembled them into a RAID-Linear device to obtain a 5.1TB drive.  All that 
worked fine.

However, when I try to run stress tests against the system (using spew or 
bonnie++), after a while, the load will start increasing, and eventually the 
system will just hang.  I've done this to make sure I don't run out of memory 
(because oom-killer was firing off):

echo 5 > /proc/sys/vm/dirty_ratio
echo 5 > /proc/sys/vm/dirty_background_ratio
echo 2 > /proc/sys/vm/overcommit_memory
echo 0 > /proc/sys/vm/overcommit_ratio

That didn't seem to have any positive effect.

No, to take out two variables.  I created a similar setup with two internal 
400GB SATA hard drives (same brand, incidentally, as are in the Etherdrives), 
so we got rid of AoE and the network drivers.

Here's what I did to test this process on the internal drives:

Prep the drives to be added to a VG
pvcreate /dev/sdc
pvcreate /dev/sdd

First, put each shelf in its own volume group
vgcreate /dev/vg-test0 /dev/sdc
vgcreate /dev/vg-test1 /dev/sdd
vgchange -ay /dev/vg-test0
vgchange -ay /dev/vg-test1

We now split each VG into 4 100GB chunks
Total PE = 95387 or 23846/23846/23846/23849

lvcreate -l 23846 -n p1 vg-test0
lvcreate -l 23846 -n p2 vg-test0
lvcreate -l 23846 -n p3 vg-test0
lvcreate -l 23849 -n p4 vg-test0

lvcreate -l 23846 -n p1 vg-test1
lvcreate -l 23846 -n p2 vg-test1
lvcreate -l 23846 -n p3 vg-test1
lvcreate -l 23849 -n p4 vg-test1

Now, create 4 100GB RAID1 md devices:

mdadm -C /dev/md7 --auto -l raid1 -n 2 /dev/vg-test0/p1 /dev/vg-test1/p1
mdadm -C /dev/md8 --auto -l raid1 -n 2 /dev/vg-test0/p2 /dev/vg-test1/p2
mdadm -C /dev/md9 --auto -l raid1 -n 2 /dev/vg-test0/p3 /dev/vg-test1/p3
mdadm -C /dev/md10 --auto -l raid1 -n 2 /dev/vg-test0/p4 /dev/vg-test1/p4

Now, we create a 400GB Linear device that is spread across the five RAID1 
devices.
mdadm -C /dev/md11 --auto -l linear -n 4 /dev/md7 /dev/md8 /dev/md9 /dev/md10

Now, running this command:

bonnie++ -d /xtesting/bonnie -s 50g -u joshua:joshua

is where I have problems.  It does the "putc()" section fine, but when it 
starts "Writing intelligently," load goes through the roof, and the system 
eventually hangs.  It exhibits this behavior on the Etherdrive setup above 
but *not* in the internal hard drive setup immediately above.

I assume the LVM/RAID code is pretty well tested.  Any hints as to where I 
might start debugging?  syslog does not report anything useful (even 
on-screen syslog).  The AoE driver could be at fault, but seeing as I copied 
95GB of files yesterday, I'm wondering if it has something to do with the 
network drivers.  These are Broadcoms using the tg3 driver...I have heard of 
problems with these, correct?  I put in a Intel Pro/1000 Dual NIC network 
card and connected to the Etherdrives using this interface (I'm using Cat6 
crossover cables, one Etherdrive per port).  I re-ran the tests and had the 
same results.

RAID or LVM problem? AoE drivers?  Network driver badness (for both of them)?

I shall attempt to include all useful info:

Distribution: Mandriva 2006
Kernel: Linux community.dist-ed.uaf.edu 2.6.12-14mdksmp #1 SMP Tue Dec 20 
13:45:20 MST 2005 i686 AMD Opteron(tm) Processor 246 unknown GNU/Linux
AoE drivers: aoe module version 23
AoE units are running on SS20060302 firmware
Note: AMD Opterons running in 32bit mode
Motherboard: Tyan S2882 Dual Opteron
RAM: 8GB
CPU's: 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 1992.068
cache size      : 1024 KB

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 1992.068
cache size      : 1024 KB

GCC 4.0.1 was used to compile (I think), binutils-2.16.91.0.2-3mdk (again, I 
think).  Not 100% sure as this is an RPM installed kernel, so I don't know 
what versions were used to compile it.

[root@community /xtesting/bonnie]# lspcidrake 
unknown         : Advanced Micro Devices|AMD-8111 PCI [BRIDGE_PCI]
amd76xrom       : Advanced Micro Devices|AMD-8111 LPC [BRIDGE_ISA]
amd74xx         : Advanced Micro Devices|AMD-8111 IDE [STORAGE_IDE]
i2c-amd8111     : Advanced Micro Devices|AMD-8111 SMBus 2.0 [SERIAL_SMBUS]
hw_random       : Advanced Micro Devices|AMD-8111 ACPI [BRIDGE_OTHER]
unknown         : Advanced Micro Devices|AMD-8131 PCI-X Bridge [BRIDGE_PCI]
unknown         : Advanced Micro Devices|AMD-8131 PCI-X Bridge [BRIDGE_PCI]
unknown         : Advanced Micro Devices|AMD-8131 PCI-X APIC [SYSTEM_PIC]
unknown         : Advanced Micro Devices|AMD-8131 PCI-X APIC [SYSTEM_PIC]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] HyperTransport 
Technology Configuration [BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] HyperTransport 
Technology Configuration [BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] Address Map 
[BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] Address Map 
[BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] DRAM Controller 
[BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] DRAM Controller 
[BRIDGE_HOST]
amd64-agp       : Advanced Micro Devices|K8 [Athlon64/Opteron] Miscellaneous 
Control [BRIDGE_HOST]
amd64-agp       : Advanced Micro Devices|K8 [Athlon64/Opteron] Miscellaneous 
Control [BRIDGE_HOST]
usb-ohci        : Advanced Micro Devices|AMD-8111 USB [SERIAL_USB]
usb-ohci        : Advanced Micro Devices|AMD-8111 USB [SERIAL_USB]
sata_sil        : Silicon Image|Sil3114A Serial ATA [STORAGE_OTHER]
Card:ATI Rage XL: ATI|Rage XL [DISPLAY_VGA]
tg3             : Broadcom Corp.|BCM5704 CIOB-E 1000BaseTX [NETWORK_ETHERNET]
tg3             : Broadcom Corp.|BCM5704 CIOB-E 1000BaseTX [NETWORK_ETHERNET]
e1000           : Intel Corp.|82544EI Gigabit Ethernet Controller 
[NETWORK_ETHERNET]
hub             : Linux 2.6.12-14mdksmp ohci_hcd|OHCI Host Controller [Hub|
Unused]
hub             : Linux 2.6.12-14mdksmp ohci_hcd|OHCI Host Controller [Hub|
Unused]

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
