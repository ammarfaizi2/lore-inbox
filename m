Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbTIJUs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTIJUs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:48:57 -0400
Received: from ns.tasking.nl ([195.193.207.2]:43018 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S265665AbTIJUsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:48:54 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: 2.6.0-test5: Oops on mount /dev/md0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <2ba3.3f5f8da3.bf8df@altium.nl>
Date: Wed, 10 Sep 2003 20:46:27 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While experimenting with RAID-1 on two loopback devices, I got a
kernel Oops. The RAID-1 volume contains an ext2 filesystem, which I
can mount just fine. However, trying to mount it after turning off the
RAID device with raidstop (which should fail of course), results in a
segmentation fault and kernel Oops. Something is stuck after this,
causing "sync" to hang. This is the scenario:

# cat /etc/raidtab
raiddev /dev/md0
	raid-level	1
	nr-raid-disks	2
	nr-spare-disks	0
	chunk-size	4
	persistent-superblock 1
	device		/dev/loop1
	raid-disk	0
	device		/dev/loop2
	raid-disk	1
# losetup /dev/loop1 /tmp/img1
# losetup /dev/loop2 /tmp/img2
# raidstart /dev/md0
# raidstop /dev/md0
# mount -t ext2 /dev/md0 /mnt
Segmentation fault

>From /var/log/messages:

Sep 10 21:45:42 zaphod kernel: md: autorun ...
Sep 10 21:45:42 zaphod kernel: md: considering loop2 ...
Sep 10 21:45:42 zaphod kernel: md:  adding loop2 ...
Sep 10 21:45:42 zaphod kernel: md:  adding loop1 ...
Sep 10 21:45:42 zaphod kernel: md: created md0
Sep 10 21:45:42 zaphod kernel: md: bind<loop1>
Sep 10 21:45:42 zaphod kernel: md: bind<loop2>
Sep 10 21:45:42 zaphod kernel: md: running: <loop2><loop1>
Sep 10 21:45:42 zaphod kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Sep 10 21:45:42 zaphod kernel: md: ... autorun DONE.
Sep 10 21:45:42 zaphod kernel: md: syncing RAID array md0
Sep 10 21:45:42 zaphod kernel: md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
Sep 10 21:45:42 zaphod kernel: md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
Sep 10 21:45:42 zaphod kernel: md: using 128k window, over a total of 10176 blocks.
Sep 10 21:45:45 zaphod kernel: md: md0: sync done.
Sep 10 21:45:48 zaphod kernel: md: md0 stopped.
Sep 10 21:45:48 zaphod kernel: md: unbind<loop2>
Sep 10 21:45:48 zaphod kernel: md: export_rdev(loop2)
Sep 10 21:45:48 zaphod kernel: md: unbind<loop1>
Sep 10 21:45:48 zaphod kernel: md: export_rdev(loop1)
Sep 10 21:45:57 zaphod kernel:  printing eip:
Sep 10 21:45:57 zaphod kernel: c03a7747
Sep 10 21:45:57 zaphod kernel: Oops: 0000 [#1]
Sep 10 21:45:57 zaphod kernel: CPU:    1
Sep 10 21:45:57 zaphod kernel: EIP:    0060:[make_request+23/752]    Not tainted
Sep 10 21:45:57 zaphod kernel: EFLAGS: 00010296
Sep 10 21:45:57 zaphod kernel: EIP is at make_request+0x17/0x2f0
Sep 10 21:45:57 zaphod kernel: eax: dbce76e0   ebx: dbce1600   ecx: dbfd3580   edx: 00000400
Sep 10 21:45:57 zaphod kernel: esi: 00000002   edi: 00000000   ebp: 00000002   esp: d61e9d5c
Sep 10 21:45:57 zaphod kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 21:45:57 zaphod kernel: Process mount (pid: 1053, threadinfo=d61e8000 task=d750d350)
Sep 10 21:45:57 zaphod kernel: Stack: dbfde4a0 00000200 00000000 00000000 dbce76e0 c0120750 d61e9d94 d61e9d94 
Sep 10 21:45:57 zaphod kernel:        d6bbcf10 00000000 00000000 00000000 d750d350 dbce1600 00000002 d5b41a20 
Sep 10 21:45:57 zaphod kernel:        00000002 c02d190f dbce1600 d5b41a20 00000000 00000000 00000010 c01641d7 
Sep 10 21:45:57 zaphod kernel: Call Trace:
Sep 10 21:45:57 zaphod kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Sep 10 21:45:57 zaphod kernel:  [generic_make_request+367/496] generic_make_request+0x16f/0x1f0
Sep 10 21:45:57 zaphod kernel:  [bio_alloc+215/448] bio_alloc+0xd7/0x1c0
Sep 10 21:45:57 zaphod kernel:  [submit_bh+161/512] submit_bh+0xa1/0x200
Sep 10 21:45:57 zaphod kernel:  [submit_bio+84/160] submit_bio+0x54/0xa0
Sep 10 21:45:57 zaphod kernel:  [__bread_slow+91/176] __bread_slow+0x5b/0xb0
Sep 10 21:45:57 zaphod kernel:  [__bread+62/80] __bread+0x3e/0x50
Sep 10 21:45:57 zaphod kernel:  [ext2_fill_super+175/2336] ext2_fill_super+0xaf/0x920
Sep 10 21:45:57 zaphod kernel:  [disk_name+177/192] disk_name+0xb1/0xc0
Sep 10 21:45:57 zaphod kernel:  [sb_set_blocksize+37/96] sb_set_blocksize+0x25/0x60
Sep 10 21:45:57 zaphod kernel:  [get_sb_bdev+296/352] get_sb_bdev+0x128/0x160
Sep 10 21:45:57 zaphod kernel:  [alloc_vfsmnt+133/192] alloc_vfsmnt+0x85/0xc0
Sep 10 21:45:57 zaphod kernel:  [ext2_get_sb+47/64] ext2_get_sb+0x2f/0x40
Sep 10 21:45:57 zaphod kernel:  [ext2_fill_super+0/2336] ext2_fill_super+0x0/0x920
Sep 10 21:45:57 zaphod kernel:  [do_kern_mount+95/224] do_kern_mount+0x5f/0xe0
Sep 10 21:45:57 zaphod kernel:  [do_add_mount+160/432] do_add_mount+0xa0/0x1b0
Sep 10 21:45:57 zaphod kernel:  [do_mount+352/432] do_mount+0x160/0x1b0
Sep 10 21:45:57 zaphod kernel:  [copy_mount_options+268/272] copy_mount_options+0x10c/0x110
Sep 10 21:45:57 zaphod kernel:  [sys_mount+242/368] sys_mount+0xf2/0x170
Sep 10 21:45:57 zaphod kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 10 21:45:57 zaphod kernel: 
Sep 10 21:45:57 zaphod kernel: Code: 8b 47 08 89 44 24 0c fa bb 00 e0 ff ff 21 e3 ff 43 14 f0 fe 

This is a dual Pentium-III kernel with the following RAID options:

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_BLK_DEV_DM=y

The mount version is 2.11z.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

