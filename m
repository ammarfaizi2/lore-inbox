Return-Path: <linux-kernel-owner+w=401wt.eu-S1750919AbXACQ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbXACQ0S (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbXACQ0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:26:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:41530 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXACQ0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:26:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h9K149m+0Hj2AfAQVoAGF4aBHysC/XAdiA6wRzyWvSt6HpBsyn4TA5sXYFcxGnFgXM3s8aL29QozqzD7mdV8GqWGpMAL4AS2Yvm2MZgn+zX7xSx8AomNpWcv3DJVx/NwHQvNVQOczV52r506hWQ4nV5k+RLE6VeNhWQTWL3hLqI=
Message-ID: <f4527be0701030826q14029246s9e6da11177c9786b@mail.gmail.com>
Date: Wed, 3 Jan 2007 16:26:13 +0000
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: linux-ide@vger.kernel.org,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Fwd: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0) r0xj0
In-Reply-To: <f4527be0701030825m3e07a38dm67d2c21fd25b1978@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
	 <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org>
	 <459B140C.1060401@gmail.com>
	 <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>
	 <f4527be0701030825m3e07a38dm67d2c21fd25b1978@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Andrew Lyon <andrew.lyon@gmail.com>
Date: Jan 3, 2007 4:25 PM
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag
-84148995 sactive 0x0) r0xj0
To: bbee <bumble.bee@xs4all.nl>


On 1/3/07, bbee <bumble.bee@xs4all.nl> wrote:
> On Wed, 3 Jan 2007, Tejun Heo wrote:
> > bbee wrote:
> >> Tejun Heo <htejun <at> gmail.com> writes:
> >>> Andrew Lyon wrote:
> >>>> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> >>>>
> >>>> Is this condition dangerous?
> >>> Not usually.  Might indicate something is going wrong in some really
> >>> rare cases.  I think vendors are getting NCQ right these days.  Maybe
> >>> it's time to remove that printk.
> >>
> >> Hi Tejun, it's funny you should say that, because in the subthread at
> >> http://thread.gmane.org/gmane.linux.ide/10264/focus=10334
> >> you seemed to have major issues with this very error and were saying there
> >> could even be data corruption.
> >
> > Yeap, I have major issues with SDB FISes which contains spurious
> > completions but most other spurious interrupts shouldn't be dangerous
> > and I haven't seen spurious completions for quite some time, so I was
> > thinking either removing the message or printing it only on SDB FIS
> > containing spurious completions.
> >
> > But, Andrew Lyon *is* reporting spurious completions.  Now I just wanna
> > update those printks such that more info is reported only on spurious
> > SDB FISes.
>
> That would certainly help verify that I'm having the exact same problem,
> since Andrew didn't say anything about his drive going offline.
>
> >> However, in my case it gets a lot worse. The following happens infrequently,
> >> usually within 15 days of uptime on a light I/O load:
> >>
> >> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >> [---snip---]
> >> ata1.00: detaching (SCSI 0:0:0:0)
> >> scsi 0:0:0:0: rejecting I/O to dead device
> >>
> >> The drive then dissapears from the system. This is not preceded by any
> >> spurious interrupt messages, but I have a hunch it is related because
> >> following your grave comments in the referenced thread, I looked for a kernel
> >> option to disable NCQ. Astonished to find none, I changed the source using the
> >> flag you added in this patch:
> >
> > Yeah, it usually indicates lousy NCQ implementation on drive's side.  I
> > can't tell whether the drive going offline is directly related tho.

When NCQ support was first added for JMicron controller I noticed that
drive performance was not as good as without NCQ, at least thats what
hdparm -tT reported (~50mb vs 80+mb/sec).. I emailed linux-ide and cc
Alan Cox, Alan suggested I try adding AHCI_FLAG_NO_NCQ to disable NCQ,
I tried that and it seemed to fix the problem.

I ran with NCQ disabled for a while, but during a kernel upgrade I
forgot to add AHCI_FLAG_NO_NCQ again and as a result NCQ has been
enabled for the past few weeks, I have only noticed the spurious
interrupts messages when NCQ has been enabled, but they are fairly
infrequent and may have always been there.

