Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbVKQHub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbVKQHub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVKQHub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:50:31 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:56223 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1161089AbVKQHua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:50:30 -0500
Date: Thu, 17 Nov 2005 08:50:41 +0100
From: Sander <sander@humilis.net>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, sander@humilis.net,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-ID: <20051117075041.GA5563@favonius>
Reply-To: sander@humilis.net
References: <431B9558.1070900@baanhofman.nl> <17179.40731.907114.194935@cse.unsw.edu.au> <20051116133639.GA18274@favonius> <20051116142000.5c63449f.akpm@osdl.org> <17275.48113.533555.948181@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17275.48113.533555.948181@cse.unsw.edu.au>
X-Uptime: 08:20:57 up 2 days, 20:56, 19 users,  load average: 2.46, 2.38, 2.13
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote (ao):
> On Wednesday November 16, akpm@osdl.org wrote:
> > Sander <sander@humilis.net> wrote:
> > > With 2.6.14-mm2 (x86) and mdadm 2.1 I get a Segmentation fault when I
> > > try this:
> > 
> > It oopsed in reiser4.  reiserfs-dev added to Cc...
> > 
> 
> Hmm... It appears that md/bitmap is calling prepare_write and
> commit_write with 'file' as NULL - this works for some filesystems,
> but not for reiser4.
> 
> Does this patch help.

Something changed, but it didn't fix it it seems:

# mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: RUN_ARRAY failed: No such file or directory

(google didn't turn up the same error, but a lot 
 without the 'No such file or directory')

[42949645.530000] md: bind<loop0>
[42949645.540000] md: bind<loop1>
[42949645.540000] md: md1: raid array is not clean -- starting background reconstruction
[42949645.540000] md1: bitmap file is out of date (0 < 1) -- forcing full recovery
[42949645.540000] md1: bitmap file is out of date, doing full recovery
[42949645.560000] md1: bitmap initialized from disk: read 0/7 pages, set 0 bits, status: 1
[42949645.560000] md1: failed to create bitmap (1)
[42949645.560000] md: pers->run() failed ...
[42949645.560000] md: md1 stopped.
[42949645.560000] md: unbind<loop1>
[42949645.560000] md: export_rdev(loop1)
[42949645.560000] md: unbind<loop0>
[42949645.560000] md: export_rdev(loop0)

# ls -l /storage/raid1.bitmap
-rw-r--r-- 1 root root 25856 Nov 17 08:37 /storage/raid1.bitmap

(file is there, lets try again)

~# mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 08:37:58 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 08:37:58 2005
Continue creating array? yes
mdadm: bitmap file /storage/raid1.bitmap already exists, use --force to overwrite

(ok, try with new bitmapfile)

# mdadm -C /dev/md1 --bitmap=/storage/raid.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 08:37:58 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 08:37:58 2005
Continue creating array? yes
mdadm: RUN_ARRAY failed: No such file or directory

