Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVBQFmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVBQFmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 00:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVBQFmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 00:42:00 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:52185 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262220AbVBQFlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 00:41:53 -0500
Date: Thu, 17 Feb 2005 14:41:55 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: discuss@x86-64.org
Subject: [BUG][x86-64]nmi_watchdog is not available
Cc: linux-kernel@vger.kernel.org, oda@valinux.co.jp
Message-Id: <20050217141942.4C85.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

nmi_watchdog is not available on my amd64 machine.
---
activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#1: NMI appears to be stuck (0)!
---
at least 2.6.9 and later, also 2.6.11-rc3-mm2.

My investigation: this seems a sequence problem between the boot cpu
and the secondary cpu.

--- boot cpu ---
smp_boot_cpus
  + ...
  + setup_IO_APIC
     + check_timer
         + check_nmi_watchdog   (2)
  + ...
  + synchronize_tsc_bp  (3)
----------------

--- secondary cpu ---
start_secondary
  + smp_callin
      + cpu_set(cpuid, cpu_callin_map)
      + syncronize_tsc_ap   (1) ... wait (3)
  + enable_NMI_through_LVT0   (4)
---------------------

check_nmi_watchdog(2) runs before enabling NMI(4). 
(where cpu_callin_map is already set)

console log is attached. 
(line marked "<===== #### debuging" are my debugging printk)

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

---
Bootdata ok (command line is ro root=/dev/hda5 3 console=tty0 console=ttyS0,38400n8r nmi_watchdog=1)
Linux version 2.6.11-rc2-mm2 (root@fas-opteronR) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-20)) #9 SMP Thu Feb 10 17:59:20 JST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fbf70000 (usable)
 BIOS-e820: 00000000fbf70000 - 00000000fbf76000 (ACPI data)
 BIOS-e820: 00000000fbf76000 - 00000000fbf80000 (ACPI NVS)
 BIOS-e820: 00000000fbf80000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
On node 0 totalpages: 2097152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 2093056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: AMD      <6>Product ID: HAMMER       <6>APIC at: 0xFEE00000
Processor #0 15:5 APIC version 16
Processor #1 15:5 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFC000000.
I/O APIC #4 Version 17 at 0xFC001000.
Setting APIC routing to flat
Processors: 2
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ c000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/hda5 3 console=tty0 console=ttyS0,38400n8r nmi_watchdog=1
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1403.233 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 8111624k/8388608k available (2325k kernel code, 210112k reserved, 1143k data, 192k init)
Calibrating delay loop... 2752.51 BogoMIPS (lpj=1376256)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 240 stepping 08
per-CPU timeslice cutoff: 1023.91 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp ffff810008027f58
Initializing CPU#1
Start SMP Callin       <========== #### debugging
Calibrating delay loop... 2801.66 BogoMIPS (lpj=1400832)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Start synchronize tsc ap  <============= #### debugging
AMD Opteron(tm) Processor 240 stepping 08
Total of 2 processors activated (5554.17 BogoMIPS).
Using IO-APIC 2
Using IO-APIC 3
Using IO-APIC 4
activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#1: NMI appears to be stuck (0)!
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
checking TSC synchronization across 2 CPUs: Finish synchronize tsc ap <====
Finish SMP Callin                                 <======================== #### debugging
passed.
time.c: Using PIT/TSC based timekeeping.
Disabling 8259A                          <=====
Enabling NMI through LVTO                <=====  #### debugging
Enabling 8259A                           <=====
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000001 00000002
CPU1 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000002 00000001

