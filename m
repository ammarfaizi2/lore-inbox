Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFAPYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFAPYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFAPYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:24:19 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:48467 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261426AbVFAPVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:21:00 -0400
Message-ID: <429DD259.9080701@tls.msk.ru>
Date: Wed, 01 Jun 2005 19:20:57 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <429CECE3.1060904@tls.msk.ru> <20050531220449.1dc15eb4.akpm@osdl.org>
In-Reply-To: <20050531220449.1dc15eb4.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>>I noticied that parport_pc and 8250[_pnp] modules
>> can't be re-loaded without rebooting when PNP is
>> turned on in kernel config.  Here's how it looks
>> like:
> 
> Please test 2.6.12-rc5

Just did so.  The OOPS (NULL pointer dereference) when unloading
parport_pc on VIA-based mobo is now gone, but re-enabling PNP
device on E7501-based machine still does not work, with the same
effect.  Here's the dmesg output when {ins,rm}moding the parport_pc
module:

[modprobe parport_pc]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]

[rmmod parport_pc]
pnp: Device 00:07 disabled.

[modprobe parport_pc]
pnp: Device 00:07 activated.
parport: PnPBIOS parport detected.
pnp: Device 00:07 disabled.
[no parport is detected]

The same is with 8250_pnp:

[modprobe 8250_pnp (also loads 8250)]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

[rmmod 8250_pnp 8250]
pnp: Device 00:06 disabled.

[modprobe 8250]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
pnp: Device 00:06 activated.
[note no ttyS0 is detected this time]

And here's complete (modulo various scsi and softraid stuff which isn't
relevant) dmesg before the above.

Is it worth the effort to try to compile w/o PNP support?
If memory serves me right, it worked w/o PNP, but eg for
parport, not all parameters (most notable IRQ) where
detected.

Thanks.

/mjt

Linux version 2.6.12-i786smp-rc5-0 (mjt@paltus.tls.msk.ru) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #1 SMP Wed Jun 1 18:55:42 MSD 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294896 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4fa0
ACPI: RSDT (v001 A M I  OEMRSDT  0x08000311 MSFT 0x00000097) @ 0x7fff0000
ACPI: FADT (v002 A M I  OEMFACP  0x08000311 MSFT 0x00000097) @ 0x7fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x08000311 MSFT 0x00000097) @ 0x7fff0300
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000311 MSFT 0x00000097) @ 0x7ffff040
ACPI: DSDT (v001  0ABBP 0ABBP001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.12-rc5-0 ro root=100 panic=60 elevator=deadline
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80400)
Initializing CPU#0
CPU 0 irqstacks, hard=c0342000 soft=c033e000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2400.110 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075412k/2097088k available (1377k kernel code, 20532k reserved, 702k data, 188k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS (lpj=2367488)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c0343000 soft=c033f000
Initializing CPU#1
Calibrating delay loop... 4784.12 BogoMIPS (lpj=2392064)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
Booting processor 2/6 eip 3000
CPU 2 irqstacks, hard=c0344000 soft=c0340000
Initializing CPU#2
Calibrating delay loop... 4784.12 BogoMIPS (lpj=2392064)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
Booting processor 3/7 eip 3000
CPU 3 irqstacks, hard=c0345000 soft=c0341000
Initializing CPU#3
Calibrating delay loop... 4784.12 BogoMIPS (lpj=2392064)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
Total of 4 processors activated (19087.36 BogoMIPS).
ENABLING IO-APIC IRQs
...TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
  domain 1: span f
   groups: 3 c
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
  domain 1: span f
   groups: 3 c
CPU2 attaching sched-domain:
 domain 0: span c
  groups: 4 8
  domain 1: span f
   groups: c 3
CPU3 attaching sched-domain:
 domain 0: span c
  groups: 8 4
  domain 1: span f
   groups: c 3
checking if image is initramfs... it is
Freeing initrd memory: 599k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:02.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:0c: ioport range 0x400-0x47f could not be reserved
pnp: 00:0c: ioport range 0x680-0x6ff has been reserved
pnp: 00:0c: ioport range 0x500-0x53f has been reserved
pnp: 00:0c: ioport range 0x500-0x53f has been reserved
pnp: 00:0c: ioport range 0x400-0x47f could not be reserved
pnp: 00:0c: ioport range 0x295-0x296 has been reserved
pnp: 00:0c: ioport range 0x3e0-0x3e7 has been reserved
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI wakeup devices:
PS2K PS2M SMBS USB0 USB1 USB2 P0P1 P0P2 P2P3 P2P4 GNIC PWRB
ACPI: (supports S0 S1 S5)
Freeing unused kernel memory: 188k freed
SCSI subsystem initialized
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 50 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:04:04.1[B] -> GSI 51 (level, low) -> IRQ 177
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 50-66Mhz, 512 SCBs

(scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
[...]
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS on md1, internal journal
Real Time Clock Driver v1.12
Intel(R) PRO/1000 Network Driver - version 5.7.6-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 48 (level, low) -> IRQ 185
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
