Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTAOKtl>; Wed, 15 Jan 2003 05:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTAOKtl>; Wed, 15 Jan 2003 05:49:41 -0500
Received: from holomorphy.com ([66.224.33.161]:36746 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266199AbTAOKtL> convert rfc822-to-8bit;
	Wed, 15 Jan 2003 05:49:11 -0500
Date: Wed, 15 Jan 2003 02:58:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030115105802.GQ940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like Linux boots and runs on a 48GB NUMA-Q, which probably is
useful publicly-posted empirical evidence for the highmem crew (I've
not seen success reports of large highmem boxen booting). But it was
only after some cleanups of subarch cleanups, and it was a major PITA.

Quick non-VM-related detour (no VM hacks were needed):

(1) I've got 320 IRQ sources. This panic()'s in setup_IO_APIC_irqs().
	-- The workaround is to set nr_ioapics = 2 in mpparse.c just
	-- before clustered_apic_check() and omit scanning node > 0 PCI.
	-- This needs considerably more attention from those who
	-- actually understand interrupt routing. From the looks of it,
	-- there is no way to cope with > 224 interrupt sources on i386,
	-- nor PCI segments, nor several other crucial things.
	-- I've already tried and failed on PCI segments.
	-- I would be much obliged for advice on this one, especially
	-- since the workaround cripples the machine.

(2) MAX_IO_APIC's got clobbered in the subarch cleanups.
	-- CONFIG_X86_NUMA was removed, use CONFIG_X86_NUMAQ
	-- this is greppable, folks...

(3) setup_ioapic_ids_from_mpc() panic()'s.
	-- the clustered_apic_mode check and/or its current equivalent
	-- no longer suffices with 16 IO-APIC's. Turn off all the
	-- renumbering logic and hardcode the numbers to alternate
	-- between 13 and 14, where they belong.
	-- The real issue here is that the phys_id_present_map is not
	-- properly per- APIC bus. The physid's of IO-APIC's are
	-- irrelevant from the standpoint of the rest of the kernel,
	-- but are inexplicably used to identify them throughout the
	-- rest of arch/i386/ when physids are nothing resembling
	-- unique identifiers in multiple APIC bus systems. This
	-- probably creates various kinds of explosions in
	-- setup_IO_APIC_irqs() via false positive comparisons in
	-- find_irq_entry(). An audit may very well be needed.

(4) PCI bridges get misnumbered children.
	-- Brew up a PCI hook for giving child buses their bus numbers.
	-- Basically, fwd port mbligh's fix for 2.4.x more cleanly.
	-- Okay, not IO-APIC-related, but it annoys me greatly.
	-- ink is at least trying to steer me in the right direction here.

(5) Booting with notsc panic()'s.
	-- Remove tsc_disable assignment in the __setup() call.
	-- I'd be much obliged if the SMP TSC issues were at long
	-- last conclusively dealt with. Not IO-APIC-related either,
	-- but also very annoying.

The patches themselves are nowhere near presentable, just debug hacks
(and very easily reconstitutable from the above descriptions). It runs
init scripts and shells, but the lowmem pressure from mem_map is severe:

MemTotal:     48719088 kB
MemFree:      48666432 kB
Buffers:           976 kB
Cached:           8624 kB
SwapCached:          0 kB
Active:           8108 kB
Inactive:         3940 kB
HighTotal:    48365568 kB
HighFree:     48345088 kB
LowTotal:       353520 kB
LowFree:        321344 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             108 kB
Writeback:           0 kB
Mapped:           5412 kB
Slab:             7784 kB
Committed_AS:     6828 kB
PageTables:        288 kB
ReverseMaps:      3872
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Minor extrapolation: aside from potential explosions in very unusual
corner cases, with these hacks/workarounds 64GB NUMA-Q should boot and
run (slowly) with an approximate LowTotal of 173296 kB. The main obstacle
is our setup here would require an additional NR_CPUS > BITS_PER_LONG
patch, and there isn't much local interest in even seeing whether or how
poorly it would run without working patches (e.g. hugh's MMUPAGE_SIZE that
I'm fwd. porting) to do something about runaway mem_map lowmem consumption.
A 2/2 split might support more loads at the cost of breaking ABI.

I amputated the I/O bits off the box to get it to boot, so tiobench
is useless to run b/c qlogicisp is ancient, buggy, and it bounces.


Thanks to nathan, mbligh, jejb, and others who helped me with the
early boot debugging issues.


Bill

Script started on Wed Jan 15 00:31:45 2003
$ screen -x
...changing IO-APIC physical APIC ID to 22 ... ok.
Saw IO-APIC 23 physid 13
...changing IO-APIC physical APIC ID to 23 ... ok.
Saw IO-APIC 24 physid 14
...changing IO-APIC physical APIC ID to 24 ... ok.
Saw IO-APIC 25 physid 13
...changing IO-APIC physical APIC ID to 25 ... ok.
Saw IO-APIC 26 physid 14
...changing IO-APIC physical APIC ID to 26 ... ok.
Saw IO-APIC 27 physid 13
...changing IO-APIC physical APIC ID to 27 ... ok.
Saw IO-APIC 28 physid 14
...changing IO-APIC physical APIC ID to 28 ... ok.
doing sync_Arb_IDs()
apic_wait_icr_idle().
Synchronizing Arb IDs.
doing setup_IO_APIC_irqs()
init IO_APIC IRQsi
IO-APIC (apicid-pin) 13-0, 14-0, 14-8, 14-18, 14-19, 14-20, 14-21, 14-22, 14-23, 15-0, 16-0, 16-8, 16-18, 16-19, 16-20, 16-21, 16-22, 16-23, 17-0, 18-0, 18-8, 18-18, 18-19, 18-20, 18-21, 18-22, 18-23, 19-0, 20-0, 20-8, 20-18, 20-19, 20-20, 20-21, 20-22, 20-23, 21-0, 22-0, 22-8, 22-18, 22-19, 22-20, 22-21, 22-22, 22-23, 23-0, 24-0<0>Kernel panic: ran out of interrupt sources!,
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
    GRUB  version 0.92  (639K lower / 3144704K upper memory)

 +-------------------------------------------------------------------------+ 
| Boot Safe Kernel                                                      |
| Boot check Kernel                                                     |
| Boot latest kernel                                                    |
| network Boot latest kernel from elm3b96                               |
| 2.5.44                                                                |
| 2.5.44-mm4                                                            |
| 2.5.44-mm4-erich                                                      |
| 2.5.44-mm4-michael                                                    |
| 2.5.52-stock                                                          |
| 2.5.52-sched                                                          |
| 2.5.50-sched                                                          |
| 2.5.50-stock                                                          |
| Boot Safe Kernel                                                      |
| Boot check Kernel                                                     |
| Boot latest kernel                                                    |
| network Boot latest kernel from elm3b96                               |
+-------------------------------------------------------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, or 'c' for a command-line.

dhcp
Found Digital Tulip Fast at 0xfc80, ROM address 0x0000
Probing...[Digital Tulip Fast]
Digital Tulip Fast: [chip: Digital DS21140 Tulip] rev 33 at FC80
Digital Tulip Fast: Vendor=1011  Device=0009
Digital Tulip Fast: 00:00:BC:0F:07:CF at ioaddr FC80
Digital Tulip Fast:  EEPROM default media type Autosense.
Digital Tulip Fast:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII
 (0) block.
Digital Tulip Fast:  Index #1 - Media 100baseTx (#3) described by a 21140 non-M
II (0) block.
Digital Tulip Fast:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non
-MII (0) block.
Digital Tulip Fast:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 n
on-MII (0) block.
Address: 9.47.67.221
Netmask: 255.255.255.0
Server: 9.47.67.96
Gateway: 9.47.67.1
kernel (nd)/boot/vmlinuz-numaq root=/dev/sda2 console=ttyS0,38400 notsc profile
=2
   [Linux-bzImage, setup=0xa00, size=0x12d3fc]

stkrnmsg
Linux version 2.5.58
got to setup_arch
boot cpu data good!
survived pre_setup_arch_hook()!
survived early_cpu_init()
survived ARCH_SETUP!
survived setup_memory_region()!
survived copy_edd()
survive parse_cmdline_early()!
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6040
survived setup_memory()!
survived smp_alloc_memory()!
entered paging_init()!
survived pagetable_init()!
survived load_cr3()!
survived set_in_cr4(X86_CR4_PAE)!
survived __flush_tlb_all()!
survived kmap_init()!
survived zone_sizes_init()!
survived paging_init()
entered get_smp_config()
survived dereferencing mpf()
    Virtual Wire compatibility mode.
about to smp_read_mpc()
entered smp_read_mpc()
OEM ID: IBM NUMA Product ID: SBB          Found an OEM MPC table at   7012ec - parsing it ... 
scanning entry@oemptr=007012fc
scanning entry@oemptr=00701304
scanning entry@oemptr=0070130c
scanning entry@oemptr=00701314
scanning entry@oemptr=0070131c
scanning entry@oemptr=00701324
scanning entry@oemptr=0070132c
scanning entry@oemptr=00701334
scanning entry@oemptr=0070133c
scanning entry@oemptr=00701344
scanning entry@oemptr=0070134c
scanning entry@oemptr=00701354
scanning entry@oemptr=0070135c
scanning entry@oemptr=00701364
scanning entry@oemptr=0070136c
scanning entry@oemptr=00701374
scanning entry@oemptr=0070137c
scanning entry@oemptr=00701384
scanning entry@oemptr=0070138c
scanning entry@oemptr=00701394
scanning entry@oemptr=0070139c
scanning entry@oemptr=007013a4
scanning entry@oemptr=007013ac
scanning entry@oemptr=007013b4
scanning entry@oemptr=007013bc
scanning entry@oemptr=007013c4
scanning entry@oemptr=007013cc
scanning entry@oemptr=007013d4
scanning entry@oemptr=007013dc
scanning entry@oemptr=007013e4
scanning entry@oemptr=007013ec
scanning entry@oemptr=007013f4
scanning entry@oemptr=007013fc
scanning entry@oemptr=00701404
scanning entry@oemptr=0070140c
scanning entry@oemptr=00701414
scanning entry@oemptr=0070141c
scanning entry@oemptr=00701424
scanning entry@oemptr=0070142c
scanning entry@oemptr=00701434
scanning entry@oemptr=0070143c
scanning entry@oemptr=00701444
scanning entry@oemptr=0070144c
scanning entry@oemptr=00701454
scanning entry@oemptr=0070145c
scanning entry@oemptr=00701464
scanning entry@oemptr=0070146c
scanning entry@oemptr=00701474
scanning entry@oemptr=0070147c
scanning entry@oemptr=00701484
scanning entry@oemptr=0070148c
scanning entry@oemptr=00701494
scanning entry@oemptr=0070149c
scanning entry@oemptr=007014a4
scanning entry@oemptr=007014ac
scanning entry@oemptr=007014b4
scanning entry@oemptr=007014bc
scanning entry@oemptr=007014c4
scanning entry@oemptr=007014cc
scanning entry@oemptr=007014d4
scanning entry@oemptr=007014dc
scanning entry@oemptr=007014e4
scanning entry@oemptr=007014ec
scanning entry@oemptr=007014f4
scanning entry@oemptr=007014fc
scanning entry@oemptr=00701504
scanning entry@oemptr=0070150c
scanning entry@oemptr=00701514
scanning entry@oemptr=0070151c
scanning entry@oemptr=00701524
scanning entry@oemptr=0070152c
scanning entry@oemptr=00701534
scanning entry@oemptr=0070153c
scanning entry@oemptr=00701544
scanning entry@oemptr=0070154c
scanning entry@oemptr=00701554
APIC at: 0xFEC08000
scanning entry@mpt=0070002c
MP_PROCESSOR
scanning entry@mpt=00700040
MP_PROCESSOR
scanning entry@mpt=00700054
MP_PROCESSOR
scanning entry@mpt=00700068
MP_PROCESSOR
scanning entry@mpt=0070007c
MP_PROCESSOR
scanning entry@mpt=00700090
MP_PROCESSOR
scanning entry@mpt=007000a4
MP_PROCESSOR
scanning entry@mpt=007000b8
MP_PROCESSOR
scanning entry@mpt=007000cc
MP_PROCESSOR
scanning entry@mpt=007000e0
MP_PROCESSOR
scanning entry@mpt=007000f4
MP_PROCESSOR
scanning entry@mpt=00700108
MP_PROCESSOR
scanning entry@mpt=0070011c
MP_PROCESSOR
scanning entry@mpt=00700130
MP_PROCESSOR
scanning entry@mpt=00700144
MP_PROCESSOR
scanning entry@mpt=00700158
MP_PROCESSOR
scanning entry@mpt=0070016c
MP_PROCESSOR
scanning entry@mpt=00700180
MP_PROCESSOR
scanning entry@mpt=00700194
MP_PROCESSOR
scanning entry@mpt=007001a8
MP_PROCESSOR
scanning entry@mpt=007001bc
MP_PROCESSOR
scanning entry@mpt=007001d0
MP_PROCESSOR
scanning entry@mpt=007001e4
MP_PROCESSOR
scanning entry@mpt=007001f8
MP_PROCESSOR
scanning entry@mpt=0070020c
MP_PROCESSOR
scanning entry@mpt=00700220
MP_PROCESSOR
scanning entry@mpt=00700234
MP_PROCESSOR
scanning entry@mpt=00700248
MP_PROCESSOR
scanning entry@mpt=0070025c
MP_PROCESSOR
scanning entry@mpt=00700270
MP_PROCESSOR
scanning entry@mpt=00700284
MP_PROCESSOR
scanning entry@mpt=00700298
MP_PROCESSOR
scanning entry@mpt=007002ac
MP_BUS
scanning entry@mpt=007002b4
MP_BUS
scanning entry@mpt=007002bc
MP_BUS
scanning entry@mpt=007002c4
MP_BUS
scanning entry@mpt=007002cc
MP_BUS
scanning entry@mpt=007002d4
MP_BUS
scanning entry@mpt=007002dc
MP_BUS
scanning entry@mpt=007002e4
MP_BUS
scanning entry@mpt=007002ec
MP_BUS
scanning entry@mpt=007002f4
MP_BUS
scanning entry@mpt=007002fc
MP_BUS
scanning entry@mpt=00700304
MP_BUS
scanning entry@mpt=0070030c
MP_BUS
scanning entry@mpt=00700314
MP_BUS
scanning entry@mpt=0070031c
MP_BUS
scanning entry@mpt=00700324
MP_BUS
scanning entry@mpt=0070032c
MP_BUS
scanning entry@mpt=00700334
MP_BUS
scanning entry@mpt=0070033c
MP_BUS
scanning entry@mpt=00700344
MP_BUS
scanning entry@mpt=0070034c
MP_BUS
scanning entry@mpt=00700354
MP_BUS
scanning entry@mpt=0070035c
MP_BUS
scanning entry@mpt=00700364
MP_BUS
scanning entry@mpt=0070036c
MP_BUS
scanning entry@mpt=00700374
MP_BUS
scanning entry@mpt=0070037c
MP_BUS
scanning entry@mpt=00700384
MP_BUS
scanning entry@mpt=0070038c
MP_IOAPIC
scanning entry@mpt=00700394
MP_IOAPIC
scanning entry@mpt=0070039c
MP_IOAPIC
scanning entry@mpt=007003a4
MP_IOAPIC
scanning entry@mpt=007003ac
MP_IOAPIC
scanning entry@mpt=007003b4
MP_IOAPIC
scanning entry@mpt=007003bc
MP_IOAPIC
scanning entry@mpt=007003c4
MP_IOAPIC
scanning entry@mpt=007003cc
MP_IOAPIC
scanning entry@mpt=007003d4
MP_IOAPIC
scanning entry@mpt=007003dc
MP_IOAPIC
scanning entry@mpt=007003e4
MP_IOAPIC
scanning entry@mpt=007003ec
MP_IOAPIC
scanning entry@mpt=007003f4
MP_IOAPIC
scanning entry@mpt=007003fc
MP_IOAPIC
scanning entry@mpt=00700404
MP_IOAPIC
scanning entry@mpt=0070040c
MP_INTSRC
scanning entry@mpt=00700414
MP_INTSRC
scanning entry@mpt=0070041c
MP_INTSRC
scanning entry@mpt=00700424
MP_INTSRC
scanning entry@mpt=0070042c
MP_INTSRC
scanning entry@mpt=00700434
MP_INTSRC
scanning entry@mpt=0070043c
MP_INTSRC
scanning entry@mpt=00700444
MP_INTSRC
scanning entry@mpt=0070044c
MP_INTSRC
scanning entry@mpt=00700454
MP_INTSRC
scanning entry@mpt=0070045c
MP_INTSRC
scanning entry@mpt=00700464
MP_INTSRC
scanning entry@mpt=0070046c
MP_INTSRC
scanning entry@mpt=00700474
MP_INTSRC
scanning entry@mpt=0070047c
MP_INTSRC
scanning entry@mpt=00700484
MP_INTSRC
scanning entry@mpt=0070048c
MP_INTSRC
scanning entry@mpt=00700494
MP_INTSRC
scanning entry@mpt=0070049c
MP_INTSRC
scanning entry@mpt=007004a4
MP_INTSRC
scanning entry@mpt=007004ac
MP_INTSRC
scanning entry@mpt=007004b4
MP_INTSRC
scanning entry@mpt=007004bc
MP_INTSRC
scanning entry@mpt=007004c4
MP_INTSRC
scanning entry@mpt=007004cc
MP_INTSRC
scanning entry@mpt=007004d4
MP_INTSRC
scanning entry@mpt=007004dc
MP_INTSRC
scanning entry@mpt=007004e4
MP_INTSRC
scanning entry@mpt=007004ec
MP_INTSRC
scanning entry@mpt=007004f4
MP_INTSRC
scanning entry@mpt=007004fc
MP_INTSRC
scanning entry@mpt=00700504
MP_INTSRC
scanning entry@mpt=0070050c
MP_INTSRC
scanning entry@mpt=00700514
MP_INTSRC
scanning entry@mpt=0070051c
MP_INTSRC
scanning entry@mpt=00700524
MP_INTSRC
scanning entry@mpt=0070052c
MP_INTSRC
scanning entry@mpt=00700534
MP_INTSRC
scanning entry@mpt=0070053c
MP_INTSRC
scanning entry@mpt=00700544
MP_INTSRC
scanning entry@mpt=0070054c
MP_INTSRC
scanning entry@mpt=00700554
MP_INTSRC
scanning entry@mpt=0070055c
MP_INTSRC
scanning entry@mpt=00700564
MP_INTSRC
scanning entry@mpt=0070056c
MP_INTSRC
scanning entry@mpt=00700574
MP_INTSRC
scanning entry@mpt=0070057c
MP_INTSRC
scanning entry@mpt=00700584
MP_INTSRC
scanning entry@mpt=0070058c
MP_INTSRC
scanning entry@mpt=00700594
MP_INTSRC
scanning entry@mpt=0070059c
MP_INTSRC
scanning entry@mpt=007005a4
MP_INTSRC
scanning entry@mpt=007005ac
MP_INTSRC
scanning entry@mpt=007005b4
MP_INTSRC
scanning entry@mpt=007005bc
MP_INTSRC
scanning entry@mpt=007005c4
MP_INTSRC
scanning entry@mpt=007005cc
MP_INTSRC
scanning entry@mpt=007005d4
MP_INTSRC
scanning entry@mpt=007005dc
MP_INTSRC
scanning entry@mpt=007005e4
MP_INTSRC
scanning entry@mpt=007005ec
MP_INTSRC
scanning entry@mpt=007005f4
MP_INTSRC
scanning entry@mpt=007005fc
MP_INTSRC
scanning entry@mpt=00700604
MP_INTSRC
scanning entry@mpt=0070060c
MP_INTSRC
scanning entry@mpt=00700614
MP_INTSRC
scanning entry@mpt=0070061c
MP_INTSRC
scanning entry@mpt=00700624
MP_INTSRC
scanning entry@mpt=0070062c
MP_INTSRC
scanning entry@mpt=00700634
MP_INTSRC
scanning entry@mpt=0070063c
MP_INTSRC
scanning entry@mpt=00700644
MP_INTSRC
scanning entry@mpt=0070064c
MP_INTSRC
scanning entry@mpt=00700654
MP_INTSRC
scanning entry@mpt=0070065c
MP_INTSRC
scanning entry@mpt=00700664
MP_INTSRC
scanning entry@mpt=0070066c
MP_INTSRC
scanning entry@mpt=00700674
MP_INTSRC
scanning entry@mpt=0070067c
MP_INTSRC
scanning entry@mpt=00700684
MP_INTSRC
scanning entry@mpt=0070068c
MP_INTSRC
scanning entry@mpt=00700694
MP_INTSRC
scanning entry@mpt=0070069c
MP_INTSRC
scanning entry@mpt=007006a4
MP_INTSRC
scanning entry@mpt=007006ac
MP_INTSRC
scanning entry@mpt=007006b4
MP_INTSRC
scanning entry@mpt=007006bc
MP_INTSRC
scanning entry@mpt=007006c4
MP_INTSRC
scanning entry@mpt=007006cc
MP_INTSRC
scanning entry@mpt=007006d4
MP_INTSRC
scanning entry@mpt=007006dc
MP_INTSRC
scanning entry@mpt=007006e4
MP_INTSRC
scanning entry@mpt=007006ec
MP_INTSRC
scanning entry@mpt=007006f4
MP_INTSRC
scanning entry@mpt=007006fc
MP_INTSRC
scanning entry@mpt=00700704
MP_INTSRC
scanning entry@mpt=0070070c
MP_INTSRC
scanning entry@mpt=00700714
MP_INTSRC
scanning entry@mpt=0070071c
MP_INTSRC
scanning entry@mpt=00700724
MP_INTSRC
scanning entry@mpt=0070072c
MP_INTSRC
scanning entry@mpt=00700734
MP_INTSRC
scanning entry@mpt=0070073c
MP_INTSRC
scanning entry@mpt=00700744
MP_INTSRC
scanning entry@mpt=0070074c
MP_INTSRC
scanning entry@mpt=00700754
MP_INTSRC
scanning entry@mpt=0070075c
MP_INTSRC
scanning entry@mpt=00700764
MP_INTSRC
scanning entry@mpt=0070076c
MP_INTSRC
scanning entry@mpt=00700774
MP_INTSRC
scanning entry@mpt=0070077c
MP_INTSRC
scanning entry@mpt=00700784
MP_INTSRC
scanning entry@mpt=0070078c
MP_INTSRC
scanning entry@mpt=00700794
MP_INTSRC
scanning entry@mpt=0070079c
MP_INTSRC
scanning entry@mpt=007007a4
MP_INTSRC
scanning entry@mpt=007007ac
MP_INTSRC
scanning entry@mpt=007007b4
MP_INTSRC
scanning entry@mpt=007007bc
MP_INTSRC
scanning entry@mpt=007007c4
MP_INTSRC
scanning entry@mpt=007007cc
MP_INTSRC
scanning entry@mpt=007007d4
MP_INTSRC
scanning entry@mpt=007007dc
MP_INTSRC
scanning entry@mpt=007007e4
MP_INTSRC
scanning entry@mpt=007007ec
MP_INTSRC
scanning entry@mpt=007007f4
MP_INTSRC
scanning entry@mpt=007007fc
MP_INTSRC
scanning entry@mpt=00700804
MP_INTSRC
scanning entry@mpt=0070080c
MP_INTSRC
scanning entry@mpt=00700814
MP_INTSRC
scanning entry@mpt=0070081c
MP_INTSRC
scanning entry@mpt=00700824
MP_INTSRC
scanning entry@mpt=0070082c
MP_INTSRC
scanning entry@mpt=00700834
MP_INTSRC
scanning entry@mpt=0070083c
MP_INTSRC
scanning entry@mpt=00700844
MP_INTSRC
scanning entry@mpt=0070084c
MP_INTSRC
scanning entry@mpt=00700854
MP_INTSRC
scanning entry@mpt=0070085c
MP_INTSRC
scanning entry@mpt=00700864
MP_INTSRC
scanning entry@mpt=0070086c
MP_INTSRC
scanning entry@mpt=00700874
MP_INTSRC
scanning entry@mpt=0070087c
MP_INTSRC
scanning entry@mpt=00700884
MP_INTSRC
scanning entry@mpt=0070088c
MP_INTSRC
scanning entry@mpt=00700894
MP_INTSRC
scanning entry@mpt=0070089c
MP_INTSRC
scanning entry@mpt=007008a4
MP_INTSRC
scanning entry@mpt=007008ac
MP_INTSRC
scanning entry@mpt=007008b4
MP_INTSRC
scanning entry@mpt=007008bc
MP_INTSRC
scanning entry@mpt=007008c4
MP_INTSRC
scanning entry@mpt=007008cc
MP_INTSRC
scanning entry@mpt=007008d4
MP_INTSRC
scanning entry@mpt=007008dc
MP_INTSRC
scanning entry@mpt=007008e4
MP_INTSRC
scanning entry@mpt=007008ec
MP_INTSRC
scanning entry@mpt=007008f4
MP_INTSRC
scanning entry@mpt=007008fc
MP_INTSRC
scanning entry@mpt=00700904
MP_INTSRC
scanning entry@mpt=0070090c
MP_INTSRC
scanning entry@mpt=00700914
MP_INTSRC
scanning entry@mpt=0070091c
MP_INTSRC
scanning entry@mpt=00700924
MP_INTSRC
scanning entry@mpt=0070092c
MP_INTSRC
scanning entry@mpt=00700934
MP_INTSRC
scanning entry@mpt=0070093c
MP_INTSRC
scanning entry@mpt=00700944
MP_INTSRC
scanning entry@mpt=0070094c
MP_INTSRC
scanning entry@mpt=00700954
MP_INTSRC
scanning entry@mpt=0070095c
MP_INTSRC
scanning entry@mpt=00700964
MP_INTSRC
scanning entry@mpt=0070096c
MP_INTSRC
scanning entry@mpt=00700974
MP_INTSRC
scanning entry@mpt=0070097c
MP_INTSRC
scanning entry@mpt=00700984
MP_INTSRC
scanning entry@mpt=0070098c
MP_INTSRC
scanning entry@mpt=00700994
MP_INTSRC
scanning entry@mpt=0070099c
MP_INTSRC
scanning entry@mpt=007009a4
MP_INTSRC
scanning entry@mpt=007009ac
MP_INTSRC
scanning entry@mpt=007009b4
MP_INTSRC
scanning entry@mpt=007009bc
MP_INTSRC
scanning entry@mpt=007009c4
MP_INTSRC
scanning entry@mpt=007009cc
MP_INTSRC
scanning entry@mpt=007009d4
MP_INTSRC
scanning entry@mpt=007009dc
MP_INTSRC
scanning entry@mpt=007009e4
MP_INTSRC
scanning entry@mpt=007009ec
MP_INTSRC
scanning entry@mpt=007009f4
MP_INTSRC
scanning entry@mpt=007009fc
MP_INTSRC
scanning entry@mpt=00700a04
MP_INTSRC
scanning entry@mpt=00700a0c
MP_INTSRC
scanning entry@mpt=00700a14
MP_INTSRC
scanning entry@mpt=00700a1c
MP_INTSRC
scanning entry@mpt=00700a24
MP_INTSRC
scanning entry@mpt=00700a2c
MP_INTSRC
scanning entry@mpt=00700a34
MP_INTSRC
scanning entry@mpt=00700a3c
MP_INTSRC
scanning entry@mpt=00700a44
MP_INTSRC
scanning entry@mpt=00700a4c
MP_INTSRC
scanning entry@mpt=00700a54
MP_INTSRC
scanning entry@mpt=00700a5c
MP_INTSRC
scanning entry@mpt=00700a64
MP_INTSRC
scanning entry@mpt=00700a6c
MP_INTSRC
scanning entry@mpt=00700a74
MP_INTSRC
scanning entry@mpt=00700a7c
MP_INTSRC
scanning entry@mpt=00700a84
MP_INTSRC
scanning entry@mpt=00700a8c
MP_INTSRC
scanning entry@mpt=00700a94
MP_INTSRC
scanning entry@mpt=00700a9c
MP_INTSRC
scanning entry@mpt=00700aa4
MP_INTSRC
scanning entry@mpt=00700aac
MP_INTSRC
scanning entry@mpt=00700ab4
MP_INTSRC
scanning entry@mpt=00700abc
MP_INTSRC
scanning entry@mpt=00700ac4
MP_INTSRC
scanning entry@mpt=00700acc
MP_INTSRC
scanning entry@mpt=00700ad4
MP_INTSRC
scanning entry@mpt=00700adc
MP_INTSRC
scanning entry@mpt=00700ae4
MP_INTSRC
scanning entry@mpt=00700aec
MP_INTSRC
scanning entry@mpt=00700af4
MP_INTSRC
scanning entry@mpt=00700afc
MP_INTSRC
scanning entry@mpt=00700b04
MP_INTSRC
scanning entry@mpt=00700b0c
MP_INTSRC
scanning entry@mpt=00700b14
MP_INTSRC
scanning entry@mpt=00700b1c
MP_INTSRC
scanning entry@mpt=00700b24
MP_INTSRC
scanning entry@mpt=00700b2c
MP_INTSRC
scanning entry@mpt=00700b34
MP_INTSRC
scanning entry@mpt=00700b3c
MP_INTSRC
scanning entry@mpt=00700b44
MP_INTSRC
scanning entry@mpt=00700b4c
MP_INTSRC
scanning entry@mpt=00700b54
MP_INTSRC
scanning entry@mpt=00700b5c
MP_INTSRC
scanning entry@mpt=00700b64
MP_INTSRC
scanning entry@mpt=00700b6c
MP_INTSRC
scanning entry@mpt=00700b74
MP_INTSRC
scanning entry@mpt=00700b7c
MP_INTSRC
scanning entry@mpt=00700b84
MP_INTSRC
scanning entry@mpt=00700b8c
MP_INTSRC
scanning entry@mpt=00700b94
MP_INTSRC
scanning entry@mpt=00700b9c
MP_INTSRC
scanning entry@mpt=00700ba4
MP_INTSRC
scanning entry@mpt=00700bac
MP_INTSRC
scanning entry@mpt=00700bb4
MP_INTSRC
scanning entry@mpt=00700bbc
MP_INTSRC
scanning entry@mpt=00700bc4
MP_INTSRC
scanning entry@mpt=00700bcc
MP_INTSRC
scanning entry@mpt=00700bd4
MP_INTSRC
scanning entry@mpt=00700bdc
MP_INTSRC
scanning entry@mpt=00700be4
MP_INTSRC
scanning entry@mpt=00700bec
MP_INTSRC
scanning entry@mpt=00700bf4
MP_INTSRC
scanning entry@mpt=00700bfc
MP_INTSRC
scanning entry@mpt=00700c04
MP_INTSRC
scanning entry@mpt=00700c0c
MP_INTSRC
scanning entry@mpt=00700c14
MP_INTSRC
scanning entry@mpt=00700c1c
MP_INTSRC
scanning entry@mpt=00700c24
MP_INTSRC
scanning entry@mpt=00700c2c
MP_INTSRC
scanning entry@mpt=00700c34
MP_INTSRC
scanning entry@mpt=00700c3c
MP_INTSRC
scanning entry@mpt=00700c44
MP_INTSRC
scanning entry@mpt=00700c4c
MP_INTSRC
scanning entry@mpt=00700c54
MP_INTSRC
scanning entry@mpt=00700c5c
MP_INTSRC
scanning entry@mpt=00700c64
MP_INTSRC
scanning entry@mpt=00700c6c
MP_INTSRC
scanning entry@mpt=00700c74
MP_INTSRC
scanning entry@mpt=00700c7c
MP_INTSRC
scanning entry@mpt=00700c84
MP_INTSRC
scanning entry@mpt=00700c8c
MP_INTSRC
scanning entry@mpt=00700c94
MP_INTSRC
scanning entry@mpt=00700c9c
MP_INTSRC
scanning entry@mpt=00700ca4
MP_INTSRC
scanning entry@mpt=00700cac
MP_INTSRC
scanning entry@mpt=00700cb4
MP_INTSRC
scanning entry@mpt=00700cbc
MP_INTSRC
scanning entry@mpt=00700cc4
MP_INTSRC
scanning entry@mpt=00700ccc
MP_INTSRC
scanning entry@mpt=00700cd4
MP_INTSRC
scanning entry@mpt=00700cdc
MP_INTSRC
scanning entry@mpt=00700ce4
MP_INTSRC
scanning entry@mpt=00700cec
MP_INTSRC
scanning entry@mpt=00700cf4
MP_INTSRC
scanning entry@mpt=00700cfc
MP_INTSRC
scanning entry@mpt=00700d04
MP_INTSRC
scanning entry@mpt=00700d0c
MP_INTSRC
scanning entry@mpt=00700d14
MP_INTSRC
scanning entry@mpt=00700d1c
MP_INTSRC
scanning entry@mpt=00700d24
MP_INTSRC
scanning entry@mpt=00700d2c
MP_INTSRC
scanning entry@mpt=00700d34
MP_INTSRC
scanning entry@mpt=00700d3c
MP_INTSRC
scanning entry@mpt=00700d44
MP_INTSRC
scanning entry@mpt=00700d4c
MP_INTSRC
scanning entry@mpt=00700d54
MP_INTSRC
scanning entry@mpt=00700d5c
MP_INTSRC
scanning entry@mpt=00700d64
MP_INTSRC
scanning entry@mpt=00700d6c
MP_INTSRC
scanning entry@mpt=00700d74
MP_INTSRC
scanning entry@mpt=00700d7c
MP_INTSRC
scanning entry@mpt=00700d84
MP_INTSRC
scanning entry@mpt=00700d8c
MP_INTSRC
scanning entry@mpt=00700d94
MP_INTSRC
scanning entry@mpt=00700d9c
MP_INTSRC
scanning entry@mpt=00700da4
MP_INTSRC
scanning entry@mpt=00700dac
MP_INTSRC
scanning entry@mpt=00700db4
MP_INTSRC
scanning entry@mpt=00700dbc
MP_INTSRC
scanning entry@mpt=00700dc4
MP_INTSRC
scanning entry@mpt=00700dcc
MP_INTSRC
scanning entry@mpt=00700dd4
MP_INTSRC
scanning entry@mpt=00700ddc
MP_INTSRC
scanning entry@mpt=00700de4
MP_INTSRC
scanning entry@mpt=00700dec
MP_INTSRC
scanning entry@mpt=00700df4
MP_INTSRC
scanning entry@mpt=00700dfc
MP_INTSRC
scanning entry@mpt=00700e04
MP_INTSRC
scanning entry@mpt=00700e0c
MP_LINTSRC
scanning entry@mpt=00700e14
MP_LINTSRC
survived get_smp_config()!
survived register_memory()!
survived dmi_scan_machine()!
survived setup_arch()
survived setup_per_cpu_areas()
survived smp_prepare_boot_cpu()
survived build_all_zonelists()
survived page_alloc_init()
survived parse_args()
Linux version 2.5.58 (wli@elm3b96) (gcc version 3.0.4) #19 SMP Wed Jan 15 00:28:32 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000c00000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 00000000c0000000 (usable)
 user: 00000000fec00000 - 00000000fec09000 (reserved)
 user: 00000000ffe80000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000c00000000 (usable)
Reserving 23040 pages of KVA for lmem_map of node 1
Shrinking node 1 from 4194304 pages to 4171264 pages
Reserving 23040 pages of KVA for lmem_map of node 2
Shrinking node 2 from 6291456 pages to 6268416 pages
Reserving 23040 pages of KVA for lmem_map of node 3
Shrinking node 3 from 8388608 pages to 8365568 pages
Reserving 11776 pages of KVA for lmem_map of node 4
Shrinking node 4 from 9437184 pages to 9425408 pages
Reserving 11776 pages of KVA for lmem_map of node 5
Shrinking node 5 from 10485760 pages to 10473984 pages
Reserving 11776 pages of KVA for lmem_map of node 6
Shrinking node 6 from 11534336 pages to 11522560 pages
Reserving 11776 pages of KVA for lmem_map of node 7
Shrinking node 7 from 12582912 pages to 12571136 pages
Reserving total of 116224 pages for numa KVA remap
48256MB HIGHMEM available.
442MB LOWMEM available.
min_low_pfn = 1027, max_low_pfn = 113152, highstart_pfn = 229376
Low memory ends at vaddr dba00000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f2600000 - f8000000
node 2 will remap to vaddr ecc00000 - f2600000
node 3 will remap to vaddr e7200000 - ecc00000
node 4 will remap to vaddr e4400000 - e7200000
node 5 will remap to vaddr e1600000 - e4400000
node 6 will remap to vaddr de800000 - e1600000
node 7 will remap to vaddr dba00000 - de800000
High memory starts at vaddr f8000000
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 2097152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 109056 pages, LIFO batch:16
  HighMem zone: 1984000 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
On node 1 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 2 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 3 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 4 totalpages: 1036800
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1036800 pages, LIFO batch:16
On node 5 totalpages: 1036800
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1036800 pages, LIFO batch:16
On node 6 totalpages: 1036800
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1036800 pages, LIFO batch:16
On node 7 totalpages: 1036800
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1036800 pages, LIFO batch:16
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          Found an OEM MPC table at   7012ec - parsing it ... 
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 1, quad 1, global 1, local 3
Translation: record 5, type 1, quad 1, global 1, local 1
Translation: record 6, type 1, quad 1, global 1, local 1
Translation: record 7, type 1, quad 1, global 1, local 1
Translation: record 8, type 1, quad 2, global 1, local 3
Translation: record 9, type 1, quad 2, global 1, local 1
Translation: record 10, type 1, quad 2, global 1, local 1
Translation: record 11, type 1, quad 2, global 1, local 1
Translation: record 12, type 1, quad 3, global 1, local 3
Translation: record 13, type 1, quad 3, global 1, local 1
Translation: record 14, type 1, quad 3, global 1, local 1
Translation: record 15, type 1, quad 3, global 1, local 1
Translation: record 16, type 1, quad 4, global 1, local 3
Translation: record 17, type 1, quad 4, global 1, local 1
Translation: record 18, type 1, quad 4, global 1, local 1
Translation: record 19, type 1, quad 4, global 1, local 1
Translation: record 20, type 1, quad 5, global 1, local 3
Translation: record 21, type 1, quad 5, global 1, local 1
Translation: record 22, type 1, quad 5, global 1, local 1
Translation: record 23, type 1, quad 5, global 1, local 1
Translation: record 24, type 1, quad 6, global 1, local 3
Translation: record 25, type 1, quad 6, global 1, local 1
Translation: record 26, type 1, quad 6, global 1, local 1
Translation: record 27, type 1, quad 6, global 1, local 1
Translation: record 28, type 1, quad 7, global 1, local 3
Translation: record 29, type 1, quad 7, global 1, local 1
Translation: record 30, type 1, quad 7, global 1, local 1
Translation: record 31, type 1, quad 7, global 1, local 1
Translation: record 32, type 3, quad 0, global 0, local 0
Translation: record 33, type 3, quad 0, global 1, local 1
Translation: record 34, type 3, quad 0, global 2, local 2
Translation: record 35, type 4, quad 0, global 20, local 18
Translation: record 36, type 3, quad 1, global 3, local 0
Translation: record 37, type 3, quad 1, global 4, local 1
Translation: record 38, type 4, quad 1, global 21, local 18
Translation: record 39, type 3, quad 2, global 5, local 0
Translation: record 40, type 3, quad 2, global 6, local 1
Translation: record 41, type 4, quad 2, global 22, local 18
Translation: record 42, type 3, quad 3, global 7, local 0
Translation: record 43, type 3, quad 3, global 8, local 1
Translation: record 44, type 4, quad 3, global 23, local 18
Translation: record 45, type 3, quad 4, global 9, local 0
Translation: record 46, type 3, quad 4, global 10, local 1
Translation: record 47, type 3, quad 4, global 11, local 2
Translation: record 48, type 4, quad 4, global 24, local 18
Translation: record 49, type 3, quad 5, global 12, local 0
Translation: record 50, type 3, quad 5, global 13, local 1
Translation: record 51, type 4, quad 5, global 25, local 18
Translation: record 52, type 3, quad 6, global 14, local 0
Translation: record 53, type 3, quad 6, global 15, local 1
Translation: record 54, type 3, quad 6, global 16, local 2
Translation: record 55, type 4, quad 6, global 26, local 18
Translation: record 56, type 3, quad 7, global 17, local 0
Translation: record 57, type 3, quad 7, global 18, local 1
Translation: record 58, type 3, quad 7, global 19, local 2
Translation: record 59, type 4, quad 7, global 27, local 18
Translation: record 60, type 2, quad 0, global 13, local 14
Translation: record 61, type 2, quad 0, global 14, local 13
Translation: record 62, type 2, quad 1, global 15, local 14
Translation: record 63, type 2, quad 1, global 16, local 13
Translation: record 64, type 2, quad 2, global 17, local 14
Translation: record 65, type 2, quad 2, global 18, local 13
Translation: record 66, type 2, quad 3, global 19, local 14
Translation: record 67, type 2, quad 3, global 20, local 13
Translation: record 68, type 2, quad 4, global 21, local 14
Translation: record 69, type 2, quad 4, global 22, local 13
Translation: record 70, type 2, quad 5, global 23, local 14
Translation: record 71, type 2, quad 5, global 24, local 13
Translation: record 72, type 2, quad 6, global 25, local 14
Translation: record 73, type 2, quad 6, global 26, local 13
Translation: record 74, type 2, quad 7, global 27, local 14
Translation: record 75, type 2, quad 7, global 28, local 13
APIC at: 0xFEC08000
Processor #0 6:10 APIC version 17 (quad 0, apic 1)
Processor #4 6:10 APIC version 17 (quad 0, apic 8)
Processor #1 6:10 APIC version 17 (quad 0, apic 2)
Processor #2 6:10 APIC version 17 (quad 0, apic 4)
Processor #0 6:10 APIC version 17 (quad 1, apic 17)
Processor #4 6:10 APIC version 17 (quad 1, apic 24)
Processor #1 6:10 APIC version 17 (quad 1, apic 18)
Processor #2 6:10 APIC version 17 (quad 1, apic 20)
Processor #0 6:10 APIC version 17 (quad 2, apic 33)
Processor #4 6:10 APIC version 17 (quad 2, apic 40)
Processor #1 6:10 APIC version 17 (quad 2, apic 34)
Processor #2 6:10 APIC version 17 (quad 2, apic 36)
Processor #0 6:10 APIC version 17 (quad 3, apic 49)
Processor #4 6:10 APIC version 17 (quad 3, apic 56)
Processor #1 6:10 APIC version 17 (quad 3, apic 50)
Processor #2 6:10 APIC version 17 (quad 3, apic 52)
Processor #0 6:10 APIC version 17 (quad 4, apic 65)
Processor #4 6:10 APIC version 17 (quad 4, apic 72)
Processor #1 6:10 APIC version 17 (quad 4, apic 66)
Processor #2 6:10 APIC version 17 (quad 4, apic 68)
Processor #0 6:10 APIC version 17 (quad 5, apic 81)
Processor #4 6:10 APIC version 17 (quad 5, apic 88)
Processor #1 6:10 APIC version 17 (quad 5, apic 82)
Processor #2 6:10 APIC version 17 (quad 5, apic 84)
Processor #0 6:10 APIC version 17 (quad 6, apic 97)
Processor #4 6:10 APIC version 17 (quad 6, apic 104)
Processor #1 6:10 APIC version 17 (quad 6, apic 98)
Processor #2 6:10 APIC version 17 (quad 6, apic 100)
Processor #0 6:10 APIC version 17 (quad 7, apic 113)
Processor #4 6:10 APIC version 17 (quad 7, apic 120)
Processor #1 6:10 APIC version 17 (quad 7, apic 114)
Processor #2 6:10 APIC version 17 (quad 7, apic 116)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is PCI    (node 0)
Bus #20 is EISA   (node 0)
Bus #3 is PCI    (node 1)
Bus #4 is PCI    (node 1)
Bus #21 is EISA   (node 1)
Bus #5 is PCI    (node 2)
Bus #6 is PCI    (node 2)
Bus #22 is EISA   (node 2)
Bus #7 is PCI    (node 3)
Bus #8 is PCI    (node 3)
Bus #23 is EISA   (node 3)
Bus #9 is PCI    (node 4)
Bus #10 is PCI    (node 4)
Bus #11 is PCI    (node 4)
Bus #24 is EISA   (node 4)
Bus #12 is PCI    (node 5)
Bus #13 is PCI    (node 5)
Bus #25 is EISA   (node 5)
Bus #14 is PCI    (node 6)
Bus #15 is PCI    (node 6)
Bus #16 is PCI    (node 6)
Bus #26 is EISA   (node 6)
Bus #17 is PCI    (node 7)
Bus #18 is PCI    (node 7)
Bus #19 is PCI    (node 7)
Bus #27 is EISA   (node 7)
I/O APIC #13 Version 17 at 0xFE800000.
I/O APIC #14 Version 17 at 0xFE801000.
I/O APIC #15 Version 17 at 0xFE840000.
I/O APIC #16 Version 17 at 0xFE841000.
I/O APIC #17 Version 17 at 0xFE880000.
I/O APIC #18 Version 17 at 0xFE881000.
I/O APIC #19 Version 17 at 0xFE8C0000.
I/O APIC #20 Version 17 at 0xFE8C1000.
I/O APIC #21 Version 17 at 0xFE900000.
I/O APIC #22 Version 17 at 0xFE901000.
I/O APIC #23 Version 17 at 0xFE940000.
I/O APIC #24 Version 17 at 0xFE941000.
I/O APIC #25 Version 17 at 0xFE980000.
I/O APIC #26 Version 17 at 0xFE981000.
I/O APIC #27 Version 17 at 0xFE9C0000.
I/O APIC #28 Version 17 at 0xFE9C1000.
Enabling APIC mode:  NUMA-Q.  Using 2 I/O APICs
Processors: 32
Building zonelist for node : 0
Building zonelist for node : 1
Building zonelist for node : 2
Building zonelist for node : 3
Building zonelist for node : 4
Building zonelist for node : 5
Building zonelist for node : 6
Building zonelist for node : 7
Kernel command line: root=/dev/sda2 console=ttyS0,38400 notsc profile=2 mem=50331648K
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 700.481 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1380.35 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Initializing highpages for node 2
Initializing highpages for node 3
Initializing highpages for node 4
Initializing highpages for node 5
Initializing highpages for node 6
Initializing highpages for node 7
Memory: 48715344k/50331648k available (1802k kernel code, 98996k reserved, 611k data, 296k init, 48365568k highmem)
Debug: sleeping function called from illegal context at mm/slab.c:1617
Call Trace: [<c011e246>]  [<c013d4c6>]  [<c012168b>]  [<c0121531>]  [<c013c21f>] 
 Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Cascades) stepping 00
per-CPU timeslice cutoff: 5854.90 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Mapping cpu 0 to node 0
Remapping cross-quad port I/O for 8 quads
xquad_portio vaddr 0xf8800000, len 00200000
Booting processor 1/2 eip 2000
Storing NMI vector
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU1: Intel Pentium III (Cascades) stepping 00
Booting processor 2/4 eip 2000
Storing NMI vector
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU2: Intel Pentium III (Cascades) stepping 00
Booting processor 3/8 eip 2000
Storing NMI vector
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU3: Intel Pentium III (Cascades) stepping 00
Booting processor 4/17 eip 2000
Storing NMI vector
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU4: Intel Pentium III (Cascades) stepping 00
Booting processor 5/18 eip 2000
Storing NMI vector
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU5: Intel Pentium III (Cascades) stepping 00
Booting processor 6/20 eip 2000
Storing NMI vector
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU6: Intel Pentium III (Cascades) stepping 00
Booting processor 7/24 eip 2000
Storing NMI vector
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU7: Intel Pentium III (Cascades) stepping 00
Booting processor 8/33 eip 2000
Storing NMI vector
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 2
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU8: Intel Pentium III (Cascades) stepping 00
Booting processor 9/34 eip 2000
Storing NMI vector
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 2
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU9: Intel Pentium III (Cascades) stepping 00
Booting processor 10/36 eip 2000
Storing NMI vector
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 2
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU10: Intel Pentium III (Cascades) stepping 00
Booting processor 11/40 eip 2000
Storing NMI vector
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 2
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU11: Intel Pentium III (Cascades) stepping 00
Booting processor 12/49 eip 2000
Storing NMI vector
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 3
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU12: Intel Pentium III (Cascades) stepping 01
Booting processor 13/50 eip 2000
Storing NMI vector
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 3
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU13: Intel Pentium III (Cascades) stepping 00
Booting processor 14/52 eip 2000
Storing NMI vector
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 3
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU14: Intel Pentium III (Cascades) stepping 00
Booting processor 15/56 eip 2000
Storing NMI vector
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 3
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU15: Intel Pentium III (Cascades) stepping 01
Booting processor 16/65 eip 2000
Storing NMI vector
Initializing CPU#16
masked ExtINT on CPU#16
Leaving ESR disabled.
Mapping cpu 16 to node 4
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU16: Intel Pentium III (Cascades) stepping 04
Booting processor 17/66 eip 2000
Storing NMI vector
Initializing CPU#17
masked ExtINT on CPU#17
Leaving ESR disabled.
Mapping cpu 17 to node 4
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU17: Intel Pentium III (Cascades) stepping 04
Booting processor 18/68 eip 2000
Storing NMI vector
Initializing CPU#18
masked ExtINT on CPU#18
Leaving ESR disabled.
Mapping cpu 18 to node 4
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU18: Intel Pentium III (Cascades) stepping 00
Booting processor 19/72 eip 2000
Storing NMI vector
Initializing CPU#19
masked ExtINT on CPU#19
Leaving ESR disabled.
Mapping cpu 19 to node 4
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU19: Intel Pentium III (Cascades) stepping 04
Booting processor 20/81 eip 2000
Storing NMI vector
Initializing CPU#20
masked ExtINT on CPU#20
Leaving ESR disabled.
Mapping cpu 20 to node 5
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU20: Intel Pentium III (Cascades) stepping 01
Booting processor 21/82 eip 2000
Storing NMI vector
Initializing CPU#21
masked ExtINT on CPU#21
Leaving ESR disabled.
Mapping cpu 21 to node 5
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU21: Intel Pentium III (Cascades) stepping 01
Booting processor 22/84 eip 2000
Storing NMI vector
Initializing CPU#22
masked ExtINT on CPU#22
Leaving ESR disabled.
Mapping cpu 22 to node 5
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU22: Intel Pentium III (Cascades) stepping 01
Booting processor 23/88 eip 2000
Storing NMI vector
Initializing CPU#23
masked ExtINT on CPU#23
Leaving ESR disabled.
Mapping cpu 23 to node 5
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU23: Intel Pentium III (Cascades) stepping 01
Booting processor 24/97 eip 2000
Storing NMI vector
Initializing CPU#24
masked ExtINT on CPU#24
Leaving ESR disabled.
Mapping cpu 24 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU24: Intel Pentium III (Cascades) stepping 04
Booting processor 25/98 eip 2000
Storing NMI vector
Initializing CPU#25
masked ExtINT on CPU#25
Leaving ESR disabled.
Mapping cpu 25 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU25: Intel Pentium III (Cascades) stepping 04
Booting processor 26/100 eip 2000
Storing NMI vector
Initializing CPU#26
masked ExtINT on CPU#26
Leaving ESR disabled.
Mapping cpu 26 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU26: Intel Pentium III (Cascades) stepping 04
Booting processor 27/104 eip 2000
Storing NMI vector
Initializing CPU#27
masked ExtINT on CPU#27
Leaving ESR disabled.
Mapping cpu 27 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU27: Intel Pentium III (Cascades) stepping 04
Booting processor 28/113 eip 2000
Storing NMI vector
Initializing CPU#28
masked ExtINT on CPU#28
Leaving ESR disabled.
Mapping cpu 28 to node 7
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU28: Intel Pentium III (Cascades) stepping 00
Booting processor 29/114 eip 2000
Storing NMI vector
Initializing CPU#29
masked ExtINT on CPU#29
Leaving ESR disabled.
Mapping cpu 29 to node 7
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU29: Intel Pentium III (Cascades) stepping 04
Booting processor 30/116 eip 2000
Storing NMI vector
Initializing CPU#30
masked ExtINT on CPU#30
Leaving ESR disabled.
Mapping cpu 30 to node 7
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU30: Intel Pentium III (Cascades) stepping 00
Booting processor 31/120 eip 2000
Storing NMI vector
Initializing CPU#31
masked ExtINT on CPU#31
Leaving ESR disabled.
Mapping cpu 31 to node 7
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU31: Intel Pentium III (Cascades) stepping 00
Total of 32 processors activated (44564.48 BogoMIPS).
ENABLING IO-APIC IRQs
doing setup_ioapic_ids_from_mpc()
Saw IO-APIC 13 physid 13
...changing IO-APIC physical APIC ID to 13 ... ok.
Saw IO-APIC 14 physid 14
...changing IO-APIC physical APIC ID to 14 ... ok.
doing sync_Arb_IDs()
apic_wait_icr_idle().
Synchronizing Arb IDs.
doing setup_IO_APIC_irqs()
init IO_APIC IRQs
 IO-APIC (apicid-pin) 13-0, 14-0, 14-8, 14-18, 14-19, 14-20, 14-21, 14-22, 14-23 not connected.
doing init_IO_APIC_traps()
doing check_timer()
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ... failed.
...trying to set up timer as Virtual Wire IRQ... works.
number of MP IRQ sources: 320.
number of IO-APIC #13 registers: 24.
number of IO-APIC #14 registers: 24.
testing the IO APIC.......................

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    61
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    81
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    91
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    A1
 10 00F 0F  1    1    0   1   0    0    1    A9
 11 00F 0F  1    1    0   1   0    0    1    B1
 12 00F 0F  1    1    0   1   0    0    1    B9
 13 00F 0F  1    1    0   1   0    0    1    C1
 14 00F 0F  1    1    0   1   0    0    1    C9
 15 00F 0F  1    1    0   1   0    0    1    D1
 16 00F 0F  1    1    0   1   0    0    1    D9
 17 00F 0F  1    1    0   1   0    0    1    E1

IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    E9
 02 00F 0F  1    1    0   1   0    0    1    32
 03 00F 0F  1    1    0   1   0    0    1    3A
 04 00F 0F  1    1    0   1   0    0    1    42
 05 00F 0F  1    1    0   1   0    0    1    4A
 06 00F 0F  1    1    0   1   0    0    1    52
 07 00F 0F  1    1    0   1   0    0    1    5A
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    62
 0a 00F 0F  1    1    0   1   0    0    1    6A
 0b 00F 0F  1    1    0   1   0    0    1    72
 0c 00F 0F  1    1    0   1   0    0    1    7A
 0d 00F 0F  1    1    0   1   0    0    1    82
 0e 00F 0F  1    1    0   1   0    0    1    8A
 0f 00F 0F  1    1    0   1   0    0    1    92
 10 00F 0F  1    1    0   1   0    0    1    9A
 11 00F 0F  1    1    0   1   0    0    1    A2
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 1:4
IRQ29 -> 1:5
IRQ30 -> 1:6
IRQ31 -> 1:7
IRQ33 -> 1:9
IRQ34 -> 1:10
IRQ35 -> 1:11
IRQ36 -> 1:12
IRQ37 -> 1:13
IRQ38 -> 1:14
IRQ39 -> 1:15
IRQ40 -> 1:16
IRQ41 -> 1:17
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0944 MHz.
..... host bus clock speed is 99.0991 MHz.
checking TSC synchronization across 32 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 93734 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 93735 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 93735 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 93735 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has 9707 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has 9707 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has 9707 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has 9706 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has -28789 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has -28789 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has -28789 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has -28789 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has 197839 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has 197839 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has 197839 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has 197839 usecs TSC skew! FIXED.
BIOS BUG: CPU#16 improperly initialized, has -116221 usecs TSC skew! FIXED.
BIOS BUG: CPU#17 improperly initialized, has -116221 usecs TSC skew! FIXED.
BIOS BUG: CPU#18 improperly initialized, has -116221 usecs TSC skew! FIXED.
BIOS BUG: CPU#19 improperly initialized, has -116221 usecs TSC skew! FIXED.
BIOS BUG: CPU#20 improperly initialized, has -125047 usecs TSC skew! FIXED.
BIOS BUG: CPU#21 improperly initialized, has -125047 usecs TSC skew! FIXED.
BIOS BUG: CPU#22 improperly initialized, has -125047 usecs TSC skew! FIXED.
BIOS BUG: CPU#23 improperly initialized, has -125047 usecs TSC skew! FIXED.
BIOS BUG: CPU#24 improperly initialized, has -55444 usecs TSC skew! FIXED.
BIOS BUG: CPU#25 improperly initialized, has -55444 usecs TSC skew! FIXED.
BIOS BUG: CPU#26 improperly initialized, has -55444 usecs TSC skew! FIXED.
BIOS BUG: CPU#27 improperly initialized, has -55444 usecs TSC skew! FIXED.
BIOS BUG: CPU#28 improperly initialized, has 24221 usecs TSC skew! FIXED.
BIOS BUG: CPU#29 improperly initialized, has 24221 usecs TSC skew! FIXED.
BIOS BUG: CPU#30 improperly initialized, has 24221 usecs TSC skew! FIXED.
BIOS BUG: CPU#31 improperly initialized, has 24221 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
CPU 4 IS NOW UP!
Starting migration thread for cpu 4
Bringing up 5
CPU 5 IS NOW UP!
Starting migration thread for cpu 5
Bringing up 6
CPU 6 IS NOW UP!
Starting migration thread for cpu 6
Bringing up 7
CPU 7 IS NOW UP!
Starting migration thread for cpu 7
Bringing up 8
CPU 8 IS NOW UP!
Starting migration thread for cpu 8
Bringing up 9
CPU 9 IS NOW UP!
Starting migration thread for cpu 9
Bringing up 10
CPU 10 IS NOW UP!
Starting migration thread for cpu 10
Bringing up 11
CPU 11 IS NOW UP!
Starting migration thread for cpu 11
Bringing up 12
CPU 12 IS NOW UP!
Starting migration thread for cpu 12
Bringing up 13
CPU 13 IS NOW UP!
Starting migration thread for cpu 13
Bringing up 14
CPU 14 IS NOW UP!
Starting migration thread for cpu 14
Bringing up 15
CPU 15 IS NOW UP!
Starting migration thread for cpu 15
Bringing up 16
CPU 16 IS NOW UP!
Starting migration thread for cpu 16
Bringing up 17
CPU 17 IS NOW UP!
Starting migration thread for cpu 17
Bringing up 18
CPU 18 IS NOW UP!
Starting migration thread for cpu 18
Bringing up 19
CPU 19 IS NOW UP!
Starting migration thread for cpu 19
Bringing up 20
CPU 20 IS NOW UP!
Starting migration thread for cpu 20
Bringing up 21
CPU 21 IS NOW UP!
Starting migration thread for cpu 21
Bringing up 22
CPU 22 IS NOW UP!
Starting migration thread for cpu 22
Bringing up 23
CPU 23 IS NOW UP!
Starting migration thread for cpu 23
Bringing up 24
CPU 24 IS NOW UP!
Starting migration thread for cpu 24
Bringing up 25
CPU 25 IS NOW UP!
Starting migration thread for cpu 25
Bringing up 26
CPU 26 IS NOW UP!
Starting migration thread for cpu 26
Bringing up 27
CPU 27 IS NOW UP!
Starting migration thread for cpu 27
Bringing up 28
CPU 28 IS NOW UP!
Starting migration thread for cpu 28
Bringing up 29
CPU 29 IS NOW UP!
Starting migration thread for cpu 29
Bringing up 30
CPU 30 IS NOW UP!
Starting migration thread for cpu 30
Bringing up 31
CPU 31 IS NOW UP!
Starting migration thread for cpu 31
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem driver Revision: 1.00
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 00:10.0
PCI->APIC IRQ transform: (B0,I10,P0) -> 23
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B2,I12,P0) -> 40
PCI->APIC IRQ transform: (B2,I15,P0) -> 28
PCI->APIC IRQ transform: (B2,I15,P1) -> 27
PCI: using PPB(B0,I12,P0) to get irq 15
PCI->APIC IRQ transform: (B1,I4,P0) -> 15
PCI: using PPB(B0,I12,P1) to get irq 13
PCI->APIC IRQ transform: (B1,I5,P1) -> 13
PCI: using PPB(B0,I12,P2) to get irq 11
PCI->APIC IRQ transform: (B1,I6,P2) -> 11
PCI: using PPB(B0,I12,P3) to get irq 7
PCI->APIC IRQ transform: (B1,I7,P3) -> 7
Enabling SEP on CPU 0
Enabling SEP on CPU 1
Enabling SEP on CPU 2
Enabling SEP on CPU 3
Enabling SEP on CPU 20
Enabling SEP on CPU 23
Enabling SEP on CPU 22
Enabling SEP on CPU 21
Enabling SEP on CPU 19
Enabling SEP on CPU 4
Enabling SEP on CPU 5
Enabling SEP on CPU 6
Enabling SEP on CPU 7
Enabling SEP on CPU 15
Enabling SEP on CPU 9
Enabling SEP on CPU 10
Enabling SEP on CPU 11
Enabling SEP on CPU 29
Enabling SEP on CPU 8
Enabling SEP on CPU 13
Enabling SEP on CPU 14
Enabling SEP on CPU 12
Enabling SEP on CPU 17
Enabling SEP on CPU 28
Enabling SEP on CPU 16
Enabling SEP on CPU 18
Enabling SEP on CPU 30
Enabling SEP on CPU 31
Enabling SEP on CPU 26
Enabling SEP on CPU 27
Enabling SEP on CPU 24
Enabling SEP on CPU 25
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 44
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.06
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 (unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.6, March 7, 2002)
eth0: Adaptec Starfire 6915 at 0xf8a53000, 00:00:d1:ed:d0:85, IRQ 15.
eth0: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth0: scatter-gather and hardware TCP cksumming disabled.
eth1: Adaptec Starfire 6915 at 0xf8ad4000, 00:00:d1:ed:d0:86, IRQ 13.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth1: scatter-gather and hardware TCP cksumming disabled.
eth2: Adaptec Starfire 6915 at 0xf8b55000, 00:00:d1:ed:d0:87, IRQ 11.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: scatter-gather and hardware TCP cksumming disabled.
eth3: Adaptec Starfire 6915 at 0xf8bd6000, 00:00:d1:ed:d0:88, IRQ 7.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: scatter-gather and hardware TCP cksumming disabled.
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
  tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