Alan said he was going to add the drive to a blacklist he was
maintaining for NCQ, perhaps that has been done in kernel 2.6.19, I
dont know as I am still running 2.6.18.

Perhaps the WD Raptor drive that I have does have lousy NCQ and that
explains both the poor performance and the spurious interrupts.

Andy

>
> Neither can I, but it has definately stopped since I disabled NCQ.
>
> >> With NCQ disabled, the spurious interrupt messages as well as the exceptions
> >> go away.
> >
> > Hmmm... How certain are you about disabling NCQ fixing the problem?  Are
> > other conditions controlled?
>
> Well, it's not a lab environment ("production" PVR box), and I can't be
> sure what conditions to control since the exception occurs unpredictably
> (which is why I suspected noise issues). The spurious interrupts were more
> frequent, 5-6 a day.
>
> But I did only start using the SATA chip after the "major libata update"
> the first thread was about so I can't say anything about stability with the
> earlier ahci code.
>
> > How many times did you verify the fix?
>
> I can't perfectly verify the fix since I don't have a test case.
> However by my syslog history in the past 3.5 months the system never went
> above 15 days of uptime before the exception ocurred, it's now been up for
> 24. The spurious interrupts are completely gone.
>
> > If you undo the change and leave everything else the same, does the
> > exception come back?
>
> I reverted the patch and am waiting for the exception while running "stress
> --io 2 --hdd 2". By past experience, it could take a while; I am already
> seeing the spurious iterrupt messages though.
>
> > Can you post the results of 'dmesg' and 'hdparm -I /dev/sdX'?
>
> Follows at end of message (md init snipped from dmesg for brevity).
>
> > Yeap, I'm definitely interested in resolving this problem.  It's not
> > likely but possible that the *controller* is responsible for spurious
> > interrupts.
>
> Unfortunately I don't have any other model of SATA drive to test it with,
> but Andrew by his dmesg seems to be using a different brand of drive.
>
>
>
> dmesg :
>
> Linux version 2.6.19-hardened-r3 (root@pixie) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #2 PREEMPT Wed Jan 3 03:45:15 CET 2007
> Command line: root=/dev/md4
> BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>   BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>   BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
>   BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
>   BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
>   BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
>   BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
> Entering add_active_range(0, 0, 159) 0 entries of 256 used
> Entering add_active_range(0, 256, 524208) 1 entries of 256 used
> end_pfn_map = 1048576
> DMI 2.3 present.
> ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f9a20
> ACPI: RSDT (v001 A M I  OEMRSDT  0x05000629 MSFT 0x00000097) @ 0x000000007ffb0000
> ACPI: FADT (v002 A M I  OEMFACP  0x05000629 MSFT 0x00000097) @ 0x000000007ffb0200
> ACPI: MADT (v001 A M I  OEMAPIC  0x05000629 MSFT 0x00000097) @ 0x000000007ffb0390
> ACPI: MCFG (v001 A M I  OEMMCFG  0x05000629 MSFT 0x00000097) @ 0x000000007ffb0400
> ACPI: OEMB (v001 A M I  AMI_OEM  0x05000629 MSFT 0x00000097) @ 0x000000007ffc0040
> ACPI: DSDT (v001  939M2 939M2201 0x00000201 INTL 0x02002026) @ 0x0000000000000000
> Entering add_active_range(0, 0, 159) 0 entries of 256 used
> Entering add_active_range(0, 256, 524208) 1 entries of 256 used
> Zone PFN ranges:
>    DMA             0 ->     4096
>    DMA32        4096 ->  1048576
>    Normal    1048576 ->  1048576
> early_node_map[2] active PFN ranges
>      0:        0 ->      159
>      0:      256 ->   524208
> On node 0 totalpages: 524111
>    DMA zone: 56 pages used for memmap
>    DMA zone: 1221 pages reserved
>    DMA zone: 2722 pages, LIFO batch:0
>    DMA32 zone: 7110 pages used for memmap
>    DMA32 zone: 513002 pages, LIFO batch:31
>    Normal zone: 0 pages used for memmap
> ACPI: PM-Timer IO Port: 0x808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 (Bootup-CPU)
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x02] address[0xfec10000] gsi_base[24])
> IOAPIC[1]: apic_id 2, address 0xfec10000, GSI 24-39
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Setting APIC routing to flat
> Using ACPI (MADT) for SMP configuration information
> Nosave address range: 000000000009f000 - 00000000000a0000
> Nosave address range: 00000000000a0000 - 00000000000e8000
> Nosave address range: 00000000000e8000 - 0000000000100000
> Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
> Built 1 zonelists.  Total pages: 515724
> Kernel command line: root=/dev/md4
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> time.c: Detected 2400.142 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Checking aperture...
> CPU 0: aperture @ dc000000 size 64 MB
> Memory: 2059368k/2096832k available (2887k kernel code, 36712k reserved, 1066k data, 200k init)
> Calibrating delay using timer specific routine.. 4801.58 BogoMIPS (lpj=2400791)
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU: AMD Athlon(tm) 64 Processor 4000+ stepping 01
> ACPI: Core revision 20060707
> Using local APIC timer interrupts.
> result 12500753
> Detected 12.500 MHz APIC timer.
> testing NMI watchdog ... OK.
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI: Using configuration type 1
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 0800-083f claimed by ali7101 ACPI
> Boot video device is 0000:01:00.0
> PCI: Transparent bridge - 0000:00:06.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB3._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 *7 10 11 12 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 13 devices
> Generic PHY: Registered new driver
> SCSI subsystem initialized
> libata version 2.00 loaded.
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Cannot allocate resource region 0 of device 0000:00:04.0
> agpgart: Detected AGP bridge 20
> Setting up ULi AGP.
> agpgart: AGP aperture is 64M @ 0xdc000000
> PCI-DMA: Disabling IOMMU.
> pnp: 00:0b: ioport range 0x290-0x29f has been reserved
> PCI: Bridge: 0000:00:01.0
>    IO window: 9000-bfff
>    MEM window: fd600000-fd6fffff
>    PREFETCH window: c3e00000-d3dfffff
> PCI: Bridge: 0000:00:02.0
>    IO window: disabled.
>    MEM window: fd700000-fd7fffff
>    PREFETCH window: disabled.
> PCI: Bridge: 0000:00:03.0
>    IO window: c000-cfff
>    MEM window: fd800000-fd8fffff
>    PREFETCH window: disabled.
> PCI: Bridge: 0000:00:05.0
>    IO window: disabled.
>    MEM window: fd900000-fe9fffff
>    PREFETCH window: d3e00000-d7dfffff
> PCI: Bridge: 0000:00:06.0
>    IO window: d000-dfff
>    MEM window: fea00000-feafffff
>    PREFETCH window: d7e00000-d7efffff
> ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 29
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 34
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 39 (level, low) -> IRQ 39
> PCI: Setting latency timer of device 0000:00:03.0 to 64
> PCI: Setting latency timer of device 0000:00:05.0 to 64
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
> TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:01.0:pcie00]
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:02.0:pcie00]
> PCI: Setting latency timer of device 0000:00:03.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:03.0:pcie00]
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
> ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
> eth0: ULi M5263 at pci0000:00:11.0, 00:13:8f:6f:35:7f, irq 17.
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ALI15X3: IDE controller at PCI slot 0000:00:12.0
> ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 19 (level, low) -> IRQ 19
> ALI15X3: chipset revision 199
> ALI15X3: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:pio, hdb:pio
>      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> Probing IDE interface ide1...
> hdc: DVD DC DQ60, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> PDC20269: IDE controller at PCI slot 0000:05:05.0
> ACPI: PCI Interrupt 0000:05:05.0[A] -> GSI 20 (level, low) -> IRQ 20
> PDC20269: chipset revision 2
> PDC20269: ROM enabled at 0xd7e00000
> PDC20269: 100% native mode on irq 20
>      ide2: BM-DMA at 0xd080-0xd087, BIOS settings: hde:pio, hdf:pio
>      ide3: BM-DMA at 0xd088-0xd08f, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> hde: Maxtor 6L300R0, ATA DISK drive
> ide2 at 0xd880-0xd887,0xd802 on irq 20
> Probing IDE interface ide3...
> hdg: Maxtor 6B200P0, ATA DISK drive
> ide3 at 0xd480-0xd487,0xd402 on irq 20
> Probing IDE interface ide0...
> hde: max request size: 512KiB
> hde: 586114704 sectors (300090 MB) w/16384KiB Cache, CHS=36483/255/63, UDMA(133)
> hde: cache flushes supported
>   hde: hde1 hde2 < hde5 hde6 hde7 hde8 > hde3 hde4
> hdg: max request size: 512KiB
> hdg: 398297088 sectors (203928 MB) w/8192KiB Cache, CHS=24792/255/63, UDMA(133)
> hdg: cache flushes supported
>   hdg: hdg1 hdg2 < hdg5 hdg6 hdg7 > hdg3 hdg4
> hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
> Uniform CD-ROM driver Revision: 3.20
> ahci 0000:03:00.0: version 2.0
> ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 35 (level, low) -> IRQ 35
> PCI: Setting latency timer of device 0000:03:00.0 to 64
> ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
> ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part
> ata1: SATA max UDMA/133 cmd 0xFFFFC20000004100 ctl 0x0 bmdma 0x0 irq 35
> scsi0 : ahci
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7, max UDMA/100, 586072368 sectors: LBA48 NCQ (depth 31/32)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/100
> scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
> SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>   sda: sda1 sda2 < sda5 sda6 sda7 sda8 > sda3 sda4
> sd 0:0:0:0: Attached scsi disk sda
> sata_uli 0000:00:12.1: version 1.0
> ACPI: PCI Interrupt 0000:00:12.1[A] -> GSI 19 (level, low) -> IRQ 19
> ata2: SATA max UDMA/133 cmd 0xEC00 ctl 0xE482 bmdma 0xE000 irq 19
> ata3: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 19
> scsi1 : sata_uli
> ata2: SATA link down (SStatus 0 SControl 300)
> scsi2 : sata_uli
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: ATA-7, max UDMA/100, 586072368 sectors: LBA48 NCQ (depth 0/32)
> ata3.00: ata3: dev 0 multi count 16
> ata3.00: configured for UDMA/100
> scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
> SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>   sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 > sdb3 sdb4
> sd 2:0:0:0: Attached scsi disk sdb
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> md: raid1 personality registered for level 1
> raid6: int64x1   2238 MB/s
> raid6: int64x2   2980 MB/s
> raid6: int64x4   3167 MB/s
> raid6: int64x8   2144 MB/s
> raid6: sse2x1    3003 MB/s
> raid6: sse2x2    4054 MB/s
> raid6: sse2x4    4378 MB/s
> raid6: using algorithm sse2x4 (4378 MB/s)
> md: raid6 personality registered for level 6
> md: raid5 personality registered for level 5
> md: raid4 personality registered for level 4
> raid5: automatically using best checksumming function: generic_sse
>     generic_sse:  7620.000 MB/sec
> raid5: using function: generic_sse (7620.000 MB/sec)
> device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> input: AT Translated Set 2 keyboard as /class/input/input0
> input: PS2++ Logitech MX Mouse as /class/input/input1
> md: Autodetecting RAID arrays.
> md: autorun ...
> [---snip---]
> md: ... autorun DONE.
> ReiserFS: md4: found reiserfs format "3.6" with standard journal
> ReiserFS: md4: using ordered data mode
> ReiserFS: md4: journal params: device md4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: md4: checking transaction log (md4)
> ReiserFS: md4: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 200k freed
> ali1563: SMBus control = 0403
> ali1563_probe: Returning 0
> ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:13.3: EHCI Host Controller
> ehci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:13.3: debug port 1
> ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ehci_hcd 0000:00:13.3: irq 23, io mem 0xfebff800
> ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 20 (level, low) -> IRQ 20
> ohci_hcd 0000:00:13.0: OHCI Host Controller
> ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:13.0: irq 20, io mem 0xfebfe000
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 21 (level, low) -> IRQ 21
> ohci_hcd 0000:00:13.1: OHCI Host Controller
> ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:00:13.1: irq 21, io mem 0xfebfd000
> usb 1-3: new high speed USB device using ehci_hcd and address 2
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 3 ports detected
> ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 22 (level, low) -> IRQ 22
> ohci_hcd 0000:00:13.2: OHCI Host Controller
> ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
> ohci_hcd 0000:00:13.2: irq 22, io mem 0xfebfc000
> usb 1-3: configuration #1 chosen from 1 choice
> hub 1-3:1.0: USB hub found
> hub 1-3:1.0: 2 ports detected
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 3 ports detected
> Linux video capture interface: v2.00
> bttv: driver version 0.9.16 loaded
> bttv: using 8 buffers with 2080k (520 pages) each for capture
> bttv: Bt8xx card found (0).
> ACPI: PCI Interrupt 0000:05:06.0[A] -> GSI 21 (level, low) -> IRQ 21
> bttv0: Bt878 (rev 17) at 0000:05:06.0, irq: 21, latency: 32, mmio: 0xd7eff000
> bttv0: detected: Twinhan VisionPlus DVB [card=113], PCI subsystem ID is 1822:0001
> bttv0: using: Twinhan DST + clones [card=113,autodetected]
> bttv0: gpio: en=00000000, out=00000000 in=00f100fd [init]
> bttv0: using tuner=4
> bttv0: add subdevice "dvb0"
> gameport: EMU10K1 is pci0000:05:07.1/gameport0, io 0xdc00, speed 971kHz
> bt878: AUDIO driver version 0.0.0 loaded
> bt878: Bt878 AUDIO function found (0).
> ACPI: PCI Interrupt 0000:05:06.1[A] -> GSI 21 (level, low) -> IRQ 21
> bt878_probe: card id=[0x11822],[ Twinhan VisionPlus DVB ] has DVB functions.
> bt878(0): Bt878 (rev 17) at 05:06.1, irq: 21, latency: 32, memory: 0xd7efe000
> usb 2-3: new low speed USB device using ohci_hcd and address 2
> usb 2-3: configuration #1 chosen from 1 choice
> ACPI: PCI Interrupt 0000:05:07.0[A] -> GSI 22 (level, low) -> IRQ 22
> usb 3-3: new full speed USB device using ohci_hcd and address 2
> usb 3-3: configuration #1 chosen from 1 choice
> usb 1-3.1: new high speed USB device using ehci_hcd and address 5
> usb 1-3.1: configuration #1 chosen from 1 choice
> hub 1-3.1:1.0: USB hub found
> hub 1-3.1:1.0: 4 ports detected
> usb 1-3.2: new high speed USB device using ehci_hcd and address 6
> usb 1-3.2: configuration #1 chosen from 1 choice
> drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x1904
> usbcore: registered new interface driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> scsi3 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 6
> usb-storage: waiting for device to settle before scanning
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new interface driver hiddev
> input: Logitech USB Receiver as /class/input/input2
> input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:13.0-3
> usbcore: registered new interface driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> scsi 3:0:0:0: Direct-Access     SMSC     223 U HS-CF      3.60 PQ: 0 ANSI: 0
> sd 3:0:0:0: Attached scsi removable disk sdc
> scsi 3:0:0:1: Direct-Access     SMSC     223 U HS-MS      3.60 PQ: 0 ANSI: 0
> sd 3:0:0:1: Attached scsi removable disk sdd
> scsi 3:0:0:2: Direct-Access     SMSC     223 U HS-SM      3.60 PQ: 0 ANSI: 0
> sd 3:0:0:2: Attached scsi removable disk sde
> scsi 3:0:0:3: Direct-Access     SMSC     223 U HS-SD/MMC  3.60 PQ: 0 ANSI: 0
> sd 3:0:0:3: Attached scsi removable disk sdf
> usb-storage: device scan complete
> ACPI: Getting cpuindex for acpiid 0x2
> powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 4000+ processors (version 2.00.00)
> powernow-k8:    0 : fid 0x10 (2400 MHz), vid 0x8
> powernow-k8:    1 : fid 0xe (2200 MHz), vid 0x8
> powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xa
> powernow-k8:    3 : fid 0xa (1800 MHz), vid 0xc
> powernow-k8:    4 : fid 0x2 (1000 MHz), vid 0x12
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> DVB: registering new adapter (bttv0).
> dst(0) dst_get_device_id: Recognise [DCT-CI]
> DST type flags : 0x1000 VLF 0x8 firmware version = 1 0x10 firmware version = 2
> dst(0) dst_get_mac: MAC Address=[xx:xx:xx:xx:xx:xx]
> dst(0) dst_get_tuner_info: DST TYpe = MULTI FE
> dst(0) dst_get_tuner_info: DST type has TS=188
> dst(0) dst_get_tuner_info: DST has Daughterboard
> dst_ca_attach: registering DST-CA device
> DVB: registering frontend 0 (DST DVB-C)...
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on md1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on dm-0, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hde8, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda8, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sdb8, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> Adding 2023672k swap on /dev/mapper/swap.  Priority:-1 extents:1 across:2023672k
> ip_tables: (C) 2000-2006 Netfilter Core Team
> Netfilter messages via NETLINK v0.30.
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 288 bytes per conntrack
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> uli526x: eth0 NIC Link is Up 100 Mbps Full duplex
> ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [drm] Initialized drm 1.0.1 20051102
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 25 (level, low) -> IRQ 25
> [drm] Initialized radeon 1.25.0 20060524 on minor 0
> [drm] Setting GART location based on new memory map
> [drm] Loading R300 Microcode
> [drm] writeback test succeeded in 1 usecs
> process `named' is using obsolete setsockopt SO_BSDCOMPAT
> eth0: no IPv6 routers present
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [drm] Loading R300 Microcode
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xc)
> grsec: time set by /usr/sbin/ntpd[ntpd:16927] uid/euid:123/123 gid/egid:123/123, parent /sbin/init[init:1] uid/euid:0/0
>   gid/egid:0/0
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> [drm] Loading R300 Microcode
> [drm] Setting GART location based on new memory map
> [drm] Loading R300 Microcode
> [drm] writeback test succeeded in 1 usecs
>
>
>
> hdparm -I :
>
> /dev/sda:
>
> ATA device, with non-removable media
>         Model Number:       Maxtor 6V300F0
>         Serial Number:      XXXXXXXX
>         Firmware Revision:  VA111630
> Standards:
>         Used: ATA/ATAPI-7 T13 1532D revision 0
>         Supported: 7 6 5 4
> Configuration:
>         Logical         max     current
>         cylinders       16383   16383
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:   16514064
>         LBA    user addressable sectors:  268435455
>         LBA48  user addressable sectors:  586072368
>         device size with M = 1024*1024:      286168 MBytes
>         device size with M = 1000*1000:      300069 MBytes (300 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         Queue depth: 32
>         Standby timer values: spec'd by Standard, no device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Advanced power management level: unknown setting (0x0000)
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    SMART feature set
>            *    Power Management feature set
>            *    Write cache
>            *    Look-ahead
>            *    WRITE_VERIFY command
>            *    WRITE_BUFFER command
>            *    READ_BUFFER command
>            *    NOP cmd
>            *    DOWNLOAD_MICROCODE
>                 Advanced Power Management feature set
>                 SET_MAX security extension
>            *    48-bit Address feature set
>            *    Device Configuration Overlay feature set
>            *    Mandatory FLUSH_CACHE
>            *    FLUSH_CACHE_EXT
>            *    SMART error logging
>            *    SMART self-test
>            *    General Purpose Logging feature set
>            *    SATA-I signaling speed (1.5Gb/s)
>            *    SATA-II signaling speed (3.0Gb/s)
>            *    Native Command Queueing (NCQ)
>            *    Host-initiated interface power management
>            *    Software settings preservation
>            *    SMART Command Transport (SCT) feature set
>            *    SCT Data Tables (AC5)
> Checksum: correct
>
>
>
> Thanks,
>
> bbee
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
