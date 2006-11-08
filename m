Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754303AbWKHVrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbWKHVrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbWKHVrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:47:05 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:14772 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1753781AbWKHVrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:47:01 -0500
Message-ID: <4552504A.8000906@gmail.com>
Date: Wed, 08 Nov 2006 22:46:50 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jano <jano@90-mo3-3.acn.waw.pl>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081309r680a5420sbb6156f5d4240797@mail.gmail.com>
In-Reply-To: <d9a083460611081309r680a5420sbb6156f5d4240797@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please, do not remove Cc people.

Jano wrote:
> On 6 Lis, 19:00, Jiri Slaby <jirisl...@gmail.com> wrote:
>> Jano wrote:
>> > Hi everyone,
>>
>> > Recently I've downloaded and compiled kernel 2.6.18.1. After installing
>> > modules and kernel and updating Grub I rebooted my box and tried to
>> > launch new kernel. Everything was launching nicely, but while loading
>> > GDM the screen went black and I was unable to switch console (using
>> > ctrl+alt+Fn). I've rebooted using single user mode and logged in as
>> > root. What I've discovered is the fact that I cannot mount any
>> > filesystem from /dev/hdb. All filesystems from /dev/hda work as they
>> > ought to, but when I try to mount something from the second hard disk I
>> > get:
>>
>> > # mount -t ext3 /dev/hdb1 /home
>> > /dev/hdb1 already mounted or /home is busy
>> > # umount /home
>> > /home not mounted
>>
>> > Here you've got my /etc/fstab:
>>
>> > proc            /proc           proc    defaults        0       0
>> > /dev/hda3       /               ext3    defaults,errors=remount-ro 0
>> >   1
>> > /dev/hda1       /boot           ext3    defaults        0       2
>> > /dev/hdb1       /home           ext3    defaults        0       2
>> > /dev/hda5       /usr            ext3    defaults        0       2
>> > /dev/hda7       none            swap    sw              0       0
>> > /dev/hdc        /media/cdrom0   udf,iso9660 user,noauto 0       0
>> > /dev/sda1       /media/usbdisk  vfat    user,auto       0       0
>>
>> > Currently I am using kernel 2.6.15 from Ubuntu repositories. All
>> > filesystems work perfectly. Have you got any ideas what might be going
>> > on?dmesg >2.6.15
>> reboot
>> dmesg >2.6.18
>> diff -u 2.6.15 2.6.18 >post_this_to_lkml
>> might help us. Also attach /proc/mounts.
>>
>> regards,
> 
> Thank you for your feedback. Here you've got my /proc/mount on 2.6.18.1
> 
> rootfs / rootfs rw 0 0
> /dev/root / ext3 rw,data=ordered 0 0
> proc /proc proc rw 0 0
> sysfs /sys sysfs rw 0 0
> tmpfs /var/run tmpfs rw 0 0
> tmpfs /var/lock tmpfs rw 0 0
> /dev/root /dev/.static/dev ext3 rw,data=ordered 0 0
> udev /dev tmpfs rw 0 0
> devpts /dev/pts devpts rw 0 0
> tmpfs /dev/shm tmpfs rw 0 0
> tmpfs /var/run tmpfs rw 0 0
> tmpfs /var/lock tmpfs rw 0 0
> /dev/hda1 /boot ext3 rw,data=ordered 0 0
> /dev/hda5 /usr ext3 rw,data=ordered 0 0
> 
> And dmesg diff, exactly as you suggested:

Yup, but you use timestamps on the one of kernels, nevermind -- it's sed job.

