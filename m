Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTCDObR>; Tue, 4 Mar 2003 09:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269154AbTCDObR>; Tue, 4 Mar 2003 09:31:17 -0500
Received: from platane.lps.ens.fr ([129.199.121.28]:27863 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP
	id <S262871AbTCDObQ>; Tue, 4 Mar 2003 09:31:16 -0500
Date: Tue, 4 Mar 2003 15:41:38 +0100
From: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.63 bug when mounting dirty loopback ext3 filesystems
Message-ID: <20030304144138.GA28345@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops in 2.6.63 when trying to mount dirty ext3 loopback filesystems.

The kernel is 2.6.63 with the latest (2003/02/28)acpi patches, plus a
couple of one-liners found on the mailing-lists to help swsusp working
(one in kernel/suspend.c, one in mm/pdflush.c, and one in
drivers/net/8139tto.c; nothing related to filesystems)

The computer is a Pentium IV on an intel chipset.

I have in /data (an ext3 partition) three files containing ext3
partitions which are mounted using loopback. For some reason, at
shutdown time, /data is unmounted (or remounted ro) before the loopback
partitions, and unmounting the loopback partitions fail, and those
partitions need to get recovered on next reboot. That is not the issue,
I will fix it when I get some time.

The issue is that I got three identical pair of oops in a raw when trying my
new 2.6.63 kernel. From the logs:

---------------------------------------------------------------------------
------- at this point /, /data and all the normal filesystem are mounted rw.
loop: loaded (max 8 devices)
Module loop cannot be unloaded due to unsafe usage in include/linux/module.h:463
------- the loop module got automatically mounted
kjournald starting.  Commit interval 5 seconds
buffer layer error at fs/buffer.c:1150
Pass this trace through ksymoops for reporting
Call Trace: [<c0149479>]  [<c018180d>]  [<c0181e08>]  [<c017b9e4>]  [<c017b344>]  [<c0192e96>]  [<c0192eb4>]  [<c014ce62>]  [<c017be3e>]  [<c017aac0>]  [<c014d031>]  [<c015db98>]  [<c015de7b>]  [<c015dcd3>]  [<c015e1fc>]  [<c010ae6b>]
buffer layer error at fs/buffer.c:2544
Pass this trace through ksymoops for reporting
Call Trace: [<c014b419>]  [<c014b5b0>]  [<c010b28b>]  [<c018181a>]  [<c0181e08>]  [<c017b9e4>]  [<c017b344>]  [<c0192e96>]  [<c0192eb4>]  [<c014ce62>]  [<c017be3e>]  [<c017aac0>]  [<c014d031>]  [<c015db98>]  [<c015de7b>]  [<c015dcd3>]  [<c015e1fc>]  [<c010ae6b>]
EXT3-fs: mounted filesystem with ordered data mode.
------ These oops repeated three times, for my three loopback filesystems
----------------------------------------------------------------------------
Through ksymoops; first part:

Trace; c0149479 <mark_buffer_dirty+19/40>
Trace; c018180d <journal_update_superblock+3d/80>
Trace; c0181e08 <journal_flush+98/1c0>
Trace; c017b9e4 <ext3_mark_recovery_complete+14/50>
Trace; c017b344 <ext3_fill_super+884/970>
Trace; c0192e96 <vsprintf+16/20>
Trace; c0192eb4 <sprintf+14/20>
Trace; c014ce62 <get_sb_bdev+d2/120>
Trace; c017be3e <ext3_get_sb+1e/22>
Trace; c017aac0 <ext3_fill_super+0/970>
Trace; c014d031 <do_kern_mount+41/a0>
Trace; c015db98 <do_add_mount+78/140>
Trace; c015de7b <do_mount+14b/170>
Trace; c015dcd3 <copy_mount_options+73/d0>
Trace; c015e1fc <sys_mount+7c/c0>
Trace; c010ae6b <syscall_call+7/b>

second part:

Trace; c014b419 <submit_bh+79/110>
Trace; c014b5b0 <sync_dirty_buffer+80/a0>
Trace; c010b28b <dump_stack+b/10>
Trace; c018181a <journal_update_superblock+4a/80>
Trace; c0181e08 <journal_flush+98/1c0>
Trace; c017b9e4 <ext3_mark_recovery_complete+14/50>
Trace; c017b344 <ext3_fill_super+884/970>
Trace; c0192e96 <vsprintf+16/20>
Trace; c0192eb4 <sprintf+14/20>
Trace; c014ce62 <get_sb_bdev+d2/120>
Trace; c017be3e <ext3_get_sb+1e/22>
Trace; c017aac0 <ext3_fill_super+0/970>
Trace; c014d031 <do_kern_mount+41/a0>
Trace; c015db98 <do_add_mount+78/140>
Trace; c015de7b <do_mount+14b/170>
Trace; c015dcd3 <copy_mount_options+73/d0>
Trace; c015e1fc <sys_mount+7c/c0>
Trace; c010ae6b <syscall_call+7/b>


I hope I didn't forgot sany relevant information...

Éric Brunet
