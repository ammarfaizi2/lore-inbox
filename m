Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWEKCIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWEKCIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWEKCIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:08:52 -0400
Received: from paragon.brong.net ([66.232.154.163]:23236 "EHLO
	paragon.brong.net") by vger.kernel.org with ESMTP id S1751228AbWEKCIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:08:51 -0400
Date: Thu, 11 May 2006 12:08:08 +1000
From: Bron Gondwana <brong@fastmail.fm>
To: linux-kernel@vger.kernel.org
Subject: OOM Killer firing when plenty of memory left and no swap used
Message-ID: <20060511020808.GA6126@brong.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: brong.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A fairly new server just went into semi-frozen mode
where it was still responding to pings but connections
were failing.  It still appears to have been sending
heartbeat UDP packets as well because its 'partner'
didn't pick up services until it was manually rebooted.

I'm not anywhere near the machine, so I was unable to
do anything other than request a remote reboot.  The
console was being spammed with messages too fast to use
over KVM and Ctrl-Alt-Del didn't work.  Alt-F2 did, but
then the new console got the messages which didn't help
much.

I hope someone can shed some light on what could possibly
have caused the oom-killer to engage with so much free
memory.  These machines do have a lot of TCP connections
through them (nginx IMAP proxies holding ~20,000 open
connections plus a couple of hundred Apache processes
running mod_accel forwarding to backend web servers).
We run a pair of servers with heartbeat from linux-ha.org
in active-active configuration with two IPs per hostname,
generally one on each machine.  The other server seems to
be fine and has picked up the double load while we debug
this server with no problems.

The hosts are fairly new IBM 1U servers:
8837E3U   	 X336 EXPRESS INTEL XEON 3.2GHZ

lspci output:
0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 0c)
0000:00:00.1 ff00: Intel Corp. Memory Controller Hub Error Reporting Register (rev 0c)
0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A0 (rev 0c)
0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B0 (rev 0c)
0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port C0 (rev 0c)
0000:00:07.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port C1 (rev 0c)
0000:00:08.0 System peripheral: Intel Corp. Memory Controller Hub Extended Configuration Registers (rev 0c)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:01:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
0000:03:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
0000:03:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
0000:04:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)
0000:06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
0000:07:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)

Verbose at:
http://linux.brong.fastmail.fm/2006-05-11/lspci-v.txt

Console snapshot while it was hung:
http://linux.brong.fastmail.fm/2006-05-11/hb1_crash.png

Output of free logged by our monitoring process 1 minute
before the first failure:

Checking memory
             total       used       free     shared    buffers     cached
Mem:       4149468    3275688     873780          0       9580    1419372
-/+ buffers/cache:    1846736    2302732
Swap:      2048276          4    2048272
Swap free: 2048272 (of 2048276)
heartbeat1.internal:CheckSwapFree passed at Wed May 10 19:56:02 2006

