Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWI0CF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWI0CF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 22:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWI0CFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 22:05:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53957 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932287AbWI0CFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 22:05:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, adurbin@google.com
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
Date: Tue, 26 Sep 2006 20:04:05 -0600
In-Reply-To: <20060924040215.8e6e7f1a.akpm@osdl.org> (Andrew Morton's message
	of "Sun, 24 Sep 2006 04:02:15 -0700")
Message-ID: <m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I apply:
x86_64-mm-insert-ioapics-and-local-apic-into-resource-map

My e1000 fails to initializes and complains about a bad eeprom checksum.
I haven't tracked this down to root cause yet and I am in the process of building
2.6.18-mm1 with just that patch reverted to confirm that is the only cause.

I could not see anything obvious in the patch.  I don't have a clue the patch
could be triggering the problem I'm seeing.

At a quick visual diff I'm not seeing any other differences in the kernel boot
logs, or in /proc/iomem.

Eric


The good.
> # cat /proc/iomem
> 00000000-00000c3f : reserved
> 00000c40-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000effff : System RAM
> 000f0000-000fffff : System ROM
> e2000000-e20fffff : PCI Bus #05
>   e2000000-e201ffff : 0000:05:0c.0
> fb000000-fc0fffff : PCI Bus #05
>   fb000000-fbffffff : 0000:05:0c.0
>   fc000000-fc000fff : 0000:05:0c.0
> fd000000-fdffffff : PCI Bus #01
>   fd000000-fdffffff : PCI Bus #02
>     fd000000-fdffffff : 0000:02:03.0
> fe000000-fe2fffff : PCI Bus #01
>   fe000000-fe0fffff : PCI Bus #02
>     fe000000-fe07ffff : 0000:02:03.0
>   fe100000-fe1fffff : PCI Bus #03
>     fe100000-fe11ffff : 0000:03:04.0
>       fe100000-fe11ffff : e1000
>     fe120000-fe13ffff : 0000:03:04.1
>       fe120000-fe13ffff : e1000
>   fe200000-fe200fff : 0000:01:00.1
>   fe201000-fe201fff : 0000:01:00.3
> fe300000-fe300fff : 0000:00:00.0
> fe301000-fe301fff : 0000:00:01.0
> fe302000-fe3023ff : 0000:00:1d.7
> fe303000-fe3033ff : 0000:00:1f.1
> 100000000-11fffffff : System RAM

The bad.
> # cat /proc/iomem
> 00000000-00000c3f : reserved
> 00000c40-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000effff : System RAM
> 000f0000-000fffff : System ROM
> e2000000-e22fffff : PCI Bus #01
>   e2000000-e20fffff : PCI Bus #02
>     e2000000-e207ffff : 0000:02:03.0
>   e2100000-e21fffff : PCI Bus #03
>     e2100000-e211ffff : 0000:03:04.0
>     e2120000-e213ffff : 0000:03:04.1
>   e2200000-e2200fff : 0000:01:00.1
>   e2201000-e2201fff : 0000:01:00.3
> e2300000-e23fffff : PCI Bus #05
>   e2300000-e231ffff : 0000:05:0c.0
> fb000000-fc0fffff : PCI Bus #05
>   fb000000-fbffffff : 0000:05:0c.0
>   fc000000-fc000fff : 0000:05:0c.0
> fd000000-fdffffff : PCI Bus #01
>   fd000000-fdffffff : PCI Bus #02
>     fd000000-fdffffff : 0000:02:03.0
> fe200000-fe200fff : IOAPIC 1
> fe201000-fe201fff : IOAPIC 2
> fe300000-fe300fff : 0000:00:00.0
> fe301000-fe301fff : 0000:00:01.0
> fe302000-fe3023ff : 0000:00:1d.7
> fe303000-fe3033ff : 0000:00:1f.1
> fec00000-fec00fff : IOAPIC 0
> fee00000-fee00fff : Local APIC
> 100000000-11fffffff : System RAM

