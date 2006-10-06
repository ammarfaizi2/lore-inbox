Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWJFQVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWJFQVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWJFQVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:21:00 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:55337 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751391AbWJFQU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:20:59 -0400
Date: Fri, 6 Oct 2006 18:20:54 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061006162054.GF14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006155021.GE14186@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 05:50:21PM +0200, Muli Ben-Yehuda wrote:

> > What happens if you boot with max_cpus=1?
> 
> Trying it now... woohoo, it boots all the way and stays up!

Ok, after verifying that maxcpus=1 causes the problematic changeset to
boot, I also tried maxcpus=1 with the tip of the tree. I hit this NULL
pointer dereference in profile_tick, with and without
maxcpus=1. Disassembly says that get_irq_regs() is returning NULL,
which may or may not be related to the genirq issue.

kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1 9200 maxcpus=1
   [Linux-bzImage, setup=0x1c00, size=0x2e44df]
initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz
   [Linux-initrd @ 0x37e3f000, 0x1b0188 bytes] savedefault
                                                                                
[    0.000000] Linux version 2.6.19-rc1mx (muli@rhun) (gcc version 3.4.1) #154 S MP Fri Oct 6 17:57:51 IST 2006
[    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200 max cpus=1
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
[    0.000000]  BIOS-e820: 00 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
[    0.000000] end_pfn_map = 1671168
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1671168
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      153
[    0.000000]     0:      256 ->   950172
[    0.000000]     0:  1048576 ->  1671168
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
[    0.000000] Processor #6
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
[    0.000000] Processor #7
[    0.000000] ACPI: LAPIC_NMI APIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id 14, address 0xfec01000, GSI 35-70
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 0000000000099000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
[    0.000000] Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
[    0.000000] Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
[    0.000000] Nosave address range: 00000000e7fa7000 - 00000000e8000000
[    0.000000] Nosave address range: 00000000e8000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at ea000000 (gap: e8000000:16c0 0000)
[    0.000000] PERCPU: Allocating 34432 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 1534050
[    0.000000] Kernel command line: root=/dev/sda2 console=tty0 console=ttyS1,19 200 maxcpus=1
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[  166.530409] Console: colour VGA+ 80x25
[  168.479402] L         1024
[  168.629696] ... MAX_LOCKDEP_ENTRIES:     8192
[  168.655898] ... MAX_LOCKDEP_CHAINS:      8192
[  168.682097] ... CHAINHASH_SIZE:          4096
[  168.708299]  memory used by lock dependency info: 1328 kB
[  168.74[  168.924070] PCI-DMA: Calgary IOMMU detected.
[  168.949728] PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabl ed.
[  169.111284] Memory: 6096436k/6684672k available (3788k kernel code, 193708k r eserved, 2727k data, 276k init)
[  169.249201] Calibrating delay using timer specific routine.. 6346.40 BogoMIPS  (lpj=12692802)
[  169.300193] Mount-cache hash table entries: 256
[  169.329043] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  169.360565] CPU: L2 cache: 1024K
[  169.379968] using mwait in idle threads.
[  169.403574] CPU: Physical Processor ID: 0
[  169.427697] CPU: Processor Core ID: 0
[  169.449745] CPU0: Thermal monitoring enabled (TM1)
[  169.478556] Freeing SMP alternatives: 32k freed
[  169.505811] ACPI: Core revision 20060707
[  169.576566] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  169.651600] Using local APIC timer interrupts.
[  169.709847] result 10425453
[  169.726643] Detected 10.425 MHz APIC timer.
[  169.753344] Brought up 1 CPUs
[  169.771342] Unable to handle kernel NULL pointer dereference at 0000000000000 088 RIP:
[  169.804240]  [<ffffffff8022de57>] profile_tick+0x34/0x6a
[  169.851061] PGD 0
[  169.863259] Oops: 0000 [1] SMP
[  169.882391] CPU 0
[  169.894607] Modules linked in:
[  169.913117] Pid: 1, comm: swapper Not tainted 2.6.19-rc1mx #154
[  169.948655] RIP: 0010:[<ffffffff8022de57>]  [<ffffffff8022de57>] profile_tick +0x34/0x6a
[  169.996876] RSP: 0000:ffffffff808d8f78  EFLAGS: 00010046
[  170.028766] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  170.071615] RDX: ffff8100893f5f00 RSI: 0000000000000000 RDI: 0000000000000001
[  170.114451] RBP: ffffffff808d8f88 R08: 0000000000000002 R09: ffffffff8022d24a
[  170.157290] R10: ffffffff8022d24a R11: ffffffff80732780 R12: 0000000000000001
[  170.200134] R13: ffffffff808e8d75 R14: 0000000000000246 R15: 0000000000000012
[  170.242975] FS:  0000000000000000(0000) GS:ffffffff8085e000(0000) knlGS:00000 00000000000
[  170.291576] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  170.326102] CR2: 0000000000000088 CR3: 0000000000201000 CR4: 00000000000006e0
[  170.368947] Process swapper (pid: 1, threadinfo ffff810197c7c000, task ffff81 0197c67040)
[  170.417545] Stack:  ffffffff807327c0 0000000000000012 ffffffff808d8f98 ffffff ff8021507e
[  170.466126] upt+0xe/0x54
[  170.616246]  [<ffffffff80215108>] smp_apic_timer_interrupt+0x44/0x4b
[  170.654411]  [<ffffffff8020a4fb>] apic_timer_interrupt+0x6b/0x70
[  170.690486]  <EOI>  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  170.730351]  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  18a65>] atomic_notifier_chain_register+0x33/0x3e
[  170.937284]  [<ffffffff808a3359>] spawn_softlockup_task+0x6a/0x6f
[  170.973876]  [<ffffffff80207116>] init+0xce/0x30c
[  171.002152]  [<ffffffff805afd00>] trace_hardirqs_on_thunk+0x35/0x37
[  171.039796]  [<ffffffff80244952>] trace_hardirqs_on+0xf6/0x11a
[  171.074833]  [<ffffffff8020a6e5>] child_rip+0xa/0x15
[  171.104669]  [<ffffffff805b0484>] _spin_unlock_irq+0x29/0x2f
[  171.138667]  [<ffffffff80209e5d>] restore_args+0x0/0x30
[  171.170065]  [<ffffffff80207048>] init+0x0/0x30c
[  171.197821]  [<ffffffff8020a6db>] child_rip+0x0/0x15
[  171.227660]
[  171.236634]
[  171.236635] Code: f6 83 88 00 00 00 03 75 28 65 8b 04 25 24 00 00 00 0f a3 05                                                                                 
[  171.291160] RIP  [<ffffffff8022de57>] profile_tick+0x34/0x6a
[  171.325282]  RSP <ffffffff808d8f78>
[  171.346230] CR2: 0000000000000088
[  171.366141]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
[  171.408520]  <1>Unable to handle kernel NULL pointer d tainted 2.6.19-rc1mx # 154
[  171.587988] RIP: 0010:[<ffffffff8022de57>]  [<ffffffff8022de57>] profile_tick +0x34/0x6a
[  171.636213] RSP: 0000:ffffffff808d8ba8  EFLAGS: 00010046
[  171.668098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  171.710945] RDX: ffff8100893f5f00 RSI: 0000000000000001 RDI: 0000000000000001
[  171.753781] RBP: ffffffff808d8bb8 R08: 0000000000000002 R09: ffffffff80214925
[  171.796617] R10: ffffffff80732780 R11: ffffffff807307e0 R12: 0000000000000001
[  171.839455] R13: ffffffff808d8ec8 R14: 0000000000000000 R15: 0000000000000009
[  171.882291] FS:  0000000000000000(0000) GS:ffffffff8085e000(0000) knlGS:00000 00000000000
[  171.930894] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  171.965414] CR2: 0000000000000088 CR3: 0000000000201000 CR4: 00000000000006e0
[  172.008261] Process swapper (pid: 1, threadinfo ffff810197c7c000, task ffff81 0197c67040)
[  172.056859] Stack:  ffffffff805eec32 0000000000000000 ffffffff808d8bc8 ffffff ff8021507e
[  172.105444]  ffffffff808d8bd8 ffffffff80215108 ffffffff808d8bf0 ffffffff8020a 4fb
[  172.150309]  ffffffff808d8bf0 ffffffff808d8c78 ffffffff807307e0 ffffffff80732 780
[  172.193985] Call Trace:
[  172.209895]  <IRQ>  [<ffffffff8021507e>] smp_local_timer_interrupt+0xe/0x54
[  172.251805]  [<ffffffff80215108>] smp_apic_timer_interrupt+0x44/0x4b
[  172.289972]  [<ffffffff8020a4fb>] apic_timer_interrupt+0x6b/0x70
[  172.326049]  [<ffffffff80214925>] smp_send_stop+0x24/0x62
[  172.358484]  [<ffffffff8021495f>] smp_send_stop+0x5e/0x62
[  172.390927]  [<ffffffff8022c938>] panic+0xe0/0x195
[  172.419721]  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  172.455808]  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  172.491892]  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  172.527973]  [<ffffffff8022f1b8>] do_exit+0x96/0x87e
[  172.557810]  [<ffffffff802f8022de57>] profile_tick+0x34/0x6a
[  172.725730]  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  172.761811]  [<ffem+0x47/0x200
[  172.914073]  [<ffffffff8022d24a>] release_console_sem+0x47/0x200
[  172.950159]  [<ffffffff8022d72e>] vprintk+0x316/0x32e
[  172.980515]  [<ffffffff8022d731>] vprintk+0x319/0x32e
[  173.010877]  [<ffffffff8024426d>] mark_lock+0x8a/0x55d
[  173.041758]  [<ffffffff8022d7e8>] printk+0xa2/0xa4
[  173.070560]  [<ffffffff80238a65>] atomic_notifier_chain_register+0x33/0x3e
[  173.111850]  [<ffffffff808a3359>] spawn_softlockup_task+0x6a/0x6f
[  173.148440]  [<ffffffff80207116>] init+0xce/0x30c
[  173.176714]  [<ffffffff805afd00>] trace_hardirqs_on_thunk+0x35/0x37
[  173.214309]  [<ffffffff80244952>] trace_hardirqs_on+0xf6/0x11a
[  173.249347]  [<ffffffff8020a6e5>] child_rip+0xa/0x15
[  173.279184]  [<ffffffff805b0484>] _spin_unlock_irq+0x29/0x2f
[  173.313189]  [<ffffffff80209e5d>] restore_args+0x0/0x30
[  173.344587]  [<ffffffff80207048>] init+0x0/0x30c
[  173.372347]  [<ffffffff8020a6db>] child_rip+0x0/0x15
[  173.402138]
[  173.411114]
[  173.411114] Code: f6 83 88 00 00 00 03 75 28 65 8b 04 25 24 00 0
