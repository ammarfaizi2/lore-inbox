Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265965AbUF2TUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUF2TUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUF2TUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:20:39 -0400
Received: from gobelins-3-82-67-192-40.fbx.proxad.net ([82.67.192.40]:46651
	"EHLO pop.free.fr") by vger.kernel.org with ESMTP id S265965AbUF2TT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:19:28 -0400
X-Spam-Filter: check_local@pop.free.fr by digitalanswers.org
Message-ID: <40E1C0B1.7060704@httrack.com>
Date: Tue, 29 Jun 2004 21:19:13 +0200
From: Xavier Roche <guest+roche@httrack.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aggressive random read/write on large files == oops (page allocation
 failure)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We (exalead.com) are encountering oops'es and then a partial filesystem 
hang (ls /proc freezes, ls in other directories also freezes randomly, 
the machine is "half dead") when agressively accessing random data 
through large mapped (mmap) memory areas. The system apparently oops'ed 
while failing to allocate memory somewhere in xfs.

The kernel first message is:
"kswapd0: page allocation failure. order:5, mode:0x50"
(see complete dump below)

The only notable running process was a single process mapping ~100 GB of 
data, doing aggressively:
- random read(2) i/o on a 5 GB file
- random read/write accesses in the mapped data
- all on the large xfs filesystem.

