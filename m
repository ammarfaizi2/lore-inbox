Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWEYUCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWEYUCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWEYUCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 16:02:42 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:1477 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1030382AbWEYUCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 16:02:39 -0400
Date: Thu, 25 May 2006 23:02:29 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: James Lamanna <jlamanna@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [OOPS] amrestore dies in kmem_cache_free 2.6.16.18 - cannot
 restore backups!
In-Reply-To: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0605252224450.4178@kai.makisara.local>
References: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am adding linux-scsi to recipients (and quoting the whole message for 
readers of that list).

On Tue, 23 May 2006, James Lamanna wrote:

> So I was able to recreate this problem on a vanilla 2.6.16.18 with the
> following oops..
> I'd say this is a serious regression since I cannot restore backups
> anymore (I could with 2.6.14.x, but that kernel series had other
> issues...)
> 
> amrestore does manage to read 1 32k block from tape before dying.
> 
> Any help would be greatly appreciated.
> 
I have tried 'amrestore' on my machine with 2.6.16.18 but was not able to 
reproduce the problem. However, there are many differences in our setups:
- mine is uniprocessor Athlon64, yours dual Opteron
- my SCSI HBA sym53c1010, yours Adaptec 39160D (aic7899)
- different tape drives (should not matter)
- my compiler gcc version 4.0.2 20050901 (prerelease) (SUSE Linux), yours
  gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)

