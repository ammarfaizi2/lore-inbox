Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWGYFv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWGYFv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWGYFv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:51:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62143 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932475AbWGYFv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:51:56 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
cc: jgarzik@pobox.com
Subject: Re: 2.6.18-rc2 Intermittent failures to detect sata disks 
In-reply-to: Your message of "Fri, 21 Jul 2006 16:18:47 +1000."
             <20339.1153462727@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jul 2006 15:50:49 +1000
Message-ID: <9235.1153806649@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens (on Fri, 21 Jul 2006 16:18:47 +1000) wrote:
>I am seeing an intermittent failures to detect sata disks on
>2.6.18-rc2.  Dell SC1425, PIIX chipset, gcc 4.1.0 (opensuse 10.1).
>Sometimes it will detect both disks, sometimes only one, sometimes none
>at all.  AFAICT it only occurs after a soft reboot, and possibly only
>after an emergency reboot.  Alas the problem is so intermittent that it
>is hard to tell what conditions will trigger it.

I applied the debug patch below, turn on prink timing and set
initdefault to 6 so the machine was in a continual soft reboot cycle.
After multiple cycles I got this trace.  piix_sata_prereset() reads a
zero config byte for almost 15 seconds then it changes to 0x11,
followed by a hang.  Why is the config byte initially zero, and what
makes it change?  The normal value for pcs is 0x33.

