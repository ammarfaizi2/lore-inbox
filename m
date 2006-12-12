Return-Path: <linux-kernel-owner+w=401wt.eu-S1751125AbWLLEHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWLLEHW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 23:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWLLEHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 23:07:22 -0500
Received: from tapsys.com ([72.36.178.242]:34164 "EHLO tapsys.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbWLLEHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 23:07:19 -0500
Message-ID: <457E2AE2.1020108@madrabbit.org>
Date: Mon, 11 Dec 2006 20:06:58 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Michael Buesch <mb@bu3sch.de>, Bcm43xx-dev@lists.berlios.de
Subject: ieee80211 sleeping in invalid context
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org> <455F58AC.3030801@lwfinger.net>
In-Reply-To: <455F58AC.3030801@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all, more data on my bcm43xx problem report from a few weeks back.

By random chance I acquired a brain, and decided to rebuild my latest kernel
pull with as many debugging options on as I could stand. Got the below, plus
a dead keyboard (except for Magic SysRq) (but only if I let userspace come up
fully -- booting with init=/bin/bash is fine). Since the trace below mentions
scans, I'm hoping it's related to my problem.

In other news, now that I've moved my laptop back to my home office, I'm able
to recreate the dead-keyboard lockups I've been having again, about once every
day or two. What fun. So if there are patches I should try ontop of the latest
git, let me know. (Though I'm hoping the below will be a smoking gun to someone
who has a clue, i.e., not me.)

Ray

Dec 11 19:34:18 phoenix syslogd 1.4.1#18ubuntu6: restart.
Dec 11 19:34:18 phoenix kernel: Inspecting /boot/System.map-2.6.19
Dec 11 19:34:19 phoenix kernel: Loaded 26330 symbols from /boot/System.map-2.6.19.
Dec 11 19:34:19 phoenix kernel: Symbols match kernel version 2.6.19.
Dec 11 19:34:19 phoenix kernel: No module symbols loaded - kernel modules not enabled.
Dec 11 19:34:19 phoenix kernel: [    0.000000] Linux version 2.6.19 (ray@phoenix) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #1 PREEMPT Mon Dec 11 12:52:41 PST 2006
Dec 11 19:34:19 phoenix kernel: [    0.000000] Command line: root=UUID=bf7dc35f-5eff-4a85-b398-590f37c5679e ro noapic
Dec 11 19:34:19 phoenix kernel: [    0.000000] BIOS-provided physical RAM map:
Dec 11 19:34:19 phoenix kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 11 19:34:19 phoenix kernel: [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 11 19:34:19 phoenix kernel: [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Dec 11 19:34:20 phoenix kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 0000000037fd0000 (usable)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 0000000037fd0000 - 0000000037fefc00 (reserved)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 0000000037fefc00 - 0000000037ffb000 (ACPI NVS)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 0000000037ffb000 - 0000000040000000 (reserved)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
Dec 11 19:34:21 phoenix kernel: [    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Dec 11 19:34:21 phoenix kernel: [    0.000000] end_pfn_map = 1048576
Dec 11 19:34:21 phoenix kernel: [    0.000000] DMI 2.3 present.
Dec 11 19:34:23 phoenix kernel: [    0.000000] No mptable found.
Dec 11 19:34:23 phoenix kernel: [    0.000000] Zone PFN ranges:
Dec 11 19:34:23 phoenix kernel: [    0.000000]   DMA             0 ->     4096
Dec 11 19:34:23 phoenix kernel: [    0.000000]   DMA32        4096 ->  1048576
Dec 11 19:34:24 phoenix kernel: [    0.000000]   Normal    1048576 ->  1048576
Dec 11 19:34:24 phoenix kernel: [    0.000000] early_node_map[2] active PFN ranges
Dec 11 19:34:24 phoenix kernel: [    0.000000]     0:        0 ->      159
Dec 11 19:34:24 phoenix kernel: [    0.000000]     0:      256 ->   229328
Dec 11 19:34:24 phoenix hpiod: 1.6.9 accepting connections at 2208...
Dec 11 19:34:25 phoenix kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x8008
Dec 11 19:34:25 phoenix kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Dec 11 19:34:25 phoenix kernel: [    0.000000] Processor #0 (Bootup-CPU)
Dec 11 19:34:25 phoenix kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Dec 11 19:34:25 phoenix kernel: [    0.000000] ACPI: Skipping IOAPIC probe due to 'noapic' option.
Dec 11 19:34:25 phoenix kernel: [    0.000000] arch/x86_64/mm/init.c:145: bad pte ffff810001c58fe8(80000000fec01173).
Dec 11 19:34:25 phoenix kernel: [    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
Dec 11 19:34:25 phoenix kernel: [    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
Dec 11 19:34:25 phoenix kernel: [    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
Dec 11 19:34:25 phoenix kernel: [    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Dec 11 19:34:25 phoenix kernel: [    0.000000] Built 1 zonelists.  Total pages: 223940
Dec 11 19:34:25 phoenix kernel: [    0.000000] Kernel command line: root=UUID=bf7dc35f-5eff-4a85-b398-590f37c5679e ro noapic
Dec 11 19:34:25 phoenix kernel: [    0.000000] Initializing CPU#0
Dec 11 19:34:25 phoenix kernel: [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
Dec 11 19:34:25 phoenix kernel: [   13.705535] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
Dec 11 19:34:25 phoenix kernel: [   13.705537] time.c: Detected 2194.592 MHz processor.
Dec 11 19:34:25 phoenix kernel: [   13.711138] Console: colour VGA+ 80x25
Dec 11 19:34:25 phoenix kernel: [   13.713451] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
Dec 11 19:34:25 phoenix kernel: [   13.713539] ... MAX_LOCKDEP_SUBCLASSES:    8
Dec 11 19:34:25 phoenix kernel: [   13.713597] ... MAX_LOCK_DEPTH:          30
Dec 11 19:34:25 phoenix kernel: [   13.713655] ... MAX_LOCKDEP_KEYS:        2048
Dec 11 19:34:25 phoenix kernel: [   13.713713] ... CLASSHASH_SIZE:           1024
Dec 11 19:34:25 phoenix kernel: [   13.713771] ... MAX_LOCKDEP_ENTRIES:     8192
Dec 11 19:34:25 phoenix kernel: [   13.713828] ... MAX_LOCKDEP_CHAINS:      16384
Dec 11 19:34:25 phoenix kernel: [   13.713886] ... CHAINHASH_SIZE:          8192
Dec 11 19:34:26 phoenix kernel: [   13.713944]  memory used by lock dependency info: 1584 kB
Dec 11 19:34:26 phoenix kernel: [   13.714003]  per task-struct memory footprint: 1680 bytes
Dec 11 19:34:26 phoenix kernel: [   13.715083] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Dec 11 19:34:26 phoenix kernel: [   13.715971] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Dec 11 19:34:26 phoenix kernel: [   13.716128] Checking aperture...
Dec 11 19:34:26 phoenix kernel: [   13.716187] CPU 0: aperture @ e04a000000 size 32 MB
Dec 11 19:34:26 phoenix kernel: [   13.716246] Aperture too small (32 MB)
Dec 11 19:34:26 phoenix kernel: [   13.728439] No AGP bridge found
Dec 11 19:34:26 phoenix kernel: [   13.743894] Memory: 875716k/917312k available (2352k kernel code, 40852k reserved, 1749k data, 200k init)
Dec 11 19:34:26 phoenix kernel: [   13.803377] Calibrating delay using timer specific routine.. 4392.18 BogoMIPS (lpj=2196094)
Dec 11 19:34:26 phoenix kernel: [   13.803975] Security Framework v1.0.0 initialized
Dec 11 19:34:26 phoenix kernel: [   13.804041] SELinux:  Disabled at boot.
Dec 11 19:34:26 phoenix kernel: [   13.804231] Mount-cache hash table entries: 256
Dec 11 19:34:26 phoenix kernel: [   13.807735] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Dec 11 19:34:26 phoenix kernel: [   13.807796] CPU: L2 Cache: 1024K (64 bytes/line)
Dec 11 19:34:26 phoenix kernel: [   13.807866] CPU: AMD Turion(tm) 64 Mobile ML-40                  stepping 02
Dec 11 19:34:26 phoenix kernel: [   13.808007] ACPI: Core revision 20060707
Dec 11 19:34:26 phoenix kernel: [   13.808609]  tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Dec 11 19:34:26 phoenix kernel: [   13.815260] Parsing all Control Methods:
Dec 11 19:34:26 phoenix kernel: [   13.815533] Table [DSDT](id 0006) - 953 Objects with 106 Devices 297 Methods 26 Regions
Dec 11 19:34:26 phoenix kernel: [   13.815739] Parsing all Control Methods:
Dec 11 19:34:26 phoenix kernel: [   13.815962] Table [SSDT](id 0004) - 8 Objects with 0 Devices 6 Methods 0 Regions
Dec 11 19:34:26 phoenix kernel: [   13.816096] ACPI Namespace successfully loaded at root ffffffff80a52500
Dec 11 19:34:26 phoenix kernel: [   13.816161] ACPI: setting ELCR to 0200 (from 0e20)
Dec 11 19:34:26 phoenix kernel: [   13.849445] evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
Dec 11 19:34:26 phoenix kernel: [   13.864288] Using local APIC timer interrupts.
Dec 11 19:34:26 phoenix kernel: [   13.909867] result 0
Dec 11 19:34:26 phoenix kernel: [   13.909924] Detected 0.000 MHz APIC timer.
Dec 11 19:34:26 phoenix kernel: [   13.910236] testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!
Dec 11 19:34:26 phoenix kernel: [   13.935758] checking if image is initramfs... it is
Dec 11 19:34:26 phoenix kernel: [   15.418743] Freeing initrd memory: 17762k freed
Dec 11 19:34:26 phoenix kernel: [   15.465890] NET: Registered protocol family 16
Dec 11 19:34:26 phoenix kernel: [   15.492746] ACPI: bus type pci registered
Dec 11 19:34:26 phoenix kernel: [   15.503568] PCI: Using MMCONFIG at e0000000
Dec 11 19:34:26 phoenix kernel: [   15.504265] PCI: No mmconfig possible on device 00:18
Dec 11 19:34:26 phoenix kernel: [   15.517096] evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
Dec 11 19:34:26 phoenix kernel: [   15.517699] evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 4 Wake, Enabled 9 Runtime GPEs in this block
Dec 11 19:34:27 phoenix kernel: [   15.519686] Completing Region/Field/Buffer/Package
initialization:............................................................................................................
Dec 11 19:34:27 phoenix kernel: [   15.526864] Initialized 25/26 Regions 0/0 Fields 30/30 Buffers 53/61 Packages (970 nodes)
Dec 11 19:34:27 phoenix kernel: [   15.526996] Initializing Device/Processor/Thermal objects by executing _INI methods:......
Dec 11 19:34:27 phoenix kernel: [   15.547491] Executed 6 _INI methods requiring 2 _STA executions (examined 113 objects)
Dec 11 19:34:27 phoenix kernel: [   15.547644] ACPI: Interpreter enabled
Dec 11 19:34:27 phoenix kernel: [   15.547704] ACPI: Using PIC for interrupt routing
Dec 11 19:34:27 phoenix kernel: [   15.556017] ACPI: PCI Root Bridge [C047] (0000:00)
Dec 11 19:34:27 phoenix kernel: [   15.560815] ACPI: Assume root bridge [\_SB_.C047] bus is 0
Dec 11 19:34:27 phoenix kernel: [   15.578179] PCI: Transparent bridge - 0000:00:14.4
Dec 11 19:34:27 phoenix kernel: [   15.578335] PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
Dec 11 19:34:27 phoenix kernel: [   15.578417] Please report the result to linux-kernel to fix this permanently
Dec 11 19:34:28 phoenix dhcdbd: Started up.
Dec 11 19:34:29 phoenix kernel: [   15.616016] ACPI: Power Resource [C1D3] (off)
Dec 11 19:34:29 phoenix kernel: [   15.634482] ACPI: Power Resource [C1BB] (on)
Dec 11 19:34:29 phoenix kernel: [   15.635496] ACPI: Power Resource [C1CB] (on)
Dec 11 19:34:29 phoenix kernel: [   15.641079] ACPI: PCI Interrupt Link [C0F0] (IRQs *10 11)
Dec 11 19:34:29 phoenix kernel: [   15.642080] ACPI: PCI Interrupt Link [C0F1] (IRQs 10 11) *5
Dec 11 19:34:29 phoenix kernel: [   15.643069] ACPI: PCI Interrupt Link [C0F2] (IRQs 10 11) *0, disabled.
Dec 11 19:34:29 phoenix kernel: [   15.644131] ACPI: PCI Interrupt Link [C0F3] (IRQs *10 11)
Dec 11 19:34:29 phoenix kernel: [   15.645093] ACPI: PCI Interrupt Link [C0F4] (IRQs 10 *11)
Dec 11 19:34:29 phoenix kernel: [   15.646066] ACPI: PCI Interrupt Link [C0F5] (IRQs *9)
Dec 11 19:34:29 phoenix kernel: [   15.646988] ACPI: PCI Interrupt Link [C0F6] (IRQs 10 11) *5
Dec 11 19:34:29 phoenix kernel: [   15.647989] ACPI: PCI Interrupt Link [C0F7] (IRQs *10 11)
Dec 11 19:34:29 phoenix kernel: [   15.652776] ACPI: Power Resource [C251] (off)
Dec 11 19:34:29 phoenix kernel: [   15.653084] ACPI: Power Resource [C252] (off)
Dec 11 19:34:29 phoenix kernel: [   15.653391] ACPI: Power Resource [C253] (off)
Dec 11 19:34:29 phoenix kernel: [   15.653729] ACPI: Power Resource [C254] (off)
Dec 11 19:34:29 phoenix kernel: [   15.654372] Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 11 19:34:29 phoenix kernel: [   15.654455] pnp: PnP ACPI init
Dec 11 19:34:29 phoenix flow-capture[4835]: chdir(/var/flow/myrouter): No such file or directory
Dec 11 19:34:29 phoenix flow-capture[4837]: chdir(/var/flow/mysecondrouter): No such file or directory
Dec 11 19:34:29 phoenix flow-capture[4839]: chdir(/var/flow/mysecondrouter): No such file or directory
Dec 11 19:34:31 phoenix kernel: [   15.674799] pnp: PnP ACPI: found 12 devices
Dec 11 19:34:31 phoenix kernel: [   15.677467] SCSI subsystem initialized
Dec 11 19:34:31 phoenix kernel: [   15.681729] PCI: Using ACPI for IRQ routing
Dec 11 19:34:31 phoenix kernel: [   15.681788] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Dec 11 19:34:32 phoenix kernel: [   15.700020] pnp: 00:09: ioport range 0x40b-0x40b has been reserved
Dec 11 19:34:32 phoenix kernel: [   15.700084] pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
Dec 11 19:34:32 phoenix kernel: [   15.700144] pnp: 00:09: ioport range 0x4d6-0x4d6 has been reserved
Dec 11 19:34:32 phoenix kernel: [   15.700211] pnp: 00:0a: ioport range 0x8000-0x802f could not be reserved
Dec 11 19:34:32 phoenix kernel: [   15.700272] pnp: 00:0a: ioport range 0x8100-0x811f could not be reserved
Dec 11 19:34:33 phoenix kernel: [   15.702637] PCI: Bridge: 0000:00:01.0
Dec 11 19:34:33 phoenix kernel: [   15.702697]   IO window: 3000-3fff
Dec 11 19:34:33 phoenix kernel: [   15.702756]   MEM window: d0600000-d09fffff
Dec 11 19:34:33 phoenix kernel: [   15.702816]   PREFETCH window: c0000000-cfffffff
Dec 11 19:34:33 phoenix kernel: [   15.702875] PCI: Bridge: 0000:00:04.0
Dec 11 19:34:33 phoenix kernel: [   15.702933]   IO window: disabled.
Dec 11 19:34:33 phoenix kernel: [   15.702991]   MEM window: disabled.
Dec 11 19:34:33 phoenix kernel: [   15.703049]   PREFETCH window: disabled.
Dec 11 19:34:33 phoenix kernel: [   15.703107] PCI: Bridge: 0000:00:05.0
Dec 11 19:34:33 phoenix kernel: [   15.703165]   IO window: disabled.
Dec 11 19:34:33 phoenix kernel: [   15.703222]   MEM window: disabled.
Dec 11 19:34:33 phoenix kernel: [   15.703280]   PREFETCH window: disabled.
Dec 11 19:34:33 phoenix kernel: [   15.703343] PCI: Bus 3, cardbus bridge: 0000:02:04.0
Dec 11 19:34:33 phoenix kernel: [   15.703402]   IO window: 00002000-000020ff
Dec 11 19:34:33 phoenix kernel: [   15.703460]   IO window: 00002400-000024ff
Dec 11 19:34:33 phoenix kernel: [   15.703519]   PREFETCH window: 50000000-51ffffff
Dec 11 19:34:33 phoenix kernel: [   15.703596]   MEM window: 52000000-53ffffff
Dec 11 19:34:33 phoenix kernel: [   15.703655] PCI: Bridge: 0000:00:14.4
Dec 11 19:34:33 phoenix kernel: [   15.703715]   IO window: 2000-2fff
Dec 11 19:34:33 phoenix kernel: [   15.703773]   MEM window: d0000000-d05fffff
Dec 11 19:34:33 phoenix kernel: [   15.703832]   PREFETCH window: 50000000-51ffffff
Dec 11 19:34:33 phoenix kernel: [   15.705872] ACPI: PCI Interrupt Link [C0F4] enabled at IRQ 11
Dec 11 19:34:34 phoenix kernel: [   15.705940] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0F4] -> GSI 11 (level, low) -> IRQ 11
Dec 11 19:34:34 phoenix kernel: [   15.706136] NET: Registered protocol family 2
Dec 11 19:34:34 phoenix kernel: [   15.726869] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
Dec 11 19:34:34 phoenix kernel: [   15.734280] TCP established hash table entries: 32768 (order: 9, 2359296 bytes)
Dec 11 19:34:34 phoenix kernel: [   15.737493] TCP bind hash table entries: 16384 (order: 8, 1310720 bytes)
Dec 11 19:34:34 phoenix kernel: [   15.739563] TCP: Hash tables configured (established 32768 bind 16384)
Dec 11 19:34:34 phoenix kernel: [   15.741473] TCP reno registered
Dec 11 19:34:34 phoenix kernel: [   15.757199] audit: initializing netlink socket (disabled)
Dec 11 19:34:34 phoenix kernel: [   15.758441] audit(1165865627.922:1): initialized
Dec 11 19:34:34 phoenix kernel: [   15.788398] VFS: Disk quotas dquot_6.5.1
Dec 11 19:34:34 phoenix kernel: [   15.788493] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Dec 11 19:34:34 phoenix kernel: [   15.821812] io scheduler noop registered
Dec 11 19:34:34 phoenix kernel: [   15.821908] io scheduler anticipatory registered
Dec 11 19:34:34 phoenix kernel: [   15.822002] io scheduler deadline registered
Dec 11 19:34:34 phoenix kernel: [   15.822110] io scheduler cfq registered (default)
Dec 11 19:34:34 phoenix kernel: [   15.823056] pcie_portdrv_probe->Dev[5a36:1002] has invalid IRQ. Check vendor BIOS
Dec 11 19:34:34 phoenix kernel: [   15.823156] assign_interrupt_mode Found MSI capability
Dec 11 19:34:34 phoenix kernel: [   15.824702] pcie_portdrv_probe->Dev[5a37:1002] has invalid IRQ. Check vendor BIOS
Dec 11 19:34:34 phoenix kernel: [   15.824801] assign_interrupt_mode Found MSI capability
Dec 11 19:34:34 phoenix kernel: [   15.825216] aer: probe of 0000:00:04.0:pcie01 failed with error 2
Dec 11 19:34:35 phoenix kernel: [   15.825315] aer: probe of 0000:00:05.0:pcie01 failed with error 2
Dec 11 19:34:43 phoenix kernel: [   15.871372] Real Time Clock Driver v1.12ac
Dec 11 19:34:43 phoenix kernel: [   15.871520] Linux agpgart interface v0.101 (c) Dave Jones
Dec 11 19:34:43 phoenix kernel: [   15.871579] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Dec 11 19:34:43 phoenix kernel: [   15.894952] ACPI: PCI Interrupt Link [C0F1] enabled at IRQ 10
Dec 11 19:34:43 phoenix kernel: [   15.895024] ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:43 phoenix kernel: [   15.895183] ACPI: PCI interrupt for device 0000:00:14.6 disabled
Dec 11 19:34:43 phoenix kernel: [   15.898084] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Dec 11 19:34:43 phoenix kernel: [   15.923187] ACPI: PCI Interrupt Link [C0F0] enabled at IRQ 10
Dec 11 19:34:43 phoenix kernel: [   15.923264] ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [C0F0] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:43 phoenix kernel: [   15.927095] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x4010 irq 14
Dec 11 19:34:43 phoenix kernel: [   15.927202] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4018 irq 15
Dec 11 19:34:43 phoenix kernel: [   15.927291] scsi0 : pata_atiixp
Dec 11 19:34:43 phoenix kernel: [   16.082954] ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48
Dec 11 19:34:43 phoenix kernel: [   16.083025] ata1.00: ata1: dev 0 multi count 16
Dec 11 19:34:43 phoenix kernel: [   16.088495] ata1.00: configured for UDMA/100
Dec 11 19:34:43 phoenix kernel: [   16.088560] scsi1 : pata_atiixp
Dec 11 19:34:43 phoenix kernel: [   16.393148] ata2.00: ATAPI, max MWDMA2
Dec 11 19:34:43 phoenix kernel: [   16.547931] ata2.00: configured for MWDMA2
Dec 11 19:34:43 phoenix kernel: [   16.569703] scsi 0:0:0:0: Direct-Access     ATA      ST9808211A       3.02 PQ: 0 ANSI: 5
Dec 11 19:34:43 phoenix kernel: [   16.587951] scsi 1:0:0:0: CD-ROM            MATSHITA UJ-840D          1.02 PQ: 0 ANSI: 5
Dec 11 19:34:43 phoenix kernel: [   16.588314] PNP: PS/2 Controller [PNP0303:C1C8,PNP0f13:C1C9] at 0x60,0x64 irq 1,12
Dec 11 19:34:43 phoenix kernel: [   16.595027] i8042.c: Detected active multiplexing controller, rev 1.1.
Dec 11 19:34:43 phoenix kernel: [   16.595855] serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 11 19:34:43 phoenix kernel: [   16.613453] serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 11 19:34:43 phoenix kernel: [   16.613514] serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 11 19:34:43 phoenix kernel: [   16.613574] serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 11 19:34:43 phoenix kernel: [   16.613635] serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 11 19:34:43 phoenix kernel: [   16.615107] mice: PS/2 mouse device common for all mice
Dec 11 19:34:43 phoenix kernel: [   16.621147] TCP cubic registered
Dec 11 19:34:43 phoenix kernel: [   16.621225] NET: Registered protocol family 1
Dec 11 19:34:43 phoenix kernel: [   16.621290] NET: Registered protocol family 8
Dec 11 19:34:43 phoenix kernel: [   16.621348] NET: Registered protocol family 20
Dec 11 19:34:43 phoenix kernel: [   16.623192] IO APIC resources could be not be allocated.
Dec 11 19:34:43 phoenix kernel: [   16.647119] ACPI: (supports S0 S3 S4 S5)
Dec 11 19:34:43 phoenix kernel: [   16.647435] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Dec 11 19:34:43 phoenix kernel: [   16.647538] Freeing unused kernel memory: 200k freed
Dec 11 19:34:44 phoenix kernel: [   16.793068] input: AT Translated Set 2 keyboard as /class/input/input0
Dec 11 19:34:44 phoenix kernel: [   16.842305] ACPI: Transitioning device [C255] to D3
Dec 11 19:34:44 phoenix kernel: [   16.842371] ACPI: Transitioning device [C255] to D3
Dec 11 19:34:44 phoenix kernel: [   16.842432] ACPI: Fan [C255] (off)
Dec 11 19:34:44 phoenix kernel: [   16.842669] ACPI: Transitioning device [C256] to D3
Dec 11 19:34:44 phoenix kernel: [   16.842728] ACPI: Transitioning device [C256] to D3
Dec 11 19:34:44 phoenix kernel: [   16.842788] ACPI: Fan [C256] (off)
Dec 11 19:34:44 phoenix kernel: [   16.843039] ACPI: Transitioning device [C257] to D3
Dec 11 19:34:44 phoenix kernel: [   16.843098] ACPI: Transitioning device [C257] to D3
Dec 11 19:34:44 phoenix kernel: [   16.843158] ACPI: Fan [C257] (off)
Dec 11 19:34:44 phoenix kernel: [   16.843392] ACPI: Transitioning device [C258] to D3
Dec 11 19:34:44 phoenix kernel: [   16.843451] ACPI: Transitioning device [C258] to D3
Dec 11 19:34:44 phoenix kernel: [   16.843512] ACPI: Fan [C258] (off)
Dec 11 19:34:44 phoenix kernel: [   16.853651] ACPI: CPU0 (power states: C1[C1] C3[C3])
Dec 11 19:34:44 phoenix kernel: [   16.853826] ACPI: Processor [C000] (supports 8 throttling states)
Dec 11 19:34:44 phoenix kernel: [   16.872777] ACPI: Thermal Zone [TZ1] (63 C)
Dec 11 19:34:44 phoenix kernel: [   16.879674] ACPI: Thermal Zone [TZ2] (50 C)
Dec 11 19:34:44 phoenix kernel: [   16.888955] ACPI: Thermal Zone [TZ3] (32 C)
Dec 11 19:34:44 phoenix kernel: [   16.892594] ACPI: Thermal Zone [TZ4] (36 C)
Dec 11 19:34:44 phoenix kernel: [   17.581262] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Dec 11 19:34:44 phoenix kernel: [   17.581345] sda: Write Protect is off
Dec 11 19:34:44 phoenix kernel: [   17.581430] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 11 19:34:44 phoenix kernel: [   17.599290] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Dec 11 19:34:44 phoenix kernel: [   17.599366] sda: Write Protect is off
Dec 11 19:34:44 phoenix kernel: [   17.599449] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 11 19:34:44 phoenix kernel: [   17.601968]  sda: sda1 sda2 sda3 < sda5 >
Dec 11 19:34:44 phoenix kernel: [   17.715966] sd 0:0:0:0: Attached scsi disk sda
Dec 11 19:34:44 phoenix kernel: [   18.075866] Attempting manual resume
Dec 11 19:34:44 phoenix kernel: [   18.094894] usbcore: registered new interface driver usbfs
Dec 11 19:34:44 phoenix kernel: [   18.099177] usbcore: registered new interface driver hub
Dec 11 19:34:44 phoenix kernel: [   18.100772] usbcore: registered new device driver usb
Dec 11 19:34:44 phoenix kernel: [   18.103152] ACPI: PCI Interrupt Link [C0F3] enabled at IRQ 10
Dec 11 19:34:44 phoenix kernel: [   18.103216] ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:44 phoenix kernel: [   18.103385] ohci_hcd 0000:00:13.0: OHCI Host Controller
Dec 11 19:34:44 phoenix kernel: [   18.146488] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
Dec 11 19:34:44 phoenix kernel: [   18.146594] ohci_hcd 0000:00:13.0: irq 10, io mem 0xd0a00000
Dec 11 19:34:44 phoenix kernel: [   18.227984] usb usb1: configuration #1 chosen from 1 choice
Dec 11 19:34:44 phoenix kernel: [   18.231927] hub 1-0:1.0: USB hub found
Dec 11 19:34:44 phoenix kernel: [   18.232653] hub 1-0:1.0: 4 ports detected
Dec 11 19:34:44 phoenix kernel: [   18.233401] ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:44 phoenix kernel: [   18.233572] ohci_hcd 0000:00:13.1: OHCI Host Controller
Dec 11 19:34:44 phoenix kernel: [   18.233679] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
Dec 11 19:34:44 phoenix kernel: [   18.233776] ohci_hcd 0000:00:13.1: irq 10, io mem 0xd0a01000
Dec 11 19:34:44 phoenix kernel: [   18.292860] usb usb2: configuration #1 chosen from 1 choice
Dec 11 19:34:44 phoenix kernel: [   18.292975] hub 2-0:1.0: USB hub found
Dec 11 19:34:44 phoenix kernel: [   18.293048] hub 2-0:1.0: 4 ports detected
Dec 11 19:34:44 phoenix kernel: [   18.293517] ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:44 phoenix kernel: [   18.293689] ehci_hcd 0000:00:13.2: EHCI Host Controller
Dec 11 19:34:44 phoenix kernel: [   18.294109] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
Dec 11 19:34:44 phoenix kernel: [   18.294254] ehci_hcd 0000:00:13.2: irq 10, io mem 0xd0a02000
Dec 11 19:34:44 phoenix kernel: [   18.294322] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Dec 11 19:34:44 phoenix kernel: [   18.297111] usb usb3: configuration #1 chosen from 1 choice
Dec 11 19:34:44 phoenix kernel: [   18.297209] hub 3-0:1.0: USB hub found
Dec 11 19:34:44 phoenix kernel: [   18.297278] hub 3-0:1.0: 8 ports detected
Dec 11 19:34:44 phoenix kernel: [   18.302946] ACPI: PCI Interrupt Link [C0F5] enabled at IRQ 9
Dec 11 19:34:44 phoenix kernel: [   18.303018] ACPI: PCI Interrupt 0000:02:04.2[C] -> Link [C0F5] -> GSI 9 (level, low) -> IRQ 9
Dec 11 19:34:44 phoenix kernel: [   18.406203] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[d0013000-d00137ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Dec 11 19:34:44 phoenix kernel: [   18.441953] kjournald starting.  Commit interval 5 seconds
Dec 11 19:34:44 phoenix kernel: [   18.452886] EXT3-fs: mounted filesystem with writeback data mode.
Dec 11 19:34:44 phoenix kernel: [   19.143568] usb 2-1: new full speed USB device using ohci_hcd and address 2
Dec 11 19:34:44 phoenix kernel: [   19.329404] usb 2-1: configuration #1 chosen from 1 choice
Dec 11 19:34:44 phoenix kernel: [   19.591799] usb 1-2: new full speed USB device using ohci_hcd and address 2
Dec 11 19:34:44 phoenix kernel: [   19.778061] usb 1-2: configuration #1 chosen from 1 choice
Dec 11 19:34:45 phoenix kernel: [   34.149057] tg3.c:v3.70 (December 1, 2006)
Dec 11 19:34:45 phoenix kernel: [   34.151188] ACPI: PCI Interrupt Link [C0F7] enabled at IRQ 10
Dec 11 19:34:45 phoenix kernel: [   34.151262] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0F7] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:45 phoenix kernel: [   34.201471] eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:0f:b0:bb:bc:f8
Dec 11 19:34:45 phoenix kernel: [   34.201775] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1]
Dec 11 19:34:45 phoenix kernel: [   34.201855] eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
Dec 11 19:34:45 phoenix kernel: [   34.311449] ieee80211: 802.11 data/management/control stack, git-1.1.13
Dec 11 19:34:45 phoenix kernel: [   34.311515] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
Dec 11 19:34:45 phoenix kernel: [   34.798739] Yenta: CardBus bridge found at 0000:02:04.0 [103c:308b]
Dec 11 19:34:45 phoenix kernel: [   34.798821] Yenta: Enabling burst memory read transactions
Dec 11 19:34:45 phoenix kernel: [   34.798883] Yenta: Using INTVAL to route CSC interrupts to PCI
Dec 11 19:34:45 phoenix kernel: [   34.798942] Yenta: Routing CardBus interrupts to PCI
Dec 11 19:34:45 phoenix kernel: [   34.799005] Yenta TI: socket 0000:02:04.0, mfunc 0x01a11b22, devctl 0x64
Dec 11 19:34:45 phoenix kernel: [   34.856577] input: PC Speaker as /class/input/input1
Dec 11 19:34:45 phoenix kernel: [   34.919822] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Dec 11 19:34:45 phoenix kernel: [   35.000682] sdhci: Secure Digital Host Controller Interface driver, 0.12
Dec 11 19:34:45 phoenix kernel: [   35.000750] sdhci: Copyright(c) Pierre Ossman
Dec 11 19:34:45 phoenix kernel: [   35.024581] Yenta: ISA IRQ mask 0x00f8, PCI irq 11
Dec 11 19:34:45 phoenix kernel: [   35.024650] Socket status: 30000006
Dec 11 19:34:45 phoenix kernel: [   35.024709] Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
Dec 11 19:34:45 phoenix kernel: [   35.024797] pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
Dec 11 19:34:45 phoenix kernel: [   35.026860] pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd05fffff
Dec 11 19:34:45 phoenix kernel: [   35.026931] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
Dec 11 19:34:45 phoenix kernel: [   35.035897] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Dec 11 19:34:45 phoenix kernel: [   35.035992] sdhci: SDHCI controller found at 0000:02:04.4 [104c:8034] (rev 0)
Dec 11 19:34:45 phoenix kernel: [   35.036096] ACPI: PCI Interrupt 0000:02:04.4[C] -> Link [C0F5] -> GSI 9 (level, low) -> IRQ 9
Dec 11 19:34:45 phoenix kernel: [   35.041391] mmc0: SDHCI at 0xd001a000 irq 9 DMA
Dec 11 19:34:45 phoenix kernel: [   35.041589] mmc1: SDHCI at 0xd001b000 irq 9 DMA
Dec 11 19:34:45 phoenix kernel: [   35.041772] mmc2: SDHCI at 0xd001c000 irq 9 DMA
Dec 11 19:34:45 phoenix kernel: [   35.101044] ACPI: PCI Interrupt 0000:02:04.3[B] -> Link [C0F5] -> GSI 9 (level, low) -> IRQ 9
Dec 11 19:34:45 phoenix kernel: [   35.204904] sd 0:0:0:0: Attached scsi generic sg0 type 0
Dec 11 19:34:45 phoenix kernel: [   35.205007] scsi 1:0:0:0: Attached scsi generic sg1 type 5
Dec 11 19:34:45 phoenix kernel: [   35.306529] piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
Dec 11 19:34:45 phoenix kernel: [   35.776690] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000
Dec 11 19:34:45 phoenix kernel: [   35.831125] input: SynPS/2 Synaptics TouchPad as /class/input/input2
Dec 11 19:34:45 phoenix kernel: [   35.928637] bcm43xx driver
Dec 11 19:34:45 phoenix kernel: [   35.943733] ACPI: PCI Interrupt Link [C0F6] enabled at IRQ 11
Dec 11 19:34:45 phoenix kernel: [   35.943797] ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0F6] -> GSI 11 (level, low) -> IRQ 11
Dec 11 19:34:45 phoenix kernel: [   35.943999] bcm43xx: Chip ID 0x4306, rev 0x3
Dec 11 19:34:45 phoenix kernel: [   35.944057] bcm43xx: Number of cores: 5
Dec 11 19:34:45 phoenix kernel: [   35.944115] bcm43xx: Core 0: ID 0x800, rev 0x4, vendor 0x4243
Dec 11 19:34:45 phoenix kernel: [   35.944179] bcm43xx: Core 1: ID 0x812, rev 0x5, vendor 0x4243
Dec 11 19:34:45 phoenix kernel: [   35.944245] bcm43xx: Core 2: ID 0x80d, rev 0x2, vendor 0x4243
Dec 11 19:34:45 phoenix kernel: [   35.944309] bcm43xx: Core 3: ID 0x807, rev 0x2, vendor 0x4243
Dec 11 19:34:45 phoenix kernel: [   35.944373] bcm43xx: Core 4: ID 0x804, rev 0x9, vendor 0x4243
Dec 11 19:34:45 phoenix kernel: [   35.947805] bcm43xx: PHY connected
Dec 11 19:34:45 phoenix kernel: [   35.947877] bcm43xx: Detected PHY: Version: 2, Type 2, Revision 2
Dec 11 19:34:45 phoenix kernel: [   35.947956] bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
Dec 11 19:34:45 phoenix kernel: [   35.948053] bcm43xx: Radio turned off
Dec 11 19:34:45 phoenix kernel: [   35.948118] bcm43xx: Radio turned off
Dec 11 19:34:45 phoenix kernel: [   36.113323] bcm43xx: PHY connected
Dec 11 19:34:45 phoenix kernel: [   36.245291] NET: Registered protocol family 17
Dec 11 19:34:45 phoenix kernel: [   36.370059] Bluetooth: Core ver 2.11
Dec 11 19:34:45 phoenix kernel: [   36.370229] NET: Registered protocol family 31
Dec 11 19:34:45 phoenix kernel: [   36.370287] Bluetooth: HCI device and connection manager initialized
Dec 11 19:34:45 phoenix kernel: [   36.372847] Bluetooth: HCI socket layer initialized
Dec 11 19:34:45 phoenix kernel: [   36.498861] ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [C0F1] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:45 phoenix kernel: [   36.613387] bcm43xx: Microcode rev 0x118, pl 0x17 (2004-05-06  21:34:00)
Dec 11 19:34:45 phoenix kernel: [   36.641430] bcm43xx: Radio turned on
Dec 11 19:34:45 phoenix kernel: [   36.710731] ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, low) -> IRQ 10
Dec 11 19:34:45 phoenix kernel: [   36.813305] MC'97 0 converters and GPIO not ready (0x1)
Dec 11 19:34:45 phoenix kernel: [   36.853497] bcm43xx: Chip initialized
Dec 11 19:34:45 phoenix kernel: [   36.856370] bcm43xx: 30-bit DMA initialized
Dec 11 19:34:45 phoenix kernel: [   36.856647] bcm43xx: Keys cleared
Dec 11 19:34:45 phoenix kernel: [   36.860366] bcm43xx: Selected 802.11 core (phytype 2)
Dec 11 19:34:45 phoenix kernel: [   36.967185] Bluetooth: HCI USB driver ver 2.9
Dec 11 19:34:46 phoenix kernel: [   37.079153] usbcore: registered new interface driver hci_usb
Dec 11 19:34:46 phoenix kernel: [   37.439428] Adding 1116476k swap on /dev/disk/by-uuid/45b6bcfd-44ec-4878-8110-f2164f9e8051.  Priority:-1 extents:1 across:1116476k
Dec 11 19:34:46 phoenix kernel: [   37.530100] EXT3 FS on sda2, internal journal
Dec 11 19:34:46 phoenix kernel: [   38.224955] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Dec 11 19:34:46 phoenix kernel: [   40.175486] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.182346] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.184468] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.186756] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.189790] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.192714] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.195561] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.197103] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.198961] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.200469] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.203465] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.206225] device-mapper: ioctl: error adding target to table
Dec 11 19:34:46 phoenix kernel: [   40.567879] NTFS driver 2.1.27 [Flags: R/O MODULE].
Dec 11 19:34:46 phoenix kernel: [   40.655469] NTFS volume version 3.1.
Dec 11 19:34:47 phoenix kernel: [   44.462601] ACPI: Battery Slot [C17C] (battery present)
Dec 11 19:34:47 phoenix kernel: [   44.463083] ACPI: Battery Slot [C17B] (battery absent)
Dec 11 19:34:47 phoenix kernel: [   44.495008] ACPI: Video Device [C049] (multi-head: yes  rom: no  post: no)
Dec 11 19:34:47 phoenix kernel: [   44.583263] ACPI: AC Adapter [C17A] (on-line)
Dec 11 19:34:47 phoenix kernel: [   44.631033] ACPI: Power Button (FF) [PWRF]
Dec 11 19:34:47 phoenix kernel: [   44.631076] ACPI: Sleep Button (CM) [C1F4]
Dec 11 19:34:47 phoenix kernel: [   44.631084] ACPI: Lid Switch [C1F5]
Dec 11 19:34:47 phoenix kernel: [   45.144920] powernow-k8: Found 1 AMD Turion(tm) 64 Mobile ML-40                  processors (version 2.00.00)
Dec 11 19:34:47 phoenix kernel: [   45.171761] powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x4
Dec 11 19:34:47 phoenix kernel: [   45.171766] powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6
Dec 11 19:34:47 phoenix kernel: [   45.171769] powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x8
Dec 11 19:34:47 phoenix kernel: [   45.171771] powernow-k8:    3 : fid 0x8 (1600 MHz), vid 0xa
Dec 11 19:34:47 phoenix kernel: [   45.171773] powernow-k8:    4 : fid 0x0 (800 MHz), vid 0x16
Dec 11 19:34:47 phoenix kernel: [   47.225768] NET: Registered protocol family 10
Dec 11 19:34:47 phoenix kernel: [   47.229617] lo: Disabled Privacy Extensions
Dec 11 19:34:47 phoenix kernel: [   47.257499] ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 11 19:34:47 phoenix kernel: [   47.257502] ADDRCONF(NETDEV_UP): eth1: link is not ready
Dec 11 19:34:47 phoenix kernel: [   55.777972] Capability LSM initialized
Dec 11 19:34:47 phoenix kernel: [   56.625268] SoftMAC: Scanning finished: scanned 14 channels starting with channel 1
Dec 11 19:34:47 phoenix kernel: [   57.010533] SoftMAC: Associate: Scanning for networks first.
Dec 11 19:34:47 phoenix kernel: [   57.011861] SoftMAC: Associate: failed to initiate scan. Is device up?
Dec 11 19:34:47 phoenix kernel: [   57.044649] SoftMAC: Scanning finished: scanned 14 channels starting with channel 1
Dec 11 19:34:47 phoenix kernel: [   57.044691] WARNING at kernel/mutex.c:132 __mutex_lock_common()
Dec 11 19:34:47 phoenix kernel: [   57.044694]
Dec 11 19:34:47 phoenix kernel: [   57.044695] Call Trace:
Dec 11 19:34:47 phoenix kernel: [   57.044712]  [dump_trace+193/1008] dump_trace+0xc1/0x3f0
Dec 11 19:34:47 phoenix kernel: [   57.044718]  [show_trace+67/96] show_trace+0x43/0x60
Dec 11 19:34:47 phoenix kernel: [   57.044723]  [dump_stack+21/32] dump_stack+0x15/0x20
Dec 11 19:34:47 phoenix kernel: [   57.044733]  [__mutex_lock_slowpath+192/672] __mutex_lock_slowpath+0xc0/0x2a0
Dec 11 19:34:47 phoenix kernel: [   57.044738]  [mutex_lock+37/48] mutex_lock+0x25/0x30
Dec 11 19:34:47 phoenix kernel: [   57.044764]  [_end+125206182/2126088072] :ieee80211softmac:ieee80211softmac_assoc_work+0x2e/0x570
Dec 11 19:34:47 phoenix kernel: [   57.044782]  [_end+125207544/2126088072] :ieee80211softmac:ieee80211softmac_assoc_notify_scan+0x10/0x20
Dec 11 19:34:47 phoenix kernel: [   57.044792]  [_end+125209290/2126088072] :ieee80211softmac:ieee80211softmac_notify_callback+0x62/0x78
Dec 11 19:34:47 phoenix kernel: [   57.044801]  [run_workqueue+196/432] run_workqueue+0xc4/0x1b0
Dec 11 19:34:47 phoenix kernel: [   57.044807]  [worker_thread+321/384] worker_thread+0x141/0x180
Dec 11 19:34:47 phoenix kernel: [   57.044813]  [kthread+211/272] kthread+0xd3/0x110
Dec 11 19:34:47 phoenix kernel: [   57.044819]  [child_rip+10/18] child_rip+0xa/0x12
Dec 11 19:34:47 phoenix kernel: [   57.045434] DWARF2 unwinder stuck at child_rip+0xa/0x12
Dec 11 19:34:47 phoenix kernel: [   57.045437] Leftover inexact backtrace:
Dec 11 19:34:47 phoenix kernel: [   57.045453]  [_spin_unlock_irq+43/96] _spin_unlock_irq+0x2b/0x60
Dec 11 19:34:47 phoenix kernel: [   57.045457]  [restore_args+0/48] restore_args+0x0/0x30
Dec 11 19:34:47 phoenix kernel: [   57.045463]  [kthread+0/272] kthread+0x0/0x110
Dec 11 19:34:47 phoenix kernel: [   57.045466]  [child_rip+0/18] child_rip+0x0/0x12
Dec 11 19:34:47 phoenix kernel: [   57.045469]
Dec 11 19:34:47 phoenix kernel: [   57.045487] PGD 3040c067 PUD 0
Dec 11 19:34:47 phoenix kernel: [   57.045494] CPU 0
Dec 11 19:34:47 phoenix kernel: [   57.045495] Modules linked in: capability commoncap ipv6 powernow_k8 cpufreq_conservative cpufreq_ondemand cpufreq_userspace cpufreq_stats freq_table
cpufreq_powersave button container ac asus_acpi video battery nls_utf8 ntfs dm_mod md_mod sbp2 hci_usb snd_atiixp_modem snd_pcm_oss snd_mixer_oss joydev tsdev snd_atiixp snd_ac97_codec snd_ac97_bus
bluetooth af_packet snd_pcm snd_timer bcm43xx serio_raw pcmcia snd soundcore i2c_piix4 ieee80211softmac sg psmouse tifm_7xx1 tifm_core evdev sdhci mmc_core shpchp pci_hotplug snd_page_alloc pcspkr
ata_generic yenta_socket rsrc_nonstatic pcmcia_core i2c_core ieee80211 ieee80211_crypt k8temp tg3 ext3 ohci1394 ieee1394 jbd mbcache ehci_hcd ohci_hcd usbcore sd_mod thermal processor fan
Dec 11 19:34:47 phoenix kernel: [   57.045536] Pid: 4, comm: events/0 Not tainted 2.6.19 #1
Dec 11 19:34:47 phoenix kernel: [   57.045539] RIP: 0010:[__mutex_lock_slowpath+263/672]  [__mutex_lock_slowpath+263/672] __mutex_lock_slowpath+0x107/0x2a0
Dec 11 19:34:47 phoenix kernel: [   57.045545] RSP: 0018:ffff810037f19c40  EFLAGS: 00010086
Dec 11 19:34:47 phoenix kernel: [   57.045548] RAX: 0000003c00000000 RBX: ffff810032100d88 RCX: 0000000000000000
Dec 11 19:34:47 phoenix kernel: [   57.045552] RDX: ffff810037f18000 RSI: ffff810037f19c40 RDI: ffff810032100d88
Dec 11 19:34:47 phoenix kernel: [   57.045554] RBP: ffff810037f19ca0 R08: 0000000000000002 R09: 0000000000000001
Dec 11 19:34:47 phoenix kernel: [   57.045557] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
Dec 11 19:34:47 phoenix kernel: [   57.045561] R13: ffff810037fbf100 R14: ffff810032100dd8 R15: ffff810037f19c40
Dec 11 19:34:47 phoenix kernel: [   57.045564] FS:  00002b392ed8b6d0(0000) GS:ffffffff80602000(0000) knlGS:0000000000000000
Dec 11 19:34:47 phoenix kernel: [   57.045567] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Dec 11 19:34:47 phoenix kernel: [   57.045570] CR2: 0000003c00000000 CR3: 00000000304ee000 CR4: 00000000000006e0
Dec 11 19:34:47 phoenix kernel: [   57.045573] Process events/0 (pid: 4, threadinfo ffff810037f18000, task ffff810037fbf100)
Dec 11 19:34:47 phoenix kernel: [   57.045575] Stack:  ffff810032100dd8 ffff810037f19c40 1111111111111111 ffff810032100d88
Dec 11 19:34:47 phoenix kernel: [   57.045583]  ffff810037f19c40 ffff810036e5f800 0000000000000086 ffff810032100d88
Dec 11 19:34:47 phoenix kernel: [   57.045588]  0000000000000000 ffff810032100e70 0000000000000000 ffff810032100cd0
Dec 11 19:34:47 phoenix kernel: [   57.045592] Call Trace:
Dec 11 19:34:47 phoenix kernel: [   57.045598]  [mutex_lock+37/48] mutex_lock+0x25/0x30
Dec 11 19:34:47 phoenix kernel: [   57.045605]  [_end+125206182/2126088072] :ieee80211softmac:ieee80211softmac_assoc_work+0x2e/0x570
Dec 11 19:34:47 phoenix kernel: [   57.045616]  [_end+125207544/2126088072] :ieee80211softmac:ieee80211softmac_assoc_notify_scan+0x10/0x20
Dec 11 19:34:47 phoenix kernel: [   57.045627]  [_end+125209290/2126088072] :ieee80211softmac:ieee80211softmac_notify_callback+0x62/0x78
Dec 11 19:34:47 phoenix kernel: [   57.045635]  [run_workqueue+196/432] run_workqueue+0xc4/0x1b0
Dec 11 19:34:47 phoenix kernel: [   57.045640]  [worker_thread+321/384] worker_thread+0x141/0x180
Dec 11 19:34:47 phoenix kernel: [   57.045645]  [kthread+211/272] kthread+0xd3/0x110
Dec 11 19:34:47 phoenix kernel: [   57.045650]  [child_rip+10/18] child_rip+0xa/0x12
Dec 11 19:34:47 phoenix kernel: [   57.046211] DWARF2 unwinder stuck at child_rip+0xa/0x12
Dec 11 19:34:47 phoenix kernel: [   57.046213] Leftover inexact backtrace:
Dec 11 19:34:47 phoenix kernel: [   57.046219]  [_spin_unlock_irq+43/96] _spin_unlock_irq+0x2b/0x60
Dec 11 19:34:47 phoenix kernel: [   57.046223]  [restore_args+0/48] restore_args+0x0/0x30
Dec 11 19:34:47 phoenix kernel: [   57.046229]  [kthread+0/272] kthread+0x0/0x110
Dec 11 19:34:47 phoenix kernel: [   57.046232]  [child_rip+0/18] child_rip+0x0/0x12
Dec 11 19:34:47 phoenix kernel: [   57.046235]
Dec 11 19:34:47 phoenix kernel: [   57.046236]
Dec 11 19:34:47 phoenix kernel: [   57.046237] Code: 4c 89 38 48 89 45 a8 4c 89 6d b0 48 c7 c0 ff ff ff ff 87 03
Dec 11 19:34:47 phoenix kernel: [   57.046254]  RSP <ffff810037f19c40>
Dec 11 19:34:47 phoenix kernel: [   57.046258]  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Dec 11 19:34:48 phoenix kernel: [   57.046262] in_atomic():0, irqs_disabled():1
Dec 11 19:34:48 phoenix kernel: [   57.046264] no locks held by events/0/4.
Dec 11 19:34:48 phoenix kernel: [   57.046265]
Dec 11 19:34:48 phoenix kernel: [   57.046266] Call Trace:
Dec 11 19:34:48 phoenix kernel: [   57.046270]  [dump_trace+193/1008] dump_trace+0xc1/0x3f0
Dec 11 19:34:48 phoenix kernel: [   57.046275]  [show_trace+67/96] show_trace+0x43/0x60
Dec 11 19:34:48 phoenix kernel: [   57.046280]  [dump_stack+21/32] dump_stack+0x15/0x20
Dec 11 19:34:48 phoenix kernel: [   57.046285]  [__might_sleep+197/208] __might_sleep+0xc5/0xd0
Dec 11 19:34:48 phoenix kernel: [   57.046292]  [down_read+29/80] down_read+0x1d/0x50
Dec 11 19:34:48 phoenix kernel: [   57.046298]  [blocking_notifier_call_chain+34/80] blocking_notifier_call_chain+0x22/0x50
Dec 11 19:34:48 phoenix kernel: [   57.046305]  [profile_task_exit+21/32] profile_task_exit+0x15/0x20
Dec 11 19:34:48 phoenix kernel: [   57.046310]  [do_exit+37/2272] do_exit+0x25/0x8e0
Dec 11 19:34:48 phoenix kernel: [   57.046316]  [do_page_fault+2032/2288] do_page_fault+0x7f0/0x8f0
Dec 11 19:34:48 phoenix kernel: [   57.046321]  [error_exit+0/150] error_exit+0x0/0x96
Dec 11 19:34:48 phoenix kernel: [   57.046879] DWARF2 unwinder stuck at error_exit+0x0/0x96
Dec 11 19:34:48 phoenix kernel: [   57.046881] Leftover inexact backtrace:
Dec 11 19:34:48 phoenix kernel: [   57.046891]  [__mutex_lock_slowpath+263/672] __mutex_lock_slowpath+0x107/0x2a0
Dec 11 19:34:48 phoenix kernel: [   57.046901]  [mutex_lock+37/48] mutex_lock+0x25/0x30
Dec 11 19:34:48 phoenix kernel: [   57.046908]  [_end+125206182/2126088072] :ieee80211softmac:ieee80211softmac_assoc_work+0x2e/0x570
Dec 11 19:34:48 phoenix kernel: [   57.046911]  [kfree+216/240] kfree+0xd8/0xf0
Dec 11 19:34:48 phoenix kernel: [   57.046917]  [trace_hardirqs_on+309/368] trace_hardirqs_on+0x135/0x170
Dec 11 19:34:48 phoenix kernel: [   57.046924]  [_end+125207528/2126088072] :ieee80211softmac:ieee80211softmac_assoc_notify_scan+0x0/0x20
Dec 11 19:34:48 phoenix kernel: [   57.046931]  [_end+125207544/2126088072] :ieee80211softmac:ieee80211softmac_assoc_notify_scan+0x10/0x20
Dec 11 19:34:48 phoenix kernel: [   57.046938]  [_end+125209290/2126088072] :ieee80211softmac:ieee80211softmac_notify_callback+0x62/0x78
Dec 11 19:34:48 phoenix kernel: [   57.046946]  [_end+125209192/2126088072] :ieee80211softmac:ieee80211softmac_notify_callback+0x0/0x78
Dec 11 19:34:48 phoenix kernel: [   57.046954]  [_end+125207528/2126088072] :ieee80211softmac:ieee80211softmac_assoc_notify_scan+0x0/0x20
Dec 11 19:34:48 phoenix kernel: [   57.046959]  [trace_hardirqs_on+309/368] trace_hardirqs_on+0x135/0x170
Dec 11 19:34:48 phoenix kernel: [   57.046966]  [_end+125209192/2126088072] :ieee80211softmac:ieee80211softmac_notify_callback+0x0/0x78
Dec 11 19:34:48 phoenix kernel: [   57.046970]  [run_workqueue+196/432] run_workqueue+0xc4/0x1b0
Dec 11 19:34:48 phoenix kernel: [   57.046976]  [worker_thread+321/384] worker_thread+0x141/0x180
Dec 11 19:34:48 phoenix kernel: [   57.046982]  [default_wake_function+0/16] default_wake_function+0x0/0x10
Dec 11 19:34:48 phoenix kernel: [   57.046989]  [worker_thread+0/384] worker_thread+0x0/0x180
Dec 11 19:34:48 phoenix kernel: [   57.046993]  [kthread+211/272] kthread+0xd3/0x110
Dec 11 19:34:48 phoenix kernel: [   57.046999]  [child_rip+10/18] child_rip+0xa/0x12
Dec 11 19:34:48 phoenix kernel: [   57.047004]  [_spin_unlock_irq+43/96] _spin_unlock_irq+0x2b/0x60
Dec 11 19:34:48 phoenix kernel: [   57.047008]  [restore_args+0/48] restore_args+0x0/0x30
Dec 11 19:34:48 phoenix kernel: [   57.047014]  [kthread+0/272] kthread+0x0/0x110
Dec 11 19:34:48 phoenix kernel: [   57.047017]  [child_rip+0/18] child_rip+0x0/0x12
Dec 11 19:34:48 phoenix kernel: [   57.047020]
Dec 11 19:34:48 phoenix kernel: [   59.017762] bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
Dec 11 19:34:48 phoenix kernel: [   63.944120] Bluetooth: L2CAP ver 2.8
Dec 11 19:34:48 phoenix kernel: [   63.944123] Bluetooth: L2CAP socket layer initialized
Dec 11 19:34:48 phoenix kernel: [   64.024249] Bluetooth: RFCOMM socket layer initialized
Dec 11 19:34:48 phoenix kernel: [   64.024261] Bluetooth: RFCOMM TTY layer initialized
Dec 11 19:34:48 phoenix kernel: [   64.024263] Bluetooth: RFCOMM ver 1.8
Dec 11 19:35:19 phoenix kernel: [   80.556717] SysRq : Emergency Sync
Dec 11 19:35:19 phoenix kernel: [   80.556760] Emergency Sync complete
Dec 11 19:35:21 phoenix kernel: [   81.396409] SysRq : Emergency Sync
Dec 11 19:35:21 phoenix kernel: [   81.396773] Emergency Sync complete

