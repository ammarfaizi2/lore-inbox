Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbUJ0HEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUJ0HEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUJ0HCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:02:46 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:63243 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262318AbUJ0HAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:00:34 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.9 SMP: via-rhine cannot be upped
Date: Wed, 27 Oct 2004 10:00:24 +0300
User-Agent: KMail/1.5.4
Cc: Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271000.24390.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, threading will be broken]

>>I have an onboard VIA eth:
>>
>># lspci
>>00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
>>
>>It cannot be upped:
>>
>># ip l set dev if up
>>SIOCSIFFLAGS: Function not implemented
>># ifconfig if up
>>SIOCSIFFLAGS: Function not implemented
>># busybox ip l set dev if up
>>SIOCSIFFLAGS: Function not implemented
>
>My suspicion is that the eth0 device is not actually the VIA driver
>at all. Since your config builds many drivers directly into the kernel,
>probably one of the others created an eth0 device.  There is no
>guarantee of initialization order about which device gets created first
>(at least the way network devices are done in 2.6). 
>
>You should investigate if there are multiple devices present
>(ifconfig -a or ls /sys/class/net).  Perhaps one of the other drivers
>does not correctly handle the case of hardware not being present
>and leaves a ghost behind..
>
>One way to find out would be to look at:
>	/sys/class/net/eth0/device/vendor
>	/sys/class/net/eth0/device/device
>	/sys/class/net/eth0/device/subsystem_vendor
>	/sys/class/net/eth0/device/subsystem_device

Thanks! This was an excellent advice.

2.6.9-smp did get right the device as Via Rhine, but IRQ is 16
now! This must be source of my problems.

I had to check dmesg in the first place instead of
mailing lkml...

Below are boot messages of SMP and preempt kernels.

--- dmesg	Wed Oct 27 07:46:04 2004
+++ dmesg-smp	Wed Oct 27 09:53:42 2004
@@ -1,4 +1,4 @@
-Linux version 2.6.9-preempt (root@shadow) (gcc version 3.3.3) #1 Sat Oct 23 15:40:47 EEST 2004
+Linux version 2.6.9 (root@shadow) (gcc version 3.3.3) #1 SMP Fri Oct 22 22:54:32 EEST 2004
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -8,23 +8,32 @@
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 256MB LOWMEM available.
+found SMP MP-table at 000f5470
 On node 0 totalpages: 65536
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 61440 pages, LIFO batch:15
   HighMem zone: 0 pages, LIFO batch:1
 DMI 2.2 present.
+ACPI: Unable to locate RSDP
+Intel MultiProcessor Specification v1.1
+    Virtual Wire compatibility mode.
+OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
+Processor #0 6:8 APIC version 17
+I/O APIC #2 Version 17 at 0xFEC00000.
+Enabling APIC mode:  Flat.  Using 1 I/O APICs
+Processors: 1
 Built 1 zonelists
 Kernel command line: root=/dev/ram  init=/linuxrc  devfs=nomount  ROOTFS=/dev/ide/host0/bus0/target0/lun0/part7  IPCFG=mac,100mbit  INIT=/init  idebus=40
 ide_setup: idebus=40
 Initializing CPU#0
