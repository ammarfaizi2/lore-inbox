Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVHBDGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVHBDGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 23:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVHBDGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 23:06:05 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:47302 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261346AbVHBDGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 23:06:04 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
In-reply-to: Your message of "Mon, 01 Aug 2005 12:03:21 MST."
             <20050801120321.230349c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Aug 2005 13:05:50 +1000
Message-ID: <26771.1122951950@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005 12:03:21 -0700,
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>
>> On Sat, 30 Jul 2005 02:29:55 -0700,
>> Andrew Morton <akpm@osdl.org> wrote:
>> >Keith Owens <kaos@sgi.com> wrote:
>> >>
>> >> 2.6.13-rc4 + kdb, with lots of CONFIG_DEBUG options.  There is an
>> >>  intermittent use after free in class_device_attr_show.  Reboot with no
>> >>  changes and the problem does not always recur.
>> >> ...
>> >>  ip is at class_device_attr_show+0x50/0xa0
>> >> ...
>> >
>> >It might help to know which file is being read from here.
>> >
>> >The below patch will record the name of the most-recently-opened sysfs
>> >file.  You can print last_sysfs_file[] in the debugger or add the
>> >appropriate printk to the ia64 code?
>>
>> No need for a patch.  It is /dev/vcsa2.
>
>You mean /sys/class/vc/vcsa2?

The vcsnn value varies.  I traced the dentry parent chain for the
latest event.  From bottom to top the d_name entries are

  dev, vcs16, vc, class, /.

That makes no sense, why is dev a child of vcs16?  Raw data at the end.

>That appears to be using generic code...
>
>Can you please summarise what you curently know about this bug?  What is
>being accessed after free in class_device_attr_show()?  class_dev_attr?
>cd?

IA64, compiled for both SMP and uni-processor.  Lots of debug configs,
including slab poisoning.

The problem was first noticed at 2.6.13-rc3, it has also been seen in
-rc4.  It is very intermittent, so -rc3 may not be the starting point.

Failures have been seen in two sysfs routines,
sysfs_read_file()->class_device_attr_show() and
sysfs_release()->module_put(owner).

The common denominator in the failures is that sd->s_element points to
poisoned data.

Raw data, from the failure in sysfs_release:

kdb> filp 0xe00000301eeae8d0
name.name 0xe00000301d171384  name.len  3
File Pointer at 0xe00000301eeae8d0
 f_list.nxt = 0xe00000301eeaea08 f_list.prv = 0xe000003003e5aeb8
 f_dentry = 0xe00000301d1712a0 f_op = 0xa000000100a615c8
 f_count = 0 f_flags = 0x8000 f_mode = 0xd
 f_pos = 5

dentry parent chain.  /class/vc/vcs16/dev WTF?

kdb> dentry 0xe00000301d1712a0
Dentry at 0xe00000301d1712a0
 d_name.len = 3 d_name.name = 0xe00000301d171384 <dev>
 d_count = 1 d_flags = 0x18 d_inode = 0xe00000b476b32df0
 d_parent = 0xe00000301d171a80
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0x0000000000200200
 d_lru.nxt = 0xe00000301d1712f8 d_lru.prv = 0xe00000301d1712f8
 d_child.nxt = 0xe00000301d171af8 d_child.prv = 0xe00000301d171af8
 d_subdirs.nxt = 0xe00000301d171318 d_subdirs.prv = 0xe00000301d171318
 d_alias.nxt = 0xe00000b476b32e20 d_alias.prv = 0xe00000b476b32e20
 d_op = 0xa000000100a61870 d_sb = 0xe000003003e5ad58

kdb> dentry 0xe00000301d171a80
Dentry at 0xe00000301d171a80
 d_name.len = 5 d_name.name = 0xe00000301d171b64 <vcs16>
 d_count = 2 d_flags = 0x10 d_inode = 0xe00000301986cac0
 d_parent = 0xe00000347b87c880
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0x0000000000200200
 d_lru.nxt = 0xe00000301d171ad8 d_lru.prv = 0xe00000301d171ad8
 d_child.nxt = 0xe000003011ba9ae8 d_child.prv = 0xe000003019f974c8
 d_subdirs.nxt = 0xe00000301d171308 d_subdirs.prv = 0xe00000301d171308
 d_alias.nxt = 0xe00000301986caf0 d_alias.prv = 0xe00000301986caf0
 d_op = 0xa000000100a61870 d_sb = 0xe000003003e5ad58

kdb> dentry 0xe00000347b87c880
Dentry at 0xe00000347b87c880
 d_name.len = 2 d_name.name = 0xe00000347b87c964 <vc>
 d_count = 8 d_flags = 0x0 d_inode = 0xe00000b47a5dad70
 d_parent = 0xe00000b47a404760
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0xa00000020079d000
 d_lru.nxt = 0xe00000347b87c8d8 d_lru.prv = 0xe00000347b87c8d8
 d_child.nxt = 0xe00000b47a445668 d_child.prv = 0xe00000347b921548
 d_subdirs.nxt = 0xe00000301a1fd788 d_subdirs.prv = 0xe00000347b87c7c8
 d_alias.nxt = 0xe00000b47a5dada0 d_alias.prv = 0xe00000b47a5dada0
 d_op = 0xa000000100a61870 d_sb = 0xe000003003e5ad58

