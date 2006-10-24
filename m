Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWJXUYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWJXUYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWJXUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:24:13 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:63684 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S965181AbWJXUYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:24:11 -0400
Date: Tue, 24 Oct 2006 13:26:13 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, xfs-masters@oss.sgi.com
Subject: [bug] 2.6.19-rc3 oops at __drain_pages during cpu hotplug tests + lockdep warning with xfs
Message-ID: <20061024202613.GA6332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
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


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2.6.19-rc2mm2 as well as 2.6.19-rc3 panics with the following OOPS when I
run kernbench continuously and execute cpu offline and online in parallel. 
This is a 2 socket 4 core tyan opteron system with 8Gs of RAM.  
The kernel has lockdep, and other debug flags enabled.  Also, we have a 
lockdep warning with XFS.  Attaching the dmesg and the .config used as well.  
Here's the snapshot of lockdep warning + oops.


[  469.336719] 
[  469.336721] =============================================
[  469.336728] [ INFO: possible recursive locking detected ]
[  469.336731] 2.6.19-rc3 #2
[  469.336737] ---------------------------------------------
[  469.336745] rm/4538 is trying to acquire lock:
[  469.336753]  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336782] 
[  469.336784] but task is already holding lock:
[  469.336791]  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336816] 
[  469.336817] other info that might help us debug this:
[  469.336825] 3 locks held by rm/4538:
[  469.336832]  #0:  (&inode->i_mutex/1){--..}, at: [<ffffffff80286055>] do_unlinkat+0x75/0x136
[  469.336866]  #1:  (&inode->i_mutex){--..}, at: [<ffffffff80285f98>] vfs_unlink+0x45/0x8d
[  469.336897]  #2:  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336928] 
[  469.336929] stack backtrace:
[  469.336936] 
[  469.336938] Call Trace:
[  469.336947]  [<ffffffff8024b4cc>] __lock_acquire+0x381/0xb8c
[  469.336957]  [<ffffffff8024bf80>] lock_acquire+0x4b/0x66
[  469.336966]  [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336976]  [<ffffffff80247c97>] down_write+0x1e/0x27
[  469.336985]  [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336993]  [<ffffffff8033cad1>] xfs_lock_dir_and_entry+0x92/0xce
[  469.337002]  [<ffffffff8033cd23>] xfs_remove+0x216/0x44a
[  469.337013]  [<ffffffff80346c96>] xfs_vn_unlink+0x21/0x4f
[  469.337024]  [<ffffffff804a72b9>] __mutex_lock_slowpath+0x249/0x279
[  469.337034]  [<ffffffff8024aaaf>] mark_held_locks+0x65/0x84
[  469.337043]  [<ffffffff804a72b9>] __mutex_lock_slowpath+0x249/0x279
[  469.337053]  [<ffffffff8024ac7c>] trace_hardirqs_on+0x101/0x128
[  469.337062]  [<ffffffff804a72dc>] __mutex_lock_slowpath+0x26c/0x279
[  469.337072]  [<ffffffff802832d9>] permission+0xa0/0xa9
[  469.337081]  [<ffffffff80285fb4>] vfs_unlink+0x61/0x8d
[  469.337090]  [<ffffffff80286098>] do_unlinkat+0xb8/0x136
[  469.337100]  [<ffffffff804a8649>] trace_hardirqs_on_thunk+0x35/0x37
[  469.337109]  [<ffffffff8024ac7c>] trace_hardirqs_on+0x101/0x128
[  469.337118]  [<ffffffff804a8649>] trace_hardirqs_on_thunk+0x35/0x37
[  469.337129]  [<ffffffff80209a4e>] system_call+0x7e/0x83
[  469.337137] 


