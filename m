Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWHNMhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWHNMhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbWHNMhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:37:15 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:19874 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1752033AbWHNMhM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:37:12 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-scsi@vger.kernel.org
Subject: Re: qlogic 2312 problems on 2.6.16.22, 2.6.18rc4
Date: Mon, 14 Aug 2006 14:37:05 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608140946.50411.arekm@pld-linux.org>
In-Reply-To: <200608140946.50411.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608141437.05269.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 09:46, Arkadiusz Miskiewicz wrote:
> Hi,
>
> I was using QLA2312 FC card on 32-bit machine with 6GB ram
> without problems. Recently I've switched to opteron dual core machine
> also with 6GB ram and I'm having serious problem with access to FC array.
>
> When I switch back to 32-bit machine the problem disappears. Some qla2312
> problems with 64bit machines?

I've tested latest git (same as 2.6.18rc4 I guess) using latest ql2300 
firmware from qlogic site.

mkfs.xfs /dev/sda2
mount /dev/sda2 /dest
rpm --root /dest --initdb

resulted with:
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
Filesystem "sda2": XFS internal error xfs_btree_check_sblock at line 334 of 
file fs/xfs/xfs_btree.c.  Caller 0xffffffff8819c33b

Call Trace:
 [<ffffffff8818a7a7>] :xfs:xfs_btree_check_sblock+0xc7/0xe0
 [<ffffffff8819c33b>] :xfs:xfs_inobt_lookup+0x10b/0x2c0
 [<ffffffff8819a4a6>] :xfs:xfs_dialloc+0x266/0x800
 [<ffffffff8027331c>] cache_alloc_refill+0xcc/0x1b0
 [<ffffffff8819fecf>] :xfs:xfs_ialloc+0x5f/0x4d0
 [<ffffffff881be03b>] :xfs:kmem_zone_alloc+0x5b/0xc0
 [<ffffffff803e4b3f>] thread_return+0x0/0xb1
 [<ffffffff881b4916>] :xfs:xfs_dir_ialloc+0x86/0x2c0
 [<ffffffff881a78eb>] :xfs:xfs_log_reserve+0x9b/0xc0
 [<ffffffff881badfa>] :xfs:xfs_mkdir+0x35a/0x680
 [<ffffffff88170e5b>] :xfs:xfs_acl_get_attr+0x5b/0x90
 [<ffffffff881c4c83>] :xfs:xfs_vn_mknod+0x1d3/0x3c0
 [<ffffffff8028e475>] d_instantiate+0x75/0x90
 [<ffffffff8028431d>] real_lookup+0x9d/0x110
 [<ffffffff88022176>] :sunrpc:rpcauth_lookup_credcache+0x96/0x200
 [<ffffffff88056519>] :nfs:nfs_do_access+0x29/0xa0
 [<ffffffff8819e886>] :xfs:xfs_iunlock+0x66/0xa0
 [<ffffffff881b88ba>] :xfs:xfs_access+0x4a/0x60
 [<ffffffff881c5414>] :xfs:xfs_vn_permission+0x14/0x20
 [<ffffffff80283ff8>] permission+0xb8/0xd0
 [<ffffffff8028472b>] __link_path_walk+0x8b/0xcc0
 [<ffffffff802923f4>] mntput_no_expire+0x24/0xa0
 [<ffffffff80286ea7>] vfs_mkdir+0xf7/0x180
 [<ffffffff80286fd8>] sys_mkdirat+0xa8/0xf0
 [<ffffffff8020a1b1>] error_exit+0x0/0x84
 [<ffffffff8020991a>] system_call+0x7e/0x83


I was able to reproduce problem with reiserfs, so it doesn't sound as 
filesystem problem:

ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11383 0x0 SD]
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11379 0x0 SD]
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11380 0x0 SD]
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11381 0x0 SD]
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11382 0x0 SD]
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11376 0x0 SD]
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.5*[2 
11375 0x1 DIRECT], item_len 16, item_location 2576, free_space(entry_count) 0
ReiserFS: sda2: warning: vs-5150: search_by_key: invalid format found in block 
33413. Fsck?
ReiserFS: sda2: warning: vs-13070: reiserfs_read_locked_inode: i/o failure 
occurred trying to find stat data of [2 11378 0x0 SD]
ReiserFS: warning: vs-500: unknown uniqueness 501
ReiserFS: warning: vs-500: unknown uniqueness 501
ReiserFS: warning: vs-500: unknown uniqueness 501
ReiserFS: warning: vs-500: unknown uniqueness 501

and even ext3:
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs error (device sda2): ext3_readdir: bad entry in directory #16372: 
rec_len is smaller than minimal - offset=44, inode=0, rec_len=0, name_len=0
Aborting journal on device sda2.
ext3_abort called.
EXT3-fs error (device sda2): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only


This happens on two of my opteron machines so it's not hardware fault I guess.

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