kdb> dentry 0xe00000b47a404760
Dentry at 0xe00000b47a404760
 d_name.len = 5 d_name.name = 0xe00000b47a404844 <class>
 d_count = 20 d_flags = 0x0 d_inode = 0xe00000347bc95c18
 d_parent = 0xe00000b47a405180
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0xa0000002002d4bc8
 d_lru.nxt = 0xe00000b47a4047b8 d_lru.prv = 0xe00000b47a4047b8
 d_child.nxt = 0xe00000b47a4048e8 d_child.prv = 0xe00000b47a4046a8
 d_subdirs.nxt = 0xe000003013818d68 d_subdirs.prv = 0xe00000b47a405d28
 d_alias.nxt = 0xe00000347bc95c48 d_alias.prv = 0xe00000347bc95c48
 d_op = 0xa000000100a61870 d_sb = 0xe000003003e5ad58

kdb> dentry 0xe00000b47a405180
Dentry at 0xe00000b47a405180
 d_name.len = 1 d_name.name = 0xe00000b47a405264 </>
 d_count = 11 d_flags = 0x10 d_inode = 0xe00000347bc97460
 d_parent = 0xe00000b47a405180
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0x0000000000000000
 d_lru.nxt = 0xe00000b47a4051d8 d_lru.prv = 0xe00000b47a4051d8
 d_child.nxt = 0xe00000b47a4051e8 d_child.prv = 0xe00000b47a4051e8
 d_subdirs.nxt = 0xe00000b47a446ce8 d_subdirs.prv = 0xe00000b47a404a08
 d_alias.nxt = 0xe00000347bc97490 d_alias.prv = 0xe00000347bc97490
 d_op = 0x0000000000000000 d_sb = 0xe000003003e5ad58

Hex dump of dentry passed via filp to sysfs_release.

kdb> mds 0xe00000301d1712a0
0xe00000301d1712a0 1800000001   ........
0xe00000301d1712a8 1d244b3c   <K$.....
0xe00000301d1712b0 00000000   ........
0xe00000301d1712b8 5a5a5a5a00000005   ....ZZZZ
0xe00000301d1712c0 a00000010092c618 __func__.4+0xeaf8
0xe00000301d1712c8 a00000010092caf8 __func__.4+0xefd8
0xe00000301d1712d0 5a5a5a5a00000215   ....ZZZZ
0xe00000301d1712d8 e00000b476b32df0   .-.v....
0xe00000301d1712e0 e00000301d171a80   ....0...
0xe00000301d1712e8 30023ee05   ..#.....
0xe00000301d1712f0 e00000301d171384   ....0...
0xe00000301d1712f8 e00000301d1712f8   ....0...
0xe00000301d171300 e00000301d1712f8   ....0...
0xe00000301d171308 e00000301d171af8   ....0...
0xe00000301d171310 e00000301d171af8   ....0...
0xe00000301d171318 e00000301d171318   ....0...
0xe00000301d171320 e00000301d171318   ....0...
0xe00000301d171328 e00000b476b32e20    ..v....
0xe00000301d171330 e00000b476b32e20    ..v....
0xe00000301d171338 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe00000301d171340 a000000100a61870 sysfs_dentry_ops
0xe00000301d171348 e000003003e5ad58   X...0...			d_sb
0xe00000301d171350 e0000030701f6d00   .m.p0...			d_fsdata
0xe00000301d171358 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe00000301d171360 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe00000301d171368 00000000   ........
0xe00000301d171370 00000000   ........
0xe00000301d171378 00200200   .. .....
0xe00000301d171380 76656400000000   ....dev.
0xe00000301d171388 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe00000301d171390 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe00000301d171398 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe00000301d1713a0 a55a5a5a5a5a5a5a   ZZZZZZZ.

kdb> sb e000003003e5ad58
struct super_block at  0xe000003003e5ad58
 s_dev 0x0 blocksize 0x4000
 s_flags 0x40000000 s_root 0xe00000b47a405180
 s_dirt 0 s_dirty.next 0xe000003003e5ae90 s_dirty.prev 0xe000003003e5ae90
 s_frozen 0 s_id [sysfs]

fsdata (sysfs_dirent).

kdb> mds e0000030701f6d00
0xe0000030701f6d00 00000001   ........		s_count
0xe0000030701f6d08 e0000030701f6d08   .m.p0...	s_sibling
0xe0000030701f6d10 e0000030701f6d08   .m.p0...
0xe0000030701f6d18 e0000030701f6d18   .m.p0...	s_children
0xe0000030701f6d20 e0000030701f6d18   .m.p0...
0xe0000030701f6d28 e000003073607c10   .|`s0...	s_element
0xe0000030701f6d30 812400000004   ....$...	s_type, s_mode
0xe0000030701f6d38 e00000301d1712a0   ....0...	s_dentry
0xe0000030701f6d40 00000000   ........		s_iattr

s_element

kdb> mds e000003073607c10
0xe000003073607c10 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c18 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c20 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c28 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c30 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c38 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c40 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003073607c48 a56b6b6b6b6b6b6b   kkkkkkk.

The failure was caused by the bad data referenced by s_element.