> --- 2.6.15    2006-11-08 18:06:16.000000000 +0100
> +++ 2.6.18.1    2006-11-08 22:07:53.000000000 +0100
> @@ -1,317 +1,254 @@
> -[17179569.184000] Linux version 2.6.15-27-386 (buildd@terranova) (gcc
> version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Sat Sep 16 01:51:59
> UTC 2006
> -[17179569.184000] BIOS-provided physical RAM map:
> -[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> -[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000
> (reserved)
> -[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000
[...]
> +EXT3-fs: mounted filesystem with ordered data mode.
> +kjournald starting.  Commit interval 5 seconds
> +EXT3 FS on hda5, internal journal
> +EXT3-fs: mounted filesystem with ordered data mode.
> 
> I hope it will be helpful.

Ok, we have this:
@@ -1,6 +1,5 @@
-Linux version 2.6.15-27-386 (buildd@terranova) (gcc
-ersion 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Sat Sep 16 01:51:59
-TC 2006
+Linux version 2.6.18.1 (root@jano-desktop) (gcc version 4.0.3 (Ubuntu
+.0.3-1ubuntu5)) #1 Mon Nov 6 16:14:01 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -11,26 +10,19 @@
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
-127MB HIGHMEM available.
+Warning only 896MB will be used.
+Use a HIGHMEM enabled kernel.


This has nothing to do with your problem, but I recommend you to enable HIGHMEM.


 896MB LOWMEM available.
-On node 0 totalpages: 262140
+On node 0 totalpages: 229376
   DMA zone: 4096 pages, LIFO batch:0
-  DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
-  HighMem zone: 32764 pages, LIFO batch:7
 DMI 2.3 present.
-ACPI: RSDP (v000 ASUS
-  ) @ 0x000f5e20
-ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
-x31313031) @ 0x3fffc000
-ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
-x31313031) @ 0x3fffc0b2
-ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
-x31313031) @ 0x3fffc030
-ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
-x31313031) @ 0x3fffc058
-ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT
-x0100000b) @ 0x00000000
+ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e20
+ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc000
+ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc0b2
+ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc030
+ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc058
+ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
 ACPI: PM-Timer IO Port: 0xe408
 ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
@@ -45,67 +37,54 @@
 ACPI: IRQ9 used by override.
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
-Allocating PCI resources starting at 50000000 (gap:
-0000000:bec00000)
-Built 1 zonelists
-Kernel command line: root=/dev/hda3 ro quiet splash
+Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
+Detected 1839.975 MHz processor.
+Built 1 zonelists.  Total pages: 229376
+Kernel command line: root=/dev/hda3 ro single
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
+Enabling fast FPU save and restore... done.
+Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
-PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 1840.206 MHz processor.
-Using pmtmr for high-res timesource
+PID hash table entries: 4096 (order: 12, 16384 bytes)
 Console: colour VGA+ 80x25
-Dentry cache hash table entries: 131072 (order: 7,
-24288 bytes)
-Inode-cache hash table entries: 65536 (order: 6,
-62144 bytes)
-Memory: 1028872k/1048560k available (1976k kernel
-ode, 18936k reserved, 606k data, 288k init, 131056k highmem)
-Checking if this processor honours the WP bit even
-n supervisor mode... Ok.
-Calibrating delay using timer specific routine..
-683.37 BogoMIPS (lpj=7366740)
-Security Framework v1.0.0 initialized
-SELinux:  Disabled at boot.
+Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
+Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
+Memory: 906300k/917504k available (1813k kernel code, 10728k
+eserved, 571k data, 172k init, 0k highmem)
+Checking if this processor honours the WP bit even in supervisor mode... Ok.
+Calibrating delay using timer specific routine.. 3682.73 BogoMIPS (lpj=7365468)
 Mount-cache hash table entries: 512
-CPU: After generic identify, caps: 0383fbff
-1c3fbff 00000000 00000000 00000000 00000000 00000000
-CPU: After vendor identify, caps: 0383fbff c1c3fbff
-0000000 00000000 00000000 00000000 00000000
-CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
-64 bytes/line)
+CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000
+0000000 00000000 00000000 00000000
+CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
+0000000 00000000 00000000
+CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 512K (64 bytes/line)
-CPU: After all inits, caps: 0383fbff c1c3fbff
-0000000 00000420 00000000 00000000 00000000
-mtrr: v2.0 (20020519)
+CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420
+0000000 00000000 00000000
+Intel machine check architecture supported.
+Intel machine check reporting enabled on CPU#0.
+Compat vDSO mapped to ffffe000.
 CPU: AMD Athlon(TM) XP 3000+ stepping 00
-Enabling fast FPU save and restore... done.
-Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
-checking if image is initramfs... it is
-Freeing initrd memory: 6616k freed
-ACPI: Looking for DSDT ... not found!
+ACPI: Core revision 20060707
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
 NET: Registered protocol family 16
-EISA bus registered
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 2.10 entry at 0xf1960, last bus=1
 PCI: Using configuration type 1
-ACPI: Subsystem revision 20051216
+Setting up standard PCI resources
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
-ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9
-0 11 12) *0, disabled.
+ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
 ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12)
-ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9
-0 11 12) *0, disabled.
+ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
 ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
 ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
-ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10
-11 12 14 15)
+ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
 ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
@@ -114,267 +93,168 @@
 Boot video device is 0000:01:00.0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
-Linux Plug and Play Support v0.97 (c) Adam Belay
-pnp: PnP ACPI init
-pnp: PnP ACPI: found 14 devices
-PnPBIOS: Disabled by ACPI PNP
 PCI: Using ACPI for IRQ routing
