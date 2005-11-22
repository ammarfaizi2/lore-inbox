Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVKVRU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVKVRU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVKVRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:20:26 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:1229 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S965021AbVKVRUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:20:25 -0500
Date: Tue, 22 Nov 2005 18:20:27 +0100
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: Re: unable to use dpkg 2.6.15-rc2
Message-ID: <20051122172027.GA11219@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121100820.D6790390@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me, I'm not subscribed)

Nathan Scott <nathans@sgi.com> ha scritto:
>> It's reproducible in 2.6.15-rc1, 2.6.15-rc1-mm1, 2.6.15-rc1-mm2 and
>> 2.6.15-rc2.
>> 
>> It does not occur in 2.6.14.
>> 
>> Most easily triggered by "make clean" in the Linux source, for those of
>> you without access to dpkg. But both clean and dpkg will trigger it.
> 
> So far I've not been able to reproduce this; I'm using "make clean"
> and it works just fine for me (I'm using the current git tree).

Confirmed here with 2.6.15-rc1 an IDE disk. Kernel is UP with
CONFIG_PREEMPT and 8KB stack. The following debug options are enabled:

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y

should I try and enable something else to gather more informations?


The first time the system hung during shutdown, with kernel stuck in
pdflush (probably waked up by sync):

 pdflush       D E3A593A8     0 27641      6         27650  1233 (L-TLB)
 d6a099fc 00000001 00000003 e3a593a8 00000296 00000001 d6a099d8 c01174af
 00000000 00000000 d0cb7570 0001226c 268d47fe 00001648 cc890590 cc8906b8
 7fffffff eef27240 d6a09a68 d6a09a38 c030a734 efa70c00 d6a09a18 d6a09a1c
 Call Trace:
  [<c030a734>] schedule_timeout+0x94/0xa0
  [<f1a693ed>] xlog_grant_log_space+0x1dd/0x370 [xfs]
  [<f1a66e57>] xfs_log_reserve+0x77/0xb0 [xfs]
  [<f1a74b8c>] xfs_trans_reserve+0x7c/0x1a0 [xfs]
  [<f1a6457c>] xfs_iomap_write_allocate+0x10c/0x4d0 [xfs]
  [<f1a635de>] xfs_iomap+0x3be/0x470 [xfs]
  [<f1a8abdc>] xfs_bmap+0x2c/0x40 [xfs]
  [<f1a824ac>] xfs_map_blocks+0x3c/0x90 [xfs]
  [<f1a83460>] xfs_page_state_convert+0x4e0/0x610 [xfs]
  [<f1a83c1e>] linvfs_writepage+0x5e/0xf0 [xfs]
  [<c0180782>] mpage_writepages+0x242/0x3d0
  [<c01417da>] do_writepages+0x2a/0x30
  [<c017ec50>] __sync_single_inode+0x70/0x200
  [<c017eea4>] __writeback_single_inode+0xc4/0x1a0
  [<c017f0e7>] sync_sb_inodes+0x167/0x2c0
  [<c017f335>] writeback_inodes+0xf5/0x140
  [<c01415d2>] wb_kupdate+0xb2/0x130
  [<c0141f65>] __pdflush+0xd5/0x200
  [<c01420b9>] pdflush+0x29/0x30
  [<c012f735>] kthread+0x95/0xd0
  [<c01013cd>] kernel_thread_helper+0x5/0x18

The second time happened while I was doing a "rm -rf" of a kernel tree:

 rm            D E4913E38     0  2831   2825                     (NOTLB)
 e4cefdb0 00000001 00000003 e4913e38 00000296 00000003 e4cefd8c c01174af
 00000000 00000000 e4b3e030 0005f191 cdb3c946 00000028 e4c98090 e4c981b8
 7fffffff ef1069d8 e4cefe1c e4cefdec c030a734 eee2f800 e4cefdcc e4cefdd0
 Call Trace:
  [<c030a734>] schedule_timeout+0x94/0xa0
  [<f1a693ed>] xlog_grant_log_space+0x1dd/0x370 [xfs]
  [<f1a66e57>] xfs_log_reserve+0x77/0xb0 [xfs]
  [<f1a74b8c>] xfs_trans_reserve+0x7c/0x1a0 [xfs]
  [<f1a7d2ad>] xfs_inactive+0x34d/0x4d0 [xfs]
  [<f1a8b618>] linvfs_clear_inode+0x68/0x90 [xfs]
  [<c01748a4>] clear_inode+0xf4/0x100
  [<c01759fd>] generic_delete_inode+0xed/0x110
  [<c0175bcf>] generic_drop_inode+0xf/0x20
  [<c0175c36>] iput+0x56/0x80
  [<c016b13c>] sys_unlink+0xcc/0x120
  [<c01031c5>] syscall_call+0x7/0xb


At the time of the rm -rf the partition was somewhat full:

root@dreamland:~# df /usr
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda8             33996740  33549488    447252  99% /usr
root@dreamland:~# df -i /usr
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/hda8            1997584  148695 1848889    8% /usr

The first time there was a lot more of free space though (a couple of
GB).

> From your earlier report with the stack traces included, it looks
> like XFS is waiting for a log write to complete, but it never
> does (which is not valid driver behaviour).  I'm using the sym53c8xx
> driver in my testing BTW, which is different to you, so maybe see if
> this still happens for you with different hardware?  (if you can).

Here it happens with an IDE disk, connected to VT8233A southbridge.

Luca
-- 
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)