eth4: Digital DS21140 Tulip rev 33 at 0xf8c57000, 00:00:BC:0F:07:CF, IRQ 40.
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace: [<c02262d2>]  [<c025928e>]  [<c024fc41>]  [<c024f811>]  [<c0246658>]  [<c02262f9>]  [<c010528b>]  [<c0105210>]  [<c0107519>] 
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 58 irq 19 MEM base 0xf8c59000
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: PLEXTOR   Model: CD-R   PX-R412C   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TANDBERG  Model:  TDC 3800         Rev: -08:
  Type:   Sequential-Access                  ANSI SCSI revision: 01
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 8, lun 0
SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdd: drive cache: write through
 sdd: sdd1
Attached scsi disk sdd at scsi0, channel 0, id 9, lun 0
SCSI device sde: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sde: drive cache: write through
 sde: sde1
Attached scsi disk sde at scsi0, channel 0, id 10, lun 0
input: PC Speaker
oprofile: using NMI interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 262144 buckets, 4096Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 296k freed
INIT: version 2.84 booting
Activating swap.
Checking root file system...
fsck 1.27 (8-Mar-2002)
/dev/sda2: clean, 82195/513024 files, 489571/1024143 blocks
System time was Wed Jan 15 08:39:45 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Wed Jan 15 08:39:50 UTC 2003.
Calculating module dependencies... depmod: QM_MODULES: Function not implemented