-CPU 0 irqstacks, hard=c066d000 soft=c066c000
+CPU 0 irqstacks, hard=c0698000 soft=c0690000
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 1743.758 MHz processor.
+Detected 1743.632 MHz processor.
 Using tsc for high-res timesource
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
-Memory: 251928k/262144k available (3165k kernel code, 9720k reserved, 1703k data, 656k init, 0k highmem)
+Memory: 251432k/262144k available (3191k kernel code, 10216k reserved, 1772k data, 708k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
 Calibrating delay loop... 3432.44 BogoMIPS (lpj=1716224)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
@@ -36,10 +45,16 @@
 CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
-CPU: AMD Unknown CPU Typ stepping 01
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
+CPU0: AMD Unknown CPU Typ stepping 01
+per-CPU timeslice cutoff: 182.84 usecs.
+task migration cache decay timeout: 1 msecs.
+Total of 1 processors activated (3432.44 BogoMIPS).
+ENABLING IO-APIC IRQs
+..TIMER: vector=0x31 pin1=2 pin2=0
+Brought up 1 CPUs
 checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
 Freeing initrd memory: 1393k freed
 NET: Registered protocol family 16
@@ -58,23 +73,17 @@
 PCI: Probing PCI hardware
 PCI: Probing PCI hardware (bus 00)
 PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
-PCI: IRQ 0 for device 0000:00:10.0 doesn't match PIRQ mask - try pci=usepirqmask
-PCI: Found IRQ 11 for device 0000:00:10.0
-PCI: Sharing IRQ 11 with 0000:00:0c.0
-PCI: Sharing IRQ 11 with 0000:00:12.0
-PCI: IRQ 0 for device 0000:00:10.1 doesn't match PIRQ mask - try pci=usepirqmask
-PCI: IRQ 0 for device 0000:00:10.2 doesn't match PIRQ mask - try pci=usepirqmask
-PCI: Found IRQ 10 for device 0000:00:10.2
-PCI: Sharing IRQ 10 with 0000:00:0a.0
-PCI: Sharing IRQ 10 with 0000:00:11.5
-PCI: IRQ 0 for device 0000:00:10.3 doesn't match PIRQ mask - try pci=usepirqmask
+PCI->APIC IRQ transform: (B0,I10,P0) -> 18
+PCI->APIC IRQ transform: (B0,I12,P0) -> 16
+PCI->APIC IRQ transform: (B0,I17,P0) -> 27
+PCI->APIC IRQ transform: (B0,I17,P2) -> 22
+PCI->APIC IRQ transform: (B0,I18,P0) -> 16
+PCI->APIC IRQ transform: (B1,I0,P0) -> 16
 Machine check exception polling timer started.
 Total HugeTLB memory allocated, 0
 devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
 devfs: boot_options: 0x0
 Initializing Cryptographic API
-PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 11
-PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 10
 cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
 pci_hotplug: PCI Hot Plug PCI Core version: 0.5
 cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
@@ -114,10 +123,7 @@
 TLAN: 0 devices installed, PCI: 0  EISA: 0
 ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
 via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
-PCI: Found IRQ 11 for device 0000:00:12.0
-PCI: Sharing IRQ 11 with 0000:00:0c.0
-PCI: Sharing IRQ 11 with 0000:00:10.0
-eth0: VIA Rhine II at 0xe400, 00:0a:e6:7c:dd:79, IRQ 11.
+eth0: VIA Rhine II at 0xe400, 00:0a:e6:7c:dd:79, IRQ 16.
 eth0: MII PHY found at address 1, status 0x784d advertising 01e1 Link 0000.
 smc-ultra.c: No ISAPnP cards found, trying standard ones...
 cs89x0:cs89x0_probe(0x0)
@@ -182,14 +188,14 @@
 Intel ISA PCIC probe: not found.
 Device 'i823650' does not have a release() function, it is broken and must be fixed.
 Badness in device_release at /.1/usr/srcdevel/kernel/linux-2.6.9.src/drivers/base/core.c:85
- [<c01060a4>] dump_stack+0x17/0x1b
- [<c021f894>] kobject_cleanup+0x77/0x7a
- [<c021fbaa>] kref_put+0x2a/0x70
- [<c021f8bc>] kobject_put+0x18/0x1e
- [<c05e6e81>] init_i82365+0x191/0x1a5
- [<c05c36f3>] do_initcalls+0x27/0xa5
- [<c0100456>] init+0x35/0x125
- [<c0103eb9>] kernel_thread_helper+0x5/0xb
+ [<c0107048>] dump_stack+0x17/0x1b
+ [<c0226256>] kobject_cleanup+0x77/0x7a
+ [<c0226578>] kref_put+0x2b/0x6f
+ [<c022627e>] kobject_put+0x18/0x1e
+ [<c0603ead>] init_i82365+0x19b/0x1af
+ [<c05da849>] do_initcalls+0x27/0xa5
+ [<c0100529>] init+0x8a/0x199
+ [<c0103fc5>] kernel_thread_helper+0x5/0xb
 Databook TCIC-2 PCMCIA probe: not found.
 mice: PS/2 mouse device common for all mice
 input: AT Translated Set 2 keyboard on isa0060/serio0
@@ -198,7 +204,7 @@
 EISA: Detected 0 cards.
 NET: Registered protocol family 2
 IP: routing cache hash table of 2048 buckets, 16Kbytes
-TCP: Hash tables configured (established 16384 bind 32768)
+TCP: Hash tables configured (established 16384 bind 16384)
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 17
@@ -206,14 +212,14 @@
 Bridge firewalling registered
 RAMDISK: Compressed image found at block 0
 VFS: Mounted root (ext2 filesystem) readonly.
-Freeing unused kernel memory: 656k freed
+Freeing unused kernel memory: 708k freed
 ReiserFS: hda7: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on hda7
 ext3: No journal on filesystem on hda7
 ReiserFS: hda8: found reiserfs format "3.6" with standard journal
 ReiserFS: hda8: using ordered data mode
 ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
 ReiserFS: hda8: checking transaction log (hda8)
-ReiserFS: hda8: replayed 27 transactions in 1 seconds
+ReiserFS: hda8: replayed 22 transactions in 1 seconds
 ReiserFS: hda8: Using r5 hash to sort names
 ReiserFS: hda9: found reiserfs format "3.6" with standard journal
 ReiserFS: hda9: using ordered data mode
@@ -221,14 +227,10 @@
 ReiserFS: hda9: checking transaction log (hda9)
 ReiserFS: hda9: Using r5 hash to sort names
 Loaded prism54 driver, version 1.2
-PCI: Found IRQ 11 for device 0000:00:0c.0
-PCI: Sharing IRQ 11 with 0000:00:10.0
-PCI: Sharing IRQ 11 with 0000:00:12.0
+eth0: could not install IRQ handler
+prism54: probe of 0000:00:0c.0 failed with error -5
 Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
-ip_conntrack version 2.1 (2048 buckets, 16384 max) - 300 bytes per conntrack
+ip_conntrack version 2.1 (2048 buckets, 16384 max) - 304 bytes per conntrack
 ip_tables: (C) 2000-2002 Netfilter core team
 Adding 262136k swap on /var/swap.  Priority:-1 extents:1114
-PCI: Found IRQ 10 for device 0000:00:11.5
-PCI: Sharing IRQ 10 with 0000:00:0a.0
-PCI: Sharing IRQ 10 with 0000:00:10.2
 PCI: Setting latency timer of device 0000:00:11.5 to 64
--
vda

