Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSKHWeh>; Fri, 8 Nov 2002 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSKHWeh>; Fri, 8 Nov 2002 17:34:37 -0500
Received: from mail.broadpark.no ([217.13.4.2]:13001 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S262641AbSKHWe3>;
	Fri, 8 Nov 2002 17:34:29 -0500
Message-ID: <3DCC3D41.386DB98C@broadpark.no>
Date: Fri, 08 Nov 2002 23:40:01 +0100
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.46bk4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: raidneilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: raid-0 BUG in 2.5.46-bk4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed 2.5.46-bk4 in order to try the new
raid patches.  (I have raid-1 and raid-0
on smp, scsi)

Raid-1 seems to work fine, but processes
trying to use the raid-0 (/usr/src)
either segfaults or gets stuck in D-state
quickly.

Make menuconfig segfaults immediately,
find /usr/src prints 4 files and gets
stuck in D-state.

I can't umount either -  the device is busy.

I use gcc 2.95.4 from debian unstable,
the kernel is compiled with preempt.

Here's some BUGs from dmesg:

md: md0: sync done.
RAID1 conf printout:
 --- wd:2 rd:2
 disk 0, wo:0, o:1, dev:scsi/host0/bus0/target0/lun0/part2
 disk 1, wo:0, o:1, dev:scsi/host0/bus0/target1/lun0/part1
md: updating md0 RAID superblock on device
md: scsi/host0/bus0/target1/lun0/part1 <6>(write)
scsi/host0/bus0/target1/lun0/p
art1's sb offset: 98240
md: scsi/host0/bus0/target0/lun0/part2 <6>(write)
scsi/host0/bus0/target0/lun0/p
art2's sb offset: 98240
------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1949!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c0247ea6>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x16/0x94
eax: 00000000   ebx: 00000000   ecx: d7fa1d80   edx: 00000000
esi: d7fa1d80   edi: 00000000   ebp: 00000001   esp: cf2b5c0c
ds: 0068   es: 0068   ss: 0068
Process make (pid: 905, threadinfo=cf2b4000 task=cd5cb980)
Stack: 00001000 000c2c37 c016f1d6 00000000 d7fa1d80 c016f4a7 00000000
d7fa1d80 
       c11c0ac8 c11c0ac0 00000002 d7fa1ad8 00000020 00000000 d113ac7c
00000001 
       00000007 00000000 00000003 00000000 00000001 0000000c cb8452e4
00000010 
Call Trace:
 [<c016f1d6>] mpage_bio_submit+0x22/0x28
 [<c016f4a7>] do_mpage_readpage+0x25b/0x390
 [<c011d734>] autoremove_wake_function+0x0/0x38
 [<c011d734>] autoremove_wake_function+0x0/0x38
 [<c01d4b04>] radix_tree_extend+0x64/0xa4
 [<c01d4b82>] radix_tree_insert+0x3e/0xc8
 [<c013605e>] add_to_page_cache+0x4a/0xe4
 [<c016f662>] mpage_readpages+0x86/0x128
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c0262274>] sym53c8xx_queue_command+0xd0/0xfc
 [<c018497d>] ext2_readpages+0x19/0x20
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c014620d>] read_pages+0x3d/0x108
 [<c014022f>] buffered_rmqueue+0x15b/0x168
 [<c01402e4>] __alloc_pages+0xa8/0x280
 [<c0146462>] do_page_cache_readahead+0x18a/0x1b8
 [<c0146562>] page_cache_readahead+0xd2/0x124
 [<c013678d>] do_generic_mapping_read+0x51/0x398
 [<c0136dd5>] __generic_file_aio_read+0x1cd/0x1f4
 [<c0136b14>] file_read_actor+0x0/0xf4
 [<c0136ecb>] generic_file_read+0x7b/0x9c
 [<c0134d6e>] do_mmap_pgoff+0x462/0x588
 [<c010f912>] old_mmap+0xda/0x114
 [<c014dc11>] vfs_read+0xc5/0x18c
 [<c014df42>] sys_read+0x2a/0x3c
 [<c0108f53>] syscall_call+0x7/0xb

Code: 0f 0b 9d 07 f9 7d 38 c0 89 f6 83 7e 28 00 75 0a 0f 0b 9e 07 

 ------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1949!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c0247ea6>]    Not tainted
EFLAGS: 00013246
EIP is at submit_bio+0x16/0x94
eax: 00000000   ebx: 00000000   ecx: cc8ea8b8   edx: 00000000
esi: cc8ea8b8   edi: 00000000   ebp: 00000001   esp: cf2b5cf8
ds: 0068   es: 0068   ss: 0068
Process make (pid: 907, threadinfo=cf2b4000 task=cd5cb980)
Stack: 00001000 000d13b7 c016f1d6 00000000 cc8ea8b8 c016f4a7 00000000
cc8ea8b8 
       c1149f38 00000000 00000000 cb8451a8 c0262274 00000000 d113ac7c
00000001 
       00000001 00000000 00000001 00000000 00000001 0000000c cb845120