Could it be a VM problem (no more available pages due to aggressive 
access to mmap'ed memory ?) or a synchronization problem ? Any 
hint/suggestion is welcome - and we can issue more tests with 
symbols-enabled kernel.

The machine hardware is a dual opteron system (IBM eServer 325) with 6 
GB RAM, running a  Gentoo with standard kernel 2.6.7, 650 GB xfs 
filesystem on lvm on a IBM ServerRaid 6m raid controler.

This problem may be related to the other problem reported by Mikael 
Wahlberg several months ago (same circumstances, same raid card, on a 
2.6 kernel), but the oops dosn't looks similar at all:
<http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=1s4by-6aJ-11%40gated-at.bofh.it>
Mikael Wahlberg told me that the problem occured another time while 
running a database on XFS. But the problem might nor be related at all 
to XFS (we will try to run tests on a regular EXT3)

The complete kern.log traces (no other traces  minutes before or after):

Jun 26 21:23:33 ng5 kswapd0: page allocation failure. order:5, mode:0x50
Jun 26 21:23:33 ng5
Jun 26 21:23:33 ng5 Call Trace:<ffffffff80159aa3>{__alloc_pages+803} 
<ffffffff80159af5>{__get_free_pages+37}
Jun 26 21:23:33 ng5 <ffffffff8015d923>{kmem_getpages+35} 
<ffffffff801f0b78>{xfs_alloc_update+88}
Jun 26 21:23:33 ng5 <ffffffff8015e950>{cache_grow+256} 
<ffffffff8015ede9>{cache_alloc_refill+569}
Jun 26 21:23:33 ng5 <ffffffff8015f5de>{__kmalloc+94} 
<ffffffff80221556>{xfs_iext_realloc+518}
Jun 26 21:23:33 ng5 <ffffffff801fbc03>{xfs_bmap_insert_exlist+51} 
<ffffffff801fa050>{xfs_bmap_add_extent_hole_real+912}
Jun 26 21:23:33 ng5 <ffffffff801f8035>{xfs_bmap_add_extent+533} 
<ffffffff80202aa9>{xfs_bmbt_get_state+9}
Jun 26 21:23:34 ng5 <ffffffff801fd9ec>{xfs_bmapi+2268} 
<ffffffff80226980>{xfs_log_release_iclog+16}
Jun 26 21:23:34 ng5 <ffffffff802240ce>{xfs_iomap_write_direct+590} 
<ffffffff802ffbde>{__split_bio+270}
Jun 26 21:23:34 ng5 <ffffffff80223c96>{xfs_iomap+582} 
<ffffffff801333d0>{autoremove_wake_function+0}
Jun 26 21:23:34 ng5 <ffffffff8023f333>{xfs_map_blocks+99} 
<ffffffff80240198>{xfs_page_state_convert+856}
Jun 26 21:23:34 ng5 <ffffffff8017f910>{alloc_buffer_head+64} 
<ffffffff8017ced6>{create_buffers+102}
Jun 26 21:23:34 ng5 <ffffffff80240850>{linvfs_writepage+176} 
<ffffffff80162261>{pageout+177}
Jun 26 21:23:34 ng5 <ffffffff8016267a>{shrink_list+954} 
<ffffffff801613b3>{__pagevec_lru_add+307}
Jun 26 21:23:34 ng5 <ffffffff80162bf2>{shrink_cache+690} 
<ffffffff80163a74>{balance_pgdat+388}
Jun 26 21:23:34 ng5 <ffffffff801331f4>{prepare_to_wait+4} 
<ffffffff80163c5a>{kswapd+282}
Jun 26 21:23:34 ng5 <ffffffff801333d0>{autoremove_wake_function+0} 
<ffffffff8012eea9>{finish_task_switch+105}
Jun 26 21:23:34 ng5 <ffffffff801333d0>{autoremove_wake_function+0} 
<ffffffff8012ef11>{schedule_tail+17}
Jun 26 21:23:34 ng5 <ffffffff8010fa47>{child_rip+8} 
<ffffffff80163b40>{kswapd+0}
Jun 26 21:23:34 ng5 <ffffffff8010fa3f>{child_rip+0}
Jun 26 21:23:34 ng5 Unable to handle kernel paging request at 
000000000000ffff RIP:
Jun 26 21:23:34 ng5 <ffffffff8025a56e>{memmove+46}
Jun 26 21:23:34 ng5 PML4 fa9d6067 PGD faad3067 PMD 0
Jun 26 21:23:34 ng5 Oops: 0000 [1] PREEMPT SMP
Jun 26 21:23:34 ng5 CPU 0
Jun 26 21:23:34 ng5 Modules linked in: uhci_hcd ehci_hcd ohci_hcd 
usbcore tg3
Jun 26 21:23:34 ng5 Pid: 54, comm: kswapd0 Not tainted 2.6.7-gentoo-r3
Jun 26 21:23:34 ng5 RIP: 0010:[<ffffffff8025a56e>] 
<ffffffff8025a56e>{memmove+46}
Jun 26 21:23:34 ng5 RSP: 0018:000001017fea7510  EFLAGS: 00010602
Jun 26 21:23:34 ng5 RAX: 0000000000020000 RBX: 0000000000000d7d RCX: 
0000000000002830
Jun 26 21:23:34 ng5 RDX: 0000000000002830 RSI: 000000000000ffff RDI: 
000000000001000f
Jun 26 21:23:34 ng5 RBP: 000001017fea7788 R08: 000000000000d7e0 R09: 
0000000000000000
Jun 26 21:23:34 ng5 R10: 00000000ffffffff R11: 0000000000000000 R12: 
0000000000000d7e
Jun 26 21:23:34 ng5 R13: 0000000000000000 R14: 0000000000000d7d R15: 
000001017fea7788
Jun 26 21:23:34 ng5 FS:  0000000044a7f960(0000) 
GS:ffffffff805004c0(0000) knlGS:0000000000000000
Jun 26 21:23:34 ng5 CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Jun 26 21:23:34 ng5 CR2: 000000000000ffff CR3: 0000000000101000 CR4: 
00000000000006e0
Jun 26 21:23:34 ng5 Process kswapd0 (pid: 54, threadinfo 
000001017fea6000, task 00000100048e8130)
Jun 26 21:23:34 ng5 Stack: ffffffff801fbc34 0000000000000030 
0000010004fed7d0 0000000000000d7d
Jun 26 21:23:34 ng5 000001015e9ceb18 000001015e9cea88 ffffffff801fa050 
000000007fc94800
Jun 26 21:23:34 ng5 000001017fea7644 000001013f595990
Jun 26 21:23:34 ng5 Call 
Trace:<ffffffff801fbc34>{xfs_bmap_insert_exlist+100} 
<ffffffff801fa050>{xfs_bmap_add_extent_hole_real+912}
Jun 26 21:23:34 ng5 <ffffffff801f8035>{xfs_bmap_add_extent+533} 
<ffffffff80202aa9>{xfs_bmbt_get_state+9}
Jun 26 21:23:34 ng5 <ffffffff801fd9ec>{xfs_bmapi+2268} 
<ffffffff80226980>{xfs_log_release_iclog+16}
Jun 26 21:23:34 ng5 <ffffffff802240ce>{xfs_iomap_write_direct+590} 
<ffffffff802ffbde>{__split_bio+270}
Jun 26 21:23:34 ng5 <ffffffff80223c96>{xfs_iomap+582} 
<ffffffff801333d0>{autoremove_wake_function+0}
Jun 26 21:23:34 ng5 <ffffffff8023f333>{xfs_map_blocks+99} 
<ffffffff80240198>{xfs_page_state_convert+856}
Jun 26 21:23:34 ng5 <ffffffff8017f910>{alloc_buffer_head+64} 
<ffffffff8017ced6>{create_buffers+102}
Jun 26 21:23:34 ng5 <ffffffff80240850>{linvfs_writepage+176} 
<ffffffff80162261>{pageout+177}
Jun 26 21:23:34 ng5 <ffffffff8016267a>{shrink_list+954} 
<ffffffff801613b3>{__pagevec_lru_add+307}
Jun 26 21:23:34 ng5 <ffffffff80162bf2>{shrink_cache+690} 
<ffffffff80163a74>{balance_pgdat+388}
Jun 26 21:23:34 ng5 <ffffffff801331f4>{prepare_to_wait+4} 
<ffffffff80163c5a>{kswapd+282}
Jun 26 21:23:34 ng5 <ffffffff801333d0>{autoremove_wake_function+0} 
<ffffffff8012eea9>{finish_task_switch+105}
Jun 26 21:23:34 ng5 <ffffffff801333d0>{autoremove_wake_function+0} 
<ffffffff8012ef11>{schedule_tail+17}
Jun 26 21:23:34 ng5 <ffffffff8010fa47>{child_rip+8} 
<ffffffff80163b40>{kswapd+0}
Jun 26 21:23:34 ng5 <ffffffff8010fa3f>{child_rip+0}
Jun 26 21:23:34 ng5
Jun 26 21:23:34 ng5 Code: f3 a4 fc 4c 89 c0 c3 90 90 90 90 90 90 90 90 
90 90 90 49 89
Jun 26 21:23:34 ng5 RIP <ffffffff8025a56e>{memmove+46} RSP 
<000001017fea7510>
Jun 26 21:23:34 ng5 CR2: 000000000000ffff

lsmod ouput:
Module                  Size  Used by
uhci_hcd               34912  0
ehci_hcd               32196  0
ohci_hcd               23556  0
usbcore               127800  5 uhci_hcd,ehci_hcd,ohci_hcd
tg3                    88004  0

lspci :
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethe
rnet (rev 03)
02:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethe
rnet (rev 03)
02:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-
MPT Dual Ultra320 SCSI (rev 07)
03:03.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 02)
04:08.0 RAID bus controller: Adaptec ServeRAID Controller (rev 02)

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 8
cpu MHz         : 1994.075
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3940.35
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 8
cpu MHz         : 1994.075
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3981.31
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

$ cat /proc/meminfo
MemTotal:      6068788 kB
MemFree:         12644 kB
Buffers:         22684 kB
Cached:        3241376 kB
SwapCached:     612620 kB
Active:        2991888 kB
Inactive:      2835580 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      6068788 kB
LowFree:         12644 kB
SwapTotal:    11727440 kB
SwapFree:     10055068 kB
Dirty:             376 kB
Writeback:           0 kB
Mapped:        4760732 kB
Slab:            73144 kB
Committed_AS:  4109240 kB
PageTables:     132044 kB
VmallocTotal: 536870911 kB
VmallocUsed:      6048 kB
VmallocChunk: 536864859 kB