[  488.264267] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
[  488.264271]  [<ffffffff8025d255>] __drain_pages+0x33/0x7d
[  488.264288] PGD 2753ae067 PUD 275f66067 PMD 0 
[  488.264302] Oops: 0000 [1] PREEMPT SMP 
[  488.264315] CPU 2 
[  488.264323] Modules linked in:
[  488.264332] Pid: 7617, comm: sh Not tainted 2.6.19-rc3 #2
[  488.264339] RIP: 0010:[<ffffffff8025d255>]  [<ffffffff8025d255>] __drain_pages+0x33/0x7d
[  488.264353] RSP: 0018:ffff81016dd3fdf8  EFLAGS: 00010046
[  488.264358] RAX: 0000000000000000 RBX: 0000000000000086 RCX: 0000000000000000
[  488.264366] RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffff810180000000
[  488.264373] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000001
[  488.264381] R10: ffffffff8025cb12 R11: 0000000000000000 R12: ffff810180000000
[  488.264389] R13: 0000000000000001 R14: 0000000000000001 R15: ffff81027a7e5998
[  488.264397] FS:  00002af4d80a5ae0(0000) GS:ffff81018001ad18(0000) knlGS:0000000000000000
[  488.264405] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  488.264412] CR2: 0000000000000000 CR3: 00000002767bf000 CR4: 00000000000006a0
[  488.264420] Process sh (pid: 7617, threadinfo ffff81016dd3e000, task ffff81016e03d080)
[  488.264427] Stack:  0000000000000001 0000000000000001 0000000000000007 0000000000000001
[  488.264448]  000000000000000f ffffffff8025e771 ffffffff80538860 ffffffff8023e3c2
[  488.264466]  0000000000000001 0000000000000001 ffff81016e11a0c0 ffffffff8024ff50
[  488.264481] Call Trace:
[  488.264490]  [<ffffffff8025e771>] page_alloc_cpu_notify+0x18/0x33
[  488.264500]  [<ffffffff8023e3c2>] notifier_call_chain+0x23/0x32
[  488.264509]  [<ffffffff8024ff50>] _cpu_down+0x184/0x245
[  488.264516]  [<ffffffff8025003c>] cpu_down+0x2b/0x42
[  488.264525]  [<ffffffff803b25b8>] store_online+0x27/0x71
[  488.264534]  [<ffffffff802b7b4a>] sysfs_write_file+0xb6/0xe5
[  488.264544]  [<ffffffff8027c6e5>] vfs_write+0xb2/0x155
[  488.264551]  [<ffffffff8027c83d>] sys_write+0x45/0x70
[  488.264560]  [<ffffffff80209a4e>] system_call+0x7e/0x83
[  488.264566] 
[  488.264570] 
[  488.264572] Code: 8b 75 00 4c 89 e7 e8 82 f8 ff ff f6 c7 02 c7 45 00 00 00 00 
[  488.264634] RIP  [<ffffffff8025d255>] __drain_pages+0x33/0x7d
[  488.264644]  RSP <ffff81016dd3fdf8>
[  488.264650] CR2: 0000000000000000
[  488.264655]  

Thanks,
Kiran

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.19-rc3"