00000010 
Call Trace:
 [<c016f1d6>] mpage_bio_submit+0x22/0x28
 [<c016f4a7>] do_mpage_readpage+0x25b/0x390
 [<c0262274>] sym53c8xx_queue_command+0xd0/0xfc
 [<c011ad86>] schedule+0x3fe/0x500
 [<c013605e>] add_to_page_cache+0x4a/0xe4
 [<c016f72e>] mpage_readpage+0x2a/0x44
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c018495f>] ext2_readpage+0xf/0x14
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c0137746>] read_cache_page+0xae/0x1e4
 [<c018229b>] ext2_get_page+0x1f/0x90
 [<c0184950>] ext2_readpage+0x0/0x14
 [<c018270f>] ext2_find_entry+0x83/0x1e8
 [<c01828e6>] ext2_inode_by_name+0x1a/0x5c
 [<c0185b17>] ext2_lookup+0x27/0x8c
 [<c015a82c>] real_lookup+0x60/0xe4
 [<c015ac60>] do_lookup+0xe8/0x2d0
 [<c015b18d>] link_path_walk+0x345/0xa8c
 [<c015bd3b>] path_lookup+0x207/0x20c
 [<c015c2b3>] open_namei+0x8b/0x4d0
 [<c0127a86>] update_wall_time+0x12/0x3c
 [<c014ce63>] filp_open+0x3b/0x5c
 [<c014d2cb>] sys_open+0x37/0x70
 [<c0108f53>] syscall_call+0x7/0xb

Code: 0f 0b 9d 07 f9 7d 38 c0 89 f6 83 7e 28 00 75 0a 0f 0b 9e 07 

------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1949!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0247ea6>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x16/0x94
eax: 00000000   ebx: 00000000   ecx: cc8ea5cc   edx: 00000000
esi: cc8ea5cc   edi: 00000000   ebp: 00000001   esp: ca5b5df4
ds: 0068   es: 0068   ss: 0068
Process ls (pid: 934, threadinfo=ca5b4000 task=ca3a7360)
Stack: 00001000 0006302f c016f1d6 00000000 cc8ea5cc c016f4a7 00000000
cc8ea5cc 
       c10c3be0 00000000 00000000 cbb5db7c c0452d00 00000000 d113ac7c
00000001 
       00000001 00000000 00000001 00000000 00000001 0000000c cbb5daf4
00000010 
Call Trace:
 [<c016f1d6>] mpage_bio_submit+0x22/0x28
 [<c016f4a7>] do_mpage_readpage+0x25b/0x390
 [<c0229b14>] pty_write+0x134/0x140
 [<c0225f03>] opost_block+0x167/0x174
 [<c013605e>] add_to_page_cache+0x4a/0xe4
 [<c016f72e>] mpage_readpage+0x2a/0x44
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c018495f>] ext2_readpage+0xf/0x14
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c0137746>] read_cache_page+0xae/0x1e4
 [<c018229b>] ext2_get_page+0x1f/0x90
 [<c0184950>] ext2_readpage+0x0/0x14
 [<c0182447>] ext2_readdir+0x13b/0x380
 [<c015fa05>] vfs_readdir+0x75/0x88
 [<c015fc90>] filldir64+0x0/0x104
 [<c015fdde>] sys_getdents64+0x4a/0x96
 [<c015fc90>] filldir64+0x0/0x104
 [<c0108f53>] syscall_call+0x7/0xb

Code: 0f 0b 9d 07 f9 7d 38 c0 89 f6 83 7e 28 00 75 0a 0f 0b 9e 07 


 ------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1949!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0247ea6>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x16/0x94
eax: 00000000   ebx: 00000000   ecx: cc8ea148   edx: 00000000
esi: cc8ea148   edi: 00000000   ebp: 00000001   esp: ca5b5df4
ds: 0068   es: 0068   ss: 0068
Process find (pid: 936, threadinfo=ca5b4000 task=ca3a79a0)
Stack: 00001000 000b951f c016f1d6 00000000 cc8ea148 c016f4a7 00000000
cc8ea148 
       c10c2a88 00000000 00000000 cbb5d46c 0000c2e6 00000000 d113ac7c
00000001 
       00000001 00000000 00000001 00000000 00000001 0000000c cbb5d3e4
00000010 
Call Trace:
 [<c016f1d6>] mpage_bio_submit+0x22/0x28
 [<c016f4a7>] do_mpage_readpage+0x25b/0x390
 [<c01402e4>] __alloc_pages+0xa8/0x280
 [<c0133a3b>] do_anonymous_page+0x1fb/0x25c
 [<c013605e>] add_to_page_cache+0x4a/0xe4
 [<c016f72e>] mpage_readpage+0x2a/0x44
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c018495f>] ext2_readpage+0xf/0x14
 [<c0184548>] ext2_get_block+0x0/0x3f4
 [<c0137746>] read_cache_page+0xae/0x1e4
 [<c018229b>] ext2_get_page+0x1f/0x90
 [<c0184950>] ext2_readpage+0x0/0x14
 [<c0182447>] ext2_readdir+0x13b/0x380
 [<c015fa05>] vfs_readdir+0x75/0x88
 [<c015fc90>] filldir64+0x0/0x104
 [<c015fdde>] sys_getdents64+0x4a/0x96
 [<c015fc90>] filldir64+0x0/0x104
 [<c015ef6d>] sys_fcntl64+0x85/0x98
 [<c015ef79>] sys_fcntl64+0x91/0x98
 [<c0108f53>] syscall_call+0x7/0xb

Code: 0f 0b 9d 07 f9 7d 38 c0 89 f6 83 7e 28 00 75 0a 0f 0b 9e 07