(doesn't work, lets force the first one)

# mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -f -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 08:40:50 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 08:40:50 2005
Continue creating array? yes
Segmentation fault


For some reason, the dmesg is quite a bit longer now.

[42949831.700000] Bad page state at free_hot_cold_page (in process 'mdadm', page c1043220)
[42949831.700000] flags:0x80000001 mapping:00000000 mapcount:0 count:0
[42949831.700000] Backtrace:
[42949831.700000]  [<c013b320>] bad_page+0x70/0xb0
[42949831.700000]  [<c013bab1>] free_hot_cold_page+0x51/0xd0
[42949831.700000]  [<c013f5da>] truncate_inode_pages_range+0x11a/0x310
[42949831.700000]  [<c01a2ac0>] reiser4_invalidate_pages+0x90/0xc0
[42949831.700000]  [<c01ba5ed>] kill_hook_extent+0x17d/0x5b0
[42949831.700000]  [<c01ac29c>] plugin_by_unsafe_id+0x1c/0x110
[42949831.700000]  [<c01ba470>] kill_hook_extent+0x0/0x5b0
[42949831.700000]  [<c01cd7fd>] call_kill_hooks+0x9d/0xc0
[42949831.700000]  [<c01cd8f0>] kill_head+0x0/0x40
[42949831.700000]  [<c01cdf76>] prepare_for_compact+0x536/0x540
[42949831.700000]  [<c0192a0e>] lock_tail+0x1e/0x40
[42949831.700000]  [<c01ac29c>] plugin_by_unsafe_id+0x1c/0x110
[42949831.700000]  [<c01cd820>] kill_units+0x0/0x80
[42949831.700000]  [<c01cd8f0>] kill_head+0x0/0x40
[42949831.700000]  [<c0192933>] longterm_unlock_znode+0xa3/0x160
[42949831.700000]  [<c0192bf3>] longterm_lock_znode+0x163/0x250
[42949831.700000]  [<c018ce4b>] jload_gfp+0x5b/0x140
[42949831.700000]  [<c01cdfb1>] kill_node40+0x31/0xc0
[42949831.700000]  [<c0191a88>] carry_cut+0x48/0x60
[42949831.700000]  [<c018f458>] carry_on_level+0x38/0xc0
[42949831.700000]  [<c018f302>] carry+0x82/0x1a0
[42949831.700000]  [<c018f704>] add_carry+0x24/0x40
[42949831.700000]  [<c018f51d>] post_carry+0x3d/0xa0
[42949831.710000]  [<c0194886>] kill_node_content+0xf6/0x160
[42949831.710000]  [<c0194e39>] cut_tree_worker_common+0x159/0x350
[42949831.710000]  [<c0194ce0>] cut_tree_worker_common+0x0/0x350
[42949831.710000]  [<c0195155>] cut_tree_object+0x125/0x240
[42949831.710000]  [<c0196d29>] reiser4_grab_reserved+0x49/0x190
[42949831.710000]  [<c018d04f>] jrelse+0xf/0x20
[42949831.710000]  [<c01bfc81>] cut_file_items+0xb1/0x180
[42949831.710000]  [<c01a0108>] add_empty_leaf+0xa8/0x220
[42949831.710000]  [<c01bfdab>] shorten_file+0x4b/0x260
[42949831.710000]  [<c01bfb40>] update_file_size+0x0/0x90
[42949831.710000]  [<c01c2f03>] setattr_truncate+0x73/0x210
[42949831.710000]  [<c01ad384>] permission_common+0x24/0x40
[42949831.710000]  [<c01ad360>] permission_common+0x0/0x40
[42949831.710000]  [<c0162b78>] permission+0x48/0x90
[42949831.710000]  [<c0163119>] __link_path_walk+0x89/0xc40
[42949831.710000]  [<c01c30fe>] setattr_unix_file+0x5e/0xc0
[42949831.710000]  [<c016f58f>] notify_change+0xcf/0x2d5
[42949831.710000]  [<c0163d3f>] link_path_walk+0x6f/0xe0
[42949831.710000]  [<c0153e9b>] do_truncate+0x4b/0x70
[42949831.710000]  [<c0162b78>] permission+0x48/0x90
[42949831.710000]  [<c0164704>] may_open+0x184/0x1d0
[42949831.710000]  [<c01647d5>] open_namei+0x85/0x560
[42949831.710000]  [<c0154fe2>] filp_open+0x22/0x50
[42949831.710000]  [<c01551ad>] get_unused_fd+0x4d/0xb0
[42949831.710000]  [<c01552c1>] do_sys_open+0x41/0xd0
[42949831.710000]  [<c0102f49>] syscall_call+0x7/0xb
[42949831.710000] Trying to fix it up, but a reboot is needed
[42949831.710000] ------------[ cut here ]------------
[42949831.710000] kernel BUG at mm/filemap.c:480!
[42949831.710000] invalid operand: 0000 [#1]
[42949831.710000] last sysfs file: /devices/pci0000:00/0000:00:11.0/i2c-0/name
[42949831.710000] Modules linked in: loop dm_mod i2c_viapro i2c_core
[42949831.710000] CPU:    0
[42949831.710000] EIP:    0060:[<c013763d>]    Tainted: G    B VLI
[42949831.710000] EFLAGS: 00010246   (2.6.14-mm2) 
[42949831.710000] EIP is at unlock_page+0xd/0x30
[42949831.710000] eax: 00000000   ebx: c1043220   ecx: c03cad30   edx: c1652218
[42949831.710000] esi: 00000001   edi: 00000000   ebp: 00000006   esp: c26c298c
[42949831.710000] ds: 007b   es: 007b   ss: 0068
[42949831.710000] Process mdadm (pid: 785, threadinfo=c26c2000 task=c6f64050)
[42949831.710000] Stack: c1043220 c013f5e1 0000000e 00007000 f2fb87ec 00000000 00000000 00000007 
[42949831.710000]        00000000 c1043220 c1045260 c1040240 c1040260 c1042820 c1042800 c10415e0 
[42949831.710000]        00007000 00000000 00000000 00000000 00000006 f2fb8810 00000001 00006fff 
[42949831.710000] Call Trace:
[42949831.710000]  [<c013f5e1>] truncate_inode_pages_range+0x121/0x310
[42949831.710000]  [<c01a2ac0>] reiser4_invalidate_pages+0x90/0xc0
[42949831.710000]  [<c01ba5ed>] kill_hook_extent+0x17d/0x5b0
[42949831.710000]  [<c01ac29c>] plugin_by_unsafe_id+0x1c/0x110
[42949831.710000]  [<c01ba470>] kill_hook_extent+0x0/0x5b0
[42949831.710000]  [<c01cd7fd>] call_kill_hooks+0x9d/0xc0
[42949831.710000]  [<c01cd8f0>] kill_head+0x0/0x40
[42949831.710000]  [<c01cdf76>] prepare_for_compact+0x536/0x540
[42949831.710000]  [<c0192a0e>] lock_tail+0x1e/0x40
[42949831.710000]  [<c01ac29c>] plugin_by_unsafe_id+0x1c/0x110
[42949831.710000]  [<c01cd820>] kill_units+0x0/0x80
[42949831.710000]  [<c01cd8f0>] kill_head+0x0/0x40
[42949831.710000]  [<c0192933>] longterm_unlock_znode+0xa3/0x160
[42949831.710000]  [<c0192bf3>] longterm_lock_znode+0x163/0x250
[42949831.710000]  [<c018ce4b>] jload_gfp+0x5b/0x140
[42949831.710000]  [<c01cdfb1>] kill_node40+0x31/0xc0
[42949831.710000]  [<c0191a88>] carry_cut+0x48/0x60
[42949831.710000]  [<c018f458>] carry_on_level+0x38/0xc0
[42949831.710000]  [<c018f302>] carry+0x82/0x1a0
[42949831.710000]  [<c018f704>] add_carry+0x24/0x40
[42949831.710000]  [<c018f51d>] post_carry+0x3d/0xa0
[42949831.710000]  [<c0194886>] kill_node_content+0xf6/0x160
[42949831.710000]  [<c0194e39>] cut_tree_worker_common+0x159/0x350
[42949831.710000]  [<c0194ce0>] cut_tree_worker_common+0x0/0x350
[42949831.710000]  [<c0195155>] cut_tree_object+0x125/0x240
[42949831.710000]  [<c0196d29>] reiser4_grab_reserved+0x49/0x190
[42949831.710000]  [<c018d04f>] jrelse+0xf/0x20
[42949831.710000]  [<c01bfc81>] cut_file_items+0xb1/0x180
[42949831.710000]  [<c01a0108>] add_empty_leaf+0xa8/0x220
[42949831.710000]  [<c01bfdab>] shorten_file+0x4b/0x260
[42949831.710000]  [<c01bfb40>] update_file_size+0x0/0x90
[42949831.710000]  [<c01c2f03>] setattr_truncate+0x73/0x210
[42949831.710000]  [<c01ad384>] permission_common+0x24/0x40
[42949831.710000]  [<c01ad360>] permission_common+0x0/0x40
[42949831.710000]  [<c0162b78>] permission+0x48/0x90
[42949831.710000]  [<c0163119>] __link_path_walk+0x89/0xc40
[42949831.710000]  [<c01c30fe>] setattr_unix_file+0x5e/0xc0
[42949831.710000]  [<c016f58f>] notify_change+0xcf/0x2d5
[42949831.710000]  [<c0163d3f>] link_path_walk+0x6f/0xe0
[42949831.710000]  [<c0153e9b>] do_truncate+0x4b/0x70
[42949831.710000]  [<c0162b78>] permission+0x48/0x90
[42949831.710000]  [<c0164704>] may_open+0x184/0x1d0
[42949831.710000]  [<c01647d5>] open_namei+0x85/0x560
[42949831.710000]  [<c0154fe2>] filp_open+0x22/0x50
[42949831.710000]  [<c01551ad>] get_unused_fd+0x4d/0xb0
[42949831.710000]  [<c01552c1>] do_sys_open+0x41/0xd0
[42949831.710000]  [<c0102f49>] syscall_call+0x7/0xb
[42949831.710000] Code: e8 69 ff ff ff 89 da b9 20 6f 13 c0 c7 04 24 02 00 00 00 e8 e6 77 22 00 83 c4 20 5b c3 90 53 89 c3 0f ba 30 00 19 c0 85 c0 75 08 <0f> 0b e0 01 f8 6a 38 c0 89 d8 e8 34 ff ff ff 89 da 31 c9 5b e9 
[42949831.710000]  

-- 
Humilis IT Services and Solutions
http://www.humilis.net
