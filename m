Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVGMKpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVGMKpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGMKnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:43:21 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:14518 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262612AbVGMKkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:40:08 -0400
Subject: RE: [BUG] Fusion MPT Base Driver initialization failure with kdum p
From: Bharata B Rao <bharata@in.ibm.com>
Reply-To: bharata@in.ibm.com
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Wade, Roy" <Roy.Wade@lsil.com>, vgoyal@in.ibm.com, fastboot@osdl.org
In-Reply-To: <91888D455306F94EBD4D168954A9457C030A9D9C@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C030A9D9C@nacos172.co.lsil.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 13 Jul 2005 16:05:03 +0530
Message-Id: <1121250903.10622.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 12:15 -0600, Moore, Eric Dean wrote:
> I've seen the report. I need more info from Bharata on how
> to reproduce. Perhaps you can send me email offline which
> provides specific instructions to how to configure kdump,
> how to capture the dump, and what you did to crash your system.

This is how I could reproduce this bug:
(http://bugzilla.kernel.org/show_bug.cgi?id=4870)

- Configure the 1st kernel to take a kdump and run 4 instances of LTP on
it (I used `runltp -p -l logfile -t 12h -x 4)
- After a few hours, the 1st kernel crashes which results in the booting
of the 2nd kernel (the kernel which captures kdump). While this is
booting, mptbase driver fails during initialization leading to the panic
of the 2nd kernel.

The instructions to configure the 1st and the 2nd kernel to enable kdump
is found in Documentation/kdump/kdump.txt. I used the exact instructions
therein.

I am pasting the complete bug report from bugzilla here:

Distribution: 
RedHat 9

Hardware Environment:
4 CPU Intel Xeon machine

lspci output:

00:00.0 Host bridge: ServerWorks CMIC-LE (rev 13)
00:00.1 Host bridge: ServerWorks CMIC-LE
00:00.2 Host bridge: ServerWorks: Unknown device 0000
00:01.0 Bridge: IBM Remote Supervisor Adapter (RSA)
00:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev
05)
00:0f.3 ISA bridge: ServerWorks GCLE Host Bridge
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
02:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0c)
02:02.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
02:02.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
02:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703
Gigabit
Ethernet (rev 02)
05:03.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
05:03.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
05:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev
07)
05:07.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev
07)
07:05.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
09:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)

Software Environment:
Running 2.6.13-rc1 as the capture kernel.

Problem Description:

When the 2nd(capture) kernel boots (to capture the dump after the base
kernel
crashed), the Fusion MPT driver initialization cause a system panic.

Steps to reproduce:

- Configure the system for kdump
- Allow the base kernel to crash
- To capture the dump, the 2nd kernel boots and panics during the
inialization
phase of MPT driver.

--------log----------
Linux version 2.6.13-rc1 (root@llm05.in.ibm.com) (gcc version 3.2.2
20030222
(Red Hat Linux 3.2.2-
5)) #1 Fri Jul 8 19:19:49 IST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000effe7f40 (usable)
 BIOS-e820: 00000000effe7f40 - 00000000effef800 (ACPI data)
 BIOS-e820: 00000000effef800 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 000000000148d000 (usable)
 user: 000000000152d400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
found SMP MP-table at 0009d540
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x0c] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 12, version 17, address 0xfec02000, GSI 32-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 05000000 (gap: 05000000:fb000000)
Built 1 zonelists
Kernel command line: root=/dev/sda5 console=tty0 console=ttyS0,38400
init 1
irqpoll memmap=exactmap
 memmap=640K@0K memmap=4660K@16384K memmap=60235K@21685K
elfcorehdr=21684K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 2395.326 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59980k/81920k available (2923k kernel code, 5368k reserved,
1203k data,
204k init, 0k highm
em)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 4803.25 BogoMIPS
(lpj=9606513)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7cc, last bus=10
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Root Bridge [PCI1] (0000:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Root Bridge [PCI2] (0000:05)
PCI: Probing PCI hardware (bus 05)
ACPI: PCI Root Bridge [PCI3] (0000:07)
PCI: Probing PCI hardware (bus 07)
ACPI: PCI Root Bridge [PCI4] (0000:09)
PCI: Probing PCI hardware (bus 09)
ACPI: PCI Interrupt Link [LP00] (IRQs *3)
ACPI: PCI Interrupt Link [LP01] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP02] (IRQs *10)
ACPI: PCI Interrupt Link [LP03] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP04] (IRQs *11)
ACPI: PCI Interrupt Link [LP05] (IRQs *10)
ACPI: PCI Interrupt Link [LP06] (IRQs *3)
ACPI: PCI Interrupt Link [LP07] (IRQs *10)
ACPI: PCI Interrupt Link [LP08] (IRQs *9)
ACPI: PCI Interrupt Link [LP09] (IRQs *5)
ACPI: PCI Interrupt Link [LP0A] (IRQs *10)
ACPI: PCI Interrupt Link [LP0B] (IRQs *9)
ACPI: PCI Interrupt Link [LP0C] (IRQs *9)
ACPI: PCI Interrupt Link [LP0D] (IRQs *11)
ACPI: PCI Interrupt Link [LP0E] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP0F] (IRQs *11)
ACPI: PCI Interrupt Link [LP10] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP11] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP12] (IRQs *5)
ACPI: PCI Interrupt Link [LP13] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP14] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP15] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP16] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP17] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP18] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP19] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1A] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1B] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1C] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1D] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1E] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP1F] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LPUS] (IRQs *11)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:00: ioport range 0x900-0x93f has been reserved
pnp: 00:00: ioport range 0x510-0x517 could not be reserved
pnp: 00:00: ioport range 0x504-0x507 could not be reserved
pnp: 00:00: ioport range 0x500-0x503 could not be reserved
pnp: 00:00: ioport range 0x520-0x53f has been reserved
pnp: 00:00: ioport range 0x420-0x427 has been reserved
pnp: 00:00: ioport range 0x460-0x461 has been reserved
pnp: 00:0b: ioport range 0x1ec-0x1ef has been reserved
pnp: 00:0b: ioport range 0x400-0x4fe could not be reserved
pnp: 00:0b: ioport range 0x600-0x600 has been reserved
pnp: 00:0b: ioport range 0x800-0x80f has been reserved
pnp: 00:0b: ioport range 0xc00-0xcfe could not be reserved
pnp: 00:0b: ioport range 0xf50-0xf58 has been reserved
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1121077976.640:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 controller has invalid data port 0x64; using default 0x60
PNP: PS/2 controller has invalid command port 0x60; using default 0x64
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
p0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
e100: eth0: e100_probe: addr 0xfbfff000, irq 16, MAC addr
00:03:47:E0:67:78
ACPI: PCI Interrupt 0000:09:06.0[A] -> GSI 31 (level, low) -> IRQ 17
e100: eth1: e100_probe: addr 0xf53ff000, irq 17, MAC addr
00:02:55:50:04:D6
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: LTN486S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device 0000:07:05.0 (0156 -> 0157)
ACPI: PCI Interrupt 0000:07:05.0[A] -> GSI 24 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.02
ACPI: PCI Interrupt 0000:05:07.0[A] -> GSI 27 (level, low) -> IRQ 19
mptbase: Initiating ioc0 bringup
Unable to handle kernel paging request at virtual address 00001e08
 printing eip:
c11d5c1f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c11d5c1f>]    Not tainted VLI
EFLAGS: 00010006   (2.6.13-rc1)
EIP is at mptscsih_io_done+0x1f/0x2f0
eax: c1794000   ebx: 00000000   ecx: 00000000   edx: 00000250
esi: 00000000   edi: 00000000   ebp: 00001e00   esp: c1617d08
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1616000 task=c1601a00)
Stack: c160f151 c111007c 00000000 c11153a3 0000006c 00000250 c1794000
00000000
       c1794000 00000000 0000000e c11cff4f c17b3a00 00000000 00001e00
c16067c0
       c1401380 00000013 00000001 c103e0bb 00000000 00000000 c1617dc0
00000000
Call Trace:
 [<c111007c>] acpi_os_release_lock+0xd/0x2b
 [<c11153a3>] acpi_ev_gpe_detect+0xde/0x101
 [<c11cff4f>] mpt_interrupt+0xcf/0x1a0
 [<c103e0bb>] misrouted_irq+0x16b/0x190
 [<c103e23f>] note_interrupt+0x9f/0xc0
 [<c103da3e>] __do_IRQ+0x12e/0x140
 [<c1005723>] do_IRQ+0x23/0x40
 [<c1003c22>] common_interrupt+0x1a/0x20
 [<c101c24d>] release_console_sem+0x6d/0x100
 [<c101c07a>] vprintk+0x18a/0x270
 [<c125aa78>] pci_conf1_read+0xa8/0x100
 [<c125c23c>] pci_read+0x2c/0x40
 [<c110001f>] kobject_get+0xf/0x20
 [<c101bee7>] printk+0x17/0x20
 [<c11d101f>] mpt_do_ioc_recovery+0x4f/0x4f0
 [<c11d09ee>] mpt_attach+0x2ae/0x5d0
 [<c11dabb2>] mptspi_probe+0x12/0x400
 [<c1108d26>] pci_device_probe_static+0x46/0x60
 [<c1108d77>] __pci_device_probe+0x37/0x50
 [<c1108db6>] pci_device_probe+0x26/0x50
 [<c11665d3>] driver_probe_device+0x33/0xa0
 [<c11666e9>] __driver_attach+0x39/0x40
 [<c1165e55>] bus_for_each_dev+0x45/0x60
 [<c1166706>] driver_attach+0x16/0x20
 [<c11666b0>] __driver_attach+0x0/0x40
 [<c116621b>] bus_add_driver+0x7b/0xa0
 [<c1108eb0>] pci_device_shutdown+0x0/0x20
 [<c110900b>] pci_register_driver+0x6b/0x90
 [<c140a85b>] do_initcalls+0x2b/0xc0
 [<c1065325>] kern_mount+0x15/0x17
 [<c1000290>] init+0x0/0x100
 [<c10002bf>] init+0x2f/0x100
 [<c10013b8>] kernel_thread_helper+0x0/0x18
 [<c10013bd>] kernel_thread_helper+0x5/0x18
Code: 41 04 e9 53 ff ff ff 0f 0b eb ce 90 55 89 d5 57 56 89 ce 53 83 ec
1c 89 44
24 18 8b 90 c0 00
00 00 81 c2 50 02 00 00 89 54 24 14 <0f> b7 4d 08 89 4c 24 10 8b 42 0c
8b 1c 88
85 db 0f 84 90 02 0
0
 <0>Kernel panic - not syncing: Fatal exception in interrupt
----------log end---------------


------- Additional Comment #1 From Vivek Goyal 2005-07-11 04:14 -------

This seems to be the typical case of driver hardening required for kdump
cases.
MPT driver does not seem to be equipped to receive interrupts from
device while
driver is initializing. This works fine if driver is built with
MPT_DEBUG_IRQ
defined.


Note: CCing to fastboot as this is related to kdump.

Regards,
Bharata.