Log messages from the first failure:
May 10 19:57:00 heartbeat1 kernel: oom-killer: gfp_mask=0xd0, order=1
May 10 19:57:00 heartbeat1 kernel:  [out_of_memory+180/209] out_of_memory+0xb4/0xd1
May 10 19:57:00 heartbeat1 kernel:  [__alloc_pages+623/795] __alloc_pages+0x26f/0x31boom-killer: gfp_mask=0xd0, order=1
May 10 19:57:00 heartbeat1 kernel:  [out_of_memory+180/209] out_of_memory+0xb4/0xd1
May 10 19:57:00 heartbeat1 kernel:  [__alloc_pages+623/795] __alloc_pages+0x26f/0x31b
May 10 19:57:00 heartbeat1 kernel:  [kmem_getpages+52/155] kmem_getpages+0x34/0x9b
May 10 19:57:00 heartbeat1 kernel:  [cache_grow+190/375] cache_grow+0xbe/0x177
May 10 19:57:00 heartbeat1 kernel:  [cache_alloc_refill+354/523] cache_alloc_refill+0x162/0x20b
May 10 19:57:00 heartbeat1 kernel:  [kmem_cache_alloc+103/127] kmem_cache_alloc+0x67/0x7f
May 10 19:57:00 heartbeat1 kernel:  [dup_task_struct+69/153] dup_task_struct+0x45/0x99
May 10 19:57:00 heartbeat1 kernel:  [copy_process+94/3348] copy_process+0x5e/0xd14
May 10 19:57:00 heartbeat1 kernel:  [do_fork+105/395] do_fork+0x69/0x18b
May 10 19:57:00 heartbeat1 kernel:  [sys_rt_sigprocmask+161/256] sys_rt_sigprocmask+0xa1/0x100
May 10 19:57:00 heartbeat1 kernel:  [sys_clone+62/66] sys_clone+0x3e/0x42
May 10 19:57:00 heartbeat1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 10 19:57:00 heartbeat1 kernel: DMA per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 2 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 2 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 3 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 3 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: DMA32 per-cpu: empty
May 10 19:57:00 heartbeat1 kernel: Normal per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 186, batch 31 used:173
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 62, batch 15 used:49
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 186, batch 31 used:47
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 62, batch 15 used:47
May 10 19:57:00 heartbeat1 kernel: cpu 2 hot: high 186, batch 31 used:39
May 10 19:57:00 heartbeat1 kernel: cpu 2 cold: high 62, batch 15 used:59
May 10 19:57:00 heartbeat1 kernel: cpu 3 hot: high 186, batch 31 used:27
May 10 19:57:00 heartbeat1 kernel: cpu 3 cold: high 62, batch 15 used:53
May 10 19:57:00 heartbeat1 kernel: HighMem per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 186, batch 31 used:54
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 62, batch 15 used:5
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 186, batch 31 used:19
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 62, batch 15 used:9
May 10 19:57:00 heartbeat1 kernel: cpu 2 hot: high 186, batch 31 used:129
May 10 19:57:00 heartbeat1 kernel: cpu 2 cold: high 62, batch 15 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 3 hot: high 186, batch 31 used:76
May 10 19:57:00 heartbeat1 kernel: cpu 3 cold: high 62, batch 15 used:0
May 10 19:57:00 heartbeat1 kernel: Free pages:      866208kB (833840kB HighMem)
May 10 19:57:00 heartbeat1 kernel: Active:513907 inactive:93944 dirty:14687 writeback:0 unstable:0 free:216552 slab:206727 mapped:255278 pagetables:3041
May 10 19:57:00 heartbeat1 kernel: DMA free:8092kB min:4568kB low:5708kB high:6852kB active:0kB inactive:48kB present:16384kB pages_scanned:28 all_unreclaimable? no
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 880 4720
May 10 19:57:00 heartbeat1 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 880 4720
May 10 19:57:00 heartbeat1 kernel: Normal free:24276kB min:26732kB low:33412kB high:40096kB active:2256kB inactive:1940kB present:901120kB pages_scanned:6457 all_unreclaimable? yes
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 0 30720
May 10 19:57:00 heartbeat1 kernel: HighMem free:833840kB min:512kB low:12652kB high:24792kB active:2053372kB inactive:373788kB present:3932160kB pages_scanned:0 all_unreclaimable? no
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 0 0
May 10 19:57:00 heartbeat1 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 1*4096kB = 8092kB
May 10 19:57:00 heartbeat1 kernel: DMA32: empty
May 10 19:57:00 heartbeat1 kernel: Normal: 51*4kB 21*8kB 16*16kB 3*32kB 2*64kB 3*128kB 2*256kB 0*512kB 0*1024kB 1*2048kB 5*4096kB = 24276kB
May 10 19:57:00 heartbeat1 kernel: HighMem: 127120*4kB 33498*8kB 2326*16kB 104*32kB 35*64kB 16*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 3*4096kB = 833840kB
May 10 19:57:00 heartbeat1 kernel: Swap cache: add 9310, delete 6286, find 1156/1535, race 0+0
May 10 19:57:00 heartbeat1 kernel: Free swap  = 2025876kB
May 10 19:57:00 heartbeat1 kernel: Total swap = 2048276kB
May 10 19:57:00 heartbeat1 kernel:
May 10 19:57:00 heartbeat1 kernel:  [kmem_getpages+52/155] kmem_getpages+0x34/0x9b
May 10 19:57:00 heartbeat1 kernel:  [cache_grow+190/375] cache_grow+0xbe/0x177
May 10 19:57:00 heartbeat1 kernel:  [cache_alloc_refill+354/523] cache_alloc_refill+0x162/0x20b
May 10 19:57:00 heartbeat1 kernel:  [kmem_cache_alloc+103/127] kmem_cache_alloc+0x67/0x7f
May 10 19:57:00 heartbeat1 kernel:  [dup_task_struct+69/153] dup_task_struct+0x45/0x99
May 10 19:57:00 heartbeat1 kernel:  [copy_process+94/3348] copy_process+0x5e/0xd14
May 10 19:57:00 heartbeat1 kernel:  [do_fork+105/395] do_fork+0x69/0x18b
May 10 19:57:00 heartbeat1 kernel:  [sys_rt_sigprocmask+161/256] sys_rt_sigprocmask+0xa1/0x100
May 10 19:57:00 heartbeat1 kernel:  [sys_clone+62/66] sys_clone+0x3e/0x42
May 10 19:57:00 heartbeat1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 10 19:57:00 heartbeat1 kernel: DMA per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 2 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 2 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 3 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 3 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: DMA32 per-cpu: empty
May 10 19:57:00 heartbeat1 kernel: Normal per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 186, batch 31 used:173
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 62, batch 15 used:49
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 186, batch 31 used:47
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 62, batch 15 used:47
May 10 19:57:00 heartbeat1 kernel: cpu 2 hot: high 186, batch 31 used:39
May 10 19:57:00 heartbeat1 kernel: cpu 2 cold: high 62, batch 15 used:59
May 10 19:57:00 heartbeat1 kernel: cpu 3 hot: high 186, batch 31 used:27
May 10 19:57:00 heartbeat1 kernel: cpu 3 cold: high 62, batch 15 used:53
May 10 19:57:00 heartbeat1 kernel: HighMem per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 186, batch 31 used:45
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 62, batch 15 used:5
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 186, batch 31 used:19
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 62, batch 15 used:9
May 10 19:57:00 heartbeat1 kernel: cpu 2 hot: high 186, batch 31 used:136
May 10 19:57:00 heartbeat1 kernel: cpu 2 cold: high 62, batch 15 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 3 hot: high 186, batch 31 used:76
May 10 19:57:00 heartbeat1 kernel: cpu 3 cold: high 62, batch 15 used:0
May 10 19:57:00 heartbeat1 kernel: Free pages:      866208kB (833840kB HighMem)
May 10 19:57:00 heartbeat1 kernel: Active:513910 inactive:93943 dirty:14690 writeback:0 unstable:0 free:216552 slab:206727 mapped:255282 pagetables:3038
May 10 19:57:00 heartbeat1 kernel: DMA free:8092kB min:4568kB low:5708kB high:6852kB active:4kB inactive:44kB present:16384kB pages_scanned:0 all_unreclaimable? no
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 880 4720
May 10 19:57:00 heartbeat1 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 880 4720
May 10 19:57:00 heartbeat1 kernel: Normal free:24276kB min:26732kB low:33412kB high:40096kB active:2256kB inactive:1940kB present:901120kB pages_scanned:6457 all_unreclaimable? yes
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 0 30720
May 10 19:57:00 heartbeat1 kernel: HighMem free:833840kB min:512kB low:12652kB high:24792kB active:2053380kB inactive:373788kB present:3932160kB pages_scanned:0 all_unreclaimable? no
May 10 19:57:00 heartbeat1 kernel: lowmem_reserve[]: 0 0 0 0
May 10 19:57:00 heartbeat1 kernel: DMA: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 1*4096kB = 8088kB
May 10 19:57:00 heartbeat1 kernel: DMA32: empty
May 10 19:57:00 heartbeat1 kernel: Normal: 51*4kB 21*8kB 16*16kB 3*32kB 2*64kB 3*128kB 2*256kB 0*512kB 0*1024kB 1*2048kB 5*4096kB = 24276kB
May 10 19:57:00 heartbeat1 kernel: HighMem: 127120*4kB 33498*8kB 2326*16kB 104*32kB 35*64kB 16*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 3*4096kB = 833840kB
May 10 19:57:00 heartbeat1 kernel: Swap cache: add 9310, delete 6286, find 1156/1535, race 0+0
May 10 19:57:00 heartbeat1 kernel: Free swap  = 2025876kB
May 10 19:57:00 heartbeat1 kernel: Total swap = 2048276kB
May 10 19:57:00 heartbeat1 kernel: Out of Memory: Kill process 1810 (postfixlookup.p) score 50338 and children.
May 10 19:57:00 heartbeat1 kernel: Out of memory: Killed process 4368 (postfixlookup.p).
May 10 19:57:00 heartbeat1 kernel: Out of Memory: Kill process 1810 (postfixlookup.p) score 41931 and children.
May 10 19:57:00 heartbeat1 kernel: Out of memory: Killed process 4375 (postfixlookup.p).
May 10 19:57:00 heartbeat1 kernel: oom-killer: gfp_mask=0xd0, order=1
May 10 19:57:00 heartbeat1 kernel:  [out_of_memory+180/209] out_of_memory+0xb4/0xd1
May 10 19:57:00 heartbeat1 kernel:  [__alloc_pages+623/795] __alloc_pages+0x26f/0x31b
May 10 19:57:00 heartbeat1 kernel:  [kmem_getpages+52/155] kmem_getpages+0x34/0x9b
May 10 19:57:00 heartbeat1 kernel:  [cache_grow+190/375] cache_grow+0xbe/0x177
May 10 19:57:00 heartbeat1 kernel:  [cache_alloc_refill+354/523] cache_alloc_refill+0x162/0x20b
May 10 19:57:00 heartbeat1 kernel:  [kmem_cache_alloc+103/127] kmem_cache_alloc+0x67/0x7f
May 10 19:57:00 heartbeat1 kernel:  [dup_task_struct+69/153] dup_task_struct+0x45/0x99
May 10 19:57:00 heartbeat1 kernel:  [copy_process+94/3348] copy_process+0x5e/0xd14
May 10 19:57:00 heartbeat1 kernel:  [do_fork+105/395] do_fork+0x69/0x18b
May 10 19:57:00 heartbeat1 kernel:  [sys_rt_sigprocmask+161/256] sys_rt_sigprocmask+0xa1/0x100
May 10 19:57:00 heartbeat1 kernel:  [sys_clone+62/66] sys_clone+0x3e/0x42
May 10 19:57:00 heartbeat1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 10 19:57:00 heartbeat1 kernel: DMA per-cpu:
May 10 19:57:00 heartbeat1 kernel: cpu 0 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 0 cold: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 1 hot: high 0, batch 1 used:0
May 10 19:57:00 heartbeat1 kernel: cpu 1 cold: high 0, batch 1 used:0
....[truncated for brevity]

