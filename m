Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWJPWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWJPWlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWJPWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:41:49 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:50847 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1161145AbWJPWlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:41:46 -0400
Date: Mon, 16 Oct 2006 15:43:30 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: 2.6.19-rc2 cpu hotplug lockdep  warning: possible circular locking dependency
Message-ID: <20061016224330.GB3746@localhost.localdomain>
References: <20061016085439.GA6651@localhost.localdomain> <20061016111511.3901be27.akpm@osdl.org> <20061016192615.GA3746@localhost.localdomain> <20061016124808.20123a01.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20061016124808.20123a01.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Was: [patch] slab: Fix a cpu hotplug race condition while tuning slab cpu
caches)

On Mon, Oct 16, 2006 at 12:48:08PM -0700, Andrew Morton wrote:
> > 
> > Not when I tested it.  I just retested with lockdep on and things seemed 
> > fine on a SMP.
> 
> Great, thanks.  Please ensure that lockdep is used when testing the kernel.
>  Also preempt, DEBUG_SLAB, DEBUG_SPINLOCK_SLEEP and various other things. 
> I guess the list in Documentation/SubmitChecklist is the definitive one.

Seems like cpu offline spits out lockdep warnings when actually offlining a 
CPU with CPU_HOTPLUG + CONFIG_PREEMPT + CONFIG_SLAB_DEBUG etc.  Here is the 
trace I get.  Note that this is plain 2.6.19-rc2 (_without_ the slab cpu 
hotplug fix).

This a dual CPU 4 thread Xeon SMP box with 8G main memory.  I am also
attaching the .config I used, and the full dmesg.

Thanks,
Kiran