[    0.000000] Linux version 2.6.19-rc3 (kiran@x460) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #2 SMP PREEMPT Tue Oct 24 12:24:39 PDT 2006
[    0.000000] Command line: root=/dev/sda2 splash=silent showopts
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
[    0.000000]  BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff10000 (usable)
[    0.000000]  BIOS-e820: 000000007ff10000 - 000000007ff19000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff19000 - 000000007ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000280000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 155) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 524048) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 1048576, 2621440) 2 entries of 3200 used
[    0.000000] end_pfn_map = 2621440
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f7040
[    0.000000] ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000007ff153c7
[    0.000000] ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @ 0x000000007ff18d36
[    0.000000] ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x000000007ff18daa
[    0.000000] ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x000000007ff18eba
[    0.000000] ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0x000000007ff18f0a
[    0.000000] ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000007ff18f46
[    0.000000] ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x000000007ff18fd8
[    0.000000] ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 2 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 3 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 0-a0000
[    0.000000] Entering add_active_range(0, 0, 155) 0 entries of 3200 used
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] Entering add_active_range(0, 0, 155) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 524048) 1 entries of 3200 used
[    0.000000] SRAT: Node 0 PXM 0 0-180000000
[    0.000000] Entering add_active_range(0, 0, 155) 2 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 524048) 2 entries of 3200 used
[    0.000000] Entering add_active_range(0, 1048576, 1572864) 2 entries of 3200 used
[    0.000000] SRAT: Node 1 PXM 1 180000000-280000000
[    0.000000] Entering add_active_range(1, 1572864, 2621440) 3 entries of 3200 used
[    0.000000] NUMA: Using 31 for the hash shift.
[    0.000000] Bootmem setup node 0 0000000000000000-0000000180000000
[    0.000000] Bootmem setup node 1 0000000180000000-0000000280000000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  2621440
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0:        0 ->      155
[    0.000000]     0:      256 ->   524048
[    0.000000]     0:  1048576 ->  1572864
[    0.000000]     1:  1572864 ->  2621440
[    0.000000] On node 0 totalpages: 1048235
[    0.000000]   DMA zone: 88 pages used for memmap
[    0.000000]   DMA zone: 2151 pages reserved
[    0.000000]   DMA zone: 1756 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 22440 pages used for memmap
[    0.000000]   DMA32 zone: 497512 pages, LIFO batch:31
[    0.000000]   Normal zone: 11264 pages used for memmap
[    0.000000]   Normal zone: 513024 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 1048576
[    0.000000]   DMA zone: 0 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages used for memmap
[    0.000000]   Normal zone: 22528 pages used for memmap
[    0.000000]   Normal zone: 1026048 pages, LIFO batch:31
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x8008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] Processor #2
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] Processor #3
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x05] address[0xd8000000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 5, address 0xd8000000, GSI 24-27
[    0.000000] ACPI: IOAPIC (id[0x06] address[0xd8001000] gsi_base[28])
[    0.000000] IOAPIC[2]: apic_id 6, address 0xd8001000, GSI 28-31
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009b000 - 000000000009c000
[    0.000000] Nosave address range: 000000000009c000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000d4000
[    0.000000] Nosave address range: 00000000000d4000 - 0000000000100000
[    0.000000] Nosave address range: 000000007ff10000 - 000000007ff19000
[    0.000000] Nosave address range: 000000007ff19000 - 000000007ff80000
[    0.000000] Nosave address range: 000000007ff80000 - 0000000080000000
[    0.000000] Nosave address range: 0000000080000000 - 00000000e0000000
[    0.000000] Nosave address range: 00000000e0000000 - 00000000e8000000
[    0.000000] Nosave address range: 00000000e8000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 00000000fee00000
[    0.000000] Nosave address range: 00000000fee00000 - 00000000fee01000
[    0.000000] Nosave address range: 00000000fee01000 - 00000000fff80000
[    0.000000] Nosave address range: 00000000fff80000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 37632 bytes of per cpu data
[    0.000000] Built 2 zonelists.  Total pages: 2038340
[    0.000000] Kernel command line: root=/dev/sda2 splash=silent showopts
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[  277.730450] Console: colour VGA+ 80x25
[  277.734534] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[  277.734605] ... MAX_LOCKDEP_SUBCLASSES:    8
[  277.734656] ... MAX_LOCK_DEPTH:          30
[  277.734706] ... MAX_LOCKDEP_KEYS:        2048
[  277.734758] ... CLASSHASH_SIZE:           1024
[  277.734809] ... MAX_LOCKDEP_ENTRIES:     8192
[  277.734860] ... MAX_LOCKDEP_CHAINS:      8192
[  277.734911] ... CHAINHASH_SIZE:          4096
[  277.734963]  memory used by lock dependency info: 1328 kB
[  277.735017]  per task-struct memory footprint: 1680 bytes
[  277.739261] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  277.746508] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  277.749122] Checking aperture...
[  277.749175] CPU 0: aperture @ 0 size 32 MB
[  277.751943] No AGP bridge found
[  277.751992] Your BIOS doesn't leave a aperture memory hole
[  277.752046] Please enable the IOMMU option in the BIOS setup
[  277.752099] This costs you 64 MB of RAM
[  277.785927] Mapping aperture over 65536 KB of RAM @ 4000000
[  277.900475] Memory: 8074684k/10485760k available (2735k kernel code, 312560k reserved, 1281k data, 304k init)
[  278.048243] Calibrating delay using timer specific routine.. 4824.91 BogoMIPS (lpj=24124594)
[  278.048925] Mount-cache hash table entries: 256
[  278.050110] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  278.050167] CPU: L2 Cache: 1024K (64 bytes/line)
[  278.050220] CPU 0/0 -> Node 0
[  278.050270] CPU: Physical Processor ID: 0
[  278.050320] CPU: Processor Core ID: 0
[  278.050389] lockdep: not fixing up alternatives.
[  278.050441] ACPI: Core revision 20060707
[  278.158599] Using local APIC timer interrupts.
[  278.200058] result 12557978
[  278.200107] Detected 12.557 MHz APIC timer.
[  278.209368] lockdep: not fixing up alternatives.
[  278.209740] Booting processor 1/4 APIC 0x1
[  278.220064] Initializing CPU#1
[  278.367716] Calibrating delay using timer specific routine.. 4822.38 BogoMIPS (lpj=24111902)
[  278.367722] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  278.367724] CPU: L2 Cache: 1024K (64 bytes/line)
[  278.367726] CPU 1/1 -> Node 0
[  278.367728] CPU: Physical Processor ID: 0
[  278.367730] CPU: Processor Core ID: 1
[  278.367848] Dual Core AMD Opteron(tm) Processor 280 stepping 02
[  278.377712] CPU 1: Syncing TSC to CPU 0.
[  278.377827] CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 637 cycles)
[  278.378892] lockdep: not fixing up alternatives.
[  278.379570] Booting processor 2/4 APIC 0x2
[  278.389900] Initializing CPU#2
[  278.537439] Calibrating delay using timer specific routine.. 4822.38 BogoMIPS (lpj=24111923)
[  278.537446] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  278.537448] CPU: L2 Cache: 1024K (64 bytes/line)
[  278.537451] CPU 2/2 -> Node 1
[  278.537453] CPU: Physical Processor ID: 1
[  278.537454] CPU: Processor Core ID: 0
[  278.537568] Dual Core AMD Opteron(tm) Processor 280 stepping 02
[  278.547437] CPU 2: Syncing TSC to CPU 0.
[  278.547619] CPU 2: synchronized TSC with CPU 0 (last diff -17 cycles, maxerr 1238 cycles)
[  278.548616] lockdep: not fixing up alternatives.
[  278.549260] Booting processor 3/4 APIC 0x3
[  278.560124] Initializing CPU#3
[  278.707160] Calibrating delay using timer specific routine.. 4822.34 BogoMIPS (lpj=24111748)
[  278.707168] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  278.707170] CPU: L2 Cache: 1024K (64 bytes/line)
[  278.707172] CPU 3/3 -> Node 1
[  278.707175] CPU: Physical Processor ID: 1
[  278.707176] CPU: Processor Core ID: 1
[  278.707290] Dual Core AMD Opteron(tm) Processor 280 stepping 02
[  278.717159] CPU 3: Syncing TSC to CPU 0.
[  278.717342] CPU 3: synchronized TSC with CPU 0 (last diff -17 cycles, maxerr 1238 cycles)
[  278.717348] Brought up 4 CPUs
[  278.718069] testing NMI watchdog ... OK.
[  278.818025] Disabling vsyscall due to use of PM timer
[  278.818079] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[  278.818133] time.c: Detected 2411.129 MHz processor.
[  279.037931] migration_cost=344,788
[  279.040588] NET: Registered protocol family 16
[  279.041267] ACPI: bus type pci registered
[  279.041322] PCI: Using configuration type 1
[  279.053074] ACPI: Interpreter enabled
[  279.053128] ACPI: Using IOAPIC for interrupt routing
[  279.055219] ACPI: PCI Root Bridge [PCI0] (0000:00)
[  279.055343] PCI: Probing PCI hardware (bus 00)
[  279.055723] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[  279.061084] Boot video device is 0000:01:07.0
[  279.061515] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[  279.109544] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[  279.112529] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[  279.115015] ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0
[  279.116022] ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0
[  279.117040] ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
[  279.118050] ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0, disabled.
[  279.119099] ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
[  279.120146] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
[  279.121181] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
[  279.122193] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0, disabled.
[  279.123240] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
[  279.124280] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
[  279.125320] ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
[  279.126360] ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
[  279.127429] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
[  279.128458] ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
[  279.129520] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
[  279.130126] ACPI: PCI Root Bridge [PCI2] (0000:08)
[  279.130181] PCI: Probing PCI hardware (bus 08)
[  279.130330] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[  279.137089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
[  279.137629] ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
[  279.139419] SCSI subsystem initialized
[  279.139687] usbcore: registered new interface driver usbfs
[  279.139874] usbcore: registered new interface driver hub
[  279.141126] usbcore: registered new device driver usb
[  279.141275] PCI: Using ACPI for IRQ routing
[  279.141328] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  279.141746] PCI-DMA: Disabling AGP.
[  279.141839] PCI-DMA: aperture base @ 4000000 size 65536 KB
[  279.141892] PCI-DMA: using GART IOMMU.
[  279.141945] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[  279.144501] PCI: Bridge: 0000:00:09.0
[  279.144553]   IO window: 2000-2fff
[  279.144605]   MEM window: c8100000-c9ffffff
[  279.144658]   PREFETCH window: 88000000-880fffff
[  279.144711] PCI: Bridge: 0000:00:0e.0
[  279.144762]   IO window: disabled.
[  279.144814]   MEM window: ca000000-ca0fffff
[  279.144867]   PREFETCH window: ca800000-d7ffffff
[  279.144925] PCI: Setting latency timer of device 0000:00:09.0 to 64
[  279.144934] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[  279.144940] PCI: Bridge: 0000:08:0a.0
[  279.144991]   IO window: disabled.
[  279.145042]   MEM window: disabled.
[  279.145093]   PREFETCH window: disabled.
[  279.145149] PCI: Bridge: 0000:08:0b.0
[  279.145198]   IO window: disabled.
[  279.145251]   MEM window: d8100000-d81fffff
[  279.145304]   PREFETCH window: 88100000-881fffff
[  279.145897] NET: Registered protocol family 2
[  279.256530] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[  279.258408] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[  279.262505] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[  279.264617] TCP: Hash tables configured (established 65536 bind 32768)
[  279.264711] TCP reno registered
[  279.265327] Simple Boot Flag at 0x36 set to 0x1
[  279.266948] microcode: CPU0 not a capable Intel processor
[  279.267030] microcode: CPU1 not a capable Intel processor
[  279.267153] microcode: CPU2 not a capable Intel processor
[  279.267291] microcode: CPU3 not a capable Intel processor
[  279.267356] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[  279.272881] SGI XFS with large block/inode numbers, no debug enabled
[  279.273920] io scheduler noop registered
[  279.274003] io scheduler anticipatory registered (default)
[  279.274118] io scheduler deadline registered
[  279.274284] io scheduler cfq registered
[  279.486101] PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
[  279.486186] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[  279.486256] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for 0000:08:0a.0 subordinate bus.
[  279.486333] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for 0000:08:0b.0 subordinate bus.
[  279.557386] Real Time Clock Driver v1.12ac
[  279.557444] Linux agpgart interface v0.101 (c) Dave Jones
[  279.557500] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  279.558052] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  279.558652] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  279.561780] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[  279.562996] loop: loaded (max 8 devices)
[  279.563048] Intel(R) PRO/1000 Network Driver - version 7.2.9-k2
[  279.563103] Copyright (c) 1999-2006 Intel Corporation.
[  279.563396] tg3.c:v3.67 (October 18, 2006)
[  279.563470] ACPI: PCI Interrupt 0000:0a:09.0[A] -> GSI 28 (level, low) -> IRQ 28
[  279.593970] eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:31:5f:ac
[  279.594232] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  279.594305] eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[  279.594411] ACPI: PCI Interrupt 0000:0a:09.1[B] -> GSI 29 (level, low) -> IRQ 29
[  279.627921] eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:31:5f:ad
[  279.628182] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  279.628255] eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[  279.628843] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  279.628901] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  279.629036] NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
[  279.629106] NFORCE-CK804: chipset revision 242
[  279.629158] NFORCE-CK804: not 100% native mode: will probe irqs later
[  279.629217] NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
[  279.629277]     ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:pio, hdb:pio
[  279.629416]     ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:pio
[  279.629552] Probing IDE interface ide0...
[  280.244638] Probing IDE interface ide1...
[  315.230991] ide1: Wait for ready failed before probe !
[  315.836959] libata version 2.00 loaded.
[  315.837066] sata_nv 0000:00:07.0: version 2.0
[  315.837804] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
[  315.837867] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 23
[  315.838403] PCI: Setting latency timer of device 0000:00:07.0 to 64
[  315.838733] ata1: SATA max UDMA/133 cmd 0x1440 ctl 0x1436 bmdma 0x1410 irq 23
[  315.838891] ata2: SATA max UDMA/133 cmd 0x1438 ctl 0x1432 bmdma 0x1418 irq 23
[  315.838965] scsi0 : sata_nv
[  316.175391] ata1: SATA link down (SStatus 0 SControl 300)
[  316.175469] scsi1 : sata_nv
[  316.504843] ata2: SATA link down (SStatus 0 SControl 300)
[  316.505656] ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 22
[  316.505719] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 22 (level, high) -> IRQ 22
[  316.506055] PCI: Setting latency timer of device 0000:00:08.0 to 64
[  316.506232] ata3: SATA max UDMA/133 cmd 0x1458 ctl 0x144E bmdma 0x1420 irq 22
[  316.506392] ata4: SATA max UDMA/133 cmd 0x1450 ctl 0x144A bmdma 0x1428 irq 22
[  316.506465] scsi2 : sata_nv
[  317.004028] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  317.004687] ata3.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/1)
[  317.004759] ata3.00: ata3: dev 0 multi count 16
[  317.005487] ata3.00: configured for UDMA/133
[  317.005544] scsi3 : sata_nv
[  317.343453] ata4: SATA link down (SStatus 0 SControl 300)
[  317.344325] scsi 2:0:0:0: Direct-Access     ATA      WDC WD1600YD-01N 10.0 PQ: 0 ANSI: 5
[  317.345270] SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
[  317.345344] sda: Write Protect is off
[  317.345395] sda: Mode Sense: 00 3a 00 00
[  317.345428] SCSI device sda: drive cache: write back
[  317.346721] SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
[  317.346794] sda: Write Protect is off
[  317.346845] sda: Mode Sense: 00 3a 00 00
[  317.346878] SCSI device sda: drive cache: write back
[  317.347108]  sda: sda1 sda2 sda3
[  317.354142] sd 2:0:0:0: Attached scsi disk sda
[  317.354542] sd 2:0:0:0: Attached scsi generic sg0 type 0
[  317.354671] USB Universal Host Controller Interface driver v3.0
[  317.354895] Initializing USB Mass Storage driver...
[  317.355054] usbcore: registered new interface driver usb-storage
[  317.355111] USB Mass Storage support registered.
[  317.355268] usbcore: registered new interface driver usbhid
[  317.355324] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  317.357957] serio: i8042 KBD port at 0x60,0x64 irq 1
[  317.358056] serio: i8042 AUX port at 0x60,0x64 irq 12
[  317.358437] mice: PS/2 mouse device common for all mice
[  317.358587] md: linear personality registered for level -1
[  317.358906] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[  317.359082] TCP cubic registered
[  317.359168] NET: Registered protocol family 1
[  317.359233] NET: Registered protocol family 17
[  317.359702] ACPI: (supports S0 S1 S4 S5)
[  317.398060] input: AT Translated Set 2 keyboard as /class/input/input0
[  318.285432] input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
[  318.353007] md: Autodetecting RAID arrays.
[  318.353059] md: autorun ...
[  318.353107] md: ... autorun DONE.
[  318.361835] EXT3-fs: INFO: recovery required on readonly filesystem.
[  318.361891] EXT3-fs: write access will be enabled during recovery.
[  320.769049] kjournald starting.  Commit interval 5 seconds
[  320.769189] EXT3-fs: sda2: orphan cleanup on readonly fs
[  320.769252] ext3_orphan_cleanup: deleting unreferenced inode 1444609
[  320.770564] ext3_orphan_cleanup: deleting unreferenced inode 1444611
[  320.770582] ext3_orphan_cleanup: deleting unreferenced inode 2611585
[  320.770821] EXT3-fs: sda2: 3 orphan inodes deleted
[  320.770873] EXT3-fs: recovery complete.
[  320.778722] EXT3-fs: mounted filesystem with ordered data mode.
[  320.779037] VFS: Mounted root (ext3 filesystem) readonly.
[  320.779181] Freeing unused kernel memory: 304k freed
[  321.294430] warning: process `showconsole' used the removed sysctl system call
[  321.663630] warning: process `showconsole' used the removed sysctl system call
[  321.807213] EXT3 (no)acl options not supported
[  321.807271] EXT3 (no)user_xattr options not supported
[  322.029072] EXT3 (no)acl options not supported
[  322.029130] EXT3 (no)user_xattr options not supported
[  322.029572] EXT3 FS on sda2, internal journal
[  322.693490] warning: process `ls' used the removed sysctl system call
[  322.694815] warning: process `ls' used the removed sysctl system call
[  322.764619] warning: process `ls' used the removed sysctl system call
[  323.789944] EXT3 (no)acl options not supported
[  323.790001] EXT3 (no)user_xattr options not supported
[  323.794042] kjournald starting.  Commit interval 5 seconds
[  323.794279] EXT3 FS on sda1, internal journal
[  323.794365] EXT3-fs: mounted filesystem with ordered data mode.
[  324.195824] XFS mounting filesystem sda3
[  324.272445] Starting XFS recovery on filesystem: sda3 (logdev: internal)
[  324.427368] Ending XFS recovery on filesystem: sda3 (logdev: internal)
[  327.851923] PM: Writing back config space on device 0000:0a:09.0 at offset b (was 164814e4, writing 164414e4)
[  327.851937] PM: Writing back config space on device 0000:0a:09.0 at offset 3 (was 804000, writing 804010)
[  327.851943] PM: Writing back config space on device 0000:0a:09.0 at offset 2 (was 2000000, writing 2000003)
[  327.851948] PM: Writing back config space on device 0000:0a:09.0 at offset 1 (was 2b00000, writing 2b00106)
[  330.623384] tg3: eth0: Link is up at 1000 Mbps, full duplex.
[  330.623389] tg3: eth0: Flow control is on for TX and on for RX.
[  469.336719] 
[  469.336721] =============================================
[  469.336728] [ INFO: possible recursive locking detected ]
[  469.336731] 2.6.19-rc3 #2
[  469.336737] ---------------------------------------------
[  469.336745] rm/4538 is trying to acquire lock:
[  469.336753]  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336782] 
[  469.336784] but task is already holding lock:
[  469.336791]  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336816] 
[  469.336817] other info that might help us debug this:
[  469.336825] 3 locks held by rm/4538:
[  469.336832]  #0:  (&inode->i_mutex/1){--..}, at: [<ffffffff80286055>] do_unlinkat+0x75/0x136
[  469.336866]  #1:  (&inode->i_mutex){--..}, at: [<ffffffff80285f98>] vfs_unlink+0x45/0x8d
[  469.336897]  #2:  (&(&ip->i_lock)->mr_lock){----}, at: [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336928] 
[  469.336929] stack backtrace:
[  469.336936] 
[  469.336938] Call Trace:
[  469.336947]  [<ffffffff8024b4cc>] __lock_acquire+0x381/0xb8c
[  469.336957]  [<ffffffff8024bf80>] lock_acquire+0x4b/0x66
[  469.336966]  [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336976]  [<ffffffff80247c97>] down_write+0x1e/0x27
[  469.336985]  [<ffffffff80320050>] xfs_ilock+0x52/0x77
[  469.336993]  [<ffffffff8033cad1>] xfs_lock_dir_and_entry+0x92/0xce
[  469.337002]  [<ffffffff8033cd23>] xfs_remove+0x216/0x44a
[  469.337013]  [<ffffffff80346c96>] xfs_vn_unlink+0x21/0x4f
[  469.337024]  [<ffffffff804a72b9>] __mutex_lock_slowpath+0x249/0x279
[  469.337034]  [<ffffffff8024aaaf>] mark_held_locks+0x65/0x84
[  469.337043]  [<ffffffff804a72b9>] __mutex_lock_slowpath+0x249/0x279
[  469.337053]  [<ffffffff8024ac7c>] trace_hardirqs_on+0x101/0x128
[  469.337062]  [<ffffffff804a72dc>] __mutex_lock_slowpath+0x26c/0x279
[  469.337072]  [<ffffffff802832d9>] permission+0xa0/0xa9
[  469.337081]  [<ffffffff80285fb4>] vfs_unlink+0x61/0x8d
[  469.337090]  [<ffffffff80286098>] do_unlinkat+0xb8/0x136
[  469.337100]  [<ffffffff804a8649>] trace_hardirqs_on_thunk+0x35/0x37
[  469.337109]  [<ffffffff8024ac7c>] trace_hardirqs_on+0x101/0x128
[  469.337118]  [<ffffffff804a8649>] trace_hardirqs_on_thunk+0x35/0x37
[  469.337129]  [<ffffffff80209a4e>] system_call+0x7e/0x83
[  469.337137] 
[  487.063562] CPU 1 is now offline
[  487.134710] Breaking affinity for irq 22
[  487.243265] CPU 2 is now offline
[  487.422969] CPU 3 is now offline
[  487.422978] lockdep: not fixing up alternatives.
[  487.472345] lockdep: not fixing up alternatives.
[  487.472637] Booting processor 1/4 APIC 0x1
[  487.483163] Initializing CPU#1
[  487.625211] Calibrating delay using timer specific routine.. 4822.28 BogoMIPS (lpj=24111431)
[  487.625217] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  487.625219] CPU: L2 Cache: 1024K (64 bytes/line)
[  487.625221] CPU 1/1 -> Node 0
[  487.625223] CPU: Physical Processor ID: 0
[  487.625225] CPU: Processor Core ID: 1
[  487.625321] Dual Core AMD Opteron(tm) Processor 280 stepping 02
[  487.635210] CPU 1: Syncing TSC to CPU 0.
[  487.635306] CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 638 cycles)
[  487.635487] microcode: CPU1 not a capable Intel processor
[  487.685423] lockdep: not fixing up alternatives.
[  487.685433] Booting processor 2/4 APIC 0x2
[  487.695710] Initializing CPU#2
[  487.844852] Calibrating delay using timer specific routine.. 4822.40 BogoMIPS (lpj=24112032)
[  487.844859] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  487.844861] CPU: L2 Cache: 1024K (64 bytes/line)
[  487.844864] CPU 2/2 -> Node 1
[  487.844866] CPU: Physical Processor ID: 1
[  487.844867] CPU: Processor Core ID: 0
[  487.844978] Dual Core AMD Opteron(tm) Processor 280 stepping 02
[  487.854844] CPU 2: Syncing TSC to CPU 0.
[  487.855026] CPU 2: synchronized TSC with CPU 0 (last diff -17 cycles, maxerr 1238 cycles)
[  487.855237] microcode: CPU2 not a capable Intel processor
[  487.904974] lockdep: not fixing up alternatives.
[  487.904984] Booting processor 3/4 APIC 0x3
[  487.915261] Initializing CPU#3
[  488.064492] Calibrating delay using timer specific routine.. 4822.42 BogoMIPS (lpj=24112120)
[  488.064500] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  488.064502] CPU: L2 Cache: 1024K (64 bytes/line)
[  488.064504] CPU 3/3 -> Node 1
[  488.064507] CPU: Physical Processor ID: 1
[  488.064508] CPU: Processor Core ID: 1
[  488.064619] Dual Core AMD Opteron(tm) Processor 280 stepping 02
[  488.074489] CPU 3: Syncing TSC to CPU 0.
[  488.074673] CPU 3: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 1239 cycles)
[  488.074875] microcode: CPU3 not a capable Intel processor
[  488.264171] CPU 1 is now offline
[  488.264267] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
[  488.264271]  [<ffffffff8025d255>] __drain_pages+0x33/0x7d
[  488.264288] PGD 2753ae067 PUD 275f66067 PMD 0 
[  488.264302] Oops: 0000 [1] PREEMPT SMP 
[  488.264315] CPU 2 
[  488.264323] Modules linked in:
[  488.264332] Pid: 7617, comm: sh Not tainted 2.6.19-rc3 #2
[  488.264339] RIP: 0010:[<ffffffff8025d255>]  [<ffffffff8025d255>] __drain_pages+0x33/0x7d
[  488.264353] RSP: 0018:ffff81016dd3fdf8  EFLAGS: 00010046
[  488.264358] RAX: 0000000000000000 RBX: 0000000000000086 RCX: 0000000000000000
[  488.264366] RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffff810180000000
[  488.264373] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000001
[  488.264381] R10: ffffffff8025cb12 R11: 0000000000000000 R12: ffff810180000000
[  488.264389] R13: 0000000000000001 R14: 0000000000000001 R15: ffff81027a7e5998
[  488.264397] FS:  00002af4d80a5ae0(0000) GS:ffff81018001ad18(0000) knlGS:0000000000000000
[  488.264405] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  488.264412] CR2: 0000000000000000 CR3: 00000002767bf000 CR4: 00000000000006a0
[  488.264420] Process sh (pid: 7617, threadinfo ffff81016dd3e000, task ffff81016e03d080)
[  488.264427] Stack:  0000000000000001 0000000000000001 0000000000000007 0000000000000001
[  488.264448]  000000000000000f ffffffff8025e771 ffffffff80538860 ffffffff8023e3c2
[  488.264466]  0000000000000001 0000000000000001 ffff81016e11a0c0 ffffffff8024ff50
[  488.264481] Call Trace:
[  488.264490]  [<ffffffff8025e771>] page_alloc_cpu_notify+0x18/0x33
[  488.264500]  [<ffffffff8023e3c2>] notifier_call_chain+0x23/0x32
[  488.264509]  [<ffffffff8024ff50>] _cpu_down+0x184/0x245
[  488.264516]  [<ffffffff8025003c>] cpu_down+0x2b/0x42
[  488.264525]  [<ffffffff803b25b8>] store_online+0x27/0x71
[  488.264534]  [<ffffffff802b7b4a>] sysfs_write_file+0xb6/0xe5
[  488.264544]  [<ffffffff8027c6e5>] vfs_write+0xb2/0x155
[  488.264551]  [<ffffffff8027c83d>] sys_write+0x45/0x70
[  488.264560]  [<ffffffff80209a4e>] system_call+0x7e/0x83
[  488.264566] 
[  488.264570] 
[  488.264572] Code: 8b 75 00 4c 89 e7 e8 82 f8 ff ff f6 c7 02 c7 45 00 00 00 00 
[  488.264634] RIP  [<ffffffff8025d255>] __drain_pages+0x33/0x7d
[  488.264644]  RSP <ffff81016dd3fdf8>
[  488.264650] CR2: 0000000000000000
[  488.264655]  

--KFztAG8eRSV9hGtP
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
zRP9YtH3Lz8BzJ9MM/FqAAA=

--KFztAG8eRSV9hGtP--
