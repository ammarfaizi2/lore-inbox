Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUHWO0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUHWO0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUHWO0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:26:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37546 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264538AbUHWOZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:25:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm4
References: <20040822013402.5917b991.akpm@osdl.org>
	<m14qmu4ffk.fsf@ebiederm.dsl.xmission.com>
	<1093262442.29522.22.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Aug 2004 08:24:15 -0600
In-Reply-To: <1093262442.29522.22.camel@localhost.localdomain>
Message-ID: <m1d61ix78w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2004-08-23 at 06:00, Eric W. Biederman wrote:
> > The function still looks fishy as there is another access
> > to rq outside of ide_lock, a few lines earlier.
> 
> HWGROUP(drive) is always valid for any live device. If this goes non
> valid you have another bug and you need to fix the HWGROUP(drive) bug.

So long as I don't have to claim it :)

What I know is an IDE bug introduced between 2.6.8.1 and 2.6.8.1-mm4.
So far all I have done is spent a couple of minutes tracking
down my the kernel was oops on bootup.

The new code introduced between those two kernels seems
to be the enhancement to ide_dump_status introduced in
ide-disk-barrier.patch   The amd74x driver has remained
the same.  So if ide_dump_status is correct it appears
it has uncovered and old bug.

Here is the oops that I get without this patch.  The drive
in question is a compact flash device.  So it implements
only a minimal number of ide commands.  Which explains the
presence of errors.

There is a truly trivial amount of driver specific code
on this path.  So if the problem is not the code I patched
it appears to be a generic IDE bug.

Also attached are my complete boot logs in the patched and
unpatched case.

Eric


Oops with unpatched 2.6.8.1-mm4
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:01:04.1
> AMD8111: chipset revision 3
> AMD8111: not 100% native mode: will probe irqs later
> AMD8111: 0000:01:04.1 (rev 03) UDMA133 controller
>     ide0: BM-DMA at 0x0f00-0x0f07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x0f08-0x0f0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: PQI IDE DiskOnModule, ATA DISK drive
> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hda: set_drive_speed_status: error=0x04 { DriveStatusError }
> Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP: 
> <ffffffff8031cd6d>{ide_dump_status+989}
> PML4 0 
> Oops: 0000 [1] SMP 
> CPU 0 
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.8.1-mm4
> RIP: 0010:[<ffffffff8031cd6d>] <ffffffff8031cd6d>{ide_dump_status+989}
> RSP: 0000:00000100048d1d48  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> RDX: 00000000ffffffff RSI: 0000000000000100 RDI: ffffffff8047c460
> RBP: ffffffff80569828 R08: 000000000000000d R09: 000000000000000e
> R10: 00000000ffffffff R11: 0000000000000010 R12: ffffffff804282c7
> R13: ffffffff805696e0 R14: 0000000000000004 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffffffff80590180(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000038 CR3: 0000000000101000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo 00000100048d0000, task 000001013ffad090)
> Stack: 0000000000000216 0000000000000051 000000000000000a ffffffff80569828 
>        ffffffff805696e0 000000000000000a 0000000000000001 ffffffff803226e9 
>        00000000000011f7 0000000000000282 
> Call Trace:<ffffffff803226e9>{ide_config_drive_speed+441} <ffffffff8031c41a>{amd_set_drive+74} 
>        <ffffffff801424e0>{process_timeout+0} <ffffffff801428a6>{msleep+38} 
>        <ffffffff8032479c>{probe_hwif+1020} <ffffffff80324806>{probe_hwif_init+22} 
>        <ffffffff80327a50>{ide_setup_pci_device+64} <ffffffff801aeb2b>{get_inode_number+59} 
>        <ffffffff805b9742>{amd74xx_probe+82} <ffffffff805ba0bf>{ide_scan_pcidev+63} 
>        <ffffffff805ba10b>{ide_scan_pcibus+27} <ffffffff805ba032>{ide_init+82} 
>        <ffffffff80597a7c>{do_initcalls+108} <ffffffff8010c16a>{init+202} 
>        <ffffffff80112307>{child_rip+8} <ffffffff8010c0a0>{init+0} 
>        <ffffffff801122ff>{child_rip+0} 
> 
> Code: 48 8b 40 38 c6 05 88 47 27 00 01 48 85 c0 74 43 48 8b 50 10 
> RIP <ffffffff8031cd6d>{ide_dump_status+989} RSP <00000100048d1d48>
> CR2: 0000000000000038