[  235.667515] CPU 3 is now offline
[  235.670860] 
[  235.670861] =======================================================
[  235.678694] [ INFO: possible circular locking dependency detected ]
[  235.684990] 2.6.19-rc2 #1
[  235.687649] -------------------------------------------------------
[  235.693945] bash/3223 is trying to acquire lock:
[  235.698596]  ((cpu_chain).rwsem){----}, at: [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  235.708226] 
[  235.708226] but task is already holding lock:
[  235.714149]  (workqueue_mutex){--..}, at: [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.723260] 
[  235.723261] which lock already depends on the new lock.
[  235.723262] 
[  235.731575] 
[  235.731575] the existing dependency chain (in reverse order) is:
[  235.739144] 
[  235.739144] -> #1 (workqueue_mutex){--..}:
[  235.744954]        [<ffffffff80249cc9>] add_lock_to_list+0x78/0x9d
[  235.751588]        [<ffffffff8024bcd8>] __lock_acquire+0xaca/0xc37
[  235.758222]        [<ffffffff8024c0ff>] lock_acquire+0x5c/0x77
[  235.764501]        [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.771836]        [<ffffffff8048d2fa>] __mutex_lock_slowpath+0xea/0x272
[  235.778990]        [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.786317]        [<ffffffff8023e932>] notifier_call_chain+0x23/0x32
[  235.793211]        [<ffffffff8023ea71>] blocking_notifier_call_chain+0x22/0x36
[  235.800901]        [<ffffffff8024ff00>] _cpu_down+0x53/0x218
[  235.807014]        [<ffffffff802500f0>] cpu_down+0x2b/0x42
[  235.812955]        [<ffffffff803b09c8>] store_online+0x27/0x71
[  235.819234]        [<ffffffff802b67b6>] sysfs_write_file+0xcc/0xfb
[  235.825878]        [<ffffffff8027bfb5>] vfs_write+0xb2/0x155
[  235.831983]        [<ffffffff8027c10d>] sys_write+0x45/0x70
[  235.838002]        [<ffffffff802099be>] system_call+0x7e/0x83
[  235.844194]        [<ffffffffffffffff>] 0xffffffffffffffff
[  235.850148] 
[  235.850148] -> #0 ((cpu_chain).rwsem){----}:
[  235.856145]        [<ffffffff8024977b>] save_trace+0x48/0xdf
[  235.862250]        [<ffffffff80249e67>] print_circular_bug_tail+0x34/0x70
[  235.869491]        [<ffffffff8024bbc5>] __lock_acquire+0x9b7/0xc37
[  235.876125]        [<ffffffff8048ef0e>] _spin_unlock_irqrestore+0x49/0x52
[  235.883374]        [<ffffffff8024c0ff>] lock_acquire+0x5c/0x77
[  235.889653]        [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  235.897334]        [<ffffffff8048c89f>] cond_resched+0x2f/0x3a
[  235.903613]        [<ffffffff80247fbf>] down_read+0x37/0x40
[  235.909642]        [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  235.917322]        [<ffffffff80250004>] _cpu_down+0x157/0x218
[  235.923532]        [<ffffffff802500f0>] cpu_down+0x2b/0x42
[  235.929464]        [<ffffffff803b09c8>] store_online+0x27/0x71
[  235.935752]        [<ffffffff802b67b6>] sysfs_write_file+0xcc/0xfb
[  235.942386]        [<ffffffff8027bfb5>] vfs_write+0xb2/0x155
[  235.948491]        [<ffffffff8027c10d>] sys_write+0x45/0x70
[  235.954520]        [<ffffffff802099be>] system_call+0x7e/0x83
[  235.960712]        [<ffffffffffffffff>] 0xffffffffffffffff
[  235.966645] 
[  235.966645] other info that might help us debug this:
[  235.966646] 
[  235.974812] 2 locks held by bash/3223:
[  235.978604]  #0:  (cpu_add_remove_lock){--..}, at: [<ffffffff802500de>] cpu_down+0x19/0x42
[  235.987160]  #1:  (workqueue_mutex){--..}, at: [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.996765] 
[  235.996766] stack backtrace:
[  236.001217] 
[  236.001218] Call Trace:
[  236.005238]  [<ffffffff80249e9a>] print_circular_bug_tail+0x67/0x70
[  236.011543]  [<ffffffff8024bbc5>] __lock_acquire+0x9b7/0xc37
[  236.017241]  [<ffffffff8048ef0e>] _spin_unlock_irqrestore+0x49/0x52
[  236.023546]  [<ffffffff8024c0ff>] lock_acquire+0x5c/0x77
[  236.028898]  [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  236.035634]  [<ffffffff8048c89f>] cond_resched+0x2f/0x3a
[  236.040987]  [<ffffffff80247fbf>] down_read+0x37/0x40
[  236.046080]  [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  236.052818]  [<ffffffff80250004>] _cpu_down+0x157/0x218
[  236.058084]  [<ffffffff802500f0>] cpu_down+0x2b/0x42
[  236.063089]  [<ffffffff803b09c8>] store_online+0x27/0x71
[  236.068441]  [<ffffffff802b67b6>] sysfs_write_file+0xcc/0xfb
[  236.074140]  [<ffffffff8027bfb5>] vfs_write+0xb2/0x155
[  236.079319]  [<ffffffff8027c10d>] sys_write+0x45/0x70
[  236.084411]  [<ffffffff802099be>] system_call+0x7e/0x83
[  236.089677] 

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Linux version 2.6.19-rc2 (kiran@x460) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #1 SMP Mon Oct 16 14:52:19 PDT 2006
[    0.000000] Command line: root=/dev/hda2 console=ttyS0,115200 console=tty0 debug 
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e2000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dffe0000 (usable)
[    0.000000]  BIOS-e820: 00000000dffe0000 - 00000000dffef000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dffef000 - 00000000dfffdc00 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dfffdc00 - 00000000e0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec86000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000220000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 917472) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 1048576, 2228224) 2 entries of 3200 used
[    0.000000] end_pfn_map = 2228224
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f84d0
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x09000526 MSFT 0x00000097) @ 0x00000000dffe0000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x09000526 MSFT 0x00000097) @ 0x00000000dffe0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x09000526 MSFT 0x00000097) @ 0x00000000dffe0390
[    0.000000] ACPI: SPCR (v001 A M I  OEMSPCR  0x09000526 MSFT 0x00000097) @ 0x00000000dffe0460
[    0.000000] ACPI: MCFG (v001 A M I  OEMMCFG  0x09000526 MSFT 0x00000097) @ 0x00000000dffe04b0
[    0.000000] ACPI: OEMB (v001 A M I  AMI_OEM  0x09000526 MSFT 0x00000097) @ 0x00000000dffef040
[    0.000000] ACPI: DSDT (v001  SJR2A SJR2A084 0x00000084 INTL 0x02002026) @ 0x0000000000000000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000220000000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 917472) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 1048576, 2228224) 2 entries of 3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-0000000220000000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  2228224
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   917472
[    0.000000]     0:  1048576 ->  2228224
[    0.000000] On node 0 totalpages: 2097023
[    0.000000]   DMA zone: 88 pages used for memmap
[    0.000000]   DMA zone: 2243 pages reserved
[    0.000000]   DMA zone: 1668 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 22440 pages used for memmap
[    0.000000]   DMA32 zone: 890936 pages, LIFO batch:31
[    0.000000]   Normal zone: 25344 pages used for memmap
[    0.000000]   Normal zone: 1154304 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
[    0.000000] Processor #6
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
[    0.000000] Processor #7
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x84] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x85] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x86] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x87] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 9, address 0xfec80000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 10, address 0xfec80400, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e2000
[    0.000000] Nosave address range: 00000000000e2000 - 0000000000100000
[    0.000000] Nosave address range: 00000000dffe0000 - 00000000dffef000
[    0.000000] Nosave address range: 00000000dffef000 - 00000000dfffd000
[    0.000000] Nosave address range: 00000000dfffd000 - 00000000dfffe000
[    0.000000] Nosave address range: 00000000dfffe000 - 00000000e0000000
[    0.000000] Nosave address range: 00000000e0000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 00000000fec86000
[    0.000000] Nosave address range: 00000000fec86000 - 00000000fee00000
[    0.000000] Nosave address range: 00000000fee00000 - 00000000fee01000
[    0.000000] Nosave address range: 00000000fee01000 - 00000000ffc00000
[    0.000000] Nosave address range: 00000000ffc00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] PERCPU: Allocating 45824 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 2046908
[    0.000000] Kernel command line: root=/dev/hda2 console=ttyS0,115200 console=tty0 debug 
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   78.949342] Console: colour VGA+ 80x25
[   79.533744] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   79.541535] ... MAX_LOCKDEP_SUBCLASSES:    8
[   79.545849] ... MAX_LOCK_DEPTH:          30
[   79.550082] ... MAX_LOCKDEP_KEYS:        2048
[   79.554484] ... CLASSHASH_SIZE:           1024
[   79.558978] ... MAX_LOCKDEP_ENTRIES:     8192
[   79.563378] ... MAX_LOCKDEP_CHAINS:      8192
[   79.567785] ... CHAINHASH_SIZE:          4096
[   79.572186]  memory used by lock dependency info: 1328 kB
[   79.577631]  per task-struct memory footprint: 1680 bytes
[   79.588044] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[   79.602931] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[   79.612603] Checking aperture...
[   79.616009] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   79.662994] Placing software IO TLB between 0x1ce5000 - 0x5ce5000
[   79.771634] Memory: 8108424k/8912896k available (2630k kernel code, 279668k reserved, 1329k data, 312k init)
[   79.927179] Calibrating delay using timer specific routine.. 7187.03 BogoMIPS (lpj=35935182)
[   79.936076] Mount-cache hash table entries: 256
[   79.942145] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   79.947469] CPU: L2 cache: 1024K
[   79.950743] CPU 0/0 -> Node 0
[   79.953755] using mwait in idle threads.
[   79.957730] CPU: Physical Processor ID: 0
[   79.961784] CPU: Processor Core ID: 0
[   79.965498] CPU0: Thermal monitoring enabled (TM2)
[   79.970360] lockdep: not fixing up alternatives.
[   79.975018] ACPI: Core revision 20060707
[   80.085548] Using local APIC timer interrupts.
[   80.117872] result 12469037
[   80.120713] Detected 12.469 MHz APIC timer.
[   80.128677] lockdep: not fixing up alternatives.
[   80.133725] Booting processor 1/4 APIC 0x6
[   80.148294] Initializing CPU#1
[   80.296976] Calibrating delay using timer specific routine.. 7182.37 BogoMIPS (lpj=35911855)
[   80.296986] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   80.296988] CPU: L2 cache: 1024K
[   80.296991] CPU 1/6 -> Node 0
[   80.296993] CPU: Physical Processor ID: 3
[   80.296994] CPU: Processor Core ID: 0
[   80.297003] CPU1: Thermal monitoring enabled (TM2)
[   80.297216]                   Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
[   80.307740] lockdep: not fixing up alternatives.
[   80.354823] Booting processor 2/4 APIC 0x1
[   80.369390] Initializing CPU#2
[   80.516858] Calibrating delay using timer specific routine.. 7182.17 BogoMIPS (lpj=35910889)
[   80.516871] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   80.516874] CPU: L2 cache: 1024K
[   80.516877] CPU 2/1 -> Node 0
[   80.516879] CPU: Physical Processor ID: 0
[   80.516881] CPU: Processor Core ID: 0
[   80.516891] CPU2: Thermal monitoring enabled (TM2)
[   80.517084]                   Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
[   80.527671] lockdep: not fixing up alternatives.
[   80.574744] Booting processor 3/4 APIC 0x7
[   80.589285] Initializing CPU#3
[   80.736740] Calibrating delay using timer specific routine.. 7182.31 BogoMIPS (lpj=35911553)
[   80.736751] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   80.736753] CPU: L2 cache: 1024K
[   80.736755] CPU 3/7 -> Node 0
[   80.736757] CPU: Physical Processor ID: 3
[   80.736759] CPU: Processor Core ID: 0
[   80.736769] CPU3: Thermal monitoring enabled (TM2)
[   80.736957]                   Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
[   80.746758] Brought up 4 CPUs
[   80.792170] testing NMI watchdog ... OK.
[   80.896206] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   80.902434] time.c: Detected 3591.102 MHz processor.
[   81.084314] migration_cost=6,650
[   81.090579] NET: Registered protocol family 16
[   81.095817] ACPI: bus type pci registered
[   81.099890] PCI: Using configuration type 1
[   81.121840] ACPI: Interpreter enabled
[   81.125557] ACPI: Using IOAPIC for interrupt routing
[   81.132656] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   81.137593] PCI: Probing PCI hardware (bus 00)
[   81.146937] PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
[   81.153427] PCI quirk: region 0500-053f claimed by ICH4 GPIO
[   81.159193] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   81.165381] PCI: PXH quirk detected, disabling MSI for SHPC device
[   81.171649] PCI: PXH quirk detected, disabling MSI for SHPC device
[   81.179311] Boot video device is 0000:05:0c.0
[   81.183740] PCI: Transparent bridge - 0000:00:1e.0
[   81.188656] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   81.210907] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0._PRT]
[   81.218001] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0.PXHA._PRT]
[   81.226003] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0.PXHB._PRT]
[   81.234112] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPC0._PRT]
[   81.243573] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
[   81.251317] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 7 *10 11 12 14 15)
[   81.259307] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 7 10 *11 12 14 15)
[   81.267321] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 7 10 11 12 14 15)
[   81.275292] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *7 10 11 12 14 15)
[   81.283272] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 7 10 11 12 14 15) *0, disabled.
[   81.292506] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 7 10 11 12 14 15) *0, disabled.
[   81.301723] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 7 10 11 12 14 15) *0, disabled.
[   81.310945] ACPI: PCI Interrupt Link [LNKH] (IRQs 5) *0, disabled.
[   81.318903] SCSI subsystem initialized
[   81.322812] PCI: Using ACPI for IRQ routing
[   81.327049] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   81.335607] PCI-GART: No AMD northbridge found.
[   81.345115] PCI: Bridge: 0000:01:00.0
[   81.348834]   IO window: disabled.
[   81.352282]   MEM window: disabled.
[   81.355814]   PREFETCH window: disabled.
[   81.359795] PCI: Bridge: 0000:01:00.2
[   81.363504]   IO window: d000-dfff
[   81.366954]   MEM window: fce00000-fcefffff
[   81.371182]   PREFETCH window: disabled.
[   81.375153] PCI: Bridge: 0000:00:02.0
[   81.378865]   IO window: d000-dfff
[   81.382317]   MEM window: fce00000-fcefffff
[   81.386543]   PREFETCH window: disabled.
[   81.390514] PCI: Bridge: 0000:00:06.0
[   81.394221]   IO window: disabled.
[   81.397677]   MEM window: fcf00000-fcffffff
[   81.401905]   PREFETCH window: f0000000-fbffffff
[   81.406569] PCI: Bridge: 0000:00:1e.0
[   81.410283]   IO window: e000-efff
[   81.413737]   MEM window: fd000000-febfffff
[   81.417968]   PREFETCH window: e2000000-e20fffff
[   81.422653] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[   81.430156] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   81.436477] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   81.442803] PCI: Setting latency timer of device 0000:01:00.2 to 64
[   81.449129] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
[   81.456632] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   81.462953] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   81.469416] NET: Registered protocol family 2
[   81.577301] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   81.586278] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[   81.600316] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[   81.610376] TCP: Hash tables configured (established 65536 bind 32768)
[   81.617026] TCP reno registered
[  121.596049] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[  121.607551] SGI XFS with large block/inode numbers, no debug enabled
[  121.614950] io scheduler noop registered
[  121.618974] io scheduler anticipatory registered (default)
[  121.624603] io scheduler deadline registered
[  121.629038] io scheduler cfq registered
[  121.718365] Real Time Clock Driver v1.12ac
[  121.722509] Linux agpgart interface v0.101 (c) Dave Jones
[  121.727953] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  121.736528] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  121.747116] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[  121.756071] loop: loaded (max 8 devices)
[  121.760036] Intel(R) PRO/1000 Network Driver - version 7.2.9-k2
[  121.765997] Copyright (c) 1999-2006 Intel Corporation.
[  121.771336] ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 54 (level, low) -> IRQ 54
[  122.057833] e1000: 0000:03:04.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:b2:fa:b0
[  122.115770] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[  122.122709] ACPI: PCI Interrupt 0000:03:04.1[B] -> GSI 55 (level, low) -> IRQ 55
[  122.407631] e1000: 0000:03:04.1: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:b2:fa:b1
[  122.465041] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[  122.472705] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  122.479110] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  122.487244] ICH5: IDE controller at PCI slot 0000:00:1f.1
[  122.492691] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[  122.500199] ICH5: chipset revision 2
[  122.503819] ICH5: not 100% native mode: will probe irqs later
[  122.509618]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[  122.517026]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
[  122.524411] Probing IDE interface ide0...
[  122.835558] hda: Maxtor 6Y080L0, ATA DISK drive
[  123.555344] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  123.560165] Probing IDE interface ide1...
[  124.165233] hda: max request size: 128KiB
[  124.170888] hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
[  124.179489] hda: cache flushes supported
[  124.184000]  hda: hda1 hda2 hda3 hda4
[  124.199111] serio: i8042 KBD port at 0x60,0x64 irq 1
[  124.204200] serio: i8042 AUX port at 0x60,0x64 irq 12
[  124.209605] mice: PS/2 mouse device common for all mice
[  124.215003] md: linear personality registered for level -1
[  124.220527] md: raid0 personality registered for level 0
[  124.225885] md: raid1 personality registered for level 1
[  124.274133] input: AT Translated Set 2 keyboard as /class/input/input0
[  124.393319] raid6: int64x1   1605 MB/s
[  124.563214] raid6: int64x2   2256 MB/s
[  124.733127] raid6: int64x4   2923 MB/s
[  124.903037] raid6: int64x8   1920 MB/s
[  125.072973] raid6: sse2x1    2510 MB/s
[  125.181357] input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
[  125.242866] raid6: sse2x2    2373 MB/s
[  125.412775] raid6: sse2x4    3408 MB/s
[  125.416570] raid6: using algorithm sse2x4 (3408 MB/s)
[  125.421661] md: raid6 personality registered for level 6
[  125.427017] md: raid5 personality registered for level 5
[  125.432373] md: raid4 personality registered for level 4
[  125.437731] raid5: automatically using best checksumming function: generic_sse
[  125.492716]    generic_sse:  5590.800 MB/sec
[  125.497035] raid5: using function: generic_sse (5590.800 MB/sec)
[  125.503395] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[  125.512000] TCP cubic registered
[  125.515303] NET: Registered protocol family 1
[  125.519715] NET: Registered protocol family 17
[  125.524540] ACPI: (supports S0 S1 S4 S5)
[  125.530016] md: Autodetecting RAID arrays.
[  125.534163] md: autorun ...
[  125.536999] md: ... autorun DONE.
[  125.565654] kjournald starting.  Commit interval 5 seconds
[  125.566222] EXT3-fs: mounted filesystem with ordered data mode.
[  125.566524] VFS: Mounted root (ext3 filesystem) readonly.
[  125.566637] Freeing unused kernel memory: 312k freed
[  131.302664] warning: process `kmodule' used the removed sysctl system call
[  131.432795] warning: process `ls' used the removed sysctl system call
[  131.830996] warning: process `date' used the removed sysctl system call
[  131.993649] md: Autodetecting RAID arrays.
[  131.993654] md: autorun ...
[  131.993656] md: ... autorun DONE.
[  132.542516] EXT3 FS on hda2, internal journal
[  132.739314] kjournald starting.  Commit interval 5 seconds
[  132.739485] EXT3 FS on hda1, internal journal
[  132.739496] EXT3-fs: mounted filesystem with ordered data mode.
[  132.868105] XFS mounting filesystem hda4
[  132.957259] Ending clean XFS mount for filesystem: hda4
[  133.005321] VFS: Can't find ext3 filesystem on dev hda3.
[  134.023727] warning: process `date' used the removed sysctl system call
[  134.224774] warning: process `kudzu' used the removed sysctl system call
[  135.186755] e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
[  140.086073] VFS: Can't find ext3 filesystem on dev hda3.
[  235.667515] CPU 3 is now offline
[  235.670860] 
[  235.670861] =======================================================
[  235.678694] [ INFO: possible circular locking dependency detected ]
[  235.684990] 2.6.19-rc2 #1
[  235.687649] -------------------------------------------------------
[  235.693945] bash/3223 is trying to acquire lock:
[  235.698596]  ((cpu_chain).rwsem){----}, at: [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  235.708226] 
[  235.708226] but task is already holding lock:
[  235.714149]  (workqueue_mutex){--..}, at: [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.723260] 
[  235.723261] which lock already depends on the new lock.
[  235.723262] 
[  235.731575] 
[  235.731575] the existing dependency chain (in reverse order) is:
[  235.739144] 
[  235.739144] -> #1 (workqueue_mutex){--..}:
[  235.744954]        [<ffffffff80249cc9>] add_lock_to_list+0x78/0x9d
[  235.751588]        [<ffffffff8024bcd8>] __lock_acquire+0xaca/0xc37
[  235.758222]        [<ffffffff8024c0ff>] lock_acquire+0x5c/0x77
[  235.764501]        [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.771836]        [<ffffffff8048d2fa>] __mutex_lock_slowpath+0xea/0x272
[  235.778990]        [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.786317]        [<ffffffff8023e932>] notifier_call_chain+0x23/0x32
[  235.793211]        [<ffffffff8023ea71>] blocking_notifier_call_chain+0x22/0x36
[  235.800901]        [<ffffffff8024ff00>] _cpu_down+0x53/0x218
[  235.807014]        [<ffffffff802500f0>] cpu_down+0x2b/0x42
[  235.812955]        [<ffffffff803b09c8>] store_online+0x27/0x71
[  235.819234]        [<ffffffff802b67b6>] sysfs_write_file+0xcc/0xfb
[  235.825878]        [<ffffffff8027bfb5>] vfs_write+0xb2/0x155
[  235.831983]        [<ffffffff8027c10d>] sys_write+0x45/0x70
[  235.838002]        [<ffffffff802099be>] system_call+0x7e/0x83
[  235.844194]        [<ffffffffffffffff>] 0xffffffffffffffff
[  235.850148] 
[  235.850148] -> #0 ((cpu_chain).rwsem){----}:
[  235.856145]        [<ffffffff8024977b>] save_trace+0x48/0xdf
[  235.862250]        [<ffffffff80249e67>] print_circular_bug_tail+0x34/0x70
[  235.869491]        [<ffffffff8024bbc5>] __lock_acquire+0x9b7/0xc37
[  235.876125]        [<ffffffff8048ef0e>] _spin_unlock_irqrestore+0x49/0x52
[  235.883374]        [<ffffffff8024c0ff>] lock_acquire+0x5c/0x77
[  235.889653]        [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  235.897334]        [<ffffffff8048c89f>] cond_resched+0x2f/0x3a
[  235.903613]        [<ffffffff80247fbf>] down_read+0x37/0x40
[  235.909642]        [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  235.917322]        [<ffffffff80250004>] _cpu_down+0x157/0x218
[  235.923532]        [<ffffffff802500f0>] cpu_down+0x2b/0x42
[  235.929464]        [<ffffffff803b09c8>] store_online+0x27/0x71
[  235.935752]        [<ffffffff802b67b6>] sysfs_write_file+0xcc/0xfb
[  235.942386]        [<ffffffff8027bfb5>] vfs_write+0xb2/0x155
[  235.948491]        [<ffffffff8027c10d>] sys_write+0x45/0x70
[  235.954520]        [<ffffffff802099be>] system_call+0x7e/0x83
[  235.960712]        [<ffffffffffffffff>] 0xffffffffffffffff
[  235.966645] 
[  235.966645] other info that might help us debug this:
[  235.966646] 
[  235.974812] 2 locks held by bash/3223:
[  235.978604]  #0:  (cpu_add_remove_lock){--..}, at: [<ffffffff802500de>] cpu_down+0x19/0x42
[  235.987160]  #1:  (workqueue_mutex){--..}, at: [<ffffffff802422a1>] workqueue_cpu_callback+0x14e/0x2a4
[  235.996765] 
[  235.996766] stack backtrace:
[  236.001217] 
[  236.001218] Call Trace:
[  236.005238]  [<ffffffff80249e9a>] print_circular_bug_tail+0x67/0x70
[  236.011543]  [<ffffffff8024bbc5>] __lock_acquire+0x9b7/0xc37
[  236.017241]  [<ffffffff8048ef0e>] _spin_unlock_irqrestore+0x49/0x52
[  236.023546]  [<ffffffff8024c0ff>] lock_acquire+0x5c/0x77
[  236.028898]  [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  236.035634]  [<ffffffff8048c89f>] cond_resched+0x2f/0x3a
[  236.040987]  [<ffffffff80247fbf>] down_read+0x37/0x40
[  236.046080]  [<ffffffff8023ea62>] blocking_notifier_call_chain+0x13/0x36
[  236.052818]  [<ffffffff80250004>] _cpu_down+0x157/0x218
[  236.058084]  [<ffffffff802500f0>] cpu_down+0x2b/0x42
[  236.063089]  [<ffffffff803b09c8>] store_online+0x27/0x71
[  236.068441]  [<ffffffff802b67b6>] sysfs_write_file+0xcc/0xfb
[  236.074140]  [<ffffffff8027bfb5>] vfs_write+0xb2/0x155
[  236.079319]  [<ffffffff8027c10d>] sys_write+0x45/0x70
[  236.084411]  [<ffffffff802099be>] system_call+0x7e/0x83
[  236.089677] 

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc2
# Mon Oct 16 14:51:41 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
# CONFIG_X86_PC is not set
CONFIG_X86_VSMP=y
# CONFIG_MK8 is not set
CONFIG_MPSC=y
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTERNODE_CACHE_BYTES=4096
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_NUMA=y
# CONFIG_K8_NUMA is not set
CONFIG_NODES_SHIFT=6
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_RESOURCES_64BIT=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_OUT_OF_LINE_PFN_TO_PAGE=y
CONFIG_NR_CPUS=64
CONFIG_HOTPLUG_CPU=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_IOMMU=y
CONFIG_CALGARY_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_SECCOMP=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_REORDER is not set
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
CONFIG_SUSPEND_SMP=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_MULTITHREAD_PROBE is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
# CONFIG_IP_ROUTE_MULTIPATH_RR is not set
# CONFIG_IP_ROUTE_MULTIPATH_RANDOM is not set
# CONFIG_IP_ROUTE_MULTIPATH_WRANDOM is not set
# CONFIG_IP_ROUTE_MULTIPATH_DRR is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
# CONFIG_ATA is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=y
# CONFIG_MD_RAID5_RESHAPE is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_TIFM_CORE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_SLAB_LEAK is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=y

--2fHTh5uZTiUOsy+g--