The bad kernel boot messages:
> Linux version 2.6.18-eb-g27fb4c0a (eric@maxwell.lnxi.com) (gcc
>  Tue Sep 26 18:58:15 MDT 2006
> Command line:  console=ttyS0,115200 reboot=hard panic=5 debug 
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 0000000000000c40 (reserved)
>  BIOS-e820: 0000000000000c40 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000c0000 - 00000000000f0000 (usable)
>  BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
>  BIOS-e820: 00000000000f0400 - 00000000e0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
> DMI not present or invalid.
> No NUMA configuration found
> Faking a node at 0000000000000000-0000000120000000
> Bootmem setup node 0 0000000000000000-0000000120000000
> On node 0 totalpages: 1029374
>   DMA zone: 966 pages, LIFO batch:0
>   DMA32 zone: 899128 pages, LIFO batch:31
>   Normal zone: 129280 pages, LIFO batch:31
> Intel MultiProcessor Specification v1.4
> MPTABLE: OEM ID: LNXI     MPTABLE: Product ID: SE7520JR20   MP
> Processor #0 (Bootup-CPU)
> Processor #6
> I/O APIC #8 at 0xFEC00000.
> I/O APIC #9 at 0xFE200000.
> I/O APIC #10 at 0xFE201000.
> Setting APIC routing to flat
> Processors: 2
> Allocating PCI resources starting at e2000000 (gap: e0000000:2
> PERCPU: Allocating 31872 bytes of per cpu data
> Built 1 zonelists.  Total pages: 1029374
> Kernel command line:  console=ttyS0,115200 reboot=hard panic=5
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> spurious 8259A interrupt: IRQ7.
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 by
> Inode-cache hash table entries: 262144 (order: 9, 2097152 byte
> Checking aperture...
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> Placing software IO TLB between 0x2637000 - 0x6637000
> Memory: 4028780k/4718592k available (2553k kernel code, 165388
> Calibrating delay using timer specific routine.. 6813.94 BogoM
> Security Framework v1.0.0 initialized
> Capability LSM initialized
> Mount-cache hash table entries: 256
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU 0/0 -> Node 0
> using mwait in idle threads.
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> CPU0: Thermal monitoring enabled (TM1)
> Freeing SMP alternatives: 36k freed
> GSI 24 sharing vector 0xA9 and IRQ 24
> GSI 25 sharing vector 0xB1 and IRQ 25
> GSI 26 sharing vector 0xB9 and IRQ 26
> GSI 27 sharing vector 0xC1 and IRQ 27
> GSI 28 sharing vector 0xC9 and IRQ 28
> GSI 29 sharing vector 0xD1 and IRQ 29
> GSI 49 sharing vector 0xD9 and IRQ 49
> GSI 50 sharing vector 0xE1 and IRQ 50
> GSI 51 sharing vector 0xE9 and IRQ 51
> GSI 52 sharing vector 0x32 and IRQ 52
> GSI 54 sharing vector 0x3A and IRQ 54
> GSI 55 sharing vector 0x42 and IRQ 55
> Using local APIC timer interrupts.
> result 12500623
> Detected 12.500 MHz APIC timer.
> Booting processor 1/2 APIC 0x6
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 6800.70 BogoM
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU 1/6 -> Node 0
> CPU: Physical Processor ID: 3
> CPU: Processor Core ID: 0
> CPU1: Thermal monitoring enabled (TM1)
>                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
> Brought up 2 CPUs
> testing NMI watchdog ... OK.
> time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
> time.c: Detected 3400.184 MHz processor.
> migration_cost=629
> checking if image is initramfs... it is
> Freeing initrd memory: 7256k freed
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> ACPI: Interpreter disabled.
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 3000-307f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 3080-30bf claimed by ICH4 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
> PCI: PXH quirk detected, disabling MSI for SHPC device
> PCI: PXH quirk detected, disabling MSI for SHPC device
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
> PCI->APIC IRQ transform: 0000:02:03.0[A] -> IRQ 24
> PCI->APIC IRQ transform: 0000:03:04.0[A] -> IRQ 54
> PCI->APIC IRQ transform: 0000:03:04.1[B] -> IRQ 55
> GSI 17 sharing vector 0x4A and IRQ 17
> PCI->APIC IRQ transform: 0000:05:0c.0[A] -> IRQ 17
> PCI: Cannot allocate resource region 8 of bridge 0000:00:02.0
> PCI: Cannot allocate resource region 8 of bridge 0000:01:00.0
> PCI: Cannot allocate resource region 8 of bridge 0000:01:00.2
> PCI: Cannot allocate resource region 0 of device 0000:01:00.1
> PCI: Cannot allocate resource region 0 of device 0000:01:00.3
> PCI: Cannot allocate resource region 0 of device 0000:03:04.0
> PCI: Cannot allocate resource region 0 of device 0000:03:04.1
> PCI-GART: No AMD northbridge found.
> PCI: Bridge: 0000:01:00.0
>   IO window: disabled.
>   MEM window: e2000000-e20fffff
>   PREFETCH window: fd000000-fdffffff
> PCI: Bridge: 0000:01:00.2
>   IO window: 1000-1fff
>   MEM window: e2100000-e21fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:02.0
>   IO window: 1000-1fff
>   MEM window: e2000000-e22fffff
>   PREFETCH window: fd000000-fdffffff
> PCI: Bridge: 0000:00:06.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1e.0
>   IO window: 2000-2fff
>   MEM window: fb000000-fc0fffff
>   PREFETCH window: e2300000-e23fffff
> PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. 
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> PCI: Setting latency timer of device 0000:01:00.2 to 64
> PCI: No IRQ known for interrupt pin A of device 0000:00:06.0. 
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 131072 (order: 8, 1048576 b
> TCP established hash table entries: 262144 (order: 10, 4194304
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
> Total HugeTLB memory allocated, 0
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Intel E7520/7320/7525 detected.<7>PCI: Setting latency timer o
> pcie_portdrv_probe->Dev[3595:8086] has invalid IRQ. Check vend
> Allocate Port Service[0000:00:02.0:pcie00]
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> pcie_portdrv_probe->Dev[3599:8086] has invalid IRQ. Check vend
> Allocate Port Service[0000:00:06.0:pcie00]
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ shari
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 b
> Intel(R) PRO/1000 Network Driver - version 7.2.7-k2-NAPI
> Copyright (c) 1999-2006 Intel Corporation.
> e1000: 0000:03:04.0: e1000_probe: The EEPROM Checksum Is Not V
> e1000: probe of 0000:03:04.0 failed with error -5
> e1000: 0000:03:04.1: e1000_probe: The EEPROM Checksum Is Not V
> e1000: probe of 0000:03:04.1 failed with error -5
> forcedeth.c: Reverse Engineered nForce ethernet driver. Versio
> netconsole: not configured, aborting
> usbmon: debugfs is not available
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> EDAC MC: Ver: 2.0.1 Sep 26 2006
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> TCP bic registered
> Initializing XFRM netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Bridge firewalling registered
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> TIPC: Activated (version 1.6.1 compiled Sep 26 2006 18:53:22)
> NET: Registered protocol family 30
> TIPC: Started in single node mode
> /home/eric/projects/linux/linux-2.6-ns/drivers/rtc/hctosys.c: 
> Freeing unused kernel memory: 220k freed

The good kernel boot messages:

> Linux version 2.6.18-eb-g94187b95 (eric@maxwell.lnxi.com) (gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #15 SMP Tue Sep 26 19:10:14 MDT 2006
> Command line:  console=ttyS0,115200 reboot=hard panic=5 debug acpi=off crashkernel=16M@16M 
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 0000000000000c40 (reserved)
>  BIOS-e820: 0000000000000c40 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000c0000 - 00000000000f0000 (usable)
>  BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
>  BIOS-e820: 00000000000f0400 - 00000000e0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
> DMI not present or invalid.
> No NUMA configuration found
> Faking a node at 0000000000000000-0000000120000000
> Bootmem setup node 0 0000000000000000-0000000120000000
> On node 0 totalpages: 1029374
>   DMA zone: 966 pages, LIFO batch:0
>   DMA32 zone: 899128 pages, LIFO batch:31
>   Normal zone: 129280 pages, LIFO batch:31
> Intel MultiProcessor Specification v1.4
> MPTABLE: OEM ID: LNXI     MPTABLE: Product ID: SE7520JR20   MPTABLE: APIC at: 0xFEE00000
> Processor #0 (Bootup-CPU)
> Processor #6
> I/O APIC #8 at 0xFEC00000.
> I/O APIC #9 at 0xFE200000.
> I/O APIC #10 at 0xFE201000.
> Setting APIC routing to flat
> Processors: 2
> Allocating PCI resources starting at e2000000 (gap: e0000000:20000000)
> PERCPU: Allocating 31872 bytes of per cpu data
> Built 1 zonelists.  Total pages: 1029374
> Kernel command line:  console=ttyS0,115200 reboot=hard panic=5 debug acpi=off crashkernel=16M@16M 
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> spurious 8259A interrupt: IRQ7.
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Checking aperture...
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> Placing software IO TLB between 0x2636000 - 0x6636000
> Memory: 4028784k/4718592k available (2553k kernel code, 165384k reserved, 1597k data, 220k init)
> Calibrating delay using timer specific routine.. 6812.89 BogoMIPS (lpj=13625785)
> Security Framework v1.0.0 initialized
> Capability LSM initialized
> Mount-cache hash table entries: 256
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU 0/0 -> Node 0
> using mwait in idle threads.
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> CPU0: Thermal monitoring enabled (TM1)
> Freeing SMP alternatives: 36k freed
> GSI 24 sharing vector 0xA9 and IRQ 24
> GSI 25 sharing vector 0xB1 and IRQ 25
> GSI 26 sharing vector 0xB9 and IRQ 26
> GSI 27 sharing vector 0xC1 and IRQ 27
> GSI 28 sharing vector 0xC9 and IRQ 28
> GSI 29 sharing vector 0xD1 and IRQ 29
> GSI 49 sharing vector 0xD9 and IRQ 49
> GSI 50 sharing vector 0xE1 and IRQ 50
> GSI 51 sharing vector 0xE9 and IRQ 51
> GSI 52 sharing vector 0x32 and IRQ 52
> GSI 54 sharing vector 0x3A and IRQ 54
> GSI 55 sharing vector 0x42 and IRQ 55
> Using local APIC timer interrupts.
> result 12500733
> Detected 12.500 MHz APIC timer.
> Booting processor 1/2 APIC 0x6
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 6800.74 BogoMIPS (lpj=13601490)
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU 1/6 -> Node 0
> CPU: Physical Processor ID: 3
> CPU: Processor Core ID: 0
> CPU1: Thermal monitoring enabled (TM1)
>                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
> Brought up 2 CPUs
> testing NMI watchdog ... OK.
> time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
> time.c: Detected 3400.214 MHz processor.
> migration_cost=632
> checking if image is initramfs... it is
> Freeing initrd memory: 7256k freed
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> ACPI: Interpreter disabled.
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 3000-307f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 3080-30bf claimed by ICH4 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
> PCI: PXH quirk detected, disabling MSI for SHPC device
> PCI: PXH quirk detected, disabling MSI for SHPC device
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
> PCI->APIC IRQ transform: 0000:02:03.0[A] -> IRQ 24
> PCI->APIC IRQ transform: 0000:03:04.0[A] -> IRQ 54
> PCI->APIC IRQ transform: 0000:03:04.1[B] -> IRQ 55
> GSI 17 sharing vector 0x4A and IRQ 17
> PCI->APIC IRQ transform: 0000:05:0c.0[A] -> IRQ 17
> PCI-GART: No AMD northbridge found.
> PCI: Bridge: 0000:01:00.0
>   IO window: disabled.
>   MEM window: fe000000-fe0fffff
>   PREFETCH window: fd000000-fdffffff
> PCI: Bridge: 0000:01:00.2
>   IO window: 1000-1fff
>   MEM window: fe100000-fe1fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:02.0
>   IO window: 1000-1fff
>   MEM window: fe000000-fe2fffff
>   PREFETCH window: fd000000-fdffffff
> PCI: Bridge: 0000:00:06.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1e.0
>   IO window: 2000-2fff
>   MEM window: fb000000-fc0fffff
>   PREFETCH window: e2000000-e20fffff
> PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Probably buggy MP table.
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> PCI: Setting latency timer of device 0000:01:00.2 to 64
> PCI: No IRQ known for interrupt pin A of device 0000:00:06.0. Probably buggy MP table.
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
> Total HugeTLB memory allocated, 0
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Intel E7520/7320/7525 detected.<7>PCI: Setting latency timer of device 0000:00:02.0 to 64
> pcie_portdrv_probe->Dev[3595:8086] has invalid IRQ. Check vendor BIOS
> Allocate Port Service[0000:00:02.0:pcie00]
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> pcie_portdrv_probe->Dev[3599:8086] has invalid IRQ. Check vendor BIOS
> Allocate Port Service[0000:00:06.0:pcie00]
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> Intel(R) PRO/1000 Network Driver - version 7.2.7-k2-NAPI
> Copyright (c) 1999-2006 Intel Corporation.
> e1000: 0000:03:04.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:02:b3:e8:fa:c8
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: 0000:03:04.1: e1000_probe: (PCI-X:100MHz:64-bit) 00:02:b3:e8:fa:c9
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
> netconsole: not configured, aborting
> usbmon: debugfs is not available
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> EDAC MC: Ver: 2.0.1 Sep 26 2006
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> TCP bic registered
> Initializing XFRM netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Bridge firewalling registered
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> TIPC: Activated (version 1.6.1 compiled Sep 26 2006 18:53:22)
> NET: Registered protocol family 30
> TIPC: Started in single node mode
> /home/eric/projects/linux/linux-2.6-ns/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> Freeing unused kernel memory: 220k freed
