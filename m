Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTLGMGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 07:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTLGMGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 07:06:45 -0500
Received: from smtp.mailix.net ([216.148.213.132]:45107 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S264415AbTLGMGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 07:06:39 -0500
Date: Sun, 7 Dec 2003 13:06:34 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] FIx 'noexec' behavior
Message-ID: <20031207120634.GA1258@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, you can try running mozilla with strace -f.  Redirect the strace
> output to a file with the -o option.  Mozilla should work if you use an
> updated RHL9 or FC1 installation.  This will show where the program
> tries to use mmap in a way conflicting with the patch.

I have a lot of processes frozen after applying the patch. I had not
enough patience to wait until any of them finish, but I have traces from
Alt+SysRq+T. Almost anything trying to access entries of /proc/<pid> is
frozen: ls /proc/[0-9]*/, top, killall, ps. Also the stack of mozilla
looks strange: 5a5a5a5a 5a5a5a5a...

 start-stop-da D 00000001     0 16248  16229                     (NOTLB)
 f6967e14 00000082 c18d2c80 00000001 00000003 3fd310d6 3aee6e31 c02cce00 
        f6967df8 c01776aa f7ff7104 4014839e c02cce00 f7010ce0 c18d2c80 0014fa7d 
        631c5675 000002cf eb16b310 f4178b30 eb16b310 fffeffff f6967e34 c01bcd27 
 Call Trace:
  [alloc_inode+30/337] alloc_inode+0x1e/0x151
  [<c01776aa>] alloc_inode+0x1e/0x151
  [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
  [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
  [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
  [<c01bca95>] rwsem_down_read_failed+0x29/0x32
  [.text.lock.base+7/105] .text.lock.base+0x7/0x69
  [<c018cad2>] .text.lock.base+0x7/0x69
  [proc_pid_follow_link+104/128] proc_pid_follow_link+0x68/0x80
  [<c018b102>] proc_pid_follow_link+0x68/0x80
  [link_path_walk+1459/2479] link_path_walk+0x5b3/0x9af
  [<c016c64e>] link_path_walk+0x5b3/0x9af
  [kmem_cache_alloc+407/469] kmem_cache_alloc+0x197/0x1d5
  [<c0147e7b>] kmem_cache_alloc+0x197/0x1d5
  [__user_walk+64/85] __user_walk+0x40/0x55
  [<c016cfa8>] __user_walk+0x40/0x55
  [vfs_stat+30/85] vfs_stat+0x1e/0x55
  [<c0167a88>] vfs_stat+0x1e/0x55
  [sys_stat64+27/55] sys_stat64+0x1b/0x37
  [<c0168173>] sys_stat64+0x1b/0x37
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010a437>] syscall_call+0x7/0xb

 ls            D 00000001     0  1426      1          1094  1235 (NOTLB)
 f0c87ed0 00200082 c18dac80 00000001 00000003 ebd7e000 f7ffd6b0 f0c87efc 
        c010ae26 80000800 ebd7e000 ec949740 f7f65718 f0c86000 c18dac80 000140f5 
        1e0176a7 00000181 eb965940 f4178b30 eb965940 fffeffff f0c87ef0 c01bcd27 
 Call Trace:
  [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
  [<c010ae26>] apic_timer_interrupt+0x1a/0x20
  [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
  [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
  [dput+36/607] dput+0x24/0x25f
  [<c0175453>] dput+0x24/0x25f
  [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
  [<c01bca95>] rwsem_down_read_failed+0x29/0x32
  [.text.lock.base+7/105] .text.lock.base+0x7/0x69
  [<c018cad2>] .text.lock.base+0x7/0x69
  [proc_pid_readlink+139/306] proc_pid_readlink+0x8b/0x132
  [<c018b268>] proc_pid_readlink+0x8b/0x132
  [sys_readlink+136/140] sys_readlink+0x88/0x8c
  [<c0168032>] sys_readlink+0x88/0x8c
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010a437>] syscall_call+0x7/0xb

 killall       D 00000001     0  1393      1          1225  1205 (NOTLB)
 e9e75dd8 00200082 c18d2c80 00000001 00000003 c1681730 c02cac00 000001f7 
        00104025 e9e75dec c0143516 c02cac00 00000000 00000000 c18d2c80 002f05a1 
        eae91d50 00000172 eb16a080 f4178b30 eb16a080 fffeffff e9e75df8 c01bcd27 
 Call Trace:
  [__alloc_pages+167/818] __alloc_pages+0xa7/0x332
 3516>] __alloc_pages+0xa7/0x332
  [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
  [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
  [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
  [<c01bca95>] rwsem_down_read_failed+0x29/0x32
  [.text.lock.array+43/143] .text.lock.array+0x2b/0x8f
  [<c018e6e4>] .text.lock.array+0x2b/0x8f
  [do_page_fault+861/1416] do_page_fault+0x35d/0x588
  [<c011da0e>] do_page_fault+0x35d/0x588
  [pid_revalidate+62/234] pid_revalidate+0x3e/0xea
  [<c018b9be>] pid_revalidate+0x3e/0xea
  [dput+36/607] dput+0x24/0x25f
  [<c0175453>] dput+0x24/0x25f
  [buffered_rmqueue+237/404] buffered_rmqueue+0xed/0x194
  [<c01433c8>] buffered_rmqueue+0xed/0x194
  [__alloc_pages+167/818] __alloc_pages+0xa7/0x332
  [<c0143516>] __alloc_pages+0xa7/0x332
  [proc_info_read+83/350] proc_info_read+0x53/0x15e
  [<c018ad3d>] proc_info_read+0x53/0x15e
  [vfs_read+161/268] vfs_read+0xa1/0x10c
  [<c015dd49>] vfs_read+0xa1/0x10c
  [sys_read+63/93] sys_read+0x3f/0x5d
  [<c015dfb3>] sys_read+0x3f/0x5d
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010a437>] syscall_call+0x7/0xb

 ps            D A4D7615A     0  1255      1          1235  1245 (NOTLB)
 eba73dd8 00200086 eb3ec6b0 a4d7615a 0000013d 00000745 eb63d000 00000000 
        00ffffff c02917a0 2000007b a4d7615a 0000013d eb3ec6b0 c18d2c80 00061ae7 
        a4db7273 0000013d eb3ecce0 f4178b30 eb3ecce0 fffeffff eba73df8 c01bcd27 
 Call Trace:
  [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
  [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
  [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
  [<c01bca95>] rwsem_down_read_failed+0x29/0x32
  [.text.lock.array+43/143] .text.lock.array+0x2b/0x8f
  [<c018e6e4>] .text.lock.array+0x2b/0x8f
  [pty_write+463/465] pty_write+0x1cf/0x1d1
  [<c01edb1b>] pty_write+0x1cf/0x1d1
  [pid_revalidate+62/234] pid_revalidate+0x3e/0xea
  [<c018b9be>] pid_revalidate+0x3e/0xea
  [dput+36/607] dput+0x24/0x25f
  [<c0175453>] dput+0x24/0x25f
  [buffered_rmqueue+237/404] buffered_rmqueue+0xed/0x194
  [<c01433c8>] buffered_rmqueue+0xed/0x194
  [check_poison_obj+41/399] check_poison_obj+0x29/0x18f
  [<c0145e89>] check_poison_obj+0x29/0x18f
  [__alloc_pages+167/818] __alloc_pages+0xa7/0x332
  [<c0143516>] __alloc_pages+0xa7/0x332
  [proc_info_read+83/350] proc_info_read+0x53/0x15e
  [<c018ad3d>] proc_info_read+0x53/0x15e
  [filp_open+93/95] filp_open+0x5d/0x5f
  [<c015ce85>] filp_open+0x5d/0x5f
  [vfs_read+161/268] vfs_read+0xa1/0x10c
  [<c015dd49>] vfs_read+0xa1/0x10c
  [sys_read+63/93] sys_read+0x3f/0x5d
  [<c015dfb3>] sys_read+0x3f/0x5d
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010a437>] syscall_call+0x7/0xb

 top           D 00000001     0  1235      1          1426  1255 (NOTLB)
 eb715dd8 00000082 c18dac80 00000001 00000003 eb715db8 c0145e89 eb67d4ec 
        0000016c eb715dc8 c0147d96 c0189d50 eb67d4ec eb67d4e8 c18dac80 004c5976 
        96f4de4f 00000134 eb965310 f4178b30 eb965310 fffeffff eb715df8 c01bcd27 
 Call Trace:
  [check_poison_obj+41/399] check_poison_obj+0x29/0x18f
  [<c0145e89>] check_poison_obj+0x29/0x18f
  [kmem_cache_alloc+178/469] kmem_cache_alloc+0xb2/0x1d5
  [<c0147d96>] kmem_cache_alloc+0xb2/0x1d5
  [proc_alloc_inode+30/115] proc_alloc_inode+0x1e/0x73
  [<c0189d50>] proc_alloc_inode+0x1e/0x73
  [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
  [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
  [proc_alloc_inode+77/115] proc_alloc_inode+0x4d/0x73
  [<c0189d7f>] proc_alloc_inode+0x4d/0x73
  [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
  [<c01bca95>] rwsem_down_read_failed+0x29/0x32
  [.text.lock.array+43/143] .text.lock.array+0x2b/0x8f
  [<c018e6e4>] .text.lock.array+0x2b/0x8f
  [proc_pident_lookup+246/588] proc_pident_lookup+0xf6/0x24c
  [<c018c002>] proc_pident_lookup+0xf6/0x24c
  [real_lookup+219/258] real_lookup+0xdb/0x102
  [<c016bdf9>] real_lookup+0xdb/0x102
  [dput+36/607] dput+0x24/0x25f
  [<c0175453>] dput+0x24/0x25f
  [buffered_rmqueue+237/404] buffered_rmqueue+0xed/0x194
  [<c01433c8>] buffered_rmqueue+0xed/0x194
  [check_poison_obj+41/399] check_poison_obj+0x29/0x18f
  [<c0145e89>] check_poison_obj+0x29/0x18f
  [__alloc_pages+167/818] __alloc_pages+0xa7/0x332
  [<c0143516>] __alloc_pages+0xa7/0x332
  [proc_info_read+83/350] proc_info_read+0x53/0x15e
  [<c018ad3d>] proc_info_read+0x53/0x15e
  [filp_open+93/95] filp_open+0x5d/0x5f
  [<c015ce85>] filp_open+0x5d/0x5f
  [vfs_read+161/268] vfs_read+0xa1/0x10c
  [<c015dd49>] vfs_read+0xa1/0x10c
  [sys_read+63/93] sys_read+0x3f/0x5d
  [<c015dfb3>] sys_read+0x3f/0x5d
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010a437>] syscall_call+0x7/0xb

 mozilla-bin   D 00000001     0  1225      1          1245  1393 (NOTLB)
 eba79df4 00000082 c18dac80 00000001 00000003 5a5a5a5a 5a5a5a5a 5a5a5a5a 
        5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a c18dac80 00008714 
        65e68354 00000130 f6efd940 f689d4dc f6efd940 fffeffff eba79e14 c01bcd27 
 Call Trace:
  [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
  [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
  [do_page_fault+0/1416] do_page_fault+0x0/0x588
  [<c011d6b1>] do_page_fault+0x0/0x588
  [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
  [<c01bca95>] rwsem_down_read_failed+0x29/0x32
  [.text.lock.fault+27/131] .text.lock.fault+0x1b/0x83
  [<c011dc54>] .text.lock.fault+0x1b/0x83
  [buffered_rmqueue+237/404] buffered_rmqueue+0xed/0x194
  [<c01433c8>] buffered_rmqueue+0xed/0x194
  [pte_chain_alloc+143/148] pte_chain_alloc+0x8f/0x94
  [<c015480b>] pte_chain_alloc+0x8f/0x94
  [__alloc_pages+167/818] __alloc_pages+0xa7/0x332
  [<c0143516>] __alloc_pages+0xa7/0x332
  [__get_free_pages+34/69] __get_free_pages+0x22/0x45
  [<c01437c3>] __get_free_pages+0x22/0x45
  [do_page_fault+0/1416] do_page_fault+0x0/0x588
  [<c011d6b1>] do_page_fault+0x0/0x588
  [error_code+45/56] error_code+0x2d/0x38
  [<c010aec1>] error_code+0x2d/0x38
  [do_mmap_pgoff+83/1656] do_mmap_pgoff+0x53/0x678
  [<c01511fc>] do_mmap_pgoff+0x53/0x678
  [pipe_read+516/628] pipe_read+0x204/0x274
  [<c016ac01>] pipe_read+0x204/0x274
  [sys_mmap2+155/210] sys_mmap2+0x9b/0xd2
  [<c01111a4>] sys_mmap2+0x9b/0xd2
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010a437>] syscall_call+0x7/0xb