Boot log with 2.6.8.1-mm4
>old bootloader convention, maybe loadlin?
> Bootdata ok (command line is root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off )
> Linux version 2.6.8.1-mm4 (eric@maxwell.lnxi.com) (gcc version 3.2.3 20030221 (Debian prerelease)) #1 SMP Sun Aug 22 21:43:08 MDT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 0000000000000de8 (reserved)
>  BIOS-e820: 0000000000000de8 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000f0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> kernel direct mapping tables upto 10140000000 @ 8000-e000
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2 (10010)
> Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
> Node 1 MemBase 0000000100000000 Limit 000000013fffffff
> node 1 shift 24 addr 100000000 conflict 0
> Using node hash shift of 25
> Bootmem setup node 0 0000000000000000-00000000ffffffff
> Bootmem setup node 1 0000000100000000-000000013fffffff
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: LNXI     <6>Product ID: HDAMA        <6>APIC at: 0xFEE00000
> Processor #0 15:5 APIC version 16
> Processor #1 15:5 APIC version 16
> I/O APIC #2 Version 17 at 0xFEC00000.
> I/O APIC #3 Version 17 at 0xFD200000.
> I/O APIC #4 Version 17 at 0xFD201000.
> Processors: 2
> Checking aperture...
> CPU 0: aperture @ f8000000 size 64 MB
> CPU 1: aperture @ f8000000 size 64 MB
> Built 2 zonelists
> Initializing CPU#0
> Kernel command line: root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off 
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 1.193182 MHz PIT timer.
> time.c: Detected 2004.573 MHz processor.
> disabling early console
> old bootloader convention, maybe loadlin?
> Bootdata ok (command line is root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off )
> Linux version 2.6.8.1-mm4 (eric@maxwell.lnxi.com) (gcc version 3.2.3 20030221 (Debian prerelease)) #1 SMP Sun Aug 22 21:43:08 MDT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 0000000000000de8 (reserved)
>  BIOS-e820: 0000000000000de8 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000f0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2 (10010)
> Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
> Node 1 MemBase 0000000100000000 Limit 000000013fffffff
> node 1 shift 24 addr 100000000 conflict 0
> Using node hash shift of 25
> Bootmem setup node 0 0000000000000000-00000000ffffffff
> Bootmem setup node 1 0000000100000000-000000013fffffff
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: LNXI     <6>Product ID: HDAMA        <6>APIC at: 0xFEE00000
> Processor #0 15:5 APIC version 16
> Processor #1 15:5 APIC version 16
> I/O APIC #2 Version 17 at 0xFEC00000.
> I/O APIC #3 Version 17 at 0xFD200000.
> I/O APIC #4 Version 17 at 0xFD201000.
> Processors: 2
> Checking aperture...
> CPU 0: aperture @ f8000000 size 64 MB
> CPU 1: aperture @ f8000000 size 64 MB
> Built 2 zonelists
> Initializing CPU#0
> Kernel command line: root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off 
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 1.193182 MHz PIT timer.
> time.c: Detected 2004.573 MHz processor.
> disabling early console
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Memory: 4889444k/5242880k available (2961k kernel code, 0k reserved, 1339k data, 224k init)
> Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> tbxfroot-0343 [03] acpi_find_root_pointer: RSDP structure not found, AE_NOT_FOUND Flags=8
> ACPI: System description tables not found
>  tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
>  tbxface-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
> ACPI: Unable to load the System Description Tables
> Using local APIC NMI watchdog using perfctr0
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU0:  stepping 08
> per-CPU timeslice cutoff: 1023.98 usecs.
> task migration cache decay timeout: 2 msecs.
> Booting processor 1/1 rip 6000 rsp 1013ffa9f58
> Initializing CPU#1
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
>  stepping 08
> Total of 2 processors activated (7946.24 BogoMIPS).
> ENABLING IO-APIC IRQs
> Using IO-APIC 2
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> Using IO-APIC 3
> ...changing IO-APIC physical APIC ID to 3 ... ok.
> Using IO-APIC 4
> ...changing IO-APIC physical APIC ID to 4 ... ok.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> testing the IO APIC.......................
> 
> 
> 
> .................................... done.
> Using local APIC timer interrupts.
> Detected 12.528 MHz APIC timer.
> checking TSC synchronization across 2 CPUs: passed.
> time.c: Using PIT/TSC based timekeeping.
> Brought up 2 CPUs
> checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040715
> ACPI: Interpreter disabled.
> SCSI subsystem initialized
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Discovered primary peer bus 01 [IRQ]
> PCI: Using IRQ router default [1022/746b] at 0000:01:04.3
> PCI->APIC IRQ transform: (B2,I3,P0) -> 19
> PCI->APIC IRQ transform: (B2,I4,P0) -> 19
> PCI-DMA: Disabling AGP.
> PCI-DMA: aperture base @ f8000000 size 65536 KB
> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Using anticipatory io scheduler
> Floppy drive(s): fd0 is 1.44M
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
> Copyright (c) 1999-2004 Intel Corporation.
> tg3.c:v3.8 (July 14, 2004)
> eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:e5:13
> eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> eth1: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:e5:14
> eth1: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:01:04.1
> AMD8111: chipset revision 3
> AMD8111: not 100% native mode: will probe irqs later
> AMD8111: 0000:01:04.1 (rev 03) UDMA133 controller
>     ide0: BM-DMA at 0x0f00-0x0f07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x0f08-0x0f0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: PQI IDE DiskOnModule, ATA DISK drive
> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hda: set_drive_speed_status: error=0x04 { DriveStatusError }
> Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP: 
> <ffffffff8031cd6d>{ide_dump_status+989}
> PML4 0 
> Oops: 0000 [1] SMP 
> CPU 0 
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.8.1-mm4
> RIP: 0010:[<ffffffff8031cd6d>] <ffffffff8031cd6d>{ide_dump_status+989}
> RSP: 0000:00000100048d1d48  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> RDX: 00000000ffffffff RSI: 0000000000000100 RDI: ffffffff8047c460
> RBP: ffffffff80569828 R08: 000000000000000d R09: 000000000000000e
> R10: 00000000ffffffff R11: 0000000000000010 R12: ffffffff804282c7
> R13: ffffffff805696e0 R14: 0000000000000004 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffffffff80590180(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000038 CR3: 0000000000101000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo 00000100048d0000, task 000001013ffad090)
> Stack: 0000000000000216 0000000000000051 000000000000000a ffffffff80569828 
>        ffffffff805696e0 000000000000000a 0000000000000001 ffffffff803226e9 
>        00000000000011f7 0000000000000282 
> Call Trace:<ffffffff803226e9>{ide_config_drive_speed+441} <ffffffff8031c41a>{amd_set_drive+74} 
>        <ffffffff801424e0>{process_timeout+0} <ffffffff801428a6>{msleep+38} 
>        <ffffffff8032479c>{probe_hwif+1020} <ffffffff80324806>{probe_hwif_init+22} 
>        <ffffffff80327a50>{ide_setup_pci_device+64} <ffffffff801aeb2b>{get_inode_number+59} 
>        <ffffffff805b9742>{amd74xx_probe+82} <ffffffff805ba0bf>{ide_scan_pcidev+63} 
>        <ffffffff805ba10b>{ide_scan_pcibus+27} <ffffffff805ba032>{ide_init+82} 
>        <ffffffff80597a7c>{do_initcalls+108} <ffffffff8010c16a>{init+202} 
>        <ffffffff80112307>{child_rip+8} <ffffffff8010c0a0>{init+0} 
>        <ffffffff801122ff>{child_rip+0} 
> 
> Code: 48 8b 40 38 c6 05 88 47 27 00 01 48 85 c0 74 43 48 8b 50 10 
> RIP <ffffffff8031cd6d>{ide_dump_status+989} RSP <00000100048d1d48>
> CR2: 0000000000000038
>  <0>Kernel panic - not syncing: Attempted to kill init!


