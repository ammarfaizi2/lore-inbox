Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbUKRUwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUKRUwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUKRUwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:52:00 -0500
Received: from proxy.quengel.org ([213.146.113.159]:4224 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S262910AbUKRUqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:46:50 -0500
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1 (8139too interrupt)
References: <20041116014213.2128aca9.akpm@osdl.org>
	<87lld0rb2i.fsf-news@hsp-law.de>
	<20041117110640.1c7ccccd.akpm@osdl.org>
	<87actgt8zy.fsf-news@hsp-law.de>
From: Ralf Gerbig <rge@quengel.org>
Date: Thu, 18 Nov 2004 21:46:44 +0100
In-Reply-To: <87actgt8zy.fsf-news@hsp-law.de> (Ralf Gerbig's message of
 "Wed, 17 Nov 2004 23:18:25 +0100")
Message-ID: <87sm76q40b.fsf-news@hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ cc'd Dave ]

* Ralf Gerbig writes:

> Hi Andrew,
* Andrew Morton writes:

>> Ralf Gerbig <rge@quengel.org> wrote:
>>> 
>>> ...
>>> [ide_intr+0/496] (ide_intr+0x0/0x1f0)
>>> [<c0269c80>] (ide_intr+0x0/0x1f0)
>>> [ide_intr+0/496] (ide_intr+0x0/0x1f0)
>>> [<c0269c80>] (ide_intr+0x0/0x1f0)
>>> [pg0+541642080/1068946432] (rtl8139_interrupt+0x0/0x1d0 [8139too])
>>> [<e091dd60>] (rtl8139_interrupt+0x0/0x1d0 [8139too])
>>> Disabling IRQ #19
>>> 
>>> NETDEV WATCHDOG: eth1: transmit timed out
>>> eth1: Transmit timeout, status 0c 0005 c07f media 18.
>>> eth1: Tx queue start entry 63  dirty entry 59.
>>> eth1:  Tx descriptor 0 is 0008a03c.
>>> eth1:  Tx descriptor 1 is 0008a06a.
>>> eth1:  Tx descriptor 2 is 0008a03c.
>>> eth1:  Tx descriptor 3 is 0008a03c. (queue head)
>>> eth1: link up, 10Mbps, full-duplex, lpa 0x4061
>>> 
>>> and the interface is dead. Rmmod/insmod does not help.

>> Does this happen immediately, or does it take a bit of load first?

> dunno exactly, the log shows the trace right at boot and again after
> about 6h.
> Logged in the next morning and found no new messages on lkml, looked
> at the log, did the ifdown -- rmmod -- modprobe -- ifup, still no joy,
> rebooted -- the pppd connection came up but went down while changing
> to runlevel 5.

investigating further, radeon.ko nukes the NIC / INT

changing to runlevel 5 gets:

[2.6.10-rc2-mm2]

device class 'drm': registering
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
CLASS: registering class device: ID = 'card0'
class_hotplug - name = card0
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 4x mode
[drm] Loading R200 Microcode
drivers/usb/input/hid-input.c: event field not found
irq 19: nobody cared!
[ ...see below ]

  0:      75841    IO-APIC-edge  timer
  1:         94    IO-APIC-edge  i8042
  3:         11    IO-APIC-edge  serial
  7:          0    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 12:        127    IO-APIC-edge  i8042
 14:       3453    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
 16:         46   IO-APIC-level  libata, fcpcipnp
 17:          2   IO-APIC-level  ohci1394
 19:      20000   IO-APIC-level  ide2, ide3, eth1
 20:        383   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  ohci_hcd, NVidia nForce2
 22:       5178   IO-APIC-level  eth0, ehci_hcd
NMI:          0 
LOC:      75736 
ERR:          0
MIS:          0

when booting without radeon, eth1 works, with radeon neither eth1 nor
drm are working.

[2.6.9-mm1]

ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 4x mode
[drm] Loading R200 Microcode


           CPU0       
  0:     235520          XT-PIC  timer
  1:        399    IO-APIC-edge  i8042
  3:         11    IO-APIC-edge  serial
  7:        503    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 12:       1587    IO-APIC-edge  i8042
 14:       6930    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
 16:       1279   IO-APIC-level  libata, fcpcipnp
 17:          2   IO-APIC-level  ohci1394
 19:      10838   IO-APIC-level  ide2, ide3, eth1, radeon@PCI:2:0:0
 20:       1629   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  ohci_hcd
 22:      21399   IO-APIC-level  eth0, ehci_hcd
NMI:          0 
LOC:     235288 
ERR:          0
MIS:          0

on 2.6.9-mm1 eth1 _and_ drm are working according to glxlinfo.
from 2.6.10-rc1-mm5 on (did not try anything between 2.6.9-mm1 and
2.6.10-rc1-mm5) drm no workie.

System: SuSE 9.1, EPOX 8RDA+, Athlon XP2800

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:07.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
0000:01:08.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN (rev 01)
0000:01:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:01:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:0c.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
0000:01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV280 [Radeon 9200] (rev 01)
0000:02:00.1 Display controller: ATI Technologies Inc: Unknown device 5941 (rev 01)


[fullquote for Dave ]

>> We should be looking for changes in 8139too, changes in IDE or changes in
>> interrupt setup.  Usually it is the latter.  It would be helpful if you
>> could gather the boot-time dmesg output from rc1-mm5 and rc2-mm1 and do a
>> `diff -u', see what changed.

> --- /var/log/boot.msg	2004-11-17 11:37:57.000000000 +0100
> +++ /var/log/boot.omsg	2004-11-17 11:36:08.000000000 +0100
> @@ -1,10 +1,10 @@
> -Inspecting /boot/System.map-2.6.10-rc1-mm5
> -Loaded 27073 symbols from /boot/System.map-2.6.10-rc1-mm5.
> +Inspecting /boot/System.map-2.6.10-rc2-mm1
> +Loaded 26846 symbols from /boot/System.map-2.6.10-rc2-mm1.
>  Symbols match kernel version 2.6.10.
>  No module symbols loaded - kernel modules not enabled.

>  klogd 1.4.1, log source = ksyslog started.
> -<4>Linux version 2.6.10-rc1-mm5 (rge@gerlin1) (gcc version 3.3.3 (SuSE Linux)) #1 Thu Nov 11 20:18:40 CET 2004
> +<4>Linux version 2.6.10-rc2-mm1 (rge@gerlin1) (gcc version 3.3.3 (SuSE Linux)) #1 Tue Nov 16 21:48:13 CET 2004
>  <6>BIOS-provided physical RAM map:
>  <4> BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
>  <4> BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
> @@ -34,23 +34,24 @@
>  <6>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>  <4>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
>  <6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> +<4>ACPI: BIOS IRQ0 pin2 override ignored.
>  <6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> -<7>ACPI: IRQ0 used by override.
> -<7>ACPI: IRQ2 used by override.
>  <7>ACPI: IRQ9 used by override.
>  <4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
>  <6>Using ACPI (MADT) for SMP configuration information
>  <4>Built 1 zonelists
> +<7>mapped APIC to ffffd000 (fee00000)
> +<7>mapped IOAPIC to ffffc000 (fec00000)
>  <6>Initializing CPU#0
> -<4>Kernel command line: root=/dev/hda2 console=ttyS1,38400 console=tty0 3
> -<4>CPU 0 irqstacks, hard=c045c000 soft=c045b000
> +<4>Kernel command line: root=/dev/hda2 3
> +<4>CPU 0 irqstacks, hard=c0453000 soft=c0452000
>  <4>PID hash table entries: 2048 (order: 11, 32768 bytes)
> -<4>Detected 2088.590 MHz processor.
> +<4>Detected 2088.645 MHz processor.
>  <6>Using pmtmr for high-res timesource
>  <4>Console: colour VGA+ 80x25
>  <4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>  <4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> -<6>Memory: 515032k/524224k available (2178k kernel code, 8632k reserved, 1063k data, 168k init, 0k highmem)
> +<6>Memory: 515072k/524224k available (2143k kernel code, 8592k reserved, 1055k data, 176k init, 0k highmem)
>  <4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
>  <7>Calibrating delay loop... 4136.96 BogoMIPS (lpj=2068480)
>  <4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> @@ -68,14 +69,10 @@
>  <4> tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
>  <4>Parsing all Control Methods:...................................................................................................................................................................................................................................................................................
>  <4>Table [DSDT](id F004) - 806 Objects with 77 Devices 275 Methods 36 Regions
> -<4>ACPI Namespace successfully loaded at root c0488120
> +<4>ACPI Namespace successfully loaded at root c047f120
>  <4>evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
>  <4>ENABLING IO-APIC IRQs
> -<6>..TIMER: vector=0x31 pin1=2 pin2=-1
> -<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
> -<6>...trying to set up timer (IRQ0) through the 8259A ...  failed.
> -<6>...trying to set up timer as Virtual Wire IRQ... failed.
> -<6>...trying to set up timer as ExtINT IRQ... works.
> +<6>..TIMER: vector=0x31 pin1=0 pin2=-1
>  <6>NET: Registered protocol family 16
>  <6>PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
>  <6>PCI: Using configuration type 1
> @@ -160,7 +157,6 @@
>  <4>vesafb: probe of vesafb0 failed with error -6
>  <6>isapnp: Scanning for PnP cards...
>  <6>isapnp: No Plug & Play device found
> -<6>[drm] Initialized drm 1.0.0 20040925
>  <6>ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
>  <6>ACPI: PS/2 Mouse Controller [PS2M] at irq 12
>  <6>serio: i8042 AUX port at 0x60,0x64 irq 12
> @@ -223,8 +219,8 @@
>  <6>hdg: 40020624 sectors (20490 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(100)
>  <7>hdg: cache flushes not supported
>  <6> hdg: hdg1 hdg2 hdg3 hdg4
> -<7>libata version 1.02 loaded.
> -<7>sata_sil version 0.54
> +<7>libata version 1.10 loaded.
> +<7>sata_sil version 0.8
>  <4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
>  <6>ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
>  <6>ata1: SATA max UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma 0xE0802000 irq 16
> @@ -255,7 +251,7 @@
>  <4>HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
>  <6>EXT3-fs: mounted filesystem with ordered data mode.
>  <4>VFS: Mounted root (ext3 filesystem) readonly.
> -<6>Freeing unused kernel memory: 168k freed
> +<6>Freeing unused kernel memory: 176k freed
>  <6>kjournald starting.  Commit interval 5 seconds
>  <6>EXT3 FS on hda2, internal journal
>  <5>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> @@ -281,7 +277,7 @@
>  Kernel logging (ksyslog) stopped.
>  Kernel log daemon terminating.

> -Boot logging started on /dev/tty1(/dev/console) at Wed Nov 17 11:37:12 2004
> +Boot logging started on /dev/tty1(/dev/console) at Wed Nov 17 11:32:45 2004

> ---------------------------------------

> --- log-rc1-mm5	2004-11-17 22:55:19.088281605 +0100
> +++ log-rc2-mm1	2004-11-17 22:55:31.521176195 +0100
> @@ -1,34 +1,32 @@
>  syslogd 1.4.1: restart.
> -pppd[3551]: Plugin rp-pppoe.so loaded.
> -pppd[3551]: RP-PPPoE plugin version 3.3 compiled against pppd 2.4.2
> -pppd[3551]: pppd 2.4.2 started by root, uid 0
> -pppd[3551]: PPP session is 1892
> -pppd[3551]: Using interface ppp0
> -pppd[3551]: Connect: ppp0 <--> eth1
> -pppd[3551]: Couldn't increase MTU to 1500
> -pppd[3551]: Couldn't increase MRU to 1500
> -pppd[3551]: Couldn't increase MRU to 1500
> -pppd[3551]: Couldn't increase MTU to 1500
> -pppd[3551]: Couldn't increase MRU to 1500
> -pppd[3551]: Couldn't increase MRU to 1500
> -pppd[3551]: PAP authentication succeeded
> -pppd[3551]: peer from calling number <me> authorized
> -pppd[3551]: local  IP address <mine>
> -pppd[3551]: remote IP address <the other>
> -pppd[3551]: Script /etc/ppp/ip-up finished (pid 3705), status = 0x0
> -/sbin/hotplug[4730]: /etc/hotplug/ieee1394.agent: line 22: VENDOR_ID: Bad invocation: $VENDOR_ID is not set
> +pppd[3535]: Plugin rp-pppoe.so loaded.
> +pppd[3535]: RP-PPPoE plugin version 3.3 compiled against pppd 2.4.2
> +pppd[3535]: pppd 2.4.2 started by root, uid 0
> +pppd[3535]: PPP session is 6975
> +pppd[3535]: Using interface ppp0
> +pppd[3535]: Connect: ppp0 <--> eth1
> +pppd[3535]: Couldn't increase MTU to 1500
> +pppd[3535]: Couldn't increase MRU to 1500
> +pppd[3535]: Couldn't increase MRU to 1500
> +pppd[3535]: Couldn't increase MTU to 1500
> +pppd[3535]: Couldn't increase MRU to 1500
> +pppd[3535]: Couldn't increase MRU to 1500
> +pppd[3535]: PAP authentication succeeded
> +pppd[3535]: peer from calling number <me> authorized
> +pppd[3535]: local  IP address <mine>
> +pppd[3535]: remote IP address <the other>
> +pppd[3535]: Script /etc/ppp/ip-up finished (pid 3708), status = 0x0
> +/etc/hotplug/usb.agent[4083]: need a device for this command
> +/etc/hotplug/usb.agent[4224]: need a device for this command
> +/etc/hotplug/usb.agent[4277]: need a device for this command
> +/etc/hotplug/usb.agent[4473]: need a device for this command
> +/etc/hotplug/usb.agent[4462]: need a device for this command
> +/sbin/hotplug[4643]: /etc/hotplug/ieee1394.agent: line 22: VENDOR_ID: Bad invocation: $VENDOR_ID is not set
> +/sbin/hotplug[4770]: /etc/hotplug/ieee1394.agent: line 22: VENDOR_ID: Bad invocation: $VENDOR_ID is not set
> +/sbin/hotplug[4789]: /etc/hotplug/ieee1394.agent: line 22: VENDOR_ID: Bad invocation: $VENDOR_ID is not set
>  kernel: klogd 1.4.1, log source = /proc/kmsg started.
> -kernel: Inspecting /boot/System.map-2.6.10-rc1-mm5
> -kernel: Loaded 27073 symbols from /boot/System.map-2.6.10-rc1-mm5.
> +kernel: Inspecting /boot/System.map-2.6.10-rc2-mm1
> +kernel: Loaded 26846 symbols from /boot/System.map-2.6.10-rc2-mm1.
>  kernel: Symbols match kernel version 2.6.10.
>  kernel: No module symbols loaded - kernel modules not enabled. 
>  kernel: ip_tables: (C) 2000-2002 Netfilter core team
> @@ -59,105 +57,102 @@
>  kernel: eth0: no link during initialization.
>  kernel: 8139too Fast Ethernet driver 0.9.27
>  kernel: ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
> -kernel: eth1: RealTek RTL8139 at 0xe08ee000, 00:04:61:4a:11:a5, IRQ 19
> +kernel: eth1: RealTek RTL8139 at 0xe08ea000, 00:04:61:4a:11:a5, IRQ 19
>  kernel: eth1:  Identified 8139 chip type 'RTL-8101'
>  kernel: eth1: link up, 10Mbps, full-duplex, lpa 0x4061
>  kernel: PPP generic driver version 2.4.2
>  kernel: NET: Registered protocol family 24
> +kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
> +kernel: ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 21 (level, high) -> IRQ 21
> +kernel: ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
> +kernel: PCI: Setting latency timer of device 0000:00:02.2 to 64
> +kernel: ehci_hcd 0000:00:02.2: irq 21, pci mem 0xdd004000
>  kernel: Linux agpgart interface v0.100 (c) Dave Jones
> +kernel: ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> +kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.2
> +kernel: ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
> +kernel: ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> +kernel: hub 1-0:1.0: USB hub found
> +kernel: hub 1-0:1.0: 6 ports detected
>  kernel: agpgart: Detected NVIDIA nForce2 chipset
>  kernel: agpgart: Maximum main memory to use for agp memory: 439M
>  kernel: agpgart: AGP aperture is 128M @ 0xc0000000
> -kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> -kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
> -kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 21 (level, high) -> IRQ 21
> +kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
> +kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 20 (level, high) -> IRQ 20
>  kernel: ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
>  kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
> -kernel: ohci_hcd 0000:00:02.0: irq 21, pci mem 0xdd002000
> -kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> -kernel: hub 1-0:1.0: USB hub found
> -kernel: hub 1-0:1.0: 3 ports detected
> -kernel: ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
> -kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 20 (level, high) -> IRQ 20
> -kernel: ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> -kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
> -kernel: ohci_hcd 0000:00:02.1: irq 20, pci mem 0xdd003000
> -kernel: ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
> -kernel: usb 1-3: new low speed USB device using ohci_hcd and address 2
> +kernel: ohci_hcd 0000:00:02.0: irq 20, pci mem 0xdd002000
> +kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
>  kernel: hub 2-0:1.0: USB hub found
>  kernel: hub 2-0:1.0: 3 ports detected
> -kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
> -kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5040
> -kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
> -kernel: ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 22 (level, high) -> IRQ 22
> -kernel: ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
> -kernel: PCI: Setting latency timer of device 0000:00:02.2 to 64
> -kernel: ehci_hcd 0000:00:02.2: irq 22, pci mem 0xdd004000
> -kernel: ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
> -kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.2
> -kernel: ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
> +kernel: ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
> +kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 22 (level, high) -> IRQ 22
> +kernel: ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> +kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
> +kernel: ohci_hcd 0000:00:02.1: irq 22, pci mem 0xdd003000
> +kernel: ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
>  kernel: hub 3-0:1.0: USB hub found
> -kernel: hub 3-0:1.0: 6 ports detected
> +kernel: hub 3-0:1.0: 3 ports detected
> +kernel: usb 2-3: new low speed USB device using ohci_hcd and address 2
>  kernel: ieee1394: Initialized config rom entry `ip1394'
> -kernel: usb 1-3: USB disconnect, address 2
> +kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
> +kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5040
>  kernel: ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
>  kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
>  kernel: ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 17 (level, high) -> IRQ 17
>  kernel: ohci1394: fw-host0: Unexpected PCI resource length of 1000!
> -kernel: usb 1-3: new low speed USB device using ohci_hcd and address 3
>  kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[dc007000-dc0077ff]  Max Packet=[2048]
>  kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000461000003e56a]
> -/sbin/hotplug[4955]: /etc/hotplug/ieee1394.agent: line 22: VENDOR_ID: Bad invocation: $VENDOR_ID is not set
> -/sbin/hotplug[4936]: /etc/hotplug/ieee1394.agent: line 22: VENDOR_ID: Bad invocation: $VENDOR_ID is not set
> -in.identd[5083]: started
> +in.identd[5088]: started
>  kernel: NET: Registered protocol family 10
> -kernel: Disabled Privacy Extensions on device c03bf8c0(lo)
> +kernel: Disabled Privacy Extensions on device c03b55a0(lo)
>  kernel: IPv6 over IPv4 tunneling driver
> +kernel: Disabled Privacy Extensions on device dc330000(sit0)
>  ip-up: fetchmail: no mailservers have been specified.
> -kernel: snd_intel8x0: Unknown parameter `#enable'
> -/sbin/hotplug[5611]: /sbin/hotplug: line 74: [: too many arguments
> -kernel: ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
> -kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
> -kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
> -named[5664]: starting BIND 9.2.3 -t /var/lib/named -u named
> -named[5664]: using 1 CPU
> -sshd[5672]: Server listening on :: port 22.
> -/sbin/hotplug[5611]: /sbin/hotplug: line 74: [: too many arguments
>  kernel: input: USB HID v1.10 Keyboard [Twinhan Tech Remote Control] on usb-0000:00:02.0-3
>  kernel: input: USB HID v1.10 Mouse [Twinhan Tech Remote Control] on usb-0000:00:02.0-3
>  kernel: usbcore: registered new driver usbhid
>  kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> +kernel: snd_intel8x0: Unknown parameter `#enable'
> +kernel: ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
> +kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
> +kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
> +sshd[5696]: Server listening on :: port 22.
> +/sbin/hotplug[5674]: /sbin/hotplug: line 74: [: too many arguments
> +named[5794]: starting BIND 9.2.3 -t /var/lib/named -u named
> +named[5794]: using 1 CPU
> +/sbin/hotplug[5674]: /sbin/hotplug: line 74: [: too many arguments
> +named[5794]: loading configuration from '/etc/named.conf'
>  ip-up: postqueue: fatal: Cannot flush mail queue - mail system is down
>  ifup: No configuration found for sit0
>  su: (to news) root on /dev/pts/2
>  su: pam_unix2: session started for user news, service su 
> @@ -173,7 +168,6 @@
>  dhcpd: Wrote 0 deleted host decls to leases file.
>  dhcpd: Wrote 0 new dynamic host decls to leases file.
>  dhcpd: Wrote 0 leases to leases file.
> -kernel: parport_pc: Ignoring new-style parameters in presence of obsolete ones
>  kernel: parport: PnPBIOS parport detected.
>  kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
>  dhcpd: Listening on Socket/eth0/192.168.100.0/24
> @@ -182,79 +176,162 @@
>  kernel: lp0: using parport0 (interrupt-driven).
>  kernel: usbcore: registered new driver usbserial
>  kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
> [ ... ]
> +kernel: [drm] Initialized drm 1.0.0 20040925
>  kernel: [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
>  kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
> -kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> -kernel: [drm:drm_unlock] *ERROR* Process 10713 using kernel context 0
> +kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> +kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
> +kernel: agpgart: Putting AGP V3 device at 0000:02:00.0 into 4x mode
> +kernel: [drm] Loading R200 Microcode
>  kernel: drivers/usb/input/hid-input.c: event field not found
> +kernel: irq 19: nobody cared!
> +kernel:  [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
> +kernel:  [<c01388ea>] __report_bad_irq+0x2a/0x90
> +kernel:  [handle_IRQ_event+57/112] handle_IRQ_event+0x39/0x70
> +kernel:  [<c01381a9>] handle_IRQ_event+0x39/0x70
> +kernel:  [note_interrupt+149/192] note_interrupt+0x95/0xc0
> +kernel:  [<c0138a05>] note_interrupt+0x95/0xc0
> +kernel:  [__do_IRQ+357/384] __do_IRQ+0x165/0x180
> +kernel:  [<c0138345>] __do_IRQ+0x165/0x180
> +kernel:  [do_IRQ+71/112] do_IRQ+0x47/0x70
> +kernel:  [<c0105907>] do_IRQ+0x47/0x70
> +kernel:  =======================
> +kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
> +kernel:  [<c0103c52>] common_interrupt+0x1a/0x20
> +kernel:  [default_idle+0/48] default_idle+0x0/0x30
> +kernel:  [<c0101030>] default_idle+0x0/0x30
> +kernel:  [default_idle+35/48] default_idle+0x23/0x30
> +kernel:  [<c0101053>] default_idle+0x23/0x30
> +kernel:  [cpu_idle+54/112] cpu_idle+0x36/0x70
> +kernel:  [<c01010d6>] cpu_idle+0x36/0x70
> +kernel:  [start_kernel+346/384] start_kernel+0x15a/0x180
> +kernel:  [<c042180a>] start_kernel+0x15a/0x180
> +kernel:  [unknown_bootoption+0/480] unknown_bootoption+0x0/0x1e0
> +kernel:  [<c0421380>] unknown_bootoption+0x0/0x1e0
> +kernel: handlers:
> +kernel: [ide_intr+0/496] (ide_intr+0x0/0x1f0)
> +kernel: [<c0269c80>] (ide_intr+0x0/0x1f0)
> +kernel: [ide_intr+0/496] (ide_intr+0x0/0x1f0)
> +kernel: [<c0269c80>] (ide_intr+0x0/0x1f0)
> +kernel: [pg0+541625696/1068946432] (rtl8139_interrupt+0x0/0x1d0 [8139too])
> +kernel: [<e0919d60>] (rtl8139_interrupt+0x0/0x1d0 [8139too])
> +kernel: Disabling IRQ #19
> +kernel: NETDEV WATCHDOG: eth1: transmit timed out
> +kernel: eth1: Transmit timeout, status 0c 0005 c07f media 18.
> +kernel: eth1: Tx queue start entry 70  dirty entry 66.
> +kernel: eth1:  Tx descriptor 0 is 0008a06a.
> +kernel: eth1:  Tx descriptor 1 is 0008a03c.
> +kernel: eth1:  Tx descriptor 2 is 0008a03c. (queue head)
> +kernel: eth1:  Tx descriptor 3 is 0008a03c.
> +kernel: eth1: link up, 10Mbps, full-duplex, lpa 0x4061
> +kernel: NETDEV WATCHDOG: eth1: transmit timed out
> +kernel: eth1: Transmit timeout, status 0d 0004 c07f media 18.
> +kernel: eth1: Tx queue start entry 4  dirty entry 0.
> +kernel: eth1:  Tx descriptor 0 is 0008a062. (queue head)
> +kernel: eth1:  Tx descriptor 1 is 0008a062.
> +kernel: eth1:  Tx descriptor 2 is 0008a03c.
> +kernel: eth1:  Tx descriptor 3 is 0008a03c.
> +kernel: eth1: link up, 10Mbps, full-duplex, lpa 0x4061
> +pppd[3535]: No response to 5 echo-requests
> +pppd[3535]: Serial link appears to be disconnected.
> +pppd[3535]: Couldn't increase MTU to 1500
> +pppd[3535]: Couldn't increase MRU to 1500
> +pppd[3535]: Script /etc/ppp/ip-down finished (pid 11312), status = 0x0
> +pppd[3535]: Connection terminated.
> +pppd[3535]: Connect time 2.1 minutes.
> +pppd[3535]: Sent 3160 bytes, received 8797 bytes.
> +kernel: NETDEV WATCHDOG: eth1: transmit timed out
> +kernel: eth1: Transmit timeout, status 0c 0005 c07f media 18.
> +kernel: eth1: Tx queue start entry 4  dirty entry 0.
> +kernel: eth1:  Tx descriptor 0 is 0008a03c. (queue head)
> +kernel: eth1:  Tx descriptor 1 is 0008a03c.
> +kernel: eth1:  Tx descriptor 2 is 0008a03c.
> +kernel: eth1:  Tx descriptor 3 is 0008a03c.
> +kernel: eth1: link up, 10Mbps, full-duplex, lpa 0x4061
> +pppd[3535]: Timeout waiting for PADO packets
> +pppd[3535]: Unable to complete PPPoE Discovery
> +kernel: NETDEV WATCHDOG: eth1: transmit timed out
> +kernel: eth1: Transmit timeout, status 0c 0005 c07f media 18.
> +kernel: eth1: Tx queue start entry 4  dirty entry 0.
> +kernel: eth1:  Tx descriptor 0 is 0008a03c. (queue head)
> +kernel: eth1:  Tx descriptor 1 is 0008a03c.
> +kernel: eth1:  Tx descriptor 2 is 0008a03c.
> +kernel: eth1:  Tx descriptor 3 is 0008a03c.
> +kernel: eth1: link up, 10Mbps, full-duplex, lpa 0x4061
> +pppd[3535]: Timeout waiting for PADO packets
> +pppd[3535]: Unable to complete PPPoE Discovery
> +pppd[3535]: Timeout waiting for PADO packets
> +pppd[3535]: Unable to complete PPPoE Discovery

> Ralf


-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