done.
Loading modules: pcnet32 modprobe: Can't open dependencies file /lib/modules/2.5.58/modules.dep (No such file or directory)

modprobe: Can't open dependencies file /lib/modules/2.5.58/modules.dep (No such file or directory)
Checking all file systems...
fsck 1.27 (8-Mar-2002)
/dev/sdb1: clean, 327988/1121664 files, 1636482/2239051 blocks
/dev/sdb2: clean, 117/1121664 files, 45322/2241067 blocks
DAVE: clean, 44647/2240224 files, 311168/4480119 blocks
/dev/sde1: clean, 4037/2240224 files, 105889/4480119 blocks
Setting kernel variables.
Mounting local filesystems...
mount: fs type ext3 not supported by kernel
mount: fs type ext3 not supported by kernel
mount: fs type ext3 not supported by kernel
/dev/sde1 on /test type ext2 (rw,errors=remount-ro)
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Loading the saved-state of the serial devices... 
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
/dev/ttyS1 at 0x02f8 (irq = 3) is a 16550A

Setting the System Clock using the Hardware Clock as reference...
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
System Clock set. Local time: Wed Jan 15 00:39:54 PST 2003

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting NFS common utilities: statd lockd.
Starting internet superserver: inetd.
Starting printer spooler: lpd.
Starting network benchmark server: netserver.
Not starting NFS kernel daemon: No exports.
Starting OpenBSD Secure Shell server: sshd.
Starting periodic command scheduler: cron.

Debian GNU/Linux testing/unstable curly ttyS0

curly login: root
Password: 
Last login: Mon Jan 13 16:45:41 2003 from dyn9-47-17-248.beaverton.ibm.com on pts/2
Linux curly 2.5.58 #19 SMP Wed Jan 15 00:28:32 PST 2003 i686 unknown unknown GNU/Linux
curly:~# mkdir /home/wli
curly:~# cat /proc/mounts             etc/[Kfdisk -l /dev/sdb

Disk /dev/sdb: 18.3 GB, 18351959040 bytes
255 heads, 63 sectors/track, 2231 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1             1      1115   8956206   83  Linux
/dev/sdb2          1116      2231   8964270   83  Linux
curly:~# mount /dev/sdb1
mount: fs type ext3 not supported by kernel
curly:~# set -o vi
curly:~# mount /dev/sdb1 -t ext2curly:~# mount /dev/sdb1 -/-t ext2h-t ext2o-t ext2m-t ext2e-t ext2 -t ext2
EXT2-fs warning (device sd(8,17)): ext2_fill_super: mounting ext3 filesystem as ext2

curly:~#
[detached]
$
Script done on Wed Jan 15 00:40:57 2003
