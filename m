Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWCALSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWCALSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWCALSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:18:50 -0500
Received: from igate.tek.com ([192.65.41.20]:33336 "EHLO igate.tek.com")
	by vger.kernel.org with ESMTP id S932264AbWCALSt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:18:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.16-rc5 oops in dm_mirror during pvmove (old bio_clone bug?)
Date: Wed, 1 Mar 2006 11:18:37 -0000
Message-ID: <8BE19BC613681046A50B3FD0DCC996CD01CB8B10@eu-brac-m51.global.tektronix.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5 oops in dm_mirror during pvmove (old bio_clone bug?)
Thread-Index: AcY9IeJ203MPrIWkRl2LlC0L6U3VtA==
From: <pete.chapman@exgate.tek.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2006 11:18:41.0879 (UTC) FILETIME=[E56A1E70:01C63D21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing an overnight pvmove on a ~200G physical volume, disk
activity by a cron job seems to have provoked an oops. I saw this on a
2.6.12 kernel too, and the bug seems to have been around for a while:
http://lkml.org/lkml/2005/4/1/116

Mar  1 00:00:00 gallifrey CROND[27778]: (andyh) CMD
(/home/andyh/bin/scripts/backup.sh >& /home/andyh/misc/backup_cron.log)
Mar  1 00:00:06 gallifrey kernel: Unable to handle kernel paging request
at ffffc2001008ec20 RIP:
Mar  1 00:00:06 gallifrey kernel:
<ffffffff882679c4>{:dm_mirror:core_in_sync+12}
Mar  1 00:00:06 gallifrey kernel: PGD 23fc4e067 PUD 23fc4f067 PMD
23fa6c067 PTE 0
Mar  1 00:00:06 gallifrey kernel: Oops: 0000 [1] SMP 
Mar  1 00:00:06 gallifrey kernel: CPU 0 
Mar  1 00:00:06 gallifrey kernel: Modules linked in: dm_mirror
binfmt_misc ipt_REJECT xt_mac xt_tcpudp iptable_filter ip_tables
x_tables nfsd exportfs lockd nfs_acl sunrpc ipv6 nls_iso8859_1 cifs
rfcomm l2cap bluetooth parport_pc lp parport af_packet floppy video
thermal processor fan container button battery ac usb_storage libusual
e1000 ide_cd loop hw_random ehci_hcd uhci_hcd usbcore ext3 jbd ata_piix
libata dm_mod sd_mod scsi_mod
Mar  1 00:00:06 gallifrey kernel: Pid: 27782, comm: tar Not tainted
2.6.16-rc5.13mdksmp #1
Mar  1 00:00:06 gallifrey kernel: RIP: 0010:[_end+131774916/2132033536]
<ffffffff882679c4>{:dm_mirror:core_in_sync+12}
Mar  1 00:00:06 gallifrey kernel: RIP: 0010:[<ffffffff882679c4>]
<ffffffff882679c4>{:dm_mirror:core_in_sync+12}
Mar  1 00:00:06 gallifrey kernel: RSP: 0018:ffff810231981848  EFLAGS:
00010202
Mar  1 00:00:06 gallifrey kernel: RAX: ffff8102396c55e8 RBX:
0000000000000000 RCX: 000000000000000a
Mar  1 00:00:06 gallifrey kernel: RDX: ffffc20010081000 RSI:
000000000006e110 RDI: ffff81023c138e68
Mar  1 00:00:06 gallifrey kernel: RBP: ffff810231981848 R08:
ffff8101901211b0 R09: 0000000000000000
Mar  1 00:00:06 gallifrey kernel: R10: ffff81023fd49040 R11:
ffff81023f714b30 R12: ffff81023f714b30
Mar  1 00:00:06 gallifrey kernel: R13: ffff810178e13720 R14:
0000000000000000 R15: ffff8101d65e6198
Mar  1 00:00:06 gallifrey kernel: FS:  00002b979cafe6e0(0000)
GS:ffffffff80472000(0000) knlGS:0000000000000000
Mar  1 00:00:06 gallifrey kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
000000008005003b
Mar  1 00:00:06 gallifrey kernel: CR2: ffffc2001008ec20 CR3:
000000022e2a9000 CR4: 00000000000006e0
Mar  1 00:00:06 gallifrey kernel: Process tar (pid: 27782, threadinfo
ffff810231980000, task ffff810233fee140)
Mar  1 00:00:06 gallifrey kernel: Stack: ffff810231981878
ffffffff882683f4 0000000000000000 ffff8101f961ada0
Mar  1 00:00:06 gallifrey kernel:        ffff81023f714b30
000000001b844010 ffff8102319818a8 ffffffff88029dc6
Mar  1 00:00:06 gallifrey kernel:        0000000000000000
ffffc2000003d0d0
Mar  1 00:00:06 gallifrey kernel: Call Trace:
<ffffffff882683f4>{:dm_mirror:mirror_map+87}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff88029dc6>{:dm_mod:__map_bio+68}
<ffffffff8802a014>{:dm_mod:__split_bio+356}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff8802a3ae>{:dm_mod:dm_request+273}
<ffffffff801d9837>{generic_make_request+348}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff88029dd6>{:dm_mod:__map_bio+84}
<ffffffff8802a014>{:dm_mod:__split_bio+356}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff8802a3ae>{:dm_mod:dm_request+273}
<ffffffff801d9837>{generic_make_request+348}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff801d9cfb>{submit_bio+191} <ffffffff8017d0eb>{submit_bh+263}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff8805b948>{:ext3:__ext3_get_inode_loc+680}
<ffffffff8805d24a>{:ext3:ext3_read_inode+56}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff880622b9>{:ext3:ext3_lookup+120}
<ffffffff80191743>{d_lookup+40}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff8018891d>{do_lookup+197}
<ffffffff8018934d>{__link_path_walk+2433}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff801898a0>{link_path_walk+103}
<ffffffff801e5230>{_atomic_dec_and_lock+52}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff801943dd>{mntput_no_expire+27}
<ffffffff80189ede>{do_path_lookup+607}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff8018a52c>{__user_walk_fd+63}
<ffffffff8018360e>{vfs_lstat_fd+33}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff801e5230>{_atomic_dec_and_lock+52}
<ffffffff801943dd>{mntput_no_expire+27}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff80183c43>{sys_newlstat+34} <ffffffff8017bef1>{fput+20}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff80179799>{filp_close+98} <ffffffff8017a097>{sys_close+147}
Mar  1 00:00:06 gallifrey kernel:
<ffffffff8010a7e6>{system_call+126}
Mar  1 00:00:06 gallifrey kernel:
Mar  1 00:00:06 gallifrey kernel: Code: 0f a3 32 19 c0 85 c0 c9 0f 95 c0
0f b6 c0 c3 48 8b 4f 08 55
Mar  1 00:00:06 gallifrey kernel: RIP
<ffffffff882679c4>{:dm_mirror:core_in_sync+12} RSP <ffff810231981848>
Mar  1 00:00:06 gallifrey kernel: CR2: ffffc2001008ec20
Mar  1 00:00:06 gallifrey kernel:  BUG: tar/27782, lock held at task
exit time!
Mar  1 00:00:06 gallifrey kernel:  [ffff8101d65e65c0] {inode_init_once}
Mar  1 00:00:06 gallifrey kernel: .. held by:               tar:27782
[ffff810233fee140, 118]
Mar  1 00:00:06 gallifrey kernel: ... acquired at:
do_lookup+0x81/0x174