Boot log with 2.6.8.1-mm4 (patched)
> Linux version 2.6.8.1-mm4 (eric@maxwell.lnxi.com) (gcc version 3.2.3 20030221 (Debian prerelease)) #2 SMP Sun Aug 22 22:08:13 MDT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000001000 - 00000000000a0000 (usable)
>  BIOS-e820: 0000000000100000 - 00000000f0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> kernel direct mapping tables upto 10140000000 @ 8000-e000
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2 (10010)
> Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
> Node 1 MemBase 0000000100000000 Limit 000000013fffffff
> node 1 shift 24 addr 100000000 conflict 0
> Using node hash shift of 25
> Bootmem setup node 0 0000000000000000-00000000ffffffff
> Bootmem setup node 1 0000000100000000-000000013fffffff
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: LNXI     
> Product ID: HDAMA        
> APIC at: 0xFEE00000
> Processor #0 15:5 APIC version 16
> Processor #1 15:5 APIC version 16
> I/O APIC #2 Version 17 at 0xFEC00000.
> I/O APIC #3 Version 17 at 0xFD200000.
> I/O APIC #4 Version 17 at 0xFD201000.
> Processors: 2
> Checking aperture...
> CPU 0: aperture @ f8000000 size 64 MB
> CPU 1: aperture @ f8000000 size 64 MB
> Built 2 zonelists
> Initializing CPU#0
> Kernel command line: root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 1.193182 MHz PIT timer.
> time.c: Detected 2004.571 MHz processor.
> disabling early console
> Bootdata ok (command line is root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off)
> Linux version 2.6.8.1-mm4 (eric@maxwell.lnxi.com) (gcc version 3.2.3 20030221 (Debian prerelease)) #2 SMP Sun Aug 22 22:08:13 MDT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000001000 - 00000000000a0000 (usable)
>  BIOS-e820: 0000000000100000 - 00000000f0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2 (10010)
> Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
> Node 1 MemBase 0000000100000000 Limit 000000013fffffff
> node 1 shift 24 addr 100000000 conflict 0
> Using node hash shift of 25
> Bootmem setup node 0 0000000000000000-00000000ffffffff
> Bootmem setup node 1 0000000100000000-000000013fffffff
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: LNXI     <6>Product ID: HDAMA        <6>APIC at: 0xFEE00000
> Processor #0 15:5 APIC version 16
> Processor #1 15:5 APIC version 16
> I/O APIC #2 Version 17 at 0xFEC00000.
> I/O APIC #3 Version 17 at 0xFD200000.
> I/O APIC #4 Version 17 at 0xFD201000.
> Processors: 2
> Checking aperture...
> CPU 0: aperture @ f8000000 size 64 MB
> CPU 1: aperture @ f8000000 size 64 MB
> Built 2 zonelists
> Initializing CPU#0
> Kernel command line: root=/dev/nfs earlyprintk=ttyS0,115200 ip=dhcp console=ttyS0,115200 panic=5 verbose reboot=hard acpi=off
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 1.193182 MHz PIT timer.
> time.c: Detected 2004.571 MHz processor.
> disabling early console
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Memory: 4890048k/5242880k available (2961k kernel code, 0k reserved, 1339k data, 224k init)
> Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> tbxfroot-0343 [03] acpi_find_root_pointer: RSDP structure not found, AE_NOT_FOUND Flags=8
> ACPI: System description tables not found
>  tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
>  tbxface-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
> ACPI: Unable to load the System Description Tables
> Using local APIC NMI watchdog using perfctr0
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU0:  stepping 08
> per-CPU timeslice cutoff: 1023.98 usecs.
> task migration caInitializing CPU#1
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
>  stepping 08
> Total of 2 processors activated (7946.24 BogoMIPS).
> ENABLING IO-APIC IRQs
> Using IO-APIC 2
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> Using IO-APIC 3
> ...changing IO-APIC physical APIC ID to 3 ... ok.
> Using IO-APIC 4
> ...changing IO-APIC physical APIC ID to 4 ... ok.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> testing the IO APIC.......................
> 
> 
> 
> .................................... done.
> Using local APIC timer interrupts.
> Detected 12.528 MHz APIC timer.
> checking TSC synchronization across 2 CPUs: passed.
> time.c: Using PIT/TSC based timekeeping.
> Brought up 2 CPUs
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040715
> ACPI: Interpreter disabled.
> SCSI subsystem initialized
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Discovered primary peer bus 01 [IRQ]
> PCI: Using IRQ router default [1022/746b] at 0000:01:04.3
> PCI->APIC IRQ transform: (B2,I3,P0) -> 19
> PCI->APIC IRQ transform: (B2,I4,P0) -> 19
> PCI-DMA: Disabling AGP.
> PCI-DMA: aperture base @ f8000000 size 65536 KB
> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Using anticipatory io scheduler
> Floppy drive(s): fd0 is 1.44M
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
> Copyright (c) 1999-2004 Intel Corporation.
> tg3.c:v3.8 (July 14, 2004)
> eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:e5:13
> eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> eth1: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:e5:14
> eth1: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:01:04.1
> AMD8111: chipset revision 3
> AMD8111: not 100% native mode: will probe irqs later
> AMD8111: 0000:01:04.1 (rev 03) UDMA133 controller
>     ide0: BM-DMA at 0x0f00-0x0f07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x0f08-0x0f0f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: PQI IDE DiskOnModule, ATA DISK drive
> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hda: set_drive_speed_status: error=0x04 { DriveStatusError }
> ide0: Drive 0 didn't accept speed setting. Oh, well.
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: ST3120022A, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> ide2: Wait for ready failed before probe !
> Probing IDE interface ide3...
> ide3: Wait for ready failed before probe !
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !
> hda: max request size: 128KiB
> hda: 32000 sectors (16 MB) w/1KiB Cache, CHS=1000/2/16
> hda: cache flushes supported
>  hda: unknown partition table
> hdc: max request size: 1024KiB
> hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
> hdc: cache flushes supported
>  hdc: unknown partition table
> mice: PS/2 mouse device common for all mice
> NET: Registered protocol family 2
> IP: routing cache hash table of 32768 buckets, 512Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Sending DHCP requests .<6>tg3: eth0: Link is up at 100 Mbps, full duplex.
> tg3: eth0: Flow control is on for TX and on for RX.
> ., OK
> IP-Config: Got DHCP answer from 172.16.31.253, my address is 172.16.16.90
> IP-Config: Complete:
>       device=eth0, addr=172.16.16.90, mask=255.255.248.0, gw=172.16.23.254,
>      host=hdama-c, domain=default.domain, nis-domain=default.lan,
>      bootserver=172.16.31.253, rootserver=172.16.31.253, rootpath=/home/images/x86_64-nfs-boot
> Looking up port of RPC 100003/2 on 172.16.31.253
> Looking up port of RPC 100005/1 on 172.16.31.253
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 224k freed
> INIT: version 2.82 booting
> 