-PCI: If a device doesn't work, try "pci=routeirq".
-f it helps, post a report
-pnp: 00:01: ioport range 0xe400-0xe47f could not be reserved
-pnp: 00:01: ioport range 0xe800-0xe81f could not be reserved
-pnp: 00:0d: ioport range 0x290-0x297 has been reserved
-pnp: 00:0d: ioport range 0x370-0x375 has been reserved
+PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 PCI: Bridge: 0000:00:01.0
   IO window: d000-dfff
   MEM window: bf000000-bfffffff
   PREFETCH window: c0000000-f7ffffff
 PCI: Setting latency timer of device 0000:00:01.0 to 64
+NET: Registered protocol family 2
+IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
+TCP established hash table entries: 131072 (order: 7, 524288 bytes)
+TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
+TCP: Hash tables configured (established 131072 bind 65536)
+TCP reno registered
 Simple Boot Flag at 0x3a set to 0x1
-audit: initializing netlink socket (disabled)
-audit(1163006904.972:1): initialized
-highmem bounce pool size: 64 pages
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Initializing Cryptographic API
 io scheduler noop registered
-io scheduler anticipatory registered
+io scheduler anticipatory registered (default)
 io scheduler deadline registered
 io scheduler cfq registered
-isapnp: Scanning for PnP cards...
-isapnp: No Plug & Play device found
-PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at
-x60,0x64 irq 1,12
-serio: i8042 AUX port at 0x60,0x64 irq 12
-serio: i8042 KBD port at 0x60,0x64 irq 1
-Serial: 8250/16550 driver $Revision: 1.90 $ 48
-orts, IRQ sharing enabled
-serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16
-level, low) -> IRQ 169
-ACPI: PCI interrupt for device 0000:00:0d.0 disabled
-RAMDISK driver initialized: 16 RAM disks of 65536K
-ize 1024 blocksize
+ACPI: Power Button (FF) [PWRF]
+ACPI: Power Button (CM) [PWRB]
+Floppy drive(s): fd0 is 1.44M
+FDC 0 is a post-1991 82077
+via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
+ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 16
+eth0: VIA Rhine II at 0xbd800000, 00:0e:a6:8a:a6:36, IRQ 16.
+eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
-ide: Assuming 33MHz system bus speed for PIO modes;
-verride with idebus=xx
-mice: PS/2 mouse device common for all mice
-EISA: Probing bus 0 at eisa.0
-EISA: Detected 0 cards.
-NET: Registered protocol family 2
-input: AT Translated Set 2 keyboard as /class/input/input0
-IP route cache hash table entries: 65536 (order: 6,
-62144 bytes)
-TCP established hash table entries: 262144 (order:
-, 1048576 bytes)
-TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
-TCP: Hash tables configured (established 262144 bind 65536)
-TCP reno registered
-TCP bic registered
-NET: Registered protocol family 1
-NET: Registered protocol family 8
-NET: Registered protocol family 20
-Using IPI Shortcut mode
-ACPI wakeup devices:
-PCI0 PCI1 USB0 USB1 USB2 SU20 SLAN
-ACPI: (supports S0 S1 S4 S5)
-Freeing unused kernel memory: 288k freed
-vga16fb: initializing
-vga16fb: mapped to 0xc00a0000
-Console: switching to colour frame buffer device 80x25
-fb0: VGA16 VGA frame buffer device
-Capability LSM initialized
-VP_IDE: IDE controller at PCI slot 0000:00:11.1
-ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
-PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
-VP_IDE: chipset revision 6
-VP_IDE: not 100% native mode: will probe irqs later
-VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller
-n pci0000:00:11.1
-    ide0: BM-DMA at 0xa800-0xa807, BIOS settings:
-da:DMA, hdb:DMA
-    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings:
-dc:DMA, hdd:DMA
+ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 Probing IDE interface ide0...
 hda: MAXTOR 6L040J2, ATA DISK drive
 hdb: SAMSUNG SP0802N, ATA DISK drive
-ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
 hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
 hdd: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
+ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: max request size: 128KiB
-hda: 78177792 sectors (40027 MB) w/1819KiB Cache,
-HS=65535/16/63, UDMA(33)
+hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63
 hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
-hdb: max request size: 1024KiB
-hdb: 156368016 sectors (80060 MB) w/2048KiB Cache,
-HS=16383/255/63, UDMA(33)
+hdb: max request size: 512KiB
+hdb: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63
 hdb: cache flushes supported
  hdb: hdb1 hdb2 < hdb5 hdb6 >
-hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
-Uniform CD-ROM driver Revision: 3.20
-hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
-usbcore: registered new driver usbfs
-usbcore: registered new driver hub
-USB Universal Host Controller Interface driver v2.3
-ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21
-level, low) -> IRQ 177
-PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 1
-uhci_hcd 0000:00:10.0: UHCI Host Controller
-uhci_hcd 0000:00:10.0: new USB bus registered,
-ssigned bus number 1
-uhci_hcd 0000:00:10.0: irq 177, io base 0x0000b800
-hub 1-0:1.0: USB hub found
-hub 1-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21
-level, low) -> IRQ 177
-PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 1
-uhci_hcd 0000:00:10.1: UHCI Host Controller
-uhci_hcd 0000:00:10.1: new USB bus registered,
-ssigned bus number 2
-uhci_hcd 0000:00:10.1: irq 177, io base 0x0000b400
-hub 2-0:1.0: USB hub found
-hub 2-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21
-level, low) -> IRQ 177
-PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 1
-uhci_hcd 0000:00:10.2: UHCI Host Controller
-uhci_hcd 0000:00:10.2: new USB bus registered,
-ssigned bus number 3
-uhci_hcd 0000:00:10.2: irq 177, io base 0x0000b000
-hub 3-0:1.0: USB hub found
-hub 3-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21
-level, low) -> IRQ 177
-PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 1
-ehci_hcd 0000:00:10.3: EHCI Host Controller
-ehci_hcd 0000:00:10.3: new USB bus registered,
-ssigned bus number 4
-ehci_hcd 0000:00:10.3: irq 177, io mem 0xbe000000
-ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00,
-river 10 Dec 2004
-hub 4-0:1.0: USB hub found
-hub 4-0:1.0: 6 ports detected
-usb 1-1: new full speed USB device using uhci_hcd
-nd address 2
-Attempting manual resume
-EXT3-fs: mounted filesystem with ordered data mode.
+serio: i8042 AUX port at 0x60,0x64 irq 12
+serio: i8042 KBD port at 0x60,0x64 irq 1
+mice: PS/2 mouse device common for all mice
+IPv4 over IPv4 tunneling driver
+TCP bic registered
+Using IPI Shortcut mode
+ACPI: (supports S0 S1 S4 S5)
+Time: tsc clocksource has been installed.
+input: AT Translated Set 2 keyboard as /class/input/input0
 kjournald starting.  Commit interval 5 seconds
-usb 4-1: new high speed USB device using ehci_hcd
-nd address 2
-usb 2-2: new full speed USB device using uhci_hcd
-nd address 2
-usb 2-2: device descriptor read/64, error -71
-usb 2-2: device descriptor read/64, error -71
-usb 2-2: new full speed USB device using uhci_hcd
-nd address 3
-usb 2-2: device descriptor read/64, error -71
-usb 2-2: device descriptor read/64, error -71
-usb 2-2: new full speed USB device using uhci_hcd
-nd address 4
-usb 2-2: device not accepting address 4, error -71
-usb 2-2: new full speed USB device using uhci_hcd
-nd address 5
-usb 2-2: device not accepting address 5, error -71
-pci_hotplug: PCI Hot Plug PCI Core version: 0.5
-shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
+EXT3-fs: mounted filesystem with ordered data mode.
+VFS: Mounted root (ext3 filesystem) readonly.
+Freeing unused kernel memory: 172k freed
+input: ImExPS/2 Logitech Wheel Mouse as /class/input/input1
+NET: Registered protocol family 1
+hdc: ATAPI 52X DVD-ROM drive, 256kB Cache
+Uniform CD-ROM driver Revision: 3.20
+eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected VIA KT400/KT400A/KT600 chipset
 agpgart: AGP aperture is 64M @ 0xf8000000
-irda_init()
-NET: Registered protocol family 23
-via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written
-y Donald Becker
-ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23
-level, low) -> IRQ 185
-PCI: Via IRQ fixup for 0000:00:12.0, from 0 to 9
-eth0: VIA Rhine II at 0x1a400, 00:0e:a6:8a:a6:36, IRQ 185.
-eth0: MII PHY found at address 1, status 0x786d
-dvertising 01e1 Link 45e1.
-gameport: EMU10K1 is pci0000:00:13.1/gameport0, io
-x9800, speed 1217kHz
-ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18
-level, low) -> IRQ 193
-Real Time Clock Driver v1.12
-input: PC Speaker as /class/input/input1
-drivers/usb/class/usblp.c: usblp0: USB
-idirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x2B17
+usbcore: registered new driver usbfs
+usbcore: registered new driver hub
+ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 17
+PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 1
+ehci_hcd 0000:00:10.3: EHCI Host Controller
+ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
+ehci_hcd 0000:00:10.3: irq 17, io mem 0xbe000000
+ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
+usb usb1: configuration #1 chosen from 1 choice
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 6 ports detected
+Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
+serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
+ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 18
+ACPI: PCI interrupt for device 0000:00:0d.0 disabled
+usb 1-1: new high speed USB device using ehci_hcd and address 2
+usb 1-1: configuration #1 chosen from 1 choice
+ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 19
+VP_IDE: IDE controller at PCI slot 0000:00:11.1
+ACPI: Unable to derive IRQ for device 0000:00:11.1
+ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
+PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 15
+VP_IDE: chipset revision 6
+VP_IDE: not 100% native mode: will probe irqs later
+VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
+VP_IDE: port 0x01f0 already claimed by ide0
+VP_IDE: port 0x0170 already claimed by ide1
+VP_IDE: neither IDE port enabled (BIOS)