> -- James Lamanna
> 
> 
> Unable to handle kernel paging request at ffff82bc81000030 RIP:
> <ffffffff801657d9>{kmem_cache_free+82}
> PGD 0
> Oops: 0000 [1] SMP
> CPU 1
> Modules linked in:
> Pid: 5814, comm: amrestore Not tainted 2.6.16.18 #2
> RIP: 0010:[<ffffffff801657d9>] <ffffffff801657d9>{kmem_cache_free+82}
> RSP: 0018:ffff81007d4afcd8  EFLAGS: 00010086
> RAX: ffff82bc81000000 RBX: ffff81004119d800 RCX: 000000000000001e
> RDX: ffff81000000c000 RSI: 0000000000000000 RDI: 00000007f0000000
> RBP: ffff81007ff0c800 R08: 0000000000000000 R09: 0000000000000400
> R10: 0000000000000000 R11: ffffffff8014b3d6 R12: ffff810041311480
> R13: 0000000000000400 R14: 0000000000000400 R15: ffff81007e676748
> FS:  00002b7f39708020(0000) GS:ffff810041173bc0(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: ffff82bc81000030 CR3: 000000007de09000 CR4: 00000000000006e0
> Process amrestore (pid: 5814, threadinfo ffff81007d4ae000, task
> ffff81007e2f8ae0)
> Stack: 0000000000000000 0000000000000246 ffff8100413c9bc0 ffff81007ff0c800
>       ffff8100413c9bc0 ffffffff8016dfdc ffff8100413c9bc0 ffff81007fe25408
>       00000000ffffffea ffffffff803187e7
> Call Trace: <ffffffff8016dfdc>{bio_free+48}
> <ffffffff803187e7>{scsi_execute_async+640}
>       <ffffffff8035d8d2>{st_do_scsi+422} <ffffffff8035d6e2>{st_sleep_done+0}
>       <ffffffff80362950>{st_read+855}
> <ffffffff8013e1ca>{autoremove_wake_function+0}
>       <ffffffff80169d7c>{vfs_read+171} <ffffffff8016a0af>{sys_read+69}
>       <ffffffff8010a93e>{system_call+126}

This stack trace does not easily tell what is happening:-( Starting from 
the bottom, up to scsi_execute_async it looks like a tape read (st_sleep_done 
is in the trace because it is parameter to scsi_execute_async). Above that 
I can't visualize what is happening. scsi_execute_async does not call 
either bio_free or kmem_cache_free.

> Code: 48 8b 48 30 0f b7 51 28 65 8b 04 25 30 00 00 00 39 c2 0f 84
> RIP <ffffffff801657d9>{kmem_cache_free+82} RSP <ffff81007d4afcd8>
> CR2: ffff82bc81000030
> 
> dmesg:
> Bootdata ok (command line is root=/dev/sda3
> netconsole=@10.20.2.30/eth1,10001@10.20.2.15/)
> Linux version 2.6.16.18 (root@fs0) (gcc version 3.4.3 20041125 (Gentoo
> 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 SMP Tue May 23 18:12:01 PDT 2006
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
> BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000007ff20000 (usable)
> BIOS-e820: 000000007ff20000 - 000000007ff2f000 (ACPI data)
> BIOS-e820: 000000007ff2f000 - 000000007ff80000 (ACPI NVS)
> BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
> BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f6f80
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
> 0x000000007ff2af87
> ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @
> 0x000000007ff2ec9e
> ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
> 0x000000007ff2ed12
> ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @
> 0x000000007ff2ee9a
> ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @
> 0x000000007ff2ef62
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
> 0x000000007ff2efd8
> ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @
> 0x0000000000000000
> SRAT: PXM 0 -> APIC 0 -> Node 0
> SRAT: PXM 1 -> APIC 1 -> Node 1
> SRAT: Node 0 PXM 0 0-a0000
> SRAT: Node 0 PXM 0 0-40000000
> SRAT: Node 1 PXM 1 40000000-80000000
> NUMA: Using 30 for the hash shift.
> Bootmem setup node 0 0000000000000000-0000000040000000
> Bootmem setup node 1 0000000040000000-000000007ff20000
> On node 0 totalpages: 257138
>  DMA zone: 2618 pages, LIFO batch:0
>  DMA32 zone: 254520 pages, LIFO batch:31
>  Normal zone: 0 pages, LIFO batch:0
>  HighMem zone: 0 pages, LIFO batch:0
> On node 1 totalpages: 258340
>  DMA zone: 0 pages, LIFO batch:0
>  DMA32 zone: 258340 pages, LIFO batch:31
>  Normal zone: 0 pages, LIFO batch:0
>  HighMem zone: 0 pages, LIFO batch:0
> Nvidia board detected. Ignoring ACPI timer override.
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:5 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x03] address[0xdf200000] gsi_base[24])
> IOAPIC[1]: apic_id 3, version 17, address 0xdf200000, GSI 24-27
> ACPI: IOAPIC (id[0x04] address[0xdf201000] gsi_base[28])
> IOAPIC[2]: apic_id 4, version 17, address 0xdf201000, GSI 28-31
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> ACPI: IRQ9 used by override.
> Setting APIC routing to flat
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
> Checking aperture...
> CPU 0: aperture @ 0 size 32 MB
> No AGP bridge found
> Built 2 zonelists
> Kernel command line: root=/dev/sda3
> netconsole=@10.20.2.30/eth1,10001@10.20.2.15/
> netconsole: local port 6665
> netconsole: local IP 10.20.2.30
> netconsole: interface eth1
> netconsole: remote port 10001
> netconsole: remote IP 10.20.2.15
> netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> Disabling vsyscall due to use of PM timer
> time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
> time.c: Detected 2009.275 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Memory: 2058556k/2096256k available (3359k kernel code, 37288k
> reserved, 1256k data, 228k init)
> Calibrating delay using timer specific routine.. 4025.03 BogoMIPS
> (lpj=8050070)
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 0(1) -> Node 0 -> Core 0
> Using local APIC timer interrupts.
> result 12557984
> Detected 12.557 MHz APIC timer.
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4018.81 BogoMIPS
> (lpj=8037638)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(1) -> Node 1 -> Core 0
> AMD Opteron(tm) Processor 246 stepping 0a
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff -9 cycles, maxerr 1085 cycles)
> Brought up 2 CPUs
> testing NMI watchdog ... OK.
> migration_cost=566
> DMI present.
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> Boot video device is 0000:01:06.0
> PCI: Transparent bridge - 0000:00:09.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Root Bridge [PCI2] (0000:08)
> PCI: Probing PCI hardware (bus 08)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI-DMA: Disabling IOMMU.
> PCI: Bridge: 0000:00:09.0
>  IO window: 2000-2fff
>  MEM window: dd100000-deffffff
>  PREFETCH window: 88000000-880fffff
> PCI: Bridge: 0000:00:0d.0
>  IO window: disabled.
>  MEM window: disabled.
>  PREFETCH window: disabled.
> PCI: Bridge: 0000:00:0e.0
>  IO window: disabled.
>  MEM window: disabled.
>  PREFETCH window: disabled.
> PCI: Setting latency timer of device 0000:00:09.0 to 64
> PCI: Setting latency timer of device 0000:00:0d.0 to 64
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> PCI: Failed to allocate mem resource #6:100000@e0000000 for 0000:09:02.0
> PCI: Failed to allocate mem resource #6:100000@e0000000 for 0000:09:02.1
> PCI: Bridge: 0000:08:0a.0
>  IO window: 3000-3fff
>  MEM window: df300000-df3fffff
>  PREFETCH window: df800000-dfffffff
> PCI: Bridge: 0000:08:0b.0
>  IO window: 4000-4fff
>  MEM window: df400000-df4fffff
>  PREFETCH window: 88100000-881fffff
> Simple Boot Flag at 0x36 set to 0x1
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Total HugeTLB memory allocated, 0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> SGI XFS with ACLs, security attributes, large block/inode numbers, no
> debug enabled
> SGI XFS Quota Management subsystem
> io scheduler noop registered
> io scheduler deadline registered (default)
> io scheduler cfq registered
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: Setting latency timer of device 0000:00:0d.0 to 64
> pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
> assign_interrupt_mode Found MSI capability
> PCI: MSI quirk detected. MSI disabled.
> Allocate Port Service[0000:00:0d.0:pcie00]
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:0e.0:pcie00]
> ACPI: Power Button (FF) [PWRF]
> ACPI: Power Button (CM) [PWRB]
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> isa bounce pool size: 16 pages
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 19
> GSI 16 sharing vector 0xB1 and IRQ 16
> ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNK3] -> GSI 19 (level,
> high) -> IRQ 177
> e100: eth0: e100_probe: addr 0xdd101000, irq 177, MAC addr 00:E0:81:30:33:CE
> tg3.c:v3.49 (Feb 2, 2006)
> GSI 17 sharing vector 0xB9 and IRQ 17
> ACPI: PCI Interrupt 0000:0a:09.0[A] -> GSI 28 (level, low) -> IRQ 185
> eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)]
> (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:30:d7:f8
> eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
> eth1: dma_rwctrl[763f0000] dma_mask[64-bit]
> GSI 18 sharing vector 0xC1 and IRQ 18
> ACPI: PCI Interrupt 0000:0a:09.1[B] -> GSI 29 (level, low) -> IRQ 193
> eth2: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)]
> (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:30:d7:f9
> eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
> eth2: dma_rwctrl[763f0000] dma_mask[64-bit]
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> netconsole: device eth1 not up yet, forcing it
> tg3: eth1: Link is up at 1000 Mbps, full duplex.
> tg3: eth1: Flow control is off for TX and off for RX.
> netconsole: network logging started
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
> NFORCE-CK804: chipset revision 162
> NFORCE-CK804: not 100% native mode: will probe irqs later
> NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
>    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: SONY CD-ROM CDU5225, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> Probing IDE interface ide1...
> hda: ATAPI 52X CD-ROM drive, 96kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> GSI 19 sharing vector 0xC9 and IRQ 19
> ACPI: PCI Interrupt 0000:0a:03.0[A] -> GSI 30 (level, low) -> IRQ 201
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
>        <Adaptec 3960D Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
>  Vendor: DELL      Model: PV-132T           Rev: 308D
>  Type:   Medium Changer                     ANSI SCSI revision: 02
> target0:0:0: Beginning Domain Validation
> target0:0:0: Ending Domain Validation
>  Vendor: IBM       Model: ULTRIUM-TD2       Rev: 53Y3
>  Type:   Sequential-Access                  ANSI SCSI revision: 03
> target0:0:1: Beginning Domain Validation
> target0:0:1: wide asynchronous
> target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
> target0:0:1: Ending Domain Validation
> GSI 20 sharing vector 0xD1 and IRQ 20
> ACPI: PCI Interrupt 0000:0a:03.1[B] -> GSI 31 (level, low) -> IRQ 209
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
>        <Adaptec 3960D Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
> 3ware Storage Controller device driver for Linux v1.26.02.001.
> 3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
> GSI 21 sharing vector 0xD9 and IRQ 21
> ACPI: PCI Interrupt 0000:09:03.0[A] -> GSI 27 (level, low) -> IRQ 217
> scsi2 : 3ware 9000 Storage Controller
> 3w-9xxx: scsi2: Found a 3ware 9000 Storage Controller at 0xdf340000, IRQ: 217.
> 3w-9xxx: scsi2: Firmware FE9X 2.06.00.009, BIOS BE9X 2.03.01.051, Ports: 8.
>  Vendor: AMCC      Model: 9500S-8    DISK   Rev: 2.06
>  Type:   Direct-Access                      ANSI SCSI revision: 03
> libata version 1.20 loaded.
> st: Version 20050830, fixed bufsize 32768, s/g segs 256
> st 0:0:1:0: Attached scsi tape st0<4>st0: try direct i/o: yes (alignment 512
> B)
> SCSI device sda: 1757749248 512-byte hdwr sectors (899968 MB)
> sda: Write Protect is off
> sda: Mode Sense: 23 00 00 00
> SCSI device sda: drive cache: write back, no read (daft)
> SCSI device sda: 1757749248 512-byte hdwr sectors (899968 MB)
> sda: Write Protect is off
> sda: Mode Sense: 23 00 00 00
> SCSI device sda: drive cache: write back, no read (daft)
> sda: sda1 sda2 sda3 sda4 < sda5 >
> sd 2:0:0:0: Attached scsi disk sda
> 0:0:0:0: Attached scsi generic sg0 type 8
> st 0:0:1:0: Attached scsi generic sg1 type 1
> sd 2:0:0:0: Attached scsi generic sg2 type 0
> SCSI Media Changer driver v0.25
> ch0: type #1 (mt): 0x1+1 [medium transport]
> ch0: type #2 (st): 0x1000+23 [storage]
> ch0: type #3 (ie): 0x10+1 [import/export]
> ch0: type #4 (dt): 0x100+1 [data transfer]
> ch0: dt 0x100: ID 1, LUN 0, name: IBM      ULTRIUM-TD2      53Y3
> ch0: INITIALIZE ELEMENT STATUS, may take some time ...
> ch0: ... finished
> ch 0:0:0:0: Attached scsi changer ch0
> Fusion MPT base driver 3.03.07
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT FC Host driver 3.03.07
> GSI 22 sharing vector 0xE1 and IRQ 22
> ACPI: PCI Interrupt 0000:09:02.0[A] -> GSI 26 (level, low) -> IRQ 225
> mptbase: Initiating ioc0 bringup
> ioc0: FC929XL: Capabilities={Initiator,Target,LAN}
> scsi3 : ioc0: LSIFC929XL, FwRev=01020b00h, Ports=1, MaxQ=1023, IRQ=225
> ACPI: PCI Interrupt 0000:09:02.1[B] -> GSI 27 (level, low) -> IRQ 217
> mptbase: Initiating ioc1 bringup
> ioc1: FC929XL: Capabilities={Initiator,Target,LAN}
>  Vendor: APPLE     Model: Xse<6>scsi4 : ioc1: LSIFC929XL,
> FwRev=01020b00h, Ports=1, MaxQ=1023, IRQ=217
> rve RAID       Rev: 1.50
>  Type:   Direct-Access                      ANSI SCSI revision:
> 05<5>usbmon: debugfs is not available
> 
> ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 23
> GSI 23 sharing vector 0xE9 and IRQ 23
> ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 23 (level,
> high) -> IRQ 233
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ehci_hcd 0000:00:02.1: EHCI Host Controller
> ehci_hcd 0000:00:02.1: debug port 1
> PCI: cache line size of 64 is not supported by device 0000:00:02.1
> ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:02.1: irq 233, io mem 0xdd001000
> ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
>  Vendor: AP<6>usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 10 ports detected
> PLE     Model: Xserve RAID       Rev: 1.50
>  Type:   Direct-Access                      ANSI SCSI revision: 05
> sdb : very big device. try to use READ CAPACITY(16).
> sdc : very big device. try to use READ CAPACITY(16).
> SCSI device sdb: 5860573184 512-byte hdwr sectors (3000613 MB)
> SCSI device sdc: 5860573184 512-byte hdwr sectors (3000613 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: ad 00 00 08
> sdc: Write Protect is off
> sdc: Mode Sense: ad 00 00 08
> SCSI device sdb: drive cache: write back
> SCSI device sdc: drive cache: write back
> sdb : very big device. try to use READ CAPACITY(16).
> sdc : very big device. try to use READ CAPACITY(16).
> SCSI device sdb: 5860573184 512-byte hdwr sectors (3000613 MB)
> SCSI device sdc: 5860573184 512-byte hdwr sectors (3000613 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: ad 00 00 08
> sdc: Write Protect is off
> sdc: Mode Sense: ad 00 00 08
> SCSI device sdb: drive cache: write back
> sdb:<5>SCSI device sdc: drive cache: write back
> sdc: unknown partition table
> sd 3:0:0:0: Attached scsi disk sdb
> unknown partition table
> sd 4:0:0:0: Attached scsi disk sdc
> sd 3:0:0:0: Attached scsi generic sg3 type 0
> sd 4:0:0:0: Attached scsi generic sg4 type 0
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
> GSI 24 sharing vector 0x32 and IRQ 24
> ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 22 (level,
> high) -> IRQ 50
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:02.0: irq 50, io mem 0xdd000000
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 10 ports detected
> USB Universal Host Controller Interface driver v2.3
> usb 2-3: new low speed USB device using ohci_hcd and address 2
> usb 2-3: configuration #1 chosen from 1 choice
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> input: BTC USB Multimedia Keyboard as /class/input/input0
> input: USB HID v1.10 Keyboard [BTC USB Multimedia Keyboard] on
> usb-0000:00:02.0-3
> input: BTC USB Multimedia Keyboard as /class/input/input1
> input: USB HID v1.10 Device [BTC USB Multimedia Keyboard] on
> input: usb-0000:00:02.0-3
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> mice: PS/2 mouse device common for all mice
> md: linear personality registered for level -1
> md: raid0 personality registered for level 0
> md: raid1 personality registered for level 1
> md: raid5 personality registered for level 5
> md: raid4 personality registered for level 4
> raid5: automatically using best checksumming function: generic_sse
>   generic_sse:  6155.000 MB/sec
> raid5: using function: generic_sse (6155.000 MB/sec)
> md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 4.39
> device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
> NET: Registered protocol family 2
> IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.0)
> powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
> powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
> cpu_init done, current fid 0xc, vid 0x2
> powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
> powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
> cpu_init done, current fid 0xc, vid 0x2
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> ReiserFS: sda3: found reiserfs format "3.6" with standard journal
> input: AT Translated Set 2 keyboard as /class/input/input2
> ReiserFS: sda3: using ordered data mode
> ReiserFS: sda3: journal params: device sda3, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: sda3: checking transaction log (sda3)
> ReiserFS: sda3: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 228k freed
> Adding 3911816k swap on /dev/sda2.  Priority:-1 extents:1 across:3911816k
> md: md0 stopped.
> md: md0 stopped.
> md: bind<sdc>
> md: bind<sdb>
> md0: setting max_sectors to 128, segment boundary to 32767
> raid0: looking at sdb
> raid0:   comparing sdb(2930286528) with sdb(2930286528)
> raid0:   END
> raid0:   ==> UNIQUE
> raid0: 1 zones
> raid0: looking at sdc
> raid0:   comparing sdc(2930286528) with sdb(2930286528)
> raid0:   EQUAL
> raid0: FINAL 1 zones
> raid0: done.
> raid0 : md_size is 5860573056 blocks.
> raid0 : conf->hash_spacing is 5860573056 blocks.
> raid0 : nb_zone is 2.
> raid0 : Allocating 16 bytes for hash.
> XFS: osyncisdsync is now the default, option is deprecated.
> XFS mounting filesystem dm-1
> Ending clean XFS mount for filesystem: dm-1
> XFS: osyncisdsync is now the default, option is deprecated.
> XFS mounting filesystem dm-0
> Ending clean XFS mount for filesystem: dm-0
> XFS: osyncisdsync is now the default, option is deprecated.
> XFS mounting filesystem md0
> Ending clean XFS mount for filesystem: md0
> eth1: no IPv6 routers present
> st0: Block limits 1 - 16777215 bytes.
> 
> 
> .config:
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.16.18
> # Tue May 23 18:09:27 2006
> #
> CONFIG_X86_64=y
> CONFIG_64BIT=y
> CONFIG_X86=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_MMU=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_DMI=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_CPUSETS is not set
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_UID16=y
> CONFIG_VM86=y
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> CONFIG_SLAB=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> # CONFIG_SLOB is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_KMOD is not set
> CONFIG_STOP_MACHINE=y
> 
> #
> # Block layer
> #
> CONFIG_LBD=y
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> # CONFIG_IOSCHED_AS is not set
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_DEFAULT_AS is not set
> CONFIG_DEFAULT_DEADLINE=y
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="deadline"
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_VSMP is not set
> CONFIG_MK8=y
> # CONFIG_MPSC is not set
> # CONFIG_GENERIC_CPU is not set
> CONFIG_X86_L1_CACHE_BYTES=64
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_SCHED_SMT=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_BKL=y
> CONFIG_NUMA=y
> CONFIG_K8_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y
> # CONFIG_NUMA_EMU is not set
> CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
> CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_NEED_MULTIPLE_NODES=y
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> 
> 
> 
> CONFIG_MIGRATION=y
> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
> CONFIG_NR_CPUS=32
> # CONFIG_HOTPLUG_CPU is not set
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_GART_IOMMU=y
> CONFIG_SWIOTLB=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x100000
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_ISA_DMA_API=y
> CONFIG_GENERIC_PENDING_IRQ=y
> 
> #
> # Power management options
> #
> CONFIG_PM=y
> CONFIG_PM_LEGACY=y
> # CONFIG_PM_DEBUG is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_NUMA=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> CONFIG_ACPI_TOSHIBA=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> # CONFIG_ACPI_CONTAINER is not set
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> # CONFIG_CPU_FREQ_DEBUG is not set
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_STAT_DETAILS is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
> 
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_POWERNOW_K8=y
> CONFIG_X86_POWERNOW_K8_ACPI=y
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_ACPI_CPUFREQ=y
> 
> #
> # shared options
> #
> CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
> # CONFIG_X86_SPEEDSTEP_LIB is not set
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_UNORDERED_IO is not set
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCI_MSI=y
> # CONFIG_PCI_LEGACY_PROC is not set
> 
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> #CONFIG_PCCARD is not set
> 
> #
> # PCI Hotplug Support
> #
> #CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_IA32_EMULATION=y
> CONFIG_IA32_AOUT=y
> CONFIG_COMPAT=y
> CONFIG_SYSVIPC_COMPAT=y
> 
> #
> # Networking
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> #CONFIG_NETDEBUG is not set
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_TUNNEL is not set
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=y
> CONFIG_IPV6=y
> # CONFIG_IPV6_PRIVACY is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_NETFILTER is not set
> 
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> #CONFIG_IP_DCCP is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> #CONFIG_IP_SCTP is not set
> 
> #
> # TIPC Configuration (EXPERIMENTAL)
> #
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> 
> #
> # QoS and/or fair queueing
> #
> #CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> # CONFIG_FW_LOADER is not set
> 
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> #CONFIG_CONNECTOR is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> #CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> #CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> #CONFIG_PNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=y
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_IDEPCI_SHARE_IRQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=y
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_IT821X is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> CONFIG_BLK_DEV_PDC202XX_NEW=y
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> CONFIG_CHR_DEV_SCH=y
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI Transport Attributes
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> 
> #
> # SCSI low-level drivers
> #
> #CONFIG_ISCSI_TCP is not set
> CONFIG_BLK_DEV_3W_XXXX_RAID=y
> CONFIG_SCSI_3W_9XXX=y
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> CONFIG_AIC7XXX_DEBUG_ENABLE=y
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> CONFIG_SCSI_AIC79XX=y
> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> CONFIG_AIC79XX_RESET_DELAY_MS=4000
> # CONFIG_AIC79XX_ENABLE_RD_STRM is not set
> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> CONFIG_AIC79XX_DEBUG_MASK=0
> # CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_SATA=y
> # CONFIG_SCSI_SATA_AHCI is not set
> # CONFIG_SCSI_SATA_SVW is not set
> CONFIG_SCSI_ATA_PIIX=y
> # CONFIG_SCSI_SATA_MV is not set
> # CONFIG_SCSI_SATA_NV is not set
> # CONFIG_SCSI_PDC_ADMA is not set
> # CONFIG_SCSI_SATA_QSTOR is not set
> # CONFIG_SCSI_SATA_PROMISE is not set
> # CONFIG_SCSI_SATA_SX4 is not set
> # CONFIG_SCSI_SATA_SIL is not set
> # CONFIG_SCSI_SATA_SIL24 is not set
> # CONFIG_SCSI_SATA_SIS is not set
> # CONFIG_SCSI_SATA_ULI is not set
> CONFIG_SCSI_SATA_VIA=y
> # CONFIG_SCSI_SATA_VITESSE is not set
> CONFIG_SCSI_SATA_INTEL_COMBINED=y
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> # CONFIG_MD_RAID10 is not set
> CONFIG_MD_RAID5=y
> # CONFIG_MD_RAID6 is not set
> # CONFIG_MD_MULTIPATH is not set
> # CONFIG_MD_FAULTY is not set
> CONFIG_BLK_DEV_DM=y
> # CONFIG_DM_CRYPT is not set
> # CONFIG_DM_SNAPSHOT is not set
> # CONFIG_DM_MIRROR is not set
> # CONFIG_DM_ZERO is not set
> # CONFIG_DM_MULTIPATH is not set
> 
> #
> # Fusion MPT device support
> #
> CONFIG_FUSION=y
> # CONFIG_FUSION_SPI is not set
> CONFIG_FUSION_FC=y
> # CONFIG_FUSION_SAS is not set
> CONFIG_FUSION_MAX_SGE=128
> # CONFIG_FUSION_CTL is not set
> # CONFIG_FUSION_LAN is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> #CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> #CONFIG_I2O is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=y
> 
> #
> # ARCnet devices
> #
> #CONFIG_ARCNET is not set
> 
> #
> # PHY device support
> #
> #CONFIG_PHYLIB is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> CONFIG_E100=y
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_VIA_RHINE is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_TIGON3=y
> # CONFIG_BNX2 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_IXGB is not set
> CONFIG_S2IO=m
> # CONFIG_S2IO_NAPI is not set
> 
> #
> # Token Ring devices
> #
> #CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> #CONFIG_NET_RADIO is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_NET_FC=y
> # CONFIG_SHAPER is not set
> CONFIG_NETCONSOLE=y
> CONFIG_NETPOLL=y
> # CONFIG_NETPOLL_RX is not set
> # CONFIG_NETPOLL_TRAP is not set
> CONFIG_NET_POLL_CONTROLLER=y
> 
> #
> # ISDN subsystem
> #
> #CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> #CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_GAMEPORT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> 
> #
> # IPMI
> #
> #CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> #CONFIG_WATCHDOG is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> CONFIG_AGP_INTEL=y
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_HPET=y
> # CONFIG_HPET_RTC_IRQ is not set
> CONFIG_HPET_MMAP=y
> # CONFIG_HANGCHECK_TIMER is not set
> 
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> 
> #
> # I2C support
> #
> #CONFIG_I2C is not set
> 
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
> 
> #
> # Dallas's 1-wire bus
> #
> #CONFIG_W1 is not set
> 
> #
> # Hardware Monitoring support
> #
> CONFIG_HWMON=y
> # CONFIG_HWMON_VID is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Misc devices
> #
> #CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia Capabilities Port drivers
> #
> 
> #
> # Multimedia devices
> #
> #CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> #CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> #CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> 
> #
> # Sound
> #
> #CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_SUSPEND is not set
> # CONFIG_USB_OTG is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=y
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> # CONFIG_USB_ISP116X_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> # CONFIG_USB_OHCI_BIG_ENDIAN is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_UHCI_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> #CONFIG_USB_ACM is not set
> CONFIG_USB_PRINTER=y
> 
> #
> #NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
> 
> #
> # may also be needed; see USB_STORAGE Help for more information
> #
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_LIBUSUAL is not set
> 
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=y
> CONFIG_USB_HIDINPUT=y
> # CONFIG_USB_HIDINPUT_POWERBOOK is not set
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_ACECAD is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_ITMTOUCH is not set
> # CONFIG_USB_EGALAX is not set
> # CONFIG_USB_YEALINK is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
> # CONFIG_USB_ATI_REMOTE2 is not set
> # CONFIG_USB_KEYSPAN_REMOTE is not set
> # CONFIG_USB_APPLETOUCH is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> 
> #
> # USB Multimedia devices
> #
> #CONFIG_USB_DABUSB is not set
> 
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network Adapters
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> CONFIG_USB_MON=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Serial Converter support
> #
> #CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETKIT is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TEST is not set
> 
> #
> # USB DSL modem support
> #
> 
> #
> # USB Gadget Support
> #
> #CONFIG_USB_GADGET is not set
> 
> #
> # MMC/SD Card support
> #
> #CONFIG_MMC is not set
> 
> #
> # InfiniBand support
> #
> #CONFIG_INFINIBAND is not set
> 
> #
> # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
> #
> #CONFIG_EDAC is not set
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> # CONFIG_EXT2_FS_SECURITY is not set
> # CONFIG_EXT2_FS_XIP is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> CONFIG_REISERFS_FS_POSIX_ACL=y
> # CONFIG_REISERFS_FS_SECURITY is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=y
> CONFIG_XFS_EXPORT=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_SECURITY=y
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_INOTIFY=y
> # CONFIG_QUOTA is not set
> CONFIG_QUOTACTL=y
> CONFIG_DNOTIFY=y
> CONFIG_AUTOFS_FS=y
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> # CONFIG_UDF_FS is not set
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_RAMFS=y
> # CONFIG_RELAYFS_FS is not set
> # CONFIG_CONFIGFS_FS is not set
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V3_ACL is not set
> # CONFIG_NFSD_V4 is not set
> CONFIG_NFSD_TCP=y
> CONFIG_ROOT_NFS=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> CONFIG_SMB_FS=y
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> 
> #
> # Partition Types
> #
> #CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
> 
> #
> # Instrumentation Support
> #
> # CONFIG_PROFILING is not set
> # CONFIG_KPROBES is not set
> 
> #
> # Kernel hacking
> #
> #CONFIG_PRINTK_TIME is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_KERNEL is not set
> CONFIG_LOG_BUF_SHIFT=15
> 
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> #CONFIG_CRYPTO is not set
> 
> #
> # Hardware crypto devices
> #
> 
> #
> # Library routines
> #
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> # CONFIG_LIBCRC32C is not set
> 
> lspci -vvv:
> 00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Capabilities: [44] HyperTransport: Slave or Primary Interface
>                Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
>                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC-
> TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
>                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut-
> LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
>                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+
> TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
>                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut-
> LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
>                Revision ID: 1.03
>                Link Frequency 0: 800MHz
>                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
>                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+
> 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
>                Link Frequency 1: 200MHz
>                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
>                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz-
> 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE-
> CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
>                Prefetchable memory behind bridge Upper: 00-00
>                Bus Number: 00
>        Capabilities: [e0] HyperTransport: MSI Mapping
> 
> 00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Region 0: I/O ports at 8c00 [size=128]
> 
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Interrupt: pin A routed to IRQ 0
>        Region 0: I/O ports at 1000 [size=32]
>        Region 4: I/O ports at 5000 [size=64]
>        Region 5: I/O ports at 5040 [size=64]
>        Capabilities: [44] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev
> a2) (prog-if 10 [OHCI])
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0 (750ns min, 250ns max)
>        Interrupt: pin A routed to IRQ 50
>        Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev
> a3) (prog-if 20 [EHCI])
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0 (750ns min, 250ns max)
>        Interrupt: pin B routed to IRQ 233
>        Region 0: Memory at dd001000 (32-bit, non-prefetchable) [size=256]
>        Capabilities: [44] Debug port
>        Capabilities: [80] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2) (prog-if
> 8a [Master SecP PriP])
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0 (750ns min, 250ns max)
>        Region 4: I/O ports at 1400 [size=16]
>        Capabilities: [44] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> (rev a3) (prog-if 85 [Master SecO PriO])
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0 (750ns min, 250ns max)
>        Interrupt: pin A routed to IRQ 10
>        Region 0: I/O ports at 1440 [size=8]
>        Region 1: I/O ports at 1434 [size=4]
>        Region 2: I/O ports at 1438 [size=8]
>        Region 3: I/O ports at 1430 [size=4]
>        Region 4: I/O ports at 1410 [size=16]
>        Region 5: Memory at dd002000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> (rev a3) (prog-if 85 [Master SecO PriO])
>        Subsystem: Tyan Computer Unknown device 2892
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0 (750ns min, 250ns max)
>        Interrupt: pin A routed to IRQ 11
>        Region 0: I/O ports at 1458 [size=8]
>        Region 1: I/O ports at 144c [size=4]
>        Region 2: I/O ports at 1450 [size=8]
>        Region 3: I/O ports at 1448 [size=4]
>        Region 4: I/O ports at 1420 [size=16]
>        Region 5: Memory at dd003000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
> (prog-if 01 [Subtractive decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>        I/O behind bridge: 00002000-00002fff
>        Memory behind bridge: dd100000-deffffff
>        Prefetchable memory behind bridge: 88000000-880fffff
>        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0, Cache Line Size 10
>        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: fff00000-000fffff
>        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [48] Message Signalled Interrupts: 64bit+
> Queue=0/1 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [58] HyperTransport: MSI Mapping
>        Capabilities: [80] Express Root Port (Slot+) IRQ 0
>                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                Device: Latency L0s <512ns, L1 <4us
>                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
>                Link: Supported Speed 2.5Gb/s, Width x4, ASPM L0s, Port 1
>                Link: Latency L0s <512ns, L1 <4us
>                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
>                Link: Speed 2.5Gb/s, Width x4
>                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
>                Slot: Number 2, PowerLimit 25.000000
>                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
>                Slot: AttnInd Off, PwrInd On, Power-
>                Root: Correctable- Non-Fatal- Fatal- PME-
> 
> 00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0, Cache Line Size 10
>        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: fff00000-000fffff
>        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [48] Message Signalled Interrupts: 64bit+
> Queue=0/1 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [58] HyperTransport: MSI Mapping
>        Capabilities: [80] Express Root Port (Slot+) IRQ 0
>                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                Device: Latency L0s <512ns, L1 <4us
>                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
>                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 0
>                Link: Latency L0s <512ns, L1 <4us
>                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
>                Link: Speed 2.5Gb/s, Width x16
>                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
>                Slot: Number 1, PowerLimit 75.000000
>                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
>                Slot: AttnInd Off, PwrInd On, Power-
>                Root: Correctable- Non-Fatal- Fatal- PME-
> 
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] HyperTransport Technology Configuration
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Capabilities: [80] HyperTransport: Host or Secondary Interface
>                !!! Possibly incomplete decoding
>                Command: WarmRst+ DblEnd-
>                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
>                <CRCErr=0
>                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
>                Revision ID: 1.02
>        Capabilities: [a0] HyperTransport: Host or Secondary Interface
>                !!! Possibly incomplete decoding
>                Command: WarmRst+ DblEnd-
>                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
>                <CRCErr=0
>                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
>                Revision ID: 1.02
>        Capabilities: [c0] HyperTransport: Host or Secondary Interface
>                !!! Possibly incomplete decoding
>                Command: WarmRst+ DblEnd-
>                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
>                <CRCErr=0
>                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
>                Revision ID: 1.02
> 
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Address Map
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] DRAM Controller
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Miscellaneous Control
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] HyperTransport Technology Configuration
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Capabilities: [80] HyperTransport: Host or Secondary Interface
>                !!! Possibly incomplete decoding
>                Command: WarmRst+ DblEnd-
>                Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+
>                <CRCErr=0
>                Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
>                Revision ID: 1.02
>        Capabilities: [a0] HyperTransport: Host or Secondary Interface
>                !!! Possibly incomplete decoding
>                Command: WarmRst+ DblEnd-
>                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
>                <CRCErr=0
>                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
>                Revision ID: 1.02
>        Capabilities: [c0] HyperTransport: Host or Secondary Interface
>                !!! Possibly incomplete decoding
>                Command: WarmRst+ DblEnd-
>                Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+
>                <CRCErr=0
>                Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
>                Revision ID: 1.02
> 
> 00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Address Map
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] DRAM Controller
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Miscellaneous Control
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
> 27) (prog-if 00 [VGA])
>        Subsystem: ATI Technologies Inc Rage XL
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 66 (2000ns min), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 10
>        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
>        Region 1: I/O ports at 2000 [size=256]
>        Region 2: Memory at dd100000 (32-bit, non-prefetchable) [size=4K]
>        [virtual] Expansion ROM at 88000000 [disabled] [size=128K]
>        Capabilities: [5c] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
> 100] (rev 10)
>        Subsystem: Intel Corporation EtherExpress PRO/100 S Server Adapter
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 66 (2000ns min, 14000ns max), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 177
>        Region 0: Memory at dd101000 (32-bit, non-prefetchable) [size=4K]
>        Region 1: I/O ports at 2400 [size=64]
>        Region 2: Memory at dd120000 (32-bit, non-prefetchable) [size=128K]
>        Capabilities: [dc] Power Management version 2
>                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 
> 08:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> (rev 12) (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64
>        Bus: primary=08, secondary=09, subordinate=09, sec-latency=96
>        I/O behind bridge: 00003000-00003fff
>        Memory behind bridge: df300000-df3fffff
>        Prefetchable memory behind bridge: 00000000df800000-00000000dff00000
>        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>        Capabilities: [a0] PCI-X bridge device
>                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
>                Status: Dev=08:0a.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
>                Upstream: Capacity=14 CommitmentLimit=65535
>                Downstream: Capacity=2 CommitmentLimit=65535
>        Capabilities: [b8] HyperTransport: Interrupt Discovery and
>        Capabilities: Configuration
>        Capabilities: [c0] HyperTransport: Slave or Primary Interface
>                !!! Possibly incomplete decoding
>                Command: BaseUnitID=10 UnitCnt=2 MastHost- DefDir-
>                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC-
> TXO- <CRCErr=0
>                Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
>                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+
> TXO+ <CRCErr=0
>                Link Config 1: MLWI=8bit MLWO=8bit LWI=N/C LWO=N/C
>                Revision ID: 1.02
> 
> 08:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev
> 01) (prog-if 10 [IO-APIC])
>        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Region 0: Memory at df200000 (64-bit, non-prefetchable) [size=4K]
> 
> 08:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> (rev 12) (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64
>        Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=96
>        I/O behind bridge: 00004000-00004fff
>        Memory behind bridge: df400000-df4fffff
>        Prefetchable memory behind bridge: 0000000088100000-0000000088100000
>        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>        Capabilities: [a0] PCI-X bridge device
>                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
>                Status: Dev=08:0b.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
>                Upstream: Capacity=14 CommitmentLimit=65535
>                Downstream: Capacity=2 CommitmentLimit=65535
>        Capabilities: [b8] HyperTransport: Interrupt Discovery and
>        Configuration
> 
> 08:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev
> 01) (prog-if 10 [IO-APIC])
>        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Region 0: Memory at df201000 (64-bit, non-prefetchable) [size=4K]
> 
> 09:02.0 Fibre Channel: LSI Logic / Symbios Logic FC929X Fibre Channel
> Adapter (rev 81)
>        Subsystem: LSI Logic / Symbios Logic Unknown device 10d0
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 72 (16000ns min, 2500ns max), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 225
>        Region 0: I/O ports at 3000 [size=256]
>        Region 1: Memory at df310000 (64-bit, non-prefetchable) [size=64K]
>        Region 3: Memory at df300000 (64-bit, non-prefetchable) [size=64K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [68] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=2048 OST=8
>                Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple
> DMMRBC=2048 DMOST=8 DMCRS=64 RSCEM- 266MHz- 533MHz-
> 
> 09:02.1 Fibre Channel: LSI Logic / Symbios Logic FC929X Fibre Channel
> Adapter (rev 81)
>        Subsystem: LSI Logic / Symbios Logic Unknown device 10d0
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 72 (16000ns min, 2500ns max), Cache Line Size 10
>        Interrupt: pin B routed to IRQ 217
>        Region 0: I/O ports at 3400 [size=256]
>        Region 1: Memory at df330000 (64-bit, non-prefetchable) [size=64K]
>        Region 3: Memory at df320000 (64-bit, non-prefetchable) [size=64K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [68] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=2048 OST=8
>                Status: Dev=ff:1f.1 64bit+ 133MHz+ SCD- USC- DC=simple
> DMMRBC=2048 DMOST=8 DMCRS=64 RSCEM- 266MHz- 533MHz-
> 
> 09:03.0 RAID bus controller: 3ware Inc 9xxx-series SATA-RAID
>        Subsystem: 3ware Inc 9xxx-series SATA-RAID
>        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 72 (2250ns min), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 217
>        Region 0: I/O ports at 3800 [size=256]
>        Region 1: Memory at df340000 (64-bit, non-prefetchable) [size=256]
>        Region 3: Memory at df800000 (64-bit, prefetchable) [size=8M]
>        [virtual] Expansion ROM at df350000 [disabled] [size=64K]
>        Capabilities: [48] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> PME(D0+,D1+,D2-,D3hot+,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 0a:03.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
>        Subsystem: Adaptec AHA-3960D U160/m
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 72 (10000ns min, 6250ns max), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 201
>        BIST result: 00
>        Region 0: I/O ports at 4000 [disabled] [size=256]
>        Region 1: Memory at df400000 (64-bit, non-prefetchable) [size=4K]
>        [virtual] Expansion ROM at 88100000 [disabled] [size=128K]
>        Capabilities: [dc] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 0a:03.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
>        Subsystem: Adaptec AHA-3960D U160/m
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 72 (10000ns min, 6250ns max), Cache Line Size 10
>        Interrupt: pin B routed to IRQ 209
>        BIST result: 00
>        Region 0: I/O ports at 4400 [disabled] [size=256]
>        Region 1: Memory at df401000 (64-bit, non-prefetchable) [size=4K]
>        [virtual] Expansion ROM at 88120000 [disabled] [size=128K]
>        Capabilities: [dc] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 0a:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
> Gigabit Ethernet (rev 03)
>        Subsystem: Broadcom Corporation Unknown device 1644
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (16000ns min), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 185
>        Region 0: Memory at df420000 (64-bit, non-prefetchable) [size=64K]
>        Region 2: Memory at df410000 (64-bit, non-prefetchable) [size=64K]
>        [virtual] Expansion ROM at 88140000 [disabled] [size=64K]
>        Capabilities: [40] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=512 OST=1
>                Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple
> DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
>        Capabilities: [48] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
>        Capabilities: [50] Vital Product Data
>        Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                Address: 1a72e12521540314  Data: 0128
> 
> 0a:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
> Gigabit Ethernet (rev 03)
>        Subsystem: Broadcom Corporation Unknown device 1644
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (16000ns min), Cache Line Size 10
>        Interrupt: pin B routed to IRQ 193
>        Region 0: Memory at df440000 (64-bit, non-prefetchable) [size=64K]
>        Region 2: Memory at df430000 (64-bit, non-prefetchable) [size=64K]
>        [virtual] Expansion ROM at 88150000 [disabled] [size=64K]
>        Capabilities: [40] PCI-X non-bridge device
>                Command: DPERE- ERO+ RBC=2048 OST=1
>                Status: Dev=ff:1f.1 64bit+ 133MHz+ SCD- USC- DC=simple
> DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
>        Capabilities: [48] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>        Capabilities: [50] Vital Product Data
>        Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                Address: 2000274248c02928  Data: 0006
> 
> /proc/cpuinfo:
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 5
> model name      : AMD Opteron(tm) Processor 246
> stepping        : 10
> cpu MHz         : 2000.000
> cache size      : 1024 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
> 3dnowext 3dnow
> bogomips        : 4025.03
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp
> 
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 5
> model name      : AMD Opteron(tm) Processor 246
> stepping        : 10
> cpu MHz         : 2000.000
> cache size      : 1024 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
> 3dnowext 3dnow
> bogomips        : 4018.81
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp
> -

-- 
Kai