[    0.000000] Linux version 2.6.18-rc2-i386-kaos (kaos@linuxbuild) (gcc version 4.1.0 (SUSE Linux)) #130 SMP PREEMPT Tue Jul 25 15:23:18 EST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
[    0.000000]  BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] 1151MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000fe710
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
[    0.000000] Processor #6 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
[    0.000000] Processor #7 15:4 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 32-55
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[64])
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 64-87
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Enabling APIC mode:  Flat.  Using 3 I/O APICs
[    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
[    0.000000] Detected 3000.323 MHz processor.
[   37.143004] Built 1 zonelists.  Total pages: 524224
[   37.143008] Kernel command line: root=/dev/sda10 resume=/dev/sda5 console=tty console=ttyS0,9600 nmi_watchdog=0
[   37.143196] Enabling fast FPU save and restore... done.
[   37.143199] Enabling unmasked SIMD FPU exception support... done.
[   37.143204] Initializing CPU#0
[   37.143256] CPU 0 irqstacks, hard=c03d1000 soft=c03c9000
[   37.143260] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   37.145474] Console: colour VGA+ 80x25
[   40.544223] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   40.628998] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   40.792755] Memory: 2075304k/2096896k available (1863k kernel code, 20512k reserved, 789k data, 160k init, 1179392k highmem)
[   40.927000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   41.024141] Using HPET for base-timer
[   41.144035] Calibrating delay using timer specific routine.. 6004.65 BogoMIPS (lpj=12009311)
[   41.245205] Mount-cache hash table entries: 512
[   41.299502] monitor/mwait feature present.
[   41.348505] using mwait in idle threads.
[   41.395460] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   41.458191] CPU: L2 cache: 2048K
[   41.496838] CPU: Physical Processor ID: 0
[   41.544841] Intel machine check architecture supported.
[   41.607378] Intel machine check reporting enabled on CPU#0.
[   41.674073] CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
[   41.745967] CPU0: Thermal monitoring enabled
[   41.797082] Compat vDSO mapped to ffffe000.
[   41.847165] Checking 'hlt' instruction... OK.
[   41.912754] SMP alternatives: switching to UP code
[   41.970194] ACPI: Core revision 20060707
[   42.022250] CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
[   42.089293] SMP alternatives: switching to SMP code
[   42.147701] Booting processor 1/1 eip 3000
[   42.196713] CPU 1 irqstacks, hard=c03d2000 soft=c03ca000
[   42.270983] Initializing CPU#1
[   42.350902] Calibrating delay using timer specific routine.. 6000.41 BogoMIPS (lpj=12000825)
[   42.350931] monitor/mwait feature present.
[   42.350939] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   42.350943] CPU: L2 cache: 2048K
[   42.350946] CPU: Physical Processor ID: 0
[   42.350957] Intel machine check architecture supported.
[   42.350964] Intel machine check reporting enabled on CPU#1.
[   42.350968] CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
[   42.350973] CPU1: Thermal monitoring enabled
[   42.351425] CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
[   43.006462] SMP alternatives: switching to SMP code
[   43.064946] Booting processor 2/6 eip 3000
[   43.113980] CPU 2 irqstacks, hard=c03d3000 soft=c03cb000
[   43.188033] Initializing CPU#2
[   43.266045] Calibrating delay using timer specific routine.. 6000.49 BogoMIPS (lpj=12000980)
[   43.266069] monitor/mwait feature present.
[   43.266075] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   43.266077] CPU: L2 cache: 2048K
[   43.266080] CPU: Physical Processor ID: 3
[   43.266088] Intel machine check architecture supported.
[   43.266095] Intel machine check reporting enabled on CPU#2.
[   43.266097] CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
[   43.266101] CPU2: Thermal monitoring enabled
[   43.266517] CPU2: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
[   43.921751] SMP alternatives: switching to SMP code
[   43.980171] Booting processor 3/7 eip 3000
[   44.029183] CPU 3 irqstacks, hard=c03d4000 soft=c03cc000
[   44.103229] Initializing CPU#3
[   44.181187] Calibrating delay using timer specific routine.. 6000.39 BogoMIPS (lpj=12000787)
[   44.181215] monitor/mwait feature present.
[   44.181223] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   44.181226] CPU: L2 cache: 2048K
[   44.181229] CPU: Physical Processor ID: 3
[   44.181240] Intel machine check architecture supported.
[   44.181248] Intel machine check reporting enabled on CPU#3.
[   44.181251] CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
[   44.181256] CPU3: Thermal monitoring enabled
[   44.181707] CPU3: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
[   44.836890] Total of 4 processors activated (24005.95 BogoMIPS).
[   44.909001] ENABLING IO-APIC IRQs
[   44.948819] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   45.164268] checking TSC synchronization across 4 CPUs: passed.
[    0.018470] Brought up 4 CPUs
[    0.413561] migration_cost=88,1627
[    0.455674] NET: Registered protocol family 16
[    0.508955] ACPI: bus type pci registered
[    0.556935] PCI: Using MMCONFIG
[    0.595081] Setting up standard PCI resources
[    0.653162] ACPI: Interpreter enabled
[    0.696969] ACPI: Using IOAPIC for interrupt routing
[    0.756831] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.816680] PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
[    0.893736] PCI quirk: region 0880-08bf claimed by ICH4 GPIO
[    0.961506] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    1.032409] PCI: PXH quirk detected, disabling MSI for SHPC device
[    1.106413] PCI: PXH quirk detected, disabling MSI for SHPC device
[    1.180769] PCI: Transparent bridge - 0000:00:1e.0
[    1.243265] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
[    1.323606] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12)
[    1.404006] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12)
[    1.486216] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12)
[    1.566570] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12)
[    1.646981] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
[    1.741304] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
[    1.835609] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12)
[    1.916067] SCSI subsystem initialized
[    1.960921] PCI: Using ACPI for IRQ routing
[    2.010954] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    2.111249] PCI: Bridge: 0000:01:00.0
[    2.155027]   IO window: e000-efff
[    2.195741]   MEM window: fe900000-feafffff
[    2.245805]   PREFETCH window: disabled.
[    2.292760] PCI: Bridge: 0000:01:00.2
[    2.336594]   IO window: disabled.
[    2.377314]   MEM window: disabled.
[    2.419072]   PREFETCH window: disabled.
[    2.466028] PCI: Bridge: 0000:00:02.0
[    2.509863]   IO window: e000-efff
[    2.550586]   MEM window: fe700000-feafffff
[    2.600654]   PREFETCH window: disabled.
[    2.647609] PCI: Bridge: 0000:00:1e.0
[    2.691444]   IO window: d000-dfff
[    2.732169]   MEM window: fe500000-fe6fffff
[    2.782238]   PREFETCH window: f0000000-f7ffffff
[    2.837515] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[    2.926333] NET: Registered protocol family 2
[    3.032344] IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
[    3.117976] TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
[    3.207978] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    3.287539] TCP: Hash tables configured (established 262144 bind 65536)
[    3.366653] TCP reno registered
[    3.405065] Machine check exception polling timer started.
[    3.472286] highmem bounce pool size: 64 pages
[    3.525862] SGI XFS with large block numbers, no debug enabled
[    3.596163] Initializing Cryptographic API
[    3.645181] io scheduler noop registered (default)
[    3.702977] io scheduler anticipatory registered
[    3.758422] io scheduler deadline registered
[    3.809765] io scheduler cfq registered
[    3.855857] Intel E7520/7320/7525 detected.<6>ACPI: Power Button (FF) [PWRF]
[    3.940723] ACPI Exception (acpi_video-1402): AE_NOT_FOUND, Evaluating _DOD [20060707]
[    4.035914] ACPI: Video Device [EVGA] (multi-head: no  rom: yes  post: no)
[    4.146619] Real Time Clock Driver v1.12ac
[    4.195686] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[    4.289518] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
[    4.364454] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[    4.453953] e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
[    4.526864] e100: Copyright(c) 1999-2005 Intel Corporation
[    4.592661] tun: Universal TUN/TAP device driver, 1.6
[    4.653085] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.727108] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    4.803103] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    4.898924] ICH5: IDE controller at PCI slot 0000:00:1f.1
[    4.963511] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[    5.031247] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
[    5.119972] ICH5: chipset revision 2
[    5.162758] ICH5: not 100% native mode: will probe irqs later
[    5.231542]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[    6.056275] hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
[    6.797382] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    7.413503] piix_init: pci_module_init
[    7.458438] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[    7.520941] ata_pci_init_one: ENTER
[    7.562711] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
[    7.651456] ata_device_add: ENTER
[    7.691122] ata_host_add: ENTER
[    7.728788] ata_port_start: prd alloc, virt f7b96000, dma 37b96000
[    7.802715] ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 17
[    7.888115] __ata_port_freeze: ata1 port frozen
[    7.942336] ata_host_add: ENTER
[    7.979969] ata_port_start: prd alloc, virt f7b16000, dma 37b16000
[    8.053911] ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 17
[    8.139312] __ata_port_freeze: ata2 port frozen
[    8.193545] ata_device_add: probe begin
[    8.239460] scsi0 : ata_piix
[    8.274004] ata_port_schedule_eh: port EH scheduled
[    8.274008] ata_scsi_error: ENTER
[    8.274012] ata_port_flush_task: ENTER
[    8.416896] ata_port_flush_task: flush #1
[    8.464901] ata_eh_autopsy: ENTER
[    8.504574] ata_eh_recover: ENTER
[    8.544261] ata_eh_prep_resume: ENTER
[    8.588102] ata_eh_prep_resume: EXIT
[    8.630906] __ata_port_freeze: ata1 port frozen
[    8.685138] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    8.856181] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[    8.933211] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    9.104163] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[    9.181254] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    9.352145] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[    9.429202] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    9.600128] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[    9.677235] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[    9.848111] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[    9.925188] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   10.096094] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   10.173137] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   10.344076] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   10.421187] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   10.592059] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   10.669115] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   10.840042] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   10.917065] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   11.088024] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   11.165114] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   11.332003] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   11.409103] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   11.579985] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   11.657045] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   11.827968] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   11.904997] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   12.075951] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   12.152981] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   12.323934] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   12.400962] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   12.571916] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   12.649028] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   12.819899] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   12.897009] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   13.067882] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   13.144983] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   13.315864] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   13.392957] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   13.563847] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   13.640909] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   13.811830] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   13.888865] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   14.059813] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   14.136921] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   14.307795] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   14.384878] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   14.555778] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   14.632835] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   14.803761] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   14.880794] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   15.051743] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   15.128857] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   15.299726] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   15.376810] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   15.547709] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   15.624754] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   15.791693] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   15.868745] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   16.035666] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   16.112739] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   16.283648] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   16.360689] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   16.531631] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   16.608729] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   16.779614] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   16.856696] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   17.027596] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   17.104661] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   17.275579] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   17.352605] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   17.523562] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   17.600664] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   17.771545] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   17.848627] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   18.019527] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   18.096587] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   18.267510] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   18.344533] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   18.515493] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   18.592572] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   18.763476] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   18.840502] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   19.011458] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   19.090356] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   19.263437] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   19.340547] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   19.511420] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   19.588493] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   19.759402] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   19.836448] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   20.007385] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   20.084412] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   20.255368] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   20.332477] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   20.499346] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   20.576386] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   20.743325] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   20.820394] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   20.991308] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   21.068333] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   21.239290] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   21.316365] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   21.487273] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   21.564303] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   21.735256] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   21.812378] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   21.983238] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   22.060330] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   22.231221] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   22.308290] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   22.479204] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   22.556260] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   22.727187] piix_sata_prereset: ata1: LEAVE, pcs=0x0 present_mask=0x0
[   22.804229] piix_sata_prereset: ata1: ENTER, pcs=0x0 base=0
[   22.975169] piix_sata_prereset: ata1: LEAVE, pcs=0x11 present_mask=0x1
[   23.212077] ata1.00: ATA-6, max UDMA/100, 156250000 sectors: LBA 
[   23.285031] ata1.00: ata1: dev 0 multi count 8
[   23.339104] ata1.00: configured for UDMA/100
[   23.390163] scsi1 : ata_piix

