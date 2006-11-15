Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWKOPGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWKOPGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbWKOPGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:06:20 -0500
Received: from dot.reactive-networks.net ([217.144.82.11]:9738 "EHLO
	dot.oreally.co.uk") by vger.kernel.org with ESMTP id S1030536AbWKOPGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:06:18 -0500
Date: Wed, 15 Nov 2006 15:06:16 +0000
From: linux-kernel@ckeith.clara.net
To: linux-kernel@vger.kernel.org
Subject: GPF oops on 2.6.18-1.2200.fc5 and repeated DWARF2 unwinder XFS errors under 2.6.18-1.2239.fc5
Message-ID: <20061115150616.GL26200@dot.oreally.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just started up a new box yesterday with Fedora Core 5. Its running with
2 dual core AMD Opteron 2220 SE's and 24Gb of memory and an Adaptec SCSI
card and I've had a number of errors which I can't seem to find solutions
for. I'd had no end of problems with spinlock issues in the aacraid driver
in the 2.6.17 series on another dual opteron box, but on hitting
2.6.18-1.2200 these went away, so I started the new box off with
2.6.18-1.2200 as well. As I understand it, this is 2.6.18.1 as compiled
by Redhat/Fedora and includes various DWARD2 unwinder fixes.

Well this caused a GPF and the following trace:

-----------

general protection fault: 0000 [1] SMP
last sysfs file: /class/net/sit0/address
CPU 1
Modules linked in: nls_utf8 ipv6 ip_conntrack_ftp ip_conntrack_netbios_ns ipt_owner ipt_LOG xt_limit ipt_REJECT xt_tcpudp xt_state ip_conntrack nfnetlink iptable_filter ip_tables x_tables xfs dm_mod video sbs i2c_ec button battery asus_acpi ac lp parport_pc parport ide_cd cdrom sg ehci_hcd ohci_hcd i2c_nforce2 i2c_core forcedeth serio_raw k8_edac edac_mc shpchp pcspkr ext3 jbd sata_nv libata aacraid sd_mod scsi_mod
Pid: 1093, comm: gawk Not tainted 2.6.18-1.2200.fc5 #1
RIP: 0010:[<ffffffff8826b4c5>]  [<ffffffff8826b4c5>]
:xfs:xfs_bmap_search_extents+0x1c/0xcb
RSP: 0018:ffff8105fd653b40  EFLAGS: 00010202
RAX: ffffffff806785a0 RBX: ffff8105fd653d28 RCX: ffff8105fd653d70
RDX: 0000000000000000 RSI: 00000000000033ce RDI: ffff8102fe801080
RBP: ffff8105fd653b40 R08: ffff8105fd653d6c R09: ffff8105fd653d28
R10: ffff8105fd653d70 R11: ffff8102f4655250 R12: ffff8105fd653d6c
R13: ffff8105ff04d800 R14: 0007ffffffffcc32 R15: ffff8105fd653de8
FS:  00002aaaab093e00(0000) GS:ffff8102ffc3b1c0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaaaae4a020 CR3: 0000000000201000 CR4: 00000000000006e0
Process gawk (pid: 1093, threadinfo ffff8105fd652000, task
ffff8105fd4f4810)
Stack:  ffff8102fe801080 0000000000000005 0000000000000000 ffff8105ff04d800
 ffffffff8826b972 ffff8105fd653d08 0000000000000007 0000000000000048
 0000000000000000 000000000000029b 0000000000100000 ffff8105fd653c18
Call Trace:
 [<ffffffff8826b972>] :xfs:xfs_bmapi+0x2d2/0x1b66
 [<ffffffff8829dfba>] :xfs:xfs_inactive_free_eofblocks+0xa3/0x1ec
 [<ffffffff882a13cc>] :xfs:xfs_release+0x97/0xc8
 [<ffffffff882a820e>] :xfs:xfs_file_release+0x1a/0x1e
 [<ffffffff8021239b>] __fput+0xbf/0x1aa
 [<ffffffff8021a4de>] remove_vma+0x4e/0x75
 [<ffffffff8023a035>] exit_mmap+0xcf/0xf3
 [<ffffffff8023c1c1>] mmput+0x41/0x96
 [<ffffffff802150e2>] do_exit+0x28c/0x8c3
 [<ffffffff80247d0e>] cpuset_exit+0x0/0x6c
 [<00002aaaab089888>]


Code: 18 4c 8b 4c 24 40 65 8b 0c 25 2c 00 00 00 48 63 c9 48 8b 0c
RIP  [<ffffffff8826b4c5>] :xfs:xfs_bmap_search_extents+0x1c/0xcb
 RSP <ffff8105fd653b40>
 <1>Fixing recursive fault but reboot is needed!

-----------

At the time the box was sitting there doing nothing but running openssh.
(This gawk process seems to be from anacron kicking in 'makewhatis').
The machine didn't die but didn't seem happy. I searching I discovered a
number of people with the same message "general protection fault: 0000 [1]
SMP" on lots of different processes so I assumed that it wasn't related
to the XFS drivers directly, but to a problem somewhere else which is
being triggered by the dual-core opterons (could heat be a factor as its
just sitting on a desk in the office not in a machine room?).

Anyway since this had happened I decided to upgrade to the next Fedora
kernel 2.6.18-1.2239.fc5 which appears to be 2.6.18.2 + some redhat/fedora
patches (mostly for Xen, which I'm not running). This sit there for a few
hours and hadn't thrown an error so I decided to upload some data to it
overnight ready for the morning. As soon as I did I started getting
traces for:


-----------
Filesystem "sda5": XFS internal error xfs_btree_check_sblock at line 334 of
file fs/xfs/xfs_btree.c.  Caller 0xffffffff8825e203

Call Trace:
 [<ffffffff802691d9>] show_trace+0x34/0x47
 [<ffffffff802691fe>] dump_stack+0x12/0x17
 [<ffffffff88272bb4>] :xfs:xfs_btree_check_sblock+0xbc/0xcc
 [<ffffffff8825e203>] :xfs:xfs_alloc_lookup+0x14f/0x39a
 [<ffffffff8825bed3>] :xfs:xfs_alloc_ag_vextent+0x74/0xf61
 [<ffffffff8825d116>] :xfs:xfs_alloc_fix_freelist+0x356/0x410
 [<ffffffff8825d54a>] :xfs:xfs_alloc_vextent+0x2ae/0x400
 [<ffffffff8826b578>] :xfs:xfs_bmapi+0xed6/0x1b66
 [<ffffffff8828ba33>] :xfs:xfs_iomap_write_allocate+0x257/0x3fc
 [<ffffffff8828aa3a>] :xfs:xfs_iomap+0x31a/0x521
 [<ffffffff882a38f0>] :xfs:xfs_map_blocks+0x2f/0x5f
 [<ffffffff882a3c46>] :xfs:xfs_page_state_convert+0x2b7/0xb63
 [<ffffffff882a4724>] :xfs:xfs_vm_writepage+0xa7/0xde
 [<ffffffff8021c78f>] mpage_writepages+0x1d0/0x395
 [<ffffffff80259e0f>] do_writepages+0x23/0x32
 [<ffffffff8024e2b8>] __filemap_fdatawrite_range+0x54/0x5e
 [<ffffffff882a779d>] :xfs:fs_flush_pages+0x4b/0x64
 [<ffffffff882a71ec>] :xfs:xfs_file_close+0x2a/0x2e
 [<ffffffff80223b7f>] filp_close+0x36/0x64
 [<ffffffff8021d873>] sys_close+0x8f/0xaa
 [<ffffffff8025c181>] tracesys+0xd1/0xdc
DWARF2 unwinder stuck at tracesys+0xd1/0xdc
Leftover inexact backtrace:
-----------



I first booted into 2.6.18-1.2239.fc5 in single user mode and forced a
check of the disk with xfs_repair and I'm using xfs-progs-2.8.11 as
I discovered on my other system that the 2.6.17 XFS kernel driver bugs
were breaking the FS in a way that the xfs-progs-2.7.x code didn't fix.

These XFS bugs seem to be the same problems that were cropping up in the
2.6.17 series which were resolved in 2.6.18.1 (2.6.18-1.2200.fc5).

Any suggestions are greatly appreciated. Also please let me know if more
details are required.

Should I just simply go back to ext3? I'd prefer not to because of the
fsck'ing time on a 1Tb array, but if it means that the kernel doesn't throw
a hissy fit then I'll be more than happy to do that.

Regards,
Colin.

thor# uname -a
Linux thor 2.6.18-1.2239.fc5 #1 SMP Fri Nov 10 12:51:06
EST 2006 x86_64 x86_64 x86_64 GNU/Linux

thor# cat /proc/cmdline
ro root=LABEL=/

Adaptec aacraid driver (1.1-5[2409]-mh2)


processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 65
model name      : Dual-Core AMD Opteron(tm) Processor 2220 SE
stepping        : 2
cpu MHz         : 2800.000
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8_legacy
bogomips        : 5639.77
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc



-- 
 "Developers are like artists; they produce their best work if they
  have the freedom to do so" - Werner Vogels, CTO Amazon.com