Full log file up until we power cycled the machine can
be seen at:

http://linux.brong.fastmail.fm/2006-05-11/messages.txt

The machine is running Debian Sarge installed via FAI and
we build our kernel as follows:

tar -jxf linux-2.6.16.tar.bz2
mv linux-2.6.16 linux-2.6.16.9-reiserfix-areca-fai
cd linux-2.6.16.9-reiserfix-areca-fai
bzcat ../patch-2.6.16.9.bz2 | patch -p1
patch -p1 < /home/mod_perl/hm/conf/patches/reiserfs-generic_write-2.6.14.1.patch
patch -p1 < /home/mod_perl/hm/conf/patches/arcmsr-2.6.15.patch
cp  /home/mod_perl/hm/infrastructure/kernel/2.6.16.9-reiserfix-areca-fai.config .config
make oldconfig
CONCURRENCY_LEVEL=5 make-kpkg --revision 0fastmail1 --append-to-version -reiserfix-areca-fai binary

arcmsr-2.6.15.patch is the Areca driver from:
ftp://60.248.88.208/RaidCards/AP_Drivers/Linux/DRIVER/SourceCode/arcmsr.1.20.0X.12.zip
re-made as a patch for easy application.

All the patches and the config file are also available in:
http://linux.brong.fastmail.fm/2006-05-11/

Regards,

Bron.