Debug patch:

---
 drivers/scsi/ata_piix.c |    5 +++++
 include/linux/libata.h  |    4 ++++
 2 files changed, 9 insertions(+)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -489,6 +489,7 @@ static void piix_pata_error_handler(stru
 	ata_bmdma_drive_eh(ap, piix_pata_prereset, ata_std_softreset, NULL,
 			   ata_std_postreset);
 }
+int ata_debug = 1;
 
 /**
  *	piix_sata_prereset - prereset for SATA host controller
@@ -514,6 +515,7 @@ static int piix_sata_prereset(struct ata
 	int port, i;
 	u8 pcs;
 
+repeat:
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
@@ -546,6 +548,9 @@ static int piix_sata_prereset(struct ata
 
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
+	if (pcs == 0)
+		goto repeat;
+	ata_debug = 0;
 
 	if (!present_mask) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
Index: linux/include/linux/libata.h
===================================================================
--- linux.orig/include/linux/libata.h
+++ linux/include/linux/libata.h
@@ -61,6 +61,10 @@
 #define VPRINTK(fmt, args...)
 #endif	/* ATA_DEBUG */
 
+extern int ata_debug;
+#undef DPRINTK
+#define DPRINTK(fmt, args...) if (ata_debug) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+
 #define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
 
 /* NEW: debug levels */