Hmmm, this smells strange.


+NET: Registered protocol family 17
+drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if
+ alt 0 proto 2 vid 0x03F0 pid 0x2B17
 usbcore: registered new driver usblp
-drivers/usb/class/usblp.c: v0.13: USB Printer
-evice Class driver
-Floppy drive(s): fd0 is 1.44M
-parport: PnPBIOS parport detected.
-parport0: PC-style at 0x378 (0x778), irq 7, dma 3
-PCSPP,TRISTATE,COMPAT,ECP,DMA]
-FDC 0 is a post-1991 82077
-eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
-input: ImExPS/2 Logitech Wheel Mouse as /class/input/input2
-ts: Compaq touchscreen protocol output
-lp0: using parport0 (interrupt-driven).
-fuse init (API version 7.3)
-fglrx: module license 'Proprietary. (C) 2002 - ATI
-echnologies, Starnberg, GERMANY' taints kernel.
-[fglrx] Maximum main memory to use for locked dma
-uffers: 929 MBytes.
-[fglrx] module loaded - fglrx 8.29.6 [Sep 19 2006] on minor 0
-Adding 1028120k swap on /dev/hda7.  Priority:-1
-xtents:1 across:1028120k
+drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
+parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
+parport0: irq 7 detected
+lp0: using parport0 (polling).
+fuse init (API version 7.7)
+Adding 1028120k swap on /dev/hda7.  Priority:-1 extents:1 across:1028120k
 EXT3 FS on hda3, internal journal
 md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
 md: bitmap version 4.39
-NET: Registered protocol family 17
-device-mapper: 4.4.0-ioctl (2005-01-12)
-nitialised: dm-devel@redhat.com
-cdrom: open failed.
+device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hda1, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
-EXT3 FS on hdb1, internal journal
-EXT3-fs: mounted filesystem with ordered data mode.
-kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hda5, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
-ACPI: Power Button (FF) [PWRF]
-ACPI: Power Button (CM) [PWRB]
-ibm_acpi: ec object not found
-pcc_acpi: loading...
-ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16
-level, low) -> IRQ 169
-ppdev: user-space parallel port driver
-apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
-apm: overridden by ACPI.
-[fglrx] AGP detected, AgpState   = 0x1f000a0b
-hardware caps of chipset)
-agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
-agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
-agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
-[fglrx] AGP enabled,  AgpCommand = 0x1f000302 (selected caps)
-[fglrx] total      GART = 67108864
-[fglrx] free       GART = 51113984
-[fglrx] max single GART = 51113984
-[fglrx] total      LFB  = 126873600
-[fglrx] free       LFB  = 116387840
-[fglrx] max single LFB  = 116387840
-[fglrx] total      Inv  = 134217728
-[fglrx] free       Inv  = 134217728
-[fglrx] max single Inv  = 134217728
-[fglrx] total      TIM  = 0
-NET: Registered protocol family 10
-lo: Disabled Privacy Extensions
-IPv6 over IPv4 tunneling driver
-eth0: no IPv6 routers present
-ISO 9660 Extensions: Microsoft Joliet Level 3
-ISOFS: changing to secondary root
-Bluetooth: Core ver 2.8
-NET: Registered protocol family 31
-Bluetooth: HCI device and connection manager initialized
-Bluetooth: HCI socket layer initialized
-Bluetooth: L2CAP ver 2.8
-Bluetooth: L2CAP socket layer initialized
-Bluetooth: RFCOMM socket layer initialized
-Bluetooth: RFCOMM TTY layer initialized
-Bluetooth: RFCOMM ver 1.7

Sorry, it's not exact diff, but there were some line wraps.

Which ATA do you use (the prod or experimental)? Post a .config.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
